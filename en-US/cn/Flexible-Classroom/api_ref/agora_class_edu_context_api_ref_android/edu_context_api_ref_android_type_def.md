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
| `rect` | Rectangle. |
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

白板基础工具属性配置类。

| Parameter | Description |
| :---------------- | :----------- |
| `activeAppliance` | 可用的白板基础工具。 |
| `color` | The color. |
| `fontsize` | The font size. |
| `thick` | Brush thickness. |

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
| `Aborted` | Was kicked out. |

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
| `end` | The class is over. |
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
data class EduContextUserInfo(
        userUuid: string,
        userName: string,
        role wave: EduContextUserRole = EduContextUserRole.Student
) {
}
```

The volume information of users.

| Parameter | Description |
| :--------- | :------------------------------------ |
| `userUuid` | The user ID. |
| `userName` | The user name. |
| `role` | User role, see EduContextUserRole for details``. |

## EduContextUserDetailInfo

```kotlin
// user: user information
// streamUuid: stream ID
data class EduContextUserDetailInfo(val user: EduContextUserInfo, val streamUuid: String) {
    var isSelf: Boolean = true
    var onLine: Boolean = false
    var coHost: Boolean = false
    var boardGranted: Boolean = false
    var cameraState: DeviceState = DeviceState.UnAvailable
    var microState: DeviceState = DeviceState.UnAvailable
    var enableVideo: Boolean = false
    var enableAudio: Boolean = false
    var rewardCount: Int = -1
}
```

The detailed user information.

| Parameter | Description |
| :------------- | :----------------------------------- |
| `isSelf` | Whether the user is the local user. |
| `onLine` | Whether the user is online. |
| `coHots` | Whether the user is on stage. |
| `boardGranted` | Whether the user has permission of drawing on the whiteboard. |
| `cameraState` | The available state of the camera, see DeviceState for details``. |
| `microState` | Microphone available status, see DeviceState for details``. |
| `enableVideo` | Whether the user enables the video. |
| `enableAudio` | Whether the user enables the audio. |
| `rewardCount` | The number of rewards. |

## deviceState

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
| `Closed` | The device has been shut down. |

## EduContextChatItem

```kotlin
data class EduContextChatItem(
        var name: String = "",
        var uid: String = "",
        var message: String = "",
        var messageId: Int = 0,
        var type: EduContextChatItemType = EduContextChatItemType.Text,
        var source: EduContextChatSource = EduContextChatSource.Remote,
        var state: EduContextChatState = EduContextChatState.Default,
        var timestamp: Long = 0) {
}
```

The information of the message.

| Parameter | Description |
| :---------- | :----------------------------------------- |
| `name` | The name of the message sender. |
| `uid` | The ID of the message sender. |
| `message` | The message. |
| `messageId` | The message ID. |
| `type` | Message type, see EduContextChatItemType for details``. |
| `source` | The source of the message, see EduContextChatSource for details``. |
| `state` | Message sending status, see EduContextChatState for details``. |
| `timestamp` | Message sending timestamp. |

## EduContextChatItemType

```kotlin
enum class EduContextChatItemType {
    Text
}
```

Information type.

| Parameter | Description |
| :----- | :--------- |
| `Text` | Text message. |

## EduContextChatSource

```kotlin
enum class EduContextChatSource {
    Local, Remote, System
}
```

Information Sources.

| Parameter | Description |
| :------- | :--------- |
| `Local` | Local news. |
| `Remote` | Remote message. |
| `System` | system information. |

## EduContextChatState

```kotlin
enum class EduContextChatState {
    Default, InProgress, Success, Fail
}
```

Message sending status.

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
    HandsUp (1),
    HandsDown(2)
}
```

The hand state.

| Parameter | Description |
| :---------- | :--------- |
| `Init` | The initial state. |
| `HandsUp` | Hand raised. |
| `HandsDown` | Hand lowered. |
