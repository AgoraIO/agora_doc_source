声网在 GitHub 上提供了开源的 SDK 示例项目 [API-Examples](https://github.com/AgoraIO/API-Examples/tree/main/iOS/APIExample)，展示了各种基础和进阶的场景。本文以跑通视频通话示例项目为例，帮助你快速体验声网视频效果。


## 前提条件

<!--  以下是 fragment 的内容，仅供 review，发布时删除
$$bbe55090-5cb0-11ec-af4b-2b38abdb1c68
{
"platform": "ios"
}
$$  -->


 - 可以访问互联网的计算机。请确保你的网络环境未部署防火墙，否则可能无法正常使用声网服务。
 - Xcode 13.0 或以上版本。
 - 已安装 Cocoapods。如尚未安装 Cocoapods，参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。
 - 两台 <% if (platform == "ios") { %>iOS 14.0<% } if (platform == "macos") { %>macOS 10.10<% } %> 以上版本的设备。
 - 一个有效的[声网账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)以及声网项目。请参考[开始使用声网平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)从声网控制台获得以下信息：
   - App ID：声网随机生成的字符串，用于识别你的项目。
   - App 证书（可选）：用于生成 token 的字符串。如果你的项目为“无证书模式”，则不需要获取该字段。
   - 频道名：用于标识频道的字符串。
 - Apple 开发者账号。

## 操作步骤

### 获取示例项目

你可以通过以下两种方式获取示例项目：
- 前往 [SDK 下载页面](./downloads?platform=iOS)，下载最新版的 iOS 视频 SDK，然后解压。
- 前往声网在 Github 上提供的[示例项目](https://github.com/AgoraIO/API-Examples/tree/main)，然后运行以下命令将仓库克隆至本地。
    ```shell
  git clone git@github.com:AgoraIO/API-Examples.git
  ```
  <div class="alert info">声网在仓库中为 iOS 平台提供了视频示例项目和音频示例项目，分别位于 <code>/iOS/APIExample</code> 和 <code>/iOS/APIExample-Audio</code> 路径下。</div>


### 配置示例项目

1. 打开示例项目文件夹，在 `samples/APIExample/APIExample/Common/KeyCenter.swift` 文件中填写你从声网控制台获取到的 App ID 和 App 证书（如果项目为“无证书模式”，该字段留空）。
    ```swift
    class KeyCenter: NSObject {
        // 把 <#Your App Id#> 替换成你的 App ID，并加引号，如 "xxxxxx"
        static let AppId: String = <#Your App Id#>
        // 把 #YOUR Certificate# 替换成你的 App 证书，并加引号，如 "xxxxxx"；该字段可为空
        static let Certificate: String? = <#YOUR Certificate#>
      }
    ```


2. 打开终端，在 `samples/API-Example` 目录下运行 `pod install` 安装 SDK 或相关依赖。安装完成后，终端会显示 `Pod installation complete!`。按照如下提示，使用 Xcode 打开项目文件夹下新生成的 `APIExample.xcworkspace` 文件。
    ```bash
    [!] Please close any current Xcode sessions and use `APIExample.xcworkspace` for this project from now on.
    Pod installation complete! There are 4 dependencies from the Podfile and 4 total pods installed.
    ```
### 编译并运行示例项目

1. 将 iOS 设备连接至电脑，在设备上打开 **设备 > 隐私与安全性 > 安全性**，打开**开发者模式**。
2. 在 Xcode 界面顶部的 **iOS Device** 选项中勾选你的 iOS 设备。
  <img src="https://web-cdn.agora.io/docs-files/1690165346541" width="400"/>

1. 在项目 **TARGETS** 下的 **Signing & Capabilities** 界面勾选 **Automatically manage signing**，然后在每一个 Target 下配置你的苹果开发者账号和 **Bundle Identifier**。
  ![](https://web-cdn.agora.io/docs-files/1690515622771)

2. 点击 <img src="https://web-cdn.agora.io/docs-files/1690171362896" height="20"/> 开始编译。

3. 编译成功后，你的 iOS 设备上会出现 <img src="https://web-cdn.agora.io/docs-files/1690171050099" height="30"/> app 图标。
4. （可选）如果设备上弹出**不受信任的开发者**提示，则首先点击**取消**关闭该提示，然后在 iOS设备上打开**设置 > 通用 > VPN 与设备管理**，在**开发者 APP** 中选择信任该开发者。

5. 打开 **API Example**，选择一个你想要尝试的场景，然后输入频道名（如 `test`），并点击**加入频道**。

    <img src="https://web-cdn.agora.io/docs-files/1690182221128" width="200"/>  
    <img src="https://web-cdn.agora.io/docs-files/1690182273239" width="200"/>


6. 为更好地体验各种音视频互动场景，你可以邀请一位朋友使用另一台设备运行该示例项目（需确保 `samples/APIExample/APIExample/Common/KeyCenter.swift` 中的 App ID 和 App 证书不变）。当你们输入相同的频道名加入频道后，即可在同一频道中体验各种互动场景。
    <img src="https://web-cdn.agora.io/docs-files/1690278567335" width="400"/>



