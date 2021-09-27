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

The screen sharing status has been updated.

- When the `state` is `start`, the UI layer prompts "Teacher initiated screen sharing".
- When the `state` is `stop`, the UI layer prompts "The teacher has stopped screen sharing".

| Parameter | Description |
| :----------- | :----------------------------------------------------- |
| `state` | Screen sharing status, see AgoraEduContextScreenShareState for details``. |
| `streamUuid` | Screen sharing stream ID. |

### onSelectScreenShare

```swift
@objc optional func onSelectScreenShare(_ selected: Bool)
```

Prompt whether the screen sharing tab is selected.

| Parameter | Description |
| :--------- | :----------------------- |
| `selected` | Whether the screen sharing tab is selected. |

