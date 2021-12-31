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
# Third-party libs
pod 'OpenSSL-Universal', '1.0.2.17'
pod 'Protobuf', '3.17.0'
pod "CocoaLumberjack", '3.6.1'
pod 'AliyunOSSiOS',  '2.10.8'
pod 'Armin',  '1.0.9'
pod 'Alamofire', '4.7.3'
pod 'SSZipArchive', '2.4.2'
pod 'SwifterSwift', '5.2.0'
pod 'Masonry'
pod 'SDWebImage', '5.12.0'

# Agora libs
pod 'AgoraRtm_iOS', '1.4.8'
pod 'Whiteboard', '2.15.8'
pod 'AgoraRtcEngine_iOS', '3.4.6'
pod 'HyphenateChat', '3.8.6'

# Open-source libs
pod 'AgoraClassroomSDK_iOS', '2.0.0'
```

请注意，在 `AgoraClassroomSDK_iOS` 库的 `podspec` 中，依赖以下库并指定了最低版本：

```
# Open-source libs
spec.dependency "AgoraEduUI", '2.0.0'
spec.dependency "AgoraEduContext", '2.0.0'

# Closed-source libs
spec.dependency "AgoraEduCore", '2.0.1'

# Open-source widgets and extApps
spec.dependency "AgoraWidgets", '>= 2.0.0'
spec.dependency "ChatWidget", '>= 2.0.0'
spec.dependency "AgoraExtApps", '>= 2.0.0'
```

<a name="custom_ui"></a>

### Do not use the default UI of Flexible Classroom

如果你不需要使用灵动课堂的默认 UI，则无需集成 `AgoraClassroomSDK` 与 `AgoraEduUI` 库，只需要集成 `AgoraEduCore`。 因此集成灵动课堂时，仅需在你的项目的 Podfile 文件中添加如下引用：

```
# Closed-source libs
pod 'AgoraEduCore', '2.0.1'

# Agora libs
pod 'AgoraRtm_iOS', '1.4.8'
pod 'Whiteboard', '2.15.8'
pod 'AgoraRtcEngine_iOS', '3.4.6'
pod 'HyphenateChat', '3.8.6'

# Third-party libs
pod 'OpenSSL-Universal', '1.0.2.17'
pod 'Protobuf', '3.17.0'
pod "CocoaLumberjack", '3.6.1'
pod 'AliyunOSSiOS',  '2.10.8'
pod 'Armin',  '1.0.9'
pod 'Alamofire', '4.7.3'
pod 'SSZipArchive', '2.4.2'
pod 'SwifterSwift', '5.2.0'
pod 'Masonry'
pod 'SDWebImage', '5.12.0'
```

请注意，在 `AgoraEduCore` 库的 `podspec` 中，依赖如下库并指定了最低版本：

```
# Common libs
spec.dependency "AgoraExtApp", '2.0.0'
spec.dependency "AgoraWidget", '2.0.1'

# Open-source libs
spec.dependency "AgoraEduContext", '2.0.0'
```

<a name="change_default_ui"></a>

### Customize the default UI of Flexible Classroom

If you want to customize the default UI of Flexible Classroom, integrate Flexible Classroom as follows:

1. 将 CloudClass-iOS 和 apaas-extapp-ios 仓库克隆至本地：

   ```bash
   git clone https://github.com/AgoraIO-Community/CloudClass-iOS.git
   git clone https://github.com/AgoraIO-Community/apaas-extapp-ios.git
   ```

2. Use the` git remote add <shortname> <url>` command to add a remote repository to the local CloudClass-iOS repository, pointing to your project.

3. Create a new branch based on the latest release branch of Flexible Classroom and push it to your project.

<div class="alert info">Get the version number x.y.z in the release<a href="/cn/agora-class/release_agora_class_ios?platform=iOS"> notes</a>, and the release branch is named as release/apaas/x.y.z.</div>

4. 在你的项目的 `Podfile` 文件中添加如下代码引用 CloudClass-iOS 仓库中的 `AgoraClassroomSDK_iOS.podspec`、`AgoraEduContext.podspec`、`AgoraEduUI.podspec`、apaas-extapp-ios 仓库中的 `AgoraWidgets.podspec`，`ChatWidget.podspec`，`AgoraExtApps.podspec` 以及其它依赖的库。

   ```
   # Third-party libs
   pod 'OpenSSL-Universal', '1.0.2.17'
   pod 'Protobuf', '3.17.0'
   pod "CocoaLumberjack", '3.6.1'
   pod 'AliyunOSSiOS',  '2.10.8'
   pod 'Armin',  '1.0.9'
   pod 'Alamofire', '4.7.3'
   pod 'SSZipArchive', '2.4.2'
   pod 'SwifterSwift', '5.2.0'
   pod 'Masonry'
   pod 'SDWebImage', '5.12.0'

   # Agora libs
   pod 'AgoraRtm_iOS', '1.4.8'
   pod 'Whiteboard', '2.15.8'
   pod 'AgoraRtcEngine_iOS', '3.4.6'
   pod 'HyphenateChat', '3.8.6'

   # Open-source libs
   pod 'AgoraClassroomSDK_iOS', :path => 'CloudClass-iOS/SDKs/AgoraClassroomSDK/AgoraClassroomSDK_iOS.podspec'
   pod 'AgoraEduContext', :path => 'CloudClass-iOS/SDKs/AgoraEduContext/AgoraEduContext.podspec'
   pod 'AgoraEduUI', :path => 'CloudClass-iOS/SDKs/AgoraEduUI/AgoraEduUI.podspec'

   # Open-sources widgets and extApps
   pod 'AgoraWidgets', :path => 'apaas-extapp-ios/Widgets/AgoraWidgets/AgoraWidgets.podspec'
   pod 'ChatWidget', :path => 'apaas-extapp-ios/Widgets/ChatWidget/ChatWidget.podspec'
   pod 'AgoraExtApps', :path => 'apaas-extapp-ios/ExtApps/AgoraExtApps.podspec'

   # Closed-source libs
   pod 'AgoraEduCore', '2.0.1'
   ```
