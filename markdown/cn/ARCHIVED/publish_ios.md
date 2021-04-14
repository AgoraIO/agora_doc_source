---
title: 发布和订阅音视频流
platform: iOS
updatedAt: 2020-04-20 12:14:02
---
在发布和订阅音视频流前，请确保你已完成环境准备、安装包获取等步骤，并成功加入频道，详见[客户端集成](/cn/Video/ios_video)。

## 实现方法
### 打开视频模式
调用 `enableVideo` 方法打开视频模式。在 Agora SDK 中，音频功能是默认打开的，因此在加入频道前，或通话过程中，你都可以调用该方法开启视频。

- 如果在加入频道前打开，则进入频道后直接加入视频通话或直播。
- 如果在通话或直播过程中打开，则由纯音频话切换为视频通话或直播。

```objective-c
//Objective-C
- (void)enableVideo {
  [self.agoraKit enableVideo];
  // Default mode is disableVideo
}
```

```swift
//Swift
func enableVideo() {
  agoraKit.enableVideo()  //Default mode is disableVideo
}
```

### 设置视频编码属性
打开视频模式后，调用 `setVideoEncoderConfiguration` 方法设置视频的编码属性。

在该方法中，指定你想要的视频编码的分辨率、帧率、码率以及视频编码的方向模式。详细的视频编码参数定义，参考 **设置本地视频属性**(`setVideoEncoderConfiguration`)中的描述。

> - 该方法设置的参数为理想情况下的最大值。当视频引擎因网络等原因无法达到设置的分辨率、帧率或码率值时，会取最接近设置值的最大值。
> - 如果设备的摄像头无法支持定义的视频属性，SDK 会为摄像头自动选择一个合理的分辨率。该行为对视频编码没有影响，编码时 SDK 仍沿用该方法中定义的分辨率。

```objective-c
//Objective-C
AgoraVideoEncoderConfiguration *configuration =
[[AgoraVideoEncoderConfiguration alloc]
initWithSize:AgoraVideoDimension640x360
frameRate:AgoraVideoFrameRateFps15 bitrate:400
orientationMode:AgoraVideoOutputOrientationModeFixedPortrait];

[self.agoraKit setVideoEncoderConfiguration:configuration];
```

```swift
//Swift
let configuration = AgoraVideoEncoderConfiguration(size:
AgoraVideoDimension640x360, frameRate: .fps15, bitrate: 400,
orientationMode: .fixedPortrait)
agoraKit.setVideoEncoderConfiguration(configuration);
```

### 设置本地视频视图
本地视频视图，是指用户在本地设备上看到的本地视频流的视图。

在进入频道前调用 `setupLocalVideo` 方法，使应用程序绑定本地视频流的显示视窗，并设置本地看到的本地视频视图。

在该方法中：

- 选择你想要看到的本地视频流的视窗。
- 指定你想要的视频显示模式。共有两种模式可选：Hidden 和 Fit 模式。两种模式下视频尺寸都是等比缩放，区别在于：
  - Hidden 模式：优先保证视窗被填满。如果缩放后的视频尺寸与显示视窗尺寸不一致，多出的视频将被截掉。
  - Fit 模式：优先保证视频内容全部显示。如果缩放后的视频尺寸与显示视窗尺寸不一致，未被填满的视窗区域将使用黑色填充。
- 传入本地用户的 UID。该值默认为 0，可以不设置。

```objective-c
//Objective-C
- (void)setupLocalVideo {
  AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
  videoCanvas.uid = 0;

  videoCanvas.view = self.localVideo;
  videoCanvas.renderMode = AgoraVideoRenderModeHidden;
  [self.agoraKit setupLocalVideo:videoCanvas];
  // Bind local video stream to view
}
```

```swift
//Swift
func setupLocalVideo() {
  let videoCanvas = AgoraRtcVideoCanvas()
  videoCanvas.uid = 0
  videoCanvas.view = localVideo
  videoCanvas.renderMode = .hidden
  agoraKit.setupLocalVideo(videoCanvas)
}
```


### 设置远端视频视图
端视频视图，是指用户在本地设备上看到的远端视频流的视图。

在进入频道后，调用 `setupRemoteVideo` 方法设置本地看到的远端用户的视频视图。用户需要在该方法中指定想要看到的远端视图的用户 UID。

在该方法中：

- 选择你想要看到的远端视频流的视窗。
- 指定你想要的视频显示模式。共有两种模式可选：Hidden 和 Fit 模式。两种模式下视频尺寸都是等比缩放，区别在于：
  - Hidden 模式：优先保证视窗被填满。如果缩放后的视频尺寸与显示视窗尺寸不一致，多出的视频将被截掉。
  - Fit 模式：优先保证视频内容全部显示。如果缩放后的视频尺寸与显示视窗尺寸不一致，未被填满的视窗区域将使用黑色填充。
- 传入你想要看到的远端视图的用户 UID。如果不知道想要指定的远端用户 UID，也可以在收到其他用户进入频道的回调事件 `didJoinedOfUid` 中使用该方法。

```objective-c
//Objective-C
- (void)setupRemoteVideo {
  AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
  videoCanvas.uid = uid;

  videoCanvas.view = self.remoteVideo;
  videoCanvas.renderMode = AgoraVideoRenderModeFit;
  [self.agoraKit setupRemoteVideo:videoCanvas];
  // Bind remote video stream to view
}
```

```swift
//Swift
func setupRemoteVideo() {
    let videoCanvas = AgoraRtcVideoCanvas()
    videoCanvas.uid = 1
    videoCanvas.view = remoteVideo
    videoCanvas.renderMode = .fit
    agoraKit.setupRemoteVideo(videoCanvas)
}
```

## 相关文档
你已成功开始视频通话。通话结束后，可以使用 Agora SDK 退出当前通话：

- [离开频道](/cn/Video/leave_ios)

如果在通话过程中，对音量、音效、视频分辨率、视频源等有特殊需求，你还可以：

- [调整通话音量](/cn/Video/volume_ios)
- [播放音效/音乐混音](/cn/Video/effect_mixing_ios)
- [使用耳返](/cn/Video/in-ear_ios)
- [调整音调、音色](/cn/Video/voice_effect_ios)
- [设置视频属性](/cn/Video/videoProfile_ios)
- [自定义采集和渲染](/cn/Video/custom_video_ios)
- [进行屏幕共享](/cn/Video/screensharing_ios)