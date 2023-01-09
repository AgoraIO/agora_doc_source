~8704dfd0-60c9-11ed-8dae-bf25bf08a626~
## 方法

### join
#### 接口描述
```cpp
virtual int join(const JoinChannelOptions& options) = 0;
```

加入频道。

成功调用该接口后会触发 `onJoinResult` 事件回调和 `onPresenceEvent` 事件回调，频道中的其他用户会收到 `join` 事件通知。该接口的回调通过 [`IRtmEventHandler`](#api-config-cpp#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

> 注意：
> 单次调用该接口只能加入一个频道。单个客户端可以同时加入最多 100 个频道。

| 参数       | 描述        |
| --------------- | ------------------ |
| `options`       | （选填）加入频道时的配置选项，详见 [`JoinChannelOptions`](#joinchanneloptions)。         |


#### 基本用法 (需提供示例代码)

##### 加入频道
<mark>待补充</mark>

#### 返回值
- `0 `：调用成功。
- < `0 `：调用失败。

### getChannelName
#### 接口描述

```cpp
virtual const char* getChannelName() = 0;
```

获取频道名称。

#### 返回值
频道名称。

### leave
#### 接口描述

```cpp
virtual int leave() = 0;
```

离开频道。

成功调用该接口后会触发 `onLeaveResult` 事件回调和 `onPresenceEvent` 事件回调，频道中的其他用户会收到 `leave` 事件通知。该接口的回调通过 [`IRtmEventHandler`](api-config-cpp#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

#### 基本用法（需提供示例代码）

##### 离开频道
<mark>待补充</mark>

#### 返回值

- `0 `：调用成功。
- < `0 `：调用失败。                                                             

### Release
#### 接口描述

```cpp
virtual int release() = 0;
```

销毁一个 IStreamChannel 类型实例。

如果你不再需要某个频道，可以调用该接口销毁对应的 IStreamChannel 实例以释放资源。本端调用该接口销 IStreamChannel 实例不会销毁此频道，后续可通过调用 `CreateStreamChannel`和 `Join` 再次加入该频道。

> 注意：如果不先调用 `Leave` 离开频道而直接调用 `Release` 销毁频道实例，SDK 会自动调用 `Leave` 并触发对应的事件回调。

#### 基本用法（需提供示例代码）

##### 离开频道
<mark>待补充</mark>


#### 返回值

- `0`：调用成功。
- <`0`：调用失败。

### joinTopic
#### 接口描述

```cpp
virtual int joinTopic(const char* topic, const JoinTopicOptions& options) = 0;
```

加入一个 Topic。

只有加入 Topic 才能执行发送 Topic 消息的操作。

调用该接口成功后会触发对应的 Presence 事件，该频道的参与者会收到相应的事件通知。该接口的回调通过 [`IRtmEventHandler`](api-config-cpp#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

> 注意：同一个客户端同时只能加入 8 个 Topic，超出数量会报错。

| 参数 | 描述                                                    |
| --------- | ------------------------------------------------- |
| `topic`   | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |
| `options` | （选填）加入 Topic 时的配置选项，详见 [`JoinTopicOptions`](#jointopicoptions)                                             |


#### 基本用法 （需提供示例代码）

##### 加入Topic
<mark>待补充</mark>


#### 返回值
- `0`：调用成功。
- < `0`：调用失败。

### leaveTopic
#### 接口描述

```cpp
virtual int leaveTopic(const char* topic) = 0;
```

离开一个 Topic。

当客户端加入的 Topic 达到上限时，需要调用 `leaveTopic` 离开某些不再需要的 Topic 以释放资源。调用成功会触发对应的 `Presence` 事件，该频道的参与者会收到相应的事件通知。该接口的回调通过 [`IRtmEventHandler`](#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。


| 参数 | 描述                                                    |
| --------- | -------------------------------------------------------------- |
| `topic`   | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |

#### 基本用法 （需提供示例代码）
<mark>待补充</mark>


#### 返回值
- `0`：调用成功。
- < `0`：调用失败。


### publishTopicMessage
#### 接口描述

```cpp
virtual int publishTopicMessage(const char* topic, const char* message, size_t length) = 0;
```

在指定 Topic 中发送文本消息。消息在传输的过程中默认已经被 SSL/TLS 加密，以保证数据链路层安全。

成功调用该接口后会触发 [`onMessageEvent`](#IRtmEventHandler) 事件回调，频道中订阅该 Topic 且订阅该消息发布者的用户会收到该事件回调。该接口的回调通过 [`IRtmEventHandler](#api-config-cpp#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

> 注意：
> - 调用该接口前需先调用 `joinTopic` 加入 Topic。
> - 不支持同时向多个 Topic 发送同一条消息。
> - 在调用 `joinTopic` 时可将 `qos` 字段配置为 `RTM_MESSAGE_QOS_ORDERED` 以开启该 Topic 的消息保序能力。除此之外，以下行为也可有效提升消息收发的可靠性：
    - 以串行的方式发送消息。
    - 消息负载不要超过 1KiB，否则发送会失败。
    - 单个客户端在单个 Topic 中发送消息的速率上限为 60 QPS，如果发送速率超限，将会有部分消息会被丢弃。在满足要求的情况下，速率越低越好。

| 参数 | 描述                                                    |
| ---------| -------------------------------------------------------------- |
| `topic`   | Topic 名称，同一个频道内相同的 Topic 名称代表同一个 Topic。 |
| `message` | 消息负载，可为任意单字节或多字节 UTF-8 字符。SDK 会自动对消息负载进行序列化。  |
| `length` | 消息负载长度。  |


#### 基本用法 （需提供示例代码）

##### 向 Topic 中发送消息
<mark>待补充</mark>

#### 返回值
- `0`：调用成功。
- < `0`：调用失败。


### subscribeTopic
#### 接口描述

```cpp
virtual int subscribeTopic(const char* topic, const TopicOptions& options) = 0;
```

订阅 Topic 及 Topic 中的消息发送者。

`subscribeTopic` 为增量接口。例如，第一次调用该接口时，订阅消息发布者列表为 `[UserA,UserB]`  , 第二次调用该接口时，订阅消息发布者列表为 `[UserB,UserC]`，则最后成功订阅的结果是 `[UserA，UserB,UserC]`。你可以通过 [`getSubscribedUserList`](#getsubscribeduserlist) 查询当前已经订阅的消息发布者名单列表。

频道中单个 Topic 的消息发布者的数量没有上限，但对于 Topic 订阅者，目前只能同时订阅单个 Topic 中最多 50 个消息发布者的消息。

该接口的回调通过 [`IRtmEventHandler](#api-config-cpp#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

你的 APP 可以通过 `IRtmEventHandler` 收到消息和事件通知，`IRtmEventHandler`  是你的 APP 中接收你订阅的 Topic 消息及事件的唯一入口点。默认情况下，你只能收取到 `subscribeTopic` 调用成功后的消息和事件通知。如果用户网络连接出现问题，RTM 2.0 将自动尝试重新连接，但在断连期间的消息将丢失。<mark>默认情况指的是？这段话只对这个接口适用？断连这句话在这里很突兀，没有上下文</mark>


| 参数    | 描述                                                    |
| ------------| --------------------------------------------------------- |
| `topic`      |  Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |
| `options`    | （选填）订阅 Topic 时的配置选项，详见 [`TopicOptions`](api-topic-cpp#topicoptions)。如果不填写该字段，SDK 将随机订阅该 Topic 中 50 个消息发布者；如果该 Topic 中消息发布者不超过 50 人，则订阅所有消息发布者。<mark>超过50个是取前50个吗？</mark>）                     |


#### 基本用法 （需提供示例代码）

##### 订阅指定用户
<mark>待补充</mark>

#### 返回值
- `0`：调用成功。
- < `0`：调用失败。

### unsubscribeTopic
#### 接口描述

```cpp
virtual int unsubscribeTopic(const char* topic, const TopicOptions& options) = 0;
```
取消订阅某 Topic 或取消对该 Topic 中指定的消息发布者的订阅。

该接口的回调通过 [`IRtmEventHandler](#api-config-cpp#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

| 参数    | 描述                                                    |
| ------------|-------------------------------------------------------------- |
| `topic`      | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |
| `options`    | （选填）取消订阅 Topic 时的配置选项，详见 [`TopicOptions`](api-topic-cpp#topicoptions)。你可以指定想要取消订阅的消息发布者。如果 `options` 中配置的用户列表不在已订阅的用户名单中，API 调用会正常返回，但不会有任何变化。如果该字段为空，将取消订阅该 Topic及取消订阅该 Topic 中所有消息发布者。        |


#### 基本用法 （需提供示例代码）

##### 取消订阅指定用户
<mark>待补充</mark>


##### 取消订阅 Topic 
<mark>待补充</mark>


#### 返回值
- `0`：调用成功。
- < `0`：调用失败。

### getSubscribedUserList
#### 接口描述

```cpp
virtual int getSubscribedUserList(const char* topic, UserList* users) = 0;
```

查询指定 Topic 中已订阅的消息发布者列表。

| 参数 | 描述                                                    |
| ---------| -------------------------------------------------------------- |
| `topic`   | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |
| `users`   | 已订阅的用户列表，详见  [`UserList`](#userlist)。                                                  |


#### 基本用法 （需提供示例代码）

##### 查询指定 Topic 已订阅消息发布者名单
<mark>待补充</mark>

#### 返回值
- `0`：调用成功。
- < `0`：调用失败。

## Struct

### JoinChannelOptions

```cpp
struct JoinChannelOptions {

  const char* token;

  JoinChannelOptions() : token(NULL) {}
};
```

加入频道时的配置选项。

| 参数   |描述      | 
| ------------ |  --------- |
| `token`        | （选填） 加入频道所使用的 Token。                  |


### UserList

```cpp
struct UserList {

  const char** users;

  size_t userCount;

  UserList() : users(NULL), userCount(0) {}
};
```
用户列表。

| 参数  | 描述                                   |
| --------------------------- |------------------------------------------------------- |
| `users` | 用户 ID 列表。                                                                      |
| `userCount`   | 用户数量。                                                                    |


### JoinTopicOptions


```cpp
struct JoinTopicOptions {

  RTM_MESSAGE_QOS qos;

  const char* meta;

  size_t metaLength;

  JoinTopicOptions() : qos(RTM_MESSAGE_QOS_UNORDERED), meta(NULL), metaLength(0) {}
};
```

加入 Topic 的配置选项。

| 参数 | 描述                         |
| ---------------- | ---------------- |
| `qos` | 指定后续发送 Topic 消息时的 QoS 保障，详见 [`RTM_MESSAGE_QOS`](#rtm_message_qos) 默认值为 `RTM_MESSAGE_QOS_ORDERED` 开启消息保序。  |
| `meta`   | 创建 Topic 的辅助信息。  |
| `metaLength`   |  创建 Topic 的辅助信息长度。  |

### TopicOptions


```cpp
struct TopicOptions {

  const char** users;

  size_t userCount;

  TopicOptions() : users(NULL), userCount(0) {}
};
```

订阅或取消订阅 Topic 时的配置选项。

| 参数 | 描述                         |
| ---------------- | ---------------- |
| `users`     | 该 Topic 中想要订阅的消息发布者列表，消息发布者数量不能超过 50 个。    |
| `userCount` | 订阅的消息发布者数量。     |


### TopicInfo

```cpp
struct TopicInfo {

  const char* topic;

  size_t numOfPublisher;

  const char** publisherUserIds;

  const char** publisherMetas;

  TopicInfo() : topic(NULL),
                numOfPublisher(0),
                publisherUserIds(NULL),
                publisherMetas(NULL) {}
};
```

Topic 信息。

| 参数 | 描述                                                    |
| --------- | -------------------------------------------------------------- |
| `topic`   | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |
| `numOfPublisher`   | 向该 Topic 发布消息的用户数量。 |
| `publisherUserIds`   | 向该 Topic 发布消息的用户 ID 列表。 |
| `publisherMetas`   | 发布消息的用户的 Topic 额外配置信息。 |

## Enum

### STREAM_CHANNEL_ERROR_CODE

```cpp
enum STREAM_CHANNEL_ERROR_CODE {

  STREAM_CHANNEL_ERROR_OK = 0,

  STREAM_CHANNEL_ERROR_EXCEED_LIMITATION = 1,

  STREAM_CHANNEL_ERROR_USER_NOT_EXIST = 2,
};
```

频道事件错误码。

| 枚举值    | 描述      | 
| ------------ | --------- |
| `STREAM_CHANNEL_ERROR_OK`     | 0: 操作成功。  | 
| `STREAM_CHANNEL_ERROR_EXCEED_LIMITATION`     | 1: 订阅用户数量超出限制。  | 
| `STREAM_CHANNEL_ERROR_JOIN_FAILURE`     | 2: 所订阅用户不存在。  | 


### RTM_MESSAGE_QOS

```cpp
enum RTM_MESSAGE_QOS {

  RTM_MESSAGE_QOS_UNORDERED = 0,

  RTM_MESSAGE_QOS_ORDERED = 1,
};
```

消息保序配置。

| 枚举值 |  描述                                                    |
| --------- | -------------------------------------------------------------- |
| `RTM_MESSAGE_QOS_UNORDERED`   | 0: 不开启消息保序。 |
| `RTM_MESSAGE_QOS_ORDERED`   | 1: 开启消息保序。 |



