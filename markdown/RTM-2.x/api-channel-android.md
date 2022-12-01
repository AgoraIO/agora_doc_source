~8704dfd0-60c9-11ed-8dae-bf25bf08a626~
## 方法

### join
#### 接口描述

```java
public abstract int join(JoinChannelOptions options);
```

加入频道。

调用该接口会触发 `onJoinResult` 事件回调，成功加入后频道中的其他用户会收到 `onPresenceEvent` 的 `join` 事件回调。该接口的回调通过 [`IRtmEventHandler`](#api-client-android#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

> 注意：
> 单次调用该接口只能加入一个频道。单个客户端可以同时加入最多 100 个频道。
> 用户需要收到成功加入频道的 `onJoinResult` 回调才能继续进行频道相关的操作。

| 参数       | 描述        |
| ---------------  | ------------------ |
| `options`       | （选填）加入频道时的配置选项，详见 [`JoinChannelOptions`](#joinchanneloptions)。         |


#### 基本用法

##### 加入频道
<mark>待补充</mark>

#### 返回值
- `0 `：调用成功。
- < `0 `：调用失败。

### getChannelName
#### 接口描述

```java
public abstract String getChannelName();
```

获取当前频道名称。

#### 返回值
频道名称。

### leave
#### 接口描述

```java
public abstract int leave();
```

离开频道。

调用该接口会触发 `onLeaveResult` 事件回调，成功离开频道后频道中的其他用户会收到 `onPresenceEvent` 的 `leave` 事件通知。该接口的回调通过 [`IRtmEventHandler`](api-client-android#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

#### 基本用法

##### 离开频道
<mark>待补充</mark>

#### 返回值
- `0 `：调用成功。
- < `0 `：调用失败。                                                           

### release
#### 接口描述

```java
public abstract int release();
```
销毁一个 StreamChannel 类型实例。

如果你不再需要某个频道，可以调用该接口销毁对应的 StreamChannel 实例以释放资源。本端调用该接口销毁 StreamChannel 实例不会销毁此频道，后续可通过调用 `createStreamChannel`和 `join` 再次加入该频道。

> 注意：如果不先调用 `leave` 离开频道而直接调用 `release` 销毁频道实例，SDK 会自动调用 `Leave` 并触发对应的事件回调。

#### 基本用法

##### 离开频道
<mark>待补充</mark>

#### 返回值
- `0`：调用成功。
- <`0`：调用失败。


### joinTopic
#### 接口描述

```java
public abstract int joinTopic(String topicName, JoinTopicOptions options);
```

加入一个 Topic。

只有加入 Topic 才能执行发送 Topic 消息的操作。

调用该接口会触发 `onJoinTopicResult` 事件回调，频道中的其他用户会收到相应的 `onPresenceEvent` 事件通知。该接口的回调通过 [`IRtmEventHandler`](api-client-java#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

> 注意：
> - 请在加入频道后调用该方法。
> - 同一个客户端同时只能加入 8 个 Topic，超出数量会报错。

| 参数 | 描述                                                    |
| --------- | ------------------------------------------------- |
| `topicName`   | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |
| `options` | （选填）加入 Topic 时的配置选项，详见 [`JoinTopicOptions`](#jointopicoptions)                                             |


#### 基本用法

<mark>待补充</mark>


#### 返回值
- `0`：调用成功。
- < `0`：调用失败。

### leaveTopic
#### 接口描述

```java
public abstract int leaveTopic(String topicName);
```

离开一个 Topic。

当客户端加入的 Topic 达到上限时，需要调用 `leaveTopic` 离开某些不再需要的 Topic 以释放资源。

调用该接口会触发 `onLeaveTopicResult` 事件回调，频道中的其他用户会收到相应的 `onPresenceEvent` 事件通知。该接口的回调通过 [`IRtmEventHandler`](#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。


| 参数 | 描述                                                    |
| --------- | -------------------------------------------------------------- |
| `topicName`   | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |

#### 基本用法
<mark>待补充</mark>


#### 返回值
- `0`：调用成功。
- < `0`：调用失败。

### publishTopicMessage
#### 接口描述

```java
public abstract int publishTopicMessage(String topicName, byte[] message);
```

在指定 Topic 中发送文本消息。消息在传输的过程中默认已经被 SSL/TLS 加密，以保证数据链路层安全。

成功调用该接口后会触发 [`onMessageEvent`](#IRtmEventHandler) 事件回调，频道中订阅该 Topic 且订阅该消息发布者的用户会收到该事件回调。该接口的回调通过 [`IRtmEventHandler`](#api-client-android#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

> 注意：
> - 调用该接口前需先调用 `joinTopic` 加入 Topic。
> - 不支持同时向多个 Topic 发送同一条消息。
> - 在调用 `joinTopic` 时可将 `qos` 字段配置为 `RTM_MESSAGE_QOS_ORDERED` 以开启该 Topic 的消息保序能力。除此之外，以下行为也可有效提升消息收发的可靠性：
    - 以串行的方式发送消息。
    - 消息负载不要超过 1KiB，否则发送会失败。
    - 单个客户端在单个 Topic 中发送消息的速率上限为 60 QPS，如果发送速率超限，将会有部分消息会被丢弃。在满足要求的情况下，速率越低越好。


| 参数  | 描述                                                    |
| --------- | -------------------------------------------------------------- |
| `topicName`   | Topic 名称，同一个频道内相同的 Topic 名称代表同一个 Topic。 |
| `message` | 消息负载。  |


#### 基本用法

##### 向 Topic 中发送消息
<mark>待补充</mark>

#### 返回值
- `0`：调用成功。
- < `0`：调用失败。


### subscribeTopic
#### 接口描述

```java
public abstract int subscribeTopic(String topicName, TopicOptions options);
```

订阅 Topic 及 Topic 中的消息发送者。

`subscribeTopic` 为增量接口。例如，第一次调用该接口时，订阅消息发布者列表为 `[UserA,UserB]`  , 第二次调用该接口时，订阅消息发布者列表为 `[UserB,UserC]`，则最后成功订阅的结果是 `[UserA，UserB,UserC]`。你可以通过 [`getSubscribedUserList`](#getsubscribeduserlist) 查询当前已经订阅的消息发布者名单列表。

频道中单个 Topic 的消息发布者的数量没有上限，但对于 Topic 订阅者，目前只能同时订阅 50 个 Topic，每个 Topic 中最多 64 个消息发布者的消息。

调用该接口会触发 `onTopicSubscribed` 回调。该接口的回调通过 [`IRtmEventHandler](#api-client-android#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。
如果用户网络连接出现问题，RTM 2.0 将自动尝试重新连接，但在断连期间的消息将丢失。

| 参数    | 描述                                                    |
| ------------| -------------------------------------------------------------- |
| `topicName`      | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |
| `options`    | （选填）订阅 Topic 时的配置选项，详见 [`TopicOptions`](api-channel-android#topicoptions)。如果不填写该字段，SDK 将随机订阅该 Topic 中 64 个消息发布者；如果该 Topic 中消息发布者不超过 64 人，则订阅所有消息发布者。）                     |

#### 基本用法

##### 订阅指定用户
<mark>待补充</mark>

#### 返回值
- `0 `：调用成功。
- < `0 `：调用失败。


### unsubscribeTopic
#### 接口描述

```java
public abstract int unsubscribeTopic(String topicName, TopicOptions options);
```

取消订阅某 Topic 或取消对该 Topic 中指定的消息发布者的订阅。

调用该接口会触发 `onTopicUnsubscribed` 回调。该接口的回调通过 [`IRtmEventHandler](#api-client-android#irtmeventhandler) 处理。如需要在 App 中接收消息和事件通知，需要在调用该接口前添加 `IRtmEventHandler`。

| 参数   | 描述                                                    |
| ------------ | -------------------------------------------------------------- |
| `topic`      | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |
| `options`    | （选填）取消订阅 Topic 时的配置选项，详见 [`TopicOptions`](api-channel-android#topicoptions)。你可以指定想要取消订阅的消息发布者。如果 `options` 中配置的用户列表不在已订阅的用户名单中，API 调用会正常返回，但不会有任何变化。如果该字段为空，将取消订阅该 Topic及取消订阅该 Topic 中所有消息发布者。        |

#### 基本用法

##### 取消订阅指定用户
<mark>待补充</mark>


##### 取消订阅 Topic 
<mark>待补充</mark>


#### 返回值
- `0 `：调用成功。
- < `0 `：调用失败。

### getSubscribedUserList
#### 接口描述

```java
public abstract int getSubscribedUserList(String topicName, UserList users);
```

查询指定 Topic 中已订阅的消息发布者列表。

> 注意：请在加入频道后调用该接口。

| 参数  | 描述                                                    |
| ---------| -------------------------------------------------------------- |
| `topicName`   |  Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |
| `users`   | `UserList` 对象的引用，用于返回已订阅的用户列表。详见  [`UserList`](#userlist)。                                                  |


#### 基本用法

##### 查询指定 Topic 已订阅消息发布者名单
<mark>待补充</mark>

#### 返回值
- `0`：调用成功。
- < `0`：调用失败。


## Class

### JoinChannelOptions

```java
public class JoinChannelOptions {

  public String token;

}
```

加入频道时的配置选项。

| 参数   | 描述      | 
| ------------ | --------- |
| `token`        | string             | （选填） 加入频道所使用的 Token。                  |

### JoinTopicOptions


```java
public class JoinTopicOptions {

  public RtmMessageQos messageQos;
}
```

加入 Topic 的配置选项。

| 参数 | 描述                         |
| ---------------- | ---------------- |
| `messageQos` | 指定后续发送 Topic 消息时的 QoS 保障，详见 [`RTM_MESSAGE_QOS`](#rtm_message_qos) 默认值为 `RTM_MESSAGE_QOS_ORDERED` 开启消息保序。  |


### TopicOptions


```java
public class TopicOptions {

  public ArrayList<String> users;
}
```

订阅或取消订阅 Topic 时的配置选项。

| 参数 | 描述                         |
| ---------------- | ---------------- |
| `users`     | 该 Topic 中想要订阅的消息发布者列表，消息发布者数量不能超过 64 个。    |


### TopicInfo

```java
public class TopicInfo {

  public String topicName;

  public ArrayList<String> publisherUserIds;
}
```

Topic 信息。

| 参数 | 描述                                                    |
| --------- | -------------------------------------------------------------- |
| `topicName`   | Topic 名称，同一个频道内相同的 Topic 名称属于同一个 Topic。 |
| `publisherUserIds`   | 向该 Topic 发布消息的用户 ID 列表。 |

### UserList

```java
public class UserList {

  public ArrayList<String> users;
};
```
用户列表。

| 参数  | 描述  |
| ----------- |  --- | 
| `users` | 用户 ID 列表。    |

## Enum

### STREAM_CHANNEL_ERROR_CODE

频道错误码。

```java
public static final int STREAM_CHANNEL_ERROR_OK = 0;

public static final int STREAM_CHANNEL_ERROR_EXCEED_LIMITATION = 1;

public static final int STREAM_CHANNEL_ERROR_USER_NOT_EXIST = 2;
```

| 枚举值    | 描述      | 
| ------------ | --------- |
| `STREAM_CHANNEL_ERROR_OK`     | 0: 操作成功。  | 
| `STREAM_CHANNEL_ERROR_EXCEED_LIMITATION`     | 1: 订阅用户数量超出限制。  | 
| `STREAM_CHANNEL_ERROR_JOIN_FAILURE`     | 2: 所订阅用户不存在。  | 


### RtmMessageQos

```cpp
  public enum RtmMessageQos {

    RTM_MESSAGE_QOS_UNORDERED(0),

    RTM_MESSAGE_QOS_ORDERED(1);
  }
```

消息保序配置。

| 枚举值 |  描述                                                    |
| --------- | -------------------------------------------------------------- |
| `RTM_MESSAGE_QOS_UNORDERED`   | 0: 不开启消息保序。 |
| `RTM_MESSAGE_QOS_ORDERED`   | 1: 开启消息保序。 |

