---
title: 实现视频直播
platform: iOS
updatedAt: 2020-12-18 08:47:48
---

本文介绍如何使用 Agora SDK 快速实现视频直播。

## 前提条件

- Xcode 9.0 或以上版本（本文 Xcode 的界面描述以 Xcode 11.0 为例）
- iOS 8.0 或以上版本的设备
- 有效的 [Agora 开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up?platform=iOS)

<div class="alert note">如果你的网络环境部署了防火墙，请参考<a href="https://docs.agora.io/cn/Agora%20Platform/firewall?platform=iOS">应用企业防火墙限制</a>以正常使用 Agora 服务。</div>

## 创建 iOS 项目

1. 打开 Xcode 并点击 **Create a new Xcode project**。

2. 选择平台类型为 **iOS**、项目类型为 **Single View App**，并点击 **Next**。

3. 输入项目名称（Product Name）、开发团队信息（Team）、组织名称（Organization Name）和语言（Language）等项目信息，并点击 **Next**。

<div class="alert note">如果你没有添加过开发团队信息，会看到 <b>Add account…</b> 按钮。点击该按钮并按照屏幕提示登入 Apple ID，完成后即可选择你的 Apple 账户作为开发团队。</div>

4. 选择项目存储路径，并点击 **Create**。

## <a name="integrate_sdk"></a>获取 SDK

选择如下任意一种方式获取最新版 Agora iOS SDK。

<div class="alert info">如需集成 3.3.0 以下版本的 SDK，请查看<a href="#earlierversion">历史版本集成方式</a>。</div>

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

4. 在终端内运行 `pod install` 命令安装 SDK。成功安装后，Terminal 中会显示 `Pod installation complete!`，此时项目文件夹下会生成一个 `xcworkspace` 文件。

5. 打开新生成的 `xcworkspace` 文件。

### 方法二：从官网获取 SDK

1. 前往 [SDK 下载页面](./downloads?platform=iOS)，获取最新版的 Agora iOS SDK，然后解压。

2. 根据你的需求，将 `libs` 文件夹中的动态库复制到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。

 <div class="alert note">如果你不使用扩展功能（如 AI 降噪），则无需集成 <code>Extension</code> 为后缀的库。你可以在<a href="./release_ios_video?platform=iOS">发版说明</a >中查看扩展库对应的功能。</div>

3. 打开 Xcode，进入 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** 菜单。

4. 点击 **+** > **Add Other…** > **Add Files** 添加对应动态库，并确保添加的动态库 **Embed** 属性设置为 **Embed & Sign**。
   添加完成后，项目会自动链接所需系统库。

  <div class="alert note"><ul><li>根据 Apple 官方要求，app 的 Extension 中不允许包含动态库。如果项目中的 Extension 需要集成 SDK，则添加动态库时需将文件状态改为 <b>Do Not Embed</b>。</li><li>Agora SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 sales@agora.io。SDK 提供的库是 FAT Image，包含 32/64 位模拟器、32/64 位真机版本。</li></ul></div>

## 基本流程

本节介绍如何实现视频直播。视频直播的 API 调用时序见下图：

![](https://web-cdn.agora.io/docs-files/1608274496401)

### 1. 创建用户界面

根据场景需要，为你的项目创建视频直播的用户界面。我们推荐你在项目中添加主播的视频窗口，你可以参考以下代码创建一个基础的用户界面。

```swift
// Swift
// ViewController.swift
// 导入 UIKit
import UIKit

class ViewController: UIViewController {

    // 定义 localView 变量
    var localView: UIView!
    // 定义 remoteView 变量
    var remoteView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // 调用初始化视频窗口函数
        initView()
        // 后续步骤调用 Agora API 使用的函数
        initializeAgoraEngine()
        setChannelProfile()
        setClientRole()
        setupLocalVideo()
        joinChannel()
    }

    // 设置视频窗口布局
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        remoteView.frame = self.view.bounds
        localView.frame = CGRect(x: self.view.bounds.width - 90, y: 0, width: 90, height: 160)
    }

    func initView() {
        // 初始化远端视频窗口。只有当远端用户为主播时，才会显示视频画面。
        remoteView = UIView()
        self.view.addSubview(remoteView)

        // 初始化本地视频窗口。只有当本地用户为主播时，才会显示视频画面。
        localView = UIView()
        self.view.addSubview(localView)
    }
}
```

```objective-c
// Objective-C
// ViewController.m
// 导入 UIKit
#import <UIKit/UIKit.h>

@interface ViewController ()
// 定义 localView 变量
@property (nonatomic, strong) UIView *localView;
// 定义 remoteView 变量
@property (nonatomic, strong) UIView *remoteView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 调用初始化视频窗口函数
    [self initViews];
    // 后续步骤调用 Agora API 使用的函数
    [self initializeAgoraEngine];
    [self setupLocalVideo];
    [self joinChannel];
}

// 设置视频窗口布局
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.remoteView.frame = self.view.bounds;
    self.localView.frame = CGRectMake(self.view.bounds.size.width - 90, 0, 90, 160);
}

- (void)initViews {
    // 初始化远端视频窗口。只有当远端用户为主播时，才会显示视频画面。
    self.remoteView = [[UIView alloc] init];
    [self.view addSubview:self.remoteView];
    // 初始化本地视频窗口。只有当本地用户为主播时，才会显示视频画面。
    self.localView = [[UIView alloc] init];
    [self.view addSubview:self.localView];
}
```

### <a name="ImportClass"></a>2. 导入类

在调用 Agora API 前，你需要在项目中导入 `AgoraRtcKit` 类，并定义一个 `agoraKit` 变量。

```swift
// Swift
// ViewController.swift
// 导入 AgoraRtcKit 类。
// 自 3.0.0 版本起，AgoraRtcEngineKit 类名更换为 AgoraRtcKit。
// 如果你使用 3.0.0 以下版本的 SDK，你需要将示例代码中的 import AgoraRtcKit 替换为 import AgoraRtcEngineKit。
import AgoraRtcKit

class ViewController: UIViewController {

    ...

    // 定义 agoraKit 变量。
    var agoraKit: AgoraRtcEngineKit?
}
```

```objective-c
// Objective-C
// ViewController.h
// 导入 AgoraRtcKit 类。
// 自 3.0.0 版本起，AgoraRtcEngineKit 类名更换为 AgoraRtcKit。
// 如果你使用 3.0.0 以下版本的 SDK，你需要将示例代码中的 AgoraRtcKit 替换为 AgoraRtcEngineKit。
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

// 声明 AgoraRtcEngineDelegate，用于监听回调。
@interface ViewController : UIViewController <AgoraRtcEngineDelegate>

// 定义 agoraKit 变量。
@property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;
```

### 3. 初始化 AgoraRtcEngineKit 对象

调用 `sharedEngineWithAppId` 创建并初始化 `AgoraRtcEngineKit` 对象。你需要将 `YourAppID` 替换为你的 Agora 项目的 App ID。详见[获取 App ID](./run_demo_video_call_ios?platform=iOS#appid)。

你还可以根据场景需要，在初始化时注册想要监听的回调事件。

```swift
// Swift
// ViewController.swift
func initializeAgoraEngine() {
       agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "YourAPPID", delegate: self)
    }
```

```objective-c
// Objective-C
// ViewController.m
- (void)initializeAgoraEngine {
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:@"YourAppID" delegate:self];
}
```

### 4. 设置频道场景

调用 `setChannelProfile` 方法，将频道场景设为直播。

一个 `AgoraRtcEngineKit` 只能使用一种频道场景。如果想切换为其他频道场景，需要先调用 `destroy` 方法销毁当前的 `AgoraRtcEngineKit` 对象，然后使用 `sharedEngineWithAppId` 方法创建一个新的对象，再调用 `setChannelProfile` 设置新的频道场景。

```swift
// Swift
// ViewController.swift
func setChannelProfile(){
agoraKit?.setChannelProfile(.liveBroadcasting)
}
```

```objective-c
// Objective-C
// ViewController.m
- (void)setChannelProfile {
[self.agoraKit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
}
```

### 5. 设置用户角色和用户级别

直播频道中可设置用户角色和用户级别：

- 用户角色 (role) 确定用户在 SDK 层的权限，包含是否可以发流、是否可以收流等。直播频道有两种用户角色：主播和观众。主播既有发流权限，又有收流权限，而观众只有收流权限。默认的角色为观众。
- 用户级别 (level) 需要与用户角色结合使用，确定用户在其角色权限范围内可以操作和享受到的服务级别。例如对于观众，可以选择接收低延时还是超低延时的视频流。**不同的级别会影响计费**。

你可以在 app 中参考如下步骤设置用户角色：

(1) 让终端用户选择自己的角色是主播还是观众。

(2) 调用 [`setClientRole`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setClientRole:options:) 方法，然后根据终端用户的选择设置 `role` 和 `options` 参数。

- 当 `role` 设为 `AgoraClientRoleBroadcaster`（主播）时， `options` 参数留空。此时主播端延时为 < 400 ms。
- 当 `role` 设为 `AgoraClientRoleAudience`（观众）时，你还需要将 `options` 中 `audienceLatencyLevel` 参数设为 `AgoraAudienceLatencyLevelLowLatency`。此时观众端延时为 1500 ms - 2000 ms。

<div class="alert note"><li>如果观众级别从 <code>AgoraAudienceLatencyLevelLowLatency</code>（低延时）切换为 <code>AgoraAudienceLatencyLevelUltraLowLatency</code>（超低延时），会从极速直播产品切换为互动直播产品，延时会变为 400 ms - 800 ms。</li><li>如果用户角色从 <code>AgoraClientRoleAudience</code>（观众）切换为 <code>AgoraClientRoleBroadcaster</code>（主播），会从极速直播产品切换为互动直播产品，延时会低于 400 ms。</li><li>当接收端为观众且用户级别为 <code>AgoraAudienceLatencyLevelLowLatency</code> 时，<code>RemoteAudioStats</code> 中的 <code>jitterBufferDelay</code> 字段（接收端到网络抖动缓冲的网络延迟）不生效。</li></div>

主播：

```swift
//Swift
// ViewController.swift
// 设置用户角色为主播。
agoraKit.setClientRole(.broadcaster, options: nil)
```

观众：

```swift
//Swift
// ViewController.swift
// 设置观众级别为低延时
let options: AgoraClientRoleOptions = AgoraClientRoleOptions()
options.audienceLatencyLevel = AgoraAudienceLatencyLevelType.lowLatency
// 设置用户角色为观众
agoraKit.setClientRole(.audience, options: options)
```

### 6. 设置本地视图

在加入频道前设置本地视图，以便主播在直播中看到本地图像。参考以下步骤设置本地视图：

(1) 调用 `enableVideo` 方法启用视频模块。
(2) 调用 `setupLocalVideo` 方法设置本地视图。

```swift
// Swift
// ViewController.swift 文件
func setupLocalVideo() {
    // 启用视频模块
    agoraKit?.enableVideo()

    let videoCanvas = AgoraRtcVideoCanvas()
    videoCanvas.uid = 0
    videoCanvas.renderMode = .hidden
    videoCanvas.view = localView
    // 设置本地视图
    agoraKit?.setupLocalVideo(videoCanvas)
    }
```

```objective-c
// Objective-C
// ViewController.m 文件
- (void)setupLocalVideo {
// 启用视频模块
[self.agoraKit enableVideo];

AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
videoCanvas.uid = 0;
videoCanvas.renderMode = AgoraVideoRenderModeHidden;
videoCanvas.view = self.localView;
// 设置本地视图
[self.agoraKit setupLocalVideo:videoCanvas];
}
```

### <a name="JoinChannel"></a>7. 加入频道

调用 `joinChannelByToken` 加入频道。
在 `joinChannelByToken` 中你需要将 `YourToken` 替换成你自己生成的 Token，并将 `YourChannelName` 替换为你生成 Token 时填入的频道名称。

- 在测试阶段，你可以直接在控制台[生成临时 Token](./run_demo_live_video_ios?platform=iOS#temptoken)。
- 在生产环境，我们推荐你在自己的服务端生成 Token，详见[在服务端生成 Token](./token_server?platform=iOS)。

```swift
// Swift
// ViewController.swift
func joinChannel(){
        agoraKit?.joinChannel(byToken: "YourToken", channelId: "YourChannelName", info: nil, uid: 0, joinSuccess: { (channel, elapsed, uid) in
    })
}
```

```objective-c
// Objective-C
// ViewController.m
- (void)joinChannel {
    [self.agoraKit joinChannelByToken:@"YourToken" channelId:@"YourChannelName" info:nil uid:0 joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
}];
}
```

### 8. 设置远端视图

视频直播中，通常你也需要看到其他主播。

远端主播成功加入频道后，SDK 会触发 `firstRemoteVideoDecodedOfUid` 回调，该回调中会包含这个远端主播的 `uid` 信息。在该回调中调用 `setupRemoteVideo` 方法，传入获取到的 `uid`，设置远端主播的视图。

```swift
// Swift
// ViewController.swift 文件，需要在 class ViewController: UIViewController 函数之外添加以下代码
extension ViewController: AgoraRtcEngineDelegate {
    // 监听 firstRemoteVideoDecodedOfUid 回调
    // SDK 接收到第一帧远端视频并成功解码时，会触发该回调
    func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid: UInt, size: CGSize, elapsed: Int) {
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.renderMode = .hidden
        videoCanvas.view = remoteView
        // 设置远端视图
        agoraKit?.setupRemoteVideo(videoCanvas)
    }
}
```

```objective-c
// Objective-C
// ViewController.m
// 监听 firstRemoteVideoDecodedOfUid 回调
// SDK 接收到第一帧远端视频并成功解码时，会触发该回调
- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstRemoteVideoDecodedOfUid:(NSUInteger)uid size: (CGSize)size elapsed:(NSInteger)elapsed {
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = uid;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    videoCanvas.view = self.remoteView;
    // 设置远端视图
    [self.agoraKit setupRemoteVideo:videoCanvas];
}
```

### 9. 离开频道

根据场景需要，如结束直播、关闭 app 或 app 切换至后台时，调用 `leaveChannel` 离开当前直播频道。

```swift
// Swift
// ViewController.swift
func leaveChannel() {
        agoraKit?.leaveChannel(nil)
    }
```

```objective-c
// Objective-C
// ViewController.m
- (void)leaveChannel {
    [self.agoraKit leaveChannel:nil];
}
```

## 运行项目

你可以在 iOS 设备中运行此项目。当成功开始视频直播时，主播可以看到自己的画面；观众可以看到主播的画面。

## <a name="earlierversion"></a>历史版本集成方式

选择如下任意一种方式集成历史版本 Agora iOS SDK。

### 方法一：使用 CocoaPods 获取 SDK

1. 开始前确保你已安装 Cocoapods。参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。

2. 在终端里进入项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。

<% if (product == "audio") { %> 3. 打开 `Podfile` 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称，并将 `version` 替换为你需集成的 SDK 版本。如需了解 SDK 版本信息，查看[发版说明](./release_ios_audio?platform=iOS)。

```
# platform :ios, '9.0' use_frameworks!
target 'Your App' do
   pod 'AgoraAudio_iOS', 'version'
end
```

<% } if (product == "video") { %> 3. 打开 `Podfile` 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称，并将 `version` 替换为你需集成的 SDK 版本。如需了解 SDK 版本信息，查看[发版说明](./release_ios_video?platform=iOS)。

```
# platform :ios, '9.0' use_frameworks!
target 'Your App' do
   pod 'AgoraRtcEngine_iOS', 'version'
end
```

<% } %>

4. 在终端内运行 `pod install` 命令安装 Agora SDK。成功安装后，Terminal 中会显示 `Pod installation complete!`，此时项目文件夹下会生成一个 `xcworkspace` 文件。

5. 打开新生成的 `xcworkspace` 文件。

### 方法二：集成本地的 SDK

不同版本的 SDK 集成方式不同，点击下列版本分类展开集成步骤。

<details>
	<summary><font color="#3ab7f8">集成 3.2.0 至 3.2.1 版本 SDK</font></summary>
<% if (product == "audio") { %>
1. 根据你的需求，选择以下一种方法将 `AgoraRtcKit.framework`、`Agorafdkaac.framework` 和 `AgoraSoundTouch.framework` 动态库复制到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。

a. 如果无需使用模拟器运行项目，复制 SDK 包中 `./libs` 路径下的上述动态库。

b. 如需使用模拟器运行项目，复制 SDK 包中 `./libs/ALL_ARCHITECTURE` 路径下的上述动态库。该路径下的动态库包含 x86-64 架构，会影响 app 在 App Store 的发布，处理方法见[发布注意事项](#distribution)。
<% } if (product == "video") { %>

1. 根据你的需求，选择以下一种方法将 `AgoraRtcKit.framework`、`Agorafdkaac.framework`、`Agoraffmpeg.framework` 和 `AgoraSoundTouch.framework` 动态库复制到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。

   a. 如果无需使用模拟器运行项目，复制 SDK 包中 `./libs` 路径下的上述动态库。

   b. 如需使用模拟器运行项目，复制 SDK 包中 `./libs/ALL_ARCHITECTURE` 路径下的上述动态库。该路径下的动态库包含 x86-64 架构，会影响 app 在 App Store 的发布，处理方法见[发布注意事项](#distribution)。
   <% } %>

2. 打开 Xcode，进入 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** 菜单。

<% if (product == "audio") { %> 3. 点击 **+** > **Add Other…** > **Add Files** 添加 `AgoraRtcKit.framework`、`Agorafdkaac.framework` 和 `AgoraSoundTouch.framework` 动态库，并确保添加的动态库 **Embed** 属性设置为 **Embed & Sign**。
添加完成后，项目会自动链接所需系统库。
<% } if (product == "video") { %> 3. 点击 **+** > **Add Other…** > **Add Files** 添加 `AgoraRtcKit.framework`、`Agorafdkaac.framework`、`Agoraffmpeg.framework` 和 `AgoraSoundTouch.framework` 动态库，并确保添加的动态库 **Embed** 属性设置为 **Embed & Sign**。
添加完成后，项目会自动链接所需系统库。
<% } %>

   <div class="alert note"><ul><li>根据 Apple 官方要求，app 的 Extension 中不允许包含动态库。如果项目中的 Extension 需要集成 SDK，则添加动态库时需将文件状态改为 <b>Do Not Embed</b>。</li><li>Agora SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 sales@agora.io。SDK 提供的库是 FAT Image，包含 32/64 位模拟器、32/64 位真机版本。</li></ul></div>

</details>

<details>
	<summary><font color="#3ab7f8">集成 3.0.1 至 3.1.2 版本 SDK</font></summary>

1. 根据你的需求，选择以下一种方法将 `AgoraRtcKit.framework` 动态库复制到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。

a. 如果无需使用模拟器运行项目，复制 SDK 包中 `./libs` 路径下的上述动态库。

b. 如需使用模拟器运行项目，复制 SDK 包中 `./libs/ALL_ARCHITECTURE` 路径下的上述动态库。该路径下的动态库包含 x86-64 架构，会影响 app 在 App Store 的发布，处理方法见[发布注意事项](#distribution)。 2. 打开 Xcode，进入 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** 菜单。 3. 点击 **+** > **Add Other…** > **Add Files** 添加 `AgoraRtcKit.framework` 动态库，并确保添加的动态库 **Embed** 属性设置为 **Embed & Sign**。添加完成后，项目会自动链接所需系统库。

  <div class="alert note"><ul><li>根据 Apple 官方要求，app 的 Extension 中不允许包含动态库。如果项目中的 Extension 需要集成 SDK，则添加动态库时需将文件状态改为 <b>Do Not Embed</b>。</li><li>Agora SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 sales@agora.io。SDK 提供的库是 FAT Image，包含 32/64 位模拟器、32/64 位真机版本。</li></ul></div>

</details>

<details>
	<summary><font color="#3ab7f8">集成 3.0.0 版本 SDK</font></summary>

3.0.0 版 SDK 中包含一个 `AgoraRtcKit.framework` 动态库和一个 `AgoraRtcKit.framework` 静态库，你可以根据需要选择其中一个库添加。

两个库在 SDK 包中的路径如下：

- 动态库的路径为 `./Agora_Native_SDK_for_iOS_..._Dynamic/libs`。
- 静态库的路径为 `./Agora_Native_SDK_for_iOS_.../libs`。

<div class="alert info">你也可以在终端运行 <tt>file /path/library_name.framework/library_name</tt> 命令，查看库类型。其中 <tt>library_name</tt> 为库名。<li>如果终端返回 <tt>dynamically linked shared library</tt>，表示该库为动态库。</li><li>如果终端返回 <tt>current ar archive random library</tt>，表示该库为静态库。</li></div>

**动态库集成：**

1. 将 SDK 包中的 `AgoraRtcKit.framework` 动态库复制到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。
2. 打开 Xcode，进入 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** 菜单。
3. 点击 **+** > **Add Other…** > **Add Files** 添加 `AgoraRtcKit.framework` 动态库，并确保添加的动态库 **Embed** 属性设置为 **Embed & Sign**。
   添加完成后，项目会自动链接所需系统库。

<div class="alert note">根据 Apple 官方要求，app 的 Extension 中不允许包含动态库。如果项目中的 Extension 需要集成 SDK，则添加动态库时需将文件状态改为 <b>Do Not Embed</b>。</div>

**静态库集成：**

1. 将 SDK 包中的 `AgoraRtcKit.framework` 静态库复制到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。
2. 打开 **Xcode**，进入 **TARGETS > Project Name > Build Phases > Link Binary with Libraries** 菜单，点击 **+** 添加如下库。在添加 `AgoraRtcKit.framework` 时，还需在点击 **+** 后点击 **Add Other…** > **Add Files**，找到本地文件并打开。

| SDK      | 库                                                                                                                                                                                                                                                                                                               |
| -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 音频 SDK | <li>`AgoraRtcKit.framework`</li><li>`Accelerate.framework`</li><li>`AudioToolbox.framework`</li><li>`AVFoundation.framework`</li><li>`CoreMedia.framework`</li><li>`libc++.tbd`</li><li>`libresolv.tbd`</li><li>`SystemConfiguration.framework`</li><li>`CoreTelephony.framework`</li>                           |
| 视频 SDK | <li>`AgoraRtcKit.framework`</li><li>`Accelerate.framework`</li><li>`AudioToolbox.framework`</li><li>`AVFoundation.framework`</li><li>`CoreMedia.framework`</li><li>`libc++.tbd`</li><li>`libresolv.tbd`</li><li>`SystemConfiguration.framework`</li><li>`CoreML.framework`</li><li>`VideoToolbox.framework`</li> |

<div class="alert note">Agora SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 sales@agora.io。SDK 提供的库是 FAT Image，包含 32/64 位模拟器、32/64 位真机版本。</div>
	
</details>

<details>
	<summary><font color="#3ab7f8">集成 3.0.0 以下版本 SDK</font></summary>

1. 将 SDK 包中的 `AgoraRtcEngineKit.framework` 静态库复制到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。
2. 打开 **Xcode**，进入 **TARGETS > Project Name > Build Phases > Link Binary with Libraries** 菜单，点击 **+** 添加如下库。在添加 `AgoraRtcEngineKit.framework` 时，还需在点击 **+** 后点击 **Add Other…** > **Add Files**，找到本地文件并打开。

| SDK      | 库                                                                                                                                                                                                                                                                                                                     |
| -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 音频 SDK | <li>`AgoraRtcEngineKit.framework`</li><li>`Accelerate.framework`</li><li>`AudioToolbox.framework`</li><li>`AVFoundation.framework`</li><li>`CoreMedia.framework`</li><li>`libc++.tbd`</li><li>`libresolv.tbd`</li><li>`SystemConfiguration.framework`</li><li>`CoreTelephony.framework`</li>                           |
| 视频 SDK | <li>`AgoraRtcEngineKit.framework`</li><li>`Accelerate.framework`</li><li>`AudioToolbox.framework`</li><li>`AVFoundation.framework`</li><li>`CoreMedia.framework`</li><li>`libc++.tbd`</li><li>`libresolv.tbd`</li><li>`SystemConfiguration.framework`</li><li>`CoreML.framework`</li><li>`VideoToolbox.framework`</li> |

<div class="alert note">Agora SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 sales@agora.io。SDK 提供的库是 FAT Image，包含 32/64 位模拟器、32/64 位真机版本。</div>
	
</details>

## <a name="distribution"></a>发布注意事项

如果集成了 SDK 包中 `./libs/ALL_ARCHITECTURE` 路径下的动态库，你需要在将 app 发布至 App Store 前移除 x86_64 架构。

在终端中运行如下命令，移除 x86_64 架构。注意将 `ALL_ARCHITECTURE/AgoraRtcKit.framework/AgoraRtcKit` 替换为动态库在你项目中的路径。

```shell
lipo -remove x86_64 ALL_ARCHITECTURE/AgoraRtcKit.framework/AgoraRtcKit -output ALL_ARCHITECTURE/AgoraRtcKit.framework/AgoraRtcKit
```

更多发布注意事项，可以参考 [Preparing Your App for Distribution](https://developer.apple.com/documentation/xcode/preparing_your_app_for_distribution)。

## 相关链接

- [直播场景下，如何监听远端观众用户加入/离开频道的事件？](https://docs.agora.io/cn/faq/audience_event)
- [如何设置日志文件？](https://docs.agora.io/cn/faq/logfile)
- [如何处理视频黑屏问题？](https://docs.agora.io/cn/faq/video_blank)
- [为什么在运行集成 RTC SDK 的 iOS app 时会看到查找本地网络设备的弹窗提示？](https://docs.agora.io/cn/faq/local_network_privacy)
