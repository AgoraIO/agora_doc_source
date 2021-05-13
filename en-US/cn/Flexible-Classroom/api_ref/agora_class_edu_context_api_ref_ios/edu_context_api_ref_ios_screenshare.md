# Screenshare Context

## AgoraEduScreenShareContext

`The AgoraEduScreenShareContext` class provides screen sharing related methods that can be called by App.

### registerEventHandler

```swift
func registerEventHandler (_ handler: AgoraEduScreenShareHandler)
```

Register the event listener.

| Parameter | Description |
| :-------- | :------------------------------------- |
| `handler` | See the `AgoraEduScreenShareHandler` class for details. |

## AgoraEduScreenShareHandler

The` AgoraEduScreenShareHandler` class is used to report screen sharing-related event callbacks to the App.

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

Display screen sharing related prompts.

There are the following tips:

- The teacher has be turned on screen sharing.
- XXX turned off screen sharing.

| Parameter | Description |
| :-------- | :--------- |
| `message` | The tip. |

