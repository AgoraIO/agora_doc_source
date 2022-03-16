## AgoraEduScreenShareContext

`AgoraEduScreenShareContext` provides the methods that can be called by your app for screen sharing.

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduScreenShareHandler)
```

Registers the event listener.

| Parameter | Description |
| :-------- | :------------------------------------- |
| `handler` | See the `AgoraEduScreenShareHandler` class for details. |

## AgoraEduScreenShareHandler

`AgoraEduScreenShareHandler` reports screen-sharing-related event callbacks to your app.

### onUpdateScreenShareState

```swift
@objc optional func onUpdateScreenShareState(_ state: AgoraEduContextScreenShareState,
                                          streamUuid: String)
```

Occurs when the screen sharing state updates.

- When the `state` is `start`, Flexible Classroom triggers a pop-up window saying "The teacher has started screen sharing".
- When the `state` is `stop`, Flexible Classroom triggers a pop-up window saying "The teacher has stopped screen sharing".

| Parameter | Description |
| :----------- | :----------------------------------------------------- |
| `state` | The screen sharing state. See `AgoraEduContextScreenShareState` for details. |
| `streamUuid` | The ID of the screen-sharing stream. |

### onSelectScreenShare

```swift
@objc optional func onSelectScreenShare(_ selected: Bool)
```

Indicates whether the screen sharing tab is selected.

| Parameter | Description |
| :--------- | :----------------------- |
| `selected` | Whether the screen sharing tab is selected. |

