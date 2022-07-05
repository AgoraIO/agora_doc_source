## AgoraEduHandsUpContext

`AgoraEduHandsUpContext` 类提供可供 App 调用的举手上台功能相关方法。

### updateHandsUpState

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

### onHandsUpEnable

```swift
@objc optional func onHandsUpEnable(_ enable: Bool)
```

报告是否可以举手。

- `enabled` 为 `true  `时，UI 层提示”老师开启了举手功能“。
- `enabled` 为 `false` 时，UI 层提示”老师关闭了举手功能“。

| 参数     | 描述           |
| :------- | :------------- |
| `enable` | 是否可以举手。 |

### onHandsUpState

```swift
@objc optional func onHandsUpState(_ state: AgoraEduContextHandsUpState)
```

报告当前举手状态。

- `state` 为 `handsUp ` 时，UI 层提示”举手成功“。
- `state` 为 `handsDown` 时，UI 层提示”取消举手成功“。

| 参数    | 描述                                               |
| :------ | :------------------------------------------------- |
| `state` | 当前举手状态，详见 `AgoraEduContextHandsUpState`。 |

### onHandsUpError

```swift
@objc optional func onHandsUpError(_ error: AgoraEduContextError?)
```

报告举手结果。 `error` 不为空表示举手失败。

| 参数    | 描述                                  |
| :------ | :------------------------------------ |
| `error` | 错误码，详见 `AgoraEduContextError`。 |
