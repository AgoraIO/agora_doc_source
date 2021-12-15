---
title: 设置音频属性
platform: Android
updatedAt: 2021-03-11 06:59:12
---

## 功能描述

在一些比较专业的场景里，用户对声音的效果尤为敏感，比如语音电台，此时就需要对双声道和高音质的支持。
所谓的高音质指的是我们提供采样率为 48 kHz、码率 192 Kbps 的能力，帮助用户实现高逼真的音乐场景，这种能力在语音电台、唱歌比赛类直播场景中应用较多。

## 实现方法

Agora SDK 提供 [setAudioProfile](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a34175b5e04c88d9dc6608b1f38c0275d) 方法给开发者根据场景需求灵活配置适合的音质属性。这个方法有 2 个参数：

- `profile` 代表不同的音频参数配置，比如采样率、码率和编码模式等
- `scenario` 侧重于不同的使用场景，如娱乐、教学和游戏直播等。流畅度、噪声控制、音质等频道特性会根据不同的场景做出优化

除高音质外，本文同时给出几种常用的参数组合供开发者参考。

```java
// FM 高音质
rtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO, Constants.AUDIO_SCENARIO_SHOWROOM);

// 游戏开黑场景
rtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_SPEECH_STANDARD, Constants.AUDIO_SCENARIO_CHATROOM_GAMING);

// 娱乐场景
rtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_MUSIC_STANDARD, Constants.AUDIO_SCENARIO_CHATROOM_ENTERTAINMENT);

// KTV
rtcEngine.setAudioProfile(Constants.AUDIO_AUDIO_PROFILE_MUSIC_HIGH_QUALITY, Constants.AUDIO_SCENARIO_CHATROOM_ENTERTAINMENT);

```

## 开发注意事项

- 该方法必须在加入频道之前调用
- `scenario` 参数仅在频道模式设为直播时有效
