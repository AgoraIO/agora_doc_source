## AgoraEduScreenShareContext

`AgoraEduScreenShareContext` 类提供可供 App 调用的屏幕共享相关方法。

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduScreenShareHandler)
```

注册事件监听。

| 参数      | 描述                                   |
| :-------- | :------------------------------------- |
| `handler` | 详见 `AgoraEduScreenShareHandler` 类。 |

## AgoraEduScreenShareHandler

`AgoraEduScreenShareHandler` 类用于向 App 报告屏幕共享相关的事件回调。

### onScreenShareStateUpdated

```swift
@objc optional func onUpdateScreenShareState(_ state: AgoraEduContextScreenShareState,
                                               streamUuid: String)
```

报告屏幕共享开启或关闭。

| 参数         | 描述                                                   |
| :----------- | :----------------------------------------------------- |
| `sharing`    | 屏幕共享状态，详见 `AgoraEduContextScreenShareState`。 |
| `streamUuid` | 屏幕共享流 ID。                                        |

### onScreenShareTip

```swift
@objc optional func onShowScreenShareTips(_ message: String)
```

显示屏幕共享相关提示。

有以下提示：

- XXX 开启了屏幕分享。
- XXX 关闭了屏幕分享。

| 参数      | 描述       |
| :-------- | :--------- |
| `message` | 提示信息。 |

### onSelectScreenShare

```swift
@objc optional func onSelectScreenShare(_ selected: Bool)
```

提示是否选中屏幕共享标签。

| 参数       | 描述                     |
| :--------- | :----------------------- |
| `selected` | 屏幕共享标签是否被选中。 |

