---
title: 实现流程
platform: Linux
updatedAt: 2021-03-31 08:45:23
---

本文介绍智能摄像头场景中设备端和客户端的实现流程。

## 设备端功能实现

设备端需集成 Agora RTSA Lite SDK，集成时可以参考以下文档：

- [快速跑通示例项目](https://docs.agora.io/cn/RTSA/demo_guide_linux?platform=Linux)
- [实现码流加速](https://docs.agora.io/cn/RTSA/transmit_streams_linux?platform=Linux)
- [API 参考](https://docs.agora.io/cn/RTSA/API%20Reference/rtsa_c/index.html)

### 设备端业务流程图

![设备端业务流程图](https://web-cdn.agora.io/docs-files/1617163508906)

### 实时音视频 API 时序图

下图展示了从设备端向客户端发送实时音视频的 API 时序。

<div class="alert note">图中红色部分非声网提供的 API，需要你自行实现。</div>

![设备端实时音视频 API 时序图](https://web-cdn.agora.io/docs-files/1617163461105)

### 实时信令 API 时序图

下图展示了设备端和客户端进行实时信令交互的 API 时序。

![设备端实时信令 API 时序图](https://web-cdn.agora.io/docs-files/1617163491334)

## 客户端功能实现

客户端需集成 Agora RTC 视频 SDK 实现实时音视频功能，集成 Agora RTM SDK 实现实时信令功能。

你可以在开发者中心[下载专区](https://docs.agora.io/cn/smart-camera/downloads)下载所需平台的 Agora RTC 视频 SDK 和 RTM SDK。下载 SDK 后，参考下述内容集成：

- GitHub 示例项目，帮助你了解 API 具体调用方式。
- 快速开始文档，逐步指导你将 SDK 集成到你自己的项目中。

|         | Android                                                                                                                                                                                 | iOS                                                                                                                                                                   | Web                                                                                                                                                                           | macOS                                                                                                                                                                           | Windows                                                                                                                                                                               |
| :------ | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| RTC SDK | [示例项目](https://github.com/AgoraIO/API-Examples/tree/master/Android/APIExample)<br/>[快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_android?platform=Android) | [示例项目](https://github.com/AgoraIO/API-Examples/tree/master/iOS)<br/>[快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_ios?platform=iOS)      | [示例项目](https://github.com/AgoraIO-Community/AgoraWebSDK-NG/tree/master/Demo)<br/>[快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_web?platform=Web) | [示例项目](https://github.com/AgoraIO/API-Examples/tree/master/macOS/APIExample)<br/>[快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_mac?platform=macOS) | [示例项目](https://github.com/AgoraIO/API-Examples/tree/master/windows)<br/>[快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_windows?platform=Windows)          |
| RTM SDK | [示例项目](https://github.com/AgoraIO/RTM/tree/master/Agora-RTM-Tutorial-Android)<br/>[快速开始](https://docs.agora.io/cn/Real-time-Messaging/messaging_android?platform=Android)       | [示例项目](https://github.com/AgoraIO/RTM/tree/master/Agora-RTM-Tutorial-iOS)<br/>[快速开始](https://docs.agora.io/cn/Real-time-Messaging/messaging_ios?platform=iOS) | [示例项目](https://github.com/AgoraIO/RTM/tree/master/Agora-RTM-Tutorial-Web)<br/>[快速开始](https://docs.agora.io/cn/Real-time-Messaging/messaging_web?platform=Web)         | [示例项目](https://github.com/AgoraIO/RTM/tree/master/Agora-RTM-Tutorial-macOS)<br/>[快速开始](https://docs.agora.io/cn/Real-time-Messaging/messaging_mac?platform=macOS)       | [示例项目](https://github.com/AgoraIO/RTM/tree/master/Agora-RTM-Tutorial-Windows)<br/>[快速开始](https://docs.agora.io/cn/Real-time-Messaging/messaging_cpp_windows?platform=Windows) |

## 集成注意事项

- 集成 RTC SDK 时，请确保频道场景设为直播，用户角色设为主播。
- 如果客户端需要支持 Web 平台，请确保设备端传输的音频为 PCM 格式或者编码后的 Opus 格式。
