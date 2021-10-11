## ChatContext

`ChatContext` 类提供可供 App 调用的消息聊天相关方法。

### sendLocalChannelMessage

```kotlin
abstract fun sendLocalChannelMessage(message: String, timestamp: Long,
                                     callback: EduContextCallback<EduContextChatItemSendResult>): EduContextChatItem
```

发送课堂消息。

| 参数        | 描述                                              |
| :---------- | :------------------------------------------------ |
| `message`   | 消息内容。                                        |
| `timestamp` | 发送消息的时间戳。                                |
| `callback`  | 通过 `EduContextCallback ` 异步获取消息发送结果。 |

### fetchChannelHistory

```kotlin
abstract fun fetchChannelHistory(startId: String?, count: Int? = 50, callback: EduContextCallback<List<EduContextChatItem>>)
```

获取历史课堂消息。

| 参数       | 描述                                          |
| :--------- | :-------------------------------------------- |
| `startId`  | 传入 `messageId`，表示从哪条消息开始获取。    |
| `count`    | 想要获取的消息条数。                          |
| `callback` | 通过 `EduContextCallback ` 异步获取历史消息。 |

### sendConversationMessage

```kotlin
abstract fun sendConversationMessage(message: String, timestamp: Long,
                                     callback: EduContextCallback<EduContextChatItemSendResult>): EduContextChatItem
```

发送提问消息。

| 参数        | 描述                                              |
| :---------- | :------------------------------------------------ |
| `message`   | 消息内容。                                        |
| `timestamp` | 发送消息的时间戳。                                |
| `callback`  | 通过 `EduContextCallback ` 异步获取消息发送结果。 |

### fetchConversationHistory

```kotlin
abstract fun fetchConversationHistory(startId: String?, callback: EduContextCallback<List<EduContextChatItem>>)
```

获取历史提问消息。

| 参数       | 描述                                          |
| :--------- | :-------------------------------------------- |
| `startId`  | 传入 `messageId`，表示从哪条消息开始获取。    |
| `callback` | 通过 `EduContextCallback ` 异步获取历史消息。 |

## IChatHandler

`IChatHandler` 类用于向 App 报告消息聊天相关的事件回调。

### onReceiveMessage

```kotlin
fun onReceiveMessage(item: EduContextChatItem)
```

收到课堂消息。

| 参数   | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| `item` | 聊天消息对象，详见 [EduContextChatItem](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextchatitem)。 |

### onReceiveChatHistory

```kotlin
fun onReceiveChatHistory(history: List<EduContextChatItem>)
```

历史课堂消息已更新。

| 参数      | 描述                                                         |
| :-------- | :----------------------------------------------------------- |
| `history` | 由多个聊天消息对象组成的数组，详见 [EduContextChatItem](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextchatitem)。 |

### onReceiveConversationMessage

```kotlin
fun onReceiveConversationMessage(item: EduContextChatItem)
```

收到提问消息。

| 参数   | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| `item` | 聊天消息对象，详见 [EduContextChatItem](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextchatitem)。 |

### onReceiveChatHistory

```kotlin
fun onReceiveConversationHistory(history: List<EduContextChatItem>)
```

历史提问消息已更新。

| 参数      | 描述                                                         |
| :-------- | :----------------------------------------------------------- |
| `history` | 由多个聊天消息对象组成的数组，详见 [EduContextChatItem](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextchatitem)。 |

### onChatAllowed

```kotlin
fun onChatAllowed(allowed: Boolean)
```

全局聊天权限发生变化。

| 参数      | 描述                     |
| :-------- | :----------------------- |
| `allowed` | 是否有权限进行消息聊天。 |

### onChatAllowed

```kotlin
fun onChatAllowed(allowed: Boolean, userInfo: EduContextUserInfo, operator: EduContextUserInfo?, local: Boolean)
```

单个用户的聊天权限发生变化。

| 参数       | 描述                                                         |
| :--------- | :----------------------------------------------------------- |
| `allowed`  | 是否有权限进行消息聊天。                                     |
| `userInfo` | 聊天权限发生变化的用户，详见 [EduContextUserInfo](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserinfo)。 |
| `operator` | 操作聊天权限变更的用户，详见 [EduContextUserInfo](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserinfo)。 |
| `local`    | 是否为本地用户。                                             |

### onChatTips

```kotlin
fun onChatTips(tip: String)
```

报告聊天过程中的提示信息。

有以下提示：

- 禁言模式开启。
- 禁言模式关闭。

| 参数  | 描述       |
| :---- | :--------- |
| `tip` | 提示信息。 |

