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

上传日志。

| Parameter | Description |
| :------ | :----------------------------------------------------------- |
| `quiet` | 是否静默上传：<li>静默上传：默认十分钟会自动上传日志。</li><li>通过按钮引导终端用户上传日志。 用于课堂出现问题时进行求救。</li> |

### updateFlexRoomProps

```kotlin
abstract fun updateFlexRoomProps(properties: MutableMap<String, String>,
                                      cause: MutableMap<String, String>?)
```

新增或更新自定义教室属性。 For details, see [How can I set user attributes? ](/en/agora-class/faq/agora_class_custom_properties)

The remote client receives the `onFlexRoomPropertiesChanged` callback.

| Parameter | Description |
| :----------- | :--------- |
| `properties` | 教室属性。 |
| `cause` | 更新原因。 |

### leave

```kotlin
abstract fun leave(exit: Boolean = true)
```

离开教室。

| Parameter | Description |
| :----- | :------------- |
| `exit` | 是否退出页面。 |

### joinClassroom

```kotlin
abstract fun joinClassroom()
```

加入教室。


## IRoomHandler

`IRoomHandler` reports the classroom-related event callbacks to your app.

### onClassroomName

```kotlin
fun onClassroomName(name: String)
```

Indicates the classroom name.

| Parameter | Description |
| :----- | :--------- |
| `name` | 教室名称。 |

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

日志上传完成。

| Parameter | Description |
| :-------- | :--------------------------------------------------------- |
| `logData` | 本次上传的日志所对应的 `serialNum`，用于精确查询线上日志。 |

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

报告初始化的自定义教室属性。

| Parameter | Description |
| :----------- | :------------- |
| `properties` | 全部教室属性。 |

### onFlexRoomPropsChanged

```kotlin
fun onFlexRoomPropsChanged(changedProperties: MutableMap<String, Any>,
                           properties: MutableMap<String, Any>,
                           cause: MutableMap<String, Any>?,
                           operator: EduContextUserInfo?)
```

自定义教室属性更新回调。

| Parameter | Description |
| :------------------ | :----------------------------------------------------------- |
| `changedProperties` | 已更新的教室属性。 |
| `properties` | 全部教室属性。 |
| `cause` | 更新原因。 |
| `operator` | The user information. See `EduContextUserInfo`. `operator` 为空表示是由服务端更新。 |

### onClassroomJoinSuccess

```kotlin
fun onClassroomJoinSuccess(roomUuid: String, timestamp: Long)
```

提示本地用户成功加入教室。

| Parameter | Description |
| :---------- | :--------------- |
| `roomUuid` | 教室 ID。 |
| `timestamp` | 加入教室的时间。 |

### onClassroomJoinFail

```kotlin
fun onClassroomJoinFail(roomUuid: String, code: Int?, msg: String?, timestamp: Long)
```

提示本地用户加入教室失败。

| Parameter | Description |
| :---------- | :------------------- |
| `roomUuid` | 教室 ID。 |
| `timestamp` | 加入教室失败的时间。 |

### onClassroomLeft

```kotlin
fun onClassroomLeft(roomUuid: String, timestamp: Long, exit: Boolean = true)
```

提示本地用户离开教室。

| Parameter | Description |
| :---------- | :----------------------------------------------------------- |
| `roomUuid` | 教室 ID。 |
| `timestamp` | 离开教室的时间。 |
| `exit` | 是否退出页面。 课堂结束时，用户不自动退出页面，开发者需要通过弹窗提示用户退出页面；用户被踢出课堂或被挤出课堂时，会自动退出页面。 |
