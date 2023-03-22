RTM 2.x 客户端 SDK 包含以下方法和回调接口：

### 初始配置

| 方法       | 描述                                       |
| ---------- | ------------------------------------------ |
| [Initialize](api-client-unity#initialize)| 初始化 IRtmClient 实例。                   |
| [Release](api-client-unity#release)   | 销毁一个 IRtmClient 类型实例以释放资源。 |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| [OnConnectionStateChange](api-client-unity#onconnectionstatechange) | SDK 连接状态发生改变时会触发该回调。     |

### 频道

| 方法                | 描述                                       |
| ------------------- | ------------------------------------------ |
| [CreateStreamChannel](api-client-unity#createstreamchannel) | 创建一个 Stream Channel 类型实例。       |
| [Release](api-channel-unity#release)            | 销毁一个 Stream Channel 类型实例。       |
| [Join](api-channel-unity#join)               | 加入频道。                                 |
| [GetChannelName](api-channel-unity#getchannelname)      | 获取频道名称。                             |
| [Leave](api-channel-unity#leave)               | 离开频道。                                 |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| [OnJoinResult](api-client-unity#onjoinresult) | 当用户加入频道时会触发该回调。用户需收到成功的回调结果，才可继续执行和频道相关的操作。     |
| [OnLeaveResult](api-client-unity#onleaveresult)    | 离开频道后时触发该回调。 |
| [OnPresenceEvent](api-client-unity#onpresenceevent)  | 当频道中有用户的 Presence 状态发生变更时会触发该回调。 |

### 消息

| 方法                     | 描述                                                         |
| ------------------------ | ------------------------------------------------------------ |
| [JoinTopic](api-channel-unity#jointopic)                | 加入一个 Topic。                                             |
| [LeaveTopic](api-channel-unity#leavetopic)               | 离开一个 Topic。                                             |
| [PublishTopicMessage[1/2]](api-channel-unity#publishtopicmessage12)      | 在指定 Topic 中发送文本消息。                                |
| [PublishTopicMessage[2/2]](api-channel-unity#publishtopicmessage22)      | 在指定 Topic 中发送文本消息。                                |
| [SubscribeTopic](api-channel-unity#subscribetopic)           | 订阅 Topic 及 Topic 中的消息发送者。                         |
| [UnsubscribeTopic](api-channel-unity#unsubscribetopic)         | 取消订阅某 Topic 或取消对该 Topic 中指定的消息发布者的订阅。 |
| [GetSubscribedUserList](api-channel-unity#getsubscribeduserlist)    | 查询指定 Topic 中已订阅的消息发布者列表。                    |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| [OnMessageEvent](api-client-unity#onmessageevent) | 当你订阅的 Topic 中订阅的用户发布消息时，会触发该回调。     |
| [OnJoinTopicResult](api-client-unity#onjointopicresult) | 加入 Topic 时会触发该回调。     |
| [OnLeaveTopicResult](api-client-unity#onleavetopicresult) | 离开 Topic 时会触发该回调。     |
| [OnTopicSubscribed](api-client-unity#ontopicsubscribed) | 订阅 Topic 或订阅 Topic 中发布消息的用户时会触发该回调。     |
| [OnTopicUnsubscribed](api-client-unity#ontopicunsubscribed) | 取消订阅 Topic 或取消订阅 Topic 中发布消息的用户时会触发该回调。     |

