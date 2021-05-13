## Overview

Extended application ExtApp is a supplementary plug-in for  Flexible Classroom. You can understand ExtApp as a relatively independent App with its own life cycle and data management, but it also depends on the Agora Classroom SDK. You can customize the UI of the plug-in through ExtApp, pass custom data and monitor data changes, and embed custom plug-ins, such as countdown, dice, etc., in the  Flexible Classroom.

The source code of ExtApp is located in the extapp directory in the [CloudClass-Android](https://github.com/AgoraIO-Community/CloudClass-Android) repository on `GitHub`.

The following describes the basic steps of embedding custom plug-ins in Smart Classroom by extending ExtApp.

## Implement real-time messaging

### 1. Implement the plug-in

First, you need to extend the `io.agora.extension.AgoraExtAppBase` class to implement a custom plug-in in your App.

The methods and callbacks in the` AgoraExtAppBase` class are introduced as follows:

#### Method

**updateProperties**

```kotlin
fun updateProperties(properties: MutableMap<String, Any?>,
                     cause: MutableMap<String, Any?>,
                     callback: AgoraExtAppCallback<String>? = null)
```

Update attributes. Other plug-ins will` receive updated property information through onPropertyUpdated`.

| Parameter | Description |
| ------------ | --------------------------------------------- |
| `properties` | Property Map. |
| `cause` | Update reason Map. |
| `callback` | Asynchronously` obtain whether it is successful through AgoraExtAppCallback`. |

**deleteProperties**

```kotlin
fun deleteProperties(propertyKeys: MutableList<String>,
                     cause: MutableMap<String, Any?>,
                     callback: AgoraExtAppCallback<String>?)
```

Delete attributes. Other plug-ins will` receive the deleted property information through onPropertyUpdated`.

| Parameter | Description |
| ------------ | --------------------------------------------- |
| `properties` | Property Map. |
| `cause` | Update reason Map. |
| `callback` | Asynchronously` obtain whether it is successful through AgoraExtAppCallback`. |

**unload**

```kotlin
fun unload()
```

Remove the plug-in. After successfully calling this method, the `onExtAppUnloaded `callback will be triggered.

**getLocalUserInfo**

```kotlin
fun getLocalUserInfo(): AgoraExtAppUserInfo?
```

Get current user information.

**getRoomInfo**

```kotlin
fun getRoomInfo (): AgoraExtAppRoomInfo?
```

Get current room information.

**getProperties**

```kotlin
fun getProperties(): MutableMap<String, Any?>?
```

Get the current latest attribute list.

#### Callback

**onExtAppLoaded**

```kotlin
fun onExtAppLoaded(context: Context)
```

This callback is triggered before the View is added to the container after the plugin is initialized.

| Parameter | Description |
| --------- | ---------------- |
| `context` | Android context. |

**onCreateView**

```kotlin
fun onCreateView(content: Context): View
```

The view added to the container has been created.

```kotlin
fun onPropertyUpdated(properties: MutableMap<String, Any>?, cause: MutableMap<String, Any?>?)
```

The properties of the container have been updated.

| Parameter | Description |
| ------------ | --------------------------------------------- |
| `properties` | Property Map. |
| `cause` | Update reason Map. |
| `callback` | Asynchronously` obtain whether it is successful through AgoraExtAppCallback`. |

**onExtAppUnloaded**

```kotlin
fun onExtAppUnloaded()
```

Triggered after the plug-in is closed and before the View is removed from the container.

### 2. Register the plugin

Call the `Agora method to register the plug`-in to the Agora Classroom SDK.

The following sample code demonstrates how to register a countdown plug-in CountDownExtApp.

```java
AgoraEduSDK.registerExtApps(Arrays.asList(
   new AgoraExtAppConfiguration(
       // Plug-in ID, which will be used when starting the plug-in later. 
       CountDownExtApp.getAppIdentifier(),
       // The size of the plug-in container, the position of the container can be set by specifying the margin. 
       new ViewGroup.LayoutParams(
               ViewGroup.LayoutParams.WRAP_CONTENT,
               ViewGroup.LayoutParams.WRAP_CONTENT),
       // The class implemented by the plug-in inherits io.agora.extension.AgoraExtAppBase. 
       CountDownExtApp.class,
       // Plug-in language type. 
       Locale.getDefault () .getLanguage (),
       // The plug-in icon will be displayed in the ToolBox pop-up window of the toolbar. 
       CountDownExtApp.getAppIconResource()),
   ......
));
```

### 3. Start the plugin

By default, successfully registered plug-ins will be displayed in the ToolBox pop-up window of the  Flexible Classroom toolbar.

If you want to customize an entry for the plug-in, you can modify the `Agora, AgoraUILargeClassContainer.kt` and ``AgoraUISmallClassContainer.kt ```files under `the Agora/src/main/kotlin/io/agora/uikit/impl/container path in the  Flexible Classroom Add an entry for the plug-in in the three major scenarios, and then call the following method when the plug-in is clicked or displayed.

```java
// Pass in the plug-in ID in the launchExtApp method. 
getEduContext()?.extAppContext()?.launchExtApp(CountDownExtApp.getAppIdentifier())
```
