根据本文指导通过 Agora Classroom SDK 快速启动并体验灵动课堂。

## 技术原理

下图展示了启动灵动课堂的基本流程。

![](https://web-cdn.agora.io/docs-files/1626925692656)

当你的 app 客户端请求加入灵动课堂时：

1. 你的 app 客户端向 app 服务端申请 RTM Token。
2. 你的 app 服务端使用 Agora App ID、App 证书和用户 ID 生成一个 RTM Token，返回给 app 客户端。详见[生成 RTM Token](/cn/Real-time-Messaging/token_server_rtm)。
3. 你的 app 客户端调用 API 并传入用户 ID、房间 ID 和 RTM Token 启动灵动课堂。灵动课堂云服务会根据你传入的房间 ID 为该课题自动创建一个房间。

<a name="prerequisites"></a>

## 前提条件

- 已在 Agora 控制台创建 Agora 项目，获取 [Agora App ID](/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-id)、[App 证书](/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-%E8%AF%81%E4%B9%A6)并[配置 aPaaS 服务](/cn/agora-class/agora_class_prep?platform=Web)。
- Xcode 10.0 或以上版本。
- CocoaPods 1.10 或以上版本。参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。
- iOS 10 或以上版本。
- 如果你使用 Swift 开发，使用 Swift 5.0 或以上版本。
- 一个有效的 Apple 开发者账号。
- 一台 iOS 设备（iPhone 或 iPad）。模拟机可能出现功能缺失或者性能问题，所以推荐使用真机。

## 启动灵动课堂

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

   为方便你快速测试，CloudClass-iOS 项目中已包含一个临时 RTM Token 生成器，会用你传入的 App ID 和 App 证书生成一个临时 RTM Token。但是在正式环境中，为确保安全，RTM Token 必须在服务端生成。

   你可在 `AgoraEducation/Main/Controllers/LoginViewController.swift` 文件中查看启动课堂的具体逻辑：

   1. 调用 [AgoraEduSDK.setConfig](/cn/agora-class/agora_class_api_ref_ios?platform=iOS#setconfig) 方法全局配置 SDK。
   2. 调用 [AgoraEduSDK.launch](/cn/agora-class/agora_class_api_ref_ios?platform=iOS#launch) 方法启动灵动课堂。

3. 连接上 iOS 设备后，用 Xcode 打开示例项目，然后编译并运行项目。

4. 输入房间名、用户名，选择一种班型，然后点击**加入**，即可进入灵动课堂，看到以下画面：

   ![](https://web-cdn.agora.io/docs-files/1619164553801)

## 后续步骤

如果 Agora Classroom SDK 中默认的 UI 无法满足你的需求，你可以参考[自定义课堂 UI 文档](/cn/agora-class/agora_class_custom_ui_ios?platform=iOS)，获取 Agora Classroom SDK 的源码，自行修改灵动课堂的 UI，如更换颜色、调整布局。

## 更多信息

### 集成 Agora Classroom SDK

你可以参考以下步骤，通过 CocoaPods 将 Agora Classroom SDK 集成到你自己的 iOS 项目中：

1. 在终端里进入你的项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。

2. 打开 `Podfile` 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称。

   ```
   # platform :ios, '10.0' use_frameworks!
   target 'Your App' do
       pod 'AgoraClassroomSDK'
   end
   ```

 <div class="alert info">1.0.0 版本请使用 <code>pod 'AgoraEduSDK'</code>。</div>

3. 在终端内运行 `pod install` 命令安装 SDK。成功安装后，Terminal 中会显示 `Pod installation complete!`，此时项目文件夹下会生成一个 `xcworkspace` 文件。
4. 打开新生成的 `xcworkspace` 文件。

自 v1.1.0 起，灵动课堂 iOS 端基于 Swift 语言进行开发。如果开发者基于 Object-C 语言开发，需要参考以下步骤在项目中创建一个 Swift 文件，生成 Swift 环境。

1. 在 Xcode 中打开 `ios/ProjectName.xcworkspace` 文件夹。
2. 点击 **File > New > File**， 选择 **iOS** > **Swift File**，点击 **Next** > **Create**，新建一个空的 `File.swift` 文件。