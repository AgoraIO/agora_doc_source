~8704dfd0-60c9-11ed-8dae-bf25bf08a626~

## 方法

### Join
#### 接口描述

```csharp
public abstract int Join(JoinChannelOptions options);
```

加入频道。

成功调用该接口后会触发 `OnJoinResult` 事件回调和 `OnPresenceEvent` 事件回调，频道中的其他用户会收到 `join` 事件通知。该接口的回调通过 [`IRtmEventHandler`](#api-config-unity#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

> 注意：
> 单次调用该接口只能加入一个频道。单个客户端可以同时加入最多 100 个频道。

| 参数       | 描述        |
| --------------- | ------------------ |
| `options`       | （选填）加入频道时的配置选项，详见 [`JoinChannelOptions`](#joinchanneloptions)。         |


#### 基本用法

##### 加入频道
```csharp
loc_stChannel = rtmClient.CreateStreamChannel("Location");
// 创建一个 JoinChannelOptions 示例。
JoinChannelOptions joinChannelOptions =new JoinChannelOptions() ;
// 订阅他人的 Presence 事件。
joinChannelOptions.withPresence = true;
// 订阅频道属性。
joinChannelOptions.withMetaData = true;
// 加入频道名为 Location 的频道。
loc_stChannel.Join(joinChannelOptions);
```

#### 返回值
- `0 `：调用成功。
- < `0 `：调用失败。

### GetChannelName
#### 接口描述

```csharp
public abstract string GetChannelName();
```

获取频道名称。


#### 返回值
频道名称。

### Leave
#### 接口描述

```csharp
public abstract int Leave();
```

离开频道。

成功调用该接口后会触发 `OnLeaveResult` 事件回调和 `OnPresenceEvent` 事件回调，频道中的其他用户会收到 `leave` 事件通知。该接口的回调通过 [`IRtmEventHandler`](api-config-unity#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

#### 基本用法

##### 离开频道
```csharp
loc_stChannel = rtmClient.CreateStreamChannel("Location");
// 创建一个 JoinChannelOptions 示例。
JoinChannelOptions joinChannelOptions =new JoinChannelOptions() ;
// 订阅他人的 Presence 事件。
joinChannelOptions.withPresence = true;
// 订阅频道属性。
joinChannelOptions.withMetaData = true;
// 加入频道名为 Location 的频道。
loc_stChannel.Join(joinChannelOptions);
// 在这里加入你的实现代码。
// 离开 Location 频道。
loc_stChannel.Leave();
```

#### 返回值
- `0 `：调用成功。
- < `0 `：调用失败。                                                             

### Release
#### 接口描述

```csharp
public abstract int Release();
```
销毁一个 `IStreamChannel` 类型实例。

如果你不再需要某个频道，可以调用该接口销毁对应的 `IStreamChannel` 实例以释放资源。本端调用该接口销毁 `IStreamChannel` 实例不会销毁此频道，后续可通过调用 `CreateStreamChannel`和 `Join` 再次加入该频道。

> 注意：如果不先调用 `Leave` 离开频道而直接调用 `Release` 销毁频道实例，SDK 会自动调用 `Leave` 并触发对应的事件回调。

#### 基本用法

##### 离开频道

```csharp
loc_stChannel = rtmClient.CreateStreamChannel("Location");
// 创建一个 JoinChannelOptions 示例。
JoinChannelOptions joinChannelOptions =new JoinChannelOptions() ;
// 订阅他人的 Presence 事件。
joinChannelOptions.withPresence = true;
// 订阅频道属性。
joinChannelOptions.withMetaData = true;
// 加入频道名为 Location 的频道。
loc_stChannel.Join(joinChannelOptions);
// 在这里加入你的实现代码。
// 离开 Location 频道。
loc_stChannel.Leave();
// 销毁 Location 频道对应的 `IStreamChannel` 实例。
loc_stChannel.Release();
```

#### 返回值
- `0 `：调用成功。
- < `0 `：调用失败。

### JoinTopic
#### 接口描述

```csharp
public abstract int JoinTopic(string topic, JoinTopicOptions options);
```

加入一个 Topic。

只有加入 Topic 才能执行发送 Topic 消息的操作。

调用该接口成功后会触发对应的 Presence 事件，该频道的参与者会收到相应的事件通知。该接口的回调通过 [`IRtmEventHandler`](api-config-unity#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

> 注意：同一个客户端同时只能加入 8 个 Topic，超出数量会报错。

| 参数 |描述                                                    |
| --------- | ---------------------------------------------------------- |
| `topic`   | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |
| `options` | （选填）加入 Topic 时的配置选项，详见 [`JoinTopicOptions`](#jointopicoptions)                                             |


#### 基本用法

##### 加入Topic

```csharp
// 创建一个 JoinTopicOptions 实例。
JoinTopicOptions joinTopicOptions = new JoinTopicOptions() ;
// QoS 保障设置为消息保序。
joinTopicOptions.qos = RTM_MESSAGE_QOS.RTM_MESSAGE_QOS_ORDERED ;
// 加入名为 gesture 的 Topic。
loc_stChannel.JoinTopic( "gesture",joinTopicOptions) ;
```


#### 返回值
- `0 `：调用成功。
- < `0 `：调用失败。

### LeaveTopic
#### 接口描述

```csharp
public abstract int LeaveTopic(string topic);
```

离开一个 Topic。

当客户端加入的 Topic 达到上限时，需要调用 `LeaveTopic` 离开某些不再需要的 Topic 以释放资源。调用成功会触发对应的 `Presence` 事件，该频道的参与者会收到相应的事件通知。该接口的回调通过 [`IRtmEventHandler`](#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。


| 参数 |描述                                                    |
| ---------  | -------------------------------------------------------------- |
| `topic`   | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |

#### 基本用法

```csharp
// 离开名为 gesture 的 Topic。
loc_stChannel.LeaveTopic( "gesture") ;
```

#### 返回值
- `0 `：调用成功。
- < `0 `：调用失败。

### PublishTopicMessage[1/2]
#### 接口描述

```csharp
public abstract int PublishTopicMessage(string topic, string message);
```

在指定 Topic 中发送文本消息。消息在传输的过程中默认已经被 SSL/TLS 加密，以保证数据链路层安全。

成功调用该接口后会触发 [`OnMessageEvent`](#IRtmEventHandler) 事件回调，频道中订阅该 Topic 且订阅该消息发布者的用户会收到该事件回调。该接口的回调通过 [`IRtmEventHandler](#api-config-unity#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

> 注意：
> - 调用该接口前需先调用 `JoinTopic` 加入 Topic。
> - 不支持同时向多个 Topic 发送同一条消息。
> - 在调用 `JoinTopic` 时可将 `qos` 字段配置为 `RTM_MESSAGE_QOS_ORDERED` 以开启该 Topic 的消息保序能力。除此之外，以下行为也可有效提升消息收发的可靠性：
    - 以串行的方式发送消息。
    - 消息负载不要超过 1KiB，否则发送会失败。
    - 单个客户端在单个 Topic 中发送消息的速率上限为 60 QPS，如果发送速率超限，将会有部分消息会被丢弃。在满足要求的情况下，速率越低越好。


| 参数 | 描述                                                   |
| ---------| -------------------------------------------------------------- |
| `topic`   | Topic 名称，同一个频道内相同的 Topic 名称代表同一个 Topic。 |
| `message` |  消息负载，可为任意单字节或多字节 UTF-8 字符。SDK 会自动对消息负载进行序列化。  |


#### 基本用法

##### 向 Topic 中发送消息
```csharp
// 创建一个 JoinTopicOptions 实例。
JoinTopicOptions joinTopicOptions = new JoinTopicOptions() ;
// 配置 QoS 保障。
joinTopicOptions.qos = RTM_MESSAGE_QOS.RTM_MESSAGE_QOS_ORDERED ;
// 加入名为 gesture 的 Topic。
loc_stChannel.JoinTopic( "gesture",joinTopicOptions) ;
```

#### 返回值
- `0`：调用成功。
- < `0`：调用失败。

### PublishTopicMessage[2/2]
#### 接口描述

```csharp
public abstract int PublishTopicMessage(string topic, byte[] message);
```

在指定 Topic 中发送二进制消息。消息在传输的过程中默认已经被 SSL/TLS 加密，以保证数据链路层安全。

成功调用该接口后会触发 [`OnMessageEvent`](#IRtmEventHandler) 事件回调，频道中订阅该 Topic 且订阅该消息发布者的用户会收到该事件回调。该接口的回调通过 [`IRtmEventHandler](#api-config-unity#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

> 注意：
> - 调用该接口前需先调用 `JoinTopic` 加入 Topic。
> - 不支持同时向多个 Topic 发送同一条消息。
> - 在调用 `JoinTopic` 时可将 `qos` 字段配置为 `RTM_MESSAGE_QOS_ORDERED` 以开启该 Topic 的消息保序能力。除此之外，以下行为也可有效提升消息收发的可靠性：
    - 以串行的方式发送消息。
    - 消息负载不要超过 1KiB，否则发送会失败。
    - 单个客户端在单个 Topic 中发送消息的速率上限为 60 QPS，如果发送速率超限，将会有部分消息会被丢弃。在满足要求的情况下，速率越低越好。

| 参数 | 描述                          |
| ---------| -------------------------------------------------------------- |
| `topic`   | Topic 名称，同一个频道内相同的 Topic 名称代表同一个 Topic。 |
| `message` | 消息负载，可为任意二进制数据。SDK 会自动对消息负载进行序列化。  |


#### 基本用法
##### 向 Topic 中发送消息

#### 返回值
- `0`：调用成功。
- < `0`：调用失败。

### SubscribeTopic
#### 接口描述

```csharp
public abstract int SubscribeTopic(string topic, TopicOptions options);
```

订阅 Topic 及 Topic 中的消息发送者。

`SubscribeTopic` 为增量接口。例如，第一次调用该接口时，订阅消息发布者列表为 `[UserA,UserB]`  , 第二次调用该接口时，订阅消息发布者列表为 `[UserB,UserC]`，则最后成功订阅的结果是 `[UserA，UserB,UserC]`。你可以通过 [`GetSubscribedUserList`](#getsubscribeduserlist) 查询当前已经订阅的消息发布者名单列表。

频道中单个 Topic 的消息发布者的数量没有上限，但对于 Topic 订阅者，目前只能同时订阅单个 Topic 中最多 50 个消息发布者的消息。

该接口的回调通过 [`IRtmEventHandler](#api-config-unity#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

你的 APP 可以通过 `IRtmEventHandler` 收到消息和事件通知，`IRtmEventHandler`  是你的 APP 中接收你订阅的 Topic 消息及事件的唯一入口点。默认情况下，你只能收取到 `SubscribeTopic` 调用成功后的消息和事件通知。如果用户网络连接出现问题，RTM 2.0 将自动尝试重新连接，但在断连期间的消息将丢失。


| 参数    | 描述                                                    |
| ------------| ------------------------------------------------------------- |
| `topic`      | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |
| `options`    | （选填）订阅 Topic 时的配置选项，详见 [`TopicOptions`](api-topic-unity#topicoptions)。如果不填写该字段，SDK 将随机订阅该 Topic 中 50 个消息发布者；如果该 Topic 中消息发布者不超过 50 人，则订阅所有消息发布者。                  |


#### 基本用法

##### 订阅指定用户
```csharp
// 创建一个 TopicOptions 实例。
TopicOptions topicOptions = new TopicOptions();
// 订阅消息发布者：Tony 和 Mary。
topicOptions.users = ["Tony","Mary"];
 // 消息发布者数量为 2。
topicOptions.userCount = 2;
// 订阅名为 gesture 的 Topic，并且订阅消息发布者 Tony 和 Mary。
loc_stChannel.SubscribeTopic( "gesture",topicOptions) ;
// 订阅消息发布者：Lily 和 Jason。
topicOptions.users = ["Lily","Jason"];
 // 消息发布者数量为 2。
topicOptions.userCount = 2;
// 订阅名为 gesture 的 Topic，并且订阅消息发布者 Lily 和 Jason。
// 现在你已订阅了 Tony，Mary，Lily 和 Jason。
loc_stChannel.SubscribeTopic( "gesture",topicOptions) ;
```

#### 返回值
- `0`：调用成功。
- < `0`：调用失败。


### UnsubscribeTopic
#### 接口描述

```csharp
public abstract int UnsubscribeTopic(string topic, TopicOptions options);
```

取消订阅某 Topic 或取消对该 Topic 中指定的消息发布者的订阅。

该接口的回调通过 [`IRtmEventHandler](#api-config-unity#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

| 参数    | 描述                                                    |
| ------------| -------------------------------------------------------------- |
| `topic`      | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |
| `options`    | （选填）取消订阅 Topic 时的配置选项，详见 [`TopicOptions`](api-topic-unity#topicoptions)。你可以指定想要取消订阅的消息发布者。如果 `options` 中配置的用户列表不在已订阅的用户名单中，API 调用会正常返回，但不会有任何变化。如果该字段为空，将取消订阅该 Topic及取消订阅该 Topic 中所有消息发布者。        |


#### 基本用法

##### 取消订阅指定用户

```csharp
// 创建一个 TopicOptions 实例。
TopicOptions topicOptions = new TopicOptions();
// 取消订阅消息发布者：Tony 和 Mary。
topicOptions.users = ["Tony","Mary"];
// 取消名为 gesture 的 Topic 中的消息发布者 Tony 和 Mary。
loc_stChannel.UnsubscribeTopic( "gesture",topicOptions) ;
```

##### 取消订阅 Topic 

```csharp
// 取消订阅名为 gesture 的 Topic 及取消订阅该 Topic 中所有消息发布者。
loc_stChannel.UnsubscribeTopic( "gesture") ;
```


#### 返回值
- `0`：调用成功。
- < `0`：调用失败。

### GetSubscribedUserList
#### 接口描述

```csharp
public abstract int GetSubscribedUserList(string topic, ref UserList users);
```

查询指定 Topic 中已订阅的消息发布者列表。


| 参数 | 描述                                                    |
| ---------| -------------------------------------------------------------- |
| `topic`   | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |
| `users`   | 已订阅的用户列表，详见  [`UserList`](#userlist)。                                                  |


#### 基本用法

```csharp
//创建一个 UserList 实例。
UserList userList = new UserList();
// 获取名为 gesture 的 Topic 中已订阅的消息发布者列表。
loc_stChannel.GetSubscribedUserList("gesture",userList);
// 打印已订阅消息发布者数量。
Debug.Log("You have Subscribed" + userList.userCount + "Publishers");
// 打印已订阅消息发布者信息列表。
Debug.Log("They are  " + userList.users);
```

#### 返回值
- `0`：调用成功。
- < `0`：调用失败。

## Class

### JoinChannelOptions

```csharp
public class JoinChannelOptions
{
    public JoinChannelOptions()
    {
        this.token = "";
    }
    public string token { set; get; }
};
```

加入频道时的配置选项。

| 参数   | 描述      | 
| ------------ |  --------- |
| `token`        | （选填） 加入频道所使用的 Token。                  |



### JoinTopicOptions
#### 接口描述

```csharp
public class JoinTopicOptions
{ 
    public RTM_MESSAGE_QOS qos { set; get; }

    public IntPtr meta { set; get; }

    public uint metaLength { set; get; }
};
```

加入 Topic 的配置选项。

| 参数 | 描述                         |
| ---------------- | ---------------- |
| `qos` | 指定后续发送 Topic 消息时的 QoS 保障，详见 [`RTM_MESSAGE_QOS`](#rtm_message_qos) 默认值为 `RTM_MESSAGE_QOS_ORDERED` 开启消息保序。  |
| `meta`   |  创建 Topic 的辅助信息。  |
| `metaLength`   |  创建 Topic 的辅助信息长度。  |

### TopicOptions
#### 接口描述

```csharp
public class TopicOptions
{
    public string[] users { set; get; }

    public uint userCount { set; get; }
};
```

订阅或取消订阅 Topic 时的配置选项。

| 参数 | 描述                         |
| ---------------- | ---------------- |
| `users`    | 该 Topic 中想要订阅的消息发布者列表，消息发布者数量不能超过 50 个。              |
| `userCount` | 订阅的消息发布者数量。                                                  |


### TopicInfo
#### 接口描述

```csharp
    public class Agora.Rtm.TopicInfo
    {

        public string topic { set; get; }

        public uint numOfPublisher { set; get; }

        public string[] publisherUserIds { set; get; }

        public string[] publisherMetas { set; get; }
    };
```

Topic 信息。

| 参数 | 描述                                                    |
| --------- | ------------------------------------------------------------ |
| `topic`   | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |
| `numOfPublisher`   | 向该 Topic 发布消息的用户数量。 |
| `publisherUserIds`   | 向该 Topic 发布消息的用户 ID 列表。 |
| `publisherMetas`   | 发布消息的用户的 Topic 额外配置信息。 |

### TopicSubUsersUpdated
#### 接口描述

Topic 中订阅的用户更新。

```csharp
public class TopicSubUsersUpdated
{
    public string topic { set; get; }

    public string[] succeedUsers { set; get; }

    public uint succeedUserCount { set; get; }

    public string[] failedUsers { set; get; }

    public uint failedUserCount { set; get; }
};
```

| 参数 | 描述                                                    |
| --------- | -------------------------------------------------------------- |
| `topic`   | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |
| `succeedUsers`   | 成功更新订阅情况的用户 ID 列表。 |
| `succeedUserCount`   | 成功更新订阅情况的用户数量。 |
| `failedUsers`   | 订阅情况更新失败的用户 ID 列表。 |
| `failedUserCount`   | 订阅情况更新失败的用户数量。 |


### UserList
#### 接口描述

```csharp
public class UserList
{
    public string[] users { set; get; }

    public uint userCount { set; get; }
};
```

用户列表。

| 参数  | 描述    |
| --------------------------------- |---------------------------------------------------- |
| `users` | 用户 ID 列表。                                                                      |
| `userCount`   | 用户数量。                                                                    |


## Enum

### STREAM_CHANNEL_ERROR_CODE

```csharp
public enum STREAM_CHANNEL_ERROR_CODE
{
    STREAM_CHANNEL_ERROR_OK = 0,
    STREAM_CHANNEL_ERROR_INVALID_ARGUMENT = 1,
    STREAM_CHANNEL_ERROR_JOIN_FAILURE = 2,
    STREAM_CHANNEL_ERROR_JOIN_REJECTED = 3,
    STREAM_CHANNEL_ERROR_REJOIN_FAILURE = 4,
    STREAM_CHANNEL_ERROR_LEAVE_FAILURE = 5,
    STREAM_CHANNEL_ERROR_EXCEED_LIMITATION = 6,
};
```

频道错误码。

| 枚举值    | 描述      | 
| ------------ | --------- |
| `STREAM_CHANNEL_ERROR_OK`     | 操作成功。  | 
| `STREAM_CHANNEL_ERROR_INVALID_ARGUMENT`     | 参数错误。  | 
| `STREAM_CHANNEL_ERROR_JOIN_FAILURE`     | 加入频道失败。  | 
| `STREAM_CHANNEL_ERROR_JOIN_REJECTED`     | 加入频道被拒绝。  | 
| `STREAM_CHANNEL_ERROR_REJOIN_FAILURE`     | 重新加入频道失败。  | 
| `STREAM_CHANNEL_ERROR_LEAVE_FAILURE`     | 离开频道失败。  | 
| `STREAM_CHANNEL_ERROR_EXCEED_LIMITATION`     | 超出限制。  | 


### RTM_MESSAGE_QOS


消息保序配置。

```csharp
public enum RTM_MESSAGE_QOS
{
    RTM_MESSAGE_QOS_UNORDERED = 0,

    RTM_MESSAGE_QOS_ORDERED = 1,
};
```

| 枚举值 |  描述                                                    |
| --------- | -------------------------------------------------------------- |
| `RTM_MESSAGE_QOS_UNORDERED`   | 0: 不开启消息保序。 |
| `RTM_MESSAGE_QOS_ORDERED`   | 1: 开启消息保序。 |


