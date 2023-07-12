## v4.2.2

该版本于 2023 年 7 月 xx 日发布。

### 升级必看

该版本对部分功能的实现方式进行了优化，请在升级到该版本后更新 app 代码。

1. **音频观测器**

`IAudioFrameObserver` 类中删除了下列方法：

- `GetObservedAudioFramePosition`：请改用 `RegisterAudioFrameObserver` 中新增的 `position` 参数。
- `GetPlaybackAudioParams`：请改用 `SetPlaybackAudioFrameParameters`。
- `GetRecordAudioParams`：请改用 `SetRecordingAudioFrameParameters`
- `GetMixedAudioParams`：请改用 `SetMixedAudioFrameParameters`。
- `GetEarMonitoringAudioParams`：请改用 `SetEarMonitoringAudioFrameParameters`。

2. **媒体附属信息**

该版本删除了 `IMetadataObserver` 类下的 `GetMaxMetadataSize` 和 `OnReadyToSendMetadata` ，请改用该版本新增的 `SetMaxMetadataSize` 和 `SendMetadata`。

3. **版权音乐**

该版本废弃了 `IMusicContentCenter` 类下的 `Preload [1/2]` 方法并新增 `Preload [2/2]` 方法。

### 新增特性

1. **通配 Token**

   该版本新增通配 Token。生成 Token 时，在用户 ID 不为 0 的情况下，声网支持你将频道名设为通配符，从而生成可以加入任何频道的通配 Token。在需要频繁切换频道及多频道场景下，使用通配 Token 可以避免 Token 的重复配置，有助于提升开发效率，减少你的 Token 服务端的压力。详见[使用通配 Token](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms)。

   <div class="alert info">声网 4.x SDK 均支持使用通配 Token。</div>

2. **预加载频道**

   该版本新增 `PreloadChannel[1/2]` 和 `PreloadChannel[2/2]` 方法，支持角色为观众的用户在加入频道前预先加载一个或多个频道。该方法调用成功后可以减少观众加入频道的时间，从而缩短观众听到主播首帧音频以及看到首帧画面的耗时，提升观众端的音视频体验。

   在同时预加载多个频道时，为避免观众在切换不同频道时需多次申请 Token 从而导致切换频道时间增长，因此声网推荐使用通配 Token 来减少你的业务服务端获取 Token 导致的耗时，进一步加快切换频道的速度，详见[使用通配 Token](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms)。

3. **支持仅播放副歌片段** (Android, iOS)

   该版本新增 `GetInternalSongCode` 方法，如果你仅需要播放某一音乐资源的副歌片段，在播放前你需要调用该方法来为该副歌片段创建一个内部歌曲编号，作为该资源的唯一标识。你可以查看[在线 K 歌房文档](https://docportal.shengwang.cn/cn/online-ktv/landing-page?platform=Android)了解更多 K 歌场景方案。


### 改进

**跨频道连麦优化**

该版本将跨频道连麦时媒体流转发的目标频道增加至 6 个，在调用 `StartOrUpdateChannelMediaRelay` 和 `StartOrUpdateChannelMediaRelayEx` 时，你可以指定最多 6 个目标频道。

该版本还进行了如下改进：

1. 为了提升多种音频路由之间的切换体验，该版本新增了 `SetRouteInCommunicationMode` 方法，用于在通话音量模式 ([`MODE_IN_COMMUNICATION`](https://developer.android.google.cn/reference/kotlin/android/media/AudioManager?hl=en#mode_in_communication)) 下，将音频路由从蓝牙耳机切换为听筒、有线耳机或扬声器。 (Android)
2. 版权音乐新增 `GetSongSimpleInfo` 方法，可用于获取某一指定歌曲的详细信息，你可以通过触发的 `OnSongSimpleInfoResult` 回调来获取歌曲信息。 (Android, iOS)

### 问题修复

该版本修复了以下问题：

- 加入频道后，偶现本地用户听自己及远端的声音时出现杂音。 (macOS)
- 网络异常导致频道连接断开后，频道连接恢复较慢。
- 多设备音频录制场景下，反复插拔或开启/禁用音频录制设备后，偶现调用 `StartRecordingDeviceTest` 进行音频采集设备测试时听不到声音。 (Windows)

### API 变更

**新增**

- `PreloadChannel[1/2]`
- `PreloadChannel[2/2]`
- `UpdatePreloadChannelToken`
- `GetSongSimpleInfo` (Android, iOS)
- `OnSongSimpleInfoResult` (Android, iOS)
- `GetInternalSongCode` (Android, iOS)
- `Preload [2/2]` (Android, iOS)
- `OnLyricResult` 中增加 `songCode` (Android, iOS)
- `OnPreLoadEvent` 中增加 `requestId` (Android, iOS)
- `SetRouteInCommunicationMode` (Android)
- `SetMaxMetadataSize`
- `SendMetadata`
- `RegisterAudioFrameObserver` 新增 `position` 参数

**废弃**

- `Preload [1/2]` (Android, iOS)

**删除**

- `GetObservedAudioFramePosition`
- `GetPlaybackAudioParams`
- `GetRecordAudioParams`
- `GetMixedAudioParams`
- `GetEarMonitoringAudioParams`
- `GetMaxMetadataSize`
- `OnReadyToSendMetadata`