---
title: Use Cloud Proxy
platform: Android
updatedAt: 2019-07-16 11:22:42
---
## Introduction

Enterprises with high-security requirements usually have firewalls that restrict employees from visiting unauthorized sites to protect internal information.

To ensure that enterprise users can connect to Agora's services through a firewall, Agora supports setting up a cloud proxy. 

Compared with setting a single proxy server, the cloud proxy is more flexible and stable, thus widely implemented in organizations with high-security requirements, such as large-scale enterprises, hospitals, universities, and banks.

## Prerequisites

Agora Native SDK v2.4.0 or later supports the cloud proxy. Before proceeding, ensure that you prepare the development environment. 

1. Contact support@agora.io and provide the information on the regions using the cloud proxy, the concurrent scale, and network operators.

2. Add the following test IP addresses and ports to your whitelist.

  | Protocol | Destination IP address  | Port                   | Port function      |
 | ---- | ------------- | ---------------------- | ---------------------- |
 | TCP  | 120.92.118.34 | 4000                   | Message data transmission |
 | TCP  | 120.92.18.162 | 4000                   | Message data transmission |
 | TCP  | 47.74.211.17  | 1080, 8000, 25000, 9700 | Edge node communication |
 | TCP  | 52.80.192.229 | 1080, 8000, 25000, 9700 | Edge node communication |
 | TCP  | 52.52.84.170  | 1080, 8000, 25000, 9700 | Edge node communication |
 | TCP  | 47.96.234.219 | 1080, 8000, 25000, 9700 | Edge node communication |
 | UDP  | 120.92.118.34 | 4500 to 4650            | Media data exchange |
 | UDP  | 120.92.18.162 | 4500 to 4650            | Media data exchange |
 | UDP  | 47.74.211.17  | 1080, 8000, 25000, 9700 | Edge node communication |
 | UDP  | 52.80.192.229 | 1080, 8000, 25000, 9700 | Edge node communication |
 | UDP  | 52.52.84.170  | 1080, 8000, 25000, 9700 | Edge node communication |
 | UDP  | 47.96.234.219 | 1080, 8000, 25000, 9700 | Edge node communication |

 <div class="alert note">These IP addresses and ports are for testing purposes only. In a production environment, apply for the dedicated IP addresses and ports.</div>

3. Enable the cloud proxy according to the instructions in the **Implementation** section and see if the audio/video call works.

4. Agora will provide the IP addresses (domain name) and ports for you to use the cloud proxy in the production environment. Add the IP address and ports to your whitelist.

## Implementation

You can set up the cloud proxy by calling the following method.

```
setParameters("{\"rtc.proxy_server\":[proxy_type, \"ip or dns\", port]}");
```

In which:
- `proxy_type`: The type of the proxy server.
- `ip or dns`: The IP address or domain name of the proxy server.
- `port`: The ports of the proxy server.

Different proxy server types corresponds to different IP addresses and ports:

| `proxy_type`                                                 | `ip or dns`                                         | `port`                        |
| ------------------------------------------------------------ | --------------------------------------------------- | ----------------------------- |
| 0: The Socks5 proxy server                         | The IP address of the server                                         | The ports of the server                 |
| 1: Use cloud proxy and configure the domain name (recommended) | ap-proxy.agora.io                                   | 0                      |
| 2: Use cloud proxy and configure the IP address (Used when the domain name is restricted | The IP address list of the server in the format of<br/> `"[\"ip1\",\"ip2\"]"` | The port of this lbs. The default value is 0 |
| 4: Do not enable the proxy service                                            | N/A                                                 | N/A                           |

### Code samples

**`proxy_server` = 0：**
```
setParameters("{\"rtc.proxy_server\":[0, \"127.0.0.1\", 1080]}");
```
**`proxy_server` = 1：**
```
setParameters("{\"rtc.proxy_server\":[1, \"ap-proxy.agora.io\", 0]}");
```
**`proxy_server` = 2：**
```
setParameters("{\"rtc.proxy_server\":[2, \"[\"192.168.0.112\",\"127.0.0.1\"]\", 0]}");
```
**`proxy_server` = 4：**
```
setParameters("{\"rtc.proxy_server\":[4, \"\", 0]}");
```
