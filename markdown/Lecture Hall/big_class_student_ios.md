---
title: 学生端实现
platform: iOS
updatedAt: 2020-05-11 16:51:49
---
本文展示如何在 iOS 平台实现学生端相关功能。

## 基础流程图

参考下图，在你的项目中实现学生端的登录登出功能。

![](https://web-cdn.agora.io/docs-files/1579590490294)

## 集成指引

根据下表链接，下载对应的 SDK，参考《快速开始》文档的步骤将 SDK 集成到你的项目中。


| 产品 | SDK 下载 | 集成文档 |
| ---------------- | ---------------- | ---------------- |
| [Agora RTC (Real-time Communication) SDK](https://docs.agora.io/cn/Interactive%20Broadcast/product_live?platform=All%20Platforms)      | [iOS 视频互动直播 SDK](https://download.agora.io/sdk/release/Agora_Native_SDK_for_iOS_v2_9_0_103_FULL_20200325_2479.zip)     | [实现互动直播](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_ios?platform=iOS) |
| [Agora RTM (Real-time Messaging) SDK](https://docs.agora.io/cn/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [iOS 云信令（原实时消息） SDK](https://docs.agora.io/cn/Real-time-Messaging/downloads) | [收发点对点消息和频道消息](https://docs.agora.io/cn/Real-time-Messaging/messaging_ios?platform=iOS) |
| Agora Edu 云服务 | / | [Agora Edu 云服务快速开始](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-%E4%BA%91%E6%9C%8D%E5%8A%A1) |
| [白板](https://developer.netless.link/docs/ios/overview/ios-introduction/) | [SDK 集成](https://developer.netless.link/docs/ios/quick-start/ios-prepare/) | [白板快速开始](https://developer.netless.link/ios-zh/home/ios-prepare) | 



## 核心 API 时序图

参考下图时序，搭配使用 [RTC SDK](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#agora-rtc-sdk) 和 [RTM SDK](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#agora-rtm-sdk) 在你的项目中实现基础的实时音视频和实时消息功能。

![](https://web-cdn.agora.io/docs-files/1581925319128)

## 核心 API 参考

- RTM SDK

| API | 实现功能 |
| ---------------- | ---------------- |
| [initWithAppId](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/initWithAppId:delegate:)      | 创建并返回一个 AgoraRtmKit 实例。      |
| [loginByToken](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/loginByToken:user:completion:) | 登录 Agora RTM 系统。登录后你可以使用 RTM 的核心业务逻辑。|
| [createChannelWithId](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/createChannelWithId:delegate:) | 创建 Agora RTM 频道。一个 AgoraRtmKit 可以创建多个频道。 |
| [joinWithCompletion](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/joinWithCompletion:) | 加入 Agora RTM 频道。|
| [getChannelAllAttributes](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/createChannelWithId:delegate:) | 获取指定频道的频道属性。 |
| [queryPeersOnlineStatus](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/queryPeersOnlineStatus:completion:) | 查询指定用户的在线状态。 |
| [sendMessage](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/sendMessage:toPeer:sendMessageOptions:completion:) | 发送点对点消息。可实现学生举手申请发言等功能。 |
| [addOrUpdateChannelAttributes](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/addOrUpdateChannel:Attributes:Options:completion:) | 添加或更新指定频道的属性。你可以在该方法中设置是否将本次变更通知到频道内所有成员。 |
| [sendMessage](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/sendMessage:completion:) | 发送频道消息。成功发送后，频道内所有用户都能收到。 |
| [leaveWithCompletion](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/leaveWithCompletion:) | 离开 RTM 频道。 |
| [logoutWithCompletion](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/logoutWithCompletion:) | 登出 Agora RTM 系统。|

- Native SDK

| API | 实现功能 |
| ---------------- | ---------------- |
| [sharedEngineWithAppId](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/sharedEngineWithAppId:delegate:)      | 初始化 AgoraRtcEngineKit 对象。      |
| [setChannelProfile](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setChannelProfile:) | 设置频道场景。互动直播大班课场景中，我们将频道属性设为直播。|
| [setClientRole](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setClientRole:) | 设置直播场景下的用户角色。互动直播大班课场景中，我们将学生进频道前的用户角色设为观众；上课过程中，当学生成功申请发言后，我们再将其用户角色设为主播，与同为主播的老师进行互动。 |
| [joinChannelByToken](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:) | 加入 RTC 频道。 |
| [setupRemoteVideo](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setupRemoteVideo:) | 设置远端视图。学生加入频道后，调用该方法设置其看到的教师的视频画面。|
| [setupLocalVideo](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setupLocalVideo:) | 设置本地视图。学生成功申请发言后，调用该方法设置其看到的自己的视频画面。 |
| [leaveChannel](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/leaveChannel:) | 离开 RTC 频道。 |

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