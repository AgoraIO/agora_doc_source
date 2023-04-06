RTM 2.x 客户端 SDK 包含以下方法和回调接口：

### 初始配置

| 方法       | 描述                                       |
| ---------- | ------------------------------------------ |
| [initWithConfig](api-client-ios#initwithconfig)| 初始化 RtmClient 实例。                   |
| [destroy](api-client-ios#destroy)   | 销毁一个 RtmClient 类型实例以释放资源。 |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| [connectionStateChange](api-client-ios#connectionstatechange) | SDK 连接状态发生改变时会触发该回调。     |

### 频道

| 方法                | 描述                                       |
| ------------------- | ------------------------------------------ |
| [createStreamChannel](api-client-ios#createstreamchannel) | 创建一个 Stream Channel 类型实例。       |
| [destroy](api-channel-ios#destroy)            | 销毁一个 Stream Channel 类型实例。       |
| [joinWithOption](api-channel-ios#joinwithoption)               | 加入频道。                                 |
| [getChannelName](api-channel-ios#getchannelname)      | 获取频道名称。                             |
| [leave](api-channel-ios#leave)               | 离开频道。                                 |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| [joinResult](api-client-ios#onjoinresult) | 当用户加入频道时会触发该回调。用户需收到成功的回调结果，才可继续执行和频道相关的操作。     |
| [leaveResult](api-client-ios#onleaveresult)    | 离开频道后时触发该回调。 |
| [OnPresenceEvent](api-client-ios#onpresenceevent)  | 当频道中有用户的 Presence 状态发生变更时会触发该回调。 |

### 消息

| 方法                     | 描述                                                         |
| ------------------------ | ------------------------------------------------------------ |
| [joinTopic](api-channel-ios#jointopic)                | 加入一个 Topic。                                             |
| [leaveTopic](api-channel-ios#leavetopic)               | 离开一个 Topic。                                             |
| [publishTopicMessage](api-channel-ios#publishtopicmessage)      | 在指定 Topic 中发送文本消息。                                |
| [subscribeTopic](api-channel-ios#subscribetopic)           | 订阅 Topic 及 Topic 中的消息发送者。                         |
| [unsubscribeTopic](api-channel-ios#unsubscribetopic)         | 取消订阅某 Topic 或取消对该 Topic 中指定的消息发布者的订阅。 |
| [getSubscribedUserList](api-channel-ios#getsubscribeduserlist)    | 查询指定 Topic 中已订阅的消息发布者列表。                    |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| [OnMessageEvent](api-client-ios#onmessageevent) | 当你订阅的 Topic 中订阅的用户发布消息时，会触发该回调。     |
| [joinTopic](api-client-ios#jointopic) | 加入 Topic 时会触发该回调。     |
| [leaveTopic](api-client-ios#leavetopic) | 离开 Topic 时会触发该回调。     |
| [subscribe](api-client-ios#subscribe) | 订阅 Topic 或订阅 Topic 中发布消息的用户时会触发该回调。     |
| [unsubscribe](api-client-ios#unsubscribe) | 取消订阅 Topic 或取消订阅 Topic 中发布消息的用户时会触发该回调。     |