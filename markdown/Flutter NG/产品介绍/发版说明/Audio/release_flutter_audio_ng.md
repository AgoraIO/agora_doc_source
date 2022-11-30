## v6.1.0 版 (对应 Native v4.1.0 版)

该版本于 2022 年 11 月 xx 日发布。


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

Agora 服务器会根据音量大小对音频流进行筛选，选出 N 路音量最大的音频流并传输至接收端。N 默认为 3 路，如需自定义设置 N，请联系技术支持。

同时，Agora 还支持发流端自定义设置是否参与音强选流，不参与选流的音频流会直接和被选出的 N 路音频流一同传输至接收端。在大型会议等多人发流的场景下，开启音强选流功能可以帮助减轻接收端的下行带宽压力和系统资源消耗，详见音强选流。

<div class="alert info">该版本新增音强选流功能，如需开启该功能，请联系 <a href="https://agora-ticket.agora.io/">技术支持</a>。</div>


**5. 声卡采集设备 (Windows)**

SDK 默认使用播放设备为声卡采集设备，自该版本起，你可以另外指定声卡采集设备并将其采集到的音频发布到远端。

- `setLoopbackDevice`：用于指定声卡采集设备，当你不希望当前的播放设备为声卡采集设备时，可以调用该方法另外指定别的设备作为声卡采集设备。
- `getLoopbackDevice`：用于获取当前的声卡采集设备。
- `followSystemLoopbackDevice`：用于设置声卡采集设备是否跟随系统默认的播放设备。


**6. 空间音效**

该版本新增了如下适用于空间音效场景的特性，在虚拟互动场景下可以有效提升用户的临场感体验。

- 隔声区域：你可以通过调用 `setZones` 设置隔声区域和声音衰减系数。当音源 (可以为用户或媒体播放器) 跟听声者分属于音障区域内部和外部时，会体验到类似真实环境中声音在遇到建筑隔断时的衰减效果。你也可以通过调用 `setPlayerAttenuation` 和 `setRemoteAudioAttenuation` 方法分别针对媒体播放器和用户设置声音衰减属性，并指定是否使用该设置强制覆盖 `setZones` 中的声音衰减系数。
- 多普勒音效：你可以通过设置 `SpatialAudioParams` 中的 `enableDoppler` 参数开启多普勒音效，在声源和接收方发生高速相对位移的情况下 (比如赛车游戏场景) ，接收方会体验到明显的音调变化。
- 耳机均衡器：你可以通过调用 `setHeadphoneEQPreset` 方法使用预设的耳机均衡效果，以改善耳机的听感。


**7. 版权音乐 (iOS, Android)**

为解决直播、语聊房、在线 K 歌房等场景下歌曲的应用版权问题，该版本新增版权音乐相关 API。你可以通过调用 `MusicContentCenter` 类、`MusicPlayer` 类、`MusicContentCenterEventHandler` 类下的相关 API 实现在实时互动场景中播放版权音乐以及相关功能，例如检索音乐资源、获取音乐榜单及榜单详情、预加载及播放音乐资源、下载歌词及海报等功能。你还可以参考[在线 K 歌房](https://docs.agora.io/cn/online-ktv/ktv_overview)来体验搭配了演唱评分、美声音效等一系列功能的线上 K 歌场景化解决方案。


**8. 耳机均衡器**

该版本新增 `setHeadphoneEQParameters` 方法，用于调节耳机均衡器的低频和高频参数，主要应用于空间音效场景。如果在调用 `setHeadphoneEQPreset` 后仍未达到预期的耳机均衡效果，你可以调用该方法进行调节。


**9. MPUDP (MultiPath UDP)**

自该版本起，SDK 支持 MPUDP 协议，在 UDP 协议的基础上，允许连接并使用多个路径来最大化信道资源的使用。你可以同时在移动端和桌面端使用不同的物理网卡并将其聚合，达到有效对抗网络抖动、提升传输质量的效果。

<div class="alert info">如果你希望体验该功能，请联系 <a href="mailto:sales@agora.io">sales@agora.io</a>。</div>


**10. 注册插件 (Windows)**

该版本新增 `registerExtension` 方法，用于注册插件。当使用第三方插件时，你需要按照以下顺序调用插件相关的 API ：

调用 `loadExtensionProvider` -> `registerExtension` -> `setExtensionProviderProperty` -> `enableExtension`。


**11. 设备管理 (Windows, macOS)**

该版本新增了一系列回调，帮助你更好地了解音频设备的状态。

- `onAudioDeviceStateChanged`：当音频设备的状态发生改变时上报。
- `onAudioDeviceVolumeChanged`：当音频设备或 app 的音量发生改变时上报。


**12. 多频道管理**

该版本增加了一系列多频道相关的方法，你可以通过调用这些方法，实现对多频道中音频流的管理。

- 新增 `muteLocalAudioStreamEx` 用于取消或恢复发布本地音频流。
- 新增 `muteAllRemoteAudioStreamsEx` 用于取消或恢复订阅所有远端用户的音频流。
- 新增 `startRtmpStreamWithoutTranscodingEx`、`startRtmpStreamWithTranscodingEx`、`updateRtmpTranscodingEx` 和 `stopRtmpStreamEx` 方法，用于实现多频道场景下的旁路推流。
- 新增 `startChannelMediaRelayEx`、`updateChannelMediaRelayEx`、`pauseAllChannelMediaRelayEx`、`resumeAllChannelMediaRelayEx` 和 `stopChannelMediaRelayEx` 方法，用于实现多频道场景下的跨频道媒体流转发。
- `leaveChannelEx` 方法新增 `options` 参数，用于在多频道场景下离开频道时，选择是否停止麦克风采集。


**13. 日志上传**

使用声网私有媒体服务器的场景下，为支持用户在调用 `setLocalAccessPoint` 方法时的进阶设置，该版本在 `LocalAccessPointConfiguration`中新增 `advancedConfig` 成员参数，该参数支持如下设置：

- `logUploadServer`：默认情况下，SDK 会将日志上传至 Agora 的日志服务器。你可以通过该参数自定义日志上传的服务器。


**14. 用户角色切换**

为方便用户分辨切换后的用户角色属于互动直播还是极速直播，该版本在 `onClientRoleChanged` 回调中新增 `newRoleOptions` 参数，该参数取值如下：

- `audienceLatencyLevelLowLatency (1)`: 低延时，属于极速直播。
- `audienceLatencyLevelUltraLowLatency (2)`: 超低延时，属于互动直播。



#### 改进

**1. 蓝牙权限 (Android)**

为简化集成步骤，自该版本起，SDK 支持你在不添加 `BLUETOOTH_CONNECT` 权限的情况下，也能让 Android 用户正常使用蓝牙。


**2. 跨频道媒体流转发**

该版本对 `updateChannelMediaRelay` 方法做了如下优化：

- 6.1.0 版本前：如果服务器内部原因导致目标频道更新失败，SDK 返回错误码 `relayEventPacketUpdateDestChannelRefused (8)`，你需要重新调用 `updateChannelMediaRelay` 方法。
- 6.1.0 版本及之后：如果服务器内部原因导致目标频道更新失败，SDK 会重新尝试更新直到目标频道更新成功。


**3. AIAEC**

该版本基于 AI 方法重构了 AEC 算法，相比传统 AEC 算法，新的算法可以在较恶劣的回信比 (echo-to-signal) 条件下保存完整、清晰、流畅的近端人声，显著提高系统的回声消除和双讲性能，带给用户更舒适的通话和直播体验。适用于会议、语聊、K 歌等场景。


**其他改进**

- 降低了推送外部音频源时的上行延迟。
- 提升了会议场景 (`audioScenarioMeeting`) 默认参数配置下的回声消除性能。
- 增强对不同网络协议栈的识别能力，在多种运营商网络场景下提升 SDK 的接入能力。


#### 问题修复

该版本修复了以下问题：

**All**
- 在直播场景下，主播在扬声器和听筒之间进行切换后，观众听主播的声音会听到滋啦杂声。
- 调用 `getExtensionProperty` 失败，返回空字符串。
- 当以观众身份进入一个已播放较长时间的直播间，首帧出图时间缩短。


**Android**
- 在多人会议场景下，本地用户接听并挂断电话后，偶现本地用户和远端用户无法听见对方的声音。
- 调用 `setCloudProxy` 设置云代理后，调用 `joinChannelEx` 加入多频道失败。


**iOS**
- 调用 `startAudioMixing` 播放 ipod-library://item 路径的音乐文件失败。


**Windows**
- 在直播场景下，主播开启屏幕共享时，偶现观众听主播说话有回声。
- 在屏幕共享场景下，偶现系统声音音量变小。
- 在屏幕共享场景下，偶现 `onNetworkQuality` 回调报告频道内指定用户的上下行网络状态不准确。


**macOS**
- 在屏幕共享场景下，偶现系统声音音量变小。
- 在屏幕共享场景下，偶现 `onNetworkQuality` 回调报告频道内指定用户的上下行网络状态不准确。
- 启动并停止音频采集设备测试后，启动音频播放设备测试时必现无声。


#### API 变更

**新增**

- `getNativeHandle`
- `getMusicContentCenter`
- `getPlaybackDefaultDevice`
- `getRecordingDefaultDevice`
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
- `AdvancedOptions`
- `EncodingPreference`
- `CompressionPreference`
- `adjustUserPlaybackSignalVolumeEx`
- `onRhythmPlayerStateChanged` (Android, iOS)
- `RhythmPlayerStateType`
- `RhythmPlayerErrorType`
- `enableAudioVolumeIndicationEx`
- `onAudioDeviceStateChanged` (Windows, macOS)
- `onAudioDeviceVolumeChanged` (Windows, macOS)
- `registerExtension` (Windows)
- `muteLocalAudioStreamEx`
- `muteAllRemoteAudioStreamsEx`
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

- `ChannelMediaOptions`：新增 `isAudioFilterable`
- `enableInEarMonitoring`：支持 PC 端
- `setEarMonitoringAudioFrameParameters`：支持 PC 端
- `setInEarMonitoringVolume`：支持 PC 端
- `onEarMonitoringAudioFrame`：支持 PC 端
- `SpatialAudioParams`：新增 `enableDoppler`
- `leaveChannelEx`：新增 `options`
- `LocalAccessPointConfiguration`：新增 `advancedConfig`
- `onClientRoleChanged`：新增 `newRoleOptions`


**废弃**

- `onApiCallExecuted`
- `ChannelMediaRelayEvent`：废弃 `relayEventPacketUpdateDestChannelRefused (8)`



## v6.0.0 版 （对应 Native v4.0.0 版）

该版本于 2022 年 9 月 29 日发布。


#### 升级必看

v6.0.0 SDK 包名由 `agora_rtc_ng` 变更为 `agora_rtc_engine`，且对部分功能的实现方式进行了优化，从而导致与 v5.x 不兼容。如下为存在兼容性变更的主要功能：
- 多频道
- 媒体流发布控制
- 错误码与警告码
升级 SDK 后，你需要结合实际业务场景更新 app 代码，详见[迁移指南](./migration_guide_flutter_ng)。


#### 新增特性

**1. 多路媒体流**

该版本支持通过设置 `RtcEngineEx` 和 `ChannelMediaOptions`，实现一个 `RtcEngine` 实例同时采集多路音频源并发布到远端，适应各种业务场景。例如：

- 调用 `joinChannel` 加入首个频道后，多次调用 `joinChannelEx` 加入多个频道，通过不同的用户 ID 和 `ChannelMediaOptions` 设置发布指定的流到不同的频道。

结合多频道能力，你还可以体验如下功能：

- 将多组音频流通过不同的用户 ID（`uid`）发布到远端。
- 将多路音频流混音后通过一个用户 ID（`uid`）发布到远端。


**2. 内置媒体播放器**

为减少 SDK 包体积、集成时间，以及简化 API 的调用步骤，该版本支持内置媒体播放器。调用 `createMediaPlayer` 创建媒体播放器后，你可以通过 `MediaPlayer` 类的一系列方法体验内置媒体播放器的各类功能：

- 自动播放本地、在线、自定义的媒体资源。
- 预先加载待播放的媒体资源。
- 根据网络情况切换媒体资源的播放线路。
- 将媒体播放器的音频流推送到任意频道、分享给远端用户。
- 实时缓存媒体资源文件，该功能开启后，播放器会预先缓存当前正在播放的媒体文件的部分数据到本地，可提高播放流畅度，帮助节省网络流量。


**3. 新版 AI 降噪**

自该版本起，SDK 支持新版 AI 降噪（相对于 agora_rtc_engine: ^5.x 中的基础 AI 降噪）功能。相比原版 AI 降噪，新版 AI 降噪具有更好的人声保真度、更干净的噪声抑制，并新增了去混响（Dereverberation）能力。
如果你希望体验新版 AI 降噪，请联系 [sales@agora.io](mailto:sales@agora.io)。


**4. 超高音质**

为还原音频的细节、提升音频的清晰度，该版本新增 `ultraHighQualityVoice`。在语聊、歌唱等以人声为主的场景中，你可以调用 `setVoiceBeautifierPreset` 并使用该枚举体验超高音质。


**5. 空间音效**

<div class="alert note">空间音效功能当前处于实验阶段，请联系 <a href= "mailto:sales@agora.io">sales@agora.io</a> 开通空间音效功能，如果需要技术支持，请<a href="https://agora-ticket.agora.io/">提交工单</a>。</div>

该版本提供本地直角坐标系计算方案实现空间音效：

- 使用 `LocalSpatialAudioEngine` 类实现空间音效，通过 SDK 计算远端用户的空间坐标。你需要分别调用 `updateSelfPosition` 和 `updateRemotePosition` 更新本地和远端用户的空间坐标，本地用户才能听到远端用户的空间音效。
![](https://web-cdn.agora.io/docs-files/1663038259399)

- 通过 SDK 计算媒体播放器的空间坐标。你需要在 `LocalSpatialAudioEngine` 类中分别调用 `updateSelfPosition` 和 `updatePlayerPositionInfo` 更新本地用户和媒体播放器的空间坐标，本地用户才能听到媒体播放器的空间音效。
![](https://web-cdn.agora.io/docs-files/1663038287220)


**6. 实时合唱**

该版本为实时合唱赋予了如下能力：

- 支持两人及两人以上合唱。
- 每位歌手相互独立。一位歌手出现问题或退出合唱，其他歌手还可以继续合唱。
- 极低延时体验。每位歌手可以实时听到彼此的歌声，观众也可以实时听到每位歌手。

该版本新增 `audioScenarioChorus` 枚举来设置极低延时。使用该枚举后，在网络条件良好的情况下，用户可以体验到极低延时的实时合唱。


**7. 增强的频道管理**

为满足各类业务场景对频道管理的需求，该版本在 `ChannelMediaOptions` 结构体中新增了如下功能：

- 设置或切换多种音频源的发布
- 设置或切换频道场景、用户角色
- 控制音频发布时延

在调用 `joinChannel` 或 `joinChannelEx` 时设置 `ChannelMediaOptions`，明确媒体流发布和订阅行为，例如，是否要主动订阅远端用户的音频流。加入频道后，调用 `updateChannelMediaOptions` 随时更新 `ChannelMediaOptions` 中的设置，例如，切换发布的音频源。


**8. 设置音频流订阅黑/白名单**

该版本新增音频流订阅黑/白名单功能，支持灵活订阅频道内发流用户的音频流。你可以通过以下 API 来将指定用户的用户 ID 加入到相应的音频黑白名单中，从而实现订阅/不订阅指定用户的音频流。在多频道场景下，你可以通 `RtcEngineEx` 类下的同名方法来实现该功能。

- `setSubscribeAudioBlacklist`：设置音频订阅黑名单。
- `setSubscribeAudioWhitelist`：设置音频订阅白名单。

如果某个用户同时在音频订阅的黑、白名单中，只有黑名单会生效。


**9. 设置音频场景**

为方便用户灵活修改音频场景，该版本新增 `setAudioScenario` 方法，支持你根据业务需求设置音频场景。例如，如果你在频道内想将音频场景从自动场景 （`AudioScenarioDefault`）切换为高音质场景 （`AudioScenarioGameStreaming`），你可以调用该方法。


**10. 设置本地代理**

该本版新增 `setLocalAccessPoint` 方法，用于在成功部署声网混合云、私有化平台后，指定 Local Access Point 来设置本地代理。你可以联系 [sales@agora.io](mailto:sales@agora.io) 了解和部署声网混合云或声网私有化平台。


#### 改进

**1. 快速切换频道**

该版本通过 `leaveChannel` 和 `joinChannel` 切换频道即可实现和 agora_rtc_engine: ^5.x 中 `switchChannel` 一样的切换速度，无需额外调用 `switchChannel` 方法。

**2. 本地人声音调**

该版本在 `onAudioVolumeIndication` 的 `AudioVolumeInfo` 中新增 `voicePitch` 参数。你可以通过 `voicePitch` 获取本地用户的人声音调，从而实现唱歌评分等业务功能。