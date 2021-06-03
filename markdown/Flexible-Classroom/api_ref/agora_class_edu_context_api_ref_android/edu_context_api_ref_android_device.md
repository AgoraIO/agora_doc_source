## DeviceContext

`DeviceContext` 类提供可供 App 调用的设备相关方法。

### getDeviceConfig

```kotlin
abstract fun getDeviceConfig(): EduContextDeviceConfig
```

获取设备配置。该方法返回 `EduContextDeviceConfig`。

### setCameraDeviceEnable

```kotlin
abstract fun setCameraDeviceEnable(enable: Boolean)
```

开启或关闭摄像头。

| 参数     | 描述             |
| :------- | :--------------- |
| `enable` | 摄像头是否开启。 |

### switchCameraFacing

```kotlin
abstract fun switchCameraFacing()
```

切换前置和后置摄像头。

### setMicDeviceEnable

```kotlin
abstract fun setMicDeviceEnable(enable: Boolean)
```

开启或关闭麦克风。

| 参数     | 描述             |
| :------- | :--------------- |
| `enable` | 麦克风是否开启。 |

### setSpeakerEnable

```kotlin
abstract fun setSpeakerEnable(enable: Boolean)
```

开启或关闭扬声器。

| 参数     | 描述             |
| :------- | :--------------- |
| `enable` | 扬声器是否开启。 |

## IDeviceHandler

`IDeviceHandler` 类用于向 App 报告设备相关的事件回调。

### onCameraDeviceEnableChanged

```kotlin
fun onCameraDeviceEnableChanged(enabled: Boolean)
```

提示摄像头是否开启。

| 参数      | 描述             |
| :-------- | :--------------- |
| `enabled` | 摄像头是否开启。 |

### onCameraFacingChanged

```kotlin
fun onCameraFacingChanged(facing: EduContextCameraFacing)
```

提示前置和后置摄像头的切换。

| 参数     | 描述                                        |
| :------- | :------------------------------------------ |
| `facing` | 摄像头方向，详见 `EduContextCameraFacing`。 |

### onMicDeviceEnabledChanged

```kotlin
fun onMicDeviceEnabledChanged(enabled: Boolean)
```

提示麦克风是否开启。

| 参数      | 描述             |
| :-------- | :--------------- |
| `enabled` | 麦克风是否开启。 |

### onSpeakerEnabledChanged

```kotlin
fun onSpeakerEnabledChanged(enabled: Boolean)
```

提示扬声器是否开启。

| 参数      | 描述             |
| :-------- | :--------------- |
| `enabled` | 扬声器是否开启。 |

### onDeviceTips

```kotlin
fun onDeviceTips(tips: String)
```

设备相关提示回调。

| 参数   | 描述       |
| :----- | :--------- |
| `tips` | 提示信息。 |

