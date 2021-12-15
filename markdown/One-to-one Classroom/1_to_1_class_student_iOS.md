---
title: 学生端实现
platform: iOS
updatedAt: 2020-05-11 17:01:36
---

本文展示如何在 iOS 平台实现学生端相关功能。

## 基础流程图

参考下图，在你的项目中实现学生端的登录登出功能。

![](https://web-cdn.agora.io/docs-files/1579592627343)

## 集成指引

根据下表链接，下载对应的 SDK，参考《快速开始》文档的步骤将 SDK 集成到你的项目中。

| 产品                                                                                                               | SDK 下载                                                                                                             | 集成文档                                                                                            |
| ------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| [RTC (Real-time Communication) SDK](https://docs.agora.io/cn/Video/product_video?platform=All%20Platforms)         | [iOS 视频通话 SDK](https://download.agora.io/sdk/release/Agora_Native_SDK_for_iOS_v2_9_0_103_FULL_20200325_2479.zip) | [实现视频通话](https://docs.agora.io/cn/Video/start_call_ios?platform=iOS)                          |
| [RTM (Real-time Messaging) SDK](https://docs.agora.io/cn/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [iOS 实时消息 SDK](https://docs.agora.io/cn/Real-time-Messaging/downloads)                                           | [收发点对点消息和频道消息](https://docs.agora.io/cn/Real-time-Messaging/messaging_ios?platform=iOS) |
| [白板](https://developer.netless.link/docs/ios/overview/ios-introduction/)                                         | [SDK 集成](https://developer.netless.link/docs/ios/quick-start/ios-prepare/)                                         | [白板快速开始](https://developer.netless.link/docs/ios/quick-start/ios-init-sdk/)                   |

## 核心 API 时序图

参考下图时序，搭配使用 Agora RTC SDK、Agora RTM SDK 和 Agora Edu 云服务在你的项目中实现基础的实时音视频、实时消息和教室信息管理功能。

![](https://web-cdn.agora.io/docs-files/1589187029226)

## 核心 API 参考

- Agora Edu 云服务

| API                                                                                                                                                     | 实现功能       |
| ------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- |
| [entry](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-%E4%BA%91%E6%9C%8D%E5%8A%A1#%E8%BF%9B%E5%85%A5%E6%95%99%E5%AE%A4)                  | 进入教室。     |
| [get room info](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-%E4%BA%91%E6%9C%8D%E5%8A%A1#%E5%88%9D%E5%A7%8B%E5%8C%96%E6%95%99%E5%AE%A4) | 获取教室信息。 |
| [change room info](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-%E4%BA%91%E6%9C%8D%E5%8A%A1#change-room-info)                           | 修改教室信息。 |
| [change user info](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-%E4%BA%91%E6%9C%8D%E5%8A%A1#change-user-info)                           | 修改用户信息。 |

- Agora RTM SDK

| API                                                                                                                                                          | 实现功能                                                   |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------- |
| [initWithAppId](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/initWithAppId:delegate:)             | 创建并返回一个 AgoraRtmKit 实例。                          |
| [loginByToken](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/loginByToken:user:completion:)        | 登录 Agora RTM 系统。登录后你可以使用 RTM 的核心业务逻辑。 |
| [createChannelWithId](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/createChannelWithId:delegate:) | 创建 Agora RTM 频道。一个 AgoraRtmKit 可以创建多个频道。   |
| [joinWithCompletion](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/joinWithCompletion:)        | 加入 Agora RTM 频道。                                      |
| [initWithText](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmMessage.html#//api/name/initWithText:)                    | 创建一个文本消息实例。                                     |
| [sendMessage](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/sendMessage:completion:)           | 发送频道消息。成功发送后，频道内所有用户都能收到。         |
| [leaveWithCompletion](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/leaveWithCompletion:)      | 离开 RTM 频道。                                            |
| [logoutWithCompletion](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/logoutWithCompletion:)        | 登出 Agora RTM 系统。                                      |

- Agora RTC SDK

| API                                                                                                                                     | 实现功能                                                                                                                                           |
| --------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| [sharedEngineWithAppId](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/sharedEngineWithAppId:delegate:)                 | 初始化 `AgoraRtcEngineKit` 对象。                                                                                                                  |
| [enableVIdeo](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableVideo:)                                              | 启用视频模块。                                                                                                                                     |
| [setVideoEncoderConfiguration](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoEncoderConfiguration:)            | 设置视频编码配置。                                                                                                                                 |
| [setupLocalVideo](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setupLocalVideo:)                                      | 设置本地视图。                                                                                                                                     |
| [joinChannelByToken](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:) | 加入 RTC 频道。你可以在加入频道前调用 [startPreview](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startPreview) 来加快本地出图。 |
| [setupRemoteVideo](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setupRemoteVideo:)                                    | 设置远端视图。                                                                                                                                     |
| [leaveChannel](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/leaveChannel:)                                            | 离开 RTC 频道。                                                                                                                                    |

<div class="alert note">Agora RTC SDK 默认的频道场景为通信场景。</div>

## 附加功能

除基础的实时音视频和实时消息功能外，你还可以参考下文，在项目中实现更多教育场景的附加功能。

<details>
<summary>网络质量监测</summary>
你可以通过使用 RTC SDK 的 <code>networkQuality</code> 回调，实时监控通话中每个用户的网络上下行 last mile 网络质量。
更多质量透明相关方法，可参考如下文档：
<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/lastmile_quality_ios?platform=iOS">通话前网络质量探测</a></li>
<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/in-call_quality_apple?platform=iOS">通话中质量监测</a></li>
</details>
<details>
<summary>关闭本地音视频</summary>
你可以通过调用 RTC SDK 的如下方法，实现相关功能：
<li>调用 <code>muteLocalAudioStream</code> 关闭本地音频发送。</li>
<li>调用 <code>muteLocalVideoStream</code> 关闭本地视频发送。</li>
</details>
<details>
<summary>人声检测</summary>
对于 v2.9.1 及以上的 RTC Native SDK，你还可以调用 <code>enableAudioVolumeInfication</code> 方法，并将参数 <code>report_vad</code> 设为 <code>true</code>，启用人声检测功能。
启用后，你会在 <code>reportAudioVolumeIndicationOfSpeakers</code> 回调报告的 <code>AgoraRtcAudioVolumeInfo</code> 结构体中获取本地用户的人声状态。
</details>
<details>
<summary>白板</summary>
参考下列常用功能文档，在你的项目中实现白板相关功能。
	<li><a href="https://developer.netless.link/ios-zh/home/ios-create-room">创建白板房间和获取白板房间信息</a></li>
	<li><a href="https://developer.netless.link/ios-zh/home/ios-document">文档转换</a></li>
	<li><a href="https://developer.netless.link/ios-zh/home/ios-state">状态管理</a></li>
	<li><a href="https://developer.netless.link/ios-zh/home/ios-tools">使用教具</a></li>
	<li><a href="https://developer.netless.link/ios-zh/home/ios-view">视角操作</a></li>
	<li><a href="https://developer.netless.link/ios-zh/home/ios-operation">白板操作</a></li>
	<li><a href="https://developer.netless.link/ios-zh/home/ios-scenes">页面（场景）管理</a></li>
</details>

## 开源示例项目

我们也在 GitHub 上提供了互动直播大课的[开源示例项目](https://github.com/AgoraIO-Usecase/eEducation)，你也可以前往下载，或查看其中的源代码。
