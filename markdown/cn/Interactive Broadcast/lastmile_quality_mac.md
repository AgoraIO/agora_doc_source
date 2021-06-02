---
title: 通话前网络和设备检测
platform: iOS
updatedAt: 2021-02-03 06:27:15
---
## 功能描述

在对质量要求高的场景下，进行通话前检测可以帮助提前识别并排查问题，保证实时通信体验。通话前检测通常可以从如下两个角度开展：

- 网络质量探测：通过探测当前的上下行 last mile 网络质量，判断或预测用户当前的网络状况是否良好。
- 设备质量检测：检测音视频设备是否能正常工作。

Agora SDK 提供了完备的网络探测及设备检测接口，帮助你实现如上功能，保证用户的使用体验。本文介绍如何使用相关 API 实现上述功能。

## 示例项目

Agora 在 GitHub 提供了一个开源的 API-Examples maOS 示例项目，其中的 [PrecallTest.swift](https://github.com/AgoraIO/API-Examples/tree/master/macOS/APIExample/Examples/Advanced/PrecallTest) 文件中实现了通话前检测功能。你可以直接下载体验或查看其中的源代码。

## 网络质量探测

从 v2.4.0 起，Agora RTC Native SDK 提供了一个 `startLastmileProbeTest` 方法，支持用户在加入频道前进行网络质量探测，然后通过回调将当前网络质量的相关数据，包括往返时延、上下行丢包率、上下行网络带宽等返回给 app。

### 实现方法

开始前请确保已在项目中实现了基本的实时音视频功能。详见[开始音视频通话](start_call_mac)或[开始互动直播](start_live_mac)。

参考如下步骤了解相关 API 的工作原理。

1. 在用户加入频道或上麦前，调用 `startLastmileProbeTest` 进行网络质量探测。调用该方法时，你需要指定期望的最大上下行码率。
2. 启用该方法后，SDK 会依次返回如下两个回调：
	- `lastmileQuality`：约两秒内返回，且每两秒触发一次。该回调通过打分反馈上下行网络质量，更贴近主观感受。
	- `lastmileProbeResult`：约 30 秒内返回。该回调通过客观数据反馈上下行网络质量，更客观。
3. 获取到网络质量数据后，调用 `stopLastmileProbeTest` 停止通话前网络质量探测。

各 API 的调用时序如下图所示：

![](https://web-cdn.agora.io/docs-files/1569465210614)

### 示例代码

你可以参考如下示例代码实现网络质量探测功能。

```swift
// Swift
let config = AgoraLastmileProbeConfig()
// 确认进行上行网络探测
config.probeUplink = true;
// 确认进行下行网络探测
config.probeDownlink = true;
// 期望的最大上行码率，单位为 bps，取值范围 [100000,5000000]
config.expectedUplinkBitrate = 100000;
// 期望的最大下行码率，单位为 bps，取值范围 [100000,5000000]
config.expectedDownlinkBitrate = 100000;
// 调用 startLastmileProbeTest 开启网络探测
agoraKit.startLastmileProbeTest(config)
```

```swift
// Swift
// 调用 startLastmileProbeTest 后 2 秒内，收到 lastmileQuality 回调，了解上下行网络质量。该回调每 2 秒触发一次
func rtcEngine(_ engine: AgoraRtcEngineKit, lastmileQuality quality: AgoraNetworkQuality) {
    lastmileResultLabel.stringValue = "Quality: \(quality.description())"
}

// 调用 startLastmileProbeTest 后 30 秒内，收到 lastmileProbeResult 回调，了解更细节的网络数据
func rtcEngine(_ engine: AgoraRtcEngineKit, lastmileProbeTest result: AgoraLastmileProbeResult) {
    // 往返时延
    let rtt = "Rtt: \(result.rtt)ms"
    // 下行带宽
    let downlinkBandWidth = "DownlinkAvailableBandwidth: \(result.  downlinkReport.availableBandwidth)Kbps"
    // 下行网络抖动
    let downlinkJitter = "DownlinkJitter: \(result.downlinkReport.  jitter)ms"
    // 下行网络丢包率
    let downlinkLoss = "DownlinkLoss: \(result.downlinkReport.  packetLossRate)%"

    // 上行带宽
    let uplinkBandwidth = "UplinkAvailableBandwidth: \(result.  uplinkReport.availableBandwidth)Kbps"
    // 上行网络抖动
    let uplinkJitter = "UplinkJitter: \(result.uplinkReport.jitter)  ms"
    // 上行网络丢包率
    let uplinkLoss = "UplinkLoss: \(result.uplinkReport.  packetLossRate)%"

    // 在 lastmileProbeTest 回调中获取网络探测结果数据
    lastmileProbResultLabel.stringValue = [rtt, downlinkBandwidth, downlinkJitter, downlinkLoss, uplinkBandwidth, uplinkJitter, uplinkLoss].joined(separator: "\n")
}
```

```swift
// Swift
// 获取网络探测数据后停止探测。
// 可以选择在 lastmileProbeResult 回调内部结束测试，也可以在其他时候结束测试。结束测试前，Agora 建议不要调用其他方法
agoraKit.stopLastmileProbeTest()
```

### API 参考

- [`startLastmileProbeTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startLastmileProbeTest:)
- [`stopLastmileProbeTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopLastmileProbeTest)
- [`lastmileQuality`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileQuality:)
- [`lastmileProbeResult`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileProbeTestResult:)

## 设备质量检测

为保证通话或直播质量，我们推荐在进入频道前进行音视频设备测试，检测麦克风、摄像头等音视频设备能否正常工作。该功能对于有高质量要求的场景，如在线教育等，尤为适用。

开始前请确保已在项目中实现了基本的实时音视频功能。详见[开始音视频通话](start_call_mac)或[开始互动直播](start_live_mac)。

参考以下步骤测试音视频设备：

- 选择以下一种方式测试音频设备：
	- 调用 `startEchoTestWithInterval` 测试系统的音频设备（耳麦、扬声器等）和网络连接。
	- 调用 `startRecordingDeviceTest` 测试录音设备，调用 `startPlaybackDeviceTest` 测试音频播放设备。
	- 调用 `startAudioDeviceLoopbackTest` 测试音频设备回路（包括录音设备和音频播放设备）。
- 调用 `startCaptureDeviceTest` 方法测试视频采集设备。

<div class="alert note">所有测试设备的方法都必须在加入频道之前调用。</div>

### 语音通话测试

- 用途：测试系统的音频设备（耳麦、扬声器等）和网络连接，是否正常工作。
- 测试方法和原理：调用 `startEchoTestWithInterval`，并使用该方法的 `interval` 参数设置返回测试结果的时间间隔；用户说话；SDK 在设定的时间间隔后，如果能正常播放该用户说的话，则说明音频设备及网络连接正常。

```swift
// Swift
// 开启通话测试。10 表示 10 秒后播放本次测试录到的声音，获取测试结果
agoraKit.startEchoTestWithInterval(10)

// 等待并检查是否可以听到自己的声音回放

// 停止测试
agoraKit.stopEchoTest()
```

### 音频录制设备测试

- 用途：测试本地音频录制设备，如麦克风，是否正常工作。
- 测试方法和原理：调用 `startRecordingDeviceTest`，并使用该方法的 `indicationInterval` 参数设置返回音量提示的间隔；用户说话，SDK 在 `reportAudioVolumeIndication` 回调中报告音量信息。UID 为 0 表示本地音量。完成测试后，需调用 `stopRecordingDeviceTest` 停止录制设备测试。

<div class="alert note">建议将 <code>indicationInterval</code> 参数设置到大于 200 毫秒，最小不得少于 10 毫秒，否则会收不到 <code>reportAudioVolumeIndication</code> 回调。</div>

```swift
// Swift
agoraKit.startRecordingDeviceTest(1000)

agoraKit.stopRecordingDeviceTest()
```

### 音频播放设备测试

- 用途：测试本地音频播放设备，如外放设备，是否正常工作。
- 测试方法和原理：调用 `startPlaybackDeviceTest`并指定播放的音频文件。如果能听到声音，说明播放设备能正常工作，SDK 会触发 `reportAudioVolumeIndication` 回调报告音频播放设备（UID 为 1）的音量信息。完成测试后，需调用 `stopPlaybackDeviceTest` 停止播放设备测试。

```swift
// Swift
agoraKit.startPlaybackDeviceTest("audio file path")

agoraKit.stopPlaybackDeviceTest()
```

### 音频设备回路测试

- 用途：测试本地音频设备回路是否正常工作。
- 测试方法和原理：调用 `startAudioDeviceLoopbackTest`，并使用该方法的 `indicationInterval` 参数设置返回音量提示的间隔；用户说话，麦克风会采集本地讲话声音，然后用扬声器播放，同时 SDK 会返回两个`reportAudioVolumeIndication` 回调，分别报告音频采集设备（UID 为 0）的音量信息和音频播放设备（UID 为 1）的音量信息。完成测试后，需调用 `stopAudioDeviceLoopbackTest` 停止录制设备测试。

<div class="alert note">建议将 <code>indicationInterval</code> 参数设置到大于 200 毫秒，最小不得少于 10 毫秒，否则会收不到 <code>reportAudioVolumeIndication</code> 回调。</div>

```swift
// Swift
agoraKit.startAudioDeviceLoopbackTest(50)

agoraKit.stopAudioDeviceLoopbackTest()
```

### 视频采集设备测试

- 用途：测试本地视频采集设备，如摄像头，是否正常功能。
- 测试方法和原理：调用 `enableVideo` 开启视频模块后，调用 `startCaptureDeviceTest`；用户指定显示图像的窗口，能看到本地采集的图像，则说明视频设备正常工作。完成测试后，需调用 `stopCaptureDeviceTest` 停止视频设备测试。

```swift
// Swift
agoraKit.startCaptureDeviceTest(videos[0])

agoraKit.stopCaptureDeviceTest()
```

### API 参考

* [`startEchoTestWithInterval`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startEchoTestWithInterval:successBlock:)
* [`stopEchoTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopEchoTest)
* [`startRecordingDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startRecordingDeviceTest:)
* [`stopRecordingDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopRecordingDeviceTest.)
* [`startPlaybackDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startPlaybackDeviceTest:)
* [`stopPlaybackDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopPlaybackDeviceTest)
* [`startCaptureDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startCaptureDeviceTest:)
* [`stopCaptureDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopCaptureDeviceTest)
* [`startAudioDeviceLoopbackTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startAudioDeviceLoopbackTest:)
* [`stopAudioDeviceLoopbackTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopAudioDeviceLoopbackTest)

## 开发注意事项

- 调用 `startLastmileProbeTest` 进行通话前网络质量探测时，会消耗一定的网络流量。因此调用方法后，Agora 建议在收到 `lastmileProbeResult` 回调之前不要调用其他方法，避免因 API 操作过于频繁导致其他方法无法执行。
- `lastmileQuality` 回调第一次报告的结果有一定概率是 `Unknown`，可通过之后的几次回调获得结果。
- 开启网络测试后，音频 SDK 使用 48 Kbps 的固定探测码率；视频 SDK 则会根据当前选定的视频属性调整探测码率。
- 直播场景下，只有角色为主播的用户才能调用 `startEchoTestWithInterval`。
- 调用 `startEchoTestWithInterval` 开始通话测试后，必须调用对应的 `stop` 方法以结束测试，否则无法进行下一次测试，也不能加入频道。


