# Room Context

## AgoraEduRoomContext

`AgoraEduRoomContext` 类提供可供 App 调用的课堂管理相关方法。

### leaveRoom

```swift
func leaveRoom()
```

离开课堂。

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduRoomHandler)
```

注册事件监听。

| 参数      | 描述                            |
| :-------- | :------------------------------ |
| `handler` | 详见 `AgoraEduRoomHandler` 类。 |


## AgoraEduRoomHandler

`AgoraEduRoomHandler` 类用于向 App 报告课堂相关的事件回调。

### onSetClassroomName

```swift
@objc optional func onSetClassroomName(_ name: String)
```

报告课堂名称。

| 参数   | 描述       |
| :----- | :--------- |
| `name` | 课堂名称。 |

### onSetClassState

```swift
@objc optional func onSetClassState(_ state: AgoraEduContextClassState)
```

报告课堂状态。

| 参数    | 描述                                         |
| :------ | :------------------------------------------- |
| `state` | 课堂状态，详见 `AgoraEduContextClassState`。 |

### onSetClassTime

```swift
@objc optional func onSetClassTime(_ time: String)
```

报告课堂时间。

- 课堂状态为 `Init` 时，提示距离上课还有 X 分 X 秒。
- 课堂状态为 `Start` 时， 提示已开始上课 X 分 X 秒。
- 课堂状态为 `End` 时，提示课堂已超时 X 分 X 秒。

| 参数   | 描述       |
| :----- | :--------- |
| `time` | 课堂时间。 |

### onSetNetworkQuality

```swift
@objc optional func onSetNetworkQuality(_ quality: AgoraEduContextNetworkQuality)
```

报告网络状态。

| 参数      | 描述                                             |
| :-------- | :----------------------------------------------- |
| `quality` | 网络状态，详见 `AgoraEduContextNetworkQuality`。 |

### onSetConnectionState

```swift
@objc optional func onSetConnectionState(_ state: AgoraEduContextConnectionState)
```

报告连接状态。

| 参数    | 描述                                              |
| :------ | :------------------------------------------------ |
| `state` | 连接状态，详见 `AgoraEduContextConnectionState`。 |

### onShowClassTips

```swift
@objc optional func onShowClassTips(_ message: String)
```

显示上课期间的提示。

有以下提示：

- 课程还有 5 分钟结束。
- 课程结束咯，还有 5 分钟关闭教室。
- 距离教室关闭还有 1 分钟。

| 参数      | 描述     |
| :-------- | :------- |
| `message` | 提示词。 |

### onShowErrorInfo

```swift
@objc optional func onShowErrorInfo(_ error: AgoraEduContextError)
```

xi上课过程中的错误信息。

| 参数    | 描述                                    |
| :------ | :-------------------------------------- |
| `error` | 错误信息，详见 `AgoraEduContextError`。 |
