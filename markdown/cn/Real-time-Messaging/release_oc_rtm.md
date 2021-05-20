---
title: 发版说明
platform: All Platforms
updatedAt: 2021-03-02 03:11:35
---
## 简介

<div class="alert info">实时消息于 2021 年 2 月正式更名为云信令，服务不变，初心不改。</div>

Agora 云信令（原实时消息）SDK 提供了稳定可靠、低延时、高并发的全球消息云服务，帮助你快速构建实时通信场景,  可实现消息通道、呼叫、聊天、状态同步等功能。点击[云信令（原实时消息）产品概述](/cn/Real-time-Messaging/product_rtm?platform=All%20Platforms)了解详情。


## 1.3.0 版

该版本于 2020 年 4 月 24 日发布。

### 兼容性改动

废弃频道消息发送方法 `sendMessage:completion:`，改由重载方法 `sendMessage:sendMessageOptions:completion:` 替代。

### 新增功能

#### 收发文件消息

v1.3.0 支持上传下载大小不超过 30 MB 的任意文件格式的非空文件，支持随时取消正在进行中的上传或下载任务。每份上传到 Agora 服务器的文件都对应一个 media ID，在服务端默认保存 7 天。用户可以通过 media ID 在 7 天有效期内从 Agora 服务器下载对应的文件。

<div class="alert note">用户只能通过 SDK 提供的下载方法下载文件。</div>

v1.3.0 引入了 `AgoraRtmFileMessage` 消息接口类用于保存和传递系统生成的 `media ID: AgoraRtmFileMessage` 继承自 `AgoraRtmMessage` 接口类，所以用户可以通过已有的点对点消息或频道消息发送方法传递 `AgoraRtmFileMessage` 实例。用户可以通过 `AgoraRtmFileMessage` 对象:

- 设置相应的上传文件的显示文件名和显示缩略图。
- 获取相应的上传文件的大小。

<div class="alert note">消息内容、显示文件名和显示缩略图的总大小不得超过 32 KB。</div>

#### 收发图片消息

v1.3.0 支持上传下载大小不超过 30 MB 的任意文件格式的非空图片，支持随时取消正在进行中的上传或下载任务。每份上传到 Agora 服务器的图片都对应一个 media ID，在服务端默认保存 7 天。用户可以通过 media ID 在 7 天有效期内从 Agora 服务器下载对应的图片。

<div class="alert note">用户只能通过 SDK 提供的下载方法下载图片。</div>

v1.3.0 引入了 `AgoraRtmImageMessage` 消息接口类用于保存和传递系统生成的 `media ID: AgoraRtmImageMessage` 继承自 `AgoraRtmMessage` 接口类，所以用户可以通过已有的点对点消息或频道消息发送方法传递 `AgoraRtmImageMessage` 实例。用户可以通过 `AgoraRtmImageMessage` 对象:

- 设置相应的上传图片的显示文件名和显示缩略图。
- 获取相应的上传图片的大小。
- 获取 SDK 为 JPEG、JPG、BMP，以及 PNG 这四种格式的图片计算的宽高数据。
- 自行设置图片的宽和高。用户自行设置的宽高数据会覆盖 SDK 计算的宽高数据。

<div class="alert note">消息内容、显示文件名和显示缩略图的总大小不得超过 32 KB。</div>

#### 通知上传或下载任务的进度

对于正在进行中的上传或下载任务，SDK 会通过主动回调每秒返回一次上传或下载的进度。当上传或下载任务陷入停顿时 SDK 暂停返回相应回调直至任务继续进行。

### 问题修复

- 由于误判用户网络导致无法登录问题。
- 其它可能导致系统崩溃的问题。

### API 变更

#### 新增方法

- [createFileMessageByUploading:withRequest:completion:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/createFileMessageByUploading:withRequest:completion:): 上传一份文件到 Agora 服务器以获取一个相应的 [AgoraRtmFileMessage](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmFileMessage.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af) 文件消息实例。
- [createImageMessageByUploading:withRequest:completion:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/createImageMessageByUploading:withRequest:completion:): 上传一份图片到 Agora 服务器以获取一个相应的 [AgoraRtmImageMessage](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmImageMessage.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af) 图片消息实例。
- [cancelMediaUpload:completion:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/cancelMediaUpload:completion:): 通过 request ID 取消一个正在进行中的文件或图片上传任务。
- [cancelMediaDownload:completion:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/cancelMediaDownload:completion:): 通过 request ID 取消一个正在进行中的文件或图片下载任务。
- [createFileMessageByMediaId:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/createFileMessageByMediaId:): 通过已有的 media ID 创建一个 [AgoraRtmFileMessage](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmFileMessage.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af) 实例。
- [createImageMessageByMediaId:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/createImageMessageByMediaId:): 通过已有的 media ID 创建一个 [AgoraRtmImageMessage](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmImageMessage.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af) 实例。
- [downloadMediaToMemory:withRequest:completion:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/downloadMediaToMemory:withRequest:completion:): 通过 media ID 从 Agora 服务器下载文件或图片至本地内存。
- [downloadMedia:toFile:withRequest:completion:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/downloadMedia:toFile:withRequest:completion:): 通过 media ID 从 Agora 服务器下载文件或图片至本地指定地址。


#### 新增回调

- [rtmKit:media:uploadingProgress:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Protocols/AgoraRtmDelegate.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/rtmKit:media:uploadingProgress:): 主动回调：上传任务的上传进度回调。
- [rtmKit:media:downloadingProgress:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Protocols/AgoraRtmDelegate.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/rtmKit:media:downloadingProgress:): 主动回调：下载任务的下载进度回调。
- [AgoraRtmUploadFileMediaBlock](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Blocks/AgoraRtmUploadFileMediaBlock.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af): 返回 [createFileMessageByUploading:withRequest:completion:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/createFileMessageByUploading:withRequest:completion:) 方法的调用结果。
- [AgoraRtmUploadImageMediaBlock](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Blocks/AgoraRtmUploadImageMediaBlock.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af): 返回 [createImageMessageByUploading:withRequest:completion:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/createImageMessageByUploading:withRequest:completion:) 方法的调用结果。
- [AgoraRtmCancelMediaBlock](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Blocks/AgoraRtmCancelMediaBlock.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af): 返回 [cancelMediaUpload:completion:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/cancelMediaUpload:completion:) 或 [cancelMediaDownload:completion:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/cancelMediaDownload:completion:) 方法的调用结果。
- [AgoraRtmDownloadMediaToMemoryBlock](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Blocks/AgoraRtmDownloadMediaToMemoryBlock.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af): 返回 [downloadMediaToMemory:withRequest:completion:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/downloadMediaToMemory:withRequest:completion:) 方法的调用结果。
- [AgoraRtmDownloadMediaToFileBlock](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Blocks/AgoraRtmDownloadMediaToFileBlock.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af): 返回 [downloadMedia:toFile:withRequest:completion:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmKit.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/downloadMedia:toFile:withRequest:completion:) 方法的调用结果。
- [rtmKit:fileMessageReceived:fromPeer:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Protocols/AgoraRtmDelegate.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/rtmKit:fileMessageReceived:fromPeer:): 收到点对点文件消息回调。
- [rtmKit:imageMessageReceived:fromPeer:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Protocols/AgoraRtmDelegate.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/rtmKit:imageMessageReceived:fromPeer:): 收到点对点图片消息回调。
- [channel:fileMessageReceived:fromMember:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Protocols/AgoraRtmChannelDelegate.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/channel:fileMessageReceived:fromMember:): 收到频道文件消息回调。
- [channel:imageMessageReceived:fromMember:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Protocols/AgoraRtmChannelDelegate.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/channel:imageMessageReceived:fromMember:): 收到频道图片消息回调。


#### 废弃方法

[sendMessage:completion:]((https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmChannel.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/sendMessage:completion:)) 被重载方法 [sendMessage:sendMessageOptions:completion:](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_oc/v1.3.0/Classes/AgoraRtmChannel.html?transId=240a4a80-7faf-11ea-a366-4fbfd071e0af#//api/name/sendMessage:sendMessageOptions:completion:) 替代。

## 1.2.2 版

该版本于 2019 年 12 月 13 日发布。



**问题修复**

修复了一个偶现的频道属性操作后无法收到回调的问题。

## 1.2.1 版

该版本于 2019 年 11 月 29 日 发布。

**新增功能**

**支持与老信令 SDK 的 endCall 方法兼容** 

你可以调用 `sendMessageToPeer` 方法在发送<i>文本</i>消息时将消息设为 AgoraRTMLegacyEndcallCompatibleMessagePrefix\_\<channelId\>\_\<your additional information\> 格式即可。请以 endCall 对应频道的 ID 替换 \<channelId\>， \<your additional information\> 为附加文本信息。请注意：附加文本信息中不可使用下划线 "_" ，附加文本信息可以设为空字符串 "" 。

**问题修复**


- 修复了一个用户使用 VPN 登录 RTM，关闭 VPN 后 RTM 重连失败的问题。
- 修复了一个频道中用户断线重连，频道中其它用户有概率收到两次 `MemberJoined` 回调的问题。

## 1.2.0 版

该版本于 2019 年 11 月6 日发布。新增如下功能：

- [订阅或退订指定单个或多个用户的在线状态](#subscribe)
- [获取某特定内容被订阅的用户列表](#list)
- [创建自定义二进制消息](#raw)

**兼容性改动**

废弃 `AgoraRtmPeerOnlineStatus` 类的 `isOnline` 属性。请改用 `state` 属性。

**新增功能**

#### 1. <a name="subscribe"></a>订阅或退订指定单个或多个用户的在线状态。

<div class="alert warning"> 该功能必须在登录 Agora RTM 系统成功（收到 AgoraRtmLoginErrorOk ）后才能调用。</div>

本版本支持订阅或退订最多 512 个用户的在线状态，SDK 会通过 `AgoraRtmSubscriptionRequestBlock` 返回订阅或退订结果。首次订阅成功时，SDK 会通过 `PeersOnlineStatusChanged` 回调返回所有被订阅用户的在线状态；之后每当有被订阅用户的在线状态出现变化，SDK 都会通过 `onPeersOnlineStatusChanged` 回调通知订阅方。

<div class="alert warning"> <sup>1</sup>用户登出 Agora RTM 系统后，所有之前的订阅内容都会被清空；重新登录后，如需保留之前订阅内容则需重新订阅。</div>

<div class="alert warning"> <sup>2</sup>重复订阅同一用户不会报错。</div>


#### 2. <a name="list"></a>获取某特定内容被订阅的用户列表

<div class="alert warning"> 该功能必须在登录 Agora RTM 系统成功（收到 AgoraRtmLoginErrorOk）后才能调用。</div>

本版本支持根据被订阅类型获取被订阅用户列表。现实情况中，你可能多次订阅或退订，可能重复订阅了相同用户，可能出现订阅或退订不成功的情况，也可能根据不同的订阅类型订阅了不同的用户。这时，你可以通过本功能根据订阅类型获取当前被订阅用户列表。

被订阅类型由枚举类型 `AgoraRtmPeerSubscriptionOptions` 定义。本版本仅支持用户在线状态订阅一种类型，后继会不断扩展。

#### 3. <a name="raw"></a>创建自定义二进制消息

本版本支持创建自定义二进制消息，支持以点对点消息或频道消息形式发送多种文件格式。

本版本支持：

- 创建不带文本描述信息的自定义二进制消息
- 创建包含文本描述信息的自定义二进制消息


<div class="alert warning"> 我们不对二进制消息的文本描述的大小单独进行限制，但是我们要求自定义二进制消息的总大小不超过 32 KB。</div>


## 1.1.0 版

该版本于 2019 年 9 月 18 日发布。新增如下功能：

- [查询频道成员人数](#getcount)
- [频道成员人数自动更新](#oncount)
- [频道属性增删改查](#channelattributes)



**兼容性改动**

1. 废弃点对点消息发送方法 [sendMessage:toPeer:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/sendMessage:toPeer:completion:)，改由重载方法 [sendMessage:toPeer:sendMessageOptions:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/sendMessage:toPeer:sendMessageOptions:completion:) 替代。
2. [AgoraRtmMessage](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmMessage.html) 对象的 [serverReceivedTs](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmMessage.html#//api/name/serverReceivedTs) 方法由仅支持点对点消息改为同时支持点对点消息和频道消息。
3. 点对点消息的超时时间由 5 秒延长为 10 秒。详见： [AgoraRtmSendPeerMessageErrorTimeout](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmSendPeerMessageErrorCode.html)
4. 针对 [joinWithCompletion](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/joinWithCompletion:) 方法调用增加了[加入相同频道的频率限制：每 5 秒 2 次](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmJoinChannelErrorCode.html)。

**新增功能**

<a name="getcount"></a>
#### 1. 查询频道成员人数

支持在不加入频道的情况下通过主动调用 [getChannelMemberCount](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getChannelMemberCount:completion:) 接口查询单个或多个频道的频道人数。一次最多可查询 32 个频道的成员人数。

<a name="oncount"></a>
#### 2. 频道成员人数自动更新

如果你已经加入某频道，你无需调用 `getChannelMemberCount` 接口查询当前频道人数。我们也不建议你通过监听 `onMemberJoined` 和 `onMemberLeft` 统计频道成员人数。从本版本开始，SDK 会在频道成员人数发生变化时通过 [memberCount](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmChannelDelegate.html#//api/name/channel:memberCount:) 回调接口通知频道成员并返回当前频道成员人数：

- 频道成员人数小于等于 512 时，最高触发频率为每秒 1 次。
- 频道成员人数超过 512 时，最高触发频率为每 3 秒 1 次。

> 请将该回调与 [AgoraRtmGetMembersBlock](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Blocks/AgoraRtmGetMembersBlock.html) 回调进行区分：
> - 前者为主动回调。SDK 向频道成员返回当前频道成员人数。
> - 后者由 [getMembersWithCompletion](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/getMembersWithCompletion:) 方法触发，返回频道成员列表，且当频道成员人数超过 512 时仅返回随机的 512 个成员列表。

<a name="channelattributes"></a>
#### 3. 频道属性增删改查

支持设置或查询某个指定频道的属性。你可以用频道属性实现群公告、上下麦同步等功能。

每个频道属性为 key 和 value 的键值对。详见：[AgoraRtmChannelAttribute](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannelAttribute.html)。其中：
- 每个属性的 key 为 32 字节可见字符，每个属性的 value 的字符串长度不得超过 8 KB。
- 某个频道的全部属性长度不得超过 32 KB。
- 某个频道属性的全部属性个数不得超过 32 个。

支持功能包括：

- 全量设置某指定频道的属性。
- 添加或更新某指定频道的属性。
- 删除某指定频道的指定属性。
- 清空某指定频道的属性。
- 查询某指定频道的全部属性。
- 查询某指定频道指定属性名的属性。

在进行频道属性的更新或删除操作时，你可以通过设置标志位 [enableNotificationToChannelMembers](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannelAttributeOptions.html#//api/name/enableNotificationToChannelMembers) 决定是否通知对应频道所有成员本次频道属性变更。


**性能改进**

#### 点对点消息重发

本版本优化了点对点消息在弱网情况下的重发机制，并延长点对点消息超时时间为 10 秒，提高了在弱网情况下点对点消息的发送成功率。

#### 频道消息缓存

Agora RTM 系统会对短期掉线后重连成功的频道成员补发最长 30 秒最多 32 条的频道消息，提高了弱网情况下频道消息的到达率。


**API 变更**

#### 新增方法

- [setChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/setChannel:Attributes:Options:completion:)：全量设置某指定频道的属性。
- [addOrUpdaeChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/addOrUpdateChannel:Attributes:Options:completion:)：添加或更新某指定频道的属性。
- [deleteChannelAttributesByKeys](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/deleteChannel:AttributesByKeys:Options:completion:)：删除某指定频道的指定属性。
- [clearChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/clearChannel:Options:AttributesWithCompletion:)：清空某指定频道的属性。
- [getChannelAllAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getChannelAllAttributes:completion:)：查询某指定频道的全部属性。
- [getChannelAttributesByKeys](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getChannelAllAttributes:completion:)：查询某指定频道指定属性名的属性。
- [getChannelMemberCount](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getChannelAttributes:ByKeys:completion:)：查询单个或多个频道的成员人数。

#### 新增回调

- [attributesUpdate](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmChannelDelegate.html#//api/name/channel:attributeUpdate:)：频道属性更新回调。返回所在频道的所有属性。
- [memberCount](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmChannelDelegate.html#//api/name/channel:memberCount:)：频道成员人数更新回调。返回最新频道成员人数。

#### 新增错误码 

- [AgoraRtmChannelMemberCountErrorCode](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmChannelMemberCountErrorCode.html)：获取指定频道成员人数的相关错误码。
- [AgoraRtmJoinSameChannelErrorTooOften](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmJoinChannelErrorCode.html)：加入相同频道的频率超过每 5 秒 2 次的上限。

#### 废弃方法

- [sendMessage:toPeer:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/sendMessage:toPeer:completion:)：被重载方法 [sendMessage:toPeer:sendMessageOptions:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/sendMessage:toPeer:sendMessageOptions:completion:) 替代。

#### 废弃错误码

- [AgoraRtmAttributeOperationErrorNotReady](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmProcessAttributeErrorCode.html)：被错误码 [AgoraRtmAttributeOperationErrorNotLoggedIn](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmProcessAttributeErrorCode.html) 替代。






## 1.0.1 版

该版本于 2019 年 8 月 1 日发布。

**问题修复**

- 断网后 SDK 未返回 `connectionStateChanged` 回调。
- iOS 平台偶现的崩溃。

## 1.0.0 版

该版本于 2019 年 7 月 24 日发布。

**新增功能**

#### 新老互通

支持与 Agora Signaling SDK 互通。

本版本在 `AgoraRtmLocalInvitation` 类中实现了 `channelId` 属性。

> - 如需与 Agora Signaling SDK 互通，则必须设置 `channelId` 。不过即使被叫成功接受呼叫邀请，Agora RTM SDK 也不会将主叫或被叫加入指定频道。
> - 如果你的应用不涉及 Agora Signaling SDK，我们推荐使用 `AgoraRtmLocalInvitation` 类中的 `content` 属性或者`AgoraRtmRemoteInvitation` 类中的 `response` 属性设置自定义内容。

#### 设置日志文件地址

支持通过调用 `setLogFile` 方法变更本地日志的默认地址。该方法无需在 `loginByToken` 成功之后调用，我们建议在创建并初始化 `AgoraRtmkit` 实例后即调用该方法，否则会造成日志文件显示不完整。

#### 设置日志输出等级

支持通过调用 `setLogFilter` 方法将日志内容按照 OFF、CRITICAL、ERROR、WARNING 和 INFO 不同等级输出。详见 [AgoraRtmLogFilter](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmLogFilter.html) 。

> 该方法无需在 `loginByToken` 成功之后调用。

#### 设置日志文件大小

支持通过 `setLogFileSize` 方法设置日志文件大小。日志的默认大小为 512 KB。低于该默认大小的设置无效。

> 该方法无需在 `loginByToken` 成功之后调用。

#### 查询 SDK 版本信息

支持通过调用静态方法 `getSDKVersion` 查询 Agora RTM SDK 的版本信息。

**功能改进**

针对以下不同错误情况细化了错误代码

- Agora RTM 服务未初始化
- 调用频率超过上限
- 未调用 `loginByToken` 方法或 `loginByToken` 方法未调用成功

**问题修复**

- 修复 iOS 平台偶现的崩溃。
- 修复了一个可以用静态 App ID 和一个通过动态 App ID 生成的 Token 登录Agora RTM 系统的问题。


### API 变更

- [setLogFile](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/setLogFile:)：设定日志文件的默认地址。
- [setLogFilter](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/setLogFilters:)：设置日志输出等级。
- [setLogFileSize](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/setLogFileSize:)：设置日志文件大小。
- [getSDKVersion](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getSDKVersion)：获取 Agora RTM SDK 的版本信息。



## 0.9.3 版

该版本于 2019 年 6 月 7 日发布。

**新增功能**

#### 发送（离线）点对点消息

本版本支持发送离线消息。在开通离线消息后，用户不必等到接收端上线才能发送点对点消息。如果对端离线，消息服务器会为每个接收端存储 200 条离线消息长达七天。消息以队列形式存储。当离线消息超限时，最新存储的消息会导致最老的消息丢失。当发送端设置了离线消息，而此时消息接收端不在线，发送端会收到错误码：[AgoraRtmSendPeerMessageErrorCachedByServer](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmProcessAttributeErrorCode.html)

> 该方法的调用频率限制为每秒 60 条（点对点消息和频道消息一并计算在内）。

#### 设置本地用户属性、查询指定用户属性

本版本支持设置和查询用户属性。每个用户属性为 key 和 value 的键值对。每个属性的 key 为 32 字节可见字符，每个属性的 value 的字符串长度不得超过 8 KB。单个用户的全部属性长度不得超过 16 KB。以下为本版本支持内容：

   - 全量设置本地用户属性
   - 增加或更新本地用户属性
   - 删除本地用户指定属性
   - 清空本地用户属性
   - 全量获取指定用户属性
   - 获取指定用户指定属性。


> - 用户属性的相关操作必须在登录 Agora RTM 系统成功后才能进行，否则 SDK 会返回错误码：`AgoraRtmAttributeOperationErrorNotReady`
> - 设置的用户属性会在用户登出 Agora RTM 系统后自动失效。
> - 单次用户属性设置操作不得超过 16 KB，否则 SDK 会返回错误码：`AgoraRtmAttributeOperationErrorSizeOverflow` 。
> - 用户属性设置相关操作的调用频率限制为每 5 秒 10 条，超限则 SDK 会返回错误码：`AgoraRtmAttributeOperationErrorTooOften`。
> - 获取用户属性相关操作的调用频率为每 5 秒 40 条，超限则 SDK 会返回错误码：`AgoraRtmAttributeOperationErrorTooOften` 。

**API 变更**

#### 新增：

- [sendMessageToPeer()](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/sendMessage:toPeer:sendMessageOptions:completion:):  发送（离线）点对点消息给指定用户。
- [serverReceivedTs](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmMessage.html#//api/name/serverReceivedTs)： 消息接收者查询服务器的接收消息时间。
- [isOfflineMessage](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmMessage.html#//api/name/isOfflineMessage)：消息接收者查询消息是否为离线消息。
- [AgoraRtmSendPeerMessageErrorCachedByServer](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmProcessAttributeErrorCode.html)：对端用户不在线，离线消息会被消息服务器存储。
- [setLocalUserAttributes:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/setLocalUserAttributes:completion:)：全量设置本地用户属性
- [addOrUpdateLocalUserAttributes:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/addOrUpdateLocalUserAttributes:completion:)：增加本地用户属性或更新本地用户属性
- [deleteLocalUserAttributesByKeys:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/deleteLocalUserAttributesByKeys:completion:)：删除本地用户指定属性
- [clearLocalUserAttributesWithCompletion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/clearLocalUserAttributesWithCompletion:)：清空本地用户全部属性
- [getUserAllAttributes:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getUserAllAttributes:completion:)：获取指定用户的全部属性
- [getUserAttributes:ByKeys:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/getUserAttributes:ByKeys:completion:): 获取指定用户的指定属性
- [	AgoraRtmProcessAttributeErrorCode](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmProcessAttributeErrorCode.html)：属性操作相关错误码

**性能改进**

- 支持在登录 Agora RTM 系统之前创建频道实例。
- 取消创建 RTM 频道最多 20 个的限制，但是同一用户只能同时加入 20 个频道，超限后会收到错误码 `AgoraRtmJoinChannelErrorFailure ` 。


**问题修复**

- 偶现的系统崩溃。
- 用户登出后，其它用户查询该用户仍然显示在线，30 秒后查询不在线。


## 0.9.2 版

该版本于 2019 年 5 月 8 日发布。

> 当前版本不支持在 [登录](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/loginByToken:user:completion:) RTM 系统前 [创建频道实例](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/createChannelWithId:delegate:) 。

**新增功能**

#### 查询用户在线状态

本版本引入了新的概念：在线和离线。一般情况下：

- 在线：用户已登录到 Agora RTM 系统。
- 离线：用户已登出 Agora RTM 系统或因其他原因，比如权限或网络原因，与 Agora RTM 系统断开连接。

本版本增加了查询用户在线状态功能。你可以在登录 Agora RTM 系统后查询最多 256 个指定用户的在线状态。详见： [queryPeersOnlineStatus:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/queryPeersOnlineStatus:completion:) 接口。

> - 返回的阵列中的 Use ID 的顺序以输入顺序为准。
> - 该方法的调用频率限制为每 5 秒 10 次。详见 [限制条件](/cn/Real-time-Messaging/limitations_oc) 。


#### 更新 Token

在安全性要求较高的情况下，你需要输入 Token [登录](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/loginByToken:user:completion:) Agora RTM 系统。 每个 Token 都会在生成 24 小时后过期，本版本提供了 [更新 Token](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/renewToken:completion:) 的功能。

- 在登录 Agora RTM 系统时，如果你的 Token 已过期，SDK 会返回 [AgoraRtmLoginErrorTokenExpired](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmLoginErrorCode.html) 错误码提示 Token 过期。
- 在已登录 Agora RTM 系统的情况下，Token 过期不会导致用户立即被踢出，但当用户重新登录 Agora RTM 系统时需要调用。所以，我们建议你在收到 [rtmKitTokenDidExpire:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmDelegate.html#//api/name/rtmKitTokenDidExpire:) 回调后尽快更新 Token。


> - [renewToken](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a9a6d33282509384165709107d7a89353) 方法必须在 [创建 RtmClient 实例](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/initWithAppId:delegate:) 后才能调用。
> - Agora RTM Token 的生成方式、输入参数与 Agora 媒体 SDK 不同，详情请见： [校验用户权限](/cn/Real-time-Messaging/rtm_token?platform=All%20Platforms) 。
> - `renewToken:completion:` 方法的调用频率为 2 次 / 秒。详见 [限制条件](/cn/Real-time-Messaging/limitations_oc) 。




**API 变更**

#### 查询用户在线状态相关

##### 新增

- 方法： [queryPeersOnlineStatus:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/queryPeersOnlineStatus:completion:)
- 错误码：[AgoraRtmQueryPeersOnlineErrorCode](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmQueryPeersOnlineErrorCode.html)

#### 更新 Token 相关

##### 新增

- 方法： [renewToken:completion:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/renewToken:completion:)
- 回调： [rtmKitTokenDidExpire:](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmDelegate.html#//api/name/rtmKitTokenDidExpire:)
- 错误码： [AgoraRtmRenewTokenErrorCode](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmRenewTokenErrorCode.html)

#### 呼叫邀请相关

新增以下错误码覆盖用户在没有登录 Agora RTM 系统的情况下发送呼叫邀请的错误情况：

- [AgoraRtmLocalInvitationErrorNotLoggedIn](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmLocalInvitationErrorCode.html)




## 0.9.1 版

该版本于 2019 年 4 月 4 日发布。

> 本版本不包含 `setLogFile` 和 `setLogFilter` 方法。所有的日志信息默认保存在：
> - iOS 平台： **/Library/Caches/agorartm.log** 。
> -macOS 平台： **~/Library/Logs/agorartm.log** 。

**新增功能**

本版本增加了呼叫邀请功能。结合音视频一对一或一对多通话场景，你可以创建、发送、取消、接受或拒绝一个呼叫邀请。



**性能改进**

- 优化了对象关系帮助开发者快速搭建应用。
- 简化了发送频道消息或点对点消息的流程。

**API 变更**

#### 新增

- [initWithCalleeId](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmLocalInvitation.html#//api/name/initWithCalleeId:): 创建一个 `AgoraRtmLocalInvitation` 实例。

- [AgoraRtmLocalInvitation](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmLocalInvitation.html): 用于主叫读取的呼叫邀请对象。

- [localInvitationReceivedByPeer](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmCallDelegate.html#//api/name/rtmCallKit:localInvitationReceivedByPeer:): 被叫已接收到呼叫邀请回调。

- [localInvitationAccepted](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmCallDelegate.html#//api/name/rtmCallKit:localInvitationAccepted:withResponse:): 被叫已接受呼叫邀请回调。

- [localInvitationRefused](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmCallDelegate.html#//api/name/rtmCallKit:localInvitationRefused:withResponse:): 被叫已拒绝呼叫邀请回调。

- [localInvitationCanceled](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmCallDelegate.html#//api/name/rtmCallKit:localInvitationCanceled:): 已取消呼叫邀请回调。

- [localInvitationFailure](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmCallDelegate.html#//api/name/rtmCallKit:localInvitationFailure:errorCode:): 发出的呼叫邀请进程失败回调。

- [remoteInvitationReceived](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmCallDelegate.html#//api/name/rtmCallKit:remoteInvitationReceived:): 收到呼叫邀请回调。

- [remoteInvitationAccepted](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmCallDelegate.html#//api/name/rtmCallKit:remoteInvitationAccepted:): 已接受呼叫邀请回调。

- [remoteInvitationRefused](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmCallDelegate.html#//api/name/rtmCallKit:remoteInvitationRefused:): 已拒绝呼叫邀请回调。

- [remoteInvitationCanceled](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmCallDelegate.html#//api/name/rtmCallKit:remoteInvitationCanceled:): 主叫已取消呼叫邀请回调。

- [remoteInvitationFailure](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmCallDelegate.html#//api/name/rtmCallKit:remoteInvitationFailure:errorCode:): 发给被叫的呼叫邀请进程失败回调。

- [AgoraRtmCallDelegate](/en/Real-time-Messaging/API%20Reference/RTM_oc/Protocols/AgoraRtmCallDelegate.html): 提供呼叫邀请相关回调。

- [sendLocalInvitation](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmCallKit.html#//api/name/sendLocalInvitation:completion:): 向指定用户发送呼叫邀请。

- [acceptRemoteInvitation](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmCallKit.html#//api/name/acceptRemoteInvitation:completion:): 用于被叫接受呼叫邀请。

- [refuseRemoteInvitation](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmCallKit.html#//api/name/refuseRemoteInvitation:completion:): 用于被叫拒绝呼叫邀请。

- [cancelLocalInvitation](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmCallKit.html#//api/name/cancelLocalInvitation:completion:): 用于主叫取消呼叫邀请。

- [AgoraRtmLocalInvitationState](/en/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmLocalInvitationState.html): 返回给主叫的呼叫邀请状态码。

- [AgoraRtmRemoteInvitationState](/en/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmRemoteInvitationState.html): 返回给被叫的呼叫邀请状态码。

- [AgoraRtmLocalInvitationErrorCode](/en/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmLocalInvitationErrorCode.html): 返回给主叫的呼叫邀请错误码。

- [AgoraRtmRemoteInvitationErrorCode](/en/API%20Reference/RTM_oc/Constants/AgoraRtmRemoteInvitationErrorCode.html): 返回给主叫的呼叫邀请错误码。

- [AgoraRtmInvitationApiCallErrorCode](/en/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmInvitationApiCallErrorCode.html): 呼叫邀请相关 API 方法调用的错误码。

- [AgoraRtmConnectionChangeReasonRemoteLogin](/en/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmConnectionChangeReason.html): 另一个实例已用相同的用户 ID 登录 Agora RTM 系统。

- [AgoraRtmSendPeerMessageErrorCode](/en/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmSendPeerMessageErrorCode.html): 发送点对点消息相关错误码。 

- [AgoraRtmSendChannelMessageErrorCode](/en/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmSendChannelMessageErrorCode.html): 发送频道消息相关错误码。 


#### 删除

- 删除常量 `AgoraRtmSendMessageErrorCode` ，改用 [AgoraRtmSendPeerMessageErrorCode](/en/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmSendPeerMessageErrorCode.html)  和 [AgoraRtmSendChannelMessageErrorCode](/en/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmSendChannelMessageErrorCode.html) 。

#### 修正

- 将 `channelDelegate` 设为 property 方便开发者设置。 
- 将参数 `rtmKit` 从 `AgoraRtmChannelDelegate` 下的回调中删除。
- 更改了通过 JSON 选项配制 SDK 的 [setParameters](/en/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/setParameters:) 方法的参数。
- 从 [AgoraRtmSendChannelMessageErrorCode](/en/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmSendChannelMessageErrorCode.html) 删除`AgoraRtmSendChannelMessageStateReceivedByServer` 状态。
- 删除点对点消息状态 AgoraRtmSendPeerMessageState interface ，改用错误码 [AgoraRtmSendPeerMessageErrorCode](/en/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmSendPeerMessageErrorCode.html) 。
- 删除频道消息状态 AgoraRtmSendChannelMessageState ，改用错误码 [AgoraRtmSendChannelMessageErrorCode](/en/Real-time-Messaging/API%20Reference/RTM_oc/Constants/AgoraRtmSendChannelMessageErrorCode.html) 。

## 0.9.0 版

该版本于 2019 年 2 月 4 日发布。

首次发布。

关键功能

- 发送或接收点对点消息。
- 加入或离开频道。
- 发送或接收频道消息。

