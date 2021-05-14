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
@objc optional func onUpdateScreenShareState(_ sharing: Bool,
                                               streamUuid: String)
```

Occurs when the state of screen sharing is updated.

| Parameter | Description |
| :----------- | :----------------- |
| `sharing` | Whether the screen is being shared. |
| `streamUuid` | The stream ID. |

### onScreenShareTip

```swift
@objc optional func onShowScreenShareTips(_ message: String)
```

Displays tips related to screen sharing.

There are the following tips:

- User A has started screen sharing.
- User A has stopped screen sharing.

| Parameter | Description |
| :-------- | :--------- |
| `message` | The tip. |

