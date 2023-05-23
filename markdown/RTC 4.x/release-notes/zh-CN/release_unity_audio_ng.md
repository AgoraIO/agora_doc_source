## V4.2.0 版

该版本于 2023 年 5 月 23 日发布。

#### 升级必看

该版本对部分功能的实现方式进行了优化，请在升级到该版本后更新 app 代码。

**1. 媒体发布选项**

- `ChannelMediaOptions` 中的 `PublishCustomAudioTrackEnableAec` 已删除，请改用 `PublishCustomAudioTrack`。
- `ChannelMediaOptions` 中的成员 `PublishCustomAudioSourceId` 变更为 `PublishCustomAudioTrackId`。

**2. 音频录制**

- `删除 GetMediaRecorder` 方法，可通过该版本新增的 `CreateMediaRecorder` 方法来创建录制对象。
- `删除 StartRecording` 、`StopRecording`、`SetMediaRecorderObserver` 中的 `connection` 参数。

**3. 其他兼容性变更**

- `OnApiCallExecuted` 已删除，请改用相关频道和媒体的事件通知得知 API 的执行结果。
- `IAudioFrameObserver` 类名变更为 `IAudioPcmFrameSink`，因此下列方法原型也有相应更新：
  - `OnFrame`
  - `IMediaPlayer` 下的 `RegisterAudioFrameObserver` [1/2]、`RegisterAudioFrameObserver`[2/2]
- `StartChannelMediaRelay`、`UpdateChannelMediaRelay`、`StartChannelMediaRelayEx` 和 `UpdateChannelMediaRelayEx` 已废弃，请改用 `StartOrUpdateChannelMediaRelay` 和 `StartOrUpdateChannelMediaRelayEx`。

#### 新增特性

**1. AI 降噪**

该版本新增AI 降噪功能。开启该功能后，SDK 会智能识别和消除背景噪音，无论是在嘈杂的公共场所，还是在需要保持低延迟的实时竞技场景，都能够确保声音传输的清晰度，为用户提供更高质量的音频体验。你可以通过该版本新增的 `SetAINSMode` 方法开启 AI 降噪，并根据实际场景，将降噪模式设置为均衡模式、强降噪模式或低延时模式。

**2. 本地录制远端音频（Beta）**

该版本新增本地录制远端音频功能。本地用户可以录制远端用户的音频流，便于将来回放、分析或分享，适用于在线教育、企业培训、在线会议等多类场景。为更准确报告录制状态，该版本在 `OnRecorderStateChanged` 、`OnRecorderInfoUpdated` 中新增 `channelId` 和 `uid` 参数，用于表示录制的音频流的具体信息，并新增 `CreateMediaRecorder` 方法，用于创建本地或远端的录制对象。

你可以通过如下方法体验本地录制远端音视频功能：

- `CreateMediaRecorder`：创建录制对象。如需同时录制本地和远端的音频，可以多次调用该方法创建多个录制对象。
- `SetMediaRecorderObserver`：设置录制回调对象。
- `StartRecording`：开始录制。
- `StopRecording`：停止录制。
- `DestroyMediaRecorder`：销毁录制对象。

**3. 多端同步**

在实时合唱的场景中，可能会出现网络原因导致各接收端下行链路不一致的情况，该版本新增 `GetNtpWallTimeInMs` 方法获取当前的 NTP (网络时间协议) 时间，用于对齐多个接收端的歌词和音乐，实现合唱同步、歌词进度同步等，为用户提供更佳的协同体验。

#### 改进

**1.优化变声** 

该版本新增了 `SetLocalVoiceFormant` 方法，用于设置共振峰比率以改变语音的音色。该方法还可以和 `SetLocalVoicePitch` 方法一起使用，同时调节音调和音色，实现更多样化的变声效果。


 **2. 提升音频文件类型兼容性（Android）**

该版本提升了音频文件类型兼容性，你可以通过 `StartAudioMixing`[2/2]、`PlayEffect`[3/3]、`Open`、`OpenWithMediaSource` 方法来打开以 `Content://` 开头的 URI 文件。

**3. 优化版权音乐（Android，iOS）**

针对在线 K 歌房场景，改版本新增 `GetCaches` 和 `RemoveCache` 方法，用于获取、删除音乐资源缓存，并新增状态码和错误码，可方便用户排查问题。

**4. 优化跨频道连麦**

该版本新增 `StartOrUpdateChannleMediaRelay` 和 `StartOrUpdateChannleMediaRelayEx` 方法，通过一个方法实现开始跨频道转发和更新转发的目标频道，提升了接口易用性；同时，优化内部交互次数，有效降低调用了延迟。在降低开发难度的同时，为开发者提供更顺畅的使用体验。


**5. 多路音频自采集**

为更好地满足音频自采集的场景需求，该版本新增了 `CreateCustomAudioTrack` 和 `DestroyCustomAudioTrack` 方法用于创建和销毁自定义音频轨道，并提供了两种音频轨道类型供用户选择，进一步提升了自采集音频处理的灵活性和易用性：

- 可混音的音频轨道：支持将多路外部音频源混合发布到同一频道中，适用于多路音频源的自采集场景。
- 非混音的音频轨道：仅支持将一路外部音频源发布到单个频道中，适用于实时低延迟的自采集场景。


#### 问题修复

该版本修复了以下问题：

- 当快速切换身份角色时，观众端听不到声音。
- 偶现耳返开启无效。(Android)
- 调用 `Getdefaultaudiodevice` 后返回值中的 `Type` 字段信息错误。(macOS)
- 偶现回声。(Android)
- 由于 `OnRemoteAudioStateChanged` 回调异常造成客户客户端状态异常。(iOS, Android)。

#### API 变更

**新增**

- `StartOrUpdateChannelMediaRelay`

- `StartOrUpdateChannelMediaRelayEx`

- `GetNtpWallTimeInMs`

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

- `RtcEngineContext` 中新增 `DomainLimit` 和 `AutoRegisterAgoraExtensions` 属性

- `OnRecorderStateChanged`、`OnRecorderInfoUpdated` 中新增 `channelId` 和 `uid` 参数

- `PreloadStatusCode` 中增加 `KPreloadStatusRemoved` (iOS, Android)

- `MusicContentCenterStatusCode` 中增加如下枚举：(iOS, Android)
  - `KMusicContentCenterStatusErrGateway`
  - `KMusicContentCenterStatusErrPermissionAndResource`
  - `KMusicContentCenterStatusErrInternalDataParse`
  - `KMusicContentCenterStatusErrMusicLoading`
  - `KMusicContentCenterStatusErrMusicDecryption`

- `MusicContentCenterConfiguration` 中新增 `maxCacheSize ` (iOS, Android)

**修改**

- `OnMusicChartsResult` 中的 `status` 修改为 `error_code` (iOS, Android)
- `OnMusicCollectionResult` 中的 `status` 修改为 `error_code` (iOS, Android)
- `OnLyricResult` 中的 `status` 修改为 `error_code` (iOS, Android)
- `OnPreLoadEvent `中的 `msg` 修改为 `error_code` (iOS, Android)

**废弃**

- `StartChannelMediaRelay`
- `StartChannelMediaRelayEx`
- `UpdateChannelMediaRelay`
- `UpdateChannelMediaRelayEx`
- `OnChannelMediaRelayEvent`
- `CHANNEL_MEDIA_RELAY_EVENT`

**删除**

- `OnApiCallExecuted`
- `ChannelMediaOptions` 中的 `PublishCustomAudioTrackEnableAec`
- `GetMediaRecorder`
- `AGORA_IID_MEDIA_RECORDER` 
- `StartRecording`、`StopRecording`、`SetMediaRecorderObserver` 中删除 `connection` 参数