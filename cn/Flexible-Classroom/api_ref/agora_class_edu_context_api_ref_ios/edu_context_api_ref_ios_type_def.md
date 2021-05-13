# 类型定义

本页列出 Edu Context 所使用的类型定义。

## AgoraEduContextError

```swift
@objcMembers public class AgoraEduContextError: NSObject {
    public var code: Int = 0
    public var message: String = ""
    public init(code: Int,
                message: String?) {
        self.code = code
        self.message = message ?? ""
    }
}
```

错误码。

| 参数     | 描述     |
| :------- | :------- |
| `code` | 错误码。 |
| `message`    | 错误信息。   |

## AgoraEduContextApplianceType

```swift
@objc public enum AgoraEduContextApplianceType: Int {
    case select, pen, rect, circle, line, eraser
}
```

白板工具类型。

| 参数     | 描述     |
| :------- | :------- |
| `select` | 选择器。 |
| `pen`    | 画笔。   |
| `rect`   | 矩形。   |
| `circle` | 圆形。   |
| `line`   | 线条。   |
| `eraser` | 橡皮擦。 |


## AgoraEduContextRoomInfo

```swift
@objcMembers public class AgoraEduContextRoomInfo: NSObject {
    public var roomUuid: String
    public var roomName: String
     
    public init(roomUuid: String,
                roomName: String) {
        self.roomUuid = roomUuid
        self.roomName = roomName
    }
}
```

课堂信息。

| 参数              | 描述         |
| :---------------- | :----------- |
| `roomUuid` | 课堂 ID。   |
| `roomName`           | 课堂名称。       |

## AgoraEduContextClassState

```swift
@objc public enum AgoraEduContextClassState: Int {
    case `default`, start, end, close
}
```

课堂状态。

| 参数        | 描述               |
| :---------- | :----------------- |
| `default`      | 课堂已初始化完成。 |
| `start`     | 课堂已开始。       |
| `end`       | 课堂已结束。       |
| `close` | 课堂已关闭。     |

## AgoraEduContextAppType

```swift
@objc public enum AgoraEduContextAppType: Int {
    case oneToOne = 0, small = 4
}
```

课堂类型。

| 参数        | 描述               |
| :---------- | :----------------- |
| `oneToOne`      | 1 对 1 互动教学。 |
| `small`     | 在线直播小班课。       |

## AgoraEduContextNetworkQuality

```swift
@objc public enum AgoraEduContextNetworkQuality: Int {
    case unknown, good, medium, bad
}
```

网络状况。

| 参数      | 描述   |
| :-------- | :----- |
| `good`    | 较好。 |
| `medium`  | 一般。 |
| `bad`     | 较差。 |
| `unknown` | 未知。 |

## AgoraEduContextConnectionState

```swift
@objc public enum AgoraEduContextConnectionState: Int {
    case disconnected, connecting, connected, reconnecting, aborted
}
```

RTM 连接状态。

| 参数           | 描述         |
| :------------- | :----------- |
| `disconnected` | 连接已断开。 |
| `connecting`   | 连接中。     |
| `connected`    | 已连接。     |
| `reconnecting` | 重连中。     |
| `aborted`      | 连接已中止。     |


## AgoraEduContextUserRole

```swift
@objc public enum AgoraEduContextUserRole: Int {
    case teacher = 1, student, assistant
}
```

用户角色。

| 参数        | 描述   |
| :---------- | :----- |
| `teacher`   | 老师。 |
| `student`   | 学生。 |
| `assistant` | 助教。 |

## AgoraEduContextUserInfo

```swift
@objcMembers public class AgoraEduContextUserInfo: NSObject {
    public var userUuid: String = ""
    public var userName: String = ""
    public var role: AgoraEduContextUserRole = .student
}
```

用户基本信息。

| 参数       | 描述                                  |
| :--------- | :------------------------------------ |
| `userUuid` | 用户 ID。                             |
| `userName` | 用户名称。                            |
| `role`     | 用户角色，详见 `AgoraEduContextUserRole`。 |

## AgoraEduContextUserDetailInfo

```swift
@objcMembers public class AgoraEduContextUserDetailInfo: NSObject {
    public var user: AgoraEduContextUserInfo?
    public var isSelf: Bool = true
    public var streamUuid: String = ""
    public var onLine: Bool = false
    public var coHost: Bool = false
    public var boardGranted: Bool = false
    public var cameraState: AgoraEduContextDeviceState = .notAvailable
    public var microState: AgoraEduContextDeviceState = .notAvailable
    public var enableVideo: Bool = false
    public var enableAudio: Bool = false
    public var rewardCount: Int = 0
}
```

用户详细信息。

| 参数           | 描述                                 |
| :------------- | :----------------------------------- |
| `user`       | 用户基本信息，详见 `AgoraEduContextUserInfo`。                     |
| `isSelf`       | 是否为本地用户。                     |
| `streamUuid`       | 用户的流 ID。                     |
| `onLine`       | 是否在线。                           |
| `coHost`       | 是否在台上。                         |
| `boardGranted` | 是否拥有白板权限。                   |
| `cameraState`  | 摄像头可用状态，详见 `AgoraEduContextDeviceState`。 |
| `microState`   | 麦克风可用状态，详见 `AgoraEduContextDeviceState`。 |
| `enableVideo`  | 是否开启视频。                       |
| `enableAudio`  | 是否开启音频。                       |
| `rewardCount`  | 奖励数量。                           |

## AgoraEduContextDeviceState

```swift
@objc public enum AgoraEduContextDeviceState: Int {
    case notAvailable, available
}
```

设备状态。

| 参数          | 描述           |
| :------------ | :------------- |
| `notAvailable` | 设备不可用。   |
| `available`   | 设备可用。     |

## AgoraEduContextChatInfo

```swift
@objcMembers public class AgoraEduContextChatInfo: NSObject {
    public var id: Int = 0
    public var message: String = ""
    public var user: AgoraEduContextUserInfo?
    public var sendState: AgoraEduContextChatState = .default
    public var type: AgoraEduContextChatType = .text
    public var time: Int64 = 0
    public var from: AgoraEduContextChatFrom = .local
}
```

聊天消息具体信息。

| 参数        | 描述                                       |
| :---------- | :----------------------------------------- |
| `id`       | 消息 ID。                            |
| `message`   | 消息内容。                                 |
| `user`      | 消息发送者信息，详见 `AgoraEduContextUserInfo`。                           |
| `sendState`     | 消息发送状态，详见 `AgoraEduContextChatState`。 |
| `type`      | 消息类型，详见 `AgoraEduContextChatType`。  |
| `time` | 消息发送时间戳。                           |
| `source`    | 消息来源，详见 `AgoraEduContextChatFrom`。    |

## AgoraEduContextChatType

```swift
@objc public enum AgoraEduContextChatType: Int {
    case text = 1
}
```

信息类型。

| 参数   | 描述       |
| :----- | :--------- |
| `text` | 文字消息。 |

## AgoraEduContextChatFrom

```swift
@objc public enum AgoraEduContextChatFrom: Int {
    case local = 1, remote
}
```

信息来源。

| 参数     | 描述       |
| :------- | :--------- |
| `local`  | 本地消息。 |
| `remote` | 远端消息。 |

## AgoraEduContextChatState

```swift
@objc public enum AgoraEduContextChatState: Int {
    case `default`, inProgress, success, failure
}
```

消息发送状态。

| 参数         | 描述           |
| :----------- | :------------- |
| `default`    | 默认状态。     |
| `inProgress` | 消息发送中。   |
| `success`    | 消息发送成功。 |
| `fail`       | 消息发送失败。 |

## AgoraEduContextHandsUpState

```swift
@objc public enum AgoraEduContextHandsUpState : Int {
    case `default`
    case handsUp
    case handsDown
}
```

举手状态。

| 参数        | 描述       |
| :---------- | :--------- |
| `default`      | 初始状态。 |
| `dandsUp`   | 举手中。   |
| `dandsDown` | 手放下。   |
