# User List Context

## UserContext

`UserContext` class provides user-list-related methods that can be called by your app.

### muteVideo

```kotlin
abstract fun muteVideo(muted: Boolean)
```

Enable or disable the local video.

| Parameter | Description |
| :------ | :----------------- |
| `muted` | Whether to disable the local video. |

### muteAudio

```kotlin
abstract fun muteAudio(muted: Boolean)
```

Enable or disable the local audio.

| Parameter | Description |
| :------ | :----------------- |
| `muted` | Whether to close the local audio. |

### renderVideo

```kotlin
abstract fun renderVideo(container: ViewGroup?, streamUuid: String)
```

Start or stop rendering the local video stream.

| Parameter | Description |
| :----------- | :----------------------------------------------------- |
| `container` | The video container. `Setting viewGroup` as `null` means stopping rendering the video stream. |
| `streamUuid` | The stream ID. |

## IUserHandler

`IUserHandler` reports user-list-related event callbacks to the app.

### onUserListUpdated

```kotlin
fun onUserListUpdated(list: MutableList<EduContextUserDetailInfo>)
```

Occurs when the user list is updated. Only display the information of online users.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `list` | The list of online users, which is an array of `EduContextUserDetailInfo` objects. |

### onCoHostListUpdated

```kotlin
fun onCoHostListUpdated(list: MutableList<EduContextUserDetailInfo>)
```

Occurs when the list of on-stage users is updated. Only display the information of users who are on the stage, including the offline users.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `list` | The list of on-stage users, which is an array of `EduContextUserDetailInfo` objects. |

### onUserReward

```kotlin
fun onUserReward (userInfo: EduContextUserInfo)
```

Occurs when the local user receives a reward.

| Parameter | Description |
| :--------- | :------------------------------------ |
| `userInfo` | The user information. See `EduContextUserInfo`. |

### onKickOut

```kotlin
fun onKickOut()
```

Occurs when the local user is kicked out of the classroom.

### onVolumeUpdated

```kotlin
fun onVolumeUpdated(volume: Int, streamUuid: String)
```

Occurs when the volume of the local user is updated.

| Parameter | Description |
| :----------- | :------ |
| `volume` | The volume. |
| `streamUuid` | The stream ID. |

### onUserTip

```kotlin
fun onUserTip(tip: String)
```

Reports the tips related to the user.

There are the following tips:

- Your camera has been turned off.
- Your camera has been turned on.
- Your microphone has been turned off.
- Your microphone has been turned on.

| Parameter | Description |
| :------- | :--------- |
| `string` | The tip. |

### onRoster

```kotlin
fun onRoster(context: Context, anchor: View, type: Int?)
```

Display the user list.

| Parameter | Description |
| :-------- | :----------------------------------------------------------- |
| `context` | The context of the app. |
| `anchor` | The Icon-View of the user list. |
| `type` | There are two types of user lists:<li>`RosterType.SmallClass`: The user list for small classrooms.<li>`RosterType.LargeClass`: The user list for lecture halls. |

