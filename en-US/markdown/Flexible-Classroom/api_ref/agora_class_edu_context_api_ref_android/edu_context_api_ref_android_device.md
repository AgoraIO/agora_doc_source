## DeviceContext

`AgoraEduDeviceContext` provides methods that can be called by your app for device control.

### getDeviceConfig

```kotlin
abstract fun getDeviceConfig(): EduContextDeviceConfig
```

Get the device configuration. This method returns `EduContextDeviceConfig`.

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

Set the life cycle state of the device according to the life cycle of the host. For example, you can call this method to close the device collection when the application returns to the background.

| Parameter | Description |
| :---------- | :----------------------------------------------------- |
| `lifecycle` | For the life cycle status of the device, see `EduContextDeviceLifecycle `for details. |

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

Device related prompt callback.

| Parameter | Description |
| :----- | :--------- |
| `tips` | The tip. |

