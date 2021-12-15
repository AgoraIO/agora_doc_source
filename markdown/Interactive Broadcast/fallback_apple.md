---
title: 视频流回退
platform: iOS
updatedAt: 2021-03-25 10:36:17
---

## 功能描述

网络不理想的环境下，音视频的质量都会下降。为提升用户体验，Agora 新增了 `setLocalPublishFallbackOption` 和 `setRemoteSubscribeFallbackOption` 两个方法。用户设置这两个方法后，在网络条件差、无法同时保证音频和视频质量的情况下，SDK 会自动将视频流从大流切换为小流，或将媒体流回退为音频流，从而提高音视频质量。

## 实现方法

在实现视频流回退机制前，请确保已在你的项目中实现基本的音视频功能。详见[开始互动直播](start_live_ios)或[开始音视频通话](start_call_ios)。

参考如下步骤，在你的项目中实现视频流回退功能：

<div class="alert note">Agora 推荐你在加入频道前完成发送端和接收端的设置。</div>

### 发流端设置

1. 调用 `enableDualStreamMode` 方法开启[双流模式](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-duala双流模式)。

2. 调用 `setLocalPublishFallbackOption` 方法，并设置 `AudioOnly (2)` 开启本地发布的媒体流在弱网环境下回退。当网络不好时，SDK 会自动停止发布视频流，只发布音频流。

   本地发布的流从媒体流切换到音频流，或从音频流切换到媒体流时，SDK 会触发 `didLocalPublishFallbackToAudioOnly` 回调报告当前发布的流的类型。

   > CDN 推流直播场景下，发送端设置 `AudioOnly (2)` 可能导致 CDN 观众听到的声音有所延迟。Agora 不建议使用视频流回退机制。

### 接收端设置

1. 调用 `setRemoteSubscribeFallbackOption` 方法设置弱网环境下接收媒体流的回退选项。

   - 设置 `StreamLow (1)`，则下行网络较弱时，只接收视频小流。
   - 设置 `AudioOnly (2)`，则下行网络较弱时，先尝试只接收视频小流。如果网络环境无法显示视频，则只接收音频流。

   用户接收到的流从媒体流切换到音频流，或从音频流切换到媒体流时，SDK 会触发 `didRemoteSubscribeFallbackToAudioOnly` 回调报告当前接收流的回退状态。当接收到的流从大流切换到小流，或从小流切换到大流时，SDK 会触发 `remoteVideoStats` 回调报告当前接收到的视频流类型。

### 示例代码

```swift
//Swift
// 开启视频双流模式。
agoraKit.enableDualStreamMode(true)

// 发送端的配置。网络较差时，只发送音频流。
agoraKit.setLocalPublishFallbackOption(.audioOnly)

// 接收端的配置。弱网环境下先尝试接收小流；若当前网络环境无法显示视频，则只接收音频流。
agoraKit.setRemoteSubscribeFallbackOption(.audioOnly)
```

```objective-c
//Objective-C
// 开启视频双流模式。
[agoraKit enableDualStreamMode: YES];

// 发送端的配置。网络较差时，只发送音频流。
[agoraKit setLocalPublishFallbackOption: AgoraStreamFallbackOptionAudioOnly];

// 接收端的配置。弱网环境下先尝试接收小流；若当前网络环境无法显示视频，则只接收音频流。
[agoraKit setRemoteSubscribeFallbackOption: AgoraStreamFallbackOptionAudioOnly];
```

### API 参考

- [`enableDualStreamMode`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableDualStreamMode:)
- [`setLocalPublishFallbackOption`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalPublishFallbackOption:)
- [`setRemoteSubscribeFallbackOption`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteSubscribeFallbackOption:)
- [`didLocalPublishFallbackToAudioOnly`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didLocalPublishFallbackToAudioOnly:)
- [`didRemoteSubscribeFallbackToAudioOnly`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didRemoteSubscribeFallbackToAudioOnly:byUid:)
- [`remoteVideoStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStats:)
