## AgoraEduMediaContext

`AgoraEduMediaContext` provides the methods that can be called by your app for pre-class audio and video preview.

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

Publish local streams to the remote clients, including the video stream captured by the camera and the audio stream sampled by the microphone.

### unpublishStream

```swift
func unpublishStream(type: EduContextMediaStreamType)
```

Unpublish local streams.

### renderRemoteView

```swift
func renderRemoteView(_ view: UIView?, streamUuid: String)
```

Starts or stops rendering the remote video stream. Setting `view` as `nil` means stopping rendering the video stream.

### setVideoConfig

```swift
func setVideoConfig(_ videoConfig: AgoraEduContextVideoConfig)
```

Sets the video encoder configuration.

| Parameter | Description |
| :------------ | :------------------------------------------------ |
| `videoConfig` | The video encoding configuration. See `AgoraEduContextVideoConfig`. |
