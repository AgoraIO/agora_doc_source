---
title: 为什么通过系统音量无法调节背景音乐？
platform: ["iOS","Android"]
updatedAt: 2021-01-27 12:27:03
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
## 问题描述

在移动设备中，用户在后台播放背景音乐，加入 RTC 频道后，用户无法通过调节系统音量去改变背景音乐的音量。

## 问题原因

移动设备的音量类型分为通话音量和媒体音量。一般而言，音视频通话时使用通话音量，播放背景音乐时使用媒体音量。详见[如何区分媒体音量和通话音量？](./faq/system_volume)

用户加入 RTC 频道后，Agora RTC SDK 控制的音量类型决定了系统音量控制的音量类型。当 SDK 控制通话音量，背景音乐使用媒体音量时，系统音量只能控制通话音量，无法调节背景音乐的音量。

## 解决方案

#### 方案一

用 `startAudioMixing` 播放背景音乐，让 SDK 同时控制背景音乐和通话声音。不论 SDK 使用的是通话音量还是媒体音量，用户都可以通过系统音量同时调节背景音乐和通话声音的音量。

#### 方案二

把 `setAudioProfile` 的 `scenario` 参数设为 `GAME_STREAMING`/`AgoraAudioScenarioGameStreaming`，即将 SDK 使用的音量类型设置为媒体音量。成功设置后，用户可以通过系统音量同时调节背景音乐和通话声音的音量。

#### 方案三

如果上述方案满足不了需求，你可以利用 Android 或 iOS 原生 API 拦截音量按键事件并调节音量。可参考如下文档：

- Android: 通过 [AudioManager](https://developer.android.com/reference/android/media/AudioManager.html)
- iOS: 通过 [MPVolumeView](https://developer.apple.com/documentation/mediaplayer/mpvolumeview)