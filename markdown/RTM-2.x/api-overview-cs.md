RTM 2.x 客户端 SDK 包含以下方法和回调接口：

### 初始配置

| 方法       | 描述                                       |
| ---------- | ------------------------------------------ |
| Initialize | 初始化 IRtmClient 实例。                   |
| Release    | 销毁一个 `IRtmClient` 类型实例以释放资源。 |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| OnConnectionStateChange | SDK 连接状态发生改变时会触发该回调。     |

### 频道

| 方法                | 描述                                       |
| ------------------- | ------------------------------------------ |
| CreateStreamChannel | 创建一个 `IStreamChannel` 类型实例。       |
| Release             | 销毁一个 `IStreamChannel` 类型实例。       |
| Join                | 加入频道。                                 |
| GetChannelName      | 获取频道名称。                             |
| Leave               | 离开频道。                                 |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| OnJoinResult | 当用户加入频道时会触发该回调。用户需收到成功的回调结果，才可继续执行和频道相关的操作。     |
| OnLeaveResult    | 离开频道后时触发该回调。 |
| OnPresenceEvent  | 当频道中有用户的 Presence 状态发生变更时会触发该回调。 |

### 消息

| 方法                     | 描述                                                         |
| ------------------------ | ------------------------------------------------------------ |
| JoinTopic                | 加入一个 Topic。                                             |
| LeaveTopic               | 离开一个 Topic。                                             |
| PublishTopicMessage[1/2] | 在指定 Topic 中发送文本消息。                                |
| PublishTopicMessage[1/2] | 在指定 Topic 中发送二进制消息。                              |
| SubscribeTopic           | 订阅 Topic 及 Topic 中的消息发送者。                         |
| UnsubscribeTopic         | 取消订阅某 Topic 或取消对该 Topic 中指定的消息发布者的订阅。 |
| GetSubscribedUserList    | 查询指定 Topic 中已订阅的消息发布者列表。                    |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| OnMessageEvent | 当你订阅的 Topic 中订阅的用户发布消息时，会触发该回调。     |
| OnJoinTopicResult | 加入 Topic 时会触发该回调。     |
| OnLeaveTopicResult | 离开 Topic 时会触发该回调。     |
| OnTopicSubscribed | 订阅 Topic 或订阅 Topic 中发布消息的用户时会触发该回调。     |
| OnTopicUnsubscribed | 取消订阅 Topic 或取消订阅 Topic 中发布消息的用户时会触发该回调。     |

