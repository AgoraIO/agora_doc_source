## VideoContext

`VideoContext` provides the methods that can be called by your app for media control. This context is mainly for controlling the audio and video of the teacher and student in the One-to-one Classrooms scenario and the audio and video of the teacher in the Small Classroom and Lecture Hall scenarios.

### updateVideo

```kotlin
abstract fun updateVideo(enabled: Boolean)
```

Enables or disables the local video.

| Parameter | Description |
| :-------- | :----------------- |
| `enabled` | Whether to enable the local video. |

### updateAudio

```kotlin
abstract fun updateAudio(enabled: Boolean)
```

Enables or disables the local audio.

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

Starts or stops rendering the local video stream.

| Parameter | Description |
| :------------- | :----------------------------------------------------------- |
| `container` | The video container. Setting `viewGroup` as `null` means stopping rendering the video stream. |
| `streamUuid` | The stream ID. |
| `renderConfig` | The video renderer configuration. See [EduContextRenderConfig](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextrenderconfig). |

### setVideoEncoderConfig

```kotlin
abstract fun setVideoEncoderConfig(config: EduContextVideoEncoderConfig)
```

Sets the video encoder configuration.

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `config` | The video encoding configuration. See [EduContextVideoEncoderConfig](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextvideoencoderconfig). |

## IVideoHandler

`IVideoHandler` reports the event callbacks related to media control to your app.

### onUserDetailInfoUpdated

```kotlin
fun onUserDetailInfoUpdated(info: EduContextUserDetailInfo)
```

Occurs when the user info updates.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `info` | The user information. See [EduContextUserDetailInfo](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserdetailinfo) for details. |

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

