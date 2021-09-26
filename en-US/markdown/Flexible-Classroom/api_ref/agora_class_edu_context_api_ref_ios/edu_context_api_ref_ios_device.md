## AgoraEduDeviceContext

`AgoraEduWhiteBoardContext` provides whiteboard-related methods that can be called by your app.

### setCameraDeviceEnable

```swift
func setCameraDeviceEnable(enable: Bool)
```

Enable or disable the local video.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | 摄像头是否开启。 |

### switchCameraFacing

```swift
func switchCameraFacing()
```

Switches between front and rear cameras.

### setMicDeviceEnable

```swift
func setMicDeviceEnable(enable: Bool)
```

Enable or disable the local video.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | 麦克风是否开启。 |

### setSpeakerEnable

```swift
func setSpeakerEnable(enable: Bool)
```

Enable or disable the local video.

| Parameter | Description |
| :------- | :--------------- |
| `enable` | 扬声器是否开启。 |

### registerEventHandler

```swift
func registerDeviceEventHandler(_ handler: AgoraEduDeviceHandler)
```

Register the event listener.

| Parameter | Description |
| :-------- | :-------------------------------- |
| `handler` | See the `AgoraEduMessageHandler` class for details. |

## AgoraEduDeviceHandler

`AgoraEduRoomHandler` reports the classroom-related event callbacks to your app.

### onCameraDeviceEnableChanged

```swift
@objc optional func onCameraDeviceEnableChanged(enabled: Bool)
```

提示本地摄像头是否开启。

- `enabled` 为 `true` 时，UI 层提示“你的摄像头被打开了”。
- `enabled` 为 `false` 时，UI 层提示“你的摄像头被关闭了”。

| Parameter | Description |
| :-------- | :--------------- |
| `enabled` | 摄像头是否开启。 |

### onCameraFacingChanged

```swift
@objc optional func onCameraFacingChanged(facing: EduContextCameraFacing)
```

提示前置和后置摄像头的切换。

| Parameter | Description |
| :------- | :------------------------------------------ |
| `facing` | 摄像头方向，详见 `EduContextCameraFacing`。 |

### onMicDeviceEnabledChanged

```swift
@objc optional func onMicDeviceEnabledChanged(enabled: Bool)
```

提示本地麦克风是否开启。

- `enabled` 为 `true` 时，UI 层提示“你可以发言了”。
- `enabled` 为 `false` 时，UI 层提示“你暂时不能发言了”。

| Parameter | Description |
| :-------- | :--------------- |
| `enabled` | 麦克风是否开启。 |

### onSpeakerEnabledChanged

```swift
@objc optional func onSpeakerEnabledChanged(enabled: Bool)
```

提示本地扬声器是否开启。

| Parameter | Description |
| :-------- | :--------------- |
| `enabled` | 扬声器是否开启。 |
