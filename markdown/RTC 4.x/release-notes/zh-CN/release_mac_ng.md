## v4.2.2

该版本于 2023 年 7 月 xx 日发布。

#### 新增特性

1. **通配 Token**

   该版本新增通配 Token。生成 Token 时，在用户 ID 不为 0 的情况下，声网支持你将频道名设为通配符，从而生成可以加入任何频道的通配 Token。在需要频繁切换频道及多频道场景下，使用通配 Token 可以避免 Token 的重复配置，有助于提升开发效率，减少你的 Token 服务端的压力。详见[使用通配 Token](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms)。

   <div class="alert note">声网 4.x SDK 均支持使用通配 Token。</div

2. **预加载频道**

   该版本新增 `preloadChannelByToken [1/2]` 和 `preloadChannelByToken [2/2]` 方法，支持角色为观众的用户在加入频道前预先加载一个或多个频道。该方法调用成功后可以减少观众加入频道的时间，从而缩短观众听到主播首帧音频以及看到首帧画面的耗时，提升观众端的音视频体验。

   在同时预加载多个频道时，为避免观众在切换不同频道时需多次申请 Token 从而导致切换频道时间增长，因此声网推荐使用通配 Token 来减少你的业务服务端获取 Token 导致的耗时，进一步加快切换频道的速度，详见[使用通配 Token](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms)。

3. **自定义视频画布背景颜色**

   该版本在 `AgoraRtcVideoCanvas` 中增加了 `backgroundColor` 成员，支持你在设置本地或远端视频显示属性时，自定义视频画布的背景颜色。

4. **指定视频源进行预览**

   为支持用户选择不同类型的视频源进行本地视频预览，该版本新增 `startPreview [2/2]` 和 `stopPreview [2/2]`方法。你可以调用 `startPreview [2/2]` 并设置 `sourceType` 指定待预览的视频源类型；然后调用 `stopPreview [2/2]` 关闭视频预览。

   <div class="alert note">该方法中设置的视频源类型需要跟 <code>setupLocalVideo</code> 中 <code>AgoraRtcVideoCanvas</code> 的视频源类型一致。

5. **发布多源采集的视频流**

   该版本在 `AgoraRtcChannelMediaOptions` 中新增下列成员，支持你发布第三个、第四个摄像头和屏幕采集到的视频流：

   - `publishThirdCameraTrack`：发布第三个摄像头采集的视频。
   - `publishFourthCameraTrack`：发布第四个摄像头采集的视频。
   - `publishThirdScreenTrack`：发布第三个屏幕采集的视频。
   - `publishFourthScreenTrack`：发布第四个屏幕采集的视频。

   <div class="alert note">目前 SDK 支持在同一时间、同一 <code>AgoraRtcConnection</code> 中发布多路音频流、一路视频流。</div>

#### 改进

1. **虚拟背景算法升级**

   该版本升级了虚拟背景的人像分割算法，全面提升了人像分割的准确度、人像边缘与虚拟背景间的平滑度以及人物移动时边缘的贴合度，同时优化了虚拟背景在会议、办公、居家等场景下，以及逆光、弱光等条件下的人物边缘精度。

2. **跨频道连麦优化**

   该版本将跨频道连麦时媒体流转发的目标频道增加至 6 个，在调用 `startOrUpdateChannelMediaRelay` 和 `startOrUpdateChannelMediaRelayEx` 时，你可以指定最多 6 个目标频道。

3. **视频编解码查询能力增强**

   为提升设备编解码能力查询功能，该版本在 `CodecCapAgoraVideoCodecCapInfoInfo` 中新增 `codecLevels` 成员。当成功调用 `queryCodecCapability` 后，可通过 `codecLevels` 得知当前设备对于 H.264 和 H.265 格式的视频的硬件和软件解码能力等级。

该版本还进行了如下改进：

1. 在屏幕共享场景下，SDK 根据共享的场景自动调节发送端的帧率。尤其是在共享文档场景下，避免发送端的视频码率超出预期的情况，以提高传输效率、减小网络负担。
2. 为帮助用户了解更多类型的远端视频状态改变的原因，`remoteVideoStateChangedOfUid` 回调中新增了 `AgoraVideoRemoteReasonCodecNotSupport` 枚举，表示本地的视频解码器不支持对收到的远端视频流进行解码。

#### 问题修复

该版本修复了以下问题：

- 加入频道后，偶现本地用户听自己及远端的声音时出现杂音。
- 网络异常导致频道连接断开后，频道连接恢复较慢。
- 在屏幕共享场景下，部分机型偶现屏幕共享画面出图延迟高于预期。
- 自采集场景下，`setBeautyEffectOptions`、`setLowlightEnhanceOptions`、`setVideoDenoiserOptions` 和 `setColorEnhanceOptions` 无法自动加载插件。

#### API 变更

**新增**

- `startPreview [2/2]`
- `stopPreview [2/2]`
- `preloadChannelByToken [1/2]`
- `preloadChannelByToken [2/2]`
- `updatePreloadChannelToken`
- `AgoraRtcChannelMediaOptions` 中增加下列成员：
  - `publishThirdCameraTrack`
  - `publishFourthCameraTrack`
  - `publishThirdScreenTrack`
  - `publishFourthScreenTrack`
- `AgoraVideoCodecCapLevels`
- `AgoraVideoCodecCapabilityLevel`
- `AgoraRtcVideoCanvas` 中增加 `backgroundColor` 成员
- `CodecCapAgoraVideoCodecCapInfoInfo` 中增加 `codecLevels` 成员
- `AgoraVideoRemoteReason` 中增加 `AgoraVideoRemoteReasonCodecNotSupport` 枚举

## v4.2.1

该版本于 2023 年 6 月 21 日发布。

#### 改进

该版本改进了网络传输策略，提升了音视频交互的流畅度。

#### 问题修复

该版本修复了以下问题：

- SDK 不兼容部分旧版本 AccessToken 导致无法加入频道。
- 发送端调用 `setAINSMode` 开启 AI 降噪功能后，接收端用户偶现回声。
- 使用媒体播放器播放媒体文件时出现短暂杂音。
- 发送端启用屏幕共享功能后，偶现接收端看到共享画面的延迟较高。

# v4.2.0 版

该版本于 2023 年 5 月 23 日发布。

## 升级必看

该版本对部分功能的实现方式进行了优化，请在升级到该版本后更新 app 代码。

**1. 视频数据获取**

- `onCaptureVideoFrame` 和 `onPreEncodeVideoFrame` 回调中新增了 `sourceType` 参数，用于表示具体的视频源类型。
- 以下回调已删除，请通过 `onPreEncodeVideoFrame` 和 `onCaptureVideoFrame` 中的 `sourceType` 参数得知视频源类型。
  - `onScreenCaptureVideoFrame`
  - `onPreEncodeScreenVideoFrame`


**2. 媒体发布选项**

- `AgoraRtcChannelMediaOptions` 中的 `publishCustomAudioTrackEnableAec` 已删除，请改用 `publishCustomAudioTrack`。
- `AgoraRtcChannelMediaOptions` 中的成员 `publishTrancodedVideoTrack` 变更为 `publishTranscodedVideoTrack。`
- `AgoraRtcChannelMediaOptions` 中的成员 `publishCustomAudioSourceId` 变更为 `publishCustomAudioTrackId`。

**3. 音视频录制**

- 删除 `sharedMediaRecorderWithRtcEngine` 方法，可通过该版本新增的 `createMediaRecorder` 方法来创建录制对象。
- 删除 `startRecording` 、`stopRecording`、`setMediaRecorderDelegate` 中的 `connection` 参数。
- 删除 `AgoraMediaRecorder` 类中的 `destroy` 方法，你可直接调用该版本新增的 `destroyMediaRecorder` 方法来销毁录制对象以释放资源。

**4. 虚拟声卡**

自该版本起，SDK 新增对第三方虚拟声卡的支持，你可以将第三方虚拟声卡作为 SDK 的音频输入或输出设备。你可以通过 `stateChanged` 回调来了解当前 SDK 选择的输入输出设备是否为虚拟声卡。


<div class-="alert note">加频道时如果设置 AgoraALD、Soundflower 作为系统的默认输入或输出设备，会造成无声。<div>

**5. 其他兼容性变更**

- `didApiCallExecute` 已删除，请改用相关频道和媒体的事件通知得知 API 的执行结果。
- `enableDualStreamMode`[1/2] 和 `enableDualStreamMode`[2/2] 已废弃，请改用 `setDualStreamMode`[1/2] 和 `setDualStreamMode`[2/2]。
- `startChannelMediaRelay`、`updateChannelMediaRelay`、`startChannelMediaRelayEx` 和 `updateChannelMediaRelayEx` 已废弃，请改用 `startOrUpdateChannelMediaRelay` 和 `startOrUpdateChannelMediaRelayEx`。



## 新增特性

**1. AI 降噪**

该版本新增AI 降噪功能。开启该功能后，SDK 会智能识别和消除背景噪音，无论是在嘈杂的公共场所，还是在需要保持低延迟的实时竞技场景，都能够确保声音传输的清晰度，为用户提供更高质量的音频体验。你可以通过该版本新增的 `setAINSMode` 方法开启 AI 降噪，并根据实际场景，将降噪模式设置为均衡模式、强降噪模式或低延时模式。



**2.增强虚拟背景**

为了增加实时视频通话的趣味性、保护用户隐私，该版本增强了虚拟背景功能。你可以在调用 `enableVirtualBackground` 方法时，将自定义背景设置为更多类型：

- 将背景处理为 alpha 信息，不作替换，仅分割人像和背景，可结合本地合图功能实现人像画中画效果。
- 将背景替换为多种格式的本地视频。



**3. 视频场景化设置**

该版本新增 `setVideoScenario` 方法用于设置视频业务场景，SDK 会根据不同场景自动启用最佳实践策略，调整关键性能指标，进而优化视频质量，提升用户体验。无论是正式的商务会议还是轻松的在线聚会，该功能都能确保视频质量满足需求。目前，该特性主要为实时视频会议场景提供了以下针对性的优化：

- 针对会议场景对小流码率要求较高的情况，自动启用多项抗弱网技术，提升小流的抗弱网能力，确保多路流订阅时接收端的流畅性。
- 实时监测接收端大小流的订阅人数，根据订阅人数动态调节大流配置、动态开启和关闭小流，以节省上行带宽和消耗。

**4. 本地录制远端音视频（Beta）**

该版本新增本地录制远端音视频功能。本地用户可以录制远端用户的音频视频流，便于将来回放、分析或分享，适用于在线教育、企业培训、在线会议等多类场景。为更准确报告录制状态，该版本在 `stateDidChanged` 、`informationDidUpdated` 中新增 `channelId` 和 `uid` 参数，用于表示录制的音视频流的具体信息，并新增 createMediaRecorder 方法，用于创建本地或远端的录制对象。

你可以通过如下方法体验本地录制远端音视频功能：

- `createMediaRecorder`：创建录制对象。如需同时录制本地和远端的音视频，可以多次调用该方法创建多个录制对象。
- `setMediaRecorderDelegate`：设置录制回调对象。
- `startRecording`：开始录制。
- `stopRecording`：停止录制。
- `destroyMediaRecorder`：销毁录制对象。



**5. 本地合图**

该版本新增本地合图功能，用户可以调用 `startLocalVideoTranscoder` 方法，在本地将多路视频流（例如：摄像头采集的视频、屏幕共享流、视频文件、图片等）混合和渲染，以实现自定义布局和效果。通过这项功能，你可以轻松创建个性化的视频显示效果，满足各种场景需求，如远程会议、直播、在线教育场景，同时支持人像画中画等功能。

另外，SDK 还提供了`updateLocalTranscoderConfiguration` 方法和 `didLocalVideoTranscoderErrorWithStream` 回调。当你在开启本地合图后，可以调用 `updateLocalTranscoderConfiguration` 更新合图的配置；当你在开启本地合图或者更新本地合图配置失败时，可通过 `didLocalVideoTranscoderErrorWithStream` 回调得知合图失败的原因。


<div class="alert note">本地合图对 CPU 的消耗较高，声网建议你在性能较高的设备上开启该功能。</div>

**6. 多端同步**

在实时合唱的场景中，可能会出现网络原因导致各接收端下行链路不一致的情况，该版本新增 `getNtpWallTimeInMs` 方法获取当前的 NTP (网络时间协议) 时间，用于对齐多个接收端的歌词和音乐，实现合唱同步、歌词进度同步等，为用户提供更佳的协同体验。

## 改进

**1. 优化变声**

该版本新增了 `setLocalVoiceFormant` 方法，用于设置共振峰比率以改变语音的音色。该方法还可以和 `setLocalVoicePitch` 方法一起使用，同时调节音调和音色，实现更多样化的变声效果。

**2. 提升音视频同步能力**

针对自定义视频和音频采集场景，该版本新增 `getCurrentMonotonicTimeInMs` 方法用于获取当前的 Monotonic Time，将该值传入视频帧和音频帧的时间戳，可以精确控制音视频时序，确保音视频同步。


**3. 优化多路摄像头及屏幕采集**

该版本新增 `startCameraCapture` 和 `startScreenCapture` [2/2] 方法，通过多次调用并指定 `sourceType` 参数可以开启多路摄像头采集的视频流和多路屏幕采集的视频流，用于本地合图或多频道发布。适用于如远程医疗、远程教育等连接多个摄像头和显示器的场景。


**4. 优化跨频道连麦**

该版本新增 `startOrUpdateChannelMediaRelay` 和 `startOrUpdateChannelMediaRelayEx` 方法，通过一个方法实现开始跨频道转发和更新转发的目标频道，提升了接口易用性；同时，优化内部交互次数，有效降低调用了延迟。在降低开发难度的同时，为开发者提供更顺畅的使用体验。



**5. 多路音频自采集**

为更好地满足音频自采集的场景需求，该版本新增了 `createCustomAudioTrack` 和 `destroyCustomAudioTrack` 方法用于创建和销毁自定义音频轨道，并提供了两种音频轨道类型供用户选择，进一步提升了自采集音频处理的灵活性和易用性：

- 可混音的音频轨道：支持将多路外部音频源混合发布到同一频道中，适用于多路音频源的自采集场景。
- 非混音的音频轨道：仅支持将一路外部音频源发布到单个频道中，适用于实时低延迟的自采集场景。


## 问题修复

该版本修复了以下问题：

- 当快速切换身份角色时，观众端听不到声音。
- 接收端默认接收小流几秒后自动变为大流。
- 调用 `getdefaultaudiodevice` 后返回值中的 `type` 字段信息错误。
- 屏幕共享偶现共享画面抖动。



## API 变更

**新增**

- `startCameraCapture`

- `stopCameraCapture`

- `startScreenCapture[2/2]`

- `stopScreenCapture[2/2]`

- `startOrUpdateChannelMediaRelay`

- `startOrUpdateChannelMediaRelayEx`

- `getNtpWallTimeInMs`

- `setVideoScenario`

- `getCurrentMonotonicTimeInMs`

- `didLocalVideoTranscoderErrorWithStream`

- `startLocalVideoTranscoder`

- `updateLocalTranscoderConfiguration`

- `setAINSMode`

- `createCustomAudioTrack`

- `destroyCustomAudioTrack`

- `createMediaRecorder`

- `destroyMediaRecorder`

- `AudioTrackConfig`

- `AgoraRecorderStreamInfo`

- `AUDIO_AINS_MODE`

- `AgoraAudioTrackType`

- `AgoraApplicationScenarioType`

- `AgoraScreenCaptureFrameRateCapability`

- `AgoraRtcEngineConfig` 中新增 `domainLimit` 和 `autoRegisterAgoraExtensions` 属性

- `stateDidChanged`、`informationDidUpdated` 中新增 `channelId` 和 `uid` 参数

- `onCaptureVideoFrame` 和 `onPreEncodeVideoFrame` 中增加 `sourceType` 参数

- `AgoraVirtualBackgroundSourceType` 中新增 `AgoraVirtualBackgroundNone` 和 `AgoraVirtualBackgroundVideo`


**废弃**

- `enableDualStreamMode`[1/2]
- `enableDualStreamMode`[2/2]
- `startChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelay`
- `updateChannelMediaRelayEx`
- `didReceiveChannelMediaRelayEvent`
- `AgoraChannelMediaRelayEvent`

**删除**

- `startPrimaryScreenCapture`
- `startSecondaryScreenCapture`
- `stopPrimaryScreenCapture`
- `stopSecondaryScreenCapture`
- `startPrimaryCameraCapture`
- `startSecondaryCameraCapture`
- `stopPrimaryCameraCapture`
- `stopSecondaryCameraCapture`
- `didApiCallExecute`
- `AgoraRtcChannelMediaOptions` 中的 ` publishCustomAudioTrackEnableAec`
- `sharedMediaRecorderWithRtcEngine`
- `AgoraMediaRecorder` 类中的 `destroy`
- `startRecording`、`stopRecording`、`setMediaRecorderDelegate` 中删除 `connection` 参数
- `onScreenCaptureVideoFrame`
- `onPreEncodeScreenVideoFrame`


## v4.1.1 版

该版本于 2023 年 1 月 xx 日发布。


#### 升级必看
**1. 默认分辨率**
自该版本起，SDK 对视频编码的算法进行了优化，将默认的视频编码分辨率从 640 × 360 提升为 960 × 540，以适应设备性能和网络带宽的提升，在各种音视频互动场景下，为用户提供全链路的高清体验。

如果你想自定义视频编码分辨率，可调用 `setVideoEncoderConfiguration` 方法，重新设置视频编码参数配置中的视频编码分辨率。

<div class="alert note">由于默认分辨率的提升，会影响集合分辨率从而导致费用变更。详见<a href="./billing_rtc_ng">计费说明</a>。</div>

**2. 设置远端视频流的订阅选项**
该版本起，`setRemoteVideo` 更名为 `setRemoteVideoSubscriptionOptions`；`setRemoteVideoEx` 更名为 `setRemoteVideoSubscriptionOptionsEx`。如果你将 SDK 升级至该版本或更高版本，请在调用处同步修改以上两个方法的名称。


#### 新增特性

**1. 快速出图出声**

该版本新增 `enableInstantMediaRendering` 方法，用于开启音视频帧的加速渲染模式，可加快用户加入频道后的首帧出图与出声速度。

**2. 视频渲染数据打点**

该版本新增 `startMediaRenderingTracing` 和 `startMediaRenderingTracingEx` 方法，SDK 以调用该方法的时刻作为起点，开始跟踪频道内视频帧的渲染状态，并通过 `videoRenderingTracingResultOfUid` 回调报告相关事件的信息。

声网推荐你将该方法和 app 中的 UI 设置（按钮、滑动条等）结合使用。例如：在终端用户点击“加入频道”按钮的时刻调用该方法进行打点，然后通过 `videoRenderingTracingResultOfUid` 回调获取视频帧渲染过程中的指标，从而方便开发者针对指标进行专项优化，以提高出图效率。



#### 改进

**视频观测器**

自该版本起，SDK 对 `onRenderVideoFrame` 回调进行了优化，在不同的视频处理模式下返回值的意义不同：

- 当视频处理模式为 `AgoraVideoFrameProcessModeReadOnly` 时，返回值无实际含义。
- 当视频处理模式为 `AgoraVideoFrameProcessModeReadWrite` 时，返回 `YES` 代表设置 SDK 接收视频帧；返回 `NO` 代表设置 SDK 丢弃视频帧。


#### 问题修复

该版本修复了以下问题：

- 使用媒体播放器播放采样率超过 48 kHz 的音频时，播放失败。
- 把播放器的渲染视图设为 `UIViewController` 的视图后，使用播放器播放视频，视频窗口切到全屏时视频画面会从左下角开始逐渐放大。
- 加入频道后接入外接摄像头，调用 `setDevice` 指定视频采集设备为该外接摄像头，方法未生效。
- 当频道内有多路视频流时，调用部分视频增强插件相关 API 偶现失败。



#### API 变更

**新增**

- `enableInstantMediaRendering`
- `startMediaRenderingTracing`
- `startMediaRenderingTracingEx`
- `videoRenderingTracingResultOfUid`
- `AgoraMediaRenderTraceEvent`
- `AgoraVideoRenderingTracingInfo`

**修改**
- `setRemoteVideo` 更名为 `setRemoteVideoSubscriptionOptions`
- `setRemoteVideoEx` 更名为 `setRemoteVideoSubscriptionOptionsEx`

**删除**

- `enableRemoteSuperResolution`
- `AgoraRtcRemoteVideoStats` 中删除 `superResolutionType`