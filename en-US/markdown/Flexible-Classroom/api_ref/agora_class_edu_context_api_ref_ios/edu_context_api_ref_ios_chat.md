## AgoraEduMessageContext

`AgoraEduMessageContext` provides the methods that can be called by your app for the chat module.

### sendRoomMessage

```swift
func sendRoomMessage(_ message: String)
```

Send class messages.

| Parameter | Description |
| :-------- | :--------- |
| `message` | The message. |

### sendConversationMessage

```swift
func sendConversationMessage(_ message: String)
```

Send a question message.

| Parameter | Description |
| :-------- | :--------- |
| `message` | The message. |

### resendRoomMessage

```swift
func resendRoomMessage(_ message: String,
                       messageId: String)
```

Resend the class message.

| Parameter | Description |
| :---------- | :--------- |
| `message` | The message. |
| `messageId` | The message ID. |

### resendConversationMessage

```swift
func resendConversationMessage(_ message: String,
                               messageId: String)
```

Resend the question message.

| Parameter | Description |
| :---------- | :--------- |
| `message` | The message. |
| `messageId` | The message ID. |

### fetchHistoryMessages

```swift
func fetchHistoryMessages(_ startId: String,
                              count: Int)
```

Fetch the message history.

| Parameter | Description |
| :-------- | :----------------------------------------- |
| `startId` | You need to pass in a `messageId`, which indicates you need to get this `message `and messages sent before this `message`. |
| `count` | The number of messages you want to get. |

### fetchConversationHistoryMessages

```swift
func fetchConversationHistoryMessages(_ startId: String,
                                          count: Int)
```

Fetch the message history.

| Parameter | Description |
| :-------- | :----------------------------------------- |
| `startId` | You need to pass in a `messageId`, which indicates you need to get this `message `and messages sent before this `message`. |
| `count` | The number of messages you want to get. |

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduMessageHandler)
```

Register the event listener.

| Parameter | Description |
| :-------- | :--------------------------------- |
| `handler` | See the `AgoraEduMessageHandler` class for details. |

## AgoraEduMessageHandler

`AgoraEduMessageHandler` reports the message-related event callbacks to your app.

### onAddRoomMessage

```swift
@objc optional func onAddRoomMessage(_ info: AgoraEduContextChatInfo)
```

Occurs when the local client receives a message.

| Parameter | Description |
| :----- | :----------------------------------------- |
| `Info` | The message object. See AgoraEduContextChatInfo for details``. |

### onAddConversationMessage

```swift
@objc optional func onAddConversationMessage(_ info: AgoraEduContextChatInfo)
```

Occurs when the local client receives a message.

| Parameter | Description |
| :----- | :----------------------------------------- |
| `Info` | The message object. See AgoraEduContextChatInfo for details``. |

### onUpdateChatPermission

```swift
@objc optional func onUpdateChatPermission(_ allow: Bool)
```

The chat permissions of all users in the classroom have changed.

- When `allow` is `true`, the UI layer prompts: the muted mode is turned on.
- When `allow` is `false`, the UI layer prompts: muting mode is off.

| Parameter | Description |
| :------ | :----------------------- |
| `allow` | Do you have permission to chat with messages. |

### onUpdateLocalChatPermission

```swift
@objc optional func onUpdateLocalChatPermission(_ allow: Bool,
                                                 toUser: AgoraEduContextUserInfo,
                                           operatorUser: AgoraEduContextUserInfo)
```

The chat permissions of local users have changed.

- ``When `allow` is `true`, the UI layer prompts: You are banned by xx.
- When `allow` is `false`, the UI layer prompts: You are unbanned by xx.

| Parameter | Description |
| :------------- | :----------------------- |
| `allow` | Do you have permission to chat with messages. |
| `toUser` | Users whose chat permissions have changed. |
| `operatorUser` | The user who has changed the permission to operate the chat. |

### onUpdateRemoteChatPermission

```swift
@objc optional func onUpdateRemoteChatPermission(_ allow: Bool,
                                                  toUser: AgoraEduContextUserInfo,
                                            operatorUser: AgoraEduContextUserInfo)
```

The chat permission of the remote user has changed.

- When `allow` is `true`, the UI layer prompts: xx is forbidden by xx.
- When `allow` is `false`, the UI layer prompts: xx is unbanned by xx.

| Parameter | Description |
| :------------- | :----------------------- |
| `allow` | Do you have permission to chat with messages. |
| `toUser` | Users whose chat permissions have changed. |
| `operatorUser` | The user who has changed the permission to operate the chat. |

### onSendRoomMessageResult

```swift
@objc optional func onSendRoomMessageResult(_ error: AgoraEduContextError?,
                                               info: AgoraEduContextChatInfo?)
```

Local users send the results of class messages (including first sending and re-sending).

| Parameter | Description |
| :------ | :----------------------------------------- |
| `error` | The error code.  If` error` is not empty, it means the local client fails to raise the hand. |
| `info` | The message object. See AgoraEduContextChatInfo for details``. |

### onSendConversationMessageResult

```swift
@objc optional func onSendConversationMessageResult(_ error: AgoraEduContextError?,
                                                       info: AgoraEduContextChatInfo?)
```

The local user sends the result of the question message (including the first and subsequent retransmissions).

| Parameter | Description |
| :------ | :----------------------------------------- |
| `error` | The error code.  If` error` is not empty, it means the local client fails to raise the hand. |
| `info` | The message object. See AgoraEduContextChatInfo for details``. |

### onFetchHistoryMessagesResult

```swift
@objc optional func onFetchHistoryMessagesResult(_ error: AgoraEduContextError?,
                                                    list: [AgoraEduContextChatInfo]?)
```

Local users get the results of historical classroom news.

| Parameter | Description |
| :------ | :--------------------------------------------------------- |
| `error` | The error code.  If` error` is not empty, it means the local client fails to raise the hand. |
| `info` | The message object. See AgoraEduContextChatInfo for details``. |

### onFetchConversationHistoryMessagesResult

```swift
@objc optional func onFetchConversationHistoryMessagesResult(_ error: AgoraEduContextError?,
                                                                list: [AgoraEduContextChatInfo]?)
```

The local user obtains the result of the historical question message.

| Parameter | Description |
| :------ | :--------------------------------------------------------- |
| `error` | The error code.  If` error` is not empty, it means the local client fails to raise the hand. |
| `info` | The message object. See AgoraEduContextChatInfo for details``. |

### onUpdateRoomMessageList

```swift
 @objc optional func onUpdateRoomMessageList(_ list: [AgoraEduContextChatInfo])
```

The class news has been updated.

| Parameter | Description |
| :------ | :--------------------------------------------------------- |
| `error` | The error code. If `error` is not empty, it means the local client fails to fetch the message history. |
| `list` | The message object. See AgoraEduContextChatInfo for details``. |

### onUpdateConversationMessageList

```swift
@objc optional func onUpdateConversationMessageList(_ list: [AgoraEduContextChatInfo])
```

The question message has been updated.

| Parameter | Description |
| :------ | :---------------------------------------------------- |
| `error` | The error code. If `error` is not empty, it means the local client fails to fetch the message history. |
| `list` | An array of message objects. See EduContextChatItem for details``. |
