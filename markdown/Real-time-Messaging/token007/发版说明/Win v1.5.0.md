## 1.5.0 版

该版本于 2022 年 7 月 14 日发布。

#### 升级必看

**AccessToken2**

自该版本起，RTM 升级 Token 鉴权机制，用户可以根据业务需求指定 Token 有效期 (最长为 24 小时)。此外，新增 `onTokenPrivilegeWillExpire` 回调，在 Token 临 30 秒过期时触发，提醒用户当前 Token 即将超出签发有效期，需尽快更新；否则，SDK 将因 Token 过期 (`CONNECTION_CHANGE_REASON_TOKEN_EXPIRED = 9`) 断线重连。 

- 如果你首次接触该产品，Agora 建议你使用最新版的 RTM SDK 并参照 [Token 鉴权](./token_server_rtm) 为 AccessToken2 部署服务器和客户端；
- 如果你已在先前版本中部署过 AccessToken 鉴权，可以参照 [升级至 AccessToken2](./token_server_rtm#upgrade) 快速完成升级。

#### 功能下架

[富媒体传输](./upload_download_media_cpp)、[历史消息](./rtm_get_event) 和 [离线消息](./messaging_restful#history) 功能于该版本正式下线。旧版本 SDK 会继续支持，已集成这些功能的用户不受影响。

#### API 变更

**新增**  
- `onTokenPrivilegeWillExpire`
- `CONNECTION_CHANGE_REASON` 中新增 `CONNECTION_CHANGE_REASON_TOKEN_EXPIRED (9)`

**废弃**  
- `createFileMessageByMediaId`
- `createFileMessageByUploading`
- `createImageMessageByMediaId`
- `createImageMessageByUploading`
- `cancelMediaUpload`
- `cancelMediaDownload`
- `downloadMediaToMemory`
- `downloadMediaToFile`
- `enableOfflineMessaging`
- `enableHistoricalMessaging`
- `onFileMessageReceived`
- `onFileMessageReceivedFromPeer`
- `onImageMessageReceived`
- `onImageMessageReceivedFromPeer`
- `onMediaUploadingProgress`
- `onMediaDownloadingProgress`

## 1.4.10 版
该版本于  2022 年 03 月 01 日发布。

#### 问题修复

修复了一些富媒体相关的崩溃问题。

## 1.4.9 版

该版本于 2021 年 11 月 26 日发布。

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

#### 改进及问题修复
- 优化了弱网对抗能力，提高了弱网环境下的登录成功率和消息投递成功率。
- 修复了一些崩溃问题。

## 1.4.3 版

该版本于 2021 年 2 月 10 日发布。

#### 问题修复

该版本修复了以下问题：

- 偶现的多线程访问冲突造成崩溃的问题。
- Agora RTM SDK 登录超时率较高的问题。

## 1.4.2 版

该版本于 2020 年 11 月 23 日发布。

#### 改进

- 优化了登录和消息发送的性能。
- 为 `RTM_AREA_CODE` 枚举定义了 `AGORA_SDK_BOTH_RTM_AND_RTC` 宏，可以用来解决 RTC 与 RTM 共同使用时命名冲突的问题。

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

[`setRtmServiceContext`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.4.0/group__get_rtm_sdk_version.html#ga55ed2d637b72bf2940872b8736a00bd3)

## 1.3.0 版

该版本于 2020 年 5 月 11 日发布。

#### 升级必看

- 防火墙白名单的 TCP 协议需要新增 9140 端口，用于发送和接收图片及文件消息。详见[应用企业防火墙限制](https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms)。
- 服务器端会屏蔽向 1.2.2 或更早版本的实时消息 SDK、信令 SDK 发送的图片或文件消息。

#### 新增功能

**1. 发送和接收文件消息** 

v1.3.0 支持上传和下载大小不超过 30 MB 的任意格式的非空文件，支持随时取消正在进行中的上传或下载任务。每个上传到 Agora 服务器的文件都对应一个 media ID，在服务端保存 7 天。你可以通过 media ID 在 7 天有效期内从 Agora 服务器下载对应的文件。

<div class="alert note">你只能通过 SDK 提供的下载方法下载文件。</div>

v1.3.0 引入了 `IFileMessage` 消息类用于保存和传递系统生成的 media ID。`IFileMessage` 继承自 `IMessage` 类，所以你可以通过点对点消息或频道消息发送方法传递 `IFileMessage` 实例。你可以通过 `IFileMessage` 对象进行以下操作:

- 设置相应的上传文件的显示文件名和显示缩略图。
- 获取相应的上传文件的大小。
  
<div class="alert note">消息内容、显示文件名和显示缩略图的总大小不得超过 32 KB。</div>

**2. 发送和接收图片消息**

v1.3.0 支持上传和下载大小不超过 30 MB 的任意格式的非空图片，支持随时取消正在进行中的上传或下载任务。每个上传到 Agora 服务器的图片都对应一个 media ID，在服务端保存 7 天。你可以通过 media ID 在 7 天有效期内从 Agora 服务器下载对应的图片。

v1.3.0 引入了 `IImageMessage` 消息类用于保存和传递系统生成的 media ID。`IImageMessage` 继承自 `IMessage` 类，所以你可以通过点对点消息或频道消息发送方法传递 `IImageMessage` 实例。你可以通过 `IImageMessage` 对象进行以下操作:

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

- [`createFileMessageByUploading`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a99f2137ec43be135b369b7d6927b6138)
- [`createImageMessageByUploading`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a7192d93f365c28e2d0b91547716fb5a9)
- [`cancelMediaUpload`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a0090bbb72e250ffbaedc84d9041b64b1)
- [`cancelMediaDownload`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#adc34b7acad8b845fe1242efd127d82b9)
- [`createFileMessageByMediaId`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a6e4b13011388ec45e8a02377b240506f)
- [`createImageMessageByMediaId`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a97bfb847ff876ab216cf219f4b4f856d)
- [`downloadMediaToMemory`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ade134da2be907a8078ce693849e0cc37)
- [`downloadMediaToFile`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a70584eb57e97476b1da072f737d88c95)


**新增回调** 

- [`onMediaUploadingProgress`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a56d5464c3b5e53c44039190a3ac4dfe9)
- [`onMediaDownloadingProgress`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a9c4dfbb224f69b73f64dc1bf34f28567)
- [`onMediaCancelResult`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a64cac4d387e2bf6a419bb478358570f6)
- [`onFileMediaUploadResult`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#aadaa8cd5309e4e70ab2cbdfc1ef21241)
- [`onImageMediaUploadResult`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#abaeeaeb6d69b98510d6c3b012849251e)
- [`onFileMessageReceivedFromPeer`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a4642bb3a8ddf026617fff47d1c9f3e3a)
- [`onImageMessageReceivedFromPeer`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a2682e64be745cf7af816a12f9895ce07)
- [`onFileMessageReceived`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a416dd103c84387a5147e962398eff8d1)
- [`onImageMessageReceived`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a6d710170df9b3c1f0ef092012af2e317)
- [`onMediaDownloadToMemoryResult`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#ad0de249a8f0b79973f34f295cabe4904)
- [`onMediaDownloadToFileResult`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a0b6edc7b944eab02d545bb2d2d1bfe2f)

**废弃方法** 

[`sendMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a4ae01f44d49f334f7c2950d95f327d30) 被重载方法 [`sendMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a056dfe9e83c168c3c94e47a017a6ec3f) 替代。

## 1.2.2 版

$$ 804cbf10-1b48-11ea-8fc3-cf882a952d6b
{
  "platform": "Windows C++"
}
$$

## 1.2.1 版

$$ fe7e5f60-20ac-11ea-b338-f1556ea7fcbf
{
  "platform": "Windows C++"
}
$$

## 1.2.0 版


$$ 14111db0-0157-11ea-9dc6-3d0c88cf24b7
{
  "queryPeersOnlineStatus": "[queryPeersOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3add0055c4455dc8d04bfc37edfd8e94)",
  "onQueryPeersOnlineStatusResult": "[onQueryPeersOnlineStatusResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a782b4623d4dcbac5c99fd6a12c42f578)",
  "PeerOnlineStatus": "[PeerOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/structagora_1_1rtm_1_1_peer_online_status.html)",
  "isOnline": "[isOnline](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/structagora_1_1rtm_1_1_peer_online_status.html#a27f653585385efc3e1a4265948d11c1c)",
  "PEER_ONLINE_STATE": "[PEER_ONLINE_STATE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a16966e9a602270d2bbdd9510602ecc5f)",
  "subscribePeersOnlineStatus": "[subscribePeersOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3a0e2d4d79ac85e23eae0dcb114ba9f0)",
  "onPeersOnlineStatusChanged": "[onPeersOnlineStatusChanged](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a1eb57be5d0cdc9e4533852794e2e47ca)",
  "onSubscriptionRequestResult": "[onSubscriptionRequestResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#af44e58f8368ceb7ad883b94fd4643cc4)",
  "PEER_SUBSCRIPTION_OPTION": "[PEER_SUBSCRIPTION_OPTION](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a2afe690e9fe0e0af4a0f5fd8b6c8eef9)",
  "createRawMessage1": "[createMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ab246e4151cf9fc42c32c13489f49c1ea)",
  "createRawMessage2": "[createMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ae74ba0d307da66176fe58d554d6676ab)",
  "IMessage": "[IMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html)",
  "setText": "[setText](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html#a2e93098d5a3819e9d4cf8d42641474ae)",
  "createTextMessage1": "[createMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#acbbfe84bc22fd161ec5dc4fe098a59ce)",
  "createTextMessage2": "[createMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#aa4b2cd37eb8eb1b2b1ba217830c6317f)",
  "unsubscribePeersOnlineStatus": "[unsubscribePeersOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a027574f04151a9fded678fadba47441e)",
  "queryPeersBySubscriptionOption": "[queryPeersBySubscriptionOption](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a063bd3db39660a7a3513378ce03f4456)",
  "onQueryPeersBySubscriptionOptionResult": "[onQueryPeersBySubscriptionOptionResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#abfa6692f88f55017f3cfbec3ca98ffdf)",
  "PEER_SUBSCRIPTION_STATUS_ERR": "[PEER_SUBSCRIPTION_STATUS_ERR](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a4fa6b08d01154d48966cfcb37acf08be)",
  "QUERY_PEERS_BY_SUBSCRIPTION_OPTION_ERR": "[QUERY_PEERS_BY_SUBSCRIPTION_OPTION_ERR](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a5ecaf0f0a7ac45ea78198f52393bf607)",
  "onlineState": "[onlineState](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/structagora_1_1rtm_1_1_peer_online_status.html#a240a2611b6e8e45413679e3ec4f59023)"
}
$$

## 1.1.0 版

该版本于 2019 年 9 月 30 日初次发布。新增以下功能：

#### 新老互通

支持与 Agora Signaling SDK 互通。

本版本在 `ILocalCallInvitation` 类中实现了 `setChannelId` 和 `getChannelId` 方法。

> - 如需与 Agora Signaling SDK 互通，则必须调用 `setChannelId` 方法设置频道 ID。不过即使被叫成功接受呼叫邀请，Agora RTM SDK 也不会将主叫或被叫加入指定频道。
> - 如果你的应用不涉及 Agora Signaling SDK，我们推荐使用 `ILocalCallInvitation::setContent` 或者 `IRemoteCallInvitation::setResponse` 方法设置自定义内容。


#### 发送（离线）点对点消息

本版本支持发送离线消息。在开通离线消息后，用户不必等到接收端上线才能发送点对点消息。如果对端离线，消息服务器会为每个接收端存储 200 条离线消息长达七天。消息以队列形式存储。当离线消息超限时，最新存储的消息会导致最老的消息丢失。当发送端设置了离线消息，而此时消息接收端不在线，发送端会收到错误码：[PEER_MESSAGE_ERR_CACHED_BY_SERVER](/cn/Video/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#ac7c591aac4ca6867e239c8bcccc1fc5caeccb9896a862a86fa1965705e2d394fd)

<a name="getcount"></a>
#### 查询频道成员人数

支持在不加入频道的情况下通过主动调用 [getChannelMemberCount](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a41dee47c6201acb2f29371b6e30249a5) 接口查询单个或多个频道的频道人数。一次最多可查询 32 个频道的成员人数。

#### 查询用户在线状态

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

#### 呼叫邀请

增加了呼叫邀请功能。结合音视频一对一或一对多通话场景，你可以创建、发送、取消、接受或拒绝一个呼叫邀请。

#### 加入或离开频道

#### 发送或接收频道消息



<a name="oncount"></a>
#### 频道成员人数自动更新

如果你已经加入某频道，你无需调用 `getChannelMemberCount` 接口查询当前频道人数。我们也不建议你通过监听 `onMemberJoined` 和 `onMemberLeft` 统计频道成员人数。从本版本开始，SDK 会在频道成员人数发生变化时通过 [onMemberCountUpdated](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#aff85052bb2a46c3220789c1ef90aa01e) 回调接口通知频道成员并返回当前频道成员人数：

- 频道成员人数小于等于 512 时，最高触发频率为每秒 1 次。
- 频道成员人数超过 512 时，最高触发频率为每 3 秒 1 次。



#### 更新 Token

#### 设置日志文件地址

支持通过调用 `setLogFile` 方法变更本地日志的默认地址。该方法无需在 `login` 成功之后调用，我们建议在初始化 Agora RTM 服务后即调用该方法，否则会造成日志文件显示不完整。

#### 设置日志输出等级

支持通过调用 `setLogFilter` 方法将日志内容按照 OFF、CRITICAL、ERROR、WARNING 和 INFO 不同等级输出。详见 [LOG_FILTER_TYPE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#af515252477afb2a71feef88113dfa481) 。

> 该方法无需在 `login` 成功之后调用。

#### 设置日志文件大小

支持通过 `setLogFileSize` 方法设置日志文件大小。日志的默认大小为 512 KB。低于该默认大小的设置无效。

> 该方法无需在 `login` 成功之后调用。


> 该方法的调用频率限制为每秒 60 条（点对点消息和频道消息一并计算在内）。