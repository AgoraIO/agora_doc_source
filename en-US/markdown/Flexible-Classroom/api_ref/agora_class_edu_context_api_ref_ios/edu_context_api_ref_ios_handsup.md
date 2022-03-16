## AgoraEduHandsUpContext

`AgoraEduHandsUpContext` provides the methods that can be called by your app for the hand-raising function.

### updateHandsUpState

```swift
func updateHandsUpState(_ state: AgoraEduContextHandsUpState)
```

Raise or lower the hand.

| Parameter | Description |
| :------ | :---------------------------------------- |
| `state` | Whether the hand is raised. See `EduContextHandsUpState` for details. |

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduHandsUpHandler)
```

Registers the event listener.

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

- When `enabled` is` true`, Flexible Classroom triggers a pop-up window saying "The teacher has enabled the hand-raising function".
- When `enabled` is `false`, Flexible Classroom triggers a pop-up window saying "The teacher has disabled the hand-raising function".

| Parameter | Description |
| :------- | :------------- |
| `enable` | Whether the hand-raising function is enabled. |

### onHandsUpState

```swift
@objc optional func onHandsUpState(_ state: AgoraEduContextHandsUpState)
```

Indicates the current hand state.

- When the `state` is `handsUp`, Flexible Classroom triggers a pop-up window saying "Your hand is up".
- When the `state` is `handsDown`, Flexible Classroom triggers a pop-up window saying "Your hand is down".

| Parameter | Description |
| :------ | :------------------------------------------------- |
| `state` | The current hand state. See `AgoraEduContextHandsUpState` for details. |

### onHandsUpError

```swift
@objc optional func onHandsUpError(_ error: AgoraEduContextError?)
```

Reports the result of raising the hand.  If `error` is not empty, it means the local client fails to raise the hand.

| Parameter | Description |
| :------ | :------------------------------------ |
| `error` | Error code. See `AgoraEduContextError` for details. |
