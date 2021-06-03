## RoomContext

`RoomContext` 类提供可供 App 调用的课堂管理相关方法。

### roomInfo

```kotlin
abstract fun roomInfo(): EduContextRoomInfo
```

获取课堂相关信息。

### uploadLog

```kotlin
abstract fun uploadLog()
```

上传日志。

### updateFlexRoomProps

```kotlin
abstract fun updateFlexRoomProps(properties: MutableMap<String, String>, 
                                 cause: MutableMap<String, String>?)
```

新增或更新自定义课堂属性。

属性成功更新后，会触发 `onFlexRoomPropertiesChanged` 回调。

| 参数         | 描述       |
| :----------- | :--------- |
| `properties` | 课堂属性。 |
| `cause`      | 更新原因。 |

### leave

```kotlin
abstract fun leave()
```

离开课堂。


## IRoomHandler

`IRoomHandler` 类用于向 App 报告课堂相关的事件回调。

### onClassroomName

```kotlin
fun onClassroomName(name: String)
```

报告课堂名称。

| 参数   | 描述       |
| :----- | :--------- |
| `name` | 课堂名称。 |

### onClassState

```kotlin
fun onClassState(state: EduContextClassState)
```

报告课堂状态。

| 参数    | 描述                                    |
| :------ | :-------------------------------------- |
| `state` | 课堂状态，详见 `EduContextClassState`。 |

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

| 参数    | 描述                                      |
| :------ | :---------------------------------------- |
| `state` | 网络状态，详见 `EduContextNetworkState`。 |

### onLogUploaded

```kotlin
fun onLogUploaded(logData: String)
```

日志上传成功。

| 参数      | 描述       |
| :-------- | :--------- |
| `logData` | 日志信息。 |

### onConnectionStateChanged

```kotlin
fun onConnectionStateChanged(state: EduContextConnectionState)
```

报告连接状态。

| 参数    | 描述                                         |
| :------ | :------------------------------------------- |
| `state` | 连接状态，详见 `EduContextConnectionState`。 |

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

报告初始化的自定义课堂属性。

| 参数         | 描述           |
| :----------- | :------------- |
| `properties` | 全部课堂属性。 |

### onFlexRoomPropertiesChanged

```kotlin
fun onFlexRoomPropsChanged(changedProperties: MutableMap<String, Any>,
                           properties: MutableMap<String, Any>,
                           cause: MutableMap<String, Any>?, 
                           operator: EduContextUserInfo?)
```

自定义课堂属性更新回调。

| 参数                | 描述                                                         |
| :------------------ | :----------------------------------------------------------- |
| `changedProperties` | 已更新的课堂属性。                                           |
| `properties`        | 全部课堂属性。                                               |
| `cause`             | 更新原因。                                                   |
| `operator`          | 操作者，详见 `EduContextUserInfo`。`operator` 为空表示是由服务端更新。 |

