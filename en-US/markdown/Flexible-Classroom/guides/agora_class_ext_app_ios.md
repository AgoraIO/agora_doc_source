## Overview

ExtApp enables developers to develop a custom plugin, such as a countdown plugin or a dice, and embed the plugin in the flexible classroom. Plugins implemented by ExtApp can be regarded as an independent application with its own life cycle and data management, but they also connect with the Agora Classroom SDK. Developers can customize the user interfaces of the plugins, pass custom data to the Agora Classroom SDK, and also listen for data change from the Agora Classroom SDK. 

The source code of ExtApp is located in the [AgoraExtApp` directory in `the CloudClass-iOS](https://github.com/AgoraIO-Community/CloudClass-iOS) repository on GitHub.

This page introduces the procedure of using ExtApp to develop and embed a custom plugin in the flexible classroom.

## Procedure

### 1. Implement a plugin

First, inherit the `AgoraBaseExtApp class` to implement a custom plugin in your app.

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

Update properties. Other plugins receive the `propertiesDidUpdate` callback to get the new properties.

**deleteProperties**

```swift
(void)deleteProperties:(NSArray <NSString *> *)keys
               success:(AgoraExtAppCompletion)success
                  fail:(AgoraExtAppErrorCompletion)fail;
```

Delete properties. Other plugins receive the `propertiesDidUpdate` callback to get the new properties.

**unload**

```swift
(void)unload;
```

Remove the plugin. A successful method call triggers the `onExtAppUnloaded` callback.

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

Occurs when the plugin has been loaded. You can initialize the plugin in this callback.

**extAppWillUnload**

```swift
(void)extAppWillUnload;
```

Occurs before the plugin is unloaded. You can perform operations such as data backup in this callback.

### 2. Register the plugin to the Agora Classroom SDK

To register the plugin in the Agora Classroom SDK, call `AgoraEduSDK.registerExtApps`.

The following sample code demonstrates how to register the countdown plugin CountDownExtApp.

```swift
// appIdentifier: The plugin ID. Different clients must use the same ID for the same plugin. 
// extAppClass: Inherit the AgoraBaseExtApp class to implement a custom plugin. 
// frame: The size of the plugin container. 
// language: The language of the container.

let countDown = AgoraExtAppConfiguration(appIdentifier: "io.agora.countdown",
                                         extAppClass: CountDownExtApp.self,
                                         frame: UIEdgeInsets(top: 10,
                                                            left: 50,
                                                          bottom: 10,
                                                           right: 50),
                                                        language: "zh")


// The plugin icon. 
countDown.image = image
countDown.selectedImage = selectedImage
let apps = [countDown]
AgoraEduSDK.registerExtApps(apps)
```

### 3. Use the plugin in the flexible classroom

By default, the icon of the registered plugin is displayed in the whiteboard toolbar in the flexible classroom.

If you want to customize an entry for the plugin in the flexible classroom, you can edit the source code of the UI components and call the following methods when the user clicks on the plugin icon.

```java
// Pass in the plugin ID in the willLaunchExtApp method. 
extAppContext?.willLaunchExtApp(appIdentifier)
```
