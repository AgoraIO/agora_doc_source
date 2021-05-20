---
title: Use Web SDK on Mobile Devices
platform: Web
updatedAt: 2019-08-22 14:18:07
---
The Agora Web SDK is based on WebRTC and relies on the browser's support for WebRTC. However, some apps on some mobile devices may not support WebRTC depending on their WebView implementation. This page introduces the support for sending and receiving audio streams on mobile webpages.

## iOS

On iOS, all apps with built-in browsers use the system WebView which does not support sending streams. The following table lists the support for sending and receiving audio streams on three types of mobile webpages.

| Mobile webpage                                              | Audio stream        |
| :---------------------------------------------------------- | :------------------ |
| The built-in browser of WeChat (supports receiving streams) | iOS 12.1.4 or later |
| Apps with built-in WebView (supports receiving streams)     | iOS 12.1.4 or later |
| Safari (supports sending and receiving streams)             | iOS 11.0 or later   |

On iOS versions that do not support receiving audio streams, you can [use the RTS plugin](https://docs-preview.agoralab.co/en/Interactive%20Broadcast/web_in_app?platform=Web) to receive and play audio streams.

## Android

Android WebView supports customization, and the system WebView varies by device. The following table lists the support for sending and receiving audio streams on three types of mobile webpages.

| Mobile webpage                 | Audio stream                                                 |
| :----------------------------- | :----------------------------------------------------------- |
| The built-in browser of WeChat | Depends on the domain name. For example, the `.com` domains support sending and receiving audio streams, while the `.io` domains do not. |
| Apps with built-in WebView     | No support on most mobile devices.                           |
| Chrome 58 or later             | Supports sending and receiving streams.                      |

> The support for sending and receiving audio streams on apps with built-in WebView is dependent on the mobile device.

On apps that do not support receiving audio streams, you can [use the RTS plugin](https://docs-preview.agoralab.co/en/Interactive%20Broadcast/web_in_app?platform=Web) to receive and play audio streams.