## AgoraEduMessageContext

`AgoraEduMessageContext` provides the methods that can be called by your app for the chat module.

### sendRoomMessage

```swift
func sendRoomMessage(_ message: String)
```

发送课堂消息。

| Parameter | Description |
| :-------- | :--------- |
| `message` | The message. |

### sendConversationMessage

```swift
func sendConversationMessage(_ message: String)
```

发送提问消息。

| Parameter | Description |
| :-------- | :--------- |
| `message` | The message. |

### resendRoomMessage

```swift
func resendRoomMessage(_ message: String,
                       messageId: String)
```

重发课堂消息。

| Parameter | Description |
| :---------- | :--------- |
| `message` | The message. |
| `messageId` | The message ID. |

### resendConversationMessage

```swift
func resendConversationMessage(_ message: String,
                               messageId: String)
```

重发提问消息。

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

课堂内全体用户的聊天权限发生变化。

- `allow` 为 `true` 时，UI 层提示：禁言模式开启。
- `allow` 为 `false` 时，UI 层提示：禁言模式关闭。

| Parameter | Description |
| :------ | :----------------------- |
| `allow` | 是否有权限进行消息聊天。 |

### onUpdateLocalChatPermission

```swift
@objc optional func onUpdateLocalChatPermission(_ allow: Bool,
                                                 toUser: AgoraEduContextUserInfo,
                                           operatorUser: AgoraEduContextUserInfo)
```

本地用户的聊天权限发生变化。

- `allow` 为 `true` 时，UI 层提示：你被xx禁言了。
- `allow` 为 `false` 时，UI 层提示：你被xx解除了禁言。

| Parameter | Description |
| :------------- | :----------------------- |
| `allow` | 是否有权限进行消息聊天。 |
| `toUser` | 聊天权限发生变化的用户。 |
| `operatorUser` | 操作聊天权限变更的用户。 |

### onUpdateRemoteChatPermission

```swift
@objc optional func onUpdateRemoteChatPermission(_ allow: Bool,
                                                  toUser: AgoraEduContextUserInfo,
                                            operatorUser: AgoraEduContextUserInfo)
```

远端用户的聊天权限发生变化。

- `allow` 为 `true` 时，UI 层提示：xx被xx禁言了。
- `allow` 为 `false` 时，UI 层提示：xx被xx解除了禁言。

| Parameter | Description |
| :------------- | :----------------------- |
| `allow` | 是否有权限进行消息聊天。 |
| `toUser` | 聊天权限发生变化的用户。 |
| `operatorUser` | 操作聊天权限变更的用户。 |

### onSendRoomMessageResult

```swift
@objc optional func onSendRoomMessageResult(_ error: AgoraEduContextError?,
                                               info: AgoraEduContextChatInfo?)
```

本地用户发送课堂消息结果（包含首次发送和重发）。

| Parameter | Description |
| :------ | :----------------------------------------- |
| `error` | The error code.  If` error` is not empty, it means the local client fails to raise the hand. |
| `info` | The message object. See AgoraEduContextChatInfo for details``. |

### onSendConversationMessageResult

```swift
@objc optional func onSendConversationMessageResult(_ error: AgoraEduContextError?,
                                                       info: AgoraEduContextChatInfo?)
```

本地用户发送提问消息结果（包含首次和后面重发）。

| Parameter | Description |
| :------ | :----------------------------------------- |
| `error` | The error code.  If` error` is not empty, it means the local client fails to raise the hand. |
| `info` | The message object. See AgoraEduContextChatInfo for details``. |

### onFetchHistoryMessagesResult

```swift
@objc optional func onFetchHistoryMessagesResult(_ error: AgoraEduContextError?,
                                                    list: [AgoraEduContextChatInfo]?)
```

本地用户获取历史课堂消息结果。

| Parameter | Description |
| :------ | :--------------------------------------------------------- |
| `error` | The error code.  If` error` is not empty, it means the local client fails to raise the hand. |
| `info` | The message object. See AgoraEduContextChatInfo for details``. |

### onFetchConversationHistoryMessagesResult

```swift
@objc optional func onFetchConversationHistoryMessagesResult(_ error: AgoraEduContextError?,
                                                                list: [AgoraEduContextChatInfo]?)
```

本地用户获取历史提问消息结果。

| Parameter | Description |
| :------ | :--------------------------------------------------------- |
| `error` | The error code.  If` error` is not empty, it means the local client fails to raise the hand. |
| `info` | The message object. See AgoraEduContextChatInfo for details``. |

### onUpdateRoomMessageList

```swift
 @objc optional func onUpdateRoomMessageList(_ list: [AgoraEduContextChatInfo])
```

课堂消息已更新。

| Parameter | Description |
| :------ | :--------------------------------------------------------- |
| `error` | The error code. If `error` is not empty, it means the local client fails to fetch the message history. |
| `list` | The message object. See AgoraEduContextChatInfo for details``. |

### onUpdateConversationMessageList

```swift
@objc optional func onUpdateConversationMessageList(_ list: [AgoraEduContextChatInfo])
```

提问消息已更新。

| Parameter | Description |
| :------ | :---------------------------------------------------- |
| `error` | The error code. If `error` is not empty, it means the local client fails to fetch the message history. |
| `list` | An array of message objects. See EduContextChatItem for details``. |
