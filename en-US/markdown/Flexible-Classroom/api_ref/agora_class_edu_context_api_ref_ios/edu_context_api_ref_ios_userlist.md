## AgoraEduUserContext

`AgoraEduUserContext` provides user-list-related methods that can be called by your app.

### updateFlexUserProperties

```swift
func updateFlexUserProperties(_ userUuid: String,
                              properties: [String: String],
                                   cause:[String: String]?)
```

新增或更新自定义用户属性。 For details, see [How can I set user attributes? ](/en/agora-class/faq/agora_class_custom_properties)

The remote client receives the `onFlexUserPropertiesChanged` callback.

| Parameter | Description |
| :----------- | :----------------------------------------------------------- |
| `userUuid` | The user ID. |
| `properties` | user attribute 可设为 `{"key.subkey":"1"}`  或 `{"key":{"subkey":"1"}}`。 |
| `cause` | 更新原因。 |

### getLocalUserInfo

```swift
func getLocalUserInfo() -> AgoraEduContextUserInfo
```

> 自 v1.1.5 起新增。

获取本地用户信息。

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

Occurs when the list of on-stage users is updated. 只显示状态为“在台上”的用户信息，包含不在线的用户。

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

本地用户被踢出课堂。

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

自定义用户属性更新回调。

| Parameter | Description |
| :------------------ | :----------------------------------------------------------- |
| `changedProperties` | 已更新的用户属性。 |
| `properties` | 全部用户属性。 |
| `cause` | 更新原因。 |
| `fromUser` | 属性被更新的用户的相关信息，详见 `AgoraEduContextUserDetailInfo`。 |
| `operator` | The user information. See AgoraEduContextUserInfo for details``. `operator` 为空表示是由服务端更新。 |
