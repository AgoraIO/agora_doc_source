---
title: 发版说明
platform: Windows
updatedAt: 2021-03-29 03:37:10
---

本文提供 Agora 语音 SDK 的发版说明。

## **简介**

Windows 语音 SDK 支持两种主要场景:

- 音频通话
- 音频直播

点击 [语音通话产品概述](https://docs.agora.io/cn/Voice/product_voice?platform=All%20Platforms) 以及 [音频互动直播产品概述](https://docs.agora.io/cn/Audio%20Broadcast/product_live_audio?platform=All%20Platforms)了解关键特性。

Windows 语音 SDK 支持 X86 和 X64 架构。

## **2.9.0 版**

该版本于 2019 年 8 月 16 日发布。新增特性与修复问题详见下文。

**升级必看**

#### 推流

该版本起，Agora 删除如下接口：

- `configPublisher`

如果你的 App 使用上述接口实现 CDN 推流功能，请确保将 Native SDK 升级至最新版本，并改用如下接口实现推流：

- [`setLiveTranscoding`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a0601e4671357dc1ec942cccc5a6a1dde)
- [`addPublishStreamUrl`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a5d62a13bd8391af83fb4ce123450f839)
- [`removePublishStreamUrl`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a30e6c64cb616fbd78bedd8c516c320e7)
- [`onRtmpStreamingStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a29754dc9d527cbff57dbc55067e3287d)

**新增特性**

#### 1. 快速切换频道

为方便直播频道中的观众用户快速切换到其他频道，该版本新增 [`switchChannel`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a3eb5ee494ce124b34609c593719c89ab) 方法。和先调 `leaveChannel`，再调 `joinChannel` 相比，该方法能实现更快的频道切换。调用 `switchChannel` 方法切换到其他直播频道后，本地会先收到离开原频道的回调 `onLeaveChannel`，再收到成功加入新频道的回调 `onJoinChannelSuccess`。

#### 2. 跨频道媒体流转发

跨频道媒体流转发，指将主播的媒体流转发至其他直播频道，实现主播跨频道与其他主播实时互动的场景。该版本新增如下接口，通过将源频道中的媒体流转发至目标频道，实现跨直播间连麦功能：

- [`startChannelMediaRelay`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#acb72f911830a6fdb77e0816d7b41dd5c)
- [`updateChannelMediaRelay`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#afad0d3f3861c770200a884b855276663)
- [`stopChannelMediaRelay`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ab4a1c52a83a08f7dacab6de36f4681b8)

在跨频道媒体流转发过程中，SDK 会通过 [`onChannelMediaRelayStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a8f22b85194d4b771bbab0e1c3b505b22) 和 [`onChannelMediaRelayEvent`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a89a4085f36c25eeed75c129c82ca9429) 回调报告媒体流转发的状态和事件。

该场景的实现方法、API 调用时序、示例代码及开发注意事项，请参考[《跨直播间连麦》](media_relay_windows)。

#### 3. 本地及远端音频状态

为方便用户了解本地及远端的音频状态，该版本新增 [`onLocalAudioStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a9296c329331eb83b3af1315c52e7f91a) 和 [`onRemoteAudioStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aa168380f86f1dc2df1c269a785c56612) 回调。新的回调下，本地及远端音频有如下状态：

- 本地音频：STOPPED(0)、RECORDING(1)、ENCODING(2) 和 FAILED(3)。状态为 FAILED(3) 时，你可以通过 `error` 参数中返回的错误码定位及排查问题。
- 远端音频：STOPED(0)、STARTING(1)、DECODING(2)、FROZEN(3) 和 FAILED(3)。你可以在 `reason` 参数中了解引起远端音频状态发生改变的原因。

#### 4. 本地音频数据

为方便更好地了解通话质量，获取更多质量相关数据，该版本新增 [`onLocalAudioStats`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a0cb47df6a8ef7acee229eb307d6f32c3) 回调，通过 `numChannels`、`sentSampleRate`、`sentBitrate` 参数报告本地音频统计信息。

**改进**

#### 1. 通话中质量透明

该版本进一步扩充了 `RtcStats` 类的成员。新增成员如下：

- [`RtcStats`](./API%20Reference/cpp/structagora_1_1rtc_1_1_rtc_stats.html) 类：累计发送音频字节数及累计接收音频字节数

#### 2. 其他改进

- 优化了 Game Streaming 模式下的音频质量。
- 优化了通信模式下用户关闭麦克风后听到的音质。

**问题修复**

#### 音频

- 修复了与 Web 互通时听声辨位过程中出现的声音失真的问题。
- 修复了 `muteRemoteAudioStream` 方法调用无效的问题。
- 修复了特殊场景下偶现的音频无声的问题。

#### 其他

- 修复了偶现的旁路推流串流的问题。
- 修复了偶现的崩溃问题。
- 修复了特定场景下加入频道失败的问题。

**API 变更**

为提升用户体验，Agora SDK 在该版本中对 API 进行了如下变动：

#### 新增

- [onLocalAudioStateChanged](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a9296c329331eb83b3af1315c52e7f91a)
- [onRemoteAudioStateChanged](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aa168380f86f1dc2df1c269a785c56612)
- [onLocalAudioStats](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a0cb47df6a8ef7acee229eb307d6f32c3)
- [switchChannel](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a3eb5ee494ce124b34609c593719c89ab)
- [`startChannelMediaRelay`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#acb72f911830a6fdb77e0816d7b41dd5c)
- [`updateChannelMediaRelay`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#afad0d3f3861c770200a884b855276663)
- [`stopChannelMediaRelay`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#ab4a1c52a83a08f7dacab6de36f4681b8)
- [`onChannelMediaRelayStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a8f22b85194d4b771bbab0e1c3b505b22)
- [`onChannelMediaRelayEvent`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a89a4085f36c25eeed75c129c82ca9429)
- [`RtcStats`](./API%20Reference/cpp/structagora_1_1rtc_1_1_rtc_stats.html) 类新增 `txAudioBytes` 和 `rxAudioBytes` 成员

#### 废弃

- `onMicrophoneEnabled`，请改用 [`onLocalAudioStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a9296c329331eb83b3af1315c52e7f91a) 的 LOCAL_AUDIO_STREAM_STATE_CHANGED(0) 或 LOCAL_AUDIO_STREAM_STATE_RECORDING(1)
- `onRemoteAudioTransportStats`，请改用 [`onRemoteAudioStats`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#af8a59626a9265264fb4638e048091d3a)

#### 删除

- `configPublisher`

## **2.8.0 版**

该版本于 2019 年 7 月 8 日发布。新增特性详见下文。

**新增特性**

#### 1. 全平台支持 String 型的用户名

很多 App 使用 String 类型的用户名。为降低开发成本，Agora 新增支持 String 型的 User account，方便用户通过如下接口直接使用 App 账号加入 Agora 频道：

- [registerLocalUserAccount](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a0d44b74ced4005ee86353c13186f870d)
- [joinChannelWithUserAccount](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a14f8c308c6c57c55653552b939a8527a)

对于其他接口，Agora 沿用 Int 型的 UID。Agora Engine 会维护 UID 和 User account 映射表，你可以随时通过 String user account 获取 UID，或者通过 UID 获取 String user account，无需自己维护映射表。

为保证通信质量，频道内所有用户需使用同一数据类型的用户名，即频道内的所有用户名应同为 Int 型或同为 String 型。详见[使用 String 型的用户名](string_windows)。

**Note**：

- 同一频道内，Int 型的 User ID 和 String 型的 User account 不可混用。目前支持 String 型 User account 的 SDK 如下：

  - Native SDK：v2.8.0 及之后版本
  - Web SDK：v2.5.0 及之后版本

如果你的频道内有不支持 String 型 User account 的用户，则只能使用 Int 型的 User ID。

- 如果你使用该版本的 Native SDK 将用户名升级至 String 型 User account，请确保所有终端用户同步升级。
- 如果使用 String 型的 User account，请确保你的服务端用户生成 Token 的脚本已升级至最新版本。如果使用 String 型 User account 加入频道，请确保使用该 User account 或其对应的 Int 型 UID 来生成 Token。你可以调用 `getUserInfoByUserAccount` 来获取 User account 所对应的 UID。

#### 2. 音频卡顿回调

为监控通话过程中的音频传输质量，方便开发者客观体验通信质量，该版本在远端音频统计数据 [RemoteAudioStats](./API%20Reference/cpp/structagora_1_1rtc_1_1_remote_audio_stats.html) 类中新增 `totalFrozenTime` 和 `frozenRate` 成员，报告远端用户在加入频道后发生音频的卡顿时长及卡顿率。

同时，该版本在 [RemoteAudioStats](./API%20Reference/cpp/structagora_1_1rtc_1_1_remote_audio_stats.html) 类中还新增 `numChannels`、`receivedSampleRate` 和 `receivedBitrate` 成员。

**改进**

为方便开发者统计掉线率，该版本在 [onConnectionStateChanged](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#af409b2e721d345a65a2c600cea2f5eb4) 回调的 `reason` 参数中添加 `CONNECTION_CHANGED_KEEP_ALIVE_TIMEOUT(14)` 成员，表示 SDK 与服务器连接保活超时，引起 SDK 连接状态发生改变。

**API 变更**

为提升用户体验，Agora 在 v2.8.0 版本中对 API 进行了如下变动：

#### 新增

- [registerLocalUserAccount](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a0d44b74ced4005ee86353c13186f870d)
- [joinChannelWithUserAccount](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a14f8c308c6c57c55653552b939a8527a)
- [getUserInfoByUid](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#abf4572004e6ceb99ce0ff76a75c69d0b)
- [getUserInfoByUserAccount](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine.html#a4f75984d3c5de5f6e3e4d8bd81e3b409)
- [onLocalUserRegistered](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a919404869f86412e1945c730e5219b20)
- [onUserInfoUpdated](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ad086cc4d8e5555cc75a0ab264c16d5ff)
- [RemoteAudioStats](./API%20Reference/cpp/structagora_1_1rtc_1_1_remote_audio_stats.html) 类中新增 `numChannels`，`receivedSampleRate`，`receivedBitrate`，`totalFrozenTime` 和 `frozenRate` 成员

#### 废弃

- [LiveTranscoding](./API%20Reference/cpp/structagora_1_1rtc_1_1_live_transcoding.html) 类中的 `lowLatency` 成员

## **2.4.1 版**

该版本于 2019 年 6 月 12 日发布。

该 SDK 首次发版。你可以参考以下文档集成 SDK，实现相应的实时音频功能：

- [快速集成](./windows_video)
- [校验用户权限](./token)
- [检测通话质量](./in_call_statistics_windows_audio)
- [调整通话音量](./volume_windows)
- [播放音效/音乐混音](effect_mixing_windows)
- [变声与混响](./voice_effect_windows)
- [推流到 CDN](./push_stream_windows2.0_audio)
- [音频设备测试与切换](switch_audio_device_windows)

如果你是由之前版本的 Windows 完整包升级到当前的纯音频包，可参考 [Windows 完整包发版说明](./release_windows_video)了解音频相关改进。
