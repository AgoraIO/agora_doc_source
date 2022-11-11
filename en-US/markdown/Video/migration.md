# API settings after SDK migration

Agora supports upgrading the Voice and Video SDK from v3.x, v4.0.0 Preview, or v4.0.0 Beta to v4.x. For more information on migration steps and differences between versions, see the [Migration guide](https://docs.agora.io/en/video-calling/develop/migration-guide?platform=windows).

This page introduces the scenarios in which the APIs and related implementation codes should be modified to help you smoothly complete migration after you upgrade the SDK.

Unless otherwise specified, all the example APIs on this page are in C++, and the corresponding platform is Windows.

## Using v3.x before migration
If you use features and scenarios described in this section in v3.x, refer to the corresponding example to update the code in your app.

### Single channel
This section provides sample code for commonly used functions in single channel.

#### Initialize the engine

v3.x

- Android: [Start interactive live video streaming]() and [sample project]()
- iOS: [Start interactive live video streaming]() and [sample project]()
- Windows: [Start interactive live video streaming]() and [sample project]()
- macOS: [Start interactive live video streaming]() and [sample project]()

v4.x

- Android: [Start interactive live video streaming]() and [sample project]()
- iOS: [Start interactive live video streaming]() and [sample project]()
- Windows: [Start interactive live video streaming]() and [sample project]()
- macOS: [Start interactive live video streaming]() and [sample project]()

#### Publish audio and video streams captured by the microphone and camera by default

v3.x

```C++
// Controls whether to publish streams via muteLocalAudioStream and muteLocalVideoStream
// Sets the parameter as true to stop publishing audio stream, or as false to continue publishing
m_rtcEngine->muteLocalAudioStream(false);
// Sets the parameter as true to stop publishing video stream, or as false to continue publishing
m_rtcEngine->muteLocalVideoStream(false);
```

v4.x

```C++
// m_rtcEngine can be customized as IRtcEngine* or IRtcEngineEx*
// IRtcEngineEx is inherited from IRtcEngine. It includes more APIs and supports multi-channel features
// Agora recommends using ChannelMediaOptions for more precise control over the publishing of audio and video streams
// Note: In v4.x, you use ChannelMediaOptions for precise control over publishing and subscription of audio and video streams by default
ChannelMediaOptions options;
options.channelProfile = CHANNEL_PROFILE_LIVE_BROADCASTING;
options.clientRoleType = CLIENT_ROLE_BROADCASTER;
// Sets the parameter as true to subscribe to the audio stream, or as false to disable the subscription
options.autoSubscribeAudio = true;
// Sets the parameter as true to subscribe to the video stream, or as false to disable the subscription
options.autoSubscribeVideo = true;
// Sets the parameter as true to publish audio stream captured by the microphone, or as false to disable publishing
options.publishMicrophoneTrack = true;
// Sets the parameter as true to publish video stream captured by the camera, or as false to disable publishing
options.publishCameraTrack = true;
// You need to use updateChannelMediaOptionsEx for replacement in the ex channel
m_rtcEngine->updateChannelMediaOptions(options);
```

#### Switch video source from webcam to shared screen

v3.x

```C++
SIZE size; size.cx = 100;
size.cy = 100;
IScreenCaptureSourceList* infos = m_rtcEngine->getScreenCaptureSources(size, size, true);
ScreenCaptureSourceInfo info = infos->getSourceInfo(index);
ScreenCaptureParameters capParam;
// Calls startScreenCaptureByDisplayId, startScreenCaptureByWindowId, or startScreenCaptureByScreenRect to share screen
m_rtcEngine->startScreenCaptureByDisplayId((int)info.sourceId, regionRect, capParam);
// Stops screen sharing
m_rtcEngine->stopScreenCapture();
```

v4.x

```C++
SIZE size;
size.cx = 100;
size.cy = 100;
agora::rtc::Rectangle regionRect = { 0,0,0,0 }；
IScreenCaptureSourceList* infos = m_rtcEngine->getScreenCaptureSources(size, size, true);
ScreenCaptureSourceInfo info = infos->getSourceInfo(index); ScreenCaptureParameters capParam;
m_rtcEngine->startScreenCaptureByDisplayId((int)info.sourceId, regionRect, capParam);
ChannelMediaOptions options;
options.publishCameraTrack = false;
// Publishes the screen-sharing stream
options.publishScreenTrack = true;
m_rtcEngine->updateChannelMediaOptions(options);
......
// Stops publishing screen-sharing stream
options.publishScreenTrack = false;
m_rtcEngine->updateChannelMediaOptions(options)
// Stops screen sharing
m_rtcEngine->stopScreenCapture();
```

#### Publish MP4 videos

v3.x 

In v3.x, this feature requires an independent process and is implemented through MediaPlayer Kit. See [MediaPlayer Kit (3.x)]().

v4.x 

Initialize MediaPlayer. See [MediaPlayer Kit (4.x)]().

1. Publish streams captured by the microphone and camera

```C++
ChannelMediaOptions options;
options.channelProfile = CHANNEL_PROFILE_LIVE_BROADCASTING;
options.clientRoleType = CLIENT_ROLE_BROADCASTER;
options.autoSubscribeAudio = true;
options.autoSubscribeVideo = true;
// Publishes the audio stream captured by the microphone by default
options.publishMicrophoneTrack = true;
// Publishes the video stream captured by the camera by default
options.publishCameraTrack = true;
// Joins the channel
m_rtcEngine->joinChannel(APP_TOKEN, szChannelId, 0, options);
```

2. Switch to publish the audio and video streams captured by media players

```C++
IMediaPlayer* m_mediaPlayer = m_rtcEngine->createMediaPlayer().get();
ChannelMediaOptions options;
// Stops publishing audio stream captured by the microphone
options.publishMicrophoneTrack = false;
// Stops publishing video stream captured by the camera
options.publishCameraTrack = false;
// Specifies the playerId of the media player to be published
options.publishMediaPlayerId = m_mediaPlayer->getMediaPlayerId();
// Switches to the audio stream captured by the media player
options.publishMediaPlayerAudioTrack = true;
// Switches to the video stream captured by the media player
options.publishMediaPlayerVideoTrack = true;
m_rtcEngine->updateChannelMediaOptions(options);
```

### Multiple channels

This section provides sample code for commonly used features in multiple channels.

#### Join multiple channels

v3.x 

v3.x only supports publishing one stream in a single process. You can only publish one stream to a channel; for other channels, you can only subscribe to their streams. You need to start multiple processes to publish multiple streams. For more information, see:

- Android: [Join multiple channels]() and [sample code]()
- iOS: [Join multiple channels]() and [sample code]()
- Windows: [Join multiple channels]() and [sample code]()
- macOS: [Join multiple channels]() and [sample code]()


v4.x 

v4.x supports joining multiple channels in a single process, and can publish audio and video streams in multiple channels simultaneously. For more information, see:

- Android: [Join multiple channels]() and [sample code]()
- iOS: [Join multiple channels]() and [sample code]()
- Windows: [Join multiple channels]() and [sample code]()
- macOS: [Join multiple channels]() and [sample code]()


#### Publish streams to two channels by default

For example:

- Publish the stream captured by the microphone and camera in channel1.
- Publish the stream captured by the shared screen in channel2.

v3.x 

v3.x does not support simultaneously publishing audio and video streams to two channels in a single process. Therefore, it is necessary to create engines separately through multiple processes.

1. Publish the stream captured by the camera to process 1.

```C++
m_rtcEngine->setClientRole(CLIENT_ROLE_BROADCASTER);
m_rtcEngine->enableVideo();
m_rtcEngine->joinChannel(accessToken, channelId, "", uid);
```

2. Publish the stream captured by the shared screen to process 2.

```C++
m_rtcEngine->setClientRole(CLIENT_ROLE_BROADCASTER);
m_rtcEngine->joinChannel(accessToken, channelId, "", uid);
m_rtcEngine->startScreenCaptureByDisplayId((int)info.sourceId, regionRect, capParam);
```

v4.x 

v4.x supports directly publishing audio and video streams in multiple channels in a single process.

1. Publish the stream captured by the camera.

```C++
ChannelMediaOptions options;
options.channelProfile = CHANNEL_PROFILE_LIVE_BROADCASTING;
options.clientRoleType = CLIENT_ROLE_BROADCASTER;
options.autoSubscribeAudio = true;
options.autoSubscribeVideo = true;
options.publishCameraTrack = true;
m_rtcEngine->joinChannel(APP_TOKEN, szChannelId, 0, options);
```

2. Publish the stream captured by the shared screen.

```C++
// Specifies the screen to be shared
agora::rtc::Rectangle rc;
ScreenCaptureParameters scp;
scp.frameRate = 15;
scp.bitrate = 0;
HWND hWnd = ::GetDesktopWindow();
RECT destop_rc;
::GetWindowRect(hWnd, &destop_rc);
scp.dimensions.width = destop_rc.right - destop_rc.left;
scp.dimensions.height = destop_rc.bottom - destop_rc.top;
m_rtcEngine->startScreenCaptureByScreenRect(rc, rc, scp);
// Joins multiple channels
ChannelMediaOptions options;
options.channelProfile = CHANNEL_PROFILE_LIVE_BROADCASTING;
options.clientRoleType = CLIENT_ROLE_BROADCASTER;
// You do not need to repeatedly subscribe to the audio stream when joining the same channel
options.autoSubscribeAudio = false;
// You do not need to repeatedly subscribe to the video stream when joining the same channel
options.autoSubscribeVideo = false;
// Disables publishing video stream captured by the camera in the ex channel
options.publishCameraTrack = false;
// Disables publishing audio stream captured by the microphone in the ex channel
options.publishMicrophoneTrack = false;
// Publishes the screen-sharing stream in the ex channel
options.publishScreenTrack = true;
agora::rtc::RtcConnection connection;
connection.channelId = szChannelId;
// Customizes the uid
connection.localUid = screenId;
m_rtcEngine->joinChannelEx(APP_TOKEN, connection, options, &eventHandlerScreen);
```

### Screen share API

This section provides sample code for screen sharing.

#### Integration

v3.x

You can directly call screen-sharing methods without integrating any screen-sharing extensions.

v4.x

You need to integrate the following screen-sharing extensions before calling the screen-sharing method:
- Android: `AgoraScreenShareExtension.aar` and `libagora_screen_capture_extension.so`
- iOS/macOS: `AgoraCIExtension.xcframework`
- Windows: `libagora_segmentation_extension.dll`

#### Implementation

v3.x

- Android: [Share the screen]() and [sample code]()
- iOS: [Share the screen and]() and [sample code]()
- Windows: [Share the screen]() and [sample code]()
- macOS: [Share the screen]() and [sample code]()

v4.x

- Android: [Share the screen]() and [sample code]()
- iOS: [Share the screen]() and [sample code]()
- Windows: [Share the screen]() and [sample code]()
- macOS: [Share the screen]() and [sample code]()

### Custom sources

If you use the custom sources feature in v3.x, such as the custom video source for a third-party image enhancement extension, Agora recommends that you use the more refined and easier-to-use SDK source in v4.x.

v4.x refines the video module in the SDK and adds support for the Texture format on Android. In general, Agora recommends that users use the SDK to capture audio and video sources after migration. In some cases, however, users can continue to use the custom sources feature, such as when they need to connect SDKs from different providers.
Compared to custom sources, the SDK source in v4.x has the following advantages:

- Easy to use: Users do not need to deal with video capture, device model compatability, and capture profile strategies. v4.x minimizes code complexity for their applications and reduces issues caused by audio and video capture. In addition, using the SDK to capture audio and video sources can help avoid out-of-sync issues.
- Low cost of issue identification: The SDK supports uploading and collecting data such as resolution, frame rate, and image processing time, and Agora analyzes these data in the background to quickly identify the causes of issues such as frame loss.
- Low maintenance cost: Agora has R&D team to continuously, iteratively optimize using the SDK to capture audio and video. QA testing for the SDK source is also consistently improved. By contrast, Agora mainly resolves major issues for the custom sources feature and does not provide iterative updates.
- Fast issue resolution: The SDK supports configuring and distributing audio and video capture strategies, and can quickly resolve issues for certain device models.
- In addition, note that the APIs related to MediaIO have been removed in v4.x; users need to switch to the Push mode.


v3.x

- Android:
  - [Custom audio capture]() and [sample project]()
  - [Custom video source]() and sample projects:
    - [PushExternalVideo (Push mode)]()
    - [SwitchExternalVideo (MediaIO mode)]()
- iOS:
  - [Custom audio source]() and sample projects:
    - [CustomAudioSource]()
    - [ExternalAudio]()
  - [Custom video source]() and sample projects:
    - [CustomVideoSourcePush (Push mode)]()
    - [CustomVideoSourceMediaIO (MediaIO mode)]()
- Windows:
  - [Custom audio source]() and [sample project]()
  - [Custom video source]() and sample projects:
    - [CustomVideoCapture (Push mode)]()
    - [MediaIOCustomVideoCaptrue (MediaIO mode)]()
- macOS:
  - [Custom audio source]() and sample projects:
    - [CustomAudioSource]()
    - [ExternalAudio]()
  - [Custom video source]() and sample projects:
    - [CustomVideoSourcePush (Push mode)]()
    - [CustomVideoSourceMediaIO (MediaIO mode)]()

v4.x

- Android:
  - [Custom video source]() and sample projects:
    - [PushExternalVideo (Push mode)]()
    - [MultiVideoSourceTracks (Video Track method)]()
- iOS:
  - [Custom video source]() and sample code:
    - [CustomVideoSourcePush (Push mode)]()
    - [CustomVideoSourcePushMulti (Video Track method)]()
- Windows:
  - [Custom audio source]() and [sample project]()
- macOS:
  - [Custom audio source]() and [sample project]()

While configuring video capturing, you may ask:

Q: What are the differences between `stopPreview`, `enableLocalVideo`, and `muteLocalVideoStream`?

A: The differences between the three APIs are as follows:

- `stopPreview` stops local preview but does not stop capturing local video or publishing local video streams.
- `enableLocalVideo(false)` stops capturing local video. For example, you use this API when your application runs in the background and video capture is no longer needed.
- `muteLocalVideoStream(true)` stops publishing local video stream. For example, you use this API when your application needs to occupy the camera but does not publish video stream.

Q: When is the recommended time to register the raw data callback?

A: The camera will automatically turn on when the user calls `joinChannel` as a host. Therefore, Agora recommends that the user should call `registerVideoFrameObserver` after initializing the engine.

## Using v4.0.0 Preview or v4.0.0 Beta before migration

### Breaking changes

- `AUDIO_SCENARIO_HIGH_DEFINITION` in `AUDIO_SCENARIO_TYPE` is removed. Use its equivalent `AUDIO_SCENARIO_GAME_STREAMING` instead.
- The `option` naming is modified to clarify the control definition for microphone track. `publishAudioTrack` in `ChannelMediaOptions` is changed to `publishMicrophoneTrack`.
- In order to enrich the diversity of multi-stream functions, the video source type parameter is added to the video stream callback events. For example: `onFirstLocalVideoFrame`, `onFirstLocalVideoFramePublished`, `onVideoSizeChanged`, `onVideoPublishStateChanged`, `onLocalVideoStats`, and `onLocalVideoStateChanged`.
- Media Push APIs improvement:
  - To reduce the difficulty of integrating Media Push, this release optimizes the API design of Media Push and improves the handling of network issues within Media Push clients and servers. You can try the optimized Media Push functionality with the following new methods:
    - `startRtmpStreamWithoutTranscoding`: Starts pushing media streams to a CDN without transcoding. This method works the same as the previous method `addPublishStreamUrl(false)`.
    - `startRtmpStreamWithTranscoding`: Starts pushing media streams to a CDN and sets the transcoding configuration. This method works the same as calling the previous methods `setLiveTranscoding` and `addPublishStreamUrl(true)` in sequence.
    - `updateRtmpTranscoding`: Updates the transcoding configuration. This method works the same as the non-first call to the previous method `setLiveTranscoding`.
    - `stopRtmpStream`: Stops pushing media streams to a CDN. This method works the same as the previous method `removePublishStreamUrl`.
    - On the Android platform, all parameter types in the `onRtmpStreamingStateChanged` callback are changed to the `int` type.
  - This release deprecates three methods for Media Push: `addPublishStreamUrl`, `setLiveTranscoding`, and `removePublishStreamUrl`. Agora recommends that you use the new methods for Media Push and update your code logic by referring to [Media Push]().
- The `replace` (`Boolean` type) parameter in `startAudioMixing` is removed. `startAudioMixing` sends a mix of audio from the microphone and the media player by default. If you need to stop sending audio from the microphone, you can call the following methods as needed depending on whether to continue recording:
  - Recording required: Call `updateChannelMediaOptions` and set `publishMicrophoneTrack` to `false`, while the microphone is still on.
  - No recording required: Call `enableLocalAudio` to turn off the microphone.
- All parameter types in the `onRemoteAudioStateChanged` callback are changed to the `Int` type (Android platform only).

### Behavior changes & added APIs

- `IAudioFrameObserver` is added with these callbacks: `getObservedAudioFramePosition`, `getRecordAudioParams`, `getPlaybackAudioParams`, and `getMixedAudioParams`. `setRecordingAudioFrameParameters` and other series of APIs in v3.x are deprecated.
- Extensions are used for screen sharing. See [Share the screen]().
- The `enableVirtualBackground` method is added with the `SegmentationProperty` and `segProperty` parameters.

### Reference
The following table shows the differences between some common APIs in different versions:

| Common API | `muteLocalAudioStream` | `muteLocalVideoStream` |
| --- | --- | --- |
| v3.x | The `joinChannel` method with the `options` parameter overrides the setting of `muteLocalAudioStream`. | The `joinChannel` method with the `options` parameter overrides the setting of `muteLocalVideoStream`.|
|v4.0.0 Preview or v4.0.0 Beta | Equivalent to `ChannelMediaOptions.publishAudioTrack`. If the host in the channel calls this method and sets the parameter to `false`, the microphone will be turned on.| Equivalent to `ChannelMediaOptions.publishCameraTrack`. |
| v4.x	| <ul><li>Calling this method either before or after joining a channel takes effect.</li><li>`muteLocalAudioStream` and `ChannelMediaOptions` are independent of each other: if you set `publishMicrophoneTrack` to `true` and `muteLocalAudioStream` to `true`, the audio stream will not be published.</li></ul> | <ul><li>Calling this method either before or after joining a channel takes effect.</li><li>`muteLocalVideoStream` and `ChannelMediaOptions` are independent from each other: If you set `publishCameraTrack` to `true` and `muteLocalVideoStream` to `true`, the video stream will not be published.</li></ul> |


| Common API | `setClientRole` | `startPreview` |
| --- | --- | --- |
| v3.x | Same as v4.x (multiple upstreams are not supported, and user roles cannot be set as hosts in multiple channels at the same time). | Same as v4.x. |
| v4.0.0 Preview or v4.0.0 Beta	| `setClientRole` is affected by `muteLocalAudioStream` and `muteLocalVideoStream`. For example, if `muteLocalAudioStream(true)` and `muteLocalVideoStream(true)` are called before calling `setClientRole` and setting the user role as a host, the host cannot publish streams.| You need to call `startPreview`/`stopPreview` to turn on/off the local preview.|
| v4.x | <ul><li>`setClientRole` takes precedence over `enableLocalAudio`/`enableLocalVideo`.</li><li>If this method is called before joining a channel, the SDK will first record the status.<ul><li>If you switch to host after joinning the channel, media capture will be enabled and automatically published according to the status of `enableLocalAudio`/`enableLocalVideo`.</li><li>If you switch the user role to audience, media capture will be turned off and publishing will stop.</li></ul></li><li>In a multi-channel scenario, users can switch to host on each channel to publish streams. Stream publishing in the channel is controlled via `updateChannelMediaOptionsEx`.</li></ul> |When the host joins a channel and publishes the video stream captured by the camera, the local preview will be automatically enabled. If `startPreview` is called for your application, you need to call `stopPreview` to close the local preview when leaving the channel. |


| Common API | `enableLocalAudio` | `enableLocalVideo` |
| --- | --- | --- |
| v3.x | Same as v4.x. | Same as v4.x. |
| v4.0.0 Preview or v4.0.0 Beta	| <ul><li>The microphone will be turned on/off when a host calls this method (either in or outside the channel).</li><li>An error code will be returned when an audience member calls this method.</li><li>If you call `ChannelMediaOptions.publishAudioTrack` in the channel, it takes effect.</li></ul> | <ul><li>The camera will be turned on/off when a host calls this method (either in or outside the channel).</li><li>An error code will be returned when an audience member calls this method.</li><li>If you call `ChannelMediaOptions.publishCameraTrack` in the channel, it takes effect.</li></ul> |
| v4.x | <ul><li>If you call this method outside the channel, the microphone will not be turned on/off, and the microphone will be turned on/off automatically after you you the channel.</li><li>If you call this method in a channel, the microphone will be turned on/off.</li> |<ul><li>If you call this method outside the channel, the camera will not be turned on/off, and the camera will be turned on/off automatically after you joining the channel.</li><li>If you call this method in a channel, the camera will be turned on/off.</li> |
