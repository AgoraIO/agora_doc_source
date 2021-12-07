根据本文指导通过 Agora Classroom SDK 快速启动并体验灵动课堂。

## Understand the tech

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

<a name="prerequisites"></a>

## Prerequisites

- 已在 Agora 控制台创建 Agora 项目，获取 [Agora App ID](/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-id)、[App 证书](/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-%E8%AF%81%E4%B9%A6)并[配置 aPaaS 服务](/cn/agora-class/agora_class_prep?platform=Web)。
- Xcode 10.0 or later.
- CocoaPods 1.10 or later. 参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。
- iOS 10 or later.
- If you use Swift, use Swift 5.3.2 or later.
- A valid Agora account. (Sign up for free)
- A physical iOS device (iPhone or iPad). A physical Android device.

## Launches a flexible classroom.

参照以下步骤启动灵动课堂：

1. 运行以下命令将 Agora 提供的灵动课堂项目 CloudClass-iOS 克隆至本地：

   ```
   git clone https://github.com/AgoraIO-Community/CloudClass-iOS
   ```

2. 将 `keycenter.m` 文件中的 `Agora App ID` 和 `Agora App Certificate` 替换成[你的 App ID 和 App 证书](#prerequisites)。

   ```swift
   + (NSString *)appId {
       return <#Your Agora App Id#>;
   }

   + (NSString *)appCertificate {
       return <#Your Agora Certificate#>;
   }
   ```

   为方便你快速测试，CloudClass-iOS 项目中已包含一个临时 RTM Token 生成器，会用你传入的 App ID 和 App 证书生成一个临时 RTM Token。 但是在正式环境中，为确保安全，RTM Token 必须在服务端生成。

   你可在 `AgoraEducation/Main/Controllers/LoginViewController.swift` 文件中查看启动课堂的具体逻辑：

   1. 调用 [AgoraEduSDK.setConfig](/cn/agora-class/agora_class_api_ref_ios?platform=iOS#setconfig) 方法全局配置 SDK。
   2. 调用 [AgoraEduSDK.launch](/cn/agora-class/agora_class_api_ref_ios?platform=iOS#launch) 方法启动灵动课堂。

3. 连接上 iOS 设备后，用 Xcode 打开示例项目，然后编译并运行项目。

4. 输入房间名、用户名，选择一种班型，然后点击**加入**，即可进入灵动课堂，看到以下画面：

   ![](https://web-cdn.agora.io/docs-files/1620822526000)

## Additional

<a name="integrate"></a>

### Add Flexible Classroom into your app

本节详细介绍如何将灵动课堂集成到你自己的 iOS 项目中。

灵动课堂可分为 AgoraClassroomSDK、AgoraEduCore、AgoraEduUI、AgoraEduContext 四个 SDK，如下图所示。 AgoraClassroomSDK, AgoraEduUI, and AgoraEduContext are open-source libraries and released on Github and CocoaPods. AgoraEduCore is a closed-source library and released on CocoaPods as a binary package.

![](https://web-cdn.agora.io/docs-files/1620822526000)

<a name="default_ui"></a>

#### 使用灵动课堂的默认 UI

如果你无需修改灵动课堂的默认 UI，在你自己项目的 `Podfile` 文件中添加如下引用即可集成灵动课堂：

```
# Open source libs
pod 'AgoraClassroomSDK_iOS', "1.1.5.1"
pod 'AgoraEduContext', "1.1.5"
pod 'AgoraEduUI', "1.1.5"
pod 'AgoraUIEduBaseViews', "1.1.5"

# Close source libs
pod 'AgoraEduCore', "1.1.5.4"

# Common libs
pod 'AgoraUIBaseViews', '1.0.1'
pod 'AgoraExtApp', '1.0.0'
pod 'AgoraWidget', '1.0.0'

# Widgets
pod 'AgoraWidgets', "1.0.0"

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

#### Customizing the UI of classrooms

如果灵动课堂的默认 UI 无法满足你的需求，你需要自定义课堂 UI，则参考以下步骤将灵动课堂集成到你自己的项目中：

1. 运行以下命令将 CloudClass-iOS 仓库克隆至本地：

   ```bash
   git clone https://github.com/AgoraIO-Community/CloudClass-iOS
   ```

2. 通过 `git remote add` 命令， 为 CloudClass-iOS 仓库添加一个远端仓库，指向你自己项目的仓库。

3. 基于 release/apaas/1.1.5 分支创建一个你自己的分支，如 `edu_apaas_ui`，推向你自己项目的仓库。

4. 在你自己项目的 `Podfile` 文件中添加如下代码引用 CloudClass-iOS 仓库中的 `AgoraClassroomSDK.podspec`、`AgoraEduContext.podspec`、`AgoraEduUI.podspec`、`AgoraUIEduBaseViews.podspec` 以及其它依赖的库。

   ```
   # Open source libs
   pod 'AgoraClassroomSDK_iOS', :path => '../SDKs/AgoraClassroomSDK/AgoraClassroomSDK_iOS.podspec'
   pod 'AgoraEduContext', :path => '../SDKs/AgoraEduContext/AgoraEduContext.podspec'
   pod 'AgoraEduUI', :path => '../SDKs/AgoraEduUI/AgoraEduUI.podspec'
   pod 'AgoraUIEduBaseViews', :path => '../SDKs/Modules/AgoraUIEduBaseViews/AgoraUIEduBaseViews_Local.podspec'

   # Close source libs
   pod 'AgoraEduCore', "1.1.5.4"

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

5. 后续你可在 `edu_apaas_ui `分支，参考[自定义课堂 UI 文档](/cn/agora-class/agora_class_custom_ui_ios?platform=iOS)自行修改灵动课堂的 UI，如更换颜色、调整布局。

> As of v1.1.0,  the Agora Classroom SDK for iOS is developed in Swift. If your project uses Object-C, see the following steps to create a Swift file in the project to generate the Swift environment.
>
> 1. Open the `ios/ProjectName.xcworkspace` folder in Xcode.
> 2. Click** File> New> File**, select **iOS**>** Swift File**, and click **Next**> **Create** to** create** an empty `File.swift file`.