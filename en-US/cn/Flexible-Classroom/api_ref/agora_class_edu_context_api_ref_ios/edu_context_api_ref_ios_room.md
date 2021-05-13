# Room Context

## AgoraEduRoomContext

The` AgoraEduRoomContext` class provides classroom management-related methods that can be called by App.

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

The` AgoraEduRoomHandler` class is used to report class-related event callbacks to the App.

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
| `state` | Classroom status, see AgoraEduContextClassState for details``. |

### onSetClassTime

```swift
@objc optional func onSetClassTime(_ time: String)
```

Reports the class time.

- 课堂状态为 `Init` 时，`time` 表示距离上课还有几秒。
- 课堂状态为 `Start` 时，`time` 表示已开始上课几秒。
- 课堂状态为 `End` 时，`time` 表示课堂已超时几秒。

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
| `quality` | Network status, see AgoraEduContextNetworkQuality for details``. |

### onSetConnectionState

```swift
@objc optional func onSetConnectionState(_ state: AgoraEduContextConnectionState)
```

Report connection status.

| Parameter | Description |
| :------ | :------------------------------------------------ |
| `state` | Connection status, see AgoraEduContextConnectionState for details``. |

### onShowClassTips

```swift
@objc optional func onShowClassTips(_ message: String)
```

Show tips during class.

There are the following tips:

- The course ends in 5 minutes.
- The class is over and there are 5 minutes to close the classroom.
- There is still 1 minute until the classroom closes.

| Parameter | Description |
| :-------- | :------- |
| `message` | Prompt word. |

### onShowErrorInfo

```swift
@objc optional func onShowErrorInfo(_ error: AgoraEduContextError)
```

xi Error messages during class.

| Parameter | Description |
| :------ | :-------------------------------------- |
| `error` | For error information, see `AgoraEduContextError `for details. |
