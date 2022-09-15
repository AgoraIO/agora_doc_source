## v6.0.0-rc.1 版 （对应 Native v4.0.0 版）

该版本于 2022 年 9 月 13 日发布。


#### 升级必看

v6.0.0-rc.1 SDK 包名由 `agora_rtc_ng` 变更为 `agora_rtc_engine`，且对部分功能的实现方式进行了优化，从而导致与 v5.x 不兼容。如下为存在兼容性变更的主要功能：
- 多频道
- 媒体流发布控制
- 自定义视频采集与渲染（Media IO 方式）
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

- 将多组音视频流通过不同的用户 ID（`uid`）发布到远端。
- 将多路音频流混音后通过一个用户 ID（`uid`）发布到远端。
- 将多组视频频流通过不同的用户 ID（`uid`）发布到远端。
- 将多路视频流合图后通过一个用户 ID（`uid`）发布到远端。


**2. 超高清分辨率 （Beta）**

为提升视频互动体验，SDK 对视频采集、编码、解码、渲染全流程做出了优化，自该版本起支持 4K 分辨率。优化了 FEC（Forward Error Correction）算法，可根据视频帧包数与帧率进行自适应切换，降低 4K 场景下的视频卡顿率。
你可以在调用 `setVideoEncoderConfiguration` 时，设置编码分辨率为 4K (3840 × 2160)、帧率为 60 fps。当你的设备不支持 4K 时，SDK 支持自动回退到适合的分辨率和帧率。
该功能对设备性能和网络带宽有一定要求，在不同的平台上支持的上下行帧率也不同，如需体验该功能，请[提交工单](https://agora-ticket.agora.io/)。


**3. 内置媒体播放器**

为减少 SDK 包体积、集成时间，以及简化 API 的调用步骤，该版本支持内置媒体播放器。调用 `createMediaPlayer` 创建媒体播放器后，你可以通过 `MediaPlayer` 类的一系列方法体验内置媒体播放器的各类功能：

- 自动播放本地、在线、自定义的媒体资源。
- 预先加载待播放的媒体资源。
- 根据网络情况切换媒体资源的播放线路。
- 将媒体播放器的音视频流推送到任意频道、分享给远端用户。
- 实时缓存媒体资源文件，该功能开启后，播放器会预先缓存当前正在播放的媒体文件的部分数据到本地，可提高播放流畅度，帮助节省网络流量。


**4. 新版 AI 降噪**

自该版本起，SDK 支持新版 AI 降噪（相对于 agora_rtc_engine: ^5.x 中的基础 AI 降噪）功能。相比原版 AI 降噪，新版 AI 降噪具有更好的人声保真度、更干净的噪声抑制，并新增了去混响（Dereverberation）能力。
如果你希望体验新版 AI 降噪，请联系 [sales@agora.io](mailto:sales@agora.io)。


**5. 超高音质**

为还原音频的细节、提升音频的清晰度，该版本新增 `ultraHighQualityVoice`。在语聊、歌唱等以人声为主的场景中，你可以调用 `setVoiceBeautifierPreset` 并使用该枚举体验超高音质。


**6. 空间音效**

<div class="alert note">空间音效功能当前处于实验阶段，请联系 <a href= "mailto:sales@agora.io">sales@agora.io</a> 开通空间音效功能，如果需要技术支持，请<a href="https://agora-ticket.agora.io/">提交工单</a>。</div>

该版本提供本地直角坐标系计算方案实现空间音效：

- 使用 `LocalSpatialAudioEngine` 类实现空间音效，通过 SDK 计算远端用户的空间坐标。你需要分别调用 `updateSelfPosition` 和 `updateRemotePosition` 更新本地和远端用户的空间坐标，本地用户才能听到远端用户的空间音效。
![](https://web-cdn.agora.io/docs-files/1663038259399)

- 通过 SDK 计算媒体播放器的空间坐标。你需要在 `LocalSpatialAudioEngine` 类中分别调用 `updateSelfPosition` 和 `updatePlayerPositionInfo` 更新本地用户和媒体播放器的空间坐标，本地用户才能听到媒体播放器的空间音效。
![](https://web-cdn.agora.io/docs-files/1663038287220)


**7. 实时合唱**

该版本为实时合唱赋予了如下能力：

- 支持两人及两人以上合唱。
- 每位歌手相互独立。一位歌手出现问题或退出合唱，其他歌手还可以继续合唱。
- 极低延时体验。每位歌手可以实时听到彼此的歌声，观众也可以实时听到每位歌手。

该版本新增 `audioScenarioChorus` 枚举来设置极低延时。使用该枚举后，在网络条件良好的情况下，用户可以体验到极低延时的实时合唱。


**8. 增强的频道管理**

为满足各类业务场景对频道管理的需求，该版本在 `ChannelMediaOptions` 结构体中新增了如下功能：

- 设置或切换多种音视频源的发布
- 设置或切换频道场景、用户角色
- 设置或切换订阅视频的大小流类型
- 控制音频发布时延

在调用 `joinChannel` 或 `joinChannelEx` 时设置 `ChannelMediaOptions`，明确媒体流发布和订阅行为，例如，是否发布摄像头采集或者屏幕共享的视频流，是否要主动订阅远端用户的音视频流。加入频道后，调用 `updateChannelMediaOptions` 随时更新 `ChannelMediaOptions` 中的设置，例如，切换发布的音视频源。


**9. 屏幕共享**

该版本优化了开启屏幕共享的逻辑，你可以根据实际场景选择不同的方式开启屏幕共享。

在 Windows 和 macOS 平台：

- 在加入频道前调用 `startScreenCaptureByDisplayId`，然后调用 `joinChannel` [2/2] 加入频道并设置 `publishScreenTrack` 或 `publishSecondaryScreenTrack` 为 `true`，即可开始屏幕共享。
- 在加入频道后调用 `startScreenCaptureByDisplayId`，然后调用 `updateChannelMediaOptions` 设置 `publishScreenTrack` 或 `publishSecondaryScreenTrack` 为 `true`，即可开始屏幕共享。

在 Android 和 iOS 平台：

- 在加入频道前调用 `startScreenCapture`，然后调用 `joinChannel` [2/2] 加入频道并设置 `publishScreenCaptureVideo` 为 `true`，即可开始屏幕共享。
- 在加入频道后调用 `startScreenCapture`，然后调用 `updateChannelMediaOptions` 设置 `publishScreenCaptureVideo` 为 `true`，即可开始屏幕共享。


**10. 设置音视频流订阅黑/白名单**

该版本新增音视频流订阅黑/白名单功能，支持灵活订阅频道内发流用户的音视频流。你可以通过以下 API 来将指定用户的用户 ID 加入到相应的音视频黑白名单中，从而实现订阅/不订阅指定用户的音频或视频流。在多频道场景下，你可以通 `RtcEngineEx` 类下的同名方法来实现该功能。

- `setSubscribeAudioBlacklist`：设置音频订阅黑名单。
- `setSubscribeAudioWhitelist`：设置音频订阅白名单。
- `setSubscribeVideoBlacklist`：设置视频订阅黑名单。
- `setSubscribeVideoWhitelist`：设置视频订阅白名单。

如果某个用户同时在音频或视频订阅的黑、白名单中，只有黑名单会生效。


**11. 设置音频场景**

为方便用户灵活修改音频场景，该版本新增 `setAudioScenario` 方法，支持你根据业务需求设置音频场景。例如，如果你在频道内想将音频场景从自动场景 （`AudioScenarioDefault`）切换为高音质场景 （`AudioScenarioGameStreaming`），你可以调用该方法。


**12. 设置本地代理**

该本版新增 `setLocalAccessPoint` 方法，用于在成功部署声网混合云、私有化平台后，指定 Local Access Point 来设置本地代理。你可以联系 [sales@agora.io](mailto:sales@agora.io) 了解和部署声网混合云或声网私有化平台。


**13. 垫片推流**

该版本新增垫片推流功能，支持你在发流时使用本地 png 格式的图片来替代当前发布的视频流画面进行推流。你可以通过 `enableVideoImageSource` 来开启该功能，并通过 `options` 参数自定义垫片图片；在你关闭垫片功能之后，远端用户看到的依旧是当前你发布的视频流画面。


**14. 本地合图**

该版本新增本地合图功能，可支持在本地将多路视频流合并为一路视频流。常见场景如下：

在直播场景或使用旁路推流功能时，可以在本地将多个主播的画面合并为一个画面。
将本地采集的多路视频流（例如：摄像头采集的视频、屏幕共享流、视频文件、图片等）合并为一路视频流，然后在频道内发布已合图的视频流。
你可以调用 `startLocalVideoTranscoder` 方法开启本地合图、调用 `stopLocalVideoTranscoder` 方法停止本地合图；在开启本地合图后，可以调用 `updateLocalTranscoderConfiguration` 进行本地合图的配置更新。


**15. 视频设备管理**

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