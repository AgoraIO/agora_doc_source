---
title: 发版说明
platform: iOS
updatedAt: 2021-03-29 03:52:12
---

本文提供 Agora 视频 SDK 的发版说明。

## **简介**

iOS 视频 SDK 支持两种主要场景:

- 音视频通话
- 音视频直播

点击 [语音通话产品概述](https://docs.agora.io/cn/Voice/product_voice?platform=All%20Platforms)、[视频通话产品概述](https://docs.agora.io/cn/Video/product_video?platform=All%20Platforms)、[音频互动直播产品概述](https://docs.agora.io/cn/Audio%20Broadcast/product_live_audio?platform=All%20Platforms)以及 [视频互动直播产品概述](https://docs.agora.io/cn/Interactive%20Broadcast/product_live?platform=All%20Platforms) 了解关键特性。

## **3.0.1 版**

该版本于 2020 年 5 月 22 日发布。

**升级必看**

#### 1. iOS 静态库升级动态库

为提升开发体验，该版本将 SDK 由静态库升级为动态库，不再支持静态库。使用动态库可以提高库的安全等级，方便 app 上传至 App Store，且避免与第三方库产生不兼容等问题。

如果你由之前版本的静态库升级为当前版本，需要重新集成。详细步骤请参考[集成 SDK](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_ios?platform=iOS#%E9%9B%86%E6%88%90-sdk)。

<div class="alert note">iOS 13.3.1 版本对动态库的支持有已知问题，已在 iOS 13.4 版本修复。</div>

#### 2. 视频观测位置 (C++)

自 v3.0.1 起，如果你想要获取 `onPreEncodeVideoFrame` 回调中的视频数据，除实现该回调外，还需要在 [`getObservedFramePosition`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#ad4c174389264630ffb1b2d24c6030013) 中将 `POSITION_PRE_ENCODER (1 << 2)` 设置为观测位置。

**新增特性**

#### 1. 调整音乐文件音调

为方便调整混音时音乐文件的播放音调，该版本新增 `setAudioMixingPitch` 方法。通过设置该方法的 `pitch` 参数，你可以升高或降低音乐文件的音调。该方法仅对音乐文件音调有效，对本地人声不生效。

#### 2. 变声与混响

为提高用户的音频体验，该版本在 `setLocalVoiceChanger` 和 `setLocalVoiceReverbPreset` 中分别新增以下枚举值：

- 新增了以 `AgoraAudioVoiceBeauty` 为前缀和以 `AgoraAudioGeneralBeautyVoice` 为前缀的枚举值，分别实现美音或语聊美声功能。
- 新增了以 `AgoraAudioReverbPresetFx` 为前缀的枚举值和 `AgoraAudioReverbPresetVirtualStereo`，分别实现增强版混响效果和虚拟立体声效果。

你可以查看进阶功能[变声与混响](voice_changer_apple)了解使用方法和注意事项。

#### 3. 人脸检测

该版本新增人脸检测功能。通过 `enableFaceDetection` 方法开启人脸检测后，SDK 会实时触发 `facePositionDidChangeWidth` 回调，向本地用户报告检测出的一系列结果，包括人脸距设备屏幕的距离。该功能可用于提醒用户注意用眼卫生，和屏幕保持一定距离。

#### 4. 全屏显示视频

为提高用户观看视频的体验，该版本在视频显示模式中新增 `AgoraVideoRenderModeFill(4)` 模式。设置该模式后，视频尺寸会进行缩放和拉伸直至充满显示视图。你可以在调用以下方法设置用户视图时选择该显示模式：

- `setupLocalVideo`
- `setupRemoteVideo`
- `setLocalRenderMode`
- `setRemoteRenderMode`

#### 5. 自渲染远端视图多频道支持

在多频道场景下，为方便通过 `AgoraRtcChannel` 类加入频道的用户使用视频自渲染功能，该版本在 `AgoraRtcChannel` 类新增 `setRemoteVideoRenderer` 和 `remoteVideoRendererOfUserId` 方法。

#### 6. 远端音视频数据后处理多频道支持

在多频道场景下，为方便后处理各频道的远端音视频数据，该版本新增如下 C++ 接口：

- `IAudioFrameObserver` 类中新增 [`isMultipleChannelFrameWanted`](./API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#a4b6bdf2a975588cd49c2da2b6eff5956) 和 [`onPlaybackAudioFrameBeforeMixingEx`](./API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#ab0cf02ba307e91086df04cda4355905b)。
- `IVideoFrameObserver` 类中新增 [`isMultipleChannelFrameWanted`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#aa6bf2611907a097ec359b83f1e3ba49a) 和 [`onRenderVideoFrameEx`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#ad325db8ee3a04e667e6db3d1a84f381d)。

成功注册音频或视频观测器后，如果你将 `isMultipleChannelFrameWanted` 的返回值设为 `true`，就可以通过上述回调获取多个频道对应的音频、视频数据。在多频道场景下，我们建议你将返回值设为 `true`。

**改进**

#### 设置视频观测位置 (C++)

成功注册视频观测器后，你可以在视频处理的各节点观测并获取想要的视频数据，如本地采集的视频数据，接收的远端视频数据等。为降低设备耗能，该版本允许自定义视频观测位置。你可以通过修改 [`getObservedFramePosition`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#ad4c174389264630ffb1b2d24c6030013) 的返回值，设置只观测以下某个或多个位置的视频数据：

- 本地采集的视频数据
- 接收远端发送的视频数据
- 本地编码前的视频数据

#### 其他改进

- 该版本优化了通话时的音频效果。频道中多个用户同时讲话时，不会减弱任何一方的音频效果。
- 该版本降低了对设备整体 CPU 的占用。

**问题修复**

- 修复了 `didRemoteAudioStateChanged` 回调不准、音频无声、混音、声音卡顿等问题
- 修复了通话无法正常结束、`didClientRoleChanged` 回调多次等问题

**API 变更**

该版本新增以下 API：

- [`setAudioMixingPitch`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setAudioMixingPitch:)
- [`AgoraAudioVoiceChanger`](./API%20Reference/oc/Constants/AgoraAudioVoiceChanger.html) 枚举中新增以 `AgoraAudioVoiceBeauty` 为前缀和以 `AgoraAudioGeneralBeautyVoice` 为前缀的枚举值
- [`AgoraAudioReverbPreset`](./API%20Reference/oc/Constants/AgoraAudioReverbPreset.html) 枚举中新增以 `AgoraAudioReverbPresetFx` 为前缀的枚举值，以及 `AgoraAudioReverbPresetVirtualStereo` 枚举值
- [`enableFaceDetection`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableFaceDetection:)
- [`facePositionDidChangeWidth`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:facePositionDidChangeWidth:previewHeight:faces:)
- [`AgoraVideoRenderMode`](./API%20Reference/oc/Constants/AgoraVideoRenderMode.html) 枚举中新增 `AgoraVideoRenderModeFill`
- `AgoraRtcChannel` 中新增 [`setRemoteVideoRenderer`](./API%20Reference/oc/Classes/AgoraRtcChannel.html#//api/name/setRemoteVideoRenderer:forUserId:) 和 [`remoteVideoRendererOfUserId`](./API%20Reference/oc/Classes/AgoraRtcChannel.html#//api/name/remoteVideoRendererOfUserId:)
- [`AgoraRtcRemoteAudioStats`](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) 中新增 `totalActiveTime`
- [`AgoraRtcRemoteVideoStats`](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html) 中新增 `totalActiveTime`

## **3.0.0.2 版**

该版本于 2020 年 4 月 22 日发布。

**新增特性**

#### 设置区域访问限制

该版本新增 `sharedEngineWithConfig` 方法，支持在创建 `AgoraRtcEngineKit` 实例时指定服务器的访问区域。该功能为高级设置，适用于有访问安全限制的场景。目前支持的区域有中国大陆、北美、欧洲、亚洲（中国大陆除外）和全球（默认）。

指定访问区域后，集成了 Agora SDK 的 app 在指定区域使用时，正常情况下会连接指定区域的 Agora 服务器；在非指定区域使用时，会从所在区域和指定区域的服务器地址中，择优选择服务器建立连接。

**问题修复**

该版本修复了无法连接蓝牙耳机的问题。

**API 变更**

#### 新增

[`sharedEngineWithConfig`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/sharedEngineWithConfig:delegate:)

## **3.0.0 版**

该版本于 2020 年 3 月 4 日发布。并于 2020 年 3 月 24 日修复了偶现的音频无声、混音、`didClientRoleChanged` 回调多次、崩溃等问题。

在该版本对通信场景采用了全新的系统架构，并升级了通信和直播场景下的 last mile 网络策略。在带宽不足时，新的网络策略能充分利用上下行有限带宽提升有效码率，从而增强弱网对抗能力，极大提升了弱网情况下通信和直播场景的终端用户体验。

由于通信场景采用了新的系统架构，为保证新老版本通信用户的互通兼容，我们使用了回退机制。如果频道内有老版本通信用户加入，则当前版本 (3.0.0) 的终端用户会回退成老版本通信。一旦回退，频道内所有用户都无法享受新版本带来的体验提升。因此我们强烈推荐同步升级所有终端用户到当前版本。

同时，我们对本地服务端录制进行了升级发布。为确保享受全新架构和网络策略优化带来的好处，使用本地服务端录制的客户，请务必同步升级本地服务端录制 SDK 至 3.0.0 版本。

新增特性、改进与问题修复详见下文。

**升级必看**

#### 1. 静态库更名与新增动态库

为与其他平台保持一致，该版本将 SDK 的库名由 AgoraRtcEngineKit 变更为 AgoraRtcKit。如果你由老版本的 SDK 升级至该版本，请务必重新导入类。详细步骤见《快速开始》中的[导入类](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_ios?platform=iOS#a-nameimportclassa2-%E5%AF%BC%E5%85%A5%E7%B1%BB)章节。

同时，为提升开发体验，该版本新增动态库支持。你可以在静态库和动态库之间任选一个进行集成，其中动态库的包名为 Agora_Native_SDK_for_iOS_v3_0_0_FULL_Dynamic。

使用动态库可以提高库的安全等级，方便 app 上传至 App Store，且避免与第三方库产生不兼容等问题。如果选择动态库，则需要重新进行集成并导入类。该步骤大约需要 5 分钟。详见《快速开始》中的[集成 SDK](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_ios?platform=iOS#%E9%9B%86%E6%88%90-sdk) 和[导入类](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_ios?platform=iOS#a-nameimportclassa2-%E5%AF%BC%E5%85%A5%E7%B1%BB)章节。

<div class="alert info">下表展示分别使用动态库和静态库生成 ipa 文件过程中各文件体积的差异：

<table>
    <tr>
        <td width="12%"><b>库类型</b></td>
        <td width="12%"><b>ipa 体积</b></td>
        <td width="15%"><b>解压后体积</b></td>
        <td width="19%"><b>Frameworks 文件夹体积</b></td>
        <td width="17%"><b>二进制文件体积</b></td>
        <td width="25%"><b>Frameworks 文件夹 + 二进制文件总体积</b></td>
    </tr>
    <tr>
        <td>动态库</td>
        <td>31.1 M</td>
        <td>65 M</td>
        <td>51.47 M</td>
        <td>2.4 M</td>
        <td>53.87 M</td>
    </tr>
    <tr>
        <td>静态库</td>
        <td>30.6 M</td>
        <td>63.7 M</td>
        <td>30.1 M</td>
        <td>22.5 M</td>
        <td>52.6 M</td>
    </tr>
</table>
	使用动态库集成时，SDK 不再存放于二进制文件中，而是作为一个独立的库存放在 Frameworks 文件夹中。与使用静态库集成相比，二进制文件体积减少了 20.1 M，Frameworks 文件夹体积增加了 21.37 M。
</div>

#### 2. 通信场景上行默认不开启视频小流

从该版本起，Agora 在通信频道场景下，默认不开启视频上行[小流](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-duala%E5%8F%8C%E6%B5%81%E6%A8%A1%E5%BC%8F)。如需开启，请在成功加入频道后，调用 [`enableDualStreamMode (YES)`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableDualStreamMode:) 方法启用视频双流模式。在多人视频通信场景下，我们建议你开启视频双流。

**新增特性**

#### 1. 多频道管理

为方便用户在同一时间加入多个频道，该版本新增了 [`AgoraRtcChannel`](./API%20Reference/oc/Classes/AgoraRtcChannel.html) 和 [`AgoraRtcChannelDelegate`](./API%20Reference/oc/Protocols/AgoraRtcChannelDelegate.html) 类。通过创建多个 `AgoraRtcChannel` 对象，用户可以加入各 `AgoraRtcChannel` 对象对应的频道中，实现多频道功能。

加入多个频道后，用户可以同时接收多个频道的流，但只能同时在一个频道内发流。该功能适用于用户需要同时接收多个频道的流，或频繁切换频道发流的场景。详细的集成步骤和注意事项，请参考[加入多频道](./multiple_channel_apple)。

#### 2. 视频原始数据

为方便开发者获取传输各阶段的视频原始数据，满足更多场景需求，该版本在 [`IVideoFrameObserver`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html) 类中新增如下 C++ 回调接口：

- [`onPreEncodeVideoFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a2be41cdde19fcc0f365d4eb14a963e1c)：获取前处理后、编码前的本地视频原始数据。该方法适用于有视频前处理需求的开发场景。
- [`getSmoothRenderingEnabled`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#aaa6c67373bb237a067318015749e8e51)：设置是否对获取的视频数据进行平滑处理。平滑处理后的视频帧，出帧时间间隔会更均匀，因此视频自渲染的体验更好。

#### 3. 调节本地播放的指定远端用户音量

该版本新增 [`adjustUserPlaybackSignalVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustUserPlaybackSignalVolume:volume:) 方法，用以调节本地用户听到的指定远端用户的音量。通话或直播过程中，你可以多次调用该方法，来调节多个远端用户在本地播放的音量，或对某个远端用户在本地播放的音量调节多次。

#### 4. 媒体播放器组件

为丰富直播玩法，Agora 发布了媒体播放器组件，支持主播在直播过程中，播放本地或在线媒体资源，并同步分享给频道内所有用户。详情请参考[媒体播放器组件发版说明](https://docs.agora.io/cn/Interactive%20Broadcast/mediaplayer_release_ios?platform=iOS)。

**改进**

#### 1. 音频编码属性

为满足更高音质需求，该版本调整了直播场景下 `AgoraAudioProfileDefault(0)` 对应的音频编码属性，详见下表：

| SDK 版本   | `AgoraAudioProfileDefault(0)`                               |
| :--------- | :---------------------------------------------------------- |
| 3.0.0      | 48 KHz 采样率，音乐编码，单声道，编码码率最大值为 52 Kbps。 |
| 3.0.0 之前 | 32 KHz 采样率，音乐编码，单声道，编码码率最大值为 52 Kbps。 |

#### 2. 镜像模式

为提升视频镜像的使用体验，该版本增加了视频编码镜像和视频渲染镜像的功能：

- 视频编码镜像：在 [`AgoraVideoEncoderConfiguration`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html) 结构体中，新增 `mirrorMode` 成员，方便设置本地视频编码的镜像模式，即远端看本地是否镜像。
- 视频渲染镜像：在 [`AgoraRtcVideoCanvas`](./API%20Reference/oc/Classes/AgoraRtcVideoCanvas.html) 结构体中，新增 `mirrorMode` 成员，方便用户在调用 [`setupLocalVideo`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setupLocalVideo:) 方法初始化本地视图时，设置本地看本地是否镜像，以及调用 [`setupRemoteVideo`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setupRemoteVideo:) 方法初始化远端视图时，设置本地看远端是否镜像；同时在 [`setLocalRenderMode`](./API%20Reference/oc/v3.0.0/Classes/AgoraRtcEngineKit.html#//api/name/setLocalRenderMode:mirrorMode:) 和 [`setRemoteRenderMode`](./API%20Reference/oc/v3.0.0/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteRenderMode:renderMode:mirrorMode:) 方法中新增 `mirrorMode` 参数，支持在通话中更新本地看本地，或本地看远端的镜像模式。

#### 3. 质量透明

为方便开发者获取更多通话统计信息，该版本在 [`AgoraChannelStats`](./API%20Reference/oc/Classes/AgoraChannelStats.html) 类中新增 `gatewayRtt`、`memoryAppUsageRatio`、`memoryTotalUsageRatio` 和 `memoryAppUsageInKbytes` 成员，方便更好地监控通话的质量和通话过程中的内存变动。

#### 4. 其他提升

该版本自动开启直播场景下 Native SDK 与 Web SDK 的互通，并废弃原有的 `enableWebSdkInteroperability` 方法。

**问题修复**

- 修复了混音、音频录制、音频编码、回声等音频问题。
- 修复了水印、视频画面比例、画质模糊、视频不能全屏、屏幕共享黑边等视频问题。
- 修复了特定场景下偶现的 app 崩溃、日志文件、推流不稳定等问题。

**API 变更**

#### 行为变更

该版本在调用 [`enableLocalAudio (NO)`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableLocalAudio:) 后，不会引起通话音量切换为媒体音量。

#### 新增

- [`setLocalRenderMode`](./API%20Reference/oc/v3.0.0/Classes/AgoraRtcEngineKit.html#//api/name/setLocalRenderMode:mirrorMode:)
- [`setRemoteRenderMode`](./API%20Reference/oc/v3.0.0/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteRenderMode:renderMode:mirrorMode:)
- [`AgoraVideoEncoderConfiguration`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html) 结构体新增 `mirrorMode` 成员
- [`AgoraRtcVideoCanvas`](./API%20Reference/oc/Classes/AgoraRtcVideoCanvas.html) 结构体新增 `channelId`、`mirrorMode` 成员
- [`AgoraRtcAudioVolumeInfo`](./API%20Reference/oc/Classes/AgoraRtcAudioVolumeInfo.html) 结构体新增 `channelId` 成员
- [`createRtcChannel`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/createRtcChannel:)
- [`AgoraRtcChannel`](./API%20Reference/oc/Classes/AgoraRtcChannel.html) 类
- [`AgoraRtcChannelDelegate`](./API%20Reference/oc/Protocols/AgoraRtcChannelDelegate.html) 类
- [`AgoraChannelStats`](./API%20Reference/oc/Classes/AgoraChannelStats.html) 类中新增 `gatewayRtt`、`memoryAppUsageRatio`、`memoryTotalUsageRatio` 和 `memoryAppUsageInKbytes` 成员

#### 废弃

- `enableWebSdkInteroperability`
- `setLocalRenderMode`¹，使用新的 [`setLocalRenderMode`](./API%20Reference/oc/v3.0.0/Classes/AgoraRtcEngineKit.html#//api/name/setLocalRenderMode:mirrorMode:) 取代
- `setRemoteRenderMode`¹，使用新的 [`setRemoteRenderMode`](./API%20Reference/oc/v3.0.0/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteRenderMode:renderMode:mirrorMode:) 取代
- `setLocalVideoMirrorMode`，使用 [`setupLocalVideo`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setupLocalVideo:) 和 [`setLocalRenderMode`](./API%20Reference/oc/v3.0.0/Classes/AgoraRtcEngineKit.html#//api/name/setLocalRenderMode:mirrorMode:) 中的 `mirrorMode` 取代
- `firstRemoteVideoFrameOfUid`，使用 [remoteVideoStateChangedOfUid](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStateChangedOfUid:state:reason:elapsed:) 取代
- `didAudioMuted`、`firstRemoteAudioFrameDecodedOfUid` 和 `firstRemoteAudioFrameOfUid`，使用 [`remoteAudioStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStateChangedOfUid:state:reason:elapsed:) 取代
- `streamPublishedWithUrl` 和 `streamUnpublishedWithUrl`，使用 [`rtmpStreamingChangedToState`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:rtmpStreamingChangedToState:state:errorCode:) 取代

## **2.9.3 版**

该版本于 2020 年 2 月 10 日发布。

该版本修复了如下问题：

- 通信场景下，调用 `setRemoteSubscribeFallbackOption` 方法也生效。
- 一对一通信场景下，下行音视频弱网下会回退为纯音频。
- 视频自采集场景下，接收到的视频分辨率在 app 切换前后台时发生改变。

## **2.9.1 版**

该版本于 2019 年 9 月 19 日发布。新增特性与修复问题列表详见下文。

**新增特性**

#### 1. 人声检测

为判断本地用户是否说话，该版本在启用说话者音量提示 [`enableAudioVolumeIndication`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableAudioVolumeIndication:smooth:report_vad:) 方法中新增 bool 型的 `report_vad` 参数。启用该参数后，你会在 [`reportAudioVolumeIndicationOfSpeakers`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:reportAudioVolumeIndicationOfSpeakers:totalVolume:) 回调报告的 [`AgoraRtcAudioVolumeInfo`](./API%20Reference/oc/Classes/AgoraRtcAudioVolumeInfo.html) 结构体中获取本地用户的人声状态。

#### 2. 摄像头采集方向

为方便用户在加入频道前选择使用前置或后置摄像头进行采集，该版本在 [`AgoraCameraCapturerConfiguration`](./API%20Reference/oc/Classes/AgoraCameraCapturerConfiguration.html) 类中新增 `AgoraCameraDirection` 成员变量。你可以通过 `AgoraCameraDirectionRear(1)` 或 `AgoraCameraDirectionFront(0)` 选择使用前置或后置摄像头。

#### 3. RGBA 视频原始数据

该版本新增支持 RGBA 格式的视频原始数据。你可以通过新增的 C++ 接口 [`getVideoFormatPreference`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a440e2a33140c25dfd047d1b8f7239369)，设置想要获取的视频原始数据的格式。

同时为提高开发体验，Agora 支持对 RGBA 格式的视频原始数据分别通过 C++ 接口 [`getRotationApplied`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#afd5bb439a9951a83f08d8c0a81468dcb) 和 [`getMirrorApplied`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#afc5cce81bf1c008e9335a0423ca45991) 进行旋转和镜像处理。

**改进**

#### 1. 直播水印

为提高直播水印的用户体验，解决视频方向模式为 `Adaptive` 时，水印位置和方向可能和预期不符的问题，该版本废弃了原有的 `addVideoWatermark` 接口，并使用一个新的同名接口进行取代。同名接口下，Agora 使用 [`WatermarkOptions`](./API%20Reference/oc/Classes/WatermarkOptions.html) 类对水印进行设置，其中：

- `visibleInPreview` 成员设置本地预览是否能看见水印。
- `positionInLandscapeMode`/`positionInPortraitMode` 成员设置视频编码横屏/竖屏模式时的水印坐标。

同时，该版本对水印功能的性能进行了优化。和之前版本相比，该功能的 CPU 占用降低了 5% - 20%。

#### 2. 设置客户端录音采样率

为方便用户设置客户端录音的采样率，该版本废弃了原有的 `startAudioRecording` 方法，并使用新的同名方法进行取代。新的方法下，录音采样率可设为 16、32、44.1 或 48 kHz。原方法仅支持固定的 32 kHz 采样率，该版本继续保留原方法但我们不推荐使用。

**问题修复**

#### 音频

- 偶现音频卡顿。
- 通话被第三方应用打断后，用户再回到频道时，音频异常。
- 进入频道后偶现回声。

#### 其他

- 修复了用户调用 [`joinChannelByUserAccount`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByUserAccount:token:channelId:joinSuccess:) 接口，在未成功加入频道前，进行切换网络操作，导致此后无法正常正常收到 [`didUpdatedUserInfo`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didUpdatedUserInfo:withUid:) 回调。
- 旁路推流串流。

**API 变更**

为提升用户体验，Agora SDK 在该版本中对 API 进行了如下变动：

#### 新增

- [`startAudioRecording`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startAudioRecording:sampleRate:quality:)
- [`addVideoWatermark`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/addVideoWatermark:options:)
- [`getVideoFormatPreference`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a440e2a33140c25dfd047d1b8f7239369)
- [`getRotationApplied`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#afd5bb439a9951a83f08d8c0a81468dcb)
- [`getMirrorApplied`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#afc5cce81bf1c008e9335a0423ca45991)
- [`enableAudioVolumeIndication`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableAudioVolumeIndication:smooth:report_vad:)，新增 `report_vad` 参数
- [`AgoraRtcAudioVolumeInfo`](./API%20Reference/oc/Classes/AgoraRtcAudioVolumeInfo.html) 类，新增 `vad` 成员
- [`AgoraCameraCapturerConfiguration`](./API%20Reference/oc/Classes/AgoraCameraCapturerConfiguration.html) 类，新增 `cameraDirection` 成员

#### 废弃

- `startAudioRecording`
- `addVideoWatermark`

## **2.9.0 版**

该版本于 2019 年 8 月 16 日发布。新增特性与修复问题列表详见下文。

**升级必看**

#### 1. RTMP 推流

该版本起，Agora 删除如下接口：

- `configPublisher`
- `setVideoCompositingLayout`
- `clearVideoCompositingLayout`

如果你的 App 使用上述接口实现 RTMP 推流功能，请确保将 Native SDK 升级至最新版本，并改用如下接口实现推流：

- [`setLiveTranscoding`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLiveTranscoding:)
- [`addPublishStreamUrl`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/addPublishStreamUrl:transcodingEnabled:)
- [`removePublishStreamUrl`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/removePublishStreamUrl:)
- [`rtmpStreamingChangedToState`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:rtmpStreamingChangedToState:state:errorCode:)

新的推流实现方法，详见[推流到 CDN](cdn_streaming_apple)。

#### 2. 远端视频状态

为方便用户了解远端视频状态，该版本删除了原有的 `remoteVideoStateChangedOfUid` 接口，并使用一个新的同名接口进行取代。新接口下， `state` 参数扩展为 Stopped(0)、Starting(1)、Decoding(2)、Frozen(3) 和 Failed(4)。同时，新接口还增加了 `reason` 参数，用以报告远端视频状态发生改变的原因。因此，如果你将 Native SDK 升级至该版本，请确保重新实现 [`remoteVideoStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStateChangedOfUid:state:reason:elapsed:) 接口。

同时，扩展后的 `state` 参数和新增的 `reason` 参数搭配使用，可以涵盖大部分远端视频状态，因此该版本废弃了如下接口。你可以继续使用这些接口，但我们不再推荐。详细的取代方案，请参考 API 文档：

- [`didVideoEnabled`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didVideoEnabled:byUid:)
- [`didLocalVideoEnabled`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didLocalVideoEnabled:byUid:)
- [`firstRemoteVideoDecodedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:firstRemoteVideoDecodedOfUid:size:elapsed:)

<div class="alert note">该回调的触发时机与老的 <code>remoteVideoStateChangedOfUid</code> 回调不同。新接口只有在远端视频流状态发生改变时，才会触发。</div>

#### 3. 关闭/开启本地音频采集

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

该版本进一步扩充了 [`AgoraChannelStats`](./API%20Reference/oc/Classes/AgoraChannelStats.html)、[`AgoraRtcLocalVideoStats`](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html) 和 [`AgoraRtcRemoteVideoStats`](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html) 类的成员。各类新增成员如下：

- `AgoraChannelStats` 类：累计发送音频/视频字节数及累计接收音频/视频字节数
- `AgoraRtcLocalVideoStats` 类：本地视频的编码码率、宽高、发送帧数及编码类型
- `AgoraRtcRemoteVideoStats` 类：远端视频在网络对抗后的丢包率

#### 2. 直播视频质量提升

该版本改善了弱网条件下直播视频卡顿问题，提升了画面清晰度，优化了网络极端丢包情况下的直播画面流畅度。

#### 3. 其他改进

- 优化了 GameStreaming 场景下的音频质量。
- 优化了通信场景下用户关闭麦克风后听到的音质。

**问题修复**

#### 音频

- 修复了与 Web 互通时听声辨位过程中出现的声音失真的问题。
- 修复了特殊场景下直播观众设置 Audio Session 为 Playback 后出现的音频卡顿问题。
- 修复了听声辨位场景下，Web 端加入频道后，听不到声音的问题。

#### 视频

- 修复了加入频道后设置视频编码属性时偶现的崩溃问题。
- 修复了加入频道后反复切换视频编码分辨率时出现的崩溃问题。

#### 其他

- 修复了偶现的旁路推流串流的问题。
- 修复了调用 [`leaveChannel`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/leaveChannel:) 后崩溃的问题。

**API 变更**

为提升用户体验，Agora SDK 在该版本中对 API 进行了如下变动：

#### 新增

- [`enableExternalAudioSink`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableExternalAudioSink:channels:)
- [`disableExternalAudioSink`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/disableExternalAudioSink)
- [`pullPlaybackAudioFrameRawData`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pullPlaybackAudioFrameRawData:lengthInByte:)
- [`pullPlaybackAudioFrameSampleBufferByLengthInByte`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pullPlaybackAudioFrameSampleBufferByLengthInByte:)
- [`localAudioStateChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioStateChange:error:)
- [`remoteAudioStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStateChangedOfUid:state:reason:elapsed:)
- [`remoteVideoStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStateChangedOfUid:state:reason:elapsed:)
- [`localAudioStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioStats:)
- [`switchChannelByToken`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/switchChannelByToken:channelId:joinSuccess:)
- [`startChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startChannelMediaRelay:)
- [`updateChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/updateChannelMediaRelay:)
- [`stopChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopChannelMediaRelay)
- [`channelMediaRelayStateDidChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:channelMediaRelayStateDidChange:error:)
- [`didReceiveChannelMediaRelayEvent`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didReceiveChannelMediaRelayEvent:)
- [`AgoraChannelStats`](./API%20Reference/oc/Classes/AgoraChannelStats.html) 类新增 `txAudioBytes`，`txVideoBytes`，`rxAudioBytes` 和 `rxVideoBytes` 成员
- [`AgoraRtcLocalVideoStats`](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html) 类新增 `encodedBitrate`，`encodedFrameWidth`，`encodedFrameHeight`，`encodedFrameCount` 和 `codedType` 成员
- [`AgoraRtcRemoteVideoStats`](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html) 类新增 `packetLossRate` 成员

#### 废弃

- [`didMicrophoneEnabled`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didMicrophoneEnabled:)，请改用 [`localAudioStateChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioStateChange:error:) 回调的 AgoraAudioLocalStateStopped(0) 或 AgoraAudioLocalStateRecording(1)。
- [`audioTransportStatsOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:audioTransportStatsOfUid:delay:lost:rxKBitRate:)，请改用 [`remoteAudioStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStats:) 回调。
- [`videoTransportStatsOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:videoTransportStatsOfUid:delay:lost:rxKBitRate:)，请改用 [`remoteVideoStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStats:) 回调。
- [`didVideoEnabled`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didVideoEnabled:byUid:)，请改用 [`remoteVideoStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStateChangedOfUid:state:reason:elapsed:) 回调的：
  - AgoraVideoRemoteStateStopped(0) 和 AgoraVideoRemoteStateReasonRemoteMuted(5)。
  - AgoraVideoRemoteStateDecoding(2) 和 AgoraVideoRemoteStateReasonRemoteUnmuted(6)。
- [`didLocalVideoEnabled`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didLocalVideoEnabled:byUid:)，请改用 [`remoteVideoStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStateChangedOfUid:state:reason:elapsed:) 回调的：
  - AgoraVideoRemoteStateStopped(0) 和 AgoraVideoRemoteStateReasonRemoteMuted(5)。
  - AgoraVideoRemoteStateDecoding(2) 和 AgoraVideoRemoteStateReasonRemoteUnmuted(6)。
- [`firstRemoteVideoDecodedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:firstRemoteVideoDecodedOfUid:size:elapsed:)，请改用 [`remoteVideoStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStateChangedOfUid:state:reason:elapsed:) 回调的 AgoraVideoRemoteStateStarting(1) 和 AgoraVideoRemoteStateDecoding(2)。

#### 删除

- `configPublisher`
- `setVideoCompositingLayout`
- `clearVideoCompositingLayout`
- `remoteVideoStateChangedOfUid`

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

#### 2. 音视频卡顿回调

为监控通话过程中的音视频传输质量，方便开发者客观体验通信质量，该版本在远端音频统计数据 [AgoraRtcRemoteAudioStats](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) 类和远端视频统计数据 [AgoraRtcRemoteVideoStats](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html) 类中新增 `totalFrozenTime` 和 `frozenRate` 成员，报告远端用户在加入频道后发生音视频的卡顿时长及卡顿率。

同时，该版本在 [AgoraRtcRemoteAudioStats](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) 类中还新增 `numChannels`、`receivedSampleRate` 和 `receivedBitrate` 成员。

**改进**

为方便开发者统计掉线率，该版本在 [connectionChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:) 回调的 `AgoraConnectionChangedReason` 参数中添加 `AgoraConnectionChangedKeepAliveTimeout(14)` 成员，表示 SDK 与服务器连接保活超时，引起 SDK 连接状态发生改变。

**问题修复**

- 修复了 `setRemoteSubscribeFallbackOption` 行为不符预期的问题。
- 修复了调用 `MediaIO` 类下方法时偶现的死循环问题。

**API 变更**

为提升用户体验，Agora 在 v2.8.0 版本中对 API 进行了如下变动：

#### 新增

- [registerLocalUserAccount](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/registerLocalUserAccount:appId:)
- [joinChannelByUserAccount](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByUserAccount:token:channelId:joinSuccess:)
- [getUserInfoByUid](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getUserInfoByUid:withError:)
- [getUserInfoByUserAccount](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getUserInfoByUserAccount:withError:)
- [didRegisteredLocalUser](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didRegisteredLocalUser:withUid:)
- [didUpdatedUserInfo](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didUpdatedUserInfo:withUid:)
- [AgoraRtcRemoteAudioStats](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) 类中新增 `numChannels`，`receivedSampleRate`，`receivedBitrate`，`totalFrozenTime` 和 `frozenRate` 成员
- [AgoraRtcRemoteVideoStats](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html) 类中新增 `totalFrozenTime` 和 `frozenRate` 成员

#### 废弃

- [AgoraLiveTranscoding](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html) 类中的 `lowLatency` 成员

## **2.4.1 版**

该版本于 2019 年 6 月 12 日发布。新增特性、功能改进与修复问题列表详见下文。

**升级必看**

如下内容涉及 SDK 的行为变更。如果你是由之前版本的 SDK 升级至该版本，升级前请务必阅读。

#### 1. RTMP 推流

为提高推流服务的易用性，该版本对推流接口的参数设置进行了如下限制：

| 类**/**接口                                                                                                                   | 参数限制                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| ----------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [AgoraLiveTranscoding](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html) 类                                             | <li>[videoFrameRate](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html#//api/name/videoFramerate)：设置转码推流的帧率，单位为 fps，取值范围为 [0, 30]，默认值为 15。如果设值超过 30，Agora 服务端会自动调整为 30<li>[videoBitrate](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html#//api/name/videoBitrate)：设置转码推流的码率，单位为 Kbps，默认值为 400。用户可以根据 [Video Profile 参考表](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/bitrate)中的码率值进行设置。如果设置的码率超出合理范围，服务端会在合理区间内对码率值进行自适应<li>[videoCodecProfile](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html#//api/name/videoCodecProfile)：设置转码推流的视频编码规格，可设为 **BASELINE**、**MAIN** 或 **HIGH**。若设为其他值，服务端会改为默认值 **HIGH**<li>[size](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html#//api/name/size)：设置转码推流的视频分辨率。size 的最小值不低于 16 x 16</li> |
| [AgoraImage](./API%20Reference/oc/Classes/AgoraImage.html) 类                                                                 | `url`：字符长度不得超过 **1024** 字节                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| [addPublishStreamUrl](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/addPublishStreamUrl:transcodingEnabled:) | `url`：字符长度不得超过 **1024** 字节                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| [removePublishStreamUrl](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/removePublishStreamUrl:)              | `url`：字符长度不得超过 **1024** 字节                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |

同时，该版本在 `LiveTranscoding` 类中新增 [audioCodecProfile](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html#//api/name/audioCodecProfile) 参数，支持设置音频编码的规格。默认规格为 LC-AAC。

此外，该版本还对 [streamPublishedWithUrl](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/removePublishStreamUrl:) 方法的 `errorCode` 参数新增了五个错误码，方便快速定位与排查问题。

#### 2、RemoteVideoStats 类参数更名

为更精准地表达远端视频流的统计信息，该版本将 [AgoraRtcRemoteVideoStats](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html) 类中的 `receivedFrameRate` 参数更名为 [rendererOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html#//api/name/rendererOutputFrameRate)。

**新增特性**

#### 1、添加媒体附属信息

常见的直播场景中，主播给观众分发商品链接、优惠券、在线答题等，能构建更为丰富的直播互动方式。为满足该部分社交类直播 App 开发者的需求，该版本新增 [setMediaMetadataSource](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setMediaMetadataDataSource:withType:) 和 [setMediaMetadataDelegate](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setMediaMetadataDelegate:withType:) 接口以及 [AgoraMediaMetadataDataSource](./API%20Reference/oc/Protocols/AgoraMediaMetadataDataSource.html) 和 [AgoraMediaMetadataDelegate](./API%20Reference/oc/Protocols/AgoraMediaMetadataDelegate.html) 协议，目前允许主播在发出的视频帧中添加 Metadata，发送媒体附属信息。

#### 2、本地视频状态回调

为方便开发者了解本地视频状态，该版本新增 [localVideoStateChange](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localVideoStateChange:error:) 回调。该回调下，本地视频有 `Stopped`、`Capturing`、`Encoding` 和 `Failed` 四种状态。当本地视频状态为 `Failed` 时，用户可以参考该回调 `error` 参数返回的错误码进行问题排查。该回调能帮助开发者辨别本地视频故障是由采集还是编码引起的。原有的 `rtcEngineCameraDidReady` 和 `rtcEngineVideoDidStop` 回调在该版本废弃，我们不再推荐。

#### 3、推流状态回调

为方便推流用户了解当前的推流状态，并在推流出错时了解原因排查问题，该版本新增 [rtmpStreamingChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:rtmpStreamingChangedToState:state:errorCode:) 回调。该回调下，推流有 `Idle`、`Connecting`、`Running`、`Recovering` 和 `Failure` 五种状态。当推流状态为 FAILURE 时，用户可以参考该回调 `errCode` 参数返回的错误码进行问题排查。原有的 `streamPublishedWithUrl` 和 `streamUnpublishedWithUrl` 回调仍可以使用，但我们不再推荐。

#### 4、网络连接失败原因梳理

为方便开发者更好地排查网络连接相关故障，该版本梳理并整合了网络连接相关的错误码，在原有 [connectionChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:) 回调的 `reason` 参数中新增八个导致网络连接失败的原因。新增后，只要网络连接发生错误，SDK 都会返回该回调。同时该版本废弃了原有的警告码 `AgoraWarningCodeLookupChannelRejected(105)` 和错误码 `AgoraErrorCodeTokenExpired(109)`、`AgoraErrorCodeInvalidToken(110)`。

#### 5、本地网络连接类型回调

为方便用户了解本地网络的连接类型，该版本新增 [networkTypeChangedToType](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:networkTypeChangedToType:) 回调。该回调下，本地网络连接有 `Unknown`、`Disconnected`、`Lan` `Wifi`、`2G`、`3G`、`4G` 七种类型。当网络连接短暂中断时，该回调能帮助开发者辨别引起中断的原因是网络切换还是网络条件不好。

#### 6、获取播放伴奏音量

为方便开发者获取伴奏的播放音量，排查音量相关问题，该版本新增 [getAudioMixingPlayoutVolume](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPlayoutVolume:) 和 [getAudioMixingPublishVolume](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPublishVolume:) 方法，用以分别获取音乐文件在本地和远端的播放音量。

#### 7、精确回调远端音频首帧解码

为更精准地获取远端用户的出声时间，该版本新增 [firstRemoteAudioFrameDecodedOfUid](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:firstRemoteAudioFrameDecodedOfUid:elapsed:) 回调，用以向 App 层报告 SDK 已完成远端音频首帧解码。在远端用户加入频道后首次发送音频，或远端用户 15 秒不发音频后再次发送时，该回调均会被触发。该回调与 `firstRemoteAudioFrameOfUid` 的区别在于，`firstRemoteAudioFrameOfUid` 在收到首个音频包时触发，先于 `firstRemoteAudioDecodedOfUid`。

**改进**

#### 1、在线音效叠加

为提高用户体验，构造丰富有趣的实时音视频场景，该版本新增支持同时播放多个**在线**音效文件。开发者可以通过多次调用 [playEffect](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/playEffect:filePath:loopCount:pitch:pan:gain:publish:) 方法，传入不同的在线音效文件的 URL，实现音效叠加。

#### 2、质量透明

- 该版本在通话相关的统计信息 [AgoraChannelStats](./API%20Reference/oc/Classes/AgoraChannelStats.html) 类中，新增 [txPacketLossRate](./API%20Reference/oc/Classes/AgoraChannelStats.html#//api/name/txPacketLossRate) 和 [rxPacketLossRate](./API%20Reference/oc/Classes/AgoraChannelStats.html#//api/name/rxPacketLossRate) 参数，分别返回本地客户端到服务器和服务器到本地客户端的丢包率。
- 该版本对 AgoraLocalVideoStats 和 AgoraRemoteVideoStats 类作了如下变动，方便用户更精准地获取本地和远端视频流的统计信息：
  - [AgoraRtcLocalVideoStats](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html)：新增 [encoderOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html#//api/name/encoderOutputFrameRate) 和 [rendererOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html#//api/name/rendererOutputFrameRate) 参数
  - [AgoraRtcRemoteVideoStats](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html)：新增 [decoderOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html#//api/name/decoderOutputFrameRate) 参数，并将原有的 receivedFrameRate 参数更名为 [rendererOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html#//api/name/rendererOutputFrameRate)

#### 3、美颜优化

为提升美颜效果，该版本结合主观测试的结果，对美颜选项 [AgoraBeautyOptions](./API%20Reference/oc/Classes/AgoraBeautyOptions.html) 类中的各参数添加了默认值；同时，该版本优化了美颜算法的性能。声网实验室报告显示，优化后的算法下，GPU 消耗和 CPU 消耗均有不同程度的下降，功耗优化约 40% - 50%。

#### 4、其他改进

- 优化了[AgoraAudioScenario](./API%20Reference/oc/Constants/AgoraAudioScenario.html) 为 `GameStreaming` 时的音质效果
- 优化了部分场景下语音和视频的延时
- SDK 包大小降低约 0.5 M
- 提高了用户修改视频属性的码率后，网络质量打分的准确性
- 默认启用音频质量通知回调。开发者无需调用 enableAudioQualityIndication 方法，也可以收到 [remoteAudioStats](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStats:) 回调
- 提升了视频服务的稳定性
- 提升了推流服务的稳定性

**问题修复**

#### 音频

- 修复了音频被 Siri 打断且无法恢复的问题

#### 视频

- 修复了相机采集曝光的问题
- 修复了智能手表上不显示远端画面的问题

#### 其他

- 修复了用户退出频道后仍然收到 `networkQuality` 回调的问题
- 修复了偶现的崩溃问题，提升了系统稳定性

**API 变更**

为提升用户体验，Agora 在 v2.4.1 版本中对 API 进行了如下变动：

#### 全平台 C++ 接口行为一致

从该版本起，Native SDK 保证了各平台 C++ 接口的行为一致性，方便用户通过统一的 C++ 接口，在各平台保持业务逻辑一致。同时在 C++ 头文件的 `IRtcEngine` 类中实现了 `RtcEngineParameters` 类下的所有方法。各接口的适用范围及使用注意事项详见 [Agora C++ API Reference for All Platforms 首页](./API%20Reference/cpp/index.html)。

#### 新增

- [getAudioMixingPlayoutVolume](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getAudioMixingPlayoutVolume)
- [getAudioMixingPublishVolume](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getAudioMixingPublishVolume)
- [firstRemoteAudioFrameDecodedOfUid](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:firstRemoteAudioFrameDecodedOfUid:elapsed:)
- [localVideoStateChange](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localVideoStateChange:error:)
- [networkTypeChangedToType](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:networkTypeChangedToType:)
- [rtmpStreamingChangedToStats](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:rtmpStreamingChangedToState:state:errorCode:)
- [setMediaMetadataSource](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setMediaMetadataDataSource:withType:)
- [setMediaMetadataDelegate](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setMediaMetadataDelegate:withType:)
- [AgoraMediaMetadataSource](./API%20Reference/oc/Protocols/AgoraMediaMetadataDataSource.html)
- [AgoraMediaMetadataDelegate](./API%20Reference/oc/Protocols/AgoraMediaMetadataDelegate.html)
- `AgoraLiveTranscoding` 类新增参数 [audioCodecProfile](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html#//api/name/audioCodecProfile)
- `AgoraChannelStats` 类新增参数 [txPacketLossRate](./API%20Reference/oc/Classes/AgoraChannelStats.html#//api/name/txPacketLossRate) 和 [rxPacketLossRate](./API%20Reference/oc/Classes/AgoraChannelStats.html#//api/name/rxPacketLossRate)
- `AgoraRtcLocalVideoStats` 类新增参数 [encoderOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html#//api/name/encoderOutputFrameRate) 和 [rendererOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html#//api/name/rendererOutputFrameRate)
- `AgoraRtcRemoteVideoStats` 类新增参数 [decoderOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html#//api/name/decoderOutputFrameRate) 和 [rendererOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html#//api/name/rendererOutputFrameRate)（替换 receivedFrameRate）

#### 废弃

- `enableAudioQualityIndication`
- `rtcEngineCameraDidReady`，请改用 [localVideoStateChange](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localVideoStateChange:error:) 回调中的 AgoraLocalVideoStreamStateCapturing(1)
- `rtcEngineVideoDidStop`，请改用 [localVideoStateChange](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localVideoStateChange:error:) 回调中的 AgoraLocalVideoStreamStateStopped(0)
- 警告码 `AgoraWarningCodeLookupChannelRejected(105)`，请改用 [connectionChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:) 回调中的 AgoraConnectionChangedRejectedByServer(10)
- 错误码 `AgoraErrorCodeTokenExpired(109)`，请改用 [connectionChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:) 回调中的 AgoraConnectionChangedTokenExpired(9)
- 错误码 `AgoraErrorCodeInvalidToken(110)`，请改用 [connectionChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:) 回调中的 AgoraConnectionChangedInvalidToken(8)
- 错误码 `AgoraErrorCodeStartCamera(1003)`，请改用 [localVideoStateChange](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localVideoStateChange:error:) 回调中的 AgoraLocalVideoStreamErrorCaptureFailure(4)

## 2.4.0 版及之前

**2.4.0 版**

该版本于 2019 年 4 月 1 日发布。新增特性、功能改进与修复问题列表详见下文。

#### **升级必看**

- Agora Video SDK for iOS 在 2.4.0 版本新增 `CoreML.framework` 库依赖。请确保在集成时添加该库，详见《快速开始》。
- 如果你希望通过 CocoaPods 自动导入库，请确保在运行 `pod install` 前，先运行 `pop update` 更新本地 CocoaPods 库。如果你希望通过指定 SDK 版本号获取最新版，请在 Podfile 中将版本号指定为 `'AgoraRtcEngnine_iOS', '2.4.0.1'`。

#### **新增特性**

##### 1. 美颜

常见的视频社交、在线教育和连麦直播等场景中，用户普遍希望有基础的美颜功能。该版本新增接口 [`setBeautyEffectOptions`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setBeautyEffectOptions:options:)，用户可以调用该接口设置对比度、亮度、平滑度等参数，达到美白、磨皮、红润肤色等美颜效果。详情请参考[美颜](image_enhancement_ios)。

##### 2. 变声和混响

在语音聊天室场景中添加变声和混响效果，能有效增强社交的趣味性。该版本在原有音效设置接口的基础上，新增 [`setLocalVoiceChanger`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceChanger:) 和 [`setLocalVoiceReverbPreset`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceReverbPreset:) 方法，开发者无需手动设置音效参数，直接选择想要的本地语音变声或混响效果。详情请参考[变声与混响](voice_changer_apple)。

##### 3. 听声辨位

该版本新增 [`enableSoundPositionIndication`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/enableSoundPositionIndication:) 和 [`setRemoteVoicePosition`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteVoicePosition:pan:gain:) 方法，支持本地用户听声辨位。用户需要在加入频道前调用 [`enableSoundPositionIndication`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/enableSoundPositionIndication:) 开启远端用户的语音立体声，然后在 [`setRemoteVoicePosition`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteVoicePosition:pan:gain:) 中设置远端用户声音出现的位置，通过左右耳听到的声音差异，对远端用户的声音产生方位感。在多人在线游戏场景，如射击游戏中，该功能可以增加游戏角色的方位感，模拟真实场景。

##### 4. 通话前 Last-mile 网络探测

在通话前进行 Last-mile 网络探测，可以有效帮助本地用户判断和预测上行网络质量是否良好。该版本新增通话前 Last-mile 网络探测接口 [`startLastmileProbeTest`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/startLastmileProbeTest:)、[`stopLastmileProbeTest`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/stopLastmileProbeTest) 及 [`lastmileProbeResult`](./API%20Reference/oc/v2.4/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileProbeTestResult:)，向用户反馈开始通话前上下行网络的带宽、丢包、网络抖动和往返时延数据。

##### 5. 设置用户媒体流优先级

该版本新增接口 [`setRemoteUserPriority`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteUserPriority:type:) 用于设置远端用户媒体流的优先级。该方法可以与 [`setRemoteSubscribeFallbackOption`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteSubscribeFallbackOption:) 搭配使用。如果开启了订阅流回退选项，弱网下 SDK 会优先保证高优先级用户收到的流的质量。

##### 6. 音乐文件播放状态

该版本为播放音乐文件新增回调 [`localAudioMixingStateDidChanged`](./API%20Reference/oc/v2.4/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioMixingStateDidChanged:errorCode:)，方便用户获知音乐文件的播放状态（成功/失败），以及播放出错的原因。同时新增一个警告码 701，当播放音乐文件时，本地音乐文件不存在、文件格式不支持或无法访问在线音乐文件 URL 时，均会触发该警告码。

##### 7. 设置日志文件大小

Agora SDK 有 2 个日志文件，每个文件默认大小为 512 KB。为解决该大小无法满足部分用户需求的问题，该版本新增接口 [`setLogFileSize`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setLogFileSize:)，用于设置 SDK 输出的日志文件大小。

##### 8. 云代理服务

支持使用云代理服务，方便部署企业防火墙的用户正常使用 Agora 的服务，详见[使用云代理服务](cloudproxy_native)。

#### **功能改进**

##### 1. 质量测试与透明

- 该版本使用新的 [`startEchoTestWithInterval`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/startEchoTestWithInterval:successBlock:) 接口取代原有的 [`startEchoTest`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/startEchoTest:)，新增参数 `intervalInSeconds`，用于设置返回测试结果的时间间隔。
- 该版本在本地视频流统计信息 [`AgoraRtcLocalVideoStats`](./API%20Reference/oc/v2.4/Classes/AgoraRtcLocalVideoStats.html) 类中新增 [`sentTargetBitrate`](./API%20Reference/oc/v2.4/Classes/AgoraRtcLocalVideoStats.html#//api/name/sentTargetBitrate)，[`sentTargetFrameRate`](./API%20Reference/oc/v2.4/Classes/AgoraRtcLocalVideoStats.html#//api/name/sentTargetFrameRate)，[`qualityAdaptIndication`](./API%20Reference/oc/v2.4/Classes/AgoraRtcLocalVideoStats.html#//api/name/qualityAdaptIndication) 三个参数，分别反映目标码率、目标帧率与和上次返回的本地视频流统计信息相比，本地视频质量的自适应情况。

##### 2. 视频偏好设置

一般场景下，Agora 默认的视频编码配置能满足需求。对于特定场景，该版本提供如下功能让用户选择视频偏好：

- 弱网下画质或流畅偏好设置。该版本在视频编码属性 [`AgoraVideoEncoderConfiguration`](./API%20Reference/oc/v2.4/Classes/AgoraVideoEncoderConfiguration.html) 类中新增 2 个参数 [`minFrameRate`](./API%20Reference/oc/v2.4/Classes/AgoraVideoEncoderConfiguration.html#//api/name/minFrameRate) 和 [`degradationPreference`](./API%20Reference/oc/v2.4/Classes/AgoraVideoEncoderConfiguration.html#//api/name/degradationPreference)，分别用于设置最低视频编码帧率，以及带宽受限时编码帧率的偏好。这两个参数需要搭配使用，详情请参考[设置视频属性](video_profile_apple)。

- 采集时预览或性能偏好设置。该版本新增接口 [`setCameraCapturerConfiguration`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setCameraCapturerConfiguration:)，通过设置摄像头采集偏好，用户可以根据实际场景选择优先保证设备性能还是视频质量。具体场景及参数选择，请参考 [API 文档](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setCameraCapturerConfiguration)。

##### 3. 核心质量改进

- 降低了音频延时
- 提升了视频质量和稳定性
- 缩短了远端视频的出图时间

#### **问题修复**

##### 音频相关

- 修复了调用 `enableLocalAudio` 接口导致的蓝牙断开的问题
- 新增支持中文字符音乐
- 修正 `pushExternalAudioFrameSampleBuffer` 成功的返回值为 YES
- 修复了高音声音变弱的问题
- 修复了偶现的声音快放问题

##### 视频相关

- 通过增加 `renderMode` 的默认值，修复了用户在没有设置的情况下，窗口和画面比例不符合引发的拉伸问题
- 部分低性能设备上出现的播放视频卡住的问题
- 优化了 SDK 出图时间

##### 其他

- 统一了 Android 和 iOS 平台上 SDK 判断远端用户掉线的时间
- 修复了转码推流场景下，SEI 信息与媒体流不同步的问题

#### **API 整理**

为提升用户体验，Agora 在 v2.4.0 版本中对 API 进行了如下变动：

##### 新增

- [`setBeautyEffectOptions`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setBeautyEffectOptions:options:)
- [`setLocalVoiceChanger`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceChanger:)
- [`setLocalVoiceReverbPreset`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceReverbPreset:)
- [`enableSoundPositionIndication`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/enableSoundPositionIndication:)
- [`setRemoteVoicePosition`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteVoicePosition:pan:gain:)
- [`startLastmileProbeTest`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/startLastmileProbeTest:)
- [`stopLastmileProbeTest`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/stopLastmileProbeTest)
- [`setRemoteUserPriority`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteUserPriority:type:)
- [`startEchoTestWithInterval`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/startEchoTestWithInterval:successBlock:)
- [`setCameraCapturerConfiguration`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setCameraCapturerConfiguration:)
- [`setLogFileSize`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setLogFileSize:)
- [`localAudioMixingStateDidChanged`](./API%20Reference/oc/v2.4/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioMixingStateDidChanged:errorCode:)
- [`lastmileProbeResult`](./API%20Reference/oc/v2.4/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileProbeTestResult:)

##### 废弃

- `startEchoTest`
- `setVideoQualityParameters`

##### 其他

[`AgoraVideoEncoderConfiguration`](./API%20Reference/oc/v2.4/Classes/AgoraVideoEncoderConfiguration.html) 类中的 [`frameRate`](./API%20Reference/oc/v2.4/Classes/AgoraVideoEncoderConfiguration.html#//api/name/frameRate) 参数由 `enum` 型修改为 `int` 型。

**2.3.3 版**

该版本于 2019 年 1 月 24 日发布。修复问题详见下文。

#### **问题修复**

修复了 `networkQuality` 回调不准确的问题。

**2.3.2 版**
该版本于 2019 年 1 月 16 日发布。新增特性与修复问题详见下文。

#### **升级必看**

2.3.2 除了下文提到的功能和改进外，整体提升直播场景下视频弱网下抗丢包能力，提高流畅度，降低卡顿率。升级前，请了解版本兼容性:

- Native SDK 版本号须大于等于 1.11 版本
- Web SDK 版本号须大于等于 2.1 版本

#### **新增功能**

##### 1. 摄像头曝光

为提升视频采集质量，该版本新增如下接口，支持摄像头曝光功能。开发者可以将需要自动曝光的区域位置发送给 Agora SDK，摄像头会基于该区域自动曝光。

- [`isCameraExposurePositionSupported`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/isCameraExposurePositionSupported)：检查设备是否支持摄像头曝光
- [`setCameraExposurePosition`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setCameraExposurePosition:)：设置摄像头曝光区域
- [`cameraExposureDidChangedToRect`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:cameraExposureDidChangedToRect:)：摄像头曝光区域已更改

##### 2. 提升直播清晰度

Agora SDK 会根据网络条件进行码率自适应。为满足用户在直播场景下对视频清晰度的要求，该版本在 [`setVideoEncoderConfiguration`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoEncoderConfiguration:) 接口中新增 [`minBitrate`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/minBitrate) 参数，强制视频编码器输出高质量图片。如果将参数设为高于默认值，在网络状况不佳情况下可能会导致网络丢包，并影响视频播放的流畅度。因此如非对画质有特殊需求，Agora 建议不要修改该参数的值。

##### 3. 控制音乐文件的播放音量

为方便用户控制混音音乐文件在本地及远端的播放音量，该版本在已有 [`adjustAudioMixingVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingVolume:) 的基础上新增 [`adjustAudioMixingPlayoutVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPlayoutVolume:) 和 [`adjustAudioMixingPublishVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPublishVolume:) 接口，用于分别控制混音音乐文件在本地和远端的播放音量。

添加新的方法后，原有的 [adjustPlaybackSignalVolume](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustPlaybackSignalVolume:) 由控制人声和音乐的音量改为仅控制人声的音量。因此，如果要静音本地播放，需同时设置 `adjustPlaybackSignalVolume(0)` 和 `adjustAudioMixingPlayoutVolume(0)`。

该版本梳理了用户在音频采集到播放过程中可能会需要调整音量的场景，及各场景对应的 API，供用户参考使用。详见官网文档[调整通话音量](./volume_ios)。

#### **改进**

##### 1. 提供更透明的质量数据统计

为提升质量透明的用户体验，该版本废弃了原有的 `audioQualityOfUid` 回调，并新增 `remoteAudioStats` 回调进行取代。和原来的接口相比，新接口使用更为综合的算法，通过引入音频丢帧率、端到端的音频延迟、接收端网络抖动的缓冲延迟等参数，使回调结果更贴近用户感受。同时，该版本优化了 `networkQuality` 的算法，对上下行网络质量采用不同的计算方法，使评分更精准。

- [`remoteAudioStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStats:)：通话中远端音频流的统计信息回调。用于替换 `audioQualityOfUid`
- [`networkQuality`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:networkQuality:txQuality:rxQuality:)：通话中每个用户的网络上下行 Last mile 质量报告回调。

Agora SDK 计划在下一个版本对如下 API 进行进一步改进：

- [`lastmileQuality`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileQuality:)：通话前网络上下行 Last mile 质量报告回调

该版本对数据统计相关回调进行了统一梳理，相关回调及算法详见[通话中数据统计](./in-call_quality_apple?platform=iOS)。

##### 2. 改进获取 SDK 网络连接状态的生成策略

为提升 SDK 使用数据统计的准确性和合理性，该版本新增如下接口，用以获取 SDK 的网络连接状态，以及连接状态发生改变的原因。

- [`getConnectionState`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getConnectionState)：获取 SDK 的网络连接状态
- [`connectionChangedToState`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:)：SDK 的网络连接状态已改变回调

该版本废弃了原有的 [`rtcEngineConnectionDidInterrupted`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngineConnectionDidInterrupted:) 和 [`rtcEngineConnectionDidBanned`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngineConnectionDidBanned:) 回调。

在新的接口下，SDK 共有 5 种连接状态：未连接、正在连接、已连接、正在重新建立连接和连接失败。当连接状态发生改变时，都会触发 `connectionChangedToState` 回调。当条件满足时，原有的 `rtcEngineConnectionDidInterrupted` 和 `rtcEngineConnectionDidBanned` 回调也会触发，但 Agora 不再推荐使用。

##### 3. 优化打分反馈机制

为方便用户（开发者）收集最终用户（应用程序使用者）对使用应用进行通话或直播的反馈，该版本将 [`rate`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/rate:rating:description:) 接口中的打分范围缩小为 1 - 5，减少最终用户的打分干扰。Agora 建议在应用程序中集成该接口，方便应用程序收集用户反馈。

##### 4. 音乐场景的音质优化

该版本针对高音质需求场景，如音乐教学等进行了音质改进。通过调用 [`setAudioProfile`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setAudioProfile:scenario:)，将 [`AgoraAudioProfile`](./API%20Reference/oc/Constants/AgoraAudioProfile.html) 设置为 `MusicHighQuality(4)`，[`AgoraAudioScenario`](./API%20Reference/oc/Constants/AgoraAudioScenario.html) 设置为 `GameStreaming(3)` 实现，在有效消除回声、降低噪音的同时，不损害音乐的音质。

##### 5. 其他改进

- 优化了直播场景下视频弱网抗丢包能力
- 加快了严重拥塞状态视频的恢复速度
- 提升了推流稳定性
- 优化了 API 的调用线程
- 优化了 SDK 在 iOS 中低端设备上的性能
- 增加了重新检测耳机插入和蓝牙设备连接的代码
- 降低了音频延时

#### **问题修复**

##### 音频相关：

- 修复了设备在连接蓝牙的状态下，退出频道后，音频不走蓝牙的问题
- 修复了调用 `startAudioMixing` 播放音乐文件时出现的崩溃问题
- 修复了麦克风在禁用的状态下，设备插上耳机后，禁用失效的问题
- 修复了外放条件下，上下麦、系统电话打断、Siri 中断、进退频道等多种场景下，出现的无法调节外放音量的问题
- 修复了应用从后台切回前台时，出现的出声音慢的问题

##### 视频相关：

- 修复了视频自采集时的偶现问题
- 修复了屏幕共享时出现的本地和远端鼠标位置不一致的问题

#### **API 整理**

为提升用户体验，Agora 在 v2.3.2 版本中对 API 进行了如下变动：

##### 新增

- [`isCameraExposurePositionSupported`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/isCameraExposurePositionSupported)
- [`setCameraExposurePosition`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setCameraExposurePosition:)
- [`getConnectionState`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getConnectionState)
- [`adjustAudioMixingPlayoutVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPlayoutVolume:)
- [`adjustAudioMixingPublishVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPublishVolume:)
- [`connectionChangedToState`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:)
- [`CameraExposureDidChangedToRect`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:cameraExposureDidChangedToRect:)
- [`remoteAudioStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStats:)

##### 废弃

- [`audioQualityOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:audioQualityOfUid:quality:delay:lost:)
- [`rtcEngineConnectionDidInterrupted`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngineConnectionDidInterrupted:)
- [`rtcEngineConnectionDidBanned`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngineConnectionDidBanned:)

**2.3.1 版**

该版本于 2018 年 9 月 28 日发布。新增特性与修复问题列表详见下文。

#### **新增功能**

##### 关闭/重新开启本地语音功能

应用程序在加入频道时，语音功能是默认打开的。为满足用户只接收而不发送音频流的需求，该版本新增 `enableLocalAudio` 接口，方便应用程序在进入频道后关闭或重新开启本地语音功能。关闭本地语音功能后，应用程序会收到 `didMicrophoneEnabled` 回调，并停止采集本地音频流。该方法不影响接收和播放远端音频流。

该功能与 `muteLocalAudioStream` 的区别在于前者不采集不发送，而后者是采集但不发送。

#### **改进**

- 优化了 iOS 低端设备在纯音频通信场景下的 CPU 消耗

#### **问题修复**

- 修复了某些 iOS 设备上偶现的崩溃问题
- 修复了使用自定义视频源功能时某些 iOS 设备上出现的崩溃问题
- 修复了使用自定义远端渲染器功能时某些 iOS 设备上出现的崩溃问题
- 修复了切换前后摄像头过程中偶现的崩溃问题
- 修复了直播场景下，切换前后摄像头一段时间后，某些 iOS 设备上偶现的应用程序卡住且无法退出频道的问题
- 修复了直播场景下，某些 iOS 设备上偶现的需要点两次才能对焦成功的问题
- 修复了通信场景下，一对一通话过程中，一端关闭视频后再打开，另一端出图较慢的问题
- 修复了直播场景下，观众端因统计有误出现的延迟的问题
- 修复了采集到的视频裸数据中，视频帧的时间戳不按帧更新的问题

**2.3.0 版**

该版本于 2018 年 8 月 31 日发布。新增特性与修复问题列表详见下文。

Agora SDK 在 v2.3.0 版本中，全面提升了视频功能的稳定性及可用性，保证了更加可靠的实时通信。同时音视频质量也得到进一步提高。 视频方面，通过优化编码性能，增强了弱网对抗能力，减少卡顿时间，提升视频流畅度；音频方面，采用深度学习算法，改进了通话中的音频质量。

#### **升级必看**

- 为满足场景中视频旋转的需要，提升自定义视频源画质，该版本引入 `setVideoEncoderConfiguration` 替换原 `setVideoProfile` 接口。 `setVideoProfile` 接口仍可用，但不再推荐。

  - 直播场景下支持 Adaptive Mode，当发送端画面旋转时不再剪切画面，避免播放端画面出现“大头”或缩放模糊的现象。

  - 自采集场景中，可以根据输入视频帧的宽和高，动态调整输出视频帧的宽和高，尽可能避免剪切，并提供更多的图像信息给到播放端。

- 该版本新增了一个系统库依赖：`Accelerate.framework`。该系统库可以进行大规模的数学计算和图像计算，并针对高性能进行了优化。

- 为更好地提升用户体验，Agora SDK 在 v2.1.0 版本中对动态秘钥进行了升级。如果你当前使用的 SDK 是 v2.1.0 之前的版本，并希望升级到 v2.1.0 或更高版本，请务必参考 [动态秘钥升级说明](/cn/Agora%20Platform/token_migration) 。

#### **新增功能**

本次发版新增如下功能：

##### 1. 直播中弱网环境下视频自动回退/重开

网络不理想的环境下，直播音视频的质量都会下降。为提升直播效率，Agora 新增了 `setLocalPublishFallbackOption` 和 `setRemoteSubscribeFallbackOption` 两个接口。 用户设置这两个接口后，在网络条件差、无法同时保证音视频质量的情况下，SDK 会自动将视频流从大流切换为小流，或直接关闭视频流，从而保证或提高音频质量。同时 SDK 会持续监控网络质量， 并在网络质量改善时恢复音视频流。在推流回退为音频流时，或由音频流恢复为音视频流，触发 `didLocalPublishFallbackToAudioOnly`) 或 `didRemoteSubscribeFallbackToAudioOnly` 回调。

##### 2. 提前 30 秒提醒 Token 即将过期

由于 Token 具有一定的时效，在通话过程中如果 Token 即将失效，SDK 会提前 30 秒触发回调 `tokenPrivilegeWillExpire`，提醒应用程序更新 Token。当收到该回调时，用户需要重新在服务端生成新的 Token，然后调用 `renewToken` 将新生成的 Token 传给 SDK。

##### 3. 按用户返回音视频上下行码率、帧率、丢包率及延迟

为方便统计每个用户的音视频上下行码率、帧率及丢包率，该版本新增 `audioTransportStatsOfUid` 和 `videoTransportStatsOfUid` 回调。 通话或直播过程中，当用户收到远端用户发送的音视频数据包后，会周期性地发生该回调上报，频率约为 2 秒 1 次。 回调中包含用户的 UID、音/视频接收码率、丢包率、以及延迟时间（毫秒）。 并在统计频道内通话相关数据的 `Rtcstats` 类中增加 `lastmileDelay` 参数，返回客户端到 vos 服务器的延迟。

##### 4. 设置 SDK 对 Audio Session 的管理限制

在默认情况下，SDK 和 App 对 Audio Session 都有控制权，但某些场景下，App 会希望限制 Agora SDK 对 Audio Session 的控制权限， 而使用其他应用或第三方组件对 Audio Session 进行操控。为满足该需求，本版本新增 `setAudioSessionOperationRestriction` 接口。 用户可以选择相应的 Restriction，来实现 SDK 不同程度的管理限制。该方法可动态使用，在加入频道前，或频道中均能调用。

##### 5. 设置视频编码属性

为满足场景中视频旋转的需要，提升自定义视频源画质，该版本引入 `setVideoEncoderConfiguration`替换原 `setVideoProfile` 接口，来设置视频编码属性。 新接口中的 AgoraVideoEncoderConfiguration 类对应一套视频参数，支持用户根据实际需要，手动设置视频的分辨率（dimension)、帧率 (frame rate)、码率 (bitrate) 以及视频方向 (orientationMode)。原接口 `setVideoProfile` 仍可使用，但不再推荐。

##### 6. 直播转码新增支持设置背景图片

在设置直播转码接口 `setLiveTranscoding` 中，新增 `backgroundImage` 参数，支持设置直播转码合图的背景图片。

#### **改进功能**

- 优化了一对一音视频的质量，在降低延时、防止卡顿方面提升明显。优化效果重点覆盖东南亚、南美、非洲和中东等地区

- 直播场景下，改善了音频编码器的效率，保证通话质量的同时节省用户流量

- 采用深度学习算法，改进了通话及直播中的音频质量

#### **问题修复**

- 修复了因视频编码问题引起的 Native 设备与 Web 端互通时，Web 端看不到 Native 端视频画面的问题

- 修复了多人视频直播连麦场景下，SDK 内存异常增长的问题

- 修复了某些 iOS 设备上 App 切换至后台后偶发的视频渲染崩溃的问题

- 修复了某些 iOS 设备上 App 偶发的闪退的问题

- 修复了特定场景下某些设备上偶发的无法看到远端视图的问题

- 修复了特定场景下偶发的 iOS 设备黑屏的问题

- 修复了特定场景下偶现的视频重影的问题

- 修复了通信场景下，由小流切换到大流时，偶现的视频画面下方出现绿边的问题。

- 修复了特定场景下某些 iOS 设备上推流后出现的崩溃问题

- 修复了某些 iOS 设备上偶现的崩溃的问题

- 修复了某些 iOS 设备上频繁暂停、恢复播放所有音效时出现的崩溃的问题

- 修复了多人连麦场景下，主播频繁进出频道时，偶现的主播内存异常增长的问题

- 修复了特定场景下偶现的主播加入频道、下麦再上麦后，远端用户听不到主播声音的问题

- 修复了偶现的设置推流背景图无效的问题

- 修复了通信场景下，某些设备上偶现的视频画面长宽和设置的长宽颠倒的问题

- 修复了某些设备上偶现的开启视频模式加入频道后，调用 destroy 方法无响应的问题

- 修复了特定场景下某些 iOS 设备上偶现的接听系统电话再回到频道后，听不到声音的问题

- 修复了特定场景下偶现的直播观众无法调节频道内通话音量的问题

- 修复了频繁进出频道时，某些 iOS 设备上出现的崩溃的问题

- 修复了通信场景下偶现的其他端看不到 iOS 端视频画面的问题

- 修复了直播场景下，主播和观众频繁切换角色时，观众切主播后偶现的采集不到画面的问题

- 修复了某些 iOS 设备上偶现的不开启双流模式，Web 端也能订阅 iOS 端小流的问题

- 修复了设置手动对焦位置并触发对焦时，某些设备上偶现的崩溃的问题

- 修复了 2 人连麦过程中，一端播放背景音乐时将自己静音或关闭音频后，另一端闪退的问题

- 修复了特定场景下，iOS 端和 Web 端互通时，Web 频繁进出频道后，iOS 设备上出现的崩溃的问题

- 修复了通信场景下，反复设置不同的视频编码属性后，无法进入频道的问题

- 修复了特定场景下，预加载音效时某些设备上偶现的崩溃问题

- 修复了直播场景下，主播端编码与解码端渲染的分辨率不一致的问题

- 修复了通信和直播场景下偶发的视频画面卡住的问题

- 修复了进入频道前暂停指定用户视频流后，某些设备上偶现的崩溃的问题

- 修复了特定场景下，某些 iOS 设备上出现的未开启弱网下视频自动回退，也能收到相关回调的问题

- 修复了直播场景下，对某些外部视频源设置编码属性时，某些 iOS 设备上出现的输出视频方向不正确的问题

- 修复了某些 iOS 设备上手动设置视频属性异常的问题

- 修复了偶现的 iOS 与 macOS 设备 无法进入频道互通的问题

- 修复了直播场景下，使用第三方应用播放音乐时，某些 iOS 设备上出现的退出频道时崩溃的问题

- 修复了特定场景下，某些 iOS 设备上出现的退出频道时崩溃的问题

- 修复了直播场景下，某些 iOS 设备上出现的拉流过程中，其他用户拉流也能成功的问题

- 修复了频繁开关摄像头时，某些 iOS 设备上出现的崩溃的问题

- 修复了直播场景下，由连麦切换回单主播时偶现的画面卡顿的问题

- 修复了特定场景下偶现的 SIP 设备和 SDK 视频不互通的问题

- 修复了小米 8 上出现的本地预览黑屏、远端也看不到它的问题

- 修复了部分设备上偶现的使用声卡时回声的问题

- 修复了部分 iOS 设备出现的视频画面由小到大跳变的问题

- 修复了特定场景下，部分 iOS 设备上出现的摄像头晃动时，频道内画面卡糊的问题

- 修复了部分 iOS 设备上偶现的视频延迟的问题

- 修复了特定场景下，某些 iOS 设备上无法调节音量的问题

#### **API 整理**

为提升用户体验，Agora 在 v2.3.0 版本中对 API 进行了梳理，并针对部分接口进行了如下处理：

为避免在直播转码推流中添加多个相同 User，v2.3.0 版本中新增如下接口：

- `addUser`

- `removeUser`

以下接口与录制相关，在 v2.3.0 版本后不再支持。Agora 提供专门的 Recording SDK 用于更好的录制服务，详见 [Agora Recording SDK 发版说明](/cn/Product%20Overview/release_recording)。

- `startRecordingService`

- `stopRecordingService`

- `refreshRecordingServiceStatus`

- `didRefreshRecordingServiceStatus`

以下接口长期处于弃用状态，现进行删除，v2.3.0 版本后不再支持：

- `switchView`

- `setSpeakerphoneVolume`

**2.2.3 版**

该版本于 2018 年 7 月 5 日发布。新增特性与修复问题列表详见下文。

#### **升级必看**

为更好地提升用户体验，Agora SDK 在 v2.1.0 版本中对动态秘钥进行了升级。如果你当前使用的 SDK 是 v2.1.0 之前的版本，并希望升级到 v2.1.0 或更高版本，请务必参考 [动态秘钥升级说明](/cn/Agora%20Platform/token_migration) 。

#### **问题修复**

- 修复了特定场景下偶发的线上统计崩溃的问题。

- 修复了直播时特定场景下偶发的崩溃的问题。

- 修复了多人直播连麦时，SDK 内存增长的问题。

- 复了偶发的无法正常反馈频道内谁在说话以及说话者音量的问题。

- 修复了直播时偶发的观众听到主播声忽大忽小的问题。

- 修复了特定场景偶发的视频尺寸变化后，视频卡住的问题。

**2.2.2 版**

该版本于 2018 年 6 月 21 日发布。修复问题列表详见下文。

#### **问题修复**

- 修复了特定场景下偶发的线上统计崩溃的问题
- 修复了 iOS 设备无法同时使用媒体和信令服务的问题
- 修复了偶发的无法正常反馈频道内谁在说话以及说话者的音量的问题
- 修复了特定场景下偶发的视频窗口尺寸变化后，视频卡住的问题

**2.2.1 版**

该版本于 2018 年 5 月 30 日发布。新增特性与修复问题列表详见下文。

#### **问题修复**

- 修复了部分设备上偶现的 Crash 问题。

- 修复了部分设备上内存泄漏的问题。

- 修复了部分设备上播放网络伴奏时某些 App 闪退的问题。

**2.2.0 版**

该版本于 2018 年 5 月 4 日发布。新增特性与修复问题列表详见下文。

#### **新增功能**

本次发版新增如下功能：

##### 1. 音效混响进频道

播放音效 `playEffect` 接口新增了一个 `publish` 参数，用于在播放音效时，远端用户可以听到本地播放的音效。

> 如果你的 SDK 是由之前版本升级到 v2.2 版本，请务必关注该接口功能的变动。

##### 2. 服务端部署代理服务器

通过部署 Agora 提供的代理服务器安装包，设有企业防火墙的用户可以设置代理服务器，使用 Agora 的服务。

##### 3. 获取远端视频状态

新增 `onRemoteVideoStateChanged `接口，以获知远端视频流的状态。

##### 4. 直播添加视频水印

在本地直播及旁路直播中增加水印功能，允许用户将一张 PNG 图片作为水印添加到正在进行的本地直播或旁路直播中。新增 `addVideoWatermark` 和 `clearVideoWatermarks` 接口，以添加或删除本地直播水印；`LiveTranscoding`接口中新增 `watermark` 参数，用于控制旁路直播中水印的添加。

#### **改进功能**

本次发版改进如下功能：

##### 1. 当前说话者音量提示

改进 `enableAudioVolumeIndication`接口的功能，无论频道内是否有人说话，都会在回调中按设置的时间间隔返回说话者音量提示。

##### 2. 频道内网络质量监测

根据用户对频道内实时网络质量监测测的需求，在 `onNetworkQuality` 中改进了返回数据的准确度。

##### 3. 进入频道前网络条件监测

为方便用户在进频道前检查当前网络是否能支撑语音或视频通话，在 `onLastmileQuality` 中，由通过恒定码率监测优化为根据用户设定的 Video Profile 的码率进行监测，提高返回数据的准确度。且在网络状态为 unknown 时，依然以 2 秒的间隔返回回调。

##### 4. 提升音乐场景下的音质

提升了用户在播放音乐等场景下的音乐音质。用户可以通过设置 `setAudioProfile` 中的 Scenario：AgoraAudioScenarioGameStreaming = 3 来实现高保真的音乐传输。

##### 5. 支持 Bitcode

新增支持 Bitcode 功能。支持 Bitcode 的 SDK 包大小约为普通包的 2.5 倍；使用 Bitcode 开发的 App 在上传 App Store 后，App Store 会对其进行优化及瘦身，瘦身程度视 App 的代码量而定，代码量越大，瘦身程度越高。

#### **问题修复**

- 修复了某些 iOS 设备横屏时，偶现的其他用户看 iOS 设备画面异常的问题。

- 修复了大量用户同时直播连麦时，偶发的抖屏现象。

- 修复了某些 iOS 设备导致频道内其他端的回音问题。

**2.1.3 版**

该版本于 2018 年 4 月 19 日发布。新增特性与修复问题列表详见下文。

#### **升级必看**

该版本的 SDK 修改了 `setVideoProfile` 方法在直播场景下的码率值，修改后的码率值与 2.0 版本一致。

#### **问题修复**

- 修复了 SDK 没有设置 Delegate 时，偶尔收不到 Block 回调的问题。

- 修复了 SDK 的外链符号里，有 NSAssertionHandler 的问题。

- 修复了部分手机上，用户离开频道后，开启自带的录音设备时，偶现录音出错的问题。

- 修复了直播场景下，调用 `enableWebSdkInteroperability `接口后，iOS 端偶尔看不到 Win 10 系统 Web 端视频画面的问题。

- 修复了使用 UIImagePickerController 调用系统相机后再回到直播中，偶现分辨率改变的问题。

- 修复了通信或直播过程中偶现 Crash 的问题。

#### **改进**

改进了通信和直播场景下屏幕共享的效果，缩短了用户从屏幕共享模式切换回普通模式需要的时间间隔。

**2.1.2 版**

该版本于 2018 年 4 月 2 日发布。新增特性与修复问题列表详见下文。

#### **升级必看**

SDK 升级至 2.1.2 的直播场景后，相同分辨率下，视频更清晰，但带宽也会变大。

#### **新增功能**

在已有 `setVideoProfile` 接口的基础上，新增一个 `setVideoResolution` 接口。用户可以用此接口，根据自身业务需要，手动设置视频的分辨率、帧率和码率。

#### **问题修复**

- 修复了之前版本 SDK 在 iOS 11 平台上崩溃的问题。

- 修复了之前版本 SDK 在 dtx+aac 模式下会视频卡顿的问题。

**2.1.1 版**

该版本于 2018 年 3 月 16 日发布。

请正在或已集成 2.1 SDK 的客户尽快升级更新！ 本次发版修复了一个的系统风险，请尽快升级以免对服务造成影响。

**2.1.0 版**

该版本于 2018 年 3 月 7 日发布。新增特性与修复问题列表详见下文。

#### **新增功能**

本次发版新增如下功能：

##### 1. 开黑

新增了一个游戏开黑场景，用于节省流量和去除杂音，通过调用 API setAudioProfile 实现。

##### 2. 音效均衡和音效混响

在直播场景下，主播如果需要通过内置的麦克风美化和定制自己的语音输入，可以通过调用 API `setLocalVoiceEqualization` 和 `setLocalVoiceReverb` 轻易地设置音效均衡和混响来实现所需要的效果。

##### 3. 在线频道信息查询

新增 RESTful API 查询用户在频道中的状态信息，查询指定频道内的分角色用户列表，查询厂商频道列表，查询用户是否为连麦用户等。详见 [控制台 RESTful API](console_overview)

##### 4. 17 人视频

在直播场景下，同一频道内支持 17 位主播同时进行视频直播和连麦，详见文档:

- [实现视频直播](start_live_ios)

- [实现七人以上视频通话](./multi_user_video_apple)

##### 5. 自定义视频源

Agora SDK 提供了摄像头采集的默认实现，同时允许开发者使用自定义视频源。

##### 6. 自定义渲染器

Agora SDK 提供了默认的渲染器实现，用来显示本地视频图像和对端视频图像。使用默认的渲染器就能满足大部分开发者需求，复杂的业务场景下，Agora 也开放了自定义渲染器接口。

##### 7. 插入外部视频源

直播场景下，可以将采集到的视频添加到正在进行的直播中，直播室里的主播和观众可以一起边看电影、比赛或演出，边进行点评、互动等功能，会让现有的直播话题更广、体验更好。 仅支持拉入一路流，格式包括: RTMP, HLS, FLV。赛事直播最多同时支持 5 人连麦直播。详见 [外部输入直播视频源](inject_stream_apple) 。

##### 8. 提示相机对焦区域

新增回调接口提示相机的对焦区域已发生改变，新增了回调 `cameraFocusDidChanged` 。

#### **改进**

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

#### **问题修复**

- 修复了自采集方案退出频道后 app 录不到声音的问题;

- 修复了偶现的崩溃;

- 修复了偶现的关闭麦克风无法听到声音的问题;

- 修复了偶现的黑屏问题;

**2.0.2 版**

该版本于 2017 年 12 月 15 日发布。新增特性与修复问题列表详见下文。

#### **问题修复**

修复了 ffmpeg 符号冲突问题;

**2.0 版**

该版本于 2017 年 12 月 6 日发布。新增特性与修复问题列表详见下文。

#### **新增功能**

- 通信场景支持视频大小流功能，新增 API `setRemoteVideoStreamType()`和 `enableDualStreamMode()` 。

- 伴奏和音效回调更新如下:

      <table>

  <colgroup>
  <col/>
  <col/>
  </colgroup>
  <tbody>
  <tr><td><strong>名称</strong></td>
  <td><strong>描述</strong></td>
  </tr>
  <tr><td><code>rtcEngineMediaEngineDidAudioMixingFinish</code></td>
  <td>废弃，已经被 <code>rtcEngineLocalAudioMixingDidFinish</code> 替代</td>
  </tr>
  <tr><td><code>rtcEngineDidAudioEffectFinish</code></td>
  <td>新增，当本地结束音效播放时触发该回调</td>
  </tr>
  <tr><td><code>rtcEngineRemoteAudioMixingDidStart</code></td>
  <td>新增，当远端开始伴奏播放时触发该回调</td>
  </tr>
  <tr><td><code>rtcEngineRemoteAudioMixingDidFinish</code></td>
  <td>新增，当远端结束音效播放时触发该回调</td>
  </tr>
  </tbody>
  </table>

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
  <tr><td><code>isCameraFocusPositionInPreviewSupported</code></td>
  <td>检测设备是否支持手动对焦功能</td>
  </tr>
  <tr><td><code>isCameraAutoFocusFaceModeSupported</code></td>
  <td>检测设备是否支持人脸对焦功能</td>
  </tr>
  <tr><td><code>setCameraZoomFactor</code></td>
  <td>设置相机缩放因子</td>
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
  <tr><td><code>enableExternalAudioSourceWithSampleRate</code></td>
  <td>开启外部音频采集</td>
  </tr>
  <tr><td><code>disableExternalAudioSource</code></td>
  <td>关闭外部音频采集</td>
  </tr>
  <tr><td><code>pushExternalAudioFrameRawData</code></td>
  <td>推送外部音频帧</td>
  </tr>
  </tbody>
  </table>

- 通信和直播场景下支持服务端踢人功能。如有需要，请联系 [sales@agora.io](mailto:sales@agora.io) 开通该功能。

#### **问题修复**

修复了音频路由和蓝牙相关的若干问题。

**1.14 版**

该版本于 2017 年 10 月 20 日发布。新增特性与修复问题列表详见下文。

#### **新增功能**

- 新增 API `setAudioProfile` 设置音频参数和应用场景。

- 新增 API `setLocalVoicePitch` 提供基础变声功能。

- 直播场景: 新增 API `setInEarMonitoringVolume` 提供调节耳返音量功能。

#### **改进**

- 优化了在高码率下的音频体验。

- 秒开: 直播场景下，单流模式时观众加入频道 1 秒内看见主播图像\(均值为 938 ms, 网络状态良好时可达 734 ms\)。

- 节省带宽:

  - 1.14 以前: 如果你选择不听某人的音频或不看某人的视频，音视频流会照发。

  - 1.14 开始: 如果你选择不听或不看某人的流，则不会下发，从而节省带宽。

- 精准的码率控制:

  - 1.14 以前: 码率控制不够精准，上下波动幅度较大。波动过大容易造成网络拥塞，增加丢包、丢帧的概率，影响了带宽估计模块的精度，特别是在弱网低码率情况下尤为明显。

  - 1.14 开始: 精准的码率控制，要多少给多少，不多给也不少给，避免波动过大造成的网络拥塞，减少传输延时，有助于减少网络卡顿。

#### **问题修复**

修复了部分 iOS 机器上偶现的崩溃。

**1.13.1 版**

该版本于 2017 年 9 月 28 日发布。新增特性与修复问题列表详见下文。

#### **问题修复**

- 解决了 iOS 11 在 iPhone 7\(及以上版本\) 手机外放下无法调节音量的问题。

- 优化了特定场景下出现的回声问题。

**1.13 版**

该版本于 2017 年 9 月 4 日发布。新增特性与修复问题列表详见下文。

#### **新增功能**

- 新增 API `didClientRoleChanged` 用于提醒直播场景下主播、观众上下麦的回调。

- 新增单独关闭语音播放的功能。

- 新增功能支持服务端推流失败回调。

- 为 SDK 新增了 module map, 意味着 Swift 项目以后不需要添加桥接文件才能使用。

#### **改进**

- 软编情况下，视频属性可控

- 可以在客户端设置推流的 profile

#### **修复问题**

修复了部分机型上偶现的崩溃。

**1.12 版**

该版本于 2017 年 7 月 25 日发布。新增特性与修复问题列表详见下文。

#### **新增功能**

- 在 API 方法 `setEncryptionMode` 里新增了加密模式 `aes-128-ecb`。

- 在 API 方法 `startAudioRecording`里新增了参数 `quality` 用于设置录音音质。

- 新增了一系列 API 管理音效。

- 直播场景下， 新增了 API 方法 `injectStream`在当前频道内插入一条 RTMP 流。该功能目前为 beta 版。

#### **改进**

通信场景下针对 320 x 180 分辨率提供了以下改进方案:

- 网络和设备状态较差的情况下仍能保证画质流畅度。

- 网络和设备状态良好的情况下可以做到比 180P 更好的画质清晰度。

#### **修复问题**

修复了部分机型上偶现的崩溃问题。
