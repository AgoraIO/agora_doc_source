---
title: 学生端实现
platform: Web
updatedAt: 2020-05-11 16:53:59
---
本文展示如何在 Web 平台实现学生端相关功能。

## 基础流程图

参考下图，在你的项目中实现学生端的登录登出功能。

![](https://web-cdn.agora.io/docs-files/1589186800325)

## 集成指引

根据下表链接，下载对应的 SDK，参考《快速开始》文档的步骤将 SDK 集成到你的项目中。

 
| 产品 | SDK 下载 | 集成文档 |
| ---------------- | ---------------- | ---------------- | 
| [Agora RTC (Real-time Communication) SDK](https://docs.agora.io/cn/Video/product_video?platform=All%20Platforms)      | [ Web 视频通话 SDK](https://docs.agora.io/cn/Video/downloads)      | [实现视频通话](https://docs.agora.io/cn/Video/start_call_web?platform=Web) |
| [Agora RTM (Real-time Messaging) SDK](https://docs.agora.io/cn/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [Web 云信令（原实时消息） SDK](https://docs.agora.io/cn/Real-time-Messaging/downloads) | [收发点对点消息和频道消息](https://docs.agora.io/cn/Real-time-Messaging/messaging_web?platform=Web) |
| Agora 房间管理服务 | / | [Agora 房间管理服务快速开始](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-%E4%BA%91%E6%9C%8D%E5%8A%A1) |
| [白板](https://developer.netless.link/docs/javascript/overview/js-outline/) | [SDK 集成](https://developer.netless.link/docs/javascript/guide/js-sdk/) | [白板快速开始](https://developer.netless.link/javascript-zh/home/install) |


## 核心 API 时序图

参考下图时序，搭配使用 Agora RTC SDK、Agora RTM SDK 和 Agora Edu 云服务在你的项目中实现基础的实时音视频、实时消息和教室信息管理功能。

![](https://web-cdn.agora.io/docs-files/1589187119742)

## 核心 API 参考
- Agora Edu 云服务

| API | 实现功能 |
| ---------------- | ---------------- |
| [entry](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-%E4%BA%91%E6%9C%8D%E5%8A%A1#%E8%BF%9B%E5%85%A5%E6%95%99%E5%AE%A4)      | 进入教室。      |
| [get room info](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-%E4%BA%91%E6%9C%8D%E5%8A%A1#%E5%88%9D%E5%A7%8B%E5%8C%96%E6%95%99%E5%AE%A4)      | 获取教室信息。      |
| [change room info](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-%E4%BA%91%E6%9C%8D%E5%8A%A1#change-room-info)      | 修改教室信息。      |
| [change user info](https://github.com/AgoraIO-Usecase/eEducation/wiki/Agora-Edu-%E4%BA%91%E6%9C%8D%E5%8A%A1#change-user-info)  | 修改用户信息。      |

- Agora RTM SDK

| API | 实现功能 |
| ---------------- | ---------------- |
| [createInstance](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_web/modules/agorartm.html#createinstance)     | 创建并返回一个 RtmClient 实例。      |
| [login](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#login) | 登录 Agora RTM 系统。登录后你可以使用 RTM 的核心业务逻辑。
| [createChannel](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#createchannel) | 创建 Agora RTM 频道。一个 RtmClient 可以创建多个频道。 |
| [join](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#join) | 加入 Agora RTM 频道。|
| [sendMessage](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#sendmessage)  | 发送频道消息。成功发送后，频道内所有用户都能收到。 |
| [leave](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#leave) | 离开 RTM 频道。 |

- Agora RTC SDK


| API | 实现功能 |
| ---------------- | ---------------- |
| [createClient](./API%20Reference/web/v3.3.1/globals.html#createclient)        | 创建客户端。      |
[Client.init](./API%20Reference/web/interfaces/agorartc.client.html#init) | 初始化客户端对象。 |
[Client.join](./API%20Reference/web/interfaces/agorartc.client.html#join) | 加入 Agora RTC 频道。 |
| [Client.on](./API%20Reference/web/interfaces/agorartc.client.html#on)("stream-added") | 远端音视频已添加。 |
| [createStream](./API%20Reference/web/v3.3.1/globals.html#createstream) | 创建并返回音视频流对象。 |
| [Stream.init](./API%20Reference/web/interfaces/agorartc.stream.html#init) | 初始化音视频对象。 |
| [Client.publish](./API%20Reference/web/interfaces/agorartc.client.html#publish) | 发布本地音视频流至 SD-RTN。 |
| [Client.subscribe](./API%20Reference/web/interfaces/agorartc.client.html#subscribe) | 订阅远端音视频流。|
| [Stream.play](./API%20Reference/web/interfaces/agorartc.stream.html#play) | 播放音、视频流。|
| [Client.leave](./API%20Reference/web/interfaces/agorartc.client.html#leave) | 离开 RTC 频道。 |

<div class="alert note">Agora RTC SDK 默认的频道场景为通信场景。</div>


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


## 开源示例项目

我们也在 GitHub 上提供了互动直播大课的[开源示例项目](https://github.com/AgoraIO-Usecase/eEducation)，你也可以前往下载，或查看其中的源代码。