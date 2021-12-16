---
title: 发版说明
platform: Web
updatedAt: 2021-03-02 12:16:20
---
## 简介

Agora RTM SDK 提供了稳定可靠、低延时、高并发的全球消息云服务，帮助你快速构建实时通信场景,  可实现消息通道、呼叫、聊天、状态同步等功能。点击 [实时消息产品概述](/cn/Real-time-Messaging/RTM_product?platform=All%20Platforms) 了解更多详情。


## 1.0.0 版

该版本于 2019 年 8 月 5 日发布。

### 新增功能

#### 新老互通

支持与 Agora Signaling SDK 互通。

本版本在 `LocalInvitation` 类中实现了 `channelId` 属性。

> - 如需与 Agora Signaling SDK 互通，则必须调用 `channelId` 属性设置频道 ID。不过即使被叫成功接受呼叫邀请，Agora RTM SDK 也不会将主叫或被叫加入指定频道。
> - 如果你的应用不涉及 Agora Signaling SDK，我们推荐使用 `LocalInvitation.content` 或者 `RemoteInvitation.response` 属性设置自定义内容。

#### 设置日志输出等级

支持通过设置 `logFilter` 参数将日志内容按照 OFF、ERROR、WARNING 和 INFO 不同等级输出 。

> 该设置在调用 `createInstance` 方法成功创建实例后即可进行。

### API 变更

### 新增

- [logFilter](/cn/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmparameters.html#logfilter)

## 0.9.3 版

该版本于 2019 年 7 月 24 日发布。

### 新增功能

#### 发送（离线）点对点消息

本版本支持发送离线消息。在开通离线消息后，用户不必等到接收端上线才能发送点对点消息。如果对端离线，消息服务器会为每个接收端存储 200 条离线消息长达七天。消息以队列形式存储。当离线消息超限时，最新存储的消息会导致最老的消息丢失。

> 该方法的调用频率限制为每秒 60 条（点对点消息和频道消息一并计算在内）。

#### 设置本地用户属性、查询指定用户属性

本版本支持设置和查询用户属性。每个用户属性为 key 和 value 的键值对。每个属性的 key 为 32 字节可见字符，每个属性的 value 的字符串长度不得超过 8 KB。单个用户的全部属性长度不得超过 16 KB。以下为本版本支持内容：

   - 全量设置本地用户属性
   - 增加或更新本地用户属性
   - 删除本地用户指定属性
   - 清空本地用户属性
   - 全量获取指定用户属性
   - 获取指定用户指定属性。

> - 设置的用户属性会在用户登出 Agora RTM 系统后自动失效。

#### 查询用户在线状态

本版本引入了新的概念：在线和离线。一般情况下：

- 在线：用户已登录到 Agora RTM 系统。
- 离线：用户已登出 Agora RTM 系统或因其他原因，比如权限或网络原因，与 Agora RTM 系统断开连接。

本版本增加了查询用户在线状态功能。你可以在登录 Agora RTM 系统后查询最多 256 个指定用户的在线状态。

#### 更新 Token

本版本提供了更新 Token 的功能

### API 变更

#### 新增：

- [sendMessageToPeer](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#sendmessagetopeer)
- [setLocalUserAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#setlocaluserattributes)
- [addOrUpdateLocalUserAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#addorupdatelocaluserattributes)
- [deleteLocalUserAttributesByKeys](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#deletelocaluserattributesbykeys)
- [clearLocalUserAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#clearlocaluserattributes)
- [getUserAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#getuserattributes)
- [getUserAttributesByKeys](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#getuserattributesbykeys)
- [queryPeersOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#querypeersonlinestatus)
- [renewToken](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#renewtoken)

## 0.9.1 版

该版本于 2019 年 5 月 20 日发布。

### 新增功能

本版本增加了呼叫邀请功能。结合音视频一对一或一对多通话场景，你可以创建、发送、取消、接受或拒绝一个呼叫邀请。

### 性能改进

-   本地用户发送的频道消息/点对点消息/进频道通知均不出现在当前用户的 API 回调中。
-   用户名 `uid` 允许以空格开头。

### API 变更

### 新增

- [createLocalInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#createlocalinvitation)：创建一个呼叫邀请
- [LocalInvitation.cancel](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/localinvitation.html#send): （主叫）取消呼叫邀请
- [LocalInvitation.send](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/localinvitation.html#send)： （主叫）发送呼叫邀请
- [LocalInvitationState](/cn/Real-time-Messaging/API%20Reference/RTM_web/enums/localinvitationstate.html)：返回给主叫的呼叫邀请状态码
- [LocalInvitationFailureReason](/cn/Real-time-Messaging/API%20Reference/RTM_web/enums/localinvitationfailurereason.html)：返回给主叫的呼叫邀请失败原因。
- [RemoteInvitationReceived](/cn/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmclientevents.html#remoteinvitationreceived): 收到来自对端的呼叫邀请回调
- [RemoteInvitation.accept](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/remoteinvitation.html#accept):  （被叫）接受呼叫邀请
- [RemoteInvitation.refuse](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/remoteinvitation.html#refuse)：（被叫）拒绝呼叫邀请
- [RemoteInvitationState](/cn/Real-time-Messaging/API%20Reference/RTM_web/enums/remoteinvitationstate.html)：返回给被叫的呼叫邀请状态码
- [RemoteInvitationFailureReason](/cn/Real-time-Messaging/API%20Reference/RTM_web/enums/remoteinvitationfailurereason.html)：返回给被叫的呼叫邀请失败原因。


#### 重命名

-   `RtmClient` 的事件 `ConnectionStateChange` 更名为 [ConnectionStateChanged](/cn/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmclientevents.html#connectionstatechanged) 。

#### 删除

-   `RtmChannel`  `getId` 方法，改用 [channelId](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#channelid) 代替。


## 0.9.0 版

该版本于 2019 年 2 月 4 日发布。

首次发布。

### 主要功能

- 发送或接收点对点消息。
- 加入或离开频道。
- 发送或接收频道消息。
