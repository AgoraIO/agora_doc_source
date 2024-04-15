## v4.2.2

该版本于 2023 年 7 月 xx 日发布。

#### 新增特性

1. **通配 Token**

   该版本新增通配 Token。生成 Token 时，在用户 ID 不为 0 的情况下，声网支持你将频道名设为通配符，从而生成可以加入任何频道的通配 Token。在需要频繁切换频道及多频道场景下，使用通配 Token 可以避免 Token 的重复配置，有助于提升开发效率，减少你的 Token 服务端的压力。详见[使用通配 Token](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms)。

   <div class="alert note">声网 4.x SDK 均支持使用通配 Token。</div>

2. **预加载频道**

   该版本新增 `preloadChannel` 和 `preloadChannelWithUserAccount` 方法，支持角色为观众的用户在加入频道前预先加载一个或多个频道。该方法调用成功后可以减少观众加入频道的时间，从而缩短观众听到主播首帧音频的耗时，提升观众端的音频体验。

   在同时预加载多个频道时，为避免观众在切换不同频道时需多次申请 Token 从而导致切换频道时间增长，因此声网推荐使用通配 Token 来减少你的业务服务端获取 Token 导致的耗时，进一步加快切换频道的速度，详见[使用通配 Token](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms)。

#### 改进

**跨频道连麦优化**

该版本将跨频道连麦时媒体流转发的目标频道增加至 6 个，在调用 `startOrUpdateChannelMediaRelay` 和 `startOrUpdateChannelMediaRelayEx` 时，你可以指定最多 6 个目标频道。

#### 问题修复

该版本修复了以下问题：

- 加入频道后，偶现本地用户听自己及远端的声音时出现杂音。 (macOS)
- 网络异常导致频道连接断开后，频道连接恢复较慢。
- 多设备音频录制场景下，反复插拔或开启/禁用音频录制设备后，偶现调用 `startRecordingDeviceTest` 进行音频采集设备测试时听不到声音。 (Windows)

#### API 变更

**新增**

- `preloadChannel`
- `preloadChannelWithUserAccount`
- `updatePreloadChannelToken`

## v4.2.1

该版本于 2023 年 6 月 21 日发布。

#### 改进

该版本改进了网络传输策略，提升了音视频交互的流畅度。

#### 问题修复

该版本修复了以下问题：

- SDK 不兼容部分旧版本 AccessToken 导致无法加入频道。
- 发送端调用 `setAINSMode` 开启 AI 降噪功能后，接收端用户偶现回声。
- 使用媒体播放器播放媒体文件时出现短暂杂音。
- 发送端启用屏幕共享功能后，偶现接收端看到共享画面的延迟较高。（macOS）
- 发送端将两路摄像头采集的视频进行本地合图并发布后，接收端偶现第二路摄像头画面缺失。（Windows）

## v4.2.0

该版本于 2023 年 5 月 26 日发布。

#### 升级必看

该版本对部分功能的实现方式进行了优化，请在升级到该版本后更新 app 代码。

**1. 视频采集 (Windows)**

原有用于摄像头和屏幕采集的方法已删除，请改用下表中列出的替代方法，并通过设置 `sourceType` 来指定视频源。

| 已删除方法                                                   | 替代方法                         |
| :----------------------------------------------------------- | :------------------------------- |
| <li>`startPrimaryCameraCapture`</li><li>`startSecondaryCameraCapture`</li> | `startCameraCapture`             |
| <li>`stopPrimaryCameraCapture`</li><li>`stopSecondaryCameraCapture`</li> | `stopCameraCapture`              |
| <li>`startPrimaryScreenCapture`</li><li>`startSecondaryScreenCapture`</li> | `startScreenCaptureBySourceType` |
| <li>`stopPrimaryScreenCapture`</li><li>`stopSecondaryScreenCapture`</li> | `stopScreenCaptureBySourceType`  |

**2. 视频数据获取**

- `onCaptureVideoFrame` 和 `onPreEncodeVideoFrame` 回调中新增了 `sourceType` 参数，用于表示具体的视频源类型。

- 以下回调已删除，请通过 `onPreEncodeVideoFrame` 和 `onCaptureVideoFrame` 中的 `sourceType`参数得知视频源类型。(Windows)
  - `onSecondaryPreEncodeCameraVideoFrame`
  - `onScreenCaptureVideoFrame`
  - `onPreEncodeScreenVideoFrame`
  - `onSecondaryPreEncodeScreenVideoFrame`

**3. 媒体发布选项**

- `ChannelMediaOptions` 中的 `publishCustomAudioTrackEnableAec` 已删除，请改用 `publishCustomAudioTrack`。
- `ChannelMediaOptions` 中的成员 `publishTrancodedVideoTrack` 变更为 `publishTranscodedVideoTrack。`
- `ChannelMediaOptions` 中的成员 `publishCustomAudioSourceId` 变更为 `publishCustomAudioTrackId`。

**4. 音视频录制**

- 删除 ` InterfaceIdType` 中的 `AgoraIidMediaRecorder` 。在创建录制对象前无需再获取 `AgoraIidMediaRecorder` 接口类指针，你可以直接调用该版本新增的 `createMediaRecorder` 方法创建录制对象。（Windows）
- 删除 `getMediaRecorder` 方法，可通过该版本新增的 `createMediaRecorder` 方法来创建录制对象。(macOS)
- 删除 `startRecording` 、`stopRecording`、`setMediaRecorderObserver` 中的 `connection` 参数。
- 删除 `IMediaRecorder` 类中的 `release` 方法，你可直接调用该版本新增的 `destroyMediaRecorder` 方法来销毁录制对象以释放资源。

**5. 本地合图**

- `LocalTranscoderConfiguration` 中的 `VideoInputStreams` 变更为 `videoInputStreams`。
- `TranscodingVideoStream` 中的枚举类 `MediaSourceType` 变更为 `VideoSourceType`。

**6. 虚拟声卡 (macOS)**

自该版本起，SDK 新增对第三方虚拟声卡的支持，你可以将第三方虚拟声卡作为 SDK 的音频输入或输出设备。你可以通过 `stateChanged` 回调来了解当前 SDK 选择的输入输出设备是否为虚拟声卡。

<div class="alert note">加频道时如果设置 AgoraALD、Soundflower 作为系统的默认输入或输出设备，会造成无声。</div>

**7. 默认分辨率提升**

 自该版本起，SDK 对视频编码的算法进行了优化，将默认的视频编码分辨率从 640 × 360 提升为 960 × 540，以适应设备性能和网络带宽的提升，在各种音视频互动场景下，为用户提供全链路的高清体验。

 如果你想自定义视频编码分辨率，可调用 `setVideoEncoderConfiguration` 方法，重新设置视频编码参数配置中的视频编码分辨率。

<div class="note">由于默认分辨率的提升，会影响集合分辨率从而导致费用变更。详见<a href="./billing_rtc_ng">计费说明</a>。</div>

**8. 其他兼容性变更**

- `onApiCallExecuted` 已删除，请改用相关频道和媒体的事件通知得知 API 的执行结果。
- `IAudioFrameObserver` 类名变更为 `IAudioPcmFrameSink`，因此下列方法原型也有相应更新：（Windows）
  - `onFrame`
  - `IMediaPlayer` 下的 `registerAudioFrameObserver` 和 `unregisterAudioFrameObserver`。
- `startChannelMediaRelay`、`updateChannelMediaRelay`、`startChannelMediaRelayEx` 和 `updateChannelMediaRelayEx` 已废弃，请改用 `startOrUpdateChannelMediaRelay` 和 `startOrUpdateChannelMediaRelayEx`。

#### 新增特性

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

**4.本地录制远端音视频（Beta）**

该版本新增本地录制远端音视频功能。本地用户可以录制远端用户的音频视频流，便于将来回放、分析或分享，适用于在线教育、企业培训、在线会议等多类场景。为更准确报告录制状态，该版本在 `onRecorderStateChanged`、`onRecorderInfoUpdated` 中新增 `channelId` 和 `uid` 参数，用于表示录制的音视频流的具体信息，并新增 `createMediaRecorder` 方法，用于创建本地或远端的录制对象。

你可以通过如下方法体验本地录制远端音视频功能：

- `createMediaRecorder`：创建录制对象。如需同时录制本地和远端的音视频，可以多次调用该方法创建多个录制对象。
- `setMediaRecorderObserver`：设置录制回调对象。
- `startRecording`：开始录制。
- `stopRecording`：停止录制。
- `destroyMediaRecorder`：销毁录制对象。

**5. 本地合图**

自该版本起，本地合图功能支持 macOS。此外，该版本新增了 `onLocalVideoTranscoderError` 回调，当你在开启本地合图或者更新本地合图配置失败时，SDK 会触发该回调并报告合图失败的原因。

**6. 多端同步**

在实时合唱的场景中，可能会出现网络原因导致各接收端下行链路不一致的情况，该版本新增 `getNtpWallTimeInMs` 方法获取当前的 NTP (网络时间协议) 时间，用于对齐多个接收端的歌词和音乐，实现合唱同步、歌词进度同步等，为用户提供更佳的协同体验。

 **7. 快速出图出声**

 该版本新增 `enableInstantMediaRendering` 方法，用于开启音视频帧的加速渲染模式，可加快用户加入频道后的首帧出图与出声速度。

 **8. 视频渲染数据打点**

 该版本新增 `startMediaRenderingTracing` 和 `startMediaRenderingTracingEx` 方法，SDK 以调用该方法的时刻作为起点，开始跟踪频道内视频帧的渲染状态，并通过 `onVideoRenderingTracingResult` 回调报告相关事件的信息。

 声网推荐你将该方法和 app 中的 UI 设置（按钮、滑动条等）结合使用。例如：在终端用户点击“加入频道”按钮的时刻调用该方法进行打点，然后通过 `onVideoRenderingTracingResult` 回调获取视频帧渲染过程中的指标，从而方便开发者针对指标进行专项优化，以提高出图效率。

#### 改进

**1.优化变声**

该版本新增了 `setLocalVoiceFormant` 方法，用于设置共振峰比率以改变语音的音色。该方法还可以和 `setLocalVoicePitch` 方法一起使用，同时调节音调和音色，实现更多样化的变声效果。

 **2. 提升渲染兼容性（Windows）**

提升了渲染的兼容性，解决了部分设备渲染失败而导致的黑屏问题。

**3. 提升音视频同步能力**

针对自定义视频和音频采集场景，该版本新增 `getCurrentMonotonicTimeInMs` 方法用于获取当前的 Monotonic Time，将该值传入视频帧和音频帧的时间戳，可以精确控制音视频时序，确保音视频同步。

**4.  优化多路摄像头及屏幕采集**

该版本新增 `startCameraCapture` 和 `startScreenCaptureBySourceType` 方法，通过多次调用并指定 `sourceType` 参数可以开启多路摄像头采集的视频流和多路屏幕采集的视频流，用于本地合图或多频道发布。适用于如远程医疗、远程教育等连接多个摄像头和显示器的场景。

**5. 优化跨频道连麦**

该版本新增 `startOrUpdatechannelMediaRelay` 和 `startOrUpdatechannelMediaRelayEx` 方法，通过一个方法实现开始跨频道转发和更新转发的目标频道，提升了接口易用性；同时，优化内部交互次数，有效降低调用了延迟。在降低开发难度的同时，为开发者提供更顺畅的使用体验。

**6. 多路音频自采集**

为更好地满足音频自采集的场景需求，该版本新增了 `createCustomAudioTrack` 和 `destroyCustomAudioTrack` 方法用于创建和销毁自定义音频轨道，并提供了两种音频轨道类型供用户选择，进一步提升了自采集音频处理的灵活性和易用性：

- 可混音的音频轨道：支持将多路外部音频源混合发布到同一频道中，适用于多路音频源的自采集场景。
- 非混音的音频轨道：仅支持将一路外部音频源发布到单个频道中，适用于实时低延迟的自采集场景。

 **7. 视频观测器**

 自该版本起，SDK 对 `onRenderVideoFrame` 回调进行了优化，在不同的视频处理模式下返回值的意义不同：

 - 当视频处理模式为 `ProcessModeReadOnly` 时，返回值无实际含义。
 - 当视频处理模式为 `ProcessModeReadWrite` 时，返回 `true` 代表设置 SDK 接收视频帧；返回 `false` 代表设置 SDK 丢弃视频帧。

#### 问题修复

该版本修复了以下问题：

- 当快速切换身份角色时，观众端听不到声音。
- 接收端默认接收小流几秒后自动变为大流。(macOS)。
- 屏幕共享偶现共享画面抖动。(macOS)
- 使用媒体播放器播放网络摄像头的 RTSP 码流时，偶现花屏。（Windows）
- 使用媒体播放器播放采样率超过 48 kHz 的音频时，播放失败。
- 把播放器的渲染视图设为 UIViewController 的视图后，使用播放器播放视频，视频窗口切到全屏时视频画面会从左下角开始逐渐放大。（macOS）
- 在本地合图场景下，不支持对 PNG 和 GIF 图片的 Alpha 通道渲染，导致透明底色的图片显示为非透明底色。
- 加入频道后添加水印然后删除，远端仍能看到水印。（Windows）
- 开始屏幕共享后添加水印，远端接收的屏幕共享画面没有水印。（Windows）
- 加入频道后接入外接摄像头，调用 `setDevice` 指定视频采集设备为该外接摄像头，方法未生效。
- 在屏幕共享场景下，如果将一个窗口设置为前置和描边，则必现窗口前置失败。(Windows)
- 当频道内有多路视频流时，调用部分视频增强插件相关 API 偶现失败。
- 客户端主动退出频道时未向服务端发起请求，导致服务端判定为退出频道超时。


#### API 变更

**新增**

- `startCameraCapture`
- `stopCameraCapture`
- `startScreenCaptureBySourceType`
- `stopScreenCaptureBySourceType`
- `startOrUpdateChannelMediaRelay`
- `startOrUpdateChannelMediaRelayEx`
- `getNtpWallTimeInMs`
- `setVideoScenario`
- `getCurrentMonotonicTimeInMs`
- `onLocalVideoTranscoderError`
- `startLocalVideoTranscoder`（Mac）
- `updateLocalTranscoderConfiguration`（Mac）
- `setAINSMode`
- `createCustomAudioTrack`
- `destroyCustomAudioTrack`
- `createMediaRecorder`
- `destroyMediaRecorder`
- `AudioTrackConfig`
- `RecorderStreamInfo`
- `AudioAinsMode`
- `AudioTrackType`
- `VideoApplicationScenarioType`
- `ScreenCaptureFramerateCapability`
- `RtcEngineContext` 中新增 `domainLimit` 和 `autoRegisterAgoraExtensions` 属性
- `onRecorderStateChanged`、`onRecorderInfoUpdated` 中新增 `channelId` 和 `uid` 参数
- `onCaptureVideoFrame` 和 `onPreEncodeVideoFrame` 中增加 `sourceType` 参数
- `BackgroundSourceType` 中新增 `BackgourndNone` 和 `BackgroundVideo`
- `enableInstantMediaRendering`
- `startMediaRenderingTracing`
- `startMediaRenderingTracingEx`
- `onVideoRenderingTracingResult`
- `MediaTraceEvent`
- `VideoRenderingTracingInfo`

**废弃**

- `startChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelay`
- `updateChannelMediaRelayEx`
- `onChannelMediaRelayEvent`
- `ChannelMediaRelayEvent`

**删除**

- `startPrimaryScreenCapture `
- `startSecondaryScreenCapture`
- `stopPrimaryScreenCapture`
- `stopSecondaryScreenCapture`
- `startPrimaryCameraCapture`
- `startSecondaryCameraCapture`
- `stopPrimaryCameraCapture`
- `stopSecondaryCameraCapture`
- `onSecondaryPreEncodeCameraVideoFrame`（Windows）
- `onScreenCaptureVideoFrame`（Windows）
- `onPreEncodeScreenVideoFrame`（Windows）
- `onSecondaryPreEncodeScreenVideoFrame`（Windows）
- `onApiCallExecuted`
- `ChannelMediaOptions` 中的 `publishCustomAudioTrackEnableAec`
- `getMediaRecorder`
- `IMediaRecorder` 类中的 `release`
- `AgoraIidMediaRecorder`（Windows）
- `startRecording`、`stopRecording`、`setMediaRecorderObserver` 中删除 `connection` 参数


## v4.1.0

该版本于 2022 年 12 月 20 日发布。

#### 升级必看

如果你已经使用了以下类或方法，请在升级到该版本后重新调用方法并更新参数设置：

删除了 `enableDualStreamMode` 中的 `sourceType` 参数，因为 SDK 支持对自定义采集或 SDK 采集的各种视频源开启双流模式，不再需要指定视频源类型。

#### 新增特性

**1. 耳返**

该本版新增耳返功能。你可以调用 `enableInEarMonitoring` 开启耳返功能。

如需调节耳返音量，你可以调用 `setInEarMonitoringVolume`。

**2. 本地网络连接类型**

为方便用户在任何阶段知悉本地网络的连接类型，该版本新增 `getNetworkType` 方法。你可以通过该方法获取正在使用的网络连接的类型，包括 UNKNOWN、DISCONNECTED、LAN、WIFI、2G、3G、4G、5G。当本地网络连接类型发生改变时，SDK 会触发 `onNetworkTypeChanged` 回调，报告当前的网络连接类型。

**3. 音强选流**

声网服务器会根据音量大小对音频流进行筛选，选出 N 路音量最大的音频流并传输至接收端。N 默认为 3 路，如需自定义设置 N，请联系技术支持。

同时，声网还支持发流端自定义设置是否参与音强选流，不参与选流的音频流会直接和被选出的 N 路音频流一同传输至接收端。在大型会议等多人发流的场景下，开启音强选流功能可以帮助减轻接收端的下行带宽压力和系统资源消耗，详见[音强选流](./audio_stream_filter_electron_ng?platform=Electron)。

<div class="alert info">该版本新增音强选流功能，如需开启该功能，请联系<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">技术支持</a>。</div>

**4. 双流模式**

该版本对双流模式做了优化，在加入频道前后均可调用 `enableDualStreamMode` 和 `enableDualStreamModeEx`。

扩展了订阅视频小流的实现方式，SDK 默认在发送端开启小流 auto 模式 (即：默认不主动发送小流) ，可通过以下步骤开启发送小流：

1. 接收端主播调用 `setRemoteVideoStreamType` 或 `setRemoteDefaultVideoStreamType` 发起接收小流申请。
2. 发送端收到申请后自动切换为发送小流模式。

如果你想修改上述发送端的默认行为，可以调用 `setDualStreamMode` 方法，将 `mode` 参数设置为 `disableSimulcastStream` (始终不发送小流) 或 `enableSimulcastStream` (始终发送小流) 。

**5. 声卡采集设备 (Windows)**

SDK 默认使用播放设备为声卡采集设备，自该版本起，你可以另外指定声卡采集设备并将其采集到的音频发布到远端。

- `setLoopbackDevice`：用于指定声卡采集设备，当你不希望当前的播放设备为声卡采集设备时，可以调用该方法另外指定别的设备作为声卡采集设备。
- `getLoopbackDevice`：用于获取当前的声卡采集设备。
- `followSystemLoopbackDevice`：用于设置声卡采集设备是否跟随系统默认的播放设备。

**6. 空间音效**

该版本新增了如下适用于空间音效场景的特性，在虚拟互动场景下可以有效提升用户的临场感体验。

- 隔声区域：你可以通过调用 `setZones` 设置隔声区域和声音衰减系数。当音源 (可以为用户或媒体播放器) 跟听声者分属于音障区域内部和外部时，会体验到类似真实环境中声音在遇到建筑隔断时的衰减效果。你也可以通过调用 `setPlayerAttenuation` 和 `setRemoteAudioAttenuation` 方法分别针对媒体播放器和用户设置声音衰减属性，并指定是否使用该设置强制覆盖 `setZones` 中的声音衰减系数。
- 多普勒音效：你可以通过设置 `SpatialAudioParams` 中的 `enable_doppler` 参数开启多普勒音效，在声源和接收方发生高速相对位移的情况下 (比如赛车游戏场景) ，接收方会体验到明显的音调变化。
- 耳机均衡器：你可以通过调用 `setHeadphoneEQPreset` 方法使用预设的耳机均衡效果，以改善耳机的听感。如果在调用 `setHeadphoneEQPreset` 后仍未达到预期的耳机均衡效果，你可以调用该方法进行调节。


**7. 已编码视频帧观测器**

该版本新增 `setRemoteVideoSubscriptionOptions` 和 `setRemoteVideoSubscriptionOptionsEx` 方法，当你调用 `registerVideoEncodedFrameObserver` 方法为编码后的视频注册视频帧观测器时，SDK 默认订阅编码后的视频帧。如果你想要修改订阅选项，可以调用新增的方法进行设置。

有关更多注册视频观测器和订阅选项的介绍，详见 [API 参考](./API%20Reference/electron_ng/API/toc_video_observer.html#api_imediaengine_registervideoencodedframeobserver)。


**8. MPUDP (MultiPath UDP)**

自该版本起，SDK 支持 MPUDP 协议，在 UDP 协议的基础上，允许连接并使用多个路径来最大化信道资源的使用。你可以同时在不同终端使用不同的物理网卡并将其聚合，达到有效对抗网络抖动、提升传输质量的效果。

<div class="alert info">如果你希望体验该功能，请联系 <a href="mailto:sales@agora.io">sales@agora.io</a>。</div>

**9. 注册插件 (Windows)**

该版本新增 `registerExtension` 方法，用于注册插件。当使用第三方插件时，你需要按照以下顺序调用插件相关的 API ：

调用 `loadExtensionProvider` -> `registerExtension` -> `setExtensionProviderProperty` -> `enableExtension`。

**10. 设备管理**

该版本新增了一系列回调，帮助你更好地了解音视频设备的状态。

- `onVideoDeviceStateChanged`：当视频设备的状态发生改变时上报。
- `onAudioDeviceStateChanged`：当音频设备的状态发生改变时上报。
- `onAudioDeviceVolumeChanged`：当音频设备或 app 的音量发生改变时上报。

**11. 摄像头采集选项**

该版本在 `CameraCapturerConfiguration` 中增加了 `followEncodeDimensionRatio` 成员参数，你可以在使用摄像头采集视频时，通过该成员参数设置是否跟随 `setVideoEncoderConfiguration` 中已经设置的视频宽高比。

**12. 多频道管理**

该版本增加了一系列多频道相关的方法，你可以通过调用这些方法，实现对多频道中音视频流的管理。

- 新增 `muteLocalAudioStreamEx` 和 `muteLocalVideoStreamEx` 方法，分别用于取消或恢复发布本地音频流和视频流。
- 新增 `muteAllRemoteAudioStreamsEx` 和 `muteAllRemoteVideoStreamsEx` 方法，分别用于取消或恢复订阅所有远端用户的音频流和视频流。
- 新增 `startRtmpStreamWithoutTranscodingEx`、`startRtmpStreamWithTranscodingEx、updateRtmpTranscodingEx` 和 `stopRtmpStreamEx` 方法，用于实现多频道场景下的旁路推流。
- 新增 `startChannelMediaRelayEx`、`updateChannelMediaRelayEx`、`pauseAllChannelMediaRelayEx`、`resumeAllChannelMediaRelayEx` 和 `stopChannelMediaRelayEx` 方法，用于实现多频道场景下的跨频道媒体流转发。
- `leaveChannelEx` 方法新增 `options` 参数，用于在多频道场景下离开频道时，选择是否停止麦克风采集。

**13. 视频编码偏好**

一般场景下，声网默认的视频编码配置能满足需求。对于特定场景，该版本在 `VideoEncoderConfiguration` 中新增 `advanceOptions` 成员参数，用于视频编码属性的进阶设置：

- `compressionPreference`：视频编码的压缩偏好设置，用于选择视频的低延时或高质量偏好。
- `encodingPreference`：视频编码器偏好设置，用于进阶设置视频编码属性，视频编码器偏好设置，用于选择视频的自适应偏好、软件编码偏好或硬件编码偏好。

**14. 日志上传**

使用声网私有媒体服务器的场景下，为支持用户在调用 `setLocalAccessPoint` 方法时的进阶设置，该版本在 `LocalAccessPointConfiguration`中新增 `advancedConfig` 成员参数，该参数支持如下设置：

- `logUploadServer`：默认情况下，SDK 会将日志上传至声网的日志服务器。你可以通过该参数自定义日志上传的服务器。

**15. 用户角色切换**

为方便用户分辨切换后的用户角色属于互动直播还是极速直播，该版本在 `onClientRoleChanged` 回调中新增 `newRoleOptions` 参数，该参数取值如下：

- `AudienceLatencyLevelLowLatency (1)`: 低延时，属于极速直播。
- `AudienceLatencyLevelUltraLowLatency (2)`: 超低延时，属于互动直播。

#### 改进

**1. 视频信息发生改变回调**

该版本优化了 `onVideoSizeChanged` 的触发逻辑，当单独调用 `startPreview` 时，也可触发该回调并上报本地视频大小发生改变。

**2. 首帧出图 (Windows)**

该版本缩短了首帧出图时间，以提升用户视频体验。

**3. 屏幕共享**

该版本对屏幕共享功能做了一系列优化，除以下列出的功能性改进之外，还有一部分可用性提升，详见[问题修复](#问题修复)。

**All**

- 支持超高清视频 (分辨率为 4K，帧率为 60 fps)，你可以在满足要求的设备上使用该功能。声网推荐的最低设备规格为：intel(R) Core(TM) i7-9750H CPU @ 2.60GHZ。

**Windows**

- 在 `ScreenCaptureSourceInfo` 中增加了 `minimizeWindow` 成员，用于表示目标窗口是否已最小化。
- 在 `ScreenCaptureParameters` 中增加了 `enableHighLight`、`highLightColor` 和 `highLightWidth` 成员，支持你在屏幕共享时对目标窗口或屏幕进行描边。
- 兼容更多主流 app，包括但不限于：WPS Office，Microsoft Office PowerPoint，Visual Studio Code，Adobe Photoshop，Windows Media Player，Scratch。
- 兼容更多设备和操作系统，包括但不限于：Window 8 系统，无独立显卡的设备，双显卡设备。

**macOS**

- 兼容更多设备和场景，包括但不限于：双显卡设备，使用外接屏幕进行屏幕共享。

**4. CDN 推流**

为提升 CDN 推流的用户体验，当设置的视频分辨率超出摄像头设备支持的范围时，SDK 会根据你的设置进行自适应，取最接近、且长宽比与你设置的分辨率一致的值进行采集、编码、推流，同时通过 `onDirectCdnStreamingStats` 回调报告推送的视频流的实际分辨率。

**5. 跨频道媒体流转发**

该版本对 `updateChannelMediaRelay` 方法做了如下优化：

- 4.1.0 版本前：如果服务器内部原因导致目标频道更新失败，SDK 返回错误码 `RelayEventPacketUpdateDestChannelRefused (8)`，你需要重新调用 `updateChannelMediaRelay` 方法。
- 4.1.0 版本及之后：如果服务器内部原因导致目标频道更新失败，SDK 会重新尝试更新直到目标频道更新成功。

**6. AIAEC**

该版本基于 AI 方法重构了 AEC 算法，相比传统 AEC 算法，新的算法可以在较恶劣的回信比 (echo-to-signal) 条件下保存完整、清晰、流畅的近端人声，显著提高系统的回声消除和双讲性能，带给用户更舒适的通话和直播体验。适用于会议、语聊、K 歌等场景。

**7. 虚拟背景**

该版本对虚拟背景算法做了如下优化：

- 在处理虚拟背景的边界时更加细腻，抠图精细程度达到发丝级别。
- 在人像静止或移动时都能确保虚拟背景的稳定性，有效解决背景闪烁、超出画面范围的问题。
- 支持更多应用场景，无论在黑夜、白天、室内、室外等各种环境下都能获得良好的虚拟背景效果。
- 支持识别多种姿态，包括半身静态、身体晃动、手部摆动，并支持精细识别手指动作，在不同手势下均能达到良好的虚拟背景效果。

**其他改进**

- 降低了推送外部音频源时的上行延迟。
- 提升了会议场景 (`audioScenarioMeeting`) 默认参数配置下的回声消除性能。
- 提升了 SDK 视频渲染的流畅度。
- 降低了当主播调用 `muteLocalVideoStream` 方法时本地设备的 CPU 占用率和耗电量。
- 增强对不同网络协议栈的识别能力，在多种运营商网络场景下提升 SDK 的接入能力。

#### 问题修复

该版本修复了以下问题：

**All**

- 在频道内调用 `setVideoEncoderConfigurationEx` 将视频的分辨率调高时，偶现失效。
- 使用媒体播放器播放视频，先调用 `play` 再调用 `pause` 暂停播放后，调用 `seek` 指定一个新的播放位置，偶现视频画面依然是暂停播放时的画面；调用 `resume` 恢复播放后，偶现视频画面出现快进。
- 在直播场景下，主播在扬声器和听筒之间进行切换后，观众听主播的声音会听到滋啦杂声。
- 调用 `getExtensionProperty` 失败，返回空字符串。
- 当以观众身份进入一个已播放较长时间的直播间，首帧出图时间缩短。
- 通过摄像头采集视频时，如果在 `CameraCapturerConfiguration` 中设置的视频宽高比例和在 `setVideoEncoderConfiguration` 中设置的不一致，导致本地视频预览的画面比例未按照后者的设置呈现。
- 在屏幕共享场景下，偶现系统声音音量变小。
- 在屏幕共享场景下，远端用户看到的画面偶现黑屏、卡顿、崩溃。
- 在屏幕共享场景下，偶现 `onNetworkQuality` 回调报告频道内指定用户的上下行网络状态不准确。

**Windows**

- 调用 `stopPreview` 关闭本地视频预览时，导致已设置的虚拟背景一定概率失效。
- 开启虚拟背景并设置为背景虚化效果时，多次退出频道再加入频道时偶现崩溃。
- 本地端使用 1920 x 1080 的摄像头作为视频采集源，偶现远端视频的分辨率与本地端不一致。
- 在屏幕共享场景下，将共享的窗口最小化时，偶现远端用户出现黑屏或远端画面切换为视频小流。
- 在直播场景下，主播开启屏幕共享时，偶现观众听主播说话有回声。
- 在屏幕共享场景下，在横屏显示器与竖屏显示器之间共享屏幕时出现黑屏。
- 调用 `startScreenCaptureByDisplayId` 进行屏幕共享时无法屏蔽窗口。
- 在屏幕共享场景下，在共享窗口中看到的鼠标位置与实际位置有偏差。
- 从普通场景切换屏幕共享场景后，由于两种场景下设置的分辨率不同导致偶现崩溃。

**macOS**

- 在屏幕共享场景下，将共享的窗口最小化或关闭共享窗口时，共享窗口自动切换为该 app 的其他窗口。
- 在屏幕共享场景下，当共享的窗口为半屏模式时，对窗口的描边不正确。
- 启动并停止音频采集设备测试后，启动音频播放设备测试时必现无声。
- `onVideoPublishStateChanged` 回调报告的视频源类型不准确。

#### API 变更

**新增**

- `getNativeHandle`
- `getPlaybackDefaultDevice`
- `getRecordingDefaultDevice`
- `enableDualStreamModeEx`
- `setDualStreamMode`
- `setDualStreamModeEx`
- `SimulcastStreamMode`
- `getNetworkType`
- `setLoopbackDevice` (Windows)
- `getLoopbackDevice` (Windows)
- `followSystemLoopbackDevice` (Windows)
- `setZones`
- `setPlayerAttenuation`
- `setRemoteAudioAttenuation`
- `setHeadphoneEQPreset`
- `setHeadphoneEQParameters`
- `HeadphoneEqualizerPreset`
- `setRemoteVideoSubscriptionOptions`
- `setRemoteVideoSubscriptionOptionsEx`
- `VideoSubscriptionOptions`
- `AdvancedOptions`
- `EncodingPreference`
- `CompressionPreference`
- `adjustUserPlaybackSignalVolumeEx`
- `RhythmPlayerStateType`
- `RhythmPlayerErrorType`
- `enableAudioVolumeIndicationEx`
- `onVideoDeviceStateChanged`
- `onAudioDeviceStateChanged`
- `onAudioDeviceVolumeChanged`
- `registerExtension` (Windows)
- `muteLocalAudioStreamEx`
- `muteLocalVideoStreamEx`
- `muteAllRemoteAudioStreamsEx`
- `muteAllRemoteVideoStreamsEx`
- `startRtmpStreamWithoutTranscodingEx`
- `startRtmpStreamWithTranscodingEx`
- `updateRtmpTranscodingEx`
- `stopRtmpStreamEx`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelayEx`
- `pauseAllChannelMediaRelayEx`
- `resumeAllChannelMediaRelayEx`
- `stopChannelMediaRelayEx`
- `LocalAccessPointConfiguration`
- `AdvancedConfigInfo`
- `LogUploadServerInfo`

**修改**

- `enableDualStreamMode`：删除 `sourceType`
- `ChannelMediaOptions`：新增 `isAudioFilterable`
- `enableInEarMonitoring`：支持 PC 端
- `setEarMonitoringAudioFrameParameters`：支持 PC 端
- `setInEarMonitoringVolume`：支持 PC 端
- `onEarMonitoringAudioFrame`：支持 PC 端
- `SpatialAudioParams`：新增 `enable_doppler`
- `ScreenCaptureSourceInfo`：新增 `minimizeWindow`
- `ScreenCaptureParameters`：支持 Windows 平台
- `CameraCapturerConfiguration`：新增 `followEncodeDimensionRatio`
- `leaveChannelEx`：新增 `options`
- `VideoEncoderConfiguration`：新增 `advanceOptions`
- `LocalAccessPointConfiguration`：新增 `advancedConfig`
- `onClientRoleChanged`：新增 `newRoleOptions`
- `VideoCanvas`：新增 `setupMode`、`mediaPlayerId` 和 `cropArea`
- `LocalVideoStats`：新增 `hwEncoderAccelerating`

**废弃**

- `onApiCallExecuted`
- `ChannelMediaRelayEvent`：废弃 `RelayEventPacketUpdateDestChannelRefused (8)`

## v4.0.0

该版本于 2022 年 9 月 29 日发布。

#### 升级必看

**兼容性变更**

v4.0.0 SDK 包名由 `electron-agora-rtc-ng` 变更为 `agora-electron-sdk`，且对部分功能的实现方式进行了优化，从而导致与 v3.7.0 不兼容。如下为存在兼容性变更的主要功能：

- 多频道
- 媒体流发布控制
- 警告码

升级 SDK 后，你需要结合实际业务场景更新 app 代码，详见[迁移指南](./migration_guide_electron_ng)。

#### 新增特性

**1. 多路媒体流**

该版本支持通过设置 `RtcEngineEx` 和 `ChannelMediaOptions`，实现一个 `IRtcEngine` 实例同时采集多路音视频源并发布到远端，适应各种业务场景。例如：

- 调用 `joinChannel` 加入首个频道后，多次调用 `joinChannelEx` 加入多个频道，通过不同的用户 ID 和 `ChannelMediaOptions` 设置发布指定的流到不同的频道。
- 支持通过设置 `ChannelMediaOptions` 中的 `publishSecondaryCameraTrack` 和 `publishSecondaryScreenTrack` 同时发布多路摄像头采集或者屏幕共享的视频流。

同时，该版本支持通过 `createCustomVideoTrack` 方法实现自定义视频采集。你可以参考如下步骤，体验同时发布多路自定义采集视频流：

1. 创建自采集视频轨道：调用 `createCustomVideoTrack` 方法创建一个自定义视频轨道，并获得视频轨道 ID。
2. 设置频道中待发布的自采集视频轨道：在每个频道的 `ChannelMediaOptions` 中，将 `customVideoTrackId` 参数设置为你想要发布的视频轨道 ID，并将 `publishCustomVideoTrack` 设置为 `true`。
3. 推送外部视频源：调用 `pushVideoFrame`，并将 `videoTrackId` 指定为你想要发布的自定义视频轨道 ID，即可根据步骤 2 的设置，实现在多个频道中发布对应的自定义视频源。

结合多频道能力，你还可以体验如下功能：

- 将多组音视频流通过不同的用户 ID（`uid`）发布到远端。
- 将多路音频流混音后通过一个用户 ID（`uid`）发布到远端。
- 将多组视频频流通过不同的用户 ID（`uid`）发布到远端。
- 将多路视频流合图后通过一个用户 ID（`uid`）发布到远端。

**2. 超高清分辨率 （Beta）**

为提升视频互动体验，SDK 对视频采集、编码、解码、渲染全流程做出了优化，自该版本起支持 4K 分辨率。优化了 FEC（Forward Error Correction）算法，可根据视频帧包数与帧率进行自适应切换，降低 4K 场景下的视频卡顿率。
你可以在调用 `setVideoEncoderConfiguration` 时，设置编码分辨率为 4K (3840 × 2160)、帧率为 60 fps。当你的设备不支持 4K 时，SDK 支持自动回退到适合的分辨率和帧率。
该功能对设备性能和网络带宽有一定要求，在不同的平台上支持的上下行帧率也不同，如需体验该功能，请[联系技术支持](https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms)。

<div class="alert info">高分辨率可能会影响集合分辨率从而导致费用变更。详见<a href="./billing_rtc_ng">计费说明</a>。</div>

**3. 内置媒体播放器**

为减少 SDK 包体积、集成时间，以及简化 API 的调用步骤，该版本支持内置媒体播放器。调用 `createMediaPlayer` 创建媒体播放器后，你可以通过 `IMediaPlayer` 类的一系列方法体验内置媒体播放器的各类功能：

- 自动播放本地、在线、自定义的媒体资源。
- 预先加载待播放的媒体资源。
- 根据网络情况切换媒体资源的播放线路。
- 将媒体播放器的音视频流推送到任意频道、分享给远端用户。
- 实时缓存媒体资源文件，该功能开启后，播放器会预先缓存当前正在播放的媒体文件的部分数据到本地，可提高播放流畅度，帮助节省网络流量。

**4. 新版 AI 降噪**

自该版本起，SDK 支持新版 AI 降噪（相对于 v3.7.0 中的基础 AI 降噪）功能。相比原版 AI 降噪，新版 AI 降噪具有更好的人声保真度、更干净的噪声抑制，并新增了去混响（Dereverberation）能力。
如果你希望体验新版 AI 降噪，请联系 [sales@agora.io](mailto:sales@agora.io)。

**5. 超高音质**

为还原音频的细节、提升音频的清晰度，该版本新增 `UltraHighQualityVoice`。在语聊、歌唱等以人声为主的场景中，你可以调用 `setVoiceBeautifierPreset` 并使用该枚举体验超高音质。

**6. 实时合唱**

该版本为实时合唱赋予了如下能力：

- 支持两人及两人以上合唱。
- 每位歌手相互独立。一位歌手出现问题或退出合唱，其他歌手还可以继续合唱。
- 极低延时体验。每位歌手可以实时听到彼此的歌声，观众也可以实时听到每位歌手。

该版本新增 `AudioScenarioChorus` 枚举来设置极低延时。使用该枚举后，在网络条件良好的情况下，用户可以体验到极低延时的实时合唱。

**7. 增强的频道管理**

为满足各类业务场景对频道管理的需求，该版本在 `ChannelMediaOptions` 结构体中新增了如下功能：

- 设置或切换多种音视频源的发布
- 设置或切换频道场景、用户角色
- 设置或切换订阅视频的大小流类型
- 控制音频发布时延

在调用 `joinChannel` 或 `joinChannelEx` 时设置 `ChannelMediaOptions`，明确媒体流发布和订阅行为，例如，是否发布摄像头采集或者屏幕共享的视频流，是否要主动订阅远端用户的音视频流。加入频道后，调用 `updateChannelMediaOptions` 随时更新 `ChannelMediaOptions` 中的设置，例如，切换发布的音视频源。

**8. 屏幕共享**

该版本优化了开启屏幕共享的逻辑，你可以根据实际场景选择不同的方式开启屏幕共享：

- 在加入频道前调用 `startScreenCaptureByDisplayId`，然后调用 `joinChannel` [2/2] 加入频道并设置 `publishScreenTrack` 或 `publishSecondaryScreenTrack` 为 `true`，即可开始屏幕共享。
- 在加入频道后调用 `startScreenCaptureByDisplayId`，然后调用 `updateChannelMediaOptions` 设置 `publishScreenTrack` 或 `publishSecondaryScreenTrack` 为 `true`，即可开始屏幕共享。

**9. 设置音视频流订阅黑/白名单**

该版本新增音视频流订阅黑/白名单功能，支持灵活订阅频道内发流用户的音视频流。你可以通过以下 API 来将指定用户的用户 ID 加入到相应的音视频黑白名单中，从而实现订阅/不订阅指定用户的音频或视频流。在多频道场景下，你可以通 `IRtcEngineEx` 类下的同名方法来实现该功能。

- `setSubscribeAudioBlocklist`：设置音频订阅黑名单。
- `setSubscribeAudioAllowlist`：设置音频订阅白名单。
- `setSubscribeVideoBlocklist`：设置视频订阅黑名单。
- `setSubscribeVideoAllowlist`：设置视频订阅白名单。

如果某个用户同时在音频或视频订阅的黑、白名单中，只有黑名单会生效。

**10. 设置音频场景**

为方便用户灵活修改音频场景，该版本新增 `setAudioScenario` 方法，支持你根据业务需求设置音频场景。例如，如果你在频道内想将音频场景从自动场景 （`AudioScenarioDefault`）切换为高音质场景 （`AudioScenarioGameStreaming`），你可以调用该方法。

**11. 设置本地代理**

该本版新增 `setLocalAccessPoint` 方法，用于在成功部署声网混合云、私有化平台后，指定 Local Access Point 来设置本地代理。你可以联系 [sales@agora.io](mailto:sales@agora.io) 了解和部署声网混合云或声网私有化平台。

**12. 垫片推流**

该版本新增垫片推流功能，支持你在发流时使用本地 png 格式的图片来替代当前发布的视频流画面进行推流。你可以通过 `enableVideoImageSource` 来开启该功能，并通过 `options` 参数自定义垫片图片；在你关闭垫片功能之后，远端用户看到的依旧是当前你发布的视频流画面。

**13. 本地合图**

该版本新增本地合图功能，可支持在本地将多路视频流合并为一路视频流。常见场景如下：

在直播场景或使用旁路推流功能时，可以在本地将多个主播的画面合并为一个画面。
将本地采集的多路视频流（例如：摄像头采集的视频、屏幕共享流、视频文件、图片等）合并为一路视频流，然后在频道内发布已合图的视频流。
你可以调用 `startLocalVideoTranscoder` 方法开启本地合图、调用 `stopLocalVideoTranscoder` 方法停止本地合图；在开启本地合图后，可以调用 `updateLocalTranscoderConfiguration` 进行本地合图的配置更新。

**14. 视频设备管理**

视频采集设备可能支持多种视频格式，每一种格式都支持不同的视频帧宽度、视频帧高度、帧率组合。

该版本新增 `numberOfCapabilities` 和 `getCapability` 方法，用于获取视频采集设备支持的视频格式数量以及指定视频格式下的视频帧详细信息。在调用 `startPrimaryCameraCapture` 或 `startSecondaryCameraCapture` 方法使用摄像头采集视频时，你可以使用指定的视频格式进行采集。
SDK 会根据你在 `VideoEncoderConfiguration` 中的设置，自动选择选择视频采集设备的最佳视频格式进行采集。一般情况下，你不需要用到该组新增方法。

#### 改进

**1. 快速切换频道**

该版本通过 `leaveChannel` 和 `joinChannel` 切换频道即可实现和 v3.7.0 中 `switchChannel` 一样的切换速度，无需额外调用 `switchChannel` 方法。

**2. 推送外部视频帧**

该版本新增支持推送 I422 格式的外部视频帧，你可以通过 `pushVideoFrame`[1/2] 方法将 I422 格式的外部视频帧推送至 SDK。

**3. 本地人声音调**

该版本在 `onAudioVolumeIndication` 的 `AudioVolumeInfo` 中新增 `voicePitch` 参数。你可以通过 `voicePitch` 获取本地用户的人声音调，从而实现唱歌评分等业务功能。

**4. 本地视频预览**

该版本优化了 `startPreview` 方法的调用逻辑。如果你需要开启本地视频预览，你可以直接通过 `startPreview` 方法来开启视频预览，无调用时序要求。

**5. 订阅视频流**

你可以通过 `setRemoteDefaultVideoStreamType` 方法，根据你想要订阅的视频流分辨率和码率来灵活设置默认订阅视频流类型。