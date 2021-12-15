---
title: AI 互动课堂
platform: All Platforms
updatedAt: 2020-11-17 07:07:27
---

## 场景介绍

### 场景概述

AI 互动课堂，是指通过服务端真人教学视频结合 AI 技术进行线上直播互动教学的场景。

![](https://web-cdn.agora.io/docs-files/1590057337486)

AI 互动课堂的整体过程如下：

- 上课前：
  - 根据教师的课程设置，将知识点讲解、互动提问、问题反馈和解答等信息录制成视频片段，准备好视频库。
  - 部署服务端推送媒体文件服务。
- 课堂上：
  - 服务端向学生推送并呈现多媒体教学内容，形式包括录播视频、音效和视觉元素。
  - 学生通过语音、触屏实现互动式学习。
  - 服务端通过 AI 技术，智能识别学生的实时语音和作答，并根据学生的表现，无缝切换教学片段，实时给予不同的反馈，从而提供个性化的教学体验。

### 功能列表

| 功能           | 描述                                                                                                                                             |
| :------------- | :----------------------------------------------------------------------------------------------------------------------------------------------- |
| 推送媒体文件   | 服务端能够向 Agora 频道内推送 MP4 文件：<li>支持播放队列，实现上课过程中视频片段的有序切换。<li>支持千人千面，根据学生的作答推送不同的视频片段。 |
| 实时音视频     | 学生端能够在 Agora 频道内发送和接收实时音视频数据。                                                                                              |
| 实时消息       | 学生端能够在 Agora 频道内发送和接收实时消息。                                                                                                    |
| 声音降噪与增益 | 提供降噪工具，有效抑制背景噪声，并对声音进行增益。                                                                                               |
| 视频补帧       | 提供 AI 补帧工具， 实现课程视频片段之间的无缝平滑切换。                                                                                          |
| 口语测评       | 支持 AI 口语测评功能，提供多维度的语音评测结果，并基于评测结果给予学生反馈。                                                                     |
| 情绪识别       | 支持 AI 情绪识别功能，通过检测面部判断学生的开心、平静、惊讶等情绪，生成课堂情绪报告。                                                           |

### Demo 体验

Agora 为 AI 互动课堂提供如下平台的 Demo，方便你即刻体验 AI 互动课堂。

| Android                                     | iOS                                                          |
| :------------------------------------------ | :----------------------------------------------------------- |
| 点击[此处](http://app.agora.io/aiclass)下载 | 点击[此处](https://itunes.apple.com/cn/app/id1480536328)下载 |

## 技术方案

### 技术架构图

![](https://web-cdn.agora.io/docs-files/1589458329133)

学生端：

- 集成 Agora RTC SDK 和 Agora RTM SDK，通过声网自建的底层实时传输网络 Agora SD-RTN™ 发送和接收实时音视频和实时消息，进行实时互动。
- 将实时音频流发送至第三方平台进行语音识别和口语评测。
- 将实时视频流发送至第三方 AI SDK 进行情绪识别。

服务端 AI 教师：

- 从 Agora SD-RTN™ 获取作答信息，与题库比对判断对错。
- 根据比对结果从视频库中获取对应的视频片段，通过 Agora Media Streaming Sever SDK 将视频片段推送给学生端。

### 方案优势

#### 1. 高速稳定的实时数据传输

依托于声网实时音视频专用网络 Agora SD-RTN™，全球部署节点，覆盖 200 多个国家和地区，并针对北美、菲律宾、印度等区域 lastmile 覆盖做了重点优化，确保服务高并发、高可用、高稳定和超低延迟。

#### 2. 优秀的弱网对抗能力

声网通过智能调节码率和帧率、优化端到端全链路算法、运用抖动缓冲机制，确保 70% 丢包情况下，音视频通话流畅，80% 丢包情况下，音频通话流畅。

#### 3. AI 补帧增强

针对视频片段切换时会出现的跳帧问题，声网提供 AI 补帧工具，支持离线对两个不连续的视频片段进行插帧，实现平滑的视频播放效果。

#### 4. 卓越音质

针对室内录播场景中常见的噪声、背景音等音质问题，声网通过自研的 AI 音频降噪算法，提供降噪工具，有效消除背景噪声，并对声音进行增益。

#### 5. AI 情绪识别

声网支持将学生的实时视频流发送到第三方平台，进行人脸检测和情绪识别，判断学生的课堂专注度和开心值。

#### 6. 优秀的设备兼容性

适配 6000+ 机型，针对中低端机型适配，进行性能优化，中低端机型也能流畅进行高清音视频互动。

#### 7. 课中课后质量保障

提供水晶球工具，追踪每节课的质量，保证教学中一切质量问题透明可查。

## 实现方法

### API 时序图

![](https://web-cdn.agora.io/docs-files/1577098826567)

### 教师端功能实现

教师端通过 Agora Media Streaming Server SDK 实现服务端推送媒体文件。

<div class="note alert">点击<a href="https://download.agora.io/ardsdk/release/Agora_MediaStreamingServer_SDK_for_Linux_v2_6_1_180_FULL_20200212_85.tar.gz">此处</a>下载 Agora Media Streaming Server SDK 包。</div>
	
我们提供：

- 服务端媒体推流命令行工具，可以循环推送 3 个视频片段至 Agora 直播频道，向你演示基本的推流功能。详见[使用推流命令行工具](https://docs-preview.agoralab.co/cn/Server/use_streaming_command_line_tool?platform=Linux)。
- 配套推流预处理工具，包括：
  - 媒体转码工具，以确保媒体文件的编码格式满足要求。详见[使用转码工具](https://docs-preview.agoralab.co/cn/Server/preprocess?platform=Linux#transcoding)。
  - 媒体降噪工具，帮助你在推流前对声音进行增益，从而抑制背景噪声。详见[使用降噪工具](https://docs-preview.agoralab.co/cn/Server/preprocess?platform=Linux#denoise)。
  - AI 补帧工具，在两个不连续的视频片段之间插帧，实现平滑的视频播放效果。详见[使用 AI 补帧工具](https://docs-preview.agoralab.co/cn/Server/preprocess?platform=Linux#interpolation)。
- 集成指南，指导你将 Agora Media Streaming Server SDK 集成到你自己的项目中并调用 API 进行媒体推流。详见[实现媒体推流](https://docs-preview.agoralab.co/cn/Server/media_streaming_on_server?platform=Linux%20C++)。
- Agora Media Streaming Server SDK 的 [API 注释](https://docs-preview.agoralab.co/cn/Server/API%20Reference/server_cpp/index.html)。

### 学生端功能实现

#### 实时音视频

学生端可集成 Agora RTC SDK 实现实时音视频功能，支持 Android、Windows、iOS、macOS 和 Web。

我们提供：

- SDK 下载。
- 示例代码，帮助你了解 API 具体调用方式。示例代码也可以参考 SDK 下载包里面的 Sample Code。
- 集成指南，逐步指导你将 SDK 集成到你自己的项目中。

下载对应平台的 SDK 后，你可以参照快速开始中的步骤将 SDK 集成到自己的项目中，并调用 API 实现音视频通话。具体链接请见下表。

| 平台    | SDK 下载                                                                                                            | 开源示例项目                                                                                                                                                                                                                                    | 集成指南                                                                                                 |
| :------ | :------------------------------------------------------------------------------------------------------------------ | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------- |
| Android | [最新版 SDK](https://docs-preview.agoralab.co/cn/Interactive%20Broadcast/edu_release_note_android?platform=Android) | [互动直播 Demo Open Live (Java)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-Android)                                                                                                                              | [Android 快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_android?platform=Android) |
| iOS     | [最新版 SDK](https://docs-preview.agoralab.co/cn/Interactive%20Broadcast/edu_release_note_ios?platform=iOS)         | [互动直播 Demo Open Live (OC)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-iOS-Objective-C)<br>[互动直播 Demo Open Live (Swift)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-iOS)     | [iOS 快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_ios?platform=iOS)             |
| macOS   | [最新版 SDK](https://docs-preview.agoralab.co/cn/Interactive%20Broadcast/edu_release_note_macos?platform=macOS)     | [互动直播 Demo Open Live (OC)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-macOS-Objective-C)<br>[互动直播 Demo Open Live (Swift)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-macOS) | [macOS 快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_mac?platform=macOS)         |
| Windows | [最新版 SDK](https://docs-preview.agoralab.co/cn/Interactive%20Broadcast/edu_release_note_windows?platform=Windows) | [互动直播 Demo Open Live (C++)](https://github.com/AgoraIO/Basic-Video-Broadcasting/blob/master/OpenLive-Windows)                                                                                                                               | [Windows 快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_windows?platform=Windows) |
| Web     | [最新版 Web SDK](https://docs.agora.io/cn/Agora%20Platform/downloads)                                               | [互动直播 Demo (JS)](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-Web/README.zh.md)                                                                                                                        | [Web 快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_web?platform=Web)             |

#### 实时消息

学生端可集成 Agora RTM SDK 实现实时消息功能，支持 Android、Windows、iOS、macOS 和 Web。

| 概述                                                                                          | SDK 下载                                                                    | 集成指南                                                                                                    |
| :-------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------- |
| [实时消息](https://docs.agora.io/cn/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [实时消息 SDK 下载](https://docs.agora.io/cn/Real-time-Messaging/downloads) | [收发点对点消息和频道消息](https://docs.agora.io/cn/Real-time-Messaging/messaging_android?platform=Android) |

#### 口语评测

我们提供以下开源示例项目指导你如何将 Agora RTC SDK 采集到的音频发送到第三方平台进行语音识别和口语评测。

| 平台    | 开源示例项目                                                                                                                                      |
| :------ | :------------------------------------------------------------------------------------------------------------------------------------------------ |
| Android | [Pronunciation Assessment (Android)](https://github.com/AgoraIO/Advanced-Audio/tree/dev/backup/Pronunciation-Assess/Pronunciation-Assess-Android) |
| iOS     | [Pronunciation Assess (iOS)](https://github.com/AgoraIO/Advanced-Audio/tree/dev/backup/Pronunciation-Assess/Pronunciation-Assess-iOS)             |
