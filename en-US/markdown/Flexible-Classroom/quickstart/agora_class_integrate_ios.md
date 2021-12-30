This page introduces how to add Flexible Classroom into your iOS app.

## Understand the tech

Flexible Classroom contains the following libraries:

- `AgoraClassroomSDK`: The glue code that connects `AgoraEduContext`, `AgoraEduUI` and `AgoraEduCore`. `AgoraClassroomSDK` is an open-sourced project and released on GitHub and CocoaPods.
- `AgoraEduUI`: This library contains the code for the UI and also includes all the texts and resource files used by Flexible Classroom. `AgoraEduCore` 通过 `AgoraEduContext` 为该层提供灵动课堂中的能力与数据。 `AgoraEduUI` is an open-sourced project and released on GitHub and CocoaPods.
- `AgoraEduContext`: This library defines context protocols and data structure. `AgoraEduContext` is an open-sourced project and released on GitHub and CocoaPods.
- `AgoraEduCore`: This library provides the capabilities and data in Flexible Classroom, and follows the protocols defined in ` AgoraEduContext`. `AgoraEduCore` is a closed-source library and released on CocoaPods as a binary package.
- `ExtApp` and `Widget`: These libraries are independent plugins that include both interfaces and functions. They are injected into Flexible Classroom by `AgoraClassroomSDK`. The difference between `ExtApp` and `Widget` is: `ExtApp` can only communicate with `AgoraEduCore` and does not communicate with other UI components in Flexible Classroom; while `Widget` can communicate with other `Widget` and UI components.

The following figure shows the structure of Flexible Classroom.

![](https://web-cdn.agora.io/docs-files/1624525178299)

## 集成方式

根据你的实际需求选择集成方式。

<div class="alert info">如果你的工程为 OC 工程，需要在 Build Settings 中 Add User-Defined Setting，Key 设为 SWIFT_VERSION，Value 设为你指定的 Swift 版本。</div>

<a name="default_ui"></a>

### Use the default UI of Flexible Classroom

If you use the default UI of Flexible Classroom, to integrate the complete Flexible Classroom in your project, add the following dependencies in your project’s `Podfile`:

```
# Open-source libs
pod 'AgoraClassroomSDK_iOS', "1.1.5.3"
pod 'AgoraEduContext', "1.1.5.1"
pod 'AgoraEduUI', "1.1.5.2"
pod 'AgoraUIEduBaseViews', "1.1.5.2"

# Closed-source libs
<<<<<<< Updated upstream
pod 'AgoraEduCore', "1.1.5.7"

# Common libs
pod 'AgoraUIBaseViews', '1.0.1'
pod 'AgoraExtApp', '1.0.0'
pod 'AgoraWidget', '1.0.0'

# Widgets
pod 'AgoraWidgets', "1.0.1"

# Third-party libs
pod 'Protobuf', '3.17.0'
pod "AFNetworking", "4.0.1"
pod "CocoaLumberjack", "3.6.1"
pod "AliyunOSSiOS", "2.10.8"
pod "Whiteboard", "2.13.19"
pod "AgoraRtcEngine_iOS", "3.4.6"
pod "AgoraRtm_iOS", "1.4.8"
=======
spec.dependency "AgoraEduCore", '2.0.1'

# Open-source widgets and extApps
spec.dependency "AgoraWidgets", '>= 2.0.0'
spec.dependency "ChatWidget", '>= 2.0.0'
spec.dependency "AgoraExtApps", '>= 2.0.0'</div>
>>>>>>> Stashed changes
```

<a name="custom_ui"></a>

### Do not use the default UI of Flexible Classroom

If you do not want to use the default UI of Flexible Classroom, you do not need the `AgoraEduUI` library. Therefore, to integrate Flexible Classroom, you only need to add the following dependencies in your project's Podfile file:

```
# Open-source libs
pod 'AgoraEduContext', "1.1.5.1"

# Closed-source libs
pod 'AgoraEduCore', "1.1.5.7"

# Common libs
pod 'AgoraUIBaseViews', '1.0.1'
pod 'AgoraExtApp', '1.0.0'
pod 'AgoraWidget', '1.0.0'

# Widgets
pod 'AgoraWidgets', "1.0.1"

# Third-party libs
pod 'Protobuf', '3.17.0'
pod "AFNetworking", "4.0.1"
pod "CocoaLumberjack", "3.6.1"
pod "AliyunOSSiOS", "2.10.8"
pod "Whiteboard", "2.13.19"
pod "AgoraRtcEngine_iOS", "3.4.6"
pod "AgoraRtm_iOS", "1.4.8"
```

<a name="change_default_ui"></a>

### Customize the default UI of Flexible Classroom

If you want to customize the default UI of Flexible Classroom, integrate Flexible Classroom as follows:

1. Clone the CloudClass-iOS repository to your local computer:

   ```bash
   git clone https://github.com/AgoraIO-Community/CloudClass-iOS
   ```

2. Use the `git remote add <shortname> <url>` command to add a remote repository to the local CloudClass-iOS repository, pointing to your project.

3. Create a new branch based on the latest release branch of Flexible Classroom and push it to your project.

<div class="alert info">Get the version number x.y.z in the release<a href="/cn/agora-class/release_agora_class_ios?platform=iOS"> notes</a>, and the release branch is named as release/apaas/x.y.z.</div>

4. Add the following code in your project's `Podfile` to link to `AgoraClassroomSDK.podspec`, `AgoraEduContext.podspec`, `AgoraEduUI.podspec`, `AgoraUIEduBaseViews.podspec` and other libraries in the CloudClass-iOS repository.

   ```
   # Open-source libs
   pod 'AgoraClassroomSDK_iOS', :path => '../SDKs/AgoraClassroomSDK/AgoraClassroomSDK_iOS.podspec'
   pod 'AgoraEduContext', :path => '../SDKs/AgoraEduContext/AgoraEduContext.podspec'
   pod 'AgoraEduUI', :path => '../SDKs/AgoraEduUI/AgoraEduUI.podspec'
   pod 'AgoraUIEduBaseViews', :path => '../SDKs/Modules/AgoraUIEduBaseViews/AgoraUIEduBaseViews_Local.podspec'

   # Closed-source libs
   pod 'AgoraEduCore', "1.1.5.7"

   # Common libs
   pod 'AgoraUIBaseViews', '1.0.1'
   pod 'AgoraExtApp', '1.0.0'
   pod 'AgoraWidget', '1.0.0'

   # Widgets
   pod 'AgoraWidgets', :path => '../Widgets/AgoraWidgets/AgoraWidgets.podspec'
   pod 'ChatWidget', :path => '../Widgets/ChatWidget/ChatWidget.podspec', :subspecs => ['SOURCE']

   # Third-party libs
   pod 'Protobuf', '3.17.0'
   pod "AFNetworking", "4.0.1"
   pod "CocoaLumberjack", "3.6.1"
   pod "AliyunOSSiOS", "2.10.8"
   pod "Whiteboard", "2.13.19"
   pod "AgoraRtcEngine_iOS", "3.4.6"
   pod "AgoraRtm_iOS", "1.4.8"
   ```

## See also

### 第三方库说明

Flexible Classroom depends on the following third-party libraries. You can change the version number of th third-party libraries, but compatibility issues may occur.

```
# Third-party libs
pod 'Protobuf', '3.17.0'
pod "AFNetworking", "4.0.1"
pod "CocoaLumberjack", "3.6.1"
pod "AliyunOSSiOS", "2.10.8"
pod "Whiteboard", "2.13.19"
pod "AgoraRtcEngine_iOS", "3.4.6"
pod "AgoraRtm_iOS", "1.4.8"
```

