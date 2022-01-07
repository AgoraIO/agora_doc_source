This page introduces how to quickly launch a flexible classroom.

## Understand the tech

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

<a name="prerequisites"></a>

## Prerequisites

- An Agora project with an<a href="/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-id" target="_blank">Agora App ID</a>, <a href="/cn/Agora%20Platform/get_appid_token#%E8%8E%B7%E5%8F%96-app-%E8%AF%81%E4%B9%A6" target="_blank">App Certificate</a>, and <a href="/cn/agora-class/agora_class_enable?platform=iOS" target="_blank">enable the Flexible Classroom service</a>.
- Xcode 10.0 or later.
- CocoaPods 1.10 or later. 参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。
- iOS 10 or later.
- If you use Swift, use Swift 5.3.2 or later.
- A valid Agora account. (Sign up for free)
- A physical iOS device (iPhone or iPad). A physical Android device.

## Launch a flexible classroom

Follow these steps to launch a flexible classroom:

1. Run the following command to clone the [CloudClass-Androidhttps](://github.com/AgoraIO-Community/CloudClass-Android) project and check out the latest release branch.

   ```
   git clone https://github.com/AgoraIO-Community/CloudClass-iOS.git
   ```

   ```
   git checkout release/apaas/x.y.z
   ```

<div class="alert info">Replace x.y.z with the version number. To get the latest version number, see the <a href="/cn/agora-class/release_agora_class_ios?platform=iOS">release notes</a>.</div>

2. 运行以下命令将 [apaas-extapp-ios](https://github.com/AgoraIO-Community/apaas-extapp-ios) 项目克隆至本地，并切换至最新发版分支。 apaas-extapp-ios 仓库需要和 CloudClass-iOS 仓库位于同一目录下。

   ```
   git clone https://github.com/AgoraIO-Community/apaas-extapp-ios.git
   ```

   ```
   git checkout release/apaas/x.y.z
   ```

2. 在 CloudClass-iOS 项目中运行 `pod install`。

3. 连接上 iOS 设备后，用 Xcode 打开 CloudClass-iOS 项目，然后编译并运行。

<div class="alert info">CloudClass-iOS 项目中使用灵动课堂默认的 App ID 和 App 证书。 如果你想替换成你自己的 App ID 和 App 证书，需在 <code>AgoraEducation/Main/Controllers/LoginViewController.swift</code> 文件中注释掉 <code>requestToken</code> 方法，使用 <code>buildToken</code> 方法。</div>

4. 输入房间名、用户名，选择一种班型，然后点击**加入**，即可进入灵动课堂。

## Next steps

现在你已经初步体验了灵动课堂的功能，接下来可将[灵动课堂集成到你自己的项目中](/cn/agora-class/agora_class_integrate_ios?platform=iOS)。