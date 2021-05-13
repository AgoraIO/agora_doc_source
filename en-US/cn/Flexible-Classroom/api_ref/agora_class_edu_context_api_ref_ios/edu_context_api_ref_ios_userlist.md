## AgoraEduUserContext

`AgoraEduUserContext` provides user-list-related methods that can be called by your app.

### muteVideo

```swift
func muteVideo(_ mute: Bool)
```

Enable or disable the local video.

| Parameter | Description |
| :----- | :----------------- |
| `mute` | Whether to disable the local video. |

### muteAudio

```swift
func muteAudio(_ mute: Bool)
```

Enable or disable the local audio.

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
| `view` | The video container. `Setting view` as `nil` means stopping rendering the video stream. |
| `streamUuid` | The stream ID. |

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduUserHandler)
```

Register the event listener.

| Parameter | Description |
| :-------- | :------------------------------ |
| `handler` | See the `AgoraEduUserHandler` class for details. |

## AgoraEduUserHandler

`AgoraEduUserHandler` reports user-list-related event callbacks to the app.

### onUpdateUserList

```swift
@objc optional func onUpdateUserList(_ list: [AgoraEduContextUserDetailInfo])
```

Occurs when the user list is updated. Only display the information of online users.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `list` | The list of online users, which is an array of `AgoraEduContextUserDetailInfo` objects. |

### onUpdateCoHostList

```swift
@objc optional func onUpdateCoHostList(_ list: [AgoraEduContextUserDetailInfo])
```

Occurs when the list of on-stage users is updated. Only display the information of users who are on the stage, including the offline users.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `list` | The list of on-stage users, which is an array of `AgoraEduContextUserDetailInfo` objects. |

### onShowUserReward

```swift
@objc optional func onShowUserReward(_ user: AgoraEduContextUserInfo)
```

Occurs when the local user receives a reward.

| Parameter | Description |
| :--------- | :----------------------------------------- |
| `userInfo` | The user information. See `AgoraEduContextUserInfo` for details. |

### onKickedOut

```swift
@objc optional func onKickedOut()
```

Occurs when the local user is kicked out of the classroom.

### onUpdateAudioVolumeIndication

```swift
@objc optional func onUpdateAudioVolumeIndication(_ value: Int, streamUuid: String)
```

Occurs when the volume of the local user is updated.

| Parameter | Description |
| :----------- | :------ |
| `volume` | The volume. |
| `streamUuid` | The stream ID. |

### onShowUserTips

```swift
@objc optional func onShowUserTips(_ message: String)
```

Reports the tips related to the user.

There are the following tips:

- Your camera has been turned off.
- Your camera has been turned on.
- Your microphone has been turned off.
- Your microphone has been turned on.

| Parameter | Description |
| :-------- | :--------- |
| `message` | The tip. |
