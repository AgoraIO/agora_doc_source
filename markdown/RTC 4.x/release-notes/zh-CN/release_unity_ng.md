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

2. **视频观测器**

`IVideoFrameObserver` 类中删除了下列方法：

- `GetVideoFormatPreference`：请改用 `RegisterVideoFrameObserver` 新增的 `formatPreference` 参数。
- `GetObservedFramePosition`：请改用 `RegisterVideoFrameObserver` 新增的 `position` 参数。

3. **媒体附属信息**

该版本删除了 `IMetadataObserver` 类下的 `GetMaxMetadataSize` 和 `OnReadyToSendMetadata` ，请改用该版本新增的 `SetMaxMetadataSize` 和 `SendMetadata`。

4. **版权音乐**

该版本废弃了 `IMusicContentCenter` 类下的 `Preload [1/2]` 方法并新增 `Preload [2/2]` 方法。

### 新增特性

1. **通配 Token**

   该版本新增通配 Token。生成 Token 时，在用户 ID 不为 0 的情况下，声网支持你将频道名设为通配符，从而生成可以加入任何频道的通配 Token。在需要频繁切换频道及多频道场景下，使用通配 Token 可以避免 Token 的重复配置，有助于提升开发效率，减少你的 Token 服务端的压力。详见[使用通配 Token](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms)。

   <div class="alert info">声网 4.x SDK 均支持使用通配 Token。</div>

2. **预加载频道**

   该版本新增 `PreloadChannel[1/2]` 和 `PreloadChannel[2/2]` 方法，支持角色为观众的用户在加入频道前预先加载一个或多个频道。该方法调用成功后可以减少观众加入频道的时间，从而缩短观众听到主播首帧音频提升观众端的音频体验。

   在同时预加载多个频道时，为避免观众在切换不同频道时需多次申请 Token 从而导致切换频道时间增长，因此声网推荐使用通配 Token 来减少你的业务服务端获取 Token 导致的耗时，进一步加快切换频道的速度，详见[使用通配 Token](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms)。

3. **自定义视频画布背景颜色**

   该版本在 `VideoCanvas` 中增加了 `backgroundColor` 成员，支持你在设置本地或远端视频显示属性时，自定义视频画布的背景颜色。

4. **发布多源采集的视频流** (Windows, macOS)

   该版本在 `ChannelMediaOptions` 中新增下列成员，支持你发布第三个、第四个摄像头和屏幕采集到的视频流：

   - `publishThirdCameraTrack`：发布第三个摄像头采集的视频。
   - `publishFourthCameraTrack`：发布第四个摄像头采集的视频。
   - `publishThirdScreenTrack`：发布第三个屏幕采集的视频。
   - `publishFourthScreenTrack`：发布第四个屏幕采集的视频。

   **注：** 目前 SDK 支持在同一时间、同一 `RtcConnection` 中发布多路音频流、一路视频流。

5. **支持仅播放副歌片段** (Android, iOS)

   该版本新增 `GetInternalSongCode` 方法，如果你仅需要播放某一音乐资源的副歌片段，在播放前你需要调用该方法来为该副歌片段创建一个内部歌曲编号，作为该资源的唯一标识。你可以查看[在线 K 歌房文档](https://docportal.shengwang.cn/cn/online-ktv/landing-page?platform=Android)了解更多 K 歌场景方案。

### 改进

1. **摄像头采集效果提升** (Android, iOS)

   该版本从以下几个方面提升了摄像头采集效果：

   1. 支持摄像头采集曝光调节

      新增 `IsCameraExposureSupported` 和 `SetCameraExposureFactor` 方法，用于查询当前设备是否支持曝光调节和设置摄像头的曝光增益。

   2. 优化默认摄像头选择 (iOS)

      自该版本起，SDK 的默认摄像头选择对齐 iOS 系统相机行为。如果设备拥有多个后置摄像头，则在视频采集时可以获得更好的拍摄视野、变焦能力、低光性能和深度感应，从而提高视频采集的质量。

2. **虚拟背景算法升级**

   该版本升级了虚拟背景的人像分割算法，全面提升了人像分割的准确度、人像边缘与虚拟背景间的平滑度以及人物移动时边缘的贴合度，同时优化了虚拟背景在会议、办公、居家等场景下，以及逆光、弱光等条件下的人物边缘精度。

3. **跨频道连麦优化**

   该版本将跨频道连麦时媒体流转发的目标频道增加至 6 个，在调用 `StartOrUpdateChannelMediaRelay` 和 `StartOrUpdateChannelMediaRelayEx` 时，你可以指定最多 6 个目标频道。

4. **视频编解码查询能力增强**

   为提升设备编解码能力查询功能，该版本在 `CodecCapInfo` 中新增 `codecLevels` 成员。当成功调用 `QueryCodecCapability` 后，可通过 `codecLevels` 得知当前设备对于 H.264 和 H.265 格式的视频的硬件和软件解码能力等级。

该版本还进行了如下改进：

1. 为了提升多种音频路由之间的切换体验，该版本新增了 `SetRouteInCommunicationMode` 方法，用于在通话音量模式 ([`MODE_IN_COMMUNICATION`](https://developer.android.google.cn/reference/kotlin/android/media/AudioManager?hl=en#mode_in_communication)) 下，将音频路由从蓝牙耳机切换为听筒、有线耳机或扬声器。 (Android)
2. 在屏幕共享场景下，SDK 根据共享的场景自动调节发送端的帧率。尤其是在共享文档场景下，避免发送端的视频码率超出预期的情况，以提高传输效率、减小网络负担。
3. 为帮助用户了解更多类型的远端视频状态改变的原因，`OnRemoteVideoStateChanged` 回调中新增了 `REMOTE_VIDEO_STATE_REASON_CODEC_NOT_SUPPORT` 枚举，表示本地的视频解码器不支持对收到的远端视频流进行解码。
4. 版权音乐新增 `GetSongSimpleInfo` 方法，可用于获取某一指定歌曲的详细信息，你可以通过触发的 `OnSongSimpleInfoResult` 回调来获取歌曲信息。 (Android, iOS)

### 问题修复

该版本修复了以下问题：

- 加入频道后，偶现本地用户听自己及远端的声音时出现杂音。 (macOS)
- 网络异常导致频道连接断开后，频道连接恢复较慢。
- 在屏幕共享场景下，部分机型偶现屏幕共享画面出图延迟高于预期。
- 自采集场景下，`SetBeautyEffectOptions`、`SetLowlightEnhanceOptions`、`SetVideoDenoiserOptions` 和 `SetColorEnhanceOptions` 无法自动加载插件。
- 多设备音频录制场景下，反复插拔或开启/禁用音频录制设备后，偶现调用 `StartRecordingDeviceTest` 进行音频采集设备测试时听不到声音。 (Windows)

### API 变更

**新增**

- `SetCameraExposureFactor` (Android, iOS)
- `IsCameraExposureSupported` (Android, iOS)
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
- `ChannelMediaOptions` 中增加下列成员 (Windows, macOS)：
  - `publishThirdCameraTrack`
  - `publishFourthCameraTrack`
  - `publishThirdScreenTrack`
  - `publishFourthScreenTrack`
- `CodecCapLevels`
- `VIDEO_CODEC_CAPABILITY_LEVEL`
- `VideoCanvas` 中增加 `backgroundColor` 成员
- `CodecCapInfo` 中增加 `codecLevels` 成员
- `REMOTE_VIDEO_STATE_REASON` 中增加 `REMOTE_VIDEO_STATE_REASON_CODEC_NOT_SUPPORT` 枚举
- `SetMaxMetadataSize`
- `SendMetadata`
- `RegisterAudioFrameObserver` 新增 `position` 参数
- `RegisterVideoFrameObserver` 新增 `formatPreference` 和 `position` 参数

**废弃**

- `Preload [1/2]` (Android, iOS)

**删除**

- `GetObservedAudioFramePosition`
- `GetPlaybackAudioParams`
- `GetRecordAudioParams`
- `GetMixedAudioParams`
- `GetEarMonitoringAudioParams`
- `GetVideoFormatPreference`
- `GetObservedFramePosition`
- `GetMaxMetadataSize`
- `OnReadyToSendMetadata`