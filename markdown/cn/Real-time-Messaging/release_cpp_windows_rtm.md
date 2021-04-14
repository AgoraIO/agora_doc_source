---
title: 发版说明
platform: All Platforms
updatedAt: 2021-03-02 03:11:49
---
## 简介

<div class="alert info">实时消息于 2021 年 2 月正式更名为云信令，服务不变，初心不改。</div>

Agora 云信令（原实时消息）SDK 提供了稳定可靠、低延时、高并发的全球消息云服务，帮助你快速构建实时通信场景,  可实现消息通道、呼叫、聊天、状态同步等功能。点击[云信令（原实时消息）产品概述](/cn/Real-time-Messaging/product_rtm?platform=All%20Platforms)了解详情。


## 1.3.0 版

该版本于 2020 年 4 月 24 日发布。

### 兼容性改动

废弃频道消息发送方法 `sendMessage`，改由重载方法 `sendMessage (const IMessage *message, const SendMessageOptions &options)` 替代。

#### 新增功能

##### 收发文件消息

v1.3.0 支持上传下载大小不超过 30 MB 的任意文件格式的非空文件，支持随时取消正在进行中的上传或下载任务。每份上传到 Agora 服务器的文件都对应一个 media ID，在服务端默认保存 7 天。用户可以通过 media ID 在 7 天有效期内从 Agora 服务器下载对应的文件。

<div class="alert note">用户只能通过 SDK 提供的下载方法下载文件。</div>

v1.3.0 引入了 `IFileMessage` 消息类用于保存和传递系统生成的 `media ID: IFileMessage` 继承自 `IMessage` 类，所以用户可以通过已有的点对点消息或频道消息发送方法传递 `IFileMessage` 实例。用户可以通过 `IFileMessage` 对象:

- 设置相应的上传文件的显示文件名和显示缩略图。
- 获取相应的上传文件的大小。
  
<div class="alert note">消息内容、显示文件名和显示缩略图的总大小不得超过 32 KB。</div>

##### 收发图片消息

v1.3.0 支持上传下载大小不超过 30 MB 的任意文件格式的非空图片，支持随时取消正在进行中的上传或下载任务。每份上传到 Agora 服务器的图片都对应一个 media ID，在服务端默认保存 7 天。用户可以通过 media ID 在 7 天有效期内从 Agora 服务器下载对应的图片。

v1.3.0 引入了 `IImageMessage` 消息类用于保存和传递系统生成的 `media ID: IImageMessage` 继承自 `IMessage` 类，所以用户可以通过已有的点对点消息或频道消息发送方法传递 `IImageMessage` 实例。用户可以通过 `IImageMessage` 对象:

- 设置相应的上传图片的显示文件名和显示缩略图。
- 获取相应的上传图片的大小。
- 获取 SDK 为 JPEG、JPG、BMP，以及 PNG 这四种格式的图片计算的宽高数据。
- 自行设置图片的宽和高。用户自行设置的宽高数据会覆盖 SDK 计算的宽高数据。

<div class="alert note">消息内容、显示文件名和显示缩略图的总大小不得超过 32 KB。</div>

##### 通知上传或下载任务的进度

对于正在进行中的上传或下载任务，SDK 会通过主动回调每秒返回一次上传或下载的进度。当上传或下载任务陷入停顿时 SDK 暂停返回相应回调直至任务继续进行。

##### 问题修复

- 由于误判用户网络类型导致无法登录问题。
- 其它可能导致系统崩溃的问题。

### API 变更

- [createFileMessageByUploading](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a99f2137ec43be135b369b7d6927b6138): 上传一份文件到 Agora 服务器以获取一个相应的 [IFileMessage](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_file_message.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af) 文件消息实例。
- [createImageMessageByUploading](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a7192d93f365c28e2d0b91547716fb5a9): 上传一份图片到 Agora 服务器以获取一个相应的 [IImageMessage](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_image_message.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af) 图片消息实例。
- [cancelMediaUpload](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a0090bbb72e250ffbaedc84d9041b64b1): 通过 request ID 取消一个正在进行中的文件或图片上传任务。
- [cancelMediaDownload](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#adc34b7acad8b845fe1242efd127d82b9): 通过 request ID 取消一个正在进行中的文件或图片下载任务。
- [createFileMessageByMediaId](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a6e4b13011388ec45e8a02377b240506f): 通过已有的 media ID 创建一个 [IFileMessage](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_file_message.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af) 实例。
- [createImageMessageByMediaId](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a97bfb847ff876ab216cf219f4b4f856d): 通过已有的 media ID 创建一个 [IImageMessage](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_image_message.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af) 实例。
- [downloadMediaToMemory](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#ade134da2be907a8078ce693849e0cc37): 通过 media ID 从 Agora 服务器下载文件或图片至本地内存。
- [downloadMediaToFile](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a70584eb57e97476b1da072f737d88c95): 通过 media ID 从 Agora 服务器下载文件或图片至本地指定地址。


### 新增回调

- [onMediaUploadingProgress](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a56d5464c3b5e53c44039190a3ac4dfe9): 主动回调：上传任务的上传进度回调。
- [onMediaDownloadingProgress](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a9c4dfbb224f69b73f64dc1bf34f28567): 主动回调：下载任务的下载进度回调。
- [onMediaCancelResult](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a64cac4d387e2bf6a419bb478358570f6): 返回 [cancelMediaDownload](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#adc34b7acad8b845fe1242efd127d82b9) 或 [cancelMediaUpload](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a0090bbb72e250ffbaedc84d9041b64b1) 方法的调用结果。
- [onFileMediaUploadResult](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#aadaa8cd5309e4e70ab2cbdfc1ef21241): 返回 [createFileMessageByUploading](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a99f2137ec43be135b369b7d6927b6138) 方法的调用结果。
- [onImageMediaUploadResult](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#abaeeaeb6d69b98510d6c3b012849251e): 返回 [createImageMessageByUploading](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a7192d93f365c28e2d0b91547716fb5a9) 方法的调用结果。
- [onFileMessageReceivedFromPeer](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a4642bb3a8ddf026617fff47d1c9f3e3a): 收到点对点文件消息回调。
- [onImageMessageReceivedFromPeer](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a2682e64be745cf7af816a12f9895ce07): 收到点对点图片消息回调。
- [onFileMessageReceived](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_channel_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a416dd103c84387a5147e962398eff8d1): 收到频道文件消息回调。
- [onImageMessageReceived](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_channel_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a6d710170df9b3c1f0ef092012af2e317): 收到频道图片消息回调。
- [onMediaDownloadToMemoryResult](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#ad0de249a8f0b79973f34f295cabe4904): 返回 [downloadMediaToMemory](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#ade134da2be907a8078ce693849e0cc37) 方法的调用结果。
- [onMediaDownloadToFileResult](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a0b6edc7b944eab02d545bb2d2d1bfe2f): 返回 [downloadMediaToFile](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_rtm_service.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a70584eb57e97476b1da072f737d88c95) 方法的调用结果。

### 废弃方法

- [sendMessage](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_channel.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a4ae01f44d49f334f7c2950d95f327d30): 被重载方法 [sendMessage (const IMessage *message, const SendMessageOptions &options)](https://docs-preview.agoralab.co/cn/Video/API%20Reference/RTM_cpp/v1.3.0/classagora_1_1rtm_1_1_i_channel.html?transId=91d56170-7fb5-11ea-a366-4fbfd071e0af#a056dfe9e83c168c3c94e47a017a6ec3f) 替代。

## 1.2.2 版

该版本于 2019 年 12 月 13 日发布。


**兼容性改动**

废弃用于创建 <code>IAgoraService</code> 的 <code>createAgoraService</code> 方法以及用于初始化 <code>IAgoraService</code> 的 <code>initialize</code> 方法。从本版本开始，你只需要调用用于创建 <code>IRtmService</code> 的 <code>createRtmService</code> 方法以及用于初始化 <code>IRtmService</code> 的 <code>initialize</code> 方法就可以开始使用 <code>IRtmService</code> 实例。


**问题修复**

修复了一个偶现的频道属性操作后无法收到回调的问题。

## 1.2.1 版

该版本于 2019 年 11 月 29 日 发布。

**新增功能**

**支持与老信令 SDK 的 endCall 方法兼容** 

你可以调用 `sendMessageToPeer` 方法在发送<i>文本</i>消息时将消息设为 AgoraRTMLegacyEndcallCompatibleMessagePrefix\_\<channelId\>\_\<your additional information\> 格式即可。请以 endCall 对应频道的 ID 替换 \<channelId\>， \<your additional information\> 为附加文本信息。请注意：附加文本信息中不可使用下划线 "_" ，附加文本信息可以设为空字符串 "" 。

**问题修复**


- 修复了一个用户使用 VPN 登录 RTM，关闭 VPN 后 RTM 重连失败的问题。
- 修复了一个频道中用户断线重连，频道中其它用户有概率收到两次 `onMemberJoined` 回调的问题。

## 1.2.0 版


该版本于 2019 年 11 月 6 日发布。新增如下功能：

- [订阅或取消订阅指定单个或多个用户的在线状态](#subscribe)
- [获取某特定内容被订阅的用户列表](#list)
- [创建自定义二进制消息](#raw)
- [创建文本消息](#text)



**兼容性改动**

#### 废弃 `isOnline`

在调用 [queryPeersOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3add0055c4455dc8d04bfc37edfd8e94) 方法查询单个或多个用户在线状态后，SDK 会通过 [onQueryPeersOnlineStatusResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a782b4623d4dcbac5c99fd6a12c42f578) 回调返回被查询用户的在线状态。你可以通过回调返回的 [PeerOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/structagora_1_1rtm_1_1_peer_online_status.html) 结构体数组中的 [isOnline](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/structagora_1_1rtm_1_1_peer_online_status.html#a27f653585385efc3e1a4265948d11c1c) 字段查询指定用户是否在线。

本版本中，我们在这个 [PeerOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/structagora_1_1rtm_1_1_peer_online_status.html) 结构体中增加了枚举类型 [PEER_ONLINE_STATE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a16966e9a602270d2bbdd9510602ecc5f) ，细分并重新定义了以下三种用户在线状态：

- 在线（online）： 用户已登录 Agora RTM 系统。
- 连接状态不稳定（unreachable）：服务器连续 6 秒未收到来自 SDK 的数据包。
- 用户不在线（offline）：用户未登录或已登出 Agora RTM 系统，或服务器连续 30 秒未收到来自 SDK 的数据包。

新增的 [PEER_ONLINE_STATE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a16966e9a602270d2bbdd9510602ecc5f) 枚举类型主要与订阅功能 [subscribePeersOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3a0e2d4d79ac85e23eae0dcb114ba9f0) 配合使用，你可以在 [onPeersOnlineStatusChanged](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a1eb57be5d0cdc9e4533852794e2e47ca) 回调返回的 [PeerOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/structagora_1_1rtm_1_1_peer_online_status.html) 结构体数组中查到用户的在线状态。

总而言之：

- 在主动查询用户在线状态时，我们推荐你通过 [PEER_ONLINE_STATE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a16966e9a602270d2bbdd9510602ecc5f) 查询，不过系统不会返回 `unreachable` 状态。
- 在订阅了指定用户的在线状态后，我们推荐你通过 [PEER_ONLINE_STATE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a16966e9a602270d2bbdd9510602ecc5f) 获取用户在线状态，方便 App 在用户连接状态不佳时快速响应，提高整体用户体验。



**新增功能**

#### 1. <a name="subscribe"></a>订阅或取消订阅指定单个或多个用户的在线状态。

<div class="alert note"> 该功能必须在登录 Agora RTM 系统成功（收到 onLoginSuccess 回调）后才能调用。</div>

本版本支持订阅或取消订阅最多 512 个用户的在线状态，SDK 会通过 [onSubscriptionRequestResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#af44e58f8368ceb7ad883b94fd4643cc4) 返回订阅或取消订阅结果。首次订阅成功时，SDK 会通过 [onPeersOnlineStatusChanged](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a1eb57be5d0cdc9e4533852794e2e47ca) 回调返回所有被订阅用户的在线状态；之后每当有被订阅用户的在线状态出现变化，SDK 都会通过 [onPeersOnlineStatusChanged](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a1eb57be5d0cdc9e4533852794e2e47ca) 回调通知订阅方。

<div class="alert note"> <sup>1</sup>用户登出 Agora RTM 系统后，所有之前的订阅内容都会被清空；重新登录后，如需保留之前订阅内容则需重新订阅。</div>

<div class="alert note"> <sup>2</sup>重复订阅同一用户不会报错。</div>


#### 2. <a name="list"></a>获取某特定内容被订阅的用户列表

<div class="alert note"> 该功能必须在登录 Agora RTM 系统成功（收到 onLoginSuccess 回调）后才能调用。</div>

本版本支持根据被订阅类型获取被订阅用户列表。现实情况中，你可能多次订阅或取消订阅，可能重复订阅了相同用户，可能出现订阅或取消订阅不成功的情况，也可能根据不同的订阅类型订阅了不同的用户。这时，你可以通过本功能根据订阅类型获取当前被订阅用户列表。

被订阅类型由枚举类型 [PEER_SUBSCRIPTION_OPTION](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a2afe690e9fe0e0af4a0f5fd8b6c8eef9) 定义。本版本仅支持用户在线状态订阅一种类型，后继会不断扩展。

#### 3. <a name="raw"></a>创建自定义二进制消息

本版本支持创建自定义二进制消息，支持以点对点消息或频道消息形式发送多种文件格式。

本版本支持：

- 创建不带文本描述信息的自定义二进制消息（[createMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ab246e4151cf9fc42c32c13489f49c1ea)）
- 创建包含文本描述信息的自定义二进制消息（[createMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ae74ba0d307da66176fe58d554d6676ab)）

如果在创建自定义二进制消息时未设置文本描述，你可以在消息实例 [IMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html) 创建成功后通过调用 [setText](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html#a2e93098d5a3819e9d4cf8d42641474ae) 方法设置自定义二进制消息的文本描述。

<div class="alert note"> 我们不对二进制消息的文本描述的大小单独进行限制，但是我们要求自定义二进制消息的总大小不超过 32 KB。</div>

#### 4. <a name="text"></a>创建文本消息

之前版本中，我们先通过 [createMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#acbbfe84bc22fd161ec5dc4fe098a59ce) 方法创建一个空文本消息实例再通过调用 [IMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html) 类的对象方法 [setText](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html#a2e93098d5a3819e9d4cf8d42641474ae) 设置文本内容，本版本提供了更加便利的 [createMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#aa4b2cd37eb8eb1b2b1ba217830c6317f) 方法可以在创建文本消息的同时直接设定文本消息内容。

<div class="alert note"> 文本消息大小不得超过 32 KB。</div>


**API 变更**

#### 新增方法

- [subscribePeersOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3a0e2d4d79ac85e23eae0dcb114ba9f0): 订阅指定单个或多个用户的在线状态。
- [unsubscribePeersOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a027574f04151a9fded678fadba47441e): 解除订阅指定单个或多个用户的在线状态。
- [queryPeersBySubscriptionOption](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a063bd3db39660a7a3513378ce03f4456): 获取某特定内容被订阅的用户列表。
- [createMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#aa4b2cd37eb8eb1b2b1ba217830c6317f): 创建并返回一个文本 [IMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html) 消息实例。
- [createMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ab246e4151cf9fc42c32c13489f49c1ea): 创建并返回一个自定义二进制 [IMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html) 消息实例。
- [createMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ae74ba0d307da66176fe58d554d6676ab): 创建并返回一个包含文字描述的自定义二进制 [IMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html) 消息实例。

#### 新增回调

- [onSubscriptionRequestResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#af44e58f8368ceb7ad883b94fd4643cc4): 返回 [subscribePeersOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3a0e2d4d79ac85e23eae0dcb114ba9f0) 或 [unsubscribePeersOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a027574f04151a9fded678fadba47441e) 方法的调用结果。
- [onPeersOnlineStatusChanged](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a1eb57be5d0cdc9e4533852794e2e47ca): 被订阅用户在线状态改变回调。
- [onQueryPeersBySubscriptionOptionResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#abfa6692f88f55017f3cfbec3ca98ffdf): 返回 [queryPeersBySubscriptionOption](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a063bd3db39660a7a3513378ce03f4456) 方法的调用结果。

#### 新增错误码 

- [PEER_SUBSCRIPTION_STATUS_ERR](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a4fa6b08d01154d48966cfcb37acf08be): 订阅或取消订阅指定用户在线状态相关错误码。
- [QUERY_PEERS_BY_SUBSCRIPTION_OPTION_ERR](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a5ecaf0f0a7ac45ea78198f52393bf607): 根据订阅类型获取被订阅用户列表相关的错误码。

#### 新增枚举类型

- [PEER_ONLINE_STATE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a16966e9a602270d2bbdd9510602ecc5f): 用户在线状态类型

#### 废弃成员变量

- [isOnline](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/structagora_1_1rtm_1_1_peer_online_status.html#a27f653585385efc3e1a4265948d11c1c)：请改用成员变量 [onlineState](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/structagora_1_1rtm_1_1_peer_online_status.html#a240a2611b6e8e45413679e3ec4f59023)

## 1.1.0 版

该版本于 2019 年 9 月 30 日初次发布。新增以下功能：

**新老互通**

支持与 Agora Signaling SDK 互通。

本版本在 `ILocalCallInvitation` 类中实现了 `setChannelId` 和 `getChannelId` 方法。

> - 如需与 Agora Signaling SDK 互通，则必须调用 `setChannelId` 方法设置频道 ID。不过即使被叫成功接受呼叫邀请，Agora RTM SDK 也不会将主叫或被叫加入指定频道。
> - 如果你的应用不涉及 Agora Signaling SDK，我们推荐使用 `ILocalCallInvitation::setContent` 或者 `IRemoteCallInvitation::setResponse` 方法设置自定义内容。


**发送（离线）点对点消息**

本版本支持发送离线消息。在开通离线消息后，用户不必等到接收端上线才能发送点对点消息。如果对端离线，消息服务器会为每个接收端存储 200 条离线消息长达七天。消息以队列形式存储。当离线消息超限时，最新存储的消息会导致最老的消息丢失。当发送端设置了离线消息，而此时消息接收端不在线，发送端会收到错误码：[PEER_MESSAGE_ERR_CACHED_BY_SERVER](/cn/Video/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#ac7c591aac4ca6867e239c8bcccc1fc5caeccb9896a862a86fa1965705e2d394fd)

<a name="getcount"></a>
**查询频道成员人数**

支持在不加入频道的情况下通过主动调用 [getChannelMemberCount](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a41dee47c6201acb2f29371b6e30249a5) 接口查询单个或多个频道的频道人数。一次最多可查询 32 个频道的成员人数。

**查询用户在线状态**

**设置本地用户属性、查询指定用户属性**

本版本支持设置和查询用户属性。每个用户属性为 key 和 value 的键值对。每个属性的 key 为 32 字节可见字符，每个属性的 value 的字符串长度不得超过 8 KB。单个用户的全部属性长度不得超过 16 KB。以下为本版本支持内容：

   - 全量设置本地用户属性
   - 增加或更新本地用户属性
   - 删除本地用户指定属性
   - 清空本地用户属性
   - 全量获取指定用户属性
   - 获取指定用户指定属性。


> - 用户属性的相关操作必须在登录 Agora RTM 系统成功后才能进行，否则 SDK 会返回错误码：`ATTRIBUTE_OPERATION_ERR_NOT_LOGGED_IN`
> - 设置的用户属性会在用户登出 Agora RTM 系统后自动失效。
> - 单次用户属性设置操作不得超过 16 KB，否则 SDK 会返回错误码：`ATTRIBUTE_OPERATION_ERR_SIZE_OVERFLOW` 。
> - 用户属性设置相关操作的调用频率限制为每 5 秒 10 条，超限则 SDK 会返回错误码：`ATTRIBUTE_OPERATION_ERR_TOO_OFTEN`。
> - 获取用户属性相关操作的调用频率为每 5 秒 40 条，超限则 SDK 会返回错误码：`ATTRIBUTE_OPERATION_ERR_TOO_OFTEN` 。

<a name="channelattributes"></a>
**频道属性增删改查**

支持设置或查询某个指定频道的属性。你可以用频道属性实现群公告、上下麦同步等功能。

每个频道属性为 key 和 value 的键值对。详见：[IRtmChannelAttribute](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_channel_attribute.html)。其中：
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

在进行频道属性的更新或删除操作时，你可以通过设置标志位 [enableNotificationToChannelMembers](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/structagora_1_1rtm_1_1_channel_attribute_options.html#a9a29721df90beca76974a5e348902530) 决定是否通知对应频道所有成员本次频道属性变更。

**呼叫邀请**

增加了呼叫邀请功能。结合音视频一对一或一对多通话场景，你可以创建、发送、取消、接受或拒绝一个呼叫邀请。

**加入或离开频道**

**发送或接收频道消息**



<a name="oncount"></a>
### 频道成员人数自动更新

如果你已经加入某频道，你无需调用 `getChannelMemberCount` 接口查询当前频道人数。我们也不建议你通过监听 `onMemberJoined` 和 `onMemberLeft` 统计频道成员人数。从本版本开始，SDK 会在频道成员人数发生变化时通过 [onMemberCountUpdated](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#aff85052bb2a46c3220789c1ef90aa01e) 回调接口通知频道成员并返回当前频道成员人数：

- 频道成员人数小于等于 512 时，最高触发频率为每秒 1 次。
- 频道成员人数超过 512 时，最高触发频率为每 3 秒 1 次。



### 更新 Token

### 设置日志文件地址

支持通过调用 `setLogFile` 方法变更本地日志的默认地址。该方法无需在 `login` 成功之后调用，我们建议在初始化 Agora RTM 服务后即调用该方法，否则会造成日志文件显示不完整。

### 设置日志输出等级

支持通过调用 `setLogFilter` 方法将日志内容按照 OFF、CRITICAL、ERROR、WARNING 和 INFO 不同等级输出。详见 [LOG_FILTER_TYPE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#af515252477afb2a71feef88113dfa481) 。

> 该方法无需在 `login` 成功之后调用。

### 设置日志文件大小

支持通过 `setLogFileSize` 方法设置日志文件大小。日志的默认大小为 512 KB。低于该默认大小的设置无效。

> 该方法无需在 `login` 成功之后调用。


> 该方法的调用频率限制为每秒 60 条（点对点消息和频道消息一并计算在内）。









