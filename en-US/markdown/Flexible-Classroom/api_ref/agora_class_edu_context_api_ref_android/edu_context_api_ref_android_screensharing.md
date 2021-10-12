## ScreenShareContext

`ScreenShareContext` provides the methods that can be called by your app for screen sharing.

### setScreenShareState

```kotlin
abstract fun setScreenShareState(sharing: Boolean)
```

Starts or stops screen sharing.

| Parameter | Description |
| :-------- | :----------------- |
| `sharing` | Whether to start screen sharing. |

### renderScreenShare

```kotlin
abstract fun renderScreenShare(container: ViewGroup?, streamUuid: String)
```

Starts or stops rendering the screen-sharing stream.

| Parameter | Description |
| :----------- | :----------------------------------------------------- |
| `container` | The video container. Setting `viewGroup` as `null` means stopping rendering the video stream. |
| `streamUuid` | The stream ID. |

## IScreenShareHandler

`IScreenShareHandler` reports screen-sharing-related event callbacks to your app.

### onScreenShareStateUpdated

```kotlin
fun onScreenShareStateUpdated(state: EduContextScreenShareState, streamUuid: String)
```

Occurs when the state of screen sharing changes.

| Parameter | Description |
| :----------- | :----------------------------------------------------------- |
| `state` | The state of screen sharing. See [EduContextScreenShareState](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextscreensharestate) for details. |
| `streamUuid` | The stream ID. |

### onScreenShareTip

```kotlin
fun onScreenShareTip(tips: String)
```

Displays tips related to screen sharing.

There are the following tips:

- User A has started screen sharing.
- User A has stopped screen sharing.

| Parameter | Description |
| :----- | :--------- |
| `tips` | The tip. |

