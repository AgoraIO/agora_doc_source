
## v4.2.1 Beta

该版本于 2023 年 7 月 xx 日发布。

#### 升级必看

该版本对部分功能的实现方式进行了优化，请在升级到该版本后更新 app 代码。

如果你已经集成了 3.x 版本的 SDK、想要升级至该版本，请参考[迁移指南]()了解升级。

**1. 视频采集**

原有用于摄像头和屏幕采集的方法已删除，请改用下表中列出的替代方法，并通过设置 `sourceType` 来指定视频源。

| 已删除方法                                                   | 替代方法                  |
| :----------------------------------------------------------- | :------------------------ |
| <li>`startPrimaryCameraCapture`<li>`startSecondaryCameraCapture` | `startCameraCapture`      |
| <li>`stopPrimaryCameraCapture`<li>`stopSecondaryCameraCapture` | `stopCameraCapture`       |
| <li>`startPrimaryScreenCapture`<li>`startSecondaryScreenCapture` | `startScreenCapture`[2/2] |
| <li>`stopPrimaryScreenCapture`<li>`stopSecondaryScreenCapture` | `stopScreenCapture`[2/2]  |

	
**2. 视频数据获取**
	
- `onCaptureVideoFrame` 和 `onPreEncodeVideoFrame` 回调中新增了 `sourceType` 参数，用于表示具体的视频源类型。
- 以下回调已删除，请通过 `onPreEncodeVideoFrame` 和 `onCaptureVideoFrame` 中的 `sourceType` 参数得知视频源类型。
  - `onSecondaryPreEncodeCameraVideoFrame`
  - `onScreenCaptureVideoFrame`
  - `onPreEncodeScreenVideoFrame`
  - `onSecondaryPreEncodeScreenVideoFrame`

**3. 媒体发布选项**

- `ChannelMediaOptions` 中的 `publishCustomAudioTrackEnableAec` 已删除，请改用 `publishCustomAudioTrack`。
- `ChannelMediaOptions` 中的 `publishTrancodedVideoTrack` 变更为 `publishTranscodedVideoTrack。`
- `ChannelMediaOptions` 中的 `publishCustomAudioSourceId` 变更为 `publishCustomAudioTrackId`。

**4. 音视频录制**

- 删除 `INTERFACE_ID_TYPE` 中的 `AGORA_IID_MEDIA_RECORDER` 。在创建录制对象前无需再获取 `AGORA_IID_MEDIA_RECORDER` 接口类指针，你可以直接调用该版本新增的 `createMediaRecorder` 方法创建录制对象。
- 删除 `startRecording` 、`stopRecording`、`setMediaRecorderObserver` 中的 `connection` 参数。
- 删除 `IMediaRecorder` 类中的 `release` 方法，你可直接调用该版本新增的 `destroyMediaRecorder` 方法来销毁录制对象以释放资源。

**5. 本地合图**

- `LocalTranscoderConfiguration` 中的 `VideoInputStreams` 变更为 `videoInputStreams`。
- `TranscodingVideoStream` 中的枚举类 `MEDIA_SOURCE_TYPE` 变更为 `VIDEO_SOURCE_TYPE`。

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

**5. 本地合图**

该版本新增了 `onLocalVideoTranscoderError` 回调，当你在开启本地合图或者更新本地合图配置失败时，SDK 会触发该回调并报告合图失败的原因。

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

 **2. 提升渲染兼容性**

提升了渲染的兼容性，解决了部分设备渲染失败而导致的黑屏问题。

**3. 提升音视频同步能力**

针对自定义视频和音频采集场景，该版本新增 `getCurrentMonotonicTimeInMs` 方法用于获取当前的 Monotonic Time，将该值传入视频帧和音频帧的时间戳，可以精确控制音视频时序，确保音视频同步。

**4. 优化多路摄像头及屏幕采集**

该版本新增 `startCameraCapture` 和 `startScreenCapture`[2/2] 方法，通过多次调用并指定 `sourceType` 参数可以开启多路摄像头采集的视频流和多路屏幕采集的视频流，用于本地合图或多频道发布。适用于如远程医疗、远程教育等连接多个摄像头和显示器的场景。

**5. 优化跨频道连麦**

该版本新增 `startOrUpdateChannleMediaRelay` 和 `startOrUpdateChannleMediaRelayEx` 方法，通过一个方法实现开始跨频道转发和更新转发的目标频道，提升了接口易用性；同时，优化内部交互次数，有效降低调用了延迟。在降低开发难度的同时，为开发者提供更顺畅的使用体验。

**6. 多路音频自采集**

为更好地满足音频自采集的场景需求，该版本新增了 `createCustomAudioTrack` 和 `destroyCustomAudioTrack` 方法用于创建和销毁自定义音频轨道，并提供了两种音频轨道类型供用户选择，进一步提升了自采集音频处理的灵活性和易用性：

- 可混音的音频轨道：支持将多路外部音频源混合发布到同一频道中，适用于多路音频源的自采集场景。
- 非混音的音频轨道：仅支持将一路外部音频源发布到单个频道中，适用于实时低延迟的自采集场景。

**7. 视频观测器**

 自该版本起，SDK 对 `onRenderVideoFrame` 回调进行了优化，在不同的视频处理模式下返回值的意义不同：

 - 当视频处理模式为 `PROCESS_MODE_READ_ONLY` 时，返回值无实际含义。
 - 当视频处理模式为 `PROCESS_MODE_READ_WRITE` 时，返回 `true` 代表设置 SDK 接收视频帧；返回 `false` 代表设置 SDK 丢弃视频帧。


其他改进：
该版本改进了网络传输策略，提升了音视频交互的流畅度。


#### 问题修复

- 该版本修复了当快速切换身份角色时，观众端听不到声音的问题。
- SDK 不兼容部分旧版本 AccessToken 导致无法加入频道。
- 发送端调用 `setAINSMode` 开启 AI 降噪功能后，接收端用户偶现回声。
- 使用媒体播放器播放媒体文件时出现短暂杂音。
- 发送端将两路摄像头采集的视频进行本地合图并发布后，接收端偶现第二路摄像头画面缺失。
- 使用媒体播放器播放网络摄像头的 RTSP 码流时，偶现花屏。
- 使用媒体播放器播放采样率超过 48 kHz 的音频时，播放失败。
- 在本地合图场景下，不支持对 PNG 和 GIF 图片的 Alpha 通道渲染，导致透明底色的图片显示为非透明底色。
- 加入频道后添加水印然后删除，远端仍能看到水印。
- 开始屏幕共享后添加水印，远端接收的屏幕共享画面没有水印。
- 加入频道后接入外接摄像头，调用 `setDevice` 指定视频采集设备为该外接摄像头，方法未生效。
- 在屏幕共享场景下，如果将一个窗口设置为前置和描边，则必现窗口前置失败。
- 当频道内有多路视频流时，调用部分视频增强插件相关 API 偶现失败。
- 客户端主动退出频道时未向服务端发起请求，导致服务端判定为退出频道超时。


#### API 变更

**新增**

- `startCameraCapture`
- `stopCameraCapture`
- `startScreenCapture`[2/2]
- `stopScreenCapture`[2/2]
- `startOrUpdateChannelMediaRelay`
- `startOrUpdateChannelMediaRelayEx`
- `getNtpWallTimeInMs`
- `setVideoScenario`
- `getCurrentMonotonicTimeInMs`
- `onLocalVideoTranscoderError`
- `setAINSMode`
- `createCustomAudioTrack`
- `destroyCustomAudioTrack`
- `createMediaRecorder`
- `destroyMediaRecorder`
- `AudioTrackConfig`
- `RecorderStreamInfo`
- `AUDIO_AINS_MODE`
- `AUDIO_TRACK_TYPE`
- `VIDEO_APPLICATION_SCENARIO_TYPE`
- `SCREEN_CAPTURE_FRAMERATE_CAPABILITY`
- `RtcEngineContext` 中新增 `domainLimit` 和 `autoRegisterAgoraExtensions` 属性
- `onRecorderStateChanged`、`onRecorderInfoUpdated` 中新增 `channelId` 和 `uid` 参数
- `onCaptureVideoFrame` 和 `onPreEncodeVideoFrame` 中增加 `sourceType` 参数
- `BACKGROUND_SOURCE_TYPE` 中新增 `BACKGROUND_NONE` 和 `BACKGROUND_VIDEO`
- `enableInstantMediaRendering`
- `startMediaRenderingTracing`
- `startMediaRenderingTracingEx`
- `onVideoRenderingTracingResult`
- `MEDIA_RENDER_TRACE_EVENT`
- `VideoRenderingTracingInfo`

**修改**
- `OnRecordAudioEncodedFrame` 变更为 `onRecordAudioEncodedFrame` 
- `OnPlaybackAudioEncodedFrame` 变更为 `onPlaybackAudioEncodedFrame` 
- `OnMixedAudioEncodedFrame` 变更为 `onPlaybackAudioEncodedFrame` 
	
**废弃**

- `enableDualStreamMode`[1/2]
- `enableDualStreamMode`[2/2]
- `startChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelay`
- `updateChannelMediaRelayEx`
- `onChannelMediaRelayEvent`
- `CHANNEL_MEDIA_RELAY_EVENT`

**删除**

- `startPrimaryScreenCapture`
- `startSecondaryScreenCapture`
- `stopPrimaryScreenCapture`
- `stopSecondaryScreenCapture`
- `startPrimaryCameraCapture`
- `startSecondaryCameraCapture`
- `stopPrimaryCameraCapture`
- `stopSecondaryCameraCapture`
- `onSecondaryPreEncodeCameraVideoFrame`
- `onScreenCaptureVideoFrame`
- `onPreEncodeScreenVideoFrame `
- `onSecondaryPreEncodeScreenVideoFrame`
- `onApiCallExecuted`
- `ChannelMediaOptions `中的` publishCustomAudioTrackEnableAec`
- `getMediaRecorder`
- `IMediaRecorder` 类中的 `release`
- `AGORA_IID_MEDIA_RECORDER` 
- `startRecording`、`stopRecording`、`setMediaRecorderObserver` 中删除 `connection` 参数
- `enableRemoteSuperResolution`
- `RemoteVideoStats` 中删除 `superResolutionType`