# Chat Context

## ChatContext

The` ChatContext` class provides messaging and chat-related methods that can be called by the App.

### sendLocalMessage

```kotlin
abstract fun sendLocalMessage (message: String, timestamp: Long, callback: EduContextCallback <EduContextChatItemSendResult>): EduContextChatItem
```

Send chat messages.

| Parameter | Description |
| :---------- | :------------------------------------------------ |
| `message` | Message content. |
| `timestamp` | The timestamp of the sent message. |
| `callback` | Get the message sending` result asynchronously through EduContextCallback`. |

### fetchHistory

```kotlin
abstract fun fetchHistory(startId: Int?, count: Int? = 50, callback: EduContextCallback<List<EduContextChatItem>>)
```

Get historical news.

| Parameter | Description |
| :--------- | :-------------------------------------------- |
| `startId` | The messageId `is passed in`, which indicates which message to get from. |
| `count` | The number of messages you want to get. |
| `callback` | Acquire historical messages asynchronously through` EduContextCallback`. |

## IChatHandler

The` IChatHandler` class is used to report message chat-related event callbacks to the App.

### onReceiveMessage

```kotlin
fun onReceiveMessage (item: EduContextChatItem)
```

Receive chat message.

| Parameter | Description |
| :----- | :---------------------------------------- |
| `item` | Chat message object, see EduContextChatItem for details``. |

### onReceiveChatHistory

```kotlin
fun onReceiveChatHistory(history: List<EduContextChatItem>)
```

Get historical chat messages.

| Parameter | Description |
| :-------- | :-------------------------------------------------------- |
| `history` | An array composed of multiple chat message objects, see EduContextChatItem for details``. |

### onChatAllowed

```kotlin
fun onChatAllowed(allowed: Boolean)
```

Chat permissions have changed

| Parameter | Description |
| :-------- | :--------------------------------- |
| `allowed` | Do you have permission to chat with messages (being banned). |

### onChatTips

```kotlin
fun onChatTips(tip: String)
```

Report the prompt message during the chat.

There are the following tips:

- Mute mode is turned on.
- Mute mode is turned off.

| Parameter | Description |
| :---- | :--------- |
| `tip` | The event message. |

