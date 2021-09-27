## DeviceContext

`AgoraEduDeviceContext` provides methods that can be called by your app for device control.

### getDeviceConfig

```kotlin
abstract fun getDeviceConfig(): EduContextDeviceConfig
```

获取设备配置。 该方法返回 `EduContextDeviceConfig`。

### setCameraDeviceEnable

```kotlin
abstract fun setCameraDeviceEnable(enable: Boolean)
```

Turn on or off the camera.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | Whether to turn on the camera. |

### switchCameraFacing

```kotlin
abstract fun switchCameraFacing()
```

Switches between front and rear cameras.

### setMicDeviceEnable

```kotlin
abstract fun setMicDeviceEnable(enable: Boolean)
```

Turn on or off the microphone.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | Whether to turn on the microphone. |

### setSpeakerEnable

```kotlin
abstract fun setSpeakerEnable(enable: Boolean)
```

Turn on or off the speaker.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | Whether to turn on the speaker. |

### setDeviceLifecycle

```kotlin
abstract fun setDeviceLifecycle(lifecycle: EduContextDeviceLifecycle)
```

根据宿主的生命周期设置设备的生命周期状态，例如可在应用退到后台时调用此方法关闭设备采集。

| Parameter | Description |
| :---------- | :----------------------------------------------------- |
| `lifecycle` | 设备的生命周期状态，详见 `EduContextDeviceLifecycle`。 |

## IDeviceHandler

`AgoraEduDeviceHandler` reports the device-related events to your app.

### onCameraDeviceEnableChanged

```kotlin
fun onCameraDeviceEnableChanged(enabled: Boolean)
```

Indicates whether the camera is on.

| Parameter | Description |
| :-------- | :--------------- |
| `enabled` | Whether to turn on the camera. |

### onCameraFacingChanged

```kotlin
fun onCameraFacingChanged(facing: EduContextCameraFacing)
```

Indicates the switch between front and rear cameras.

| Parameter | Description |
| :------- | :------------------------------------------ |
| `facing` | The camera facing``. |

### onMicDeviceEnabledChanged

```kotlin
fun onMicDeviceEnabledChanged(enabled: Boolean)
```

Whether to turn on the microphone.

| Parameter | Description |
| :-------- | :--------------- |
| `enabled` | Whether to turn on the microphone. |

### onSpeakerEnabledChanged

```kotlin
fun onSpeakerEnabledChanged(enabled: Boolean)
```

Indicates whether the speaker is on.

| Parameter | Description |
| :-------- | :--------------- |
| `enabled` | Whether to turn on the speaker. |

### onDeviceTips

```kotlin
fun onDeviceTips(tips: String)
```

设备相关提示回调。

| Parameter | Description |
| :----- | :--------- |
| `tips` | The tip. |

