---
title: 发布和订阅音视频流
platform: Windows
updatedAt: 2018-12-12 15:31:02
---

在发布或订阅音频流前，请确保你已完成环境准备、安装包获取等步骤，并成功加入频道，详见[客户端集成](/cn/Video/windows_video)。

## 实现方法

### 打开视频模式

调用 <code>enableVideo</code> 方法打开视频模式。在加入频道前，或通话过程中，你都可以调用该方法开启视频。音频功能是默认打开的。

- 如果在加入频道前打开视频模式，则进入频道后直接加入视频通话或直播。
- 如果在通话或直播过程中打开视频模式，则由纯音频切换为视频通话或直播。

```
nRet = m_lpAgoraEngine->enableVideo();
```

### 设置视频编码属性

打开视频模式后，调用 <code>setVideoProfile</code> 方法设置视频编码属性。

在该方法中：

- 将 <code>AgoraVideoProfile</code> 设置为你想要的值，如 <code>AgoraVideoProfileLandscape360P</code>。该参数对应着一套视频相关的属性，包含视频分辨率、帧率、码率等 。该参数对应着一套视频相关的属性，包含视频分辨率、帧率、码率等。
- 将 <code>swapWidthAndHeight</code> 根据实际需要设置为 true 或者 false。如果设置为 true，则交换视频的宽和高，反之则不交换。
  > - Agora 建议直接通过 <code>AgoraVideoProfile</code> 来定义输出视频的 <code>Orientation</code> 模式；<code>swapWidthAndHeight</code> 建议设为默认的 false。
  > - 如果设备的摄像头无法支持定义的视频属性，SDK 会为摄像头自动选择一个合理的分辨率。该行为对视频编码没有影响，编码时 SDK 仍沿用该方法中定义的分辨率。

```
int nVideoSolution = m_dlgSetup.GetVideoSolution();
lpAgoraEngine->setVideoProfile((VIDEO_PROFILE_TYPE)nVideoSolution, m_dlgSetup.IsWHSwap());
```

### 设置本地视频视图

本地视频视图，是指用户在本地设备上看到的本地视频流的视图。

在进入频道前调用 <code>setupLocalVideo</code> 方法，使应用程序绑定本地视频流的显示视窗，并设置本地看到的本地视频视图。

在该方法中：

- 选择你想要看到的本地视频流的视窗。
- 指定你想要的视频显示模式。共有两种模式可选：Hidden 和 Fit 模式。两种模式下视频尺寸都是等比缩放，区别在于：

  - Hidden 模式：优先保证视窗被填满。如果缩放后的视频尺寸与显示视窗尺寸不一致，多出的视频将被截掉。
  - Fit 模式：优先保证视频内容全部显示。如果缩放后的视频尺寸与显示视窗尺寸不一致，未被填满的视窗区域将使用黑色填充。

- 传入本地用户的 UID。该值默认为 0，可以不设置。

```
VideoCanvas vc;

vc.uid = 0;
vc.view = m_dlgVideo.GetLocalVideoWnd();
vc.renderMode = RENDER_MODE_TYPE::RENDER_MODE_FIT;

lpRtcEngine->setupLocalVideo(vc);
```

### 设置远端视频视图

远端视频视图，是指用户在本地设备上看到的远端视频流的视图。

在进入频道后，调用 <code>setupRemoteVideo</code> 方法设置本地看到的远端用户的视频视图。

在该方法中：

- 选择你想要看到的远端视频流的视窗。
- 指定你想要的视频显示模式。共有两种模式可选：Hidden 和 Fit 模式。两种模式下视频尺寸都是等比缩放，区别在于：

  - Hidden 模式：优先保证视窗被填满。如果缩放后的视频尺寸与显示视窗尺寸不一致，多出的视频将被截掉。
  - Fit 模式：优先保证视频内容全部显示。如果缩放后的视频尺寸与显示视窗尺寸不一致，未被填满的视窗区域将使用黑色填充。

- 传入你想要看到的远端视图的用户 UID。如果不知道想要指定的远端用户 UID，也可以在收到其他用户进入频道的回调事件 <code>onUserJoined</code> 中使用该方法。

```
canvas.uid = agvWndInfo.nUID;
canvas.view = m_wndVideo[nIndex].GetSafeHwnd();

CAgoraObject::GetEngine()->setupRemoteVideo(canvas);
```

## 相关文档

你已成功开始语音通话。通话结束后，可以使用 Agora SDK 退出当前通话：

- [离开频道](/cn/Video/leave_windows)

如果在通话过程中，对音量、音效、音调等有特殊需求，你还可以：

- [调整通话音量](/cn/Video/volume_windows)
- [播放音效/音乐混音](/cn/Video/effect_mixing_windows)
- [调整音调、音色](/cn/Video/voice_effect_windows)
- [设置视频属性](/cn/Video/videoProfile_windows)
- [自定义采集和渲染](/cn/Video/custom_video_windows)
- [进行屏幕共享](/cn/Video/screensharing_windows)
