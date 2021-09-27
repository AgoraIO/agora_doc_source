# Extension App Context

## ExtAppContext

`HandsUpContext` provides the methods that can be called by your app for the hand-raising function.

### Init

```kotlin
fun init(container: RelativeLayout)
```

Initialize the extended application.

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

The` IAgoraExtApp` class contains the necessary operations and life cycle callbacks for extended applications.

### onExtAppLoaded

```kotlin
fun onExtAppLoaded(context: Context)
```

The instance of the extended application is initialized.

| Parameter | Description |
| :-------- | :--------------- |
| `context` | The android context. |

### onCreateView

```kotlin
fun onCreateView(content: Context): View
```

The view of the extended application has been created.

| Parameter | Description |
| :-------- | :--------------- |
| `context` | The android context. |

### onPropertyUpdated

```kotlin
fun onPropertyUpdated(properties: MutableMap<String, Any>?, cause: MutableMap<String, Any?>?)
```

It prompts that the data of the current extended application has been updated.

| Parameter | Description |
| :----------- | :----------- |
| `properties` | The property map. |
| `cause` | The reason map. |

### onExtAppUnloaded

```kotlin
fun onExtAppUnloaded()
```

The extended application has been closed and the instance has been released.
