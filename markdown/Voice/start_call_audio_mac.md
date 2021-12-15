---
title: 实现语音通话
platform: macOS
updatedAt: 2021-01-28 10:25:37
---

本文介绍如何使用 Agora 语音通话 SDK 快速实现语音通话。

## 示例项目

Agora 在 GitHub 上提供开源的实时语音通话示例项目 [Agora-macOS-Tutorial-Objective-C-1to1](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-macOS-Tutorial-Objective-C-1to1)/[Agora-macOS-Tutorial-Swift-1to1](https://github.com/AgoraIO/Basic-Video-Call/tree/master/One-to-One-Video/Agora-macOS-Tutorial-Swift-1to1)。在实现相关功能前，你可以下载并查看源代码。

## 前提条件

- Xcode 9.0 或以上版本
- 支持 macOS 10.10 或以上版本的 macOS 设备
- 有效的 Agora 账户（免费[注册](https://sso.agora.io/cn/signup)）

<div class="alert note">如果你的网络环境部署了防火墙，请根据<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms">应用企业防火墙限制</a>打开相关端口。</div>

## 准备开发环境

## 前提条件

- Xcode 9.0 或以上版本（本文 Xcode 的界面描述以 Xcode 11.0 为例）
- macOS 10.10 或以上版本的设备
- 有效的 [Agora 开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up?platform=macOS)

<div class="alert note">如果你的网络环境部署了防火墙，请参考<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=macOS">应用企业防火墙限制</a>以正常使用 Agora 服务。</div>

## 创建 macOS 项目

1. 打开 Xcode 并点击 **Create a new Xcode project**。

2. 选择平台类型为 **macOS**、项目类型为 **App**，并点击 **Next**。

3. 输入项目名称（Product Name）、开发团队信息（Team）、组织名称（Organization Name）和语言（Language）等项目信息，并点击 **Next**。

<div class="alert note">如果你没有添加过开发团队信息，会看到 <b>Add account…</b> 按钮。点击该按钮并按照屏幕提示登入 Apple ID，完成后即可选择你的 Apple 账户作为开发团队。</div>

4. 选择项目存储路径，并点击 **Create**。

## <a name="integrate_sdk"></a>获取 SDK

选择如下任意一种方式获取最新版 Agora macOS SDK。

<div class="alert info">如需集成 3.3.0 以下版本的 SDK，请查看<a href="#earlierversion">历史版本集成方式</a>。</div>

### 方法一：使用 CocoaPods 获取 SDK

1. 开始前确保你已安装 Cocoapods。参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。

2. 在终端里进入项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。

3. 打开 `Podfile` 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称。

```
# platform :macOS, '10.11' use_frameworks!
target 'Your App' do
  pod 'AgoraRtcEngine_macOS'
end
```

4. 在终端内运行 `pod install` 命令安装 SDK。成功安装后，Terminal 中会显示 `Pod installation complete!`，此时项目文件夹下会生成一个 `xcworkspace` 文件。

5. 打开新生成的 `xcworkspace` 文件。

### 方法二：从官网获取 SDK

1. 前往 [SDK 下载页面](./downloads?platform=macOS)，获取最新版的 Agora macOS SDK，然后解压。

2. 根据你的需求，将 `libs` 文件夹中的动态库复制到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。

 <div class="alert note">如果你不使用扩展功能（如 AI 降噪），则无需集成 <code>Extension</code> 为后缀的库。你可以在<a href="./release_mac_video?platform=macOS">发版说明</a >中查看扩展库对应的功能。</div>

3. 打开 Xcode，进入 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** 菜单。

4. 点击 **+** > **Add Other…** > **Add Files** 添加对应动态库，并确保添加的动态库 **Embed** 属性设置为 **Embed & Sign**。
   添加完成后，项目会自动链接所需系统库

    <div class="alert note"><ul><li>根据 Apple 官方要求，app 的 Extension 中不允许包含动态库。如果项目中的 Extension 需要集成 SDK，则添加动态库时需将文件状态改为 <b>Do Not Embed</b>。</li><li>Agora SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 sales@agora.io。SDK 提供的库是 FAT Image，包含 32/64 位模拟器、32/64 位真机版本。</li></ul></div>

## 实现语音通话

本节介绍如何实现语音通话。语音通话的 API 调用时序见下图：
![](https://web-cdn.agora.io/docs-files/1584694537986)

### 1. 创建用户界面

根据场景需要，为你的项目创建语音通话的用户界面。若已有用户界面，可以直接查看[导入类](#ImportClass)。

在语音通话中，我们推荐你添加如下 UI 元素：

- 语音通话窗口
- 退出频道按钮

当你使用示例项目中的 UI 设计时，你将会看到如下界面：

![](https://web-cdn.agora.io/docs-files/1584695135878)

### <a name="ImportClass"></a>2. 导入类

在项目中导入 `AgoraRtcKit` 类：

```objective-c
// Objective-C
// 自 3.0.0 版本，SDK 使用 AgoraRtcKit 类。
#import <AgoraRtcKit/AgoraRtcEngineKit.h>
// 在 3.0.0 版本以前，SDK 使用 AgoraRtcEngineKit 类。
#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h>
```

```swift
// Swift
// 自 3.0.0 版本，SDK 使用 AgoraRtcKit 类。
import AgoraRtcKit
// 在 3.0.0 版本以前，SDK 使用 AgoraRtcEngineKit 类。
import AgoraRtcEngineKit
```

<div class="alert note">Agora 语音通话 SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 sales@agora.io。SDK 提供的库是 Fat Image，包含 32/64 位模拟器、32/64 位真机版本。</div>

### 3. 初始化 AgoraRtcEngineKit

在调用其他 Agora API 前，需要创建并初始化 `AgoraRtcEngineKit` 对象。

你需要在该步骤中填入项目的 App ID。请参考如下步骤在控制台[创建 Agora 项目](https://docs.agora.io/cn/Agora%20Platform/manage_projects?platform=All%20Platforms)并获取 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id)。

1. 登录[控制台](https://console.agora.io/)，点击左侧导航栏的**[项目管理](https://console.agora.io/projects)**图标 ![](https://web-cdn.agora.io/docs-files/1551254998344)。
2. 点击**创建**，按照屏幕提示设置项目名，选择一种鉴权机制，然后点击**提交**。
3. 在**项目管理**页面，你可以获取该项目的 **App ID**。

调用 `sharedEngineWithAppId` 方法，传入获取到的 App ID，即可初始化 `AgoraRtcEngineKit`。

你还可以根据场景需要，在初始化时注册想要监听的回调事件，如远端用户加入频道或离开频道等。

```objective-c
// Objective-C
- (void)initializeAgoraEngine {
    // 输入 App ID 并初始化 AgoraRtcEngineKit 类
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:appID delegate:self];
}
```

```swift
// Swift
func initializeAgoraEngine() {
   // 输入 App ID 并初始化 AgoraRtcEngineKit 类。
   agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: AppID, delegate: self)
}
```

### 4. 加入频道

完成初始化后，你就可以调用 `joinChannelByToken` 方法加入频道。你需要在该方法中传入如下参数：

- `channelId`: 传入能标识频道的频道 ID。输入频道 ID 相同的用户会进入同一个频道。
- `token`：传入能标识用户角色和权限的 Token。可设为如下一个值：

  - `nil`
  - 控制台中生成的临时 Token。一个临时 Token 的有效期为 24 小时，详情见[获取临时 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#%E8%8E%B7%E5%8F%96%E4%B8%B4%E6%97%B6-token)。
  - 你的服务器端生成的正式 Token。适用于对安全要求较高的生产环境，详情见[生成 Token](./token_server)。

  <div class="alert note">若项目已启用 App 证书，请使用 Token。</div>

- `uid`: 本地用户的 ID。数据类型为整型，且频道内每个用户的 `uid` 必须是唯一的。若将 `uid` 设为 0，则 SDK 会自动分配一个 `uid`，并在 `joinSuccessBlock` 回调中报告。
- `joinSuccessBlock`：成功加入频道回调。`joinSuccessBlock` 优先级高于 `didJoinChannel`，2 个同时存在时，`didJoinChannel` 会被忽略。 需要有 `didJoinChannel` 回调时，请将 `joinSuccessBlock` 设置为 `nil`。

更多的参数设置注意事项请参考 [joinChannelByToken](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:) 接口中的参数描述。

```objective-c
// Objective-C
- (void)joinChannel {
    // 加入频道
    [self.agoraKit joinChannelByToken:token channelId:@"demoChannel1" info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
    }];
}
```

```swift
// Swift
func joinChannel() {
    // 加入频道
    agoraKit.joinChannel(byToken: Token, channelId: "demoChannel1", info:nil, uid:0) { [unowned self] (channel, uid, elapsed) -> Void in}
    self.logVC?.log(type: .info, content: "did join channel")
    }
    isStartCalling = true
}
```

### 5. 离开频道

根据场景需要，如结束通话、关闭 App 或 App 切换至后台时，调用 `leaveChannel` 离开当前通话频道。

```objective-c
// Objective-C
- (void)leaveChannel {
    // 离开频道。
    [self.agoraKit leaveChannel:^(AgoraChannelStats *stat)
}
```

```swift
// Swift
func leaveChannel() {
// 离开频道
 AgoraKit.leaveChannel(nil)
 AgoraKit = nil
 view.window!.close()
 }
```

### 示例代码

你可以在 Agora-macOS-Tutorial-Objective-C-1to1/Agora-macOS-Tutorial-Swift-1to1 示例项目的 [VideoChatViewController.m](https://github.com/AgoraIO/Basic-Video-Call/blob/master/One-to-One-Video/Agora-macOS-Tutorial-Objective-C-1to1/Agora%20Mac%20Tutorial%20Objective-C/VideoChat/VideoChatViewController.m)/[VideoChatViewController.swift](https://github.com/AgoraIO/Basic-Video-Call/blob/master/One-to-One-Video/Agora-macOS-Tutorial-Swift-1to1/Agora%20Mac%20Tutorial%20Swift/VideoChat/VideoChatViewController.swift) 文件中查看完整的源码和代码逻辑。

## 运行项目

你可以在 macOS 设备中运行此项目。当成功开始语音通话时，你和远端用户可听到彼此的声音。

## 相关链接

如果你需要实现一对多群聊场景，可以前往 GitHub 下载 [OpenVideoCall-macOS](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-macOS) 示例项目，或查看源代码。
