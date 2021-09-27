## UserContext

`UserContext` class provides` user`-list-related methods that can be called by your app.

### localUserInfo

```kotlin
abstract fun localUserInfo(): EduContextUserInfo
```

获取本地用户信息。

### updateFlexUserProps

```kotlin
abstract fun updateFlexUserProps(userUuid: String,
                                 properties: MutableMap<String, String>,
                                 cause: MutableMap<String, String>?)
```

新增或更新自定义用户属性。 For details, see [How can I set user attributes? ](/en/agora-class/faq/agora_class_custom_properties)

The remote client receives the `onFlexUserPropertiesChanged` callback.

| Parameter | Description |
| :----------- | :--------- |
| `userUuid` | The user ID. |
| `properties` | user attribute |
| `cause` | 更新原因。 |

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
| `container` | The video container. Setting `viewGroup` as `null` means stopping rendering the video stream. |
| `streamUuid` | The stream ID. |

### setVideoEncoderConfig

```kotlin
abstract fun setVideoEncoderConfig(config: EduContextVideoEncoderConfig)
```

Sets the video encoder configuration.

| Parameter | Description |
| :------- | :-------------------------------------------------- |
| `config` | The video encoding configuration. See `EduContextVideoEncoderConfig`. |

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

Occurs when the list of on-stage users is updated. 只显示状态为“在台上”的用户信息，包含不在线的用户。

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `list` | The list of on-stage users, which is an array of `EduContextUserDetailInfo` objects. |

### onUserReward

```kotlin
fun onUserReward(userInfo: EduContextUserInfo)
```

Occurs when the local user receives a reward.

| Parameter | Description |
| :--------- | :------------------------------------ |
| `userInfo` | The user information. See `EduContextUserInfo`. |

### onKickOut

```kotlin
fun onKickOut()
```

本地用户被踢出课堂。

### onVolumeUpdated

```kotlin
fun onVolumeUpdated(volume: Int, streamUuid: String)
```

Occurs when the volume of the local user is updated.

| Parameter | Description |
| :----------- | :------ |
| `volume` | The volume. |
| `streamUuid` | The stream ID. |

### onRoster

```kotlin
fun onRoster(context: Context, anchor: View, type: Int?)
```

Display the user list.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `type` | 花名册分为小班花名册 (RosterType.SmallClass) 和大班花名册 (RosterType.LargeClass)。 |

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
| `type` | There are two types of user lists:<li>`RosterType.SmallClass`: The user list for` small` classrooms.<li>`RosterType.LargeClass`: The user list for lecture halls. |

### onFlexUserPropsChanged

```kotlin
fun onFlexUserPropsChanged(changedProperties: MutableMap<String, Any>,
                           properties: MutableMap<String, Any>,
                           cause: MutableMap<String, Any>?,
                           fromUser: EduContextUserDetailInfo,
                           operator: EduContextUserInfo?)
```

自定义用户属性更新回调。

| Parameter | Description |
| :------------------ | :----------------------------------------------------------- |
| `changedProperties` | 已更新的用户属性。 |
| `properties` | 全部用户属性。 |
| `cause` | 更新原因。 |
| `fromUser` | The user information. See `EduContextUserDetailInfo `for details. |
| `operator` | The user information. See `EduContextUserInfo`. `operator` 为空表示是由服务端更新。 |
