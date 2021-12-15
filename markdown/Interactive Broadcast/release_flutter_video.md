---
title: 发版说明
platform: Flutter
updatedAt: 2021-03-12 05:24:43
---

本文提供 Agora Flutter SDK 的发版说明。

## 3.3.1 版

该版本于 2020 年 3 月 12 日发布。

#### 升级必看

该版本废弃了 `setDefaultMuteAllRemoteAudioStreams` 和 `setDefaultMuteAllRemoteVideoStreams`，并修改了 `mute` 相关方法的如下行为：

- `mute` 相关方法需要在加入频道或切换频道**后**调用，否则会不生效。
- `mute` 相关方法都能独立控制用户的订阅状态。一起调用 `muteAll` 为前缀的方法和 `muteRemote` 为前缀的方法时，后调用的方法会生效。
- `muteAll` 为前缀的方法设置是否订阅所有音频或视频流，包含调用时刻之后加入频道的用户的音频或视频流，即 `muteAll` 为前缀的方法包含了 `setDefaultMute` 为前缀的方法的功能。Agora 不推荐一起调用 `muteAll` 和 `setDefaultMute` 为前缀的方法，否则设置可能会不生效。

#### 新增特性

**1. 频道媒体选项**

为方便开发者更灵活地控制媒体流订阅，`joinChannel` 和 `switchChannel` 方法新增 `options` 参数，支持设置用户加入频道和切换频道时是否订阅频道内所有的远端音频流或视频流。

**2. 云代理**

为提升 Agora 云代理的易用性，该版本新增 `setCloudProxy` 方法设置云代理并允许你选择连接 UDP 协议的云代理。详见[云代理](./cloudproxy_native?platform=Flutter)。

**3. AI 降噪**

为在传统降噪模式的基础上消除非平稳噪声，该版本新增 `enableDeepLearningDenoise`，用于开启 AI 降噪模式。

**4. 歌唱美声**

在歌唱场景中，为美化歌声并添加混响效果，该版本新增 `setVoiceBeautifierParameters`，并在 `VoiceBeautifierPreset` 中添加 `SingingBeautifier` 枚举值。

你可以调用 `setVoiceBeautifierPreset(SingingBeautifier)` 美化男声并添加歌声在小房间的混响效果。如需更多设置，你可以调用 `setVoiceBeautifierParameters(SingingBeautifier, param1, param2)` 美化男声或女声，并添加歌声在小房间、大房间或大厅的混响效果。

**5. 设置日志文件**

为保证日志内容的完整性，该版本新增 `createWithConfig` 方法，并在 `config` 参数中新增 `logConfig` 属性，在你初始化 `RtcEngine` 时可用于设置 Agora SDK 输出的日志文件。详见[如何设置日志文件](https://docs.agora.io/cn/Interactive%20Broadcast/faq/logfile)。

自该版本起，Agora 不推荐使用 `setLogFile`、`setLogFileSize` 和 `setLogFilter` 方法设置日志文件。

**6. 采集画质**

为更好地控制摄像头采集的画质，该版本新增支持自定义采集分辨率并监听采集异常：

- 自定义采集分辨率：调用 `setCameraCapturerConfiguration` 方法，将采集偏好设为 `Manual(3)` 并设置采集视频的宽高。

- 监听采集异常：

  - 采集的画质亮度异常：通过 `localVideoStats` 回调的 `captureBrightnessLevel` 监听。
  - 摄像头无法输出采集视频：通过 `localVideoStateChange(Failed, Failure)` 回调监听。
  - 摄像头重复输出采集视频：通过 `localVideoStateChange(Capturing, Failure)` 回调监听。

同时，为提升用户体验，该版本在 `localVideoStateChange` 回调中新增本地采集出错的原因：

- `CaptureInBackGround(6)`：应用处于后台。
- `CaptureMultipleForegroundApps(7)`：应用窗口处于侧拉、分屏、画中画模式。

**7. 创建数据流**

为了支持歌词同步、课件同步等场景，该版本废弃了原有的 `createDataStream` 方法，并使用 `createDataStreamWithConfig` 方法替代，用于创建数据流，并设置数据流是否与发布到 Agora 频道内的音频流同步以及接收到的数据是否有序。

**8. 基础变声**

该版本新增 `setVoiceConversionPreset` 方法改变用户的声音。你可以把男声变得低沉、稳重，把女声变得甜美、中性。

#### 改进

**1. AES-GCM 加密模式**

在安全要求高的场景中，为保证数据的保密性、完整性和真实性，提高数据加密的计算效率，该版本在 `EncryptionMode` 中新增如下枚举值：

- `AES128GCM`: 128 位 AES 加密，GCM 模式。
- `AES256GCM`: 256 位 AES 加密，GCM 模式。

<div class="alert note">开启加密功能后，同一频道内的所有用户都必须使用相同的加密模式和密钥，包括服务端用户（例如 Agora 录制服务）。</div>

**2. 远端音频统计**

- 为监测通话中与音频相关的主观体验，该版本在 `remoteAudioStats` 中增加 `mosValue`，报告 Agora 实时音频 MOS（平均主观意见分）评估系统对接收到的远端音频流的质量评分。
- 为方便监测通话中与音频有关的主观体验，该版本在 `remoteAudioStats` 中增加 `qoeQuality` 和 `qualityChangedReason`，报告接收远端音频时的体验质量以及体验质量较差的原因。

#### 问题修复

**iOS 平台**

该版本修复了如下问题：

- 开启听声辨位后，无法通过 `audioVolumeIndication` 回调获取远端用户音量。
- 在应用窗口切换为侧拉、分屏、画中画模式时调用 `enableLocalVideo(false)` 有可能会崩溃。

**Android 平台**

- 特定机型上，设备被插入耳机后，采集音频失败。
- Android 10 设备上偶现的采集本地音频失败的问题。

#### API 变更

**新增**

- [`createWithConfig`]
- [`setVoiceConversionPreset`](./API%20Reference/flutter/rtc_engine/RtcEngine/setVoiceConversionPreset.html)
- [`EncryptionMode`](./API%20Reference/flutter/rtc_engine/RtcEngine/EncryptionConfig-class.html) 中新增 `AES128GCM` 和 `AES256GCM`
- [`AgoraRtcRemoteAudioStats`](./API%20Reference/flutter/rtc_engine/RtcEngine/RemoteAudioStats-class.html) 中新增 `mosValue`
- [`setVoiceBeautifierParameters`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVoiceBeautifierParameters:param1:param2:)
- [`AgoraVoiceBeautifierPreset`](./API%20Reference/oc/Constants/AgoraVoiceBeautifierPreset.html) 常量中新增 `SingingBeautifier`
- [`enableDeepLearningDenoise`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableDeepLearningDenoise:)
- [`joinChannel`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:options:) 新增 `options` 参数
- [`switchChannel`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/switchChannelByToken:channelId:options:) 新增 `options` 参数
- [`createDataStreamWithConfig`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/createDataStream:config:)
- [`RemoteAudioStats`](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) 类中新增 `qoeQuality` 和 `qualityChangedReason` 属性
- [`setCloudProxy`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setCloudProxy:)
- [`LocalVideoStats`](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html) 类中新增 `captureBrightnessLevel` 属性
- [`CameraCapturerConfiguration`](./API%20Reference/oc/Classes/AgoraCameraCapturerConfiguration.html) 类中新增 `captureWidth` 和 `captureHeight` 属性
- [`CameraCaptureOutputPreference`](./API%20Reference/oc/Constants/AgoraCameraCaptureOutputPreference.html) 常量中新增 `Manual(3)`
- [`LocalVideoStreamError`](./API%20Reference/oc/Constants/AgoraLocalVideoStreamError.html) 常量中新增 `CaptureInBackGround(6)` 和 `CaptureMultipleForegroundApps(7)`
- 错误码: [`ModuleNotFound(157)`](./API%20Reference/oc/Constants/AgoraErrorCode.html)

**废弃**

- `createWithAreaCode`
- `setDefaultMuteAllRemoteVideoStreams`
- `setDefaultMuteAllRemoteAudioStreams`
- `setLogFile`
- `setLogFileSize`
- `setLogFilter`
- `createDataStream`

## 3.2.1 版

该版本于 2020 年 12 月 23 日发布。

#### 升级必看

**1. 云代理**

该版本优化了 Agora 云代理架构。如果你已经在使用云代理，为避免新 SDK 和老云代理的兼容性问题，请在升级 SDK 前联系[技术支持](https://agora-ticket.agora.io/)。详见[云代理](./cloudproxy_native?platform=Flutter)。

**2. 安全合规**

Agora 已通过 ISO 27001、ISO 27017、ISO 27018 国际认证，为全球用户提供安全可靠的实时互动云服务。详见 [ISO 证书](https://docs.agora.io/cn/Agora%20Platform/iso_cert?platform=Flutter)。

同时，为支持传输层加密，该版本新增 TLS（Transport Layer Security）加密和 UDP（User Datagram Protocol）加密方式。

#### 新增特性

**极速直播**

该版本在 `setClientRole` 方法中新增 `options` 参数，支持设置观众的延时级别。你可以通过该方法在互动直播和极速直播之间切换：

- 将观众的延时级别设为超低延时，使用互动直播。
- 将观众的延时级别设为低延时，使用极速直播。

详见极速直播[产品概述](https://docs.agora.io/cn/live-streaming/product_live_standard?platform=Flutter)。

#### 改进

**1. 会议场景**

为提升多人会议的音频体验，该版本在 `setAudioProfile` 中新增 `MEETING(8)`。

**2. 美声与音效**

为提升美声与音效 API 的易用性，该版本废弃 `setLocalVoiceChanger` 和 `setLocalVoiceReverbPreset`，并新增如下方法替代：

- `setVoiceBeautifierPreset`: 与 `setLocalVoiceChanger` 相比，该方法删除了小男孩等变声音效和空旷音效。
- `setAudioEffectPreset`: 与 `setLocalVoiceReverbPreset` 相比，该方法新增了小男孩等变声音效、空旷音效、3D 人声音效和电音音效，并删除了摇滚和嘻哈音效。
- `setAudioEffectParameters`: 对指定的音效选项进行更细节的设置。该版本支持的音效选项有 3D 人声和电音音效。

**3. 互动直播延时**

互动直播场景下，观众看直播的延时降低了约 500 ms。

**4. 本地采集视频画质 （仅 iOS）**

为提升本地采集的视频画质，该版本对摄像头采集本地视频进行如下优化：

- 优化后置摄像头自动对焦功能。
- 改善强光场景下图像局部过曝问题，该改善仅对分辨率不低于 960 × 540 的视频有效。

#### 问题修复

该版本修复了如下问题：

**Android 平台**

- 该版本修复了用户使用小米音箱进行通话时偶现的录音问题。
- 修复了发送端使用 vivo X30 时，接收端出现黑屏的问题。
- 修复了发送端使用 Android TV 频繁进、出频道时，接收端偶现黑屏的问题。
- IPv6 场景下的高概率崩溃问题。
- 调用 `enableEncryption` 后，`firstLocalVideoFramePublished` 回调无法被触发。
- Native 音频 SDK 的客户端与 Web 客户端互通时，Web 客户端持续报告 `Client.on(disable-local-video)` 或 `Client.on(mute-video)` 回调。

**iOS 平台**

- iPhone 5s 和 iPhone 6 开启基础美颜且用户切换前、后台时，画面出现闪烁的问题。
- `stopChannelMediaRelay` 不生效的问题。
- 特定场景下 SDK 错误地返回了 `AdmStartRecording(1012)` 错误码的问题。
- IPv6 场景下的高概率崩溃问题。
- 调用 `enableEncryption` 后，`firstLocalVideoFramePublished` 回调无法被触发。
- Native 音频 SDK 的客户端与 Web 客户端互通时，Web 客户端持续报告 `Client.on(disable-local-video)` 或 `Client.on(mute-video)` 回调。

#### API 变更

**新增**

- [`setClientRole`](./API%20Reference/flutter/rtc_channel/RtcChannel/setClientRole.html) 中新增 `options`
- [`setAudioEffectPreset`](./API%20Reference/flutter/rtc_engine/RtcEngine/setAudioEffectPreset.html)
- [`setVoiceBeautifierPreset`](./API%20Reference/flutter/rtc_engine/RtcEngine/setVoiceBeautifierPreset.html)
- [`setAudioEffectParameters`](./API%20Reference/flutter/rtc_engine/RtcEngine/setAudioEffectParameters.html)
- [`AudioScenario`](./API%20Reference/flutter/rtc_engine/AudioScenario-class.html) enum 中新增 `MEETING(8)`

**废弃**

- `setLocalVoiceChanger`
- `setLocalVoiceReverbPreset`

## 3.1.2 版

该版本于 2020 年 9 月 30 日发布。功能特性及相关文档详见下文。

**功能特性**

1. 全面适配 Agora RTC SDK v3.1.2。
2. 支持多频道管理。
3. 全面支持异步编程 （`async/await`）。
4. Android 平台支持 `TextureView` 渲染。
5. 支持发布和订阅状态转换回调、本地首帧发布回调。

**相关文档**

你可以参考以下文档集成 SDK，实现相应的实时音视频功能：

- 快速开始：
  - [实现语音通话](/cn/Video/start_call_audio_flutter?platform=Flutter)
  - [实现视频通话](/cn/Video/start_call_flutter?platform=Flutter)
  - [实现视频互动直播](/cn/Video/start_live_flutter?platform=Flutter)
  - [实现音频互动直播](/cn/Video/start_live_audio_flutter?platform=Flutter)
- [API 参考](/cn/Video/API%20Reference/flutter/v3.1.2/index.html)

Agora 在 GitHub 提供一个开源的 [Agora Flutter Quickstart](https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart) 示例项目。你也可以前往下载并体验。

<div class="alert note">为提升用户体验，防止 app 在 iOS 14.0 版本上触发查看本地网络设备的弹窗提示，该版本默认关闭本地网络连通质量报告功能。<code>RtcStats</code> 中的 <code>gatewayRtt</code> 参数会失效，请不要使用该参数获取客户端到本地路由器的往返延时。详见 <a href="https://docs.agora.io/cn/faq/local_network_privacy">FAQ</a>。 如果你不介意弹窗提示，且需启用本地网络连通质量报告功能，请<a href="https://agora-ticket.agora.io/">提交工单</a>联系声网技术支持。</div>
