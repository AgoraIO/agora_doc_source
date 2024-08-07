声网 SDK v4.0.0 是一个新的 SDK 版本，可帮助用户将实时音视频功能集成到 app 中。在大规模的实时互动场景下，你可以用它实现更好的实时互动效果，详见[产品概述](./product_live_framework_ng?platform=React%20Native)。

本文介绍如何将 SDK 从 v3.x（指 v3.7.0 以及之前版本）升级至 v4.0.0。

## 迁移步骤

本节介绍将 SDK 从 v3.x 升级至 v4.0.0 的主要步骤。

### 1. 集成 SDK

参考[建立项目](./start_live_react_native_ng?platform=React%20Native#创建项目)，将 v4.0.0 SDK 集成到你的项目中。

### 2. 更新 app 代码

v4.0.0 SDK 对部分功能的实现方式进行了重构，从而导致与 v3.x 不兼容。为了继续使用 app 中已有的声网功能，请根据[变更介绍](./migration_guide_rn_ng?platform=React%20Native#变更介绍)更新 app 中的代码。


## 变更介绍

本节以 v3.7.0 为基础，按如下分类介绍 v4.0.0 相对于 v3.7.0 的主要变更，你需要结合实际业务场景更新 app 代码：

- 中断性变更：介绍影响较大的 API 兼容性变更，修改相关实现代码的预期耗时较多。
- 行为变更：介绍对 SDK 默认行为和 API 行为的合理优化造成的变更，无需修改相关实现代码或修改代码的预期耗时较少。
- 功能差距：介绍在 v3.7.0 中支持、但在 v4.0.0 中不支持的功能，这些功能会在后续版本中增加。
- 已删除 API：介绍在 v3.7.0 中支持、但在 v4.0.0 中删除了的 API，这些 API 大部分在 v4.0.0 中有替代方案，修改相关实现代码的预期耗时较少。
- 命名和数据类型变更：介绍主要 API 的命名和数据类型变更，你可以借助 IDE 的报错提示更新相关实现代码，预期耗时较少。

### 中断性变更 (3.x → 4.0.0)

从 v3.7.0 升级至 v4.0.0 后，实现部分功能的 API 存在差异。本节介绍这些 API 的兼容性变更及 app 代码的更新逻辑。

#### 初始化引擎

在 v3.7.0 中，你可以使用 `create` 或 `createWithContext` 方法创建并初始化 `RtcEngine` 实例。

在 v4.0.0 中，你可以使用 `createAgoraRtcEngine `方法来获取 `IRtcEngine`，然后通过 `initialize` 方法来初始化引擎。

#### 注册事件监听 

以 `onError` 为例：

在 v3.7.0 中，你可以使用 `addListener` 方法注册事件监听。

```typescript
this.engine.addListener('Error', (errorCode) => {});
```

在 v4.0.0 中，你可以使用 `registerEventHandler` 或 `addListener` 方法注册事件监听。

```typescript
this.engine.registerEventHandler({
  onError(err: ErrorCodeType, msg: string) {},
});
this.engine.addListener('onError', (err: ErrorCodeType, msg: string) => {});
```

#### 多频道

在 v3.7.0 中，SDK 提供 `RtcChannel` 类和 `RtcChannelEvents` 类实现多频道控制，支持订阅多个频道的音视频流，但只能选择一个频道发布一组音视频流。

在 v4.0.0 中：

- SDK 支持同时采集或同时发布多组音视频流。例如，同时发布多路摄像头采集或者屏幕共享的视频流。
- SDK 提供 `IRtcEngineEx` 类实现多频道功能：调用 `joinChannel` 加入首个频道后，多次调用 `joinChannelEx` 加入多个频道，通过不同的用户 ID（`localUid`）和 `ChannelMediaOptions` 设置发布指定的流到不同的频道。
- 新增了 `RtcConnection `二元类表示 `joinChannel` 建立的连接，一个连接由频道名（`channelId`）和 `localUid` 确定。你可以通过 `RtcConnection` 控制不同连接的发布和订阅。所有带 `connection`参数（对应 `RtcConnection` 类）的 API 命名中都增加了 Ex 以区分，并统一放在 `IRtcEngineEx` 类中，用于多流的扩展。

通过设置 `ChannelMediaOptions`，v4.0.0 支持一个 `IRtcEngine` 实例同时采集多路音视频源并发布到远端，适应各种业务场景。例如：

- 同时发布多路摄像头采集的视频流或者多路屏幕共享流
- 同时发布单路媒体播放器的视频流、屏幕共享流和摄像头采集的视频流
- 同时发布单路麦克风采集、自采集的音频流和媒体播放器的音频流

结合多频道能力，你还可以体验如下功能：

- 将多组音视频流通过不同的 `localUid` 发布到远端
- 将多路音频流混音后通过一个 `localUid` 发布到远端

v3.7.0 的 `RtcChannel` 和 `IRtcEngine` 在功能上有部分重复、不够正交，因此在 v4.0.0 中隐藏了 `RtcChannel` 类和 `RtcChannelEvents` 类。你可以参考 [JoinMultiChannel](https://github.com/AgoraIO-Extensions/react-native-agora/blob/main/example/src/examples/advanced/JoinMultipleChannel/JoinMultipleChannel.tsx) 示例项目，用 `joinChannelEx` 和 `ChannelMediaOptions` 替代 `RtcChannel`，预计迁移成本在一天以内。如果你需要继续使用 `RtcChannel` 和 `RtcChannelEvents` 类，请[提交工单](https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms)联系技术支持，声网会根据反馈情况决定是否在后续版本中保持兼容。

#### 媒体流发布控制

在 v4.0.0 中，将更多频道相关的设置都汇聚进了 `ChannelMediaOptions`，包括不同音视频流的发布、自动订阅、用户角色切换、Token 更新、默认大小流选项等。你可以在加入频道时通过 `joinChannel` 或 `joinChannelEx` 明确媒体流发布和订阅行为，也可以在加入频道后通过 `updateChannelMediaOptions` 动态更新频道中的媒体选项，例如切换视频源。

#### 错误码与警告码

在 v3.7.0 中，SDK 通过 `Warning` 事件报告警告码。

为方便用户定位和排查问题，v4.0.0 通过 API 返回值或不同状态回调来报告问题和原因。例如：

- `onConnectionStateChanged`：报告网络连接状态。
- `onLocalAudioStateChanged`：报告本地音频状态。
- `onLocalVideoStateChanged`：报告本地视频状态。
- `onRemoteAudioStateChanged`：报告远端音频状态。
- `onRemoteVideoStateChanged`：报告远端视频状态。

因此，v4.0.0 删除了 `Warning` 事件。


### 中断性变更 (4.0.0 Beta → 4.0.0)

本节介绍 v4.0.0 Beta 升级至 v4.0.0 后存在的中断性变更。

#### SDK 包名变更

从 v4.0.0 Beta 升级至 v4.0.0 后，SDK 包名由 `react-native-agora` 变更为 `react-native-agora`，详见 [集成 SDK](./start_live_react_native_ng?platform=React%20Native#集成-sdk)。

#### 加入频道

在 v4.0.0 Beta 中，你可以使用 `joinChannel` 或 `joinChannelWithOptions` 方法加入频道。

```typescript
this._engine?.joinChannel(token: string, channelId: string, info: string, uid: number): number;
this._engine?.joinChannelWithOptions(token: string, channelId: string, uid: number, options: ChannelMediaOptions): number;
```

v4.0.0 移除了原 `joinChannel` 方法，原 `joinChannelWithOptions` 在 v4.0.0 中更名为 `joinChannel`。

```typescript
this._engine?.joinChannel(
 token: string,
 channelId: string,
 uid: number,
 options: ChannelMediaOptions
): number;
```

此外，`ChannelMediaOptions` 枚举中的 `publishAudioTrack` 替换为 `publishMicrophoneTrack`。如果你在 v4.0.0 Beta 版本中使用了该功能、并且希望升级到 v4.0.0 版本，请在升级 SDK 后修改功能的实现。

### 行为变更

本节介绍由 v4.0.0 对 SDK 默认行为和 API 行为的合理优化造成的变更。

#### 频道场景

在 v3.7.0 中，默认的频道场景为 `ChannelProfileCommunication`（通信）。

因为直播场景支持从一对一通话无缝切换到多人互动，所以声网自 v3.0.0 起将通信场景下内部的传输协议和弱网对抗能力改成与直播场景一致。在 v4.0.0 中，声网也将默认的频道场景改成了 `ChannelProfileLiveBroadcasting`（直播）。

#### 网络质量回调

在 v3.7.0 中，如果 `onNetworkQuality` 中的 `uid` 为 0，则该回调返回的是本地用户的网络质量。 在 v4.0.0 中，该回调返回的本地用户 `uid` 和用户在频道内实际的 `uid` 相同。

#### 默认日志文件

在 v3.7.0 中，有多个日志文件时，旧的文件会以 agorasdk_x.log 格式命名，例如 agorasdk_1.log。v4.0.0 修改命名格式为 agorasdk.x.log（例如 agorasdk.1.log）。此外，v4.0.0 新增了 agoraapi.log 记录 API 调用的日志。

#### 快速切换频道

在 v3.7.0 中，你需要调用 `switchChannel` 实现快速切换频道。

在 v4.0.0 中，通过 `leaveChannel` 和 `joinChannel` 切换频道即可实现和 `switchChannel` 一样的切换速度，因此该版本删除了 `switchChannel`。如果你在 v3.7.0 中使用 `switchChannel` 切换频道，你需要在 v4.0.0 中先调用 `leaveChannel` 离开当前频道，再调用 `joinChannel` 加入第二个频道。

#### 声网自研插件

v4.0.0 在 v4.0.0 Beta 的基础上新增了自动加载自研动态库功能。自该版本起，当你使用声网自研的插件时，不需要在项目中手动集成动态库，SDK 会在 `IRtcEngine` 初始化阶段自动加载动态库。你可以直接调用插件对应的方法即可开启该功能。

| API                                                          | 插件类型     |
| :----------------------------------------------------------- | :----------- |
| enableVirtualBackground                                      | 虚拟背景插件 |
| <li>setBeautyEffectOption<li>ssetVideoDenoiserOptions<li>setLowlightEnhanceOptions<li>setColorEnhanceOptions | 视频增强插件 |
| enableRemoteSuperResolution                                  | 超分辨率插件 |
| <li>setAudioEffectPreset<li>setVoiceBeautifierPreset<li>setVoiceConversionPreset | 美声插件     |
| enableSpatialAudio                                           | 空间音效插件 |
| enableContentInspect                                         | 内容审核插件 |


**本地音视频流录制**

- 在 v3.7.0 中，如需开启本地音视频流录制，需要调用 `startRecording `方法。
- 在 v 4.0.0 中，如需开启本地音视频流录制，需要调用 `getMediaRecorder` 方法获取获取 `IMediaRecorder` 接口类。

**虚拟节拍器**

当你调用 `startRhythmPlayer` 时，SDK 默认将虚拟节拍器的声音发布到远端，如果你不希望远端用户听到虚拟节拍器，需参考以下操作：

- 在 v3.7.0 中，调用  `configRhythmPlayer` 并将 `publish` 设置为 `false`。
- 在 v4.0.0 中，将 `ChannelMediaOptions` 中的 `publishRhythmPlayerTrack` 设置为 `false`。

#### 音量提示

当你调用 `enableAudioVolumeIndication` 方法并将 `interval` 参数设置为 >0 时，可启用用户音量提示。在 v3.7.0 和 v4.0.0 中，`interval` 参数的定义存在差异：

- 在 v3.7.0 中：建议设置到大于 200 毫秒。最小不得少于 10 毫秒，否则会收不到 `onAudioVolumeIndication` 回调。
- 在 v4.0.0 中：该参数需要设为 200 的整数倍。如果取值低于 200，SDK 会自动调整为 200。

当启用音量提示回调后，SDK 会上报 `onAudioVolumeIndication` 回调，如果本地用户将自己静音（调用了 `muteLocalAudioStream`），在 v3.7.0 和 v4.0.0 中，SDK 的行为不一致：

- 在 v3.7.0 中：SDK 立即停止报告本地用户的音量提示回调。
- 在 v4.0.0 中：SDK 会继续报告本地用户的音量提示回调。

#### 设备权限

- 在 v3.7.0 中，通过 `LocalAudioStateChanged` 事件中的 `AudioLocalError.DeviceNoPermission `上报没有权限启动音频采集设备；通过 `LocalVideoStateChanged` 事件中的 `LocalVideoStreamError. `上报没有权限启动视频采集设备。
- 在 v4.0.0 中，统一通过 `onPermissionError `回调上报音视频采集设备的权限状态。

**通话前网络测试**

如果你需要开启或停止网络连接质量测试：

在 v3.7.0 中，你可以调用 `enableLastmileTest` 开启网络质量测试，如果你想停止网络测试，需要调用 `disableLastmileTest`。 

在 v4.0.0 中，你可以调用 `startLastmileProbeTest `启用网络质量测试，如果你想停止网络测试，需要调用 `stopLastmileProbeTest`。


#### 远端媒体事件触发机制

假设存在以下两种场景：

- 场景一：主播在频道外调用 `muteLocalAudioStream` 或 `muteLocalVideoStream` 改变本地音视频流的发布状态、然后加入频道。
- 场景二：主播在频道内调用 `muteLocalAudioStream` 或 `muteLocalVideoStream` 改变本地音视频流的发布状态，然后其他用户加入频道。

v3.7.0 和 v4.0.0 SDK 中存在以下行为差异：

- 在 v3.7.0 中，本地用户会收到 `remoteAudioStateChangedOfUid` 或 `remoteVideoStateChangedOfUid` 回调，报告远端主播的音视频流的状态变化。
- 在 v4.0.0 中，本地用户不会收到 `remoteAudioStateChangedOfUid` 或 `remoteVideoStateChangedOfUid` 回调，但是会收到 `didAudioMuted` 或 `didVideoMuted` 回调，报告远端主播的发流状态变化（即是否正在发布音视频流）。

**功能差距**

本节介绍在 v3.7.0 中支持、但在 v4.0.0 中不支持或行为不一致的功能，这些功能会在后续版本中支持或改为一致。

#### 音频应用场景

v4.0.0 重构了音频应用场景，可以替代大部分 v3.7.0 的音频应用场景。下表展示了两个版本中音频应用场景的对应关系：

| v3.7.0                               | v4.0.0                       |
| :----------------------------------- | :--------------------------- |
| `AudioScenarioDefault`               | `AudioScenarioDefault`       |
| `AudioScenarioChatroomEntertainment` | `AudioScenarioChatroom`      |
| `AudioScenarioEducation`             | `AudioScenarioDefault`       |
| `AudioScenarioGameStreaming`         | `AudioScenarioGameStreaming` |
| `AudioScenarioShowroom`              | `AudioScenarioDefault`       |
| `AudioScenarioChatroomGaming`        | `AudioScenarioChatroom`      |
| `AudioScenarioIot`                   | `AudioScenarioDefault`       |
| `AudioScenarioMeeting`               | `AudioScenarioMeeting`       |

### 已删除 API

v4.0.0 中，删除了已废弃或不推荐使用的 API。已删除 API 的替代方案或删除原因展示如下：

- `VirtualBackgroundSourceEnabled` 事件：使用 `enableVirtualBackground `的返回值替代。
- `UserSuperResolutionEnabled` 事件：使用 `onRemoteVideoStats `回调的 `superResolutionType` 成员替代。
- `setAudioMixingPlaybackSpeed`：使用 `IMediaPlayer` 类下的相关 API 替代。
- `getAudioFileInfo `和 `RequestAudioFileInfo` 事件 ：使用 `getDuration` 替代。
- `setLocalPublishFallbackOption` 和 `LocalPublishFallbackToAudioOnly` 事件：在 v3.7.0 中很少使用。
- `RenderMode` 中的 `FILL `(4)：该模式可能造成图片过度拉伸，不推荐使用。
- `AudioMixingReason `中的以下枚举：在 v3.7.0 中应用场景很少。
  - `AudioMixingReasonStartedByUser`
  - `AudioMixingReasonStartNewLoop`
  - `AudioMixingReasonPausedByUser`
  - `AudioMixingReasonResumedByUser`
- `AudioMixingFinished `事件: 使用 `onAudioMixingStateChanged` 替代。
- `enableDeepLearningDenoise`：AI 降噪将在后续版本改由 SDK 控制，不通过 API 实现。
- `takeSnapshot` 和 `onSnapshotTaken` 中的 `channel` 参数：冗余参数。

- `setDefaultMuteAllRemoteVideoStreams`：由 `ChannelMediaOptions` 中的 `autoSubscribeVideo `替代。
- `setDefaultMuteAllRemoteAudioStreams`：由 `ChannelMediaOptions `中的 `autoSubscribeAudio `替代。

- `startAudioMixing `中的 `replace` 参数：由 `ChannelMediaOptions` 中的 `publishMicrophoneTrack` 替代。 

### 命名变更

v4.0.0 的命名和数据类型变更会在你编译项目时引入 IDE 的报错提示，你需要根据提示更新 app 代码。

主要的 API 及参数名变更如下：

- `FirstLocalAudioFrame` 事件变更为 `onFirstLocalAudioFramePublished` 回调。
- `LogConfig `中的 `fileSize `成员变更为 `fileSizeInKB`。
- `enableAudioVolumeIndication `中的 `report_vad `参数变更为 `reportVad`。