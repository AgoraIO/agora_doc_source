
## v4.2.1 Beta

该版本于 2023 年 8 月 xx 日发布。

#### 升级必看

该版本对部分功能的实现方式进行了优化，请在升级到该版本后更新 app 代码。

如果你已经集成了 3.x 版本的 SDK、想要升级至该版本，请参考[迁移指南]()了解升级。

**1. 视频采集 (Windows, iOS)**

原有用于摄像头和屏幕采集的方法已删除，请改用下表中列出的替代方法，并通过设置 `sourceType` 来指定视频源。

| 已删除方法 | 替代方法 |
|:---------|:--------|
| <li>`startPrimaryCameraCapture` (Windows)</li><li>`startSecondaryCameraCapture` (Windows, iOS)</li> | `startCameraCapture` |
| <li>`stopPrimaryCameraCapture` (Windows)</li><li>`stopSecondaryCameraCapture` (Windows, iOS)</li> | `stopCameraCapture` |
| <li>`startPrimaryScreenCapture` (Windows)</li><li>`startSecondaryScreenCapture` (Windows)</li> | `startScreenCaptureBySourceType` (Windows) |
| <li>`stopPrimaryScreenCapture` (Windows)</li><li>`stopSecondaryScreenCapture` (Windows)</li> | `stopScreenCaptureBySourceType` (Windows) |

	
**2. 视频数据获取**
	
- `onCaptureVideoFrame` 和 `onPreEncodeVideoFrame` 回调中新增了 `sourceType` 参数，用于表示具体的视频源类型。
- 以下回调已删除，请通过 `onPreEncodeVideoFrame` 和 `onCaptureVideoFrame` 中的 `sourceType` 参数得知视频源类型。(Windows)
  - `onSecondaryPreEncodeCameraVideoFrame`
  - `onScreenCaptureVideoFrame`
  - `onPreEncodeScreenVideoFrame`
  - `onSecondaryPreEncodeScreenVideoFrame`

**3. 媒体发布选项**

- `ChannelMediaOptions` 中的 `publishCustomAudioTrackEnableAec` 已删除，请改用 `publishCustomAudioTrack`。
- `ChannelMediaOptions` 中的 `publishTrancodedVideoTrack` 变更为 `publishTranscodedVideoTrack。`
- `ChannelMediaOptions` 中的 `publishCustomAudioSourceId` 变更为 `publishCustomAudioTrackId`。

**4. 音视频录制**

- 删除 `InterfaceIdType` 中的 `agoraIidMediaRecorder`。在创建录制对象前无需再获取 `agoraIidMediaRecorder` 接口类指针，你可以直接调用该版本新增的 `createMediaRecorder` 方法创建录制对象。(Windows)
- 删除 `getMediaRecorder` 方法，可通过该版本新增的 `createMediaRecorder` 方法来创建录制对象。(Android, iOS, macOS)
- 删除 `startRecording` 、`stopRecording`、`setMediaRecorderObserver` 中的 `connection` 参数。
- 删除 `MediaRecorder` 类中的 `release` 方法，你可直接调用该版本新增的 `destroyMediaRecorder` 方法来销毁录制对象以释放资源。

**5. 本地合图 (Windows)**

- `LocalTranscoderConfiguration` 中的 `VideoInputStreams` 变更为 `videoInputStreams`。
- `TranscodingVideoStream` 中的枚举类 `MediaSourceType` 变更为 `VideoSourceType`。

**6. 视频编码分辨率**

自该版本起，SDK 对视频编码的算法进行了优化，将默认的视频编码分辨率从 640 × 360 提升为 960 × 540，以适应设备性能和网络带宽的提升，在各种音视频互动场景下，为用户提供全链路的高清体验。

 如果你想自定义视频编码分辨率，可调用 `setVideoEncoderConfiguration` 方法，重新设置视频编码参数配置中的视频编码分辨率。

<div class="note">由于默认分辨率的提升，会影响集合分辨率从而导致费用变更。详见<a href="./billing_rtc_ng">计费说明</a>。</div>

**7. 其他兼容性变更**

- `onApiCallExecuted` 已删除，请改用相关频道和媒体的事件通知得知 API 的执行结果。
- `IAudioFrameObserver` 类名变更为 `IAudioPcmFrameSink`，因此下列方法原型也有相应更新：
  - `onFrame`
  - `IMediaPlayer` 下的 `registerAudioFrameObserver` [1/2]、`registerAudioFrameObserver`[2/2]
- `enableDualStreamMode`[1/2] 和 `enableDualStreamMode`[2/2] 已废弃，请改用 `setDualStreamMode`[1/2] 和 `setDualStreamMode`[2/2]。
- `startChannelMediaRelay`、`updateChannelMediaRelay`、`startChannelMediaRelayEx` 和 `updateChannelMediaRelayEx` 已废弃，请改用 `startOrUpdateChannelMediaRelay` 和 `startOrUpdateChannelMediaRelayEx`。
- `OnRecordAudioEncodedFrame` 变更为 `onRecordAudioEncodedFrame` 。
- `OnPlaybackAudioEncodedFrame` 变更为 `onPlaybackAudioEncodedFrame` 。
- `OnMixedAudioEncodedFrame` 变更为 `onPlaybackAudioEncodedFrame` 。

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

该版本新增本地录制远端音视频功能。本地用户可以录制远端用户的音频视频流，便于将来回放、分析或分享，适用于在线教育、企业培训、在线会议等多类场景。为更准确报告录制状态，该版本在 `onRecorderStateChanged` 、`onRecorderInfoUpdated` 中新增 `channelId` 和 `uid` 参数，用于表示录制的音视频流的具体信息，并新增 `createMediaRecorder` 方法，用于创建本地或远端的录制对象。

你可以通过如下方法体验本地录制远端音视频功能：
	
- `createMediaRecorder`：创建录制对象。如需同时录制本地和远端的音视频，可以多次调用该方法创建多个录制对象。
- `setMediaRecorderObserver`：设置录制回调对象。
- `startRecording`：开始录制。
- `stopRecording`：停止录制。
- `destroyMediaRecorder`：销毁录制对象。

**5. 本地合图 (macOS, iOS, Android)**

该版本新增本地合图功能，用户可以调用 `startLocalVideoTranscoder` 方法，在本地将多路视频流（例如：摄像头采集的视频、屏幕共享流、视频文件、图片等）混合和渲染，以实现自定义布局和效果。通过这项功能，你可以轻松创建个性化的视频显示效果，满足各种场景需求，如远程会议、直播、在线教育场景，同时支持人像画中画等功能。

另外，SDK 还提供了 `updateLocalTranscoderConfiguration` 方法和 `onLocalVideoTranscoderError` 回调。当你在开启本地合图后，可以调用 `updateLocalTranscoderConfiguration` 更新合图的配置；当你在开启本地合图或者更新本地合图配置失败时，可通过 `onLocalVideoTranscoderError` 回调得知合图失败的原因。

<div class="alert note">本地合图对 CPU 的消耗较高，声网建议你在性能较高的设备上开启该功能。</div>


**6. 本地合图 (Windows)**

该版本新增了 `onLocalVideoTranscoderError` 回调，当你在开启本地合图或者更新本地合图配置失败时，SDK 会触发该回调并报告合图失败的原因。

**7. 多端同步**

在实时合唱的场景中，可能会出现网络原因导致各接收端下行链路不一致的情况，该版本新增 `getNtpWallTimeInMs` 方法获取当前的 NTP (网络时间协议) 时间，用于对齐多个接收端的歌词和音乐，实现合唱同步、歌词进度同步等，为用户提供更佳的协同体验。

**8. 快速出图出声**

 该版本新增 `enableInstantMediaRendering` 方法，用于开启音视频帧的加速渲染模式，可加快用户加入频道后的首帧出图与出声速度。

**9. 视频渲染数据打点**

 该版本新增 `startMediaRenderingTracing` 和 `startMediaRenderingTracingEx` 方法，SDK 以调用该方法的时刻作为起点，开始跟踪频道内视频帧的渲染状态，并通过 `onVideoRenderingTracingResult` 回调报告相关事件的信息。

 声网推荐你将该方法和 app 中的 UI 设置（按钮、滑动条等）结合使用。例如：在终端用户点击“加入频道”按钮的时刻调用该方法进行打点，然后通过 `onVideoRenderingTracingResult` 回调获取视频帧渲染过程中的指标，从而方便开发者针对指标进行专项优化，以提高出图效率。

#### 改进

**1.优化变声** 

该版本新增了 `setLocalVoiceFormant` 方法，用于设置共振峰比率以改变语音的音色。该方法还可以和 `setLocalVoicePitch` 方法一起使用，同时调节音调和音色，实现更多样化的变声效果。

**2. 增强屏幕共享 (Android, iOS)**

该版本新增 `queryScreenCaptureCapability` 方法，用于查询当前设备的屏幕捕获能力。如果你想在屏幕共享时启用高帧率（如 60 fps）、但不确定设备是否支持时，可以调用该方法、然后从返回值中得知设备支持的最高帧率是否满足需求。

该版本新增 `setScreenCaptureScenario` 方法，用于设置屏幕共享的场景类型，SDK 会根据场景类型自动调整共享画面的的流畅度和清晰度。

**3. 提升音频文件类型兼容性 (Android)**

该版本提升了音频文件类型兼容性，你可以通过 `startAudioMixing`、`playEffect`、`openWithMediaSource` 方法来打开以 `content://` 开头的 URI 文件。

**4. 提升渲染兼容性 (Windows)**

提升了渲染的兼容性，解决了部分设备渲染失败而导致的黑屏问题。

**3. 提升音视频同步能力**

针对自定义视频和音频采集场景，该版本新增 `getCurrentMonotonicTimeInMs` 方法用于获取当前的 Monotonic Time，将该值传入视频帧和音频帧的时间戳，可以精确控制音视频时序，确保音视频同步。

**6. 优化多路摄像头及屏幕采集**

该版本新增 `startScreenCaptureBySourceType` (仅支持 PC 端) 和 `startCameraCapture` 方法，通过多次调用并指定 `sourceType` 参数可以开启多路摄像头采集的视频流和多路屏幕采集的视频流，用于本地合图或多频道发布。适用于如远程医疗、远程教育等连接多个摄像头和显示器的场景。

**7. 优化版权音乐 (Android, iOS)**

针对在线 K 歌房场景，改版本新增 `getCaches` 和 `removeCache` 方法，用于获取、删除音乐资源缓存，并新增状态码和错误码，可方便用户排查问题。

**8. 优化跨频道连麦**

该版本新增 `startOrUpdateChannelMediaRelay` 和 `startOrUpdateChannelMediaRelayEx` 方法，通过一个方法实现开始跨频道转发和更新转发的目标频道，提升了接口易用性；同时，优化内部交互次数，有效降低调用了延迟。在降低开发难度的同时，为开发者提供更顺畅的使用体验。

**9. 多路音频自采集**

为更好地满足音频自采集的场景需求，该版本新增了 `createCustomAudioTrack` 和 `destroyCustomAudioTrack` 方法用于创建和销毁自定义音频轨道，并提供了两种音频轨道类型供用户选择，进一步提升了自采集音频处理的灵活性和易用性：

- 可混音的音频轨道：支持将多路外部音频源混合发布到同一频道中，适用于多路音频源的自采集场景。
- 非混音的音频轨道：仅支持将一路外部音频源发布到单个频道中，适用于实时低延迟的自采集场景。

**10. 视频观测器**

自该版本起，SDK 对 `onRenderVideoFrame` 回调进行了优化，在不同的视频处理模式下返回值的意义不同：

- 当视频处理模式为 `processModeReadOnly` 时，返回值无实际含义。
- 当视频处理模式为 `processModeReadWrite` 时，返回 `true` 代表设置 SDK 接收视频帧；返回 `false` 代表设置 SDK 丢弃视频帧。

**11. 超分辨率 (Android, iOS)**

该版本提升了超分辨率的性能表现。为提升超分辨率易用性，该版本删除了 `enableRemoteSuperResolution`，超分辨率不再需要手动开启，SDK 将自动根据用户设备性能优化远端视频的分辨率。


其他改进：
该版本改进了网络传输策略，提升了音视频交互的流畅度。


#### 问题修复

- 加入或退出频道时，安卓设备端偶现的崩溃。(Android)
- 当快速切换身份角色时，观众端听不到声音。
- 偶现耳返开启无效。(Android)
- 跨频道连麦时 `onFirstRemoteVideoFrame` 回调偶现丢失。(iOS)
- 接收端主动订阅大流但是异常接收小流。(iOS)
- 接收端默认接收小流几秒后自动变为大流。(macOS)。
- 偶现回声。(Android)
- 屏幕共享偶现共享画面抖动。(macOS)
- 由于 `onRemoteAudioStateChanged` 回调异常造成客户端状态异常。(iOS, Android)。
- 使用媒体播放器播放网络摄像头的 RTSP 码流时，偶现花屏。(Windows)
- 使用媒体播放器播放采样率超过 48 kHz 的音频时，播放失败。
- 在红米 9A 上进行 CDN 推流，将推流的视频分辨率设置为 3840 × 2160 必现崩溃。(Android)
- 把播放器的渲染视图设为 UIViewController 的视图后，使用播放器播放视频，视频窗口切到全屏时视频画面会从左下角开始逐渐放大。(macOS)
- 在本地合图场景下，不支持对 PNG 和 GIF 图片的 Alpha 通道渲染，导致透明底色的图片显示为非透明底色。(Windows)
- 合唱模式下，OPPO R11 设备外放加入频道后，对端听到明显杂声和回音。(Android)
- 本地音乐文件结束播放时，未能触发 `onAudioMixingFinished` 回调。(Android)
- 加入频道后添加水印然后删除，远端仍能看到水印。(Windows)
- 开始屏幕共享后添加水印，远端接收的屏幕共享画面没有水印。(Windows)
- 加入频道后接入外接摄像头，调用 `setDevice` 指定视频采集设备为该外接摄像头，方法未生效。(macOS, Windows)
- 接收端通过视频观测器接收的第一帧视频帧偶现丢包。(Android)
- 在多频道场景下开启屏幕共享，偶现远端看到的本地屏幕共享画面为黑屏。(Android)
- 在屏幕共享场景下，如果将一个窗口设置为前置和描边，则必现窗口前置失败。(Windows)
- 开启虚拟背景时切换至后置摄像头会导致背景倒置。(Android)
- 当频道内有多路视频流时，调用部分视频增强插件相关 API 偶现失败。
- 客户端主动退出频道时未向服务端发起请求，导致服务端判定为退出频道超时。
- SDK 不兼容部分旧版本 AccessToken 导致无法加入频道。
- 发送端调用 `setAINSMode` 开启 AI 降噪功能后，接收端用户偶现回声。
- 使用媒体播放器播放媒体文件时出现短暂杂音。
- 发送端启用屏幕共享功能后，偶现接收端看到共享画面的延迟较高。（macOS）
- 调用 `destroyMediaPlayer` 销毁媒体播放器时偶现崩溃。（iOS）
- 发送端将两路摄像头采集的视频进行本地合图并发布后，接收端偶现第二路摄像头画面缺失。（Windows）
- 屏幕共享场景下，部分机型必现接收端看到共享的画面卡顿。（Android）



#### API 变更

**新增**

- `startCameraCapture`
- `stopCameraCapture`
- `startScreenCaptureBySourceType` (Windows, macOS)
- `stopScreenCaptureBySourceType` (Windows, macOS)
- `startOrUpdateChannelMediaRelay`
- `startOrUpdateChannelMediaRelayEx`
- `getNtpWallTimeInMs`
- `setVideoScenario`
- `getCurrentMonotonicTimeInMs`
- `onLocalVideoTranscoderError`
- `startLocalVideoTranscoder` (macOS, iOS, Android)
- `updateLocalTranscoderConfiguration` (macOS, iOS, Android)
- `queryScreenCaptureCapability` (iOS, Android)
- `setScreenCaptureScenario` (iOS, Android)
- `setAINSMode`
- `createCustomAudioTrack`
- `destroyCustomAudioTrack`
- `createMediaRecorder`
- `destroyMediaRecorder`
- `MusicContentCenter` 中新增如下方法 (Android, iOS)：
    - `getCaches`
    - `removeCache`
- `AudioTrackConfig`
- `MusicCacheInfo` (Android, iOS)
- `RecorderStreamInfo`
- `AudioAinsMode`
- `AudioTrackType`
- `MusicCacheStatusType` (Android, iOS)
- `VideoApplicationScenarioType`
- `ScreenCaptureFramerateCapability`
- `RtcEngineContext` 中新增 `domainLimit` 和 `autoRegisterAgoraExtensions` 属性
- `onRecorderStateChanged`、`onRecorderInfoUpdated` 中新增 `channelId` 和 `uid` 参数
- `onCaptureVideoFrame` 和 `onPreEncodeVideoFrame` 中增加 `sourceType` 参数
- `backgroundSourceType` 中新增 `backgroundNone` 和 `backgroundVideo`
- `PreloadStatusCode` 中 增加 `kPreloadStatusRemoved` (Android, iOS)
- `MusicContentCenterStatusCode` 中增加如下枚举 (Android, iOS)：
    - `kMusicContentCenterStatusErrGateway`
    - `kMusicContentCenterStatusErrPermissionAndResource`
    - `kMusicContentCenterStatusErrInternalDataParse`
    - `kMusicContentCenterStatusErrMusicLoading`
    - `kMusicContentCenterStatusErrMusicDecryption`
- `MusicContentCenterConfiguration` 中新增 `maxCacheSize` (Android, iOS)
- `enableInstantMediaRendering`
- `startMediaRenderingTracing`
- `startMediaRenderingTracingEx`
- `onVideoRenderingTracingResult`
- `MediaTraceEvent`
- `VideoRenderingTracingInfo`

**修改**

- `onMusicChartsResult` 中的 `status` 修改为 `errorCode` (Android, iOS)
- `onMusicCollectionResult` 中的 `status` 修改为 `errorCode` (Android, iOS)
- `onLyricResult` 中的 `status` 修改为 `errorCode` (Android, iOS)
- `onPreLoadEvent` 中的 `msg` 修改为 `errorCode` (Android, iOS)

**废弃**

- `startChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelay`
- `updateChannelMediaRelayEx`
- `onChannelMediaRelayEvent`
- `ChannelMediaRelayEvent`

**删除**

- `startPrimaryScreenCapture` (Windows)
- `startSecondaryScreenCapture` (Windows)
- `stopPrimaryScreenCapture` (Windows)
- `stopSecondaryScreenCapture` (Window)
- `startPrimaryCameraCapture` (Windows)
- `startSecondaryCameraCapture` (Windows, iOS)
- `stopPrimaryCameraCapture` (Windows)
- `stopSecondaryCameraCapture` (Windows, iOS)
- `onSecondaryPreEncodeCameraVideoFrame` (Windows)
- `onScreenCaptureVideoFrame` (Windows)
- `onPreEncodeScreenVideoFrame` (Windows)
- `onSecondaryPreEncodeScreenVideoFrame` (Windows)
- `onApiCallExecuted`
- `ChannelMediaOptions` 中的 `publishCustomAudioTrackEnableAec`
- `getMediaRecorder`
- `MediaRecorder` 类中的 `release`
- `InterfaceIdType` 中的 `agoraIidMediaRecorder` (Windows)
- `startRecording`、`stopRecording`、`setMediaRecorderObserver` 中删除 `connection` 参数
- `enableRemoteSuperResolution`
- `RemoteVideoStats` 中删除 `superResolutionType`