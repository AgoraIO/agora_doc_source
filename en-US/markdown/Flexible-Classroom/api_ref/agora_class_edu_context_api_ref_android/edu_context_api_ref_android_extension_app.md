# Ext App Context

## ExtAppContext

`HandsUpContext` provides the methods that can be called by your app for the hand-raising function.

### Init

```kotlin
fun init(container: RelativeLayout)
```

初始化扩展应用。

### launchExtApp

```kotlin
fun launchExtApp(appIdentifier: String): Int
```

启动扩展应用。

| Parameter | Description |
| :-------------- | :-------------- |
| `GetAppIdentifier` | 扩展应用的 ID。 |

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

| Parameter | Description |
| :-------- | :--------------- |
| `context` | The android context. |

### onCreateView

```kotlin
fun onCreateView(content: Context): View
```

已创建扩展应用的视图。

| Parameter | Description |
| :-------- | :--------------- |
| `context` | The android context. |

### onPropertyUpdated

```kotlin
fun onPropertyUpdated(properties: MutableMap<String, Any>?, cause: MutableMap<String, Any?>?)
```

提示当前扩展应用的数据有更新。

| Parameter | Description |
| :----------- | :----------- |
| `properties` | The property map. |
| `cause` | The reason map. |

### onExtAppUnloaded

```kotlin
fun onExtAppUnloaded()
```

扩展应用已被关闭，实例被释放。
