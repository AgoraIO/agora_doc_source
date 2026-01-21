声网在 GitHub 上提供开源 [BeautyAPI](https://github.com/AgoraIO-Community/BeautyAPI/tree/1.0.1.1) 示例项目供你参考。本文介绍如何快速跑通该示例项目，体验商汤美颜效果。

## 前提条件

- [Git](https://git-scm.com/downloads)
- [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started)
- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 13.0 及以上
- iOS 设备，版本 11.0 及以上
- 有效的苹果开发者账号
- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)

<div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>

<a name = "create"></a>
## 创建声网项目

~f42d44d0-2ac7-11ee-b391-19a59cc2656e~

## 克隆仓库

运行以下命令克隆仓库到本地：

```shell
git clone git@github.com:AgoraIO-Community/BeautyAPI.git
```

## 集成第三方美颜 SDK

1. 联系商汤技术支持获取最新的美颜 SDK、美颜资源、美颜证书。

2. 下载并解压美颜 SDK 等文件，然后将如下文件添加到美颜示例项目对应的文件路径下：

    | 文件    |  项目路径   |
    |-----|-----|
    | SenseMe/remoteSourcesLib    | iOS/SenseLib/remoteSourcesLib              |
    | SenseMe/st_mobil_sdk | iOS/SenseLib/st_mobile_sdk  |
    |SenseMe/st_mobil_sdk/license/SENSEME.lic   | iOS/SenseLib/SENSEME.lic |



## 配置示例项目

1. 运行美颜项目前，你需要在 `iOS/BeautyAPi/KeyCenter.swift` 文件中设置如下参数：

    ```swift
    static let AppId: String = <#YOUR_APP_ID#>
    ```

    你可以在[创建声网项目](#create)后，从控制台获取这些参数的值，详情如下：

    | 参数 | 描述   | 获取方式 |
    |----|----|----|
    | `AppId`    | 声网项目的 App ID     | [获取 App ID](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id)  |


2. 在 `iOS/` 目录下运行 `pod install`，然后等待依赖库安装完成。


## 编译并运行示例项目

![](https://web-cdn.agora.io/docs-files/1690276905446)

1. 连接上 iOS 设备后，点击 `BeautyAPi.xcodeproj` 文件以通过 Xcode 打开项目，并在 **iOS Device** 选项中勾选上你的 iOS 设备。

2. 在项目 **TARGETS** 下的 **Signing & Capabilities** 界面勾选 **Automatically manage signing**，配置你的苹果开发者账号和 **Bundle Identifier**。Bundle ID 是设备上应用程序的唯一标识。在开发应用时，你需要设置 Bundle ID。在此处设置的 Bundle ID 需要与你申请商汤美颜 SDK 时提供的 Bundle ID 一致。

3. 点击 <img src="https://web-cdn.agora.io/docs-files/1639710560035" width="25" style="display: inline;" /> 开始编译。

4. 编译成功后，你的 iOS 设备上会出现美颜应用。在 iOS 系统设置中将该应用设为信任开发者后你才能打开应用。

5. 打开美颜应用，进行体验。