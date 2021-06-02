---
title: Use Web SDK on Mobile Devices
platform: Web
updatedAt: 2020-07-28 11:50:54
---
The Agora Web SDK is based on WebRTC and relies on the browser's support for WebRTC. However, some apps on some mobile devices may not support WebRTC depending on their WebView implementation. This page introduces the supported codecs on mobile webpages.

## iOS

On iOS, all apps with built-in browsers use the system WebView which does not support sending streams. The following table lists the supported codecs of three types of mobile webpages.

|                                                             | VP8               | H.264               |
| :---------------------------------------------------------- | :---------------- | :------------------ |
| The built-in browser of WeChat (supports receiving streams) | iOS 12.2 or later | iOS 12.1.4 or later |
| Apps with built-in WebView (supports receiving streams)     | iOS 12.2 or later | iOS 12.1.4 or later |
| Safari (supports sending and receiving streams)             | iOS 12.2 or later | iOS 11 or later     |

In iOS versions that do not support H.264, you can [use the RTS plugin](https://docs-preview.agoralab.co/en/Interactive%20Broadcast/web_in_app?platform=Web) to receive the H.264 video.

## Android

Android WebView supports customization, and the system WebView varies by device. The following table lists the supported codecs of three types of mobile webpages.

|                                | VP8                                                          | H.264                                                        |
| :----------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| The built-in browser of WeChat | The latest version supports sending and receiving streams.   | No support                                                   |
| Apps with built-in WebView     | Supports sending and receiving streams on some mobile devices. | Supports sending and receiving streams on some mobile devices. |
| Chrome 58 or later             | Supports sending and receiving video streams.                | Supports sending and receiving streams on some mobile devices |

> VP8 and H.264 support on apps with built-in WebView and H.264 support on Chrome are dependent on the mobile device.

On apps that do not support H.264, you can [use the RTS plugin](https://docs-preview.agoralab.co/en/Interactive%20Broadcast/web_in_app?platform=Web) to receive the H.264 video.

## Codec setting

If all users in the channel use the Agora Web SDK, we recommend setting `codec` as `"vp8"` in the `createStream` method. Refer to the above tables for the supported system and app versions.

If there are senders using the Agora Native SDK, you can [use the RTS plugin](https://docs-preview.agoralab.co/en/Interactive%20Broadcast/web_in_app?platform=Web) to support watching H.264 video on mobile webpages. In the meantime, all the senders using the Agora Web SDK should set `codec` as `"h264"`.