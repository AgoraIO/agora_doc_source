# User List Context

## AgoraEduUserContext

`AgoraEduUserContext` 类提供可供 App 调用的用户列表相关方法。

### muteVideo

```swift
func muteVideo(_ mute: Bool)
```

开启或关闭本地视频。

| 参数   | 描述               |
| :----- | :----------------- |
| `mute` | 是否关闭本地视频。 |

### muteAudio

```swift
func muteAudio(_ mute: Bool)
```

开启或关闭本地音频。

| 参数   | 描述               |
| :----- | :----------------- |
| `mute` | 是否关闭本地音频。 |

### renderView

```swift
func renderView(_ view: UIView?, streamUuid: String)
```

开始或停止渲染本地视频流。

| 参数         | 描述                                             |
| :----------- | :----------------------------------------------- |
| `view`       | 视频 Container。`view` 为 `nil` 代表关闭流渲染。 |
| `streamUuid` | 流 ID。                                          |

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

提示上台用户列表已更新。只显示台上状态的用户的信息，包含不在线的用户。

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

本地客户端被提出课堂。

### onUpdateAudioVolumeIndication

```swift
@objc optional func onUpdateAudioVolumeIndication(_ value: Int, streamUuid: String)
```

提示音量。

| 参数         | 描述    |
| :----------- | :------ |
| `volume`     | 音量。  |
| `streamUuid` | 流 ID。 |

### onShowUserTips

```swift
@objc optional func onShowUserTips(_ message: String)
```

报告用户相关的提示信息。

有以下提示：

- 你的摄像头被关闭了。
- 你的摄像头被打开了。
- 你的麦克风被关闭了。
- 你的麦克风被打开了。

| 参数      | 描述       |
| :-------- | :--------- |
| `message` | 提示信息。 |
