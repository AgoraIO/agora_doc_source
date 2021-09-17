## MediaContext

`RoomContext` provides the methods that can be called by your app for classroom management.

### openCamera

```kotlin
abstract fun leave()
```

Turn on the camera.

### closeCamera

```kotlin
abstract fun leave()
```

Turn off the camera.

### startPreview

```kotlin
abstract fun startPreview(container: ViewGroup)
```

Starts the local video preview before joining a channel.

### stopPreview

```kotlin
abstract fun setPrevPage()
```

Stops the local video preview and disables video.

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

将流发布到远端，包括当前摄像头采集的视频流和麦克风采集的音频流。

### unpublishStream

```kotlin
abstract fun unPublishStream(type: EduContextMediaStreamType)
```

取消发布流。

### renderRemoteView

```kotlin
abstract fun renderVideo(container: ViewGroup?, streamUuid: String)
```

Start or stop rendering the local video stream.

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
| :------------------- | :-------------------------------------------------- |
| `videoEncoderConfig` | 视频编码配置，详见 `EduContextVideoEncoderConfig`。 |
