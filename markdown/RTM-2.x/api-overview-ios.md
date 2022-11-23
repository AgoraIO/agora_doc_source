RTM 2.x 客户端 SDK 包含以下方法和回调接口：

### 初始配置

| 方法       | 描述                                       |
| ---------- | ------------------------------------------ |
| initWithConfig| 初始化 IRtmClient 实例。                   |
| destroy       | 销毁一个 `IRtmClient` 类型实例以释放资源。 |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| connectionStateChange | SDK 连接状态发生改变时会触发该回调。     |

### 频道

| 方法                | 描述                                       |
| ------------------- | ------------------------------------------ |
| createStreamChannel | 创建一个 `IStreamChannel` 类型实例。       |
| destroy             | 销毁一个 `IStreamChannel` 类型实例。       |
| joinWithOption      | 加入频道。                                 |
| getChannelName      | 获取频道名称。                             |
| leave              | 离开频道。                                 |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| joinChannel     | 当用户加入频道时会触发该回调。用户需收到成功的回调结果，才可继续执行和频道相关的操作。     |
| leaveChannel    | 离开频道后时触发该回调。 |
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
| onMessageEvent | 当你订阅的 Topic 中订阅的用户发布消息时，会触发该回调。     |
| joinTopic | 加入 Topic 时会触发该回调。     |
| leaveTopic | 离开 Topic 时会触发该回调。     |
| subscribe | 订阅 Topic 或订阅 Topic 中发布消息的用户时会触发该回调。     |
| unsubscribe | 取消订阅 Topic 或取消订阅 Topic 中发布消息的用户时会触发该回调。     |
