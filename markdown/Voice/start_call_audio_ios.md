---
title: 实现语音通话
platform: iOS
updatedAt: 2021-01-28 10:25:18
---
本文介绍如何使用 Agora 语音通话 SDK 快速实现语音通话。

## 快速跑通示例项目

如果你是第一次使用声网的服务，我们推荐观看下面的视频，了解关于声网服务的基本信息以及如何快速跑通示例项目。

<div class="alert info">点击参与<a href="https://www.wenjuan.com/s/7FbeEz6/" target="_blank">视频教程问卷调查</a>，帮助我们改进体验。</div>

<video src="https://web-cdn.agora.io/docs-files/1593742244429" poster="https://web-cdn.agora.io/docs-files/1597911607719"   controls width = 100% height = auto>你的浏览器不支持 <code>video</code> 标签。</video>

<div class="alert note">视频中展示的 UI 可能有部分调整更新，请以当前最新版为准。</div>

## 前提条件

- Xcode 9.0 或以上版本（本文 Xcode 的界面描述以 Xcode 11.0 为例）
- 支持 iOS 8.0 或以上版本的 iOS 设备
- 有效的 [Agora 开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up?platform=iOS)

<div class="alert note">如果你的网络环境部署了防火墙，请参考<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=iOS">应用企业防火墙限制</a>以正常使用 Agora 服务。</div>

## 创建 iOS 项目

1. 打开 Xcode 并点击 **Create a new Xcode project**。

2. 选择项目类型为 **Single View App**，并点击 **Next**。

3. 输入项目名称（Product Name）、开发团队信息（Team）、组织名称（Organization Name）和语言（Language）等项目信息，并点击 **Next**。

   <div class="alert note">如果你没有添加过开发团队信息，会看到 <b>Add account…</b> 按钮。点击该按钮并按照屏幕提示登入 Apple ID，完成后即可选择你的 Apple 账户作为开发团队。</div>

4. 选择项目存储路径，并点击 **Create**。

## 获取 SDK

选择如下任意一种方式获取最新版 Agora iOS SDK。

<div class="alert info">如需集成 3.2.0 以下版本的 SDK，请查看<a href="#earlierversion">历史版本集成方式</a>。</div>

### 方法一：使用 CocoaPods 获取 SDK

1. 开始前确保你已安装 Cocoapods。参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。

2. 在终端里进入项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。

3. 打开 `Podfile` 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称。


```
# platform :ios, '9.0' use_frameworks!
target 'Your App' do
    pod 'AgoraRtcEngine_iOS'
end
```


4. 在终端内运行 `pod`` install` 命令安装 SDK。成功安装后，Terminal 中会显示 `Pod installation complete!`，此时项目文件夹下会生成一个 `xcworkspace` 文件。

5. 打开新生成的 `xcworkspace` 文件。

### 方法二：从官网获取 SDK

1. 前往 [SDK 下载页面](https://docs.agora.io/cn/All/downloads?platform=iOS)，获取最新版的 Agora iOS SDK，然后解压。

2. 根据你的需求，选择以下一种方法将 `AgoraRtcKit.framework`、`Agorafdkaac.framework`、`Agoraffmpeg.framework` 和 `AgoraSoundTouch.framework` 动态库复制到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。

   a. 如果无需使用模拟器运行项目，复制 SDK 包中 `./libs` 路径下的上述动态库。

   b. 如需使用模拟器运行项目，复制 SDK 包中 `./libs/ALL_ARCHITECTURE` 路径下的上述动态库。
   该路径下的动态库包含 x86_64 架构，会影响 app 在 App Store 的发布，处理方法见[发布注意事项](#distribution)。

3. 打开 Xcode，进入 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** 菜单。

4. 点击 **+** > **Add Other…** > **Add Files** 添加 `AgoraRtcKit.framework`、`Agorafdkaac.framework`、`Agoraffmpeg.framework` 和 `AgoraSoundTouch.framework` 动态库，并确保添加的动态库 **Embed** 属性设置为 **Embed & Sign**。

   添加完成后，项目会自动链接所需系统库。

    <div class="alert note">根据 Apple 官方要求，app 的 Extension 中不允许包含动态库。如果项目中的 Extension 需要集成 SDK，则添加动态库时需将文件状态改为 <b>Do Not Embed</b>。</div>

## 配置项目

### 设置签名和开发团队

1. 在 Xcode 中，进入 **TARGETS** > **Project Name** > **Signing & Capabilities** > **Signing** 菜单，勾选 **Automatically manage signing。**
2. 仔细阅读弹窗提示，并点击 **Enable Automatic**。
3. 成功设置签名后，在 **Team** 处选择你的开发团队。

### 添加设备权限

在 Xcode 中，打开 `info.plist` 文件。在右侧列表中添加如下内容，获取相应的设备权限：


| Key                                    | Type   | Value                                                        |
| :------------------------------------- | :----- | :----------------------------------------------------------- |
| Privacy - Microphone Usage Description | String | 使用麦克风的目的，例如：for a call or live interactive streaming。 |
| Privacy - Camera Usage Description     | String | 使用摄像头的目的，例如：for a call or live interactive streaming。 |


<div class="alert note">iOS 14.0 版本新增了 <b>Privacy - Local Network Usage Description</b> 权限。如果使用 3.1.2 之前版本的 SDK，你需要添加该权限。详见 <a href="https://docs.agora.io/cn/faq/local_network_privacy">解决方案</a >。</div>

## 示例项目

Agora 在 GitHub 上提供开源的实时语音通话示例项目 [Agora-iOS-Voice-Tutorial-Swift-1to1](https://github.com/AgoraIO/Basic-Audio-Call/tree/master/One-to-One-Voice/Agora-iOS-Voice-Tutorial-Swift-1to1)。在实现相关功能前，你可以下载并查看源代码。

## 前提条件

- Xcode 9.0 或以上版本（本文 Xcode 的界面描述以 Xcode 11.0 为例）
- 支持 iOS 8.0 或以上版本的 iOS 设备
- 有效的 [Agora 开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up?platform=iOS)

<div class="alert note">如果你的网络环境部署了防火墙，请参考<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=iOS">应用企业防火墙限制</a>以正常使用 Agora 服务。</div>

## 创建 iOS 项目

1. 打开 Xcode 并点击 **Create a new Xcode project**。

2. 选择项目类型为 **Single View App**，并点击 **Next**。

3. 输入项目名称（Product Name）、开发团队信息（Team）、组织名称（Organization Name）和语言（Language）等项目信息，并点击 **Next**。

   <div class="alert note">如果你没有添加过开发团队信息，会看到 <b>Add account…</b> 按钮。点击该按钮并按照屏幕提示登入 Apple ID，完成后即可选择你的 Apple 账户作为开发团队。</div>

4. 选择项目存储路径，并点击 **Create**。

## 获取 SDK

选择如下任意一种方式获取最新版 Agora iOS SDK。

<div class="alert info">如需集成 3.2.0 以下版本的 SDK，请查看<a href="#earlierversion">历史版本集成方式</a>。</div>

### 方法一：使用 CocoaPods 获取 SDK

1. 开始前确保你已安装 Cocoapods。参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。

2. 在终端里进入项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。

3. 打开 `Podfile` 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称。


```
# platform :ios, '9.0' use_frameworks!
target 'Your App' do
    pod 'AgoraAudio_iOS'
end
```


4. 在终端内运行 `pod`` install` 命令安装 SDK。成功安装后，Terminal 中会显示 `Pod installation complete!`，此时项目文件夹下会生成一个 `xcworkspace` 文件。

5. 打开新生成的 `xcworkspace` 文件。

### 方法二：从官网获取 SDK

1. 前往 [SDK 下载页面](https://docs.agora.io/cn/All/downloads?platform=iOS)，获取最新版的 Agora iOS SDK，然后解压。

2. 根据你的需求，选择以下一种方法将 `AgoraRtcKit.framework`、`Agorafdkaac.framework`、`Agoraffmpeg.framework` 和 `AgoraSoundTouch.framework` 动态库复制到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。

   a. 如果无需使用模拟器运行项目，复制 SDK 包中 `./libs` 路径下的上述动态库。

   b. 如需使用模拟器运行项目，复制 SDK 包中 `./libs/ALL_ARCHITECTURE` 路径下的上述动态库。
   该路径下的动态库包含 x86_64 架构，会影响 app 在 App Store 的发布，处理方法见[发布注意事项](#distribution)。

3. 打开 Xcode，进入 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** 菜单。

4. 点击 **+** > **Add Other…** > **Add Files** 添加 `AgoraRtcKit.framework`、`Agorafdkaac.framework`、`Agoraffmpeg.framework` 和 `AgoraSoundTouch.framework` 动态库，并确保添加的动态库 **Embed** 属性设置为 **Embed & Sign**。

   添加完成后，项目会自动链接所需系统库。

    <div class="alert note">根据 Apple 官方要求，app 的 Extension 中不允许包含动态库。如果项目中的 Extension 需要集成 SDK，则添加动态库时需将文件状态改为 <b>Do Not Embed</b>。</div>

## 配置项目

### 设置签名和开发团队

1. 在 Xcode 中，进入 **TARGETS** > **Project Name** > **Signing & Capabilities** > **Signing** 菜单，勾选 **Automatically manage signing。**
2. 仔细阅读弹窗提示，并点击 **Enable Automatic**。
3. 成功设置签名后，在 **Team** 处选择你的开发团队。

### 添加设备权限

在 Xcode 中，打开 `info.plist` 文件。在右侧列表中添加如下内容，获取相应的设备权限：


| Key                                    | Type   | Value                                                        |
| :------------------------------------- | :----- | :----------------------------------------------------------- |
| Privacy - Microphone Usage Description | String | 使用麦克风的目的，例如：for a call or live interactive streaming。 |


<div class="alert note">iOS 14.0 版本新增了 <b>Privacy - Local Network Usage Description</b> 权限。如果使用 3.1.2 之前版本的 SDK，你需要添加该权限。详见 <a href="https://docs.agora.io/cn/faq/local_network_privacy">解决方案</a >。</div>

## 实现语音通话

本节介绍如何实现语音通话。语音通话的 API 调用时序见下图：

![](https://web-cdn.agora.io/docs-files/1584590910617)

### 1. 创建用户界面

根据场景需要，为你的项目创建语音通话的用户界面。若已有用户界面，可以直接查看[导入类](#ImportClass)。

在语音通话中，我们推荐你添加如下 UI 元素：

- 语音通话窗口
- 退出频道按钮
	
当你使用示例项目中的 UI 设计时，你将会看到如下界面：

![](https://web-cdn.agora.io/docs-files/1584592390009)
	
### <a name="ImportClass"></a>2. 导入类

在项目中导入 AgoraRtcKit 类：

```objective-c
// 自 3.0.0 版本，SDK 使用 AgoraRtcKit 类。
#import <AgoraRtcKit/AgoraRtcEngineKit.h>
// 在 3.0.0 版本以前，SDK 使用 AgoraRtcEngineKit 类。
#import <AgoraRtcEngineKit/AgoraRtcEngineKit.h>
```

```swift
// 自 3.0.0 版本，SDK 使用 AgoraRtcKit 类。
import AgoraRtcKit
// 在 3.0.0 版本以前，SDK 使用 AgoraRtcEngineKit 类。
import AgoraRtcEngineKit
```

<div class="alert note">Agora Native SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 sales@agora.io。SDK 提供的库是 Fat Image，包含 32/64 位模拟器、32/64 位真机版本。</div>


### 3. 初始化 AgoraRtcEngineKit

在调用其他 Agora API 前，需要创建并初始化 `AgoraRtcEngineKit` 对象。

调用 `sharedEngineWithAppId` 方法，传入获取到的 App ID，即可初始化 `AgoraRtcEngineKit`。

你还可以根据场景需要，在初始化时注册想要监听的回调事件，如远端用户加入频道或离开频道等。

```objective-c
// Objective-C
- (void)initializeAgoraEngine {
    // 输入 App ID 并初始化 AgoraRtcEngineKit 类。
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
- channelId: 传入能标识频道的频道 ID。输入频道 ID 相同的用户会进入同一个频道。
- token: 传入能标识用户角色和权限的 Token。你可以设置如下值：
	- `nil`。
	- 控制台中生成的临时 Token。一个临时 Token 的有效期为 24 小时，详情见[获取临时 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#get-a-temporary-token)。
	- 你的服务器端生成的正式 Token。适用于对安全要求较高的生产环境，详情见[生成 Token](./token_server)。

 <div class="alert note">若项目已启用 App 证书，请使用 Token。</div>

- uid: 本地用户的 ID。数据类型为整型，且频道内每个用户的 `uid` 必须是唯一的。若将 `uid` 设为 0，则 SDK 会自动分配一个 `uid`，并在 `joinSuccessBlock` 回调中报告。

 <div class="alert note">用户成功加入频道后，会默认订阅频道内其他所有用户的音频流，因此产生用量并影响计费。如果想取消订阅，可以通过调用相应的 <tt>mute</tt> 方法实现。</div>
 
- joinSuccessBlock：成功加入频道回调。`joinSuccessBlock` 优先级高于 `didJoinChannel`，2 个同时存在时，`didJoinChannel` 会被忽略。 需要有 `didJoinChannel` 回调时，请将 `joinSuccessBlock` 设置为 `nil`。

更多的参数设置注意事项请参考 [joinChannelByToken](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:) 接口中的参数描述。

```objective-c
// Objective-C
- (void)joinChannel {
    // 加入频道。
    [self.agoraKit joinChannelByToken:token channelId:@"demoChannel1" info:nil uid:0 joinSuccess:^(NSString *channel, NSUInteger uid, NSInteger elapsed) {
    }];
}
```

```swift
// Swift
func joinChannel() {
    // 加入频道。
    agoraKit.joinChannel(byToken: Token, channelId: "demoChannel1", info:nil, uid:0) { [unowned self] (channel, uid, elapsed) -> Void in}
    self.logVC?.log(type: .info, content: "did join channel")
    }
    isStartCalling = true
}
```
		
### 5. 离开频道

根据场景需要，如结束通话、关闭 app 或 app 切换至后台时，调用 `leaveChannel` 离开当前通话频道。

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
        // 离开频道。
        agoraKit.leaveChannel(nil)
        isStartCalling = false
        self.logVC?.log(type: .info, content: "did leave channel")
    }
```

## 运行项目
你可以在 iOS 设备中运行此项目。当成功开始语音通话时，你和远端用户可听到彼此的声音。

## 相关链接

如果你需要实现一对多群聊场景，可以前往 GitHub 下载以下示例项目，或查看源代码。

- Swift 项目: [OpenVoiceCall-iOS](https://github.com/AgoraIO/Basic-Audio-Call/tree/master/Group-Voice-Call/OpenVoiceCall-iOS)，参考 [RoomViewController.swift](https://github.com/AgoraIO/Basic-Audio-Call/blob/master/Group-Voice-Call/OpenVoiceCall-iOS/OpenVoiceCall/RoomViewController.swift) 中的代码。
- Objective-C 项目: [OpenVoiceCall-iOS-Objective-C](https://github.com/AgoraIO/Basic-Audio-Call/tree/master/Group-Voice-Call/OpenVoiceCall-iOS-Objective-C)，参考 [RoomViewController.m](https://github.com/AgoraIO/Basic-Audio-Call/blob/master/Group-Voice-Call/OpenVoiceCall-iOS-Objective-C/OpenVoiceCall-iOS-Objective-C/RoomViewController.m) 中的代码。

使用 Agora 语音通话 SDK 开发过程中，你还可以参考如下文档：

- [如何设置日志文件？](https://docs.agora.io/cn/faq/logfile)
- [为什么在运行集成 RTC SDK 的 iOS app 时会看到查找本地网络设备的弹窗提示？](https://docs.agora.io/cn/faq/local_network_privacy)