---
title: 发版说明
platform: macOS
updatedAt: 2021-03-29 03:48:11
---

本文提供 Agora 语音 SDK 的发版说明。

## **简介**

macOS 语音 SDK 支持两种主要场景:

- 音频通话
- 音频直播

点击 [语音通话产品概述](https://docs.agora.io/cn/Voice/product_voice?platform=All%20Platforms) 以及 [音频互动直播产品概述](https://docs.agora.io/cn/Audio%20Broadcast/product_live_audio?platform=All%20Platforms)了解关键特性。

## **3.1.0 版**

该版本于 8 月 6 日发布。

**新增特性**

#### 1. 发布和订阅状态转换回调

该版本新增以下回调方便你了解音频流当前的发布及订阅状态，有助于订阅和发布相关的数据统计：

- `didAudioPublishStateChange`: 音频发布状态发生改变。
- `didAudioSubscribeStateChange`: 音频订阅状态发生改变。

#### 2. 本地首帧发布回调

为提示用户本地音频首帧已发布，该版本新增 `firstLocalAudioFramePublished` 回调。该回调取代 `firstLocalAudioFrame` 回调，我们推荐你不再使用 `firstLocalAudioFrame` 回调。

#### 3. 自定义数据上报

该版本支持自定义数据上报。如需试用，请联系 [sales@agora.io](mailto:sales@agora.io) 开通并商定自定义数据格式。

**改进**

#### 1. 指定访问区域完善

该版本新增以下枚举值，在调用 `sharedEngineWithConfig` 创建 `AgoraRtcEngineKit` 实例时提供更多区域选择。指定访问区域后，集成了 Agora SDK 的 app 会连接指定区域内的 Agora 服务器。

- `AgoraIpAreaCode_JAPAN`: 日本。
- `AgoraIpAreaCode_INDIA`: 印度。

#### 2. 加密

该版本新增 `enableEncryption` 方法，用于开启内置加密，并废弃原加密方法：

- `setEncryptionSecret`
- `setEncryptionMode`

与原加密方法相比，该方法新增对国密 SM4 加密模式的支持，你可以根据需要选择合适的加密模式。

#### 3. 通话中质量透明

该版本进一步扩充了 `AgoraRtcLocalAudioStats` 类和 `AgoraRtcRemoteAudioStats` 类的成员，提供更多音频质量相关数据。

- `AgoraRtcLocalAudioStats` 类新增 `txPacketLossRate`，表示本端到 Agora 边缘服务器的物理音频丢包率 (%)。
- `AgoraRtcRemoteAudioStats` 类中新增 `publishDuration`，表示远端音频流的累计发布时长（毫秒）。

#### 4. 设置音频编码属性

为提升音频性能，该版本对音频编码码率最大值进行如下优化：

| Profile                                   | 3.1.0 版本                                           | 3.1.0 版本之前                                       |
| :---------------------------------------- | :--------------------------------------------------- | :--------------------------------------------------- |
| `AgoraAudioProfileDefault`                | <li>直播场景: 64 Kbps</li><li>通信场景: 18 Kbps</li> | <li>直播场景: 52 Kbps</li><li>通信场景: 18 Kbps</li> |
| `AgoraAudioProfileSpeechStandard`         | 18 Kbps                                              | 18 Kbps                                              |
| `AgoraAudioProfileMusicStandard`          | 64 Kbps                                              | 48 Kbps                                              |
| `AgoraAudioProfileMusicStandardStereo`    | 80 Kbps                                              | 56 Kbps                                              |
| `AgoraAudioProfileMusicHighQuality`       | 96 Kbps                                              | 128 Kbps                                             |
| `AgoraAudioProfileMusicHighQualityStereo` | 128 Kbps                                             | 192 Kbps                                             |

#### 5. 日志扩容

该版本中，Agora SDK 日志文件的默认个数由 2 个增加至 5 个，单个日志文件的默认大小由 512 KB 扩大至 1024 KB。默认情况下，SDK 会生成 `agorasdk.log`、`agorasdk_1.log`、`agorasdk_2.log`、`agorasdk_3.log`、`agorasdk_4.log 这` 5 个日志文件。最新的日志永远写在 `agorasdk.log` 中。`agorasdk.log `写满后，SDK 会从 1-4 中删除修改时间最早的一个文件，然后将 `agorasdk.log` 重命名为该文件，并建立新的 `agorasdk.log` 写入最新的日志。

#### 6. 音频路由

为支持在更多设备中播放音频，该版本在 `AgoraAudioOutputRouting` 枚举中新增 4 个枚举值，支持 USB 外围设备、HDMI 外围设备、DisplayPort 外围设备和 Apple AirPlay。

**问题修复**

该版本修复了特定场景下偶现因设备音频模块未启动，导致的本地录音无声。

**API 变更**

#### 新增

- [`didAudioPublishStateChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didAudioPublishStateChange:oldState:newState:elapseSinceLastState:)
- [`didAudioSubscribeStateChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didAudioSubscribeStateChange:withUid:oldState:newState:elapseSinceLastState:)
- [`firstLocalAudioFramePublished`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:firstLocalAudioFramePublished:)
- [`enableEncryption`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableEncryption:encryptionConfig:)
- [`AgoraRtcLocalAudioStats`](./API%20Reference/oc/Classes/AgoraRtcLocalAudioStats.html) 类中新增 `txPacketLossRate`
- [`AgoraRtcRemoteAudioStats`](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) 类中新增 `publishDuration`
- [`AgoraScreenCaptureParameters`](./API%20Reference/oc/Classes/AgoraScreenCaptureParameters.html) 类中新增 `windowFocus` 和 `excludeWindowList`
- [`rtmpStreamingEventWithUrl`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:rtmpStreamingEventWithUrl:eventCode:)
- 警告码: `AgoraWarningCodeAdmCategoryNotPlayAndRecord(1029)` 和 `AgoraWarningCodeApmResidualEcho(1053)`
- 错误码: `AgoraErrorCodeNoServerResources(103)`

#### 废弃

- `setEncryptionSecret`
- `setEncryptionMode`
- `firstLocalAudioFrame`

#### 删除

警告码: `AgoraWarningCodeAdmImproperSettings(1053)`

## **3.0.1 版**

该版本于 2020 年 5 月 27 日发布。

**升级必看**

#### macOS 静态库升级动态库

为提升开发体验，该版本将 SDK 由静态库升级为动态库，不再支持静态库。使用动态库可以提高库的安全等级，方便 app 上传至 App Store，且避免与第三方库产生不兼容等问题。

如果你由之前版本的静态库升级为当前版本，需要重新集成，详见[升级指南](migration_apple)。

**新增特性**

#### 1. 调整音乐文件音调

为方便调整混音时音乐文件的播放音调，该版本新增 `setAudioMixingPitch` 方法。通过设置该方法的 `pitch` 参数，你可以升高或降低音乐文件的音调。该方法仅对音乐文件音调有效，对本地人声不生效。

#### 2. 变声与混响

为提高用户的音频体验，该版本在 `setLocalVoiceChanger` 和 `setLocalVoiceReverbPreset` 中分别新增以下枚举值：

- 新增了以 `AgoraAudioVoiceBeauty` 为前缀和以 `AgoraAudioGeneralBeautyVoice` 为前缀的枚举值，分别实现美音或语聊美声功能。
- 新增了以 `AgoraAudioReverbPresetFx` 为前缀的枚举值和 `AgoraAudioReverbPresetVirtualStereo`，分别实现增强版混响效果和虚拟立体声效果。

你可以查看进阶功能[变声与混响](voice_changer_apple)了解使用方法和注意事项。

#### 3. 远端音频数据后处理多频道支持 (C++)

在多频道场景下，为方便后处理各频道的远端音频数据，该版本在 `IAudioFrameObserver` 类中新增 [`isMultipleChannelFrameWanted`](./API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#a4b6bdf2a975588cd49c2da2b6eff5956) 和 [`onPlaybackAudioFrameBeforeMixingEx`](./API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#ab0cf02ba307e91086df04cda4355905b)。

成功注册音频观测器后，如果你将 `isMultipleChannelFrameWanted` 的返回值设为 `true`，就可以通过上述回调获取多个频道对应的音频数据。在多频道场景下，我们建议你将返回值设为 `true`。

**问题修复**

- 修复了混音相关问题
- 修复了 App ID 和 Token 校验相关问题

**API 变更**

该版本新增以下 API：

- [`setAudioMixingPitch`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setAudioMixingPitch:)
- [`AgoraAudioVoiceChanger`](./API%20Reference/oc/Constants/AgoraAudioVoiceChanger.html) 枚举中新增以 `AgoraAudioVoiceBeauty` 为前缀和以 `AgoraAudioGeneralBeautyVoice` 为前缀的枚举值
- [`AgoraAudioReverbPreset`](./API%20Reference/oc/Constants/AgoraAudioReverbPreset.html) 枚举中新增以 `AgoraAudioReverbPresetFx` 为前缀的枚举值，以及 `AgoraAudioReverbPresetVirtualStereo` 枚举值
- [`AgoraRtcRemoteAudioStats`](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) 中新增 `totalActiveTime`

## **3.0.0.2 版**

该版本于 2020 年 4 月 22 日发布。

**新增特性**

#### 设置区域访问限制

该版本新增 `sharedEngineWithConfig` 方法，支持在创建 `AgoraRtcEngineKit` 实例时指定服务器的访问区域。该功能为高级设置，适用于有访问安全限制的场景。目前支持的区域有中国大陆、北美、欧洲、亚洲（中国大陆除外）和全球（默认）。

指定访问区域后，集成了 Agora SDK 的 app 在指定区域使用时，正常情况下会连接指定区域的 Agora 服务器；在非指定区域使用时，会从所在区域和指定区域的服务器地址中，择优选择服务器建立连接。

**问题修复**

该版本修复了音频无声、进频道后蓝牙设备断开、无法频道等问题。

**API 变更**

#### 新增

[`sharedEngineWithConfig`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/sharedEngineWithConfig:delegate:)

## **3.0.0 版**

该版本于 2020 年 3 月 4 日发布。

在该版本对通信场景采用了全新的系统架构，并升级了通信和直播场景下的 last mile 网络策略。在带宽不足时，新的网络策略能充分利用上下行有限带宽提升有效码率，从而增强弱网对抗能力，极大提升了弱网情况下通信和直播场景的终端用户体验。

由于通信场景采用了新的系统架构，为保证新老版本通信用户的互通兼容，我们使用了回退机制。如果频道内有老版本通信用户加入，则当前版本 (3.0.0) 的终端用户会回退成老版本通信。一旦回退，频道内所有用户都无法享受新版本带来的体验提升。因此我们强烈推荐同步升级所有终端用户到当前版本。

同时，我们对本地服务端录制进行了升级发布。为确保享受全新架构和网络策略优化带来的好处，使用本地服务端录制的客户，请务必同步升级本地服务端录制 SDK 至 3.0.0 版本。

新增特性、改进与问题修复详见下文。

**升级必看**

#### 1. 静态库更名与新增动态库

为与其他平台保持一致，该版本将 SDK 的库名由 AgoraRtcEngineKit 变更为 AgoraRtcKit。如果你由老版本的 SDK 升级至该版本，请务必重新导入类。详细步骤见《快速开始》中的[导入类](https://docs.agora.io/cn/Voice/start_call_mac?platform=macOS#a-nameimportclassa2-%E5%AF%BC%E5%85%A5%E7%B1%BB)章节。

同时，为提升开发体验，该版本新增动态库支持。你可以在静态库和动态库之间任选一个进行集成，其中动态库的包名为 Agora_Native_SDK_for_macOS_v3_0_0_VOICE_Dynamic。

使用动态库可以提高库的安全等级，方便 app 上传至 App Store，且避免与第三方库产生不兼容等问题。如果选择动态库，则需要重新进行集成并导入类。该步骤大约需要 5 分钟。详见《快速开始》中的[集成 SDK](https://docs.agora.io/cn/Voice/start_call_mac?platform=macOS#a-nameintegratesdka%E9%9B%86%E6%88%90-sdk) 和[导入类](https://docs.agora.io/cn/Voice/start_call_mac?platform=macOS#a-nameimportclassa2-%E5%AF%BC%E5%85%A5%E7%B1%BB)章节。

<div class="alert info">下表展示分别使用动态库和静态库生成 ipa 文件过程中各文件体积的差异：

<table>
    <tr>
        <td width="12%"><b>库类型</b></td>
        <td width="12%"><b>ipa 体积 (M)</b></td>
        <td width="15%"><b>解压后体积 (M)</b></td>
        <td width="19%"><b>Frameworks 文件夹体积 (M)</b></td>
        <td width="17%"><b>二进制文件体积 (M)</b></td>
        <td width="25%"><b>Frameworks 文件夹 + 二进制文件总体积 (M)</b></td>
    </tr>
    <tr>
        <td>动态库</td>
        <td>27</td>
        <td>56.6</td>
        <td>44</td>
        <td>2.4</td>
        <td>46.4</td>
    </tr>
    <tr>
        <td>静态库</td>
        <td>26.5</td>
        <td>55.3</td>
        <td>30.1</td>
        <td>15.1</td>
        <td>45.2</td>
    </tr>
</table>
	使用动态库集成时，SDK 不再存放于二进制文件中，而是作为一个独立的库存放在 Frameworks 文件夹中。与使用静态库集成相比，二进制文件体积减少了 12.7 M，Frameworks 文件夹体积增加了 13.9 M。
</div>

**新增特性**

#### 1. 多频道管理

为方便用户在同一时间加入多个频道，该版本新增了 [`AgoraRtcChannel`](./API%20Reference/oc/Classes/AgoraRtcChannel.html) 和 [`AgoraRtcChannelDelegate`](./API%20Reference/oc/Protocols/AgoraRtcChannelDelegate.html) 类。通过创建多个 `AgoraRtcChannel` 对象，用户可以加入各 `AgoraRtcChannel` 对象对应的频道中，实现多频道功能。

加入多个频道后，用户可以同时接收多个频道的流，但只能同时在一个频道内发流。该功能适用于用户需要同时接收多个频道的流，或频繁切换频道发流的场景。详细的集成步骤和注意事项，请参考[加入多频道](./multiple_channel_apple)。

#### 2. 调节本地播放的指定远端用户音量

该版本新增 [`adjustUserPlaybackSignalVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustUserPlaybackSignalVolume:volume:) 方法，用以调节本地用户听到的指定远端用户的音量。通话或直播过程中，你可以多次调用该方法，来调节多个远端用户在本地播放的音量，或对某个远端用户在本地播放的音量调节多次。

**改进**

#### 1. 音频编码属性

为满足更高音质需求，该版本调整了直播场景下 `AgoraAudioProfileDefault(0)` 对应的音频编码属性，详见下表：

| SDK 版本   | `AgoraAudioProfileDefault(0)`                               |
| :--------- | :---------------------------------------------------------- |
| 3.0.0      | 48 KHz 采样率，音乐编码，单声道，编码码率最大值为 52 Kbps。 |
| 3.0.0 之前 | 32 KHz 采样率，音乐编码，单声道，编码码率最大值为 44 Kbps。 |

#### 2. 质量透明

为方便开发者获取更多通话统计信息，该版本在 [`AgoraChannelStats`](./API%20Reference/oc/Classes/AgoraChannelStats.html) 类中新增 `gatewayRtt`、`memoryAppUsageRatio`、`memoryTotalUsageRatio` 和 `memoryAppUsageInKbytes` 成员，方便更好地监控通话的质量和通话过程中的内存变动。

#### 3. 其他提升

该版本自动开启直播场景下 Native SDK 与 Web SDK 的互通，并废弃原有的 `enableWebSdkInteroperability` 方法。

**问题修复**

- 修复了混音、音频录制、音频编码、回声等音频问题。
- 修复了特定场景下偶现的 app 崩溃、日志文件、推流不稳定等问题。

**API 变更**

#### 行为变更

该版本修改了 macOS 设备连接耳机或蓝牙时的音频路由。修改后的语音路由与 macOS 设备管理器中显示的一致。

#### 新增

- [`AgoraRtcAudioVolumeInfo`](./API%20Reference/oc/Classes/AgoraRtcAudioVolumeInfo.html) 结构体新增 `channelId` 成员
- [`createRtcChannel`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/createRtcChannel:)
- [`AgoraRtcChannel`](./API%20Reference/oc/Classes/AgoraRtcChannel.html) 类
- [`AgoraRtcChannelDelegate`](./API%20Reference/oc/Protocols/AgoraRtcChannelDelegate.html) 类
- [`AgoraChannelStats`](./API%20Reference/oc/Classes/AgoraChannelStats.html) 类中新增 `gatewayRtt`、`memoryAppUsageRatio`、`memoryTotalUsageRatio` 和 `memoryAppUsageInKbytes` 成员

#### 废弃

- `enableWebSdkInteroperability`
- `didAudioMuted`、`firstRemoteAudioFrameDecodedOfUid` 和 `firstRemoteAudioFrameOfUid`，使用 [`remoteAudioStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStateChangedOfUid:state:reason:elapsed:) 取代
- `streamPublishedWithUrl` 和 `streamUnpublishedWithUrl`，使用 [`rtmpStreamingChangedToState`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:rtmpStreamingChangedToState:state:errorCode:) 取代

## **2.9.1 版**

该版本于 2019 年 9 月 19 日发布。新增特性与修复问题列表详见下文。

**新增特性**

#### 人声检测

为判断本地用户是否说话，该版本在启用说话者音量提示 [`enableAudioVolumeIndication`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableAudioVolumeIndication:smooth:report_vad:) 方法中新增 bool 型的 `report_vad` 参数。启用该参数后，你会在 [`reportAudioVolumeIndicationOfSpeakers`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:reportAudioVolumeIndicationOfSpeakers:totalVolume:) 回调报告的 [`AgoraRtcAudioVolumeInfo`](./API%20Reference/oc/Classes/AgoraRtcAudioVolumeInfo.html) 结构体中获取本地用户的人声状态。

**改进**

#### 设置客户端录音采样率

为方便用户设置客户端录音的采样率，该版本废弃了原有的 `startAudioRecording` 方法，并使用新的同名方法进行取代。新的方法下，录音采样率可设为 16、32、44.1 或 48 kHz。原方法仅支持固定的 32 kHz 采样率，该版本继续保留原方法但我们不推荐使用。

**API 变更**

为提升用户体验，Agora SDK 在该版本中对 API 进行了如下变动：

#### 新增

- [`startAudioRecording`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startAudioRecording:sampleRate:quality:)
- [`enableAudioVolumeIndication`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableAudioVolumeIndication:smooth:report_vad:)，新增 `report_vad` 参数
- [`AgoraRtcAudioVolumeInfo`](./API%20Reference/oc/Classes/AgoraRtcAudioVolumeInfo.html) 类，新增 `vad` 成员

#### 废弃

- `startAudioRecording`

## **2.9.0 版**

该版本于 2019 年 8 月 16 日发布。新增特性与修复问题列表详见下文。

**升级必看**

#### 1. RTMP 推流

该版本起，Agora 删除如下接口：

- `configPublisher`

如果你的 App 使用上述接口实现 RTMP 推流功能，请确保将 Native SDK 升级至最新版本，并改用如下接口实现推流：

- [`setLiveTranscoding`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLiveTranscoding:)
- [`addPublishStreamUrl`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/addPublishStreamUrl:transcodingEnabled:)
- [`removePublishStreamUrl`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/removePublishStreamUrl:)
- [`rtmpStreamingChangedToState`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:rtmpStreamingChangedToState:state:errorCode:)

新的推流实现方法，详见[推流到 CDN](cdn_streaming_apple)。

#### 2. 关闭/开启本地音频采集

为提高通信场景下，本地用户关闭麦克风后听到的音质，该版本在 `enableLocalAudio`(true) 后，将系统音量修改为媒体音量。调用 `enableLocalAudio`(false) 后，系统音量自动切换为通话音量。

**新增特性**

#### 1. 快速切换频道

为方便直播频道中的观众用户快速切换到其他频道，该版本新增 [`switchChannelByToken`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/switchChannelByToken:channelId:joinSuccess:) 方法。和先调 [`leaveChannel`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/leaveChannel:)，再调 [`joinChannelByToken`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:) 相比，该方法能实现更快的频道切换。调用 [`switchChannelByToken`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/switchChannelByToken:channelId:joinSuccess:) 方法切换到其他直播频道后，本地会先收到离开原频道的回调 [`didLeaveChannelWithStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didLeaveChannelWithStats:)，再收到成功加入新频道的回调 [`didJoinChannel`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didJoinChannel:withUid:elapsed:)。

#### 2. 跨频道媒体流转发

跨频道媒体流转发，指将主播的媒体流转发至其他直播频道，实现主播跨频道与其他主播实时互动的场景。该版本新增如下接口，通过将源频道中的媒体流转发至目标频道，实现跨直播间连麦功能：

- [`startChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startChannelMediaRelay:)
- [`updateChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/updateChannelMediaRelay:)
- [`stopChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopChannelMediaRelay)

在跨频道媒体流转发过程中，SDK 会通过 [`channelMediaRelayStateDidChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:channelMediaRelayStateDidChange:error:) 和 [`didReceiveChannelMediaRelayEvent`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didReceiveChannelMediaRelayEvent:) 回调报告媒体流转发的状态和事件。

该场景的实现方法、API 调用时序、示例代码及开发注意事项，请参考 [跨直播间连麦](media_relay_apple) 指南。

#### 3. 本地及远端音频状态

为方便用户了解本地及远端的音频状态，该版本新增 [`localAudioStateChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioStateChange:error:) 和 [`remoteAudioStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStateChangedOfUid:state:reason:elapsed:) 回调。新的回调下，本地及远端音频有如下状态：

- 本地音频：Stopped(0)、Recording(1)、Encoding(2) 和 Failed(3)。状态为 Failed(3) 时，你可以通过 `error` 参数中返回的错误码定位及排查问题。
- 远端音频：Stopped(0)、Starting(1)、Decoding(2)、Frozen(3) 和 Failed(4)。你可以在 `reason` 参数中了解引起远端音频状态发生改变的原因。

#### 4. 本地音频数据

为方便更好地了解通话质量，获取更多质量相关数据，该版本新增 [`localAudioStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioStats:) 回调，通过 `numChannels`、`sentSampleRate`、`sentBitrate` 参数报告本地音频统计信息。

#### 5. 远端音频帧拉取

为提升音频播放体验，该版本新增如下接口，支持使用拉取的方式获取远端音频数据。App 可以对拉取到的原始音频数据进行处理后再渲染，获取想要的音频效果。

- [`enableExternalAudioSink`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableExternalAudioSink:channels:)
- [`disableExternalAudioSink`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/disableExternalAudioSink)
- [`pullPlaybackAudioFrameRawData`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pullPlaybackAudioFrameRawData:lengthInByte:)
- [`pullPlaybackAudioFrameSampleBufferByLengthInByte`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pullPlaybackAudioFrameSampleBufferByLengthInByte:)

该方法和 `onPlaybackAudioFrame` 回调相比，区别在于：

- `onPlaybackAudioFrame`：SDK 每 10 毫秒通过回调将音频数据传输给 App。如果 App 处理延时，可能会导致音频播放抖动。
- `pullPlaybackAudioFrameRawData` / `pullPlaybackAudioFrameSampleBufferByLengthInByte`：App 主动拉取音频数据。通过设置音频数据，SDK 可以调整缓存，帮助 App 处理延时，从而有效避免音频播放抖动。

**改进**

#### 1. 通话中质量透明

该版本进一步扩充了 [`AgoraChannelStats`](./API%20Reference/oc/Classes/AgoraChannelStats.html) 类的成员：

- `AgoraChannelStats` 类：累计发送音频/视频字节数及累计接收音频/视频字节数

#### 2. 其他改进

- 优化了 GameStreaming 场景下的音频质量。
- 优化了通信场景下用户关闭麦克风后听到的音质。

**问题修复**

#### 音频

- 修复了与 Web 互通时听声辨位过程中出现的声音失真的问题。
- 修复了测试麦克风时出现的崩溃问题。

#### 其他

- 修复了偶现的旁路推流串流的问题。

**API 变更**

为提升用户体验，Agora SDK 在该版本中对 API 进行了如下变动：

#### 新增

- [`enableExternalAudioSink`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableExternalAudioSink:channels:)
- [`disableExternalAudioSink`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/disableExternalAudioSink)
- [`pullPlaybackAudioFrameRawData`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pullPlaybackAudioFrameRawData:lengthInByte:)
- [`pullPlaybackAudioFrameSampleBufferByLengthInByte`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pullPlaybackAudioFrameSampleBufferByLengthInByte:)
- [`localAudioStateChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioStateChange:error:)
- [`remoteAudioStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStateChangedOfUid:state:reason:elapsed:)
- [`localAudioStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioStats:)
- [`switchChannelByToken`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/switchChannelByToken:channelId:joinSuccess:)
- [`startChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startChannelMediaRelay:)
- [`updateChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/updateChannelMediaRelay:)
- [`stopChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopChannelMediaRelay)
- [`channelMediaRelayStateDidChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:channelMediaRelayStateDidChange:error:)
- [`didReceiveChannelMediaRelayEvent`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didReceiveChannelMediaRelayEvent:)
- [`AgoraChannelStats`](./API%20Reference/oc/Classes/AgoraChannelStats.html) 类新增 `txAudioBytes` 和 `rxAudioBytes` 成员

#### 废弃

- [`didMicrophoneEnabled`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didMicrophoneEnabled:)，请改用 [`localAudioStateChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioStateChange:error:) 回调的 AgoraAudioLocalStateStopped(0) 或 AgoraAudioLocalStateRecording(1)。
- [`audioTransportStatsOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:audioTransportStatsOfUid:delay:lost:rxKBitRate:)，请改用 [`remoteAudioStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStats:) 回调。

#### 删除

- `configPublisher`

## **2.8.0 版**

该版本于 2019 年 7 月 8 日发布。新增特性与修复问题列表详见下文。

**新增特性**

#### 1. 全平台支持 String 型的用户 ID

很多 App 使用 String 类型的用户 ID。为降低开发成本，Agora 新增支持 String 型的 User account，方便用户通过如下接口直接使用 App 账号加入 Agora 频道：

- [registerLocalUserAccount](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/registerLocalUserAccount:appId:)
- [joinChannelByUserAccount](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByUserAccount:token:channelId:joinSuccess:)

对于其他接口，Agora 沿用 Int 型的 UID。Agora Engine 会维护 UID 和 User account 映射表，你可以随时通过 String user account 获取 UID，或者通过 UID 获取 String user account，无需自己维护映射表。

为保证通信质量，频道内所有用户需使用同一数据类型的用户 ID，即频道内的所有用户 ID 应同为 Int 型或同为 String 型。

**Note**：

- 同一频道内，Int 型的 User ID 和 String 型的 User account 不可混用。目前支持 String 型 User account 的 SDK 如下：

  - Native SDK：v2.8.0 及之后版本
  - Web SDK：v2.5.0 及之后版本

如果你的频道内有不支持 String 型 User account 的用户，则只能使用 Int 型的 User ID。

- 如果你使用该版本的 Native SDK 将用户 ID 升级至 String 型 User account，请确保所有终端用户同步升级。
- 如果使用 String 型的 User account，请确保你的服务端用户生成 Token 的脚本已升级至最新版本。如果使用 String 型 User account 加入频道，请确保使用该 User account 或其对应的 Int 型 UID 来生成 Token。你可以调用 `getUserInfoByUserAccount` 来获取 User account 所对应的 UID。

#### 2. 音频卡顿回调

为监控通话过程中的音频传输质量，方便开发者客观体验通信质量，该版本在远端音频统计数据 [AgoraRtcRemoteAudioStats](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) 类中新增 `totalFrozenTime` 和 `frozenRate` 成员，报告远端用户在加入频道后发生音频的卡顿时长及卡顿率。

同时，该版本在 [AgoraRtcRemoteAudioStats](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) 类中还新增 `numChannels`、`receivedSampleRate` 和 `receivedBitrate` 成员。

**改进**

为方便开发者统计掉线率，该版本在 [connectionChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:) 回调的 `AgoraConnectionChangedReason` 参数中添加 `AgoraConnectionChangedKeepAliveTimeout(14)` 成员，表示 SDK 与服务器连接保活超时，引起 SDK 连接状态发生改变。

**修复问题**

- 特定场景下偶现的崩溃问题。

**API 变更**

为提升用户体验，Agora 在 v2.8.0 版本中对 API 进行了如下变动：

#### 新增

- [registerLocalUserAccount](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/registerLocalUserAccount:appId:)
- [joinChannelByUserAccount](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByUserAccount:token:channelId:joinSuccess:)
- [getUserInfoByUid](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getUserInfoByUid:withError:)
- [getUserInfoByUserAccount](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getUserInfoByUserAccount:withError:)
- [didRegisteredLocalUser](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didRegisteredLocalUser:withUid:)
- [didUpdatedUserInfo](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didUpdatedUserInfo:withUid:)
- [AgoraRtcRemoteAudioStats](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) 类中新增 `numChannels`，`receivedSampleRate`，`receivedBitrate`，`totalFrozenTime` 和 frozenRate 成员

#### 废弃

- [AgoraLiveTranscoding](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html) 类中的 `lowLatency` 成员

## **2.4.1 版**

该版本于 2019 年 6 月 12 日发布。

该 SDK 首次发版。你可以参考以下文档集成 SDK，实现相应的实时音频功能：

- 快速集成
- 校验用户权限
- 检测通话质量
- 调整通话音量
- 播放音效/音乐混音
- 变声与混响
- 推流到 CDN
- 音频设备测试与切换
- [云代理服务](./cloudproxy_native)

如果你是由之前版本的 macOS 完整包升级到当前的纯音频包，可参考 [macOS 完整包发版说明](./release_mac_video)了解音频的相关改进。
