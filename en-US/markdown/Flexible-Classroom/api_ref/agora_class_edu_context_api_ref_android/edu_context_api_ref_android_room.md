## RoomContext

`RoomContext` provides the methods that can be called by your app for classroom management.

### roomInfo

```kotlin
abstract fun roomInfo(): EduContextRoomInfo
```

Gets the classroom information. See [EduContextRoomInfo](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextroominfo).

### uploadLog

```kotlin
abstract fun uploadLog(quiet: Boolean = false)
```

Uploads the logs.

| Parameter | Description |
| :------ | :----------------------------------------------------------- |
| `quiet` | Whether to upload the logs silently:<li>Silent: The logs are uploaded automatically every ten minutes.</li><li>Update logs when the end-user clicks on the Upload button in the classroom. Users can use this button to seek for help when an issue occurs during a class.</li> |

### updateFlexRoomProps

```kotlin
abstract fun updateFlexRoomProps(properties: MutableMap<String, String>,
                                      cause: MutableMap<String, String>?)
```

Adds or updates custom classroom properties. For details, see [How can I set classroom properties? ](/en/agora-class/faq/agora_class_custom_properties)

After you successfully update the properties, the remote client receives the `onFlexRoomPropertiesChanged` callback.

| Parameter | Description |
| :----------- | :--------- |
| `properties` | Classroom properties. |
| `cause` | The update reason. |

### leave

```kotlin
abstract fun leave(exit: Boolean = true)
```

Leaves the classroom.

| Parameter | Description |
| :----- | :------------- |
| `exit` | Whether to exit the current page. |

### joinClassroom

```kotlin
abstract fun joinClassroom()
```

Joins a classroom.


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
| :------ | :----------------------------------------------------------- |
| `state` | The classroom state. See [EduContextClassState](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextclassstate) for details. |

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
fun onNetworkStateChanged(state: EduContextNetworkState)
```

Reports the network state.

| Parameter | Description |
| :------ | :----------------------------------------------------------- |
| `state` | The network state. See [EduContextNetworkState](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextnetworkstate) for details. |

### onLogUploaded

```kotlin
fun onLogUploaded(logData: String)
```

Occurs when the log upload completes.

| Parameter | Description |
| :-------- | :--------------------------------------------------------- |
| `logData` | The `serialNum` of this log upload. |

### onConnectionStateChanged

```kotlin
fun onConnectionStateChanged(state: EduContextConnectionState)
```

Indicates the connection state.

| Parameter | Description |
| :------ | :----------------------------------------------------------- |
| `state` | The connection state. See [EduContextConnectionState](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextconnectionstate-1) for details. |

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

### onFlexRoomPropsInitialized

```kotlin
fun onFlexRoomPropsInitialized(properties: MutableMap<String, Any>)
```

Reports the initial custom classroom properties.

| Parameter | Description |
| :----------- | :------------- |
| `properties` | All classroom properties. |

### onFlexRoomPropsChanged

```kotlin
fun onFlexRoomPropsChanged(changedProperties: MutableMap<String, Any>,
                           properties: MutableMap<String, Any>,
                           cause: MutableMap<String, Any>?,
                           operator: EduContextUserInfo?)
```

Occurs when the custom classroom properties are updated.

| Parameter | Description |
| :------------------ | :----------------------------------------------------------- |
| `changedProperties` | The updated classroom properties. |
| `properties` | All classroom properties. |
| `cause` | The update reason. |
| `operator` | The information of the operator. See [EduContextUserInfo](/en/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserinfo). `operator` being empty means that properties are updated by the server. |

### onClassroomJoinSuccess

```kotlin
fun onClassroomJoinSuccess(roomUuid: String, timestamp: Long)
```

Occurs when the local client successfully joins the classroom.

| Parameter | Description |
| :---------- | :--------------- |
| `roomUuid` | The classroom ID. |
| `timestamp` | Timestamp when the local client joins the classroom. |

### onClassroomJoinFail

```kotlin
fun onClassroomJoinFail(roomUuid: String, code: Int?, msg: String?, timestamp: Long)
```

Occurs when the local client fails to join the classroom.

| Parameter | Description |
| :---------- | :------------------- |
| `roomUuid` | The classroom ID. |
| `timestamp` | Timestamp when the local client fails to join the classroom. |

### onClassroomLeft

```kotlin
fun onClassroomLeft(roomUuid: String, timestamp: Long, exit: Boolean = true)
```

Occurs when the local client successfully leaves the classroom.

| Parameter | Description |
| :---------- | :----------------------------------------------------------- |
| `roomUuid` | The classroom ID. |
| `timestamp` | Timestamp when the local client leaves the classroom. |
| `exit` | Whether to exit the current page. When a class ends, the user does not automatically exit the page. Developers need to remind the user of exiting the page through a pop-up window. When the user is kicked out of the class, the user automatically exits the page. |
