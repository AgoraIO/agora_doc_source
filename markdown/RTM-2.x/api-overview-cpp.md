RTM 2.x 客户端 SDK 包含以下方法和回调接口：

### 初始配置

| 方法       | 描述                                       |
| ---------- | ------------------------------------------ |
| [createAgoraRtmClient](api-client-linux#createagorartmclient)| 创建 IRtmClient 实例。                   |
| [initialize](api-client-linux#initialize)| 初始化 IRtmClient 实例。                   |
| [release](api-client-linux#release)   | 销毁一个 IRtmClient 类型实例以释放资源。 |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| [onConnectionStateChange](api-client-linux#onconnectionstatechange) | SDK 连接状态发生改变时会触发该回调。     |

### 频道

| 方法                | 描述                                       |
| ------------------- | ------------------------------------------ |
| [createStreamChannel](api-client-linux#createstreamchannel) | 创建一个 Stream Channel 类型实例。       |
| [release](api-channel-linux#release)            | 销毁一个 Stream Channel 类型实例。       |
| [join](api-channel-linux#join)               | 加入频道。                                 |
| [getChannelName](api-channel-linux#getchannelname)      | 获取频道名称。                             |
| [leave](api-channel-linux#leave)               | 离开频道。                                 |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| [onJoinResult](api-client-linux#onjoinresult) | 当用户加入频道时会触发该回调。用户需收到成功的回调结果，才可继续执行和频道相关的操作。     |
| [onLeaveResult](api-client-linux#onleaveresult)    | 离开频道后时触发该回调。 |
| [onPresenceEvent](api-client-linux#onpresenceevent)  | 当频道中有用户的 Presence 状态发生变更时会触发该回调。 |

### 消息

| 方法                     | 描述                                                         |
| ------------------------ | ------------------------------------------------------------ |
| [joinTopic](api-channel-linux#jointopic)                | 加入一个 Topic。                                             |
| [leaveTopic](api-channel-linux#leavetopic)               | 离开一个 Topic。                                             |
| [publishTopicMessage](api-channel-linux#publishtopicmessage)      | 在指定 Topic 中发送文本消息。                                |
| [subscribeTopic](api-channel-linux#subscribetopic)           | 订阅 Topic 及 Topic 中的消息发送者。                         |
| [unsubscribeTopic](api-channel-linux#unsubscribetopic)         | 取消订阅某 Topic 或取消对该 Topic 中指定的消息发布者的订阅。 |
| [getSubscribedUserList](api-channel-linux#getsubscribeduserlist)    | 查询指定 Topic 中已订阅的消息发布者列表。                    |


| 回调       | 描述                                       |
| ---------- | ------------------------------------------ |
| [onMessageEvent](api-client-linux#onmessageevent) | 当你订阅的 Topic 中订阅的用户发布消息时，会触发该回调。     |
| [onJoinTopicResult](api-client-linux#onjointopicresult) | 加入 Topic 时会触发该回调。     |
| [onLeaveTopicResult](api-client-linux#onleavetopicresult) | 离开 Topic 时会触发该回调。     |
| [onTopicSubscribed](api-client-linux#ontopicsubscribed) | 订阅 Topic 或订阅 Topic 中发布消息的用户时会触发该回调。     |
| [onTopicUnsubscribed](api-client-linux#ontopicunsubscribed) | 取消订阅 Topic 或取消订阅 Topic 中发布消息的用户时会触发该回调。     |

