## ExtAppContext

`ExtAppContext` 类提供可供 App 调用的扩展应用相关方法。

### init

```kotlin
fun init(container: RelativeLayout)
```

初始化扩展应用。

### launchExtApp

```kotlin
fun launchExtApp(appIdentifier: String): Int
```

启动扩展应用。

| 参数            | 描述            |
| :-------------- | :-------------- |
| `appIdentifier` | 扩展应用的 ID。 |

### getRegisteredExtApps

```kotlin
fun getRegisteredExtApps(): List<AgoraExtAppInfo>
```

获取当前注册的所有扩展应用的信息。

## IAgoraExtApp

`IAgoraExtApp` 类包含扩展应用必须的操作和生命周期回调。

### onExtAppLoaded

```kotlin
fun onExtAppLoaded(context: Context)
```

扩展应用的实例被初始化。

| 参数      | 描述             |
| :-------- | :--------------- |
| `context` | Android 上下文。 |

### onCreateView

```kotlin
fun onCreateView(content: Context): View
```

已创建扩展应用的视图。

| 参数      | 描述             |
| :-------- | :--------------- |
| `context` | Android 上下文。 |

### onPropertyUpdated

```kotlin
fun onPropertyUpdated(properties: MutableMap<String, Any>?, cause: MutableMap<String, Any?>?)
```

提示当前扩展应用的数据有更新。

| 参数         | 描述         |
| :----------- | :----------- |
| `properties` | 属性 Map     |
| `cause`      | 更新原因 Map |

### onExtAppUnloaded

```kotlin
fun onExtAppUnloaded()
```

扩展应用已被关闭，实例被释放。
