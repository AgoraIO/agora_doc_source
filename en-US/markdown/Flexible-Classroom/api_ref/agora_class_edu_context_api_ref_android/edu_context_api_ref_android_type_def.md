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

白板连接状态。

| Parameter | Description |
| :-------------- | :----------- |
| `connecting` | The SDK is connecting to the RTM system. |
| `connected` | The SDK is connected to the RTM system. |
| `reconnecting` | The SDK is reconnecting to the RTM system. |
| `disconnecting` | 断开连接中。 |
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
| `role` | The user role. See EduContextUserRole for details``. |
| `properties` | 自定义用户属性。 |

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
| `boardGranted` | Whether the user has permission of drawing on the whiteboard. |
| `cameraState` | The camera state of the user. See `AgoraEduContextDeviceState`. |
| `microState` | The microphone state of the user. See `AgoraEduContextDeviceState`. |
| `enableVideo` | Whether the user enables the video. |
| `enableAudio` | Whether the user enables the audio. |
| `silence` | 是否拥有消息聊天的权限。 |
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
| `role` | The name of the message sender. |
| `message` | The message. |
| `messageId` | The message ID. |
| `type` | The message type. See EduContextChatItemType for details``. |
| `source` | The source of the message. See EduContextChatSource for details``. |
| `state` | The sending state of the message. See EduContextChatState for details``. |
| `timestamp` | The timestamp when the message is sent. |

## EduContextChatItemSendResult

```kotlin
data class EduContextChatItemSendResult(
        val fromUserId: String,
        val messageId: String,
        val timestamp: Long
)
```

聊天消息发送结果。

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

屏幕共享状态。

| Parameter | Description |
| :------ | :--------------- |
| `Start` | 屏幕共享已开始。 |
| `Pause` | 屏幕共享已暂停。 |
| `Stop` | 屏幕共享已结束。 |

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

设备配置。

| Parameter | Description |
| :--------------- | :--------------- |
| `cameraEnabled` | Whether to turn on the camera. |
| `cameraFacing` | The camera direction. |
| `micEnabled` | Whether to turn on the microphone. |
| `speakerEnabled` | Whether to turn on the speaker. |

## EduContextRoomInfo

```kotlin
data class EduContextRoomInfo(
        val roomUuid: String,
        val roomName: String,
        val roomType: EduContextRoomType
)
```

The basic user information.

| Parameter | Description |
| :--------- | :------------------------------------ |
| `roomUuid` | The room ID. |
| `roomName` | The classroom name. |
| `roomType` | 课堂类型，详见 `EduContextRoomType`。 |

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
| `oneToOne` | 一对一互动教学。 |
| `LargeClass` | Lecture Hall |
| `SmallClass` | Small Classroom |

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

白板房间连接状态。

| Parameter | Description |
| :-------------- | :----------- |
| `connecting` | The SDK is connecting to the RTM system. |
| `connected` | The SDK is connected to the RTM system. |
| `reconnecting` | The SDK is reconnecting to the RTM system. |
| `disconnecting` | 断开连接中。 |
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
| `Audio` | Audio-only streams. |
| `Video` | 视频流 |
| `All` | 音视频流。 |

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

## The video encoding configuration. See EduContextVideoEncoderConfig.

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

Video profile

| Parameter | Description |
| :--------------------- | :----------------------------------------------------------- |
| `videoDimensionWidth` | The page height (pixel). The default value is 320. |
| `videoDimensionHeight` | The page height (pixel). The default value is 200. |
| `frameRate` | 视频帧率，单位为 fps，默认值为 15。 |
| `bitrate` | 视频码率，单位为 Kbps，默认值为 200。 |
| `mirrorMode` | 镜像模式，详见 `AgoraEduContextVideoMirrorMode`。 默认为 `AUTO`。 |

## EduContextRenderConfig

```kotlin
data class EduContextRenderConfig(
        val renderMode: EduContextRenderMode = EduContextRenderMode.HIDDEN,
        val mirrorMode: EduContextMirrorMode = EduContextMirrorMode.AUTO)
```

Video profile

| Parameter | Description |
| :----------- | :----------------------------------------------------------- |
| `renderMode` | 视频渲染模式，详见 `EduContextRenderMode`。 默认为 `HIDDEN`。 |
| `mirrorMode` | 镜像模式，详见 `AgoraEduContextVideoMirrorMode`。 默认为 `AUTO`。 |

## EduContextDeviceLifecycle

```kotlin
enum class EduContextDeviceLifecycle(val value: Int) {
    Stop(0),
    Resume(1)
}
```

设备的生命周期状态。

| Parameter | Description |
| :------- | :----------------------------------- |
| `Stop` | 停止设备采集，释放资源。 |
| `Resume` | 将设备状态恢复至 `Stop` 之前的状态。 |
