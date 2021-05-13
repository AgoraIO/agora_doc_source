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
| `state` | The classroom state. See `EduContextClassState` for details. |

### onClassTime

```kotlin
fun onClassTime(time: String)
```

Reports the class time.

- When the classroom state is `Init`, `time` indicates how many seconds are left before the class begins.
- When the classroom state is `Start`, `time` indicates how many seconds the class has lasted.
- When the classroom state is `End`, `time` means how many seconds the class has gone over time.

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

Indicates the connection state.

| Parameter | Description |
| :------ | :------------------------------------------- |
| `state` | The connection state. See `EduContextConnectionState` for details. |

### onClassTip

```kotlin
fun onClassTip(tip: String)
```

Class notifications.

There are the following tips:

- The class ends in five minutes.
- The class is over and the classroom closes in five minutes.
- The classroom closes in one minute.

| Parameter | Description |
| :---- | :------- |
| `tip` | The notification. |

### onError

```kotlin
fun onError(error: EduContextError)
```

Reports the error message during the class.

| Parameter | Description |
| :------ | :--------------------------------- |
| `error` | The error message. See `EduContextErro` for details. |
