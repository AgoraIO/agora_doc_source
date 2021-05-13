## HandsUpContext

The` HandsUpContext` class provides hands-up related methods that can be called by App.

### performHandsUp

```kotlin
abstract fun performHandsUp(state: EduContextHandsUpState, callback: EduContextCallback<Boolean>? = null)
```

Update the hand status.

| Parameter | Description |
| :--------- | :----------------------------------------------- |
| `state` | Hands up state, see EduContextHandsUpState for details``. |
| `callback` | Obtain the interface` call result asynchronously through EduContextCallback`. |

## IHandsUpHandler

The` IHandsUpHandler` class is used to report event callbacks related to raising hands to the App.

### onHandsUpEnabled

```kotlin
fun onHandsUpEnabled(enabled: Boolean)
```

Report whether you can raise your hand.

| Parameter | Description |
| :-------- | :------------- |
| `enabled` | Can you raise your hand? |

### onHandsUpStateUpdated

```kotlin
fun onHandsUpStateUpdated(state: EduContextHandsUpState, coHost: Boolean)
```

The hands up status has been updated.

| Parameter | Description |
| :------- | :-------------------------------------------- |
| `state` | For the current hands-up state, see EduContextHandsUpState for details``. |
| `coHost` | Whether the current student is on stage. Students on the stage cannot raise their hands. |

### onHandsUpStateResultUpdated

```kotlin
fun onHandsUpStateResultUpdated(error: EduContextError?)
```

Report the result of the raise of hands.  If` error` is not empty, it means that the hand has failed.

| Parameter | Description |
| :------ | :------------------------------- |
| `error` | Error code, see EduContextError for details``. |

### onHandsUpTips

```kotlin
fun onHandsUpTips (tips: String)
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
| :----- | :--------- |
| `tips` | The tip. |

