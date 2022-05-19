本文介绍如何获取灵动课堂 iOS 端 GitHub 源码并运行项目，快速启动并体验灵动课堂。

## 技术原理

~96d9aaf0-eb84-11eb-b768-51ffcd29c763~

<a name="prerequisites"></a>

## 前提条件

-   在 Agora 控制台[开通灵动课堂服务](/cn/agora-class/agora_class_enable?platform=Web)。
-   在 Agora 控制台获取 [Agora App ID](/cn/Agora%20Platform/get_appid_token#获取-app-id) 和 [App 证书](/cn/Agora%20Platform/get_appid_token#获取-app-证书)。
-   一个有效的 Apple 开发者账号。
-   一台 iOS 设备（iPhone 或 iPad）。模拟机可能出现功能缺失或者性能问题，所以推荐使用真机。此外，灵动课堂 iOS 端要求运行在 iOS 10 或以上版本。

## 准备开发环境

在你的设备上运行灵动课堂依赖于 Xcode 和 CocoaPods。

你可参考以下步骤准备开发环境：

1. 打开 App Store，下载并安装 Xcode。要求 Xcode 12.5 或以上版本。
2. 点击[链接](https://guides.cocoapods.org/using/getting-started.html#getting-started)前往下载 CocoaPods。要求 CocoaPods 1.10 或以上版本。

<div class="alert info">如果你使用 Swift 开发，需要使用 Swift 5.0 或以上版本。</div>

## 获取源码

灵动课堂 iOS 端的源码位于 GitHub [CloudClass-iOS](https://github.com/AgoraIO-Community/CloudClass-iOS) 仓库和 [apaas-extapp-ios](https://github.com/AgoraIO-Community/apaas-extapp-ios) 仓库。你可参考以下步骤获取源码：

1. 运行以下命令将 CloudClass-iOS 仓库克隆到本地：

    ```bash
    git clone https://github.com/AgoraIO-Community/CloudClass-iOS.git
    ```

2. 运行以下命令进入 CloudClass-iOS 目录并切换分支至指定版本。将 {VERSION} 替换为要切换的版本号：

    ```bash
    cd CloudClass-iOS
    ```

    ```bash
    git checkout release/apaas/{VERSION}
    ```

    例如要切换到 2.1.0 版本分支，执行以下命令：

    ```bash
    git checkout release/apaas/2.1.0
    ```

    Agora 建议你切换到最新的发版分支。

3. 运行以下命令将 apaas-extapp-ios 仓库克隆到本地。

    ```bash
    git clone https://github.com/AgoraIO-Community/apaas-extapp-ios.git
    ```

    apaas-extapp-ios 仓库需要和 CloudClass-iOS 仓库位于同一目录下，如下图所示：

    ![](https://web-cdn.agora.io/docs-files/1648725190226)

4. 运行以下命令进入 apaas-extapp-ios 目录并切换分支至指定版本。将 {VERSION} 替换为要切换的版本号：

    ```bash
    cd apaas-extapp-ios
    ```

    ```bash
    git checkout release/apaas/{VERSION}
    ```

    例如要切换到 2.1.0 版本分支，执行以下命令：

    ```bash
    git checkout release/apaas/2.1.0
    ```

## 启动灵动课堂

按照以下步骤启动灵动课堂：

1. 运行以下命令进入 CloudClass-iOS/App 目录：

    ```bash
    cd CloudClass-iOS/App
    ```

2. 运行以下命令安装依赖包。

    ```bash
    pod install
    ```

    如下图所示：

    ![](https://web-cdn.agora.io/docs-files/1648725475723)

3. 成功安装依赖包后，在“访达”窗口中打开 CloudClass-iOS 文件夹，双击 `AgoraEducation.xcworkspace` 在 Xcode 中打开项目。

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
