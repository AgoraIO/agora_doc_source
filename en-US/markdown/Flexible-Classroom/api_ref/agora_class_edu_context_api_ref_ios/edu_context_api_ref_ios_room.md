## AgoraEduRoomContext

`AgoraEduRoomContext` provides the methods that can be called by your app for classroom management.

### getRoomInfo

```swift
func getRoomInfo() -> AgoraEduContextRoomInfo
```

Gets the classroom information.

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

新增或更新自定义教室属性。 For details, see [How can I set user attributes? ](/en/agora-class/faq/agora_class_custom_properties)

The remote client receives the `onFlexRoomPropertiesChanged` callback.

| Parameter | Description |
| :----------- | :--------- |
| `properties` | 教室属性。 |
| `cause` | 更新原因。 |

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduRoomHandler)
```

Register the event listener.

| Parameter | Description |
| :-------- | :------------------------------ |
| `handler` | See the `AgoraEduRoomHandler` class for details. |


## AgoraEduRoomHandler

`AgoraEduRoomHandler` reports the` classroom`-related event callbacks to your app.

### onClassroomName

```swift
@objc optional func onClassroomName(_ name: String)
```

> Since v1.1.5.

Indicates the classroom name.

| Parameter | Description |
| :----- | :--------- |
| `name` | 教室名称。 |

### onClassState

```swift
@objc optional func onClassState(_ state: AgoraEduContextClassState)
```

> Since v1.1.5.

Indicates the classroom state.

| Parameter | Description |
| :------ | :------------------------------------------- |
| `state` | The classroom state. See AgoraEduContextClassState for details``. |

### onClassTimeInfo

```swift
@objc optional func onClassTimeInfo(startTime: Int64,
                                    differTime: Int64,
                                    duration: Int64,
                                    closeDelay: Int64)
```

> Since v1.1.5.

Reports the class time.

| Parameter | Description |
| :----------- | :--------------------------------------- |
| `startTime` | 课堂开始时间（毫秒）。 |
| `differTime` | 客户端跟服务端的时间误差（毫秒）。 |
| `duration` | 课堂持续时间（秒）。 |
| `closeDelay` | 课堂结束后距离教室关闭所剩的时间（秒）。 |

### onNetworkQuality

```swift
@objc optional func onNetworkQuality(_ quality: AgoraEduContextNetworkQuality)
```

> Since v1.1.5.

Reports the network state.

| Parameter | Description |
| :-------- | :----------------------------------------------- |
| `quality` | The network state. See AgoraEduContextNetworkQuality for details``. |

### onConnectionState

```swift
@objc optional func onConnectionState(_ state: AgoraEduContextConnectionState)
```

> Since v1.1.5.

Indicates the connection state.

| Parameter | Description |
| :------ | :------------------------------------------------ |
| `state` | The connection state. See AgoraEduContextConnectionState for details``. |

### onUploadLogSuccess

```swift
@objc optional func onUploadLogSuccess(_ logId: String)
```

成功上传日志。

| Parameter | Description |
| :------ | :-------- |
| `logId` | 日志 ID。 |

### onClassroomJoined

```swift
@objc optional func onClassroomJoined()
```

The SDK has joined the channel successfully.

### onShowErrorInfo

```swift
@objc optional func onShowErrorInfo(_ error: AgoraEduContextError)
```

Reports the error message during the class.

| Parameter | Description |
| :------ | :-------------------------------------- |
| `error` | The error message. See AgoraEduContextError for details``. |

### onFlexRoomPropertiesInitialize

```swift
@objc optional func onFlexRoomPropertiesInitialize(_ properties: [String: Any])
```

报告初始化的自定义教室属性。

| Parameter | Description |
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

| Parameter | Description |
| :------------------ | :----------------------------------------------------------- |
| `changedProperties` | 已更新的教室属性。 |
| `properties` | 全部教室属性。 |
| `cause` | 更新原因。 |
| `operator` | The user information. See AgoraEduContextUserInfo for details``. `operator` 为空表示是由服务端更新。 |

