---
title: Agora RTC SDK
platform: All Platforms
updatedAt: 2021-02-03 06:25:48
---
Agora RTC (Real-Time Communication) SDK 是声网提供的用于实现音视频实时通信的 SDK。通过集成 RTC SDK，开发者可以在项目中实现语音通话、视频通话、音频互动直播及视频互动直播等功能。

根据支持的功能及平台，RTC SDK 又作如下区分：

| SDK      | 支持平台                                                     | 实现功能                                         |
| :------- | :----------------------------------------------------------- | :----------------------------------------------- |
| 语音 SDK | <li>原生平台：Android、iOS、macOS、Windows<br><li>第三方框架：Unity      | <li>纯语音通话<br><li>纯音频互动直播                         |
| 视频 SDK | <li>原生平台：Android、iOS、macOS、Web、Windows、微信小程序<br><li>第三方框架：Unity、Electron、React Native、Flutter | <li>纯语音通话<br><li>纯音频互动直播<br><li>音视频通话<br><li>音视频互动直播 |

其中：

- Android、iOS、macOS、Windows 平台的 RTC SDK，通常被统称为 Agora RTC Native SDK。
- [React Native](https://github.com/AgoraIO/React-Native-SDK) 和 [Flutter](https://github.com/AgoraIO/Flutter-SDK) 平台的 Agora RTC SDK，目前仅在 GitHub 发布与维护。

除了基本的实时音视频互动外，Agora RTC SDK 还支持伴奏混音、屏幕共享、修改音视频原始数据、接收外部音视频源数据、推流到 CDN 等高阶功能，帮助开发者实现更多场景。

开发者还可以搭配使用其他的 Agora SDK 或服务，在实时音视频互动过程中实现其他功能：

- 搭配 Agora 本地服务端录制或云录制服务，实现录制实时音视频功能。
- 搭配 Agora MediaPlayer Kit 组件，实现在线播放媒体资源功能。
- 搭配 Agora RTM SDK，实现实时消息、信令维护功能。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/Voice/product_voice?platform=All%20Platforms">语音通话产品概述</a></li><li><a href="https://docs.agora.io/cn/Video/product_video?platform=All%20Platforms">视频通话产品概述</a></li><li><a href="https://docs.agora.io/cn/Audio%20Broadcast/product_live_audio?platform=All%20Platforms">音频互动直播产品概述</a></li><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/product_live?platform=All%20Platforms">视频互动直播产品概述</a></li>
</div>

<a href="./terms"><button>返回术语库</button></a>