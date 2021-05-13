# Room Context

## RoomContext

`RoomContext` 类提供可供 App 调用的课堂管理相关方法。

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

| 参数    | 描述                                  |
| :------ | :------------------------------------ |
| `state` | 课堂状态，详见 EduContextClassState。 |

### onClassTime

```kotlin

fun onClassTime(time: String)
```

报告课堂时间。

- 课堂状态为 `Init` 时，提示距离上课还有 X 分 X 秒。
- 课堂状态为 `Start` 时， 提示已开始上课 X 分 X 秒。

   * 课堂状态为 `End` 时，提示课堂已超时 X 分 X 秒。

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
