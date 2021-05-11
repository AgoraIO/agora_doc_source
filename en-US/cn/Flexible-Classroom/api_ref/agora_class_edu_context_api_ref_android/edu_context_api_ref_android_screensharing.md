# Screenshare Context

## ScreenShareContext

The` ScreenShareContext` class provides screen sharing related methods that can be called by App.

### setScreenShareState

```kotlin
abstract fun setScreenShareState(sharing: Boolean)
```

Turn screen sharing on or off.

| Parameter | Description |
| :-------- | :----------------- |
| `sharing` | Whether to enable screen sharing. |

### renderScreenShare

```kotlin
abstract fun renderScreenShare(container: ViewGroup?, streamUuid: String)
```

Start or stop rendering the screen sharing stream.

| Parameter | Description |
| :----------- | :----------------------------------------------------- |
| `container` | Video Container. If ``viewGroup` is null`, it means to close the stream rendering. |
| `streamUuid` | Stream ID. |

## IScreenShareHandler

The` IScreenShareHandler` class is used to report screen sharing-related event callbacks to the App.

### onScreenShareStateUpdated

```kotlin
fun onScreenShareStateUpdated(sharing: Boolean, streamUuid: String)
```

Report that screen sharing is turned on or off.

| Parameter | Description |
| :----------- | :----------------- |
| `sharing` | Whether the screen is being shared. |
| `streamUuid` | Stream ID. |

### onScreenShareTip

```kotlin
fun onScreenShareTip(tips: String)
```

Display screen sharing related prompts.

There are the following tips:

- XXX turned on screen sharing.
- XXX turned off screen sharing.

| Parameter | Description |
| :----- | :--------- |
| `tips` | The event message. |

