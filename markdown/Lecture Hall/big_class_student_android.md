---
title: 学生端实现
platform: Android
updatedAt: 2020-05-13 19:13:17
---

本文展示如何在 Android 平台实现学生端相关功能。

## 基础流程图

参考下图，在你的项目中实现学生端的登录登出功能。

![](https://web-cdn.agora.io/docs-files/1579590468311)

## 集成指引

根据下表链接，下载对应的 SDK，参考《快速开始》文档的步骤将 SDK 集成到你的项目中。

| 产品                                                                                                                              | SDK 下载                                                                                                                         | 集成文档                                                                                                                                     |
| --------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| [Agora RTC (Real-time Communication) SDK](https://docs.agora.io/cn/Interactive%20Broadcast/product_live?platform=All%20Platforms) | [Android 视频互动直播 SDK](https://download.agora.io/sdk/release/Agora_Native_SDK_for_Android_v2_9_0_103_FULL_20200325_1695.zip) | [实现互动直播](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_android?platform=Android)                                         |
| [Agora RTM (Real-time Messaging) SDK](https://docs.agora.io/cn/Real-time-Messaging/product_rtm?platform=All%20Platforms)          | [Android 云信令（原实时消息） SDK](https://docs.agora.io/cn/Real-time-Messaging/downloads)                                       | [收发点对点消息和频道消息](https://docs.agora.io/cn/Real-time-Messaging/messaging_android?platform=Android)                                  |
| Agora 房间管理服务                                                                                                                | /                                                                                                                                | [Agora 房间管理服务快速开始](https://github.com/AgoraIO-Usecase/eEducation/wiki/eEducation-5.0.0-%E4%BD%BF%E7%94%A8%E6%8C%87%E5%8D%97#cloud) |
| [白板](https://developer.netless.link/docs/android/overview/android-introduction/)                                                | [SDK 集成](https://developer.netless.link/docs/android/quick-start/android-prepare/)                                             | [白板快速开始](https://developer.netless.link/android-zh/home/android-prepare)                                                               |

## 核心 API 时序图

参考下图时序，搭配使用 RTC SDK 和 RTM SDK 在你的项目中实现基础的实时音视频和实时消息功能。

![](https://web-cdn.agora.io/docs-files/1579589777899)

## 核心 API 参考

- RTM SDK

| API                                                                                                                                                                                                         | 实现功能                                                                                                                      |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| [createInstance](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a6411640143c4d0d0cd9481937b754dbf)                                       | 创建并返回一个 RtmClient 实例。                                                                                               |
| [login](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a995bb1b1bbfc169ee4248bd37e67b24a)                                                | 登录 Agora RTM 系统。登录后你可以使用 RTM 的核心业务逻辑。                                                                    |
| [createChannel](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a95ebbd1a1d902572b444fef7853f335a)                                        | 创建 Agora RTM 频道。一个 RtmClient 可以创建多个频道。                                                                        |
| [join](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#ad7b321869aac2822b3f88f8c01ce0d40)                                                | 加入 Agora RTM 频道。                                                                                                         |
| [getChannelAttributes](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a81f14a747a4012815ab4ba8d9e480fb6)                                 | 获取指定频道的频道属性。                                                                                                      |
| [queryPeersOnlineStatus](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ac711f981405648ed5ef1cb07436125f3)                               | 查询指定用户的在线状态。                                                                                                      |
| [ceateMessage](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a77dbd15cb6c9db3844fb313bd5dceac3)                                         | 创建并返回一个 RtmMessage 消息示例。可创建文本消息、二进制消息、原始数据消息。                                                |
| [sendMessageToPeer](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a25ab5c0126e1dc51c78b2b705de68b7a)                                    | 发送点对点消息。可实现学生举手申请发言等功能。                                                                                |
| [setEnableNotificationToChannelMembers](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_channel_attribute_options.html#a2f240727791b3ad1af97f4a399ce1579) | 设置通知所有频道成员本地频道属性变更。当本地频道属性变更时，会在远端触发 onAttributesUpdated 回调。每次设置仅对本次变更有效。 |
| [addOrUpdateChannelAttributes](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a997a31e6bfe1edc9b6ef58a931ef3f23)                         | 添加或更新指定频道的属性。                                                                                                    |
| [sendMessage](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a6e16eb0e062953980a92e10b0baec235)                                         | 发送频道消息。成功发送后，频道内所有用户都能收到。                                                                            |
| [leave](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a9e0b6aad17bfceb3c9c939351a467d14)                                               | 离开 RTM 频道。                                                                                                               |
| [logout](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a6f5695854e251ddd4ba05547ab47b317)                                               | 登出 Agora RTM 系统。                                                                                                         |

- RTC SDK

| API                                                                                                                                                                      | 实现功能                                                                                                                                                                       |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [create](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a35466f690d0a9332f24ea8280021d5ed)            | 创建 RtcEngine 实例。                                                                                                                                                          |
| [setChannelProfile](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a1bfb76eb4365b8b97648c3d1b69f2bd6) | 设置频道场景。互动直播大班课场景中，我们将频道属性设为直播。                                                                                                                   |
| [setClientRole](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa2affa28a23d44d18b6889fba03f47ec)     | 设置直播场景下的用户角色。互动直播大班课场景中，我们将学生进频道前的用户角色设为观众；上课过程中，当学生成功申请发言后，我们再将其用户角色设为主播，与同为主播的老师进行互动。 |
| [joinChannel](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8b308c9102c08cb8dafb4672af1a3b4c)       | 加入 RTC 频道。                                                                                                                                                                |
| [setupRemoteVideo](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0e9f693c9bc2ccb91554c2c7dc6b7140)  | 设置远端视图。学生加入频道后，调用该方法设置其看到的老师的视频画面。                                                                                                           |
| [setupLocalVideo](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a1fa43a5ce24196e840bcb1062cadbf23)   | 设置本地视图。学生成功申请发言后，调用该方法设置其看到的自己的视频画面。                                                                                                       |
| [leaveChannel](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a2929e4a46d5342b68d0deb552c29d597)      | 离开 RTC 频道。                                                                                                                                                                |

## 附加功能

除基础的实时音视频和实时消息功能外，你还可以参考下文，在项目中实现更多教育场景的附加功能。

<details>
<summary>网络质量监测</summary>
你可以通过使用 RTC SDK 的 <code>onNetworkQuality</code> 回调，实时监控通话中每个用户的网络上下行 last mile 网络质量。
更多质量透明相关方法，可参考如下文档：
<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/lastmile_quality_android?platform=Android">通话前网络质量探测</a></li>
<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/in-call_quality_android?platform=Android">通话中质量监测</a></li>
</details>
<details>
<summary>关闭本地音视频</summary>
你可以通过调用 RTC SDK 的如下方法，实现相关功能：
<li>调用 <code>muteLocalAudioStream</code> 关闭本地音频发送。</li>
<li>调用 <code>muteLocalVideoStream</code> 关闭本地视频发送。</li>
</details>
<details>
<summary>人声检测</summary>
对于 v2.9.1 及以上的 RTC Native SDK，你还可以调用 <code>enableAudioVolumeIndication</code> 方法，并将参数 <code>report_vad</code> 设为 <code>true</code>，启用人声检测功能。
启用后，你会在 <code>onAudioVolumeIndication</code> 回调报告的 <code>AudioVolumeInfo</code> 结构体中获取本地用户的人声状态。
</details>
<details>
<summary>白板</summary>
参考下列常用功能文档，在你的项目中实现白板相关功能。
	<li><a href="https://developer.netless.link/android-zh/home/android-create-room">创建白板房间和获取白板房间信息</a></li>
	<li><a href="https://developer.netless.link/android-zh/home/android-document">文档转换</a></li>
		<li><a href="https://developer.netless.link/android-zh/home/android-state">状态管理</a></li>
	<li><a href="https://developer.netless.link/android-zh/home/android-tools">使用教具</a></li>
	<li><a href="https://developer.netless.link/android-zh/home/android-view">视角操作</a></li>
	<li><a href="https://developer.netless.link/android-zh/home/android-operation">白板操作</a></li>
	<li><a href="https://developer.netless.link/android-zh/home/android-scenes">页面（场景）管理</a></li>
</details>

## 开源示例项目

我们也在 GitHub 上提供了互动直播大课的[开源示例项目](https://github.com/AgoraIO-Usecase/eEducation)，你也可以前往下载，或查看其中的源代码。
