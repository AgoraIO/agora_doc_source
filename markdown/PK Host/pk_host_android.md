---
title: 客户端实现
platform: Android
updatedAt: 2020-07-09 17:46:59
---
本文介绍如何使用 Agora SDK 实现视频 PK 连麦场景的重要功能。

## 基础流程图

参考下图，在你的项目中实现如下功能：

- 登录登出

![](https://web-cdn.agora.io/docs-files/1594619113688)

- 跨频道连麦

![](https://web-cdn.agora.io/docs-files/1592882988082)

## 集成指引

对照下表，将相应的 SDK 或服务集成到你的项目中。


| 产品 | SDK 下载 | 集成文档 |
| ---------------- | ---------------- | ---------------- |
| [Agora RTC (Real-time Communication) SDK](https://docs.agora.io/cn/Interactive%20Broadcast/product_live?platform=All%20Platforms)      | [Android 视频互动直播 SDK](https://docs.agora.io/cn/Agora%20Platform/downloads)      | [实现互动直播](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_android?platform=Android) |
| [Agora RTM (Real-time Messaging) SDK](https://docs.agora.io/cn/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [Android 云信令（原实时消息） SDK](https://docs.agora.io/cn/Real-time-Messaging/downloads) | [收发点对点消息和频道消息](https://docs.agora.io/cn/Real-time-Messaging/messaging_android?platform=Android) |
| [第三方美颜 SDK](https://www.faceunity.com/#/developindex) | N/A | [Android 平台集成开发](https://www.faceunity.com/docs_develop/#/markdown/integrate/flow_an) |


## 核心 API 时序图

下图展示如何调用 Agora 的 API 实现一个视频 PK 连麦场景。你可以参考如下 API 时序图进行相应的实现。

<div class="alert note">下图中使用的云服务是 Agora 实现的。如果你需要使用相同功能，需要自行部署。</div>

- 房主加入直播间、发起连麦 PK 请求

![](https://web-cdn.agora.io/docs-files/1592884272275)

- 观众发送聊天信息和切换直播间

![](https://web-cdn.agora.io/docs-files/1592884315307)

## 核心 API 参考

- Agora RTM SDK

| API | 实现功能 |
| ---------------- | ---------------- |
| [createInstance](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a6411640143c4d0d0cd9481937b754dbf)      | 创建并返回一个 RtmClient 实例。      |
| [login](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a995bb1b1bbfc169ee4248bd37e67b24a) | 登录 Agora RTM 系统。登录后你可以使用 RTM 的核心业务逻辑。|
| [createChannel](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a95ebbd1a1d902572b444fef7853f335a) | 创建 Agora RTM 频道。一个 RtmClient 可以创建多个频道。 |
| [join](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#ad7b321869aac2822b3f88f8c01ce0d40) | 加入 Agora RTM 频道。|
| [sendMessage](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a6e16eb0e062953980a92e10b0baec235) | 发送频道消息。成功发送后，频道内所有用户都能收到。 |
| [sendMessageToPeer](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9) | 发送点对点消息，可用于主播向另一个房间的主播发送 PK 连麦邀请。|
| [leave](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a9e0b6aad17bfceb3c9c939351a467d14) | 离开 RTM 频道。 |
| [logout](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a6f5695854e251ddd4ba05547ab47b317) | 登出 Agora RTM 系统。|

- Agora RTC SDK

| API | 实现功能 |
| ---------------- | ---------------- |
| [create](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a35466f690d0a9332f24ea8280021d5ed)      | 创建 RtcEngine 实例。      |
| [setChannelProfile](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a1bfb76eb4365b8b97648c3d1b69f2bd6) | 设置频道场景。本场景中，我们将频道属性设为直播。|
| [setClientRole](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa2affa28a23d44d18b6889fba03f47ec) | 设置直播场景下的用户角色。 |
| [enableVideo](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a99ae52334d3fa255dfcb384b78b91c52) | 开启视频。|
| [setupLocalVideo](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a1fa43a5ce24196e840bcb1062cadbf23) | 设置本地视图。主播需要调用该方法，才能在本地看到自己的画面。 |
| [joinChannel](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8b308c9102c08cb8dafb4672af1a3b4c) | 加入 RTC 频道。 |
| [startChannelMediaRelay](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6f09ba685f8ab01d7dc06173286950f6) | 开始跨频道媒体流转发。这是实现跨直播间连麦场景的 API。|
| [setupRemoteVideo](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0e9f693c9bc2ccb91554c2c7dc6b7140) | 设置远端视图。目标频道主播同意连麦 PK 后，源频道主播需要调用该方法，才能看到连麦主播的视频画面。|
| [stopChannelMediaRelay](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0f9f19e48c21190dd4e697dec632c328) | 停止跨频道媒体流转发。|
| [leaveChannel](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a2929e4a46d5342b68d0deb552c29d597) | 离开 RTC 频道。 |

## 附加功能

**美颜**

Agora Live 使用第三方的 SDK 实现美颜功能。你可以参考示例代码里 faceunity 文件中的逻辑进行实现。

**网络质量检测**

使用 `onRtcStats` 回调，在你的项目中实现网络质量检测和报告功能。该回调统计当前通话数据，包括本地的数据发送和接收码率以及丢包率等。在通话或直播过程中每两秒触发一次。

**本地禁音、禁视频**

调用 `muteLocalAudioStream` 和 `muteLocalVideoStream` 方法，来停止发送本地音频流、视频流。

**耳返**

调用 `enableInEarMonitoring` 方法开启主播的耳返功能。

**混音及音效**

加入频道后，调用 `startAudioMixing` 方法，可以播放音乐文件，实现播放背景音乐的功能。调用 `playEffect` 方法，播放音效文件，实现鼓掌、欢呼、尖叫等氛围音效果。

## 开源示例代码

我们也在 GitHub 上提供了[视频 PK 连麦](https://github.com/AgoraIO-Usecase/AgoraLive)的开源示例项目，你也可以前往下载，或查看其中的源代码。