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

| 参数 | 描述 |
| :--- | :--- |
|      |      |

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
// 用户信息
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
// streamUuid: 流Id
data class EduContextUserDetailInfo(val user: EduContextUserInfo, val streamUuid: String) {
    // 是否是本地用户
    var isSelf: Boolean = true
    // 是否在线
    var onLine: Boolean = false
    // 是否在台上
    var coHost: Boolean = false
    // 是否拥有白板权限
    var boardGranted: Boolean = false
    // 摄像头可用状态
    var cameraState: DeviceState = DeviceState.UnAvailable
    // 麦克风可用状态
    var microState: DeviceState = DeviceState.UnAvailable
    // 是否打开视频
    var enableVideo: Boolean = false
    // 是否打开音频
    var enableAudio: Boolean = false
    // 奖励数量
    var rewardCount: Int = -1
}
```

用户详细信息。

| 参数 | 描述 |
| :--- | :--- |
|      |      |

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
// 聊天信息
data class EduContextChatItem(
        // 信息发送者姓名
        var name: String = "",
        // 信息发送者id
        var uid: String = "",
        // 内容
        var message: String = "",
        // 信息Id
        var messageId: Int = 0,
        // 信息类型
        var type: EduContextChatItemType = EduContextChatItemType.Text,
        // 信息来源
        var source: EduContextChatSource = EduContextChatSource.Remote,
        // 信息发送状态
        var state: EduContextChatState = EduContextChatState.Default,
        // 时间戳
        var timestamp: Long = 0) {
}
```

聊天消息具体信息。

| 参数 | 描述 |
| :--- | :--- |
| ``   |      |
| ``   |      |
| ``   |      |
| ``   |      |
| ``   |      |
| ``   |      |
| ``   |      |
| ``   |      |

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
