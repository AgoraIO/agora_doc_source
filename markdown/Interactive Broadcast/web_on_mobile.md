---
title: 移动端使用 Web SDK
platform: Web
updatedAt: 2020-07-28 11:59:11
---

Agora Web SDK 是基于 WebRTC 实现音视频通信的，因此依赖于浏览器对 WebRTC 的支持。尽管移动端主流的浏览器都支持 WebRTC，但是由于平台和一些应用内置浏览器的实现各不相同，移动端对视频编解码格式的支持情况比较复杂，本文详细介绍移动端各种应用场景下对编解码格式的支持。

## iOS

iOS 平台上所有的应用内置浏览器只能使用系统提供的 WebView，且不支持发送音视频流。下面列出三种浏览器对编解码格式的支持：

|                                   | VP8                 | H.264                 |
| :-------------------------------- | :------------------ | :-------------------- |
| 微信内置浏览器（仅支持接收）      | iOS 12.2 及以后版本 | iOS 12.1.4 及以后版本 |
| Safari 浏览器（支持发送和接收）   | iOS 12.2 及以后版本 | iOS 11 及以后版本     |
| 内嵌 WebView 的应用（仅支持接收） | iOS 12.2 及以后版本 | iOS 12.1.4 及以后版本 |

对于不支持 H.264 的 iOS 版本，可以通过[引入 RTS 插件](https://docs-preview.agoralab.co/cn/Interactive Broadcast/web_in_app?platform=Web)支持观看视频。

## Android

安卓平台原生的 WebView 支持自定义，因此不同设备、不同应用的 WebView 实现可能不同。下面列出三种浏览器对编解码格式的支持：

|                      | VP8                      | H.264                  |
| :------------------- | :----------------------- | :--------------------- |
| 微信内置浏览器       | 微信最新版支持发送和接收 | 不支持                 |
| 内嵌 WebView 的应用  | 部分设备支持发送和接收   | 部分设备支持发送和接收 |
| Chrome 58 及以后版本 | 支持发送和接收           | 部分设备支持发送和接收 |

> 内嵌 WebView 的应用对 VP8 和 H.264 的支持以及 Chrome 浏览器对 H.264 的支持都与使用的设备有关。

对于不支持 H.264 的情况，可以通过[引入 RTS 插件](https://docs-preview.agoralab.co/cn/Interactive Broadcast/web_in_app?platform=Web)支持观看视频。

## 编解码格式选择

如果所有用户都使用 Agora Web SDK，我们建议在调用 `createStream` 时将 `codec` 设为 `"vp8"`。VP8 对系统和应用版本的要求请参考上面的表格。

如果频道中有发送端使用 Agora Native SDK ，由于 Agora Native SDK 发送的视频流均为 H.264 编解码，在不支持 H.264 的手机上 Web SDK 可以[引入 RTS 插件](https://docs-preview.agoralab.co/cn/Interactive Broadcast/web_in_app?platform=Web)支持观看视频，同时频道中使用 Web SDK 的发送端也需要将 `codec` 设为 `"h264"`。
