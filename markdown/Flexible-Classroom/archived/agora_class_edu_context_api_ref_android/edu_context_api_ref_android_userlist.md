## UserContext

`UserContext` 类提供可供 App 调用的用户列表相关方法。

### localUserInfo

```kotlin
abstract fun localUserInfo(): EduContextUserInfo
```

获取本地用户信息，详见 [EduContextUserInfo](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserinfo)。

### updateFlexUserProps

```kotlin
abstract fun updateFlexUserProps(userUuid: String,
                                 properties: MutableMap<String, String>,
                                 cause: MutableMap<String, String>?)
```

新增或更新自定义用户属性。详见[如何设置自定义用户属性？](/cn/agora-class/faq/agora_class_custom_properties)

属性成功更新后，会触发 `onFlexUserPropertiesChanged` 回调。

| 参数         | 描述       |
| :----------- | :--------- |
| `userUuid`   | 用户 ID。  |
| `properties` | 用户属性。 |
| `cause`      | 更新原因。 |

### muteVideo

```kotlin
abstract fun muteVideo(muted: Boolean)
```

开启或关闭本地视频。

| 参数    | 描述               |
| :------ | :----------------- |
| `muted` | 是否关闭本地视频。 |

### muteAudio

```kotlin
abstract fun muteAudio(muted: Boolean)
```

开启或关闭本地音频。

| 参数    | 描述               |
| :------ | :----------------- |
| `muted` | 是否关闭本地音频。 |

### renderVideo

```kotlin
abstract fun renderVideo(container: ViewGroup?, streamUuid: String)
```

开始或停止渲染本地视频流。

| 参数         | 描述                                                   |
| :----------- | :----------------------------------------------------- |
| `container`  | 视频 Container。`viewGroup` 为 `null` 代表关闭流渲染。 |
| `streamUuid` | 流 ID。                                                |

### setVideoEncoderConfig

```kotlin
abstract fun setVideoEncoderConfig(config: EduContextVideoEncoderConfig)
```

设置视频编码配置。

| 参数     | 描述                                                                                                                                                    |
| :------- | :------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `config` | 视频编码配置，详见 [EduContextVideoEncoderConfig](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextvideoencoderconfig)。 |

## IUserHandler

`IUserHandler` 类用于向 App 报告用户列表相关的事件回调。

### onUserListUpdated

```kotlin
fun onUserListUpdated(list: MutableList<EduContextUserDetailInfo>)
```

提示用户列表已更新。只显示在线用户的信息。

| 参数   | 描述                                                                                                                                                         |
| :----- | :----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `list` | 在线用户列表，由 [EduContextUserDetailInfo](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserdetailinfo) 对象组成的数组。 |

### onCoHostListUpdated

```kotlin
fun onCoHostListUpdated(list: MutableList<EduContextUserDetailInfo>)
```

提示上台用户列表已更新。只显示状态为“在台上”的用户信息，包含不在线的用户。

| 参数   | 描述                                                                                                                                                         |
| :----- | :----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `list` | 上台用户列表，由 [EduContextUserDetailInfo](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserdetailinfo) 对象组成的数组。 |

### onUserReward

```kotlin
fun onUserReward(userInfo: EduContextUserInfo)
```

收到奖励。

| 参数       | 描述                                                                                                                            |
| :--------- | :------------------------------------------------------------------------------------------------------------------------------ |
| `userInfo` | 用户信息，详见 [EduContextUserInfo](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserinfo)。 |

### onKickOut

```kotlin
fun onKickOut()
```

本地用户被踢出课堂。

### onVolumeUpdated

```kotlin
fun onVolumeUpdated(volume: Int, streamUuid: String)
```

提示音量。

| 参数         | 描述    |
| :----------- | :------ |
| `volume`     | 音量。  |
| `streamUuid` | 流 ID。 |

### onRoster

```kotlin
fun onRoster(context: Context, anchor: View, type: Int?)
```

显示用户列表。

| 参数   | 描述                                                                                |
| :----- | :---------------------------------------------------------------------------------- |
| `type` | 花名册分为小班花名册 (RosterType.SmallClass) 和大班花名册 (RosterType.LargeClass)。 |

### onUserTip

```kotlin
fun onUserTip(tip: String)
```

报告用户相关的提示信息。

有以下提示：

-   你的摄像头被关闭了。
-   你的摄像头被打开了。
-   你的麦克风被关闭了。
-   你的麦克风被打开了。

| 参数     | 描述       |
| :------- | :--------- |
| `string` | 提示信息。 |

### onRoster

```kotlin
fun onRoster(context: Context, anchor: View, type: Int?)
```

显示用户列表。

| 参数      | 描述                                                                                                                   |
| :-------- | :--------------------------------------------------------------------------------------------------------------------- |
| `context` | App 的上下文。                                                                                                         |
| `anchor`  | 用户列表 Icon-View。                                                                                                   |
| `type`    | 用户列表有两种：<li>`RosterType.SmallClass`: 互动小班课的用户列表。<li>`RosterType.LargeClass`: 直播大班课的用户列表。 |

### onFlexUserPropsChanged

```kotlin
fun onFlexUserPropsChanged(changedProperties: MutableMap<String, Any>,
                           properties: MutableMap<String, Any>,
                           cause: MutableMap<String, Any>?,
                           fromUser: EduContextUserDetailInfo,
                           operator: EduContextUserInfo?)
```

自定义用户属性更新回调。

| 参数                | 描述                                                                                                                                                             |
| :------------------ | :--------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `changedProperties` | 已更新的用户属性。                                                                                                                                               |
| `properties`        | 全部用户属性。                                                                                                                                                   |
| `cause`             | 更新原因。                                                                                                                                                       |
| `fromUser`          | 属性被更新的用户的相关信息，详见 [EduContextUserDetailInfo](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserdetailinfo)。    |
| `operator`          | 操作者，详见 [EduContextUserInfo](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserinfo)。`operator` 为空表示是由服务端更新。 |
