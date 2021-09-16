## AgoraEduDeviceContext

`AgoraEduDeviceContext` 类提供可供 App 调用的课中设备控制相关方法。

### setCameraDeviceEnable

```swift
func setCameraDeviceEnable(enable: Bool)
```

开启或关闭本地摄像头。

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

开启或关闭本地麦克风。

| 参数     | 描述             |
| :------- | :--------------- |
| `enable` | 麦克风是否开启。 |

### setSpeakerEnable

```swift
func setSpeakerEnable(enable: Bool)
```

开启或关闭本地扬声器。

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

`AgoraEduDeviceHandler` 类用于向 App 报告课中设备控制相关的事件回调。

### onCameraDeviceEnableChanged

```swift
@objc optional func onCameraDeviceEnableChanged(enabled: Bool)
```

提示本地摄像头是否开启。

- `enabled` 为 `true` 时，UI 层提示“你的摄像头被打开了”。
- `enabled` 为 `false` 时，UI 层提示“你的摄像头被关闭了”。

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

提示本地麦克风是否开启。

- `enabled` 为 `true` 时，UI 层提示“你可以发言了”。
- `enabled` 为 `false` 时，UI 层提示“你暂时不能发言了”。

| 参数      | 描述             |
| :-------- | :--------------- |
| `enabled` | 麦克风是否开启。 |

### onSpeakerEnabledChanged

```swift
@objc optional func onSpeakerEnabledChanged(enabled: Bool)
```

提示本地扬声器是否开启。

| 参数      | 描述             |
| :-------- | :--------------- |
| `enabled` | 扬声器是否开启。 |
