# Room Context

## RoomContext

`RoomContext` provides the methods that can be called by your app for classroom management.

### leave

```kotlin
abstract fun leave()
```

Leave the classroom.


## IRoomHandler

`IRoomHandler` reports the classroom-related event callbacks to your app. 

### onClassroomName

```kotlin
fun onClassroomName(name: String)
```

Indicates the classroom name.

| Parameter | Description |
| :----- | :--------- |
| `name` | The classroom name. |

### onClassState

```kotlin
fun onClassState(state: EduContextClassState)
```

Indicates the classroom state.

| Parameter | Description |
| :------ | :-------------------------------------- |
| `state` | 课堂状态，详见 `EduContextClassState`。 |

### onClassTime

```kotlin
fun onClassTime(time: String)
```

Reports the class time.

- 课堂状态为 `Init` 时，`time` 表示距离上课还有几秒。
- 课堂状态为 `Start` 时，`time` 表示已开始上课几秒。
- 课堂状态为 `End` 时，`time` 表示课堂已超时几秒。

| Parameter | Description |
| :----- | :--------- |
| `time` | The class time. |

### onNetworkStateChanged

```kotlin
fun onNetworkStateChanged (state: EduContextNetworkState)
```

Reports the network state.

| Parameter | Description |
| :------ | :---------------------------------------- |
| `state` | The network state. See `EduContextNetworkState` for details. |

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

Reports the error message during the class.

| Parameter | Description |
| :------ | :--------------------------------- |
| `error` | The error message. See `EduContextErro` for details. |
