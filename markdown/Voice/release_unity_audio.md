---
title: 发版说明
platform: Unity
updatedAt: 2021-03-12 08:40:05
---

本文提供 Agora Unity SDK 的发版说明。

## 3.2.0 版

该版本于 2020 年 12 月发布。

#### 升级必看

**1. 集成变更**

自该版本起，SDK 包中新增以下动态库：

- Fraunhofer FDK AAC 动态库
- mpg123 动态库
- SoundTouch 动态库

各平台对应新增的文件如下：

| 平台    | 文件                                                                                           |
| :------ | :--------------------------------------------------------------------------------------------- |
| Android | <li>`libagora-fdkaac.so`</li><li>`libagora-mpg123.so`</li><li>`libagora-soundtouch.so`</li>    |
| iOS     | <li>`Agorafdkaac.framework`</li><li>`AgoraSoundTouch.framework`</li>                           |
| macOS   | <li>`Agorafdkaac.framework`</li><li>`AgoraSoundTouch.framework`</li>                           |
| Windows | <li>`libagora-fdkaac.dll`</li><li>`libagora-mpg123.dll`</li><li>`libagora-soundtouch.dll`</li> |

如果你将 SDK 升级到 v3.2.0，请务必参考[快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_unity?platform=Unity#集成-sdk)在你的项目中添加上述文件。

**2. 云代理**

该版本优化了 Agora 云代理架构。如果你已经在使用云代理，为避免新 SDK 和老云代理的兼容性问题，请在升级 SDK 前联系[技术支持](https://agora-ticket.agora.io/)。详见[云代理](./cloudproxy_unity?platform=Unity)。

**3. 安全合规**

Agora 已通过 ISO 27001、ISO 27017、ISO 27018 国际认证，为全球用户提供安全可靠的实时互动云服务。详见 [ISO 证书](https://docs.agora.io/cn/Agora%20Platform/iso_cert?platform=Unity)。

同时，为支持传输层加密，该版本新增 TLS（Transport Layer Security）加密和 UDP（User Datagram Protocol）加密方式。

<div class="alert note">传输层加密导致 SDK 包体积大小受到影响，数据详见《产品概述》。</div>

#### 新增特性

**1. 极速直播**

该版本新增 `SetClientRole` 方法，支持设置观众的延时级别。你可以通过该方法在互动直播和极速直播之间切换：

- 将观众的延时级别设为超低延时，使用互动直播。
- 将观众的延时级别设为低延时，使用极速直播。

详见极速直播[产品概述](https://docs.agora.io/cn/live-streaming/product_live_standard?platform=Unity)。

**2. 发布和订阅状态转换回调**

该版本新增以下回调方便你了解音频流当前的发布及订阅状态，有助于订阅和发布相关的数据统计：

- `OnAudioPublishStateChangedHandler`: 音频发布状态发生改变。
- `OnAudioSubscribeStateChangedHandler`: 音频订阅状态发生改变。

**3. 本地首帧发布回调**

为提示用户本地音频首帧已发布，该版本新增 `OnFirstLocalAudioFramePublishedHandler` 回调，并废弃 `OnFirstLocalAudioFrameHandler` 回调。

**4. 自定义数据上报**

该版本支持自定义数据上报。如需试用，请联系 [sales@agora.io](mailto:sales@agora.io) 开通并商定自定义数据格式。

#### 改进

**1. 指定访问区域完善**

该版本修改了区域访问限制的区域码（`AREA_CODE）`，并新增日本和印度的区域码。最新区域码如下：

- `AREA_CODE_CN`: 中国大陆。
- `AREA_CODE_NA`: 北美区域。
- `AREA_CODE_EU`: 欧洲区域。
- `AREA_CODE_AS`: 除中国大陆以外的亚洲区域。
- `AREA_CODE_JP`: 日本。
- `AREA_CODE_IN`: 印度。
- `AREA_CODE_GLOB`:（默认）全球。

如你此前调用 `GetEngine` 方法时指定了访问区域，在由之前版本升级至该版本时，请确保使用正确的区域码。

**2. 会议场景**

为提升多人会议的音频体验，该版本在 `SetAudioProfile` 中新增 `AUDIO_SCENARIO_MEETING(8)`。

**3. 美声与音效**

为提升美声与音效 API 的易用性，该版本废弃 `SetLocalVoiceChanger` 和 `SetLocalVoiceReverbPreset`，并新增如下方法替代：

- `SetVoiceBeautifierPreset`: 与 `SetLocalVoiceChanger` 相比，该方法删除了小男孩等变声音效和空旷音效。
- `SetAudioEffectPreset`: 与 `SetLocalVoiceReverbPreset` 相比，该方法新增了小男孩等变声音效、空旷音效、3D 人声音效和电音音效，并删除了摇滚和嘻哈音效。
- `SetAudioEffectParameters`: 对指定的音效选项进行更细节的设置。该版本支持的音效选项有 3D 人声和电音音效。

**4. 加密**

该版本新增 `EnableEncryption` 方法，用于开启内置加密，并废弃原加密方法：

- `SetEncryptionSecret`
- `SetEncryptionMode`

与原加密方法相比，该方法新增对国密 SM4 加密模式的支持，你可以根据需要选择合适的加密模式。

**5. 通话中质量透明**

该版本进一步扩充了 `LocalAudioStats` 类和 `RemoteAudioStats` 类的成员，提供更多音频质量相关数据。

- `LocalAudioStats` 类新增 `txPacketLossRate`，表示本端到 Agora 边缘服务器的物理音频丢包率 (%)。
- `RemoteAudioStats` 类中新增 `publishDuration`，表示远端音频流的累计发布时长（毫秒）。

**6. 设置音频编码属性**

为提升音频性能，该版本对音频编码码率最大值进行如下优化：

| Profile                                   | 3.2.0 版本                                                             | 3.2.0 版本之前                                                        |
| :---------------------------------------- | :--------------------------------------------------------------------- | :-------------------------------------------------------------------- |
| `AUDIO_PROFILE_DEFAULT`                   | 直播场景: 64 Kbps 通信场景: Windows: 16 KbpsAndroid/iOS/macOS: 18 Kbps | 直播场景: 52 Kbps 通信场景:Windows: 16 KbpsAndroid/iOS/macOS: 18 Kbps |
| `AUDIO_PROFILE_SPEECH_STANDARD`           | 18 Kbps                                                                | 18 Kbps                                                               |
| `AUDIO_PROFILE_MUSIC_STANDARD`            | 64 Kbps                                                                | 48 Kbps                                                               |
| `AUDIO_PROFILE_MUSIC_STANDARD_STEREO`     | 80 Kbps                                                                | 56 Kbps                                                               |
| `AUDIO_PROFILE_MUSIC_HIGH_QUALITY`        | 96 Kbps                                                                | 128 Kbps                                                              |
| `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO` | 128 Kbps                                                               | 192 Kbps                                                              |

**7. 日志扩容**

该版本中，Agora SDK 日志文件的默认个数由 2 个增加至 5 个，单个日志文件的默认大小由 512 KB 扩大至 1024 KB。默认情况下，SDK 会生成 `agorasdk.log`、`agorasdk_1.log`、`agorasdk_2.log`、`agorasdk_3.log`、`agorasdk_4.log` 这 5 个日志文件。最新的日志永远写在 `agorasdk.log` 中。`agorasdk.log` 写满后，SDK 会从 1-4 中删除修改时间最早的一个文件，然后将 `agorasdk.log` 重命名为该文件，并建立新的 `agorasdk.log` 写入最新的日志。

**8. 音频路由**

为支持在更多 macOS 设备中播放音频，该版本在 `AUDIO_ROUTE` 枚举中新增 4 个枚举值，支持 USB 外围设备、HDMI 外围设备、DisplayPort 外围设备和 Apple AirPlay。

**9. OPPO 耳返优化**

该版本在 OPPO 如下机型上降低了耳返延时：

- Reno4 Pro 5G
- Reno4 5G

#### 问题修复

该版本修复了如下问题：

**音频**

- 调用 `SetAudioMixingPitch` 方法时，部分参数不生效。
- 在 iOS 设备上，断开蓝牙设备时，偶现音频卡顿。
- 在 macOS 设备上，特定场景下偶现因设备音频模块未启动，导致的本地采集无声。

**SDK**

- 在 Android 设备上，离开频道时偶现崩溃。
- Android 6 及以上且 CPU 为 x86 架构的手机出现崩溃。
- 在 iOS 设备上，多频道场景中，用户切换频道发言后，退出频道时偶现崩溃。

#### API 变更

**新增**

- [`SetClientRole`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a9a31f9b8e45c6528d6f56914619de314)
- [`SetAudioEffectPreset`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a4bbf600b51a400fe6ab261a95e47bad6)
- [`SetVoiceBeautifierPreset`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ab4953c6ce75adc42a13297af41676d9a)
- [`SetAudioEffectParameters`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a9ccf7abdd5f7b4bc0e7f0a7807e34390)
- [`EnableEncryption`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a54214baf0b421161990eded9c7401976)
- [`OnAudioPublishStateChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#aabfff11675d45572de8eb5f28d80ac33)
- [`OnAudioSubscribeStateChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#aa0283db27464a1cc827515853db924c5)
- [`OnFirstLocalAudioFramePublishedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a2be635d5257a7673102e0e0e62c73793)
- [`LocalAudioStats`](./API%20Reference/unity/structagora__gaming__rtc_1_1_local_audio_stats.html) 类中新增 `txPacketLossRate`
- [`RemoteAudioStats`](./API%20Reference/unity/structagora__gaming__rtc_1_1_remote_audio_stats.html) 和 `RemoteVideoStats` 类中新增 `publishDuration`
- [`AUDIO_SCENARIO_TYPE`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a7630f2ee913986430344d4aad26098a3) enum 中新增 `AUDIO_SCENARIO_MEETING`(8)
- [`AUDIO_ROUTE`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#aca310af5a1412fa7a7475b245994b3ae) enum 中新增 `AUDIO_ROUTE_USB`、`AUDIO_ROUTE_HDMI`、` AUDIO_ROUTE_DISPLAYPORT 和 ``AUDIO_ROUTE_AIRPLAY `

**废弃**

- `SetLocalVoiceChanger`
- `SetLocalVoiceReverbPreset`
- `SetEncryptionSecret`
- `SetEncryptionMode`
- `OnFirstLocalAudioFrameHandler`

## 3.0.1 版

该版本于 2020 年 9 月 16 日发布。

Agora 在该版本对通信场景采用了全新的系统架构，并升级了通信和直播场景下的 last mile 网络策略。在带宽不足时，新的网络策略能充分利用上下行有限带宽提升有效码率，从而增强弱网对抗能力，极大提升了弱网情况下通信和直播场景的终端用户体验。

由于通信场景采用了新的系统架构，为保证新老版本通信用户的互通兼容，我们使用了回退机制。如果频道内有老版本通信用户加入，则当前版本 (3.0.1) 的终端用户会回退成老版本通信。一旦回退，频道内所有用户都无法享受新版本带来的体验提升。因此我们强烈推荐同步升级所有终端用户到当前版本。

为确保享受全新架构和网络策略优化带来的好处，使用本地服务端录制的客户，请务必同步升级本地服务端录制 SDK 至 3.0.0 版本。

新增特性、改进与问题修复详见下文。

#### 升级必看

**1. 静态库升级动态库（macOS 和 iOS）**

该版本将 iOS 和 macOS 的静态库升级为动态库，且库名由 `AgoraRtcEngineKit` 变更为 `AgoraRtcKit`。如果你由老版本的 SDK 升级至该版本，请务必在 Xcode 中重新导入 `AgoraRtcKit.framework`，并将该库的 **Embed** 属性设置为 **Embed & Sign**。

如果你集成了加密库 `AgoraRtcCryptoLoader.framework`，也需要重新导入库并将其 **Embed** 属性设置为 **Embed & Sign**。

![](https://web-cdn.agora.io/docs-files/1600240476016)

**2. 枚举更名**

该版本将设置用户角色的 `CLIENT_ROLE` 枚举类更名为 `CLIENT_ROLE_TYPE`，并对其包含的枚举进行了如下修改：

- `BROADCASTER` 更名为 `CLIENT_ROLE_BROADCASTER`
- `AUDIENCE` 更名为 `CLIENT_ROLE_AUDIENCE`

#### 新增特性

**1. 设置区域访问限制**

该版本新增 `GetEngine2` 方法，支持在创建 `IRtcEngine` 实例时指定 SDK 访问的服务器区域。该功能为高级设置，适用于有访问安全限制的场景。目前支持的区域有中国大陆、北美、欧洲、亚洲（中国大陆除外）和全球（默认）。

**2. 多频道管理**

为方便用户在同一时间加入多个频道，该版本新增了 `AgoraChannel` 类。通过创建多个 `AgoraChannel` 对象，用户可以加入各 `AgoraChannel` 对象对应的频道中，实现多频道功能。

该版本还新增了 `SetMultiChannelWant` 为当前引擎开启多频道状态。

加入多个频道后，用户可以同时接收多个频道的流，但同一时间只能在一个频道发流。该功能适用于用户需要同时接收多个频道的流，或频繁切换频道发流的场景。详细的集成步骤和注意事项，请参考[加入多频道](./multiple_channel_unity)。

**3. 调整音乐文件音调**

为方便调整混音时音乐文件的播放音调，该版本新增 `SetAudioMixingPitch` 方法。通过设置该方法的 `pitch` 参数，你可以升高或降低音乐文件的音调。该方法仅对音乐文件音调有效，对本地人声不生效。

**4. 调节本地播放的指定远端用户音量**

该版本新增 `AdjustUserPlaybackSignalVolume` 方法，用以调节本地用户听到的指定远端用户的音量。通话或直播过程中，你可以多次调用该方法，来调节多个远端用户在本地播放的音量，或对某个远端用户在本地播放的音量调节多次。

**5. 美声和音效**

为提高用户的音频体验，该版本在 `SetLocalVoiceChanger` 和 `SetLocalVoiceReverbPreset` 中分别新增以下枚举值：

- 在 `VOICE_CHANGER_PRESET` 枚举中新增了以 `VOICE_BEAUTY` 为前缀和以 `GENERAL_BEAUTY_VOICE` 为前缀的枚举值，分别实现音色变换或语聊美声功能。
- 在 `AUDIO_REVERB_PRESET` 枚举中新增了以 `AUDIO_REVERB_FX` 为前缀的枚举值和 `AUDIO_VIRTUAL_STEREO`，分别实现变声音效、新版曲风音效、新版空间塑造和虚拟立体声效果。

#### 改进

**1. 音频编码属性**

为满足更高音质需求，该版本调整了直播场景下 `AUDIO_PROFILE_DEFAULT(0)` 对应的音频编码属性，详见下表：

| SDK 版本   | `AUDIO_PROFILE_DEFAULT(0)`                                  |
| :--------- | :---------------------------------------------------------- |
| 3.0.1      | 48 KHz 采样率，音乐编码，单声道，编码码率最大值为 52 Kbps。 |
| 3.0.1 之前 | 32 KHz 采样率，音乐编码，单声道，编码码率最大值为 64 Kbps。 |

**2. 质量透明**

为方便开发者获取更多通话统计信息，该版本在 `RtcStats` 类中新增如下成员，方便更好地监控通话的质量和通话过程中的内存变动：

- `gatewayRtt`
- `memoryAppUsageRatio`
- `memoryTotalUsageRatio`
- `memoryAppUsageInKbytes`

在 iOS 上，为避免 iOS 14 设备中出现本地网络权限弹窗提示，`gatewayRtt` 参数默认关闭。详见 [FAQ](https://docs.agora.io/cn/faq/local_network_privacy)。 如果你不介意弹窗提示，且需启用该功能，请[提交工单](https://agora-ticket.agora.io/)联系声网技术支持。

**3. 其他提升**

该版本自动开启直播场景下 Native SDK 与 Web SDK 的互通，并废弃原有的 `EnableWebSdkInteroperability` 方法。

#### 问题修复

- 修复了混音、Loopback 测试异常、音频录制、音频编码、回声等音频问题。
- 修复了特定场景下偶现的崩溃、日志文件、推流不稳定等问题。
- 修复了 `OnClientRoleChangedHandler` 回调多次、App ID 和 Token 校验、日志目录乱码等问题。

#### API 变更

**新增**

- [`GetEngine2`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac1a02000088c915aa36065325f42d166)
- [`CreateChannel`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac14119e2505e2f44931bed0181c5624f)
- [`AgoraChannel`](./API%20Reference/unity/classagora__gaming__rtc_1_1_agora_channel.html) 类
- [`SetMultiChannelWant`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a50ddfe8050fd11f1537bd0dddc2eb8a3)
- [`SetAudioMixingPitch`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac1f7b492430f2c3f38826804a418c2a7)
- [`AdjustUserPlaybackSignalVolume`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a6ae88c74d0dc4e80837cd0a351f81c00)
- [`VOICE_CHANGER_PRESET`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a710b9754965ccb92ed968a562968df2c) 枚举类型中新增 `VOICE_BEAUTY_VIGOROUS` 等 12 个枚举值
- [`AUDIO_REVERB_PRESET`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a1e681589411dd2f5df62dab5c1fca7b9) 枚举类型中新增 `AUDIO_REVERB_FX_KTV` 等 9 个枚举值
- `RtcStats` 类中新增 [`gatewayRtt`](./API%20Reference/unity/structagora__gaming__rtc_1_1_rtc_stats.html#aef762b5910ca3a7a06a4e37869c34fed)、[`memoryAppUsageRatio`](./API%20Reference/unity/structagora**gaming**rtc_1_1_rtc_stats.html#a5b7d328a6f8e6aca9e1b8b6c8ce16e02、[`memoryTotalUsageRatio`](./API%20Reference/unity/structagora__gaming__rtc_1_1_rtc_stats.html#a232d695be9b723df8dae4ca219c6745f) 和 [`memoryAppUsageInKbytes`](./API%20Reference/unity/structagora__gaming__rtc_1_1_rtc_stats.html#aeb37b39c64362e3954b279c6dfc5e774) 成员
- `RemoteAudioStats` 结构体中新增 [`totalActiveTime`](./API%20Reference/unity/structagora__gaming__rtc_1_1_remote_audio_stats.html#a7453a27b08439186f35b3b7bb9eafd3b) 成员
- `AudioVolumeInfo` 结构体新增 [`channelId`](./API%20Reference/unity/structagora__gaming__rtc_1_1_audio_volume_info.html#a0b95567512ed7c6642671e805207a8e1) 成员

**更名**

枚举类 `CLIENT_ROLE` 更名为 [`CLIENT_ROLE_TYPE`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a901253f94f78da34371bf7eb656a19ff)。其包含的枚举 `BROADCASTER` 和 `AUDIENCE` 更名为 `CLIENT_ROLE_BROADCASTER` 和 `CLIENT_ROLE_AUDIENCE`。

**废弃**

- `EnableWebSdkInteroperability`
- `OnUserMutedAudioHandler`, `OnFirstRemoteAudioDecodedHandler` 和 `OnFirstRemoteAudioFrameHandler`，使用 [`OnRemoteAudioStateChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a92f016ea980eba06cf38192191d17e01) 取代
- `OnStreamPublishedHandler` 和 `OnStreamUnpublishedHandler`，使用 [`OnRtmpStreamingStateChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a589c11ed19b0638824aa1b2e23971271) 取代

## 2.9.2 版

该版本于 2020 年 2 月 17 日发布。

- 该版本修复了 Android 设备上的部分异常。
- 该版本修复了 Windows 平台下，使用 Editor 调试模式时偶现的卡死问题。

## 2.9.1 版

Agora Unity SDK 广泛应用于游戏、教育、AR、VR 等场景。

该版本于 2019 年 12 月 23 日发布。功能特性及相关文档详见下文。

#### 功能特性

**1. 多平台支持**

该版本支持在 iOS、Android、macOS 和 Windows (x86/x86_64) 平台中集成。

**2. 支持与 Web 互通**

该版本提供 `EnableWebSdkInteroperability` 方法，用于打开直播场景下与 Agora Web SDK 的互通。

**3. 原始音频数据**

该版本支持原始音频数据，你可以获取原始音频数据并自行处理。

**4. 音频自采集**

该版本提供音频自采集的接口，你可以配置外部音频源及推送音频数据。

**5. 加密**

该版本支持加密功能，你可以对音频流进行加密。下表展示移动端的加密库信息，若希望减小 SDK 体积且不使用加密功能，你可以把加密库移除。

| 平台    | 加密库                                                           |
| :------ | :--------------------------------------------------------------- |
| Android | libagora-crypto.so                                               |
| iOS     | <ul><li>AgoraRtcCryptoLoader.framework <li>libcrypto.a</li></ul> |

**6. 云代理服务**

支持使用云代理服务，方便部署企业防火墙的用户正常使用 Agora 的服务，详见[使用云代理服务](cloudproxy_unity)。

#### 相关文档

你可以参考以下文档集成 SDK，实现相应的实时音频功能：

- [实现语音通话](start_call_audio_unity)或[实现语音直播](start_live_audio_unity)
- [API 参考](./API%20Reference/unity/index.html)

Agora 提供了开源的 [Unity GitHub Sample](https://github.com/AgoraIO/Agora-Unity-Quickstart/tree/master/audio/Hello-Unity3D-Agora)，你也可以前往下载并体验。
