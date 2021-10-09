## AgoraEduMessageContext

`AgoraEduMessageContext` provides the methods that can be called by your app for the chat module.

### sendRoomMessage

```swift
func sendRoomMessage(_ message: String)
```

Sends a classroom message.

| Parameter | Description |
| :-------- | :--------- |
| `message` | The message. |

### sendConversationMessage

```swift
func sendConversationMessage(_ message: String)
```

Sends a peer-to-peer message to a remote user.

| Parameter | Description |
| :-------- | :--------- |
| `message` | The message. |

### resendRoomMessage

```swift
func resendRoomMessage(_ message: String,
                       messageId: String)
```

Resends the classroom message.

| Parameter | Description |
| :---------- | :--------- |
| `message` | The message. |
| `messageId` | The message ID. |

### resendConversationMessage

```swift
func resendConversationMessage(_ message: String,
                               messageId: String)
```

Resends the peer-to-peer message.

| Parameter | Description |
| :---------- | :--------- |
| `message` | The message. |
| `messageId` | The message ID. |

### fetchHistoryMessages

```swift
func fetchHistoryMessages(_ startId: String,
                              count: Int)
```

Fetches the history of classroom messages.

| Parameter | Description |
| :-------- | :----------------------------------------- |
| `startId` | You need to pass in a `messageId`, which indicates you need to get this message and messages sent before this message. |
| `count` | The number of messages you want to get. |

### fetchConversationHistoryMessages

```swift
func fetchConversationHistoryMessages(_ startId: String,
                                          count: Int)
```

Fetches the history of peer-to-peer messages.

| Parameter | Description |
| :-------- | :----------------------------------------- |
| `startId` | You need to pass in a `messageId`, which indicates you need to get this message and messages sent before this message. |
| `count` | The number of messages you want to get. |

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduMessageHandler)
```

Registers the event listener.

| Parameter | Description |
| :-------- | :--------------------------------- |
| `handler` | See the `AgoraEduMessageHandler` class for details. |

## AgoraEduMessageHandler

`AgoraEduMessageHandler` reports the message-related event callbacks to your app.

### onAddRoomMessage

```swift
@objc optional func onAddRoomMessage(_ info: AgoraEduContextChatInfo)
```

Occurs when the local client receives a classroom message.

| Parameter | Description |
| :----- | :----------------------------------------- |
| `Info` | The message object. See `AgoraEduContextChatInfo` for details. |

### onAddConversationMessage

```swift
@objc optional func onAddConversationMessage(_ info: AgoraEduContextChatInfo)
```

Occurs when the local client receives a peer-to-peer message from a remote user.

| Parameter | Description |
| :----- | :----------------------------------------- |
| `Info` | The message object. See `AgoraEduContextChatInfo` for details. |

### onUpdateChatPermission

```swift
@objc optional func onUpdateChatPermission(_ allow: Bool)
```

Occurs when the chat permission of all users in the classroom changes.

- When `allow` is `true`, Flexible Classroom triggers a pop-up window saying "The mute mode is on".
- When `allow` is `false`, Flexible Classroom triggers a pop-up window saying "The mute mode is off".

| Parameter | Description |
| :------ | :----------------------- |
| `allow` | Whether the local client has the permission to chat. |

### onUpdateLocalChatPermission

```swift
@objc optional func onUpdateLocalChatPermission(_ allow: Bool,
                                                 toUser: AgoraEduContextUserInfo,
                                           operatorUser: AgoraEduContextUserInfo)
```

Occurs when the chat permission of the local user changes.

- When `allow` is `true`, Flexible Classroom triggers a pop-up window saying "You are muted by xx".
- When `allow` is `false`, Flexible Classroom triggers a pop-up window saying "You are unmuted by xx".

| Parameter | Description |
| :------------- | :----------------------- |
| `allow` | Whether the local client has the permission to chat. |
| `toUser` | The information of the user whose chat permission has changed. |
| `operatorUser` | The information of the operator. |

### onUpdateRemoteChatPermission

```swift
@objc optional func onUpdateRemoteChatPermission(_ allow: Bool,
                                                  toUser: AgoraEduContextUserInfo,
                                            operatorUser: AgoraEduContextUserInfo)
```

Occurs when the chat permission of a remote user changes.

- When `allow` is `true`, Flexible Classroom triggers a pop-up window saying "xx is muted by xx".
- When `allow` is `false`, Flexible Classroom triggers a pop-up window saying "xx is unmuted by xx".

| Parameter | Description |
| :------------- | :----------------------- |
| `allow` | Whether the local client has the permission to chat. |
| `toUser` | The information of the user whose chat permission has changed. |
| `operatorUser` | The information of the operator. |

### onSendRoomMessageResult

```swift
@objc optional func onSendRoomMessageResult(_ error: AgoraEduContextError?,
                                               info: AgoraEduContextChatInfo?)
```

Reports the result of the local user sending the classroom message (including sending for the first time and re-sending).

| Parameter | Description |
| :------ | :----------------------------------------- |
| `error` | The error code. ` error` not being empty means failure. |
| `info` | The message object. See `AgoraEduContextChatInfo` for details. |

### onSendConversationMessageResult

```swift
@objc optional func onSendConversationMessageResult(_ error: AgoraEduContextError?,
                                                       info: AgoraEduContextChatInfo?)
```

Reports the result of the local user sending the peer-to-peer message (including sending for the first time and re-sending).

| Parameter | Description |
| :------ | :----------------------------------------- |
| `error` | The error code. ` error` not being empty means failure. |
| `info` | The message object. See `AgoraEduContextChatInfo` for details. |

### onFetchHistoryMessagesResult

```swift
@objc optional func onFetchHistoryMessagesResult(_ error: AgoraEduContextError?,
                                                    list: [AgoraEduContextChatInfo]?)
```

Reports the result of the local user fetching the history of classroom messages.

| Parameter | Description |
| :------ | :--------------------------------------------------------- |
| `error` | The error code. ` error` not being empty means failure. |
| `info` | An array of message objects. See `AgoraEduContextChatInfo` for details. |

### onFetchConversationHistoryMessagesResult

```swift
@objc optional func onFetchConversationHistoryMessagesResult(_ error: AgoraEduContextError?,
                                                                list: [AgoraEduContextChatInfo]?)
```

Reports the result of the local user fetching the history of peer-to-peer messages.

| Parameter | Description |
| :------ | :--------------------------------------------------------- |
| `error` | The error code. ` error` not being empty means failure. |
| `info` | An array of message objects. See `AgoraEduContextChatInfo` for details. |

### onUpdateRoomMessageList

```swift
 @objc optional func onUpdateRoomMessageList(_ list: [AgoraEduContextChatInfo])
```

Occurs when the classroom message list updates.

| Parameter | Description |
| :------ | :--------------------------------------------------------- |
| `error` | The error code. If `error` is not empty, it means the local client fails to fetch the message history. |
| `list` | An array of message objects. See `AgoraEduContextChatInfo` for details. |

### onUpdateConversationMessageList

```swift
@objc optional func onUpdateConversationMessageList(_ list: [AgoraEduContextChatInfo])
```

Occurs when the peer-to-peer message list updates.

| Parameter | Description |
| :------ | :---------------------------------------------------- |
| `error` | The error code. If `error` is not empty, it means the local client fails to fetch the message history. |
| `list` | An array of message objects. See `EduContextChatItem` for details. |
