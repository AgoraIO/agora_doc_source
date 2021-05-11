# User List Context

## AgoraEduUserContext

The` AgoraEduUserContext` class provides methods related to the user list that can be called by the App.

### muteVideo

```swift
func muteVideo(_ mute: Bool)
```

Turn local video on or off.

| Parameter | Description |
| :----- | :----------------- |
| `mute` | Whether to close the local video. |

### muteAudio

```swift
func muteAudio(_ mute: Bool)
```

Turn local audio on or off.

| Parameter | Description |
| :----- | :----------------- |
| `mute` | Whether to close the local audio. |

### renderView

```swift
func renderView(_ view: UIView?, streamUuid: String)
```

Start or stop rendering the local video stream.

| Parameter | Description |
| :----------- | :----------------------------------------------- |
| `view` | Video Container. The ``view` is nil`, which means that streaming rendering is closed. |
| `streamUuid` | Stream ID. |

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduUserHandler)
```

Register event listener.

| Parameter | Description |
| :-------- | :------------------------------ |
| `handler` | See the `AgoraEduUserHandler` class for details. |

## AgoraEduUserHandler

The` AgoraEduUserHandler` class is used to report event callbacks related to the user list to the App.

### onUpdateUserList

```swift
@objc optional func onUpdateUserList(_ list: [AgoraEduContextUserDetailInfo])
```

Prompt that the user list has been updated. Only display information about online users.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `list` | Online user list, an array composed of `AgoraEduContextUserDetailInfo` objects. |

### onUpdateCoHostList

```swift
@objc optional func onUpdateCoHostList(_ list: [AgoraEduContextUserDetailInfo])
```

Prompt that the list of on-stage users has been updated. Only display the information of users who are on the stage, including users who are not online.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `list` | The list of on-stage users, an array composed of `AgoraEduContextUserDetailInfo` objects. |

### onShowUserReward

```swift
@objc optional func onShowUserReward(_ user: AgoraEduContextUserInfo)
```

Receive rewards.

| Parameter | Description |
| :--------- | :----------------------------------------- |
| `userInfo` | For user information, see AgoraEduContextUserInfo for details``. |

### onKickedOut

```swift
@objc optional func onKickedOut()
```

The local client is brought up in the classroom.

### onUpdateAudioVolumeIndication

```swift
@objc optional func onUpdateAudioVolumeIndication(_ value: Int, streamUuid: String)
```

Prompt volume.

| Parameter | Description |
| :----------- | :------ |
| `volume` | volume. |
| `streamUuid` | Stream ID. |

### onShowUserTips

```swift
@objc optional func onShowUserTips(_ message: String)
```

Report user-related prompt information.

There are the following tips:

- Your camera is turned off.
- Your camera is turned on.
- Your microphone is turned off.
- Your microphone is turned on.

| Parameter | Description |
| :-------- | :--------- |
| `message` | The event message. |
