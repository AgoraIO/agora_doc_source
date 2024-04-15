声网在 GitHub 上提供一个开源的 [MetaWorld](https://github.com/AgoraIO-Community/Agora-MetaWorld/tree/dev_metasdk1.0) 示例项目供你参考。

本文介绍如何快速跑通该示例项目，体验效果。

## 前提条件

- [Git](https://git-scm.com/downloads)
- [CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started)
- [Xcode](https://apps.apple.com/cn/app/xcode/id497799835?mt=12) 12.0 及以上
- iOS 设备，版本 11.0 及以上
    <div class="alert note">声网推荐使用真机运行项目。部分模拟机可能存在功能缺失或者性能问题。</div>
- 有效的苹果开发者账号
- 有效的[声网账号](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E5%88%9B%E5%BB%BA%E5%A3%B0%E7%BD%91%E8%B4%A6%E5%8F%B7)

## 创建声网项目

1. 进入声网控制台的[项目管理](https://console.agora.io/projects)页面。

2. 在项目管理页面，点击**创建**按钮。

3. 在弹出的对话框内输入项目名称、使用场景，然后选择**安全模式：** **APP ID + Token**。

4. 点击**提交**按钮。新建的项目会显示在项目管理页中。

## 获取示例项目

1. 运行以下命令克隆仓库到本地：

```shell
git clone git@github.com:AgoraIO-Community/Agora-MetaWorld.git
```

2. 运行以下命令切换到 `dev_metasdk1.0` 分支：

```shell
git checkout dev_metasdk1.0
```

## 配置示例项目

### 集成 SDK 及依赖库

1. 联系 [sales@agora.io](mailto:sales@agora.io) 获取 Meta SDK，下载并解压。

2. 将 SDK 包内 `libs` 及路径下的文件，拷贝到示例项目的 `./Agora-MetaWorld/ios/sdk/` 路径下。

3. 在 `Agora-MetaWorld/ios` 目录下运行 `pod install`，然后等待依赖库安装完成。


### 设置 ID 和证书

运行示例项目前，你需要在 `./Agora-MetaWorld/ios/MetaChatDemo/KeyCenter.swift` 文件中设置如下参数：

```shell
@objc static let CHANNEL_ID: String = "<#ChannelId#>"
@objc static let APP_ID: String = "<#AppId#>"
@objc static let certificate: String = "<#Certificate#>"
@objc static let FACE_CAPTURE_APP_ID: String = "<#Face Capture App Id#>"
@objc static let FACE_CAPTURE_CERTIFICATE: String = "<#Face Capture Certificate#>"
...
@objc static let RTC_UID: UInt = "<#UID#>"
...
@objc static let kUserKey: String = "<#kUserKey#>"
@objc static let kUserSecret: String = "<#kUserSecret#>"
```

在创建声网项目后，从控制台获取这些参數的值，详情如下：

| 参数  |  描述  | 获取方式 |
| ---- | ------ | ------ |
| AppId    | 声网项目的 App ID     | [获取 App ID](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-id)  |
| Certificate | 声网项目的 App 证书 | [获取 App 证书](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#获取-app-证书)   |
| Face Capture App Id<br>Face Capture Certificate | 声网面部捕捉插件 | 联系 [sales@agora.io](mailto:sales@agora.io) 获取 |
| kUserKey<br>kUserSecret | 客户 ID 和密钥，声网 RESTful API 使用客户 ID 和客户密钥进行 HTTP 基本认证 | [生成客户 ID 和密钥](https://docportal.shengwang.cn/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms#%E7%94%9F%E6%88%90%E5%AE%A2%E6%88%B7-id-%E5%92%8C%E5%AF%86%E9%92%A5) |

<div class="alert info"><code>CHANNEL_ID</code> 设置为任意字符串，<code>RTC_UID</code> 设置为 0 以外的任意 Int 值。</div>


## 编译并运行示例项目

![](https://web-cdn.agora.io/docs-files/1686540295452)

1. 点击 `MetaChatDemo.xcworkspace` 文件通过 Xcode 打开项目。

2. 通过 USB 线将你的 iOS 设备接入电脑，并在 **iOS Device** 选项中勾选你的 iOS 设备。

3. 在项目 **TARGETS** 下的 **Signing & Capabilities** 界面勾选 **Automatically manage signing**，配置你的苹果开发者账号和 **Bundle Identifier**。Bundle ID 用于在设备上唯一标识应用程序。在开发应用时，你需要设置 Bundle ID。

4. 点击 <img src="https://web-cdn.agora.io/docs-files/1686540324207" width="25"/> 开始编译。

5. 编译成功后，你的 iOS 设备上会出现 **MetaChatDemo** 应用。在 iOS 系统设置中将该应用设为信任开发者后你才能打开应用。

6. 打开应用，体验 MetaWorld 场景。在登录界面的**请选择场景**字段可以自行选择**元语聊**或**元直播**场景。

<div class="alert info">MetaWorld 包含元语聊和元直播场景：<ul><li>在元语聊场景中，用户可以在 3D 场景中自由走动，与其他用户或 NPC 进行语音聊天，开始 K 歌等。</li><li>在元直播场景中，用户可以在 3D 场景中直播。声网面部捕捉插件使用户可以通过模拟脸部表情的 Avatar 形象进行直播，增加直播趣味性。</li><li>在融合元语聊和元直播的场景中，用户可以进行在元语聊和元直播场景中支持的所有操作。</li></ul></div>