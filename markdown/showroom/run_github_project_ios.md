声网在 GitHub 上提供一个开源的秀场直播示例项目 [agora-ent-scenarios](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/v3.0.0-all-iOS/iOS/AgoraEntScenarios/Scenes/Show)。本文介绍如何快速跑通该示例项目，体验直播效果。

## 前提条件

- [Git](https://git-scm.com/downloads)
- [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started)
- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 12.0 及以上
- iOS 设备，版本 13.0 及以上
- 有效的苹果开发者账号
- 有效的声网[开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)

<div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>

<a name = "create"></a>
## 创建声网项目

~4c028930-19e2-11eb-b0e2-eb6c69fefbc6~

## 克隆仓库

运行以下命令克隆仓库到本地：

```shell
git clone git@github.com:AgoraIO-Usecase/agora-ent-scenarios.git
```

## 集成商汤美颜 SDK

1. 联系商汤技术支持获取最新的美颜 SDK 和测试证书。美颜 SDK 中包含 Android 和 iOS SDK。

2. 下载并解压美颜 SDK，然后将 SDK 中如下文件添加到秀场直播示例项目对应的文件路径下：

    |用途 |SDK 文件    |  项目路径   |
    |----|-----|-----|
    | 基础美颜| iOS/include/*.h | iOS/SenseLib/*.h  |
    | 基础美颜| iOS/libs/ios_os-universal/libst_mobile.a  |iOS/SenseLib/libst_mobile.a     |
    | 基础美颜| iOS/models/model.bundle   | iOS/SenseLib/model.bundle   |
    | 美颜贴纸| iOS/samples/SenseMeEffects/SenseMeEffects/datasource/resources/StickerZipAndIcons/lianxingface.zip   | iOS/SenseLib/sticker_face_shape/lianxingface.zip   |
    | 风格妆| Android/smaple/SenseMeEffects/app/src/main/assets/style_lightly/qise.zip | iOS/SenseLib/style_ligthly/qise.zip   |
    | 风格妆| Android/smaple/SenseMeEffects/app/src/main/assets/style_lightly/wanneng.zip  | iOS/SenseLib/style_ligthly/wanneng.zip   |
    | 证书| 商汤证书SENSEME.lic   | iOS/AgoraEntScenarios/Scenes/Show/Beauty/SenseBeaufy/SENSEME.lic     |



## 配置示例项目

1. 运行秀场直播项目前，你需要在 `iOS/AgoraEntScenarios/KeyCenter.swift` 文件中设置如下参数：

    ```shell
    static let AppId: String = <#YOUR APPID#>
    static let Certificate: String? = <#YOUR Certificate#>
    static let CloudPlayerKey: String? = nil
    static let CloudPlayerSecret: String? = nil
    ```

    你可以在[创建声网项目](#create)后，从控制台获取这些参数的值，详情如下：

    | 参数 | 描述   | 获取方式 |
    |----|----|----|
    | AppId    | 声网项目的 App ID     | [获取 App ID](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id)  |
    | Certificate | 声网项目的 App 证书 |[获取 App 证书](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-证书)   |
    | CloudPlayerKey | 声网输入在线媒体流 RESTful 服务所需的客户 ID       | [生成客户 ID 和密钥](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#生成客户-id-和密钥)    |
    | CloudPlayerSecret | 声网输入在线媒体流 RESTful 服务所需的客户密钥   | [生成客户 ID 和密钥](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#生成客户-id-和密钥)   |


2. 在 `agora-ent-sceanrios/iOS` 目录下运行 `pod install`，然后等待依赖库安装完成。


## 编译并运行示例项目

![](https://web-cdn.agora.io/docs-files/1685431554693)

1. 连接上 iOS 设备后，点击 `AgoraEntScenarios.xcworkspace` 文件以通过 Xcode 打开项目，并在 **iOS Device** 选项中勾选上你的 iOS 设备。

2. 在项目 **TARGETS** 下的 **Signing & Capabilities** 界面勾选 **Automatically manage signing**，配置你的苹果开发者账号和 **Bundle Identifier**。Bundle ID 用于在设备上唯一标识应用程序。在开发应用时，你需要设置 Bundle ID。在此处设置的 Bundle ID 需要与你申请商汤美颜 SDK 时提供的 Bundle ID 一致。

3. 点击 <img src="https://web-cdn.agora.io/docs-files/1639710560035" width="25"/> 开始编译。

4. 编译成功后，你的 iOS 设备上会出现**声动互娱**应用。在 iOS 系统设置中将该应用设为信任开发者后你才能打开应用。

5. 打开**声动互娱**应用，点击**秀场直播**，即可进行体验。主播可以创建房间；观众可以加入房间。

![](https://web-cdn.agora.io/docs-files/1684826793571)

## 常见问题

### 签名报错

使用 Xcode 14 编译失败，遇到 **Signing for "SenseLib-SenseLib" requires a developement team** 的签名报错，如下面截图所示：

![](https://web-cdn.agora.io/docs-files/1685614210647)

### 解决方案

你可以通过在 Terminal 中执行如下命令将 CocoaPods 升级到 1.12.0 以上解决报错。

```shell
sudo gem install -n /usr/local/bin cocoapods
```

### 备选解决方案

如果遇到 CocoaPods 升级失败，你还可以通过手动给第三方库签名来解决报错。将 **Signing > Team** 设置为你的开发团队即可。