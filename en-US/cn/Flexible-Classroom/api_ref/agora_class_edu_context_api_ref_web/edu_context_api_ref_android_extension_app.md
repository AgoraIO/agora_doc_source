# Extion App Context

## ExtAppContext

The` ExtAppContext` class provides extended application-related methods that can be called by App.

### launchExtApp

```kotlin
fun launchExtApp(appIdentifier: String): Int
```

Start an extended application.

| Parameter | Description |
| :-------------- | :-------------- |
| `GetAppIdentifier` | The ID of the extension application. |

### getRegisteredExtApps

```kotlin
fun getRegisteredExtApps(): List<AgoraExtAppInfo>
```

Get information about all currently registered extension applications.

## IAgoraExtApp

The` IAgoraExtApp` class contains the necessary operations and life cycle callbacks for extended applications.

### onExtAppLoaded

```kotlin
fun onExtAppLoaded(context: Context)
```

The instance of the extended application is initialized.

| Parameter | Description |
| :-------- | :--------------- |
| `context` | Android context. |

### onCreateView

```kotlin
fun onCreateView(content: Context): View
```

The view of the extended application has been created.

| Parameter | Description |
| :-------- | :--------------- |
| `context` | Android context. |

### onPropertyUpdated

```kotlin
fun onPropertyUpdated(properties: MutableMap<String, Any>?, cause: MutableMap<String, Any?>?)
```

It prompts that the data of the current extended application is updated.

| Parameter | Description |
| :----------- | :----------- |
| `properties` | Property Map |
| `cause` | Update reason Map |

### onExtAppUnloaded

```kotlin
fun onExtAppUnloaded()
```

The extended application has been closed and the instance has been released.

| Parameter | Description |
| :--- | :--- |
|  |  |

