---
title: 客户端实现
platform: iOS
updatedAt: 2020-10-16 11:15:51
---
本文介绍如何使用 Agora SDK 实现电商直播场景的重要功能。

## 基础流程图

参考下图，在你的项目中实现如下功能：

- 登录登出

![](https://web-cdn.agora.io/docs-files/1594619113688)

- 跨频道连麦

![](https://web-cdn.agora.io/docs-files/1592882988082)

- 与观众互动连麦

![](https://web-cdn.agora.io/docs-files/1602222177503)

- 管理商品列表

<div class="alert note">下图仅供参考。如果你需要使用管理商品列表功能，需要自行设计并部署。</div>

![](https://web-cdn.agora.io/docs-files/1602218451199)

## 集成指引

对照下表，将相应的 SDK 或服务集成到你的项目中。


| 产品 | SDK 下载 | 集成文档 |
| ---------------- | ---------------- | ---------------- |
| [Agora RTC (Real-time Communication) SDK](https://docs.agora.io/cn/Interactive%20Broadcast/product_live?platform=All%20Platforms)      | [iOS 视频互动直播 SDK](https://docs.agora.io/cn/Agora%20Platform/downloads)      | [实现互动直播](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_ios?platform=iOS) |
| [Agora RTM (Real-time Messaging) SDK](https://docs.agora.io/cn/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [iOS 云信令（原实时消息） SDK](https://docs.agora.io/cn/Real-time-Messaging/downloads) | [收发点对点消息和频道消息](https://docs.agora.io/cn/Real-time-Messaging/messaging_ios?platform=iOS) |
| [第三方美颜 SDK](https://www.faceunity.com/#/developindex) | N/A | [iOS 平台集成开发](https://www.faceunity.com/docs_develop/#/markdown/integrate/flow_io) |


## 核心 API 时序图

下图展示如何调用 Agora 的 API 实现一个电商直播场景。你可以参考如下 API 时序图进行相应的实现。

<div class="alert note">下图中使用的云服务是 Agora 实现的。如果你需要使用相同功能，需要自行部署。</div>

- 房主加入直播间并开始直播
 ![](https://web-cdn.agora.io/docs-files/1602224614451)

- 房主与观众互动连麦
 ![](https://web-cdn.agora.io/docs-files/1602224643010)

- 房主发起 PK 连麦邀请
 ![](https://web-cdn.agora.io/docs-files/1602224684613)

- 观众发送聊天信息和切换直播间

![](https://web-cdn.agora.io/docs-files/1592895674546)

## 核心 API 参考

- Agora RTM SDK

| API | 实现功能 |
| ---------------- | ---------------- |
| [initWithAppId](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/initWithAppId:delegate:)        | 创建并返回一个 RtmClient 实例。      |
| [loginByToken](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/loginByToken:user:completion:) | 登录 Agora RTM 系统。登录后你可以使用 RTM 的核心业务逻辑。|
| [createChannelWithId](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/createChannelWithId:delegate:) | 创建 Agora RTM 频道。一个 RtmClient 可以创建多个频道。 |
| [joinWithCompletion](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/joinWithCompletion:) | 加入 Agora RTM 频道。|
| [sendMessage](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/sendMessage:completion:) | 发送频道消息。成功发送后，频道内所有用户都能收到。 |
| [sendMessage](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/sendMessage:toPeer:sendMessageOptions:completion:) | 发送点对点消息，可用于主播向观众或另一个房间的主播发送连麦邀请；也可用于观众向主播发送上麦申请。|
| [leaveWithCompletion](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/leaveWithCompletion:) | 离开 RTM 频道。 |
| [logoutWithCompletion](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/logoutWithCompletion:) | 登出 Agora RTM 系统。|

- Agora RTC SDK

| API | 实现功能 |
| ---------------- | ---------------- |
|  [sharedEngineWithAppId](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/sharedEngineWithAppId:delegate:)      | 初始化 AgoraRtcEngineKit 对象。      |
| [setChannelProfile](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setChannelProfile:) | 设置频道场景。本场景中，我们将频道属性设为直播。|
| [setClientRole](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setClientRole:) | 设置直播场景下的用户角色。该方法可实现用户的上下麦。 |
| [enableVideo](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableVideo) | 开启视频。|
| [setupLocalVideo](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setupLocalVideo:) | 设置本地视图。主播或连麦主播需要调用该方法，才能在本地看到自己的画面。 |
| [joinChannelByToken](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:) | 加入 RTC 频道。 |
| [startChannelMediaRelay](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startChannelMediaRelay:) | 开始跨频道媒体流转发。这是实现跨直播间连麦场景的 API。|
| [setupRemoteVideo](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setupRemoteVideo:) | 设置远端视图。观众或目标频道主播同意连麦后，源频道主播需要调用该方法，才能看到连麦主播的视频画面。|
| [stopChannelMediaRelay](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopChannelMediaRelay) | 停止跨频道媒体流转发。|
| [leaveChannel](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/leaveChannel:) | 离开 RTC 频道。 |

## 附加功能

**美颜**

Agora Live 使用第三方的 SDK 实现美颜功能。你可以参考示例代码里 faceunity 文件中的逻辑进行实现。

**网络质量检测**

使用 `reportRtcStats` 回调，在你的项目中实现网络质量检测和报告功能。该回调统计当前通话数据，包括本地的数据发送和接收码率以及丢包率等。在通话或直播过程中每两秒触发一次。

**耳返**

调用 `enableInEarMonitoring` 方法开启主播的耳返功能。

**混音及音效**

加入频道后，调用 `startAudioMixing` 方法，可以播放音乐文件，实现播放背景音乐的功能。调用 `playEffect` 方法，播放音效文件，实现鼓掌、欢呼、尖叫等氛围音效果。

## 开源示例代码

我们也在 GitHub 上提供了[电商直播](https://github.com/AgoraIO-Usecase/AgoraLive)的开源示例项目，你也可以前往下载，或查看其中的源代码。