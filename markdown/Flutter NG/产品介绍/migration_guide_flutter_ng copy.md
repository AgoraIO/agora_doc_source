# Migrate from ^5.x to v6.0.0-rc.1 (Flutter)

agora_rtc_engine: ^6.0.0-rc.1 is a new version of the SDK that you can use to embed real-time video and audio into your app. It supports large-scale real-time interactive activities and provides better real-time interactive effects. For details, see [Benefits and features](product_live_ng#benefits).

This page introduces the main steps to upgrade the SDK from ^5.x to v4.0.0, as well as the related changes.


## Migration steps

This section introduces the main steps to upgrade the SDK from agora_rtc_engine: ^5.x to agora_rtc_engine: ^6.0.0-rc.1

### 1. Integrate the SDK

See [Project setup](./start_live_flutter_ng#create-a-flutter-project) for more information about integrating the agora_rtc_engine: ^6.0.0-rc.1 SDK into your project.

### 2. Update the Agora code in your app

The agora_rtc_engine: ^6.0.0-rc.1 SDK has optimized or modified the implementation of some functions, resulting in incompatibility with the agora_rtc_engine: ^5.x. In order to retain Agora functionality in your app, update the code in your app according to [What has changed](#changes).


<a name="changes"></a>

## What has changed

This section introduces the main changes of agora_rtc_engine: ^6.0.0-rc.1 compared to agora_rtc_engine: ^5.x in the following categories:

- Breaking changes: Introduces API compatibility changes that have a big impact. You need to spend significant time modifying the related implementation.
- Behavior changes: Introduces changes caused by reasonable optimization of the SDK default behavior and API behavior. Less time is required to modify the related implementation, if any.
- Function gaps: Introduces functions that were supported in agora_rtc_engine: ^5.x but are not supported in agora_rtc_engine: ^6.0.0-rc.1. However, these functions are intended to be added in a future release.
- Removed APIs: Introduces APIs that were supported in agora_rtc_engine: ^5.x but removed in agora_rtc_engine: ^6.0.0-rc.1. Most of these APIs have alternatives in agora_rtc_engine: ^6.0.0-rc.1. Modifying the related implementation should require less time.
- Naming and data type changes: Introduces the naming and data type changes of the main APIs. You can update the relevant implementation according to the error messages in the IDE, which is expected to take less time.

As stated above, you need to update the code of your app according to your business scenario.


### Breaking changes

After upgrading from agora_rtc_engine: ^5.x to agora_rtc_engine: ^6.0.0-rc.1, the way the APIs implement some functions is different. This section introduces compatibility changes for these APIs and the logic for updating the code of your app.

#### 命名参数

为了更好的代码可读性，agora_rtc_engine: ^6.0.0-rc.1后将所有参数多于2个的方法的参数改成了[命名参数](https://dart.dev/guides/language/language-tour#parameters)，如 `joinChannel` 方法：

```dart
await _engine.joinChannel(token: '', channelId: 'channelid', info: '', uid: 0);
```

#### 初始化流程

agora_rtc_engine: ^6.0.0-rc.1 后提供了 top-level 方法 `createAgoraRtcEngine` 用于创建 RtcEngine，创建完 RtcEngine 后需要主动调用 `initialize` 进行初始化。

#### 渲染控件

agora_rtc_engine: ^6.0.0-rc.1 后移除了 [SurfaceView](https://docs.agora.io/cn/video-legacy/API%20Reference/flutter/v5.3.0/API/class_rtc_local_view_surfaceview.html)/[TextureView](https://docs.agora.io/cn/video-legacy/API%20Reference/flutter/v5.3.0/API/class_rtc_local_view_textureview.html) 控件，视频渲染统一使用 [AgoraVideoView](https://docs.agora.io/cn/video-call-4.x/API%20Reference/flutter_ng/API/class_agoravideoview.html) 控件。

#### Multiple channels

In agora_rtc_engine: ^5.x, the SDK provides the `RtcChannel` and `RtcChannelEventHandler` classes to implement multi-channel control. The agora_rtc_engine: ^5.x SDK supports subscribing to the audio and video streams of multiple channels, but only supports publishing one group of audio and video streams in one channel.

在 agora_rtc_engine: ^6.0.0-rc.1 中：

agora_rtc_engine: ^6.0.0-rc.1 introduces the following changes:



- SDK 支持同时采集或同时发布多组音视频流。例如，同时发布多路摄像头采集或者屏幕共享的视频流。
- SDK 提供 `RtcEngineEx` 类实现多频道功能：调用 `joinChannel` 加入首个频道后，多次调用 `joinChannelEx` 加入多个频道，通过不同的用户 ID（`localUid`）和 `ChannelMediaOptions` 设置发布指定的流到不同的频道。
- 新增了 `RtcConnection `二元组表示 `joinChannel` 建立的连接，一个连接由频道名（`channelId`）和 `localUid` 确定。你可以通过 `RtcConnection` 控制不同连接的发布和订阅。所有带 `connection`参数（对应 `RtcConnection` 类）的 API 命名中都增加了 Ex 以区分，并统一放在 `RtcEngineEx` 类中，用于多流的扩展。

通过设置 `ChannelMediaOptions`，agora_rtc_engine: ^6.0.0-rc.1 支持一个 `RtcEngine` 实例同时采集多路音视频源并发布到远端，适应各种业务场景。例如：

- 同时发布多路摄像头采集的视频流或者多路屏幕共享流
- 同时发布单路媒体播放器的视频流、屏幕共享流和摄像头采集的视频流
- 同时发布单路麦克风采集、自采集的音频流和媒体播放器的音频流

结合多频道能力，你还可以体验如下功能：

- 将多组音视频流通过不同的 `localUid` 发布到远端
- 将多路音频流混音后通过一个 `localUid` 发布到远端
- 将多路视频流合图后通过一个 `localUid` 发布到远端

agora_rtc_engine: ^5.x 的 `RtcChannel` 和 `RtcEngine` 在功能上有部分重复、不够正交，因此在 agora_rtc_engine: ^6.0.0-rc.1 中隐藏了 `RtcChannel` 类和 `RtcChannelEventHandler` 类。你可以参考 [JoinMultiChannel](https://github.com/AgoraIO/API-Examples/tree/4.0.0-GA/windows/APIExample/APIExample/Advanced/MultiChannel) 示例项目，用 `joinChannel` 和 `ChannelMediaOptions` 替代 `RtcChannel`，预计迁移成本在一天以内。如果你需要继续使用 `RtcChannel` 和 `RtcChannelEventHandler` 类，请提交工单[联系技术支持](https://agora-ticket.agora.io/)，Agora 会根据反馈情况决定是否在后续版本中保持兼容。

#### 媒体流发布控制

在 agora_rtc_engine: ^6.0.0-rc.1 中，将更多频道相关的设置都汇聚进了 `ChannelMediaOptions`，包括不同音视频流的发布、自动订阅、用户角色切换、Token 更新、默认大小流选项等。你可以在加入频道时通过 `joinChannel` 或 `joinChannelEx` 明确媒体流发布和订阅行为，也可以在加入频道后通过 `updateChannelMediaOptions` 动态更新频道中的媒体选项，例如切换视频源。

#### 警告码

在 agora_rtc_engine: ^5.x 中，SDK 通过 `warning` 回调报告警告码。

为方便用户定位和排查问题，agora_rtc_engine: ^6.0.0-rc.1 通过 API 返回值或不同状态回调来报告问题和原因。例如：

- `onConnectionStateChanged`：报告网络连接状态。
- `onLocalAudioStateChanged`：报告本地音频状态。
- `onLocalVideoStateChanged`：报告本地视频状态。
- `onRemoteAudioStateChanged`：报告远端音频状态。
- `onRemoteVideoStateChanged`：报告远端视频状态。

因此，agora_rtc_engine: ^6.0.0-rc.1 删除了 `warning` 回调。

<div class="alert note">除上述相对于 agora_rtc_engine: ^5.x 的中断性变更以外，agora_rtc_engine: ^6.0.0-rc.1 对于 agora_rtc_engine: ^6.0.0-rc.1-beta.2 也存在极少数中断性变更。例如：

- 在 agora_rtc_engine: ^6.0.0-rc.1 中，将 `ChannelMediaOptions` 中的 `publishAudioTrack` 替换为 `publishMicrophoneTrack`。

如果你在 agora_rtc_engine: ^6.0.0-rc.1-beta.2 版本中使用了该功能、并且希望升级到 agora_rtc_engine: ^6.0.0-rc.1 版本，请在升级 SDK 后修改功能的实现。</div>


### Behavior changes

本节介绍由 agora_rtc_engine: ^6.0.0-rc.1 对 SDK 默认行为和 API 行为的合理优化造成的变更。

#### 频道场景

因为直播场景支持从一对一通话无缝切换到多人互动，所以 Agora 自 agora_rtc_engine: ^5.x 起将通信场景下内部的传输协议和弱网对抗能力改成与直播场景一致。在 agora_rtc_engine: ^6.0.0-rc.1 中，Agora 也将默认的频道场景改成了 `ChannelProfileLiveBroadcasting`（直播）。

#### 网络质量回调

在 agora_rtc_engine: ^5.x 中，如果 `onNetworkQuality` 中的 `uid` 为 0，则该回调返回的是本地用户的网络质量。在 agora_rtc_engine: ^6.0.0-rc.1 中，该回调返回的本地用户 `uid` 和用户在频道内实际的 `uid` 相同。

#### 默认日志文件

在 agora_rtc_engine: ^5.x 中，有多个日志文件时，旧的文件会以 agorasdk_x.log 格式命名，例如 agorasdk_1.log。agora_rtc_engine: ^6.0.0-rc.1 修改命名格式为 agorasdk.x.log（例如 agorasdk.1.log）。此外，agora_rtc_engine: ^6.0.0-rc.1 新增了 agoraapi.log 记录 API 调用的日志。

#### 快速切换频道

在 agora_rtc_engine: ^5.x 中，你需要调用 `switchChannel` 实现快速切换频道。

在 agora_rtc_engine: ^6.0.0-rc.1 中，通过 `leaveChannel` 和 `joinChannel` 切换频道即可实现和 `switchChannel` 一样的切换速度，因此该版本删除了 `switchChannel`。如果你在 agora_rtc_engine: ^5.x 中使用 `switchChannel` 切换频道，你需要在 agora_rtc_engine: ^6.0.0-rc.1 中先调用 `leaveChannel` 离开当前频道，再调用 `joinChannel` 加入第二个频道。

#### (Windows) 本地音视频流录制

- 在 agora_rtc_engine: ^5.x 中，如需开启本地音视频流录制，需要调用 `MediaRecorder.getMediaRecorder` 方法先获取 MediaRecorder 对象。
- 在 agora_rtc_engine: ^6.0.0-rc.1 中，如需开启本地音视频流录制，需要调用 `RtcEngine.getMediaRecorder` 方法获取获取 MediaRecorder 接口类。

#### 虚拟节拍器

当你调用 `startRhythmPlayer` 时，SDK 默认将虚拟节拍器的声音发布到远端，如果你不希望远端用户听到虚拟节拍器，需参考以下操作：

- 在 agora_rtc_engine: ^5.x 中，调用  `configRhythmPlayer` 并将 `publish` 设置为 `false。`
- 在 agora_rtc_engine: ^6.0.0-rc.1 中，将 `ChannelMediaOptions` 中的 `publishRhythmPlayerTrack` 设置为 `false`。

#### 音量提示

当你调用 `enableAudioVolumeIndication` 方法并将 `interval` 参数设置为 >0 时，可启用用户音量提示。在 agora_rtc_engine: ^5.x 和 agora_rtc_engine: ^6.0.0-rc.1 中，`interval` 参数的定义存在差异：

- 在 agora_rtc_engine: ^5.x 中：建议设置到大于 200 毫秒。最小不得少于 10 毫秒，否则会收不到 `onAudioVolumeIndication` 回调。
- 在 agora_rtc_engine: ^6.0.0-rc.1 中：该参数需要设为 200 的整数倍。如果取值低于 200，SDK 会自动调整为 200。

当启用音量提示回调后，SDK 会上报 `onAudioVolumeIndication` 回调，如果本地用户将自己静音（调用了 `muteLocalAudioStream`），在 agora_rtc_engine: ^5.x 和 agora_rtc_engine: ^6.0.0-rc.1 中，SDK 的行为不一致：

- 在 agora_rtc_engine: ^5.x 中：SDK 立即停止报告本地用户的音量提示回调。
- 在 agora_rtc_engine: ^6.0.0-rc.1 中：SDK 会继续报告本地用户的音量提示回调。

#### 设备权限

- 在 agora_rtc_engine: ^5.x 中，通过 `localAudioStateChanged` 中的`AudioLocalError.DeviceNoPermission` 上报没有权限启动音频采集设备；通过 `localAudioStateChanged` 中的 `LocalVideoStreamError.DeviceNoPermission` 上报没有权限启动视频采集设备。

在 agora_rtc_engine: ^6.0.0-rc.1  中，统一通过 `onPermissionError` 回调上报音视频采集设备的权限状态。

#### 通话前网络测试

如果你需要开启或停止网络连接质量测试：

- 在 agora_rtc_engine: ^5.x 中，你可以调用 `enableLastmileTest` 开启网络质量测试，如果你想停止网络测试，需要调用 `disableLastmileTest`。
- 在 agora_rtc_engine: ^6.0.0-rc.1 中，你可以调用 `startLastmileProbeTest` 启用网络质量测试，如果你想停止网络测试，需要调用 `stopLastmileProbeTest`。


### Function gaps

本节介绍在 agora_rtc_engine: ^5.x 中支持、但在 agora_rtc_engine: ^6.0.0-rc.1 中不支持或行为不一致的功能，这些功能会在后续版本中支持或改为一致。

#### 音频应用场景

agora_rtc_engine: ^6.0.0-rc.1 重构了音频应用场景，可以替代大部分 agora_rtc_engine: ^5.x 的音频应用场景。下表展示了两个版本中音频应用场景的对应关系：

| agora_rtc_engine: ^5.x   | agora_rtc_engine: ^6.0.0-rc.1           |
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

相比于 agora_rtc_engine: ^5.x，某些功能在 agora_rtc_engine: ^6.0.0-rc.1 中不支持或仅支持部分。本节展示尚未支持的 API，这些 API 会在后续版本中支持。

远端视频流回退：

- `setRemoteUserPriority`

屏幕共享：

- `onScreenCaptureInfoUpdated`

### Removed APIs

agora_rtc_engine: ^6.0.0-rc.1 中，删除了已废弃或不推荐使用的 API。已删除 API 的替代方案或删除原因展示如下：

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
- `setDefaultMuteAllRemoteVideoStreams：`由 `ChannelMediaOptions` 中的 `autoSubscribeVideo` 替代。
- `setDefaultMuteAllRemoteAudioStreams`：由 `ChannelMediaOptions` 中的 `autoSubscribeAudio` 替代。
- `LocalVideoStreamError` 中的 `LocalVideoStreamErrorScreenCaptureWindowNotSupported`：该枚举在 agora_rtc_engine: ^5.x 已废弃。
- `startAudioMixing` 中的 `replace` 参数：由 `ChannelMediaOptions` 中的 `publishMicrophoneTrack` 替代。

### Naming changes

agora_rtc_engine: ^6.0.0-rc.1 的方法命名和数据类型变更会在你编译项目时引入 IDE 的报错提示，你需要根据提示更新 app 代码。

主要的 API 及参数名变更如下：

- (Windows 和 macOS) `adjustLoopbackRecordingSignalVolume` 变更为 `adjustLoopbackSignalVolume`。
- `firstLocalAudioFrame` 变更为 `onFirstLocalAudioFramePublished`。
- `LogConfig` 中的 `fileSize` 成员变更为 `fileSizeInKB`。
- `enableAudioVolumeIndication` 中的 `report_vad` 参数变更为 `reportVad`。