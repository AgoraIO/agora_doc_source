## V4.2.0 版

该版本于 2023 年 5 月 23 日发布。

#### 升级必看

该版本对部分功能的实现方式进行了优化，请在升级到该版本后更新 app 代码。

**1. 视频采集**

原有用于摄像头和屏幕采集的方法已删除，请改用下表中列出的替代方法，并通过设置 `sourceType` 来指定视频源。

| 已删除方法                                                   | 替代方法                  |
| :----------------------------------------------------------- | :------------------------ |
| <li>`StartPrimaryCameraCapture`（Windows）</li><li>`StartSecondaryCameraCapture`（Windows，iOS）<li> | `StartCameraCapture`      |
| <li>`StopPrimaryCameraCapture`（Windows）</li><li>`StopSecondaryCameraCapture`（Windows，iOS）</li> | `StopCameraCapture`       |
| <li>`StartPrimaryScreenCapture `（Windows）</li>`StartSecondaryScreenCapture`（Windows，iOS）</li> | `StartScreenCapture`[2/2] |
| <li>`StopPrimaryScreenCapture`（Windows）</li><li>`StopSecondaryScreenCapture`（Windows，iOS）</li> | `StopScreenCapture`[2/2]  |

**2.视频渲染**

自该版本起，声网 Unity SDK 不支持同时使用 `VideoSurface` 和 `VideoSurfaceYUV` 来渲染不同的视频源。在成功创建 `IRtcEngine` 后，如果第一个视图是通过 `VideoSurfaceYUV` 渲染，则在整个 `IRtcEngine` 生命周期中，`VideoSurfaceYUV` 渲染。

**3. 视频数据获取**

 `OnCaptureVideoFrame` 和 `OnPreEncodeVideoFrame` 回调中新增了 `sourceType` 参数，用于表示具体的视频源类型。


**4. 媒体发布选项**

- `ChannelMediaOptions` 中的 `PublishCustomAudioTrackEnableAec` 已删除，请改用 `PublishCustomAudioTrack`。
- `ChannelMediaOptions` 中的成员 `PublishTrancodedVideoTrack` 变更为 `PublishTranscodedVideoTrack`。
- `ChannelMediaOptions` 中的成员 `PublishCustomAudioSourceId` 变更为 `PublishCustomAudioTrackId`。

**5. 音视频录制**

- 删除 `GetMediaRecorder` 方法，可通过该版本新增的 `CreateMediaRecorder` 方法来创建录制对象。
- 删除 `StartRecording` 、`StopRecording`、`SetMediaRecorderObserver` 中的 `connection` 参数。

**6. 本地合图 (Windows)**

`TranscodingVideoStream` 中的枚举类 `MEDIA_SOURCE_TYPE` 变更为 `VIDEO_SOURCE_TYPE`。

**7. 虚拟声卡 (macOS)**

自该版本起，SDK 新增对第三方虚拟声卡的支持，你可以将第三方虚拟声卡作为 SDK 的音频输入或输出设备。你可以通过 stateChanged 回调来了解当前 SDK 选择的输入输出设备是否为虚拟声卡。
<div class="alert info">加频道时如果设置 AgoraALD、Soundflower 做为系统的默认输入或输出设备，会造成无声。</div>

**7. 视频编码分辨率**

自该版本起，SDK 对视频编码的算法进行了优化，将默认的视频编码分辨率从 640 × 360 提升为 960 × 540，以适应设备性能和网络带宽的提升，在各种音视频互动场景下，为用户提供全链路的高清体验。

 如果你想自定义视频编码分辨率，可调用 `SetVideoEncoderConfiguration` 方法，重新设置视频编码参数配置中的视频编码分辨率。

<div class="note">由于默认分辨率的提升，会影响集合分辨率从而导致费用变更。详见<a href="./billing_rtc_ng">计费说明</a>。</div>

**8. 其他兼容性变更**

- `OnApiCallExecuted` 已删除，请改用相关频道和媒体的事件通知得知 API 的执行结果。
- `IAudioFrameObserver` 类名变更为 `IAudioPcmFrameSink`，因此下列方法原型也有相应更新：
  - `OnFrame`
  - `IMediaPlayer` 下的 `RegisterAudioFrameObserver` [1/2]、`RegisterAudioFrameObserver`[2/2]
- `EnableDualStreamMode`[1/2] 和 `EnableDualStreamMode`[2/2] 已废弃，请改用 `SetDualStreamMode`[1/2] 和 `SetDualStreamMode`[2/2]。
- `StartChannelMediaRelay`、`UpdateChannelMediaRelay`、`StartChannelMediaRelayEx` 和 `UpdateChannelMediaRelayEx` 已废弃，请改用 `StartOrUpdateChannelMediaRelay` 和 `StartOrUpdateChannelMediaRelayEx`。

#### 新增特性

**1. AI 降噪**

该版本新增AI 降噪功能。开启该功能后，SDK 会智能识别和消除背景噪音，无论是在嘈杂的公共场所，还是在需要保持低延迟的实时竞技场景，都能够确保声音传输的清晰度，为用户提供更高质量的音频体验。你可以通过该版本新增的 `SetAINSMode` 方法开启 AI 降噪，并根据实际场景，将降噪模式设置为均衡模式、强降噪模式或低延时模式。

**2.增强虚拟背景**

为了增加实时视频通话的趣味性、保护用户隐私，该版本增强了虚拟背景功能。你可以在调用 `EnableVirtualBackground` 方法时，将自定义背景设置为更多类型：

- 将背景处理为 Alpha 信息，不作替换，仅分割人像和背景，可结合本地合图功能实现人像画中画效果。
- 将背景替换为多种格式的本地视频。

**3. 视频场景化设置** 

该版本新增 `SetVideoScenario` 方法用于设置视频业务场景，SDK 会根据不同场景自动启用最佳实践策略，调整关键性能指标，进而优化视频质量，提升用户体验。无论是正式的商务会议还是轻松的在线聚会，该功能都能确保视频质量满足需求。目前，该特性主要为实时视频会议场景提供了以下针对性的优化：

- 针对会议场景对小流码率要求较高的情况，自动启用多项抗弱网技术，提升小流的抗弱网能力，确保多路流订阅时接收端的流畅性。
- 实时监测接收端大小流的订阅人数，根据订阅人数动态调节大流配置、动态开启和关闭小流，以节省上行带宽和消耗。

**4.本地录制远端音视频（Beta）**

该版本新增本地录制远端音视频功能。本地用户可以录制远端用户的音频视频流，便于将来回放、分析或分享，适用于在线教育、企业培训、在线会议等多类场景。为更准确报告录制状态，该版本在 `OnRecorderStateChanged` 、`OnRecorderInfoUpdated` 中新增 `channelId` 和 `uid` 参数，用于表示录制的音视频流的具体信息，并新增 CreateMediaRecorder 方法，用于创建本地或远端的录制对象。

你可以通过如下方法体验本地录制远端音视频功能：

- `CreateMediaRecorder`：创建录制对象。如需同时录制本地和远端的音视频，可以多次调用该方法创建多个录制对象。
- `SetMediaRecorderObserver`：设置录制回调对象。
- `StartRecording`：开始录制。
- `StopRecording`：停止录制。
- `DestroyMediaRecorder`：销毁录制对象。

**5. 本地合图**

Windows: 该版本新增了 `OnLocalVideoTranscoderError` 回调，当你在开启本地合图或者更新本地合图配置失败时，SDK 会触发该回调并报告合图失败的原因。

macOS，iOS，Android：该版本新增本地合图功能，用户可以调用 `StartLocalVideoTranscoder` 方法，在本地将多路视频流（例如：摄像头采集的视频、屏幕共享流、视频文件、图片等）混合和渲染，以实现自定义布局和效果。通过这项功能，你可以轻松创建个性化的视频显示效果，满足各种场景需求，如远程会议、直播、在线教育场景，同时支持人像画中画等功能。

另外，SDK 还提供了 `UpdateLocalTranscoderConfiguration` 方法和 `OnLocalVideoTranscoderError` 回调。当你在开启本地合图后，可以调用 `UpdateLocalTranscoderConfiguration` 更新合图的配置；当你在开启本地合图或者更新本地合图配置失败时，可通过 `OnLocalVideoTranscoderError` 回调得知合图失败的原因。

<div class="alert info">本地合图对 CPU 的消耗较高，声网建议你在性能较高的设备上开启该功能。</div>


**6. 多端同步**

在实时合唱的场景中，可能会出现网络原因导致各接收端下行链路不一致的情况，该版本新增 `GetNtpWallTimeInMs` 方法获取当前的 NTP (网络时间协议) 时间，用于对齐多个接收端的歌词和音乐，实现合唱同步、歌词进度同步等，为用户提供更佳的协同体验。

 **7. 快速出图出声**

 该版本新增 `EnableInstantMediaRendering` 方法，用于开启音视频帧的加速渲染模式，可加快用户加入频道后的首帧出图与出声速度。

 **8. 视频渲染数据打点**

 该版本新增 `StartMediaRenderingTracing` 和 `StartMediaRenderingTracingEx` 方法，SDK 以调用该方法的时刻作为起点，开始跟踪频道内视频帧的渲染状态，并通过 `OnVideoRenderingTracingResult` 回调报告相关事件的信息。

 声网推荐你将该方法和 app 中的 UI 设置（按钮、滑动条等）结合使用。例如：在终端用户点击“加入频道”按钮的时刻调用该方法进行打点，然后通过 `OnVideoRenderingTracingResult` 回调获取视频帧渲染过程中的指标，从而方便开发者针对指标进行专项优化，以提高出图效率。

#### 改进

**1.优化变声** 

该版本新增了 `SetLocalVoiceFormant` 方法，用于设置共振峰比率以改变语音的音色。该方法还可以和 `SetLocalVoicePitch` 方法一起使用，同时调节音调和音色，实现更多样化的变声效果。


**2. 增强屏幕共享 (Android, iOS)**

该版本新增 `QueryScreenCaptureCapability` 方法，用于查询当前设备的屏幕捕获能力。如果你想在屏幕共享时启用高帧率（如 60 Fps）、但不确定设备是否支持时，可以调用该方法、然后从返回值中得知设备支持的最高帧率是否满足需求。

该版本新增 `SetScreenCaptureScenario` 方法，用于设置屏幕共享的场景类型，SDK 会根据场景类型自动调整共享画面的的流畅度和清晰度。


 **3. 提升音频文件类型兼容性（Android）**

该版本提升了音频文件类型兼容性，你可以通过 `StartAudioMixing`[2/2]、`PlayEffect`[3/3]、`Open`、`OpenWithMediaSource` 方法来打开以 `Content://` 开头的 URI 文件。


 **4. 提升渲染兼容性（Windows）**

提升了渲染的兼容性，解决了部分设备渲染失败而导致的黑屏问题。

**5. 提升音视频同步能力**

针对自定义视频和音频采集场景，该版本新增 `GetCurrentMonotonicTimeInMs` 方法用于获取当前的 Monotonic Time，将该值传入视频帧和音频帧的时间戳，可以精确控制音视频时序，确保音视频同步。

**6. 优化多路摄像头及屏幕采集**

该版本新增 `StartScreenCapture` [2/2] (仅支持 PC 端) 和 `StartCameraCapture` 方法，通过多次调用并指定 `sourceType` 参数可以开启多路摄像头采集的视频流和多路屏幕采集的视频流，用于本地合图或多频道发布。适用于如远程医疗、远程教育等连接多个摄像头和显示器的场景。

**7. 优化版权音乐（Android，iOS）**

针对在线 K 歌房场景，改版本新增 `GetCaches` 和 `RemoveCache` 方法，用于获取、删除音乐资源缓存，并新增状态码和错误码，可方便用户排查问题。


**8. 优化跨频道连麦**

该版本新增 `StartOrUpdateChannelMediaRelay` 和 `StartOrUpdateChannelMediaRelayEx` 方法，通过一个方法实现开始跨频道转发和更新转发的目标频道，提升了接口易用性；同时，优化内部交互次数，有效降低调用了延迟。在降低开发难度的同时，为开发者提供更顺畅的使用体验。


**9. 多路音频自采集**

为更好地满足音频自采集的场景需求，该版本新增了 `CreateCustomAudioTrack` 和 `DestroyCustomAudioTrack` 方法用于创建和销毁自定义音频轨道，并提供了两种音频轨道类型供用户选择，进一步提升了自采集音频处理的灵活性和易用性：

- 可混音的音频轨道：支持将多路外部音频源混合发布到同一频道中，适用于多路音频源的自采集场景。
- 非混音的音频轨道：仅支持将一路外部音频源发布到单个频道中，适用于实时低延迟的自采集场景。

**10. 超分辨率 （Android, iOS）**

该版本提升了超分辨率的性能表现。为提升超分辨率易用性，该版本删除了 `enableRemoteSuperResolution`，超分辨率不再需要手动开启，SDK 将自动根据用户设备性能优化远端视频的分辨率。


#### 问题修复

该版本修复了以下问题：

**Windows**
- 使用媒体播放器播放网络摄像头的 RTSP 码流时，偶现花屏。
- 加入频道后添加水印然后删除，远端仍能看到水印。
- 开始屏幕共享后添加水印，远端接收的屏幕共享画面没有水印。
- 在屏幕共享场景下，如果将一个窗口设置为前置和描边，则必现窗口前置失败。
- 在本地合图场景下，不支持对 PNG 和 GIF 图片的 Alpha 通道渲染，导致透明底色的图片显示为非透明底色。
- 加入频道后接入外接摄像头，调用 `setDevice` 指定视频采集设备为该外接摄像头，方法未生效。

**Android**
- 偶现耳返开启无效。
- 偶现回声
- 由于 `OnRemoteAudioStateChanged` 回调异常造成客户端状态异常。
- 在红米 9A 上进行 CDN 推流，将推流的视频分辨率设置为 3840 × 2160 必现崩溃。
- 合唱模式下，OPPO R11 设备外放加入频道后，对端听到明显杂声和回音
- 本地音乐文件结束播放时，未能触发 `OnAudioMixingFinished` 回调。
- 接收端通过视频观测器接收的第一帧视频帧偶现丢包。
- 在多频道场景下开启屏幕共享，偶现远端看到的本地屏幕共享画面为黑屏。
- 开启虚拟背景时切换至后置摄像头会导致背景倒置。

**iOS**
- 跨频道连麦时 `OnFirstRemoteVideoFrame` 回调偶现丢失。
- 接收端主动订阅大流但是异常接收小流。
- 由于 `OnRemoteAudioStateChanged` 回调异常造成客户端状态异常。

**macOS**
- 接收端默认接收小流几秒后自动变为大流。
- 屏幕共享偶现共享画面抖动。
- 把播放器的渲染视图设为 UIViewController 的视图后，使用播放器播放视频，视频窗口切到全屏时视频画面会从左下角开始逐渐放大。
- 加入频道后接入外接摄像头，调用 `setDevice` 指定视频采集设备为该外接摄像头，方法未生效。

**全平台**
- 使用媒体播放器播放采样率超过 48 kHz 的音频时，播放失败。
- 当快速切换身份角色时，观众端听不到声音。
- 当频道内有多路视频流时，调用部分视频增强插件相关 API 偶现失败。



#### API 变更

**新增**

- `StartCameraCapture`
- `StopCameraCapture`
- `StartScreenCapture`[2/2] (Windows,macOS)
- `StopScreenCapture`[2/2] (Windows,macOS)
- `StartOrUpdateChannelMediaRelay`
- `StartOrUpdateChannelMediaRelayEx`
- `GetNtpWallTimeInMs`
- `SetVideoScenario`
- `GetCurrentMonotonicTimeInMs`
- `OnLocalVideoTranscoderError`
- `startLocalVideoTranscoder`（macOS, iOS, Android）
- `updateLocalTranscoderConfiguration`（macOS, iOS, Android）
- `QueryScreenCaptureCapability` (iOS, Android)
- `SetScreenCaptureScenario` (iOS, Android)
- `SetAINSMode`
- `CreateAudioCustomTrack`
- `DestroyAudioCustomTrack`
- `CreateMediaRecorder`
- `DestroyMediaRecorder`
- `IMusicContentCenter` 中新增如下方法：(iOS, Android)
  - `RemoveCache`
  - `GetCaches`
- `AudioTrackConfig`
- `MusicCacheInfo` (iOS, Android)
- `RecorderStreamInfo`
- `AUDIO_AINS_MODE`
- `AUDIO_TRACK_TYPE`
- `MUSIC_CACHE_STATUS_TYPE ` (iOS, Android)
- `VIDEO_APPLICATION_SCENARIO_TYPE`
- `SCREEN_CAPTURE_CAPABILITY_LEVEL`
- `RtcEngineContext` 中新增 `DomainLimit` 和 `AutoRegisterAgoraExtensions` 属性
- `OnRecorderStateChanged`、`OnRecorderInfoUpdated` 中新增 `channelId` 和 `uid` 参数
- `OnCaptureVideoFrame` 和 `OnPreEncodeVideoFrame` 中增加 `sourceType` 参数
- `BACKGROUND_SOURCE_TYPE` 中新增 `BACKGROUND_NONE` 和 `BACKGROUND_VIDEO`
- `PreloadStatusCode` 中增加 `KPreloadStatusRemoved` (iOS, Android)
- `MusicContentCenterStatusCode` 中增加如下枚举：(iOS, Android)
  - `KMusicContentCenterStatusErrGateway`
  - `KMusicContentCenterStatusErrPermissionAndResource`
  - `KMusicContentCenterStatusErrInternalDataParse`
  - `KMusicContentCenterStatusErrMusicLoading`
  - `KMusicContentCenterStatusErrMusicDecryption`
- `MusicContentCenterConfiguration` 中新增 `maxCacheSize ` (iOS, Android)
- `EnableInstantMediaRendering`
- `StartMediaRenderingTracing`
- `StartMediaRenderingTracingEx`
- `OnVideoRenderingTracingResult`
- `MEDIA_TRACE_EVENT`
- `VideoRenderingTracingInfo`

**修改**

- `OnMusicChartsResult` 中的 `status` 修改为 `error_code` (iOS, Android)
- `OnMusicCollectionResult` 中的 `status` 修改为 `error_code` (iOS, Android)
- `OnLyricResult` 中的 `status` 修改为 `error_code` (iOS, Android)
- `OnPreLoadEvent `中的 `msg` 修改为 `error_code` (iOS, Android)

**废弃**

- `EnableDualStreamMode`[1/2]
- `EnableDualStreamMode`[2/2]
- `StartChannelMediaRelay`
- `StartChannelMediaRelayEx`
- `UpdateChannelMediaRelay`
- `UpdateChannelMediaRelayEx`
- `OnChannelMediaRelayEvent`
- `CHANNEL_MEDIA_RELAY_EVENT`

**删除**

- `StartPrimaryScreenCapture` (Windows)
- `StartSecondaryScreenCapture` (Windows)
- `StopPrimaryScreenCapture` (Windows)
- `StopSecondaryScreenCapture` (Windows)
- `StartPrimaryCameraCapture` (Windows)
- `StartSecondaryCameraCapture` (Windows/iOS)
- `StopPrimaryCameraCapture` (Windows)
- `StopSecondaryCameraCapture` (Windows/iOS)
- `OnApiCallExecuted`
- `ChannelMediaOptions` 中的 `PublishCustomAudioTrackEnableAec`
- `GetMediaRecorder`
- `AGORA_IID_MEDIA_RECORDER` 
- `StartRecording`、`StopRecording`、`SetMediaRecorderObserver` 中删除 `connection` 参数
- `EnableRemoteSuperResolution`
- `RemoteVideoStats` 中删除 `superResolutionType`