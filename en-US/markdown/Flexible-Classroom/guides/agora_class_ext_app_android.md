## Overview

ExtApp enables developers to develop a custom plugin, such as a countdown plugin or a dice, and embed the plugin in the flexible classroom. Plugins implemented by ExtApp can be regarded as an independent application with its own life cycle and data management, but they also connect with the Agora Classroom SDK. Developers can customize the user interfaces of the plugins, pass custom data to the Agora Classroom SDK, and also listen for data change from the Agora Classroom SDK. 

The source code of ExtApp is in the `extapp` directory in the [CloudClass-Android](https://github.com/AgoraIO-Community/CloudClass-Android) repository on GitHub.

This page introduces the procedure of using ExtApp to develop and embed a custom plugin in the flexible classroom.

## Procedure

### 1. Implement a plugin

First, inherit the `io.agora.extension.AgoraExtAppBase` class to implement a custom plugin in your app.

`AgoraExtAppBase` includes the following methods and callbacks:

#### Method

**updateProperties**

```kotlin
fun updateProperties(properties: MutableMap<String, Any?>,
                     cause: MutableMap<String, Any?>,
                     callback: AgoraExtAppCallback<String>? = null)
```

Update properties. Other plugins receive the `onPropertyUpdated` callback to get the new properties.

| Parameter | Description |
| ------------ | --------------------------------------------- |
| `properties` | The property map. |
| `cause` | The reason map. |
| `callback` | Asynchronously check whether this method call is successful through `AgoraExtAppCallback`. |

**deleteProperties**

```kotlin
fun deleteProperties(propertyKeys: MutableList<String>,
                     cause: MutableMap<String, Any?>,
                     callback: AgoraExtAppCallback<String>?)
```

Delete properties. Other plugins receive the `onPropertyUpdated` callback to get the new properties.

| Parameter | Description |
| ------------ | --------------------------------------------- |
| `properties` | The property map. |
| `cause` | The reason map. |
| `callback` | Asynchronously check whether this method call is successful through `AgoraExtAppCallback`. |

**unload**

```kotlin
fun unload()
```

Remove the plugin. A successful method call triggers the `onExtAppUnloaded` callback.

**getLocalUserInfo**

```kotlin
fun getLocalUserInfo(): AgoraExtAppUserInfo?
```

Get the current user information.

**getRoomInfo**

```kotlin
fun getRoomInfo(): AgoraExtAppRoomInfo?
```

Get the current classroom information.

**getProperties**

```kotlin
fun getProperties(): MutableMap<String, Any?>?
```

Get the current property list.

#### Callback

**onExtAppLoaded**

```kotlin
fun onExtAppLoaded(context: Context)
```

This callback is triggered after the plugin is initialized and before the view is added to the container.

| Parameter | Description |
| --------- | ---------------- |
| `context` | The android context. |

**onCreateView**

```kotlin
fun onCreateView(content: Context): View
```

Occurs when the view is created.

```kotlin
fun onPropertyUpdated(properties: MutableMap<String, Any>?, cause: MutableMap<String, Any?>?)
```

Occurs when the properties of the container are updated.

| Parameter | Description |
| ------------ | --------------------------------------------- |
| `properties` | The property map. |
| `cause` | The reason map. |
| `callback` | Asynchronously check whether this method call is successful through `AgoraExtAppCallback`. |

**onExtAppUnloaded**

```kotlin
fun onExtAppUnloaded()
```

Occurs after the plugin is closed and before the view is removed from the container.

### 2. Register the plugin to the Agora Classroom SDK

To register the plugin in the Agora Classroom SDK, call `AgoraEduSDK.registerExtApp`.

The following sample code demonstrates how to register the countdown plugin CountDownExtApp.

```java
AgoraEduSDK.registerExtApps(Arrays.asList(
   new AgoraExtAppConfiguration(
       // The plugin ID. 
              CountDownExtApp.getAppIdentifier(),
       // The size of the plugin container. 
              new ViewGroup.LayoutParams(
               ViewGroup.LayoutParams.WRAP_CONTENT,
               ViewGroup.LayoutParams.WRAP_CONTENT),
       // Inherits io.agora.extension.AgoraExtAppBase to implement the plugin 
              CountDownExtApp.class,
       // The language of the plugin. 
              Locale.getDefault().getLanguage(),
       // The plugin icon. 
              CountDownExtApp.getAppIconResource()),
   ......
));
```

### 3. Use the plugin in the flexible classroom

By default, the icon of the registered plugin is displayed in the whiteboard toolbar in the flexible classroom.

If you want to customize an entry for the plugin in the flexible classroom, you can edit the `AgoraUI1v1Container.kt`, `AgoraUILargeClassContainer.kt,` and `AgoraUISmallClassContainer.kt` files under the `agoraui/src/main/kotlin/io/agora/uikit/impl/container` path. Then call the following methods when the user clicks on the plugin icon.

```java
// Pass in the plug-in ID in the launchExtApp method. 
getEduContext()?.extAppContext()?.launchExtApp(CountDownExtApp.getAppIdentifier())
```
