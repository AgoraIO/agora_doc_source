---
title: Use Cloud Proxy
platform: Android
updatedAt: 2021-03-12 03:41:06
---
## Introduction

Enterprises with high-security requirements usually have firewalls that restrict employees from visiting unauthorized sites to protect internal information.

To ensure that enterprise users can connect to Agora's services through a firewall, Agora supports setting up a cloud proxy. 

Compared with setting a single proxy server, the cloud proxy is more flexible and stable, thus widely implemented in organizations with high-security requirements, such as large-scale enterprises, hospitals, universities, and banks.

## Implementation

1. Download [the latest version of the Agora Native SDK](https://docs.agora.io/en/Agora%20Platform/downloads).
2. Integrate the SDK and prepare the development environment. For details, see the **Integrate the SDK** guide.
3. Contact support@agora.io and provide your App ID, and the information on the regions using the cloud proxy, the concurrent scale, and network operators.
4. Add the following test IP addresses and ports to your whitelist.

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

5. Enable the cloud proxy by calling the `setParameters("{\"rtc.enable_proxy\"}:true"); ` method and see if the audio/video call works.
6. Agora will provide the IP addresses (domain name) and ports for you to use the cloud proxy in the production environment. Add the IP address and ports to your whitelist.

## Working principles

The following diagram shows the working principles of the Agora cloud proxy.

![](https://web-cdn.agora.io/docs-files/1569400862850)

1. Before connecting to Agora SD-RTN, the Agora SDK sends the request to the cloud proxy;

2. The cloud proxy sends back the proxy information;
3. The Agora SDK sends the data to the cloud proxy, and the cloud proxy forwards the data to Agora SD-RTN;
4. Agora SD-RTN sends the data to the cloud proxy, and the cloud proxy forwards the data to the Agora SDK.