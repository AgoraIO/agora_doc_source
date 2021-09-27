## RoomContext

`RoomContext` provides the methods that can be called by your app for classroom management.

### roomInfo

```kotlin
abstract fun roomInfo(): EduContextRoomInfo
```

Gets the classroom information.

### uploadLog

```kotlin
abstract fun uploadLog(quiet: Boolean = false)
```

Upload the log.

| Parameter | Description |
| :------ | :----------------------------------------------------------- |
| `quiet` | Whether to upload silently:<li>Silent upload: The log will be uploaded automatically in ten minutes by default.</li><li>Use buttons to guide end users to upload logs. Used to call for help when there is a problem in the classroom.</li> |

### updateFlexRoomProps

```kotlin
abstract fun updateFlexRoomProps(properties: MutableMap<String, String>,
                                      cause: MutableMap<String, String>?)
```

Add or update custom classroom attributes. For details, see [How can I set user attributes? ](/en/agora-class/faq/agora_class_custom_properties)

The remote client receives the `onFlexRoomPropertiesChanged` callback.

| Parameter | Description |
| :----------- | :--------- |
| `properties` | Classroom attributes. |
| `cause` | Reason for update. |

### leave

```kotlin
abstract fun leave(exit: Boolean = true)
```

Leave the classroom.

| Parameter | Description |
| :----- | :------------- |
| `exit` | Whether to exit the page. |

### joinClassroom

```kotlin
abstract fun joinClassroom()
```

Join the classroom.


## IRoomHandler

`IRoomHandler` reports the classroom-related event callbacks to your app.

### onClassroomName

```kotlin
fun onClassroomName(name: String)
```

Indicates the classroom name.

| Parameter | Description |
| :----- | :--------- |
| `name` | Classroom name. |

### onClassState

```kotlin
fun onClassState(state: EduContextClassState)
```

Indicates the classroom state.

| Parameter | Description |
| :------ | :-------------------------------------- |
| `state` | The classroom state. See EduContextClassState for details``. |

### onClassTime

```kotlin
fun onClassTime(time: String)
```

Reports the class time.

- When the classroom state is `Init`, `time` indicates how many seconds are left before the class begins.
- When the classroom state is `Start`, `time` indicates how many seconds the class has lasted.
- When the classroom state is `End`, `time` means how many seconds the class has gone over` time`.

| Parameter | Description |
| :----- | :--------- |
| `time` | The class time. |

### onNetworkStateChanged

```kotlin
fun onNetworkStateChanged(state: EduContextNetworkState)
```

Reports the network state.

| Parameter | Description |
| :------ | :---------------------------------------- |
| `state` | The network state. See EduContextNetworkState for details``. |

### onLogUploaded

```kotlin
fun onLogUploaded(logData: String)
```

The log upload is complete.

| Parameter | Description |
| :-------- | :--------------------------------------------------------- |
| `logData` | The serialNum corresponding to the uploaded log ``this time is used to accurately query the online log. |

### onConnectionStateChanged

```kotlin
fun onConnectionStateChanged(state: EduContextConnectionState)
```

Indicates the connection state.

| Parameter | Description |
| :------ | :------------------------------------------- |
| `state` | The connection state. See EduContextConnectionState for details``. |

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
| `error` | The error message. See EduContextErro for details``. |

### onFlexRoomPropsInitialized

```kotlin
fun onFlexRoomPropsInitialized(properties: MutableMap<String, Any>)
```

Report initialized custom classroom properties.

| Parameter | Description |
| :----------- | :------------- |
| `properties` | All classroom attributes. |

### onFlexRoomPropsChanged

```kotlin
fun onFlexRoomPropsChanged(changedProperties: MutableMap<String, Any>,
                           properties: MutableMap<String, Any>,
                           cause: MutableMap<String, Any>?,
                           operator: EduContextUserInfo?)
```

Custom classroom attribute update callback.

| Parameter | Description |
| :------------------ | :----------------------------------------------------------- |
| `changedProperties` | The updated classroom properties. |
| `properties` | All classroom attributes. |
| `cause` | Reason for update. |
| `operator` | The user information. See `EduContextUserInfo`. An empty` operator` means that it is updated by the server. |

### onClassroomJoinSuccess

```kotlin
fun onClassroomJoinSuccess(roomUuid: String, timestamp: Long)
```

Prompt local users to successfully join the classroom.

| Parameter | Description |
| :---------- | :--------------- |
| `roomUuid` | Classroom ID. |
| `timestamp` | Time to join the classroom. |

### onClassroomJoinFail

```kotlin
fun onClassroomJoinFail(roomUuid: String, code: Int?, msg: String?, timestamp: Long)
```

Prompt that the local user failed to join the classroom.

| Parameter | Description |
| :---------- | :------------------- |
| `roomUuid` | Classroom ID. |
| `timestamp` | Time when joining the classroom failed. |

### onClassroomLeft

```kotlin
fun onClassroomLeft(roomUuid: String, timestamp: Long, exit: Boolean = true)
```

Prompt local users to leave the classroom.

| Parameter | Description |
| :---------- | :----------------------------------------------------------- |
| `roomUuid` | Classroom ID. |
| `timestamp` | Time to leave the classroom. |
| `exit` | Whether to exit the page. At the end of the class, the user does not automatically exit the page, the developer needs to prompt the user to exit the page through a pop-up window; when the user is kicked out of the class or is pushed out of the class, the user will automatically exit the page. |
