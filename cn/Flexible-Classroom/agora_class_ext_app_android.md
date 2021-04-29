本页介绍如何通过 ExtApp 来在灵动课堂内嵌入自定义插件，例如倒计时。

## 工作原理

ExtApp 是对灵动课堂 UIKit 的补充，能够帮助开发者在不修改 UIKit 代码的前提下，在灵动课堂内嵌入自己实现的插件，例如倒计时等。开发者需要在自己的 App 中实现一个自定义插件，然后调用 API 将该插件注册到 Agora Classroom SDK 中，最后在灵动课堂中启用该插件。

ExtApp 的源码位于 GitHub 上 [CloudClass-Android](https://github.com/AgoraIO-Community/CloudClass-Android) 仓库（dev/apaas/1.1.0 分支）中 `extapp` 目录下。

## 操作步骤

### 1. 实现插件

首先，你需要继承 [`io.agora.extension.AgoraExtAppBase`]() 类，在你的 App 中实现一个自定义插件。

### 2. 注册插件

调用 `AgoraEduSDK.registerExtApp` 方法，将该插件注册到 Agora Classroom SDK 中。

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
       // 插件实现的 class，继承 io.agora.extension.AgoraExtAppBase，例如倒计时插件。
       CountDownExtApp.class,
       // 插件语言类型。
       Locale.getDefault().getLanguage(),
       // 插件图标，会在工具栏的 ToolBox 弹窗里显示。
       CountDownExtApp.getAppIconResource()),
   ......
));
```

### 3. 启动插件

默认情况下，成功注册的插件会显示在灵动课堂工具栏的 ToolBox 弹窗里显示。

如果你想要为该插件自定义一个入口，你可修改 `agoraui/src/main/kotlin/io/agora/uikit/impl/container` 路径下 `AgoraUI1v1Container.kt`、`AgoraUILargeClassContainer.kt` 和 `AgoraUISmallClassContainer.kt` 文件，在灵动课堂三大场景中为该插件添加一个入口，然后在点击或者显示该插件时调用以下方法即可。

```java
// 在 launchExtApp 方法中传入插件 ID。
getEduContext()?.extAppContext()?.launchExtApp(CountDownExtApp.getAppIdentifier())
```