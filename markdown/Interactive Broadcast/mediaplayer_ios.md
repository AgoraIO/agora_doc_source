---
title: 媒体播放器组件
platform: iOS
updatedAt: 2021-03-18 04:04:20
---
## 功能描述

媒体播放器组件（MediaPlayer Kit）是一款功能强大的播放器，支持播放本地或在线的媒体资源。通过该播放器，你可以本地播放媒体资源，或将媒体资源同步分享给 Agora 频道内的远端用户观看/收听。

### 使用须知

- 目前支持播放的媒体格式：AVI、MP4、MP3、MKV 和 FLV 格式的本地文件，RTMP 和 RTSP 协议的在线媒体流。
- 本地播放媒体资源时，只需单独使用 MediaPlayer Kit。分享媒体资源到远端时，需同时使用 MediaPlayer Kit，Agora Native SDK 和 RtcChannelPublishPlugin 三者。其中，MediaPlayer Kit 支持本地用户使用播放器功能，Native SDK 支撑本地用户和远端用户的实时音视频直播场景，RtcChannelPublishPlugin 支持将播放的媒体流发送给 Agora 频道中远端用户。

## 准备开发条件

### 前提条件

- Xcode 9.0 或以上版本
- 支持 iOS 8.0 或以上版本的 iOS 设备

> 如果你的网络环境部署了防火墙，请根据[应用企业防火墙限制](https://docs.agora.io/cn/Agora%20Platform/firewall?platform=All%20Platforms)打开相关端口。
>
> 分享媒体资源到远端时，还需有效的 Agora 账户（免费[注册](https://dashboard.agora.io/)）。

### 创建项目

参考以下步骤创建一个 iOS 项目。

<details>
	<summary><font color="#3ab7f8">创建 iOS 项目</font></summary>
	
1. 打开 **Xcode** 并点击 **Create a new Xcode project**。
2. 选择项目类型为 **Single View App**，并点击 **Next**。
3. 输入项目信息，如项目名称、开发团队信息、组织名称和语言，并点击 **Next**。
 
	**Note**：如果你没有添加过开发团队信息，会看到 **Add account…** 按钮。点击该按钮并按照屏幕提示登入 Apple ID，完成后即可选择你的账户作为开发团队。
4. 选择项目存储路径，并点击 **Create**。
5. 将你的 iOS 设备连接至电脑。
6. 进入 **TARGETS > Project Name > Signing & Capabilities** 菜单，选择 **Automatically manage signing**，并在弹出菜单中点击 **Enable Automatic**。
</details>


### 集成 MediaPlayer Kit

1. 前往 [SDK 下载页面](https://docs.agora.io/cn/AgoraPlatform/downloads)，获取最新版 MediaPlayer Kit，然后解压。

2. 将 libs 文件夹内的 `AgoraMediaPlayer.framework` 文件复制到项目文件夹下。
3. 在 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** 菜单中，将 `AgoraMediaPlayer.framework` 的状态修改为 **Embed & Sign**。

4. 打开 Xcode，进入 **TARGETS > Project Name > Build Phases > Link Binary with Libraries** 菜单，点击 + 添加如下库。在添加 `AgoraMediaPlayer.framework` 文件时，还需在点击 **+** 后点击 Add Other…，找到本地文件并打开。

   - AgoraMediaPlayer.framework

   - Accelerate.framework

   - AudioToolbox.framework

   - AVFoundation.framework

   - CoreMedia.framework

   - CoreML.framework

   - CoreTelephony.framework

   - libc++.tbd

   - libresolv.tbd

   - SystemConfiguration.framework

   - VideoToolbox.framework

	添加后：
![](https://web-cdn.agora.io/docs-files/1583119068826)

	> 如需支持 iOS 11 或更低版本的设备，请在 Xcode 中将对 **CoreML.framework** 的依赖设为 **Optional**。

5. 根据场景需要，在 **info.plist** 文件中，点击 **+** 图标开始添加如下内容，获取相应的设备权限：

| Key | Type | Value |
| ---------------- | ---------------- | ---------------- |
| Privacy - Microphone Usage Description      | String      | 使用麦克风的目的，例如：for a video call。      |
| Privacy - Camera Usage Description      | String      | 使用摄像头的目的，例如：for a video call。      |

### 集成 Native SDK

**版本要求**：2.4.0 或更高版本。

集成步骤：参考[集成 Native SDK](https://docs.agora.io/cn/InteractiveBroadcast/start_live_ios?platform=iOS#集成-sdk)。

### 集成 RtcChannelPublishPlugin

1. [下载](https://github.com/AgoraIO/Agora-Extensions/tree/master/MediaPlayer/helper/apple) RtcChannelPublishPlugin。
2. 将 RtcChannelPublishPlugin 文件夹复制到项目文件中。

## 实现方法

<a name="local"></a>
### 本地播放媒体资源

集成 MediaPlayer Kit 后，参考如下步骤实现本地播放功能。

**创建一个播放器实例**

创建一个 `AgoraMediaPlayer` 实例。

> 如需同时播放不同的媒体资源，你可以创建多个实例。

**获取事件回调**

重写 `AgoraMediaPlayerDelegate` 代理方法，获取以下事件回调：

- `didChangedToPosition`，报告当前播放进度
- `didChangedToState`，报告播放状态改变
- `didOccurEvent`，报告定位播放状态
- `didReceiveData`，报告媒体附属信息（metadata）的接收
- `didReceiveAudioFrame`，报告每帧音频帧的接收
- `didReceiveVideoFrame`，报告每帧视频帧的接收

通过监听这些事件，你可以更好地掌握播放过程，并使用自定义格式数据（媒体附属信息）。如果播放发生异常，你可以根据这些事件排查问题。

**准备播放**

1. 调用 `AgoraMediaPlayer` 接口的 `setView` 方法设置播放器的渲染视图。

2. 调用 `AgoraMediaPlayer` 接口的 `setRenderMode` 方法设置播放器视图的渲染模式。

3. 调用 `AgoraMediaPlayer` 接口的 `open` 方法打开媒体资源。媒体资源路径可以为网络路径或本地路径，支持绝对路径和相对路径。

   > 请收到 `didChangedToState` 回调报告播放状态为 `AgoraMediaPlayerStateOpenCompleted(2)` 后再进行下一步操作。

4. 调用 `AgoraMediaPlayer` 接口的 `play` 方法本地播放该媒体资源。

**调节播放设置**

调用 `AgoraMediaPlayer` 接口的其他方法，你可以实现如下播放设置：

- 暂停/恢复播放，调节播放进度，调节本地播放音量等。
- 获取媒体资源总时长，获取播放进度，获取当前播放状态，获取该媒体资源中媒体流的个数和每个媒体流的详细信息。

**结束播放**

1. 调用 `AgoraMediaPlayer` 接口的 `stop` 方法停止播放。
2. 将 `setView` 方法中 `view` 赋值为 NULL，释放 view。
3. 使用 iOS ARC 内存管理机制释放 `AgoraMediaPlayer` 实例。

**示例代码**

```objective-c
_mediaPlayerKit = [[AgoraMediaPlayer alloc] initWithDelegate:self];
[_mediaPlayerKit setView:self.containerView];
[_mediaPlayerKit open:url startPos:0];
[_mediaPlayerKit play];
[_mediaPlayerKit stop];
[_mediaPlayerKit seekToPosition:value];
[_mediaPlayerKitadjustVolume:volume];
  
 //重写代理方法 获得播放器的事件回调
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
       didChangedToState:(AgoraMediaPlayerState)state
                   error:(AgoraMediaPlayerError)error;
{
     //todo
}
 
 
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
    didChangedToPosition:(NSInteger)position;
{
}
 
 
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
          didOccurEvent:(AgoraMediaPlayerEvent)event;
{
     //todo
}
 
 
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
          didReceiveData:(NSString *)data
                  length:(NSInteger)length;
{
     //todo
}
 
 
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
    didReceiveVideoFrame:(CVPixelBufferRef
{
    //todo
}
 
 
- (void)AgoraMediaPlayer:(AgoraMediaPlayer *_Nonnull)playerKit
    didReceiveAudioFrame:(CMSampleBufferRef)
{
    //todo
};
```

### 分享媒体资源到远端

集成 MediaPlayer Kit、Agora Native SDK 和 RtcChannelPublishPlugin 后，参考如下步骤将本地用户使用播放器播放的媒体资源分享给 Agora 频道内的远端用户。

**实例化**

1. [实例化 AgoraRtcEngineKit](https://docs.agora.io/cn/InteractiveBroadcast/start_live_ios?platform=iOS#3-初始化-agorartcenginekit) 对象。
2. 实例化 AgoraMediaPlayer 和 RtcChannelPublishHelper 对象。

**播放器完成准备工作**

参考[本地播放资源](#local)，**获取事件回调**，完成**准备播放。**

> 请收到 `didChangedToState` 回调报告播放状态为 `AgoraMediaPlayerStatePlaying(3)` 后再进行下一步操作。

**本地用户加入频道**

参考 [RTC 快速开始](https://docs.agora.io/cn/InteractiveBroadcast/start_live_ios?platform=iOS#4-设置频道场景)，实现本地用户以主播身份加入 Agora 直播频道：

1. 调用 `setChannelProfile` 方法设置频道场景为直播。
2. 调用 `setClientRole` 方法设置本地用户角色为主播。
3. 调用 `enableVideo` 方法开启视频模块。
4. 调用 `joinChannelByToken` 方法使本地用户加入频道。

> 请收到 `joinSuccessBlock` 或 `didJoinChannel` 回调后再进行下一步操作。

**开始分享**

1. 调用 `attachPlayerToRtc` 方法将播放器和 Agora 频道捆绑。播放器画面将占据本地用户视图。
2. 调用 `publishVideo`/`publishAudio` 方法将播放的视频/音频流分享给 Agora 频道内远端用户。
3. 调用 `adjustPublishSignalVolume` 方法调节远端播放音量。

**取消分享**

1. 调用 `unpublishVideo`/`unpublishAudio` 方法取消分享该视频/音频流。
2. 调用 `detachPlayerFromRtc` 方法将播放器和 Agora 频道解绑。
3. （可选）调用 [`setVideoSource`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoSource:) 方法将播放器画面切换为主播画面，使远端用户重新看到主播。

<div class="alert note">请不要略过此步直接调用 <code>leaveChannel</code> 使本地用户取消分享媒体流，否则本地用户重新加入频道时可能会出现以下问题：
	<li>之前停止分享的媒体流会自动发送给频道内远端用户。</li>
	<li>播放媒体资源时，音画不同步。</li></div>

**示例代码**

```objective-c
_rtcEnginekit = [AgoraRtcEngineKit sharedEngineWithAppId:@"YOUR_APPID" delegate:self];
[_rtcEnginekit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
[_rtcEnginekit setClientRole:AgoraClientRoleBroadcaster];
[_rtcEnginekit enableVideo];
[_rtcEnginekit joinChannelByToken:token channelId:channelid info:""  uid:"" joinSuccess:NULL];
[[AgoraRtcChannelPublishHelper shareInstance] attachPlayerToRtc:_mediaPlayerKit RtcEngine:_rtcEnginekit];
[[AgoraRtcChannelPublishHelper shareInstance] publishAudio];
[[AgoraRtcChannelPublishHelper shareInstance] publishVideo];
[[AgoraRtcChannelPublishHelper shareInstance] detachPlayerFromRtc];

if(!_defaultCamera)
{
    _defaultCamera = [[AgoraRtcDefaultCamera alloc] init];
}
[_rtcEngineKit setVideoSource:NULL];
[_rtcEngineKit setVideoSource:_defaultCamera];
```

## 获取日志文件
日志文件包含媒体播放器组件运行时产生的所有日志。日志文件的输出地址为 `App Sandbox/Library/caches/agoraplayer.log`。

## API 文档
详见 [API 文档](./API%20Reference/mediaplayer_oc/docs/headers/MediaPlayer-Kit-Objective-C-API-Overview.html)