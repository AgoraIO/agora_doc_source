## AgoraEduMessageContext

`AgoraEduMessageContext` 类提供可供 App 调用的消息聊天相关方法。

### sendRoomMessage

```swift
func sendRoomMessage(_ message: String)
```

发送课堂消息。

| 参数      | 描述       |
| :-------- | :--------- |
| `message` | 消息内容。 |

### sendConversationMessage

```swift
func sendConversationMessage(_ message: String)
```

发送提问消息。

| 参数      | 描述       |
| :-------- | :--------- |
| `message` | 消息内容。 |

### resendRoomMessage

```swift
func resendRoomMessage(_ message: String,
                       messageId: String)
```

重发课堂消息。

| 参数        | 描述       |
| :---------- | :--------- |
| `message`   | 消息内容。 |
| `messageId` | 消息 ID。  |

### resendConversationMessage

```swift
func resendConversationMessage(_ message: String,
                               messageId: String)
```

重发提问消息。

| 参数        | 描述       |
| :---------- | :--------- |
| `message`   | 消息内容。 |
| `messageId` | 消息 ID。  |

### fetchHistoryMessages

```swift
func fetchHistoryMessages(_ startId: String,
                              count: Int)
```

获取历史课堂消息。

| 参数      | 描述                                       |
| :-------- | :----------------------------------------- |
| `startId` | 传入 `messageId`，表示从哪条消息开始获取。 |
| `count`   | 想要获取的消息条数。                       |

### fetchConversationHistoryMessages

```swift
func fetchConversationHistoryMessages(_ startId: String,
                                          count: Int)
```

获取历史提问消息。

| 参数      | 描述                                       |
| :-------- | :----------------------------------------- |
| `startId` | 传入 `messageId`，表示从哪条消息开始获取。 |
| `count`   | 想要获取的消息条数。                       |

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduMessageHandler)
```

注册事件监听。

| 参数      | 描述                               |
| :-------- | :--------------------------------- |
| `handler` | 详见 `AgoraEduMessageHandler` 类。 |

## AgoraEduMessageHandler

`AgoraEduMessageHandler` 类用于向 App 报告消息聊天相关的事件回调。

### onAddRoomMessage

```swift
@objc optional func onAddRoomMessage(_ info: AgoraEduContextChatInfo)
```

收到课堂聊天消息。

| 参数   | 描述                                       |
| :----- | :----------------------------------------- |
| `Info` | 消息对象，详见 `AgoraEduContextChatInfo`。 |

### onAddConversationMessage

```swift
@objc optional func onAddConversationMessage(_ info: AgoraEduContextChatInfo)
```

收到提问消息。

| 参数   | 描述                                       |
| :----- | :----------------------------------------- |
| `Info` | 消息对象，详见 `AgoraEduContextChatInfo`。 |

### onUpdateChatPermission

```swift
@objc optional func onUpdateChatPermission(_ allow: Bool)
```

课堂内全体用户的聊天权限发生变化。

- `allow` 为 `true` 时，UI 层提示：禁言模式开启。
- `allow` 为 `false` 时，UI 层提示：禁言模式关闭。

| 参数    | 描述                     |
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

| 参数           | 描述                     |
| :------------- | :----------------------- |
| `allow`        | 是否有权限进行消息聊天。 |
| `toUser`       | 聊天权限发生变化的用户。 |
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

| 参数           | 描述                     |
| :------------- | :----------------------- |
| `allow`        | 是否有权限进行消息聊天。 |
| `toUser`       | 聊天权限发生变化的用户。 |
| `operatorUser` | 操作聊天权限变更的用户。 |

### onSendRoomMessageResult

```swift
@objc optional func onSendRoomMessageResult(_ error: AgoraEduContextError?,
                                               info: AgoraEduContextChatInfo?)
```

本地用户发送课堂消息结果（包含首次发送和重发）。

| 参数    | 描述                                       |
| :------ | :----------------------------------------- |
| `error` | 错误码。 `error` 不为空表示发送失败。      |
| `info`  | 消息对象，详见 `AgoraEduContextChatInfo`。 |

### onSendConversationMessageResult

```swift
@objc optional func onSendConversationMessageResult(_ error: AgoraEduContextError?,
                                                       info: AgoraEduContextChatInfo?)
```

本地用户发送提问消息结果（包含首次和后面重发）。

| 参数    | 描述                                       |
| :------ | :----------------------------------------- |
| `error` | 错误码。 `error` 不为空表示发送失败。      |
| `info`  | 消息对象，详见 `AgoraEduContextChatInfo`。 |

### onFetchHistoryMessagesResult

```swift
@objc optional func onFetchHistoryMessagesResult(_ error: AgoraEduContextError?,
                                                    list: [AgoraEduContextChatInfo]?)
```

本地用户获取历史课堂消息结果。

| 参数    | 描述                                                       |
| :------ | :--------------------------------------------------------- |
| `error` | 错误码。 `error` 不为空表示发送失败。                      |
| `info`  | 由多个消息对象组成的数组，详见 `AgoraEduContextChatInfo`。 |

### onFetchConversationHistoryMessagesResult

```swift
@objc optional func onFetchConversationHistoryMessagesResult(_ error: AgoraEduContextError?,
                                                                list: [AgoraEduContextChatInfo]?)
```

本地用户获取历史提问消息结果。

| 参数    | 描述                                                       |
| :------ | :--------------------------------------------------------- |
| `error` | 错误码。 `error` 不为空表示发送失败。                      |
| `info`  | 由多个消息对象组成的数组，详见 `AgoraEduContextChatInfo`。 |

### onUpdateRoomMessageList

```swift
 @objc optional func onUpdateRoomMessageList(_ list: [AgoraEduContextChatInfo])
```

课堂消息已更新。

| 参数    | 描述                                                       |
| :------ | :--------------------------------------------------------- |
| `error` | 错误码。如 `error` 不为空，表示获取失败。                  |
| `list`  | 由多个消息对象组成的数组，详见 `AgoraEduContextChatInfo`。 |

### onUpdateConversationMessageList

```swift
@objc optional func onUpdateConversationMessageList(_ list: [AgoraEduContextChatInfo])
```

提问消息已更新。

| 参数    | 描述                                                  |
| :------ | :---------------------------------------------------- |
| `error` | 错误码。如 `error` 不为空，表示获取失败。             |
| `list`  | 由多个消息对象组成的数组，详见 `EduContextChatItem`。 |
