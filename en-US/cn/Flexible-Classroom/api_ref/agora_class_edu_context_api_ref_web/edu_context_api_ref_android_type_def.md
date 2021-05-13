# Type definition

This page lists the type definitions used by Edu Context.

## WhiteboardApplianceType

```kotlin
enum class WhiteboardApplianceType {
    Select, Pen, Rect, Circle, Line, Eraser, Text;
}
```

白板基础工具类型。

| Parameter | Description |
| :------- | :------- |
| `Select` | Selector. |
| `Pen` | brush. |
| `rect` | rectangle. |
| `Circle` | Round. |
| `Line` | line. |
| `Eraser` | Eraser |
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

whiteboard tool attribute configuration class.

## EduContextNetworkState

```kotlin
enum class EduContextNetworkState {
    Good, Medium, Bad, Unknown;
}
```

Network conditions.

| Parameter | Description |
| :-------- | :----- |
| `Good` | better. |
| `Medium` | general. |
| `Bad` | Poor. |
| `Unknown` | unknown. |

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

RTM connection status.

| Parameter | Description |
| :------------- | :----------- |
| `Disconnected` | The SDK disconnects from the network. |
| `Connecting` | connecting. |
| `Connected` | connected. |
| `Reconnecting` | Reconnecting. |
| `Aborted` | Was kicked out. |

## EduContextClassState

```kotlin
enum class EduContextClassState {
    Init, Start, End, Destroyed
}
```

Classroom status.

| Parameter | Description |
| :---------- | :----------------- |
| `Init` | The class has been initialized. |
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
| `Teacher` | teacher. |
| `Student` | student. |
| `Assistant` | Teaching assistant. |

## EduContextUserInfo

```kotlin
// User Info
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
| `userUuid` | User ID. |
| `userName` | user name. |
| `role` | User role, see EduContextUserRole for details``. |

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

The detailed information.

| Parameter | Description |
| :--- | :--- |
|  |  |

## deviceState

```kotlin
enum class DeviceState(val value: Int) {
    UnAvailable(0),
    Available(1),
    Closed(2)
}
```

Media device states.

| Parameter | Description |
| :------------ | :------------- |
| `UnAvailable` | The device is unavailable. |
| `Available` | The equipment is available. |
| `Closed` | The device has been shut down. |

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

The specific information of the chat message.

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
| `Default` | The default state. |
| `InProgress` | The message is being sent. |
| `success` | The message was sent successfully. |
| `Fail` | Failed to send the message. |

## EduContextHandsUpState

```kotlin
enum class EduContextHandsUpState(val value: Int) {
    Init(0),
    HandsUp (1),
    HandsDown(2)
}
```

Hand up state.

| Parameter | Description |
| :---------- | :--------- |
| `Init` | The initial state. |
| `HandsUp` | Raise your hands. |
| `HandsDown` | Hands down. |
