本文介绍如何获取灵动课堂 iOS 端 GitHub 源码并运行项目，快速启动并体验灵动课堂。

## 技术原理

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

<a name="prerequisites"></a>

## 前提条件

-   在声网控制台[开通灵动课堂服务](/cn/agora-class/agora_class_enable?platform=Web)。
-   在声网控制台获取 [声网 App ID](/cn/Agora%20Platform/get_appid_token#获取-app-id) 和 [App 证书](/cn/Agora%20Platform/get_appid_token#获取-app-证书)。
-   一个有效的 Apple 开发者账号。
-   一台 iOS 设备（iPhone 或 iPad）。模拟机可能出现功能缺失或者性能问题，所以推荐使用真机。此外，灵动课堂 iOS 端要求运行在 iOS 11 或以上版本。

## 准备开发环境

在你的设备上运行灵动课堂依赖于 Xcode 和 CocoaPods。

你可参考以下步骤准备开发环境：

1. 打开 App Store，下载并安装 Xcode。要求 Xcode 13.0 或以上版本。
2. 点击[链接](https://guides.cocoapods.org/using/getting-started.html#getting-started)前往下载 CocoaPods。要求 CocoaPods 1.10 或以上版本。

<div class="alert info">如果你使用 Swift 开发，需要使用 Swift 5.0 或以上版本。</div> 

## 获取源码

灵动课堂 App iOS 端的源码位于 GitHub [flexible-classroom-ios](https://github.com/AgoraIO-Community/flexible-classroom-ios) 仓库。你可参考以下步骤获取源码：

1. 运行以下命令将 flexible-classroom-ios 仓库克隆到本地：
	
	```
	git clone https://github.com/AgoraIO-Community/flexible-classroom-ios.git
	```

2. 运行以下命令进入 flexible-classroom-ios 目录并切换分支至指定版本。将 {VERSION} 替换为要切换的版本号：
	
	```
	git checkout release/{VERSION} 
	```
	
	例如要切换到 2.8.0 版本分支，执行以下命令：
	
	```
	git checkout release/2.8.0
	```

   声网建议你切换到最新发版分支。参考下图在 GitHub 仓库中查看最新发版分支：
   ![](https://web-cdn.agora.io/docs-files/1670308184065)

## 启动灵动课堂

按照以下步骤启动灵动课堂：

1. 运行以下命令进入 flexible-classroom-ios/App 目录：

    ```bash
    cd flexible-classroom-ios/App
    ```

2. 运行以下命令安装依赖包。

    ```bash
    pod install
    ```

    如下图所示：

    ![](https://web-cdn.agora.io/docs-files/1670310132026)

3. 成功安装依赖包后，在“访达”窗口中打开 flexible-classroom-ios/App 文件夹，双击 `AgoraEducation.xcworkspace` 在 Xcode 中打开项目。

   ![](https://web-cdn.agora.io/docs-files/1648725644218)

   ![](https://web-cdn.agora.io/docs-files/1648725725804)

4. 在项目 TARGETS 下的 Signing & Capabilities 界面勾选 Automatically manage signing，配置你的 Apple 开发者账号和 Bundle Identifier。

   ![](https://web-cdn.agora.io/docs-files/1648725848162)

5. 连接上你的 iOS 设备后，点击 Xcode 左上角的运行按钮运行项目。

   ![](https://web-cdn.agora.io/docs-files/1648725959472)

6. 运行成功后，你可以在 iOS 设备上看到以下画面。输入房间名、用户名，选择一种班型，然后点击**加入**，即可进入灵动课堂。

   ![](https://web-cdn.agora.io/docs-files/1648726024179)

## 后续步骤

现在你已经初步体验了灵动课堂的功能，接下来可将[灵动课堂集成到你自己的项目中](/cn/agora-class/agora_class_integrate_ios?platform=iOS)。