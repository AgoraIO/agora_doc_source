## 1.4.6 版

该版本于 2022 年 7 月 20 日发布。

#### 升级必看

**AccessToken2**

自该版本起，RTM 升级 Token 鉴权机制。

<div class="alert note"><li>如果你首次接触该产品，Agora 建议你使用最新版的 RTM SDK 并参照  <a href="https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm">Token 鉴权</a> 为 AccessToken2 部署服务器和客户端；<li>如果你已在先前版本中部署过 AccessToken 鉴权，可以参照  <a href="https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm#upgrade">升级至 AccessToken2</a> 快速完成升级。</div>

升级后的 AccessToken2 支持用户根据业务需求指定 Token 有效期 (最长为 24 小时)。此外，新增 `TokenPrivilegeWillExpire` 回调，在 Token 临 30 秒过期时触发，提醒用户当前 Token 即将超出签发有效期，需尽快更新；否则，处于登录连接状态的用户会因为 Token 过期 (`TOKEN_EXPIRED (9)`) 而终止登录。详情参见 [RTM Token 过期](./token_server_rtm#rtm-token-过期)。 



#### 问题修复

修复了请求超时输出日志的单位，先前为毫秒 (ms)，现修复为秒 (s)。

#### API 变更

**新增**  
- `TokenPrivilegeWillExpire`
- `ConnectionChangeReason` 中新增 `TOKEN_EXPIRED (9)`


## 1.4.5 版

该版本于 2022 年 5 月 31 日发布。

#### 改进

该版本改进了以下问题：

- 当调用 `subscribePeersOnlineStatus` 方法的调用频率超过每 5 秒 10 次时，SDK 返回 `PEER_SUBSCRIPTION_STATUS_ERR_TOO_OFTEN (5)` 错误码。
- 当调用 `subscribePeersOnlineStatus` 方法订阅的用户数超过 512 人数上限时，SDK 返回 `PEER_SUBSCRIPTION_STATUS_ERR_OVERFLOW (6)` 错误码。

#### 修复

该版本修复了当 Safari 浏览器或其标签页在 macOS 后台运行时，RTM Web SDK 与 RTM 系统不断重连的问题。


## 1.4.4 版
该版本于 2021 年 12 月 24 日发布。

修复了在 Chrome 88 及以上版本使用 Agora RTM Web SDK 的前提下，当浏览器或标签页进入后台运行时，RTM Web SDK 可能出现与 RTM 系统重连（连接状态为 RECONNECTING）的问题。


## 1.4.3 版
该版本于 2021 年 5 月 27 日发布。

#### 升级必看

**域名白名单变更**

自 1.4.3 版本起，SDK 的域名白名单变更为：


- `.edge.agora.io`
- `.edge.sd-rtn.com`
- `web-1.ap.sd-rtn.com`
- `web-2.ap.sd-rtn.com`
- `ap-web-1.agora.io`
- `ap-web-2.agora.io`
- `webcollector-rtm.agora.io`
- `logservice-rtm.agora.io`
- `rtm.statscollector.sd-rtn.com`
- `rtm.logservice.sd-rtn.com`

为确保你在有网络访问限制的环境中能够使用 Agora 产品，如果你将 SDK 升级至 1.4.3 版本，请务必更新防火墙的域名白名单。

#### 新增特性

**设置区域访问限制**

- 新增 `AgoraRTM.setArea` 方法用于指定 Agora RTM SDK 的访问区域。该功能为高级设置，适用于有访问安全限制的场景。
指定访问区域之后，SDK 只会连接到指定区域内的 Agora 服务器。支持的区域如下：

 - 中国大陆
 - 北美
 - 欧洲
 - 亚洲（中国大陆除外）
 - 日本
 - 印度
 - 全球

- 支持通过 `AgoraRTM.setArea` 方法中的 `excludeArea` 参数，去除访问区域中的个别区域。该设置仅对于 `GLOBAL` 的访问区域有效。详见[限定访问区域](https://docs.agora.io/cn/Real-time-Messaging/region_web_rtm?platform=Web)。
- 废弃 `createInstance` 并新增同名方法替代。新方法去除 `areaCodes` 参数设置，即不再通过 `createInstance` 方法设置 Agora RTM SDK 的访问区域。


#### API 变更

**新增**

 [`createInstance`](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_web/modules/agorartm.html#createinstance)

**废弃**

`createInstance`，使用新的 [`createInstance`](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_web/modules/agorartm.html#createinstance) 。


## 1.4.2 版

该版本于 2021 年 3 月 2 日发布。

#### 升级必看

**行为变更**

- 为了在方法名上更精准地表达原有的 `setParameters` 方法的作用，该版本新增了功能完全相同的 `updateConfig` 方法，并废弃了原有的 `setParameters` 方法。
- `content` 的参数大小超过 8 KB 时，`INVITATION_API_CALL_ERR_INVALID_ARGUMENT` 错误码的触发条件从调用 `setContent` 时触发改为调用 `send` 时触发。

**兼容性变更**

- 从该版本起，你需要额外引入 [js-sha1](https://www.npmjs.com/package/js-sha1) 库才能在 Microsoft Edge 旧版浏览器和 Internet Explorer 11 浏览器中使用 SDK 进行文件或图片的上传及下载操作。具体方法如下：
	- 在 HTML 文件中，将 js-sha1暴露到全局的 `sha1` 变量中
	```html
	<script src="https://cdn.jsdelivr.net/npm/js-sha1@0.6.0/src/sha1.min.js"></script>
	```
	- 或者在 JS 文件中添加：
	```javascript
	window.sha1 = require('js-sha1')
	```
- 该版本删除了 `ReceivedMessageProperties` 对象的 `isHistoricalMessage` 成员变量。

#### 改进

- 压缩后的 SDK 包体积减小了约 30%。
- (仅限于从 NPM 获得的 SDK) 在 SDK 包中的 TS 文件中新增以下类型导出：
	- `LocalInvitation`
	- `RemoteInvitation`
	- `RtmMessage`
	- `RtmRawMessage`
	- `RtmTextMessage`
	- `RtmFileMessage`
	- `RtmImageMessage`
- SDK 会根据内容为 `downloadMedia` 下载的二进制 Blob 对象添加相应 MIME 类型，支持自动检测并添加以下 MIME 类型:
	- image/png
	- image/gif
	- application/pdf
	- image/jpeg
	- application/zip

#### API 变更

**新增**

[`updateConfig`](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#updateconfig)

**废弃**

`setParameters`


#### 删除

`ReceivedMessageProperties` 对象的 `isHistoricalMessage` 成员变量

## 1.4.1 版

该版本于 2020 年 11 月 5 日发布。

**新增功能**

修复了与 RTM Native SDK 互通时的性能问题。

## 1.4.0 版

该版本于 2020 年 9 月 25 日发布。

**升级必看**

1.4.0 版仅支持 TypeScript 3.8 或以上版本。

**新增功能**

增加限定访问区域功能。你可以通过 `createInstance` 方法中的 `areaCodes` 参数设置 Agora RTM SDK 的访问区域。设置之后，RTM SDK 只能连接位于限定区域的 Agora RTM 服务器。详见[限定访问区域](/cn/Real-time-Messaging/region_web_rtm?platform=Web)。


**API 变更**

#### 新增

 [`createInstance`](/cn/Real-time-Messaging/API%20Reference/RTM_web/modules/agorartm.html#createinstance) 方法新增 `areaCodes` 参数。


## 1.3.1 版

该版本于 2020 年 8 月 12 日发布。

**问题修复**

- 修复了重连后 SDK 与 RTM 系统连接不稳定的问题。
- 修复了离线消息可能重复投递的问题。
- 修复了 SDK 登录 RTM 系统的可靠性问题。
- 修复了点对点消息发送和回执的可靠性问题。
- 修复了 [`TokenExpired`](/cn/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmevents.rtmclientevents.html#tokenexpired) 回调无法及时触发的问题。


## 1.3.0 版

该版本于 2020 年 6 月 24 日发布。

**升级必看**

- 服务器端会屏蔽向 1.2.2 或更早版本的实时消息 SDK、信令 SDK 发送的图片或文件消息。
- 异步调用方法的通用超时时间由 5 秒更新为 10 秒。
- 防火墙白名单的 TCP 协议需要新增 9601 端口，用于发送和接收图片及文件消息。详见[应用企业防火墙限制](https://docs.agora.io/en/Agora%20Platform/firewall?platform=All%20Platforms)。

**新增特性**

#### 1. 发送和接收文件或图片消息

你可以通过 `createMediaMessageByUploading` 方法上传不超过 30 MB 的非空文件或图片。每个上传成功的文件或图片会在 Agora 服务器保存七天，SDK 会返回一个 media ID 作为此文件或图片的唯一标识。你可以使用 `RtmFileMessage` 接口或 `RtmImageMessage` 接口保存 SDK 返回的 media ID。`RtmFileMessage` 接口和 `RtmImageMessage` 接口都是 `RtmMessage` 接口的类型别名，所以你可以通过点对点消息或频道消息发送和接收文件消息或图片消息。你可以使用 `downloadMedia` 方法下载接收到的文件或图片。

#### 2. 管理上传和下载任务

你可以通过 `mediaTransferHandler` 接口取消上传或下载任务，或者报告上传或下载的进度。

**问题修复**

解决了部分地区用户无法登录的问题。

**API 变更**

#### 新增

- [`createMediaMessageByUploading`](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/classes/rtmclient.html#createmediamessagebyuploading) 方法
- [`downloadMedia`](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/classes/rtmclient.html#downloadmedia) 方法
- [`createMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/classes/rtmclient.html#createmessage) 方法
- [`RtmImageMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/interfaces/rtmimagemessage.html) 接口
- [`RtmFileMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/interfaces/rtmfilemessage.html) 接口
- [`mediaTransferHandler`](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/interfaces/mediatransferhandler.html) 接口
- [`mediaOperationProgress`](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.3.0/interfaces/mediaoperationprogress.html) 接口

## 1.2.2 版

该版本于 2020 年 2 月 21 日发布。

**兼容性改变**

发送频道消息的超时时间由 5 秒变更为 10 秒。

**问题修复**

从 Windows 平台上较新版本 Chrome 登录 Agora RTM 系统会偶尔收到错误码 `LOGIN_ERR_UNKNOWN`。

## 1.2.1 版

$$ fe7e5f60-20ac-11ea-b338-f1556ea7fcbf
{
  "platform": "Web"
}
$$

## 1.2.0 版

该版本于 2019 年 11 月 15 日发布。新增如下功能：

- [订阅或取消订阅指定单个或多个用户的在线状态](#subscribe)
- [获取某特定内容被订阅的用户列表](#list)
- [创建自定义二进制消息](#raw)
- [创建文本消息](#text)



**新增功能**

#### 1. <a name="subscribe"></a>订阅或取消订阅指定单个或多个用户的在线状态。

<div class="alert note"> 该功能必须在登录 Agora RTM 系统成功后才能调用。</div>

本版本支持订阅或取消订阅最多 512 个用户的在线状态。首次订阅成功时，SDK 会通过 `PeersOnlineStatusChanged` 回调返回所有被订阅用户的在线状态；之后每当有被订阅用户的在线状态出现变化，SDK 都会通过 `PeersOnlineStatusChanged` 回调通知订阅方。

<div class="alert note"> <sup>1</sup>用户登出 Agora RTM 系统后，所有之前的订阅内容都会被清空；重新登录后，如需保留之前订阅内容则需重新订阅。</div>

<div class="alert note"> <sup>2</sup>重复订阅同一用户不会报错。</div>


#### 2. <a name="list"></a>获取某特定内容被订阅的用户列表

<div class="alert note"> 该功能必须在登录 Agora RTM 系统成功后才能调用。</div>

本版本支持根据被订阅类型获取被订阅用户列表。现实情况中，你可能多次订阅或取消订阅，可能重复订阅了相同用户，可能出现订阅或取消订阅不成功的情况，也可能根据不同的订阅类型订阅了不同的用户。这时，你可以通过本功能根据订阅类型获取当前被订阅用户列表。

被订阅类型由枚举类型 `PeerSubscriptionOption` 定义。本版本仅支持用户在线状态订阅一种类型，后继会不断扩展。

#### 3. <a name="raw"></a>创建自定义二进制消息

本版本支持创建自定义二进制消息，支持以点对点消息或频道消息形式发送多种文件格式。

<div class="alert note"> 我们不对二进制消息的文本描述的大小单独进行限制，但是我们要求自定义二进制消息的总大小不超过 32 KB。</div>

**问题修复**

SDK 偶尔会被服务端踢开：问题发生时，Client 实例会收到 ConnectionStateChange 回调，状态改变为 ABORTED，改变原因为 INTERRUPTED；日志显示服务端错误码为 10001。


## 1.1.0 版

该版本于 2019 年 9 月 30 日发布。新增如下功能：

- [查询频道成员人数](#getcount)
- [频道成员人数自动更新](#oncount)
- [频道属性增删改查](#channelattributes)



**兼容性改动**

1. `RtmMessage` 对象的 `serverReceivedTs` 方法由仅支持点对点消息改为同时支持点对点消息和频道消息。
2. 点对点消息的超时时间由 5 秒延长为 10 秒。

**新增功能**

<a name="getcount"></a>
#### 1. 查询频道成员人数

支持在不加入频道的情况下通过主动调用 `getChannelMemberCount` 接口查询单个或多个频道的频道人数。一次最多可查询 32 个频道的成员人数。

<a name="oncount"></a>
#### 2. 频道成员人数自动更新

如果你已经加入某频道，你无需调用 `getChannelMemberCount` 接口查询当前频道人数。我们也不建议你通过监听 `MemberJoined` 和 `MemberLeft` 统计频道成员人数。从本版本开始，SDK 会在频道成员人数发生变化时通过 `MemberCountUpdated` 回调接口通知频道成员并返回当前频道成员人数：

- 频道成员人数小于等于 512 时，最高触发频率为每秒 1 次。
- 频道成员人数超过 512 时，最高触发频率为每 3 秒 1 次。

<a name="channelattributes"></a>
#### 3. 频道属性增删改查

支持设置或查询某个指定频道的属性。你可以用频道属性实现群公告、上下麦同步等功能。

每个频道属性为 key 和 value 的键值对。其中：
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

在进行频道属性的更新或删除操作时，你可以通过设置标志位 `enableNotificationToChannelMembers` 决定是否通知对应频道所有成员本次频道属性变更。


**性能改进**

#### 点对点消息重发

本版本优化了点对点消息在弱网情况下的重发机制，并延长点对点消息超时时间为 10 秒，提高了在弱网情况下点对点消息的发送成功率。

#### 频道消息缓存

Agora RTM 系统会对短期掉线后重连成功的频道成员补发最长 30 秒最多 32 条的频道消息，提高了弱网情况下频道消息的到达率。


**API 变更**

#### 新增方法

- [setChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/classes/rtmclient.html#setlocaluserattributes)：全量设置某指定频道的属性。
- [addOrUpdaeChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/classes/rtmclient.html#addorupdatechannelattributes)：添加或更新某指定频道的属性。
- [deleteChannelAttributesByKeys](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/classes/rtmclient.html#deletechannelattributesbykeys)：删除某指定频道的指定属性。
- [clearChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/classes/rtmclient.html#clearchannelattributes)：清空某指定频道的属性。
- [getChannelAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/classes/rtmclient.html#getchannelattributes)：查询某指定频道的全部属性。
- [getChannelAttributesByKeys](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/classes/rtmclient.html#getchannelattributesbykeys)：查询某指定频道指定属性名的属性。
- [getChannelMemberCount](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/classes/rtmclient.html#getchannelmembercount)：查询单个或多个频道的成员人数。

#### 新增回调

- [AttributesUpdated](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/interfaces/rtmevents.rtmchannelevents.html#attributesupdated)：频道属性更新回调。返回所在频道的所有属性。
- [MemberCountUpdated](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/interfaces/rtmevents.rtmchannelevents.html#membercountupdated)：频道成员人数更新回调。返回最新频道成员人数。

#### 新增错误码 

- [GetChannelMemberCountErrCode](/cn/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/enums/rtmerrorcode.getchannelmembercounterrcode.html)：获取指定频道成员人数的相关错误码。
- [JOIN_CHANNEL_ERR_JOIN_SAME_CHANNEL_TOO_OFTEN](/en/Real-time-Messaging/API%20Reference/RTM_web/v1.1.0/enums/rtmerrorcode.joinchannelerror.html#join_channel_err_join_same_channel_too_often)：加入相同频道的频率超过每 5 秒 2 次的上限。
- [JOIN_CHANNEL_ERR_ALREADY_JOINED_CHANNEL_OF_SAME_ID](/cn/Real-time-Messaging/API%20Reference/RTM_web/enums/rtmerrorcode.joinchannelerror.html#join_channel_err_already_joined_channel_of_same_id)：已加入另一同名频道。




## 1.0.1 版

该版本于 2019 年 9 月 5 日发布。

**问题修复**

- 在未设置 [enableOfflineMessaging](/cn/Real-time-Messaging/API%20Reference/RTM_web/interfaces/sendmessageoptions.html) 的情况下，发送的点对点消息有一定几率成为离线消息。
- 对端用户成功登录后立即设置的用户属性有一定几率无法被获取。

**功能改进**

- 改进断线重连时的点对点消息发送机制：缓存默认 6 秒时长的点对点消息，在用户重连成功后立即投递。
- 点对点消息超时时间改为 10 秒。

## 1.0.0 版

该版本于 2019 年 8 月 5 日发布。

**新增功能**

#### 新老互通

支持与 Agora Signaling SDK 互通。

本版本在 `LocalInvitation` 类中实现了 `channelId` 属性。

> - 如需与 Agora Signaling SDK 互通，则必须调用 `channelId` 属性设置频道 ID。不过即使被叫成功接受呼叫邀请，Agora RTM SDK 也不会将主叫或被叫加入指定频道。
> - 如果你的应用不涉及 Agora Signaling SDK，我们推荐使用 `LocalInvitation.content` 或者 `RemoteInvitation.response` 属性设置自定义内容。

#### 设置日志输出等级

支持通过设置 `logFilter` 参数将日志内容按照 OFF、ERROR、WARNING 和 INFO 不同等级输出 。


**API 变更**

**新增**

- [logFilter](/cn/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmparameters.html#logfilter)
- [setParameters](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#setparameters)

## 0.9.3 版

该版本于 2019 年 7 月 24 日发布。

**新增功能**

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

**API 变更**

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

**新增功能**

本版本增加了呼叫邀请功能。结合音视频一对一或一对多通话场景，你可以创建、发送、取消、接受或拒绝一个呼叫邀请。

**性能改进**

-   本地用户发送的频道消息/点对点消息/进频道通知均不出现在当前用户的 API 回调中。
-   用户名 `uid` 允许以空格开头。

**API 变更**

**新增**

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

**主要功能**

- 发送或接收点对点消息。
- 加入或离开频道。
- 发送或接收频道消息。