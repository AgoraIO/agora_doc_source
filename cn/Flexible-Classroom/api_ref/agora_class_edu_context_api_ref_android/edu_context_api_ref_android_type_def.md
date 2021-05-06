# 类型定义

本页列出 Edu Context 所使用的类型定义。

## WhiteboardApplianceType

```kotlin
enum class WhiteboardApplianceType {
    Select, Pen, Rect, Circle, Line, Eraser, Text;
}
```

白板工具类型。

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

白板工具属性配置类。

| 参数              | 描述         |
| :---------------- | :----------- |
| `activeAppliance` | 白板工具。   |
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
        val role: EduContextUserRole = EduContextUserRole.Student
) {
}
```

用户信息。

| 参数       | 描述                                  |
| :--------- | :------------------------------------ |
| `userUuid` | 用户 ID。                             |
| `userName` | 用户名称。                            |
| `role`     | 用户角色，详见 `EduContextUserRole`。 |

## EduContextUserDetailInfo

```kotlin
// user: 用户信息
// streamUuid: 流 ID
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

| 参数           | 描述                                 |
| :------------- | :----------------------------------- |
| `isSelf`       | 是否为本地用户。                     |
| `onLine`       | 是否在线。                           |
| `coHots`       | 是否在台上。                         |
| `boardGranted` | 是否拥有白板权限。                   |
| `cameraState`  | 摄像头可用状态，详见 `DeviceState`。 |
| `microState`   | 麦克风可用状态，详见 `DeviceState`。 |
| `enableVideo`  | 是否开启视频。                       |
| `enableAudio`  | 是否开启音频。                       |
| `rewardCount`  | 奖励数量。                           |

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
| `message`   | 消息内容。                                 |
| `messageId` | 消息 ID。                                  |
| `type`      | 消息类型，详见 `EduContextChatItemType`。  |
| `source`    | 消息来源，详见 `EduContextChatSource`。    |
| `state`     | 消息发送状态，详见 `EduContextChatState`。 |
| `timestamp` | 消息发送时间戳。                           |

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
