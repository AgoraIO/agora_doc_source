# User List Context

## UserContext

The` UserContext` class provides methods related to the user list that can be called by the App.

### muteVideo

```kotlin
abstract fun muteVideo(muted: Boolean)
```

Turn local video on or off.

| Parameter | Description |
| :------ | :----------------- |
| `muted` | Whether to close the local video. |

### muteAudio

```kotlin
abstract fun muteAudio(muted: Boolean)
```

Turn local audio on or off.

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
| `container` | Video Container. If ``viewGroup` is null`, it means to close the stream rendering. |
| `streamUuid` | Stream ID. |



## IUserHandler

The` IUserHandler` class is used to report event callbacks related to the user list to the App.

### onUserListUpdated

```kotlin
fun onUserListUpdated(list: MutableList<EduContextUserDetailInfo>)
```

Prompt that the user list has been updated. Only display information about online users.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `list` | List of online users, an array of `EduContextUserDetailInfo` objects. |

### onCoHostListUpdated

```kotlin
// Update the list of personnel information on stage, only display personnel information on stage. (Onstage will include offline ones)
fun onCoHostListUpdated(list: MutableList<EduContextUserDetailInfo>)
```

Prompt that the list of on-stage users has been updated. Only display the information of users who are on the stage, including users who are not online.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `list` | The list of on-stage users, an array of `EduContextUserDetailInfo` objects. |

### onUserReward

```kotlin
fun onUserReward (userInfo: EduContextUserInfo)
```

Receive rewards.

| Parameter | Description |
| :--------- | :------------------------------------ |
| `userInfo` | User information, see EduContextUserInfo for details``. |

### onKickOut

```kotlin
// I was kicked out
fun onKickOut()
```

The local client is brought up in the classroom.

### onVolumeUpdated

```kotlin
fun onVolumeUpdated(volume: Int, streamUuid: String)
```

Prompt volume.

| Parameter | Description |
| :----------- | :------ |
| `volume` | volume. |
| `streamUuid` | Stream ID. |

### onUserTip

```kotlin
fun onUserTip(tip: String)
```

Report user-related prompt information.

There are the following tips:

- Your camera is turned off.
- Your camera is turned on.
- Your microphone is turned off.
- Your microphone is turned on.

| Parameter | Description |
| :------- | :--------- |
| `String` | The event message. |

### onRoster

```kotlin
fun onRoster(context: Context, anchor: View, type: Int?)
```

Display a list of users.

| Parameter | Description |
| :-------- | :----------------------------------------------------------- |
| `context` | The context of the app. |
| `anchor` | User list Icon-View. |
| `type` | There are two types of user lists:<li>`RosterType.SmallClass`: The user list of the interactive small class.<li>`RosterType.LargeClass`: A list of users who broadcast large classes. |

