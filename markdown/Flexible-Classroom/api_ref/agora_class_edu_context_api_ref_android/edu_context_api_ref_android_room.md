## RoomContext

`RoomContext` 类提供可供 App 调用的教室管理相关方法。

### roomInfo

```kotlin
abstract fun roomInfo(): EduContextRoomInfo
```

获取教室相关信息，详见[EduContextRoomInfo](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextroominfo)。

### uploadLog

```kotlin
abstract fun uploadLog(quiet: Boolean = false)
```

上传日志。

| 参数    | 描述                                                         |
| :------ | :----------------------------------------------------------- |
| `quiet` | 是否静默上传：<li>静默上传：默认十分钟会自动上传日志。</li><li>通过按钮引导终端用户上传日志。用于课堂出现问题时进行求救。</li> |

### updateFlexRoomProps

```kotlin
abstract fun updateFlexRoomProps(properties: MutableMap<String, String>, 
                                      cause: MutableMap<String, String>?)
```

新增或更新自定义教室属性。详见[如何设置自定义教室属性？](/cn/agora-class/faq/agora_class_custom_properties)

属性成功更新后，会触发 `onFlexRoomPropertiesChanged` 回调。

| 参数         | 描述       |
| :----------- | :--------- |
| `properties` | 教室属性。 |
| `cause`      | 更新原因。 |

### leave

```kotlin
abstract fun leave(exit: Boolean = true)
```

离开教室。

| 参数   | 描述           |
| :----- | :------------- |
| `exit` | 是否退出页面。 |

### joinClassroom

```kotlin
abstract fun joinClassroom()
```

加入教室。


## IRoomHandler

`IRoomHandler` 类用于向 App 报告教室相关的事件回调。

### onClassroomName

```kotlin
fun onClassroomName(name: String)
```

报告教室名称。

| 参数   | 描述       |
| :----- | :--------- |
| `name` | 教室名称。 |

### onClassState

```kotlin
fun onClassState(state: EduContextClassState)
```

报告课堂状态。

| 参数    | 描述                                                         |
| :------ | :----------------------------------------------------------- |
| `state` | 课堂状态，详见 [EduContextClassState](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextclassstate)。 |

### onClassTime

```kotlin
fun onClassTime(time: String)
```

报告课堂时间。

- 课堂状态为 `Init` 时，`time` 表示距离上课还有几秒。
- 课堂状态为 `Start` 时，`time` 表示已开始上课几秒。
- 课堂状态为 `End` 时，`time` 表示课堂已超时几秒。

| 参数   | 描述       |
| :----- | :--------- |
| `time` | 课堂时间。 |

### onNetworkStateChanged

```kotlin
fun onNetworkStateChanged(state: EduContextNetworkState)
```

报告网络状态。

| 参数    | 描述                                                         |
| :------ | :----------------------------------------------------------- |
| `state` | 网络状态，详见 [EduContextNetworkState](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextnetworkstate)。 |

### onLogUploaded

```kotlin
fun onLogUploaded(logData: String)
```

日志上传完成。

| 参数      | 描述                                                       |
| :-------- | :--------------------------------------------------------- |
| `logData` | 本次上传的日志所对应的 `serialNum`，用于精确查询线上日志。 |

### onConnectionStateChanged

```kotlin
fun onConnectionStateChanged(state: EduContextConnectionState)
```

报告连接状态。

| 参数    | 描述                                                         |
| :------ | :----------------------------------------------------------- |
| `state` | 连接状态，详见 [EduContextConnectionState](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextconnectionstate-1)。 |

### onClassTip

```kotlin
fun onClassTip(tip: String)
```

报告上课期间的提示。

有以下提示：

- 课程还有 5 分钟结束。
- 课程结束咯，还有 5 分钟关闭教室。
- 距离教室关闭还有 1 分钟。

| 参数  | 描述     |
| :---- | :------- |
| `tip` | 提示词。 |

### onError

```kotlin
fun onError(error: EduContextError)
```

报告上课过程中的错误信息。

| 参数    | 描述                               |
| :------ | :--------------------------------- |
| `error` | 错误信息，详见 `EduContextError`。 |

### onFlexRoomPropsInitialized

```kotlin
fun onFlexRoomPropsInitialized(properties: MutableMap<String, Any>)
```

报告初始化的自定义教室属性。

| 参数         | 描述           |
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

| 参数                | 描述                                                         |
| :------------------ | :----------------------------------------------------------- |
| `changedProperties` | 已更新的教室属性。                                           |
| `properties`        | 全部教室属性。                                               |
| `cause`             | 更新原因。                                                   |
| `operator`          | 操作者，详见 [EduContextUserInfo](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontextuserinfo)。`operator` 为空表示是由服务端更新。 |

### onClassroomJoinSuccess

```kotlin
fun onClassroomJoinSuccess(roomUuid: String, timestamp: Long)
```

提示本地用户成功加入教室。

| 参数        | 描述             |
| :---------- | :--------------- |
| `roomUuid`  | 教室 ID。        |
| `timestamp` | 加入教室的时间。 |

### onClassroomJoinFail

```kotlin
fun onClassroomJoinFail(roomUuid: String, code: Int?, msg: String?, timestamp: Long)
```

提示本地用户加入教室失败。

| 参数        | 描述                 |
| :---------- | :------------------- |
| `roomUuid`  | 教室 ID。            |
| `timestamp` | 加入教室失败的时间。 |

### onClassroomLeft

```kotlin
fun onClassroomLeft(roomUuid: String, timestamp: Long, exit: Boolean = true)
```

提示本地用户离开教室。

| 参数        | 描述                                                         |
| :---------- | :----------------------------------------------------------- |
| `roomUuid`  | 教室 ID。                                                    |
| `timestamp` | 离开教室的时间。                                             |
| `exit`      | 是否退出页面。课堂结束时，用户不自动退出页面，开发者需要通过弹窗提示用户退出页面；用户被踢出课堂或被挤出课堂时，会自动退出页面。 |
