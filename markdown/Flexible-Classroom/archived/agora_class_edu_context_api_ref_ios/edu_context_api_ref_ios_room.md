## AgoraEduRoomContext

`AgoraEduRoomContext` 类提供可供 App 调用的教室管理相关方法。

### getRoomInfo

```swift
func getRoomInfo() -> AgoraEduContextRoomInfo
```

获取教室信息。

### joinClassroom

```swift
func joinClassroom()
```

加入教室。

### leaveRoom

```swift
func leaveRoom()
```

离开教室。

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

新增或更新自定义教室属性。详见[如何设置自定义教室属性？](/cn/agora-class/faq/agora_class_custom_properties)

属性成功更新后，会触发 `onFlexRoomPropertiesChanged` 回调。

| 参数         | 描述       |
| :----------- | :--------- |
| `properties` | 教室属性。 |
| `cause`      | 更新原因。 |

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduRoomHandler)
```

注册事件监听。

| 参数      | 描述                            |
| :-------- | :------------------------------ |
| `handler` | 详见 `AgoraEduRoomHandler` 类。 |

## AgoraEduRoomHandler

`AgoraEduRoomHandler` 类用于向 App 报告教室相关的事件回调。

### onClassroomName

```swift
@objc optional func onClassroomName(_ name: String)
```

> 自 v1.1.5 起新增。

报告教室名称。

| 参数   | 描述       |
| :----- | :--------- |
| `name` | 教室名称。 |

### onClassState

```swift
@objc optional func onClassState(_ state: AgoraEduContextClassState)
```

> 自 v1.1.5 起新增。

报告课堂状态。

| 参数    | 描述                                         |
| :------ | :------------------------------------------- |
| `state` | 课堂状态，详见 `AgoraEduContextClassState`。 |

### onClassTimeInfo

```swift
@objc optional func onClassTimeInfo(startTime: Int64,
                                    differTime: Int64,
                                    duration: Int64,
                                    closeDelay: Int64)
```

> 自 v1.1.5 起新增。

报告课堂时间。

| 参数         | 描述                                     |
| :----------- | :--------------------------------------- |
| `startTime`  | 课堂开始时间（毫秒）。                   |
| `differTime` | 客户端跟服务端的时间误差（毫秒）。       |
| `duration`   | 课堂持续时间（秒）。                     |
| `closeDelay` | 课堂结束后距离教室关闭所剩的时间（秒）。 |

### onNetworkQuality

```swift
@objc optional func onNetworkQuality(_ quality: AgoraEduContextNetworkQuality)
```

> 自 v1.1.5 起新增。

报告网络状态。

| 参数      | 描述                                             |
| :-------- | :----------------------------------------------- |
| `quality` | 网络状态，详见 `AgoraEduContextNetworkQuality`。 |

### onConnectionState

```swift
@objc optional func onConnectionState(_ state: AgoraEduContextConnectionState)
```

> 自 v1.1.5 起新增。

报告连接状态。

| 参数    | 描述                                              |
| :------ | :------------------------------------------------ |
| `state` | 连接状态，详见 `AgoraEduContextConnectionState`。 |

### onUploadLogSuccess

```swift
@objc optional func onUploadLogSuccess(_ logId: String)
```

成功上传日志。

| 参数    | 描述      |
| :------ | :-------- |
| `logId` | 日志 ID。 |

### onClassroomJoined

```swift
@objc optional func onClassroomJoined()
```

成功加入教室。

### onShowErrorInfo

```swift
@objc optional func onShowErrorInfo(_ error: AgoraEduContextError)
```

上课过程中的错误信息。

| 参数    | 描述                                    |
| :------ | :-------------------------------------- |
| `error` | 错误信息，详见 `AgoraEduContextError`。 |

### onFlexRoomPropertiesInitialize

```swift
@objc optional func onFlexRoomPropertiesInitialize(_ properties: [String: Any])
```

报告初始化的自定义教室属性。

| 参数         | 描述                 |
| :----------- | :------------------- |
| `properties` | 当前教室的全部属性。 |

### onFlexRoomPropertiesChanged

```swift
@objc optional func onFlexRoomPropertiesChanged(_ changedProperties: [String: Any],
                                                  properties: [String: Any],
                                                  cause: [String: Any]?,
                                                  operator:AgoraEduContextUserInfo?)
```

自定义教室属性更新回调。

| 参数                | 描述                                                                        |
| :------------------ | :-------------------------------------------------------------------------- |
| `changedProperties` | 已更新的教室属性。                                                          |
| `properties`        | 全部教室属性。                                                              |
| `cause`             | 更新原因。                                                                  |
| `operator`          | 操作者，详见 `AgoraEduContextUserInfo`。`operator` 为空表示是由服务端更新。 |
