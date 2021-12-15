本文详细介绍如何将灵动课堂集成到你自己的 iOS 项目中。

## 技术原理

灵动课堂可分为以下库：

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
# Open-source libs
pod 'AgoraClassroomSDK_iOS', "1.1.5.3"
pod 'AgoraEduContext', "1.1.5.1"
pod 'AgoraEduUI', "1.1.5.2"
pod 'AgoraUIEduBaseViews', "1.1.5.2"

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

<a name="custom_ui"></a>

## 不使用灵动课堂的默认 UI

如果你不需要使用灵动课堂的默认 UI，则无需集成 `AgoraEduUI `库，因此集成灵动课堂时，仅需在你的项目的 Podfile 文件中添加如下引用：

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

## 修改灵动课堂的默认 UI

如果你想要修改灵动课堂的默认 UI，则参考以下步骤集成灵动课堂：

1. 将 CloudClass-iOS 仓库克隆至本地：

   ```bash
   git clone https://github.com/AgoraIO-Community/CloudClass-iOS
   ```

2. 通过 `git remote add <shortname> <url>` 命令为 CloudClass-iOS 仓库添加一个远端仓库，指向你的项目仓库。

3. 基于最新的发版分支创建一个你自己的分支，推向你的项目仓库。

<div class="alert info">你可在<a href="/cn/agora-class/release_agora_class_ios?platform=iOS">发版说明</a>中查看最新版本号 x.y.z，发版分支为 release/apaas/x.y.z。</div>

4. 在你的项目的 `Podfile` 文件中添加如下代码引用 CloudClass-iOS 仓库中的 `AgoraClassroomSDK.podspec`、`AgoraEduContext.podspec`、`AgoraEduUI.podspec`、`AgoraUIEduBaseViews.podspec` 以及其它依赖的库。

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

## 更多信息

### 第三方库说明

灵动课堂中依赖于以下第三方库，你可以自行修改第三方库的版本号，但可能产生兼容性问题。

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
