## ChatContext

`ChatContext` provides the methods that can be called by your app for the chat module.

### sendLocalChannelMessage

```kotlin
abstract fun sendLocalChannelMessage(message: String, timestamp: Long,
                                     callback: EduContextCallback<EduContextChatItemSendResult>): EduContextChatItem
```

Sends a classroom message.

| Parameter | Description |
| :---------- | :------------------------------------------------ |
| `message` | The message. |
| `timestamp` | The timestamp when the message is sent. |
| `callback` | Gets the result of sending the message asynchronously through ` EduContextCallback`. |

### fetchChannelHistory

```kotlin
abstract fun fetchChannelHistory(startId: String?, count: Int? = 50, callback: EduContextCallback<List<EduContextChatItem>>)
```

Fetches the history of classroom messages.

| Parameter | Description |
| :--------- | :-------------------------------------------- |
| `startId` | You need to pass in a `messageId`, which indicates you need to get this message and messages sent before this message. |
| `count` | The number of messages you want to get. |
| `callback` | Get the result of fetching the message history asynchronously through ` EduContextCallback`. |

### sendConversationMessage

```kotlin
abstract fun sendConversationMessage(message: String, timestamp: Long,
                                     callback: EduContextCallback<EduContextChatItemSendResult>): EduContextChatItem
```

Sends a peer-to-peer message to a remote user.

| Parameter | Description |
| :---------- | :------------------------------------------------ |
| `message` | The message. |
| `timestamp` | The timestamp when the message is sent. |
| `callback` | Gets the result of sending the message asynchronously through ` EduContextCallback`. |

### fetchConversationHistory

```kotlin
abstract fun fetchConversationHistory(startId: String?, callback: EduContextCallback<List<EduContextChatItem>>)
```

Fetches the history of peer-to-peer messages.

| Parameter | Description |
| :--------- | :-------------------------------------------- |
| `startId` | You need to pass in a `messageId`, which indicates you need to get this message and messages sent before this message. |
| `callback` | Get the result of fetching the message history asynchronously through ` EduContextCallback`. |

## IChatHandler

`IChatHandler` reports the message-related event callbacks to your app.

### onReceiveMessage

```kotlin
fun onReceiveMessage(item: EduContextChatItem)
```

Occurs when the local client receives a classroom message.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `item` | The message object. See [EduContextChatItem](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextchatitem) for details. |

### onReceiveChatHistory

```kotlin
fun onReceiveChatHistory(history: List<EduContextChatItem>)
```

Occurs when the history of classroom messages is updated.

| Parameter | Description |
| :-------- | :----------------------------------------------------------- |
| `history` | An array of message objects. See [EduContextChatItem](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextchatitem) for details. |

### onReceiveConversationMessage

```kotlin
fun onReceiveConversationMessage(item: EduContextChatItem)
```

Occurs when the local client receives a peer-to-peer message from a remote user.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `item` | The message object. See [EduContextChatItem](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextchatitem) for details. |

### onReceiveChatHistory

```kotlin
fun onReceiveConversationHistory(history: List<EduContextChatItem>)
```

Occurs when the history of peer-to-peer messages is updated.

| Parameter | Description |
| :-------- | :----------------------------------------------------------- |
| `history` | An array of message objects. See [EduContextChatItem](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextchatitem) for details. |

### onChatAllowed

```kotlin
fun onChatAllowed(allowed: Boolean)
```

Occurs when the global chat permission changes.

| Parameter | Description |
| :-------- | :----------------------- |
| `allowed` | Whether the local client has the permission to chat. |

### onChatAllowed

```kotlin
fun onChatAllowed(allowed: Boolean, userInfo: EduContextUserInfo, operator: EduContextUserInfo?, local: Boolean)
```

Occurs when the chat permissions of a single user changes.

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `allowed` | Whether the local client has the permission to chat. |
| `userInfo` | The information of the user whose chat permission has changed. See [EduContextUserInfo](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserinfo). |
| `operator` | The information of the operator. See [EduContextUserInfo](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserinfo). |
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

