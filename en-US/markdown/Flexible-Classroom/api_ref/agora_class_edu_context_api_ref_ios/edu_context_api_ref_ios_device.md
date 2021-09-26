## AgoraEduDeviceContext

`AgoraEduDeviceContext` provides methods that can be called by your app for device control.

### setCameraDeviceEnable

```swift
func setCameraDeviceEnable(enable: Bool)
```

Turn on or off the camera.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | Whether to turn on the camera. |

### switchCameraFacing

```swift
func switchCameraFacing()
```

Switches between front and rear cameras.

### setMicDeviceEnable

```swift
func setMicDeviceEnable(enable: Bool)
```

Turn on or off the microphone.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | Whether to turn on the microphone. |

### setSpeakerEnable

```swift
func setSpeakerEnable(enable: Bool)
```

Turn on or off the speaker.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | Whether to turn on the speaker. |

### registerEventHandler

```swift
func registerDeviceEventHandler(_ handler: AgoraEduDeviceHandler)
```

Register the event listener.

| Parameter | Description |
| :-------- | :-------------------------------- |
| `handler` | See the `AgoraEduDeviceHandler` class for details. |

## AgoraEduDeviceHandler

`AgoraEduDeviceHandler` reports the device-related events to your app.

### onCameraDeviceEnableChanged

```swift
@objc optional func onCameraDeviceEnableChanged(enabled: Bool)
```

Indicates whether the camera is on.

- When `enabled` is `true`, the UI layer prompts "your camera is turned on".
- When `enabled` is `false`, the UI layer prompts "your camera is turned off".

| Parameter | Description |
| :-------- | :--------------- |
| `enabled` | Whether to turn on the camera. |

### onCameraFacingChanged

```swift
@objc optional func onCameraFacingChanged(facing: EduContextCameraFacing)
```

Indicates the switch between front and rear cameras.

| Parameter | Description |
| :------- | :------------------------------------------ |
| `facing` | The camera facing.`` |

### onMicDeviceEnabledChanged

```swift
@objc optional func onMicDeviceEnabledChanged(enabled: Bool)
```

提示本地麦克风是否开启。

- When enabled is true, the UI layer prompts "your camera is turned on".````
- `enabled` 为 `false` 时，UI 层提示“你暂时不能发言了”。

| Parameter | Description |
| :-------- | :--------------- |
| `enabled` | Whether to turn on the microphone. |

### onSpeakerEnabledChanged

```swift
@objc optional func onSpeakerEnabledChanged(enabled: Bool)
```

Indicates whether the speaker is on.

| Parameter | Description |
| :-------- | :--------------- |
| `enabled` | Whether to turn on the speaker. |
