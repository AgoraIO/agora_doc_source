## AgoraEduUserContext

`AgoraEduUserContext` 类提供可供 App 调用的用户列表相关方法。

### updateFlexUserProperties

```swift
func updateFlexUserProperties(_ userUuid: String,
                              properties: [String: String],
                                   cause:[String: String]?)
```

新增或更新自定义用户属性。详见[如何设置自定义用户属性？](/cn/agora-class/faq/agora_class_custom_properties)

属性成功更新后，会触发 `onFlexUserPropertiesChanged` 回调。

| 参数         | 描述                                                         |
| :----------- | :----------------------------------------------------------- |
| `userUuid`   | 用户 ID。                                                    |
| `properties` | 用户属性。可设为 `{"key.subkey":"1"}`  或 `{"key":{"subkey":"1"}}`。 |
| `cause`      | 更新原因。                                                   |

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

注册事件监听。

| 参数      | 描述                            |
| :-------- | :------------------------------ |
| `handler` | 详见 `AgoraEduUserHandler` 类。 |

## AgoraEduUserHandler

`AgoraEduUserHandler` 类用于向 App 报告用户列表相关的事件回调。

### onUpdateUserList

```swift
@objc optional func onUpdateUserList(_ list: [AgoraEduContextUserDetailInfo])
```

提示用户列表已更新。只显示在线用户的信息。

| 参数   | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| `list` | 在线用户列表，由 `AgoraEduContextUserDetailInfo` 对象组成的数组。 |

### onUpdateCoHostList

```swift
@objc optional func onUpdateCoHostList(_ list: [AgoraEduContextUserDetailInfo])
```

提示上台用户列表已更新。只显示状态为“在台上”的用户信息，包含不在线的用户。

| 参数   | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| `list` | 上台用户列表，由 `AgoraEduContextUserDetailInfo` 对象组成的数组。 |

### onShowUserReward

```swift
@objc optional func onShowUserReward(_ user: AgoraEduContextUserInfo)
```

收到奖励。

| 参数       | 描述                                       |
| :--------- | :----------------------------------------- |
| `userInfo` | 用户信息，详见 `AgoraEduContextUserInfo`。 |

### onKickedOut

```swift
@objc optional func onKickedOut()
```

本地用户被踢出课堂。

### onUpdateAudioVolumeIndication

```swift
@objc optional func onUpdateAudioVolumeIndication(_ value: Int, streamUuid: String)
```

提示音量。

| 参数         | 描述    |
| :----------- | :------ |
| `volume`     | 音量。  |
| `streamUuid` | 流 ID。 |

### onFlexUserPropertiesChanged

```swift
@objc optional func onFlexUserPropertiesChanged(_ changedProperties:[String : Any],
                                                         properties: [String: Any],
                                                              cause:[String : Any]?,
                                                           fromUser:AgoraEduContextUserDetailInfo,
                                                           operator:AgoraEduContextUserInfo?)
```

自定义用户属性更新回调。

| 参数                | 描述                                                         |
| :------------------ | :----------------------------------------------------------- |
| `changedProperties` | 已更新的用户属性。                                           |
| `properties`        | 全部用户属性。                                               |
| `cause`             | 更新原因。                                                   |
| `fromUser`          | 属性被更新的用户的相关信息，详见 `AgoraEduContextUserDetailInfo`。 |
| `operator`          | 操作者，详见 `AgoraEduContextUserInfo`。`operator` 为空表示是由服务端更新。 |
