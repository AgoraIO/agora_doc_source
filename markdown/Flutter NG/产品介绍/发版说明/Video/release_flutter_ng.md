## v6.1.0 (对应 Native v4.1.0)

该版本于 2022 年 12 月 20 日发布。


#### 升级必看

如果你已经使用了以下类或方法，请在升级到该版本后重新调用方法并更新参数设置：

删除了 `enableDualStreamMode` 中的 `sourceType` 参数，因为 SDK 支持对自定义采集或 SDK 采集的各种视频源开启双流模式，不再需要指定视频源类型。



#### 新增特性

**1. 耳返**

该本版新增耳返功能。你可以调用 `enableInEarMonitoring` 开启耳返功能。

成功开启耳返功能后，你可以调用 `registerAudioFrameObserver` 注册音频观测器，SDK 会触发 `onEarMonitoringAudioFrame` 回调报告耳返原始音频数据。你可以使用自己的音效处理模块对耳返音频数据进行前处理，实现自定义音效，声网推荐你调用 `setEarMonitoringAudioFrameParameters` 方法设置耳返音频数据格式，SDK 会根据该方法中的参数计算采样间隔，并根据该采样间隔触发 `onEarMonitoringAudioFrame` 回调。

如需调节耳返音量，你可以调用 `setInEarMonitoringVolume`。


**2. 音频采集设备测试 (Android)**

该版本支持加入频道前测试本地音频采集设备。你可以调用 `startRecordingDeviceTest` 开启音频采集设备测试，测试完成后，调用 `stopPlaybackDeviceTest` 方法停止音频采集设备测试。


**3. 本地网络连接类型**

为方便用户在任何阶段知悉本地网络的连接类型，该版本新增  `getNetworkType` 方法。你可以通过该方法获取正在使用的网络连接的类型，包括 UNKNOWN、DISCONNECTED、LAN、WIFI、2G、3G、4G、5G。当本地网络连接类型发生改变时，SDK 会触发 `onNetworkTypeChanged` 回调，报告当前的网络连接类型。 


**4. 音强选流**

声网服务器会根据音量大小对音频流进行筛选，选出 N 路音量最大的音频流并传输至接收端。N 默认为 3 路，如需自定义设置 N，请联系技术支持。

同时，声网还支持发流端自定义设置是否参与音强选流，不参与选流的音频流会直接和被选出的 N 路音频流一同传输至接收端。在大型会议等多人发流的场景下，开启音强选流功能可以帮助减轻接收端的下行带宽压力和系统资源消耗，详见音强选流。

<div class="alert info">该版本新增音强选流功能，如需开启该功能，请联系<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">技术支持</a>。</div>


**5. 双流模式**

该版本对双流模式做了优化，在加入频道前后均可调用 `enableDualStreamMode` 和 `enableDualStreamModeEx`。

扩展了订阅视频小流的实现方式，SDK 默认在发送端开启小流 auto 模式 (即：默认不主动发送小流) ，可通过以下步骤开启发送小流：

1. 接收端主播调用 `setRemoteVideoStreamType` 或 `setRemoteDefaultVideoStreamType` 发起接收小流申请。
2. 发送端收到申请后自动切换为发送小流模式。

如果你想修改上述发送端的默认行为，可以调用 `setDualStreamMode` 方法，将 `mode` 参数设置为 `disableSimulcastStream` (始终不发送小流) 或 `enableSimulcastStream` (始终发送小流)。


**6. 声卡采集设备 (Windows)**

SDK 默认使用播放设备为声卡采集设备，自该版本起，你可以另外指定声卡采集设备并将其采集到的音频发布到远端。

- `setLoopbackDevice`：用于指定声卡采集设备，当你不希望当前的播放设备为声卡采集设备时，可以调用该方法另外指定别的设备作为声卡采集设备。
- `getLoopbackDevice`：用于获取当前的声卡采集设备。
- `followSystemLoopbackDevice`：用于设置声卡采集设备是否跟随系统默认的播放设备。


**7. 空间音效**

该版本新增了如下适用于空间音效场景的特性，在虚拟互动场景下可以有效提升用户的临场感体验。

- 隔声区域：你可以通过调用 `setZones` 设置隔声区域和声音衰减系数。当音源 (可以为用户或媒体播放器) 跟听声者分属于音障区域内部和外部时，会体验到类似真实环境中声音在遇到建筑隔断时的衰减效果。你也可以通过调用 `setPlayerAttenuation` 和 `setRemoteAudioAttenuation` 方法分别针对媒体播放器和用户设置声音衰减属性，并指定是否使用该设置强制覆盖 `setZones` 中的声音衰减系数。
- 多普勒音效：你可以通过设置 `SpatialAudioParams` 中的 `enableDoppler` 参数开启多普勒音效，在声源和接收方发生高速相对位移的情况下 (比如赛车游戏场景) ，接收方会体验到明显的音调变化。
- 耳机均衡器：你可以通过调用 `setHeadphoneEQPreset` 方法使用预设的耳机均衡效果，以改善耳机的听感。如果在调用 `setHeadphoneEQPreset` 后仍未达到预期的耳机均衡效果，你可以调用该方法进行调节。


**8. 多路摄像头 (iOS)**

该版本新增多路摄像头视频采集功能，你可以通过调用 `enableMultiCamera` 开启多路摄像头采集模式，再调用 `startSecondaryCameraCapture` 通过第二个摄像头采集视频，然后将采集到的视频发布到多频道中。

如需停止多路摄像头采集，需要先调用 `stopSecondaryCameraCapture` 停止第二个摄像头采集，然后调用 `enableMultiCamera` 并将 `enabled` 设置为 `false`。


**9. 版权音乐 (iOS, Android)**

为解决直播、语聊房、在线 K 歌房等场景下歌曲的应用版权问题，该版本新增版权音乐相关 API。你可以通过调用 `MusicContentCenter` 类、`MusicPlayer` 类、`MusicContentCenterEventHandler` 类下的相关 API 实现在实时互动场景中播放版权音乐以及相关功能，例如检索音乐资源、获取音乐榜单及榜单详情、预加载及播放音乐资源、下载歌词及海报等功能。你还可以参考[在线 K 歌房](https://docs.agora.io/cn/online-ktv/ktv_overview)来体验搭配了演唱评分、美声音效等一系列功能的线上 K 歌场景化解决方案。


**10. 已编码视频帧观测器**

该版本新增 `setRemoteVideoSubscriptionOptions` 和 `setRemoteVideoSubscriptionOptionsEx` 方法，当你调用 `registerVideoEncodedFrameObserver` 方法为编码后的视频注册视频帧观测器时，SDK 默认订阅编码后的视频帧。如果你想要修改订阅选项，可以调用新增的方法进行设置。

有关更多注册视频观测器和订阅选项的介绍，详见 [API 参考](./API%20Reference/flutter_ng/API/toc_video_observer.html#api_imediaengine_registervideoencodedframeobserver)。


**11. MPUDP (MultiPath UDP)**

自该版本起，SDK 支持 MPUDP 协议，在 UDP 协议的基础上，允许连接并使用多个路径来最大化信道资源的使用。你可以同时在移动端和桌面端使用不同的物理网卡并将其聚合，达到有效对抗网络抖动、提升传输质量的效果。

<div class="alert info">如果你希望体验该功能，请联系 <a href="mailto:sales@agora.io">sales@agora.io</a>。</div>


**12. 注册插件 (Windows)**

该版本新增 `registerExtension` 方法，用于注册插件。当使用第三方插件时，你需要按照以下顺序调用插件相关的 API ：

调用 `loadExtensionProvider` -> `registerExtension` -> `setExtensionProviderProperty` -> `enableExtension`。


**13. 设备管理 (Windows, macOS)**

该版本新增了一系列回调，帮助你更好地了解音视频设备的状态。

- `onVideoDeviceStateChanged`：当视频设备的状态发生改变时上报。
- `onAudioDeviceStateChanged`：当音频设备的状态发生改变时上报。
- `onAudioDeviceVolumeChanged`：当音频设备或 app 的音量发生改变时上报。


**14. 摄像头采集选项**

该版本在 `CameraCapturerConfiguration` 中增加了 `followEncodeDimensionRatio` 成员，你可以在使用摄像头采集视频时，通过该成员设置是否跟随 `setVideoEncoderConfiguration` 中已经设置的视频宽高比。


**15. 多频道管理**

该版本增加了一系列多频道相关的方法，你可以通过调用这些方法，实现对多频道中音视频流的管理。

- 新增 `muteLocalAudioStreamEx` 和 `muteLocalVideoStreamEx` 方法，分别用于取消或恢复发布本地音频流和视频流。
- 新增 `muteAllRemoteAudioStreamsEx` 和 `muteAllRemoteVideoStreamsEx` 方法，分别用于取消或恢复订阅所有远端用户的音频流和视频流。
- 新增 `startRtmpStreamWithoutTranscodingEx`、`startRtmpStreamWithTranscodingEx`、`updateRtmpTranscodingEx` 和 `stopRtmpStreamEx` 方法，用于实现多频道场景下的旁路推流。
- 新增 `startChannelMediaRelayEx`、`updateChannelMediaRelayEx`、`pauseAllChannelMediaRelayEx`、`resumeAllChannelMediaRelayEx` 和 `stopChannelMediaRelayEx` 方法，用于实现多频道场景下的跨频道媒体流转发。
- `leaveChannelEx` 方法新增 `options` 参数，用于在多频道场景下离开频道时，选择是否停止麦克风采集。


**16. 视频编码偏好**

一般场景下，声网默认的视频编码配置能满足需求。对于特定场景，该版本在 `VideoEncoderConfiguration` 中新增 `advanceOptions` 成员参数，用于视频编码属性的进阶设置：

- `CompressionPreference`：视频编码的压缩偏好设置，用于选择视频的低延时或高质量偏好。
- `EncodingPreference`：视频编码器偏好设置，用于进阶设置视频编码属性，视频编码器偏好设置，用于选择视频的自适应偏好、软件编码偏好或硬件编码偏好。


**17. 日志上传**

使用声网私有媒体服务器的场景下，为支持用户在调用 `setLocalAccessPoint` 方法时的进阶设置，该版本在 `LocalAccessPointConfiguration` 中新增 `advancedConfig` 成员参数，该参数支持如下设置：

- `logUploadServer`：默认情况下，SDK 会将日志上传至声网的日志服务器。你可以通过该参数自定义日志上传的服务器。


**18. 用户角色切换**

为方便用户分辨切换后的用户角色属于互动直播还是极速直播，该版本在 `onClientRoleChanged` 回调中新增 `newRoleOptions` 参数，该参数取值如下：

- `audienceLatencyLevelLowLatency (1)`：低延时，属于极速直播。
- `audienceLatencyLevelUltraLowLatency (2)`：超低延时，属于互动直播。



#### 改进

**1. 视频信息发生改变回调**

该版本优化了 `onVideoSizeChanged` 的触发逻辑，当单独调用 `startPreview` 时，也可触发该回调并上报本地视频大小发生改变。


**2. 首帧出图 (Windows)**

该版本缩短了首帧出图时间，以提升用户视频体验。


**3. 屏幕共享**

该版本对屏幕共享功能做了一系列优化，除以下列出的功能性改进之外，还有一部分可用性提升，详见[问题修复](#问题修复)。

**Windows**
- 在 `ScreenCaptureSourceInfo` 中增加了 `minimizeWindow` 成员，用于表示目标窗口是否已最小化。 
- 在 `ScreenCaptureParameters` 中增加了 `enableHighLight`、`highLightColor` 和 `highLightWidth` 成员，支持你在屏幕共享时对目标窗口或屏幕进行描边。
- 兼容更多主流 app，包括但不限于：WPS Office，Microsoft Office PowerPoint，Visual Studio Code，Adobe Photoshop，Windows Media Player，Scratch。
- 兼容更多设备和操作系统，包括但不限于：Window 8 系统，无独立显卡的设备，双显卡设备。 
- 支持超高清视频 (分辨率为 4K，帧率为 60 fps)，你可以在满足要求的设备上使用该功能。声网推荐的最低设备规格为：inter(R) Core(TM) i7-9750H CPU @ 2.60GHZ。

**macOS**
- 兼容更多设备和场景，包括但不限于：双显卡设备，使用外接屏幕进行屏幕共享。
- 支持超高清视频 (分辨率为 4K，帧率为 60 fps)，你可以在满足要求的设备上使用该功能。声网推荐的最低设备规格为：MacBook Pro (16 英寸，M1，2021 年)。


**4. 蓝牙权限 (Android)**

为简化集成步骤，自该版本起，SDK 支持你在不添加 `BLUETOOTH_CONNECT` 权限的情况下，也能让 Android 用户正常使用蓝牙。


**5. CDN 推流**

为提升 CDN 推流的用户体验，当设置的视频分辨率超出摄像头设备支持的范围时，SDK 会根据你的设置进行自适应，取最接近、且长宽比与你设置的分辨率一致的值进行采集、编码、推流，同时通过 `onDirectCdnStreamingStats` 回调报告推送的视频流的实际分辨率。


**6. 跨频道媒体流转发**

该版本对 `updateChannelMediaRelay` 方法做了如下优化：

- v6.1.0 前：如果服务器内部原因导致目标频道更新失败，SDK 返回错误码 `relayEventPacketUpdateDestChannelRefused (8)`，你需要重新调用 `updateChannelMediaRelay` 方法。
- v6.1.0 及之后：如果服务器内部原因导致目标频道更新失败，SDK 会重新尝试更新直到目标频道更新成功。


**7. AIAEC**

该版本基于 AI 方法重构了 AEC 算法，相比传统 AEC 算法，新的算法可以在较恶劣的回信比 (echo-to-signal) 条件下保存完整、清晰、流畅的近端人声，显著提高系统的回声消除和双讲性能，带给用户更舒适的通话和直播体验。适用于会议、语聊、K 歌等场景。


**8. 虚拟背景**

该版本对虚拟背景算法做了如下优化：

- 在处理虚拟背景的边界时更加细腻，抠图精细程度达到发丝级别。
- 在人像静止或移动时都能确保虚拟背景的稳定性，有效解决背景闪烁、超出画面范围的问题。
- 支持更多应用场景，无论在黑夜、白天、室内、室外等各种环境下都能获得良好的虚拟背景效果。
- 支持识别多种姿态，包括半身静态、身体晃动、手部摆动，并支持精细识别手指动作，在不同手势下均能达到良好的虚拟背景效果。


**其他改进**

- 降低了推送外部音频源时的上行延迟。
- 提升了会议场景 (`audioScenarioMeeting`) 默认参数配置下的回声消除性能。
- 提升了 SDK 视频渲染的流畅度。
- 降低了当主播调用 `muteLocalVideoStream` 方法时本地设备的 CPU 占用率和耗电量。(Window, macOS)
- 增强对不同网络协议栈的识别能力，在多种运营商网络场景下提升 SDK 的接入能力。


#### 问题修复

该版本修复了以下问题：

**All**
- 在频道内调用 `setVideoEncoderConfigurationEx` 将视频的分辨率调高时，偶现失效。
- 使用媒体播放器播放视频，先调用 `play` 再调用 `pause` 暂停播放后，调用 `seek` 指定一个新的播放位置，偶现视频画面依然是暂停播放时的画面；调用 `resume` 恢复播放后，偶现视频画面出现快进。
- 在直播场景下，主播在扬声器和听筒之间进行切换后，观众听主播的声音会听到滋啦杂声。
- 调用 `getExtensionProperty` 失败，返回空字符串。
- 当以观众身份进入一个已播放较长时间的直播间，首帧出图时间缩短。


**Android**
- 在多人会议场景下，本地用户接听并挂断电话后，偶现本地用户和远端用户无法听见对方的声音。
- 调用 `setCloudProxy` 设置云代理后，调用 `joinChannelEx` 加入多频道失败。


**iOS**
- 调用 `startAudioMixing` 播放 ipod-library://item 路径的音乐文件失败。
- 同时通过 `onRecordAudioFrame` 和 `onCaptureVideoFrame` 回调分别获取的音频和视频数据时间戳不同。


**Windows**
- 调用 `stopPreview` 关闭本地视频预览时，导致已设置的虚拟背景一定概率失效。
- 开启虚拟背景并设置为背景虚化效果时，多次退出频道再加入频道时偶现崩溃。
- 本地端使用 1920 x 1080 的摄像头作为视频采集源，偶现远端视频的分辨率与本地端不一致。
- 通过摄像头采集视频时，如果在 `CameraCapturerConfiguration` 中设置的视频宽高比例和在 `setVideoEncoderConfiguration` 中设置的不一致，导致本地视频预览的画面比例未按照后者的设置呈现。
- 在屏幕共享场景下，将共享的窗口最小化时，偶现远端用户出现黑屏或远端画面切换为视频小流。
- 在直播场景下，主播开启屏幕共享时，偶现观众听主播说话有回声。
- 在屏幕共享场景下，偶现系统声音音量变小。
- 在屏幕共享场景下，在横屏显示器与竖屏显示器之间共享屏幕时出现黑屏。
- 在屏幕共享场景下屏蔽窗口时，屏幕共享区域超出屏幕分辨率导致崩溃。
- 调用 `startScreenCaptureByDisplayId` 进行屏幕共享时无法屏蔽窗口。
- 在屏幕共享场景下，远端用户看到的画面偶现黑屏、卡顿、崩溃。 
- 在屏幕共享场景下，偶现 `onNetworkQuality` 回调报告频道内指定用户的上下行网络状态不准确。
- 在屏幕共享场景下，在共享窗口中看到的鼠标位置与实际位置有偏差。
- 从普通场景切换屏幕共享场景后，由于两种场景下设置的分辨率不同导致偶现崩溃。


**macOS**
- 通过摄像头采集视频时，如果在 `CameraCapturerConfiguration` 中设置的视频宽高比例和在 `setVideoEncoderConfiguration` 中设置的不一致，导致本地视频预览的画面比例未按照后者的设置呈现。
- 在屏幕共享场景下，将共享的窗口最小化或关闭共享窗口时，共享窗口自动切换为该 app 的其他窗口。
- 在屏幕共享场景下，偶现系统声音音量变小。
- 在屏幕共享场景下，当共享的窗口为半屏模式时，对窗口的描边不正确。
- 在屏幕共享场景下，远端用户看到的画面偶现黑屏、卡顿、崩溃。 
- 在屏幕共享场景下，偶现 `onNetworkQuality` 回调报告频道内指定用户的上下行网络状态不准确。
- 启动并停止音频采集设备测试后，启动音频播放设备测试时必现无声。
- `onVideoPublishStateChanged` 回调报告的视频源类型不准确。


#### API 变更

**新增**

- `getNativeHandle`
- `getMusicContentCenter`
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
- `enableMultiCamera` (iOS)
- `setRemoteVideoSubscriptionOptions`
- `setRemoteVideoSubscriptionOptionsEx`
- `VideoSubscriptionOptions`
- `AdvanceOptions`
- `EncodingPreference`
- `CompressionPreference`
- `adjustUserPlaybackSignalVolumeEx`
- `onRhythmPlayerStateChanged` (Android, iOS)
- `RhythmPlayerStateType`
- `RhythmPlayerErrorType`
- `enableAudioVolumeIndicationEx`
- `onVideoDeviceStateChanged` (Windows, macOS)
- `onAudioDeviceStateChanged` (Windows, macOS)
- `onAudioDeviceVolumeChanged` (Windows, macOS)
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
- `MusicContentCenter` 接口类及其中方法 (Android, iOS)
- `MusicPlayer` 接口类及其中方法 (Android, iOS)
- `MusicContentCenterEventHandler` 接口类及其中回调 (Android, iOS)
- `MusicChartInfo` 类 (Android, iOS)
- `ClimaxSegment` 类 (Android, iOS)
- `Music` 类 (Android, iOS)
- `MusicContentCenterConfiguration` 类 (Android, iOS)
- `MusicChartCollection` 类 (iOS)
- `MusicCollection` 类 (iOS)
- `PreloadStatusCode` (iOS)
- `MusicContentCenterStatusCode` (iOS)


**修改**

- `enableDualStreamMode`：删除 `sourceType`
- `ChannelMediaOptions`：新增 `isAudioFilterable`
- `enableInEarMonitoring`：支持 PC 端
- `setEarMonitoringAudioFrameParameters`：支持 PC 端
- `setInEarMonitoringVolume`：支持 PC 端
- `onEarMonitoringAudioFrame`：支持 PC 端
- `SpatialAudioParams`：新增 `enableDoppler`
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
- `ChannelMediaRelayEvent`：废弃 `relayEventPacketUpdateDestChannelRefused (8)`







## v6.0.0 (对应 Native v4.0.0) 

该版本于 2022 年 9 月 29 日发布。


#### 升级必看

v6.0.0 SDK 包名由 `agora_rtc_ng` 变更为 `agora_rtc_engine`，且对部分功能的实现方式进行了优化，从而导致与 v5.x 不兼容。如下为存在兼容性变更的主要功能：
- 多频道
- 媒体流发布控制
- 自定义视频采集与渲染 (Media IO 方式) 
- 错误码与警告码
升级 SDK 后，你需要结合实际业务场景更新 app 代码，详见[迁移指南](./migration_guide_flutter_ng)。


#### 新增特性

**1. 多路媒体流**

该版本支持通过设置 `RtcEngineEx` 和 `ChannelMediaOptions`，实现一个 `RtcEngine` 实例同时采集多路音视频源并发布到远端，适应各种业务场景。例如：

- 调用 `joinChannel` 加入首个频道后，多次调用 `joinChannelEx` 加入多个频道，通过不同的用户 ID 和 `ChannelMediaOptions` 设置发布指定的流到不同的频道。
- 支持通过设置 `ChannelMediaOptions` 中的 `publishSecondaryCameraTrack` 和 `publishSecondaryScreenTrack` 同时发布多路摄像头采集或者屏幕共享的视频流。

该版本支持通过 `createCustomVideoTrack` 方法实现自定义视频采集。你可以参考如下步骤，体验同时发布多路自定义采集视频流：

1. 创建自采集视频轨道：调用 `createCustomVideoTrack` 方法创建一个自定义视频轨道，并获得视频轨道 ID。
2. 设置频道中待发布的自采集视频轨道：在每个频道的 `ChannelMediaOptions` 中，将 `customVideoTrackId` 参数设置为你想要发布的视频轨道 ID，并将 `publishCustomVideoTrack` 设置为 `true`。
3. 推送外部视频源：调用 `pushVideoFrame`，并将 `videoTrackId` 指定为你想要发布的自定义视频轨道 ID，即可根据步骤 2 的设置，实现在多个频道中发布对应的自定义视频源。

结合多频道能力，你还可以体验如下功能：

- 将多组音视频流通过不同的用户 ID (`uid`) 发布到远端。
- 将多路音频流混音后通过一个用户 ID (`uid`) 发布到远端。
- 将多组视频频流通过不同的用户 ID (`uid`) 发布到远端。
- 将多路视频流合图后通过一个用户 ID (`uid`) 发布到远端。

**2. 超高清分辨率 (Beta) (Windows, macOS)**

为提升视频互动体验，SDK 对视频采集、编码、解码、渲染全流程做出了优化，自该版本起支持 4K 分辨率。优化了 FEC (Forward Error Correction) 算法，可根据视频帧包数与帧率进行自适应切换，降低 4K 场景下的视频卡顿率。你可以在调用 `setVideoEncoderConfiguration` 时，设置编码分辨率为 4K (3840 × 2160)、帧率为 60 fps。当你的设备不支持 4K 时，SDK 支持自动回退到适合的分辨率和帧率。

<div class="alert info"><ul><li>该功能对设备性能和网络带宽有一定要求，在不同的平台上支持的上下行帧率也不同，如需体验该功能，请联系<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">技术支持</a>。</li><li>高分辨率可能会影响集合分辨率从而导致费用变更。详见<a href="./billing_rtc_ng">计费说明</a>。</li></ul></div>


**3. 全高清和超高清分辨率 (Android, iOS)**

为提升视频互动体验，SDK 对视频采集、编码、解码、渲染全流程做出了优化，自该版本起支持全高清 (FHD) 和超高清 (UHD) 视频分辨率。你可以在调用 `setVideoEncoderConfiguration` 方法时，将 `dimensions` 参数设置为 1920 × 1080 或更高的分辨率。如果你的设备不支持高分辨率，SDK 支持自动回退到适合的分辨率。

<div class="alert info"><ul><li>超高清分辨率 (4K，60 fps) 目前为 Beta 功能，且对设备性能和网络带宽有一定要求，如需体验该功能，请联系<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">技术支持</a>。</li><li>高分辨率通常需要更高的性能消耗，为避免设备性能不足导致体验下降，声网建议你在性能较好的设备上开启全高清和超高清视频分辨率。</li><li>高分辨率可能会影响集合分辨率从而导致费用变更。详见<a href="./billing_rtc_ng">计费说明</a>。</li></ul></div>


**4. 内置媒体播放器**

为减少 SDK 包体积、集成时间，以及简化 API 的调用步骤，该版本支持内置媒体播放器。调用 `createMediaPlayer` 创建媒体播放器后，你可以通过 `MediaPlayer` 类的一系列方法体验内置媒体播放器的各类功能：

- 自动播放本地、在线、自定义的媒体资源。
- 预先加载待播放的媒体资源。
- 根据网络情况切换媒体资源的播放线路。
- 将媒体播放器的音视频流推送到任意频道、分享给远端用户。
- 实时缓存媒体资源文件，该功能开启后，播放器会预先缓存当前正在播放的媒体文件的部分数据到本地，可提高播放流畅度，帮助节省网络流量。


**5. 新版 AI 降噪**

自该版本起，SDK 支持新版 AI 降噪 (相对于 agora_rtc_engine: ^5.x 中的基础 AI 降噪) 功能。相比原版 AI 降噪，新版 AI 降噪具有更好的人声保真度、更干净的噪声抑制，并新增了去混响 (Dereverberation) 能力。
如果你希望体验新版 AI 降噪，请联系 [sales@agora.io](mailto:sales@agora.io)。


**6. 超高音质**

为还原音频的细节、提升音频的清晰度，该版本新增 `ultraHighQualityVoice`。在语聊、歌唱等以人声为主的场景中，你可以调用 `setVoiceBeautifierPreset` 并使用该枚举体验超高音质。


**7. 空间音效**

<div class="alert note">空间音效功能当前处于实验阶段，请联系 <a href= "mailto:sales@agora.io">sales@agora.io</a> 开通空间音效功能，如果需要技术支持，请<a href="https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms">提交工单</a>。</div>

该版本提供本地直角坐标系计算方案实现空间音效：

- 使用 `LocalSpatialAudioEngine` 类实现空间音效，通过 SDK 计算远端用户的空间坐标。你需要分别调用 `updateSelfPosition` 和 `updateRemotePosition` 更新本地和远端用户的空间坐标，本地用户才能听到远端用户的空间音效。
![](https://web-cdn.agora.io/docs-files/1663038259399)

- 通过 SDK 计算媒体播放器的空间坐标。你需要在 `LocalSpatialAudioEngine` 类中分别调用 `updateSelfPosition` 和 `updatePlayerPositionInfo` 更新本地用户和媒体播放器的空间坐标，本地用户才能听到媒体播放器的空间音效。
![](https://web-cdn.agora.io/docs-files/1663038287220)


**8. 实时合唱**

该版本为实时合唱赋予了如下能力：

- 支持两人及两人以上合唱。
- 每位歌手相互独立。一位歌手出现问题或退出合唱，其他歌手还可以继续合唱。
- 极低延时体验。每位歌手可以实时听到彼此的歌声，观众也可以实时听到每位歌手。

该版本新增 `audioScenarioChorus` 枚举来设置极低延时。使用该枚举后，在网络条件良好的情况下，用户可以体验到极低延时的实时合唱。


**9. 增强的频道管理**

为满足各类业务场景对频道管理的需求，该版本在 `ChannelMediaOptions` 类中新增了如下功能：

- 设置或切换多种音视频源的发布
- 设置或切换频道场景、用户角色
- 设置或切换订阅视频的大小流类型
- 控制音频发布时延

在调用 `joinChannel` 或 `joinChannelEx` 时设置 `ChannelMediaOptions`，明确媒体流发布和订阅行为，例如，是否发布摄像头采集或者屏幕共享的视频流，是否要主动订阅远端用户的音视频流。加入频道后，调用 `updateChannelMediaOptions` 随时更新 `ChannelMediaOptions` 中的设置，例如，切换发布的音视频源。


**10. 屏幕共享**

该版本优化了开启屏幕共享的逻辑，你可以根据实际场景选择不同的方式开启屏幕共享。

在 Windows 和 macOS 平台：

- 在加入频道前调用 `startScreenCaptureByDisplayId`，然后调用 `joinChannel` 加入频道并设置 `publishScreenTrack` 或 `publishSecondaryScreenTrack` 为 `true`，即可开始屏幕共享。
- 在加入频道后调用 `startScreenCaptureByDisplayId`，然后调用 `updateChannelMediaOptions` 设置 `publishScreenTrack` 或 `publishSecondaryScreenTrack` 为 `true`，即可开始屏幕共享。

在 Android 和 iOS 平台：

- 在加入频道前调用 `startScreenCapture`，然后调用 `joinChannel` 加入频道并设置 `publishScreenCaptureVideo` 为 `true`，即可开始屏幕共享。
- 在加入频道后调用 `startScreenCapture`，然后调用 `updateChannelMediaOptions` 设置 `publishScreenCaptureVideo` 为 `true`，即可开始屏幕共享。


**11. 设置音视频流订阅黑/白名单**

该版本新增音视频流订阅黑/白名单功能，支持灵活订阅频道内发流用户的音视频流。你可以通过以下 API 来将指定用户的用户 ID 加入到相应的音视频黑白名单中，从而实现订阅/不订阅指定用户的音频或视频流。在多频道场景下，你可以通 `RtcEngineEx` 类下的同名方法来实现该功能。

- `setSubscribeAudioBlacklist`：设置音频订阅黑名单。
- `setSubscribeAudioWhitelist`：设置音频订阅白名单。
- `setSubscribeVideoBlacklist`：设置视频订阅黑名单。
- `setSubscribeVideoWhitelist`：设置视频订阅白名单。

如果某个用户同时在音频或视频订阅的黑、白名单中，只有黑名单会生效。


**12. 设置音频场景**

为方便用户灵活修改音频场景，该版本新增 `setAudioScenario` 方法，支持你根据业务需求设置音频场景。例如，如果你在频道内想将音频场景从自动场景 (`AudioScenarioDefault`) 切换为高音质场景 (`AudioScenarioGameStreaming`) ，你可以调用该方法。


**13. 设置本地代理**

该本版新增 `setLocalAccessPoint` 方法，用于在成功部署声网混合云、私有化平台后，指定 Local Access Point 来设置本地代理。你可以联系 [sales@agora.io](mailto:sales@agora.io) 了解和部署声网混合云或声网私有化平台。


**14. 垫片推流**

该版本新增垫片推流功能，支持你在发流时使用本地 png 格式的图片来替代当前发布的视频流画面进行推流。你可以通过 `enableVideoImageSource` 来开启该功能，并通过 `options` 参数自定义垫片图片；在你关闭垫片功能之后，远端用户看到的依旧是当前你发布的视频流画面。


**15. 本地合图**

该版本新增本地合图功能，可支持在本地将多路视频流合并为一路视频流。常见场景如下：

在直播场景或使用旁路推流功能时，可以在本地将多个主播的画面合并为一个画面。
将本地采集的多路视频流 (例如：摄像头采集的视频、屏幕共享流、视频文件、图片等) 合并为一路视频流，然后在频道内发布已合图的视频流。
你可以调用 `startLocalVideoTranscoder` 方法开启本地合图、调用 `stopLocalVideoTranscoder` 方法停止本地合图；在开启本地合图后，可以调用 `updateLocalTranscoderConfiguration` 进行本地合图的配置更新。


**16. 视频设备管理**

视频采集设备可能支持多种视频格式，每一种格式都支持不同的视频帧宽度、视频帧高度、帧率组合。

该版本新增 `numberOfCapabilities` 和 `getCapability` 方法，用于获取视频采集设备支持的视频格式数量以及指定视频格式下的视频帧详细信息。在调用 `startPrimaryCameraCapture` 或 `startSecondaryCameraCapture` 方法使用摄像头采集视频时，你可以使用指定的视频格式进行采集。
SDK 会根据你在 `VideoEncoderConfiguration` 中的设置，自动选择选择视频采集设备的最佳视频格式进行采集。一般情况下，你不需要用到该组新增方法。


#### 改进

**1. 快速切换频道**

该版本通过 `leaveChannel` 和 `joinChannel` 切换频道即可实现和 agora_rtc_engine: ^5.x 中 `switchChannel` 一样的切换速度，无需额外调用 `switchChannel` 方法。


**2. 推送外部视频帧**

该版本新增支持推送 I422 格式的外部视频帧，你可以通过 `pushVideoFrame` 方法将 I422 格式的外部视频帧推送至 SDK。


**3. 本地人声音调**

该版本在 `onAudioVolumeIndication` 的 `AudioVolumeInfo` 中新增 `voicePitch` 参数。你可以通过 `voicePitch` 获取本地用户的人声音调，从而实现唱歌评分等业务功能。


**4. 本地视频预览**

该版本优化了 `startPreview` 方法的调用逻辑。如果你需要开启本地视频预览，你可以直接通过 `startPreview` 方法来开启视频预览，无调用时序要求。


**5. 订阅视频流**

你可以通过 `setRemoteDefaultVideoStreamType` 方法，根据你想要订阅的视频流分辨率和码率来灵活设置默认订阅视频流类型。