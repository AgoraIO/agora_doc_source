## AgoraEduHandsUpContext

`AgoraEduHandsUpContext` provides the methods that can be called by your app for the hand-raising function.

### performHandsUp

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

### onSetHandsUpEnable

```swift
@objc optional func onSetHandsUpEnable(_ enable: Bool)
```

Indicates whether the hand-raising function is enabled.

| Parameter | Description |
| :------- | :------------- |
| `enable` | Whether the hand-raising function is enabled. |

### onHandsUpStateUpdated

```swift
@objc optional func onSetHandsUpState(_ state: AgoraEduContextHandsUpState)
```

Indicate the current hand state.

| Parameter | Description |
| :------ | :------------------------------------------------- |
| `state` | The current hand state. See `AgoraEduContextHandsUpState` for details. |

### onHandsUpStateResultUpdated

```swift
@objc optional func onUpdateHandsUpStateResult(_ error: AgoraEduContextError?)
```

Reports the result of raise the hand. ` If error` is not empty, it means the local client fails to raise the hand.

| Parameter | Description |
| :------ | :------------------------------------ |
| `error` | Error code, see `AgoraEduContextError `for details. |

### onHandsUpTips

```swift
@objc optional func onShowHandsUpTips(_ message: String)
```

Displays tips related to hand-raising.

There are the following tips:

- A timeout occurs.
- The teacher has rejected your application for a talk.
- The teacher has approved your application for a talk.
- You have been removed from the "stage" by the teacher.
- You have raise your hand.
- You have lowered your hand.
- The teacher has disabled the raise hand function.
- The teacher has enabled the raise hand function.

| Parameter | Description |
| :-------- | :--------- |
| `message` | The tip. |

