## HandsUpContext

`HandsUpContext` provides the methods that can be called by your app for the hand-raising function.

### performHandsUp

```kotlin
abstract fun performHandsUp(state: EduContextHandsUpState, callback: EduContextCallback<Boolean>? = null)
```

Raise or lower the hand.

| Parameter | Description |
| :--------- | :----------------------------------------------------------- |
| `state` | The current hand state. See [EduContextHandsUpState](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontexthandsupstate) for details. |
| `callback` | Get the result of hand raising asynchronously through ` EduContextCallback`. |

## IHandsUpHandler

`IHandsUpHandler` reports event callbacks related to the hand-raising function to your app.

### onHandsUpEnabled

```kotlin
fun onHandsUpEnabled(enabled: Boolean)
```

Indicates whether the hand-raising function is enabled.

| Parameter | Description |
| :-------- | :------------- |
| `enabled` | Whether the hand-raising function is enabled. |

### onHandsUpStateUpdated

```kotlin
fun onHandsUpStateUpdated(state: EduContextHandsUpState, coHost: Boolean)
```

Occurs when the hand state updates.

| Parameter | Description |
| :------- | :----------------------------------------------------------- |
| `state` | The current hand state. See [EduContextHandsUpState](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontexthandsupstate). |
| `coHost` | Whether the local client is on "stage". The on-stage students cannot raise their hands. |

### onHandsUpStateResultUpdated

```kotlin
fun onHandsUpStateResultUpdated(error: EduContextError?)
```

Reports the result of raising the hand.  If `error` is not empty, it means the local client fails to raise the hand.

| Parameter | Description |
| :------ | :------------------------------- |
| `error` | The error code. See `EduContextError` for details. |

### onHandsUpTips

```kotlin
fun onHandsUpTips(tips: String)
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
| :----- | :--------- |
| `tips` | The tip. |