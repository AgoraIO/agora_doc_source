## AgoraEduMediaContext

`AgoraEduMediaContext` 类提供可供 App 调用的用于课前预览的相关方法。

### openCamera

```swift
func openCamera()
```

开启摄像头。

### closeCamera

```swift
func closeCamera()
```

关闭摄像头。

### startPreview

```swift
func startPreview(_ view: UIView)
```

开启本地视频预览。

### stopPreview

```swift
func stopPreview()
```

停止本地视频预览。

### openMicrophone

```swift
func openMicrophone()
```

开启麦克风。

### closeMicrophone

```swift
func closeMicrophone()
```

关闭麦克风。

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
func renderRemoteView(_ view: UIView?, streamUuid: String)
```

开始或停止渲染远端流。`view` 为 `nil` 表示停止渲染。

### setVideoConfig

```swift
func setVideoConfig(_ videoConfig: AgoraEduContextVideoConfig)
```

设置视频编码配置。

| 参数          | 描述                                              |
| :------------ | :------------------------------------------------ |
| `videoConfig` | 视频编码配置，详见 `AgoraEduContextVideoConfig`。 |
