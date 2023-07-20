## v4.2.2

该版本于 2023 年 7 月 xx 日发布。

#### 新增特性

1. **通配 Token**

   该版本新增通配 Token。生成 Token 时，在用户 ID 不为 0 的情况下，声网支持你将频道名设为通配符，从而生成可以加入任何频道的通配 Token。在需要频繁切换频道及多频道场景下，使用通配 Token 可以避免 Token 的重复配置，有助于提升开发效率，减少你的 Token 服务端的压力。详见[使用通配 Token](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms)。

   <div class="alert note">声网 4.x SDK 均支持使用通配 Token。</div

2. **预加载频道**

   该版本新增 `preloadChannelByToken [1/2]` 和 `preloadChannelByToken [2/2]` 方法，支持角色为观众的用户在加入频道前预先加载一个或多个频道。该方法调用成功后可以减少观众加入频道的时间，从而缩短观众听到主播首帧音频的耗时，提升观众端的音频体验。

   在同时预加载多个频道时，为避免观众在切换不同频道时需多次申请 Token 从而导致切换频道时间增长，因此声网推荐使用通配 Token 来减少你的业务服务端获取 Token 导致的耗时，进一步加快切换频道的速度，详见[使用通配 Token](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms)。

#### 改进

1. **跨频道连麦优化**

   该版本将跨频道连麦时媒体流转发的目标频道增加至 6 个，在调用 `startOrUpdateChannelMediaRelay` 和 `startOrUpdateChannelMediaRelayEx` 时，你可以指定最多 6 个目标频道。

#### 问题修复

该版本修复了以下问题：

- 加入频道后，偶现本地用户听自己及远端的声音时出现杂音。
- 网络异常导致频道连接断开后，频道连接恢复较慢。

#### API 变更

**新增**

- `preloadChannelByToken [1/2]`
- `preloadChannelByToken [2/2]`
- `updatePreloadChannelToken`


## v4.2.1

该版本于 2023 年 6 月 21 日发布。

#### 改进

该版本改进了网络传输策略，提升了音视频交互的流畅度。

#### 问题修复

该版本修复了以下问题：

- SDK 不兼容部分旧版本 AccessToken 导致无法加入频道。
- 发送端调用 `setAINSMode` 开启 AI 降噪功能后，接收端用户偶现回声。
- 使用媒体播放器播放媒体文件时出现短暂杂音。

# v4.2.0 版

该版本于 2023 年 5 月 23 日发布。

## 升级必看

该版本对部分功能的实现方式进行了优化，请在升级到该版本后更新 app 代码。

**1. 媒体发布选项**

- `AgoraRtcChannelMediaOptions` 中的 `publishCustomAudioTrackEnableAec` 已删除，请改用 `publishCustomAudioTrack`。
- `AgoraRtcChannelMediaOptions` 中的成员 `publishCustomAudioSourceId` 变更为 `publishCustomAudioTrackId`。

**2. 音频录制**

- 删除 `sharedMediaRecorderWithRtcEngine` 方法，可通过该版本新增的 `createMediaRecorder` 方法来创建录制对象。
- 删除 `startRecording` 、`stopRecording`、`setMediaRecorderDelegate` 中的 `connection` 参数。
- 删除 `AgoraMediaRecorder` 类中的 `destroy` 方法，你可直接调用该版本新增的 `destroyMediaRecorder` 方法来销毁录制对象以释放资源。

**3. 虚拟声卡**

自该版本起，SDK 新增对第三方虚拟声卡的支持，你可以将第三方虚拟声卡作为 SDK 的音频输入或输出设备。你可以通过 `stateChanged` 回调来了解当前 SDK 选择的输入输出设备是否为虚拟声卡。


<div class-="alert note">加频道时如果设置 AgoraALD、Soundflower 作为系统的默认输入或输出设备，会造成无声。<div>

**4. 其他兼容性变更**

- `didApiCallExecute` 已删除，请改用相关频道和媒体的事件通知得知 API 的执行结果。
- `startChannelMediaRelay`、`updateChannelMediaRelay`、`startChannelMediaRelayEx` 和 `updateChannelMediaRelayEx` 已废弃，请改用 `startOrUpdateChannelMediaRelay` 和 `startOrUpdateChannelMediaRelayEx`。



## 新增特性

**1. AI 降噪**

该版本新增AI 降噪功能。开启该功能后，SDK 会智能识别和消除背景噪音，无论是在嘈杂的公共场所，还是在需要保持低延迟的实时竞技场景，都能够确保声音传输的清晰度，为用户提供更高质量的音频体验。你可以通过该版本新增的 `setAINSMode` 方法开启 AI 降噪，并根据实际场景，将降噪模式设置为均衡模式、强降噪模式或低延时模式。


**2.本地录制远端音频（Beta）**

该版本新增本地录制远端音频功能。本地用户可以录制远端用户的音频流，便于将来回放、分析或分享，适用于在线教育、企业培训、在线会议等多类场景。为更准确报告录制状态，该版本在 `stateDidChanged` 、`informationDidUpdated` 中新增 `channelId` 和 `uid` 参数，用于表示录制的音频流的具体信息，并新增 createMediaRecorder 方法，用于创建本地或远端的录制对象。

你可以通过如下方法体验本地录制远端音频功能：

- `createMediaRecorder`：创建录制对象。如需同时录制本地和远端的音频，可以多次调用该方法创建多个录制对象。
- `setMediaRecorderDelegate`：设置录制回调对象。
- `startRecording`：开始录制。
- `stopRecording`：停止录制。
- `destroyMediaRecorder`：销毁录制对象。


**3. 多端同步**

在实时合唱的场景中，可能会出现网络原因导致各接收端下行链路不一致的情况，该版本新增 `getNtpWallTimeInMs` 方法获取当前的 NTP (网络时间协议) 时间，用于对齐多个接收端的歌词和音乐，实现合唱同步、歌词进度同步等，为用户提供更佳的协同体验。

## 改进

**1.优化变声**

该版本新增了 `setLocalVoiceFormant` 方法，用于设置共振峰比率以改变语音的音色。该方法还可以和 `setLocalVoicePitch` 方法一起使用，同时调节音调和音色，实现更多样化的变声效果。


**2. 优化跨频道连麦**

该版本新增 `startOrUpdateChannelMediaRelay` 和 `startOrUpdateChannelMediaRelayEx` 方法，通过一个方法实现开始跨频道转发和更新转发的目标频道，提升了接口易用性；同时，优化内部交互次数，有效降低调用了延迟。在降低开发难度的同时，为开发者提供更顺畅的使用体验。



**3. 多路音频自采集**

为更好地满足音频自采集的场景需求，该版本新增了 `createCustomAudioTrack` 和 `destroyCustomAudioTrack` 方法用于创建和销毁自定义音频轨道，并提供了两种音频轨道类型供用户选择，进一步提升了自采集音频处理的灵活性和易用性：

- 可混音的音频轨道：支持将多路外部音频源混合发布到同一频道中，适用于多路音频源的自采集场景。
- 非混音的音频轨道：仅支持将一路外部音频源发布到单个频道中，适用于实时低延迟的自采集场景。


## 问题修复

该版本修复了以下问题：

- 当快速切换身份角色时，观众端听不到声音。
- 调用 `getdefaultaudiodevice` 后返回值中的 `type` 字段信息错误。



## API 变更

**新增**

- `startOrUpdateChannelMediaRelay`

- `startOrUpdateChannelMediaRelayEx`

- `getNtpWallTimeInMs`

- `setAINSMode`

- `createCustomAudioTrack`

- `destroyCustomAudioTrack`

- `createMediaRecorder`

- `destroyMediaRecorder`

- `AudioTrackConfig`

- `AgoraRecorderStreamInfo`

- `AUDIO_AINS_MODE`

- `AgoraAudioTrackType`

- `AgoraApplicationScenarioType`

- `AgoraRtcEngineConfig` 中新增 `domainLimit` 和 `autoRegisterAgoraExtensions` 属性

- `stateDidChanged`、`informationDidUpdated` 中新增 `channelId` 和 `uid` 参数


**废弃**

- `startChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelay`
- `updateChannelMediaRelayEx`
- `didReceiveChannelMediaRelayEvent`
- `AgoraChannelMediaRelayEvent`

**删除**

- `didApiCallExecute`
- `AgoraRtcChannelMediaOptions` 中的 ` publishCustomAudioTrackEnableAec`
- `sharedMediaRecorderWithRtcEngine`
- `AgoraMediaRecorder` 类中的 `destroy`
- `startRecording`、`stopRecording`、`setMediaRecorderDelegate` 中删除 `connection` 参数


## v4.1.1 版

该版本于 2023 年 1 月 xx 日发布。



#### 新增特性

**快速出声**

该版本新增 `enableInstantMediaRendering` 方法，用于开启音频帧的加速渲染模式，可加快用户加入频道后的首帧出声速度。



#### 问题修复

该版本修复了使用媒体播放器播放采样率超过 48 kHz 的音频时，播放失败的问题。



#### API 变更

**新增**

- `enableInstantMediaRendering`
