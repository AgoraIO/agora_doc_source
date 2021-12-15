---
title: AI 互动课堂
platform: All Platforms
updatedAt: 2021-03-02 04:17:50
---

## API 时序图

![](https://web-cdn.agora.io/docs-files/1577098826567)

## 教师端功能实现

教师端通过 Agora Media Streaming Server SDK 实现服务端推送媒体文件。

<div class="note alert">点击<a href="https://download.agora.io/ardsdk/release/Agora_MediaStreamingServer_SDK_for_Linux_v2_6_1_180_FULL_20200212_85.tar.gz">此处</a>下载 Agora Media Streaming Server SDK 包。</div>
	
我们提供：

- 服务端媒体推流命令行工具，可以循环推送 3 个视频片段至 Agora 直播频道，向你演示基本的推流功能。详见[使用推流命令行工具](https://docs-preview.agoralab.co/cn/Server/use_streaming_command_line_tool?platform=Linux)。
- 配套推流预处理工具，包括：
  - 媒体转码工具，以确保媒体文件的编码格式满足要求。详见[使用转码工具](https://docs-preview.agoralab.co/cn/Server/preprocess?platform=Linux#transcoding)。
  - 媒体降噪工具，帮助你在推流前对声音进行增益，从而抑制背景噪声。详见[使用降噪工具](https://docs-preview.agoralab.co/cn/Server/preprocess?platform=Linux#denoise)。
  - AI 补帧工具，在两个不连续的视频片段之间插帧，实现平滑的视频播放效果。详见[使用 AI 补帧工具](https://docs-preview.agoralab.co/cn/Server/preprocess?platform=Linux#interpolation)。
- 集成指南，指导你将 Agora Media Streaming Server SDK 集成到你自己的项目中并调用 API 进行媒体推流。详见[实现媒体推流](https://docs-preview.agoralab.co/cn/Server/media_streaming_on_server?platform=Linux%20C++)。
- Agora Media Streaming Server SDK 的 [API 注释](https://docs.agora.io/cn/AI%20Interactive%20Classroom/API%20Reference/server_cpp/index.html)。

## 学生端功能实现

### 实时音视频

学生端可集成 Agora RTC SDK 实现实时音视频功能，支持 Android、Windows、iOS、macOS 和 Web。

我们提供：

- SDK 下载。
- 示例代码，帮助你了解 API 具体调用方式。示例代码也可以参考 SDK 下载包里面的 Sample Code。
- 集成指南，逐步指导你将 SDK 集成到你自己的项目中。

下载对应平台的 SDK 后，你可以参照快速开始中的步骤将 SDK 集成到自己的项目中，并调用 API 实现音视频通话。具体链接请见下表。

| 平台    | SDK 下载                                                                                                         | 开源示例项目                                                                                                                                                                                                                                    | 集成指南                                                                                                 |
| :------ | :--------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------- |
| Android | [最新版 SDK](https://docs-preprod.agora.io/cn/Interactive%20Broadcast/edu_release_note_android?platform=Android) | [互动直播 Demo Open Live (Java)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-Android)                                                                                                                              | [Android 快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_android?platform=Android) |
| iOS     | [最新版 SDK](https://docs-preprod.agora.io/cn/Interactive%20Broadcast/edu_release_note_ios?platform=iOS)         | [互动直播 Demo Open Live (OC)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-iOS-Objective-C)<br>[互动直播 Demo Open Live (Swift)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-iOS)     | [iOS 快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_ios?platform=iOS)             |
| macOS   | [最新版 SDK](https://docs-preprod.agora.io/cn/Interactive%20Broadcast/edu_release_note_macos?platform=macOS)     | [互动直播 Demo Open Live (OC)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-macOS-Objective-C)<br>[互动直播 Demo Open Live (Swift)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-macOS) | [macOS 快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_mac?platform=macOS)         |
| Windows | [最新版 SDK](https://docs-preprod.agora.io/cn/Interactive%20Broadcast/edu_release_note_windows?platform=Windows) | [互动直播 Demo Open Live (C++)](https://github.com/AgoraIO/Basic-Video-Broadcasting/blob/master/OpenLive-Windows)                                                                                                                               | [Windows 快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_windows?platform=Windows) |
| Web     | [最新版 Web SDK](https://docs.agora.io/cn/Agora%20Platform/downloads)                                            | [互动直播 Demo (JS)](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-Web/README.zh.md)                                                                                                                        | [Web 快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_web?platform=Web)             |

### 实时消息

学生端可集成 Agora RTM SDK 实现实时消息功能，支持 Android、Windows、iOS、macOS 和 Web。

| 概述                                                                                          | SDK 下载                                                                               | 集成指南                                                                                                    |
| :-------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------- |
| [实时消息](https://docs.agora.io/cn/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [云信令（原实时消息）SDK 下载](https://docs.agora.io/cn/Real-time-Messaging/downloads) | [收发点对点消息和频道消息](https://docs.agora.io/cn/Real-time-Messaging/messaging_android?platform=Android) |

### 口语评测

我们提供以下开源示例项目指导你如何将 Agora RTC SDK 采集到的音频发送到第三方平台进行语音识别和口语评测。

| 平台    | 开源示例项目                                                                                                                                      |
| :------ | :------------------------------------------------------------------------------------------------------------------------------------------------ |
| Android | [Pronunciation Assessment (Android)](https://github.com/AgoraIO/Advanced-Audio/tree/dev/backup/Pronunciation-Assess/Pronunciation-Assess-Android) |
| iOS     | [Pronunciation Assessment (iOS)](https://github.com/AgoraIO/Advanced-Audio/tree/dev/backup/Pronunciation-Assess/Pronunciation-Assess-iOS)         |
