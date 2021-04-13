---
title: How can I use Agora Web SDK on mobile devices?
platform: ["Web"]
updatedAt: 2020-08-18 14:40:18
Products: ["Voice","Video","Interactive Broadcast"]
---
The Agora Web SDK is based on WebRTC and relies on the browser's support for WebRTC. However, some apps on some mobile devices may not support WebRTC depending on their WebView implementation. This page introduces the support for sending and receiving audio/video streams on mobile webpages.

## Audio streams

### iOS

On iOS, all apps with built-in browsers use the system WebView which does not support sending streams. The following table lists the support for sending and receiving audio streams on three types of mobile webpages.

| Mobile webpage                                              | Version        |
| :---------------------------------------------------------- | :------------------ |
| The built-in browser of WeChat (supports receiving streams) | iOS 12.1.4 or later |
| Apps with built-in WebView (supports receiving streams)     | iOS 12.1.4 or later |
| Safari (supports sending and receiving streams)             | iOS 11.0 or later   |


### Android

Android WebView supports customization, and the system WebView varies by device. The following table lists the support for sending and receiving audio streams on three types of mobile webpages.

| Mobile webpage                 | Version                                                 |
| :----------------------------- | :----------------------------------------------------------- |
| The built-in browser of WeChat | Depends on the domain name. For example, the `.com` domains support sending and receiving audio streams, while the `.io` domains do not. |
| Apps with built-in WebView     | No support on most mobile devices.                           |
| Chrome 58 or later             | Supports sending and receiving streams.                      |

<div class="alert note">The support for sending and receiving audio streams on apps with built-in WebView is dependent on the mobile device.</div>

## Video streams

### iOS

On iOS, all apps with built-in browsers use the system WebView which does not support sending streams. The following table lists the supported codecs of three types of mobile webpages.

|                                                             | VP8               | H.264               |
| :---------------------------------------------------------- | :---------------- | :------------------ |
| The built-in browser of WeChat (supports receiving streams) | iOS 12.2 or later | iOS 12.1.4 or later |
| Apps with built-in WebView (supports receiving streams)     | iOS 12.2 or later | iOS 12.1.4 or later |
| Safari (supports sending and receiving streams)             | iOS 12.2 or later | iOS 11 or later     |


### Android

Android WebView supports customization, and the system WebView varies by device. The following table lists the supported codecs of three types of mobile webpages.

|                                | VP8                                                          | H.264                                                        |
| :----------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| The built-in browser of WeChat | The latest version supports sending and receiving streams.   | No support                                                   |
| Apps with built-in WebView     | Supports sending and receiving streams on some mobile devices. | Supports sending and receiving streams on some mobile devices. |
| Chrome 58 or later             | Supports sending and receiving video streams.                | Supports sending and receiving streams on some mobile devices |

<div class="alert note">VP8 and H.264 support on apps with built-in WebView and H.264 support on Chrome are dependent on the mobile device.</div>

### Codec setting

If all users in the channel use the Agora Web SDK, we recommend setting `codec` as `"vp8"` in the `createClient` method. Refer to the above tables for the supported system and app versions.