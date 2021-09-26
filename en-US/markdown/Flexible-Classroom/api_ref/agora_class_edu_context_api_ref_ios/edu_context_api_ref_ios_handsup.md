## AgoraEduHandsUpContext

`AgoraEduHandsUpContext` provides the methods that can be called by your app for the hand-raising function.

### updateHandsUpState

```swift
func updateHandsUpState(_ state: AgoraEduContextHandsUpState)
```

Raise or lower the hand.

| Parameter | Description |
| :------ | :---------------------------------------- |
| `state` | Whether the hand is raised. See EduContextHandsUpState for details``. |

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduHandsUpHandler)
```

Register the event listener.

| Parameter | Description |
| :-------- | :--------------------------------- |
| `handler` | See the `AgoraEduHandsUpHandler` class for details. |

## AgoraEduHandsUpHandler

`AgoraEduHandsUpHandler` reports event callbacks related to the hand-raising function to your app.

### onHandsUpEnable

```swift
@objc optional func onHandsUpEnable(_ enable: Bool)
```

Indicates whether the hand-raising function is enabled.

- `enabled` 为 `true  `时，UI 层提示”老师开启了举手功能“。
- `enabled` 为 `false` 时，UI 层提示”老师关闭了举手功能“。

| Parameter | Description |
| :------- | :------------- |
| `enable` | Whether the hand-raising function is enabled. |

### onHandsUpState

```swift
@objc optional func onHandsUpState(_ state: AgoraEduContextHandsUpState)
```

Indicate the current hand state.

- `state` 为 `handsUp ` 时，UI 层提示”举手成功“。
- `state` 为 `handsDown` 时，UI 层提示”取消举手成功“。

| Parameter | Description |
| :------ | :------------------------------------------------- |
| `state` | The current hand state. See AgoraEduContextHandsUpState for details``. |

### onHandsUpError

```swift
@objc optional func onHandsUpError(_ error: AgoraEduContextError?)
```

Reports the result of raise the hand.  If` error` is not empty, it means the local client fails to raise the hand.

| Parameter | Description |
| :------ | :------------------------------------ |
| `error` | Error code, see `AgoraEduContextError `for details. |
