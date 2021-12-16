## HandsUpContext

`HandsUpContext` 类提供可供 App 调用的举手上台功能相关方法。

### performHandsUp

```kotlin
abstract fun performHandsUp(state: EduContextHandsUpState, callback: EduContextCallback<Boolean>? = null)
```

更新举手状态。

| 参数       | 描述                                                         |
| :--------- | :----------------------------------------------------------- |
| `state`    | 举手状态，详见 [EduContextHandsUpState](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontexthandsupstate)。 |
| `callback` | 通过 `EduContextCallback` 异步获取接口调用结果。             |

## IHandsUpHandler

`IHandsUpHandler` 类用于向 App 报告举手上台相关的事件回调。

### onHandsUpEnabled

```kotlin
fun onHandsUpEnabled(enabled: Boolean)
```

报告是否可以举手。

| 参数      | 描述           |
| :-------- | :------------- |
| `enabled` | 是否可以举手。 |

### onHandsUpStateUpdated

```kotlin
fun onHandsUpStateUpdated(state: EduContextHandsUpState, coHost: Boolean)
```

举手状态已更新。

| 参数     | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| `state`  | 当前举手状态，详见 [EduContextHandsUpState](/cn/agora-class/edu_context_api_ref_android_type_def?platform=Android#educontexthandsupstate)。 |
| `coHost` | 当前学生是否在台上。在台上的学生不能举手。                   |

### onHandsUpStateResultUpdated

```kotlin
fun onHandsUpStateResultUpdated(error: EduContextError?)
```

报告举手结果。 `error` 不为空表示举手失败。

| 参数    | 描述                             |
| :------ | :------------------------------- |
| `error` | 错误码，详见 `EduContextError`。 |

### onHandsUpTips

```kotlin
fun onHandsUpTips(tips: String)
```

显示举手相关提示。

有以下提示：

- 举手超时。
- 老师拒绝了你的举手申请。
- 老师同意了你的举手申请。
- 你被老师下台了。
- 举手成功。
- 取消举手成功。
- 老师关闭了举手功能。
- 老师开启了举手功能

| 参数   | 描述       |
| :----- | :--------- |
| `tips` | 提示信息。 |