## 1.5.0 版

该版本于 2022 年 7 月 27 日发布。

#### 功能下架

[富媒体传输](./upload_download_media_java)、[历史消息](./rtm_get_event) 和 [离线消息](./messaging_restful#history) 功能于该版本正式下线。旧版本 SDK 会继续支持，已集成这些功能的用户不受影响。

#### API 变更

**废弃**  
- `createFileMessageByMediaId`
- `createFileMessageByUploading`
- `createImageMessageByMediaId`
- `createImageMessageByUploading`
- `cancelMediaUpload`
- `cancelMediaDownload`
- `downloadMediaToFile`
- `downloadMediaToMemory`
- `onFileMessageReceived`
- `onFileMessageReceivedFromPeer`
- `onImageMessageReceived`
- `onImageMessageReceivedFromPeer`
- `onMediaUploadingProgress`
- `onMediaDownloadingProgress`
- `enableOfflineMessaging`
- `enableHistoricalMessaging`


## 1.4.10 版
该版本于  2022 年 03 月 01 日发布。

#### 升级必看

自该版本起，你无需在 Android 项目的 `AndroidManifest.xml` 文件中添加如下权限：

```java
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

#### 问题修复

修复了一些富媒体相关的崩溃问题。


## 1.4.9 版
该版本于  2021 年 11 月 19 日发布。

#### 升级必看

- 自该版本起，你可以通过 Maven Central 自动集成 Agora RTM Android SDK。关于使用 Maven Central 自动集成的步骤，详见[集成 SDK](https://docs.agora.io/cn/Real-time-Messaging/messaging_android?platform=Android#a-namesdka-快速集成-sdk)。

- 自该版本起，你需要在 Android 项目的 `AndroidManifest.xml` 文件中添加如下权限，便于检测 WIFI 网络的连接状态：
```java
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
```

#### 改进

提升了 IPv4/IPv6 双栈网络下登录成功率和连接稳定性。

## 1.4.7 版
该版本于  2021 年 7 月 19 日发布。

提高了弱网状态下的登录成功率和消息投递成功率。

## 1.4.6 版

该版本于  2021 年 6 月 21 日发布。

修复了一些可能导致崩溃的问题，优化了稳定性。

## 1.4.5 版

该版本于  2021 年 4 月 30 日发布。

#### 改进

修复了一些可能导致崩溃的问题，优化了稳定性。

## 1.4.4 版

该版本于 2021 年 4 月 20 日发布。

#### 升级必看

**集成变更**

由于 JCenter 即将关闭，自该版本起，Agora 停止将 SDK 包发布到 JCenter，而会发布到 JitPack。关于使用 JitPack 自动集成的步骤，详见[集成 SDK](https://docs.agora.io/cn/Real-time-Messaging/messaging_android?platform=Android#a-namesdka-快速集成-sdk)。

#### 改进
优化了弱网对抗能力，提高了弱网环境下的登录成功率和消息投递成功率。

#### 问题修复
修复了一些崩溃问题。

## 1.4.3 版

该版本于 2021 年 2 月 10 日发布。


该版本修复了以下问题：

- 偶现的多线程访问冲突造成崩溃的问题。
- Agora RTM SDK 登录超时率较高的问题。

## 1.4.2 版

该版本于 2020 年 11 月 23 日发布。

#### 改进

优化了登录和消息发送的性能。


## 1.4.1 版

该版本于 2020 年 9 月 30 日发布。

#### 改进

优化了日志文件。


## 1.4.0 版

该版本于 2020 年 9 月 1 日发布。

#### 升级必看

- 防火墙白名单端口变更。详见[应用企业防火墙限制](https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms)。
  - 新增 TCP 端口：8443, 9136, 9137, 9141。 新增 UDP 端口：8443。原因：用于支持传输加密能力。
  - 新增 UDP 端口：8130, 9120, 9121。原因：用于开启 UDP 通道，帮助提升 RTM 的弱网对抗能力。
  - 新增 UDP 端口：9700。原因：用于数据上报。
- `setLogFileSize` 日志文件的大小默认值从 512 KB 增加到 10 MB。上限从 10 MB 增加到 1 GB。


#### 新增功能

- 增加限定访问区域功能。你可以调用 `setRtmServiceContext` 方法设置 Agora RTM SDK 的访问区域。设置之后，RTM SDK 只能连接位于限定区域的 Agora RTM 服务器。
- 增加链路加密功能。此功能默认开启。如果你要关闭此功能，请[提交工单](https://agora-ticket.agora.io/)联系 Agora 技术支持。

#### 改进

- 优化了弱网对抗能力，提高了弱网环境下的登录成功率和消息投递成功率。
- 优化了重连机制。

#### API 变更

**新增方法**

[`setRtmServiceContext`](/cn/Real-time-Messaging/API%20Reference/RTM_java/v1.4.0/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a60f0dae72834f3d300bd7e5abb3fdcc7)

## 1.3.0 版

该版本于 2020 年 5 月 11 日发布。

#### 升级必看

- 防火墙白名单的 TCP 协议需要新增 9140 端口，用于发送和接收图片及文件消息。详见[应用企业防火墙限制](https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms)。
- 服务器端会屏蔽向 1.2.2 或更早版本的实时消息 SDK、信令 SDK 发送的图片或文件消息。

#### 新增功能

**1. 发送和接收文件消息**

v1.3.0 支持上传和下载大小不超过 30 MB 的任意格式的非空文件，支持随时取消正在进行中的上传或下载任务。每份上传到 Agora 服务器的文件都对应一个 media ID，在服务端保存 7 天。你可以通过 media ID 在 7 天有效期内从 Agora 服务器下载对应的文件。

<div class="alert note">你只能通过 SDK 提供的下载方法下载文件。</div>

v1.3.0 引入了 `RtmFileMessage` 消息类用于保存和传递系统生成的 media ID。`RtmFileMessage` 继承自 `RtmMessage` 类，所以你可以通过已有的点对点消息或频道消息发送方法传递 `RtmFileMessage` 实例。你可以通过 `RtmFileMessage` 对象进行以下操作:

- 设置相应的上传文件的显示文件名和显示缩略图。
- 获取相应的上传文件的大小。
  
<div class="alert note">消息内容、显示文件名和显示缩略图的总大小不得超过 32 KB。</div>

**2. 发送和接收图片消息**

v1.3.0 支持上传和下载大小不超过 30 MB 的任意格式的非空图片，支持随时取消正在进行中的上传或下载任务。每份上传到 Agora 服务器的图片都对应一个 media ID，在服务端保存 7 天。你可以通过 media ID 在 7 天有效期内从 Agora 服务器下载对应的图片。

v1.3.0 引入了 `RtmImageMessage` 消息类用于保存和传递系统生成的 media ID。`RtmImageMessage` 继承自 `RtmMessage` 类，所以你可以通过已有的点对点消息或频道消息发送方法传递 `RtmImageMessage` 实例。你可以通过 `RtmImageMessage` 对象进行以下操作:

- 设置相应的上传图片的显示文件名和显示缩略图。
- 获取相应的上传图片的大小。
- 获取 SDK 自动计算的 JPEG、JPG、BMP、PNG 四种格式的图片宽高数据。
- 自行设置图片的宽和高。你自行设置的宽高数据会覆盖 SDK 计算的宽高数据。

<div class="alert note">消息内容、显示文件名和显示缩略图的总大小不得超过 32 KB。</div>

**3. 通知上传或下载任务的进度**

对于正在进行中的上传或下载任务，SDK 会通过主动回调每秒返回一次上传或下载的进度。当上传或下载任务暂停时，SDK 暂停返回相应回调，直至任务继续进行。

#### 问题修复

- 由于误判用户网络类型导致无法登录的问题。
- 其它可能导致系统崩溃的问题。

#### API 变更

**新增方法**

- [`createFileMessageByMediaId`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ae4104179072ed6ebcf050d12250c7a1b)
- [`createImageMessageByMediaId`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#aaa3e2556fc93af882fd2758419c682af)
- [`createFileMessageByUploading`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a1b08207278d611e5e4b87e6d9712e0c7)
- [`createImageMessageByUploading`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#afc93fad7700593a803ddbc87482c0ac0)
- [`downloadMediaToMemory`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a3d2568cc940dfd8c8110e70dcc4fb85d)
- [`downloadMediaToFile`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a34e0bd19fb0bbd1d91dec0a1af100038)
- [`cancelMediaUpload`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a17467b5b336a39bc0d29058244aa7c0c)
- [`cancelMediaDownload`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a21af4c790dcb6547253ffd43114696a5)

**新增回调**

- [`onImageMessageReceived`](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html#aa5e74313bc9c7a47e2e877690bbd5b8d)
- [`onFileMessageReceived`](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html#a0d6889ad993ae6e99edaa1d05e67ba77)
- [`onImageMessageReceivedFromPeer`](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#a9cdc9016e7b3349d8340318411852ccf)
- [`onFileMessageReceivedFromPeer`](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#a812843550667e2e13068d4715d2fa98b)
- [`onMediaUploadingProgress`](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#ad54b344caf11bcbfb086a15e96fbb9f2)
- [`onMediaDownloadingProgress`](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#a1f774858444cc9b36369cbee4770df9c)

**废弃方法**

[`sendMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a57087adf4227a17c774ea292840148a0) 被重载方法 [`sendMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a6e16eb0e062953980a92e10b0baec235) 替代。

## 1.2.2 版

$$ 804cbf10-1b48-11ea-8fc3-cf882a952d6b
{
  "platform": "Android"
}
$$

## 1.2.1 版

$$ fe7e5f60-20ac-11ea-b338-f1556ea7fcbf
{
  "platform": "Android"
}
$$



## 1.2.0 版

该版本于 2019 年 11 月6 日发布。新增如下功能：

- [订阅或取消订阅指定单个或多个用户的在线状态](#subscribe)
- [获取某特定内容被订阅的用户列表](#list)
- [创建自定义二进制消息](#raw)
- [创建文本消息](#text)


#### 新增功能

**1. <a name="subscribe"></a>订阅或取消订阅指定单个或多个用户的在线状态。**

<div class="alert note"> 该功能必须在登录 Agora RTM 系统成功（收到 onSuccess 回调）后才能调用。</div>

本版本支持订阅或取消订阅最多 512 个用户的在线状态，SDK 会通过 `onSuccess` 返回订阅或取消订阅结果。首次订阅成功时，SDK 会通过 `onPeersOnlineStatusChanged` 回调返回所有被订阅用户的在线状态；之后每当有被订阅用户的在线状态出现变化，SDK 都会通过 `onPeersOnlineStatusChanged` 回调通知订阅方。

<div class="alert note"> <sup>1</sup>用户登出 Agora RTM 系统后，所有之前的订阅内容都会被清空；重新登录后，如需保留之前订阅内容则需重新订阅。</div>

<div class="alert note"> <sup>2</sup>重复订阅同一用户不会报错。</div>


**2. <a name="list"></a>获取某特定内容被订阅的用户列表。**

<div class="alert note"> 该功能必须在登录 Agora RTM 系统成功（收到 onSuccess 回调）后才能调用。</div>

本版本支持根据被订阅类型获取被订阅用户列表。现实情况中，你可能多次订阅或取消订阅，可能重复订阅了相同用户，可能出现订阅或取消订阅不成功的情况，也可能根据不同的订阅类型订阅了不同的用户。这时，你可以通过本功能根据订阅类型获取当前被订阅用户列表。

被订阅类型由枚举类型 `PeerSubscriptionOption` 定义。本版本仅支持用户在线状态订阅一种类型，后继会不断扩展。

**3. <a name="raw"></a>创建自定义二进制消息。**

本版本支持创建自定义二进制消息，支持以点对点消息或频道消息形式发送多种文件格式。

本版本支持：

- 创建不带文本描述信息的自定义二进制消息
- 创建包含文本描述信息的自定义二进制消息

如果在创建自定义二进制消息时未设置文本描述，你可以在消息实例 `RtmMessage` 创建成功后通过调用 `setText` 方法设置自定义二进制消息的文本描述。

<div class="alert note"> 我们不对二进制消息的文本描述的大小单独进行限制，但是我们要求自定义二进制消息的总大小不超过 32 KB。</div>

**4. <a name="text"></a>创建文本消息。**

之前版本中，我们先通过 `createMessage` 方法创建一个空文本消息实例再通过调用 `RtmMessage` 类的对象方法 `setText` 设置文本内容，本版本提供了更加便利的 `createMessage` 方法可以在创建文本消息的同时直接设定文本消息内容。

<div class="alert note"> 文本消息大小不得超过 32 KB。</div>

#### 问题修复

- 以相同 `channelId` 创建频道后调用 `join` 或 `leave` 时系统返回 `rtm native not ready` 。

## 1.1.0 版

该版本于 2019 年 9 月 18 日发布。新增如下功能：

- [查询频道成员人数](#getcount)
- [频道成员人数自动更新](#oncount)
- [频道属性增删改查](#channelattributes)



#### 兼容性改动

1. 废弃点对点消息发送方法 [sendMessageToPeer](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a25ab5c0126e1dc51c78b2b705de68b7a)，改由重载方法 [sendMessageToPeer(const char \*, const IMessage \*, const SendMessageOptions \&)](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9) 替代。
2. [RtmMessage](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_message.html) 对象的 [getServerReceivedTs](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_message.html#a7994de6da26269c3137e93ddf7a2c2be) 方法由仅支持点对点消息改为同时支持点对点消息和频道消息。
3. 点对点消息的超时时间由 5 秒延长为 10 秒。详见： [PEER_MESSAGE_ERR_TIMEOUT ](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_peer_message_error.html#a9aaaa5b9fa46cc15327abd6c2825bc4d)
4. 针对 [join](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#ad7b321869aac2822b3f88f8c01ce0d40) 方法调用增加了[加入相同频道的频率限制：每 5 秒 2 次](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_join_channel_error.html#a2040b572e1ef4f593f234a20c84a22c7)。

#### 新增功能

<a name="getcount"></a>
**1. 查询频道成员人数**

支持在不加入频道的情况下通过主动调用 [getChannelMemberCount](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#aff0384f2a004ed75498e20e1917352e4) 接口查询单个或多个频道的频道人数。一次最多可查询 32 个频道的成员人数。

<a name="oncount"></a>
**2. 频道成员人数自动更新**

如果你已经加入某频道，你无需调用 `getChannelMemberCount` 接口查询当前频道人数。我们也不建议你通过监听 `onMemberJoined` 和 `onMemberLeft` 统计频道成员人数。从本版本开始，SDK 会在频道成员人数发生变化时通过 [onMemberCountUpdated](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html#ad778e702e026a79460f45a992bb8576d) 回调接口通知频道成员并返回当前频道成员人数：

- 频道成员人数小于等于 512 时，最高触发频率为每秒 1 次。
- 频道成员人数超过 512 时，最高触发频率为每 3 秒 1 次。

> 请将该回调与 [getMembers](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a567aca5f866cf71c3b679ae09b4bf626) 方法进行区分：
> - 前者为主动回调。SDK 向频道成员返回最新频道成员人数。
> - 后者由 [onSuccess](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_result_callback.html#a7206b30500655c4a73d146acf50cb6f5) 返回频道成员列表，且当频道成员人数超过 512 时仅返回随机的 512 个成员列表。

<a name="channelattributes"></a>
**3. 频道属性增删改查**

支持设置或查询某个指定频道的属性。你可以用频道属性实现群公告、上下麦同步等功能。

每个频道属性为 key 和 value 的键值对。详见：[RtmChannelAttribute](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel_attribute.html)。其中：
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



#### 性能改进

**点对点消息重发**

本版本优化了点对点消息在弱网情况下的重发机制，并延长点对点消息超时时间为 10 秒，提高了在弱网情况下点对点消息的发送成功率。

**频道消息缓存**

Agora RTM 系统会对短期掉线后重连成功的频道成员补发最长 30 秒最多 32 条的频道消息，提高了弱网情况下频道消息的到达率。


#### API 变更

**新增方法**

- [setChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ad25f51a3671db50e348ec6c170044ec6)：全量设置某指定频道的属性。
- [addOrUpdaeChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a765b186d62ed3ef6d67a5e875b040875)：添加或更新某指定频道的属性。
- [deleteChannelAttributesByKeys](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a2477533989c1bb9ced831af210f1dba4)：删除某指定频道的指定属性。
- [clearChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ae0c6c5c5bae6020e69009441d8a41785)：清空某指定频道的属性。
- [getChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a81f14a747a4012815ab4ba8d9e480fb6)：查询某指定频道的全部属性。
- [getChannelAttributesByKeys](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a3b927c35cca5ebd31afb976d60e99193)：查询某指定频道指定属性名的属性。
- [getChannelMemberCount](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#aff0384f2a004ed75498e20e1917352e4)：查询单个或多个频道的成员人数。

**新增回调**

- [onAttributesUpdated](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html#a2904a1f1f78c497b9176fffb853be96f)：频道属性更新回调。返回所在频道的所有属性。
- [onMemberCountUpdated](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html#ad778e702e026a79460f45a992bb8576d)：频道成员人数更新回调。返回最新频道成员人数。

**新增错误码**

- [GetChannelMemberCountErrCode](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_get_channel_member_count_err_code.html)：获取指定频道成员人数的相关错误码。
- [JOIN_CHANNEL_ERR_JOIN_SAME_CHANNEL_TOO_OFTEN](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_join_channel_error.html#a2040b572e1ef4f593f234a20c84a22c7)：加入相同频道的频率超过每 5 秒 2 次的上限。

**废弃方法**

- [sendMessageToPeer](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a25ab5c0126e1dc51c78b2b705de68b7a)：被重载方法 [sendMessageToPeer(const char \*, const IMessage \*, const SendMessageOptions \&)](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9) 替代。

**废弃错误码**

- [ATTRIBUTE_OPERATION_ERR_NOT_READY](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_attribute_operation_error.html#ac6a33aef7c62a132ba79630219d548a7)：被错误码 [ATTRIBUTE_OPERATION_ERR_USER_NOT_LOGGED_IN](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_attribute_operation_error.html#a9f329760056976289e49ad1dc69c598f) 替代。




## 1.0.1 版

该版本于 2019 年 8 月 1 日发布。

#### 问题修复

- 断网后 SDK 未返回 `onConnectionStateChanged` 回调。

## 1.0.0 版

该版本于 2019 年 7 月 24 日发布。

#### 新增功能

**新老互通**

支持与 Agora Signaling SDK 互通。

本版本在 `LocalInvitation` 类中实现了 `setChannelId` 和 `getChannelId` 方法。

> - 如需与 Agora Signaling SDK 互通，则必须调用 `setChannelId` 方法设置频道 ID。不过即使被叫成功接受呼叫邀请，Agora RTM SDK 也不会将主叫或被叫加入指定频道。
> - 如果你的应用不涉及 Agora Signaling SDK，我们推荐使用 `LocalInvitation.setContent` 或者 `RemoteInvitation.setResponse` 方法设置自定义内容。

**设置日志文件地址**

支持通过调用 `setLogFile` 方法变更本地日志的默认地址。该方法无需在 `login` 成功之后调用，我们建议在创建 `RtmClient` 后即调用该方法，否则会造成日志文件显示不完整。

**设置日志输出等级**

支持通过调用 `setLogFilter` 方法将日志内容按照 OFF、CRITICAL、ERROR、WARNING 和 INFO 不同等级输出 。

> 该方法无需在 `login` 成功之后调用。

**设置日志文件大小**

支持通过 `setLogFileSize` 方法设置日志文件大小。日志的默认大小为 512 KB。低于该默认大小的设置无效。

> 该方法无需在 `login` 成功之后调用。

#### 功能改进

针对以下不同错误情况细化了错误代码

- Agora RTM 服务未初始化
- 调用频率超过上限
- 未调用 `login` 方法或 `login` 方法未调用成功

#### 问题修复

- 修复了一个可以用静态 App ID 和一个通过动态 App ID 生成的 Token 登录Agora RTM 系统的问题。


#### API 变更

- [setLogFile](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ad44bd79d005d25c68712cc35d16d934b)：设定日志文件的默认地址。
- [setLogFilter](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a6726b3a3eafee4528280d3b0d1c6316f)：设置日志输出等级。
- [setLogFileSize](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a85a6365227adc43f8c3e07042dec6723)：设置日志文件大小。
- [getSdkVersion](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#af3cc54b4d456a67d912786f61619c065)：获取 Agora RTM SDK 的版本信息。




## 0.9.3 版

该版本于 2019 年 6 月 7 日发布。

#### 新增功能

**发送（离线）点对点消息**

本版本支持发送离线消息。在开通离线消息后，用户不必等到接收端上线才能发送点对点消息。如果对端离线，消息服务器会为每个接收端存储 200 条离线消息长达七天。消息以队列形式存储。当离线消息超限时，最新存储的消息会导致最老的消息丢失。当发送端设置了离线消息，而此时消息接收端不在线，发送端会收到错误码：[PEER_MESSAGE_ERR_CACHED_BY_SERVER](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_peer_message_error.html#a723c2bc0bb1d4b045edc4044f026e30c)

> 该方法的调用频率限制为每秒 60 条（点对点消息和频道消息一并计算在内）。

**设置本地用户属性、查询指定用户属性**

本版本支持设置和查询用户属性。每个用户属性为 key 和 value 的键值对。每个属性的 key 为 32 字节可见字符，每个属性的 value 的字符串长度不得超过 8 KB。单个用户的全部属性长度不得超过 16 KB。以下为本版本支持内容：

   - 全量设置本地用户属性
   - 增加或更新本地用户属性
   - 删除本地用户指定属性
   - 清空本地用户属性
   - 全量获取指定用户属性
   - 获取指定用户指定属性。


> - 用户属性的相关操作必须在登录 Agora RTM 系统成功后才能进行，否则 SDK 会返回错误码：`ATTRIBUTE_OPERATION_ERR_NOT_READY`
> - 设置的用户属性会在用户登出 Agora RTM 系统后自动失效。
> - 单次用户属性设置操作不得超过 16 KB，否则 SDK 会返回错误码：`ATTRIBUTE_OPERATION_ERR_SIZE_OVERFLOW` 。
> - 用户属性设置相关操作的调用频率限制为每 5 秒 10 条，超限则 SDK 会返回错误码：`ATTRIBUTE_OPERATION_ERR_TOO_OFTEN`。
> - 获取用户属性相关操作的调用频率为每 5 秒 40 条，超限则 SDK 会返回错误码：`ATTRIBUTE_OPERATION_ERR_TOO_OFTEN` 。

#### API 变更

**新增**

- [sendMessageToPeer()](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9):  发送（离线）点对点消息给指定用户。
- [getServerReceivedTs()](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_message.html#a7994de6da26269c3137e93ddf7a2c2be)： 消息接收者查询服务器的接收消息时间。
- [isOfflineMessage()](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_message.html#a463b5df7c54bf45dc39aa42457e4b5bd)：消息接收者查询消息是否为离线消息。
- [PEER_MESSAGE_ERR_CACHED_BY_SERVER](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_peer_message_error.html#a723c2bc0bb1d4b045edc4044f026e30c)：对端用户不在线，离线消息会被消息服务器存储。
- [setLocalUserAttributes()](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a339b7b2371ff2b86137b6db6c1c66294)：全量设置本地用户属性
- [addOrUpdateLocalUserAttributes()](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a765b186d62ed3ef6d67a5e875b040875)：增加本地用户属性或更新本地用户属性
- [deleteLocalUserAttributesByKeys()](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a2477533989c1bb9ced831af210f1dba4)：删除本地用户指定属性
- [clearLocalUserAttributes()](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ae0c6c5c5bae6020e69009441d8a41785)：清空本地用户全部属性
- [getUserAttributes()](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#aee9a6c027f35b652781f654a89433755)：获取指定用户的全部属性
- [getUserAttributesByKeys()](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a3b927c35cca5ebd31afb976d60e99193): 获取指定用户的指定属性
- [	AttributeOperationError](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_attribute_operation_error.html)：属性操作相关错误码

#### 性能改进

- 支持在登录 Agora RTM 系统之前创建频道实例。
- 取消创建 RTM 频道最多 20 个的限制，但是同一用户只能同时加入 20 个频道，超限后会收到错误码 `JOIN_CHANNEL_ERR_FAILURE ` 。


#### 问题修复

- 偶现的系统崩溃。
- 用户登出后，其它用户查询该用户仍然显示在线，30 秒后查询不在线。

## 0.9.2 版

该版本于 2019 年 5 月 8 日发布。

> 当前版本不支持在 [登录](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a995bb1b1bbfc169ee4248bd37e67b24a) RTM 系统前 [创建频道实例](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a95ebbd1a1d902572b444fef7853f335a) 。

#### 新增功能

**查询用户在线状态**

本版本引入了新的概念：在线和离线。一般情况下：

- 在线：用户已登录到 Agora RTM 系统。
- 离线：用户已登出 Agora RTM 系统或因其他原因，比如权限或网络原因，与 Agora RTM 系统断开连接。

本版本增加了查询用户在线状态功能。你可以在登录 Agora RTM 系统后查询最多 256 个指定用户的在线状态。详见： [queryPeersOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ac711f981405648ed5ef1cb07436125f3) 接口。

> - 返回的 Map 的 Use ID 的顺序以输入顺序为准。
> - 返回的 Map 中与每个 User ID 对应的 BOOLEAN 值表示用户在线与否。
> - 该方法的调用频率限制为每 5 秒 10 次。详见 [限制条件](/cn/Real-time-Messaging/limitations_android?platform=Android) 。


**更新 Token**

在安全性要求较高的情况下，你需要输入 Token [登录](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a995bb1b1bbfc169ee4248bd37e67b24a) Agora RTM 系统。 每个 Token 都会在生成 24 小时后过期，本版本提供了 [更新 Token](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a9a6d33282509384165709107d7a89353) 的功能。

- 在登录 Agora RTM 系统时，如果你的 Token 已过期，SDK 会返回 [LOGIN_ERR_TOKEN_EXPIRED](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_login_error.html#a4a15940de40fe029ba9821e406f3d875) 错误码
- 在已登录 Agora RTM 系统的情况下，Token 过期不会导致用户立即被踢出，但当用户重新登录 Agora RTM 系统时需要调用。所以，我们建议你在收到 [onTokenExpired](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#aef74f37ed8797d274115d7f13785134e) 回调后尽快更新 Token。


> - [renewToken](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a9a6d33282509384165709107d7a89353) 方法必须在 [创建 RtmClient 实例](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a6411640143c4d0d0cd9481937b754dbf) 后才能调用。
> - Agora RTM Token 的生成方式、输入参数与 Agora 媒体 SDK 不同，详情请见： [校验用户权限](/cn/Real-time-Messaging/RTM_token?platform=All%20Platforms) 。
> - `RenewToken` 方法的调用频率限制为 2 次 / 秒。详见 [限制条件](/cn/Real-time-Messaging/limitations_android?platform=Android) 。

#### 性能改进

- 支持以空格开头的 `userId` 参数。


#### API 变更

**查询用户在线状态相关**

**新增**

- 方法： [queryPeersOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ac711f981405648ed5ef1cb07436125f3)
- 错误码：[QueryPeersOnlineStatusError](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_query_peers_online_status_error.html)

**更新 Token 相关**

**新增**

- 方法： [renewToken](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a9a6d33282509384165709107d7a89353)
- 回调： [onTokenExpired](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#aef74f37ed8797d274115d7f13785134e)
- 错误码： [RenewTokenError](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_renew_token_error.html)

**呼叫邀请相关**

新增以下错误码覆盖用户在没有登录 Agora RTM 系统的情况下发送呼叫邀请的错误情况：

- [LOCAL_INVITATION_ERR_NOT_LOGGEDIN](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_local_invitation_error.html#aa717afb5d4809544e6d66e1c0538f2eb)


## 0.9.1 版

该版本于 2019 年 4 月 4 日发布。

> 本版本不包含 `setLogFile` 和 `setLogFilter` 方法。所有的日志信息默认保存在 #### /sdcard/\<AppName\>/agorartm.log####  。

#### 新增功能

本版本增加了呼叫邀请功能。结合音视频一对一或一对多通话场景，你可以创建、发送、取消、接受或拒绝一个呼叫邀请。

#### 性能改进

- 优化了对象关系帮助开发者快速搭建应用。
- 重命名部分接口以遵循 Java 命名规范。
- 删除状态 `ChannelMessageState` 和 `PeerMessageState` 以简化发送频道消息和点对点消息流程。以错误码 `ChannelMessageError` 和 `PeerMessageError` 代替。
- 删除用于监听消息状态的 `IStateListener` 类。改用 `ResultCallback` 类返回成功和错误回调。

#### API 变更

**新增**

- [LocalInvitation.setContent()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_local_invitation.html#a4cec28ff6d356242329b1034c7531445): 用于主叫设置发出的呼叫邀请内容。
- [LocalInvitation.getContent()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_local_invitation.html#a97294ce1b9b591f9d93e497869b1ad90): 用于主叫获取发出的呼叫邀请内容。 
- [LocalInvitation.getResponse()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_local_invitation.html#a268c738458538a266d440b0e281328ee): 用于主叫获取被叫对发出呼叫邀请的响应内容。
- [LocalInvitation.getState()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_local_invitation.html#a59608fbac8050f17ec0f855f28598d20): 用于主叫获取发出的呼叫邀请的状态。 
- [RemoteInvitation.getCallerId()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_remote_invitation.html#ae38c5740aa9edb09749f0febb2663926): 用于被叫获取主叫的用户 ID。
- [RemoteInvitation.getContent()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_remote_invitation.html#aeca3b3e981c69c44c7a618d4fdfb3b87): 用于被叫获取主叫设置的呼叫邀请内容。
- [RemoteInvitation.setResponse()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_remote_invitation.html#a229b8cf773eaa0e79b0d67815fd6b6f1): 用于被叫设置呼叫邀请响应。 
- [RemoteInvitation.getResponse()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_remote_invitation.html#a12a70e7d8a77eee21d37bbb65b2f9d3e): 用于被叫获取设置的呼叫邀请响应。
- [RemoteInvitation.getState()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_remote_invitation.html#af77a4afabb19ff1468edf29720361a0f): 用于被叫获取收到的呼叫邀请的状态。
- [RtmCallEventListener.onLocalInvitationReceivedByPeer()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a24e1cb71d3e752963da49bdf91847788): 被叫收到呼叫邀请回调。 
- [RtmCallEventListener.onLocalInvitationAccepted()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a4dece02a62a187a66c2415fecf6b75dc): 被叫已接受呼叫邀请回调。 
- [RtmCallEventListener.onLocalInvitationRefused()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a6224643c400268d356cb5d489825bdd0): 被叫已拒绝呼叫邀请回调。 
- [RtmCallEventListener.onLocalInvitationCanceled()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#ae3164e81772cd4d6171165b1705adcaa): 呼叫邀请已取消回调。 
- [RtmCallEventListener.onLocalInvitationFailure()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#acfefb97eaca497cbd71a0c1cbf5067b0): 发出的呼叫邀请进程失败回调。 
- [RtmCallEventListener.onRemoteInvitationReceived()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a8d01498a993c4016aa45ccb9bf4e9097): 收到呼叫邀请回调。 
- [RtmCallEventListener.onRemoteInvitationAccepted()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a81d9d3de89d08c41408d8a94c8309d29): 已接受呼叫邀请回调。 
- [RtmCallEventListener.onRemoteInvitationRefused()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a7a21eaa9ff49bcf39e3c49b94f6e6ac7): 已拒绝呼叫邀请回调。 
- [RtmCallEventListener.onRemoteInvitationCanceled()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a9d0409c87455d4d2b1315f67a5f7aa12): 主叫已取消呼叫邀请回调。 
- [RtmCallEventListener.onRemoteInvitationFailure()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a6f9f2bbbfbcb0a766c6f1b2e4a8314a1): 发给被叫的呼叫邀请进程失败回调。 
- [RtmCallManager.setEventListener()](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#a934eee4922584707a1a7ef9ac6999cf2): 设置 `RtmCallManager` 实例的事件监听。
- [RtmCallManager.createLocalInvitation()](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#a1756dca077267acaa407c6901daa2248): 创建呼叫邀请。 
- [RtmCallManager.sendLocalInvitation()](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#af899697061305ca840e829b92c78e353): 向指定用户发送呼叫邀请。 
- [RtmCallManager.acceptRemoteInvitation()](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#a5f6f97c84e426e2fbd8a5dda71e2fc6c): 用于被叫接受呼叫邀请。 
- [RtmCallManager.refuseRemoteInvitation()](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#a2ce4af944183976d18c055816f756bf6): 用于被叫拒绝呼叫邀请。 
- [RtmCallManager.cancelLocalInvitation()](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#a5f03bfe1cfd6987fbc7b5a4dc484f564): 用于主叫取消呼叫邀请。 
- [RtmStatusCode#LocalInvitationState](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_local_invitation_state.html): 返回给主叫的呼叫邀请状态码。
- [RtmStatusCode#RemoteInvitationState](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_remote_invitation_state.html): 返回给被叫的呼叫邀请状态码。 
- [RtmStatusCode#LocalInvitationError](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_local_invitation_error.html): 返回给主叫的呼叫邀请错误码。 
- [RtmStatusCode#RemoteInvitationError](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_remote_invitation_error.html): 返回给主叫的呼叫邀请错误码。 
- [RtmStatusCode#InvitationApiCallError](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_invitation_api_call_error.html): 呼叫邀请相关 API 方法调用的错误码。 
- [ConnectionChangeReason#CONNECTION_CHANGE_REASON_REMOTE_LOGIN](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_connection_change_reason.html): 另一个实例已用相同的用户 ID 登录 Agora RTM 系统。

**重命名**

- 将用于释放 `RtmClient` 实例的所有资源的 `RtmClient.destroy()` 方法更名为 [RtmClient.release()](/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a5147d00d14afeebf0926b0d2f01079f5) 。
- 将 `IResultCallback` 类更名为 [ResultCallback](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_result_callback.html) 类。

**删除**

- 从 [PeerMessageError](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_peer_message_error.html) 删除 `PEER_MESSAGE_RECEIVED_BY_SERVER` ，改用错误码  `PEER_MESSAGE_ERR_OK` 。
- 从 [ChannelMessageError](/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_channel_message_error.html) 删除 `CHANNEL_MESSAGE_RECEIVED_BY_SERVER`  ，改用错误码 `CHANNEL_MESSAGE_OK` 。
- 删除 `PeerMessageState` 接口，改用 [PeerMessageError](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_peer_message_error.html) 。
- 删除 `ChannelMessageState` 接口，改用 [ChannelMessageError](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_channel_message_error.html) 返回频道消息错误码。
- 删除用于监听消息状态的 `IStateListener` 类，改用 [ResultCallback](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_result_callback.html) 类监听点对点消息和频道消息结果。
  - 成功：SDK 返回 [ResultCallback.onSuccess()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_result_callback.html#a7206b30500655c4a73d146acf50cb6f5) 回调。
  - 失败：SDK 返回 [ResultCallback.onFailure()](/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_result_callback.html#a1f9145a3eb119e32cfc0afa938062396) 回调以及相应的错误码

## 0.9.0 版

该版本于 2019 年 2 月 4 日发布。

首次发布。

关键功能

- 发送或接收点对点消息。
- 加入或离开频道。
- 发送或接收频道消息。