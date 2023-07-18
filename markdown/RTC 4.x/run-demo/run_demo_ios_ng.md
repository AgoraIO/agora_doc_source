声网在 GitHub 上提供了开源的 SDK 示例项目 [API-Examples](https://github.com/AgoraIO/API-Examples/tree/main/iOS/APIExample)，展示了各种基础和进阶的场景。本文以跑通视频通话示例项目为例，帮助你快速体验声网视频效果。


## 前提条件

$$bbe55090-5cb0-11ec-af4b-2b38abdb1c68
{
"platform": "ios"
}
$$

## 操作步骤


### 配置示例项目

下载最新版的[视频 SDK](./downloads?platform=iOS)，在 `samples/APIExample/APIExample/Common/KeyCenter.swift` 文件中填写你从声网控制台获取到的 App ID 和临时 Token。

  ```swift
class KeyCenter: NSObject {
    // 把 <#Your App Id#> 替换成你的 App ID，并加引号，如 "xxxxxx"
    static let AppId: String = <#Your App Id#>
    // 把 #Temp Access Token# 替换成你的临时 Token，并加引号，如 "xxxxxx"
    static let Certificate: String? = <#YOUR Certificate#>
  }
  ```

### 5. 集成声网 SDK

在 `samples/API-Example` 目录下运行 `pod install`，等待安装完成。

### 6. 编译并运行示例项目

1. 连接上 iOS 设备后，点击 `APIExample.xcworkspace` 文件以通过 Xcode 打开 `API-Example` 项目，并在 **iOS Device** 选项中勾选上你的 iOS 设备。

    <img src="https://web-cdn.agora.io/docs-files/1639710570014" width="200"/>

2. 在项目 **TARGETS** 下的 **Signing & Capabilities** 界面勾选 **Automatically manage signing**，配置你的苹果开发者账号和 **Bundle Identifier**。

3. 点击 <img src="https://web-cdn.agora.io/docs-files/1639710560035" width="25"/> 开始编译。

4. 编译成功后，你的 iOS 设备上会出现 <img src="https://web-cdn.agora.io/docs-files/1640600081300" width="30"/> 应用。在 iOS 系统设置中将该应用设为信任开发者后你才能打开应用。

5. 打开应用后，点击 **Join a channel (Video)**，输入你之前生成 Token 时使用的频道名（如 `test`），并点击 **Join**。

    <img src="https://web-cdn.agora.io/docs-files/1639710578205" width="200"/>

    <img src="https://web-cdn.agora.io/docs-files/1639710595513" width="193"/>


现在你就以 `local host` 的角色开始视频直播了。你可以邀请一位朋友加入你所在的直播频道：克隆 [API-Examples-Web](https://github.com/AgoraIO/API-Examples-Web) 项目到本地，在浏览器中打开 `Demo/index.html` 文件，并输入相同的 App ID、频道名、临时 Token。