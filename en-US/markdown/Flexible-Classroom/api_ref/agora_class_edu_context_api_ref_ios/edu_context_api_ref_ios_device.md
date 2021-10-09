## AgoraEduDeviceContext

`AgoraEduDeviceContext` provides methods that can be called by your app for device control.

### setCameraDeviceEnable

```swift
func setCameraDeviceEnable(enable: Bool)
```

Turn on or off the camera.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | Whether the camera is turned on. |

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
| `enable` | Whether to the microphone is turned on. |

### setSpeakerEnable

```swift
func setSpeakerEnable(enable: Bool)
```

Turn on or off the speaker.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | Whether to the speaker is turned on. |

### registerEventHandler

```swift
func registerDeviceEventHandler(_ handler: AgoraEduDeviceHandler)
```

Registers the event listener.

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

- When `enabled` is `true`, the UI layer prompts "Your camera is turned on".
- When `enabled` is `false`, the UI layer prompts "Your camera is turned off".

| Parameter | Description |
| :-------- | :--------------- |
| `enabled` | Whether the camera is turned on. |

### onCameraFacingChanged

```swift
@objc optional func onCameraFacingChanged(facing: EduContextCameraFacing)
```

Indicates the switch between front and rear cameras.

| Parameter | Description |
| :------- | :------------------------------------------ |
| `facing` | The camera direction. See `EduContextCameraFacing`. |

### onMicDeviceEnabledChanged

```swift
@objc optional func onMicDeviceEnabledChanged(enabled: Bool)
```

Indicates whether the camera is on.

- When `enabled` is `true`, the UI layer prompts "Your camera is turned on".
- When `enabled` is `false`, the UI layer prompts "Your camera is turned off".

| Parameter | Description |
| :-------- | :--------------- |
| `enabled` | Whether to the microphone is turned on. |

### onSpeakerEnabledChanged

```swift
@objc optional func onSpeakerEnabledChanged(enabled: Bool)
```

Indicates whether the speaker is on.

| Parameter | Description |
| :-------- | :--------------- |
| `enabled` | Whether to the speaker is turned on. |
