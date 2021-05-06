# Chat Context

## AgoraEduMessageContext

`AgoraEduMessageContext` 类提供可供 App 调用的消息聊天相关方法。

### sendRoomMessage

```swift
func sendRoomMessage(_ message: String)
```

发送房间消息。

| 参数      | 描述       |
| :-------- | :--------- |
| `message` | 消息内容。 |

### resendRoomMessage

```swift
func resendRoomMessage(_ message: String, messageId: Int)
```

重发房间信息。

| 参数        | 描述       |
| :---------- | :--------- |
| `message`   | 消息内容。 |
| `messageId` | 消息 ID。  |

### fetchHistoryMessages

```swift
func fetchHistoryMessages(_ startId: Int, count: Int)
```

获取历史消息。

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

收到房间聊天消息。

| 参数   | 描述                                           |
| :----- | :--------------------------------------------- |
| `Info` | 聊天消息对象，详见 `AgoraEduContextChatInfo`。 |

### onFetchHistoryMessagesResult

```swift
@objc optional func onFetchHistoryMessagesResult(_ error: AgoraEduContextError?, list: [AgoraEduContextChatInfo]?)
```

获取历史聊天消息结果。

| 参数    | 描述                                                      |
| :------ | :-------------------------------------------------------- |
| `error` | 错误码。如 `error` 不为空，表示获取失败。                 |
| `list`  | 由多个聊天消息对象组成的数组，详见 `EduContextChatItem`。 |

### onUpdateChatPermission

```swift
@objc optional func onUpdateChatPermission(_ allow: Bool)
```

聊天权限发生变化

| 参数    | 描述                               |
| :------ | :--------------------------------- |
| `allow` | 是否有权限进行消息聊天（被禁言）。 |

### onShowChatTips

```swift
@objc optional func onShowChatTips(_ message: String)
```

显示聊天过程中的提示信息。

有以下提示：

- 禁言模式开启。
- 禁言模式关闭。

| 参数      | 描述       |
| :-------- | :--------- |
| `message` | 提示信息。 |
