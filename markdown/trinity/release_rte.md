---
title: 发版说明
platform: All Platforms
updatedAt: 2020-11-30 07:57:44
---
本页提供 Agora 下一代 RTC SDK 的发版说明。

## v3.xx

该版本于 2020 年 9 月 24 日发布。

**功能亮点**

#### 1. 加强频道管理

- 支持多次进入相同频道（用 connection id 标示，用于发送多流进入相同频道）。
- 支持进入不同频道用于订阅不同频道的流。
- 增加频道媒体选项。

#### 2. 支持多路媒体流

- 支持发布多条外部视频流进入“相同”/“不同”频道 ，包括 摄像头采集，屏幕采集和自渲染。
- 支持发布多路外部音频PCM 流进入“相同”/“不同”的频道 ，包括麦克风和自采集。
- 支持多路音频流自动混音。

#### 3. 其他功能

- 支持 `CHANNEL_PROFILE_COMMUNICATION_1v1`，优化了在 1v1 场景上的延迟，卡顿。
- 支持 `CHANNEL_PROFILE_CLOUD_GAMING`, 适合云游戏场景，端到端延迟低至 20ms。
- Android 支持 Texture 自采集，自渲染。
- Android 支持 EGL renderer，支持全链路硬件处理优化，包括硬件采集，编解码，渲染，旋转处理和大幅优化 CPU。

**新增特性**

#### 1. 音效

为方便用户在通话中添加音效，该版本新增如下 API。

预加载音效：

- `preloadEffect`: 将音效文件预加载至内存。
- `unloadEffect`: 从内存释放指定的预加载音效文件。
- `unloadAllEffects`: 从内存释放所有预加载音效文件。

管理播放状态：

- `playEffect`: 播放指定音效文件。你可以设置是否将音频发布到远端，让本地和远端用户都可听到音效。
- `playAllEffects`: 播放所有音效文件。你可以设置是否将音频发布到远端，让本地和远端用户都可听到音效。
- `pauseEffect`: 暂停播放指定音效文件。
- `pauseAllEffects`: 暂停播放所有音效文件。
- `resumeEffect`: 恢复播放指定音效文件。
- `resumeAllEffects`: 恢复播放所有音效文件。
- `stopEffect`: 停止播放指定音效文件。
- `stopAllEffects`: 停止播放所有音效文件。

管理播放音量：

- `getVolumeOfEffect`: 获取指定音效文件的播放音量。
- `setVolumeOfEffect`: 设置指定音效文件的播放音量。
- `getEffectsVolume`: 获取所有音效文件的播放音量。
- `setEffectsVolume`: 获取所有音效文件的播放音量。

#### 2. 设置区域访问限制

该版本支持在初始化 `RtcEngine` 时通过 `areaCode` 成员指定 Agora 服务器的访问区域。该功能为高级功能，适用于有访问安全限制的场景。目前支持的区域有中国大陆、北美、欧洲、亚洲（中国大陆除外）和全球（默认）。

#### 3. 视频质量透明

为方便开发者了解本地和远端的视频质量和状态，该版本新增如下 API：

- `onLocalVideoStats`: 通话中，每 2 秒报告一次本地用户视频流的质量信息，如编码和发送时的码率、帧率和分辨率。
- `onRemoteVideoStats`: 通话中，每 2 秒报告一次接收到的远端视频流的质量信息，如视频码率、丢包率和卡顿时长。
- `onLocalVideoStateChanged`: 本地视频状态改变回调。状态为 `FAILED(3)` 时，请根据错误码排查问题。
- `onRemoteVideoStateChanged`: 远端视频状态改变回调。

#### 4. 发送和接收媒体附属信息

为满足多样化的直播互动需求，如支持主播向观众发放购物链接、电子优惠券和在线测试题，该版本新增支持发送和接收媒体附属信息 (metadata)。你需要自行实现 `IMetadataObserver` 并注册 metadata 观测器。

#### 5. 数据流

该版本新增以下 API，支持使用数据流：

- `createDataStream`: 创建数据流。
- `sendStreamMessage`: 发送数据流。Agora SDK 对发送数据流消息有以下限制：
    - 消息频率：每秒最多可以发送 60 条消息。
    - 消息大小：每条消息不能超过 1 KB。
    - 消息吞吐量：每秒最多可以发送 30 KB 大小的消息。
- `onStreamMessage`: 接收到对方数据流回调。
- `onStreamMessageError`: 接收对方数据流发生错误回调。

#### 6. 设置日志输出等级

该版本新增 `setLogLevel` 方法，支持设置 SDK 输出日志的等级：

- `LOG_LEVEL_NONE (0x0000)`: 不输出任何日志。
- `LOG_LEVEL_INFO (0x0001)`: （推荐值）输出 INFO 等级的日志。
- `LOG_LEVEL_WARN (0x0002)`: 输出 WARN 等级的日志。
- `LOG_LEVEL_ERROR (0x0004)`: 输出 ERROR 等级的日志。
- `LOG_LEVEL_FATAL (0x0008)`: 输出 FATAL 等级的日志。

#### 7. 自定义数据上报

该版本支持自定义数据上报。如需试用，请联系 sales@agora.io 开通并商定自定义数据格式。

#### 8. 视频原始数据（Android）

为方便开发者拿到视频裸数据，该版本新增 `registerVideoFrameObserver` 方法供你注册视频观测器，成功注册后，你可以从 `onCaptureVideoFrame` 中拿到本地采集到的视频裸数据，也可以从 `onRenderVideoFrame` 中拿到接收到的远端用户的视频裸数据。


**改进**

#### 自定义视频源（Android）

该版本优化了 Android 平台的自定义视频源功能。通过 `setExternalVideoSource` 设置自定义视频源后，你可以通过 `pushExternalVideoFrame` 将视频帧推送给 SDK。

该版本提供两个同名的 `pushExternalVideoFrame`，一个使用 `VideoFrame`，一个使用 `AgoraVideoFrame`。如果你想让 SDK 更好地发挥设备的硬件性能，Agora 推荐你使用带 `VideoFrame` 的 `pushExternalVideoFrame` 方法。

**变更**

#### 音频编码属性

该版本废弃原来的 `setAudioProfile` 方法并新增同名的方法。自该版本起，Agora 推荐你通过如下方式设置音频编码属性：

- 创建 `RtcEngine` 时设置音频 `scenario`。
- 调用新的 `setAudioProfile` 方法设置音频 `profile`。

该版本对音频 `scenario` 和 `profile` 进行如下优化：

- `scenario`: 新增 `AUDIO_SCENARIO_HIGH_DEFINITION(6)` 类型，代表高音质场景。Agora 推荐你在 `AUDIO_SCENARIO_DEFAULT(0)`、`AUDIO_SCENARIO_GAME_STREAMING(3)` 和 `AUDIO_SCENARIO_HIGH_DEFINITION(6)` 三种类型中选择一种使用。
- `profile`: 该版本调整了一些 profile 使用的编码码率最大值。

    |profile|旧版本码率 (Kbps)| 当前版本码率 (Kbps)|
    |------|-------|--------|
    |`DEFAULT(0)`|52（直播场景）| 64（直播场景）|
    |`MUSIC_STANDARD(2)`|48|64|
    |`MUSIC_STANDARD_STEREO(3)`|64|80|
    |`MUSIC_HIGH_QUALITY(4)`|128|96|
    |`MUSIC_HIGH_QUALITY_STEREO(5)`|192|128|

**已知问题**

- VQC 算法的问题：当前策略为帧率优先，不能画质优先，因此，在相同弱网下，画质可能不如主版。
- 弱网多人场景的问题：
    - 缺乏端到端反馈，卡顿率高于主版。
    - 观众端没有默认 1s 延迟，导致弱网下卡顿较大。遇到该问题时请联系我们处理。

**相关链接**

- [Android 迁移指南](https://confluence.agoralab.co/pages/viewpage.action?pageId=681270968)
- [iOS 迁移指南](https://confluence.agoralab.co/display/ADC/iOS)
- [API Sample 示例项目](https://github.com/AgoraIO/API-Examples/tree/2.7.1_fury)
- [内部发版说明](https://confluence.agoralab.co/display/MS/2.7.1+release+note)

## v3.0.225

该版本于 2020 年 7 月 24 日发布。

优化和问题修复如下：
- 优化了压测下 SDK 的稳定性。
- 修复了 iOS 平台上加入频道较慢的问题。

## v3.0.0.23

该版本于 2020 年 7 月 3 日发布。

该版本修复了频道外占用通话音量的问题。

## v3.0.0.22

该版本于 2020 年 6 月 30 日发布。

**新增特性**

#### 自定义音频采集

为方便你自行采集并处理音频数据，该版本新增 `setExternalAudioSource` 方法允许你开启自定义音频源功能并设置外部音频源的参数。你需要在加入频道前调用该方法。处理完音频数据后，你可以通过 `pushExternalAudioFrame` 方法将音视频数据发送回 SDK，以进行后续操作。

#### 原始音频数据

为方便你自行处理音频数据，该版本新增如下接口允许你在编码后和解码前获取并修改原始音频数据：

- `registerAudioFrameObserver`：注册音频观测器。
- `setRecordingAudioFrameParameters`：设置 `onRecordAudioFrame` 报告的音频数据格式。
- `setPlaybackAudioFrameParameters`：设置 `onPlaybackAudioFrame` 报告的音频数据格式。
- `setMixedAudioFrameParameters`：设置 `onMixedAudioFrame` 报告的音频数据格式。
- `setPlaybackAudioFrameBeforeMixingParameters`：设置 `onPlaybackAudioFrameBeforeMixing` 报告的音频数据格式。
- `onRecordAudioFrame`：获取本地用户的原始音频数据。
- `onPlaybackAudioFrame`：获取所有远端用户的原始音频数据。
- `onMixedAudioFrame`：获取本地用户和所有远端用户的原始音频数据。
- `onPlaybackAudioFrameBeforeMixing`：获取特定远端用户的原始音频数据。

你需要在加入频道前调用 `registerAudioFrameObserver` 方法注册音频观测器，并在该方法中实现 `IAudioFrameObserver` 类。注册成功后，SDK 每隔 10 毫秒触发 `onRecordAudioFrame`、`onPlaybackAudioFrame`、`onMixedAudioFrame` 或 `onPlaybackAudioFrameBeforeMixing` 回调。你可以从回调中获取原始音频数据，并根据场景自行处理音频数据。处理完成后，你可以直接播放音频或将音频数据发送回 SDK 以进行后续操作。

<div class="alert note">如果你想修改从回调中获取到的原始音频数据格式，请调用 setRecordingAudioFrameParameters、setPlaybackAudioFrameParameters、setMixedAudioFrameParameters 或 setPlaybackAudioFrameBeforeMixingParameters 方法。</div>

#### 音量管理

该版本新增支持调节本地录音音量和背景音乐的播放音量：

- `adjustRecordingSignalVolume`：调节本地录音音量。
- `adjustAudioMixingPlayoutVolume`：调节音乐文件的本地播放音量。
- `adjustAudioMixingPublishVolume`：调节音乐文件的远端播放音量。

你也可以通过如下方法获取背景音乐在本地和远端的音量：

- `getAudioMixingPlayoutVolume`：获取音乐文件的本地播放音量。
- `getAudioMixingPublishVolume`：获取音乐文件的远端播放音量。

**问题修复**

该版本修复了用户离开频道后，SDK 音频模块未关闭的问题。

## v3.0.0.21

该版本于 2020 年 6 月 5 日发布。主要改进和修复问题如下：

- 优化了 SDK 在 iOS 平台上的 CPU 占用率。对比上一个版本，该版本 CPU 占用减少了 19%。
- 新增支持 Android x64 架构。
- 修复了特定场景下音频路由无法从外放切换到听筒的问题。


## v3.0.0.20

该版本于 2020 年 5 月 8 日发布。

该版本主要针对语聊房场景，提供完整的音频管理方法。具体涵盖的功能及对应 API 详见下文。

**实现功能**

该版本实现了如下功能，且使用逻辑与官网 SDK 完全一致。

#### 频道管理

初始化 RtcEngine 后，你可以通过调用 joinChannel 方法创建并加入频道；通话结束后，调用 leaveChannel 可以离开频道。 在整个 RtcEngine 生命周期内，你都可以通过 getConnectionState 方法获取当前的频道连接状态。

#### 本地发布/远端订阅音频控制

在互动过程中，该版本支持通过如下方法对音频进行更为精细的控制：

- muteLocalAudioStream：停止/继续发送本地音频流
- muteRemoteAudioStream：停止/继续接收指定的远端音频流
- muteAllRemoteAudioStreams：停止/继续接收所有远端音频流

#### 音频状态管理

提供如下回调，方便用户在音频异常时，通过这些回调了解当前的音频状态，及产生异常的原因：

- onFirstLocalAudioFramePublished: 本地音频首帧成功发布回调
- onLocalAudioStateChanged：本地音频状态发生改变回调
- onRemoteAudioStateChanged：远端音频状态发生改变回调

#### 音量检测

为方便了解频道中谁在说话，以及说话人的音量，该版本提供 enableAudioVolumeIndication 方法。通过该方法开启音量检测后，SDK 会在 onAudioVolumeIndication 回调中报告当前频道中音量最高的几个用户，及其音量信息。

#### 音频质量统计

提供 onLocalAudioStats 和 onRemoteAudioStats 回调。在成功加入频道后，SDK 会每两秒触发一次这两个回调，实时报告当前的统计数据。

#### 网络质量统计

提供 onRtcStats 和 onNetworkQuality，方便实时了解当前的网络质量。

#### 音频路由

音频路由是指 app 在播放音频时使用的设备通道。该版本提供如下方法设置音频路由：

- setDefaultAudioRoutetoSpeakerphone：设置默认的音频路由
- setEnableSpeakerphone：暂态启用或禁用扬声器

#### 变声及混响

在社交娱乐应用中，为增加产品的趣味性和互动性，用户常常需要变声和混响效果。该版本通过 setLocalVoiceChanger 和 setLocalVoiceReverbPreset 方法，提供预置的 18 种变声和 16 种混响效果选项。

#### 耳返

通过如下方法，支持耳返功能：

- enableInEarMonitoring：启用耳返功能。该版本还提供一个重载的方法，含有 includeAudioFilter 参数，你可以通过该参数设置耳返中是否应用混音音效。
- setInEarMonitoringVolume：设置耳返音量

#### 音乐文件播放及混响

在实时音视频互动中，用户除了自己说话的声音，有时候需要播放自定义的声音让频道内的其他人也听到。比如连麦合唱场景中，需要播放背景音乐。该版本通过如下方法，提供完整的音乐文件播放与混音功能，帮助你实现更为丰富的场景：

- startAudioMixing：开始播放音乐文件
- stopAudioMixing：停止播放音乐文件
- pauseAudioMixing：暂停播放音乐文件
- resumeAudioMixing：恢复播放音乐文件
- adjustAudioMixingVolume：调节音乐文件播放音量
- getAudioMixingDuration：获取音乐文件的播放进度
- getAudioMixingCurrentPosition：获取音乐文件的播放进度
- setAudioMixingPosition：设置音乐文件的播放位置

在音乐文件播放与混音的过程中，你都可以从 onAudioMixingStateChanged 回调中了解当前音乐播放的状态。

#### 通话前网络测试

在加入频道或切换角色前，进行网络质量探测，可以判断或预测用户当前的网络状况是否良好。

该版本通过 startLastmileProbeTest 方法，支持在加入频道前，对 last-mile 网络质量进行探测。成功启用网络探测后，SDK 会触发 onLastmileProbeResult 回调，报告当前网络质量。

**改进**

除上述功能外，该版本还引进了一些新的方法，或对原有方法的逻辑进行了优化。

#### 频道媒体选项（新增类）

为方便开发者对频道进行更精细的控制，该版本提供了一个重载的 joinChannel 方法，其中包含一个 ChannelMediaOptions 类。在加入频道前，你可以使用该类进行如下默认设置：

- 频道场景
- 本地用户的角色类型
- 发布哪个音、视频轨道<sup>1</sup>
- 是否自动订阅远端流

加入频道以后，你还可以通过 `updateChannelMediaOptions` 方法，动态调整 `ChannelMediaOptions` 类中的设置。

<div class="note alert"><sup>1</sup>：一路流中可以包含多个音频轨道。通过将各音频轨道发布选项设为 true，用户可以同时发布外部采集的 PCM 和麦克风采集的音频轨道。</div>

#### 多频道（新增类）

为方便用户同时加入多个频道，该版本通过 `RtcEngineEx` 和 `IRtcEngineEventHandlerEx` 类，并通过 Connection ID 来标记频道。

你可以调用 `RtcEngineEx` 类中的 `joinChannelEx` 方法，然后设置其中的 `Connection` 参数来实现加入多个频道。加入多个频道后，用户可以同时发布多路视频流和音频流。

#### mute 逻辑（行为优化）

针对老引擎中 `mute` 和 `muteAll` 方法“双锁”逻辑带来的集成问题，该版本对这两个方法的实现进行了优化。

在该版本中，`muteAll` 和 `mute` 方法互不依赖。无论当前设置如何，`muteAll` 都会对当前所有用户，和即将加入频道的用户（如有）生效；`mute` 都会对指定用户生效。

#### 音频路由切换原则（行为优化）

由于设备的音频路由会受用户行为和操作系统制约，实际使用中，音频路由可能会和预期不符。针对这个问题，该版本对音频路由切换的原则进行了优化。

#### 其他改进

- 音频 3A 算法。在直播场景下，该版本应用 3A（回声消除、噪声抑制、自动增益） 算法，优化音频体验。
- Android 平台的平均延迟大幅减少 100 ms。
- Android 平台的耳反减少 100 ms。
- Android 平台减少内存。

## v2.6.3.4

该版本于 2020 年 7 月 31 日发布。

新增特性和问题修复如下：
- 新增支持 Windows 平台上耳麦动态插拔。
- 修复了 Windows 和 Android 平台上的一些 crash，提高了 SDK 稳定性。
- 修复了 iOS 和 macOS 平台上 bundle ID 重复问题。
- 修复了 iOS 平台上 MediaPlayer Kit 播放视频模糊问题。
- 修复了 iOS 平台上少量内存泄漏问题。


## v2.6.3.2

该版本于 2020 年 6 月 12 日发布。该版本修复了如下问题：

- 偶现的开始或停止发布流时，麦克风采集的音量为 0 的问题。
- SDK 初始化影响其他 app 音频播放音量的问题。
- 采用临时方案尝试解决麦克风初始化失败的问题。
- 其他偶现的崩溃问题。

## v2.6.3.1

该版本于 2020 年 5 月 13 日发布。

**支持功能** 

- 为对互动场景进行更有针对性的优化，该版本梳理了 Agora  的频道场景：
	- 增加 CHANNEL_PROFILE_COMMUNICATION_1v1 为 1 v 1 场景优化。
	- 默认 CHANNEL_PROFILE_LIVE_BROADCASTING 作为多人视频场景 。
- 优化了 Android 平台多频道相关 API。
- 提供 registerAudioFrameObserver 方法，支持从当前所有频道中获取 PCM 格式的音频数据。
- iOS 版本支持提升到 9.0。

**改进**

- 优化了观众端的出图速度。
- 优化了连麦 PK 场景下，观众快速切换频道的速度。
- 优化了弱网对抗策略，可以增加有效编码码率约 5%。
- 优化了发送 PCM 音频原始数据场景下的的 CPU 消耗。


**问题修复**
- 修复偶现的崩溃，提升了 SDK 整体的稳定性。
- 修复了特定场景下在使用 registerVideoEncodedImageReceiver 接口接受 H264 编码的数据时， SDK 和其他版本的互通问题。
- 修复了在使用 registerVideoEncodedImageReceiver 场景下，进入频道后，无法订阅远端用户的问题。
- 修复了云录制的黑屏问题。
- 修复了 Windows 平台上，没有麦克风情况下初始化失败的问题。