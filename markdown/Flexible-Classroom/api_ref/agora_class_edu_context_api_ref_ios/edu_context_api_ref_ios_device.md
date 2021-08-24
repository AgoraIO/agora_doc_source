## AgoraEduDeviceContext

`AgoraEduDeviceContext` 类提供可供 App 调用的设备相关方法。

### setCameraDeviceEnable

```swift
func setCameraDeviceEnable(enable: Bool)
```

开启或关闭摄像头。

| 参数     | 描述             |
| :------- | :--------------- |
| `enable` | 摄像头是否开启。 |

### switchCameraFacing

```swift
func switchCameraFacing()
```

切换前置和后置摄像头。

### setMicDeviceEnable

```swift
func setMicDeviceEnable(enable: Bool)
```

开启或关闭麦克风。

| 参数     | 描述             |
| :------- | :--------------- |
| `enable` | 麦克风是否开启。 |

### setSpeakerEnable

```swift
func setSpeakerEnable(enable: Bool)
```

开启或关闭扬声器。

| 参数     | 描述             |
| :------- | :--------------- |
| `enable` | 扬声器是否开启。 |

### registerEventHandler

```swift
func registerDeviceEventHandler(_ handler: AgoraEduDeviceHandler)
```

注册事件监听。

| 参数      | 描述                              |
| :-------- | :-------------------------------- |
| `handler` | 详见 `AgoraEduDeviceHandler` 类。 |

## AgoraEduDeviceHandler

`AgoraEduDeviceHandler` 类用于向 App 报告设备相关的事件回调。

### onCameraDeviceEnableChanged

```swift
@objc optional func onCameraDeviceEnableChanged(enabled: Bool)
```

提示摄像头是否开启。

| 参数      | 描述             |
| :-------- | :--------------- |
| `enabled` | 摄像头是否开启。 |

### onCameraFacingChanged

```swift
@objc optional func onCameraFacingChanged(facing: EduContextCameraFacing)
```

提示前置和后置摄像头的切换。

| 参数     | 描述                                        |
| :------- | :------------------------------------------ |
| `facing` | 摄像头方向，详见 `EduContextCameraFacing`。 |

### onMicDeviceEnabledChanged

```swift
@objc optional func onMicDeviceEnabledChanged(enabled: Bool)
```

提示麦克风是否开启。

| 参数      | 描述             |
| :-------- | :--------------- |
| `enabled` | 麦克风是否开启。 |

### onSpeakerEnabledChanged

```swift
@objc optional func onSpeakerEnabledChanged(enabled: Bool)
```

提示扬声器是否开启。

| 参数      | 描述             |
| :-------- | :--------------- |
| `enabled` | 扬声器是否开启。 |

### onDeviceTips

```swift
@objc optional func onDeviceTips(message: String)
```

设备相关提示回调。

| 参数      | 描述       |
| :-------- | :--------- |
| `message` | 提示信息。 |

