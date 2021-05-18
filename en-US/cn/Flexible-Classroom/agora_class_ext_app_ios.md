## Overview

扩展应用 ExtApp 能够帮助开发者实现一个自定义插件并嵌入灵动课堂内，例如倒计时、骰子等。 你可以将通过 ExtApp 实现的插件理解为一个相对独立的 App，有自己的生命周期和数据管理，但是又依赖于 Agora Classroom SDK。 开发者可以自定义插件的 UI，传递自定义数据和监听数据变化。

The source code of ExtApp is located in the [AgoraExtApp` directory in `the CloudClass-iOS](https://github.com/AgoraIO-Community/CloudClass-iOS) repository on GitHub.

下文介绍通过扩展应用 ExtApp 实现自定义插件并在灵动课堂内嵌入该插件的基本步骤。

## Procedure

### 1. Implement a plug-in

First, inherit the `AgoraBaseExtApp class` to implement a custom plug-in in your app.

`AgoraExtAppBase` includes the following methods and callbacks:

#### Method

**initWithAppIdentifier**

```swift
(instancetype)initWithAppIdentifier:(NSString *)appIdentifier
                      localUserInfo:(AgoraExtAppUserInfo *)userInfo
                           roomInfo:(AgoraExtAppRoomInfo *)roomInfo
                         properties:(NSDictionary *)properties;
```

Initialize the plugin.

**updateProperties**

```swift
(void)updateProperties:(NSDictionary *)properties
               success:(AgoraExtAppCompletion)success
                  fail:(AgoraExtAppErrorCompletion)fail;
```

Update properties. Other plug-ins receive the `propertiesDidUpdate` callback to get the new properties.

**deleteProperties**

```swift
(void)deleteProperties:(NSArray <NSString *> *)keys
               success:(AgoraExtAppCompletion)success
                  fail:(AgoraExtAppErrorCompletion)fail;
```

Delete properties. Other plug-ins receive the `propertiesDidUpdate` callback to get the new properties.

**unload**

```swift
(void)unload;
```

Remove the plug-in. A successful method call triggers the `onExtAppUnloaded` callback.

#### Callback

**propertiesDidUpdate**

```swift
(void)propertiesDidUpdate:(NSDictionary *)properties;
```

Occurs when the properties have been updated.

**extAppDidLoad**

```swift
(void)extAppDidLoad:(AgoraExtAppContext *)context;
```

Occurs when the plug-in has been loaded. You can initialize the plug-in in this callback.

**extAppWillUnload**

```swift
(void)extAppWillUnload;
```

Occurs before the plug-in is unloaded. You can perform operations such as data backup in this callback.

### 2. Register the plug-in

To register the plug-in in the Agora Classroom SDK, call `AgoraEduSDK.registerExtApps`.

The following sample code demonstrates how to register the countdown plug-in CountDownExtApp.

```swift
// appIdentifier: 插件 ID，不同平台的相同插件必须使用同一 ID。 
// Inherit the AgoraBaseExtApp class to implement a custom plug-in. 
// frame: 插件容器的大小，代表距离底层视图的间距。 底层视图由 Agora Classroom SDK 生成（不包含安全区域）。 
// language: 容器语言，Agora Classroom SDK 会透传该变量到具体插件容器中，这样容器可以自己设置多语言。 
let countDown = AgoraExtAppConfiguration(appIdentifier: "io.agora.countdown",
                                         extAppClass: CountDownExtApp.self,
                                         frame: UIEdgeInsets(top: 10,
                                                            left: 50,
                                                          bottom: 10,
                                                           right: 50),
                                                        language: "zh")


// The plug-in icon. 
countDown.image = image
countDown.selectedImage = selectedImage
let apps = [countDown]
AgoraEduSDK.registerExtApps(apps)
```

### 3. Use the plug-in

By default, the registered plug-in is displayed in the whiteboard toolbar in the Flexible Classroom.

如果你想要为该插件自定义一个入口，你可修改 UIKit 模块的相应文件，在灵动课堂中为该插件添加一个入口，然后在点击或者显示该插件时调用以下方法即可。

```java
// Pass in the plug-in ID in the willLaunchExtApp method. 
extAppContext?.willLaunchExtApp(appIdentifier)
```
