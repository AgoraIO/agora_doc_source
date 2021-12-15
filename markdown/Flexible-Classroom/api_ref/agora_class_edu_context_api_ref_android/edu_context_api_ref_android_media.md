## MediaContext

`MediaContext` 类提供可供 App 调用的用于课前预览的相关方法。

### openCamera

```kotlin
abstract fun openCamera()
```

开启摄像头。

### closeCamera

```kotlin
abstract fun closeCamera()
```

关闭摄像头。

### startPreview

```kotlin
abstract fun startPreview(container: ViewGroup)
```

开启本地视频预览。

### stopPreview

```kotlin
abstract fun stopPreview()
```

停止本地视频预览。

### openMicrophone

```kotlin
abstract fun openMicrophone()
```

开启麦克风。

### closeMicrophone

```kotlin
abstract fun closeMicrophone()
```

关闭麦克风。

### publishStream

```kotlin
abstract fun publishStream(type: EduContextMediaStreamType)
```

将流发布到远端，包括当前摄像头采集的视频流和麦克风采集的音频流。

| 参数   | 描述                                                                                                                                            |
| :----- | :---------------------------------------------------------------------------------------------------------------------------------------------- |
| `type` | 媒体流类型，详见 [EduContextMediaStreamType](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextmediastreamtype)。 |

### unpublishStream

```kotlin
abstract fun unPublishStream(type: EduContextMediaStreamType)
```

取消发布流。

| 参数   | 描述                                                                                                                                            |
| :----- | :---------------------------------------------------------------------------------------------------------------------------------------------- |
| `type` | 媒体流类型，详见 [EduContextMediaStreamType](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextmediastreamtype)。 |

### renderRemoteView

```kotlin
abstract fun renderRemoteView(container: ViewGroup?, streamUuid: String)
```

开始或停止渲染远端视频流。

| 参数         | 描述                                                   |
| :----------- | :----------------------------------------------------- |
| `container`  | 视频 Container。`viewGroup` 为 `null` 代表关闭流渲染。 |
| `streamUuid` | 流 ID。                                                |

### setVideoEncoderConfig

```kotlin
abstract fun setVideoEncoderConfig(videoEncoderConfig: EduContextVideoEncoderConfig)
```

设置视频编码配置。

| 参数                 | 描述                                                                                                                                                    |
| :------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `videoEncoderConfig` | 视频编码配置，详见 [EduContextVideoEncoderConfig](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextvideoencoderconfig)。 |
