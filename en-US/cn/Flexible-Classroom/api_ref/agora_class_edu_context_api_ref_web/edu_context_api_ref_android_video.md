# Video Context

## VideoContext

The` VideoContext` class provides media control-related methods that can be called by the App.

### updateVideo

```kotlin
abstract fun updateVideo(enabled: Boolean)
```

Turn local video on or off.

| Parameter | Description |
| :-------- | :----------------- |
| `enabled` | Whether to enable the local video capture. |

### updateAudio

```kotlin
abstract fun updateAudio(enabled: Boolean)
```

Turn local audio on or off.

| Parameter | Description |
| :-------- | :----------------- |
| `enabled` | Whether to enable the local video capture. |

### renderVideo

```kotlin
abstract fun renderVideo(viewGroup: ViewGroup?, streamUuid: String)
```

Start or stop rendering the local video stream.

| Parameter | Description |
| :----------- | :----------------------------------------------------- |
| `container` | Video Container. If ``viewGroup` is null`, it means to close the stream rendering. |
| `streamUuid` | Stream ID. |

## VideoHandler

The` IVideoHandler` class is used to report media-related event callbacks to the App.

### onUserDetailInfoUpdated

```kotlin
fun onUserDetailInfoUpdated (info: EduContextUserDetailInfo)
```

Prompt the user to update the information.

| Parameter | Description |
| :----- | :------------------------------------------ |
| `info` | User information, see EduContextUserDetailInfo for details``. |

### onVolumeUpdated

```kotlin
fun onVolumeUpdated(volume: Int, streamUuid: String)
```

Prompt for volume update.

| Parameter | Description |
| :----------- | :------ |
| `volume` | volume. |
| `streamUuid` | Stream ID. |

### onMessageUpdated

```kotlin
fun onMessageUpdated(msg: String)
```

Display media-related prompt information.

There are the following tips:

- Your camera is turned off
- Your camera is turned on
- Your microphone is turned off
- Your microphone is turned on

| Parameter | Description |
| :---- | :--------- |
| `msg` | The event message. |

