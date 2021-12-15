---
title: 发版说明
platform: macOS
updatedAt: 2021-03-29 03:37:33
---

本文提供 Agora 视频 SDK 的发版说明。

## **简介**

macOS 视频 SDK 支持两种主要场景:

- 音视频通话
- 音视频直播

点击 [语音通话产品概述](https://docs.agora.io/cn/Voice/product_voice?platform=All%20Platforms)、[视频通话产品概述](https://docs.agora.io/cn/Video/product_video?platform=All%20Platforms)、[音频互动直播产品概述](https://docs.agora.io/cn/Audio%20Broadcast/product_live_audio?platform=All%20Platforms) 及 [视频互动传播产品概述](https://docs.agora.io/cn/Interactive%20Broadcast/product_live?platform=All%20Platforms) 了解关键特性。

#### 已知问题和局限性

macOS 上连接 USB 耳麦，可能会出现听不见声音或者声音显示异常等问题，通常为 USB 设备驱动的问题，macOS 上对普通的 USB 支持都不是很友好，建议购买更优质的 USB 耳麦。

## **3.0.0 版**

该版本于 2020 年 3 月 5 日发布。

在该版本对通信场景采用了全新的系统架构，并升级了通信和直播场景下的 last mile 网络策略。在带宽不足时，新的网络策略能充分利用上下行有限带宽提升有效码率，从而增强弱网对抗能力，极大提升了弱网情况下通信和直播场景的终端用户体验。

由于通信场景采用了新的系统架构，为保证新老版本通信用户的互通兼容，我们使用了回退机制。如果频道内有老版本通信用户加入，则当前版本 (3.0.0) 的终端用户会回退成老版本通信。一旦回退，频道内所有用户都无法享受新版本带来的体验提升。因此我们强烈推荐同步升级所有终端用户到当前版本。

同时，我们对本地服务端录制进行了升级发布。为确保享受全新架构和网络策略优化带来的好处，使用本地服务端录制的客户，请务必同步升级本地服务端录制 SDK 至 3.0.0 版本。

新增特性、改进与问题修复详见下文。

**升级必看**

#### 1. 静态库更名与新增动态库

为与其他平台保持一致，该版本将 SDK 的库名由 AgoraRtcEngineKit 变更为 AgoraRtcKit。如果你由老版本的 SDK 升级至该版本，请务必重新导入类。详细步骤见《快速开始》中的[导入类](https://docs.agora.io/cn/Video/start_call_mac?platform=macOS#a-nameimportclassa2-%E5%AF%BC%E5%85%A5%E7%B1%BB)章节。

同时，为提升开发体验，该版本新增动态库支持。你可以在静态库和动态库之间任选一个进行集成，其中动态库的包名为 Agora_Native_SDK_for_iOS_v3_0_0_FULL_Dynamic。

使用动态库可以提高库的安全等级，方便 app 上传至 App Store，且避免与第三方库产生不兼容等问题。如果选择动态库，则需要重新进行集成并导入类。该步骤大约需要 5 分钟。详见《快速开始》中的[集成 SDK](https://docs.agora.io/cn/Video/start_call_mac?platform=macOS#a-nameintegratesdka%E9%9B%86%E6%88%90-sdk) 和[导入类](https://docs.agora.io/cn/Video/start_call_mac?platform=macOS#a-nameimportclassa2-%E5%AF%BC%E5%85%A5%E7%B1%BB)章节。

<div class="alert info">下表展示分别使用动态库和静态库生成 ipa 文件过程中各文件体积的差异：

<table>
    <tr>
			<td width="10%"><b>SDK 版本</b></td>
        <td width="10%"><b>库类型</b></td>
        <td width="12%"><b>ipa 体积</b></td>
        <td width="10%"><b>解压后体积</b></td>
        <td width="19%"><b>Frameworks 文件夹体积</b></td>
        <td width="15%"><b>二进制文件体积</b></td>
        <td width="23%"><b>Frameworks 文件夹 + 二进制文件总体积</b></td>
    </tr>
    <tr>
        <td>3.0.0 及以上</td>
        <td>动态库</td>
        <td>31.1 M</td>
        <td>65 M</td>
        <td>51.47 M</td>
        <td>2.4 M</td>
        <td>53.87 M</td>
    </tr>
    <tr>
        <td>3.0.0 以下</td>
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

加入多个频道后，用户可以同时接收多个频道的流，但只能同时在一个频道内发流。该功能适用于用户需要同时接收多个频道的流，或频繁切换频道发流的场景。详细的集成步骤和注意事项，请参考《[加入多频道](./multiple_channel_apple)》。

#### 2. 调节本地播放的指定远端用户音量

该版本新增 [`adjustUserPlaybackSignalVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustUserPlaybackSignalVolume:volume:) 方法，用以调节本地用户听到的指定远端用户的音量。通话或直播过程中，你可以多次调用该方法，来调节多个远端用户在本地播放的音量，或对某个远端用户在本地播放的音量调节多次。

**改进**

#### 1. 音频编码属性

为满足更高音质需求，该版本调整了直播场景下 `AgoraAudioProfileDefault(0)` 对应的音频编码属性，详见下表：

| SDK 版本   | `AgoraAudioProfileDefault(0)`                               |
| :--------- | :---------------------------------------------------------- |
| 3.0.0      | 48 KHz 采样率，音乐编码，单声道，编码码率最大值为 52 Kbps。 |
| 3.0.0 之前 | 32 KHz 采样率，音乐编码，单声道，编码码率最大值为 44 Kbps。 |

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

该版本修改了 macOS 设备连接耳机或蓝牙时的音频路由。修改后的语音路由与 macOS 设备管理器中显示的一致。

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
- macOS 10.15 系统下，偶现系统渲染窗口 UI 异常。

## **2.9.1 版**

该版本于 2019 年 9 月 19 日发布。新增特性与修复问题列表详见下文。

**新增特性**

#### 1. 人声检测

为判断本地用户是否说话，该版本在启用说话者音量提示 [`enableAudioVolumeIndication`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableAudioVolumeIndication:smooth:report_vad:) 方法中新增 bool 型的 `report_vad` 参数。启用该参数后，你会在 [`reportAudioVolumeIndicationOfSpeakers`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:reportAudioVolumeIndicationOfSpeakers:totalVolume:) 回调报告的 [`AgoraRtcAudioVolumeInfo`](./API%20Reference/oc/Classes/AgoraRtcAudioVolumeInfo.html) 结构体中获取本地用户的人声状态。

#### 2. RGBA 视频原始数据

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

#### 视频

修复了 [`getDeviceInfo`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getDeviceInfo:) 返回值与实际可用设备不符的问题。

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

为提高通信模式下，本地用户关闭麦克风后听到的音质，该版本在 `enableLocalAudio`(true) 后，将系统音量修改为媒体音量。调用 `enableLocalAudio`(false) 后，系统音量自动切换为通话音量。

**新增特性**

#### 1. 快速切换频道

为方便直播频道中的观众用户快速切换到其他频道，该版本新增 [`switchChannelByToken`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/switchChannelByToken:channelId:joinSuccess:) 方法。和先调 [`leaveChannel`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/leaveChannel:)，再调 [`joinChannelByToken`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:) 相比，该方法能实现更快的频道切换。调用 [`switchChannelByToken`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/switchChannelByToken:channelId:joinSuccess:) 方法切换到其他直播频道后，本地会先收到离开原频道的回调 [`didLeaveChannelWithStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didLeaveChannelWithStats:)，再收到成功加入新频道的回调 [`didJoinChannel`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didJoinChannel:withUid:elapsed:)。

#### 2. 跨频道媒体流转发

跨频道媒体流转发，指将主播的媒体流转发至其他直播频道，实现主播跨频道与其他主播实时互动的场景。该版本新增如下接口，通过将源频道中的媒体流转发至目标频道，实现跨直播间连麦功能：

- [`startChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startChannelMediaRelay:)
- [`updateChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/updateChannelMediaRelay:)
- [`stopChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopChannelMediaRelay)

在跨频道媒体流转发过程中，SDK 会通过 [`channelMediaRelayStateDidChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:channelMediaRelayStateDidChange:error:) 和 [`didReceiveChannelMediaRelayEvent`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didReceiveChannelMediaRelayEvent:) 回调报告媒体流转发的状态和事件。

该场景的实现方法、API 调用时序、示例代码及开发注意事项，请参考 [跨直播间连麦](media_relay_mac) 指南。

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

#### 3. 屏幕共享质量提升

该版本提升了通信模式下，下行网络状况不佳时，屏幕共享文字的清晰度。该改进只在屏幕共享的内容类型 `contentHint` 设置为 Details(2) 时生效。

#### 4. 其他改进

- 优化了 GameStreaming 模式下的音频质量。
- 优化了通信模式下用户关闭麦克风后听到的音质。

**问题修复**

#### 音频

- 修复了与 Web 互通时听声辨位过程中出现的声音失真的问题。
- 修复了测试麦克风时出现的崩溃问题。

#### 视频

- 修复了视频卡住的问题。

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

#### 1. 全平台支持 String 型的用户名

很多 App 使用 String 类型的用户名。为降低开发成本，Agora 新增支持 String 型的 User account，方便用户通过如下接口直接使用 App 账号加入 Agora 频道：

- [registerLocalUserAccount](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/registerLocalUserAccount:appId:)
- [joinChannelByUserAccount](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByUserAccount:token:channelId:joinSuccess:)

对于其他接口，Agora 沿用 Int 型的 UID。Agora Engine 会维护 UID 和 User account 映射表，你可以随时通过 String user account 获取 UID，或者通过 UID 获取 String user account，无需自己维护映射表。

为保证通信质量，频道内所有用户需使用同一数据类型的用户名，即频道内的所有用户名应同为 Int 型或同为 String 型。

**Note**：

- 同一频道内，Int 型的 User ID 和 String 型的 User account 不可混用。目前支持 String 型 User account 的 SDK 如下：

  - Native SDK：v2.8.0 及之后版本
  - Web SDK：v2.5.0 及之后版本

如果你的频道内有不支持 String 型 User account 的用户，则只能使用 Int 型的 User ID。

- 如果你使用该版本的 Native SDK 将用户名升级至 String 型 User account，请确保所有终端用户同步升级。
- 如果使用 String 型的 User account，请确保你的服务端用户生成 Token 的脚本已升级至最新版本。如果使用 String 型 User account 加入频道，请确保使用该 User account 或其对应的 Int 型 UID 来生成 Token。你可以调用 `getUserInfoByUserAccount` 来获取 User account 所对应的 UID。

#### 2. 音视频卡顿回调

为监控通话过程中的音视频传输质量，方便开发者客观体验通信质量，该版本在远端音频统计数据 [AgoraRtcRemoteAudioStats](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) 类和远端视频统计数据 [AgoraRtcRemoteVideoStats](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html) 类中新增 `totalFrozenTime` 和 `frozenRate` 成员，报告远端用户在加入频道后发生音视频的卡顿时长及卡顿率。

同时，该版本在 [AgoraRtcRemoteAudioStats](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) 类中还新增 `numChannels`、`receivedSampleRate` 和 `receivedBitrate` 成员。

**改进**

为方便开发者统计掉线率，该版本在 [connectionChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:) 回调的 `AgoraConnectionChangedReason` 参数中添加 `AgoraConnectionChangedKeepAliveTimeout(14)` 成员，表示 SDK 与服务器连接保活超时，引起 SDK 连接状态发生改变。

**修复问题**

#### 视频

- 修复了调用 `MediaIO` 类下方法时偶现的死循环问题。

#### 其他

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
- [AgoraRtcRemoteAudioStats](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) 类中新增 `numChannels`，`receivedSampleRate`，`receivedBitrate`，`totalFrozenTime` 和 `frozenRate` 成员
- [AgoraRtcRemoteVideoStats](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html 类中新增 `totalFrozenTime` 和 `frozenRate` 成员

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

#### 2、优化屏幕共享

为确保屏幕共享画面完整性，保持共享屏幕的宽高比，避免画面裁剪和拉伸，该版本对屏幕共享的编码策略进行了优化。该版本下 Agora 按如下策略进行编码。假设 `dimensions` 值为 1920 x 1080，即 2073600 像素：

- 如果屏幕分辨率小于 `dimensions`，如 1000 x 1000，SDK 直接按 1000 x 1000 进行编码
- 如果屏幕分辨率大于 `dimensions`，如 2000 x 2000，SDK 将保持屏幕分辨率的宽高比 1：1，取 `dimensions` 以内的最大分辨率，即 1440 x 1440， 进行编码

屏幕共享按用户在 [AgoraScreenCaptureParameters](./API%20Reference/oc/Classes/AgoraScreenCaptureParameters.html) 类下设置的 [dimensions](./API%20Reference/oc/Classes/AgoraScreenCaptureParameters.html#//api/name/dimensions) 值进行计费。如果用户没有设置 `dimensions` 的值，SDK 会按 1920 x 1080 计费。

同时，为方便用户选择屏幕共享时是否采集鼠标，该版本在 `AgoraScreenCaptureParameters` 类中新增 [captureMouseCursor](./API%20Reference/oc/Classes/AgoraScreenCaptureParameters.html#//api/name/captureMouseCursor) 参数。该参数默认采集鼠标。

#### 3、本地视频状态回调

为方便开发者了解本地视频状态，该版本新增 [localVideoStateChange](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localVideoStateChange:error:) 回调。该回调下，本地视频有 `Stopped`、`Capturing`、`Encoding` 和 `Failed` 四种状态。当本地视频状态为 `Failed` 时，用户可以参考该回调 `error` 参数返回的错误码进行问题排查。该回调能帮助开发者辨别本地视频故障是由采集还是编码引起的。原有的 `rtcEngineCameraDidReady` 和 `rtcEngineVideoDidStop` 回调在该版本废弃，我们不再推荐。

#### 4、推流状态回调

为方便推流用户了解当前的推流状态，并在推流出错时了解原因排查问题，该版本新增 [rtmpStreamingChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:rtmpStreamingChangedToState:state:errorCode:) 回调。该回调下，推流有 `Idle`、`Connecting`、`Running`、`Recovering` 和 `Failure` 五种状态。当推流状态为 FAILURE 时，用户可以参考该回调 `errCode` 参数返回的错误码进行问题排查。原有的 `streamPublishedWithUrl` 和 `streamUnpublishedWithUrl` 回调仍可以使用，但我们不再推荐。

#### 5、网络连接失败原因梳理

为方便开发者更好地排查网络连接相关故障，该版本梳理并整合了网络连接相关的错误码，在原有 [connectionChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:) 回调的 `reason` 参数中新增八个导致网络连接失败的原因。新增后，只要网络连接发生错误，SDK 都会返回该回调。同时该版本废弃了原有的警告码 `AgoraWarningCodeLookupChannelRejected(105)` 和错误码 `AgoraErrorCodeTokenExpired(109)`、`AgoraErrorCodeInvalidToken(110)`。

#### 6、本地网络连接类型回调

为方便用户了解本地网络的连接类型，该版本新增 [networkTypeChangedToType](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:networkTypeChangedToType:) 回调。该回调下，本地网络连接有 `Unknown`、`Disconnected`、`Lan` `Wifi`、`2G`、`3G`、`4G` 七种类型。当网络连接短暂中断时，该回调能帮助开发者辨别引起中断的原因是网络切换还是网络条件不好。

#### 7、获取播放伴奏音量

为方便开发者获取伴奏的播放音量，排查音量相关问题，该版本新增 [getAudioMixingPlayoutVolume](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPlayoutVolume:) 和 [getAudioMixingPublishVolume](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPublishVolume:) 方法，用以分别获取音乐文件在本地和远端的播放音量。

#### 8、精确回调远端音频首帧解码

为更精准地获取远端用户的出声时间，该版本新增 [firstRemoteAudioFrameDecodedOfUid](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:firstRemoteAudioFrameDecodedOfUid:elapsed:) 回调，用以向 App 层报告 SDK 已完成远端音频首帧解码。在远端用户加入频道后首次发送音频，或远端用户 15 秒不发音频后再次发送时，该回调均会被触发。该回调与 `firstRemoteAudioFrameOfUid` 的区别在于，`firstRemoteAudioFrameOfUid` 在收到首个音频包时触发，先于 `firstRemoteAudioDecodedOfUid`。

**改进**

#### 1、质量透明

- 该版本在通话相关的统计信息 [AgoraChannelStats](./API%20Reference/oc/Classes/AgoraChannelStats.html) 类中，新增 [txPacketLossRate](./API%20Reference/oc/Classes/AgoraChannelStats.html#//api/name/txPacketLossRate) 和 [rxPacketLossRate](./API%20Reference/oc/Classes/AgoraChannelStats.html#//api/name/rxPacketLossRate) 参数，分别返回本地客户端到服务器和服务器到本地客户端的丢包率。
- 该版本对 AgoraLocalVideoStats 和 AgoraRemoteVideoStats 类作了如下变动，方便用户更精准地获取本地和远端视频流的统计信息：
  - [AgoraRtcLocalVideoStats](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html)：新增 [encoderOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html#//api/name/encoderOutputFrameRate) 和 [rendererOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html#//api/name/rendererOutputFrameRate) 参数
  - [AgoraRtcRemoteVideoStats](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html)：新增 [decoderOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html#//api/name/decoderOutputFrameRate) 参数，并将原有的 receivedFrameRate 参数更名为 [rendererOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html#//api/name/rendererOutputFrameRate)

#### 2、其他改进

- 优化了[AgoraAudioScenario](./API%20Reference/oc/Constants/AgoraAudioScenario.html) 为 `GameStreaming` 时的音质效果
- 优化了部分场景下语音和视频的延时
- SDK 包大小降低约 0.5 M
- 提高了用户修改视频属性的码率后，网络质量打分的准确性
- 默认启用音频质量通知回调。开发者无需调用 enableAudioQualityIndication 方法，也可以收到 [remoteAudioStats](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStats:) 回调
- 提升了视频服务的稳定性
- 提升了推流服务的稳定性

**问题修复**

#### 视频

- 修复了特殊场景下无法自由切换屏幕共享流和摄像头流的问题

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
- `AgoraScreenCaptureParameters` 类新增参数 [captureMouseCursor](./API%20Reference/oc/Classes/AgoraScreenCaptureParameters.html#//api/name/captureMouseCursor)（macOS/Windows）
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

## **2.4.0 版**

该版本于 2019 年 4 月 1 日发布。新增特性、功能改进与修复问题列表详见下文。

**升级必看**

如果你希望通过 CocoaPods 自动导入库，请确保在运行 `pod install` 前，先运行 `pop update` 更新本地 CocoaPods 库。如果你希望通过指定 SDK 版本号获取最新版，请在 Podfile 中将版本号指定为 `'AgoraRtcEngnine_macOS', '2.4.0.1'`。

**新增特性**

#### 1. 高级屏幕共享

该版本针对原有的屏幕共享进行了升级，并支持如下功能：

- 多屏环境下共享指定屏幕或屏幕内的部分区域（[`startScreenCaptureByDisplayId`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/startScreenCaptureByDisplayId:rectangle:parameters:)）
- 共享指定窗口或窗口内的部分区域（[`startScreenCaptureByWindowId`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/startScreenCaptureByWindowId:rectangle:parameters:)）
- 根据屏幕共享的内容类型设置运动优先或细节优先（[`setScreenCaptureContentHint`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setScreenCaptureContentHint:)）
- 单独设置屏幕共享的分辨率、帧率和码率（[`updateScreenCaptureParameters`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/updateScreenCaptureParameters:)）

该版本废弃了原有的 `startScreenCapture` 接口。Agora 推荐你使用新接口实现屏幕共享 。新接口下，用户需要在设计获取 `displayId` 和 `windowId` 的代码逻辑，详情请参考[开始屏幕共享](screensharing_mac)。

#### 2. 变声和混响

在语音聊天室场景中添加变声和混响效果，能有效增强社交的趣味性。该版本在原有音效设置接口的基础上，新增 [`setLocalVoiceChanger`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceChanger:) 和 [`setLocalVoiceReverbPreset`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceReverbPreset:) 方法，开发者无需手动设置音效参数，直接选择想要的本地语音变声或混响效果。详情请参考[变声与混响](voice_effect_mac)。

#### 3. 听声辨位

该版本新增 [`enableSoundPositionIndication`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/enableSoundPositionIndication:) 和 [`setRemoteVoicePosition`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteVoicePosition:pan:gain:) 方法，支持本地用户听声辨位。用户需要在加入频道前调用 [`enableSoundPositionIndication`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/enableSoundPositionIndication:) 开启远端用户的语音立体声，然后在 [`setRemoteVoicePosition`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteVoicePosition:pan:gain:) 中设置远端用户声音出现的位置，通过左右耳听到的声音差异，对远端用户的声音产生方位感。在多人在线游戏场景，如射击游戏中，该功能可以增加游戏角色的方位感，模拟真实场景。

#### 4. 通话前 Last-mile 网络探测

在通话前进行 Last-mile 网络探测，可以有效帮助本地用户判断和预测上行网络质量是否良好。该版本新增通话前 Last-mile 网络探测接口 [`startLastmileProbeTest`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/startLastmileProbeTest:)、[`stopLastmileProbeTest`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/stopLastmileProbeTest) 及 [`lastmileProbeResult`](./API%20Reference/oc/v2.4/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileProbeTestResult:)，向用户反馈开始通话前上下行网络的带宽、丢包、网络抖动和往返时延数据。

#### 5. 音频设备回路测试

该版本新增音频设备回路测试接口 [`startAudioDeviceLoopbackTest`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/startAudioDeviceLoopbackTest:) 与 [`stopAudioDeviceLoopbackTest`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/stopAudioDeviceLoopbackTest)，用于测试本地的麦克风和播放设备能否正常工作。该测试在本地进行，不涉及网络传输。

#### 6. 设置用户媒体流优先级

该版本新增接口 [`setRemoteUserPriority`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteUserPriority:type:) 用于设置远端用户媒体流的优先级。该方法可以与 [`setRemoteSubscribeFallbackOption`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteSubscribeFallbackOption:) 搭配使用。如果开启了订阅流回退选项，弱网下 SDK 会优先保证高优先级用户收到的流的质量。

#### 7. 音乐文件播放状态回调

该版本为播放音乐文件新增回调 [`localAudioMixingStateDidChanged`](./API%20Reference/oc/v2.4/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioMixingStateDidChanged:errorCode:)，方便用户获知音乐文件的播放状态（成功/失败），以及播放出错的原因。同时新增一个警告码 701，当播放音乐文件时，本地音乐文件不存在、文件格式不支持或无法访问在线音乐文件 URL 时，均会触发该警告码。

#### 8. 设置日志文件大小

Agora SDK 有 2 个日志文件，每个文件默认大小为 512 KB。为解决该大小无法满足部分用户需求的问题，该版本新增接口 [`setLogFileSize`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setLogFileSize:)，用于设置 SDK 输出的日志文件大小。

**功能改进**

#### 1. 质量测试与透明

- 该版本使用新的 [`startEchoTestWithInterval`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/startEchoTestWithInterval:successBlock:) 接口取代原有的 [`startEchoTest`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/startEchoTest:)，新增参数 `intervalInSeconds`，用于设置返回测试结果的时间间隔。
- 该版本在本地视频流统计信息 [`AgoraRtcLocalVideoStats`](./API%20Reference/oc/v2.4/Classes/AgoraRtcLocalVideoStats.html) 类中新增 [`sentTargetBitrate`](./API%20Reference/oc/v2.4/Classes/AgoraRtcLocalVideoStats.html#//api/name/sentTargetBitrate)，[`sentTargetFrameRate`](./API%20Reference/oc/v2.4/Classes/AgoraRtcLocalVideoStats.html#//api/name/sentTargetFrameRate)，[`qualityAdaptIndication`](./API%20Reference/oc/v2.4/Classes/AgoraRtcLocalVideoStats.html#//api/name/qualityAdaptIndication) 三个参数，分别反映目标码率、目标帧率与和上次返回的本地视频流统计信息相比，本地视频质量的自适应情况。

#### 2. 视频偏好设置

一般场景下，Agora 默认的视频编码配置能满足需求。对于特定场景，该版本提供如下功能让用户选择视频偏好：

- 弱网下画质或流畅偏好设置。该版本在视频编码属性 [`AgoraVideoEncoderConfiguration`](./API%20Reference/oc/v2.4/Classes/AgoraVideoEncoderConfiguration.html) 类中新增 2 个参数 [`minFrameRate`](./API%20Reference/oc/v2.4/Classes/AgoraVideoEncoderConfiguration.html#//api/name/minFrameRate) 和 [`degradationPreference`](./API%20Reference/oc/v2.4/Classes/AgoraVideoEncoderConfiguration.html#//api/name/degradationPreference)，分别用于设置最低视频编码帧率，以及带宽受限时编码帧率的偏好。这两个参数需要搭配使用，详情请参考[设置视频属性](videoProfile_mac)。

- 采集时预览或性能偏好设置。该版本新增接口 [`setCameraCapturerConfiguration`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setCameraCapturerConfiguration:)，通过设置摄像头采集偏好，用户可以根据实际场景选择优先保证设备性能还是视频质量。具体场景及参数选择，请参考 [API 文档](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setCameraCapturerConfiguration:)。

#### 3. 核心质量改进

- 降低了音频延时
- 提升了视频质量和稳定性
- 缩短了远端视频的出图时间
- 改善了屏幕共享直播弱网下视频的流畅性和延迟
- 优化了 CPU 和内存占用

**问题修复**

#### 音频相关

- 修复了调用 `enableLocalAudio` 接口导致的蓝牙断开的问题
- 新增支持中文字符音乐
- 修正 `pushExternalAudioFrameSamplBuffer` 成功的返回值为 Yes
- 修复了高音声音变弱的问题
- 修复了偶现的声音快放问题
- 修复了使用 `getAudioPlaybackDevices` 方法无法获取虚拟声卡的问题

#### 视频相关

- 通过增加 `renderMode` 的默认值，修复了用户在没有设置的情况 下，窗口和画面比例不符合引发的拉伸问题
- 部分低性能设备上出现的播放视频卡住的问题
- 优化了 SDK 出图时间
- 修复了虚拟摄像头不支持 640 x 480 分辨时，Electron SDK 崩溃的问题
- 修复了共享窗口时，鼠标位置不对的问题

#### 其他

- 修复了转码推流场景下，SEI 信息与媒体流不同步的问题

**API 整理**

为提升用户体验，Agora 在 v2.4.0 版本中对 API 进行了如下变动：

#### 新增

- [`setBeautyEffectOptions`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setBeautyEffectOptions:options:)
- [`startScreenCaptureByDisplayId`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/startScreenCaptureByDisplayId:rectangle:parameters:)
- [`startScreenCaptureByWindowId`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/startScreenCaptureByWindowId:rectangle:parameters:)
- [`updateScreenCaptureParameters`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/updateScreenCaptureParameters:)
- [`setScreenCaptureContentHint`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setScreenCaptureContentHint:)
- [`setLocalVoiceChanger`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceChanger:)
- [`setLocalVoiceReverbPreset`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceReverbPreset:)
- [`enableSoundPositionIndication`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/enableSoundPositionIndication:)
- [`setRemoteVoicePosition`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteVoicePosition:pan:gain:)
- [`startLastmileProbeTest`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/startLastmileProbeTest:)
- [`stopLastmileProbeTest`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/stopLastmileProbeTest)
- [`setRemoteUserPriority`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteUserPriority:type:)
- [`startEchoTestWithInterval`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/startEchoTestWithInterval:successBlock:)
- [`startAudioDeviceLoopbackTest`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/startAudioDeviceLoopbackTest:)
- [`stopAudioDeviceLoopbackTest`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/stopAudioDeviceLoopbackTest)
- [`setCameraCapturerConfiguration`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setCameraCapturerConfiguration:)
- [`setLogFileSize`](./API%20Reference/oc/v2.4/Classes/AgoraRtcEngineKit.html#//api/name/setLogFileSize:)
- [`localAudioMixingStateDidChanged`](./API%20Reference/oc/v2.4/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioMixingStateDidChanged:errorCode:)
- [`lastmileProbeResult`](./API%20Reference/oc/v2.4/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileProbeTestResult:)

#### 废弃

- `startEchoTest`
- `startScreenCapture`
- `setVideoQualityParameters`

#### 其他

[`AgoraVideoEncoderConfiguration`](./API%20Reference/oc/v2.4/Classes/AgoraVideoEncoderConfiguration.html) 类中的 [`frameRate`](./API%20Reference/oc/v2.4/Classes/AgoraVideoEncoderConfiguration.html#//api/name/frameRate) 参数由 `enum` 型修改为 `int` 型。

## **2.3.3 版**

该版本于 2019 年 1 月 24 日发布。功能改进与修复问题详见下文。

**改进**

为提升用户体验，屏幕共享做了大量算法优化。针对不同的共享场景提供不同的屏幕共享策略，尤其针对 PPT 翻页和网页浏览场景，提升了屏幕共享过程中的流畅度和清晰度。同时改善了通信模式下屏幕共享开启阶段画面模糊的现象。

**问题修复**

修复了 `networkQuality` 回调不准确的问题。

## **2.3.2 版**

该版本于 2019 年 1 月 16 日发布。新增特性与修复问题详见下文。

**升级必看**

2.3.2 除了下文提到的功能和改进外，整体提升直播模式下视频弱网下抗丢包能力，提高流畅度，降低卡顿率。升级前，请了解版本兼容性:

- Native SDK 版本号须大于等于 1.11 版本
- Web SDK 版本号须大于等于 2.1 版本

**新增功能**

#### 1. 提升直播清晰度

Agora SDK 会根据网络条件进行码率自适应。为满足用户在直播场景下对视频清晰度的要求，该版本在 [setVideoEncoderConfiguration](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoEncoderConfiguration:) 接口中新增 [minBitrate](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/minBitrate) 参数，强制视频编码器输出高质量图片。如果将参数设为高于默认值，在网络状况不佳情况下可能会导致网络丢包，并影响视频播放的流畅度。因此如非对画质有特殊需求，Agora 建议不要修改该参数的值。

#### 2. 控制音乐文件的播放音量

为方便用户控制混音音乐文件的播放音量，该版本在已有 [`adjustAudioMixingVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingVolume:) 的基础上新增 [`adjustAudioMixingPlayoutVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPlayoutVolume:) 和 [`adjustAudioMixingPublishVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPublishVolume:) 接口，用于分别控制混音音乐文件在本地和远端的播放音量。

添加新的方法后，原有的 [adjustPlaybackSignalVolume](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustPlaybackSignalVolume:) 由控制人声和音乐的音量改为仅控制人声的音量。因此，如果要静音本地播放，需同时设置 `adjustPlaybackSignalVolume(0)` 和 `adjustAudioMixingPlayoutVolume(0)`。

该版本梳理了用户在音频采集到播放过程中可能会需要调整音量的场景，及各场景对应的 API，供用户参考使用。详见官网文档[调整通话音量](./volume_mac)。

#### 3. 直播中弱网环境下视频自动回退/重开

网络不理想的环境下，直播音视频的质量都会下降。为提升直播效率，Agora 新增了 [`setLocalPublishFallbackOption`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalPublishFallbackOption:) 和 [`setRemoteSubscribeFallbackOption`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteSubscribeFallbackOption:) 两个接口。用户设置这两个接口后，在网络条件差、无法同时保证音视频质量的情况下，SDK 会自动将视频流从大流切换为小流，或直接关闭视频流，从而保证或提高音频质量。同时 SDK 会持续监控网络质量， 并在网络质量改善时恢复音视频流。在推流回退为音频流时，或由音频流恢复为音视频流，触发 [`didLocalPublishFallbackToAudioOnly`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didLocalPublishFallbackToAudioOnly:) 或 [`didRemoteSubscribeFallbackToAudioOnly`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didRemoteSubscribeFallbackToAudioOnly:byUid:) 回调。

#### 4. 按用户返回音视频上下行码率、帧率、丢包率及延迟

为方便统计每个用户的音视频上下行码率、帧率及丢包率，该版本新增 [`audioTransportStatsOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:audioTransportStatsOfUid:delay:lost:rxKBitRate:) 和 [`videoTransportStatsOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:videoTransportStatsOfUid:delay:lost:rxKBitRate:) 回调。 通话或直播过程中，当用户收到远端用户发送的音视频数据包后，会周期性地发生该回调上报，频率约为 2 秒 1 次。 回调中包含用户的 UID、音/视频接收码率、丢包率、以及延迟时间（毫秒）。 并在统计频道内通话相关数据的 AgoraChannelStats 类中增加 [`lastmileDelay`](./API%20Reference/oc/Classes/AgoraChannelStats.html?transId=9fa366f0-01e7-11e9-a659-33e4b5b761ac#//api/name/lastmileDelay) 参数，返回客户端到 vos 服务器的延迟。

#### 5. 设置视频编码属性

为满足场景中视频旋转的需要，提升自定义视频源画质，该版本引入 [`setVideoEncoderConfiguration`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoEncoderConfiguration:) 替换原 [`setVideoProfile`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoProfile:swapWidthAndHeight:) 接口，来设置视频编码属性。 新接口中的 [`AgoraVideoEncoderConfiguration`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html) 类对应一套视频参数，包含视频的分辨率 `dimension`、帧率 `frame rate`、码率 `bitrate`、最低编码码率 `minBitrate` 以及视频方向 `orientationMode`，其中 Agora 建议保留 `minBitrate` 的默认设置。原接口 `setVideoProfile` 仍可使用，但不再推荐。

#### 6. 虚拟声卡采集

为提升声卡采集易用性，该版本在 [enableLoopbackRecording](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableLoopbackRecording:deviceName:) 接口中新增参数 `deviceName`，支持用户使用虚拟声卡进行采集。该参数 NULL 时默认使用当前声卡采集。如需使用虚拟声卡，直接使用虚拟声卡的产品名传参即可。

**改进**

#### 1. 提供更透明的质量数据统计

为提升质量透明的用户体验，该版本废弃了原有的 `audioQualityOfUid` 回调，并新增 `remoteAudioStats` 回调进行取代。和原来的接口相比，新接口使用更为综合的算法，通过引入音频丢帧率、端到端的音频延迟、接收端网络抖动的缓冲延迟等参数，使回调结果更贴近用户感受。同时，该版本优化了 `networkQuality` 的算法，对上下行网络质量采用不同的计算方法，使评分更精准。

- [`remoteAudioStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStats:)：通话中远端音频流的统计信息回调。用于替换 `audioQualityOfUid`
- [`networkQuality`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:networkQuality:txQuality:rxQuality:)：通话中每个用户的网络上下行 Last mile 质量报告回调。

Agora SDK 计划在下一个版本对如下 API 进行进一步改进：

- [`lastmileQuality`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileQuality:)：通话前网络上下行 Last mile 质量报告回调

该版本对数据统计相关回调进行了统一梳理，相关回调及算法详见[通话中数据统计](./in_call_statistics_macos?platform=macOS)。

#### 2. 改进获取 SDK 网络连接状态的生成策略

为提升 SDK 使用数据统计的准确性和合理性，该版本新增如下接口，用以获取 SDK 的网络连接状态，以及连接状态发生改变的原因。

- [`getConnectionState`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getConnectionState)：获取 SDK 的网络连接状态
- [`connectionChangedToState`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:)：SDK 的网络连接状态已改变回调

该版本废弃了原有的 [`rtcEngineConnectionDidInterrupted`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngineConnectionDidInterrupted:) 和 [`rtcEngineConnectionDidBanned`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngineConnectionDidBanned:) 回调。

在新的接口下，SDK 共有 5 种连接状态：未连接、正在连接、已连接、正在重新建立连接和连接失败。当连接状态发生改变时，都会触发 `connectionChangedToState` 回调。当条件满足时，原有的 `rtcEngineConnectionDidInterrupted` 和 `rtcEngineConnectionDidBanned` 回调也会触发，但 Agora 不再推荐使用。

#### 3. 优化打分反馈机制

为方便用户（开发者）收集最终用户（应用程序使用者）对使用应用进行通话或直播的反馈，该版本将 [`rate`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/rate:rating:description:) 接口中的打分范围由 1 - 10 修改为 1 - 5，减少最终用户的打分干扰。Agora 建议在应用程序中集成该接口，方便应用程序收集用户反馈。

#### 4. 其他改进

- 优化了直播模式下视频弱网抗丢包能力
- 加快了严重拥塞状态视频的恢复速度 s
- 优化了 API 的调用线程
- 增加了重新检测耳机插入和蓝牙设备连接的代码
- 降低了音频延时
- 优化了 macOS 设备的视频采集方式，降低了性能消耗

**问题修复**

#### SDK 相关：

- 修复了 SDK 在 macOS 设备上出现的崩溃问题

#### 音频相关：

- 修复了设备在连接蓝牙的状态下，退出频道后，音频不走蓝牙的问题
- 修复了调用 startAudioMixing 播放音乐文件时出现的崩溃问题
- 修复了麦克风在禁用的状态下，设备插上耳机后，禁用失效的问题
- 修复了外放条件下，上下麦、系统电话打断、Siri 中断、进退频道等多种场景下，出现的无法调节外放音量的问题
- 修复了应用从后台切回前台时，出现的出声音慢的问题

#### 视频相关：

- 修复了因视频编码问题引起的 Native 设备与 Web 端互通时，Web 端看不到 Native 端视频画面的问题
- 修复了 x86 设备上自采集图像时硬件编码器的相关问题
- 修复了视频自采集时的偶现问题

**API 整理**

为提升用户体验，Agora 在 v2.3.2 版本中对 API 进行了如下变动：

#### 新增

- [`setVideoEncoderConfiguration`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoEncoderConfiguration:)
- [`setLocalPublishFallbackOption`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalPublishFallbackOption:)
- [`setRemoteSubscribeFallbackOption`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteSubscribeFallbackOption:)
- [`getConnectionState`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getConnectionState)
- [`adjustAudioMixingPlayoutVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPlayoutVolume:)
- [`adjustAudioMixingPublishVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPublishVolume:)
- [`connectionChangedToState`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:)
- [`didLocalPublishFallbackToAudioOnly`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didLocalPublishFallbackToAudioOnly:)
- [`didRemoteSubscribeFallbackToAudioOnly`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didRemoteSubscribeFallbackToAudioOnly:byUid:)
- [`remoteAudioStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStats:)
- [`audioTransportStatsOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:audioTransportStatsOfUid:delay:lost:rxKBitRate:)
- [`videoTransportStatsOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:videoTransportStatsOfUid:delay:lost:rxKBitRate:)

#### 废弃

- [`setVideoProfile`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoProfile:swapWidthAndHeight:)
- [`audioQualityOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:audioQualityOfUid:quality:delay:lost:)
- [`rtcEngineConnectionDidInterrupted`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngineConnectionDidInterrupted:)
- [`rtcEngineConnectionDidBanned`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngineConnectionDidBanned:)

## **2.2.3 版**

该版本于 2018 年 7 月 5 日发布。新增特性与修复问题列表详见下文。

**升级必看**

为更好地提升用户体验，Agora SDK 在 2.1 版本中对动态秘钥进行了升级。 如果你当前使用的 SDK 是 2.1 之前的版本，并希望升级到 2.1 或更高版本，请务必参考 [动态秘钥升级说明](/cn/Agora%20Platform/token_migration) 。

**问题修复**

- 修复了特定场景下偶发的线上统计崩溃的问题。

- 修复了直播时特定场景下偶发的崩溃的问题。

- 修复了多人直播连麦时，SDK 内存增长的问题。

- 修复了特定场景下偶发的视频窗口尺寸变化后，视频卡住的问题。

- 修复了偶发的无法正常反馈频道内谁在说话以及说话者的音量的问题。

## **2.2.2 版**

该版本于 2018 年 6 月 21 日发布。修复问题列表详见下文。

**修复问题**

- 修复了特定场景下偶发的线上统计崩溃的问题
- 修复了特定场景下偶发的视频窗口尺寸变化后，视频卡住的问题
- 修复了偶发的无法正常反馈频道内谁在说话以及说话者的音量的问题

## **2.2.1 版**

该版本于 2018 年 5 月 30 日发布。内部代码优化。

## **2.2.0 版**

该版本于 2018 年 5 月 4 日发布。新增特性与修复问题列表详见下文。

**新增功能**

本次发版新增如下功能：

#### 1. 音效混响进频道

播放音效 `playEffect` 接口新增了一个 `publish` 参数，用于在播放音效时，远端用户可以听到本地播放的音效。

> 如果你的 SDK 是由之前版本升级到 v2.2 版本，请务必关注该接口功能的变动。

#### 2. 服务端部署代理服务器

通过部署 Agora 提供的代理服务器安装包，设有企业防火墙的用户可以设置代理服务器，使用 Agora 的服务。

#### 3. 获取远端视频状态

新增 `onRemoteVideoStateChanged` 接口，以获知远端视频流的状态。

#### 4. 直播添加视频水印

在本地直播及旁路直播中增加水印功能，允许用户将一张 PNG 图片作为水印添加到正在进行的本地直播或旁路直播中。新增 `addVideoWatermark` 和 `clearVideoWatermarks` 接口，以添加或删除本地直播水印；`LiveTranscoding `接口中新增 `watermark` 参数，用于控制旁路直播中水印的添加。

**改进功能**

本次发版改进如下功能：

#### 1. 当前说话者音量提示

改进 `enableAudioVolumeIndication `接口的功能，无论频道内是否有人说话，都会在回调中按设置的时间间隔返回说话者音量提示。

#### 2. 频道内网络质量监测

根据用户对频道内实时网络质量监测的需求，在 `onNetworkQuality` 中改进了返回数据的准确度。

#### 3. 进入频道前网络条件监测

为方便用户在仅频道前检查当前网络是否能支撑语音或视频通话，在 `onLastmileQuality` 中，由通过恒定码率监测优化为根据用户设定的 Video Profile 的码率进行监测，提高返回数据的准确度。且在网络状态为 unknown 时，依然以 2 秒的间隔返回回调。

#### 4. 提升音乐场景下的音质

提升了用户在播放音乐等场景下的音乐音质。

**问题修复**

- 修复了 macOS 设备上偶现的 crash 问题

- 修复了大量用户同时连麦直播时，偶发的抖屏现象

## **2.1.3 版**

该版本于 2018 年 4 月 19 日发布。新增特性与修复问题列表详见下文。

**升级必看**

该版本的 SDK 修改了 `setVideoProfile `方法在直播模式下的码率值，修改后的码率值与 2.0 版本一致。

**问题修复**

- 修复了 SDK 没有设置 Delegate 时，偶尔收不到 Block 回调的问题。

- 修复了 SDK 的外链符号里，有 NSAssertionHandler 的问题。

- 修复了部分手机上，用户离开频道后，开启自带的录音设备时，偶现录音出错的问题。

**改进**

改进了通信和直播模式下屏幕共享的效果，缩短了用户从屏幕共享模式切换回普通模式需要的时间间隔。

## **2.1.2 版**

该版本于 2018 年 4 月 2 日发布。新增特性与修复问题列表详见下文。

**升级必看**

SDK 升级至 2.1.2 的直播模式后，相同分辨率下，视频更清晰，但带宽也会变大。

**新增功能**

在已有 `setVideoProfile` 接口的基础上，新增一个 `setVideoResolution` 接口。用户可以用此接口，根据自身业务需要，手动设置视频的分辨率、帧率和码率。

**问题修复**

修复了通信模式的屏幕共享清晰度小于直播模式的问题。

## **2.1.1 版**

该版本于 2018 年 3 月 16 日发布。

请正在或已集成 2.1 SDK 的客户尽快升级更新！ 本次发版修复了一个的系统风险，请尽快升级以免对服务造成影响。

## **2.1.0 版**

该版本于 2018 年 3 月 7 日发布。新增特性与修复问题列表详见下文。

**新增功能**

本次发版新增如下功能：

#### 1. 开黑

新增了一个游戏开黑场景，用于节省流量和去除杂音，通过调用 API `setAudioProfile` 实现。

#### 2. 音效均衡和音效混响

在直播场景下，主播如果需要通过内置的麦克风美化和定制自己的语音输入，可以通过调用 API `setLocalVoiceEqualization` 和 `setLocalVoiceReverb` 轻易地设置音效均衡和混响来实现所需要的效果。

#### 3. 在线频道信息查询

新增 RESTful API 查询用户在频道中的状态信息，查询指定频道内的分角色用户列表，查询厂商频道列表，查询用户是否为连麦用户等。详见:

- 通话场景，详见 [控制台 RESTful API](/cn/Video/dashboard_restful_communication)
- 互动直播场景，详见 [控制台 RESTful API](/cn/Interactive%20Braodcast/dashboard_restful_live)

#### 4. 17 人视频

在直播场景下，同一频道内支持 17 位主播同时进行视频直播和连麦，详见文档:

- [实现视频直播](./broadcast_video_mac)
- [实现七人以上视频通话](./seventeen_people_iosmac)

#### 5. 自定义视频源

Agora SDK 提供了摄像头采集的默认实现，同时允许开发者使用自定义视频源。

#### 6. 自定义渲染器

Agora SDK 提供了默认的渲染器实现，用来显示本地视频图像和对端视频图像。使用默认的渲染器就能满足大部分开发者需求，复杂的业务场景下，Agora 也开放了自定义渲染器接口。

#### 7. 插入外部视频源

直播场景下，可以将采集到的视频添加到正在进行的直播中，直播室里的主播和观众可以一起边看电影、比赛或演出，边进行点评、互动等功能，会让现有的直播话题更广、体验更好。 仅支持拉入一路流，格式包括: RTMP, HLS, FLV。赛事直播最多同时支持 5 人连麦直播。

**改进**

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
<tr><td>计费优化</td>
<td>计费系统针对极小分辨率统一按音频计费，例如 16 * 16</td>
</tr>
</tbody>
</table>

**问题修复**

- 修复了自采集方案退出频道后 app 录不到声音的问题。

- 修复了偶现的崩溃。

- 修复了偶现的关闭麦克风无法听到声音的问题。

- 修复了偶现的黑屏问题。

## **2.0.2 版**

该版本于 2017 年 12 月 15 日发布。新增特性与修复问题列表详见下文。

**问题修复**

修复了 ffmpeg 符号冲突问题;

## **2.0 版及之前**

**2.0 版**

该版本于 2017 年 12 月 6 日发布。新增特性与修复问题列表详见下文。

#### **新增功能**

- 通信场景支持视频大小流功能，新增 API `setRemoteVideoStreamType()` 和 `enableDualStreamMode()` ;

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
  <td>废弃，已经被<code>rtcEngineLocalAudioMixingDidFinish</code>替代</td>
  </tr>
  <tr><td><code>rtcEngineDidAudioEffectFinish</code></td>
  <td>新增，当本地结束音效播放时触发该回调</td>
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

**1.14 版**

该版本于 2017 年 10 月 20 日发布。新增特性与修复问题列表详见下文。

#### **新增功能**

- 新增 API `setAudioProfile`设置音频参数和应用场景。

- 新增 API `setLocalVoicePitch`提供基础变声功能。

- 直播场景: 新增 API `setInEarMonitoringVolume` 提供调节耳返音量功能。

#### **改进**

- 优化了在高码率下的音频体验;

- 秒开: 直播场景下，单流模式时观众加入频道 1 秒内看见主播图像\(均值为 858 ms, 网络状态良好时可达 625 ms\);

- 节省带宽:

  - 1.14 以前: 如果你选择不听某人的音频或不看某人的视频，音视频流会照发。

  - 1.14 开始: 如果你选择不听或不看某人的流，则不会下发，从而节省带宽。

- 精准的码率控制:

  - 1.14 以前: 码率控制不够精准，上下波动幅度较大。波动过大容易造成网络拥塞，增加丢包、丢帧的概率，影响了带宽估计模块的精度，特别是在弱网低码率情况下尤为明显。

  - 1.14 开始: 精准的码率控制，要多少给多少，不多给也不少给，避免波动过大造成的网络拥塞，减少传输延时，有助于减少网络卡顿。

**1.13.1 版**

该版本于 2017 年 9 月 28 日发布。新增特性与修复问题列表详见下文。

#### **改进**

优化了特定场景下出现的回声问题。

**1.13 版**

该版本于 2017 年 9 月 4 日发布。新增特性与修复问题列表详见下文。

#### **新增功能**

- 新增 API `didClientRoleChanged `用于提醒直播场景下主播、观众上下麦的回调

- 新增单独关闭语音播放的功能

- 新增功能支持服务端推流失败回调

- 屏幕共享直播场景下采集声卡选项动态开启和关闭

#### **改进**

- 软编情况下，视频属性可控

- 可以在客户端设置推流的 profile

- 屏幕共享: 提升了画质清晰度和流畅度

- 屏幕共享: 通信场景下新增动态更新截图区域

#### **修复问题**

修复了部分机型上偶现的崩溃

**1.12 版**

该版本于 2017 年 7 月 25 日发布。新增特性与修复问题列表详见下文。

#### **新增功能**

- 直播场景下， 新增 API 方法 `injectStream` 在当前频道内插入一条 RTMP 流。该功能目前为 beta 版

- 在 API 方法 `setEncryptionMode` 里新增加密模式 `aes-128-ecb` 。

- 在 API 方法 `startAudioRecording` 里新增参数 quality 用于设置录音音质。

- 新增一系列 API 管理音效。

- 新增 API `activeSpeaker` 提示当前频道内谁在说话。

- 通信场景下，删除了原有的 API 方法 `setScreenCaptureWindow`，更新 API 方法 `startScreenCapture` 共享整个屏幕、指定窗口或指定区域。

- 通信场景下，启用屏幕共享功能后，在屏幕共享过程中可以显示鼠标。

#### **改进**

通信场景下针对 320 x 180 分辨率提供了以下改进方案:

- 网络和设备状态较差的情况下仍能保证画质流畅度。
- 网络和设备状态良好的情况下可以做到比 180P 更好的画质清晰度。

#### **修复问题**

修复了部分机型上偶现的崩溃问题。
