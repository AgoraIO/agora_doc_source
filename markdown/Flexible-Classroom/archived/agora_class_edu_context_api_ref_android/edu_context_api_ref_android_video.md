## VideoContext

`VideoContext` 类提供可供 App 调用的课中媒体控制相关方法。主要用于控制一对一课堂中的老师和学生的音视频以及小班课和大班课中老师的音视频。

### updateVideo

```kotlin
abstract fun updateVideo(enabled: Boolean)
```

开启或关闭本地视频。

| 参数      | 描述               |
| :-------- | :----------------- |
| `enabled` | 是否开启本地视频。 |

### updateAudio

```kotlin
abstract fun updateAudio(enabled: Boolean)
```

开启或关闭本地音频。

| 参数      | 描述               |
| :-------- | :----------------- |
| `enabled` | 是否开启本地音频。 |

### renderVideo

```kotlin
abstract fun renderVideo(viewGroup: ViewGroup?,
                         streamUuid: String,
                         renderConfig: EduContextRenderConfig = EduContextRenderConfig()
)
```

开始或停止渲染本地视频流。

| 参数           | 描述                                                                                                                                        |
| :------------- | :------------------------------------------------------------------------------------------------------------------------------------------ |
| `container`    | 视频 Container。`viewGroup` 为 `null` 代表关闭流渲染。                                                                                      |
| `streamUuid`   | 流 ID。                                                                                                                                     |
| `renderConfig` | 视频渲染配置，详见 [EduContextRenderConfig](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextrenderconfig)。 |

### setVideoEncoderConfig

```kotlin
abstract fun setVideoEncoderConfig(config: EduContextVideoEncoderConfig)
```

设置视频编码配置。

| 参数     | 描述                                                                                                                                                    |
| :------- | :------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `config` | 视频编码配置，详见 [EduContextVideoEncoderConfig](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextvideoencoderconfig)。 |

## IVideoHandler

`IVideoHandler` 类用于向 App 报告媒体相关的事件回调。

### onUserDetailInfoUpdated

```kotlin
fun onUserDetailInfoUpdated(info: EduContextUserDetailInfo)
```

提示用户信息更新。

| 参数   | 描述                                                                                                                                        |
| :----- | :------------------------------------------------------------------------------------------------------------------------------------------ |
| `info` | 用户信息，详见 [EduContextUserDetailInfo](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserdetailinfo)。 |

### onVolumeUpdated

```kotlin
fun onVolumeUpdated(volume: Int, streamUuid: String)
```

提示音量更新。

| 参数         | 描述    |
| :----------- | :------ |
| `volume`     | 音量。  |
| `streamUuid` | 流 ID。 |

### onMessageUpdated

```kotlin
fun onMessageUpdated(msg: String)
```

显示媒体相关提示信息。

有以下提示：

-   你的摄像头被关闭了
-   你的摄像头被打开了
-   你的麦克风被关闭了
-   你的麦克风被打开了

| 参数  | 描述       |
| :---- | :--------- |
| `msg` | 提示信息。 |
