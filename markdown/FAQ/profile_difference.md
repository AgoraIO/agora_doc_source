---
title: 通信和直播场景有什么区别？
platform: ["Android", "iOS", "macOS", "Windows", "Unity", "Cocos Creator", "Electron", "React Native", "Flutter"]
updatedAt: 2020-12-09 03:45:31
Products: ["Voice", "Video", "Interactive Broadcast", "live-streaming"]
---

<div class="alert note">本文内容仅适用于 Agora RTC Native SDK。</div>

为针对不同的实时音视频场景采用不同的优化策略，Agora 为 RTC 频道提供了一个 `setChannelProfile` 方法。你可以通过该方法将频道设置为通信（`CHANNEL_PROFILE_COMMUNICATION`）场景或直播（`CHANNEL_PROFILE_LIVE_BROADCASTING`）场景。这两种场景默认的用户角色、音频路由、视频编码码率是不同的。

## 默认用户角色

为方便对用户进行管理，Agora 对用户角色进行区分：

- 主播：在频道中既可以发流、也可以收流的用户。
- 观众：在频道中只能收流的用户。

不同的频道场景下，默认的用户角色如下：

- 通信场景：主播。且不可以调用 `setClientRole` 改变用户角色。
- 直播场景：观众。如果想要改变用户角色为主播，可以通过调用 `setClientRole` 来实现。

<div class="alert note">在有连麦鉴权的场景中，如果用户以 subscriber 角色的 Token 加入频道，只调用 <code>setClientRole</code> 不能切换用户角色。详见<a href="https://docs.agora.io/cn/faq/token_cohost">如何使用连麦鉴权功能</a>。</div>

## 默认音频路由

音频路由是指 app 在播放音频时使用的设备通道。默认音频路由指的是设备本身的音频路由，通常为手机的听筒或扬声器。

不同的 Agora 频道场景下，移动端默认的音频路由也是不同的:

- 通话场景
  - 如果是纯语音通话的场景，默认音频路由为听筒。
  - 如果是有视频的通话场景，默认音频路由为扬声器。
- 直播场景：默认音频路由为扬声器。

## 默认视频编码码率

`setVideoEncoderConfiguration` 方法中的 `bitrate` 成员为本地视频编码码率。当码率使用默认值，即 `STANDARD_BITRATE(0)` 时，相同的分辨率和帧率下，直播场景的码率是通信场景码率的两倍。

| 分辨率 (px) | 帧率 (fps) | 基准码率 (Kbps, 通信场景适用) | 直播码率 (Kbps, 直播场景适用) |
| ----------- | ---------- | ----------------------------- | ----------------------------- |
| 160 × 120   | 15         | 65                            | 130                           |
| 320 × 180   | 15         | 140                           | 280                           |
| 640 × 360   | 30         | 600                           | 1,200                         |
| 848 × 480   | 30         | 930                           | 1,860                         |

完整的视频编码分辨率、帧率、码率对照表请参考 [API 文档](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a4b090cd0e9f6d98bcf89cb1c4c2066e8)。

## 推荐设置

根据上述差异，Agora 推荐在一对一通话或多人群聊场景中，将频道场景设为 `CHANNEL_PROFILE_COMMUNICATION`（通信），在语音聊天室、小班课、互动大班课、视频直播等场景中，将频道场景设为 `CHANNEL_PROFILE_LIVE_BROADCASTING`（直播）。
