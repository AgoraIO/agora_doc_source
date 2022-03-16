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

| Parameter | Description |
| :---------------- | :----------- |
| `activeAppliance` | Active whiteboard basic editing tools. |
| `color` | The color. |
| `fontsize` | The font size. |
| `thick` | The line thickness. |

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

## EduBoardRoomPhase

```kotlin
enum class EduBoardRoomPhase(val value: Int) {
    connecting(0),
    connected(1),
    reconnecting(2),
    disconnecting(3),
    disconnected(4);
}
```

The connection state of the whiteboard.

| Parameter | Description |
| :-------------- | :----------- |
| `connecting` | The SDK is connecting to the RTM system. |
| `connected` | The SDK is connected to the RTM system. |
| `reconnecting` | The SDK is reconnecting to the RTM system. |
| `disconnecting` | The whiteboard is disconnecting. |
| `disconnected` | The SDK disconnects from the RTM system. |

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
data class EduContextUserInfo(
        val userUuid: String,
        val userName: String,
        val role: EduContextUserRole = EduContextUserRole.Student,
        val properties: MutableMap<String, String>?
)
```

The volume information of users.

| Parameter | Description |
| :----------- | :------------------------------------ |
| `userUuid` | The user ID. |
| `userName` | The user name. |
| `role` | The user role. See `EduContextUserRole` for details. |
| `properties` | Custom user properties. |

## EduContextUserDetailInfo

```kotlin
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
| :------------- | :--------------------------------------------- |
| `isSelf` | Whether the user is the local user. |
| `onLine` | Whether the user is online. |
| `coHots` | Whether the user is on stage. |
| `boardGranted` | Whether the user has the permission of drawing on the whiteboard. |
| `cameraState` | The camera state of the user. See `EduContextDeviceState`. |
| `microState` | The microphone state of the user. See `EduContextDeviceState`. |
| `enableVideo` | Whether the user enables the video. |
| `enableAudio` | Whether the user enables the audio. |
| `silence` | Whether the local client has the permission to send messages. |
| `rewardCount` | The number of rewards. |

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
data class EduContextChatItem(
        var name: String = "",
        var uid: String = "",
        var role: Int = EduContextUserRole.Student.value,
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
| `role` | The role of the message sender. |
| `message` | The message. |
| `messageId` | The message ID. |
| `type` | The message type. See `EduContextChatItemType` for details. |
| `source` | The source of the message. See `EduContextChatSource` for details. |
| `state` | The sending state of the message. See `EduContextChatState` for details. |
| `timestamp` | The timestamp when the message is sent. |

## EduContextChatItemSendResult

```kotlin
data class EduContextChatItemSendResult(
        val fromUserId: String,
        val messageId: String,
        val timestamp: Long
)
```

The result of sending chat messages.

| Parameter | Description |
| :----------- | :--------------- |
| `fromUserId` | The ID of the message sender. |
| `messageId` | The message ID. |
| `timestamp` | The timestamp when the message is sent. |

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

## EduContextScreenShareState

```kotlin
enum class EduContextScreenShareState(val value: Int) {
    Start(0),
    Pause(1),
    Stop(2)
}
```

The state of screen sharing.

| Parameter | Description |
| :------ | :--------------- |
| `Start` | Screen sharing has been started. |
| `Pause` | Screen sharing has been paused. |
| `Stop` | Screen sharing has ended. |

## EduContextCameraFacing

```kotlin
enum class EduContextCameraFacing(val value: Int) {
    Front(0),
    Back(1);
}
```

The camera direction.

| Parameter | Description |
| :------ | :----------- |
| `Front` | The front camera. |
| `Back` | The rear camera. |

## EduContextDeviceConfig

```kotlin
data class EduContextDeviceConfig(
        var cameraEnabled: Boolean = true,
        var cameraFacing: EduContextCameraFacing = EduContextCameraFacing.Front,
        var micEnabled: Boolean = true,
        var speakerEnabled: Boolean = true)
```

Device configurations.

| Parameter | Description |
| :--------------- | :--------------- |
| `cameraEnabled` | Whether the camera is turned on. |
| `cameraFacing` | The camera direction. |
| `micEnabled` | Whether to the microphone is turned on. |
| `speakerEnabled` | Whether to the speaker is turned on. |

## EduContextRoomInfo

```kotlin
data class EduContextRoomInfo(
        val roomUuid: String,
        val roomName: String,
        val roomType: EduContextRoomType
)
```

The basic classroom information.

| Parameter | Description |
| :--------- | :------------------------------------ |
| `roomUuid` | The room ID. |
| `roomName` | The classroom name. |
| `roomType` | Classroom type. See `EduContextRoomType` for details. |

## EduContextRoomType

```kotlin
enum class EduContextRoomType(val value: Int) {
    OneToONe(0),
    LargeClass(2),
    SmallClass(4);
}
```

The classroom type.

| Parameter | Description |
| :----------- | :--------------- |
| `oneToOne` | One-to-one Classroom. |
| `LargeClass` | Lecture Hall. |
| `SmallClass` | Small Classroom. |

## EduContextConnectionState

```kotlin
enum class EduContextConnectionState {
    connecting(0),
    connected(1),
    reconnecting(2),
    disconnecting(3),
    disconnected(4);
}
```

The connection state of the whiteboard room.

| Parameter | Description |
| :-------------- | :----------- |
| `connecting` | The SDK is connecting to the RTM system. |
| `connected` | The SDK is connected to the RTM system. |
| `reconnecting` | The SDK is reconnecting to the RTM system. |
| `disconnecting` | The whiteboard is disconnecting. |
| `disconnected` | The SDK disconnects from the RTM system. |

## EduContextMediaStreamType

```kotlin
enum class EduContextMediaStreamType(val value: Int) {
    Audio(0),
    Video(1),
    All(2)
}
```

The type of the media stream.

| Parameter | Description |
| :------ | :--------- |
| `Audio` | An audio stream. |
| `Video` | A video stream. |
| `All` | Audio and video streams. |

## EduContextRenderMode

```kotlin
enum class EduContextRenderMode(val value: Int) {
    HIDDEN(1),
    FIT(2)
}
```

Video rendering mode.

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `HIDDEN` | Hidden mode. Uniformly scale the video until it fills the visible boundaries (cropped). One dimension of the video may have clipped contents. |
| `FIT` | Fit mode. Uniformly scale the video until one of its dimension fits the boundary (zoomed to fit). Areas that are not filled due to the disparity in the aspect ratio are filled with black. |

## EduContextMirrorMode

```kotlin
enum class EduContextMirrorMode(val value: Int) {
    AUTO(0),
    ENABLED(1),
    DISABLED(2)
}
```

Whether to enable mirror mode.

| Parameter | Description |
| :--------- | :--------------------- |
| `AUTO` | The SDK disables mirror mode by default. |
| `ENABLED` | Enable mirror mode. |
| `DISABLED` | Disable mirror mode. |

## EduContextVideoEncoderConfig

```kotlin
data class EduContextVideoEncoderConfig(
        val videoDimensionWidth: Int = VideoDimensions_320X240[0],
        val videoDimensionHeight: Int = VideoDimensions_320X240[1],
        val frameRate: Int = 15,
        val bitRate: Int = 200,
        val mirrorMode: EduContextMirrorMode = EduContextMirrorMode.AUTO) {

    fun convert(): EduVideoEncoderConfig {
        return EduVideoEncoderConfig(videoDimensionWidth, videoDimensionHeight, frameRate, bitRate,
                mirrorMode.value)
    }
}
```

Video encoder configurations.

| Parameter | Description |
| :--------------------- | :----------------------------------------------------------- |
| `videoDimensionWidth` | The video width (pixel). The default value is 320. |
| `videoDimensionHeight` | The video height (pixel). The default value is 240. |
| `frameRate` | Frame rate (fps). The default value is 15. |
| `bitrate` | Birate (Kbps). The default value is 200. |
| `mirrorMode` | Mirror mode. See `AgoraEduContextVideoMirrorMode` for details. The default value is `AUTO`. |

## EduContextRenderConfig

```kotlin
data class EduContextRenderConfig(
        val renderMode: EduContextRenderMode = EduContextRenderMode.HIDDEN,
        val mirrorMode: EduContextMirrorMode = EduContextMirrorMode.AUTO)
```

Video encoder configurations.

| Parameter | Description |
| :----------- | :----------------------------------------------------------- |
| `renderMode` | Video rendering mode. See `EduContextRenderMode` for details. The default value is `HIDDEN`. |
| `mirrorMode` | Mirror mode. See `AgoraEduContextVideoMirrorMode` for details. The default value is `AUTO`. |

## EduContextDeviceLifecycle

```kotlin
enum class EduContextDeviceLifecycle(val value: Int) {
    Stop(0),
    Resume(1)
}
```

The state in the life cycle of a device.

| Parameter | Description |
| :------- | :----------------------------------- |
| `Stop` | The device stops capturing and releases resources. |
| `Resume` | The device returns to the state before ` Stop`. |
