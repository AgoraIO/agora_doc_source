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

- When `enabled` is` true`, the UI layer prompts "the teacher has turned on the raise hand function".
- When `enabled` is `false`, the UI layer prompts "The teacher has turned off the raise hand function".

| Parameter | Description |
| :------- | :------------- |
| `enable` | Whether the hand-raising function is enabled. |

### onHandsUpState

```swift
@objc optional func onHandsUpState(_ state: AgoraEduContextHandsUpState)
```

Indicate the current hand state.

- When the `state` is` handsUp`, the UI layer prompts "hands up successfully".
- When the `state` is `handsDown`, the UI layer prompts "Cancel raise of hand successfully".

| Parameter | Description |
| :------ | :------------------------------------------------- |
| `state` | The current hand state. See AgoraEduContextHandsUpState for details``. |

### onHandsUpError

```swift
@objc optional func onHandsUpError(_ error: AgoraEduContextError?)
```

Reports the result of raise the hand.  If `error` is not empty, it means the local client fails to raise the hand.

| Parameter | Description |
| :------ | :------------------------------------ |
| `error` | Error code, see `AgoraEduContextError `for details. |
