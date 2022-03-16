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

Joins a classroom.

### leaveRoom

```swift
func leaveRoom()
```

Leaves the classroom.

### uploadLog

```swift
func uploadLog()
```

Uploads the logs.

### updateFlexRoomProperties

```swift
func updateFlexRoomProperties(_ properties:[String: String],
                                     cause:[String: String]?)
```

Adds or updates custom classroom properties. For details, see [How can I set classroom properties? ](/en/agora-class/faq/agora_class_custom_properties)

After you successfully update the properties, the remote client receives the `onFlexRoomPropertiesChanged` callback.

| Parameter | Description |
| :----------- | :--------- |
| `properties` | Classroom properties. |
| `cause` | The update reason. |

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduRoomHandler)
```

Registers the event listener.

| Parameter | Description |
| :-------- | :------------------------------ |
| `handler` | See the `AgoraEduRoomHandler` class for details. |


## AgoraEduRoomHandler

`AgoraEduRoomHandler` reports the classroom-related event callbacks to your app.

### onClassroomName

```swift
@objc optional func onClassroomName(_ name: String)
```

> Since v1.1.5.

Indicates the classroom name.

| Parameter | Description |
| :----- | :--------- |
| `name` | The classroom name. |

### onClassState

```swift
@objc optional func onClassState(_ state: AgoraEduContextClassState)
```

> Since v1.1.5.

Indicates the classroom state.

| Parameter | Description |
| :------ | :------------------------------------------- |
| `state` | The classroom state. See `AgoraEduContextClassState` for details. |

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
| `startTime` | Class start time (milliseconds). |
| `differTime` | The time difference between the client and the server (milliseconds). |
| `duration` | Class duration (seconds). |
| `closeDelay` | After the class ends, the time (seconds) left before the classroom is closed. |

### onNetworkQuality

```swift
@objc optional func onNetworkQuality(_ quality: AgoraEduContextNetworkQuality)
```

> Since v1.1.5.

Reports the network state.

| Parameter | Description |
| :-------- | :----------------------------------------------- |
| `quality` | The network state. See `AgoraEduContextNetworkQuality` for details. |

### onConnectionState

```swift
@objc optional func onConnectionState(_ state: AgoraEduContextConnectionState)
```

> Since v1.1.5.

Indicates the connection state.

| Parameter | Description |
| :------ | :------------------------------------------------ |
| `state` | The connection state. See `AgoraEduContextConnectionState` for details. |

### onUploadLogSuccess

```swift
@objc optional func onUploadLogSuccess(_ logId: String)
```

Occurs when the log is uploaded successfully.

| Parameter | Description |
| :------ | :-------- |
| `logId` | Log ID. |

### onClassroomJoined

```swift
@objc optional func onClassroomJoined()
```

Occurs when the local user joins the channel successfully.

### onShowErrorInfo

```swift
@objc optional func onShowErrorInfo(_ error: AgoraEduContextError)
```

Reports the error message during the class.

| Parameter | Description |
| :------ | :-------------------------------------- |
| `error` | The error message. See `AgoraEduContextError` for details. |

### onFlexRoomPropertiesInitialize

```swift
@objc optional func onFlexRoomPropertiesInitialize(_ properties: [String: Any])
```

Reports the initial custom classroom properties.

| Parameter | Description |
| :----------- | :------------------- |
| `properties` | All properties of the current classroom. |

### onFlexRoomPropertiesChanged

```swift
@objc optional func onFlexRoomPropertiesChanged(_ changedProperties: [String: Any],
                                                  properties: [String: Any],
                                                  cause: [String: Any]?,
                                                  operator:AgoraEduContextUserInfo?)
```

Occurs when the custom classroom properties are updated.

| Parameter | Description |
| :------------------ | :----------------------------------------------------------- |
| `changedProperties` | The updated classroom properties. |
| `properties` | All classroom properties. |
| `cause` | The update reason. |
| `operator` | The information of the operator. See `AgoraEduContextUserInfo`. `operator` being empty means that properties are updated by the server. |

