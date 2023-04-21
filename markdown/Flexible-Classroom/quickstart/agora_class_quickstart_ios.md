本文介绍如何获取灵动课堂 iOS 端 GitHub 源码并运行项目，快速启动并体验灵动课堂。

## 前提条件
-   一个有效的 [Apple 开发者账号](https://developer.apple.com/)。
-   一台 iOS 设备（iPhone 或 iPad）。模拟机可能出现功能缺失或者性能问题，所以推荐使用真机。此外，灵动课堂 iOS 端要求运行在 iOS 11 或以上版本。

## 准备开发环境

在你的设备上运行灵动课堂依赖于 Xcode 和 CocoaPods。

你可参考以下步骤准备开发环境：

1. 打开 App Store，下载并安装 Xcode。要求 Xcode 13.0 或以上版本。
2. 点击[链接](https://guides.cocoapods.org/using/getting-started.html#getting-started)前往下载 CocoaPods。版本需要为 1.10 或更高版本。

安装后，可以在终端输入以下命令，如果终端能正常打印出版本信息，则表示安装成功：


```
pod --version
```

例如，你安装了 1.11.3 版本，则终端会打印如下信息：

```
1.11.3
```

## 获取源码

灵动课堂 App iOS 端的源码位于 GitHub [flexible-classroom-ios](https://github.com/AgoraIO-Community/flexible-classroom-ios) 仓库。你可参考以下步骤获取源码：

1. 运行以下命令将 flexible-classroom-ios 仓库克隆到本地：
	
	```
	git clone https://github.com/AgoraIO-Community/flexible-classroom-ios.git
	```

2. 仓库克隆到本地后，默认为最新发布的分支，如果你需要切换历史的版本，则进入到 flexible-classroom-ios 目录下，运行以下命令并切换分支至指定版本。将 {VERSION} 替换为要切换的版本号：
	
	```
	git checkout release/{VERSION} 
	```
	
	例如要切换到 2.8.20 版本分支，执行以下命令：
	
	```
	git checkout release/2.8.20
	```

## 启动灵动课堂

按照以下步骤启动灵动课堂：

1. 运行以下命令进入 flexible-classroom-ios/App 目录：

    ```bash
    cd flexible-classroom-ios/App
    ```

2. 运行以下命令安装依赖包：

   ```bash
   pod install
   ```
   以 release/2.8.20 分支为例，安装依赖过程中会打印如下信息：

   ```
   Analyzing dependencies
   Downloading dependencies
   Installing AgoraClassroomSDK_iOS (2.8.20)
   Installing AgoraEduCore (2.8.20)
   Installing AgoraEduUI (2.8.20)
   Installing AgoraLog (1.0.2)
   Installing AgoraMediaPlayer_iOS (1.3.0)
   Installing AgoraProctorSDK (1.0.0)
   Installing AgoraProctorUI (1.0.0)
   Installing AgoraRtcEngine_iOS (3.7.2)
   Installing AgoraRtm_iOS (1.4.8)
   Installing AgoraUIBaseViews (2.8.0)
   Installing AgoraWidget (2.8.0)
   Installing AgoraWidgets (2.8.20)
   Installing Agora_Chat_iOS (1.0.6)
   Installing AliyunOSSiOS (2.10.8)
   Installing Armin (1.1.0)
   Installing CocoaLumberjack (3.6.1)
   Installing Masonry (1.1.0)
   Installing NTLBridge (3.1.5)
   Installing Protobuf (3.17.0)
   Installing SDWebImage (5.12.0)
   Installing SSZipArchive (2.4.2)
   Installing SwifterSwift (5.2.0)
   Installing Whiteboard (2.16.51)
   Installing YYModel (1.0.4)
   Generating Pods project
   Integrating client project
   ```

3. 成功安装依赖包后，打开 `flexible-classroom-ios/App` 文件夹，双击 `AgoraEducation.xcworkspace` 在 Xcode 中打开项目：

   ![](https://web-cdn.agora.io/docs-files/1648725644218)

   ![](https://web-cdn.agora.io/docs-files/1648725725804)

4. 在项目 **TARGETS** 下的 **Signing & Capabilities**，配置你的 Apple 开发者账号和 [Bundle Identifier](https://developer.apple.com/documentation/appstoreconnectapi/bundle_ids)：

   ![](https://web-cdn.agora.io/docs-files/1648725848162)

5. 连接上你的 iOS 设备后，点击 Xcode 左上角的运行按钮运行项目：

   ![](https://web-cdn.agora.io/docs-files/1648725959472)

6. 运行成功后，你可以在 iOS 设备上看到以下画面。输入房间名、用户名，选择一种班型，然后点击**加入**，即可进入灵动课堂：

   ![](https://web-cdn.agora.io/docs-files/1648726024179)

## 后续步骤

现在你已经初步体验了灵动课堂的功能，接下来可以将[灵动课堂集成到你自己的项目中](/cn/agora-class/agora_class_integrate_ios?platform=iOS)。