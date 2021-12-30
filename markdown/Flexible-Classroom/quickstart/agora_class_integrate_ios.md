本文详细介绍如何将灵动课堂集成到你自己的 iOS 项目中。

## 技术原理

灵动课堂包含以下库：

- `AgoraClassroomSDK`: 胶水层，串联起 `AgoraEduContext`、`AgoraEduUI` 和 `AgoraEduCore`。`AgoraClassroomSDK` 在 GitHub 与 CocoaPods 上开源发布。
- `AgoraEduUI`: 提供灵动课堂交互层的代码，并包含交互层所使用的文案信息和资源文件。`AgoraEduCore` 通过 `AgoraEduContext` 为该层提供灵动课堂中的能力与数据。`AgoraEduUI` 在 GitHub 与 CocoaPods 上开源发布。
- `AgoraEduContext`: 定义了 Context Protocol 和数据结构。`AgoraEduContext` 在 GitHub 与 CocoaPods 上开源发布。
- `AgoraEduCore`: 提供灵动课堂中的能力与数据，遵守 `AgoraEduContext` 中定义的协议。`AgoraEduCore` 闭源，以二进制包在 CocoaPods 上发布。
- `ExtApp` 和 `Widget`：包含界面与功能的独立插件，由 `AgoraClassroomSDK` 注入灵动课堂内。`ExtApp` 和 `Widget` 的区别在于，`ExtApp` 是完全独立的插件，仅能与 `AgoraEduCore` 通讯，不与灵动课堂内的其它 UI 组件通讯；而 `Widget` 与 `Widget` 之间，以及与 UI 层中的其他组件都能进行通讯。

下图展示了灵动课堂的架构。

![](https://web-cdn.agora.io/docs-files/1631954134292)

<a name="default_ui"></a>

## 使用灵动课堂的默认 UI

如果你使用灵动课堂的默认 UI，在你的项目的 `Podfile` 文件中添加如下引用集成完整的灵动课堂：

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
spec.dependency "AgoraWidgets", '>= 2.0.1'
spec.dependency "ChatWidget", '>= 2.0.0'
spec.dependency "AgoraExtApps", '>= 2.0.0'</div>
```

<a name="custom_ui"></a>

## 不使用灵动课堂的默认 UI

如果你不需要使用灵动课堂的默认 UI，则无需集成 `AgoraClassroomSDK` 与 `AgoraEduUI` 库，只需要集成 `AgoraEduCore`。因此集成灵动课堂时，仅需在你的项目的 Podfile 文件中添加如下引用：

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

## 修改灵动课堂的默认 UI

如果你想要修改灵动课堂的默认 UI，则参考以下步骤集成灵动课堂：

1. 将 CloudClass-iOS 和 apaas-extapp-ios 仓库克隆至本地：

   ```bash
   git clone https://github.com/AgoraIO-Community/CloudClass-iOS.git
   git clone https://github.com/AgoraIO-Community/apaas-extapp-ios.git
   ```

2. 通过 `git remote add <shortname> <url>` 命令为 CloudClass-iOS 和 apaas-extapp-ios 仓库添加远端仓库，指向你的项目仓库。

3. 基于最新的发版分支创建一个你自己的分支，推向你的项目仓库。

   <div class="alert info">你可在<a href="/cn/agora-class/release_agora_class_ios?platform=iOS">发版说明</a>中查看最新版本号 x.y.z，发版分支为 release/apaas/x.y.z。</div>

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