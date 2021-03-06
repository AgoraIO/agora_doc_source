Deployed on your server, the Agora Server Gateway SDK communicates with clients integrated with the [Agora RTC SDK](https://docs.agora.io/en/Agora%20Platform/term_agora_rtc_sdk). You can use the Server Gateway SDK to transmit video and audio streams between the server and the client through [SD-RTN™](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#sd-rtn).

The following diagram shows typical application scenarios of the Server Gateway SDK, including playing local media files, pushing streams to CDN, and communicating with enterprise call centers. The Server Gateway SDK implements media stream transmission by the following means:

- Converting incoming media streams from SD&#8209;RTN™ to a specified format.
- Encoding and sending local media streams to SD&#8209;RTN™.

![](https://web-cdn.agora.io/docs-files/1652091395635)

<div class="alert note">When you use the <a href="https://docs.agora.io/en/Agora%20Platform/term_agora_rtc_sdk">Agora RTC SDK</a> to communicate with the Server Gateway SDK, set the channel scenario of the RTC SDK to <code>LIVE_BROADCASTING</code>.</div>

## Advantages

The Gateway Server SDK has the following advantages:

| <span style="white-space:nowrap;">&emsp;Feature&emsp;</span>  | Description                                                         |
| :----- | :----------------------------------------------------------- |
| Compatibility   | Compatible with the Agora RTC SDK on the following platforms: <ul><li>Android</li><li>iOS</li><li>Windows</li><li>macOS</li><li>Web (3.0.0 or higher)</li></ul> |
| Reliability   | Supports cluster deployment, dynamic scalability, and high availability.                         |
| Smoothness  | Low-latency media transmission from the server to the client based on the packet loss reduction feature of SD-RTN™.  |
| High concurrency | For a server with an 8-core, 2.5 GHz CPU and 16 GB RAM, you can simultaneously send video streams (320 × 240, 15 fps) to 1,000 channels.|
| Security   | Provides end-to-end security measures for video and audio chat, data transmission, and storage. See [Information Security Policy](https://docs.agora.io/en/Agora%20Platform/security). |

## Platform Compatibility

The Gateway Server SDK supports the following operating systems:

- Ubuntu (14.04 or higher)
- CentOS (6.6 or higher)

The Gateway Server SDK supports the following architectures:

- arm64
- x86-64

If you need to use the SDK on other architectures, contact sales@agora.io.

## Application scenarios

The Gateway Server SDK supports the following scenarios:

|  <span style="white-space:nowrap;">&emsp;&emsp;Scenario&emsp;&emsp;</span>    | Description                                                     |
| :---------- | :----------------------------------------------------------- |
| AI interactive class | An AI interactive class is a custom online class that uses AI to analyze student performance and recommend appropriate video class content. You use the Server Gateway SDK to send different video content to different user IDs in a channel. |
| Network test | Prior to the start of an online class, you use the Server Gateway SDK to join the channel as a robot to test the end-to-end network status by communicating with teachers and students. |
| Call center    | You use the Server Gateway SDK to create audio connections for traditional enterprise call centers (VoIP/PTSN). Users can conveniently call customer service from an app. |

## Functions

The Gateway Server SDK supports the following functions:

| Function                           | Description                                                         |
| :----------------------------- | :----------------------------------------------------------- |
| Sending and receiving video and audio data in various formats. | Supports sending and receiving video and audio data in various formats. See [Send and Receive Media streams](server_gateway_tx_rx_stream). |
| Independent video/audio sending/receiving processes.     | You can send and receive media streams simultaneously, or choose to only send or receive audio or video streams. |
| Using string user ID to join a channel.              | Supports joining a channel with a string user ID. See [Using String User ID](server_gateway_stringuid). |
| Specifying remote streams by user ID.           | Supports receiving media streams from a specified user ID.                               |
| Starting a single process with multiple SDK instances.                 | Supports sending and/or receiving media streams to and from multiple channels simultaneously.                       |
| Audio mixing.                           | Supports mixing multiple audio streams.                              |
| Media encryption. | Supports media encryption. See [Media Encryption](server_gateway_encryption).  |
| Cloud proxy. | Supports cloud proxy service. You need to add specified IPs and ports to your firewall allowlist to access Agora services from restricted networks. See [Cloud Proxy](server_gateway_cloud_proxy).|
| Network Geofencing | Supports network geofencing. After enabling geofencing, the Agora SDK only connects to Agora servers within the specified region. See [Network Geofencing](server_gateway_region).|

## Billing

The billing of the Server Gateway SDK is the same as Agora RTC SDK. See [Billing](https://docs.agora.io/en/Interactive%20Broadcast/billing_rtc).
