---
title: 实现视频直播
platform: macOS
updatedAt: 2020-12-16 02:56:18
---

本文介绍如何使用 Agora SDK 快速实现音视频直播。

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

## 实现音视频直播

本节介绍如何实现音视频直播。音视频直播的 API 调用时序见下图：

![](https://web-cdn.agora.io/docs-files/1570604677337)

### 1. 创建用户界面

根据场景需要，为你的项目创建音视频直播的用户界面。若已有用户界面，可以直接查看[导入类](#ImportClass)。

我们推荐你添加如下 UI 元素：

- 主播视频窗口
- 退出频道按钮

当你使用示例项目中的 UI 设计时，你将会看到如下界面：

![](https://web-cdn.agora.io/docs-files/1568802427977)

### <a name="ImportClass"></a>2. 导入类

在项目中导入 AgoraRtcKit 类：

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

<div class="alert note">Agora Native SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 sales@agora.io。SDK 提供的库是 Fat Image，包含 32/64 位模拟器、32/64 位真机版本。</div>

### 3. 初始化 AgoraRtcEngineKit

在调用其他 Agora API 前，需要创建并初始化 AgoraRtcEngineKit 对象。

调用 `sharedEngineWithAppId` 方法，传入获取到的 App ID，即可初始化 `AgoraRtcEngineKit`。

你还可以根据场景需要，在初始化时注册想要监听的回调事件，如本地用户加入频道，及解码远端用户视频首帧等。

```
// Objective-C
- (void)initializeAgoraEngine {
    // 输入 App ID 并初始化 AgoraRtcEngineKit 类。
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithAppId:appID delegate:self];
}
```

```
// Swift
func initializeAgoraEngine() {
   // 输入 App ID 并初始化 AgoraRtcEngineKit 类。
   agoraKit = AgoraRtcEngineKit.sharedEngine(withAppId: AppID, delegate: self)
}
```

### 4. 设置频道场景

初始化结束后，调用 `setChannelProfile` 方法，将频道场景设为直播。

一个 `AgoraRtcEngineKit` 只能使用一种频道场景。如果想切换为其他模式，需要先调用 `destroy` 方法释放当前的 `AgoraRtcEngineKit` 实例，然后使用 `sharedEngineWithAppId` 方法创建一个新实例，再调用 `setChannelProfile` 设置新的频道场景。

```objective-c
// Objective-C
// 设置频道场景。
[self.agoraKit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
```

```swift
// Swift
// 设置频道场景。
agoraKit.setChannelProfile(.liveBroadcasting)
```

### 5. 设置用户角色和用户级别

直播频道中可设置用户角色和用户级别：

- 用户角色 (role) 确定用户在 SDK 层的权限，包含是否可以发流、是否可以收流等。直播频道有两种用户角色：主播和观众。主播既有发流权限，又有收流权限，而观众只有收流权限。默认的角色为观众。
- 用户级别 (level) 需要与用户角色结合使用，确定用户在其角色权限范围内可以操作和享受到的服务级别。例如对于观众，可以选择接收低延时还是超低延时的视频流。**不同的级别会影响计费**。

你可以在 app 中参考如下步骤设置用户角色：

1. 让终端用户选择自己的角色是主播还是观众。

2. 调用 [`setClientRole`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setClientRole:options:) 方法，然后根据终端用户的选择设置 `role` 和 `options` 参数。
   - 当 `role` 设为 `AgoraClientRoleBroadcaster`（主播）时， `options` 参数留空。此时主播端延时为 < 400 ms。
   - 当 `role` 设为 `AgoraClientRoleAudience`（观众）时，你还需要将 `options` 中 `audienceLatencyLevel` 参数设为 `AgoraAudienceLatencyLevelLowLatency`。此时观众端延时为 1500 ms - 2000 ms。

<div class="alert note"><li>如果观众级别从 <code>AgoraAudienceLatencyLevelLowLatency</code>（低延时）切换为 <code>AgoraAudienceLatencyLevelUltraLowLatency</code>（超低延时），会从极速直播产品切换为互动直播产品，延时会变为 400 ms - 800 ms。</li><li>如果用户角色从 <code>AgoraClientRoleAudience</code>（观众）切换为 <code>AgoraClientRoleBroadcaster</code>（主播），会从极速直播产品切换为互动直播产品，延时会低于 400 ms。</li><li>当接收端为观众且用户级别为 <code>AgoraAudienceLatencyLevelLowLatency</code> 时，<code>RemoteAudioStats</code> 中的 <code>jitterBufferDelay</code> 字段（接收端到网络抖动缓冲的网络延迟）不生效。</li></div>

主播：

```swift
agoraKit.setClientRole(.broadcaster, options: nil)
```

观众：

```swift
let options: AgoraClientRoleOptions = AgoraClientRoleOptions()
options.audienceLatencyLevel = AgoraAudienceLatencyLevelType.lowLatency
agoraKit.setClientRole(.audience, options: options)
```

### 6. 设置本地视图

成功初始化 AgoraRtcEngineKit 对象后，需要在加入频道前设置本地视图，以便在通话中看到本地图像。参考以下步骤设置本地视图：

- 调用 `enableVideo` 方法启用视频模块。
- 调用 `setupLocalVideo` 方法设置本地视图。

```objective-c
// Objective-C
// 启用视频模块。
[self.agoraKit enableVideo];
- (void)setupLocalVideo {
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = 0;
    videoCanvas.view = self.localVideo;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    // 设置本地视图。
    [self.agoraKit setupLocalVideo:videoCanvas];
}
```

```swift
// Swift
// 启用视频模块。
agoraKit.enableVideo()
func addLocalSession() {
    let localSession = VideoSession.localSession()
    videoSessions.append(localSession)
    // 设置本地视图。
    agoraKit.setupLocalVideo(localSession.canvas)
    let mediaInfo = MediaInfo(dimension: settings.dimension,
                                  fps: settings.frameRate.rawValue)
    localSession.mediaInfo = mediaInfo
    }
```

### <a name="JoinChannel"></a>7. 加入频道

完成初始化和设置本地视图后（视频通话场景），你就可以调用 `joinChannelByToken` 方法加入频道。你需要在该方法中传入如下参数：

- channelId: 传入能标识频道的频道 ID。输入频道 ID 相同的用户会进入同一个频道。

- token：传入能标识用户角色和权限的 Token。可设为如下一个值：

  - `nil`
  - 临时 Token。临时 Token 服务有效期为 24 小时。你可以在控制台里生成一个临时 Token，详见[获取临时 Token](https://docs.agora.io/cn/Agora%20Platform/token?platform=All%20Platforms#get-a-temporary-token)。
  - 在你的服务器端生成的 Token。在安全要求高的场景下，我们推荐你使用此种方式生成的 Token，详见[生成 Token](./token_server)。

 <div class="alert note">若项目已启用 App 证书，请使用 Token。</div>

- uid: 本地用户的 ID。数据类型为整型，且频道内每个用户的 `uid` 必须是唯一的。若将 `uid` 设为 0，则 SDK 会自动分配一个 `uid`，并在 `joinSuccessBlock` 回调中报告。

 <div class="alert note">用户成功加入频道后，会默认订阅频道内其他所有用户的音频流和视频流，因此产生用量并影响计费。如果想取消订阅，可以通过调用相应的 <tt>mute</tt> 方法实现。</div>
 
- joinSuccessBlock：成功加入频道回调。`joinSuccessBlock` 优先级高于 `didJoinChannel`，2 个同时存在时，`didJoinChannel` 会被忽略。 需要有 `didJoinChannel` 回调时，请将 `joinSuccessBlock` 设置为 `nil`。

更多的参数设置注意事项请参考 [joinChannelByToken](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:) 接口中的参数描述。

<div class="alert note">对于 v3.0.0 之前的 SDK，如果频道中有 Web SDK，需要调用<code>enableWebSdkInteroperability</code> 开启和Web SDK 的互通。v3.0.0 及之后的 SDK 在通信和直播场景下均自动开启了与 Web SDK 的互通。</div>

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
// 加入频道。
agoraKit.joinChannel(byToken: KeyCenter.Token, channelId: channelId, info: nil, uid: 0, joinSuccess: nil)
```

### 8. 设置远端视图

视频通话中，通常你也需要看到其他用户。在加入频道后，可通过调用 `setupRemoteVideo` 方法设置远端用户的视图。

远端用户成功加入频道后，SDK 会触发 `firstRemoteVideoDecodedOfUid` 回调，该回调中会包含这个远端用户的 `uid` 信息。在该回调中调用 `setupRemoteVideo` 方法，传入获取到的 `uid`，设置远端用户的视图。

```objective-c
// Objective-C
// 监听 firstRemoteVideoDecodedOfUid 回调。
// SDK 接收到第一帧远端视频并成功解码时，会触发该回调。
// 可以在该回调中调用 setupRemoteVideo 方法设置远端视图。
- (void)rtcEngine:(AgoraRtcEngineKit *)engine firstRemoteVideoDecodedOfUid:(NSUInteger)uid size: (CGSize)size elapsed:(NSInteger)elapsed {
    if (self.remoteVideo.hidden) {
        self.remoteVideo.hidden = NO;
    }
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = uid;
    videoCanvas.view = self.remoteVideo;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    // 设置远端视图。
    [self.agoraKit setupRemoteVideo:videoCanvas];
}
```

```swift
// Swift
// 监听 firstRemoteVideoDecodedOfUid 回调。
// SDK 接收到第一帧远端视频并成功解码时，会触发该回调。
// 可以在该回调中调用 setupRemoteVideo 方法设置远端视图。
func rtcEngine(_ engine: AgoraRtcEngineKit, firstRemoteVideoDecodedOfUid uid: UInt, size: CGSize, elapsed: Int) {
    let userSession = videoSession(of: uid)
    userSession.updateMediaInfo(resolution: size)
    // 设置远端视图。
    agoraKit.setupRemoteVideo(userSession.canvas)
    }
```

### 9. 离开频道

根据场景需要，如结束通话、关闭 app 或 app 切换至后台时，调用 `leaveChannel` 离开当前通话频道。

```objective-c
// Objective-C
[self.agoraKit setupLocalVideo:nil];
    // 离开频道。
    [self.agoraKit leaveChannel:nil];
    if (self.isBroadcaster) {
        [self.agoraKit stopPreview];
    }
```

```swift
// Swift
func leaveChannel() {
    setIdleTimerActive(true)
    agoraKit.setupLocalVideo(nil)
    // 离开频道。
    agoraKit.leaveChannel(nil)
    if settings.role == .broadcaster {
       agoraKit.stopPreview()
    }
    navigationController?.popViewController(animated: true)
    }
```

## 运行项目

你可以在 macOS 设备中运行此项目。当成功开始视频直播时，主播可以看到自己的画面；观众可以看到主播的画面。

<div class="alert note">在 12.2 及以上版本的 Xcode 中，为避免编译项目时发生问题，你需要在编译项目前进入 <b>TARGETS > Project Name > Build Settings > Architectures</b>，并将 <b>Architectures</b> 属性设置为 <b>x86_64</b>。</div>

## <a name="earlierversion"></a>历史版本集成方式

选择如下任意一种方式集成历史版本 Agora macOS SDK。

### 方法一：使用 CocoaPods 获取 SDK

1. 开始前确保你已安装 Cocoapods。参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。

2. 在终端里进入项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 `Podfile` 文本文件。

<% if (product == "audio") { %> 3. 打开 `Podfile` 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称，并将 `version` 替换为你需集成的 SDK 版本。如需了解 SDK 版本信息，查看[发版说明](./release_mac_audio?platform=macOS)。

<% } if (product == "video") { %> 3. 打开 `Podfile` 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称，并将 `version` 替换为你需集成的 SDK 版本。如需了解 SDK 版本信息，查看[发版说明](./release_mac_video?platform=macOS)。

<% } %>

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
	<summary><font color="#3ab7f8">集成 3.2.0 至 3.2.1 版本 SDK</font></summary>

<% if (product == "audio") { %>

1. 复制 SDK 包中的 `AgoraRtcKit.framework`、`Agorafdkaac.framework` 和 `AgoraSoundTouch.framework` 动态库到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。
   <% } if (product == "video") { %>
1. 复制 SDK 包中的 `AgoraRtcKit.framework`、`Agorafdkaac.framework`、`Agoraffmpeg.framework` 和 `AgoraSoundTouch.framework` 动态库到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。
   <% } %>

1. 打开 Xcode，进入 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** 菜单。

<% if (product == "audio") { %> 3. 点击 **+** > **Add Other…** > **Add Files** 添加 `AgoraRtcKit.framework`、`Agorafdkaac.framework` 和 `AgoraSoundTouch.framework` 动态库，并确保添加的动态库 **Embed** 属性设置为 **Embed & Sign**。
添加完成后，项目会自动链接所需系统库。
<% } if (product == "video") { %> 3. 点击 **+** > **Add Other…** > **Add Files** 添加 `AgoraRtcKit.framework`、`Agorafdkaac.framework`、`Agoraffmpeg.framework` 和 `AgoraSoundTouch.framework` 动态库，并确保添加的动态库 **Embed** 属性设置为 **Embed & Sign**。
添加完成后，项目会自动链接所需系统库。
<% } %>

   <div class="alert note"><ul><li>根据 Apple 官方要求，app 的 Extension 中不允许包含动态库。如果项目中的 Extension 需要集成 SDK，则添加动态库时需将文件状态改为 <b>Do Not Embed</b>。</li><li>Agora SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 sales@agora.io。SDK 提供的库是 FAT Image，包含 32/64 位模拟器、32/64 位真机版本。</li></ul></div>

</details>

<details>
	<summary><font color="#3ab7f8">集成 3.0.1 至 3.1.2 版本 SDK</font></summary>

1.  复制 SDK 包中的 `AgoraRtcKit.framework` 动态库到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。
2.  打开 Xcode，进入 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** 菜单。
3.  点击 **+** > **Add Other…** > **Add Files** 添加 `AgoraRtcKit.framework` 动态库，并确保添加的动态库 **Embed** 属性设置为 **Embed & Sign**。添加完成后，项目会自动链接所需系统库。

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

| SDK      | 库                                                                                                                                                                                                                   |
| -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 音频 SDK | <li>`AgoraRtcKit.framework`</li><li>`Accelerate.framework`</li><li>`CoreWLAN.framework`</li><li>`libc++.tbd`</li><li>`libresolv.9.tbd`</li><li>`SystemConfiguration.framework`</li>                                  |
| 视频 SDK | <li>`AgoraRtcKit.framework`</li><li>`Accelerate.framework`</li><li>`CoreWLAN.framework`</li><li>`libc++.tbd`</li><li>`libresolv.9.tbd`</li><li>`SystemConfiguration.framework`</li><li>`VideoToolbox.framework`</li> |

<div class="alert note">Agora SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 sales@agora.io。SDK 提供的库是 FAT Image，包含 32/64 位模拟器、32/64 位真机版本。</div>

</details>

<details>
	<summary><font color="#3ab7f8">集成 3.0.0 以下版本 SDK</font></summary>

1. 将 SDK 包中的 `AgoraRtcEngineKit.framework` 静态库复制到项目的 `./project_name` 文件夹下（`project_name` 为你的项目名称）。
2. 打开 **Xcode**，进入 **TARGETS > Project Name > Build Phases > Link Binary with Libraries** 菜单，点击 **+** 添加如下库。在添加 `AgoraRtcEngineKit.framework` 时，还需在点击 **+** 后点击 **Add Other…** > **Add Files**，找到本地文件并打开。

| SDK      | 库                                                                                                                                                                                                                         |
| -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 音频 SDK | <li>`AgoraRtcEngineKit.framework`</li><li>`Accelerate.framework`</li><li>`CoreWLAN.framework`</li><li>`libc++.tbd`</li><li>`libresolv.9.tbd`</li><li>`SystemConfiguration.framework`</li>                                  |
| 视频 SDK | <li>`AgoraRtcEngineKit.framework`</li><li>`Accelerate.framework`</li><li>`CoreWLAN.framework`</li><li>`libc++.tbd`</li><li>`libresolv.9.tbd`</li><li>`SystemConfiguration.framework`</li><li>`VideoToolbox.framework`</li> |

<div class="alert note">Agora SDK 默认使用 libc++ (LLVM)，如需使用 libstdc++ (GNU)，请联系 sales@agora.io。SDK 提供的库是 FAT Image，包含 32/64 位模拟器、32/64 位真机版本。</div>
</details>

## 相关链接

- [直播场景下，如何监听远端观众用户加入/离开频道的事件？](https://docs.agora.io/cn/faq/audience_event)
- [如何设置日志文件？](https://docs.agora.io/cn/faq/logfile)
- [如何处理视频黑屏问题？](https://docs.agora.io/cn/faq/video_blank)
