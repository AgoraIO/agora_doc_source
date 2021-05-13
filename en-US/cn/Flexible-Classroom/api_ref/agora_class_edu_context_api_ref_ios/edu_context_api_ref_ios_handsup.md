# Hands-up Context

## AgoraEduHandsUpContext

`AgoraEduHandsUpContext` provides hand-raising-related methods that can be called by App.

### performHandsUp

```swift
func updateHandsUpState(_ state: AgoraEduContextHandsUpState)
```

Update the hand status.

| Parameter | Description |
| :------ | :---------------------------------------- |
| `state` | Hands up state, see EduContextHandsUpState for details``. |

### registerEventHandler

```swift
func registerEventHandler(_ handler: AgoraEduHandsUpHandler)
```

Register the event listener.

| Parameter | Description |
| :-------- | :--------------------------------- |
| `handler` | See the `AgoraEduHandsUpHandler` class for details. |

## AgoraEduHandsUpHandler

The` AgoraEduHandsUpHandler` class is used to report event callbacks related to raising hands to the App.

### onSetHandsUpEnable

```swift
@objc optional func onSetHandsUpEnable(_ enable: Bool)
```

Report whether you can raise your hand.

| Parameter | Description |
| :------- | :------------- |
| `enable` | Can you raise your hand? |

### onHandsUpStateUpdated

```swift
@objc optional func onSetHandsUpState(_ state: AgoraEduContextHandsUpState)
```

Report the current hand-raising status.

| Parameter | Description |
| :------ | :------------------------------------------------- |
| `state` | For the current hands-up state, see `AgoraEduContextHandsUpState `for details. |

### onHandsUpStateResultUpdated

```swift
@objc optional func onUpdateHandsUpStateResult(_ error: AgoraEduContextError?)
```

Report the result of the raise of hands.  If` error` is not empty, it means that the hand has failed.

| Parameter | Description |
| :------ | :------------------------------------ |
| `error` | Error code, see `AgoraEduContextError `for details. |

### onHandsUpTips

```swift
@objc optional func onShowHandsUpTips(_ message: String)
```

Display prompts related to raising hands.

There are the following tips:

- Raise hand timed out.
- The teacher rejected your application for a raise of hand.
- The teacher approved your application by raising your hand.
- You were stepped down by the teacher.
- Raise your hand successfully.
- Succeeded in canceling raise of hand.
- The teacher turned off the raise hand function.
- The teacher turned on the raise hand function

| Parameter | Description |
| :-------- | :--------- |
| `message` | The tip. |

