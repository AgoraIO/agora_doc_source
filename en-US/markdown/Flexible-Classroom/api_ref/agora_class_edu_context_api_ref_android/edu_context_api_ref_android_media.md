## MediaContext

`MediaContext` provides the methods that can be called by your app for pre-class audio and video preview.

### openCamera

```kotlin
abstract fun openCamera()
```

Turn on the camera.

### closeCamera

```kotlin
abstract fun closeCamera()
```

Turn off the camera.

### startPreview

```kotlin
abstract fun startPreview(container: ViewGroup)
```

Starts the local video preview.

### stopPreview

```kotlin
abstract fun stopPreview()
```

Stops the local video preview.

### openMicrophone

```kotlin
abstract fun openMicrophone()
```

Turn on the microphone.

### closeMicrophone

```kotlin
abstract fun closeMicrophone()
```

Turn off the microphone.

### publishStream

```kotlin
abstract fun publishStream(type: EduContextMediaStreamType)
```

Publish local streams to the remote clients, including the video stream captured by the camera and the audio stream sampled by the microphone.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `type` | The media type. See [EduContextMediaStreamType](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextmediastreamtype). |

### unpublishStream

```kotlin
abstract fun unPublishStream(type: EduContextMediaStreamType)
```

Unpublish local streams.

| Parameter | Description |
| :----- | :----------------------------------------------------------- |
| `type` | The media type. See [EduContextMediaStreamType](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextmediastreamtype). |

### renderRemoteView

```kotlin
abstract fun renderRemoteView(container: ViewGroup?, streamUuid: String)
```

Starts or stops rendering the remote video stream.

| Parameter | Description |
| :----------- | :----------------------------------------------------- |
| `container` | The video container. Setting `viewGroup` as `null` means stopping rendering the video stream. |
| `streamUuid` | The stream ID. |

### setVideoEncoderConfig

```kotlin
abstract fun setVideoEncoderConfig(videoEncoderConfig: EduContextVideoEncoderConfig)
```

Sets the video encoder configuration.

| Parameter | Description |
| :------------------- | :----------------------------------------------------------- |
| `videoEncoderConfig` | The video encoding configuration. See [EduContextVideoEncoderConfig](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextvideoencoderconfig). |
