## ScreenShareContext

`ScreenShareContext` provides the methods that can be called by your app for screen sharing.

### setScreenShareState

```kotlin
abstract fun setScreenShareState(sharing: Boolean)
```

Start or stop screen sharing.

| Parameter | Description |
| :-------- | :----------------- |
| `sharing` | Whether to start screen sharing. |

### renderScreenShare

```kotlin
abstract fun renderScreenShare(container: ViewGroup?, streamUuid: String)
```

Start or stop rendering the screen-sharing stream.

| Parameter | Description |
| :----------- | :----------------------------------------------------- |
| `container` | The video container. `Setting viewGroup` as `null` means stopping rendering the video stream. |
| `streamUuid` | The stream ID. |

## IScreenShareHandler

`IScreenShareHandler` reports screen-sharing-related event callbacks to your app.

### onScreenShareStateUpdated

```kotlin
fun onScreenShareStateUpdated(sharing: Boolean, streamUuid: String)
```

Occurs when the state of screen sharing is updated.

| Parameter | Description |
| :----------- | :----------------- |
| `sharing` | Whether the screen is being shared. |
| `streamUuid` | The stream ID. |

### onScreenShareTip

```kotlin
fun onScreenShareTip(tips: String)
```

Display screen sharing related prompts.

There are the following tips:

- The teacher has be turned on screen sharing.
- XXX turned off screen sharing.

| Parameter | Description |
| :----- | :--------- |
| `tips` | The tip. |

