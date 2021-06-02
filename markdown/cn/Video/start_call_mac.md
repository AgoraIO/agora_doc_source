---
title: 实现视频通话
platform: macOS
updatedAt: 2021-01-28 10:26:56
---
本文介绍如何使用 Agora 视频通话 SDK 快速实现视频通话。

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

## 获取 SDK

选择如下任意一种方式获取最新版 Agora macOS SDK。

<div class="alert info">如需集成 3.2.0 以下版本的 SDK，请查看<a href="#earlierversion">历史版本集成方式</a>。</div>

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


2. 复制 SDK 包中的 `AgoraRtcKit.framework`、`Agorafdkaac.framework`、`Agoraffmpeg.framework` 和 `AgoraSoundTouch.framework` 动态库到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。


3. 打开 Xcode，进入 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** 菜单。


4. 点击 **+** > **Add Other…** > **Add Files** 添加 `AgoraRtcKit.framework`、`Agorafdkaac.framework`、`Agoraffmpeg.framework` 和 `AgoraSoundTouch.framework` 动态库，并确保添加的动态库 **Embed** 属性设置为 **Embed & Sign**。
   添加完成后，项目会自动链接所需系统库。


   <div class="alert note"><ul><li>根据 Apple 官方要求，app 的 Extension 中不允许包含动态库。如果项目中的 Extension 需要集成 SDK，则添加动态库时需将文件状态改为 <b>Do Not Embed</b>。</li><li>Agora SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 sales@agora.io。SDK 提供的库是 FAT Image，包含 32/64 位模拟器、32/64 位真机版本。</li></ul></div>

## 基本流程

现在，我们已经将 Agora macOS SDK 集成到项目中了。接下来我们要在 `ViewController` 中调用 Agora macOS SDK 提供的核心 API 实现基础的视频通话功能，API 调用时序见下图。

![](https://web-cdn.agora.io/docs-files/1608263915042)

### 1. 创建用户界面

根据场景需要，为你的项目创建视频通话的用户界面。我们推荐你在项目中添加如下元素：

- 本地视频窗口
- 远端视频窗口

你可以参考以下代码创建一个基础的用户界面。

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">Objective-C</div>
		<div class="switch-tab">Swift</div>
	</div>
<pre class="objective-c show"><code class="language-objective-c">// ViewController.h
// 导入 AppKit。
#import &lt;AppKit/AppKit.h&gt;
@interface ViewController ()
// 定义 localView 变量。
@property (nonatomic, strong) NSView *localView;
// 定义 remoteView 变量。
@property (nonatomic, strong) NSView *remoteView;
@end
@implementation ViewController
...
- (void)viewDidLoad {
    ...
    // 调用初始化视频窗口函数。
    [self initViews];
}
// 设置视频窗口布局。
- (void)viewDidLayout {
    [super viewDidLayout];
    self.remoteView.frame = self.view.bounds;
    self.localView.frame = CGRectMake(self.view.bounds.size.width - 90, 0, 90, 160);
}
- (void)initViews {
    // 初始化远端视频窗口。
    self.remoteView = [[NSView alloc] init];
    [self.view addSubview:self.remoteView];
    // 初始化本地视频窗口。
    self.localView = [[NSView alloc] init];
    [self.view addSubview:self.localView];
}
...
@end
</code></pre>
<pre class="swift"><code class="language-swift">// ViewController.swift
// 导入 AppKit。
import AppKit
class ViewController: NSViewController {
    ...
     // 定义 localView 变量。
     var localView: NSView!
     // 定义 remoteView 变量。
     var remoteView: NSView!
     override func viewDidLoad() {
         ...
         // 调用初始化视频窗口函数。
         initView()
     }
    // 设置视频窗口布局。
    override func viewDidLayout() {
        super.viewDidLayout()
        remoteView.frame = self.view.bounds
        localView.frame = CGRect(x: self.view.bounds.width - 90, y: 0, width: 90, height: 160)
    }
    func initView() {
        // 初始化远端视频窗口。
        remoteView = NSView()
        self.view.addSubview(remoteView)
        // 初始化本地视频窗口。
        localView = NSView()
        self.view.addSubview(localView)
    }
    ...
}
</code></pre>
</div>

### <a name="ImportClass"></a>2. 导入类

在调用 Agora API 前，你需要在项目中导入 `AgoraRtcKit` 类，并定义一个 `agoraKit` 变量。

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">Objective-C</div>
		<div class="switch-tab">Swift</div>
	</div>
<pre class="objective-c show"><code class="language-objective-c">// ViewController.h
// 导入 AgoraRtcKit 类。
// 自 3.0.0 版本起，AgoraRtcEngineKit 类名更换为 AgoraRtcKit。
// 如果你使用 3.0.0 以下版本的 SDK，你需要将示例代码中的 AgoraRtcKit 替换为 AgoraRtcEngineKit。
#import &ltAgoraRtcKit/AgoraRtcEngineKit.h&gt
// 声明 AgoraRtcEngineDelegate，用于监听回调。
@interface ViewController : NSViewController &ltAgoraRtcEngineDelegate&gt
// 定义 agoraKit 变量。
@property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;
</code></pre>
<pre class="swift"><code class="language-swift">// ViewController.swift
// 导入 AgoraRtcKit 类。
// 自 3.0.0 版本起，AgoraRtcEngineKit 类名更换为 AgoraRtcKit。
// 如果你使用 3.0.0 以下版本的 SDK，你需要将示例代码中的 import AgoraRtcKit 替换为 import AgoraRtcEngineKit。
import AgoraRtcKit
class ViewController: NSViewController {
    ...
    // 定义 agoraKit 变量。
    var agoraKit: AgoraRtcEngineKit?
}
</code></pre>
</div>

### 3. 初始化 AgoraRtcEngineKit 对象

调用 `sharedEngineWithAppId` 创建并初始化 `AgoraRtcEngineKit` 对象。你需要将 `YourAppID` 替换为你的 Agora 项目的 App ID。详见[获取 App ID](https://docs.agora.io/cn/Video/run_demo_video_call_macos?platform=macOS#appid)。

你还可以根据场景需要，在初始化时注册想要监听的回调事件。

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">Objective-C</div>
		<div class="switch-tab">Swift</div>
	</div>
<pre class="objective-c show"><code class="language-objective-c">// ViewController.m
// 将以下代码填入你定义的函数中，例如 viewDidLoad()。
self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:@"YourAppID" delegate:self];
</code></pre>
<pre class="swift"><code class="language-swift">// ViewController.swift
// 将以下代码填入你定义的函数中，例如 viewDidLoad()。
agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: "YourAppID", delegate: self)
</code></pre>
</div>

### 4. 设置本地视图

在加入频道前设置本地视图，以便在通话中看到本地图像。参考以下步骤设置本地视图：

(1) 调用 `enableVideo` 启用视频模块。
(2) 调用 `setupLocalVideo` 设置本地视图。

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">Objective-C</div>
		<div class="switch-tab">Swift</div>
	</div>
<pre class="objective-c show"><code class="language-objective-c">// ViewController.m
// 将以下代码填入你定义的函数中，例如 viewDidLoad()。
// 启用视频模块
[self.agoraKit enableVideo];
AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
videoCanvas.uid = 0;
videoCanvas.renderMode = AgoraVideoRenderModeHidden;
videoCanvas.view = self.localView;
// 设置本地视图
[self.agoraKit setupLocalVideo:videoCanvas];
</code></pre>
<pre class="swift"><code class="language-swift">// ViewController.swift
// 将以下代码填入你定义的函数中，例如 viewDidLoad()。
// 启用视频模块
agoraKit?.enableVideo()
let videoCanvas = AgoraRtcVideoCanvas()
videoCanvas.uid = 0
videoCanvas.renderMode = .hidden
videoCanvas.view = localView
// 设置本地视图
agoraKit?.setupLocalVideo(videoCanvas)
</code></pre>
</div>

### <a name="JoinChannel"></a>5. 加入频道

调用 `joinChannelByToken` 加入频道。

在 `joinChannelByToken` 中你需要将 `YourToken` 替换成你自己生成的 Token，并将 `YourChannelName` 替换为你生成 Token 时填入的频道名称。

- 在测试阶段，你可以直接在控制台[生成临时 Token](https://docs.agora.io/cn/Video/run_demo_video_call_macos?platform=macOS#temptoken)。
- 在生产环境，我们推荐你在自己的服务端生成 Token，详见[在服务端生成 Token](https://docs.agora.io/cn/Video/token_server?platform=macOS)。

<div class="alert note">用户成功加入频道后，会默认订阅频道内其他所有用户的音频流和视频流，因此产生用量并影响计费。如果想取消订阅，可以通过调用相应的 `mute` 方法实现。</div>

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">Objective-C</div>
		<div class="switch-tab">Swift</div>
	</div>
<pre class="objective-c show"><code class="language-objective-c">// ViewController.m
// 将以下代码填入你定义的函数中，例如 viewDidLoad()。
[self.agoraKit joinChannelByToken:@"YourToken" channelId:@"YourChannelName" info:nil uid:0 joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
}];
</code></pre>
<pre class="swift"><code class="language-swift">// ViewController.swift
// 将以下代码填入你定义的函数中，例如 viewDidLoad()。
agoraKit?.joinChannel(byToken: "YourToken", channelId: "YourChannelName", info: nil, uid: 0, joinSuccess: { (channel, elapsed, uid) in
})
</code></pre>
</div>

### 6. 设置远端视图

视频通话中，通常你也需要看到其他用户。

远端用户成功加入频道后，SDK 会触发 `firstRemoteVideoDecodedOfUid` 回调，该回调中会包含这个远端用户的 `uid` 信息。在该回调中调用 `setupRemoteVideo` 方法，传入获取到的 `uid`，设置远端用户的视图。

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">Objective-C</div>
		<div class="switch-tab">Swift</div>
	</div>
<pre class="objective-c show"><code class="language-objective-c">// ViewController.m
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
</code></pre>
<pre class="swift"><code class="language-swift">// ViewController.swift
// 声明 AgoraRtcEngineDelegate，用于监听回调
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
</code></pre>
</div>

### 7. 离开频道

根据场景需要，如结束通话、关闭 app 或 app 切换至后台时，调用 `leaveChannel` 离开当前通话频道。

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">Objective-C</div>
		<div class="switch-tab">Swift</div>
	</div>
<pre class="objective-c show"><code class="language-objective-c">// ViewController.m
// 将以下代码填入你定义的函数中。
[self.agoraKit leaveChannel:nil];
</code></pre>
<pre class="swift"><code class="language-swift">// ViewController.swift
// 将以下代码填入你定义的函数中。
agoraKit?.leaveChannel(nil)
</code></pre>
</div>

### 8. 销毁 AgoraRtcEngineKit 对象

离开频道后，如果你想释放 Agora SDK 使用的所有资源，需调用 `destroy` 销毁 `AgoraRtcEngineKit` 对象。

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">Objective-C</div>
		<div class="switch-tab">Swift</div>
	</div>
<pre class="objective-c show"><code class="language-objective-c">// ViewController.m
// 将以下代码填入你定义的函数中。
[AgoraRtcEngineKit destroy];
</code></pre>
<pre class="swift"><code class="language-swift">// ViewController.swift
// 将以下代码填入你定义的函数中。
AgoraRtcEngineKit.destroy()
</code></pre>
</div>

## 运行项目

在运行项目前，你需要设置签名和开发团队，并添加设备权限。

### 1. 设置签名和开发团队

 1. 在 Xcode 中，进入 **TARGETS** > **Project Name** > **Signing & Capabilities** > **Signing** 菜单，勾选 **Automatically manage signing**。
 2. 仔细阅读弹窗提示，并点击 **Enable Automatic**。
 3. 成功设置签名后，在 **Team** 处选择你的开发团队。

### 2. 添加设备权限

 1. 在 Xcode 中，打开 `info.plist` 文件。在右侧列表中添加如下内容，获取相应的设备权限：

  
| Key                                    | Type   | Value                                                        |
| :------------------------------------- | :----- | :----------------------------------------------------------- |
| Privacy - Microphone Usage Description | String | 使用麦克风的目的，例如：for a call or live interactive streaming。 |
| Privacy - Camera Usage Description     | String | 使用摄像头的目的，例如：for a call or live interactive streaming。 |

  

 2. 进入 **TARGETS** > **Project Name** > **Signing & Capabilities**，在 App Sandbox 和 Hardened Runtime 功能中添加如下权限：

  
| Capability       | Category        | Permission                                                 |
| :--------------- | :-------------- | :--------------------------------------------------------- |
| App Sandbox      | Network         | <ul><li>Incoming Connections (Server)</li><li>Outgoing Connections (Client)</li></ul> |
| App Sandbox      | Hardware        | <ul><li>Camera</li><li>Audio Input</li></ul>                                          |
| Hardened Runtime | Resource Access | <ul><li>Camera</li><li>Audio Input</li></ul>                                          |

 <div class="alert note"><ul><li>如果你的项目中需要添加第三方插件或库（例如第三方摄像头），且该插件或库的签名与项目的签名不一致，你还需勾选 <b>Hardened Runtime</b> > <b>Runtime Exceptions</b> 中的 <b>Disable Library Validation</b>。</li><li>更多注意事项，可以参考 <a href="https://developer.apple.com/documentation/xcode/preparing_your_app_for_distribution">Preparing Your App for Distribution</a >。</li></ul></div>
 
 
 3. 在 12.2 及以上版本的 Xcode 中，为避免编译项目时发生问题，你还需要在编译项目前进入 **TARGETS** > **Project Name** > **Build Settings** > **Architectures**，并将 **Architectures** 属性设置为 **x86_64**。

### 3. 体验视频通话

我们建议在 macOS 真机中运行你的项目。运行成功后，你可以看到本地视频。

你还可以通过声网的 [Web 端示例应用](https://webdemo.agora.io/agora-web-showcase/examples/Agora-Web-Tutorial-1to1-Web/)，输入相同的 App ID、频道名和临时 Token，加入同一频道与 macOS 端互通。当成功开始视频通话时，你可以同时看到本地和远端的视频。

## <a name="earlierversion"></a>历史版本集成方式

选择如下任意一种方式集成历史版本 Agora macOS SDK。

### 方法一：使用 CocoaPods 获取 SDK

1. 开始前确保你已安装 Cocoapods。参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。

2. 在终端里进入项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。

 
3. 打开 `Podfile` 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称，并将 `version` 替换为你需集成的 SDK 版本。如需了解 SDK 版本信息，查看[发版说明](./release_mac_video?platform=macOS)。

 

 ```
# platform :macOS, '10.11' use_frameworks!
target 'Your App' do
  pod 'AgoraRtcEngine_macOS', 'version'
end
```

4. 在终端内运行 `pod install` 命令安装 Agora SDK。成功安装后，Terminal 中会显示 `Pod installation complete!`，此时项目文件夹下会生成一个 `xcworkspace` 文件。

5. 打开新生成的 `xcworkspace` 文件。

### 方法二：集成本地的 SDK

不同版本的 SDK 集成方式不同，点击下列版本分类展开集成步骤。

<details>
	<summary><font color="#3ab7f8">集成 3.0.1 至 3.1.2 版本 SDK</font></summary>

 1. 复制 SDK 包中的 `AgoraRtcKit.framework` 动态库到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。
 2. 打开 Xcode，进入 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** 菜单。
 3. 点击 **+** > **Add Other…** > **Add Files** 添加 `AgoraRtcKit.framework` 动态库，并确保添加的动态库 **Embed** 属性设置为 **Embed & Sign**。添加完成后，项目会自动链接所需系统库。

  <div class="alert note"><ul><li>根据 Apple 官方要求，app 的 Extension 中不允许包含动态库。如果项目中的 Extension 需要集成 SDK，则添加动态库时需将文件状态改为 <b>Do Not Embed</b>。</li><li>Agora SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 sales@agora.io。SDK 提供的库是 FAT Image，包含 32/64 位模拟器、32/64 位真机版本。</li></ul></div>

</details>

<details>
	<summary><font color="#3ab7f8">集成 3.0.0 版本 SDK</font></summary>

3.0.0 版 SDK 中包含一个 `AgoraRtcKit.framework` 动态库和一个 `AgoraRtcKit.framework` 静态库，你可以根据需要选择其中一个库添加。

两个库在 SDK 包中的路径如下：
- 动态库的路径为 `./Agora_Native_SDK_for_macOS_..._Dynamic/libs`。
- 静态库的路径为 `./Agora_Native_SDK_for_macOS_.../libs`。

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

| SDK | 库 |
| ---------------- | ---------------- |
| 音频 SDK      |<li>`AgoraRtcKit.framework`</li><li>`Accelerate.framework`</li><li>`CoreWLAN.framework`</li><li>`libc++.tbd`</li><li>`libresolv.9.tbd`</li><li>`SystemConfiguration.framework`</li>|
| 视频 SDK | <li>`AgoraRtcKit.framework`</li><li>`Accelerate.framework`</li><li>`CoreWLAN.framework`</li><li>`libc++.tbd`</li><li>`libresolv.9.tbd`</li><li>`SystemConfiguration.framework`</li><li>`VideoToolbox.framework`</li> |

<div class="alert note">Agora SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 sales@agora.io。SDK 提供的库是 FAT Image，包含 32/64 位模拟器、32/64 位真机版本。</div>

</details>

<details>
	<summary><font color="#3ab7f8">集成 3.0.0 以下版本 SDK</font></summary>

1. 将 SDK 包中的 `AgoraRtcEngineKit.framework` 静态库复制到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。
2. 打开 **Xcode**，进入 **TARGETS > Project Name > Build Phases > Link Binary with Libraries** 菜单，点击 **+** 添加如下库。在添加 `AgoraRtcEngineKit.framework` 时，还需在点击 **+** 后点击 **Add Other…** > **Add Files**，找到本地文件并打开。

| SDK | 库 |
| ---------------- | ---------------- |
| 音频 SDK      |<li>`AgoraRtcEngineKit.framework`</li><li>`Accelerate.framework`</li><li>`CoreWLAN.framework`</li><li>`libc++.tbd`</li><li>`libresolv.9.tbd`</li><li>`SystemConfiguration.framework`</li>|
| 视频 SDK | <li>`AgoraRtcEngineKit.framework`</li><li>`Accelerate.framework`</li><li>`CoreWLAN.framework`</li><li>`libc++.tbd`</li><li>`libresolv.9.tbd`</li><li>`SystemConfiguration.framework`</li><li>`VideoToolbox.framework`</li> |

<div class="alert note">Agora SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 sales@agora.io。SDK 提供的库是 FAT Image，包含 32/64 位模拟器、32/64 位真机版本。</div>
</details>

## 相关链接

- 如果你需要实现一对多群聊场景，可以前往 GitHub 下载 [OpenVideoCall-macOS](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-macOS) 示例项目，或查看源代码。
- [如何设置日志文件？](https://docs.agora.io/cn/faq/logfile)
- [如何处理视频黑屏问题？](https://docs.agora.io/cn/faq/video_blank)