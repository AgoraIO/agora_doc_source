## AgoraEduUserContext

`AgoraEduUserContext` provides user-list-related methods that can be called by your app.

### updateFlexUserProperties

```swift
func updateFlexUserProperties(_ userUuid: String,
                              properties: [String: String],
                                   cause:[String: String]?)
```

Add or update custom user attributes. For details, see [How can I set user attributes? ](/en/agora-class/faq/agora_class_custom_properties)

The remote client receives the `onFlexUserPropertiesChanged` callback.

| Parameter | Description |
| :----------- | :----------------------------------------------------------- |
| `userUuid` | The user ID. |
| `properties` | user attribute Can be set to `{"key.subkey":"1"}` or `{"key":{"subkey":"1"}}`. |
| `cause` | Reason for update. |

### getLocalUserInfo

```swift
func getLocalUserInfo() -> AgoraEduContextUserInfo
```

> Since v1.1.5.

Get local user information.

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
| `userInfo` | The user information. See AgoraEduContextUserInfo for details``. |

### onKickedOut

```swift
@objc optional func onKickedOut()
```

Local users were kicked out of the classroom.

### onUpdateAudioVolumeIndication

```swift
@objc optional func onUpdateAudioVolumeIndication(_ value: Int, streamUuid: String)
```

Occurs when the volume of the local user is updated.

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

Custom user attribute update callback.

| Parameter | Description |
| :------------------ | :----------------------------------------------------------- |
| `changedProperties` | The updated user attributes. |
| `properties` | All user attributes. |
| `cause` | Reason for update. |
| `fromUser` | For information about the user whose attributes are updated, see `AgoraEduContextUserDetailInfo `for details. |
| `operator` | The user information. See AgoraEduContextUserInfo for details``. An empty` operator` means that it is updated by the server. |
