## DeviceContext

`DeviceContext` provides methods that can be called by your app for device control.

### getDeviceConfig

```kotlin
abstract fun getDeviceConfig(): EduContextDeviceConfig
```

Gets the device configuration. This method returns [EduContextDeviceConfig](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextdeviceconfig).

### setCameraDeviceEnable

```kotlin
abstract fun setCameraDeviceEnable(enable: Boolean)
```

Turns on or off the camera.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | Whether the camera is turned on. |

### switchCameraFacing

```kotlin
abstract fun switchCameraFacing()
```

Switches between front and rear cameras.

### setMicDeviceEnable

```kotlin
abstract fun setMicDeviceEnable(enable: Boolean)
```

Turns on or off the microphone.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | Whether to the microphone is turned on. |

### setSpeakerEnable

```kotlin
abstract fun setSpeakerEnable(enable: Boolean)
```

Turns on or off the speaker.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | Whether to the speaker is turned on. |

### setDeviceLifecycle

```kotlin
abstract fun setDeviceLifecycle(lifecycle: EduContextDeviceLifecycle)
```

Sets the life cycle state of the device according to the life cycle state of the host. For example, you can call this method to stop media capturing when the application returns to the backend.

| Parameter | Description |
| :---------- | :----------------------------------------------------------- |
| `lifecycle` | For the life cycle status of the device, see [EduContextDeviceLifecycle](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextdevicelifecycle). |

## IDeviceHandler

`IDeviceHandler` reports the device-related events to your app.

### onCameraDeviceEnableChanged

```kotlin
fun onCameraDeviceEnableChanged(enabled: Boolean)
```

Indicates whether the camera is on.

| Parameter | Description |
| :-------- | :--------------- |
| `enabled` | Whether the camera is turned on. |

### onCameraFacingChanged

```kotlin
fun onCameraFacingChanged(facing: EduContextCameraFacing)
```

Indicates the switch between front and rear cameras.

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `facing` | The camera direction. See [EduContextCameraFacing](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextcamerafacing). |

### onMicDeviceEnabledChanged

```kotlin
fun onMicDeviceEnabledChanged(enabled: Boolean)
```

Indicates whether the microphone is on.

| Parameter | Description |
| :-------- | :--------------- |
| `enabled` | Whether to the microphone is turned on. |

### onSpeakerEnabledChanged

```kotlin
fun onSpeakerEnabledChanged(enabled: Boolean)
```

Indicates whether the speaker is on.

| Parameter | Description |
| :-------- | :--------------- |
| `enabled` | Whether to the speaker is turned on. |

### onDeviceTips

```kotlin
fun onDeviceTips(tips: String)
```

Displays device-related tips.

| Parameter | Description |
| :----- | :--------- |
| `tips` | The tip. |