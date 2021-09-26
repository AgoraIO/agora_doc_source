## AgoraEduScreenShareContext

`AgoraEduScreenShareContext` provides the methods that can be called by your app for screen sharing.

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduScreenShareHandler)
```

Register the event listener.

| Parameter | Description |
| :-------- | :------------------------------------- |
| `handler` | See the `AgoraEduScreenShareHandler` class for details. |

## AgoraEduScreenShareHandler

`AgoraEduScreenShareHandler` reports screen-sharing-related event callbacks to your app.

### onScreenShareStateUpdated

```swift
@objc optional func onUpdateScreenShareState(_ state: AgoraEduContextScreenShareState,
                                          streamUuid: String)
```

屏幕共享状态已更新。

- `state`  为 `start` 时，UI 层提示”老师发起了屏幕共享“。
- `state` 为 `stop` 时，UI 层提示“老师停止了屏幕共享”。

| Parameter | Description |
| :----------- | :----------------------------------------------------- |
| `state` | 屏幕共享状态，详见 `AgoraEduContextScreenShareState`。 |
| `streamUuid` | 屏幕共享流 ID。 |

### onSelectScreenShare

```swift
@objc optional func onSelectScreenShare(_ selected: Bool)
```

提示屏幕共享标签是否被选中。

| Parameter | Description |
| :--------- | :----------------------- |
| `selected` | 屏幕共享标签是否被选中。 |

