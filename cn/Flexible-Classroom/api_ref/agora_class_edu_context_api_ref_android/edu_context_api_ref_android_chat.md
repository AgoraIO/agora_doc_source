# Chat Context

## ChatContext

`ChatContext` 类提供可供 App 调用的消息聊天相关方法。

### sendLocalMessage

```kotlin
abstract fun sendLocalMessage(message: String, timestamp: Long, callback: EduContextCallback<EduContextChatItemSendResult>) : EduContextChatItem
```

发送聊天消息。

| 参数        | 描述                                              |
| :---------- | :------------------------------------------------ |
| `message`   | 消息内容。                                        |
| `timestamp` | 发送消息的时间戳。                                |
| `callback`  | 通过 `EduContextCallback ` 异步获取消息发送结果。 |

### fetchHistory

```kotlin
abstract fun fetchHistory(startId: Int?, count: Int? = 50, callback: EduContextCallback<List<EduContextChatItem>>)
```

获取历史消息。

| 参数       | 描述                                          |
| :--------- | :-------------------------------------------- |
| `startId`  | 传入 `messageId`，表示从哪条消息开始获取。    |
| `count`    | 想要获取的消息条数。                          |
| `callback` | 通过 `EduContextCallback ` 异步获取历史消息。 |

## IChatHandler

`IChatHandler` 类用于向 App 报告消息聊天相关的事件回调。

### onReceiveMessage

```kotlin
fun onReceiveMessage(item: EduContextChatItem)
```

收到聊天消息。

| 参数   | 描述                                      |
| :----- | :---------------------------------------- |
| `item` | 聊天消息对象，详见 `EduContextChatItem`。 |

### onReceiveChatHistory

```kotlin
fun onReceiveChatHistory(history: List<EduContextChatItem>)
```

获取历史聊天消息。

| 参数      | 描述                                                      |
| :-------- | :-------------------------------------------------------- |
| `history` | 由多个聊天消息对象组成的数组，详见 `EduContextChatItem`。 |

### onChatAllowed

```kotlin
fun onChatAllowed(allowed: Boolean)
```

聊天权限发生变化

| 参数      | 描述                               |
| :-------- | :--------------------------------- |
| `allowed` | 是否有权限进行消息聊天（被禁言）。 |

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

