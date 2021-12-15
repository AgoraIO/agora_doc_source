---
title: 音视频设备测试
platform: macOS
updatedAt: 2020-03-06 16:35:22
---

## 功能描述

为保证通话或直播质量，我们推荐在进入频道前进行音视频设备测试，检测麦克风、摄像头等音视频设备能否正常工作。该功能对于有高质量要求的场景，如在线教育等，尤为适用。

## 实现方法

请确保你已经了解如何[实现音视频通话](start_call_mac)或[互动直播](start_live_mac)。

参考以下步骤测试音视频设备：

- 选择以下一种方式测试音频设备：
  - 调用 `startRecordingDeviceTest` 测试录音设备，调用 `startPlaybackDeviceTest` 测试音频播放设备。
  - 调用 `startAudioDeviceLoopbackTest` 测试音频设备回路（包括录音设备和音频播放设备）。
- 调用 `startCaptureDeviceTest` 方法测试视频采集设备。

<div class="alert note">所有测试设备的方法都必须在加入频道之前调用。</div>

### 录音设备测试

- 用途：测试本地音频录制设备，如麦克风，是否正常工作。
- 测试方法和原理：调用 `startRecordingDeviceTest`；用户说话，SDK 在 `reportAudioVolumeIndication` 回调中报告音量信息。UID 为 0 表示本地音量。完成测试后，需调用 `stopRecordingDeviceTest` 停止录制设备测试。

```swift
// swift
// 开始录制设备测试
agoraKit.startRecordingDeviceTest(1000)

// 停止录制设备测试
agoraKit.stopRecordingDeviceTest()
```

```oc
// objective-c
// 开始录制设备测试
[agoraKit startRecordingDeviceTest: 1000];

// 停止录制设备测试
[agoraKit stopRecordingDeviceTest];
```

### 音频播放设备测试

- 用途：测试本地音频播放设备，如外放设备，是否正常工作。
- 测试方法和原理：调用 `startPlaybackDeviceTest`；用户指定播放的音频文件，能听到声音，则说明播放设备正常工作。完成测试后，需调用 `stopPlaybackDeviceTest` 停止播放设备测试。

```swift
// swift
// 开始播放设备测试
agoraKit.startPlaybackDeviceTest("audio file path")

// 停止播放设备测试
agoraKit.stopPlaybackDeviceTest()
```

```oc
// objective-c
// 开始播放设备测试
[agoraKit startPlaybackDeviceTest: @"audio file path"];

// 停止播放设备测试
[agoraKit stopPlaybackDeviceTest];
```

### 音频设备回路测试

- 用途：测试本地音频设备回路是否正常工作。
- 测试方法和原理：调用 `startAudioDeviceLoopbackTest`；用户说话，麦克风会采集本地讲话声音，然后用扬声器播放，同时 SDK 会在 `reportAudioVolumeIndication` 回调中报告音量信息。UID 为 0 表示本地音量。完成测试后，需调用 `stopAudioDeviceLoopbackTest` 停止录制设备测试。

### 视频采集设备测试

- 用途：测试本地视频采集设备，如摄像头，是否正常功能。
- 测试方法和原理：调用 `enableVideo` 开启视频模块后，调用 `startCaptureDeviceTest`；用户指定显示图像的窗口，能看到本地采集的图像，则说明视频设备正常工作。完成测试后，需调用 `stopCaptureDeviceTest` 停止视频设备测试。

```swift
// swift
// 开始视频采集设备测试
agoraKit.startCaptureDeviceTest("view window")

// 停止视频采集设备测试
agoraKit.stopCaptureDeviceTest
```

```objective-c
// objective-c
// 开始视频采集设备测试
[agoraKit startCaptureDeviceTest: "view window"];

// 停止视频采集设备测试
[agoraKit stopCaptureDeviceTest];
```

### API 参考

- [`startRecordingDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startRecordingDeviceTest:)
- [`stopRecordingDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopRecordingDeviceTest.)
- [`startPlaybackDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startPlaybackDeviceTest:)
- [`stopPlaybackDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopPlaybackDeviceTest)
- [`startCaptureDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startCaptureDeviceTest:)
- [`stopCaptureDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopCaptureDeviceTest)
- [`startAudioDeviceLoopbackTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startAudioDeviceLoopbackTest:)
- [`stopAudioDeviceLoopbackTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopAudioDeviceLoopbackTest)

## 开发注意事项

在初始化输入设备时可能失败，请查询对应的 [错误信息](./API%20Reference/oc/Constants/AgoraErrorCode.html)。
