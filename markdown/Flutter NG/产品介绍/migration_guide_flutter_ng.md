# 迁移指南

agora_rtc_engine: ^6.0.0 是基于 Agora SDK v4.0.0 是一个新的 SDK 版本，可帮助用户将实时音视频功能集成到 app 中。在大规模的实时互动场景下，你可以用它实现更好的实时互动效果，详见[产品概述](./product_live_ng#benefits)。

本文介绍如何将 SDK 从 agora_rtc_engine: ^5.x 迁移至 agora_rtc_engine: ^6.0.0。


## 迁移步骤

本节介绍将 agora_rtc_engine: ^5.x 迁移至 agora_rtc_engine: ^6.0.0 的主要步骤。

### 1. 集成 SDK

参考[建立项目](./start_live_flutter_ng#创建-flutter-项目)，将 agora_rtc_engine: ^6.0.0 SDK 集成到你的项目中。

### 2. 更新 app 代码

agora_rtc_engine: ^6.0.0 SDK 对部分功能的实现方式进行了优化或修改，从而导致与 agora_rtc_engine: ^5.x 不兼容。为了继续使用 app 中已有的 Agora 功能，请根据[变更介绍](#changes)更新 app 中的代码。


<a name="changes"></a>

## 变更介绍

本节以 agora_rtc_engine: ^5.x 为基础，按如下分类介绍 agora_rtc_engine: ^6.0.0 相对于 agora_rtc_engine: ^5.x 的主要变更，你需要结合实际业务场景更新 app 代码：

- 中断性变更：介绍影响较大的 API 兼容性变更，修改相关实现代码的预期耗时较多。
- 行为变更：介绍对 SDK 默认行为和 API 行为的合理优化造成的变更，无需修改相关实现代码或修改代码的预期耗时较少。
- 功能差距：介绍在 agora_rtc_engine: ^5.x 中支持、但在 agora_rtc_engine: ^6.0.0 中不支持的功能，这些功能会在后续版本中增加。
- 已删除 API：介绍在 agora_rtc_engine: ^5.x 中支持或被标记成废弃、但在 agora_rtc_engine: ^6.0.0 中删除了的 API，这些 API 大部分在 agora_rtc_engine: ^6.0.0 中有替代方案，修改相关实现代码的预期耗时较少。
- 命名和数据类型变更：介绍主要 API 的命名和数据类型变更，你可以借助 IDE 的报错提示更新相关实现代码，预期耗时较少。


### 中断性变更

#### 升级前版本为 agora_rtc_engine: ^5.x

从 agora_rtc_engine: ^5.x 升级至 agora_rtc_engine: ^6.0.0 后，实现部分功能的 API 存在差异。本节介绍这些 API 的兼容性变更及 app 代码的更新逻辑。

**命名参数**

为了更好的代码可读性，agora_rtc_engine: ^6.0.0 后将所有参数多于 2 个的方法的参数改成了[命名参数](https://dart.dev/guides/language/language-tour#parameters)，如 `joinChannel` 方法：

```dart
await _engine.joinChannel(token: '', channelId: 'channelid', uid: 0, options: const ChannelMediaOptions());
```

**初始化流程**

agora_rtc_engine: ^6.0.0 后提供了 top-level 方法 `createAgoraRtcEngine` 用于创建 RtcEngine，创建完 RtcEngine 后需要主动调用 `initialize` 进行初始化。

**渲染控件**

agora_rtc_engine: ^6.0.0 后移除了 [SurfaceView](https://docs.agora.io/cn/video-legacy/API%20Reference/flutter/v5.3.0/API/class_rtc_local_view_surfaceview.html)/[TextureView](https://docs.agora.io/cn/video-legacy/API%20Reference/flutter/v5.3.0/API/class_rtc_local_view_textureview.html) 控件，视频渲染统一使用 [AgoraVideoView](./API%20Reference/flutter_ng/API/rtc_interface_class.html#class_agoravideoview) 控件。

**多频道**

在 agora_rtc_engine: ^5.x 中，SDK 提供 `RtcChannel` 类和 `RtcChannelEventHandler` 类实现多频道控制，支持订阅多个频道的音视频流，但只能选择一个频道发布一组音视频流。

在 agora_rtc_engine: ^6.0.0 中：

- SDK 支持同时采集或同时发布多组音视频流。例如，同时发布多路摄像头采集或者屏幕共享的视频流。
- SDK 提供 `RtcEngineEx` 类实现多频道功能：调用 `joinChannel` 加入首个频道后，多次调用 `joinChannelEx` 加入多个频道，通过不同的用户 ID（`localUid`）和 `ChannelMediaOptions` 设置发布指定的流到不同的频道。
- 新增了 `RtcConnection `二元组表示 `joinChannel` 建立的连接，一个连接由频道名（`channelId`）和 `localUid` 确定。你可以通过 `RtcConnection` 控制不同连接的发布和订阅。所有带 `connection`参数（对应 `RtcConnection` 类）的 API 命名中都增加了 Ex 以区分，并统一放在 `RtcEngineEx` 类中，用于多流的扩展。

通过设置 `ChannelMediaOptions`，agora_rtc_engine: ^6.0.0 支持一个 `RtcEngine` 实例同时采集多路音视频源并发布到远端，适应各种业务场景。例如：

- 同时发布多路摄像头采集的视频流或者多路屏幕共享流
- 同时发布单路媒体播放器的视频流、屏幕共享流和摄像头采集的视频流
- 同时发布单路麦克风采集、自采集的音频流和媒体播放器的音频流

结合多频道能力，你还可以体验如下功能：

- 将多组音视频流通过不同的 `localUid` 发布到远端
- 将多路音频流混音后通过一个 `localUid` 发布到远端
- 将多路视频流合图后通过一个 `localUid` 发布到远端

agora_rtc_engine: ^5.x 的 `RtcChannel` 和 `RtcEngine` 在功能上有部分重复、不够正交，因此在 agora_rtc_engine: ^6.0.0 中隐藏了 `RtcChannel` 类和 `RtcChannelEventHandler` 类。你可以参考 [join_multiple_channel.dart](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/tree/main/example/lib/examples/advanced/join_multiple_channel) 示例项目，用 `joinChannel` 和 `ChannelMediaOptions` 替代 `RtcChannel`，预计迁移成本在一天以内。如果你需要继续使用 `RtcChannel` 和 `RtcChannelEventHandler` 类，请提交工单[联系技术支持](https://agora-ticket.agora.io/)，Agora 会根据反馈情况决定是否在后续版本中保持兼容。

**媒体流发布控制**

在 agora_rtc_engine: ^6.0.0 中，将更多频道相关的设置都汇聚进了 `ChannelMediaOptions`，包括不同音视频流的发布、自动订阅、用户角色切换、Token 更新、默认大小流选项等。你可以在加入频道时通过 `joinChannel` 或 `joinChannelEx` 明确媒体流发布和订阅行为，也可以在加入频道后通过 `updateChannelMediaOptions` 动态更新频道中的媒体选项，例如切换视频源。

**警告码**

在 agora_rtc_engine: ^5.x 中，SDK 通过 `warning` 回调报告警告码。

为方便用户定位和排查问题，agora_rtc_engine: ^6.0.0 通过 API 返回值或不同状态回调来报告问题和原因。例如：

- `onConnectionStateChanged`：报告网络连接状态。
- `onLocalAudioStateChanged`：报告本地音频状态。
- `onLocalVideoStateChanged`：报告本地视频状态。
- `onRemoteAudioStateChanged`：报告远端音频状态。
- `onRemoteVideoStateChanged`：报告远端视频状态。

因此，agora_rtc_engine: ^6.0.0 删除了 `warning` 回调。


#### 升级前版本为 agora_rtc_engine: ^6.0.0-beta.2

除上述相对于 agora_rtc_engine: ^5.x 的中断性变更以外，agora_rtc_engine: ^6.0.0 相对于 agora_rtc_engine: ^6.0.0-beta.2 也存在极少数中断性变更。例如：

- 将 `ChannelMediaOptions` 中的 `publishAudioTrack` 替换为 `publishMicrophoneTrack`。
- 移除 `joinChannelWithOptions` 方法。
- `joinChannel` 方法移除 `info` 参数，新增 `options` 参数，详见 [`joinChannel`](./API%20Reference/flutter_ng/API/toc_core_method.html?platform=Flutter#api_irtcengine_joinchannel2) 方法。

如果你在 agora_rtc_engine: ^6.0.0-beta.2 版本中使用了该功能、并且希望升级到 agora_rtc_engine: ^6.0.0 版本，请在升级 SDK 后修改功能的实现。


### 行为变更

本节介绍由 agora_rtc_engine: ^6.0.0 对 SDK 默认行为和 API 行为的合理优化造成的变更。

#### 频道场景

因为直播场景支持从一对一通话无缝切换到多人互动，所以 Agora 自 agora_rtc_engine: ^5.x 起将通信场景下内部的传输协议和弱网对抗能力改成与直播场景一致。在 agora_rtc_engine: ^6.0.0 中，Agora 也将默认的频道场景改成了 `ChannelProfileLiveBroadcasting`（直播）。

#### 网络质量回调

在 agora_rtc_engine: ^5.x 中，如果 `onNetworkQuality` 中的 `uid` 为 0，则该回调返回的是本地用户的网络质量。在 agora_rtc_engine: ^6.0.0 中，该回调返回的本地用户 `uid` 和用户在频道内实际的 `uid` 相同。

#### 默认日志文件

在 agora_rtc_engine: ^5.x 中，有多个日志文件时，旧的文件会以 agorasdk_x.log 格式命名，例如 agorasdk_1.log。agora_rtc_engine: ^6.0.0 修改命名格式为 agorasdk.x.log（例如 agorasdk.1.log）。此外，agora_rtc_engine: ^6.0.0 新增了 agoraapi.log 记录 API 调用的日志。

#### 快速切换频道

在 agora_rtc_engine: ^5.x 中，你需要调用 `switchChannel` 实现快速切换频道。

在 agora_rtc_engine: ^6.0.0 中，通过 `leaveChannel` 和 `joinChannel` 切换频道即可实现和 `switchChannel` 一样的切换速度，因此该版本删除了 `switchChannel`。如果你在 agora_rtc_engine: ^5.x 中使用 `switchChannel` 切换频道，你需要在 agora_rtc_engine: ^6.0.0 中先调用 `leaveChannel` 离开当前频道，再调用 `joinChannel` 加入第二个频道。

#### (Windows) 本地音视频流录制

- 在 agora_rtc_engine: ^5.x 中，如需开启本地音视频流录制，需要调用 `MediaRecorder.getMediaRecorder` 方法先获取 MediaRecorder 对象。
- 在 agora_rtc_engine: ^6.0.0 中，如需开启本地音视频流录制，需要调用 `RtcEngine.getMediaRecorder` 方法获取获取 MediaRecorder 接口类。

#### 虚拟节拍器

当你调用 `startRhythmPlayer` 时，SDK 默认将虚拟节拍器的声音发布到远端，如果你不希望远端用户听到虚拟节拍器，需参考以下操作：

- 在 agora_rtc_engine: ^5.x 中，调用  `configRhythmPlayer` 并将 `publish` 设置为 `false`。
- 在 agora_rtc_engine: ^6.0.0 中，将 `ChannelMediaOptions` 中的 `publishRhythmPlayerTrack` 设置为 `false`。

#### 音量提示

当你调用 `enableAudioVolumeIndication` 方法并将 `interval` 参数设置为 >0 时，可启用用户音量提示。在 agora_rtc_engine: ^5.x 和 agora_rtc_engine: ^6.0.0 中，`interval` 参数的定义存在差异：

- 在 agora_rtc_engine: ^5.x 中：建议设置到大于 200 毫秒。最小不得少于 10 毫秒，否则会收不到 `onAudioVolumeIndication` 回调。
- 在 agora_rtc_engine: ^6.0.0 中：该参数需要设为 200 的整数倍。如果取值低于 200，SDK 会自动调整为 200。

当启用音量提示回调后，SDK 会上报 `onAudioVolumeIndication` 回调，如果本地用户将自己静音（调用了 `muteLocalAudioStream`），在 agora_rtc_engine: ^5.x 和 agora_rtc_engine: ^6.0.0 中，SDK 的行为不一致：

- 在 agora_rtc_engine: ^5.x 中：SDK 立即停止报告本地用户的音量提示回调。
- 在 agora_rtc_engine: ^6.0.0 中：SDK 会继续报告本地用户的音量提示回调。

#### 设备权限

在 agora_rtc_engine: ^5.x 中，通过 `localAudioStateChanged` 中的`AudioLocalError.DeviceNoPermission` 上报没有权限启动音频采集设备；通过 `localAudioStateChanged` 中的 `LocalVideoStreamError.DeviceNoPermission` 上报没有权限启动视频采集设备。

在 agora_rtc_engine: ^6.0.0 中，统一通过 `onPermissionError` 回调上报音视频采集设备的权限状态。

#### 通话前网络测试

如果你需要开启或停止网络连接质量测试：

- 在 agora_rtc_engine: ^5.x 中，你可以调用 `enableLastmileTest` 开启网络质量测试，如果你想停止网络测试，需要调用 `disableLastmileTest`。
- 在 agora_rtc_engine: ^6.0.0 中，你可以调用 `startLastmileProbeTest` 启用网络质量测试，如果你想停止网络测试，需要调用 `stopLastmileProbeTest`。


### 功能差距

本节介绍在 agora_rtc_engine: ^5.x 中支持、但在 agora_rtc_engine: ^6.0.0 中不支持或行为不一致的功能，这些功能会在后续版本中支持或改为一致。

#### 音频应用场景

agora_rtc_engine: ^6.0.0 重构了音频应用场景，可以替代大部分 agora_rtc_engine: ^5.x 的音频应用场景。下表展示了两个版本中音频应用场景的对应关系：

| agora_rtc_engine: ^5.x   | agora_rtc_engine: ^6.0.0           |
| :---------- | :-------- |
| `AudioScenario.Default`                | `AudioScenarioType.audioScenarioDefault`        |
| `AudioScenario.ChatRoomEntertainment` | `AudioScenarioType.audioScenarioChatroom`       |
| `AudioScenario.Education`  | `AudioScenarioType.audioScenarioDefault`        |
| `AudioScenario.GameStreaming`         | `AudioScenarioType.audioScenarioGameStreaming` |
| `AudioScenario.ShowRoom`               | `AudioScenarioType.audioScenarioDefault`        |
| `AudioScenario.ChatRoomGaming`        | `AudioScenarioType.audioScenarioChatroom`       |
| `AudioScenario.IOT`                    | `AudioScenarioType.audioScenarioDefault`        |
| `AudioScenario.MEETING`                | `AudioScenarioType.audioScenarioMeeting`        |

#### 不支持功能

相比于 agora_rtc_engine: ^5.x，某些功能在 agora_rtc_engine: ^6.0.0 中不支持或仅支持部分。本节展示尚未支持的 API，这些 API 会在后续版本中支持。

远端视频流回退：

- `setRemoteUserPriority`

屏幕共享：

- `onScreenCaptureInfoUpdated`

### 已删除 API

agora_rtc_engine: ^6.0.0 中，删除了已废弃或不推荐使用的 API。已删除 API 的替代方案或删除原因展示如下：

- `virtualBackgroundSourceEnabled`：使用 `enableVirtualBackground` 的返回值替代。
- `userSuperResolutionEnabled`：使用 `remoteVideoStats` 回调的 `superResolutionType` 成员替代。
- `setAudioMixingPlaybackSpeed`：使用 `MediaPlayerController` 类下的相关 API 替代。
- `setExternalAudioSourceVolume`：使用 `adjustCustomAudioPublishVolume` 替代。
- `getAudioFileInfo` 和 `requestAudioFileInfo`：使用 `getDuration` 替代。
- `audioDeviceTestVolumeIndication`：由 `onAudioVolumeIndication` 替代。
- `setLocalPublishFallbackOption` 和 `localPublishFallbackToAudioOnly`：在 agora_rtc_engine: ^5.x 中很少使用。
- `VideoRenderMode` 中的 `FILL(4)`：该模式可能造成图片过度拉伸，不推荐使用。
- `AudioMixingReason` 中的以下枚举：在 agora_rtc_engine: ^5.x 中应用场景很少。
  - `StartedByUser`
  - `StartNewLoop`
  - `PausedByUser`
  - `ResumedByUser`
- `audioMixingFinished`: 使用 `onAudioMixingStateChanged` 替代。
- `enableDeepLearningDenoise`：AI 降噪将在后续版本改由 SDK 控制，不通过 API 实现。
- `takeSnapshot` 和 `onSnapshotTaken` 中的 `channel` 参数：冗余参数。
- `setDefaultMuteAllRemoteVideoStreams`：由 `ChannelMediaOptions` 中的 `autoSubscribeVideo` 替代。
- `setDefaultMuteAllRemoteAudioStreams`：由 `ChannelMediaOptions` 中的 `autoSubscribeAudio` 替代。
- `LocalVideoStreamError` 中的 `LocalVideoStreamErrorScreenCaptureWindowNotSupported`：该枚举在 agora_rtc_engine: ^5.x 已废弃。
- `startAudioMixing` 中的 `replace` 参数：由 `ChannelMediaOptions` 中的 `publishMicrophoneTrack` 替代。

### 命名变更

agora_rtc_engine: ^6.0.0 的方法命名和数据类型变更会在你编译项目时引入 IDE 的报错提示，你需要根据提示更新 app 代码。

主要的 API 及参数名变更如下：

- (Windows 和 macOS) `adjustLoopbackRecordingSignalVolume` 变更为 `adjustLoopbackSignalVolume`。
- `firstLocalAudioFrame` 变更为 `onFirstLocalAudioFramePublished`。
- `LogConfig` 中的 `fileSize` 成员变更为 `fileSizeInKB`。
- `enableAudioVolumeIndication` 中的 `report_vad` 参数变更为 `reportVad`。