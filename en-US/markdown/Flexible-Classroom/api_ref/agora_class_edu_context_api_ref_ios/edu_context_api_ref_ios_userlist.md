## AgoraEduUserContext

`AgoraEduUserContext` provides user-list-related methods that can be called by your app.

### updateFlexUserProperties

```swift
func updateFlexUserProperties(_ userUuid: String,
                              properties: [String: String],
                                   cause:[String: String]?)
```

Adds or updates custom user properties. For details, see [How can I set user properties? ](/en/agora-class/faq/agora_class_custom_properties)

After you successfully update the properties, the remote client receives the `onFlexUserPropertiesChanged` callback.

| Parameter | Description |
| :----------- | :----------------------------------------------------------- |
| `userUuid` | The user ID. |
| `properties` | The user properties. You can set this parameter as `{"key.subkey":"1"}` or `{"key":{"subkey":"1"}}`. |
| `cause` | The update reason. |

### getLocalUserInfo

```swift
func getLocalUserInfo() -> AgoraEduContextUserInfo
```

> Since v1.1.5.

Gets the information of the local user.

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduUserHandler)
```

Registers the event listener.

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

Occurs when the list of on-stage users is updated. Only display the information of users whose status is "on stage", including users who are not online.

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

Occurs when the volume of the local user updates.

| Parameter | Description |
| :----------- | :------ |
| `volume` | The volume. |
| `streamUuid` | The stream ID. |

### onFlexUserPropertiesChanged

```swift
@objc optional func onFlexUserPropertiesChanged(_ changedProperties:[String : Any],
                                                         properties: [String: Any],
                                                              cause:[String : Any]?,
                                                           fromUser:AgoraEduContextUserDetailInfo,
                                                           operator:AgoraEduContextUserInfo?)
```

Occurs when the custom user properties are updated.

| Parameter | Description |
| :------------------ | :----------------------------------------------------------- |
| `changedProperties` | The updated user properties. |
| `properties` | All user properties. |
| `cause` | The update reason. |
| `fromUser` | The information of the user whose properties are updated. See `AgoraEduContextUserDetailInfo` for details. |
| `operator` | The information of the operator. See `AgoraEduContextUserInfo`. `operator` being empty means that properties are updated by the server. |
