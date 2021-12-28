根据本文指导通过 Agora Classroom SDK 快速启动并体验灵动课堂。

## 技术原理

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

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

1. 运行以下命令将 Agora 提供的灵动课堂项目 CloudClass-iOS 克隆至本地，并切换至最新发版分支。

   ```
   git clone https://github.com/AgoraIO-Community/CloudClass-iOS
   ```

	```
   git checkout release/apaas/x.y.z
   ```

   <div class="alert info">x.y.z 请替换为版本号。你可在<a href="/cn/agora-class/release_agora_class_ios?platform=iOS">发版说明</a>中获取最新版本号。</div>

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

现在你已经初步体验了灵动课堂的功能，接下来可将[灵动课堂集成到你自己的 app 项目中](/cn/agora-class/agora_class_integrate_ios?platform=iOS)。