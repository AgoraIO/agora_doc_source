# Type definition

This page lists the type definitions used by Agora Edu Context.

## WhiteboardApplianceType

```kotlin
enum class WhiteboardApplianceType {
    Select, Pen, Rect, Circle, Line, Eraser, Text;
}
```

The whiteboard editing tool.

| Parameter | Description |
| :------- | :------- |
| `Select` | Selector. |
| `Pen` | Pen. |
| `Rect` | Rectangle. |
| `Circle` | Circle. |
| `Line` | Line. |
| `Eraser` | Eraser. |
| `Text` | Text box. |

## WhiteboardDrawingConfig

```kotlin
data class WhiteboardDrawingConfig(
        var activeAppliance: AgoraUIApplianceType = AgoraUIApplianceType.Select,
        var color: Int = Color.WHITE,
        var fontSize: Int = 22,
        var thick: Int = 0) {
 
        fun set(config: AgoraUIDrawingConfig) {
        this.activeAppliance = config.activeAppliance
        this.color = config.color
        this.fontSize = config.fontSize
        this.thick = config.thick
    }
}
```

The configuration of the whiteboard editing tools.

## EduContextNetworkState

```kotlin
enum class EduContextNetworkState {
    Good, Medium, Bad, Unknown;
}
```

The network quality.

| Parameter | Description |
| :-------- | :----- |
| `Good` | Good. |
| `Medium` | Medium. |
| `Bad` | Poor. |
| `Unknown` | Unknown. |

## EduContextConnectionState

```kotlin
enum class EduContextConnectionState {
    Disconnected,
    Connecting,
    Connected,
    Reconnecting,
    Aborted
}
```

The connection state with the RTM system.

| Parameter | Description |
| :------------- | :----------- |
| `Disconnected` | The SDK disconnects from the RTM system. |
| `Connecting` | The SDK is connecting to the RTM system. |
| `Connected` | The SDK is connected to the RTM system. |
| `Reconnecting` | The SDK is reconnecting to the RTM system. |
| `Aborted` | The connection is aborted. |

## EduContextClassState

```kotlin
enum class EduContextClassState {
    Init, Start, End, Destroyed
}
```

The classroom state.

| Parameter | Description |
| :---------- | :----------------- |
| `Init` | The classroom has been initialized. |
| `Start` | The class has started. |
| `End` | The class is over. |
| `Destroyed` | The classroom has been destroyed. |

## EduContextUserRole

```kotlin
enum class EduContextUserRole(val value: Int) {
    Teacher(1),
    Student(2),
    Assistant(3)
}
```

The user role.

| Parameter | Description |
| :---------- | :----- |
| `Teacher` | Teacher. |
| `Student` | Student. |
| `Assistant` | Teaching assistant. |

## EduContextUserInfo

```kotlin
// User Info
data class EduContextUserInfo(
        val userUuid: String,
        val userName: String,
        val role: EduContextUserRole = EduContextUserRole.Student
) {
}
```

The volume information of users.

| Parameter | Description |
| :--------- | :------------------------------------ |
| `userUuid` | The user ID. |
| `userName` | The user name. |
| `role` | The user role. See `EduContextUserRole` for details. |

## EduContextUserDetailInfo

```kotlin
// user: user information
// streamUuid: stream Id
data class EduContextUserDetailInfo(val user: EduContextUserInfo, val streamUuid: String) {
    // Is it a local user
    var isSelf: Boolean = true
    // is online
    var onLine: Boolean = false
    // Are you on stage
    var coHost: Boolean = false
    // Do you have whiteboard permissions
    var boardGranted: Boolean = false
    // camera available status
    var cameraState: DeviceState = DeviceState.UnAvailable
    // Microphone available status
    var microState: DeviceState = DeviceState.UnAvailable
    // Whether to open the video
    var enableVideo: Boolean = false
    // Whether to open audio
    var enableAudio: Boolean = false
    // Number of rewards
    var rewardCount: Int = -1
}
```

The detailed user information.

| Parameter | Description |
| :--- | :--- |
|  |  |

## DeviceState

```kotlin
enum class DeviceState(val value: Int) {
    UnAvailable(0),
    Available(1),
    Closed(2)
}
```

The device state.

| Parameter | Description |
| :------------ | :------------- |
| `UnAvailable` | The device is unavailable. |
| `Available` | The device is available. |
| `Closed` | The device has been closed. |

## EduContextChatItem

```kotlin
// chat information
data class EduContextChatItem(
        // The name of the message sender
        var name: String = "",
        // Information sender id
        var uid: String = "",
        // content
        var message: String = "",
        // Information Id
        var messageId: Int = 0,
        // Information type
        var type: EduContextChatItemType = EduContextChatItemType.Text,
        // Information Sources
        var source: EduContextChatSource = EduContextChatSource.Remote,
            // The system gets the result of a sent channel message
        var state: EduContextChatState = EduContextChatState.Default,
        // timestamp
        var timestamp: Long = 0) {
}
```

The information of the message.

| Parameter | Description |
| :--- | :--- |
| `` |  |
| `` |  |
| `` |  |
| `` |  |
| `` |  |
| `` |  |
| `` |  |
| `` |  |

## EduContextChatItemType

```kotlin
enum class EduContextChatItemType {
    Text
}
```

The message type.

| Parameter | Description |
| :----- | :--------- |
| `Text` | Text. |

## EduContextChatSource

```kotlin
enum class EduContextChatSource {
    Local, Remote, System
}
```

The message source.

| Parameter | Description |
| :------- | :--------- |
| `Local` | The message is from a local user. |
| `Remote` | The message is from a remote user. |
| `System` | The message is from the system |

## EduContextChatState

```kotlin
enum class EduContextChatState {
    Default, InProgress, Success, Fail
}
```

The sending state of the message.

| Parameter | Description |
| :----------- | :------------- |
| `Default` | The initial state. |
| `InProgress` | The message is being sent. |
| `success` | The message is sent successfully. |
| `Fail` | Fail to send the message. |

## EduContextHandsUpState

```kotlin
enum class EduContextHandsUpState(val value: Int) {
    Init(0),
    HandsUp(1),
    HandsDown(2)
}
```

The hand state.

| Parameter | Description |
| :---------- | :--------- |
| `Init` | The initial state. |
| `HandsUp` | Hand raised. |
| `HandsDown` | Hand lowered. |
