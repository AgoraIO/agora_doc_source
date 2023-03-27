RtmClientKit ~03f2af90-60ca-11ed-8dae-bf25bf08a626~
## 方法

### initWithConfig
#### 接口描述

```objc
- (instancetype _Nullable) initWithConfig:(AgoraRtmClientConfig * _Nonnull)config
                                 delegate:(id <AgoraRtmClientDelegate> _Nullable)delegate;
```

初始化 RtmClient 实例。

> 注意：
> 创建并初始化实例必须在你使用 RTM 其他功能之前完成，以建立正确的账号级别的凭据（例如 APP ID）。

| 参数 |描述                    |
| --------- | ------------------------------ |
| `config` | 该 `RtmClient` 实例的配置信息，详见 [`AgoraRtmClientConfig`](#agorartmclientconfig)。 |
| `delegate` | 频道事件监听程序，详见 [`AgoraRtmClientDelegate`](#agorartmclientdelegate)。 |

#### 基本用法

#### 初始化 RTM 实例
<mark>待补充</mark>

#### 返回值
- 一个`RtmClient` 实例：调用成功。
- < `0 `：调用失败。

### destroy
#### 接口描述

```objc
- (int) destroy;
```

销毁一个 `RtmClient` 类型实例以释放资源。

#### 基本用法
<mark>待补充</mark>

#### 返回值
- `0 `：调用成功。
- < `0 `：调用失败。


## 回调

### AgoraRtmClientDelegate 协议

通过 `AgoraRtmClientDelegate` 协议以获得接口调用结果以及事件通知，包括连接状态，消息到达，Presence 状态等事件通知以及监控接口回调结果。在调用这些函数前必须先添加事件监听处理程序。

#### 添加事件监听程序

```objc

```

#### 处理断连

```objc

```

### onMessageEvent
#### 接口描述

```objc
- (void)rtmKit:(AgoraRtmClientKit * _Nonnull)rtmKit
    onMessageEvent:(AgoraRtmMessageEvent * _Nonnull)event;
```

当你订阅的 Topic 中订阅的用户发布消息时，会触发该回调。

| 参数   | 描述      | 
| ------------ | --------- |
| `event`  | 消息事件类型，详见 [`AgoraRtmMessageEvent`](#agorartmmessageevent)。  | 


### onPresenceEvent
#### 接口描述

```objc
- (void)rtmKit:(AgoraRtmClientKit * _Nonnull)rtmKit
    onPresenceEvent:(AgoraRtmPresenceEvent * _Nonnull)event;
```

当频道中有用户的 Presence 状态发生变更时会触发该回调。比如，远端用户加入或离开频道，同一频道内远端用户加入或离开 Topic，本地用户加入频道。

| 参数   | 描述      | 
| ------------ | --------- |
| `event`  | 消息事件类型，详见 [`AgoraRtmPresenceEvent`](#aogrartmpresenceeevent)。  | 


### joinChannel
#### 接口描述

```objc
- (void)rtmKit:(AgoraRtmClientKit * _Nonnull)rtmKit
    onUser:(NSString * _Nonnull)userId
    joinChannel:(NSString * _Nonnull)channelName
    result:(AgoraRtmStreamChannelErrorCode)errorCode;
```

加入频道时会触发该回调。

| 参数      | 描述                              |
| ------------- | ---------------------------------------- |
| `channelName` | 发生事件所属频道。 |
| `userId`      | 加入频道的用户 ID。  |
| `errorCode`   | 频道错误码，详见[`AgoraRtmStreamChannelErrorCode`](api-channel-ios#agorartmstreamchannelerrorcode)。       |

### leaveChannel
#### 接口描述

```objc
- (void)rtmKit:(AgoraRtmClientKit * _Nonnull)rtmKit
    onUser:(NSString * _Nonnull)userId
    leaveChannel:(NSString * _Nonnull)channelName
    result:(AgoraRtmStreamChannelErrorCode)errorCode;
```

离开频道后时触发该回调。

| 参数    | 描述                              |
| ------------- | ---------------------------------------- |
| `channelName`| 发生事件所属频道。 |
| `userId`     | 离开频道的用户 ID。  |
| `errorCode`  | 频道错误码，详见[`AgoraRtmStreamChannelErrorCode`](api-channel-ios#agorartmstreamchannelerrorcode)。       |

### joinTopic
#### 接口描述

```objc
- (void)rtmKit:(AgoraRtmClientKit * _Nonnull)rtmKit
    onUser:(NSString * _Nonnull)userId
    joinTopic:(NSString * _Nonnull)topic
    inChannel:(NSString * _Nonnull)channelName
    withMeta:(NSData * _Nullable)meta
    result:(AgoraRtmStreamChannelErrorCode)errorCode;
```

加入 Topic 时会触发该回调。

| 参数    | 描述                              |
| ------------- | ---------------------------------------- |
| `channelName`  | 发生事件所属频道。 |
| `userId`      | 加入 Topic 的用户 ID。  |
| `topic`        | Topic 名称。       |
| `meta`        | 创建 Topic 的辅助信息。  |
| `errorCode`    | 频道错误码，详见[`AgoraRtmStreamChannelErrorCode`](api-channel-ios#agorartmstreamchannelerrorcode)。       |

### leaveTopic
#### 接口描述

```objc
- (void)rtmKit:(AgoraRtmClientKit * _Nonnull)rtmKit
    onUser:(NSString * _Nonnull)userId
    leaveTopic:(NSString * _Nonnull)topic
    inChannel:(NSString * _Nonnull)channelName
    withMeta:(NSData * _Nullable)meta
    result:(AgoraRtmStreamChannelErrorCode)errorCode;
```

离开 Topic 时会触发该回调。

| 参数    | 描述                              |
| -------------  | ---------------------------------------- |
| `channelName` | 发生事件所属频道。 |
| `userId`      | 离开 Topic 的用户 ID。  |
| `topic`       | Topic 名称。       |
| `meta`        | 创建 Topic 的辅助信息。  |
| `errorCode`   | 频道错误码，详见[`AgoraRtmStreamChannelErrorCode`](api-channel-ios#agorartmstreamchannelerrorcode)。       |

### subscribe
#### 接口描述

```objc
- (void)rtmKit:(AgoraRtmClientKit * _Nonnull)rtmKit
    onUser:(NSString * _Nonnull)userId
    inTopic:(NSString * _Nonnull)topic
    inChannel:(NSString * _Nonnull)channelName
    withSubscribeSuccess:(NSArray<NSString *> * _Nonnull)succeedUsers
    withSubscribeFailed:(NSArray<NSString *> * _Nonnull)failedUsers
    result:(AgoraRtmStreamChannelErrorCode)errorCode;
```

订阅 Topic 或订阅 Topic 中发布消息的用户时会触发该回调。

| 参数      | 描述                                |
| --------------| ------------------------------------------ |
| `channelName` | 发生事件所属频道。 |
| `userId`      | 订阅 Topic 的用户 ID。  |
| `topic`       | 发生事件所属 Topic。 |
| `succeedUsers`| 本次操作订阅成功的消息发布者列表。                       |
| `failedUsers` | 本次操作订阅失败的消息发布者列表。                       |
| `errorCode`   | 频道错误码，详见[`AgoraRtmStreamChannelErrorCode`](api-channel-ios#agorartmstreamchannelerrorcode)。       |

### unsubscribe
#### 接口描述

```objc
- (void)rtmKit:(AgoraRtmClientKit * _Nonnull)rtmKit
    onUser:(NSString * _Nonnull)userId
    inTopic:(NSString * _Nonnull)topic
    inChannel:(NSString * _Nonnull)channelName
    withUnsubscribeSuccess:(NSArray<NSString *> * _Nonnull)succeedUsers
    withUnsubscribeFailed:(NSArray<NSString *> * _Nonnull)failedUsers
    result:(AgoraRtmStreamChannelErrorCode)errorCode;
```

取消订阅 Topic 或取消订阅 Topic 中发布消息的用户时会触发该回调。

| 参数        | 描述                                |
| --------------| ------------------------------------------ |
| `channelName` | 发生事件所属频道。 |
| `userId`     | 取消订阅 Topic 的用户 ID。  |
| `topicName`     | 发生事件所属 Topic。 |
| `succeedUsers` | 本次操作订阅成功的消息发布者列表。                       |
| `failedUsers`   | 本次操作订阅失败的消息发布者列表。                       |
| `errorCode`    | 频道错误码，详见[`AgoraRtmStreamChannelErrorCode`](api-channel-ios#agorartmstreamchannelerrorcode)。       |


### connectionStateChange
#### 接口描述

```objc
- (void)rtmKit:(AgoraRtmClientKit * _Nonnull)kit
    channel:(NSString * _Nonnull)channelName
    connectionStateChanged:(AgoraRtmClientConnectionState)state
    result:(AgoraRtmClientConnectionChangeReason)reason;
```

SDK 连接状态发生改变时会触发该回调。

| 参数   | 描述      | 
| ------------ | --------- |
| `channelName` | 发生事件所属频道。 |
| `state`  | SDK 连接状态，详见 [`AgoraRtmClientConnectionState`](#agorartmclientconnectionstate)。  | 
| `reason`   | SDK 连接状态改变原因，详见 [`AgoraRtmClientConnectionChangeReason`](#agorartmclientconnectionchangereason)。  | 


## Interface

### AgoraRtmClientConfig


```objc
__attribute__((visibility("default"))) @interface AgoraRtmClientConfig: NSObject

@property (nonatomic, copy, nonnull) NSString *appId;

@property (nonatomic, copy, nonnull) NSString *userId;
```

该接口用于存储配置信息，这些信息将影响后续 RTM 客户端的行为。

| 属性  | 描述           |
| ------------ |----------------------------------- |
| appId       | 从声网控制台上获取的 APP ID。                                                        |
| userId      | 用户 ID，用户或设备设置唯一的标识符。你需要维护 userId 和用户之间的映射关系，并在整个服务周期内不能改变。如果不设置该属性，将无法连接到 RTM 服务。                               |


#### 基本用法

```objc

```


### MessageEvent

```objc
__attribute__((visibility("default"))) @interface AgoraRtmMessageEvent: NSObject
rty (nonatomic, assign, readonly) AgoraRtmChannelType channelType;

@property (nonatomic, copy, nonnull) NSString *channelName;

@property (nonatomic, copy, nonnull) NSString *channelTopic;

@property (nonatomic, copy, nonnull) NSData *message;

@property (nonatomic, copy, nonnull) NSString *publisher;
```

消息回调事件。

| 属性   | 描述      | 
| ------------  | --------- |
| `channelType`  | 频道类型，详见 [`RtmChannelType`](#rtmchanneltype)。  | 
| `channelName`   | 频道名称。  | 
| `channelTopic`  | Topic 名称。  | 
| `message`   | 消息负载。  | 
| `publisher`   | 发布消息的用户 ID。  | 

### PresenceEvent

```objc
__attribute__((visibility("default"))) @interface AgoraRtmPresenceEvent: NSObject

@property (nonatomic, assign, readonly) AgoraRtmChannelType channelType;

@property (nonatomic, assign, readonly) AgoraRtmPresenceType type;

@property (nonatomic, copy, nonnull) NSString *channelName;

@property (nonatomic, copy, nonnull) NSArray<AgoraRtmTopicInfo *> *topicInfos;

@property (nonatomic, copy, nonnull) NSString *userId;
```

Presence 回调事件。

| 属性    | 描述      | 
| ------------ | --------- |
| `channelType`         |频道类型，详见 [`AgoraRtmChannelType`](#rtmchanneltype)。  | 
| `type`        |Presence 类型，详见 [`AgoraRtmPresenceType`](#rtmpresencetype)。  | 
| `channelName`      | 频道名称。  | 
| `topicInfos`    | Topic 信息，详见 [TopicInfo](#api-topic-ios#topicinfo)。  | 
| `userId`    | Presence 所属用户 ID。  | 

## Enum

### AgoraRtmChannelType

```objc
typedef NS_ENUM(NSInteger, AgoraRtmChannelType) {

  AgoraRtmChannelTypeMessage = 0,

  AgoraRtmChannelTypeStream = 1,
};
```

RTM 频道类型。

| 枚举值    | 描述      | 
| ------------ | --------- |
| `AgoraRtmChannelTypeMessage`     | 0: Message Channel。  | 
| `AgoraRtmChannelTypeStream`     | 1: Stream Channel。  | 



### AgoraRtmClientErrorCode

```objc
typedef NS_ENUM(NSInteger, AgoraRtmClientErrorCode) {

  AgoraRtmClientErrTopicAlreadyExist = 10001,

  AgoraRtmClientErrExceedCreateTopicLimitation = 10002,

  AgoraRtmClientErrInvalidTopicName = 10003,

  AgoraRtmClientErrPublishTopicFailed = 10004,

  AgoraRtmClientErrExceedSubscribeTopicLimitation = 10005,

  AgoraRtmClientErrExceedUserLimitation = 10006,

  AgoraRtmClientErrExceedChannelLimitation = 10007,

  AgoraRtmClientErrAlreadyJoinChannel = 10008,

  AgoraRtmClientErrNotJoinChannel = 10009,
};
```

RTM 错误码。

| 枚举值    | 描述      | 
| ------------ | --------- |
| `AgoraRtmClientErrTopicAlreadyExist`     | 10001: Topic 已存在。  | 
| `AgoraRtmClientErrExceedCreateTopicLimitation`     | 10002: 创建的 Topic 超出数量限制。  | 
| `AgoraRtmClientErrInvalidTopicName`     | 10003: 不是有效的 Topic 名称。  | 
| `AgoraRtmClientErrPublishTopicFailed`    | 10004: 发布 Topic 失败。  | 
| `AgoraRtmClientErrExceedSubscribeTopicLimitation`    | 10005: 订阅的 Topic 超出数量限制。  | 
| `AgoraRtmClientErrExceedUserLimitation`    | 10006: 频道内用户超出数量限制。  | 
| `AgoraRtmClientErrExceedChannelLimitation`    | 10007: 创建的频道超出数量限制。  | 
| `AgoraRtmClientErrAlreadyJoinChannel`    | 10008: 已加入该频道。  | 
| `AgoraRtmClientErrNotJoinChannel`    | 10009: 未加入任何频道。  | 



### AgoraRtmClientConnectionState

```objc
typedef NS_ENUM(NSInteger, AgoraRtmClientConnectionState) {

  AgoraRtmClientConnectionStateDisconnected = 1,

  AgoraRtmClientConnectionStateConnecting = 2,

  AgoraRtmClientConnectionStateConnected = 3,

  AgoraRtmClientConnectionStateReconnecting = 4,

  AgoraRtmClientConnectionStateFailed = 5,
};
```

SDK 连接状态。

| 枚举值  | 描述                                                                                                |
| ----------------------------------- | ----------------------------------------------- |
| `AgoraRtmClientConnectionStateDisconnected` | 1: SDK 已和服务器断开连接。                                                                      |
| `AgoraRtmClientConnectionStateConnecting`   | 2: SDK 正在连接服务器。                                                                    |
| `AgoraRtmClientConnectionStateConnected`    | 3: SDK 已连上服务器。                                                                           |
| `AgoraRtmClientConnectionStateReconnecting` | 4: SDK 和服务器断开连接，正在重新连接服务器。 |
| `AgoraRtmClientConnectionStateFailed`       | 5: SDK 无法连接服务器。                                                                      |

### AgoraRtmClientConnectionChangeReason

```objc
typedef NS_ENUM(NSInteger, AgoraRtmClientConnectionChangeReason) {

  AgoraRtmClientConnectionChangedConnecting = 0,

  AgoraRtmClientConnectionChangedJoinSuccess = 1,

  AgoraRtmClientConnectionChangedInterrupted = 2,

  AgoraRtmClientConnectionChangedBannedByServer = 3,

  AgoraRtmClientConnectionChangedJoinFailed = 4,

  AgoraRtmClientConnectionChangedLeaveChannel = 5,

  AgoraRtmClientConnectionChangedInvalidAppId = 6,

  AgoraRtmClientConnectionChangedInvalidChannelName = 7,

  AgoraRtmClientConnectionChangedInvalidToken = 8,

  AgoraRtmClientConnectionChangedTokenExpired = 9,

  AgoraRtmClientConnectionChangedRejectedByServer = 10,

  AgoraRtmClientConnectionChangedSettingProxyServer = 11,

  AgoraRtmClientConnectionChangedRenewToken = 12,

  AgoraRtmClientConnectionChangedClientIpAddressChanged = 13,

  AgoraRtmClientConnectionChangedKeepAliveTimeout = 14,

  AgoraRtmClientConnectionChangedRejoinSuccess = 15,

  AgoraRtmClientConnectionChangedChangedLost = 16,

  AgoraRtmClientConnectionChangedEchoTest = 17,

  AgoraRtmClientConnectionChangedClientIpAddressChangedByUser = 18,

  AgoraRtmClientConnectionChangedSameUidLogin = 19,

  AgoraRtmClientConnectionChangedTooManyBroadcasters = 20,
};
```

SDK 连接状态改变原因。

| 枚举值                             | 描述                          |
| ------------------------------------ | ------------------------------------ |
|  `AgoraRtmClientConnectionChangedConnecting`   | 0: 建立网络连接中。 |
|  `AgoraRtmClientConnectionChangedJoinSuccess` | 1: 成功加入频道。  |
|  `AgoraRtmClientConnectionChangedInterrupted`   | 2: 网络连接中断。  |
|  `AgoraRtmClientConnectionChangedBannedByServer`  | 3: 网络连接被服务器禁止。   |
|  `AgoraRtmClientConnectionChangedJoinFailed`  |  4: SDK 连续 20 分钟无法加入频道，停止重连频道。  |
|  `AgoraRtmClientConnectionChangedLeaveChannel`  |  5: 离开频道。                            |
|  `AgoraRtmClientConnectionChangedInvalidAppId` |  6: 不是有效的 APP ID，无法加入频道。    |
|  `AgoraRtmClientConnectionChangedInvalidChannelName` |  7: 不是有效的频道名，无法加入频道。     |
|  `AgoraRtmClientConnectionChangedInvalidToken`  |   8: Token 无效，无法加入频道。   |
|  `AgoraRtmClientConnectionChangedTokenExpired` |  9: Token 过期D，无法加入频道。     |
|  `AgoraRtmClientConnectionChangedRejectedByServer`  |  10: 被服务器禁止连接。    |
|  `AgoraRtmClientConnectionChangedSettingProxyServer` |  11: 由于设置了代理服务器，SDK 尝试重连。   |
|  `AgoraRtmClientConnectionChangedRenewToken`  |   12: 更新 Token 引起网络连接状态改变。    |
|  `AgoraRtmClientConnectionChangedClientIpAddressChanged` |  13: 由于网络类型，或网络运营商的 IP 或端口发生改变，客户端 IP 地址变更，SDK 尝试重连。     |
|  `AgoraRtmClientConnectionChangedKeepAliveTimeout`  | 14: SDK 和服务器连接保活超时，进入自动重连状态。   |
|  `AgoraRtmClientConnectionChangedRejoinSuccess`  |  15: SDK 重连成功。    |
|  `AgoraRtmClientConnectionChangedChangedLost`  |    16: SDK 丢失与服务器的连接。    |
|  `AgoraRtmClientConnectionChangedEchoTest`  |   17: 通话回声测试引起连接状态改变。     |
|  `AgoraRtmClientConnectionChangedClientIpAddressChangedByUser`|  18: 用户变更客户端 IP 地址，SDK 尝试重连。  |
|  `AgoraRtmClientConnectionChangedSameUidLogin`  |  19: 使用相同的 UID 从不同的设备加入同一频道。   |
|  `AgoraRtmClientConnectionChangedTooManyBroadcasters`  |  20: 频道内主播人数已达上限。   |

### AgoraRtmPresenceType

```objc
typedef NS_ENUM(NSInteger, AgoraRtmPresenceType) {

  AgoraRtmPresenceTypeRemoteJoinChannel = 0,

  AgoraRtmPresenceTypeRemoteLeaveChannel = 1,

  AgoraRtmPresenceTypeRemoteConnectionTimeout = 2,

  AgoraRtmPresenceTypeRemoteJoinTopic = 3,

  AgoraRtmPresenceTypeRemoteLeaveTopic = 4,

  AgoraRtmPresenceTypeSelfJoinChannel = 5,
};
```

Presence 类型。

| 枚举值    | 描述      | 
| ------------ | --------- |
| `AgoraRtmPresenceTypeRemoteJoinChannel`     | 0: 远端用户加入频道。  | 
| `AgoraRtmPresenceTypeRemoteLeaveChannel`     | 1: 远端用户离开频道。  | 
| `AgoraRtmPresenceTypeRemoteConnectionTimeout`     | 2: 远端用户连接超时。  | 
| `AgoraRtmPresenceTypeRemoteJoinTopic`     | 3: 远端用户加入 Topic。  | 
| `AgoraRtmPresenceTypeRemoteLeaveTopic`     | 4: 远端用户离开 Topic。  | 
| `AgoraRtmPresenceTypeSelfJoinChannel`     | 5: 本地用户加入频道。  | 
