# Type definition

This page lists the type definitions used by Agora Edu Context.

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

The error code.

| Parameter | Description |
| :------- | :------- |
| `code` | The error code. |
| `message` | The error message. |

## AgoraEduContextApplianceType

```swift
@objc public enum AgoraEduContextApplianceType: Int {
    case select, pen, rect, circle, line, eraser
}
```

The whiteboard editing tool.

| Parameter | Description |
| :------- | :------- |
| `select` | Selector. |
| `pen` | Pen. |
| `rect` | Rectangle. |
| `circle` | Circle. |
| `line` | Line. |
| `eraser` | Eraser. |


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

The classroom information.

| Parameter | Description |
| :---------------- | :----------- |
| `roomUuid` | The room ID. |
| `roomName` | The classroom name. |

## AgoraEduContextClassState

```swift
@objc public enum AgoraEduContextClassState: Int {
    case `default`, start, end, close
}
```

The classroom state.

| Parameter | Description |
| :---------- | :----------------- |
| `default` | The classroom has been initialized. |
| `start` | The class has started. |
| `end` | The class is over. |
| `close` | The classroom is closed. |

## AgoraEduContextAppType

```swift
@objc public enum AgoraEduContextAppType: Int {
    case oneToOne = 0, small = 4
}
```

The classroom type.

| Parameter | Description |
| :---------- | :----------------- |
| `oneToOne` | One-to-one Classroom. |
| `small` | Small Classroom. |

## AgoraEduContextNetworkQuality

```swift
@objc public enum AgoraEduContextNetworkQuality: Int {
    case unknown, good, medium, bad
}
```

The network quality.

| Parameter | Description |
| :-------- | :----- |
| `good` | Good. |
| `medium` | Medium. |
| `bad` | Poor. |
| `unknown` | Unknown. |

## AgoraEduContextConnectionState

```swift
@objc public enum AgoraEduContextConnectionState: Int {
    case disconnected, connecting, connected, reconnecting, aborted
}
```

The connection state with the RTM system.

| Parameter | Description |
| :------------- | :----------- |
| `disconnected` | The SDK disconnects from the RTM system. |
| `connecting` | The SDK is connecting to the RTM system. |
| `connected` | The SDK is connected to the RTM system. |
| `reconnecting` | The SDK is reconnecting to the RTM system. |
| `aborted` | The connection has been aborted. |


## AgoraEduContextUserRole

```swift
@objc public enum AgoraEduContextUserRole: Int {
    case teacher = 1, student, assistant
}
```

The user role.

| Parameter | Description |
| :---------- | :----- |
| `teacher` | Teacher. |
| `student` | Student. |
| `assistant` | Teaching assistant. |

## NowEduContextUserInfo

```swift
@objcMembers public class AgoraEduContextUserInfo: NSObject {
    public var userUuid: String = ""
    public var userName: String = ""
    public var role: AgoraEduContextUserRole = .student
}
```

The basic user information.

| Parameter | Description |
| :--------- | :------------------------------------ |
| `userUuid` | The user ID. |
| `userName` | The user name. |
| `role` | The user role. See `AgoraEduContextUserRole` for details. |

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

The detailed user information.

| Parameter | Description |
| :------------- | :----------------------------------- |
| `user` | For the basic user information, see `AgoraEduContextUserInfo`. |
| `isSelf` | Whether the user is the local user. |
| `streamUuid` | The stream ID of the user. |
| `onLine` | Whether the user is online. |
| `coHost` | Whether the user is on stage. |
| `boardGranted` | Whether the user has permission of drawing on the whiteboard. |
| `cameraState` | The camera state of the user. See `AgoraEduContextDeviceState`. |
| `microState` | The microphone state of the user. See `AgoraEduContextDeviceState`. |
| `enableVideo` | Whether the user enables the video. |
| `enableAudio` | Whether the user enables the audio. |
| `rewardCount` | The number of rewards. |

## AgoraEduContextDeviceState

```swift
@objc public enum AgoraEduContextDeviceState: Int {
    case notAvailable, available
}
```

The device state.

| Parameter | Description |
| :------------ | :------------- |
| `notAvailable` | The device is unavailable. |
| `available` | The device is available. |

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

The information of the message.

| Parameter | Description |
| :---------- | :----------------------------------------- |
| `id` | The message ID. |
| `message` | The message. |
| `user` | The user who sends the message. See `AgoraEduContextUserInfo` for details. |
| `sendState` | Message sending status, see AgoraEduContextChatState for details``. |
| `type` | Message type, see AgoraEduContextChatType for details``. |
| `time` | Message sending timestamp. |
| `source` | The source of the message, see AgoraEduContextChatFrom for details``. |

## AgoraEduContextChatType

```swift
@objc public enum AgoraEduContextChatType: Int {
    case text = 1
}
```

Information type.

| Parameter | Description |
| :----- | :--------- |
| `text` | Text message. |

## AgoraEduContextChatFrom

```swift
@objc public enum AgoraEduContextChatFrom: Int {
    case local = 1, remote
}
```

Information Sources.

| Parameter | Description |
| :------- | :--------- |
| `local` | Local news. |
| `remote` | Remote message. |

## AgoraEduContextChatState

```swift
@objc public enum AgoraEduContextChatState: Int {
    case `default`, inProgress, success, failure
}
```

Message sending status.

| Parameter | Description |
| :----------- | :------------- |
| `default` | The initial state. |
| `inProgress` | The message is being sent. |
| `success` | The message is sent successfully. |
| `fail` | Fail to send the message. |

## AgoraEduContextHandsUpState

```swift
@objc public enum AgoraEduContextHandsUpState : Int {
    case `default`
    case handsUp
    case handsDown
}
```

The hand state.

| Parameter | Description |
| :---------- | :--------- |
| `default` | The initial state. |
| `dandsUp` | Hand raised. |
| `dandsDown` | Hand lowered. |
