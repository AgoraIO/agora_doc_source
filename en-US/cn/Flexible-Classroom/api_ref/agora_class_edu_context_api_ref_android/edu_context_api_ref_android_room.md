# Room Context

## RoomContext

The` RoomContext` class provides classroom management related methods that can be called by the App.

### leave

```kotlin
abstract fun leave()
```

Leave the class.


## IRoomHandler

The` IRoomHandler` class is used to report class-related event callbacks to the App.

### onClassroomName

```kotlin
fun onClassroomName(name: String)
```

Report the class name.

| Parameter | Description |
| :----- | :--------- |
| `name` | Class name. |

### onClassState

```kotlin
fun onClassState(state: EduContextClassState)
```

Report class status.

| Parameter | Description |
| :------ | :------------------------------------ |
| `state` | Class state, see EduContextClassState for details. |

### onClassTime

```kotlin
fun onClassTime(time: String)
```

Report class time.

- When the class status is `Init`, the reminder is X minutes and X seconds before class.
- When the class status is `Start`, it indicates that the class has started for X minutes and X seconds.

   * When the class status is `End`, it prompts that the class has timed out for X minutes and X seconds.

| Parameter | Description |
| :----- | :--------- |
| `time` | Class time. |

### onNetworkStateChanged

```kotlin
fun onNetworkStateChanged (state: EduContextNetworkState)
```

Report network status.

| Parameter | Description |
| :------ | :---------------------------------------- |
| `state` | Network status, see EduContextNetworkState for details``. |

### onConnectionStateChanged

```kotlin
fun onConnectionStateChanged(state: EduContextConnectionState)
```

Report connection status.

| Parameter | Description |
| :------ | :------------------------------------------- |
| `state` | Connection status, see EduContextConnectionState for details``. |

### onClassTip

```kotlin
fun onClassTip(tip: String)
```

Report tips during class.

There are the following tips:

- The course ends in 5 minutes.
- The class is over and there are 5 minutes to close the classroom.
- There is still 1 minute until the classroom closes.

| Parameter | Description |
| :---- | :------- |
| `tip` | Prompt word. |

### onError

```kotlin
fun onError(error: EduContextError)
```

Report wrong information during class.

| Parameter | Description |
| :------ | :--------------------------------- |
| `error` | Error information, see `EduContextError `for details. |
