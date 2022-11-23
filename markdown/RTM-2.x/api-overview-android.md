RTM 2.x 客户端 SDK 包含以下方法和回调接口：

### 初始配置

| 方法       | 描述                                       |
| ---------- | ------------------------------------------ |
| [create](api-client-android#create)| 创建 RtmClient 实例。                   |
| [initialize](api-client-android#initialize)| 初始化 RtmClient 实例。                   |
| [release](api-client-android#release)   | 销毁一个 RtmClient 类型实例以释放资源。 |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| [onConnectionStateChange](api-client-android#onconnectionstatechange) | SDK 连接状态发生改变时会触发该回调。     |

### 频道

| 方法                | 描述                                       |
| ------------------- | ------------------------------------------ |
| [createStreamChannel](api-client-android#createstreamchannel) | 创建一个 StreamChannel 类型实例。       |
| [release](api-channel-android#release)            | 销毁一个 StreamChannel 类型实例。       |
| [join](api-channel-android#join)               | 加入频道。                                 |
| [getChannelName](api-channel-android#getchannelname)      | 获取频道名称。                             |
| [leave](api-channel-android#leave)               | 离开频道。                                 |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| onJoinResult | 当用户加入频道时会触发该回调。用户需收到成功的回调结果，才可继续执行和频道相关的操作。     |
| onLeaveResult    | 离开频道后时触发该回调。 |
| onPresenceEvent  | 当频道中有用户的 Presence 状态发生变更时会触发该回调。 |

### 消息

| 方法                     | 描述                                                         |
| ------------------------ | ------------------------------------------------------------ |
| joinTopic                | 加入一个 Topic。                                             |
| leaveTopic               | 离开一个 Topic。                                             |
| publishTopicMessage      | 在指定 Topic 中发送文本消息。                                |
| subscribeTopic           | 订阅 Topic 及 Topic 中的消息发送者。                         |
| unsubscribeTopic         | 取消订阅某 Topic 或取消对该 Topic 中指定的消息发布者的订阅。 |
| getSubscribedUserList    | 查询指定 Topic 中已订阅的消息发布者列表。                    |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| [onMessageEvent](api-client-android#onmessageevent) | 当你订阅的 Topic 中订阅的用户发布消息时，会触发该回调。     |
| [onJoinTopicResult](api-client-android#onjointopicresult) | 加入 Topic 时会触发该回调。     |
| [onLeaveTopicResult](api-client-android#onleavetopicresult) | 离开 Topic 时会触发该回调。     |
| [onTopicSubscribed](api-client-android#ontopicsubscribed) | 订阅 Topic 或订阅 Topic 中发布消息的用户时会触发该回调。     |
| [onTopicUnsubscribed](api-client-android#ontopicunsubscribed) | 取消订阅 Topic 或取消订阅 Topic 中发布消息的用户时会触发该回调。     |

