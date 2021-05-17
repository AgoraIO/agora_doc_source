## Overview

ExtApp is a tool for embedding plug-ins in Flexible Classroom. Plug-ins implemented by ExtApp can be regarded as an independent application with its own life cycle and data management, but they also depend on the Agora Classroom SDK. You can customize the user interfaces of the plug-in, pass custom data to the Agora Classroom SDK, and monitor data changes through ExtApp. ExtApp enables you to embed custom plug-ins, such as a countdown tool or a dice in the  Flexible Classroom.

The source code of ExtApp is located in the [AgoraExtApp` directory in `the CloudClass-iOS](https://github.com/AgoraIO-Community/CloudClass-iOS) repository on GitHub.

This page describes the procedure of using ExtApp to embed a custom plug-in in the Flexible Classroom.

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
// The plug-in ID. 
// Inherit the AgoraBaseExtApp class to implement a custom plug-in. 
// frame: 插件容器的大小，代表距离底层视图的间距。 底层视图由 Classroom SDK 生成（不包含安全区域）。 
// The plug-in language. 
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

If you want to customize an entry for the plug-in in the flexible classroom, you can edit the source code of the UI components and call the following methods when the user clicks on the plug-in icon.

```java
// Pass in the plug-in ID in the willLaunchExtApp method. 
extAppContext?.willLaunchExtApp(appIdentifier)
```
