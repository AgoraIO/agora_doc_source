本页列出 Edu Context 所使用的类型定义。

## WhiteboardApplianceType

```kotlin
enum class WhiteboardApplianceType {
    Select, Pen, Rect, Circle, Line, Eraser, Text;
}
```

白板基础工具类型。

| 参数     | 描述     |
| :------- | :------- |
| `Select` | 选择器。 |
| `Pen`    | 画笔。   |
| `Rect`   | 矩形。   |
| `Circle` | 圆形。   |
| `Line`   | 线条。   |
| `Eraser` | 橡皮擦。 |
| `Text`   | 文本框。 |

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

| 参数              | 描述         |
| :---------------- | :----------- |
| `activeAppliance` | 可用的白板基础工具。   |
| `color`           | 颜色。       |
| `fontsize`        | 字体大小。   |
| `thick`           | 画笔粗细度。 |

## EduContextNetworkState

```kotlin
enum class EduContextNetworkState {
    Good, Medium, Bad, Unknown;
}
```

网络状况。

| 参数      | 描述   |
| :-------- | :----- |
| `Good`    | 较好。 |
| `Medium`  | 一般。 |
| `Bad`     | 较差。 |
| `Unknown` | 未知。 |

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

RTM 连接状态。

| 参数           | 描述         |
| :------------- | :----------- |
| `Disconnected` | 连接已断开。 |
| `Connecting`   | 连接中。     |
| `Connected`    | 已连接。     |
| `Reconnecting` | 重连中。     |
| `Aborted`      | 被踢出。     |

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

| 参数            | 描述         |
| :-------------- | :----------- |
| `connecting`    | 连接中。     |
| `connected`     | 已连接。     |
| `reconnecting`  | 重连中。     |
| `disconnecting` | 断开连接中。 |
| `disconnected`  | 连接已断开。 |

## EduContextClassState

```kotlin
enum class EduContextClassState {
    Init, Start, End, Destroyed
}
```

课堂状态。

| 参数        | 描述               |
| :---------- | :----------------- |
| `Init`      | 课堂已初始化完成。 |
| `Start`     | 课堂已开始。       |
| `End`       | 课堂已结束。       |
| `Destroyed` | 课堂已被销毁。     |

## EduContextUserRole

```kotlin
enum class EduContextUserRole(val value: Int) {
    Teacher(1),
    Student(2),
    Assistant(3)
}
```

用户角色。

| 参数        | 描述   |
| :---------- | :----- |
| `Teacher`   | 老师。 |
| `Student`   | 学生。 |
| `Assistant` | 助教。 |

## EduContextUserInfo

```kotlin
data class EduContextUserInfo(
        val userUuid: String,
        val userName: String,
        val role: EduContextUserRole = EduContextUserRole.Student,
        val properties: MutableMap<String, String>?
)
```

用户信息。

| 参数         | 描述                                  |
| :----------- | :------------------------------------ |
| `userUuid`   | 用户 ID。                             |
| `userName`   | 用户名称。                            |
| `role`       | 用户角色，详见 `EduContextUserRole`。 |
| `properties` | 自定义用户属性。                      |

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

用户详细信息。

| 参数           | 描述                                           |
| :------------- | :--------------------------------------------- |
| `isSelf`       | 是否为本地用户。                               |
| `onLine`       | 是否在线。                                     |
| `coHots`       | 是否在台上。                                   |
| `boardGranted` | 是否拥有白板权限。                             |
| `cameraState`  | 摄像头可用状态，详见 `EduContextDeviceState`。 |
| `microState`   | 麦克风可用状态，详见 `EduContextDeviceState`。 |
| `enableVideo`  | 是否开启视频。                                 |
| `enableAudio`  | 是否开启音频。                                 |
| `silence`      | 是否拥有消息聊天的权限。                       |
| `rewardCount`  | 奖励数量。                                     |

## DeviceState

```kotlin
enum class DeviceState(val value: Int) {
    UnAvailable(0),
    Available(1),
    Closed(2)
}
```

设备状态。

| 参数          | 描述           |
| :------------ | :------------- |
| `UnAvailable` | 设备不可用。   |
| `Available`   | 设备可用。     |
| `Closed`      | 设备已被关闭。 |

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

聊天消息具体信息。

| 参数        | 描述                                       |
| :---------- | :----------------------------------------- |
| `name`      | 消息发送者名称。                           |
| `uid`       | 消息发送者 ID。                            |
| `role`      | 消息发送者角色。                           |
| `message`   | 消息内容。                                 |
| `messageId` | 消息 ID。                                  |
| `type`      | 消息类型，详见 `EduContextChatItemType`。  |
| `source`    | 消息来源，详见 `EduContextChatSource`。    |
| `state`     | 消息发送状态，详见 `EduContextChatState`。 |
| `timestamp` | 消息发送时间戳。                           |

## EduContextChatItemSendResult

```kotlin
data class EduContextChatItemSendResult(
        val fromUserId: String,
        val messageId: String,
        val timestamp: Long
)
```

聊天消息发送结果。

| 参数         | 描述             |
| :----------- | :--------------- |
| `fromUserId` | 消息发送者 ID。  |
| `messageId`  | 消息 ID。        |
| `timestamp`  | 消息发送时间戳。 |

## EduContextChatItemType

```kotlin
enum class EduContextChatItemType {
    Text
}
```

信息类型。

| 参数   | 描述       |
| :----- | :--------- |
| `Text` | 文字消息。 |

## EduContextChatSource

```kotlin
enum class EduContextChatSource {
    Local, Remote, System
}
```

信息来源。

| 参数     | 描述       |
| :------- | :--------- |
| `Local`  | 本地消息。 |
| `Remote` | 远端消息。 |
| `System` | 系统消息。 |

## EduContextChatState

```kotlin
enum class EduContextChatState {
    Default, InProgress, Success, Fail
}
```

消息发送状态。

| 参数         | 描述           |
| :----------- | :------------- |
| `Default`    | 默认状态。     |
| `InProgress` | 消息发送中。   |
| `Success`    | 消息发送成功。 |
| `Fail`       | 消息发送失败。 |

## EduContextHandsUpState

```kotlin
enum class EduContextHandsUpState(val value: Int) {
    Init(0),
    HandsUp(1),
    HandsDown(2)
}
```

举手状态。

| 参数        | 描述       |
| :---------- | :--------- |
| `Init`      | 初始状态。 |
| `HandsUp`   | 举手中。   |
| `HandsDown` | 手放下。   |

## EduContextScreenShareState

```kotlin
enum class EduContextScreenShareState(val value: Int) {
    Start(0),
    Pause(1),
    Stop(2)
}
```

屏幕共享状态。

| 参数    | 描述             |
| :------ | :--------------- |
| `Start` | 屏幕共享已开始。 |
| `Pause` | 屏幕共享已暂停。 |
| `Stop`  | 屏幕共享已结束。 |

## EduContextCameraFacing

```kotlin
enum class EduContextCameraFacing(val value: Int) {
    Front(0),
    Back(1);
}
```

摄像头方向。

| 参数    | 描述         |
| :------ | :----------- |
| `Front` | 前置摄像头。 |
| `Back`  | 后置摄像头。 |

## EduContextDeviceConfig

```kotlin
data class EduContextDeviceConfig(
        var cameraEnabled: Boolean = true,
        var cameraFacing: EduContextCameraFacing = EduContextCameraFacing.Front,
        var micEnabled: Boolean = true,
        var speakerEnabled: Boolean = true)
```

设备配置。

| 参数             | 描述             |
| :--------------- | :--------------- |
| `cameraEnabled`  | 摄像头是否开启。 |
| `cameraFacing`   | 摄像头方向。     |
| `micEnabled`     | 麦克风是否开启。 |
| `speakerEnabled` | 扬声器是否开启。 |

## EduContextRoomInfo

```kotlin
data class EduContextRoomInfo(
        val roomUuid: String,
        val roomName: String,
        val roomType: EduContextRoomType
)
```

课堂基本信息。

| 参数       | 描述                                  |
| :--------- | :------------------------------------ |
| `roomUuid` | 课堂 ID。                             |
| `roomName` | 课堂名称。                            |
| `roomType` | 课堂类型，详见 `EduContextRoomType`。 |

## EduContextRoomType

```kotlin
enum class EduContextRoomType(val value: Int) {
    OneToONe(0),
    LargeClass(2),
    SmallClass(4);
}
```

课堂类型。

| 参数         | 描述             |
| :----------- | :--------------- |
| `OneToONe`   | 一对一互动教学。 |
| `LargeClass` | 互动直播大班课。 |
| `SmallClass` | 在线互动小班课。 |

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

| 参数            | 描述         |
| :-------------- | :----------- |
| `connecting`    | 连接中。     |
| `connected`     | 已连接。     |
| `reconnecting`  | 重连中。     |
| `disconnecting` | 断开连接中。 |
| `disconnected`  | 连接已断开。 |

## EduContextMediaStreamType

```kotlin
enum class EduContextMediaStreamType(val value: Int) {
    Audio(0),
    Video(1),
    All(2)
}
```

媒体流类型。

| 参数    | 描述       |
| :------ | :--------- |
| `Audio` | 音频流。   |
| `Video` | 视频流     |
| `All`   | 音视频流。 |

## EduContextRenderMode

```kotlin
enum class EduContextRenderMode(val value: Int) {
    HIDDEN(1),
    FIT(2)
}
```

视频渲染模式。

| 参数     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| `HIDDEN` | 优先保证视窗被填满。视频尺寸等比缩放，直至整个视窗被视频填满。如果视频长宽与显示窗口不同，多出的视频将被截掉。 |
| `FIT`    | 优先保证视频内容全部显示。视频尺寸等比缩放，直至视频窗口的一边与视窗边框对齐。如果视频长宽与显示窗口不同，视窗上未被填满的区域将被涂黑。 |

## EduContextMirrorMode

```kotlin
enum class EduContextMirrorMode(val value: Int) {
    AUTO(0),
    ENABLED(1),
    DISABLED(2)
}
```

是否开启镜像模式。

| 参数       | 描述                   |
| :--------- | :--------------------- |
| `AUTO`     | SDK 默认关闭镜像模式。 |
| `ENABLED`  | 开启镜像模式。         |
| `DISABLED` | 关闭镜像模式。         |

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

视频编码配置。

| 参数                   | 描述                                                         |
| :--------------------- | :----------------------------------------------------------- |
| `videoDimensionWidth`  | 视频宽，单位为 pixel。默认值为 320。                         |
| `videoDimensionHeight` | 视频高，单位为 pixel。默认值为 240。                         |
| `frameRate`            | 视频帧率，单位为 fps，默认值为 15。                          |
| `bitrate`              | 视频码率，单位为 Kbps，默认值为 200。                        |
| `mirrorMode`           | 镜像模式，详见 `AgoraEduContextVideoMirrorMode`。默认为 `AUTO`。 |

## EduContextRenderConfig

```kotlin
data class EduContextRenderConfig(
        val renderMode: EduContextRenderMode = EduContextRenderMode.HIDDEN,
        val mirrorMode: EduContextMirrorMode = EduContextMirrorMode.AUTO)
```

视频编码配置。

| 参数         | 描述                                                         |
| :----------- | :----------------------------------------------------------- |
| `renderMode` | 视频渲染模式，详见 `EduContextRenderMode`。默认为 `HIDDEN`。 |
| `mirrorMode` | 镜像模式，详见 `AgoraEduContextVideoMirrorMode`。默认为 `AUTO`。 |

## EduContextDeviceLifecycle

```kotlin
enum class EduContextDeviceLifecycle(val value: Int) {
    Stop(0),
    Resume(1)
}
```

设备的生命周期状态。

| 参数     | 描述                                 |
| :------- | :----------------------------------- |
| `Stop`   | 停止设备采集，释放资源。             |
| `Resume` | 将设备状态恢复至 `Stop` 之前的状态。 |
