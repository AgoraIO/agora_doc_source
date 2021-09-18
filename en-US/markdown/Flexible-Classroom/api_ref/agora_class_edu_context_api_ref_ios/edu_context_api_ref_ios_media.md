## AgoraEduMediaContext

`AgoraEduUserContext` provides user-list-related methods that can be called by your app.

### openCamera

```swift
func openCamera()
```

Turn on the camera.

### closeCamera

```swift
func closeCamera()
```

Turn off the camera.

### startPreview

```swift
func startPreview(_ view: UIView)
```

Starts the local video preview.

### stopPreview

```swift
func stopPreview()
```

Stops the local video preview.

### openMicrophone

```swift
func openMicrophone()
```

Turn on the microphone.

### closeMicrophone

```swift
func closeMicrophone()
```

Turn off the microphone.

### publishStream

```swift
func publishStream(type: EduContextMediaStreamType)
```

将流发布到远端，包括当前摄像头采集的视频流和麦克风采集的音频流。

### unpublishStream

```swift
func unpublishStream(type: EduContextMediaStreamType)
```

取消发布流。

### renderRemoteView

```swift
func renderView(_ view: UIView?, streamUuid: String)
```

开始或停止渲染远端流。 Setting `view` as `nil` means stopping rendering the video stream.

### setVideoConfig

```swift
func setVideoConfig(_ videoConfig: AgoraEduContextVideoConfig)
```

Sets the video encoder configuration.

| Parameter | Description |
| :------------ | :------------------------------------------------ |
| `videoConfig` | 视频编码配置，详见 `AgoraEduContextVideoConfig`。 |
