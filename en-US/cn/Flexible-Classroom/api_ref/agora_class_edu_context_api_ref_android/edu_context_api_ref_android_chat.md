## ChatContext

`ChatContext` provides the methods that can be called by your app for the chat module.

### sendLocalMessage

```kotlin
abstract fun sendLocalMessage (message: String, timestamp: Long, callback: EduContextCallback <EduContextChatItemSendResult>): EduContextChatItem
```

Send a message.

| Parameter | Description |
| :---------- | :------------------------------------------------ |
| `message` | The message. |
| `timestamp` | The timestamp when the message is sent. |
| `callback` | Get the result of sending the message asynchronously through `EduContextCallback`. |

### fetchHistory

```kotlin
abstract fun fetchHistory(startId: Int?, count: Int? = 50, callback: EduContextCallback<List<EduContextChatItem>>)
```

Fetch the message history.

| Parameter | Description |
| :--------- | :-------------------------------------------- |
| `startId` | You need to pass in a `messageId`, which indicates you need to get this message and messages sent before this message. |
| `count` | The number of messages you want to get. |
| `callback` | Get the result of fetching the message history asynchronously through `EduContextCallback`. |

## IChatHandler

`IChatHandler` reports the message-related event callbacks to your app. 

### onReceiveMessage

```kotlin
fun onReceiveMessage (item: EduContextChatItem)
```

Occurs when the local client receives a message.

| Parameter | Description |
| :----- | :---------------------------------------- |
| `item` | The message object. See `EduContextChatItem` for details. |

### onReceiveChatHistory

```kotlin
fun onReceiveChatHistory(history: List<EduContextChatItem>)
```

Occurs when the local client receives the message history.

| Parameter | Description |
| :-------- | :-------------------------------------------------------- |
| `history` | An array of message objects. See `EduContextChatItem` for details. |

### onChatAllowed

```kotlin
fun onChatAllowed(allowed: Boolean)
```

Occurs when the chat permission changes.

| Parameter | Description |
| :-------- | :--------------------------------- |
| `allowed` | Whether the local client has the permission of sending chat messages. |

### onChatTips

```kotlin
fun onChatTips(tip: String)
```

Reports the tips related to the chat.

There are the following tips:

- You have no permission of sending chat messages.
- You have the permission of sending chat messages.

| Parameter | Description |
| :---- | :--------- |
| `tip` | The tip. |

