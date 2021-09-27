## VideoContext

`VideoContext` provides the methods that can be called by your app for media control. It is mainly used to control the audio and video of teachers and students in one-to-one classrooms and the audio and video of teachers in small and large classes.

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
abstract fun renderVideo(viewGroup: ViewGroup?,
                         streamUuid: String,
                         renderConfig: EduContextRenderConfig = EduContextRenderConfig()
)
```

Start or stop rendering the local video stream.

| Parameter | Description |
| :------------- | :----------------------------------------------------- |
| `container` | The video container. Setting `viewGroup` as `null` means stopping rendering the video stream. |
| `streamUuid` | The stream ID. |
| `renderConfig` | Configurations for the video renderer. |

### setVideoEncoderConfig

```kotlin
abstract fun setVideoEncoderConfig(config: EduContextVideoEncoderConfig)
```

Sets the video encoder configuration.

| Parameter | Description |
| :------- | :-------------------------------------------------- |
| `config` | The video encoding configuration. See `EduContextVideoEncoderConfig`. |

## IVideoHandler

`IVideoHandler` reports the event callbacks related to media control to your app.

### onUserDetailInfoUpdated

```kotlin
fun onUserDetailInfoUpdated(info: EduContextUserDetailInfo)
```

Occurs when the user info updates.

| Parameter | Description |
| :----- | :------------------------------------------ |
| `info` | The user information. See EduContextUserDetailInfo for details``. |

### onVolumeUpdated

```kotlin
fun onVolumeUpdated(volume: Int, streamUuid: String)
```

Occurs when the volume of the local user is updated.

| Parameter | Description |
| :----------- | :------ |
| `volume` | The volume. |
| `streamUuid` | The stream ID. |

### onMessageUpdated

```kotlin
fun onMessageUpdated(msg: String)
```

Display media-related tips.

There are the following tips:

- Your camera has been turned off.
- Your camera has been turned on.
- Your microphone has been turned off.
- Your microphone has been turned on.

| Parameter | Description |
| :---- | :--------- |
| `msg` | The tip. |

