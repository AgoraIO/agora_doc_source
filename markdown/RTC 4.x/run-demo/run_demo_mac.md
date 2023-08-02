声网在 GitHub 上提供了开源的 SDK 示例项目 [API-Examples](https://github.com/AgoraIO/API-Examples/tree/main/macOS/APIExample)，展示了各种基础和进阶的场景。本文以跑通视频通话示例项目为例，帮助你快速体验声网视频通话效果。


## 前提条件

<!--  以下是 fragment 的内容，仅供 review，发布时删除
$$bbe55090-5cb0-11ec-af4b-2b38abdb1c68
{
"platform": "macos"
}
$$  -->


 - 可以访问互联网的计算机。请确保你的网络环境未部署防火墙，否则可能无法正常使用声网服务。
 - Xcode 13.0 或以上版本。
 - 已安装 Cocoapods。如尚未安装 Cocoapods，参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。
 - 两台 <% if (platform == "ios") { %>iOS 9.0<% } if (platform == "macos") { %>macOS 10.10<% } %> 或以上版本的设备。
 - 一个有效的[声网账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)以及声网项目。请参考[开始使用声网平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)从声网控制台获得以下信息：
   - App ID：声网随机生成的字符串，用于识别你的项目。
   - 频道名：用于标识频道的字符串。
 - Apple 开发者账号。

## 操作步骤

### 获取示例项目

你可以通过以下两种方式获取示例项目：

- 前往 [SDK 下载页面](./downloads?platform=macOS)，获取最新版的 macOS 视频 SDK，然后解压。

- 前往声网在 Github 行提供的[示例项目](https://github.com/AgoraIO/API-Examples/tree/main)，然后运行以下命令克隆仓库到本地：

  ```shell
  git clone git@github.com:AgoraIO/API-Examples.git
  ```

  该仓库中包含声网实时音视频 SDK 的 Native 平台示例项目，其中 macOS 平台的 API 使用示例位于 `/macOS` 路径下。

### 配置示例项目

1. 打开示例项目文件夹，在 `KeyCenter.swift` 文件中填写你从声网控制台获取到的 App ID。

   ```swift
   struct KeyCenter {
   	// 把 <#Your App Id#> 替换成你的 App ID 并加引号，如 "xxxxxx"
       static let AppId: String = <#YOUR AppId#>
       // 如果你的项目启用了 App 证书，把 <#YOUR Certificate#> 替换成你的 App 证书并加引号，如 "xxxxxx"；如未启用该字段为空
       static let Certificate: String? = <#YOUR Certificate#>
   }
   ```


2. 打开终端，在 `/macOS` 目录下运行 `pod install` 安装项目依赖。安装完成后，终端会显示 `Pod installation complete!`，此时项目文件夹下会生成一个 `APIExample.xcworkspace` 文件，使用 Xcode 打开该文件。


### 编译并运行示例项目

1. 在 Xcode 中打开 `APIExample.xcworkspace` 文件后，在项目 **TARGETS** 下的 **Signing & Capabilities** 界面勾选 **Automatically manage signing**，然后在每一个 Target 下配置你的苹果开发者账号和 **Bundle Identifier**。
   ![](https://web-cdn.agora.io/docs-files/1690515719254)

4. 点击 <img src="https://web-cdn.agora.io/docs-files/1690171362896" height="20"/> 开始编译。

5. 编译成功后，示例项目的 app 会在你的窗口中弹出。

7. 选择一个你想要尝试的场景，输入频道名，然后点击**加入频道**。

   ![](https://web-cdn.agora.io/docs-files/1690515752444)

5. 为更好地体验各种音视频互动场景，你可以邀请一位朋友使用另一台设备运行该示例项目（需确保 与 `KeyCenter.swift` 中的 App ID 一致）。当你们输入相同的频道名加入频道后，即可在同一频道中体验各种互动场景。

   ![](https://web-cdn.agora.io/docs-files/1690515855575)