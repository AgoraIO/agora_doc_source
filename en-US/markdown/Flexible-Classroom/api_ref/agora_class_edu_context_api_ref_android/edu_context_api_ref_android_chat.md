## ChatContext

`ChatContext` provides the methods that can be called by your app for the chat module.

### sendLocalChannelMessage

```kotlin
abstract fun sendLocalChannelMessage(message: String, timestamp: Long,
                                     callback: EduContextCallback<EduContextChatItemSendResult>): EduContextChatItem
```

Send class messages.

| Parameter | Description |
| :---------- | :------------------------------------------------ |
| `message` | The message. |
| `timestamp` | The timestamp when the message is sent. |
| `callback` | Get the result of sending the message asynchronously through` EduContextCallback`. |

### fetchChannelHistory

```kotlin
abstract fun fetchChannelHistory(startId: String?, count: Int? = 50, callback: EduContextCallback<List<EduContextChatItem>>)
```

Fetch the message history.

| Parameter | Description |
| :--------- | :-------------------------------------------- |
| `startId` | You need to pass in a `messageId`, which indicates you need to get this `message `and messages sent before this `message`. |
| `count` | The number of messages you want to get. |
| `callback` | Get the result of fetching the message history asynchronously through` EduContextCallback`. |

### sendConversationMessage

```kotlin
abstract fun sendConversationMessage(message: String, timestamp: Long,
                                     callback: EduContextCallback<EduContextChatItemSendResult>): EduContextChatItem
```

Send a question message.

| Parameter | Description |
| :---------- | :------------------------------------------------ |
| `message` | The message. |
| `timestamp` | The timestamp when the message is sent. |
| `callback` | Get the result of sending the message asynchronously through` EduContextCallback`. |

### fetchConversationHistory

```kotlin
abstract fun fetchConversationHistory(startId: String?, callback: EduContextCallback<List<EduContextChatItem>>)
```

Fetch the message history.

| Parameter | Description |
| :--------- | :-------------------------------------------- |
| `startId` | You need to pass in a `messageId`, which indicates you need to get this `message `and messages sent before this `message`. |
| `callback` | Get the result of fetching the message history asynchronously through` EduContextCallback`. |

## IChatHandler

`IChatHandler` reports the message-related event callbacks to your app.

### onReceiveMessage

```kotlin
fun onReceiveMessage(item: EduContextChatItem)
```

Occurs when the local client receives a message.

| Parameter | Description |
| :----- | :---------------------------------------- |
| `item` | The message object. See EduContextChatItem for details``. |

### onReceiveChatHistory

```kotlin
fun onReceiveChatHistory(history: List<EduContextChatItem>)
```

The historical classroom news has been updated.

| Parameter | Description |
| :-------- | :-------------------------------------------------------- |
| `history` | An array of message objects. See EduContextChatItem for details``. |

### onReceiveConversationMessage

```kotlin
fun onReceiveConversationMessage(item: EduContextChatItem)
```

Occurs when the local client receives a message.

| Parameter | Description |
| :----- | :---------------------------------------- |
| `item` | The message object. See EduContextChatItem for details``. |

### onReceiveChatHistory

```kotlin
fun onReceiveConversationHistory(history: List<EduContextChatItem>)
```

The historical question message has been updated.

| Parameter | Description |
| :-------- | :-------------------------------------------------------- |
| `history` | An array of message objects. See EduContextChatItem for details``. |

### onChatAllowed

```kotlin
fun onChatAllowed(allowed: Boolean)
```

Occurs when the chat permission changes.

| Parameter | Description |
| :-------- | :----------------------- |
| `allowed` | Do you have permission to chat with messages. |

### onChatAllowed

```kotlin
fun onChatAllowed(allowed: Boolean, userInfo: EduContextUserInfo, operator: EduContextUserInfo?, local: Boolean)
```

The chat permissions of a single user have changed.

| Parameter | Description |
| :--------- | :-------------------------------------------------- |
| `allowed` | Do you have permission to chat with messages. |
| `userInfo` | For users whose chat permissions have changed, see EduContextUserInfo for details``. |
| `operator` | For the user who has changed the permission to operate the chat, see EduContextUserInfo for details``. |
| `local` | Whether the user is the local user. |

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

