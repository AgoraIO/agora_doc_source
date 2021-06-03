## AgoraEduRoomContext

`AgoraEduRoomContext` 类提供可供 App 调用的课堂管理相关方法。

### leaveRoom

```swift
func leaveRoom()
```

离开课堂。

### uploadLog

```swift
func uploadLog()
```

上传日志。

### updateFlexRoomProperties

```swift
func updateFlexRoomProperties(_ properties:[String: String],
                                cause:[String: String]?)
```

新增或更新自定义课堂属性。

属性成功更新后，会触发 `onFlexRoomPropertiesChanged` 回调。

| 参数         | 描述                                                         |
| :----------- | :----------------------------------------------------------- |
| `properties` | 课堂属性。可设为 `{"key.subkey":"1"}`  或 `{"key":{"subkey":"1"}}`。 |
| `cause`      | 更新原因。                                                   |

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

- 课堂状态为 `Init` 时，`time` 表示距离上课还有几秒。
- 课堂状态为 `Start` 时，`time` 表示已开始上课几秒。
- 课堂状态为 `End` 时，`time` 表示课堂已超时几秒。

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

### onUploadLogSuccess

```swift
@objc optional func onUploadLogSuccess(_ logId: String)
```

日志上传成功。

| 参数    | 描述      |
| :------ | :-------- |
| `logId` | 日志 ID。 |

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

报告上课过程中的错误信息。

| 参数    | 描述                                    |
| :------ | :-------------------------------------- |
| `error` | 错误信息，详见 `AgoraEduContextError`。 |

### onFlexRoomPropertiesInitialize

```swift
@objc optional func onFlexRoomPropertiesInitialize(_ properties: [String: Any])
```

报告初始化的课堂自定义属性。

| 参数         | 描述                 |
| :----------- | :------------------- |
| `properties` | 当前课堂的全部属性。 |

### onFlexRoomPropertiesChanged

```swift
@objc optional func onFlexRoomPropertiesChanged(_ changedProperties: [String: Any],
                                                  properties: [String: Any],
                                                  cause: [String: Any]?,
                                                  operator:AgoraEduContextUserInfo?)
```

自定义课堂属性更新回调。

| 参数                | 描述                                                         |
| :------------------ | :----------------------------------------------------------- |
| `changedProperties` | 已更新的课堂属性。                                           |
| `properties`        | 全部课堂属性。                                               |
| `cause`             | 更新原因。                                                   |
| `operator`          | 操作者，详见 `AgoraEduContextUserInfo`。`operator` 为空表示是由服务端更新。 |

