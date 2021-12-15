---
title: 推流组件
platform: iOS
updatedAt: 2021-01-31 11:12:43
---

## 简介

Agora 为 CDN 直播推流场景研发 Streaming Kit（推流组件），支持将单个主播音视频流推送到 CDN。如果你同时集成 Streaming Kit 和 Agora RTC SDK，你还可以在观众无感知的情况下实现单主播和多主播画面的动态切换。

![](https://web-cdn.agora.io/docs-files/1597407339661)

## 示例项目

Agora 在 GitHub 上提供开源的 [Agora-Extensions](https://github.com/AgoraIO/Agora-Extensions) 示例项目供你参考：

- [RtmpStreaming](https://github.com/AgoraIO/Agora-Extensions/tree/master/RtmpStreaming)：适用于无需美颜的开发者参考。
- [RtmpSteramingWithBeauty](https://github.com/AgoraIO/Agora-Extensions/tree/master/RtmpStreamingWithBeauty)：适用于需要美颜功能的开发者参考。

## 准备开发环境

### 前提条件

- Xcode 9.0 或以上版本
- iOS 8.0 或以上版本的设备

> 使用 Agora RTC SDK 时，请确保你有有效的 Agora 账户（免费[注册](https://dashboard.agora.io/)）并参考[快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_android?platform=Android#准备开发环境)集成 SDK。

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

### 集成 Streaming Kit

**方法一：使用 CocoaPods 自动集成**

1. 开始前请确保你已安装 Cocoapods。参考 [Getting Started with CocoaPods](https://guides.cocoapods.org/using/getting-started.html#getting-started) 安装说明。
2. 在 **Terminal** 里进入项目根目录，并运行 `pod init` 命令。项目文件夹下会生成一个 **Podfile** 文本文件。
3. 打开 **Podfile** 文件，修改文件为如下内容。注意将 `Your App` 替换为你的 Target 名称。

   ```
   target 'Your App' do
       pod 'AgoraStreamingKit_iOS'
   end
   ```

4. 在 **Terminal** 内运行 `pod update` 命令更新本地库版本。
5. 运行 `pod install` 命令安装 Streaming Kit。成功安装后，**Terminal** 中会显示 `Pod installation complete!`，此时项目文件夹下会生成一个 `xcworkspace` 文件。
6. 打开新生成的 `xcworkspace` 文件。

**方法二：手动复制 Streaming Kit 文件**

1. 前往[下载](./downloads?platform=iOS)页面，下载最新版 Streaming Kit，然后解压。

2. 将 `libs` 文件夹内的 `AgoraStreamingKit.framework` 文件复制到项目文件夹下。
3. 在 **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** 菜单中，将 `AgoraStreamingKit.framework` 的状态修改为 **Embed & Sign**。

4. 打开 Xcode，进入 **TARGETS > Project Name > Build Phases > Link Binary with Libraries** 菜单，点击 + 添加如下库。在添加 `AgoraStreamingKit.framework` 文件时，还需在点击 **+** 后点击 Add Other…，找到本地文件并打开。

   - AgoraStreamingKit.framework

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
   ![](https://web-cdn.agora.io/docs-files/1597407353344)

   > 如需支持 iOS 11 或更低版本的设备，请在 Xcode 中将对 **CoreML.framework** 的依赖设为 **Optional**。

5. 根据场景需要，在 **info.plist** 文件中，点击 **+** 图标开始添加如下内容，获取相应的设备权限：

   | Key                                    | Type   | Value                                        |
   | -------------------------------------- | ------ | -------------------------------------------- |
   | Privacy - Microphone Usage Description | String | 使用麦克风的目的，例如：`for live streaming` |
   | Privacy - Camera Usage Description     | String | 使用摄像头的目的，例如：`for live streaming` |

## 实现方法

你可以参考本节依次实现如下功能：

1. 单主播推流。
2. 单主播推流切换为多位主播直播推流。
3. 多位主播直播推流切换为单主播推流。

### 单主播推流

#### 1. 创建 Streaming Kit

创建一个 `AgoraStreamingKit` 实例，并设置 `AgoraStreamingContext` 的如下参数：

- `appId`: 你的 App ID。
- `delegate`: 详见 `AgoraStreamingDelegate`。
- `audioStreamConfiguration`: 音频编码属性。推荐使用默认的音频编码属性：采样率 44.1 kHz，码率 48 Kbps，16 bits，单声道，LC-AAC。
- `videoStreamConfiguration`: 视频编码属性，推荐使用默认的视频编码属性：分辨率 640 \* 360，帧率 15 fps，码率 800 Kbps，方向模式为 `OrientationModeFixedPortrait (2)`。

```objective-c
- (void)createStreamingKit {
    AgoraStreamingContext *context = [[AgoraStreamingContext alloc] init];
    // 设置音频配置信息
    context.audioStreamConfiguration = [AgoraAudioStreamConfiguration defaultConfiguration];
    // 设置视频配置信息
    context.videoStreamConfiguration = [AgoraVideoStreamConfiguration defaultConfiguration];
    context.appId = @"AppId";
    // 设置代理回调
    context.delegate = self;
    // 初始化 AgoraStreamingKit 单实例
    self.streamingKit = [AgoraStreamingKit sharedStreamingKitWithContext:context];
}
```

#### 2. 管理日志

你可以使用默认的日志设置。如果你需要管理日志，请在创建 Streaming Kit 后立即调用如下方法。

```objective-c
- (void)setupLog:(NSString *)filePath {
    // 设置日志文件路径，默认为 App Sandbox/Library/Caches/streaming-kit.log
    [self.streamingKit setLogFile:filePath];
    // 设置日志文件大小，默认为 512 KB
    [self.streamingKit setLogFileSize:512];
    // 设置日志过滤级别，默认为 INFO
    [self.streamingKit setLogFilter:LogFilterInfo];
}
```

#### 3. 管理本地预览视图

如果你想让主播在直播推流开始前进行本地预览，请在创建 Streaming Kit 后调用如下方法：

```objective-c
- (void)setupPreview:(UIView *)view {
    //（必须）获取 preview renderer 对象，以管理所有与渲染相关的操作
    AgoraVideoPreviewRenderer *previewRenderer = [self.streamingKit getVideoPreviewRenderer];
    // 设置本地预览视图
    [previewRenderer setView:view];
    // 设置本地预览视图的镜像模式，默认情况下，使用前置摄像头开启镜像，使用后置摄像头不开启镜像
    [previewRenderer setMirrorMode:MirrorModeAuto];
    // 设置本地预览渲染模式，默认为 FIT 模式
    [previewRenderer setRenderMode:RenderModeFit];
}
```

#### 4. 开启录音和摄像头

开始直播推流前，你需要让 Streaming Kit 对主播进行录音和视频采集。该步骤和步骤 3 无严格先后顺序。

```objective-c
// 开启录音，不支持推流过程中调用
[self.streamingKit enableAudioRecording:YES];
// 开启视频采集，不支持推流过程中调用
[self.streamingKit enableVideoCapturing:YES];
```

#### 5. 添加和删除自定义美颜

如果你想给主播美颜，请调用 `addVideoFilter` 向 video track 添加一个 video filter。然后自行实现 VideoFilter 类，使用该类的 `process` 方法。

Streaming Kit 通过 `process` 方法的 `inputPixelBuffer` 参数向你输出采集到的视频帧。拿到视频帧后，你可以通过第三方 SDK 对视频帧进行美颜等前处理。最后，将处理后的视频帧通过 `process` 方法的返回值传回 Steaming Kit。

> 如果你想抛弃视频帧，将返回值传空。

```objective-c
// 添加自定义美颜
[self.streamingKit addVideoFilter:videoFilter];
// 删除自定义美颜
[self.streamingKit removeVideoFilter:videoFilter];
```

#### 6. 开始和结束单主播 CDN 直播推流

调用如下方法开始推流：

```objective-c
// 开始单主播直推 CDN
[self.streamingKit startStreaming:publishUrl];
// 停止单主播直推 CDN
[self.streamingKit stopStreaming];
```

`startStreaming` 成功和失败会分别触发 `onStartStreamingSuccess` 和 `onStartStreamingFailure` 回调。失败时，请通过 `AgoraStartStreamingError` 排查问题。`startStreaming` 成功后，如果推送的媒体流出错，kit 会触发 `onMediaStreamingFailure` 回调。你可以通过 `AgoraMediaStreamingError` 和 `msg` 信息排查媒体流的问题。推流过程中，你可以通过 `onStreamingConnectionStateChanged` 回调监听当前推流状态，详见 `AgoraStreamingConnectionState`。

如果你想只推视频流或只推音视流，你可以在 `startStreaming` 后调用 `muteAudioStream` 或 `muteVideoStream`。如果你想切换摄像头，可以在 `startStreaming` 前和后调用 `switchCamera`。

> - Streaming Kit 在 iOS 设备上默认使用前置摄像头。
> - Streaming Kit 不支持在 `startStreaming` 后调用 `enableAudioRecording` 和 `enableVideoCapturing`。

#### 7. 销毁 Streaming Kit

销毁 Streaming Kit 后，请确保不再使用 Streaming Kit 提供的 API。

```objective-c
// 销毁 StreamingKit ，同时需要将实例置为 nil
[self.streamingKit releaseStreamingKit];
 self.streamingKit = nil;
```

### 动态切换

#### 单主播切换为多主播

当其他主播加入单主播的直播推流时，你需要先结束单主播的 CDN 直播推流，然后注册音视频观测器接收音频帧，并将音视频帧作为 RTC SDK 的自定义音频源和自定义视频源。最后使用 RTC SDK 提供的 CDN 推流 API 完成多主播的直播推流。

![](https://web-cdn.agora.io/docs-files/1597407371916)

```objective-c
- (void)switchToAgoraChannel {
    // 结束单主播 CDN 直播推流
    [self.streamingKit stopStreaming];
    // 设置 RTC SDK 自定义音频源
    [self.agoraKit enableExternalAudioSourceWithSampleRate:audioSampleRate channelsPerFrame:audioChannels];
    // 设置 RTC SDK 自定义视频源
    [self.agoraKit setExternalVideoSource:YES useTexture:YES pushMode:YES];
    // 加入 Agora 频道
    [self.agoraKit joinChannelByToken:[KeyCenter Token] channelId:self.roomName info:nil uid:0 joinSuccess:nil];

    // 在 onJoinChannelSuccess 和 didJoinedOfUid 回调之后，依次调用 setLiveTranscoding 和 addPublishStreamUrl 开始旁路推流
    ......
}
```

详情请参考如下文档：

- [自定义音频采集](https://docs.agora.io/cn/Interactive%20Broadcast/custom_audio_apple?platform=iOS#自定义音频采集)
- [自定义视频采集(Push)](https://docs.agora.io/cn/Interactive%20Broadcast/custom_video_apple?platform=iOS#自定义视频采集)
- [使用 RTC SDK 推流到 CDN](https://docs.agora.io/cn/Interactive%20Broadcast/cdn_streaming_apple?platform=iOS#前提条件)

#### 多主播切换为单主播

当其他主播离开单主播的直播推流时，你需要使用 RTC SDK 的推流 API 结束多主播的直播推流，然后离开 RTC 频道，并取消注册音视频观测器。最后开始单主播的直播推流。

![](https://web-cdn.agora.io/docs-files/1597407385889)

```objective-c
- (void)switchToRtmpStreaming {
    // 结束 RTC SDK 提供的旁路推流
    [self.agoraKit removePublishStreamUrl:self.publishUrl];
    // 退出 Agora RTC 频道
    [self.agoraKit leaveChannel:nil];
    // 关闭 RTC SDK 自定义音频源
    [self.agoraKit disableExternalAudioSource];
    // 关闭 RTC SDK 自定义视频源
    [self.agoraKit setExternalVideoSource:NO useTexture:NO pushMode:NO];
    // 开始单主播 CDN 直播推流
    [self.streamingKit startStreaming:self.publishUrl];
}
```

## API 参考

[Streaming Kit API 文档](./API%20Reference/rsk_oc/docs/headers/RTMP-Streaming-Kit-Objective-C-API-Overview.html)
