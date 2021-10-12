## UserContext

`UserContext` class provides user-list-related methods that can be called by your app.

### localUserInfo

```kotlin
abstract fun localUserInfo(): EduContextUserInfo
```

Gets the information of the local user. See [EduContextUserInfo](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserinfo).

### updateFlexUserProps

```kotlin
abstract fun updateFlexUserProps(userUuid: String,
                                 properties: MutableMap<String, String>,
                                 cause: MutableMap<String, String>?)
```

Adds or updates custom user properties. For details, see [How can I set user properties? ](/en/agora-class/faq/agora_class_custom_properties)

After you successfully update the properties, the remote client receives the `onFlexUserPropertiesChanged` callback.

| Parameter | Description |
| :----------- | :--------- |
| `userUuid` | The user ID. |
| `properties` | The user properties. |
| `cause` | The update reason. |

### muteVideo

```kotlin
abstract fun muteVideo(muted: Boolean)
```

Enables or disables the local video.

| Parameter | Description |
| :------ | :----------------- |
| `muted` | Whether to disable the local video. |

### muteAudio

```kotlin
abstract fun muteAudio(muted: Boolean)
```

Enables or disables the local audio.

| Parameter | Description |
| :------ | :----------------- |
| `muted` | Whether to disable the local audio. |

### renderVideo

```kotlin
abstract fun renderVideo(container: ViewGroup?, streamUuid: String)
```

Starts or stops rendering the local video stream.

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
| :------- | :----------------------------------------------------------- |
| `config` | The video encoding configuration. See [EduContextVideoEncoderConfig](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextvideoencoderconfig). |

## IUserHandler

`IUserHandler` reports user-list-related event callbacks to the app.

### onUserListUpdated

```kotlin
fun onUserListUpdated(list: MutableList<EduContextUserDetailInfo>)
```

Occurs when the user list is updated. Only display the information of online users.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `list` | The list of online users, which is an array of [EduContextUserDetailInfo](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserdetailinfo) objects. |

### onCoHostListUpdated

```kotlin
fun onCoHostListUpdated(list: MutableList<EduContextUserDetailInfo>)
```

Occurs when the list of on-stage users is updated. Only display the information of users whose status is "on stage", including users who are not online.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `list` | The list of on-stage users, which is an array of [EduContextUserDetailInfo](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserdetailinfo) objects. |

### onUserReward

```kotlin
fun onUserReward(userInfo: EduContextUserInfo)
```

Occurs when the local user receives a reward.

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `userInfo` | The user information. See [EduContextUserInfo](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserinfo) for details. |

### onKickOut

```kotlin
fun onKickOut()
```

Occurs when the local user is kicked out of the classroom.

### onVolumeUpdated

```kotlin
fun onVolumeUpdated(volume: Int, streamUuid: String)
```

Occurs when the volume of the local user updates.

| Parameter | Description |
| :----------- | :------ |
| `volume` | The volume. |
| `streamUuid` | The stream ID. |

### onRoster

```kotlin
fun onRoster(context: Context, anchor: View, type: Int?)
```

Displays the user list.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `type` | There are two types of the user list: RosterType.SmallClass and RosterType.LargeClass. |

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

Displays the user list.

| Parameter | Description |
| :-------- | :----------------------------------------------------------- |
| `context` | The context of the app. |
| `anchor` | The Icon-View of the user list. |
| `type` | There are two types of user lists:<li>`RosterType.SmallClass`: The user list for the Small Classroom scenario.<li>`RosterType.LargeClass`: The user list for the Lecture Hall scenario. |

### onFlexUserPropsChanged

```kotlin
fun onFlexUserPropsChanged(changedProperties: MutableMap<String, Any>,
                           properties: MutableMap<String, Any>,
                           cause: MutableMap<String, Any>?,
                           fromUser: EduContextUserDetailInfo,
                           operator: EduContextUserInfo?)
```

Occurs when the custom user properties are updated.

| Parameter | Description |
| :------------------ | :----------------------------------------------------------- |
| `changedProperties` | The updated user properties. |
| `properties` | All user properties. |
| `cause` | The update reason. |
| `fromUser` | The information of users whose properties are updated. See [EduContextUserDetailInfo](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserdetailinfo) for details. |
| `operator` | The information of the operator. See [EduContextUserInfo](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserinfo). `operator` being empty means that properties are updated by the server. |
