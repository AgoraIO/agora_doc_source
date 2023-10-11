## v4.2.1 Beta

该版本于 2023 年 8 月 xx 日发布。

#### 升级必看

该版本对部分功能的实现方式进行了优化，请在升级到该版本后更新 app 代码。

**1. 媒体发布选项**

- `ChannelMediaOptions` 中的 `publishCustomAudioTrackEnableAec` 已删除，请改用 `publishCustomAudioTrack`。
- `ChannelMediaOptions` 中的成员 `publishCustomAudioSourceId` 变更为 `publishCustomAudioTrackId`。

**2. 音频录制**

- 删除 `InterfaceIdType` 中的 `agoraIidMediaRecorder`。在创建录制对象前无需再获取 `agoraIidMediaRecorder` 接口类指针，你可以直接调用该版本新增的 `createMediaRecorder` 方法创建录制对象。(Windows)
- 删除 `getMediaRecorder` 方法，可通过该版本新增的 `createMediaRecorder` 方法来创建录制对象。(Android, iOS, macOS)
- 删除 `startRecording` 、`stopRecording`、`setMediaRecorderObserver` 中的 `connection` 参数。
- 删除 `MediaRecorder` 类中的 `release` 方法，你可直接调用该版本新增的 `destroyMediaRecorder` 方法来销毁录制对象以释放资源。

**3. 其他兼容性变更**

- `onApiCallExecuted` 已删除，请改用相关频道和媒体的事件通知得知 API 的执行结果。
- `IAudioFrameObserver` 类名变更为 `IAudioPcmFrameSink`，因此下列方法原型也有相应更新：
    - `onFrame`
    - `MediaPlayer` 下的 `registerAudioFrameObserver` 和 `unregisterAudioFrameObserver`
- `startChannelMediaRelay`、`updateChannelMediaRelay`、`startChannelMediaRelayEx` 和 `updateChannelMediaRelayEx` 已废弃，请改用 `startOrUpdateChannelMediaRelay` 和 `startOrUpdateChannelMediaRelayEx`。


#### 新增特性

**1. AI 降噪**

该版本新增AI 降噪功能。开启该功能后，SDK 会智能识别和消除背景噪音，无论是在嘈杂的公共场所，还是在需要保持低延迟的实时竞技场景，都能够确保声音传输的清晰度，为用户提供更高质量的音频体验。你可以通过该版本新增的 `setAINSMode` 方法开启 AI 降噪，并根据实际场景，将降噪模式设置为均衡模式、强降噪模式或低延时模式。

**2. 本地录制远端音频 (Beta)**

该版本新增本地录制远端音频功能。本地用户可以录制远端用户的音频流，便于将来回放、分析或分享，适用于在线教育、企业培训、在线会议等多类场景。为更准确报告录制状态，该版本在 `onRecorderStateChanged`、`onRecorderInfoUpdated` 中新增 `channelId` 和 `uid` 参数，用于表示录制的音频流的具体信息，并新增 `createMediaRecorder` 方法，用于创建本地或远端的录制对象。

你可以通过如下方法体验本地录制远端音频功能：

- `createMediaRecorder`：创建录制对象。如需同时录制本地和远端的音频，可以多次调用该方法创建多个录制对象。
- `setMediaRecorderObserver`：设置录制回调对象。
- `startRecording`：开始录制。
- `stopRecording`：停止录制。
- `destroyMediaRecorder`：销毁录制对象。

**3. 多端同步**

在实时合唱的场景中，可能会出现网络原因导致各接收端下行链路不一致的情况，该版本新增 `getNtpWallTimeInMs` 方法获取当前的 NTP (网络时间协议) 时间，用于对齐多个接收端的歌词和音乐，实现合唱同步、歌词进度同步等，为用户提供更佳的协同体验。

**4. 快速出声**

该版本新增 `enableInstantMediaRendering` 方法，用于开启音频帧的加速渲染模式，可加快用户加入频道后的首帧出声速度。

#### 改进

**1. 优化变声**

该版本新增了 `setLocalVoiceFormant` 方法，用于设置共振峰比率以改变语音的音色。该方法还可以和 `setLocalVoicePitch` 方法一起使用，同时调节音调和音色，实现更多样化的变声效果。

**2. 提升音频文件类型兼容性 (Android)**

该版本提升了音频文件类型兼容性，你可以通过 `startAudioMixing`、`playEffect`、`openWithMediaSource` 方法来打开以 `content://` 开头的 URI 文件。

**3. 优化版权音乐 (Android, iOS)**

针对在线 K 歌房场景，改版本新增 `getCaches` 和 `removeCache` 方法，用于获取、删除音乐资源缓存，并新增状态码和错误码，可方便用户排查问题。

**4. 优化跨频道连麦**

该版本新增 `startOrUpdateChannelMediaRelay` 和 `startOrUpdateChannelMediaRelayEx` 方法，通过一个方法实现开始跨频道转发和更新转发的目标频道，提升了接口易用性；同时，优化内部交互次数，有效降低调用了延迟。在降低开发难度的同时，为开发者提供更顺畅的使用体验。

**5. 多路音频自采集**

为更好地满足音频自采集的场景需求，该版本新增了 `createCustomAudioTrack` 和 `destroyCustomAudioTrack` 方法用于创建和销毁自定义音频轨道，并提供了两种音频轨道类型供用户选择，进一步提升了自采集音频处理的灵活性和易用性：

- 可混音的音频轨道：支持将多路外部音频源混合发布到同一频道中，适用于多路音频源的自采集场景。
- 非混音的音频轨道：仅支持将一路外部音频源发布到单个频道中，适用于实时低延迟的自采集场景。

其他改进
该版本改进了网络传输策略，提升了音频交互的流畅度。


#### 问题修复

该版本修复了以下问题：

- 加入或退出频道时，安卓设备端偶现的崩溃。(Android)
- 当快速切换身份角色时，观众端听不到声音。
- 偶现耳返开启无效。(Android)
- 偶现回声。(Android)
- 由于 `onRemoteAudioStateChanged` 回调异常造成客户端状态异常。(iOS, Android)
- 使用媒体播放器播放采样率超过 48 kHz 的音频时，播放失败。
- 合唱模式下，OPPO R11 设备外放加入频道后，对端听到明显杂声和回音。(Android)
- 本地音乐文件结束播放时，未能触发 `onAudioMixingFinished` 回调。(Android)
- 客户端主动退出频道时未向服务端发起请求，导致服务端判定为退出频道超时。
- SDK 不兼容部分旧版本 AccessToken 导致无法加入频道。
- 发送端调用 `setAINSMode` 开启 AI 降噪功能后，接收端用户偶现回声。
- 使用媒体播放器播放媒体文件时出现短暂杂音。
- 调用 `destroyMediaPlayer` 销毁媒体播放器时偶现崩溃。（iOS）



#### API 变更

**新增**

- `startOrUpdateChannelMediaRelay`
- `startOrUpdateChannelMediaRelayEx`
- `getNtpWallTimeInMs`
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
- `RtcEngineContext` 中新增 `domainLimit` 和 `autoRegisterAgoraExtensions` 属性
- `onRecorderStateChanged`、`onRecorderInfoUpdated` 中新增 `channelId` 和 `uid` 参数
- `PreloadStatusCode` 中增加 `kPreloadStatusRemoved` (Android, iOS)
- `MusicContentCenterStatusCode` 中增加如下枚举 (Android, iOS)：
    - `kMusicContentCenterStatusErrGateway`
    - `kMusicContentCenterStatusErrPermissionAndResource`
    - `kMusicContentCenterStatusErrInternalDataParse`
    - `kMusicContentCenterStatusErrMusicLoading`
    - `kMusicContentCenterStatusErrMusicDecryption`
- `MusicContentCenterConfiguration` 中新增 `maxCacheSize` (Android, iOS)
- `enableInstantMediaRendering`

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

- `onApiCallExecuted`
- `ChannelMediaOptions` 中的 `publishCustomAudioTrackEnableAec`
- `getMediaRecorder`
- `MediaRecorder` 类中的 `release`
- `InterfaceIdType` 中的 `agoraIidMediaRecorder` (Windows)
- `startRecording`、`stopRecording`、`setMediaRecorderObserver` 中删除 `connection` 参数
