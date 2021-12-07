This page lists the type definitions used by Agora Edu Context.

## AgoraEduContextError

```swift
@objcMembers public class AgoraEduContextError: NSObject {
    public var code: Int = 0
    public var message: String = ""
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
    public var roomType: AgoraEduContextRoomType
}
```

The classroom information.

| Parameter | Description |
| :---------------- | :----------- |
| `roomUuid` | The room ID. |
| `roomName` | The classroom name. |
| `roomType` | The classroom type. See `AgoraEduContextRoomType`. |

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
| `lecture` | Lecture Hall. |
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

## AgoraEduContextUserInfo

```swift
@objcMembers public class AgoraEduContextUserInfo: NSObject {
    public var userUuid: String
    public var userName: String
    public var role: AgoraEduContextUserRole
    public var userProperties: [String : Any]?
}
```

The basic user information.

| Parameter | Description |
| :--------- | :------------------------------------ |
| `userUuid` | The user ID. |
| `userName` | The user name. |
| `role` | The user role. See `AgoraEduContextUserRole` for details. |
| `userProperties` | Custom user properties. |

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
    public var enableChat: Bool = true
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
| `boardGranted` | Whether the user has the permission of drawing on the whiteboard. |
| `cameraState` | The camera state of the user. See `AgoraEduContextDeviceState`. |
| `microState` | The microphone state of the user. See `AgoraEduContextDeviceState`. |
| `enableVideo` | Whether the video is enabled. |
| `enableAudio` | Whether the audio is enabled. |
| `enableChat` | Whether the local client has the permission to send messages. |
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
    public var id: String
    public let message: String
    public let user: AgoraEduContextUserInfo
    public var sendState: AgoraEduContextChatState = .default
    public let type: AgoraEduContextChatType
    public let time: Int64
    public let from: AgoraEduContextChatFrom
}
```

The information of the message.

| Parameter | Description |
| :---------- | :----------------------------------------- |
| `id` | The message ID. |
| `message` | The message. |
| `user` | The user who sends the message. See `AgoraEduContextUserInfo` for details. |
| `sendState` | The sending state of the message. See `AgoraEduContextChatState` for details. |
| `type` | The message type. See `AgoraEduContextChatType` for details. |
| `time` | The message sending timestamp (ms). |
| `source` | The source of the message. See `AgoraEduContextChatFrom` for details. |

## AgoraEduContextChatType

```swift
@objc public enum AgoraEduContextChatType: Int {
    case text = 1
}
```

The message type.

| Parameter | Description |
| :----- | :--------- |
| `text` | Text. |

## AgoraEduContextChatFrom

```swift
@objc public enum AgoraEduContextChatFrom: Int {
    case local = 1, remote
}
```

The message source.

| Parameter | Description |
| :------- | :--------- |
| `local` | The message is from a local user. |
| `remote` | The message is from a remote user. |

## AgoraEduContextChatState

```swift
@objc public enum AgoraEduContextChatState: Int {
    case `default`, inProgress, success, failure
}
```

The sending state of the message.

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
| `handsUp` | Hand raised. |
| `handsDown` | Hand lowered. |

## AgoraEduContextHandsUpResult

```swift
@objc public enum AgoraEduContextHandsUpResult: Int {
    case rejected
    case accepted
    case timeout
}
```

The result of raising hands to request for speak.

| Parameter | Description |
| :--------- | :--------------- |
| `rejected` | The request to speak was denied. |
| `accepted` | The request to speak was accepted. |
| `timeout` | A timeout occurs. |

## AgoraEduContextScreenShareState

```swift
@objc public enum AgoraEduContextScreenShareState : Int {
    case start, pause, stop
}
```

The state of screen sharing.

| Parameter | Description |
| :------ | :--------------- |
| `start` | Screen sharing has been started. |
| `pause` | Screen sharing has been paused. |
| `stop` | Screen sharing has ended. |

## EduContextCameraFacing

```swift
@objc public enum EduContextCameraFacing : Int {
    case front, back
}
```

The camera direction.

| Parameter | Description |
| :------ | :----------- |
| `front` | The front camera. |
| `back` | The rear camera. |

## AgoraEduContextDeviceConfig

```swift
@objcMembers public class AgoraEduContextDeviceConfig: NSObject {
    public var cameraEnabled: Bool = true
    public var cameraFacing: EduContextCameraFacing = .front
    public var micEnabled: Bool = true
    public var speakerEnabled: Bool = true
}
```

Device configurations.

| Parameter | Description |
| :--------------- | :--------------- |
| `cameraEnabled` | Whether the camera is turned on. |
| `cameraFacing` | The camera direction. |
| `micEnabled` | Whether to the microphone is turned on. |
| `speakerEnabled` | Whether to the speaker is turned on. |

## AgoraEduContextVideoMirrorMode

```swift
@objc public enum AgoraEduContextVideoMirrorMode: Int {
    case auto, enabled, disabled
}
```

Whether to enable mirror mode.

| Parameter | Description |
| :--------- | :--------------------- |
| `auto` | The SDK disables mirror mode by default. |
| `enabled` | Enable mirror mode. |
| `disabled` | Disable mirror mode. |

## AgoraEduContextVideoConfig

```swift
@objcMembers public class AgoraEduContextVideoConfig: NSObject {
    public var videoDimensionWidth: UInt = 320
    public var videoDimensionHeight: UInt = 240
    public var frameRate: UInt = 15
    public var bitrate: UInt = 200
    public var mirrorMode: AgoraEduContextVideoMirrorMode = .auto
}
```

Video encoder configurations.

| Parameter | Description |
| :--------------------- | :----------------------------------------------------------- |
| `videoDimensionWidth` | The video width (pixel). The default value is 320. |
| `videoDimensionHeight` | The video height (pixel). The default value is 240. |
| `frameRate` | Frame rate (fps). The default value is 15. |
| `bitrate` | Birate (Kbps). The default value is 200. |
| `mirrorMode` | Mirror mode. See `AgoraEduContextVideoMirrorMode` for details. The default value is `auto`. |
