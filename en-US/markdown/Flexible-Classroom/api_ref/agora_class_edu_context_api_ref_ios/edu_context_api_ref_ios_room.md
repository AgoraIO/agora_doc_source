## AgoraEduRoomContext

`AgoraEduRoomContext` provides the methods that can be called by your app for classroom management.

### leaveRoom

```swift
func leaveRoom()
```

Leave the classroom.

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduRoomHandler)
```

Register the event listener.

| Parameter | Description |
| :-------- | :------------------------------ |
| `handler` | See the `AgoraEduRoomHandler` class for details. |


## AgoraEduRoomHandler

`AgoraEduRoomHandler` reports the classroom-related event callbacks to your app.

### onSetClassroomName

```swift
@objc optional func onSetClassroomName(_ name: String)
```

Indicates the classroom name.

| Parameter | Description |
| :----- | :--------- |
| `name` | The classroom name. |

### onSetClassState

```swift
@objc optional func onSetClassState(_ state: AgoraEduContextClassState)
```

Indicates the classroom state.

| Parameter | Description |
| :------ | :------------------------------------------- |
| `state` | The classroom state. See `AgoraEduContextClassState` for details. |

### onSetClassTime

```swift
@objc optional func onSetClassTime(_ time: String)
```

Reports the class time.

- When the classroom state is `Init`, `time` indicates how many seconds are left before the class begins.
- When the classroom state is `Start`, `time` indicates how many seconds the class has lasted.
- When the classroom state is `End`, `time` means how many seconds the class has gone over time.

| Parameter | Description |
| :----- | :--------- |
| `time` | The class time. |

### onSetNetworkQuality

```swift
@objc optional func onSetNetworkQuality(_ quality: AgoraEduContextNetworkQuality)
```

Reports the network state.

| Parameter | Description |
| :-------- | :----------------------------------------------- |
| `quality` | The network state. See `AgoraEduContextNetworkQuality` for details. |

### onSetConnectionState

```swift
@objc optional func onSetConnectionState(_ state: AgoraEduContextConnectionState)
```

Indicates the connection state.

| Parameter | Description |
| :------ | :------------------------------------------------ |
| `state` | The connection state. See `AgoraEduContextConnectionState` for details. |

### onShowClassTips

```swift
@objc optional func onShowClassTips(_ message: String)
```

Class notifications.

There are the following tips:

- The class ends in five minutes.
- The class is over and the classroom closes in five minutes.
- The classroom closes in one minute.

| Parameter | Description |
| :-------- | :------- |
| `message` | The notification. |

### onShowErrorInfo

```swift
@objc optional func onShowErrorInfo(_ error: AgoraEduContextError)
```

Reports the error message during the class.

| Parameter | Description |
| :------ | :-------------------------------------- |
| `error` | The error message. See `AgoraEduContextError` for details. |
