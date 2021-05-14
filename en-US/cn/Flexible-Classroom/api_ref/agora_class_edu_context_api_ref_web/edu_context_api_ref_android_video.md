# Video Context

## VideoContext

`VideoContext` provides the methods that can be called by your app for media control.

### updateVideo

```kotlin
abstract fun updateVideo(enabled: Boolean)
```

Enable or disable the local video.

| Parameter | Description |
| :-------- | :----------------- |
| `enabled` | Whether to enable the local video. |

### updateAudio

```kotlin
abstract fun updateAudio(enabled: Boolean)
```

Enable or disable the local audio.

| Parameter | Description |
| :-------- | :----------------- |
| `enabled` | Whether to enable the local audio. |

### renderVideo

```kotlin
abstract fun renderVideo(viewGroup: ViewGroup?, streamUuid: String)
```

Start or stop rendering the local video stream.

| Parameter | Description |
| :----------- | :----------------------------------------------------- |
| `container` | The video container. `Setting viewGroup` as `null` means stopping rendering the video stream. |
| `streamUuid` | The stream ID. |

## IVideoHandler

`IVideoHandler` reports the event callbacks related to media control to your app.

### onUserDetailInfoUpdated

```kotlin
fun onUserDetailInfoUpdated (info: EduContextUserDetailInfo)
```

Occurs when the user info updates.

| Parameter | Description |
| :----- | :------------------------------------------ |
| `info` | The user information. See `EduContextUserDetailInfo` for details. |

### onVolumeUpdated

```kotlin
fun onVolumeUpdated(volume: Int, streamUuid: String)
```

Prompt for volume update.

| Parameter | Description |
| :----------- | :------ |
| `volume` | The volume. |
| `streamUuid` | The stream ID. |

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
| `msg` | The tip. |

