## 概览

扩展应用 ExtApp 能够帮助开发者实现一个自定义插件并嵌入灵动课堂内，例如倒计时、骰子等。你可以将通过 ExtApp 实现的插件理解为一个相对独立的 App，有自己的生命周期和数据管理，但是又依赖于 Agora Classroom SDK。开发者可以自定义插件的 UI，传递自定义数据和监听数据变化。

ExtApp 的源码位于 GitHub 上 [CloudClass-iOS](https://github.com/AgoraIO-Community/CloudClass-iOS) 仓库中 `AgoraExtApp` 目录下。

下文介绍通过扩展应用 ExtApp 实现自定义插件并在灵动课堂内嵌入该插件的基本步骤。

## 操作步骤

### 1. 实现插件

首先，你需要继承 `AgoraBaseExtApp` 类，在你的 App 中实现一个自定义插件。

`AgoraExtAppBase` 类中的方法和回调介绍如下：

#### 方法

**initWithAppIdentifier**

```swift
(instancetype)initWithAppIdentifier:(NSString *)appIdentifier
                      localUserInfo:(AgoraExtAppUserInfo *)userInfo
                           roomInfo:(AgoraExtAppRoomInfo *)roomInfo
                         properties:(NSDictionary *)properties;
```

初始化插件。

**updateProperties**

```swift
(void)updateProperties:(NSDictionary *)properties
               success:(AgoraExtAppCompletion)success
                  fail:(AgoraExtAppErrorCompletion)fail;
```

更新属性。其他插件会通过 `propertiesDidUpdate` 收到更新后的属性信息。

**deleteProperties**

```swift
(void)deleteProperties:(NSArray <NSString *> *)keys
               success:(AgoraExtAppCompletion)success
                  fail:(AgoraExtAppErrorCompletion)fail;
```

删除属性。其他插件会通过 `propertiesDidUpdate` 收到删除后的属性信息。

**unload**

```swift
(void)unload;
```

移除插件。成功调用该方法后将触发 `onExtAppUnloaded` 回调。

#### 回调

**propertiesDidUpdate**

```swift
(void)propertiesDidUpdate:(NSDictionary *)properties;
```

属性已更新。

**extAppDidLoad**

```swift
(void)extAppDidLoad:(AgoraExtAppContext *)context;
```

插件已经加载。你可以在该回调中初始化。

**extAppWillUnload**

```swift
(void)extAppWillUnload;
```

插件将被卸载。你可以在该回调中进行数据备份等操作。

### 2. 注册插件

调用 `AgoraEduSDK.registerExtApps` 方法，将该插件注册到 Agora Classroom SDK 中。

以下示例代码演示了如何注册一个倒计时插件 CountDownExtApp。

```swift
// appIdentifier: 插件 ID，不同平台的相同插件必须使用同一 ID。
// extAppClass: 容器 App Class Type, 由 SDK 创建该类的实例。
// frame: 插件容器的大小。
// language: 容器语言。
let countDown = AgoraExtAppConfiguration(appIdentifier: "io.agora.countdown",
                                         extAppClass: CountDownExtApp.self,
                                         frame: UIEdgeInsets(top: 10,
                                                            left: 50,
                                                          bottom: 10,
                                                           right: 50),
                                                        language: "zh")


// 插件图标，用于在 UIKit 层设置，默认会在白板工具栏的工具箱弹窗里显示。
countDown.image = image
countDown.selectedImage = selectedImage
let apps = [countDown]
AgoraEduSDK.registerExtApps(apps)
```

### 3. 启动插件

默认情况下，成功注册的插件会显示在灵动课堂白板工具栏的工具箱弹窗里显示。

如果你想要为该插件自定义一个入口，你可修改 UIKit 模块的相应文件，在灵动课堂中为该插件添加一个入口，然后在点击或者显示该插件时调用以下方法即可。

```java
// 在 willLaunchExtApp 方法中传入插件 ID。
extAppContext?.willLaunchExtApp(appIdentifier)
```
