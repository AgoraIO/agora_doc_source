## 概览

扩展应用 ExtApp 是灵动课堂的补充插件。你可以将 ExtApp 理解为一个相对独立的 App，有自己的生命周期和数据管理，但是又依赖于声网 Classroom SDK。你可以通过 ExtApp 自定义插件的 UI，传递自定义数据和监听数据变化，在灵动课堂内嵌入自定义插件，例如倒计时、骰子等。

ExtApp 的源码位于 GitHub 上 [CloudClass-Android](https://github.com/AgoraIO-Community/CloudClass-Android) 仓库中 `extapp` 目录下。

下文介绍通过扩展应用 ExtApp 来在灵动课堂内嵌入自定义插件的基本步骤。

## 操作步骤

### 1. 实现插件

首先，你需要继承 `io.agora.extension.AgoraExtAppBase` 类，在你的 App 中实现一个自定义插件。

`AgoraExtAppBase` 类中的方法和回调介绍如下：

#### 方法

**updateProperties**

```kotlin
fun updateProperties(properties: MutableMap<String, Any?>,
                     cause: MutableMap<String, Any?>,
                     callback: AgoraExtAppCallback<String>? = null)
```

更新属性。其他插件会通过 `onPropertyUpdated` 收到更新后的属性信息。

| 参数         | 描述                                          |
| ------------ | --------------------------------------------- |
| `properties` | 属性 Map。                                    |
| `cause`      | 更新原因 Map。                                |
| `callback`   | 通过 `AgoraExtAppCallback` 异步获取是否成功。 |

**deleteProperties**

```kotlin
fun deleteProperties(propertyKeys: MutableList<String>,
                     cause: MutableMap<String, Any?>,
                     callback: AgoraExtAppCallback<String>?)
```

删除属性。其他插件会通过 `onPropertyUpdated` 收到删除后的属性信息。

| 参数         | 描述                                          |
| ------------ | --------------------------------------------- |
| `properties` | 属性 Map。                                    |
| `cause`      | 更新原因 Map。                                |
| `callback`   | 通过 `AgoraExtAppCallback` 异步获取是否成功。 |

**unload**

```kotlin
fun unload()
```

移除插件。成功调用该方法后将触发 `onExtAppUnloaded` 回调。

**getLocalUserInfo**

```kotlin
fun getLocalUserInfo(): AgoraExtAppUserInfo?
```

获取当前的用户信息。

**getRoomInfo**

```kotlin
fun getRoomInfo(): AgoraExtAppRoomInfo?
```

获取当前的房间信息。

**getProperties**

```kotlin
fun getProperties(): MutableMap<String, Any?>?
```

获取当前最新的属性列表。

#### 回调

**onExtAppLoaded**

```kotlin
fun onExtAppLoaded(context: Context)
```

该回调在插件初始化完后将 View 添加到容器之前触发。

| 参数      | 描述             |
| --------- | ---------------- |
| `context` | Android 上下文。 |

**onCreateView**

```kotlin
fun onCreateView(content: Context): View
```

添加到容器的视图已创建。

```kotlin
fun onPropertyUpdated(properties: MutableMap<String, Any>?, cause: MutableMap<String, Any?>?)
```

容器的属性有更新。

| 参数         | 描述                                          |
| ------------ | --------------------------------------------- |
| `properties` | 属性 Map。                                    |
| `cause`      | 更新原因 Map。                                |
| `callback`   | 通过 `AgoraExtAppCallback` 异步获取是否成功。 |

**onExtAppUnloaded**

```kotlin
fun onExtAppUnloaded()
```

插件被关闭后、View 从容器移除之前触发。

### 2. 注册插件

调用 `AgoraEduSDK.registerExtApp` 方法，将该插件注册到声网 Classroom SDK 中。

以下示例代码演示了如何注册一个倒计时插件 CountDownExtApp。

```java
AgoraEduSDK.registerExtApps(Arrays.asList(
   new AgoraExtAppConfiguration(
       // 插件 ID，后续启动插件时会用到。
       CountDownExtApp.getAppIdentifier(),
       // 插件容器的大小，可以通过指定 margin 来设置容器的位置。
       new ViewGroup.LayoutParams(
               ViewGroup.LayoutParams.WRAP_CONTENT,
               ViewGroup.LayoutParams.WRAP_CONTENT),
       // 插件实现的 class，继承 io.agora.extension.AgoraExtAppBase。
       CountDownExtApp.class,
       // 插件语言类型。
       Locale.getDefault().getLanguage(),
       // 插件图标，会在工具栏的 ToolBox 弹窗里显示。
       CountDownExtApp.getAppIconResource()),
   ......
));
```

### 3. 启动插件

默认情况下，成功注册的插件会显示在灵动课堂工具栏的 ToolBox 弹窗中显示。

如果你想要为该插件自定义一个入口，你可修改 `agoraui/src/main/kotlin/io/agora/uikit/impl/container` 路径下 `AgoraUI1v1Container.kt`、`AgoraUILargeClassContainer.kt` 和 `AgoraUISmallClassContainer.kt` 文件，在灵动课堂三大场景中为该插件添加一个入口，然后在点击或者显示该插件时调用以下方法即可。

```java
// 在 launchExtApp 方法中传入插件 ID。
getEduContext()?.extAppContext()?.launchExtApp(CountDownExtApp.getAppIdentifier())
```