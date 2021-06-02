---
title: 通话前网络和设备检测
platform: iOS
updatedAt: 2021-02-03 06:27:27
---
## 功能描述

在对质量要求高的场景下，进行通话前检测可以帮助提前识别并排查问题，保证实时通信体验。通话前检测通常可以从如下两个角度开展：

- 网络质量探测：通过探测当前的上下行 last mile 网络质量，判断或预测用户当前的网络状况是否良好。
- 设备质量检测：检测本地音频采集设备和播放设备是否能正常工作。

Agora SDK 提供了完备的网络探测及设备检测接口，帮助你实现如上功能，保证用户的使用体验。本文介绍如何使用相关 API 实现上述功能。

## 示例项目

Agora 在 GitHub 提供了一个开源的 API-Examples iOS 示例项目，其中的 [PrecallTest.swift](https://github.com/AgoraIO/API-Examples/blob/master/iOS/APIExample/Examples/Advanced/PrecallTest/PrecallTest.swift) 文件中实现了通话前检测功能。你可以直接下载体验或查看其中的源代码。

## 网络质量探测

从 v2.4.0 起，Agora RTC Native SDK 提供了一个 `startLastmileProbeTest` 方法，支持用户在加入频道前进行网络质量探测，然后通过回调将当前网络质量的相关数据，包括往返时延、上下行丢包率、上下行网络带宽等返回给 app。

### 实现方法

开始前请确保已在项目中实现了基本的音视频通信或直播功能。

参考如下步骤了解相关 API 的工作原理。

1. 在用户加入频道或上麦前，调用 `startLastmileProbeTest` 进行网络质量探测。调用该方法时，你需要指定期望的最大上下行码率。
2. 启用该方法后，SDK 会依次返回如下两个回调：
	- `lastmileQuality`：约两秒内返回，且每两秒触发一次。该回调通过打分反馈上下行网络质量，更贴近主观感受。
	- `lastmileProbeResult`：约 30 秒内返回。该回调通过客观数据反馈上下行网络质量，更客观。
3. 获取到网络质量数据后，调用 `stopLastmileProbeTest` 停止通话前网络质量探测。

各 API 的调用时序如下图所示： 

![](https://web-cdn.agora.io/docs-files/1603706208379)

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
    lastmileResultLabel.text = "Quality: \(quality.description())"
}
 
 
// 调用 startLastmileProbeTest 后 30 秒内，收到 lastmileProbeResult 回调，了解更细节的网络数据
func rtcEngine(_ engine: AgoraRtcEngineKit, lastmileProbeTest result: AgoraLastmileProbeResult) {
  // 往返时延
  let rtt = "Rtt: \(result.rtt)ms"
  // 下行带宽
  let downlinkBandWidth = "DownlinkAvailableBandwidth: \(result.downlinkReport.availableBandwidth)Kbps"
  // 下行网络抖动
  let downlinkJitter = "DownlinkJitter: \(result.downlinkReport.jitter)ms"
  // 下行网络丢包率
  let downlinkLoss = "DownlinkLoss: \(result.downlinkReport.packetLossRate)%"
   
  // 上行带宽
  let uplinkBandwidth = "UplinkAvailableBandwidth: \(result.uplinkReport.availableBandwidth)Kbps"
  // 上行网络抖动
  let uplinkJitter = "UplinkJitter: \(result.uplinkReport.jitter)ms"
  // 上行网络丢包率
  let uplinkLoss = "UplinkLoss: \(result.uplinkReport.packetLossRate)%"
   
  // 在 lastmileProbeTest 回调中获取网络探测结果数据
  lastmileProbResultLabel.text = [rtt, downlinkBandwidth, downlinkJitter, downlinkLoss, uplinkBandwidth, uplinkJitter, uplinkLoss].joined(separator: "\n")
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

从 v2.4.0 起，Agora RTC Native SDK 通过一个 `startEchoTestWithInterval` 方法，支持用户在加入频道前，启动通话测试。该测试的目的是测试系统的音频设备（耳麦、扬声器等）和网络连接是否正常。

### 实现方法

开始前请确保已在项目中实现了基本的音视频通信或直播功能。详见开始[音视频通话](start_call_ios)或[开始互动直播](start_live_ios)。

参考如下步骤了解相关 API 的工作原理。

1. 在加入频道前，调用 `startEchoTestWithInterval` 方法。调用该方法时，你需要设置一个 `interval` 参数，表示获取本次测试结果的间隔时间。该参数单位为秒，取值范围为 [2,10]，默认值为 10。
2. 成功调用 `startEchoTestWithInterval` 方法后，引导用户先说一段话，如果声音在设置的时间间隔后回放出来，且用户能听到自己刚才说的话，则表示系统音频设备和网络连接都是正常的。
3. 获取音频设备测试结果后，调用 `stopEchoTest` 方法停止语音通话检测，然后你可以调用 `joinChannelByToken` 加入频道。

### 示例代码

你可以参考如下示例代码实现通话检测功能。

```swift
// Swift
// 开启通话测试。10 表示 10 秒后播放本次测试录到的声音，获取测试结果
agoraKit.startEchoTestWithInterval(10)
 
// 等待并检查是否可以听到自己的声音回放
 
// 停止测试
agoraKit.stopEchoTest()
```

### API 参考

- [`startEchoTestWithInterval`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startEchoTestWithInterval:successBlock:)
- [`stopEchoTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopEchoTest)

## 开发注意事项

- 调用 `startLastmileProbeTest` 进行通话前网络质量探测时，会消耗一定的网络流量。因此调用方法后，Agora 建议在收到 `lastmileProbeResult` 回调之前不要调用其他方法，避免因 API 操作过于频繁导致其他方法无法执行。
- `lastmileQuality` 回调第一次报告的结果有一定概率是 `Unknown`，可通过之后的几次回调获得结果。
- 开启网络测试后，音频 SDK 使用 48 Kbps 的固定探测码率；视频 SDK 则会根据当前选定的视频属性调整探测码率。
- 直播场景下，只有角色为主播的用户才能调用 `startEchoTestWithInterval`。
- 调用 `startEchoTestWithInterval` 开始通话测试后，必须调用对应的 `stop` 方法以结束测试，否则无法进行下一次测试，也不能加入频道。

