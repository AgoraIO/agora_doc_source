---
title: 直播场景下，如何监听远端观众角色用户加入/离开频道的事件？
platform: ["All Platforms"]
updatedAt: 2021-02-05 06:06:21
Products: ["Voice","Video","Interactive Broadcast","Audio Broadcast","Real-time-Messaging"]
---
目前，Agora 没有在 RTC SDK 中提供监听远端观众加入或离开频道事件的回调。你可以使用以下两种方法进行实现：

- 通过消息通知服务提供的事件通知。
- 利用 RTM SDK 的状态维护功能通知。

## 使用消息通知服务 （Beta）
<div class="alert note">Agora 消息通知服务目前处于 Beta 阶段，不建议你的核心业务依赖该服务。</div>

消息通知服务可以监听 Agora 各业务下的事件，并以 HTTP/HTTPS 请求的形式向你的服务器发送通知。

### 实现方法

1. 使用前，你需要参考[用户配置](https://docs-preview.agoralab.co/cn/Agora%20Platform/ncs#%E7%94%A8%E6%88%B7%E9%85%8D%E7%BD%AE)开通消息通知服务。
2. 完成配置后，消息通知回调会以 HTTP/HTTPS POST 请求的形式发送给你的服务器。你可以使用实时通信业务中的以下事件监听直播频道中观众进出频道的事件：

| event_type | event_name | 事件含义 | payload 包含字段 |
| ---------------- | ---------------- | ---------------- | ----------------- |
| 105      | `audience join channel`      | 直播场景下，观众加入频道      |<ul><li>channelName</li><li>uid</li><li>platform</li><li>ts</li></ul> |
| 106      | `audience leave channel`   | 直播场景下，观众离开频道      |<ul><li>channelName</li><li>uid</li><li>platform</li><li>reason</li><li>ts</li></ul> |

### 参考链接

详细使用步骤及描述，请参考以下文档：

- [消息通知服务](https://docs-preview.agoralab.co/cn/Agora%20Platform/ncs)
- [实时通信事件类型](https://docs-preview.agoralab.co/cn/Agora%20Platform/rtc_eventtype?platform=All%20Platforms#%E5%AE%9E%E6%97%B6%E9%80%9A%E4%BF%A1)
- [payload 字段含义](https://docs-preview.agoralab.co/cn/Agora%20Platform/rtc_eventtype?platform=All%20Platforms#payload-%E5%AD%97%E6%AE%B5)

## 使用信令系统

Agora RTM SDK 是一个实现了信令功能的 SDK，可以为直播、社交、教育等应用场景，提供稳定、可靠的状态维护、收发消息等功能。

### 实现方法

你可以在项目中同步集成 Agora RTC SDK 和 RTM SDK，然后利用 RTM 的回调事件，监控 RTC 频道内观众用户的状态。实现步骤如下：

- 同一个用户使用相同的频道名，分别加入 RTC 和 RTM 频道；
- 在你的代码逻辑中，将加入两个频道的动作进行绑定；
- 当 RTM SDK 监听到用户加入频道时，说明该用户同时已加入了 RTC 频道。离开频道同理。

### 参考链接

详细的集成步骤及 API 描述，请参考以下文档：

- [RTM 快速开始](https://docs.agora.io/cn/Real-time-Messaging/messaging_android?platform=Android)
- [RTM 加入与离开频道相关 API 参考](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/index.html#joinorleavechannel)
	
	