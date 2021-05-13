# Type definition

This page lists the type definitions used by Edu Context.

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

Error code

| Parameter | Description |
| :------- | :------- |
| `code` | Error code |
| `message` | Error codes of the RTMP or RTMPS streaming. |

## AgoraEduContextApplianceType

```swift
@objc public enum AgoraEduContextApplianceType: Int {
    case select, pen, rect, circle, line, eraser
}
```

白板基础工具类型。

| Parameter | Description |
| :------- | :------- |
| `select` | Selector. |
| `pen` | brush. |
| `rect` | rectangle. |
| `circle` | Round. |
| `line` | line. |
| `eraser` | Eraser |


## AgoraEduContextRoomInfo

```swift
@objcMembers public class AgoraEduContextRoomInfo: NSObject {
    public var roomUuid: String
    public var roomName: String
     
    public init(roomUuid: String,
                roomName: string,
        self.roomUuid = roomUuid
        self.roomName = roomName
    }
}
```

Class information.

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

Classroom status.

| Parameter | Description |
| :---------- | :----------------- |
| `default` | The class has been initialized. |
| `start` | The class has started. |
| `end` | The class is over. |
| `close` | The class is closed. |

## AgoraEduContextAppType

```swift
@objc public enum AgoraEduContextAppType: Int {
    case oneToOne = 0, small = 4
}
```

The classroom type.

| Parameter | Description |
| :---------- | :----------------- |
| `oneToOne` | One-to-one Online Classroom |
| `small` | Live broadcast small classes online. |

## AgoraEduContextNetworkQuality

```swift
@objc public enum AgoraEduContextNetworkQuality: Int {
    case unknown, good, medium, bad
}
```

Network conditions.

| Parameter | Description |
| :-------- | :----- |
| `good` | better. |
| `medium` | general. |
| `bad` | Poor. |
| `unknown` | unknown. |

## AgoraEduContextConnectionState

```swift
@objc public enum AgoraEduContextConnectionState: Int {
    case disconnected, connecting, connected, reconnecting, aborted
}
```

RTM connection status.

| Parameter | Description |
| :------------- | :----------- |
| `disconnected` | The SDK disconnects from the network. |
| `connecting` | connecting. |
| `connected` | connected. |
| `reconnecting` | Reconnecting. |
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
| `teacher` | teacher. |
| `student` | student. |
| `assistant` | Teaching assistant. |

## NowEduContextUserInfo

```swift
@objcMembers public class AgoraEduContextUserInfo: NSObject {
    public var userUuid: String = ""
    public var userName: String = ""
    public var role: AgoraEduContextUserRole = .student
}
```

Basic user information.

| Parameter | Description |
| :--------- | :------------------------------------ |
| `userUuid` | User ID. |
| `userName` | user name. |
| `role` | User role, see AgoraEduContextUserRole for details``. |

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

The detailed information.

| Parameter | Description |
| :------------- | :----------------------------------- |
| `user` | For basic user information, see AgoraEduContextUserInfo for details``. |
| `isSelf` | Whether it is a local user. |
| `streamUuid` | The stream ID of the user. |
| `onLine` | Is it online? |
| `coHost` | Is it on stage? |
| `boardGranted` | Whether to have whiteboard permission. |
| `cameraState` | Camera availability status, see AgoraEduContextDeviceState for details``. |
| `microState` | Microphone availability status, see AgoraEduContextDeviceState for details``. |
| `enableVideo` | Enables video. |
| `enableAudio` | Whether to turn on audio. |
| `rewardCount` | The number of rewards. |

## AgoraEduContextDeviceState

```swift
@objc public enum AgoraEduContextDeviceState: Int {
    case notAvailable, available
}
```

Media device states.

| Parameter | Description |
| :------------ | :------------- |
| `notAvailable` | The device is unavailable. |
| `available` | The equipment is available. |

## NowEduContextChatInfo

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

The specific information of the chat message.

| Parameter | Description |
| :---------- | :----------------------------------------- |
| `id` | Retrieves the unique ID of the message. |
| `message` | Message content. |
| `user` | Message sender information, see AgoraEduContextUserInfo for details``. |
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
| `default` | The default state. |
| `inProgress` | The message is being sent. |
| `success` | The message was sent successfully. |
| `fail` | Failed to send the message. |

## AgoraEduContextHandsUpState

```swift
@objc public enum AgoraEduContextHandsUpState : Int {
    case `default`
    case handsUp
    case handsDown
}
```

Hand up state.

| Parameter | Description |
| :---------- | :--------- |
| `default` | The initial state. |
| `dandsUp` | Raise your hands. |
| `dandsDown` | Hands down. |
