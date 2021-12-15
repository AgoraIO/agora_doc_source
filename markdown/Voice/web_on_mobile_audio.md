---
title: 移动端使用 Web SDK
platform: Web
updatedAt: 2019-07-25 11:29:21
---

Agora Web SDK 是基于 WebRTC 实现音视频通信的，因此依赖于浏览器对 WebRTC 的支持。尽管移动端主流的浏览器都支持 WebRTC，但是由于平台和一些应用内置浏览器的实现各不相同，移动端对音频编解码的支持情况比较复杂，本文详细介绍移动端各种应用场景下对发送和接收音频的支持。

## iOS

iOS 应用只能使用系统 WebView，不支持发送音频流。因此在 iOS 上只有 Safari 浏览器可以发送和接收音频流。下面列出三种浏览器对发送和接收音频流的支持：

- 微信内置浏览器：iOS 12.1.4 及以后版本支持接收音频流。对于不支持接收音频流的 iOS 版本，可以通过[引入 RTS 插件](https://docs-preview.agoralab.co/cn/Interactive%20Broadcast/web_in_app?platform=Web)支持播放音频。
- 内嵌 WebView 的应用：iOS 12.1.4 及以后版本支持接收音频流。对于不支持接收音频流的 iOS 版本，可以通过[引入 RTS 插件](https://docs-preview.agoralab.co/cn/Interactive%20Broadcast/web_in_app?platform=Web)支持播放音频。
- Safari 浏览器：iOS 11 及以后版本支持发送和接收音频流。

## Android

安卓平台原生的 WebView 支持自定义，因此不同设备、不同应用的 WebView 实现可能不同。下面列出三种浏览器对发送和接收音频流的支持：

- 微信内置浏览器：是否支持发送和接收音频流与使用的域名有关。例如 .com 域名可以正常发送和接收音频流，但是 .io 域名无法发送和接收音频流。
- 内嵌 WebView 的应用：大多数不支持发送和接收音频流。对于不支持接收音频流的应用，可以通过[引入 RTS 插件](https://docs-preview.agoralab.co/cn/Interactive%20Broadcast/web_in_app?platform=Web)支持播放音频。
- Chrome 浏览器：Chrome 58 及以上版本支持发送和接收音频流。
