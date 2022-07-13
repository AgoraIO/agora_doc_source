## 1.5.0 版

该版本于 2022 年 7 月 14 日发布。

#### 升级必看

**AccessToken2**

自该版本起，RTM 升级 Token 鉴权机制，用户可以根据业务需求指定 Token 有效期 (最长为 24 小时)。此外，新增 `onTokenPrivilegeWillExpire` 回调，在 Token 临 30 秒过期时触发，提醒用户当前 Token 即将超出签发有效期，需尽快更新；否则，SDK 将因 Token 过期 (`CONNECTION_CHANGE_REASON_TOKEN_EXPIRED (9)`) 断线重连。 

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

#### 升级必看

- 对于 CentOS 系统，1.4.2 版不支持 7 或更早版本。如果你的 CentOS 版本是 7 或更早版本，Agora 建议你使用 1.4.1 版。
- `setLogFileSize` 日志文件的大小默认值从 10 MB 增加到 100 MB。

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
- Agora RTM Linux C++ SDK 提高了以下操作的调用频率限制。详见[限制条件](/cn/Real-time-Messaging/limitations_java?platform=Linux%20CPP)。

| 操作                 | 调用频率变化                          |
| :------------------- | :------------------------------------ |
| 点对点或频道消息发送 | 由每 3 秒 300 次增加到每 3 秒 1500 次 |
| 用户在线状态查询     | 由每 5 秒 20 次增加到每 5 秒 100 次   |
| 用户属性增删修改     | 由每 5 秒 20 次增加到每 5 秒 100 次   |
| 用户属性查询         | 由每 5 秒 80 次增加到每 5 秒 400 次   |
| 频道属性增删修改     | 由每 5 秒 20 次增加到每 5 秒 100 次   |
| 频道属性查询         | 由每 5 秒 80 次增加到每 5 秒 400 次   |

- 优化了重连机制。

#### API 变更

**新增方法**

[`setRtmServiceContext`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/v1.4.0/group__get_rtm_sdk_version.html#ga55ed2d637b72bf2940872b8736a00bd3)

## 1.3.0 版

该版本于 2020 年 6 月 12 日发布。

#### 升级必看

- 防火墙白名单的 TCP 协议需要新增 9140 端口，用于发送和接收图片及文件消息。详见[应用企业防火墙限制](https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms)。
- 服务器端会屏蔽向 1.2.2 或更早版本的实时消息 SDK、信令 SDK 发送的图片或文件消息。

#### 新增特性

**1. 发送和接收文件或图片消息**

你可以通过 `createFileMessageByUploading` 方法或 `createImageMessageByUploading` 方法上传不超过 30 MB 的非空文件或图片。每个上传成功的文件或图片会在 Agora 服务器保存七天，SDK 会返回一个 media ID 作为此文件或图片的唯一标识。你可以使用 `IFileMessage` 类或 `IImageMessage` 类保存 SDK 返回的 media ID。`IFileMessage` 和 `IImageMessage` 继承自 `IMessage` 类，所以你可以通过点对点消息或频道消息发送和接收文件消息或图片消息。你可以使用 `downloadMediaToMemory` 或 `downloadMediaToFile` 方法下载接收到的文件或图片。

**2. 管理上传或下载任务**

你可以通过 `cancelMediaUpload` 方法或 `cancelMediaDownload` 方法取消上传或下载任务，通过 `onMediaUploadingProgress` 回调或 `onMediaDownloadingProgress` 回调报告上传或下载的进度。

#### 改进

Agora RTM Linux C++ SDK 提高了以下操作的调用频率限制。详见[限制条件](/cn/Real-time-Messaging/limitations_cpp_linux?platform=Linux%20CPP)。

| 操作                | 调用频率变化                         |
| :------------------ | :----------------------------------- |
| 点对点/频道消息发送 | 由每 3 秒 180 次增加到每 3 秒 300 次 |
| 用户在线状态查询    | 由每 5 秒 10 次增加到每 5 秒 20 次   |
| 用户属性增删修改    | 由每 5 秒 10 次增加到每 5 秒 20 次   |
| 用户属性查询        | 由每 5 秒 40 次增加到每 5 秒 80 次   |
| 频道属性增删修改    | 由每 5 秒 10 次增加到每 5 秒 20 次   |
| 频道属性查询        | 由每 5 秒 10 次增加到每 5 秒 80 次   |

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
  "platform": "Linux C++"
}
$$

## 1.2.1 版

$$ fe7e5f60-20ac-11ea-b338-f1556ea7fcbf
{
  "platform": "Linux C++"
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

该版本于 2019 年 10 月 14 日发布。新增如下功能：

- [查询频道成员人数](#getcount)
- [频道成员人数自动更新](#oncount)
- [频道属性增删改查](#channelattributes)



#### 兼容性改动

1. 废弃点对点消息发送方法 [sendMessageToPeer](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#afec5391fa9c4ec2bfe9ac4e684705600)，改由重载方法 [sendMessageToPeer(const char \*, const IMessage \*, const SendMessageOptions \&)](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a08c1b3d444af5a2778ede48e4c677a52) 替代。
2. [IMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html) 对象的 [getServerReceivedTs](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html#ac7427e3a49bd44e53b2809e0b39511b6) 方法由仅支持点对点消息改为同时支持点对点消息和频道消息。
3. 点对点消息的超时时间由 5 秒延长为 10 秒。详见： [PEER_MESSAGE_ERR_SENT_TIMEOUT ](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#ac7c591aac4ca6867e239c8bcccc1fc5ca231d49ed8da45aa4be794cfe927703dc)
4. 针对 [joinChannel](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a6a54cdd8e5db526514e0ca84aa9cba4c) 方法调用增加了[加入相同频道的频率限制：每 5 秒 2 次](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#adeb91ade364eddd742d8f3ad59c6638ea02250c14972ba934c148fc3d558baa6f)。

#### 新增功能

<a name="getcount"></a>
**1. 查询频道成员人数**

支持在不加入频道的情况下通过主动调用 [getChannelMemberCount](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a41dee47c6201acb2f29371b6e30249a5) 接口查询单个或多个频道的频道人数。一次最多可查询 32 个频道的成员人数。

<a name="oncount"></a>
**2. 频道成员人数自动更新**

如果你已经加入某频道，你无需调用 `getChannelMemberCount` 接口查询当前频道人数。我们也不建议你通过监听 `onMemberJoined` 和 `onMemberLeft` 统计频道成员人数。从本版本开始，SDK 会在频道成员人数发生变化时通过 [onMemberCountUpdated](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#aff85052bb2a46c3220789c1ef90aa01e) 回调接口通知频道成员并返回当前频道成员人数：

- 频道成员人数小于等于 512 时，最高触发频率为每秒 1 次。
- 频道成员人数超过 512 时，最高触发频率为每 3 秒 1 次。

> 请将该回调与 [onGetMembers](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a5e3f5a5ae0b3861de2f0310841ad0b37) 回调进行区分：
> - 前者为主动回调。SDK 向频道成员返回当前频道成员人数。
> - 后者由 [getMembers](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a3f9c943059ac48a568c81798da38c3cb) 方法触发，返回频道成员列表，且当频道成员人数超过 512 时仅返回随机的 512 个成员列表。

<a name="channelattributes"></a>
**3. 频道属性增删改查**

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


#### 性能改进

**点对点消息重发**

本版本优化了点对点消息在弱网情况下的重发机制，并延长点对点消息超时时间为 10 秒，提高了在弱网情况下点对点消息的发送成功率。

**频道消息缓存**

Agora RTM 系统会对短期掉线后重连成功的频道成员补发最长 30 秒最多 32 条的频道消息，提高了弱网情况下频道消息的到达率。


#### API 变更

**新增方法**

- [createChannelAttribute](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#af153fe0c639a009bf35bad1da471d2be)：创建并返回一个 [IRtmChannelAttribute](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_channel_attribute.html) 实例。
- [setChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#aa229a7207062b510799166c1239412fa)：全量设置某指定频道的属性。
- [addOrUpdaeChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ae4068ff21c8e20e8eeb45ba21959c368)：添加或更新某指定频道的属性。
- [deleteChannelAttributesByKeys](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a1a448f33be57b31f9952822426e5c4bd)：删除某指定频道的指定属性。
- [clearChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#aff6cff676e3fc3150ef5f27845c9a3d3)：清空某指定频道的属性。
- [getChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3dc8409ed82d8f95a0839d5e9e7da564)：查询某指定频道的全部属性。
- [getChannelAttributesByKeys](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ac97f24f9d78e885e494a22be95db8d33)：查询某指定频道指定属性名的属性。
- [getChannelMemberCount](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a41dee47c6201acb2f29371b6e30249a5)：查询单个或多个频道的成员人数。

**新增回调**

- [onSetChannelAttributesResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a7e9581ecf7998686b96aa25005381492)：返回 [setChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#aa229a7207062b510799166c1239412fa) 方法的调用结果。
- [onAddOrUpdateChannelAttributesResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a24acf67b176597cd13e0d5dc5c3885e7)：返回 [addOrUpdaeChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ae4068ff21c8e20e8eeb45ba21959c368) 方法的调用结果。
- [onDeleteChannelAttributesResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a087caa19e3d4115f040d943e738cc2df)：返回 [deleteChannelAttributesByKeys](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a1a448f33be57b31f9952822426e5c4bd) 方法的调用结果。
- [onClearChannelAttributesResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a10c56b8ac93aedb31348da8f2811228c)：返回 [clearChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#aff6cff676e3fc3150ef5f27845c9a3d3) 方法的调用结果。
- [onGetChannelAttributesResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#ab3f049ec99393efb883e0e589704e613)：返回 [getChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3dc8409ed82d8f95a0839d5e9e7da564) 或 [getChannelAttributesByKeys](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ac97f24f9d78e885e494a22be95db8d33) 方法的调用结果。
- [onAttributesUpdated](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a7a9ae1b89fdf3f69242393955d0fd5c5)：频道属性更新回调。返回所在频道的所有属性。
- [onGetChannelMemberCountResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a881a9953322b09dc17cd0dc98c11eb18)：返回 [getChannelMemberCount](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a41dee47c6201acb2f29371b6e30249a5) 方法的调用结果。
- [onMemberCountUpdated](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#aff85052bb2a46c3220789c1ef90aa01e)：频道成员人数更新回调。返回最新频道成员人数。

**新增错误码**

- [GET_CHANNEL_MEMBER_COUNT_ERR_CODE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#ad2e93c1596f5f929e7d7601a85024dcc)：获取指定频道成员人数的相关错误码。
- [JOIN_CHANNEL_ERR_JOIN_SAME_CHANNEL_TOO_OFTEN](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#adeb91ade364eddd742d8f3ad59c6638ea02250c14972ba934c148fc3d558baa6f)：加入相同频道的频率超过每 5 秒 2 次的上限。

**废弃方法**

- [sendMessageToPeer](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#afec5391fa9c4ec2bfe9ac4e684705600)：被重载方法 [sendMessageToPeer](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a08c1b3d444af5a2778ede48e4c677a52) 替代。

**废弃错误码**

- [ATTRIBUTE_OPERATION_ERR_NOT_READY](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a9413a8cce9bbd88d8d4baade13c2ccceacfd54d25148ff796305ab58ef7317613)：被错误码 [ATTRIBUTE_OPERATION_ERR_USER_NOT_LOGGED_IN](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a9413a8cce9bbd88d8d4baade13c2cccea9469baeab2e6c16b0351c16885f9fd33) 替代。




## 1.0.1 版

该版本于 2019 年 8 月 1 日发布。

#### 问题修复

- 断网后 SDK 未返回 `onConnectionStateChanged` 回调。

## 1.0.0 版

该版本于 2019 年 7 月 24 日发布。

#### 新增功能

**新老互通**

支持与 Agora Signaling SDK 互通。

本版本在 `ILocalCallInvitation` 类中实现了 `setChannelId` 和 `getChannelId` 方法。

> - 如需与 Agora Signaling SDK 互通，则必须调用 `setChannelId` 方法设置频道 ID。不过即使被叫成功接受呼叫邀请，Agora RTM SDK 也不会将主叫或被叫加入指定频道。
> - 如果你的应用不涉及 Agora Signaling SDK，我们推荐使用 `ILocalCallInvitation::setContent` 或者 `IRemoteCallInvitation::setResponse` 方法设置自定义内容。

**设置日志文件地址**

支持通过调用 `setLogFile` 方法变更本地日志的默认地址。该方法无需在 `login` 成功之后调用，我们建议在初始化 Agora RTM 服务后即调用该方法，否则会造成日志文件显示不完整。

**设置日志输出等级**

支持通过调用 `setLogFilter` 方法将日志内容按照 OFF、CRITICAL、ERROR、WARNING 和 INFO 不同等级输出。详见 [LOG_FILTER_TYPE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#af515252477afb2a71feef88113dfa481) 。

> 该方法无需在 `login` 成功之后调用。

**设置日志文件大小**

支持通过 `setLogFileSize` 方法设置日志文件大小。日志的默认大小为 512 KB。低于该默认大小的设置无效。

> 该方法无需在 `login` 成功之后调用。

#### 功能改进

针对以下不同错误情况细化了错误码

- Agora RTM 服务未初始化
- 调用频率超过上限
- 未调用 `login` 方法或 `login` 方法未调用成功

#### 问题修复

- 修复了一个可以用静态 App ID 和一个通过动态 App ID 生成的 Token 登录Agora RTM 系统的问题。


#### API 变更

- [setLogFile](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a08063b2692a6091ad5e8b30146498089)：设定日志文件的默认地址。
- [setLogFilter](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a41da0404ac726b7326ef1ca6213b2d61)：设置日志输出等级。
- [setLogFileSize](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ae7f4dcaf1173365ae5836bb23d5188f9)：设置日志文件大小。



## 0.9.3 版

该版本于 2019 年 6 月 7 日发布。

#### 新增功能

**发送（离线）点对点消息**

本版本支持发送离线消息。在开通离线消息后，用户不必等到接收端上线才能发送点对点消息。如果对端离线，消息服务器会为每个接收端存储 200 条离线消息长达七天。消息以队列形式存储。当离线消息超限时，最新存储的消息会导致最老的消息丢失。当发送端设置了离线消息，而此时消息接收端不在线，发送端会收到错误码：[PEER_MESSAGE_ERR_CACHED_BY_SERVER](/cn/Video/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#ac7c591aac4ca6867e239c8bcccc1fc5caeccb9896a862a86fa1965705e2d394fd)

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

- [sendMessageToPeer()](/cn/Video/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a08c1b3d444af5a2778ede48e4c677a52):  发送（离线）点对点消息给指定用户。
- [getServerReceivedTs()](/cn/Video/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html#ac7427e3a49bd44e53b2809e0b39511b6)： 消息接收者查询服务器的接收消息时间。
- [isOfflineMessage()](/cn/Video/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_message.html#a191d3073625f002018359ee3e7cba33a)：消息接收者查询消息是否为离线消息。
- [PEER_MESSAGE_ERR_CACHED_BY_SERVER](/cn/Video/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#ac7c591aac4ca6867e239c8bcccc1fc5caeccb9896a862a86fa1965705e2d394fd)：对端用户不在线，离线消息会被消息服务器存储。
- [setLocalUserAttributes()](/cn/Video/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a86dcbfc38c665be8565f06c534338d33)：全量设置本地用户属性
- [addOrUpdateLocalUserAttributes()](/cn/Video/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a0a63923bd1e81e60d6ca54213a329747)：增加本地用户属性或更新本地用户属性
- [deleteLocalUserAttributesByKeys()](/cn/Video/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#acb669f6c4c28e08cdf889df11e1ddeb3)：删除本地用户指定属性
- [clearLocalUserAttributes()](/cn/Video/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#acb669f6c4c28e08cdf889df11e1ddeb3)：清空本地用户全部属性
- [getUserAttributes()](/cn/Video/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html?transId=0.9.3#a14cac887f9adb390621dd0427092a65b)：获取指定用户的全部属性
- [getUserAttributesByKeys()](/cn/Video/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#af011235917c291df5581f92afa35532f): 获取指定用户的指定属性
- [onSetLocalUserAttributesResult()](/cn/Video/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#ac01ea1ff17082bbf3c8cfbaccef4dfe8)：全量设置本地用户属性的执行回调
- [onAddOrUpdateLocalUserAttributesResult()](/cn/Video/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#ab21ea7e02361debe4ebbf558cc80f268)：增加本地用户属性或更新本地用户属性的执行回调
- [onDeleteLocalUserAttributesResult()](/cn/Video/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a2b98a102d2bb9664552e30d257679887)：删除本地用户指定属性的执行回调
- [onClearLocalUserAttributesResult()](/cn/Video/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a94bbff8cdfee2ee306d66f73c1a29aa3)：清空本地用户全部属性的执行回调
- [onGetUserAttributesResult()](/cn/Video/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a76058e05b9a623645ba05ea1d1796007)：获取指定用户属性的执行回调
- [ATTRIBUTE_OPERATION_ERR](/cn/Video/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a9413a8cce9bbd88d8d4baade13c2ccce)：属性操作相关错误码

#### 性能改进

- 支持在登录 Agora RTM 系统之前创建频道实例。
- 取消创建 RTM 频道最多 20 个的限制，但是同一用户只能同时加入 20 个频道，超限后会收到错误码 `JOIN_CHANNEL_ERR_FAILURE ` 。

#### 问题修复

- 偶现的系统崩溃。
- 用户登出后，其它用户查询该用户仍然显示在线，30 秒后查询不在线。

## 0.9.2 版

该版本于 2019 年 5 月 8 日发布。

#### 新增功能

- 查询用户在线状态
- 更新 Token

#### 性能改进

支持以空格开头的 `userId` 参数。

## 0.9.1 版

该版本于 2019 年 4 月 4 日发布。

#### 新增功能

本版本增加了呼叫邀请功能。结合音视频一对一或一对多通话场景，你可以创建、发送、取消、接受或拒绝一个呼叫邀请。

## 0.9.0 版

该版本于 2019 年 2 月 4 日发布。

首次发布。

#### 关键功能

- 发送或接收点对点消息。
- 加入或离开频道。
- 发送或接收频道消息。