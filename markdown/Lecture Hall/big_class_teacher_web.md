---
title: 教师端实现
platform: Web
updatedAt: 2020-12-30 09:02:06
---
## 基础流程图

参考下图，在你的项目中实现教师端的登入登出、禁学生端音视频、禁聊天功能：

![](https://web-cdn.agora.io/docs-files/1579412905725)

## 集成指引

根据下表链接，下载对应的 SDK，参考《快速开始》文档的步骤将 SDK 集成到你的项目中。



## API 时序图

参考下图时序，将 RTC SDK 和 RTM SDK 集成到你的项目中。

![](https://web-cdn.agora.io/docs-files/1579418758188)

## API 参考

- RTM SDK

| API | 实现功能 | 
| ---------------- | ---------------- | 
| [createInstance](./API%20Reference/RTM_web/modules/agorartm.html#createinstance)      | 创建并返回一个 RtcClient 实例。      |
| [login](./API%20Reference/RTM_web/classes/rtmclient.html#login) | 登录 Agora RTM 系统。 |
| [createChannel](./API%20Reference/RTM_web/classes/rtmclient.html#createchannel) | 创建 Agora RTM 频道。一个 RtcClient 可以创建多个频道。 |
| [getChannelAttributes](./API%20Reference/RTM_web/classes/rtmclient.html#getchannelattributes) | 获取指定频道的频道信息。|
| [queryPeersOnlineStatus](./API%20Reference/RTM_web/classes/rtmclient.html#querypeersonlinestatus) | 查询指定用户的在线状态。|
| [MessageFromPeer](./API%20Reference/RTM_web/interfaces/rtmevents.rtmclientevents.html#messagefrompeer) | 收到来自对端的点对点消息。|
| [sendMessageToPeer](./API%20Reference/RTM_web/classes/rtmclient.html#sendmessagetopeer) | 向指定用户发送点对点消息。|
| [addOrUpdateChannelAttributes](./API%20Reference/RTM_web/classes/rtmclient.html#addorupdatechannelattributes) | 添加或更新指定频道的属性。你可以在该方法中设置是否将本次变更通知到频道内所有成员。|
| [sendMessage](./API%20Reference/RTM_web/classes/rtmchannel.html#sendmessage) | 发送频道消息。成功发送后，频道内所有用户都能收到。|
| [leave](./API%20Reference/RTM_web/classes/rtmchannel.html#leave) | 离开 RTM 频道。|

- RTC SDK

| API | 实现功能 |
| ---------------- | ---------------- |
| [createClient](./API%20Reference/web/globals.html#createclient)      | 创建客户端。      |
| [Client.init](./API%20Reference/web/interfaces/agorartc.client.html#init) | 初始化客户端对象。 |
| [Client.setClientRole](./API%20Reference/web/interfaces/agorartc.client.html#setclientrole) | 设置直播场景下的用户角色。互动直播大班课场景中，我们将老师的用户角色设为主播。|
| [createStream](./API%20Reference/web/globals.html#createstream) | 创建并返回音视频流对象。 |
| [Stream.init](./API%20Reference/web/interfaces/agorartc.stream.html#init) | 初始化音视频对象。 |
| [Client.join](./API%20Reference/web/interfaces/agorartc.client.html#join) | 加入 Agora RTC 频道。 |
| [Client.publish](./API%20Reference/web/interfaces/agorartc.client.html#publish) | 发布本地音视频流至 SD-RTN。 |
| [Client.on](./API%20Reference/web/interfaces/agorartc.client.html#on)("stream-added") | 远端音视频已添加。 |
| [Client.subscribe](./API%20Reference/web/interfaces/agorartc.client.html#subscribe) | 订阅远端音视频流。|
| [Stream.play](./API%20Reference/web/interfaces/agorartc.stream.html#play) | 播放音、视频流。|
| [Client.leave](./API%20Reference/web/interfaces/agorartc.client.html#leave) | 离开 RTC 频道。 |

## 附加功能

你还可以参考下列文档或示例代码，在你的项目中实现更多教育场景的附加功能。


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
<summary>关闭远端音视频</summary>
你需要联合调用 RTM SDK 和 RTC SDK 的方法，实现该功能：
<ol>
	<li>教师端调用 <code>sendMessageToPeer</code> 方法，给学生发送点对点消息，通知学生关闭音视频。</li>
	<li>学生端调用对应的 <code>mute</code> 方法关闭本地的音视频。</li>
</ol>
</details>
<details>
<summary>屏幕共享</summary>
根据你的浏览器，参考如下文档实现屏幕共享功能：
<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/screensharing_web?platform=Web#a-name--chromeachrome-%E5%B1%8F%E5%B9%95%E5%85%B1%E4%BA%AB">Chrome 屏幕共享</a></li>
<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/screensharing_web?platform=Web#a-nameffafirefox-%E5%B1%8F%E5%B9%95%E5%85%B1%E4%BA%AB">Firefox 屏幕共享</a></li>
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
