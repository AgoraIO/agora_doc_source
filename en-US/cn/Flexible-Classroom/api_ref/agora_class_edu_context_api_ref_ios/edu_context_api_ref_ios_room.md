# Room Context

## AgoraEduRoomContext

The` AgoraEduRoomContext` class provides classroom management-related methods that can be called by App.

### leaveRoom

```swift
func leaveRoom()
```

Leave the class.

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduRoomHandler)
```

Register event listener.

| Parameter | Description |
| :-------- | :------------------------------ |
| `handler` | See the `AgoraEduRoomHandler` class for details. |


## AgoraEduRoomHandler

The` AgoraEduRoomHandler` class is used to report class-related event callbacks to the App.

### onSetClassroomName

```swift
@objc optional func onSetClassroomName(_ name: String)
```

Report the class name.

| Parameter | Description |
| :----- | :--------- |
| `name` | Class name. |

### onSetClassState

```swift
@objc optional func onSetClassState(_ state: AgoraEduContextClassState)
```

Report class status.

| Parameter | Description |
| :------ | :------------------------------------------- |
| `state` | Classroom status, see AgoraEduContextClassState for details``. |

### onSetClassTime

```swift
@objc optional func onSetClassTime(_ time: String)
```

Report class time.

- When the class status is `Init`, the reminder is X minutes and X seconds before class.
- When the class status is `Start`, it indicates that the class has started for X minutes and X seconds.
- When the class status is `End`, it prompts that the class has timed out for X minutes and X seconds.

| Parameter | Description |
| :----- | :--------- |
| `time` | Class time. |

### onSetNetworkQuality

```swift
@objc optional func onSetNetworkQuality(_ quality: AgoraEduContextNetworkQuality)
```

Report network status.

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
