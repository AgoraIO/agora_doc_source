# Chat Context

## AgoraEduMessageContext

The` AgoraEduMessageContext` class provides messaging and chat-related methods that can be called by App.

### sendRoomMessage

```swift
func sendRoomMessage(_ message: String)
```

Send room message.

| Parameter | Description |
| :-------- | :--------- |
| `message` | Message content. |

### resendRoomMessage

```swift
func resendRoomMessage(_ message: String, messageId: Int)
```

Resend the room information.

| Parameter | Description |
| :---------- | :--------- |
| `message` | Message content. |
| `messageId` | Retrieves the unique ID of the message. |

### fetchHistoryMessages

```swift
func fetchHistoryMessages(_ startId: Int, count: Int)
```

Get historical news.

| Parameter | Description |
| :-------- | :----------------------------------------- |
| `startId` | The messageId `is passed in`, which indicates which message to get from. |
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

The` AgoraEduMessageHandler` class is used to report message chat-related event callbacks to the App.

### onAddRoomMessage

```swift
@objc optional func onAddRoomMessage(_ info: AgoraEduContextChatInfo)
```

Receive room chat message.

| Parameter | Description |
| :----- | :--------------------------------------------- |
| `Info` | The chat message object, see AgoraEduContextChatInfo for details``. |

### onFetchHistoryMessagesResult

```swift
@objc optional func onFetchHistoryMessagesResult(_ error: AgoraEduContextError?, list: [AgoraEduContextChatInfo]?)
```

Get the results of historical chat messages.

| Parameter | Description |
| :------ | :-------------------------------------------------------- |
| `error` | Error code If `error` is not empty, it means the acquisition failed. |
| `list` | An array composed of multiple chat message objects, see EduContextChatItem for details``. |

### onUpdateChatPermission

```swift
@objc optional func onUpdateChatPermission(_ allow: Bool)
```

Chat permissions have changed

| Parameter | Description |
| :------ | :--------------------------------- |
| `allow` | Do you have permission to chat with messages (being banned). |

### onShowChatTips

```swift
@objc optional func onShowChatTips(_ message: String)
```

Display the prompt message during the chat.

There are the following tips:

- Mute mode is turned on.
- Mute mode is turned off.

| Parameter | Description |
| :-------- | :--------- |
| `message` | The tip. |
