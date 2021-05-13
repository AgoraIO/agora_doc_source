## AgoraEduMessageContext

`AgoraEduMessageContext` provides the methods that can be called by your app for the chat module.

### sendRoomMessage

```swift
func sendRoomMessage(_ message: String)
```

Send a message.

| Parameter | Description |
| :-------- | :--------- |
| `message` | The message. |

### resendRoomMessage

```swift
func resendRoomMessage(_ message: String, messageId: Int)
```

Resend a message.

| Parameter | Description |
| :---------- | :--------- |
| `message` | The message. |
| `messageId` | The message ID. |

### fetchHistoryMessages

```swift
func fetchHistoryMessages(_ startId: Int, count: Int)
```

Fetch the message history.

| Parameter | Description |
| :-------- | :----------------------------------------- |
| `startId` | You need to pass in a `messageId`, which indicates you need to get this message and messages sent before this message. |
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
| :----- | :--------------------------------------------- |
| `Info` | The message object. See `AgoraEduContextChatInfo` for details. |

### onFetchHistoryMessagesResult

```swift
@objc optional func onFetchHistoryMessagesResult(_ error: AgoraEduContextError?, list: [AgoraEduContextChatInfo]?)
```

Get the results of fetching the message history.

| Parameter | Description |
| :------ | :-------------------------------------------------------- |
| `error` | Error code. If `error` is not empty, it means the local client fails to fetch the message history. |
| `list` | An array of message objects. See `EduContextChatItem` for details. |

### onUpdateChatPermission

```swift
@objc optional func onUpdateChatPermission(_ allow: Bool)
```

Occurs when the chat permission changes.

| Parameter | Description |
| :------ | :--------------------------------- |
| `allow` | Whether the local client has the permission of sending chat messages. |

### onShowChatTips

```swift
@objc optional func onShowChatTips(_ message: String)
```

Reports the tips related to the chat.

There are the following tips:

- You have no permission of sending chat messages.
- You have the permission of sending chat messages.

| Parameter | Description |
| :-------- | :--------- |
| `message` | The tip. |
