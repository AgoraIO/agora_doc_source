## Overview

扩展应用 ExtApp 能够帮助开发者实现一个自定义插件并嵌入灵动课堂内，例如倒计时、骰子等。 你可以将通过 ExtApp 实现的插件理解为一个相对独立的 App，有自己的生命周期和数据管理，但是又依赖于 Agora Classroom SDK。 开发者可以自定义插件的 UI，传递自定义数据和监听数据变化。

The source code of ExtApp is in the `extapp` directory in the [CloudClass-Android](https://github.com/AgoraIO-Community/CloudClass-Android) repository on GitHub.

下文介绍通过扩展应用 ExtApp 实现自定义插件并在灵动课堂内嵌入该插件的基本步骤。

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

如果你想要为该插件自定义一个入口，你可修改 `agoraui/src/main/kotlin/io/agora/uikit/impl/container` 路径下 `AgoraUI1v1Container.kt`、`AgoraUILargeClassContainer.kt` 和 `AgoraUISmallClassContainer.kt` 文件，在灵动课堂中为该插件添加一个入口，然后在点击或者显示该插件时调用以下方法即可。

```java
// Pass in the plug-in ID in the launchExtApp method. 
getEduContext()?.extAppContext()?.launchExtApp(CountDownExtApp.getAppIdentifier())
```
