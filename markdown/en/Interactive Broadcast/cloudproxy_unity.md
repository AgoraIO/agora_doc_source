---
title: Use Cloud Proxy
platform: Unity
updatedAt: 2021-03-12 04:51:09
---
## Introduction

To allow users to use the Agora RTC Unity SDK in environments with restricted network access, Agora provides a cloud proxy. Users only need to add specific IP addresses and ports to the firewall whitelist, and call the API to configure the Agora cloud proxy service.

### Working principles

![](https://web-cdn.agora.io/docs-files/1569400862850)

1. The Agora SDK sends a request to the Agora cloud proxy. The Agora cloud proxy returns the proxy information.
2. The Agora SDK sends data to the Agora cloud proxy. The Agora cloud proxy forwards the data to Agora [SD-RTN™](terms#sd-rtn) (Software Defined Real-time Network).
3. Agora SD-RTN™ sends data to the Agora cloud proxy. The Agora cloud proxy forwards the data to the Agora SDK.

## Implementation

1. Download the Agora RTC Unity SDK.

2. Integrate the SDK and prepare the development environment. For details, see *QuickStart Guide*.

3. Contact [Agora technical support](mailto:support@agora.io) and provide the following information:

    - Your App ID.
    - The regions using the cloud proxy.
    - The concurrent scale.
    - Network operators.

4. Add all the IP addresses and ports in the appropriate table to your firewall whitelist. The source addresses are the IP addresses of the clients integrated with the Agora RTC Unity SDK.

    - If your SDK is v3.2.1 or later, refer to the following table.

      <div class="alert note">The Agora cloud proxy service provides server resources in two ways:<ul><li>Sharing mode: You share Agora server resources with other users.</li><li>Exclusive mode: You have exclusive use of Agora server resources.</li></ul>Both modes ensure the security of Agora services. If you want to use exclusive mode, do not to refer to the following table. Instead, you must apply to Agora for dedicated server resources. Once approved, you need to add the IP addresses and ports provided by Agora to the firewall whitelist.</div>

      | Protocol| Destination IP address   | Port      | Comment |
      | ----|--------------------- | ----------- | ----------|
      | UDP |140.210.77.68 (Mainland China)  | 8443 | Used to access Agora services, namely AP (Access Point) communication |
      | UDP |125.88.159.163 (Mainland China) | 8443 | Used to access Agora services, namely AP (Access Point) communication |
      | UDP |128.1.87.146 (Asia, excluding Mainland China)  | 8443  | Used to access Agora services, namely AP (Access Point) communication |
      | UDP |128.1.77.34 (Europe)  | 8443 | Used to access Agora services, namely AP (Access Point) communication |
      | UDP |128.1.78.146 (Europe)  | 8443 | Used to access Agora services, namely AP (Access Point) communication |
      | UDP |69.28.51.142 (North America)  | 8443 | Used to access Agora services, namely AP (Access Point) communication |
      | UDP |107.155.14.132 (North America)  | 8443 | Used to access Agora services, namely AP (Access Point) communication |
      | UDP |106.3.140.194 (Mainland China) | 8001 - 8005, 4590 - 4600 | Used for the Agora cloud proxy service |
      | UDP |106.3.140.195 (Mainland China) | 8001 - 8005, 4590 - 4600 | Used for the Agora cloud proxy service |
      | UDP |164.52.53.77 (Asia, excluding Mainland China) | 8001 - 8005, 4590 - 4600 | Used for the Agora cloud proxy service |
      | UDP |164.52.53.78 (Asia, excluding Mainland China) | 8001 - 8005, 4590 - 4600 | Used for the Agora cloud proxy service |
      | UDP |128.1.78.94 (Europe)  | 8001 - 8005, 4590 - 4600 | Used for the Agora cloud proxy service |
      | UDP |148.153.53.105 (North America) | 8001 - 8005, 4590 - 4600 | Used for the Agora cloud proxy service |
      | UDP |148.153.53.106 (North America) | 8001 - 8005, 4590 - 4600 | Used for the Agora cloud proxy service |

    - If your SDK is earlier than v3.2.1, refer to the following table.

      <div class="alert note">Some IP addresses and ports in the following table are for testing purposes only. In a production environment, you must apply to Agora for the official IP addresses and ports that replace them.</div>

      | Protocol | Destination IP address   | Port          | Comment   |
      | ---- | ------------- | ----------------------- | ------------ |
      | TCP  | 47.74.211.17  | 1080, 8000, 25000, 9700 | Used to access Agora services, namely AP (Access Point) communication |
      | TCP  | 52.80.192.229 | 1080, 8000, 25000, 9700 | Used to access Agora services, namely AP (Access Point) communication |
      | TCP  | 52.52.84.170  | 1080, 8000, 25000, 9700 | Used to access Agora services, namely AP (Access Point) communication |
      | TCP  | 47.96.234.219 | 1080, 8000, 25000, 9700 | Used to access Agora services, namely AP (Access Point) communication |
      | UDP  | 47.74.211.17  | 1080, 8000, 25000, 9700 | Used to access Agora services, namely AP (Access Point) communication |
      | UDP  | 52.80.192.229 | 1080, 8000, 25000, 9700 | Used to access Agora services, namely AP (Access Point) communication |
      | UDP  | 52.52.84.170  | 1080, 8000, 25000, 9700 | Used to access Agora services, namely AP (Access Point) communication |
      | UDP  | 47.96.234.219 | 1080, 8000, 25000, 9700 | Used to access Agora services, namely AP (Access Point) communication |
      | TCP  | 120.92.118.34 | 4000                    | Used for the Agora cloud proxy service (for testing purpose only) |
      | TCP  | 120.92.18.162 | 4000                    | Used for the Agora cloud proxy service (for testing purpose only) |
      | UDP  | 120.92.118.34 | 4500 - 4650             | Used for the Agora cloud proxy service (for testing purpose only) |
      | UDP  | 120.92.18.162 | 4500 - 4650             | Used for the Agora cloud proxy service (for testing purpose only) |

5. Enable the cloud proxy service by calling `SetParameters("{\"rtc.enable_proxy\":true}");`.

6. After you enable the cloud proxy service, Agora uses the domain name to configure the service by default. If the default configuration does not meet your requirements, call `SetParameters("{\"rtc.proxy_server\":[2, \"[\"ip1\",\"ip2\",\"ip3\"]\", 0]}");` to use IP addresses to configure the cloud proxy service.

    <div class="alert note">Agora recommends using the domain name to configure the cloud proxy server. When the domain name is restricted, you can use IP addresses instead.</div>

7. Test the audio and video call functionality.

<div class="alert note">To disable the cloud proxy service, call <code>SetParameters("{\"rtc.enable_proxy\":false}");</code>.</div>

### Sample code

```C#
// Enables the cloud proxy server and uses the domain name for configuration by default.
SetParameters("{\"rtc.enable_proxy\":true}");
```

```C#
// Enables the cloud proxy server and uses IP addresses for configuration.
SetParameters("{\"rtc.enable_proxy\":true}");
// The following IP addresses are just examples. You need to fill in all the IP addresses that need to be opened.
SetParameters("{\"rtc.proxy_server\":[2, \"[\"128.1.87.146\",\"164.52.53.77\",\"164.52.53.78\"]\", 0]}");
```

## Considerations

- The `SetParameters` method must be called before joining a channel or after leaving a channel.
- When you use the cloud proxy, the services for pushing streams to CDN and co-hosting across channels are not available.