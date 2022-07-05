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

### onUpdateScreenShareState

```swift
@objc optional func onUpdateScreenShareState(_ state: AgoraEduContextScreenShareState,
                                          streamUuid: String)
```

屏幕共享状态已更新。

-   `state` 为 `start` 时，UI 层提示”老师发起了屏幕共享“。
-   `state` 为 `stop` 时，UI 层提示“老师停止了屏幕共享”。

| 参数         | 描述                                                   |
| :----------- | :----------------------------------------------------- |
| `state`      | 屏幕共享状态，详见 `AgoraEduContextScreenShareState`。 |
| `streamUuid` | 屏幕共享流 ID。                                        |

### onSelectScreenShare

```swift
@objc optional func onSelectScreenShare(_ selected: Bool)
```

提示屏幕共享标签是否被选中。

| 参数       | 描述                     |
| :--------- | :----------------------- |
| `selected` | 屏幕共享标签是否被选中。 |
