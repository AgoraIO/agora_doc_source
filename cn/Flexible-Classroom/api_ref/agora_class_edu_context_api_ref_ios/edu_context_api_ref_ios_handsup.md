# Hands-up Context

## AgoraEduHandsUpContext

`AgoraEduHandsUpContext` 类提供可供 App 调用的举手上台相关方法。

### performHandsUp

```swift
func updateHandsUpState(_ state: AgoraEduContextHandsUpState)
```

更新举手状态。

| 参数    | 描述                                      |
| :------ | :---------------------------------------- |
| `state` | 举手状态，详见 `EduContextHandsUpState`。 |

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduHandsUpHandler)
```

注册事件监听。

| 参数      | 描述                               |
| :-------- | :--------------------------------- |
| `handler` | 详见 `AgoraEduHandsUpHandler` 类。 |

## AgoraEduHandsUpHandler

`AgoraEduHandsUpHandler` 类用于向 App 报告举手上台相关的事件回调。

### onSetHandsUpEnable

```swift
@objc optional func onSetHandsUpEnable(_ enable: Bool)
```

报告是否可以举手。

| 参数     | 描述           |
| :------- | :------------- |
| `enable` | 是否可以举手。 |

### onHandsUpStateUpdated

```swift
@objc optional func onSetHandsUpState(_ state: AgoraEduContextHandsUpState)
```

报告当前举手状态。

| 参数    | 描述                                               |
| :------ | :------------------------------------------------- |
| `state` | 当前举手状态，详见 `AgoraEduContextHandsUpState`。 |

### onHandsUpStateResultUpdated

```swift
@objc optional func onUpdateHandsUpStateResult(_ error: AgoraEduContextError?)
```

报告举手结果。 `error` 不为空表示举手失败。

| 参数    | 描述                                  |
| :------ | :------------------------------------ |
| `error` | 错误码，详见 `AgoraEduContextError`。 |

### onHandsUpTips

```swift
@objc optional func onShowHandsUpTips(_ message: String)
```

显示举手相关提示。

有以下提示：

- 举手超时。
- 老师拒绝了你的举手申请。
- 老师同意了你的举手申请。
- 你被老师下台了。
- 举手成功。
- 取消举手成功。
- 老师关闭了举手功能。
- 老师开启了举手功能

| 参数      | 描述       |
| :-------- | :--------- |
| `message` | 提示信息。 |

