---
title: 发版说明
platform: Unity
updatedAt: 2021-03-12 08:40:40
---
本文提供 Agora Unity SDK 的发版说明。

## 简介
 
Agora Unity SDK 主要支持两种场景：
 
- 音视频通话
- 音视频直播
 
点击[语音通话产品概述](product_voice)、[视频通话产品概述](product_video)、[音频互动直播产品概述](product_live_audio)及[视频互动直播](product_live)了解关键特性。

## 3.0.1 版

该版本于 2020 年 9 月 16 日发布。

Agora 在该版本对通信场景采用了全新的系统架构，并升级了通信和直播场景下的 last mile 网络策略。在带宽不足时，新的网络策略能充分利用上下行有限带宽提升有效码率，从而增强弱网对抗能力，极大提升了弱网情况下通信和直播场景的终端用户体验。

由于通信场景采用了新的系统架构，为保证新老版本通信用户的互通兼容，我们使用了回退机制。如果频道内有老版本通信用户加入，则当前版本 (3.0.1) 的终端用户会回退成老版本通信。一旦回退，频道内所有用户都无法享受新版本带来的体验提升。因此我们强烈推荐同步升级所有终端用户到当前版本。

为确保享受全新架构和网络策略优化带来的好处，使用本地服务端录制的客户，请务必同步升级本地服务端录制 SDK 至 3.0.0 版本。

新增特性、改进与问题修复详见下文。

**升级必看**

#### 1. 静态库升级动态库（macOS 和 iOS）

该版本将 iOS 和 macOS 的静态库升级为动态库，且库名由 `AgoraRtcEngineKit` 变更为 `AgoraRtcKit`。如果你由老版本的 SDK 升级至该版本，请务必在 Xcode 中重新导入 `AgoraRtcKit.framework`，并将该库的 **Embed** 属性设置为 **Embed & Sign**。

如果你集成了加密库 `AgoraRtcCryptoLoader.framework`，也需要重新导入库并将其 **Embed** 属性设置为 **Embed & Sign**。

![](https://web-cdn.agora.io/docs-files/1600240476016)

#### 2. 枚举更名

该版本将设置用户角色的 `CLIENT_ROLE` 枚举类更名为 `CLIENT_ROLE_TYPE`，并对其包含的枚举进行了如下修改：

- `BROADCASTER` 更名为 `CLIENT_ROLE_BROADCASTER`
- `AUDIENCE` 更名为 `CLIENT_ROLE_AUDIENCE`

#### 3. 通信场景上行默认不开启视频小流

从该版本起，Agora 在通信场景下，默认不开启视频[小流](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#dual-stream)。如需启用，请在成功加入频道后，调用 `EnableDualStreamMode(true)` 方法启用视频双流模式。在多人视频通信场景下，我们建议你开启视频双流。

**新增特性**

#### 1. 设置区域访问限制

该版本新增 `GetEngine2` 方法，支持在创建 `IRtcEngine` 实例时指定 SDK 访问的服务器区域。该功能为高级设置，适用于有访问安全限制的场景。目前支持的区域有中国大陆、北美、欧洲、亚洲（中国大陆除外）和全球（默认）。

#### 2. 多频道管理

为方便用户在同一时间加入多个频道，该版本新增了 `AgoraChannel` 类。通过创建多个 `AgoraChannel` 对象，用户可以加入各 `AgoraChannel` 对象对应的频道中，实现多频道功能。

该版本还新增了 `SetMultiChannelWant` 为当前引擎开启多频道状态，和 `SetForMultiChannelUser` 在多频道中渲染本地和远端视图。

加入多个频道后，用户可以同时接收多个频道的流，但同一时间只能在一个频道发流。该功能适用于用户需要同时接收多个频道的流，或频繁切换频道发流的场景。详细的集成步骤和注意事项，请参考[加入多频道](./multiple_channel_unity)。

#### 3. 调整音乐文件音调

为方便调整混音时音乐文件的播放音调，该版本新增 `SetAudioMixingPitch` 方法。通过设置该方法的 `pitch` 参数，你可以升高或降低音乐文件的音调。该方法仅对音乐文件音调有效，对本地人声不生效。

#### 4. 调节本地播放的指定远端用户音量

该版本新增 `AdjustUserPlaybackSignalVolume` 方法，用以调节本地用户听到的指定远端用户的音量。通话或直播过程中，你可以多次调用该方法，来调节多个远端用户在本地播放的音量，或对某个远端用户在本地播放的音量调节多次。

#### 5. 美声和音效

为提高用户的音频体验，该版本在 `SetLocalVoiceChanger` 和 `SetLocalVoiceReverbPreset` 中分别新增以下枚举值：

- 在 `VOICE_CHANGER_PRESET` 枚举中新增了以 `VOICE_BEAUTY` 为前缀和以 `GENERAL_BEAUTY_VOICE` 为前缀的枚举值，分别实现音色变换或语聊美声功能。
- 在 `AUDIO_REVERB_PRESET` 枚举中新增了以 `AUDIO_REVERB_FX` 为前缀的枚举值和 `AUDIO_VIRTUAL_STEREO`，分别实现变声音效、新版曲风音效、新版空间塑造和虚拟立体声效果。

#### 6. 人脸检测

该版本在 Android 和 iOS 平台新增人脸检测功能。通过 `EnableFaceDetection` 方法开启人脸检测后，SDK 会实时触发 `OnFacePositionChangedHandler` 回调，向本地用户报告检测出的一系列结果，包括人脸距设备屏幕的距离。该功能可用于提醒用户注意用眼卫生，和屏幕保持一定距离。

**改进**

#### 1. 音频编码属性

为满足更高音质需求，该版本调整了直播场景下 `AUDIO_PROFILE_DEFAULT(0)` 对应的音频编码属性，详见下表：

| SDK 版本   | `AUDIO_PROFILE_DEFAULT(0)`                                   |
| :--------- | :---------------------------------------------------------- |
| 3.0.1      | 48 KHz 采样率，音乐编码，单声道，编码码率最大值为 52 Kbps。 |
| 3.0.1 之前 | 32 KHz 采样率，音乐编码，单声道，编码码率最大值为 64 Kbps。 |

####  2. 质量透明

为方便开发者获取更多通话统计信息，该版本在 `RtcStats` 类中新增如下成员，方便更好地监控通话的质量和通话过程中的内存变动：

- `gatewayRtt`
- `memoryAppUsageRatio`
- `memoryTotalUsageRatio`
- `memoryAppUsageInKbytes`

在 iOS 上，为避免 iOS 14 设备中出现本地网络权限弹窗提示，`gatewayRtt` 参数默认关闭。详见 [FAQ](https://docs.agora.io/cn/faq/local_network_privacy)。 如果你不介意弹窗提示，且需启用该功能，请[提交工单](https://agora-ticket.agora.io/)联系声网技术支持。

#### 3. 屏幕共享

为支持更多屏幕共享使用场景，该版本新增支持调用 `StartScreenCaptureByWindowId` 方法时共享[通用 Windows 平台](https://docs.microsoft.com/zh-cn/windows/uwp/get-started/universal-application-platform-guide)（UWP）应用窗口。

#### 4. 美颜

该版本新增 `SetBeautyEffectOptions` 对 Windows 平台的支持，你可以调用该接口设置对比度、亮度、平滑度等参数，达到美白、磨皮、红润肤色等美颜效果。

#### 5. 其他提升

- 该版本在 `VIDEO_PIXEL_FORMAT` 中新增 `VIDEO_PIXEL_RGBA`，你可以将自采集的 RGBA 视频数据传递给 SDK。
- 该版本自动开启直播场景下 Native SDK 与 Web SDK 的互通，并废弃原有的 `EnableWebSdkInteroperability` 方法。

**问题修复**

- 修复了混音、Loopback 测试异常、音频录制、音频编码、回声等音频问题。
- 修复了 `OnVideoSizeChangedHandler` 回调无响应、 `VideoFrame` 中 `buffer` 一直为空、水印、视频画面比例、画质模糊、视频不能全屏、连麦用户屏幕共享黑屏、屏幕共享黑边等视频问题。
- 修复了特定场景下偶现的崩溃、日志文件、推流不稳定等问题。
- 修复了通信场景下，调用 `SetRemoteSubscribeFallbackOption` 方法也生效的问题。
- 修复了一对一通信场景下，下行音视频弱网下会回退为纯音频的问题。
- 修复了 `SendStreamMessage` 和 `SetLiveTranscoding` 中 `TranscodingUser` 不支持数组的问题。
- 修复了 `OnClientRoleChangedHandler` 回调多次、App ID 和 Token 校验、日志目录乱码等问题。

**API 变更**

#### 新增

- [`GetEngine2`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac1a02000088c915aa36065325f42d166)
- [`CreateChannel`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac14119e2505e2f44931bed0181c5624f)
- [`AgoraChannel`](./API%20Reference/unity/classagora__gaming__rtc_1_1_agora_channel.html) 类
- [`SetMultiChannelWant`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a50ddfe8050fd11f1537bd0dddc2eb8a3)
- [`SetForMultiChannelUser`](./API%20Reference/unity/class_video_surface.html#a2c751c8013e9a20c9f7929ca427b04b9)
- [`SetAudioMixingPitch`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac1f7b492430f2c3f38826804a418c2a7)
- [`AdjustUserPlaybackSignalVolume`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a6ae88c74d0dc4e80837cd0a351f81c00)
- [`VOICE_CHANGER_PRESET`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a710b9754965ccb92ed968a562968df2c) 枚举类型中新增 `AUDIO_REVERB_FX_KTV` 等 9 个枚举值
- [`AUDIO_REVERB_PRESET`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a1e681589411dd2f5df62dab5c1fca7b9) 枚举类型中新增 `VOICE_BEAUTY_VIGOROUS` 等 12 个枚举值
- [`EnableFaceDetection`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a45f7776f4fd3a6d73186c83e4e15e917)
- [`OnFacePositionChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a2425866f7157395b0f6cc04e7854d0f5)
- `RtcStats` 类中新增 [`gatewayRtt`](./API%20Reference/unity/structagora__gaming__rtc_1_1_rtc_stats.html#aef762b5910ca3a7a06a4e37869c34fed)、[`memoryAppUsageRatio`](./API%20Reference/unity/structagora__gaming__rtc_1_1_rtc_stats.html#a5b7d328a6f8e6aca9e1b8b6c8ce16e02)、[`memoryTotalUsageRatio`](./API%20Reference/unity/structagora__gaming__rtc_1_1_rtc_stats.html#a232d695be9b723df8dae4ca219c6745f) 和 [`memoryAppUsageInKbytes`](./API%20Reference/unity/structagora__gaming__rtc_1_1_rtc_stats.html#aeb37b39c64362e3954b279c6dfc5e774) 成员
- `RemoteAudioStats` 结构体中新增 [`totalActiveTime`](./API%20Reference/unity/structagora__gaming__rtc_1_1_remote_audio_stats.html#a7453a27b08439186f35b3b7bb9eafd3b) 成员
- `RemoteVideoStats` 结构体中新增 [`totalActiveTime`](./API%20Reference/unity/structagora__gaming__rtc_1_1_remote_audio_stats.html#a7453a27b08439186f35b3b7bb9eafd3b) 成员
- `AudioVolumeInfo` 结构体新增 [`channelId`](./API%20Reference/unity/structagora__gaming__rtc_1_1_audio_volume_info.html#a0b95567512ed7c6642671e805207a8e1) 成员

#### 更名

枚举类 `CLIENT_ROLE` 更名为 [`CLIENT_ROLE_TYPE`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a901253f94f78da34371bf7eb656a19ff)。其包含的枚举 `BROADCASTER` 和 `AUDIENCE` 更名为 `CLIENT_ROLE_BROADCASTER` 和 `CLIENT_ROLE_AUDIENCE`。

#### 废弃

- `EnableWebSdkInteroperability`
- `OnFirstRemoteVideoFrameHandler`，使用 [`OnRemoteVideoStateChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a53d577f5c1c2d863f7946d86d76adb13) 取代
- `OnUserMutedAudioHandler`, `OnFirstRemoteAudioDecodedHandler` 和 `OnFirstRemoteAudioFrameHandler`，使用 [`OnRemoteAudioStateChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a92f016ea980eba06cf38192191d17e01) 取代
- `OnStreamPublishedHandler` 和 `OnStreamUnpublishedHandler`，使用 [`OnRtmpStreamingStateChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a589c11ed19b0638824aa1b2e23971271) 取代

## **2.9.2 版**

该版本于 2020 年 2 月 17 日发布。

- 该版本修复了 Android 设备上的部分异常。
- 该版本修复了 Windows 平台下，使用 Editor 调试模式时偶现的卡死问题。

## **2.9.1 版**

Agora Unity SDK 广泛应用于游戏、教育、AR、VR 等场景。

该版本于 2019 年 12 月 23 日发布。功能特性及相关文档详见下文。

**功能特性**

#### 1. 多平台支持

该版本支持在 iOS、Android、macOS 和 Windows (x86/x86_64) 平台中集成。

#### 2. 支持与 Web 互通

该版本提供 `EnableWebSdkInteroperability` 方法，用于打开直播场景下与 Agora Web SDK 的互通。

#### 3. 视频渲染方式

该版本支持多样的视频渲染方式，你可以在 Unity 菜单中选择 **Auto Graphics API** 下任意的视频渲染模式。
![](https://web-cdn.agora.io/docs-files/1576826628073)

#### 4. 多线程渲染

该版本支持多线程渲染，你可以在 Unity 菜单中选择 **Multithreaded Rendering** 启用该功能。

#### 5. 原始音视频数据

该版本支持原始音频数据和 RGBA 格式的原始视频数据，你可以获取原始音视频数据并自行处理。详见[原始视频数据](raw_data_video_unity)。

#### 6. 音视频自采集

该版本提供音视频自采集的接口，你可以配置外部音视频源及推送音视频数据。详见[自定义视频采集和渲染](custom_video_unity)。

#### 7. 加密

该版本支持加密功能，你可以对音视频流进行加密。下表展示移动端的加密库信息，若希望减小 SDK 体积且不使用加密功能，你可以把加密库移除。

   | 平台    | 加密库                                     |
   | :------ | :----------------------------------------- |
   | Android | libagora-crypto.so                         |
   | iOS     | <ul><li>AgoraRtcCryptoLoader.framework <li>libcrypto.a</li></ul> |

#### 8. 云代理服务

支持使用云代理服务，方便部署企业防火墙的用户正常使用 Agora 的服务，详见[使用云代理服务](cloudproxy_unity)。

**相关文档**

你可以参考以下文档集成 SDK，实现相应的实时音视频功能：

- [实现视频通话](https://docs.agora.io/cn/Video/start_call_unity?platform=Unity)或[实现视频直播](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_unity?platform=Unity)
- [API 参考](./API%20Reference/unity/index.html)

Agora 提供了开源的 [Unity GitHub Sample](https://github.com/AgoraIO/Agora-Unity-Quickstart/tree/master/video/Hello-Video-Unity-Agora)，你也可以前往下载并体验。