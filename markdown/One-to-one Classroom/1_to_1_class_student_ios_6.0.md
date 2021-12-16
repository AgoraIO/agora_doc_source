---
title: 学生端实现
platform: iOS
updatedAt: 2020-11-02 19:50:05
---
本文展示如何在 Android 平台实现学生端相关功能。

## 集成指引

根据下表链接，下载对应的 SDK，参考集成文档的步骤将 SDK 集成到你的项目中。

 
| 产品 | SDK 下载 | 集成文档 |
| ---------------- | ---------------- | ---------------- |
| [Agora RTC (Real-time Communication) SDK](https://docs.agora.io/cn/Video/product_video?platform=All%20Platforms)      | [iOS 视频通话 SDK](https://download.agora.io/sdk/release/Agora_Native_SDK_for_iOS_v2_9_0_103_FULL_20200325_2479.zip)     | [实现视频通话](https://docs.agora.io/cn/Video/start_call_ios?platform=iOS) |
| [Agora RTM (Real-time Messaging) SDK](https://docs.agora.io/cn/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [iOS 云信令（原实时消息） SDK](https://docs.agora.io/cn/Real-time-Messaging/downloads) | [收发点对点消息和频道消息](https://docs.agora.io/cn/Real-time-Messaging/messaging_ios?platform=iOS) |
| Agora 房间管理服务 | N/A | [房间管理服务 API 文档](https://agoradoc.github.io/cn/edu-cloud-service/restfulapi) |
| [白板](https://developer.herewhite.com/ios-zh/home) | [SDK 集成](https://developer.herewhite.com/ios-zh/home/ios-prepare) | N/A | 


## 核心 API 时序图

参考下图了解学生端实现的基础流程和 API 调用。

<div class="alert info">教育 SDK 是基于 Agora RTC SDK、Agora RTM SDK 和 Agora 房间管理服务封装的场景化 SDK，API 设计与实际业务场景更贴近、更易用。教育 SDK 当前处于内部测试体验阶段，如有疑问，请至 GitHub 提交 <a href="https://github.com/AgoraIO-Usecase/eEducation">issue</a>。</div>

### 基础流程

![](https://web-cdn.agora.io/docs-files/1604316413983)

### 更新教室信息

![](https://web-cdn.agora.io/docs-files/1604316426966)

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
