## Overview

ExtApp is a tool for embedding plug-ins in Flexible Classroom. Plug-ins implemented by ExtApp can be regarded as an independent application with its own life cycle and data management, but they also depend on the Agora Classroom SDK. You can customize the user interfaces of the plug-in, pass custom data to the Agora Classroom SDK, and monitor data changes through ExtApp. ExtApp enables you to embed custom plug-ins, such as a countdown tool or a dice in the  Flexible Classroom.

The source code of ExtApp is in the `extapp` directory in the [CloudClass-Android](https://github.com/AgoraIO-Community/CloudClass-Android) repository on GitHub.

This page describes the procedure of using ExtApp to embed a custom plug-in in the Flexible Classroom.

## Procedure

### 1. Implement a plug-in

First, inherit the `io.agora.extension.AgoraExtAppBase` class to implement a custom plug-in in your app.

`AgoraExtAppBase` includes the following methods and callbacks:

#### Method

**updateProperties**

```kotlin
fun updateProperties(properties: MutableMap<String, Any?>,
                     cause: MutableMap<String, Any?>,
                     callback: AgoraExtAppCallback<String>? = null)
```

Update properties. Other plug-ins receive the `onPropertyUpdated` callback to get the new properties.

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

Delete properties. Other plug-ins receive the `onPropertyUpdated` callback to get the new properties.

| Parameter | Description |
| ------------ | --------------------------------------------- |
| `properties` | The property map. |
| `cause` | The reason map. |
| `callback` | Asynchronously check whether this method call is successful through `AgoraExtAppCallback`. |

**unload**

```kotlin
fun unload()
```

Remove the plug-in. A successful method call triggers the `onExtAppUnloaded` callback.

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

This callback is triggered after the plug-in is initialized and before the view is added to the container.

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

Occurs after the plug-in is closed and before the view is removed from the container.

### 2. Register the plug-in

To register the plug-in in the Agora Classroom SDK, call `AgoraEduSDK.registerExtApp`.

The following sample code demonstrates how to register the countdown plug-in CountDownExtApp.

```java
AgoraEduSDK.registerExtApps(Arrays.asList(
   new AgoraExtAppConfiguration(
       // The plug-in ID. 
              CountDownExtApp.getAppIdentifier(),
       // The size of the plug-in container. 
              new ViewGroup.LayoutParams(
               ViewGroup.LayoutParams.WRAP_CONTENT,
               ViewGroup.LayoutParams.WRAP_CONTENT),
       // Inherits io.agora.extension.AgoraExtAppBase to implement the plug-in 
              CountDownExtApp.class,
       // The language of the plug-in. 
              Locale.getDefault().getLanguage(),
       // The plug-in icon. 
              CountDownExtApp.getAppIconResource()),
   ......
));
```

### 3. Use the plug-in

By default, the registered plug-in is displayed in the whiteboard toolbar in the Flexible Classroom.

If you want to customize an entry for the plug-in in the flexible classroom, you can edit the `AgoraUI1v1Container.kt`, `AgoraUILargeClassContainer.kt`, and `AgoraUISmallClassContainer.kt` files under the `agoraui/src/main/kotlin/io/agora/uikit/impl/container` path. Then call the following methods when the user clicks on the plug-in icon.

```java
// Pass in the plug-in ID in the launchExtApp method. 
getEduContext()?.extAppContext()?.launchExtApp(CountDownExtApp.getAppIdentifier())
```
