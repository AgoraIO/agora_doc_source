---
title: 音频设备测试与切换
platform: iOS
updatedAt: 2020-03-06 16:41:45
---

## 功能描述

为保证通话或直播质量，我们推荐在进入频道前进行音视频设备测试，检测麦克风、摄像头等音视频设备能否正常工作。该功能对于有高质量要求的场景，如在线教育等，尤为适用。

Agora 通过一个 `startEchoTestWithInterval` 方法，支持用户在加入频道前，启动语音通话测试。该测试目的是测试系统的音频设备（耳麦、扬声器等）和网络连接是否正常。本文介绍如何使用该方法在项目中进行音频设备检测。

## 实现方法

请确保你已经了解如何[实现音视频通话](start_call_ios)或[实现互动直播](start_live_ios)。

1. 在加入频道前，调用 `startEchoTestWithInterval` 方法。调用该方法时，你需要设置一个 `interval` 参数，表示获取本次测试结果的间隔时间。该参数单位为秒，取值范围为 [2, 10]，默认值为 10。

2. 成功调用 `startEchoTestWithInterval` 方法后，引导用户先说一段话，如果声音在设置的时间间隔后回放出来，且用户能听到自己刚才说的话，则表示系统音频设备和网络连接都是正常的。

3. 获取音频设备测试结果后，调用 `stopEchoTest` 方法停止语音通话检测，然后你可以调用 `joinChannelByToken` 加入频道。

### 示例代码

你可以参考如下示例代码在你的项目中进行实现。

```swift
// Swift
agoraKit.startEchoTestWithInterval(10)

// 等待并检查是否可以听到自己的声音回放

// 停止测试
agoraKit.stopEchoTest
```

```objective-c
// Objective-C
// 开启回声测试
[agoraKit startEchoTestWithInterval: 10];

// 等待并检查是否可以听到自己的声音回放

// 停止测试
[agoraKit stopEchoTest];
```

### API 参考

- [`startEchoTestWithInterval`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startEchoTestWithInterval:successBlock:)
- [`stopEchoTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopEchoTest)

## 开发注意事项

- 调用 `startEchoTestWithInterval` 后必须调用 `stopEchoTest` 以结束测试，否则不能进行下一次回声测试，或者调用 `joinChannelByToken` 进行通话。
- 直播场景下，该方法仅能由用户角色为主播的用户调用。如果用户由通信场景切换到直播场景，请务必调用 `setClientRole` 方法将用户的角色设置为主播。
