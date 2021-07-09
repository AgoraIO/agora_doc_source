---
title: 学生端实现
platform: iOS
updatedAt: 2020-11-02 19:50:09
---
本文展示如何在 Web 平台实现学生端相关功能。

## 集成指引

根据下表链接，下载对应的 SDK，参考集成文档的步骤将 SDK 集成到你的项目中。

 
| 产品 | SDK 下载 | 集成文档 |
| ---------------- | ---------------- | ---------------- | 
| [Agora RTC (Real-time Communication) SDK](https://docs.agora.io/cn/Video/product_video?platform=Web)      | [ Web 视频通话 SDK](https://docs.agora.io/cn/Video/downloads?platform=Web)      | [实现视频通话](https://docs.agora.io/cn/Video/start_call_web?platform=Web) |
| [Agora RTM (Real-time Messaging) SDK](https://docs.agora.io/cn/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [Web 云信令（原实时消息） SDK](https://docs.agora.io/cn/Real-time-Messaging/downloads?platform=Web) | [收发点对点消息和频道消息](https://docs.agora.io/cn/Real-time-Messaging/messaging_web?platform=Web) |
| Agora 房间管理服务 | N/A | [房间管理服务 API 文档](https://agoradoc.github.io/cn/edu-cloud-service/restfulapi) |
| [白板](https://developer.herewhite.com/javascript-zh/home) | [SDK 集成](https://developer.herewhite.com/javascript-zh/home/install) | N/A |


## 核心 API 时序图

参考下图了解学生端实现的基础流程和 API 调用。

<div class="alert info">教育 SDK 是基于 Agora RTC SDK、Agora RTM SDK 和 Agora 房间管理服务封装的场景化 SDK，API 设计与实际业务场景更贴近、更易用。教育 SDK 当前处于内部测试体验阶段，如有疑问，请至 GitHub 提交 <a href="https://github.com/AgoraIO-Usecase/eEducation">issue</a>。</div>

![](https://web-cdn.agora.io/docs-files/1604055199106)

## 附加功能

除基础的实时音视频和实时消息功能外，你还可以参考下文，在项目中实现更多教育场景的附加功能。


<details>
<summary>网络质量监测</summary>
你可以通过使用 RTC SDK 的 <code>on("network-quality")</code> 回调，实时监控通话中每个用户的网络上下行 last mile 网络质量。
更多质量透明相关方法，可参考如下文档：
<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/lastmile_quality_web?platform=Web">通话前网络质量探测</a></li>
<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/in-call_quality_web?platform=Web">通话中质量监测</a></li>
</details>
<details>
<summary>关闭本地音视频</summary>
你可以通过调用 RTC SDK 的如下方法，实现相关功能：
	<li>调用 <code>muteAudio</code> 或 <code>unmuteAudio</code>关闭或重新开启本地音频。</li>
	<li>调用 <code>muteVideo</code> 或 <code>unmuteVideo</code> 关闭或重新开启本地视频。</li>
</details>

<details>
<summary>白板</summary>
参考下列常用功能文档，在你的项目中实现白板相关功能。
	<li><a href="https://developer.netless.link/javascript-zh/home/document-converter">文档转换</a></li>
	<li><a href="https://developer.netless.link/javascript-zh/home/business-state-management">房间与回放的业务状态管理</a></li>
	<li><a href="https://developer.netless.link/javascript-zh/home/tools">教具</a></li>
	<li><a href="https://developer.netless.link/javascript-zh/home/view">视角</a></li>
	<li><a href="https://developer.netless.link/javascript-zh/home/room-methods">白板操作</a></li>
	<li><a href="https://developer.netless.link/document-zh/home/scene-manangement">页面（场景）管理</a></li>
</details>
