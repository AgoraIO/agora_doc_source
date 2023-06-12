# 跑通 MetaWorld 示例项目

声网在 GitHub 上提供一个开源的 MetaWorld 示例项目 [MetaWorld](https://github.com/AgoraIO-Community/Agora-MetaWorld/)。本文介绍如何快速跑通该示例项目，体验效果。


## 前提条件

- [Git](https://git-scm.com/downloads)
- [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started)
- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 12.0 及以上
- iOS 设备，版本 11.0 及以上
    <div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>
- 有效的苹果开发者账号
- 有效的[声网账户](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E5%88%9B%E5%BB%BA%E5%A3%B0%E7%BD%91%E8%B4%A6%E5%8F%B7)和[声网项目](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E5%88%9B%E5%BB%BA%E5%A3%B0%E7%BD%91%E9%A1%B9%E7%9B%AE)


## 获取示例项目

运行以下命令克隆仓库到本地：

```shell
git clone git@github.com:AgoraIO-Community/Agora-MetaWorld.git
```

## 配置示例项目

### 集成 SDK

1. 联系技术支持获取 MetaWorld SDK，下载并解压。

2. 将 SDK 包内 `libs` 及路径下的文件，拷贝到示例项目的 `./Agora-MetaWorld/ios/sdk/` 路径下。

3. 点击 `MetaChatDemo.xcodeproj` 文件以通过 Xcode 打开项目，添加 SDK 包 `libs` 路径下的框架和库。
    
    ![](https://web-cdn.agora.io/docs-files/1686302836178)


### 设置 ID 和证书

1. 运行示例项目前，你需要在 `./Agora-MetaWorld/ios/MetaChatDemo/KeyCenter.swift` 文件中设置如下参数：

    ```shell
    @objc static let APP_ID: String = <#AppId#>
    @objc static let certificate: String = <#Certificate#>
    @objc static let FACE_CAPTURE_APP_ID: String = <#Face Capture App Id#>
    @objc static let FACE_CAPTURE_CERTIFICATE: String = <#Face Capture Certificate#>
    ...
    ...
    @objc static let kUserKey: String = <#kUserKey#>
    @objc static let kUserSecret: String = <#kUserSecret#>
    ```

    详情如下：

    | 参数  |  描述  | 获取方式 |
    | ---- | ------ | ------ |
    | AppId    | 声网项目的 App ID     | [获取 App ID](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id)  |
    | Certificate | 声网项目的 App 证书 | [获取 App 证书](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-证书)   |
    | Face Capture App Id | 声网面捕的 App ID | 联系销售获取 |
    | Face Capture Certificate | 声网面捕的 App 证书 | 联系销售获取 |
    | kUserKey | 客户 ID，声网 RESTful API 使用客户 ID 和客户密钥进行 HTTP 基本认证 | [生成客户 ID 和密钥](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E7%94%9F%E6%88%90%E5%AE%A2%E6%88%B7-id-%E5%92%8C%E5%AF%86%E9%92%A5) |
    | kUserSecret | 客户密钥，声网 RESTful API 使用客户 ID 和客户密钥进行 HTTP 基本认证 | [生成客户 ID 和密钥](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E7%94%9F%E6%88%90%E5%AE%A2%E6%88%B7-id-%E5%92%8C%E5%AF%86%E9%92%A5) |

<div class="alert info"><code>CHANNEL_ID</code> 设置为任意字符串，<code>RTC_UID</code> 设置为 0 以外的任意 Int 值。</div>

2. 在 `Agora-MetaWorld/ios` 目录下运行 `pod install`，然后等待依赖库安装完成。


## 编译并运行示例项目

![](https://web-cdn.agora.io/docs-files/1686540295452)

1. 点击 `AgoraEntScenarios.xcworkspace` 文件通过 Xcode 打开项目。

2. 通过 USB 线将你的 iOS 设备接入电脑，并在 **iOS Device** 选项中勾选你的 iOS 设备。

3. 在项目 **TARGETS** 下的 **Signing & Capabilities** 界面勾选 **Automatically manage signing**，配置你的苹果开发者账号和 **Bundle Identifier**。Bundle ID 用于在设备上唯一标识应用程序。在开发应用时，你需要设置 Bundle ID。

4. 点击 <img src="https://web-cdn.agora.io/docs-files/1686540324207" width="25"/> 开始编译。编译成功后，你的 iOS 设备上会出现 **MetaChatDemo** 应用。在 iOS 系统设置中将该应用设为信任开发者后你才能打开应用。

5. 打开应用，即可体验语聊 + 直播的场景示例。如仅想体验直播的场景示例，请打开 `./Agora-MetaWorld/ios/MetaChatDemo/MetaChatLoginViewController.swift` 进行以下修改，并重新编译和运行示例项目。

```swift
// 将 true 改为 false
if true {
    kSceneIndex = .chat
    switchOrientation(isPortrait: false, isFullScreen: isEnter)
} else {
    kSceneIndex = .live
    switchOrientation(isPortrait: true, isFullScreen: isEnter)
}
```