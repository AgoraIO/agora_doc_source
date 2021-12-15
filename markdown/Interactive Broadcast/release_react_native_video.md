---
title: 发版说明
platform: React Native
updatedAt: 2021-03-12 05:30:51
---

本文提供 Agora React Native SDK 的发版说明。

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

为提升 Agora 云代理的易用性，该版本新增 `setCloudProxy` 方法设置云代理并允许你选择连接 UDP 协议的云代理。详见[云代理](./cloudproxy_native?platform=React Native)。

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
  - 摄像头无法输出采集视频：通过 `LocalVideoStateChanged(Failed, CaptureFailure)` 回调监听。
  - 摄像头重复输出采集视频：通过 `LocalVideoStateChanged(Capturing, CaptureFailure)` 回调监听。

（仅适用于 iOS）同时，为提升用户体验，该版本在 `LocalVideoStateChanged` 回调中新增本地采集出错的原因：

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

**Android 平台**

- 特定机型上，设备被插入耳机后，采集音频失败。
- Android 10 设备上偶现的采集本地音频失败的问题。

**iOS 平台**

该版本修复了如下问题：

- 开启听声辨位后，无法通过 `audioVolumeIndication` 回调获取远端用户音量。
- 在应用窗口切换为侧拉、分屏、画中画模式时调用 `enableLocalVideo(false)` 有可能会崩溃。

#### API 变更

**新增**

- [`createWithConfig`](./API%20Reference/react_native/classes/rtcengine.html#createwithconfig)
- [`setVoiceConversionPreset`](./API%20Reference/react_native/classes/rtcengine.html#setvoiceconversionpreset)
- [`EncryptionMode`](./API%20Reference/react_native/enums/encryptionmode.html) 中新增 `AES128GCM` 和 `AES256GCM`
- [`RemoteAudioStats`](./API%20Reference/react_native/interfaces/rtcengineevents.html#remoteaudiostats) 中新增 `mosValue`
- [`setVoiceBeautifierParameters`](./API%20Reference/react_native/classes/rtcengine.html#setvoicebeautifierparameters)
- [`VoiceBeautifierPreset`](./API%20Reference/react_native/enums/voicebeautifierpreset.html)中新增 `SingingBeautifier`
- [`enableDeepLearningDenoise`](./API%20Reference/react_native/classes/rtcengine.html#enabledeeplearningdenoise)
- [`joinChannel`](./API%20Reference/react_native/classes/rtcengine.html#joinchannel) 新增 `options` 参数
- [`switchChannel`](./API%20Reference/react_native/classes/rtcengine.html#switchchannel) 新增 `options` 参数
- [`createDataStreamWithConfig`](./API%20Reference/react_native/classes/rtcengine.html#createdatastreamwithconfig)
- [`RemoteAudioStats`](./API%20Reference/react_native/interfaces/rtcengineevents.html#remoteaudiostats) 中新增 `qoeQuality` 和 `qualityChangedReason` 属性
- [`setCloudProxy`](./API%20Reference/react_native/classes/rtcengine.html#setcloudproxy)
- [`LocalVideoStats`](./API%20Reference/react_native/interfaces/localvideostats.html) 中新增 `captureBrightnessLevel` 属性
- [`CameraCapturerConfiguration`](./API%20Reference/react_native/classes/cameracapturerconfiguration.html) 中新增 `captureWidth` 和 `captureHeight` 属性
- [`CameraCaptureOutputPreference`](./API%20Reference/react_native/enums/cameracaptureoutputpreference.html) 中新增 `Manual(3)`
- [`LocalVideoStreamError`](./API%20Reference/react_native/enums/localvideostreamerror.html) 中新增 `CaptureInBackGround(6)` 和 `CaptureMultipleForegroundApps(7)`
- 错误码: [`ModuleNotFound(157)`](./API%20Reference/react_native/enums/errorcode.html)

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

该版本优化了 Agora 云代理架构。如果你已经在使用云代理，为避免新 SDK 和老云代理的兼容性问题，请在升级 SDK 前联系[技术支持](https://agora-ticket.agora.io/)。详见[云代理](./cloudproxy_native?platform=React%20Native)。

**2. 安全合规**

Agora 已通过 ISO 27001、ISO 27017、ISO 27018 国际认证，为全球用户提供安全可靠的实时互动云服务。详见 [ISO 证书](https://docs.agora.io/cn/Agora%20Platform/iso_cert?platform=React%20Native)。

同时，为支持传输层加密，该版本新增 TLS（Transport Layer Security）加密和 UDP（User Datagram Protocol）加密方式。

#### 新增特性

**极速直播**

该版本在 `setClientRole` 方法中新增 `options` 参数，支持设置观众的延时级别。你可以通过该方法在互动直播和极速直播之间切换：

- 将观众的延时级别设为超低延时，使用互动直播。
- 将观众的延时级别设为低延时，使用极速直播。

详见极速直播[产品概述](https://docs.agora.io/cn/live-streaming/product_live_standard?platform=React%20Native)。

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
- 调用 `enableEncryption` 后，`FirstLocalVideoFramePublished` 回调无法被触发。
- Native 音频 SDK 的客户端与 Web 客户端互通时，Web 客户端持续报告 `Client.on(disable-local-video)` 或 `Client.on(mute-video)` 回调。

**iOS 平台**

- iPhone 5s 和 iPhone 6 开启基础美颜且用户切换前、后台时，画面出现闪烁的问题。
- `stopChannelMediaRelay` 不生效的问题。
- 特定场景下 SDK 错误地返回了 `AdmStartRecording(1012)` 错误码的问题。
- IPv6 场景下的高概率崩溃问题。
- 调用 enableEncryption 后，`FirstLocalVideoFramePublished` 回调无法被触发。
- Native 音频 SDK 的客户端与 Web 客户端互通时，Web 客户端持续报告 `Client.on(disable-local-video)` 或 `Client.on(mute-video)` 回调。

#### API 变更

**新增**

- [`setClientRole`](./API%20Reference/react_native/classes/rtcengine.html#setclientrole) 中新增 `options`
- [`setAudioEffectPreset`](./API%20Reference/react_native/classes/rtcengine.html#setaudioeffectpreset)
- [`setVoiceBeautifierPreset`](./API%20Reference/react_native/classes/rtcengine.html#setvoicebeautifierpreset)
- [`setAudioEffectParameters`](./API%20Reference/react_native/classes/rtcengine.html#setaudioeffectparameters)
- [`AudioScenario`](./API%20Reference/react_native/enums/audioscenario.html) enum 中新增 [`MEETING(8)`](./API%20Reference/react_native/enums/audioscenario.html#audioscenario.html#meeting)

**废弃**

- `setLocalVoiceChanger`
- `setLocalVoiceReverbPreset`

## 3.1.2 版

该版本于 2020 年 9 月 28 日发布。

**升级必看**

#### 1. 关闭本地网络连通质量报告功能 （仅 iOS）

为提升用户体验，防止 app 在 iOS 14.0 版本上触发查看本地网络设备的弹窗提示，该版本默认关闭本地网络连通质量报告功能。[`RtcStats`](./API%20Reference/react_native/interfaces/rtcstats.html) 中的 [`gatewayRtt`](./API%20Reference/react_native/interfaces/rtcstats.html#gatewayrtt) 参数会失效，请不要使用该参数获取客户端到本地路由器的往返延时。详见 [FAQ](https://docs.agora.io/cn/faq/local_network_privacy)。 如果你不介意弹窗提示，且需启用本地网络连通质量报告功能，请[提交工单](https://agora-ticket.agora.io/)联系声网技术支持。

#### 2. 指定访问区域完善

该版本修改了区域访问限制的区域码 `AreaCode`，最新区域码如下：

- `CN`：中国大陆。
- `NA`：北美区域。
- `EU`：欧洲区域。
- `AS`：除中国大陆以外的亚洲区域。
- `JP`：日本。
- `IN`：印度。
- `GLOB`：（默认）全球。

如你此前调用 [`createWithAreaCode`](./API%20Reference/react_native/classes/rtcengine.html#createwithareacode) 方法时指定了访问区域，在由之前版本升级至该版本时，请确保使用正确的区域码。

**新增特性**

#### 1. 发布和订阅状态转换回调

该版本新增以下回调方便你了解音视频流当前的发布及订阅状态，有助于订阅和发布相关的数据统计：

- `AudioPublishStateChanged`：音频发布状态发生改变。
- `VideoPublishStateChanged`：视频发布状态发生改变。
- `AudioSubscribeStateChanged`：音频订阅状态发生改变。
- `VideoSubscribeStateChanged`：视频订阅状态发生改变

#### 2. 本地首帧发布回调

为提示用户本地音视频首帧已发布，该版本新增如下回调：

- `FirstLocalAudioFramePublished`：已发布本地音频首帧回调。该回调取代 `FirstLocalAudioFrame` 回调，我们建议你不再使用 `FirstLocalAudioFrame` 回调。
- `FirstLocalVideoFramePublished`：已发布本地视频首帧回调。

**改进**

#### 1. CDN 直播推流

该版本新增 `RtmpStreamingEvent` 回调，报告 CDN 直播推流过程中发生的事件，如未成功添加背景图或水印。

#### 2. 加密

该版本新增 `enableEncryption` 方法，用于开启内置加密，并废弃原加密方法：

- `setEncryptionSecret`
- `setEncryptionMode`

与原加密方法相比，该方法新增对国密 SM4 加密模式的支持，你可以根据需要选择合适的加密模式。

#### 3. 通话中质量透明

该版本进一步扩充了 `LocalAudioStats` 类、`LocalVideoStats` 类、`RemoteVideoStats` 类和 `RemoteAudioStats` 类的成员，提供更多音视频质量相关数据。

- `LocalAudioStats` 类新增 `txPacketLossRate`，表示本端到 Agora 边缘服务器的物理音频丢包率 (%)。

- `LocalVideoStats` 类新增：

  - `txPacketLossRate`：本端到 Agora 边缘服务器的物理视频丢包率 (%)。
  - `captureFrameRate`：本地视频采集帧率 (fps)。

- `RemoteAudioStats` 和 `RemoteVideoStats` 类中新增 `publishDuration`，表示远端音频流和视频流的累计发布时长（毫秒）。

#### 4. 设置音频编码属性

为提升音频性能，该版本对音频编码码率最大值进行如下优化：

| Profile                  | 3.1.2 版本                              | 3.1.2 版本之前                          |
| :----------------------- | :-------------------------------------- | :-------------------------------------- |
| `Default`                | 直播场景: 64 Kbps</br>通信场景: 18 Kbps | 直播场景: 52 Kbps</br>通信场景: 18 Kbps |
| `SpeechStandard`         | 18 Kbps                                 | 18 Kbps                                 |
| `MusicStandard`          | 64 Kbps                                 | 48 Kbps                                 |
| `MusicStandardStereo`    | 80 Kbps                                 | 56 Kbps                                 |
| `MusicHighQuality`       | 96 Kbps                                 | 128 Kbps                                |
| `MusicHighQualityStereo` | 128 Kbps                                | 192 Kbps                                |

#### 5. 日志扩容

该版本中，Agora SDK 日志文件的默认个数由 2 个增加至 5 个，单个日志文件的默认大小由 512 KB 扩大至 1024 KB。默认情况下，SDK 会生成 `agorasdk.log`、`agorasdk_1.log`、`agorasdk_2.log`、`agorasdk_3.log`、`agorasdk_4.log` 这 5 个日志文件。最新的日志永远写在 `agorasdk.log` 中。`agorasdk.log` 写满后，SDK 会从 1-4 中删除修改时间最早的一个文件，然后将 `agorasdk.log` 重命名为该文件，并建立新的 `agorasdk.log` 写入最新的日志。

#### 6. TextureView 实现方式

该版本改进了 `TextureView` 的底层实现方式，从实例化 `TextureView` 对象改为用 `CreateTextureView` 方法创建 `TextureView` 对象。

#### 7. 其他改进

- 降低了音频延时。
- 降低了远端用户音频首帧解码时间。
- 该版本对 iOS 部分机型（使用 Apple A10 及以下芯片）进行性能优化，降低了 CPU 使用率和内存占用。
- 该版本在 OPPO 如下机型上降低了耳返延时：
  - Reno4 Pro 5G
  - Reno4 5G

**问题修复**

该版本修复了如下问题：

- `FirstLocalVideoFrame` 和 `FirstRemoteVideoFrame` 回调的触发时机不准确。
- 调用 `setAudioMixingPitch` 方法时，部分参数不生效。
- 美颜功能不生效。
- Android 平台：
  - 特定场景下视频画面模糊。
  - Android 6 及以上且 CPU 为 x86 架构的手机出现崩溃。
- iOS 平台：
  - 远端用户退出频道时，本地用户看远端视频黑屏。
  - 断开蓝牙设备时，偶现音频卡顿。
  - 多频道场景中，用户切换频道发言后，退出频道时偶现崩溃。

**API 变更**

#### 新增

- [`AudioPublishStateChanged`](./API%20Reference/react_native/interfaces/rtcengineevents.html#audiopublishstatechanged)
- [`VideoPublishStateChanged`](./API%20Reference/react_native/interfaces/rtcengineevents.html#videopublishstatechanged)
- [`AudioSubscribeStateChanged`](./API%20Reference/react_native/interfaces/rtcengineevents.html#audiosubscribestatechanged)
- [`VideoSubscribeStateChanged`](./API%20Reference/react_native/interfaces/rtcengineevents.html#videosubscribestatechanged)
- [`FirstLocalAudioFramePublished`](./API%20Reference/react_native/interfaces/rtcengineevents.html#firstlocalaudioframepublished)
- [`FirstLocalVideoFramePublished`](./API%20Reference/react_native/interfaces/rtcengineevents.html#firstlocalvideoframepublished)
- [`enableEncryption`](./API%20Reference/react_native/classes/rtcengine.html#enableencryption)
- [`LocalAudioStats`](./API%20Reference/react_native/interfaces/localaudiostats.html) 类中新增 [`txPacketLossRate`](./API%20Reference/react_native/interfaces/localaudiostats.html#txpacketlossrate)
- [`LocalVideoStats`](./API%20Reference/react_native/interfaces/localvideostats.html) 类中新增 [`txPacketLossRate`](./API%20Reference/react_native/interfaces/localvideostats.html#txpacketlossrate) 和 [`captureFrameRate`](./API%20Reference/react_native/interfaces/localvideostats.html#captureframerate)
- [`RemoteAudioStats`](./API%20Reference/react_native/interfaces/remoteaudiostats.html) 和 [`RemoteVideoStats` ](./API%20Reference/react_native/interfaces/remotevideostats.html)类中新增 `publishDuration`
- [`RtmpStreamingEvent`](./API%20Reference/react_native/interfaces/rtcengineevents.html#rtmpstreamingevent)
- 错误码：[`NoServerResources(103)`](./API%20Reference/react_native/enums/errorcode.html#noserverresources)
- 警告码：
  - [`AdmCategoryNotPlayAndRecord(1029)`](./API%20Reference/react_native/enums/warningcode.html#admcategorynotplayandrecord)
  - [`AdmNoDataReadyCallback(1040)`](./API%20Reference/react_native/enums/warningcode.html#admnodatareadycallback)
  - [`AdmInconsistentDevices(1042)`](./API%20Reference/react_native/enums/warningcode.html#adminconsistentdevices)
  - [`ApmResidualEcho(1053)`](./API%20Reference/react_native/enums/warningcode.html#apmresidualecho)

#### 废弃

- `setEncryptionSecret`
- `setEncryptionMode`
- `FirstLocalAudioFrame`

#### 删除

- 警告码：`AdmImproperSettings(1053)`
-

## 3.0.1 版

该版本于 2020 年 9 月 4 日发布。功能特性及相关文档详见下文。

**功能特性**

1. 全面适配 Agora RTC SDK v3.0.1。
2. 支持多频道管理。
3. 全面支持异步编程 （Promises）。
4. Android 平台支持 `TextureView` 渲染。

**相关文档**

你可以参考以下文档集成 SDK，实现相应的实时音视频功能：

- 快速开始：
- [实现语音通话](./start_call_audio_react_native)
- [实现视频通话](./start_call_react_native)
- [实现视频互动直播](./start_live_react_native)
- [实现音频互动直播](./start_live_audio_react_native)
- [API 参考](./API%20Reference/react_native/index.html)

Agora 在 GitHub 提供一个开源的 [Agora React Native Quickstart](https://github.com/AgoraIO-Community/Agora-RN-Quickstart) 示例项目。你也可以前往下载并体验。
