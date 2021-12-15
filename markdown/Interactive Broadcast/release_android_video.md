---
title: 发版说明
platform: Android
updatedAt: 2021-03-29 03:54:03
---

本文提供 Agora 视频 SDK 的发版说明。

## 已知问题和局限性

#### 隐私权变更

如果您的应用以 Android 9 为目标平台，您应牢记以下行为变更。对设备序列信息和 DNS 信息进行的这些更新可增强用户隐私保护。

**构建序列号弃用**

在 Android 9 中，`Build.SERIAL` 始终设置为 "UNKNOWN" 以保护用户的隐私。
如果您的应用需要访问设备的硬件序列号，您应改为请求 READ_PHONE_STATE 权限，然后调用 `getSerial()`。

**DNS 隐私**

以 Android 9 为目标平台的应用应采用私有 DNS API。 具体而言，当系统解析程序正在执行 DNS-over-TLS 时，应用应确保任何内置 DNS 客户端均使用加密的 DNS 查找与系统相同的主机名，或停用它而改用系统解析程序。

详情请参考 [Android 隐私权变更](https://developer.android.com/about/versions/pie/android-9.0-changes-28?hl=zh-CN#privacy-changes-p)。

## 3.3.0 版

该版本于 2021 年 1 月 22 日发布。

#### 升级必看

**1. 集成变更**

该版本新增 Agora 基础计算框架 `libagora-core.so`。请参考[集成 SDK](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_android?platform=Android#integrate_sdk) 将 SDK 集成至你的项目。

**2. 行为变更**
该版本废弃了 `setDefaultMuteAllRemoteAudioStreams` 和 `setDefaultMuteAllRemoteVideoStreams`，并修改了 `muteRemote` 相关方法的如下行为：

- `muteRemote` 相关方法需要在加入频道或切换频道**后**调用，否则会不生效。
- `muteRemote` 相关方法都能独立控制用户的订阅状态。一起调用 `muteAll` 为前缀的方法和 `muteRemote` 为前缀的方法时，后调用的方法会生效。
- `muteAll` 为前缀的方法设置是否订阅所有音频或视频流，包含调用时刻之后加入频道的用户的音频或视频流，即 `muteAll` 为前缀的方法包含了 `setDefaultMute` 为前缀的方法的功能。Agora 不推荐一起调用 `muteAll` 和 `setDefaultMute` 为前缀的方法，否则设置可能会不生效。

更多介绍见[设置订阅状态](./set_subscribing_state?platform=Android)。

#### 新增特性

**1. 频道媒体选项**

为方便开发者更灵活地控制媒体流订阅，该版本新增 `joinChannel`[2/2] 和 `switchChannel`[2/2] 方法，支持设置用户加入频道和切换频道时是否订阅频道内所有的远端音频流或视频流。

**2. 云代理**

为提升 Agora 云代理的易用性，该版本新增 `setCloudProxy` 方法设置云代理并允许你选择连接 UDP 或 TCP（加密）协议的云代理。详见[云代理](./cloudproxy_native?platform=Android)。

**3. AI 降噪**

为在传统降噪模式的基础上消除非平稳噪声，该版本新增 `enableDeepLearningDenoise`，用于开启 AI 降噪模式。

<div class="alert note">开启 AI 降噪前，请将 <code>libagora_ai_denoise_extension.so</code> 动态库集成到你的项目文件中。</div>

**4. 歌唱美声**

在歌唱场景中，为美化歌声并添加混响效果，该版本新增 `setVoiceBeautifierParameters`，并在 `VOICE_BEAUTIFIER_PRESET` 中添加 `SINGING_BEAUTIFIER` 枚举值。

你可以调用 `setVoiceBeautifierPreset(SINGING_BEAUTIFIER)`美化男声并添加歌声在小房间的混响效果。如需更多设置，你可以调用 `setVoiceBeautifierParameters(SINGING_BEAUTIFIER, param1, param2)` 美化男声或女声，并添加歌声在小房间、大房间或大厅的混响效果。

**5. 设置和上传日志文件**

为保证日志内容的完整性，该版本在 `RtcEngineConfig` 中新增 `mLogConfig` 成员变量，在你初始化 `RtcEngine` 时可用于设置 Agora SDK 输出的日志文件。详见[如何设置日志文件](/cn/Voice/faq/logfile)。

同时，为方便问题排查，该版本新增 `uploadLogFile `方法，用于上传所有本地的 SDK 日志文件。成功调用该方法后，SDK 会触发 `onUploadLogResult` 回调报告日志文件是否成功上传至 Agora 服务器。

自该版本起，Agora 不推荐使用 `setLogFile`、`setLogFileSize` 和 `setLogFilter` 方法设置日志文件。

**6. 采集画质**

为更好地控制摄像头采集的画质，该版本新增支持自定义采集分辨率并监听采集异常：

- 自定义采集分辨率：调用 `setCameraCapturerConfiguration` 方法，将采集偏好设为 `MANUAL(3)` 并设置采集视频的宽高。
- 监听采集异常：
  - 采集的画质亮度异常：通过 `onLocalVideoStats` 回调的 `captureBrightnessLevel` 监听。
  - 摄像头无法输出采集视频：通过 `onLocalVideoStateChanged(LOCAL_VIDEO_STREAM_STATE_FAILED, LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE)` 回调监听。
  - 摄像头重复输出采集视频：通过 `onLocalVideoStateChanged(LOCAL_VIDEO_STREAM_STATE_CAPTURING, LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE)` 回调监听。

**7. 创建数据流**

为了支持歌词同步、课件同步等场景，该版本废弃了原有的 `createDataStream` 方法，并使用新的同名方法替代，用于创建数据流，并设置数据流是否与发布到 Agora 频道内的音频流同步以及接收到的数据是否有序。

#### 改进

**1. 原始音频数据**

该版本补齐了 Android 平台的原始音频数据接口。你可以从原始音频数据接口获取原始音频数据，并进行前处理或后处理，获取想要的播放效果。

- `onPlaybackFrameBeforeMixing`
- `onMixedFrame`
- `isMultipleChannelFrameWanted`
- `onPlaybackFrameBeforeMixingEx`

**2. 远端音频统计**

为方便监测通话中与音频有关的主观体验，该版本在 `onRemoteAudioStats` 中增加 `qoeQuality` 和 `qualityChangedReason`，报告接收远端音频时的体验质量以及体验质量较差的原因。

#### 问题修复

- 特定机型上，设备被插入耳机后，采集音频失败。
- Android 10 设备上偶现的采集本地音频失败的问题。
- 通过 Media IO 方式自定义 Texture 格式的视频源时，偶现视频渲染异常。

#### API 变更

**新增**

- [`setVoiceBeautifierParameters`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa7124a19c0704d8c549bde165a450be3)
- [`SINGING_BEAUTIFIER`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#af28042038aa5568c4668425658154654) 枚举值
- [`enableDeepLearningDenoise`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a12ef81e6b342a554305ba1ba5b1c5356)
- [`joinChannel[2/2]`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a501d43c29b0d2ea6096cca3d71c834fe)
- [`switchChannel[2/2]`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a4d8858a38b81473c4784401e25db982f)
- [`createDataStream`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a594fc8b39073487469665d73c2d73c74)
- [`uploadLogFile`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ae27d94878323574c7ba839a78a86aac8)
- [`onUploadLogResult`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#adba198c3f4602714ba61e1bdd18a8a2c)
- `RtcEngineConfig` 类中新增 [`mLogConfig` ](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine_config.html#af240d344b3a223622d8d3f3b093acf41)成员变量
- [`onPlaybackFrameBeforeMixing`](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#ab43c709bdbce83f907b00710b48d8d56)
- [`onMixedFrame`](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#a81794255075807161fa1a3c13e23db2c)
- [`isMultipleChannelFrameWanted`](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#a118bceeebe3f1aa0298fdbe44a3ce069)
- [`onPlaybackFrameBeforeMixingEx`](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#a0c400931561b31732e4ef02f20ad6ac7)
- `RemoteAudioStats` 类中新增 [`qoeQuality`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_audio_stats.html#a3c008f73e8bb77f52530f4129378e0fb) 和 [`qualityChangedReason`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_audio_stats.html#aa97add0d15edfdd0fc44da9d1aa3dfe0) 成员变量
- [`setCloudProxy`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a191c08aa5bffe7083fa182729104244c)
- `LocalVideoStats` 类中新增 [`captureBrightnessLevel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#a90d27a9f25b03c4e7ef428ba1ff8698c) 成员变量
- `CameraCapturerConfiguration`类中新增 [`width`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_camera_capturer_configuration_1_1_capture_dimensions.html#aa4864ca70b912d5dfa371ec8ab542117) 和 [`height`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_camera_capturer_configuration_1_1_capture_dimensions.html#a9cb98d3364d707c0d448553db807cb4f) 成员变量
- `CAPTURER_OUTPUT_PREFERENCE` enum 中新增 [`CAPTURER_OUTPUT_PREFERENCE_MANUAL(3)`](./API%20Reference/java/enumio_1_1agora_1_1rtc_1_1video_1_1_camera_capturer_configuration_1_1_c_a_p_t_u_r_e_r___o_u_t_p_u_t___p_r_e_f_e_r_e_n_c_e.html#aeebd07224559669e412eb34d6e9a4a53)
- 错误码：[`ERR_MODULE_NOT_FOUND(157)`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#ad638ac3c7ccbc3620eaed68ddfd49efe)

**废弃**

- `setDefaultMuteAllRemoteVideoStreams`
- `setDefaultMuteAllRemoteAudioStreams`
- `setLogFile`
- `setLogFileSize`
- `setLogFilter`
- `createDataStream`

## 3.2.1 版

该版本于 2020 年 12 月 17 日发布，修复了如下问题：

- IPv6 场景下的高概率崩溃问题。
- 调用 `enableEncryption` 后，`onFirstLocalVideoFramePublished` 回调无法被触发。

## 3.2.0 版

该版本于 2020 年 11 月 30 日发布。

#### 升级必看

**1. 集成变更**

**SDK 包变更**

自该版本起，SDK 包中新增以下文件：

- `libagora-fdkaac.so`: Fraunhofer FDK AAC 动态库。
- `libagora-mpg123.so`: mpg123 动态库。
- `libagora-soundtouch.so`: SoundTouch 动态库。
- `libagora-ffmpeg.so`: FFmpeg 动态库。

如果你将 SDK 升级到 v3.2.0 或更高版本，请务必将上述文件拷贝至 `libagora-rtc-sdk.so` 所在文件夹中。

此外，该版本将 SDK 包中的 `libagora-crypto.so` 文件合并入 `libagora-rtc-sdk.so` 文件中。集成 `libagora-rtc-sdk.so` 后，你可以直接使用内置加密功能。

**拼写更正**

该版本更正了 API 拼写错误，将 `USER_PRIORITY_NORANL` 修改为 `USER_PRIORITY_NORMAL`。

**2. 云代理**

该版本优化了 Agora 云代理架构。如果你已经在使用云代理，为避免新 SDK 和老云代理的兼容性问题，请在升级 SDK 前联系[技术支持](https://agora-ticket.agora.io/)。详见[云代理](./cloudproxy_native?platform=Android)。

**3. 安全合规**

Agora 已通过 ISO 27001、ISO 27017、ISO 27018 国际认证，为全球用户提供安全可靠的实时互动云服务。详见 [ISO 证书](https://docs.agora.io/cn/Agora%20Platform/iso_cert?platform=Android)。

同时，为支持传输层加密，该版本新增 TLS（Transport Layer Security）加密和 UDP（User Datagram Protocol）加密方式。

<div class="alert note">传输层加密导致以下指标受到影响：<li>SDK 包体积大小：数据详见《产品概述》。</li><li>首帧出图时长：首帧出图时长（中位数）相比 v3.1.0 增加 0 ~ 70 ms。</li></div>

#### 新增特性

**极速直播**

该版本新增 `setClientRole` 方法，支持设置观众的延时级别。你可以通过该方法在互动直播和极速直播之间切换：

- 将观众的延时级别设为超低延时，使用互动直播。
- 将观众的延时级别设为低延时，使用极速直播。

详见极速直播[产品概述](https://docs.agora.io/cn/live-streaming/product_live_standard?platform=Android)。

#### 改进

**1. 会议场景**

为提升多人会议的音频体验，该版本在 `setAudioProfile` 中新增 `AUDIO_SCENARIO_MEETING(8)`。

**2. 美声与音效**

为提升美声与音效 API 的易用性，该版本废弃 `setLocalVoiceChanger` 和 `setLocalVoiceReverbPreset`，并新增如下方法替代：

- `setVoiceBeautifierPreset`: 与 `setLocalVoiceChanger` 相比，该方法删除了小男孩等变声音效和空旷音效。
- `setAudioEffectPreset`: 与 `setLocalVoiceReverbPreset` 相比，该方法新增了小男孩等变声音效、空旷音效、3D 人声音效和电音音效，并删除了摇滚和嘻哈音效。
- `setAudioEffectParameters`: 对指定的音效选项进行更细节的设置。该版本支持的音效选项有 3D 人声和电音音效。

**3. 互动直播延时**

互动直播场景下，观众看直播的延时降低了约 500 ms。

#### 问题修复

**音频**

- 该版本修复了用户使用小米音箱进行通话时偶现的录音问题。

**视频**

- 修复了发送端使用 vivo X30 时，接收端出现黑屏的问题。
- 修复了发送端使用 Android TV 频繁进、出频道时，接收端偶现黑屏的问题。

#### API 变更

**新增**

- [`setClientRole`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6571a364cfb42a3e552e6bfdf0eebb7c)
- [`setAudioEffectPreset`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af12f990d231904787e1cfc3d9097af04)
- [`setVoiceBeautifierPreset`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a5977ae8d823d23314faab78fa1a72a29)
- [`setAudioEffectParameters`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a62beca2921fbd86a9b0041a051d8564e)
- `AUDIO_SCENARIO_TYPE` enum 中新增 [`AUDIO_SCENARIO_MEETING`(8)](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#a085184565a4807f7e2b4d0fc0beaa1d6)

**废弃**

- `setLocalVoiceChanger`
- `setLocalVoiceReverbPreset`

## 3.1.3 版

该版本于 2020 年 10 月 13 发布，修复了离开频道时偶现的崩溃问题。

## 3.1.2 版

该版本于 2020 年 9 月 14 日发布。该版本修复了如下问题：

- 使用 MediaIO 方式切换视频源时画面会卡住。
- `onFirstLocalVideoFrame` 和 `onFirstRemoteVideoFrame` 回调的触发时机不准确。

## 3.1.1 版

该版本于 2020 年 8 月 27 日发布。该版本修改了区域访问限制的区域码 `AreaCode`，最新区域码如下：

- `AREA_CODE_CN`: 中国大陆。
- `AREA_CODE_NA`: 北美区域。
- `AREA_CODE_EU`: 欧洲区域。
- `AREA_CODE_AS`: 除中国大陆以外的亚洲区域。
- `AREA_CODE_JP`: 日本。
- `AREA_CODE_IN`: 印度。
- `AREA_CODE_GLOB`:（默认）全球。

如你此前调用 [`create`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a45832a91b1051bc7641ccd8958288dba) 方法时指定了访问区域，在由之前版本升级至该版本时，请确保使用正确的区域码。

## 3.1.0 版

该版本于 2020 年 8 月 11 日发布。

#### 新增特性

**1. 发布和订阅状态转换回调**

该版本新增以下回调方便你了解音视频流当前的发布及订阅状态，有助于订阅和发布相关的数据统计：

- `onAudioPublishStateChanged`: 音频发布状态发生改变。
- `onVideoPublishStateChanged`: 视频发布状态发生改变。
- `onAudioSubscribeStateChanged`: 音频订阅状态发生改变。
- `onVideoSubscribeStateChanged`: 视频订阅状态发生改变。

**2. 本地首帧发布回调**

为提示用户本地音视频首帧已发布，该版本新增如下回调：

- `onFirstLocalAudioFramePublished`：已发布本地音频首帧回调。该回调取代 `onFirstLocalAudioFrame` 回调，我们建议你不再使用 `onFirstLocalAudioFrame` 回调。
- `onFirstLocalVideoFramePublished`：已发布本地视频首帧回调。

**3. TextureView 支持**

为支持用户在屏幕共享等场景下对视频画面进行缩放、旋转和平移操作，该版本新增 `CreateTextureView` 方法，向你返回 Android 系统的 `TextureView`。请根据实际场景并参考 API 文档，在 `CreateRendererView` 和 `CreateTextureView` 之中选择一种使用。

**4. 自定义数据上报**

该版本支持自定义数据上报。如需试用，请联系 [sales@agora.io](mailto:sales@agora.io) 开通并商定自定义数据格式。

#### 改进

**1. 指定访问区域完善**

该版本新增以下枚举值，在调用 `create` 创建 `RtcEngine` 实例时提供更多区域选择。指定访问区域后，集成了 Agora SDK 的 app 会连接指定区域内的 Agora 服务器。

- `AREA_CODE_JAPAN`: 日本。
- `AREA_CODE_INDIA`: 印度。

**2. 屏幕共享**

为提升屏幕共享的用户体验，该版本在 `IVideoSource` 类中新增以下回调：

- `getCaptureType`: 指定自采集的视频源类型。
- `getContentHint`: 指定自采集屏幕共享视频的内容类型。

**3. CDN 直播推流**

该版本新增 `onRtmpStreamingEvent` 回调，报告 CDN 直播推流过程中发生的事件，如未成功添加背景图或水印。

**4. 加密**

该版本新增 `enableEncryption` 方法，用于开启内置加密，并废弃原加密方法：

- `setEncryptionSecret`
- `setEncryptionMode`

与原加密方法相比，该方法新增对国密 SM4 加密模式的支持，你可以根据需要选择合适的加密模式。

**5. 通话中质量透明**

该版本进一步扩充了 `LocalAudioStats` 类、`LocalVideoStats` 类、`RemoteVideoStats` 类和 `RemoteAudioStats` 类的成员，提供更多音视频质量相关数据。

- `LocalAudioStats` 类新增 `txPacketLossRate`，表示本端到 Agora 边缘服务器的物理音频丢包率 (%)。
- `LocalVideoStats` 类新增：
  - `txPacketLossRate`: 本端到 Agora 边缘服务器的物理视频丢包率 (%)。
  - `captureFrameRate`: 本地视频采集帧率 (fps)。
- `RemoteAudioStats` 和 `RemoteVideoStats` 类中新增 `publishDuration`，表示远端音频流和视频流的累计发布时长（毫秒）。

**6. 设置音频编码属性**

为提升音频性能，该版本对音频编码码率最大值进行如下优化：

| Profile                                 | 3.1.0 版本                                           | 3.1.0 版本之前                                       |
| :-------------------------------------- | :--------------------------------------------------- | :--------------------------------------------------- |
| AUDIO_PROFILE_DEFAULT                   | <li>直播场景: 64 Kbps</li><li>通信场景: 18 Kbps</li> | <li>直播场景: 52 Kbps</li><li>通信场景: 18 Kbps</li> |
| AUDIO_PROFILE_SPEECH_STANDARD           | 18 Kbps                                              | 18 Kbps                                              |
| AUDIO_PROFILE_MUSIC_STANDARD            | 64 Kbps                                              | 48 Kbps                                              |
| AUDIO_PROFILE_MUSIC_STANDARD_STEREO     | 80 Kbps                                              | 56 Kbps                                              |
| AUDIO_PROFILE_MUSIC_HIGH_QUALITY        | 96 Kbps                                              | 128 Kbps                                             |
| AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO | 128 Kbps                                             | 192 Kbps                                             |

**7. 日志扩容**

该版本中，Agora SDK 日志文件的默认个数由 2 个增加至 5 个，单个日志文件的默认大小由 512 KB 扩大至 1024 KB。默认情况下，SDK 会生成 `agorasdk.log`、`agorasdk_1.log`、`agorasdk_2.log`、`agorasdk_3.log`、`agorasdk_4.log` 这 5 个日志文件。最新的日志永远写在 `agorasdk.log` 中。`agorasdk.log` 写满后，SDK 会从 1-4 中删除修改时间最早的一个文件，然后将 `agorasdk.log` 重命名为该文件，并建立新的 `agorasdk.log` 写入最新的日志。

**8. OPPO 耳返优化**

该版本在 OPPO 如下机型上降低了耳返延时：

- Reno4 Pro 5G
- Reno4 5G

**9. 优化弱网环境下的视频体验**

- 自该版本起，弱网环境下会自动降低视频分辨率，以进一步优化视频流畅度。
- 优化了网络状态变化过程中的视频画质，保证画质不模糊。

**10. 其他改进**

- 降低了音频延时。
- 降低了远端用户音频首帧解码时间。

#### 问题修复

该版本修复了如下问题：

- 调用 `setAudioMixingPitch` 方法时，部分参数不生效。
- 特定场景下视频画面模糊。
- 视频自采集场景下，app 偶现崩溃。

#### API 变更

**新增**

- [`onAudioPublishStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a19d2c72ed37bc3c1e8fbb9744060cec8)
- [`onVideoPublishStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a180eb7fcfd46e28b0eca70c074f58b1d)
- [`onAudioSubscribeStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a3fdd1d93b146c58e7bf69f36766b2f3a)
- [`onVideoSubscribeStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a6a8e37eb47679d0b8a49c792e031fa06)
- [`onFirstLocalAudioFramePublished`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a94c87921fc48dbd80048efc785270808)
- [`onFirstLocalVideoFramePublished`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#af06bd501878b9d594d406497fdf1db89)
- [`CreateTextureView`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ae12df01b67f756ce4abdeba4b08242e4)
- [`enableEncryption`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8d283886c17dbd2555e1f967c7faff2d)
- `LocalAudioStats` 类中新增 [`txPacketLossRate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_audio_stats.html#a3f39c69e3a02c05044603b28da879e9c)
- `LocalVideoStats` 类中新增 [`txPacketLossRate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#a5aabe8c34e6e59808808fb7e688e01d8) 和 [`captureFrameRate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#ae60a432682957ff8d4d2cddf359d84d7)
- [`RemoteAudioStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_audio_stats.html#ad56757c408074784356bbfac47f58af2) 和 [`RemoteVideoStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html#a85301bc33f0169afe6d66177d8cae9fe) 类中新增 `publishDuration`
- `IVideoSource` 类中新增 [`getCaptureType`](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1mediaio_1_1_i_video_source.html#a6e0bc3921a9c1a076a63d3ab5eeaf236) 和 [`getContentHint`](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1mediaio_1_1_i_video_source.html#a34f90e4af3735c9542ca8e4d439fe25c) 回调
- [`onRtmpStreamingEvent`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a2c26ecc40133c2bb18b30f4752edc61c)
- 错误码: [`ERR_NO_SERVER_RESOURCES(103)`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#ab0e9fe12b5357df5f03019d084183799)
- 警告码:
  - [`WARN_ADM_RECORD_IS_OCCUPIED(1033)`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#adead939e929d2a89b458ae7ece72f797)
  - [`WARN_ADM_RECORD_ABNORMAL_FREQUENCY(1021)`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#a1c0d1e891192c8a37a59cb9f32b7ba64)
  - [`WARN_ADM_PLAYOUT_ABNORMAL_FREQUENCY(1020)`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#a67dfe3691ed974e46f6f37cb696b01b3)
  - [`WARN_APM_RESIDUAL_ECHO(1053)`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#a449523bb31a7ce15f38006531244d537)

**废弃**

- `setEncryptionSecret`
- `setEncryptionMode`
- `onFirstLocalAudioFrame`

## 3.0.1.1 版

该版本于 2020 年 6 月 18 日发布。主要修复如下问题：

- Android 6 及以上且 CPU 为 x86 架构的手机出现崩溃。
- `registerVideoRenderFactory` 方法（已废弃）导致的崩溃。
- 美颜功能不生效。
- 特定场景下视频自采集不生效。

## 3.0.1 版

该版本于 2020 年 5 月 27 日发布。

#### 升级必看

**视频观测位置 (C++)**

自 v3.0.1 起，如果你想要获取 `onPreEncodeVideoFrame` 回调中的视频数据，除实现该回调外，还需要在 [`getObservedFramePosition`](./API%20Reference/cpp/v3.0.1/classagora_1_1media_1_1_i_video_frame_observer.html#ad4c174389264630ffb1b2d24c6030013) 中将 `POSITION_PRE_ENCODER (1 << 2)` 设置为观测位置。

#### 新增特性

**1. 调整音乐文件音调**

为方便调整混音时音乐文件的播放音调，该版本新增 `setAudioMixingPitch` 方法。通过设置该方法的 `pitch` 参数，你可以升高或降低音乐文件的音调。该方法仅对音乐文件音调有效，对本地人声不生效。

**2. 变声与混响**

为提高用户的音频体验，该版本在 `setLocalVoiceChanger` 和 `setLocalVoiceReverbPreset` 中分别新增以下枚举值：

- 新增了以 `VOICE_BEAUTY` 为前缀和以 `GENERAL_BEAUTY_VOICE` 为前缀的枚举值，分别实现美音或语聊美声功能。
- 新增了以 `AUDIO_REVERB_FX` 为前缀的枚举值和 `AUDIO_VIRTUAL_STEREO`，分别实现增强版混响效果和虚拟立体声效果。

你可以查看进阶功能[变声与混响](./voice_changer_android)了解使用方法和注意事项。

**3. 人脸检测**

该版本新增人脸检测功能。通过 `enableFaceDetection` 方法开启人脸检测后，SDK 会实时触发 `onFacePositionChanged` 回调，向本地用户报告检测出的一系列结果，包括人脸距设备屏幕的距离。该功能可用于提醒用户注意用眼卫生，和屏幕保持一定距离。

**4. 全屏显示视频**

为提高用户观看视频的体验，该版本在视频显示模式中新增 `RENDER_MODE_FILL` 模式。设置该模式后，视频尺寸会进行缩放和拉伸直至充满显示视图。你可以在调用以下方法设置用户视图时选择该显示模式：

- `setupLocalVideo`
- `setupRemoteVideo`
- `setLocalRenderMode`
- `setRemoteRenderMode`

**5. 自渲染远端视图多频道支持**

在多频道场景下，为方便通过 `RtcChannel` 类加入频道的用户使用视频自渲染功能，该版本在 `RtcChannel` 类新增 `setRemoteVideoRenderer` 方法。

**6. 远端音视频数据后处理多频道支持**

在多频道场景下，为方便后处理各频道的远端音视频数据，该版本新增如下 C++ 接口：

- `IAudioFrameObserver` 类中新增 [`isMultipleChannelFrameWanted`](./API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#a4b6bdf2a975588cd49c2da2b6eff5956) 和 [`onPlaybackAudioFrameBeforeMixingEx`](./API%20Reference/cpp/v3.0.1/classagora_1_1media_1_1_i_audio_frame_observer.html#ab0cf02ba307e91086df04cda4355905b)。
- `IVideoFrameObserver` 类中新增 [`isMultipleChannelFrameWanted`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#aa6bf2611907a097ec359b83f1e3ba49a) 和 [`onRenderVideoFrameEx`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#ad325db8ee3a04e667e6db3d1a84f381d)。

成功注册音频或视频观测器后，如果你将 `isMultipleChannelFrameWanted` 的返回值设为 `true`，就可以通过上述回调获取多个频道对应的音频、视频数据。在多频道场景下，我们建议你将返回值设为 `true`。

#### 改进

**设置视频观测位置 (C++)**

成功注册视频观测器后，你可以在视频处理的各节点观测并获取想要的视频数据，如本地采集的视频数据，接收的远端视频数据等。为降低设备耗能，该版本允许自定义视频观测位置。你可以通过修改 [`getObservedFramePosition`](./API%20Reference/cpp/v3.0.1/classagora_1_1media_1_1_i_video_frame_observer.html#ad4c174389264630ffb1b2d24c6030013) 的返回值，设置只观测以下某个或多个位置的视频数据：

- 本地采集的视频数据
- 接收远端发送的视频数据
- 本地编码前的视频数据

**其他改进**

- 该版本基于华为 EMUI 10 版本以上的手机，实现了耳返低延时。
- 该版本优化了通话时的音频效果。频道中多个用户同时讲话时，不会减弱任何一方的音频效果。
- 该版本降低了对设备整体 CPU 的占用。

#### 问题修复

- 修复了 `onRemoteAudioStateChanged` 回调不准、音频无声、混音、声音卡顿等问题。
- 修复了偶现的黑屏问题。
- 修复了通话无法正常结束、`onClientRoleChanged` 回调多次、偶现崩溃、上麦逻辑、加密互通等问题。

#### API 变更

**新增**

- [`setAudioMixingPitch`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a1ffa38f7445ff0ba71515c931f2f4f6a)
- 以 [`VOICE_BEAUTY`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#a6e16001b5e0f252460d584131fc11750) 为前缀、以 [`GENERAL_BEAUTY_VOICE`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#ab77b264331a44b104e5d1b333fc39ed8) 为前缀和以 [`AUDIO_REVERB_FX`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#a238965ba87ce04aaaa50c45f57c8727d) 为前缀的枚举值，以及 [`AUDIO_VIRTUAL_STEREO`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#a4488f5ef2274a3e2e0dff5721f3bb708) 枚举值
- [`enableFaceDetection`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a20ee30231265a5f898384a7974e3f2b1)
- [`onFacePositionChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a629081c0db3ecf7dfc057d5f04598c77)
- [`RENDER_MODE_FILL`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_canvas.html#a80d484794fab78276f5d55d3d95851d8)
- `RtcChannel` 中新增 [`setRemoteVideoRenderer`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_channel.html#a25538dc7eb3c2fe34e103f86c555f130)
- `RemoteAudioStats` 中新增 [`totalActiveTime`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_audio_stats.html#a18b02fb2d2af40bc0730c2c916a5729d)
- `RemoteVideoStats` 中新增 [`totalActiveTime`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html#adc903aec128b9094b5f85b9286d3486a)

## 3.0.0.2 版

该版本于 2020 年 4 月 22 日发布。

#### 新增特性

**设置区域访问限制**

该版本新增 `create` 方法，支持在创建 `RtcEngine` 实例时指定服务器的访问区域。该功能为高级设置，适用于有访问安全限制的场景。目前支持的区域有中国大陆、北美、欧洲、亚洲（中国大陆除外）和全球（默认）。

指定访问区域后，集成了 Agora SDK 的 app 在指定区域使用时，正常情况下会连接指定区域的 Agora 服务器；在非指定区域使用时，会从所在区域和指定区域的服务器地址中，择优选择服务器建立连接。

#### 问题修复

该版本修复了音频无声的问题。

#### API 变更

**新增**

[`create`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a45832a91b1051bc7641ccd8958288dba)

## 3.0.0 版

该版本于 2020 年 3 月 4 日发布。并于 2020 年 3 月 24 日修复了偶现的音频无声、混音、`onClientRoleChanged` 回调多次、崩溃等问题。

Agora 在该版本对通信场景采用了全新的系统架构，并升级了通信和直播场景下的 last mile 网络策略。在带宽不足时，新的网络策略能充分利用上下行有限带宽提升有效码率，从而增强弱网对抗能力，极大提升了弱网情况下通信和直播场景的终端用户体验。

由于通信场景采用了新的系统架构，为保证新老版本通信用户的互通兼容，我们使用了回退机制。如果频道内有老版本通信用户加入，则当前版本 (3.0.0) 的终端用户会回退成老版本通信。一旦回退，频道内所有用户都无法享受新版本带来的体验提升。因此我们强烈推荐同步升级所有终端用户到当前版本。

同时，我们对本地服务端录制进行了升级发布。为确保享受全新架构和网络策略优化带来的好处，使用本地服务端录制的客户，请务必同步升级[本地服务端录制 SDK](https://docs.agora.io/cn/Recording/release_recording?platform=Linux#300-%E7%89%88) 至 3.0.0 版本。

#### 升级必看

**1. 通信场景默认不开启视频双流**

从该版本起，Agora 在通信频道场景下，默认不开启视频[双流](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-duala%E5%8F%8C%E6%B5%81%E6%A8%A1%E5%BC%8F)。如需启用，请在成功加入频道后，调用 [`enableDualStreamMode (true)`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a645cb7d0f3a59dda27b157cf130c8c9a) 方法。在多人视频通信场景下，我们建议你开启视频双流模式。

**2. 日志默认保存路径改变**

为避免权限问题，该版本默认日志路径由 `/storage/emulated/0/<package name>/` 变更为 `/storage/emulated/0/Android/data/<package name>/files/`。

#### 新增特性

**1. 多频道管理**

为方便用户在同一时间加入多个频道，该版本新增了 [`RtcChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_channel.html) 和 [`IRtcChannelEventHandler`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_channel_event_handler.html) 类。通过创建多个 `RtcChannel` 对象，用户可以加入各 `RtcChannel` 对象对应的频道中，实现多频道功能。

加入多个频道后，用户可以同时接收多个频道的流，但只能同时在一个频道内发流。该功能适用于用户需要同时接收多个频道的流，或频繁切换频道发流的场景。详细的集成步骤和注意事项，请参考《[加入多频道](multiple_channel_android)》。

**2. 视频原始数据**

为方便开发者获取传输各阶段的视频原始数据，满足更多场景需求，该版本在 [`IVideoFrameObserver`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html) 类中新增如下 C++ 回调接口：

- [`onPreEncodeVideoFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a2be41cdde19fcc0f365d4eb14a963e1c)：获取前处理后、编码前的本地视频原始数据。该方法适用于有视频前处理需求的开发场景。
- [`getSmoothRenderingEnabled`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#aaa6c67373bb237a067318015749e8e51)：设置是否对获取的视频数据进行平滑处理。平滑处理后的视频帧，出帧时间间隔会更均匀，因此视频自渲染的体验更好。

**3. 调节本地播放的指定远端用户音量**

该版本新增 [`adjustUserPlaybackSignalVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aac9c5135996428d9a238fe8e66858268) 方法，用以调节本地用户听到的指定远端用户的音量。通话或直播过程中，你可以多次调用该方法，来调节多个远端用户在本地播放的音量，或对某个远端用户在本地播放的音量调节多次。

**4. 媒体播放器组件**

为丰富直播玩法，Agora 发布了媒体播放器组件，支持主播在直播过程中，播放本地或在线媒体资源，并同步分享给频道内所有用户。详情请参考《[媒体播放器组件发版说明](https://docs.agora.io/cn/Interactive%20Broadcast/mediaplayer_release_android?platform=Android)》。

#### 改进

**1. 音频编码属性**

为满足更高音质需求，该版本调整了直播场景下 `AUDIO_PROFILE_DEFAULT (0)` 对应的音频编码属性，详见下表：

| SDK 版本   | AUDIO_PROFILE_DEFAULT (0)                                   |
| ---------- | ----------------------------------------------------------- |
| 3.0.0      | 48 KHz 采样率，音乐编码，单声道，编码码率最大值为 52 Kbps。 |
| 3.0.0 之前 | 32 KHz 采样率，音乐编码，单声道，编码码率最大值为 44 Kbps。 |

**2. 镜像模式**

为提升视频镜像的使用体验，该版本对以下接口进行了变动：

- 视频编码镜像：在 [`VideoEncoderConfiguration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html) 结构体中，新增 `mirrorMode` 成员，方便设置本地视频编码的镜像模式，即远端看本地是否镜像。
- 视频渲染镜像：在 [`VideoCanvas`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_canvas.html) 结构体中，新增 `mirrorMode` 成员，方便你在调用 [`setupLocalVideo`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a1fa43a5ce24196e840bcb1062cadbf23) 初始化本地视图时，设置本地看本地是否镜像，以及调用 [`setupRemoteVideo`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0e9f693c9bc2ccb91554c2c7dc6b7140) 初始化远端视图时，设置本地看远端是否镜像；同时在 `setLocalRenderMode` 和 `setRemoteRenderMode` 方法中新增 `mirrorMode` 参数，支持在通话中更新本地看本地，或本地看远端的镜像模式。

**3. 质量透明**

为方便开发者获取更多通话统计信息，该版本在 [`RtcStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html) 类中新增 `gatewayRtt`、`memoryAppUsageRatio`、`memoryTotalUsageRatio` 和 `memoryAppUsageInKbytes` 成员，方便更好地监控通话的质量和通话过程中的内存变动。

**4. 其他提升**

该版本自动开启直播场景下 Native SDK 与 Web SDK 的互通，并废弃原有的 `enableWebSdkInteroperability` 方法。

#### 问题修复

- 修复了混音、音频录制、音频编码、回声等音频问题。
- 修复了水印、视频画面比例、画质模糊、视频不能全屏、屏幕共享黑边等视频问题。
- 修复了特定场景下偶现的 app 崩溃、日志文件、推流不稳定等问题。

#### API 变更

**行为变更**

- 该版本在调用 `enableLocalAudio` (false) 后，不会引起通话音量切换为媒体音量。
- 当设备连接耳机或蓝牙时，调用` setEnableSpeakerPhone` (true)，不会将语音路由切换到外放。

**新增**

- [`setLocalRenderMode`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8978be2e06307e632abee88c4824b8f6)
- [`setRemoteRenderMode`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a5a8498025206a5680ef391c4e812f45f)
- [`VideoEncoderConfiguration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html) 结构体新增 `mirrorMode` 成员
- [`VideoCanvas`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_canvas.html) 结构体新增 `channelId`、`mirrorMode` 成员
- [`AudioVolumeInfo`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_audio_volume_info.html) 结构体新增 `channelId` 成员
- [`RtcStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html) 结构体新增 `gatewayRtt`, `memoryAppUsageRatio`, `memoryTotalUsageRatio`, and `memoryAppUsageInKbytes` 成员
- [`createRtcChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a9eb0770851a8ba489564f72f9b280bca)
- [`RtcChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_channel.html) 类
- [`IRtcChannelEventHandler`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_channel_event_handler.html) 类

**废弃**

- `enableWebSdkInteroperability`
- `setLocalRenderMode¹`，使用新的 [`setLocalRenderMode`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8978be2e06307e632abee88c4824b8f6) 取代
- `setRemoteRenderMode¹`，使用新的 [`setRemoteRenderMode`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a5a8498025206a5680ef391c4e812f45f) 取代
- `setLocalVideoMirrorMode`，使用 [`setupLocalVideo`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a1fa43a5ce24196e840bcb1062cadbf23) 和 [`setupRemoteVideo`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0e9f693c9bc2ccb91554c2c7dc6b7140) 中的 `mirrorMode` 取代
- `onFirstRemoteVideoFrame`，使用 [`onRemoteVideoStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a93ebe88d2544253bf4b13faf34873131) 取代
- `onUserMuteAudio`，`onFirstRemoteAudioDecoded` 和 `onFirstRemoteAudioFrame`，使用 [`onRemoteAudioStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a24fd6b0d12214f6bc6fa7a9b6235aeff) 取代
- `onStreamPublished` 和 `onStreamUnpublished`，使用 [`onRtmpStreamingStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7b9f1a5d87480cfd6187c3da0ade3f94) 取代

## 2.9.4 版

该版本于 2020 年 2 月 17 日发布。

该版本修复了 Android 设备上的部分异常。

## 2.9.3 版

该版本于 2020 年 2 月 10 日发布。

该版本修复了如下问题：

- 通信场景下，调用 `setRemoteSubscribeFallbackOption` 方法也生效。
- 一对一通信场景下，下行音视频弱网下会回退为纯音频。
- 部分设备升级系统后，摄像头采集不到视频画面。

## 2.9.2 版

该版本于 2019 年 10 月 18 日发布。

该版本修复了部分 Android 设备上的崩溃问题。

## 2.9.1 版

该版本于 2019 年 9 月 19 日发布。新增特性与修复问题详见下文。

#### 新增特性

**1. 人声检测**

为判断本地用户是否说话，该版本在启用说话者音量提示 [enableAudioVolumeIndication](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aaec0b8db9458b45d14cdcb3003f76fbe) 方法中新增 bool 型的 `report_vad` 参数。启用该参数后，你会在 `onAudioVolumeIndication` 回调报告的 [AudioVolumeInfo](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_audio_volume_info.html) 结构体中获取本地用户的人声状态。

**2. 摄像头采集方向**
为方便用户在加入频道前选择使用前置或后置摄像头进行采集，该版本在 [CameraCapturerConfiguration](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_camera_capturer_configuration.html) 类中新增 [cameraDirection](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_camera_capturer_configuration.html#a9d3182d0003faf617125a4f9b1a12d54) 成员变量。你可以通过 `CAMERA_FRONT(1)` 或 `CAMERA_REAR(0)` 选择使用前置或后置摄像头。

**3. RGBA 视频原始数据**
该版本新增支持 RGBA 格式的视频原始数据。你可以通过新增的 C++ 接口 [getVideoFormatPreference](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a440e2a33140c25dfd047d1b8f7239369)，设置想要获取的视频原始数据的格式。

同时为提高开发体验，Agora 支持对 RGBA 格式的视频原始数据分别通过 C++ 接口 [getRotationApplied](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#afd5bb439a9951a83f08d8c0a81468dcb) 和 [getMirrorApplied](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#afc5cce81bf1c008e9335a0423ca45991) 接口进行旋转和镜像处理。

**4. 删除指定事件句柄**
在特定场景下，开发者不想再接收某些事件的回调。该版本新增 [removeHandler](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a5e807ee4302756e6912a4fd1ed7a0db3) 方法，你可以调用该方法删除不再需要的事件句柄。

#### 改进

**1. 直播水印**
为提高直播水印的用户体验，解决视频方向模式为 ADAPTIVE 时，水印位置和方向可能和预期不符的问题，该版本废弃了原有的 `addVideoWatermark` 接口，并使用一个新的同名接口进行取代。同名接口下，Agora 使用 [WatermarkOptions](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_watermark_options.html) 类对水印进行设置，其中：

- `visibleInPreview` 成员设置本地预览是否能看见水印。
- `positionInLandscapeMode`/`positionInPortraitMode` 成员设置视频编码横屏/竖屏模式时的水印坐标。

同时，该版本对水印功能的性能进行了优化。和之前版本相比，该功能的 CPU 占用降低了 5% - 20%。

**2. 设置客户端录音采样率**
为方便用户设置客户端录音的采样率，该版本废弃了原有的 `startAudioRecording` 方法，并使用新的同名方法进行取代。新的方法下，录音采样率可设为 16、32、44.1 或 48 kHz。原方法仅支持固定的 32 kHz 采样率，该版本继续保留原方法但我们不推荐使用。

**3. 错误码梳理**
为提高用户体验，该版本对各平台的错误码 Error Code 进行了梳理。其中 Java 平台的 ErrorCode 类中，补齐如下错误码：

- `ERR_ALREADY_IN_USE(19)`
- `ERR_WATERMARK_PATH(125)`
- `ERR_INVALID_USER_ACCOUNT(134)`
- `ERR_AUDIO_BT_SCO_FAILED(1030)`
- `ERR_ADM_NO_RECORDING_DEVICE(1359)`
- `ERR_VCM_UNKNOWN_ERROR(1600)`
- `ERR_VCM_ENCODER_INIT_ERROR(1601)`
- `ERR_VCM_ENCODER_ENCODE_ERROR(1602)`
- `ERR_VCM_ENCODER_SET_ERROR(1603)`

各错误码的详细描述及排查办法，详见 [Error Codes](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_error_code.html)。

#### 问题修复

**音频**

- 通信场景下，设备连接蓝牙后进行通话。退出通话后使用 YouTube 蓝牙无声。
- 通信场景下，设备连接蓝牙时，调用 `setEnableSpeakerphone` 方法后行为与预期不符。
- 加入频道后，语音路由异常。
- 使用 Push 方式实现视频自采集时，app 崩溃。
- 偶现音频卡顿。
- 关掉蓝牙耳机后，音频不走外放，而走听筒。
- 进入频道后偶现回声。
- 直播场景下，特定场景偶现杂音。
- Android 10 设备上调用 `startAudioMixing` 方法播放在线音乐 URL 失败。

**其他**

- OpenSSL 版本过低。

#### API 变更

**新增**

- [startAudioRecording](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ac2ad403a7a75617316673f251615ef92)
- [addVideoWatermark](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a63d94cda85b76e77b9016bbdac04a32d)
- [getVideoFormatPreference](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a440e2a33140c25dfd047d1b8f7239369)
- [getRotationApplied](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#afd5bb439a9951a83f08d8c0a81468dcb)
- [getMirrorApplied](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#afc5cce81bf1c008e9335a0423ca45991)
- [removeHandler](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a5e807ee4302756e6912a4fd1ed7a0db3)
- [enableAudioVolumeIndication](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aaec0b8db9458b45d14cdcb3003f76fbe)，新增 `report_vad` 参数
- [AudioVolumeInfo](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_audio_volume_info.html) 类，新增 `vad` 成员
- [CameraCapturerConfiguration](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_camera_capturer_configuration.html) 类，新增 `cameraDirection` 成员

**废弃**

- `startAudioRecording`
- `addVideoWatermark`

## 2.9.0 版

该版本于 2019 年 8 月 16 日发布。新增特性与修复问题详见下文。

#### 升级必看

**1. RTMP 推流**

该版本起，Agora 删除如下接口：

- `configPublisher`
- `setVideoCompositingLayout`
- `clearVideoCompositingLayout`

如果你的 App 使用上述接口实现 RTMP 推流功能，请确保将 Native SDK 升级至最新版本，并改用如下接口实现推流：

- [`setLiveTranscoding`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a3cb9804ae71819038022d7575834b88c)
- [`addPublishStreamUrl`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a4445b4ca9509cc4e2966b6d308a8f08f)
- [`removePublishStreamUrl`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a87b3f2f17bce8f4cc42b3ee6312d30d4)
- [`onRtmpStreamingStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7b9f1a5d87480cfd6187c3da0ade3f94)

新的推流实现方法，请参考[推流到 CDN](cdn_streaming_android)。

**2. 远端视频状态**

为方便用户了解远端视频状态，该版本删除了原有的 `onRemoteVideoStateChanged` 接口，并使用一个新的同名接口进行取代。新接口下， `state` 参数扩展为 STOPPED(0)、STARTING(1)、DECODING(2)、FROZEN(3) 和 FAILED(4)。同时，新接口还增加了 `reason` 参数，用以报告远端视频状态发生改变的原因。因此，如果你将 Native SDK 升级至该版本，请确保重新实现 [`onRemoteVideoStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a93ebe88d2544253bf4b13faf34873131) 接口。

同时，扩展后的 `state` 参数和新增的 `reason` 参数搭配使用，可以涵盖大部分远端视频状态，因此该版本废弃了如下接口。你可以继续使用这些接口，但我们不再推荐。详细的取代方案，请参考 API 文档：

- [`onUserEnableVideo`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#af87247218ec1ef398a9478672ad4dd49)
- [`onUserEnableLocalVideo`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a2640b0eef8b7f1b105c485b4f1c9d8b5)
- [`onFirstRemoteVideoDecoded`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ac7144e0124c3d8f75e0366b0246fbe3b)

<div class="alert note">该回调的触发时机与老的 <code>onRemoteVideoStateChanged</code> 回调不同。新接口只有在远端视频流状态发生改变时，才会触发。</div>

**3. 关闭/开启本地音频采集**

为提高通信场景下，本地用户关闭麦克风后听到的音质，该版本在 `enableLocalAudio`(true) 后，将系统音量修改为媒体音量。调用 `enableLocalAudio`(false) 后，系统音量自动切换为通话音量。

#### 新增特性

**1. 快速切换频道**

为方便直播频道中的观众用户快速切换到其他频道，该版本新增 [`switchChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a72f13225defc1b14dfb29820a0495da2) 方法。和先调 `leaveChannel`，再调 `joinChannel` 相比，该方法能实现更快的频道切换。调用 `switchChannel` 方法切换到其他直播频道后，本地会先收到离开原频道的回调 `onLeaveChannel`，再收到成功加入新频道的回调 `onJoinChannelSuccess`。

**2. 跨频道媒体流转发**

跨频道媒体流转发，指将主播的媒体流转发至其他直播频道，实现主播跨频道与其他主播实时互动的场景。该版本新增如下接口，通过将源频道中的媒体流转发至目标频道，实现跨直播间连麦功能：

- [`startChannelMediaRelay`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6f09ba685f8ab01d7dc06173286950f6)
- [`updateChannelMediaRelay`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#abd40d706379d27cf617376a504f394bd)
- [`stopChannelMediaRelay`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0f9f19e48c21190dd4e697dec632c328)

在跨频道媒体流转发过程中，SDK 会通过 [`onChannelMediaRelayStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a89fd95b3536e8e6afd5f001926162f66) 和 [`onChannelMediaRelayEvent`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a6fe2367e9ea61e48a4cc3b373d198b54) 回调报告媒体流转发的状态和事件。

该场景的实现方法、API 调用时序、示例代码及开发注意事项，请参考[跨直播间连麦](media_relay_android)。

**3. 本地及远端音频状态**

为方便用户了解本地及远端的音频状态，该版本新增 [`onLocalAudioStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a59946a989f87c737899e2284539adf09) 和 [`onRemoteAudioStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a24fd6b0d12214f6bc6fa7a9b6235aeff) 回调。新的回调下，本地及远端音频有如下状态：

- 本地音频：STOPPED(0)、RECORDING(1)、ENCODING(2) 和 FAILED(3)。状态为 FAILED(3) 时，你可以通过 `error` 参数中返回的错误码定位及排查问题。
- 远端音频：STOPPED(0)、STARTING(1)、DECODING(2)、FROZEN(3) 和 FAILED(4)。你可以在 `reason` 参数中了解引起远端音频状态发生改变的原因。

**4. 本地音频数据**

为方便更好地了解通话质量，获取更多质量相关数据，该版本新增 [`onLocalAudioStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aeba2aa3fc29404fc6f25bff5c00bfdf9) 回调，通过 `numChannels`、`sentSampleRate`、`sentBitrate` 参数报告本地音频统计信息。

**5. 远端音频帧拉取**

为提升音频播放体验，该版本新增如下接口，支持使用拉取的方式获取远端音频数据。App 可以对拉取到的原始音频数据进行处理后再渲染，获取想要的音频效果。

- [`setExternalAudioSink`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a270c0607d443790e92cdbd0d45ba1732)
- [`pullPlaybackAudioFrame`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ae15064944870692e9a0a59fdc87654c4)

该方法和 [`onPlaybackFrame`](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#a3781dd30d34a0634140872a9dd131488) 回调相比，区别在于：

- `onPlaybackFrame`：SDK 每 10 毫秒通过回调将音频数据传输给 App。如果 App 处理延时，可能会导致音频播放抖动。
- `pullPlaybackAudioFrame`：App 主动拉取音频数据。通过设置音频数据，SDK 可以调整缓存，帮助 App 处理延时，从而有效避免音频播放抖动。

#### 改进

**1. 通话中质量透明**

该版本进一步扩充了 `RtcStats`、`LocalVideoStats` 和 `RemoteVideoStats` 类的成员。各类新增成员如下：

- [`RtcStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html) 类：累计发送音频/视频字节数及累计接收音频/视频字节数
- [`LocalVideoStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html) 类：本地视频的编码码率、宽高、发送帧数及编码类型
- [`RemoteVideoStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html) 类：远端视频在网络对抗后的丢包率

**2. 直播视频质量提升**

该版本改善了弱网条件下直播视频卡顿问题，提升了画面清晰度，优化了网络极端丢包情况下的直播画面流畅度。

**3. 其他改进**

- 优化了耳返延迟。
- 优化了 Game Streaming 模式下的音频质量。
- 优化了通信场景下用户关闭麦克风后听到的音质。

#### 问题修复

**音频**

- 修复了与 Web 互通时听声辨位过程中出现的声音失真的问题。
- 修复了主播下主播将耳返音量设置为 0 后，远端听不到主播声音的问题。
- 修复了特殊场景下调用 `startAudioMixing` 播放音乐文件失败的问题。
- 修复了特殊机型上语音路由无法切换到蓝牙的问题。
- 修复了使用音频裸数据功能时的崩溃问题。
- 修复了断开蓝牙设备后，语音路由与默认设置不符的问题。

**视频**

- 修复了直播下视频自采集时偶现的崩溃问题。
- 修复了特殊场景下远端观众看主播画面黑屏的问题。

**其他**

- 修复了偶现的旁路推流串流的问题。
- 修复了特殊机型上偶现的加入频道后崩溃的问题。

#### API 变更

为提升用户体验，Agora SDK 在该版本中对 API 进行了如下变动：

**新增**

- [`setExternalAudioSink`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a270c0607d443790e92cdbd0d45ba1732)
- [`pullPlaybackAudioFrame`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ae15064944870692e9a0a59fdc87654c4)
- [`onLocalAudioStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a59946a989f87c737899e2284539adf09)
- [`onRemoteAudioStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a24fd6b0d12214f6bc6fa7a9b6235aeff)
- [`onRemoteVideoStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a93ebe88d2544253bf4b13faf34873131)
- [`onLocalAudioStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aeba2aa3fc29404fc6f25bff5c00bfdf9)
- [`switchChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a72f13225defc1b14dfb29820a0495da2)
- [`startChannelMediaRelay`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6f09ba685f8ab01d7dc06173286950f6)
- [`updateChannelMediaRelay`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#abd40d706379d27cf617376a504f394bd)
- [`stopChannelMediaRelay`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0f9f19e48c21190dd4e697dec632c328)
- [`onChannelMediaRelayStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a89fd95b3536e8e6afd5f001926162f66)
- [`onChannelMediaRelayEvent`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a6fe2367e9ea61e48a4cc3b373d198b54)
- [`RtcStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html) 类新增 `txAudioBytes`，`txVideoBytes`，`rxAudioBytes` 和 `rxVideoBytes` 成员
- [`LocalVideoStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html) 类新增 `encodedBitrate`，`encodedFrameWidth`，`encodedFrameHeight`，`encodedFrameCount` 和 `codedType` 成员
- [`RemoteVideoStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html) 类新增 `packetLossRate` 成员

**废弃**

- `onMicrophoneEnabled`，请改用 [`onLocalAudioStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aeba2aa3fc29404fc6f25bff5c00bfdf9) 的 LOCAL_AUDIO_STREAM_STATE_CHANGED(0) 或 LOCAL_AUDIO_STREAM_STATE_RECORDING(1)。
- `onRemoteAudioTransportStats`，请改用 [`onRemoteAudioStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a9eaf8021d6f0c97d056e400b50e02d54)。
- `onRemoteVideoTransportStats`，请改用 [`onRemoteVideoStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#abb7af6e2827bbd03c6ab8338a0f616ca)。

- `onUserEnableVideo`，请改用 [`onRemoteVideoStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a93ebe88d2544253bf4b13faf34873131) 的如下参数搭配：

  - REMOTE_VIDEO_STATE_STOPPED(0) 和 REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED(5)。
  - REMOTE_VIDEO_STATE_DECODING(2) 和 REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED(6)。

- `onUserEnableLocalVideo`，请改用 [`onRemoteVideoStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a93ebe88d2544253bf4b13faf34873131) 的如下参数搭配：

  - REMOTE_VIDEO_STATE_STOPPED(0) 和 REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED(5)。
  - REMOTE_VIDEO_STATE_DECODING(2) 和 REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED(6)。

- `onFirstRemoteVideoDecoded`，请改用 [`onRemoteVideoStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a93ebe88d2544253bf4b13faf34873131) 的 REMOTE_VIDEO_STATE_STARTING(1) 或 REMOTE_VIDEO_STATE_DECODING(2)。

**删除**

- `configPublisher`
- `setVideoCompositingLayout`
- `clearVideoCompositingLayout`
- `onRemoteVideoStateChanged`

## 2.8.2 版

该版本于 2019 年 8 月 1 日发布。修复了与 Web SDK 的互通问题。

## 2.8.1 版

该版本于 2019 年 7 月 20 日发布。新增特性详见下文。

#### 新增特性

- 支持 x86-64 位系统。
- 支持 Android Q 系统。

## 2.8.0 版

该版本于 2019 年 7 月 8 日发布。新增特性与修复问题列表详见下文。

#### 新增特性

**1. 全平台支持 String 型的用户 ID**

很多 App 使用 String 类型的用户 ID。为降低开发成本，Agora 新增支持 String 型的 User account，方便用户通过如下接口直接使用 App 账号加入 Agora 频道：

- [registerLocalUserAccount](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa37ea6307e4d1513c0031084c16c9acb)
- [joinChannelWithUserAccount](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a310dbe072dcaec3892c4817cafd0dd88)

对于其他接口，Agora 沿用 Int 型的 UID。Agora Engine 会维护 UID 和 User account 映射表，你可以随时通过 String user account 获取 UID，或者通过 UID 获取 String user account，无需自己维护映射表。

为保证通信质量，频道内所有用户需使用同一数据类型的用户 ID，即频道内的所有用户 ID 应同为 Int 型或同为 String 型。

**Note**：

- 同一频道内，Int 型的 User ID 和 String 型的 User account 不可混用。目前支持 String 型 User account 的 SDK 如下：

  - Native SDK：v2.8.0 及之后版本
  - Web SDK：v2.5.0 及之后版本

如果你的频道内有不支持 String 型 User account 的用户，则只能使用 Int 型的 User ID。

- 如果你使用该版本的 Native SDK 将用户 ID 切换至 String 型 User account，请确保所有终端用户同步升级。
- 如果使用 String 型的 User account，请确保你的服务端用户生成 Token 的脚本已升级至最新版本。如果使用 String 型 User account 加入频道，请确保使用该 User account 或其对应的 Int 型 UID 来生成 Token。你可以调用 `getUserInfoByUserAccount` 来获取 User account 所对应的 UID。

**2. 音视频卡顿回调**

为监控通话过程中的音视频传输质量，方便开发者客观体验通信质量，该版本在远端音频统计数据 [RemoteAudioStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_audio_stats.html) 类和远端视频统计数据 [RemoteVideoStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html) 类中新增 `totalFrozenTime` 和 `frozenRate` 成员，报告远端用户在加入频道后发生音视频的卡顿时长及卡顿率。

同时，该版本在 [RemoteAudioStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_audio_stats.html) 类中还新增 `numChannels`、`receivedSampleRate` 和 `receivedBitrate` 成员。

#### 改进

为方便开发者统计掉线率，该版本在 [onConnectionStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a31b2974a574ec45e62bb768e17d1f49e) 回调的 `reason` 参数中添加 `CONNECTION_CHANGED_KEEP_ALIVE_TIMEOUT(14)` 成员，表示 SDK 与服务器连接保活超时，引起 SDK 连接状态发生改变。

#### 修复问题

**音频**

- 修复了特定场景下偶现的音频卡顿的问题。

**视频**

- 修复了停止接收视频流后再恢复接收，视频流变为小流，且恢复为大流时间过慢的问题。

**其他**

- 修复了指定的 Log 输出文件夹不存在时，没有生成日志文件，且默认日志文件中断的问题。

#### API 变更

为提升用户体验，Agora 在 v2.8.0 版本中对 API 进行了如下变动：

**新增**

- [registerLocalUserAccount](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa37ea6307e4d1513c0031084c16c9acb)
- [joinChannelWithUserAccount](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a310dbe072dcaec3892c4817cafd0dd88)
- [getUserInfoByUid](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a9a787b8d0784e196b08f6d0ae26ea19c)
- [getUserInfoByUserAccount](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#afd4119e2d9cc360a2b99eef56f74ae22)
- [onLocalUserRegistered](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aca1987909703d84c912e2f1e7f64fb0b)
- [onUserInfoUpdated](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aa3e9ead25f7999272d5700c427b2cb3d)
- [RemoteAudioStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_audio_stats.html) 类中新增 `numChannels`，`receivedSampleRate`，`receivedBitrate`，`totalFrozenTime` 和 `frozenRate` 成员
- [RemoteVideoStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html) 类中新增 `totalFrozenTime` 和 `frozenRate` 成员

**废弃**

- [LiveTranscoding](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding.html) 类中的 `lowLatency` 成员

## 2.4.1 版

该版本于 2019 年 6 月 12 日发布。新增特性、功能改进与修复问题列表详见下文。

#### 升级必看

如下内容涉及 SDK 的行为变更。如果你是由之前版本的 SDK 升级至该版本，升级前请务必阅读。

**1. RTMP 推流**

为提高推流服务的易用性，该版本对推流接口的参数设置进行了如下限制：

| 类/接口                                                                                                                        | 参数限制                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [LiveTranscoding](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding.html) 类                         | <li>[videoFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding.html#a514340a98a537fdc4f91003aed2068a6)：设置转码推流的帧率，单位为 fps，取值范围为 [0, 30]，默认值为 15。如果设值超过 30，Agora 服务端会自动调整为 30<li>[videoBitrate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding.html#a514340a98a537fdc4f91003aed2068a6)：设置转码推流的码率，单位为 Kbps，默认值为 400。用户可以根据 [Video Profile 参考表](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a4b090cd0e9f6d98bcf89cb1c4c2066e8)中的码率值进行设置。如果设置的码率超出合理范围，服务端会在合理区间内对码率值进行自适应<li>[videoCodecProfile](./API%20Reference/java/enumio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding_1_1_video_codec_profile_type.html)：设置转码推流的视频编码规格，可设为 **BASELINE**、**MAIN** 或 **HIGH**。若设为其他值，服务端会改为默认值 **HIGH**<li>[width](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding.html#a514340a98a537fdc4f91003aed2068a6) 和 [height](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding.html#a80960c1a972e9b3851fd16d921f8a75c)：设置转码推流的视频分辨率。**width x height** 的最小值不低于 **16 x 16**</li> |
| [AgoraImage](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_agora_image.html) 类                                  | `url`：字符长度不得超过 **1024** 字节                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| [addPublishStreamUrl](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a4445b4ca9509cc4e2966b6d308a8f08f)    | `url`：字符长度不得超过 **1024** 字节                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| [removePublishStreamUrl](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a4445b4ca9509cc4e2966b6d308a8f08f) | `url`：字符长度不得超过 **1024** 字节                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |

同时，该版本在 `LiveTranscoding` 类中新增 [audioCodecProfile](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding.html#ac7d4a839af2994e68d8f14544d323ae9) 参数，支持设置音频编码的规格。默认规格为 LC-AAC。

此外，该版本还对 [onStreamPublished](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7b9f1a5d87480cfd6187c3da0ade3f94) 方法的 `error` 参数新增了五个错误码，方便快速定位与排查问题。

**2、RemoteVideoStats 类参数更名**

为更精准地表达远端视频流的统计信息，该版本将 [RemoteVideoStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html) 类中的 `receivedFrameRate` 参数 更名为 [rendererOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html#aa09441cb1b9a0f4318cd59b0ca5b3ffb)。

#### 新增特性

**1、添加媒体附属信息**

常见的直播场景中，主播给观众分发商品链接、优惠券、在线答题等，能构建更为丰富的直播互动方式。为满足该部分社交类直播 App 开发者的需求，该版本新增 [registerMediaMetadataObserver](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aeb1a5691094a10cb047d106d6c6c32b7) 接口以及 [IMediaMetadataObserver](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_metadata_observer.html) 类，目前允许主播在发出的视频帧中添加 Metadata，发送媒体附属信息。

**2、本地视频状态回调**

为方便开发者了解本地视频状态，该版本新增 [onLocalVideoStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aface271c0606ab99bb08a0d00267306c) 回调。该回调下，本地视频有 `STOPPED`、`CAPTURING`、`ENCODING` 和 `FAILED` 四种状态。当本地视频状态为 FAILED 时，用户可以参考该回调 `error` 参数返回的错误码进行问题排查。该回调能帮助开发者辨别本地视频故障是由采集还是编码引起的。原有的 `onCameraReady` 和 `onVideoStopped` 回调在该版本废弃，我们不再推荐。

**3、推流状态回调**

为方便推流用户了解当前的推流状态，并在推流出错时了解原因排查问题，该版本新增 [onRtmpStreamingStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7b9f1a5d87480cfd6187c3da0ade3f94) 回调。该回调下，推流有 `IDLE`、`CONNECTING`、`RUNNING`、`RECOVERING` 和 `FAILURE` 五种状态。当推流状态为 `FAILURE` 时，用户可以参考该回调 `errCode` 参数返回的错误码进行问题排查。原有的 `onStreamPublished` 和 `onStreamUnpublished` 回调仍可以使用，但我们不再推荐。

**4、网络连接失败原因梳理**

为方便开发者更好地排查网络连接相关故障，该版本梳理并整合了网络连接相关的错误码，在原有 [onConnectionStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a31b2974a574ec45e62bb768e17d1f49e) 回调的 `reason` 参数中新增八个导致网络连接失败的原因。新增后，只要网络连接发生错误，SDK 都会返回该回调。同时该版本废弃了原有的警告码 `WARN_LOOK_UP_CHANNEL_REJECTED(105)` 和错误码 `ERR_TOKEN_EXPIRED(109)`、`ERR_INVALID_TOKEN(110)`。

**5、本地网络连接类型回调**

为方便用户了解本地网络的连接类型，该版本新增 [onNetworkTypeChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a75b014a87d0ead6cd4fa519a630f6f90) 回调。该回调下，本地网络连接有 `UNKNOWN`、`DISCONNECTED`、`LAN`、`WIFI`、`2G`、`3G`、`4G` 七种类型。当网络连接短暂中断时，该回调能帮助开发者辨别引起中断的原因是网络切换还是网络条件不好。

**6、获取播放伴奏音量**

为方便开发者获取伴奏的播放音量，排查音量相关问题，该版本新增 [getAudioMixingPlayoutVolume](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6eef6e4d3d148c25993376f93ebbb8e9) 和 [getAudioMixingPublishVolume](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a962819abd0e5458b89cefb756bb9e631) 方法，用以分别获取音乐文件在本地和远端的播放音量。

**7、精确回调远端音频首帧解码**

为更精准地获取远端用户的出声时间，该版本新增 [onFirstRemoteAudioDecoded](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a0fcac6cafae63e4ef453ddd041e80f8a) 回调，用以向 App 层报告 SDK 已完成远端音频首帧解码。在远端用户加入频道后首次发送音频，或远端用户 15 秒不发音频后再次发送时，该回调均会被触发。该回调与 `onFirstRemoteAudioFrame` 的区别在于，`onFirstRemoteAudioFrame` 在收到首个音频包时触发，先于 `onFirstRemoteAudioDecoded`。

#### 改进

**1、在线音效叠加**

为提高用户体验，构造丰富有趣的实时音视频场景，该版本新增支持同时播放多个**在线**音效文件。开发者可以通过多次调用 [playEffect](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_effect_manager.html#a6fd330db3e3e5735f7f8d5c36bc3fea1) 方法，传入不同的在线音效文件的 URL，实现音效叠加。

**2、质量透明**

- 该版本在通话相关的统计信息 [RtcStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html) 类中，新增 [txPacketLossRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html#a6b0c3798427c6bf07b829896e29ace5e) 和 [rxPacketLossRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html#a72df02822bfcc37dfcdb543fd2ba46af) 参数，分别返回本地客户端到服务器和服务器到本地客户端的丢包率。
- 该版本对 `LocalVideoStats` 和 `RemoteVideoStats` 类作了如下变动，方便用户更精准地获取本地和远端视频流的统计信息：

  - [LocalVideoStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html)：新增 [encoderOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#af6350acef5578bf0501a234fc36d86a3) 和 [rendererOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#aa754035a384b502a45c6fed6f17038da) 参数
  - [RemoteVideoStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html)：新增 [decoderOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html#aafc03c6a890c36dc9810537c47ce0cd9) 参数，并将原有的 `receivedFrameRate` 参数更名为 [rendererOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html#aa09441cb1b9a0f4318cd59b0ca5b3ffb)

**3、美颜优化**

为提升美颜效果，该版本结合主观测试的结果，对美颜选项 [BeautyOptions](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_beauty_options.html) 类中的各参数添加了默认值；同时，该版本优化了美颜算法的性能。声网实验室报告显示，优化后的算法下，GPU 消耗 和 CPU 消耗均有不同程度的下降，功耗优化约 30%。

**4、其他改进**

- 优化了 AudioScenario 为 [GAME_STREAMING](./API%20Reference/java/enumio_1_1agora_1_1rtc_1_1_constants_1_1_audio_scenario.html#aedcb78447298f4794ba8df7a72d71909) 时的音质效果
- 优化了部分场景下语音和视频的延时
- SDK 包大小降低约 0.5 M
- 提高了用户修改视频属性的码率后，网络质量打分的准确性
- 默认启用音频质量通知回调。开发者无需调用 `enableAudioQualityIndication` 方法，也可以收到 [onRemoteAudioStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a9eaf8021d6f0c97d056e400b50e02d54) 回调
- 提升了视频服务的稳定性
- 提升了推流服务的稳定性

#### 问题修复

**音频**

- 修复了部分设备上插耳机后音频仍走外放的问题
- 修复了单主播模式下调用 `startAudioMixing` 播放伴奏时，音频无法通过蓝牙播放的问题
- 修复了直播场景下偶现的播放伴奏异常的问题

**视频**

- 修复了特殊场景下观众看到主播画面为黑屏的问题

**其他**

- 修复了用户退出频道后仍然收到 `onNetworkQuality` 回调的问题
- 修复了偶现的崩溃问题，提升了系统稳定性
- 修复了个别手机上出现的调用 `joinChannel` 后 App 闪退的问题

#### API 变更

为提升用户体验，Agora 在 v2.4.1 版本中对 API 进行了如下变动：

**全平台 C++ 接口行为一致**

从该版本起，Native SDK 保证了各平台 C++ 接口的行为一致性，方便用户通过统一的 C++ 接口，在各平台保持业务逻辑一致。同时在 C++ 头文件的 `IRtcEngine` 类中实现了 `RtcEngineParameters` 类下的所有方法。各接口的适用范围及使用注意事项详见 [Agora C++ API Reference for All Platforms 首页](./API%20Reference/cpp/index.html)。

**新增**

- [getAudioMixingPlayoutVolume](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6eef6e4d3d148c25993376f93ebbb8e9)
- [getAudioMixingPublishVolume](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a962819abd0e5458b89cefb756bb9e631)
- [onFirstRemoteAudioDecoded](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a0fcac6cafae63e4ef453ddd041e80f8a)
- [onLocalVideoStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aface271c0606ab99bb08a0d00267306c)
- [onNetworkTypeChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a75b014a87d0ead6cd4fa519a630f6f90)
- [onRtmpStreamingStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7b9f1a5d87480cfd6187c3da0ade3f94)
- [registerMediaMetadataObserver](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aeb1a5691094a10cb047d106d6c6c32b7)
- [IMetadataObserver](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_metadata_observer.html) 类
- `LiveTranscoding` 类新增参数 [audioCodecProfile](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding.html#ac7d4a839af2994e68d8f14544d323ae9)
- `RtcStats` 类新增参数 [txPacketLossRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html#a6b0c3798427c6bf07b829896e29ace5e) 和 [rxPacketLossRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html#a72df02822bfcc37dfcdb543fd2ba46af)
- `LocalVideoStats` 类新增参数 [encoderOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#af6350acef5578bf0501a234fc36d86a3) 和 [rendererOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#aa754035a384b502a45c6fed6f17038da)
- `RemoteVideoStats` 类新增参数 [decoderOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html#aafc03c6a890c36dc9810537c47ce0cd9) 和 [rendererOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html#aa09441cb1b9a0f4318cd59b0ca5b3ffb)（替换 `receivedFrameRate`）

**废弃**

- `enableAudioQualityIndication`
- `onCameraReady`，请改用 [onLocalVideoStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aface271c0606ab99bb08a0d00267306c) 回调中的 LOCAL_VIDEO_STREAM_STATE_CAPTURING(1)
- `onVideoStopped`，请改用 [onLocalVideoStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aface271c0606ab99bb08a0d00267306c) 回调中的 LOCAL_VIDEO_STREAM_STATE_STOPPED(0)
- 警告码 `WARN_LOOKUP_CHANNEL_REJECTED(105)`，请改用 [onConnectionStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a31b2974a574ec45e62bb768e17d1f49e) 回调中的 CONNECTION_CHANGED_REJECTED_BY_SERVER(10)
- 错误码 `ERR_TOKEN_EXPIRED(109)`，请改用 [onConnectionStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a31b2974a574ec45e62bb768e17d1f49e) 回调中的 CONNECTION_CHANGED_TOKEN_EXPIRED(9)
- 错误码 `ERR_INVALID_TOKEN(110)`，请改用 [onConnectionStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a31b2974a574ec45e62bb768e17d1f49e) 回调中的 CONNECTION_CHANGED_INVALID_TOKEN(8)
- 错误码 `ERR_START_CAMERA(1003)`，请改用 [onLocalVideoStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aface271c0606ab99bb08a0d00267306c) 回调中的 LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE(4)

## 2.4.0 版及之前

**2.4.0 版**

该版本于 2019 年 4 月 1 日发布。新增特性、功能改进与修复问题列表详见下文。

#### 新增特性

##### 1. 美颜

常见的视频社交、在线教育和连麦直播等场景中，用户普遍希望有基础的美颜功能。该版本新增接口 [`setBeautyEffectOptions`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa9327de4fb0c29f840b1e68ca2e83fc6)，用户可以调用该接口设置对比度、亮度、平滑度等参数，达到美白、磨皮、红润肤色等美颜效果。详情请参考[美颜](image_enhancement_android)。

##### 2. 变声和混响

在语音聊天室场景中添加变声和混响效果，能有效增强社交的趣味性。该版本在原有音效设置接口的基础上，新增 [`setLocalVoiceChanger`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ade6883c7878b7a596d5b2563462597dd) 和 [`setLocalVoiceReverbPreset`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a10dd25bc8e129512cd6727133b7fc42f) 方法，开发者无需手动设置音效参数，直接选择想要的本地语音变声或混响效果。详情请参考[变声与混响](voice_changer_android)。

##### 3. 听声辨位

该版本新增 [`enableSoundPositionIndication`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aaeb3e1df5d2cb091bd2e9c41f156d3c0) 和 [`setRemoteVoicePosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a7d851c2cabde18c2438c1ebe8bf763de) 方法，支持本地用户听声辨位。用户需要在加入频道前调用 [`enableSoundPositionIndication`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aaeb3e1df5d2cb091bd2e9c41f156d3c0) 开启远端用户的语音立体声，然后在 [`setRemoteVoicePosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a7d851c2cabde18c2438c1ebe8bf763de) 中设置远端用户声音出现的位置，通过左右耳听到的声音差异，对远端用户的声音产生方位感。在多人在线游戏场景，如射击游戏中，该功能可以增加游戏角色的方位感，模拟真实场景。

##### 4. 通话前 Last-mile 网络探测

在通话前进行 Last-mile 网络探测，可以有效帮助本地用户判断和预测上行网络质量是否良好。该版本新增通话前 Last-mile 网络探测接口 [`startLastmileProbeTest`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a81c6541685b1c4437d9779a095a0f871)、[`stopLastmileProbeTest`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ae21243b8da8bda9ee5f3a00621cbf959) 及 [`onLastmileProbeResult`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ad74a9120325bfeccdec4af4611110281)，向用户反馈开始通话前上下行网络的带宽、丢包、网络抖动和往返时延数据。

##### 5. 设置用户媒体流优先级

该版本新增接口 [`setRemoteUserPriority`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ad4705f9e56f0cf7e0a3e9cbd09ec8f61) 用于设置远端用户媒体流的优先级。该方法可以与 [`setRemoteSubscribeFallbackOption`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af64301ea1788dad0561aa678f3fe6ad3) 搭配使用。如果开启了订阅流回退选项，弱网下 SDK 会优先保证高优先级用户收到的流的质量。

##### 6. 音乐文件播放状态

该版本为播放音乐文件新增回调 [`onAudioMixingStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aee0aa9286a39654312b162750713e986)，方便用户获知音乐文件的播放状态（成功/失败），以及播放出错的原因。同时新增一个警告码 701，当播放音乐文件时，本地音乐文件不存在、文件格式不支持或无法访问在线音乐文件 URL 时，均会触发该警告码。

##### 7. 设置日志文件大小

Agora SDK 有 2 个日志文件，每个文件默认大小为 512 KB。为解决该大小无法满足部分用户需求的问题，该版本新增接口 [`setLogFileSize`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a50fd37c6f5b8fc144b18ed4620aee6fc)，用于设置 SDK 输出的日志文件大小。

##### 8. 云代理服务

支持使用云代理服务，方便部署企业防火墙的用户正常使用 Agora 的服务，详见[使用云代理服务](./cloudproxy_native?platform=Android)。

#### 功能改进

##### 1. 质量测试与透明

- 该版本在原有的 [`startEchoTest`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a712bb50be350186d097f4deed8e1aa37) 中新增参数 `intervalInSeconds`，用于设置返回测试结果的时间间隔。
- 该版本在本地视频流统计信息 [`LocalVideoStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html) 类中新增 [`targetBitrate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#a4e5c046867a773a74096663bd894e843)，[`targetFrameRate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#a01b15bb718064ed086edbafcd1678c9a)，[`qualityAdaptIndication`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#a7a93886b530e5f9ed2fec22ca9d3f5c0) 三个参数，分别反映目标码率、目标帧率与和上次返回的本地视频流统计信息相比，本地视频质量的自适应情况。

##### 2. 视频偏好设置

一般场景下，Agora 默认的视频编码配置能满足需求。对于特定场景，该版本提供如下功能让用户选择视频偏好：

- 弱网下画质或流畅偏好设置。该版本在视频编码属性 [`VideoEncoderConfiguration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html) 类中新增 2 个参数 [`minFrameRate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#ad8d377cd077587ee0991d297b1a8c8bc) 和 [`degradationPrefer`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a47f36783c1f9da09454c19cafb489b3c)，分别用于设置最低视频编码帧率，以及带宽受限时编码帧率的偏好。这两个参数需要搭配使用，详情请参考[设置视频属性](video_profile_android)。

- 采集时预览或性能偏好设置。该版本新增接口 [`setCameraCapturerConfiguration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab241578c1baf67e68bcabe1a07eb3363)，通过设置摄像头采集偏好，用户可以根据实际场景选择优先保证设备性能还是视频质量。具体场景及参数选择，请参考 [API 文档](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab241578c1baf67e68bcabe1a07eb3363)。

##### 3. 核心质量改进

- 降低了音频延时
- 提升了视频质量和稳定性
- 缩短了远端视频出图时间
- 优化了耳返延迟和回声抑制

#### 问题修复

##### 音频相关

- 修复了调用 `enableLocalAudio` 接口导致的蓝牙断开的问题
- 新增支持中文字符音乐
- 修复了高音声音变弱的问题
- 修复了偶现的声音快放问题
- 修复了部分设备无法调节音量的问题

##### 视频相关

- 通过增加 `renderMode` 的默认值，修复了用户在没有设置的情况 下，窗口和画面比例不符合引发的拉伸问题
- 部分低性能设备上出现的播放视频卡住的问题
- 优化了 SDK 出图时间

##### 其他

- 统一了 Android 和 iOS 平台上 SDK 判断远端用户掉线的时间
- 修复了转码推流场景下，SEI 信息与媒体流不同步的问题

#### API 整理

为提升用户体验，Agora 在 v2.4.0 版本中对 API 进行了如下变动：

##### 新增

- [`setBeautyEffectOptions`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa9327de4fb0c29f840b1e68ca2e83fc6)
- [`setLocalVoiceChanger`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ade6883c7878b7a596d5b2563462597dd)
- [`setLocalVoiceReverbPreset`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a10dd25bc8e129512cd6727133b7fc42f)
- [`enableSoundPositionIndication`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aaeb3e1df5d2cb091bd2e9c41f156d3c0)
- [`setRemoteVoicePosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a7d851c2cabde18c2438c1ebe8bf763de)
- [`startLastmileProbeTest`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a81c6541685b1c4437d9779a095a0f871)
- [`stopLastmileProbeTest`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ae21243b8da8bda9ee5f3a00621cbf959)
- [`setRemoteUserPriority`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ad4705f9e56f0cf7e0a3e9cbd09ec8f61)
- [`startEchoTest`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a712bb50be350186d097f4deed8e1aa37)
- [`setCameraCapturerConfiguration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab241578c1baf67e68bcabe1a07eb3363)
- [`setLogFileSize`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a50fd37c6f5b8fc144b18ed4620aee6fc)
- [`onAudioMixingStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aee0aa9286a39654312b162750713e986)
- [`onLastmileProbeResult`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ad74a9120325bfeccdec4af4611110281)

##### 废弃

- `startEchoTest`
- `setVideoQualityParameters`

##### 其他

[`VideoEncoderConfiguration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html) 类中的 [`frameRate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a8ab46f09a0c6eee1f3f2b6f04efeab2b) 参数由 `enum` 型修改为 `int` 型。

**2.3.3 版**

该版本于 2019 年 1 月 24 日发布。修复问题详见下文。

#### 问题修复

- 修复了 `onNetworkQuality` 回调不准确的问题。
- 修复了特定场景下华为 P9 上偶发的崩溃问题。

**2.3.2 版**

该版本于 2019 年 1 月 16 日发布。新增特性与修复问题列表详见下文。

#### 升级必看

2.3.2 整体提升直播场景下视频弱网抗丢包能力，提高流畅度，降低卡顿率。升级前，请了解以下版本兼容性:

- Native SDK 版本不能低于 1.11.0
- Web SDK（若互通）版本不能低于 2.1.0

#### 新增功能

##### 1. 对兴趣点自动曝光

为提升视频采集质量，该版本新增如下接口，支持对兴趣点自动曝光功能。开发者可以将需要自动曝光的区域位置发送给 Agora SDK，摄像头会基于该区域自动曝光。

- [`isCameraExposurePositionSupported`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6818c2a98bebeb72e4802b1c585da99b)：检查设备是否支持摄像头曝光
- [`setCameraExposurePosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0ac20919f60df42635850c53c9cbdefd)：设置摄像头曝光区域
- [`onCameraExposureAreaChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ab6bc82a55191e596d5bf5a7c56bdf95e)：摄像头曝光区域已更改

##### 2. 提升直播清晰度

Agora SDK 会根据网络条件进行码率自适应。为满足用户在直播场景下对视频清晰度的要求，该版本在 [`setVideoEncoderConfiguration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af5f4de754e2c1f493096641c5c5c1d8f) 接口中新增 [`minBitrate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a9cd44566bc19eca4006fda264ea96dc7) 参数，强制视频编码器输出高质量图片。如果将参数设为高于默认值，在网络状况不佳情况下可能会导致网络丢包，并影响视频播放的流畅度。因此如非对画质有特殊需求，Agora 建议不要修改该参数的值。

##### 3. 控制音乐文件的播放音量

为方便用户控制混音音乐文件在本地及远端的播放音量，该版本在已有 [`adjustAudioMixingVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a13c5737248d5a5abf6e8eb3130aba65a) 的基础上新增 [`adjustAudioMixingPlayoutVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0308c6bc82af433ae8340e0b3cd228c9) 和 [`adjustAudioMixingPublishVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a16c4dc66d9c43eef9bee7afc86762c00) 接口，用于分别控制混音音乐文件在本地和远端的播放音量。

添加新的方法后，原有的 [adjustPlaybackSignalVolume](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af7d7f10fc96db2febb9c2590891d071b) 由控制人声和音乐的音量改为仅控制人声的音量。因此，如果要静音本地播放，需同时设置 `adjustPlaybackSignalVolume(0)` 和 `adjustAudioMixingPlayoutVolume(0)`。

该版本梳理了用户在音频采集到播放过程中可能会需要调整音量的场景，及各场景对应的 API，供用户参考使用。详见官网文档[调整通话音量](./volume_android)。

#### 改进

##### 1. 提供更透明的质量数据统计

为提升质量透明的用户体验，该版本废弃了原有的 `onAudioQuality` 回调，并新增 `onRemoteAudioStats` 回调进行取代。和原来的接口相比，新接口使用更为综合的算法，通过引入音频丢帧率、端到端的音频延迟、接收端网络抖动的缓冲延迟等参数，使回调结果更贴近用户感受。同时，该版本优化了 `onNetworkQuality` 的算法，对上下行网络质量采用不同的计算方法，使评分更精准。

- [`onRemoteAudioStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a9eaf8021d6f0c97d056e400b50e02d54)：通话中远端音频流的统计信息回调。用于替换 `onAudioQuality`
- [`onNetworkQuality`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a76be982389183c5fe3f6e4b03eaa3bd4)：通话中每个用户的网络上下行 Last mile 质量报告回调

Agora SDK 计划在下一个版本对如下 API 进行进一步改进：

- [`onLastmileQuality`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a2887941e3c105c21309bd2643372e7f5)：通话前网络上下行 Last mile 质量报告回调

该版本对数据统计相关回调进行了统一梳理，相关回调及算法详见[通话中数据统计](./in-call_quality_android)。

##### 2. 改进获取 SDK 网络连接状态的生成策略

为提升 SDK 使用数据统计的准确性和合理性，该版本新增如下接口，用以获取 SDK 的网络连接状态，以及连接状态发生改变的原因。

- [`getConnectionState`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8635e3c9e26ffe95e7ab9a518af533b9) ：获取 SDK 的网络连接状态
- [`onConnectionStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a31b2974a574ec45e62bb768e17d1f49e)：SDK 的网络连接状态已改变回调

该版本废弃了原有的 [`onConnectionInterrupted`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a0841fb3453a1a271249587fa3d3b3c88) 和 [`onConnectionBanned`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a80cfde2c8b1b9ae499f6d7a91481c5db) 回调。

在新的接口下，SDK 共有 5 种连接状态：未连接、正在连接、已连接、正在重新建立连接和连接失败。当连接状态发生改变时，都会触发 `onConnectionStateChanged` 回调。当条件满足时，原有的 `onConnectionInterrupted` 和 `onConnectionBanned` 回调也会触发，但 Agora 不再推荐使用。

##### 3. 优化打分反馈机制

为方便用户（开发者）收集最终用户（应用程序使用者）对使用应用进行通话或直播的反馈，该版本将 [`rate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab7083355af531cc43d455024bd1f7662) 接口中的打分范围缩小为 1 - 5，减少最终用户的打分干扰。Agora 建议在应用程序中集成该接口，方便应用程序收集用户反馈。

##### 4. 其他改进

- 优化了直播场景下视频弱网抗丢包能力
- 加快了严重拥塞状态视频的恢复速度
- 提升了推流稳定性
- 优化了 SDK 在 Android 6.0 以上设备上的性能
- 优化了 API 的调用线程
- 增加了重新检测耳机插入和蓝牙设备连接的代码
- 降低了音频延时
- 新增了对锤子手机摄像头的适配

#### 问题修复

##### SDK 相关：

- 修复了 SDK 在部分模拟器（夜神、mumu 等）上的崩溃问题
- 修复了 Android 6.0 以上 x86 so 重定位导致的崩溃问题

##### 音频相关：

- 修复了设备在连接蓝牙的状态下，退出频道后，音频不走蓝牙的问题
- 修复了调用 `startAudioMixing` 播放音乐文件时出现的崩溃问题
- 修复了麦克风在禁用的状态下，设备插上耳机后，禁用失效的问题
- 修复了华为 Mate 20X 上出现的应用切至后台，使用其他应用时出现的远端听不到本地说话的问题
- 修复了 Pixel 2 设备上出现的回声问题
- 修复了外放条件下，上下麦、系统电话打断、进退频道等多种场景下，出现的无法调节外放音量的问题
- 修复了应用从后台切回前台时，出现的出声音慢的问题

##### 视频相关：

- 修复了 x86 设备上自采集图像时硬件编码器的相关问题
- 修复了视频自采集时的偶现问题

#### API 整理

为提升用户体验，Agora 在 v2.3.2 版本中对 API 进行了如下变动。

##### 新增

- [`isCameraExposurePositionSupported`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6818c2a98bebeb72e4802b1c585da99b)
- [`setCameraExposurePosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0ac20919f60df42635850c53c9cbdefd)
- [`getConnectionState`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8635e3c9e26ffe95e7ab9a518af533b9)
- [`adjustAudioMixingPlayoutVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0308c6bc82af433ae8340e0b3cd228c9)
- [`adjustAudioMixingPublishVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a16c4dc66d9c43eef9bee7afc86762c00)
- [`onConnectionStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a31b2974a574ec45e62bb768e17d1f49e)
- [`onCameraExposureAreaChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ab6bc82a55191e596d5bf5a7c56bdf95e)
- [`onRemoteAudioStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a9eaf8021d6f0c97d056e400b50e02d54)

##### 废弃

- [`onAudioQuality`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#abeac442a777e103536dcf9c8ce2d7135)
- [`onConnectionInterrupted`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a0841fb3453a1a271249587fa3d3b3c88)
- [`onConnectionBanned`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a80cfde2c8b1b9ae499f6d7a91481c5db)

**2.3.1 版**

该版本于 2018 年 10 月 12 日发布。新增特性与修复问题列表详见下文。

#### 新增功能

##### 关闭/重新开启本地语音功能

应用程序在加入频道时，语音功能是默认打开的。为满足用户只接收而不发送音频流的需求，该版本新增 `enableLocalAudio` 接口，方便应用程序在进入频道后关闭或重新开启本地语音功能。关闭本地语音功能后，应用程序会收到 `onMicrophoneEnabled` 回调，并停止采集本地音频流。该方法不影响接收和播放远端音频流。

该功能与 `muteLocalAudioStream` 的区别在于前者不采集不发送，而后者是采集但不发送。

#### 改进

- 提升了 SDK 与 Android 设备上视频编码器的适配度。

#### 问题修复

- 修复了直播场景下，多次上下麦后某些 Android 设备上偶现的崩溃问题。
- 修复了切换前后摄像头过程中偶现的崩溃问题。
- 修复了通信场景下，一对一通话过程中，一端关闭视频后再打开，另一端出图较慢的问题。
- 修复了直播场景下，观众端因统计有误出现的延迟的问题。
- 修复了某些 Android 设备上偶现的无法渲染视频的问题。
- 修复了某些 Android 设备上偶现的视频卡顿的问题。
- 修复了某些 Android 设备上偶现的退出频道时，如果频道内还有人在说话，会听到声音且声音破音的问题。
- 修复了采集到的视频裸数据中，视频帧的时间戳不按帧更新的问题。

**2.3.0 版**

该版本于 2018 年 8 月 31 日发布。新增特性与修复问题列表详见下文。

Agora SDK 在 v2.3.0 版本中，全面提升了视频功能的稳定性及可用性，保证了更加可靠的实时通信。同时音视频质量也得到进一步提高。 视频方面，通过优化编码性能，增强了弱网对抗能力，减少卡顿时间，提升视频流畅度；音频方面，采用深度学习算法，改进了通话中的音频质量。

#### 升级必看

- 为满足场景中视频旋转的需要，提升自定义视频源画质，该版本引入 `setVideoEncoderConfiguration` 替换原 `setVideoProfile` 接口。 `setVideoProfile` 接口仍可用，但不再推荐。

  - 直播场景下支持 Adaptive Mode，当发送端画面旋转时不再剪切画面，避免播放端画面出现“大头”或缩放模糊的现象。

  - 自采集场景中，可以根据输入视频帧的宽和高，动态调整输出视频帧的宽和高，尽可能避免剪切，并提供更多的图像信息给到播放端。

- 该版本中 LiveTranscoding Class 从 `io.agora.live `Package 移到了 `io.agora.rtc.live` Package。

- 该版本修改了 API `constants.java` 中的拼写错误。

  - 修改前：

  ```
  public static final int SOFEWARE_ENCODER = 1;
  ```

  - 修改后：

  ```
  public static final int SOFTWARE_ENCODER = 1;
  ```

- 为更好地提升用户体验，Agora SDK 在 v2.1.0 版本中对动态密钥进行了升级。如果你当前使用的 SDK 是 v2.1.0 之前的版本，并希望升级到 v2.1.0 或更高版本，请务必参考 [动态密钥升级说明](./token_migration) 。

#### 新增功能

本次发版新增如下功能：

##### 1. 直播中弱网环境下视频自动回退/重开

网络不理想的环境下，直播音视频的质量都会下降。为提升直播效率，Agora 新增了 `setLocalPublishFallbackOption` 和 `setRemoteSubscribeFallbackOption` 两个接口。 用户设置这两个接口后，在网络条件差、无法同时保证音视频质量的情况下，SDK 会自动将视频流从大流切换为小流，或直接关闭视频流，从而保证或提高音频质量。同时 SDK 会持续监控网络质量， 并在网络质量改善时恢复音视频流。在推流回退为音频流时，或由音频流恢复为音视频流，触发 `onLocalPublishFallbackToAudioOnly` 或 `onRemoteSubscribeFallbackToAudioOnly` 回调。

##### 2. 提前 30 秒提醒 Token 即将过期

由于 Token 具有一定的时效，在通话过程中如果 Token 即将失效，SDK 会提前 30 秒触发回调 `onTokenPrivilegeWillExpire` ，提醒应用程序更新 Token。当收到该回调时，用户需要重新在服务端生成新的 Token，然后调用 `renewToken` 将新生成的 Token 传给 SDK。

##### 3. 按用户返回音视频上下行码率、帧率、丢包率及延迟

为方便统计每个用户的音视频上下行码率、帧率及丢包率，该版本新增 `onRemoteAudioTransportStats` 和 `onRemoteVideoTransportStats` 回调。 通话或直播过程中，当用户收到远端用户发送的音视频数据包后，会周期性地发生该回调上报，频率约为 2 秒 1 次。 回调中包含用户的 UID、音/视频接收码率、丢包率、以及延迟时间（毫秒）。 并在统计频道内通话相关数据的 Rtcstats 类中增加 `lastmileDelay` 参数，返回客户端到 vos 服务器的延迟。

##### 4. 设置视频编码属性

为满足场景中视频旋转的需要，提升自定义视频源画质，该版本引入 `setVideoEncoderConfiguration` 替换原 `setVideoProfile` 接口，来设置视频编码属性。 新接口中的 `VideoEncoderConfiguration` 类对应一套视频参数，支持用户根据实际需要，手动设置视频的分辨率（dimension)、帧率 (frame rate)、码率 (bitrate) 以及视频方向 (orientationMode)。原接口 `setVideoProfile` 仍可使用，但不再推荐。

##### 5. 直播转码新增支持设置背景图片

在设置直播转码接口 `setLiveTranscoding` 中，新增 `backgroundImage` 参数，支持设置直播转码合图的背景图片。

#### 改进功能

- 优化了一对一音视频的质量，在降低延时、防止卡顿方面提升明显。优化效果重点覆盖东南亚、南美、非洲和中东等地区

- 直播场景下，改善了音频编码器的效率，保证通话质量的同时节省用户流量

- 采用深度学习算法，改进了通话及直播中的音频质量

#### 问题修复

- 修复了因视频编码问题引起的 Native 设备与 Web 端互通时，Web 端看不到 Native 端视频画面的问题

- 修复了多人视频直播连麦场景下，SDK 内存异常增长的问题

- 修复了某些 Android 设备上偶现的崩溃的问题

- 修复了特定场景下某些设备上偶发的无法看到远端视图的问题

- 修复了特定场景下部分 Android 设备上无法开启本地视频的问题

- 修复了特定场景下偶现的视频重影的问题

- 修复了小米 8 上出现的本地预览黑屏、远端也看不到它的问题

- 修复了通信场景下，由小流切换到大流时，偶现的视频画面下方出现绿边的问题。

- 修复了多平台互通时，一段时间后某些 Andorid 设备上偶现的崩溃问题。

- 修复了多人连麦场景下，主播频繁进出频道时，偶现的主播内存异常增长的问题

- 修复了某些 Android 设备上偶现的黑屏的问题

- 修复了特定场景下偶现的主播加入频道、下麦再上麦后，远端用户听不到主播声音的问题

- 修复了偶现的设置推流背景图无效的问题

- 修复了通信场景下，某些设备上偶现的视频画面长宽和设置的长宽颠倒的问题

- 修复了某些设备上偶现的开启视频模式加入频道后，调用 `destroy` 方法无响应的问题

- 修复了频道内其他用户频繁进出频道时，Android 设备上偶现的崩溃问题

- 修复了特定场景下某些 Android 设备上无法渲染远端视频，一直黑屏的问题

- 修复了特定场景下偶现的直播观众无法调节频道内通话音量的问题

- 修复了特定场景下某些 Android 设备上偶现的应用无响应的问题

- 修复了直播场景下，动态切换分辨率时，某些 Android 设备上偶现的崩溃的问题

- 修复了直播场景下，某些 Android 设备上出现的以观众身份加入频道，上麦后无法看到主播图像的问题

- 修复了通信场景下，反复设置不同的视频编码属性进出频道后，某些 Android 设备上出现码率爬升不上的问题

- 修复了直播场景下，主播和观众频繁切换角色时，观众切主播后偶现的采集不到画面的问题

- 修复了通信场景下，反复设置不同的视频编码属性进出频道后，某些 Android 设备上偶现的采集不到画面也不发流的问题

- 修复了设置手动对焦位置并触发对焦时，某些设备上偶现的崩溃的问题

- 修复了通信过程中，特定场景下某些 Android 设备上偶现的无法打开应用摄像头和系统摄像头的问题

- 修复了通信和直播场景下，某些 Android 设备上出现的加入频道一段时候后，视频卡住不再发流的问题

- 修复了 2 人连麦过程中，一端播放背景音乐时将自己静音或关闭音频后，另一端闪退的问题

- 修复了通信场景下，反复设置不同的视频编码属性后，无法进入频道的问题

- 修复了特定场景下，预加载音效时某些设备上偶现的崩溃问题

- 修复了特定场景下，某些 Android 设备上无法输出小分辨率视频的问题

- 修复了通信场景下，某些 Android 设备上偶现的服务端无法踢人的问题

- 修复了直播场景下，主播端编码与解码端渲染的分辨率不一致的问题

- 修复了某些 Andoid 设备上偶现的无法打开硬件编码器的问题

- 修复了通信和直播场景下偶发的视频画面卡住的问题

- 修复了进入频道前暂停指定用户视频流后，某些设备上偶现的崩溃的问题

- 修复了特定场景下，视频通话切到视频直播时，某些 Android 设备上出现的卡住的问题

- 修复了直播场景下，开关闪光灯时某些 Android 设备上出现崩溃的问题

- 修复了直播场景下，某些 Android 设备上出现的观众上麦后，主播接收不到上麦观众的音视频流的问题

- 修复了直播场景下，对某些外部视频源设置编码属性时，某些 Android 设备上出现的崩溃的问题

- 修复了直播场景下，对某些外部视频源设置编码属性时，某些 Android 设备上出现的输出视频方向不正确的问题

- 修复了特定场景下，某些 Android 设备上偶发的设置弱网下视频自动回退为 Audio-only 不生效的问题

- 修复了偶现的频繁切换 Token 时，某些 Android 设备上偶现的崩溃的问题

- 修复了特定场景下，某些 Android 设备上出现的分屏异常的问题

- 修复了直播场景下，旁路推流时部分 Android 设备上偶现的旁路观众看不到拉流画面的问题

- 修复了直播场景下，由连麦切换回单主播时偶现的画面卡顿的问题

- 修复了特殊场景下偶现的 SIP 设备和 SDK 视频不互通的问题

- 修复了某些 Android 设备上偶现的无法看到对方的问题

- 修复了部分 Android 设备上偶现的视频延迟的问题

- 修复了特定场景下某些 Android 设备上出现的传视频过程中出现的崩溃的问题

#### API 整理

为提升用户体验，Agora 在 v2.3.0 版本中对 API 进行了梳理，并针对部分接口进行了如下处理：

为避免在直播转码推流中添加多个相同 User，以下接口在 v2.3.0 版本中进行删除，并将 `addUser` 返回类型由 void 变更为 int。

- setUser

以下接口与录制相关，在 v2.3.0 版本后不再支持。Agora 提供专门的 Recording SDK 用于更好的录制服务，详见 [Agora Recording SDK 发版说明](https://docs.agora.io/cn/Recording/release_recording?platform=Linux)。

- `startRecordingService`

- `stopRecordingService`

- `refreshRecordingServiceStatus`

- `onRefreshRecordingServiceStatus`

以下接口长期处于弃用状态，现进行删除，v2.3.0 版本后不再支持：

- `monitorConnectionEvent`

- `monitorBluetoothHeadsetEvent`

- `monitorHeadsetEvent`

- `setPreferHeadset`

- `switchView`

- `setSpeakerphoneVolume`

**2.2.3 版**

该版本于 2018 年 7 月 5 日发布。新增特性与修复问题列表详见下文。

#### 升级必看

为更好地提升用户体验，Agora SDK 在 v2.1.0 版本中对动态密钥进行了升级。如果你当前使用的 SDK 是 v2.1.0 之前的版本，并希望升级到 v2.1.0 或更高版本，请务必参考 [动态密钥升级说明](/cn/Agora%20Platform/token_migration) 。

#### 问题修复

- 修复了特定场景下偶发的线上统计崩溃的问题。

- 修复了直播时部分设备上主播声音变音的问题。

- 修复了直播时特定场景下偶发的崩溃的问题。

- 修复了多人直播连麦时，SDK 内存增长的问题。

- 修复了部分设备上偶发的离开频道后，收到 `onLeaveChannel` 回调偏慢的问题。

- 修复了偶发的无法正常反馈频道内谁在说话以及说话者音量的问题。

- 修复了直播时偶发的观众听到主播声忽大忽小的问题。

- 修复了直播时部分设备上偶发的视频卡住的问题。

- 修复了部分设备上偶发的关闭摄像头结束通话时，程序界面无响应的问题。

- 修复了特定场景下偶发的视频窗口尺寸变化后，视频卡住的问题。

**2.2.2 版**

该版本于 2018 年 6 月 21 日发布。修复问题列表详见下文。

#### 问题修复

- 修复了特定场景下偶发的线上统计崩溃的问题
- 修复了部分安卓设备上偶发的音频崩溃的问题
- 修复了直播场景下部分安卓设备上主播声音变音的问题
- 修复了偶发的无法正常反馈频道内谁在说话以及说话者的音量的问题
- 修复了部分安卓设备上偶现的离开频道后，收到 `onLeaveChannel` 回调偏慢的问题
- 修复了特定场景下偶发的视频窗口尺寸变化后，视频卡住的问题
- 修复了部分安卓设备上偶现的关闭摄像头结束通话时，程序界面无响应的问题

**2.2.1 版**

该版本于 2018 年 5 月 30 日发布。新增特性与修复问题列表详见下文。

#### 问题修复

- 修复了部分设备上偶现的游戏过程中 Crash 的问题。

- 修复了部分设备上无法获取声道指针的问题。

- 修复了部分设备上偶现的 Crash 问题。

- 修复了部分设备上插入耳机后无法调节音量的问题。

**2.2.0 版**

该版本于 2018 年 5 月 4 日发布。新增特性与修复问题列表详见下文。

#### 新增功能

本次发版新增如下功能：

##### 1. 音效混响进频道

播放音效 `playEffect `接口新增了一个 `publish` 参数，用于在播放音效时，远端用户可以听到本地播放的音效。

> 如果你的 SDK 是由之前版本升级到 v2.2 版本，请务必关注该接口功能的变动。

##### 2. 服务端部署代理服务器

通过部署 Agora 提供的代理服务器安装包，设有企业防火墙的用户可以设置代理服务器，使用 Agora 的服务。

##### 3. 获取远端视频状态

新增 `onRemoteVideoStateChanged` 接口，以获知远端视频流的状态。

##### 4. 直播添加视频水印

在本地直播及旁路直播中增加水印功能，允许用户将一张 PNG 图片作为水印添加到正在进行的本地直播或旁路直播中。新增 `addVideoWatermark` 和 `clearVideoWatermarks` 接口，以添加或删除本地直播水印；`LiveTranscoding` 接口中新增 `watermark` 参数，用于控制旁路直播中水印的添加。

#### 改进功能

本次发版改进如下功能：

##### 1. 当前说话者音量提示

改进 `enableAudioVolumeIndication `接口的功能，无论频道内是否有人说话，都会在回调中按设置的时间间隔返回说话者音量提示。

##### 2. 频道内网络质量监测

根据用户对频道内实时网络质量监测的需求，在 `onNetworkQuality` 中改进了返回数据的准确度。

##### 3. 进入频道前网络条件监测

为方便用户在进频道前检查当前网络是否能支撑语音或视频通话，在 `onLastmileQuality` 中，由通过恒定码率监测优化为根据用户设定的 Video Profile 的码率进行监测，提高返回数据的准确度。且在网络状态为 unknown 时，依然以 2 秒的间隔返回回调。

##### 4. 提升音乐场景下的音质

提升了用户在播放音乐等场景下的音乐音质。

#### 问题修复

- 修复了大量用户同时直播连麦时，偶发的抖屏现象

- 修复了某些 App 在直播过程中退到后台后，旁路推流显示异常的问题

**2.1.3 版**

该版本于 2018 年 4 月 19 日发布。新增特性与修复问题列表详见下文。

#### 升级必看

该版本的 SDK 修改了`setVideoProfile` 方法在直播场景下的码率值，修改后的码率值与 2.0 版本一致。

#### 问题修复

修复了部分手机上，用户离开频道后，开启自带的录音设备时，偶现录音出错的问题。

#### 改进

改进了通信和直播场景下屏幕共享的效果，缩短了用户从屏幕共享模式切换回普通模式需要的时间间隔。

**2.1.2 版**

该版本于 2018 年 4 月 2 日发布。新增特性与修复问题列表详见下文。

#### 升级必看

SDK 升级至 2.1.2 的直播场景后，相同分辨率下，视频更清晰，但带宽也会变大。

#### 新增功能

在已有 `setVideoProfile `接口的基础上，新增一个同名接口。用户可以用此接口，根据自身业务需要，手动设置视频的分辨率、帧率和码率。

#### 问题修复

修复了之前版本 SDK 在 dtx + aac 模式下会视频卡顿的问题。

**2.1.1 版**

该版本于 2018 年 3 月 16 日发布。

请正在或已集成 2.1 SDK 的客户尽快升级更新！ 本次发版修复了一个的系统风险，请尽快升级以免对服务造成影响。

**2.1.0 版**

该版本于 2018 年 3 月 7 日发布。新增特性与修复问题列表详见下文。

#### 新增功能

本次发版新增如下功能：

##### 1. 开黑

新增了一个游戏开黑场景，用于节省流量和去除杂音，通过调用 API `setAudioProfile` 实现。

##### 2. 音效均衡和音效混响

在直播场景下，主播如果需要通过内置的麦克风美化和定制自己的语音输入，可以通过调用 API `setLocalVoiceEqualization` 和 `setLocalVoiceReverb` 轻易地设置音效均衡和混响来实现所需要的效果。

##### 3. 在线频道信息查询

新增 RESTful API 查询用户在频道中的状态信息，查询指定频道内的分角色用户列表，查询厂商频道列表，查询用户是否为连麦用户等。详见[控制台 RESTful API](console_overview)。

##### 4. 17 人视频

在直播场景下，同一频道内支持 17 位主播同时进行视频直播和连麦，详见[七人以上视频通话](./multi_user_video_android)。

##### 5. 自定义视频源

Agora SDK 提供了摄像头采集的默认实现，同时允许开发者使用自定义视频源。主要适用场景和文档详见 [自定义视频源和渲染器](custom_video_android) 。

##### 6. 自定义渲染器

Agora SDK 提供了默认的渲染器实现，用来显示本地视频图像和对端视频图像。使用默认的渲染器就能满足大部分开发者需求，复杂的业务场景下，Agora 也开放了自定义渲染器接口。

##### 7. 插入外部视频源

直播场景下，可以将采集到的视频添加到正在进行的直播中，直播室里的主播和观众可以一起边看电影、比赛或演出，边进行点评、互动等功能，会让现有的直播话题更广、体验更好。 仅支持拉入一路流，格式包括: RTMP, HLS, FLV。赛事直播最多同时支持 5 人连麦直播。

##### 8. 直播优化方案

提供一套全新的 API，直播场景优化 API，将原来 API 封装在底层，更快集成，更多功能扩展性。升级到 SDK 2.1 的用户可以选择使用新 API 或者老 API，两套方案均可以使用。

##### 9. 提示相机对焦区域

新增回调接口提示相机的对焦区域已发生改变，新增了回调 `onCameraFocusAreaChanged` 。

#### 改进

本次发版改进如下功能：

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<tbody>
<tr><td>改进</td>
<td>描述</td>
</tr>
<tr><td>卡顿</td>
<td>改善了观众模式下的卡顿现象</td>
</tr>
<tr><td>卡顿</td>
<td>改善了特定设备导致的卡顿现象</td>
</tr>
<tr><td>鉴权模型优化</td>
<td>旧鉴权模型一个密钥只能对应一个服务权限(例如加入频道)，而新的一个 Token 包含了所有的服务权限(例如加入频道，连麦，推流等)</td>
</tr>
<tr><td>硬件编码优化</td>
<td>在 Qualcomm、MTK、Hisilicon、和 Orion 芯片上适配硬件 264 编码器</td>
</tr>
<tr><td>硬件编码优化</td>
<td>改善硬件编码器优化码率控制</td>
</tr>
<tr><td>计费优化</td>
<td>计费系统针对极小分辨率统一按音频计费，例如 16 * 16</td>
</tr>
</tbody>
</table>

#### 问题修复

- 修复了华为 Nexus 6p 播放杂音的问题。

- 修复了一加手机上的破音问题。

- 修复了自采集声音不正常问题。

- 修复了偶现的崩溃问题。

**2.0.2 版**

该版本于 2017 年 12 月 15 日发布。新增特性与修复问题列表详见下文。

#### 问题修复

修复了偶现的语音路由问题。

**2.0 版**

该版本于 2017 年 12 月 6 日发布。新增特性与修复问题列表详见下文。

#### 新增功能

- 通信场景支持视频大小流功能，新增 API `setRemoteVideoStreamType` 和 `enableDualStreamMode`

- 通信和直播场景下支持摄像头管理功能，新增以下 API:

      <table>

  <colgroup>
  <col/>
  <col/>
  </colgroup>
  <tbody>
  <tr><td><strong>名称</strong></td>
  <td><strong>描述</strong></td>
  </tr>
  <tr><td><code>isCameraZoomSupported</code></td>
  <td>检测设备是否支持相机缩放功能</td>
  </tr>
  <tr><td><code>isCameraTorchSupported</code></td>
  <td>检测设备是否支持闪光灯常开</td>
  </tr>
  <tr><td><code>isCameraFocusSupported</code></td>
  <td>检测设备是否支持手动对焦功能</td>
  </tr>
  <tr><td><code>isCameraAutoFocusFaceModeSupported</code></td>
  <td>检测设备是否支持人脸对焦功能</td>
  </tr>
  <tr><td><code>setCameraZoomFactor</code></td>
  <td>设置相机缩放因子</td>
  </tr>
  <tr><td><code>getCameraMaxZoomFactor</code></td>
  <td>获取相机支持最大缩放比例</td>
  </tr>
  <tr><td><code>setCameraFocusPositionInPreview</code></td>
  <td>设置手动对焦位置，并触发对焦</td>
  </tr>
  <tr><td><code>setCameraTorchOn</code></td>
  <td>设置是否打开闪光灯</td>
  </tr>
  <tr><td><code>setCameraAutoFocusFaceModeEnabled</code></td>
  <td>设置是否开启人脸对焦功能</td>
  </tr>
  </tbody>
  </table>

- 通信和直播场景下支持音频自采集功能，新增以下 API:

      <table>

  <colgroup>
  <col/>
  <col/>
  </colgroup>
  <tbody>
  <tr><td><strong>名称</strong></td>
  <td><strong>描述</strong></td>
  </tr>
  <tr><td><code>setExternalAudioSource</code></td>
  <td>设置外部音频采集参数: 采样率，通道数等</td>
  </tr>
  <tr><td><code>pushExternalAudioFrame</code></td>
  <td>推送外部音频帧</td>
  </tr>
  </tbody>
  </table>

- 通信和直播场景下支持服务端踢人功能。

- 新增以下 Android 模拟器支持: 夜神、雷电、逍遥。

#### 改进

硬件编码器优化: 支持超小分辨率的编码，例如 64 x 64。

#### 问题修复

- 修复了音频路由和蓝牙相关的若干问题。

- 优化了音量均衡控制。

**1.14 版**

该版本于 2017 年 10 月 20 日发布。新增特性与修复问题列表详见下文。

#### 新增功能

- 新增 API `setAudioProfile 设`置音频参数和应用场景。

- 新增 API `setLocalVoicePitch` 提供基础变声功能。

- 直播场景: 新增 API `setInEarMonitoringVolume`提供调节耳返音量功能。

#### 改进

- 优化了在高码率下的音频体验。

- 秒开: 直播场景下，单流模式时观众加入频道 1 秒内看见主播图像 (均值为 226 ms, 网络状态良好时可达 204 ms)。

- 节省带宽:

  - 1.14 以前: 如果你选择不听某人的音频或不看某人的视频，音视频流会照发。

  - 1.14 开始: 如果你选择不听或不看某人的流，则不会下发，从而节省带宽。

- 精准的码率控制:

  - 1.14 以前: 码率控制不够精准，上下波动幅度较大。波动过大容易造成网络拥塞，增加丢包、丢帧的概率，影响了带宽估计模块的精度，特别是在弱网低码率情况下尤为明显。

  - 1.14 开始: 精准的码率控制，要多少给多少，不多给也不少给，避免波动过大造成的网络拥塞，减少传输延时，有助于减少网络卡顿。

#### 问题修复

修复了部分 Android 机器上摄像头相关的问题。

**1.13.1 版**

该版本于 2017 年 9 月 28 日发布。新增特性与修复问题列表详见下文。

#### 优化

优化了特定场景下出现的回声问题。

**1.13 版**

该版本于 2017 年 9 月 4 日发布。新增特性与修复问题列表详见下文。

#### 新增功能

- 新增 API `onClientRoleChanged` 用于提醒直播场景下主播、观众上下麦的回调。

- 新增功能 Android 模拟器。

- 新增单独关闭语音播放的功能。

- 新增功能支持服务端推流失败回调。

#### 改进

- 软编情况下，视频属性可控。

- 可以在客户端设置推流的 Profile。

#### 修复问题

修复了部分机型上偶现的崩溃

**1.12 版**

该版本于 2017 年 7 月 25 日发布。新增特性与修复问题列表详见下文。

#### 新增功能

- 在 API 方法 `setEncryptionMode`里新增了加密模式 `aes-128-ecb`。

- 在 API 方法 `startAudioRecording` 里新增了参数 `quality` 用于设置录音音质。

- 新增了一系列 API 管理音效。

- 直播场景下， 新增了 API 方法 `injectStream`在当前频道内插入一条 RTMP 流。该功能目前为 beta 版。

#### 改进

通信场景下针对 320 x 180 分辨率提供了以下改进方案:

- 网络和设备状态较差的情况下仍能保证画质流畅度。

- 网络和设备状态良好的情况下可以做到比 180P 更好的画质清晰度。

#### 修复问题

- 修复了部分机型上蓝牙相关的语音路由问题。

- 修复了部分机型上偶现的崩溃问题。
