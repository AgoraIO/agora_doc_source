## ExtAppContext

`ExtAppContext` provides the methods that can be called by your app for extension applications.

### Init

```kotlin
fun init(container: RelativeLayout)
```

Initializes the extension application.

### launchExtApp

```kotlin
fun launchExtApp(appIdentifier: String): Int
```

Launches an extension application.

| Parameter | Description |
| :-------------- | :-------------- |
| `appIdentifier` | The ID of the extension application. |

### getRegisteredExtApps

```kotlin
fun getRegisteredExtApps(): List<AgoraExtAppInfo>
```

Gets the information of all registered extension applications.

## IAgoraExtApp

The `IAgoraExtApp` class contains the necessary operations and life cycle callbacks for an extension application.

### onExtAppLoaded

```kotlin
fun onExtAppLoaded(context: Context)
```

Occurs when the instance of the extension application is initialized.

| Parameter | Description |
| :-------- | :--------------- |
| `context` | The android context. |

### onCreateView

```kotlin
fun onCreateView(content: Context): View
```

The view of the extension application that has been created.

| Parameter | Description |
| :-------- | :--------------- |
| `context` | The android context. |

### onPropertyUpdated

```kotlin
fun onPropertyUpdated(properties: MutableMap<String, Any>?, cause: MutableMap<String, Any?>?)
```

Occurs when that the data of the current extension application is updated.

| Parameter | Description |
| :----------- | :----------- |
| `properties` | The property map. |
| `cause` | The reason map. |

### onExtAppUnloaded

```kotlin
fun onExtAppUnloaded()
```

Occurs when the extension application is closed and the instance is released.
