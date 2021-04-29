# User List Context

## UserContext

`UserContext` 类提供可供 App 调用的用户列表相关方法。

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



## IUserHandler

`IUserHandler` 类用于向 App 报告用户列表相关的事件回调。

### onUserListUpdated

```kotlin
fun onUserListUpdated(list: MutableList<EduContextUserDetailInfo>)
```

提示用户列表已更新。只显示在线用户的信息。

| 参数   | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| `list` | 在线用户列表，由 `EduContextUserDetailInfo` 对象组成的数组。 |

### onCoHostListUpdated

```kotlin
// 更新上台人员信息列表，只显示台上人员信息。（台上会包含不在线的）
fun onCoHostListUpdated(list: MutableList<EduContextUserDetailInfo>)
```

提示上台用户列表已更新。只显示台上状态的用户的信息，包含不在线的用户。

| 参数   | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| `list` | 上台用户列表，由 `EduContextUserDetailInfo` 对象组成的数组。 |

### onUserReward

```kotlin
fun onUserReward(userInfo: EduContextUserInfo)
```

收到奖励。

| 参数       | 描述                                  |
| :--------- | :------------------------------------ |
| `userInfo` | 用户信息，详见 `EduContextUserInfo`。 |

### onKickOut

```kotlin
// 自己被踢出
fun onKickOut()
```

本地客户端被提出课堂。

### onVolumeUpdated

```kotlin
fun onVolumeUpdated(volume: Int, streamUuid: String)
```

提示音量。

| 参数         | 描述    |
| :----------- | :------ |
| `volume`     | 音量。  |
| `streamUuid` | 流 ID。 |

### onUserTip

```kotlin
fun onUserTip(tip: String)
```

报告用户相关的提示信息。

有以下提示：

- 你的摄像头被关闭了。
- 你的摄像头被打开了。
- 你的麦克风被关闭了。
- 你的麦克风被打开了。

| 参数     | 描述       |
| :------- | :--------- |
| `string` | 提示信息。 |

### onRoster

```kotlin
fun onRoster(context: Context, anchor: View, type: Int?)
```

显示用户列表。

| 参数      | 描述                                                         |
| :-------- | :----------------------------------------------------------- |
| `context` | App 的上下文。                                               |
| `anchor`  | 用户列表 Icon-View。                                         |
| `type`    | 用户列表有两种：<li>`RosterType.SmallClass`: 互动小班课的用户列表。<li>`RosterType.LargeClass`: 直播大班课的用户列表。 |

