# Migrate from ^5.x to ^6.0.0-rc.2

agora_rtc_engine: ^6.0.0-rc.2 is a new version of the SDK that you can use to embed real-time video and audio into your app. It supports large-scale real-time interactive activities and provides better real-time interactive effects. For details, see [Benefits and features](product_live_ng#benefits).

This page introduces the main steps to upgrade the SDK from ^5.x to ^6.0.0-rc.2, as well as the related changes.


## Migration steps

This section introduces the main steps to upgrade the SDK from agora_rtc_engine: ^5.x to agora_rtc_engine: ^6.0.0-rc.2

### 1. Integrate the SDK

See [Project setup](./start_live_flutter_ng#create-a-flutter-project) for more information about integrating the agora_rtc_engine: ^6.0.0-rc.2 SDK into your project.

### 2. Update the Agora code in your app

The agora_rtc_engine: ^6.0.0-rc.2 SDK has optimized or modified the implementation of some functions, resulting in incompatibility with the agora_rtc_engine: ^5.x. In order to retain Agora functionality in your app, update the code in your app according to [What has changed](#changes).


<a name="changes"></a>

## What has changed

This section introduces the main changes of agora_rtc_engine: ^6.0.0-rc.2 compared to agora_rtc_engine: ^5.x in the following categories:

- Breaking changes: Introduces API compatibility changes. You need to spend significant time modifying the related implementation.
- Behavior changes: Introduces changes caused by reasonable optimization of the SDK default behavior and API behavior. Less time is required to modify the related implementation, if any.
- Function gaps: Introduces functions that were supported in agora_rtc_engine: ^5.x but are not supported in agora_rtc_engine: ^6.0.0-rc.2. However, these functions are intended to be added in a future release.
- Removed APIs: Introduces APIs that were supported in agora_rtc_engine: ^5.x but removed in agora_rtc_engine: ^6.0.0-rc.2. Most of these APIs have alternatives in agora_rtc_engine: ^6.0.0-rc.2. Modifying the related implementation should require less time.
- Naming and data type changes: Introduces the naming and data type changes of the main APIs. You can update the relevant implementation according to the error messages in the IDE, which is expected to take less time.

As stated above, you need to update the code of your app according to your business scenario.


### Breaking changes

#### As of agora_rtc_engine: ^5.x

After upgrading from agora_rtc_engine: ^5.x to agora_rtc_engine: ^6.0.0-rc.2, the way the APIs implement some functions is different. This section introduces compatibility changes for these APIs and the logic for updating the code of your app.

**Named parameters**

For optimal code readability, agora_rtc_engine: ^6.0.0-rc.2 has changed the parameters of all methods with more than two parameters to [named parameters](https://dart.dev/guides/language/language-tour#parameters). Take the `joinChannel` method as an example:

```dart
await _engine.joinChannel(token: '', channelId: 'channelid', uid: 0, options: const ChannelMediaOptions());
```

**Initialization**

In agora_rtc_engine: ^6.0.0-rc.2, the top-level `createAgoraRtcEngine` method is provided to create the `RtcEngine` object. Once created, call `initialize` to initialize it.

**Rendering control**

In agora_rtc_engine: ^6.0.0-rc.2, [SurfaceView](https://docs.agora.io/en/video-legacy/API%20Reference/flutter/v5.3.0/API/class_rtc_local_view_surfaceview.html) and [TextureView](https://docs.agora.io/en/video-legacy/API%20Reference/flutter/v5.3.0/API/class_rtc_local_view_textureview.html) are removed. [AgoraVideoView](https://docs.agora.io/en/video-call-4.x/API%20Reference/flutter_ng/API/class_agoravideoview.html) is used instead for video rendering.

**Multiple channels**

In agora_rtc_engine: ^5.x, the SDK provides the `RtcChannel` and `RtcChannelEventHandler` classes to implement multi-channel control. The agora_rtc_engine: ^5.x SDK supports subscribing to the audio and video streams of multiple channels, but only supports publishing one group of audio and video streams in one channel.

agora_rtc_engine: ^6.0.0-rc.2 introduces the following changes:

- The SDK supports one `RtcEngine` instance to collect multiple audio and video sources at the same time and publish them to the remote users by setting `RtcEngineEx` and `ChannelMediaOptions`. After calling `joinChannel` to join the first channel, call `joinChannelEx` multiple times to join multiple channels, and publish the specified stream to different channels through different user ID (`localUid`) and `ChannelMediaOptions` settings.
- Added a binary group `RtcConnection` to represent the connection established by `joinChannel`. A connection is determined by the channel name (`channelId`) and `localUid`. You can control the publishing and subscribing state of different connections through `RtcConnection`. The SDK adds Ex in the name of all APIs with a connection parameter (corresponding to the `RtcConnection` class) to distinguish them, and gathers these APIs in the `RtcEngineEx` class to implement more multi-stream functions.

By setting `ChannelMediaOptions`, agora_rtc_engine: ^6.0.0-rc.2 supports one `RtcEngine` instance to capture audio and video streams from multiple sources at the same time and publish them to the remote user, adapting to various business scenarios. For example:

- Simultaneously publish multiple video streams captured by the camera and screen-sharing streams.
- Simultaneously publish a media player stream, a screen-sharing stream, and a video stream captured by the camera.
- Simultaneously publish one audio stream captured by the microphone and one by the custom audio source, and one media player steam.

Combined with the multi-channel capability, you can also experience the following functions:

- Publish multiple groups of audio and video streams to the remote user through different `localUid`.
- Mix multiple audio streams and publish them to the remote user through one `localUid`.
- Mix multiple video streams and publish them to the remote user through one `localUid`.

`RtcChannel` and `RtcEngine` of agora_rtc_engine: ^5.x are partially duplicated and overlap in their functionality, so agora_rtc_engine: ^6.0.0-rc.2 hides the `RtcChannel` and `RtcChannelEventHandler` classes. See the [JoinMultiChannel](https://github.com/AgoraIO/API-Examples/tree/4.0.0-GA/windows/APIExample/APIExample/Advanced/MultiChannel) sample project for more details on how to replace `RtcChannel` with `joinChannel` and `ChannelMediaOptions`. The expected migration cost is one day or less.

If you need to continue to use the `RtcChannel` and `RtcChannelEventHandler` classes, contact [support@agora.io](mailto:support@agora.io). The decision whether to maintain compatibility in a future release is based on your feedback.

**Media stream publishing control**

In agora_rtc_engine: ^6.0.0-rc.2, the SDK gathers more channel-related settings into `ChannelMediaOptions`, including publishing of audio and video streams from different sources, automatic subscribing of audio and video streams, user role switching, token updating, and default dual stream options. You can determine the media stream publishing and subscribing behavior by calling `joinChannel` or `joinChannelEx` when joining a channel, or you can flexibly update the media options by calling `updateChannelMediaOptions` after joining a channel, such as switching video sources.

**Warning codes**

In agora_rtc_engine: ^5.x, the SDK returns warning codes through the `warning` callbacks.

To facilitate locating and troubleshooting issues, agora_rtc_engine: ^6.0.0-rc.2 reports problems and causes through the return values of APIs or different callbacks for listening to states. For example:

- `onConnectionStateChanged`: Reports the network connection state.
- `onLocalAudioStateChanged`: Reports the local audio state.
- `onLocalVideoStateChanged`: Reports the local video state.
- `onRemoteAudioStateChanged`: Reports the remote audio state.
- `onRemoteVideoStateChanged`: Reports the remote video state.

As a consequence, agora_rtc_engine: ^6.0.0-rc.2 removes the `warning` callbacks.


#### As of agora_rtc_engine: ^6.0.0-beta.2

In addition to the breaking changes listed here relative to agora_rtc_engine: ^5.x, agora_rtc_engine: ^6.0.0-rc.2 has a small number of breaking changes relative to the agora_rtc_engine: ^6.0.0-beta.2 release. For example:

- Replaces `publishAudioTrack` in `ChannelMediaOptions` with `publishMicrophoneTrack`.
- Removes `joinChannelWithOptions`.
- Adds `options` and removes `info` in `joinChannel`. See [`joinChannel`](https://docs.agora.io/en/video-call-4.x/API%20Reference/flutter_ng/API/class_irtcengine.html#api_irtcengine_joinchannel2) for details.

If you used this feature in agora_rtc_engine: ^6.0.0-beta.2 and wish to upgrade to agora_rtc_engine: ^6.0.0-rc.2, modify the implementation code of the feature after upgrading the SDK.


### Behavior changes

This section introduces changes caused by reasonable optimization of the SDK default behavior and API behavior.

#### Channel profile

Because the interactive live streaming profile supports seamless switching from one-to-one calls to multi-user interaction, since agora_rtc_engine: ^5.x, Agora has changed the internal transmission protocol and the ability to resist poor network conditions in the communication profile to be consistent with the interactive live streaming profile. In agora_rtc_engine: ^6.0.0-rc.2, Agora also changed the default channel profile to `ChannelProfileLiveBroadcasting` (the interactive live streaming profile).

#### Network quality callback

In agora_rtc_engine: ^5.x, if the `uid` parameter returned in `onNetworkQuality` is 0, the callback reports the network quality of the local user. In agora_rtc_engine: ^6.0.0-rc.2, the `uid` of the local user returned in this callback is the same as the local user's actual `uid` in the channel.

#### Default log file

In agora_rtc_engine: ^5.x, when the SDK creates multiple log files, the earlier files are named in a agorasdk_x.log format, such as agorasdk_1.log. agora_rtc_engine: ^6.0.0-rc.2 modified the naming format to agorasdk.x.log, such as agorasdk.1.log. Additionally, agora_rtc_engine: ^6.0.0-rc.2 adds the agoraapi.log file to record API logs.

#### Fast channel switching

In agora_rtc_engine: ^5.x, you need to call `switchChannel` to quickly switch a channel.

In agora_rtc_engine: ^6.0.0-rc.2, you can achieve the same switching speed as `switchChannel` in agora_rtc_engine: ^5.x by switching a channel through `leaveChannel` and `joinChannel`. Therefore, agora_rtc_engine: ^6.0.0-rc.2 removes `switchChannel`. If you call `switchChannel` to quickly switch a channel in agora_rtc_engine: ^5.x, you need to call `leaveChannel` to leave the current channel in agora_rtc_engine: ^6.0.0-rc.2 and `joinChannel` to join the second channel instead.

#### (Windows) Local audio and video recording

In agora_rtc_engine: ^5.x, if you want to enable local audio and video recording, you need to call the `MediaRecorder.getMediaRecorder` method to get the `MediaRecorder` object.

In agora_rtc_engine: ^6.0.0-rc.2, if you want to enable local audio and video recording, you need to call the `RtcEngine.getMediaRecorder` method to get the `MediaRecorder` object.

#### Virtual metronome

When you call `startRhythmPlayer`, the SDK publishes the sound of the virtual metronome to the remote by default. If you do not want the remote users to hear the virtual metronome, refer to the following operations:

- In agora_rtc_engine: ^5.x, call the `configRhythmPlayer`, and set `publish` to `false`.
- In agora_rtc_engine: ^6.0.0-rc.2, set `publishRhythmPlayerTrack` in `ChannelMediaOptions` to `false`.

#### Volume indication

You can call the `enableAudioVolumeIndication` method to enable the user's volume indication function. There is a difference in the definition of the `interval` parameter in the `enableAudioVolumeIndication` method between agora_rtc_engine: ^5.x and agora_rtc_engine: ^6.0.0-rc.2, as follows:

- In agora_rtc_engine: ^5.x, Agora recommends that you set the interval to be greater than 200 ms. The minimum is 10 ms; otherwise, the `onAudioVolumeIndication` callback is not received.
- In agora_rtc_engine: ^6.0.0-rc.2, you must set the interval to an integer that is a multiple of 200 ms. If the value of interval is lower than 200, the SDK automatically adjusts it to 200.

When the user's volume indication is enabled, the SDK triggers the `onAudioVolumeIndication` callback at the time interval set in this method. If the local user calls `muteLocalAudioStream` to mute themselves, the SDK behaves inconsistently between agora_rtc_engine: ^5.x and agora_rtc_engine: ^6.0.0-rc.2:

- In agora_rtc_engine: ^5.x, the SDK immediately stops reporting the local user's volume indication callback.
- In agora_rtc_engine: ^6.0.0-rc.2, the SDK continues to report the local user's volume indication callback.

#### Device permissions

In agora_rtc_engine: ^5.x, `AudioLocalError.DeviceNoPermission` in `localAudioStateChanged` reports that there is no permission to start the capture device, and `LocalVideoStreamError.DeviceNoPermission` in `localAudioStateChanged` reports that there is no permission to start the video capture device.

In agora_rtc_engine: ^6.0.0-rc.2, the permission statuses of the audio and video capture devices are both reported in the `onPermissionError` callback.

#### Pre-call network test

If you need to start or stop the network connection quality test, note the following:

- In agora_rtc_engine: ^5.x, you can call `enableLastmileTest` to start the network quality test. If you want to stop the network test, you need to call `disableLastmileTest`.
- In agora_rtc_engine: ^6.0.0-rc.2, you can call `startLastmileProbeTest` to enable network quality testing. If you want to stop network testing, you need to call `stopLastmileProbeTest`.


### Function gaps

This section introduces functions that were supported in agora_rtc_engine: ^5.x but are no longer supported or behave inconsistently in agora_rtc_engine: ^6.0.0-rc.2. Plans exist to support them or make them consistent in a future release, however.

#### Audio application scenarios

agora_rtc_engine: ^6.0.0-rc.2 reconstructs the audio application scenarios, which can replace most of the audio application scenarios of agora_rtc_engine: ^5.x. The following table shows the correspondence of audio application scenarios in the two releases:

| agora_rtc_engine: ^5.x   | agora_rtc_engine: ^6.0.0-rc.2           |
| :---------- | :-------- |
| `AudioScenario.Default`                | `AudioScenarioType.audioScenarioDefault`        |
| `AudioScenario.ChatRoomEntertainment` | `AudioScenarioType.audioScenarioChatroom`       |
| `AudioScenario.Education`  | `AudioScenarioType.audioScenarioDefault`        |
| `AudioScenario.GameStreaming`         | `AudioScenarioType.audioScenarioGameStreaming` |
| `AudioScenario.ShowRoom`               | `AudioScenarioType.audioScenarioDefault`        |
| `AudioScenario.ChatRoomGaming`        | `AudioScenarioType.audioScenarioChatroom`       |
| `AudioScenario.IOT`                    | `AudioScenarioType.audioScenarioDefault`        |
| `AudioScenario.MEETING`                | `AudioScenarioType.audioScenarioMeeting`        |

#### Unsupported functions

Compared to agora_rtc_engine: ^5.x, some features are not supported or only partially supported in agora_rtc_engine: ^6.0.0-rc.2. This section shows the APIs currently unsupported but for which support is planned in a future release.

Remote video stream fallback:

- `setRemoteUserPriority`

Screen sharing:

- `onScreenCaptureInfoUpdated`

### Removed APIs

The agora_rtc_engine: ^6.0.0-rc.2 removes deprecated or unrecommended APIs. Alternatives to the removed API or reasons for their removal are shown as follows:

- `virtualBackgroundSourceEnabled`: Use the return value of `enableVirtualBackground` instead.
- `userSuperResolutionEnabled`: Use the `remoteVideoStats` member of the `superResolutionType` class instead.
- `setAudioMixingPlaybackSpeed`: Use the relevant API under the `MediaPlayerController` class instead.
- `setExternalAudioSourceVolume`: Use `adjustCustomAudioPublishVolume` instead.
- `getAudioFileInfo` and `requestAudioFileInfo`: Use `getDuration` instead.
- `audioDeviceTestVolumeIndication`: Use `onAudioVolumeIndication` instead.
- `setLocalPublishFallbackOption` and `localPublishFallbackToAudioOnly`: Rarely used in agora_rtc_engine: ^5.x.
- `FILL(4)` in `VideoRenderMode`: This mode can cause image overstretch and is not recommended.
- The following enumerations in `AudioMixingReason`: Rarely used in agora_rtc_engine: ^5.x:
  - `StartedByUser`
  - `StartNewLoop`
  - `PausedByUser`
  - `ResumedByUser`
- `audioMixingFinished`: Use `onAudioMixingStateChanged` instead.
- `enableDeepLearningDenoise`: The SDK adds deep-learning noise reduction as one of its capability in a future release instead of implementing through an API.
- The `channel` parameter in `takeSnapshot` and `onSnapshotTaken`: The parameter is redundant.
- `setDefaultMuteAllRemoteVideoStreams`: Use `autoSubscribeVideo` in the `ChannelMediaOptions` instead.
- `setDefaultMuteAllRemoteAudioStreams`: Use `autoSubscribeAudio` in the `ChannelMediaOptions` instead.
- `LocalVideoStreamErrorScreenCaptureWindowNotSupported` in `LocalVideoStreamError`: Deprecated in agora_rtc_engine: ^5.x.
- The `replace` parameter in `startAudioMixing`: Use `publishMicrophoneTrack` in the `ChannelMediaOptions` instead.

### Naming changes

The naming changes in agora_rtc_engine: ^6.0.0-rc.2 cause error messages in the IDE when you compile your project, and you need to update the code of your app according to each error message.

The main API and parameter name changes are as follows:

- (Windows and macOS) `adjustLoopbackRecordingSignalVolume` is changed to `adjustLoopbackSignalVolume`.
- `firstLocalAudioFrame` is changed to `onFirstLocalAudioFramePublished`.
- The `fileSize` member in `LogConfig` is renamed to `fileSizeInKB`.
- The `report_vad` parameter in `enableAudioVolumeIndication` is changed to `reportVad`.