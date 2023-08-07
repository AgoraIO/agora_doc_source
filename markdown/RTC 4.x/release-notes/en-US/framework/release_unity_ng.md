## v4.2.2

This version was released on August 1, 2023.

#### Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

1. **Audio frame observer**

The following methods in the `IAudioFrameObserver` class are deleted:

- `GetObservedAudioFramePosition`: Use the newly-added `position` parameter in  `RegisterAudioFrameObserver` instead.
- `GetPlaybackAudioParams`: Use `SetPlaybackAudioFrameParameters` instead.
- `GetRecordAudioParams`: Use `SetRecordingAudioFrameParameters` instead.
- `GetMixedAudioParams`: Use `SetMixedAudioFrameParameters` instead.
- `GetEarMonitoringAudioParams`: Use `SetEarMonitoringAudioFrameParameters` instead.

2. **Video frame observer**

The following methods in the `IVideoFrameObserver` class are deleted:

- `GetVideoFormatPreference`: Use the newly-added `formatPreference` parameter in  `RegisterVideoFrameObserver`.
- `GetObservedFramePosition`: Use the newly-added `position` parameter in  `RegisterVideoFrameObserver`.

3. **Metadata**

This release deletes `GetMaxMetadataSize` and `OnReadyToSendMetadata` in the `IMetadataObserver` class. You can use the newly-added `SetMaxMetadataSize` and `SendMetadata` methods instead.

#### New features

1. **Wildcard token**

   This release introduces wildcard tokens. Agora supports setting the channel name used for generating a token as a wildcard character. The token generated can be used to join any channel if you use the same user id. In scenarios involving multiple channels, such as switching between different channels, using a wildcard token can avoid repeated application of tokens every time users joining a new channel, which reduces the pressure on your token server. See [Secure authentication with tokens](/en/video-calling/get-started/authentication-workflow).

   <div class="alert info">All 4.x SDKs support using wildcard tokens.</div>

2. **Preloading channels**

   This release adds `PreloadChannel[1/2]` and `PreloadChannel[2/2]` methods, which allows a user whose role is set as audience to preload channels before joining one. Calling the method can help shortening the time of joining a channel, thus reducing the time it takes for audience members to hear and see the host.

   When preloading more than one channels, Agora recommends that you use a wildcard token for preloading to avoid repeated application of tokens every time you joining a new channel, thus saving the time for switching between channels. See [Wildcard Tokens](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).

3. **Customized background color of video canvas**

   In this release, the `backgroundColor` member has been added to `VideoCanvas`, which allows you to customize the background color of the video canvas when setting the properties of local or remote video display.

4. **Publishing video streams from different sources** (Windows, macOS)

   This release adds the following members in `ChannelMediaOptions` to allow you publish video streams captured from the third and fourth camera or screen:

   - `publishThirdCameraTrack`: Publishing the video stream captured from the third camera.
   - `publishFourthCameraTrack`: Publishing the video stream captured from the fourth camera.
   - `publishThirdScreenTrack`: Publishing the video stream captured from the third screen.
   - `publishFourthScreenTrack`: Publishing the video stream captured from the fourth screen.

   <div class="alert info">For one <code>RtcConnection</code>, Agora supports publishing multiple audio streams and one video stream at the same time.</div>

#### Improvements

1. **Improved camera capture effect** (Android, iOS)

   This release has improved camera capture effect in the following aspects:

   1. Support for camera exposure adjustment

      This release adds `IsCameraExposureSupported` to query whether the device supports exposure adjustment and `SetCameraExposureFactor` to set the exposure ratio of the camera.

   2. Optimization of default camera selection (iOS)

      Since this release, the default camera selection behavior of the SDK is aligned with that of the iOS system camera. If the device has multiple rear cameras, better shooting perspectives, zooming capabilities, low-light performance, and depth sensing can be achieved during video capture, thereby improving the quality of video capture.

2. **Virtual Background Algorithm Upgrade**

   This version has upgraded the portrait segmentation algorithm of the virtual background, which comprehensively improves the accuracy of portrait segmentation, the smoothness of the portrait edge with the virtual background, and the fit of the edge when the person moves. In addition, it optimizes the precision of the person's edge in scenarios such as meetings, offices, homes, and under backlight or weak light conditions.

3. **Channel media relay**

   The number of target channels for media relay has been increased to 6. When calling `StartOrUpdateChannelMediaRelay` and `StartOrUpdateChannelMediaRelayEx`, you can specify up to 6 target channels.

4. **Enhancement in video codec query capability**

   To improve the video codec query capability, this release adds the `codecLevels` member in `CodecCapInfo`. After successfully calling `QueryCodecCapability`, you can obtain the hardware and software decoding capability levels of the device for H.264 and H.265 video formats through `codecLevels`.

This release includes the following additional improvements:

1. To improve the switching experience between multiple audio routes, this release adds the `SetRouteInCommunicationMode` method. This method can switch the audio route from a Bluetooth headphone to the earpiece, wired headphone or speaker in communication volume mode ([`MODE_IN_COMMUNICATION`](https://developer.android.google.cn/reference/kotlin/android/media/AudioManager?hl=en#mode_in_communication)). (Android)
2. The SDK automacially adjusts the frame rate of the sending end based on the screen sharing scenario. Especially in document sharing scenarios, this feature avoids exceeding the expected video bitrate on the sending end to improve transmission efficiency and reduce network burden.
3. To help users understand the reasons for more types of remote video state changes, the `REMOTE_VIDEO_STATE_REASON_CODEC_NOT_SUPPORT` enumeration has been added to the `OnRemoteVideoStateChanged` callback, indicating that the local video decoder does not support decoding the received remote video stream.

#### Issues fixed

This release fixed the following issues:

- Occasionally, noise occurred when the local user listened to their own and remote audio after joining the channel. (macOS)
- Slow channel reconnection after the connection was interrupted due to network reasons.
- In screen sharing scenarios, the delay of seeing the shared screen was occasionally higher than expected on some devices.
- In custom video capturing scenarios, `SetBeautyEffectOptions`, `SetLowlightEnhanceOptions`, `SetVideoDenoiserOptions`, and `SetColorEnhanceOptions` could not load extensions automatically.
- In multi-device audio recording scenarios, after repeatedly plugging and unplugging or enabling/disabling the audio recording device, no sound could be heard occasionally when calling the `StartRecordingDeviceTest` to start an audio capturing device test. (Windows)

#### API changes

**Added**

- `SetCameraExposureFactor` (Android, iOS)
- `IsCameraExposureSupported` (Android, iOS)
- `PreloadChannel[1/2]`
- `PreloadChannel[2/2]`
- `UpdatePreloadChannelToken`
- `SetRouteInCommunicationMode` (Android)
- The following members in `ChannelMediaOptions` (Windows, macOS):
  - `publishThirdCameraTrack`
  - `publishFourthCameraTrack`
  - `publishThirdScreenTrack`
  - `publishFourthScreenTrack`
- `CodecCapLevels`
- `VIDEO_CODEC_CAPABILITY_LEVEL`
- `backgroundColor` in `VideoCanvas`
- `codecLevels` in `CodecCapInfo`
- `REMOTE_VIDEO_STATE_REASON_CODEC_NOT_SUPPORT` in `REMOTE_VIDEO_STATE_REASON`
- `SetMaxMetadataSize`
- `SendMetadata`
- `position` parameter in `RegisterAudioFrameObserver`
- `formatPreference` and `position`  parameters in `RegisterVideoFrameObserver`

**Deleted**

- `GetObservedAudioFramePosition`
- `GetPlaybackAudioParams`
- `GetRecordAudioParams`
- `GetMixedAudioParams`
- `GetEarMonitoringAudioParams`
- `GetVideoFormatPreference`
- `GetObservedFramePosition`
- `GetMaxMetadataSize`
- `OnReadyToSendMetadata`

## v4.2.1

This version was released on June 21, 2023.

#### Improvements

This version improves the network transmission strategy, enhancing the smoothness of audio and video interactions.

#### Fixed Issues

This version fixed the following issues:

- Inability to join channels caused by SDK's incompatibility with some older versions of AccessToken.
- After the sending end called `SetAINSMode` to activate AI noise reduction, occasional echo was observed by the receiving end.
- Brief noise occurred while playing media files using the media player.
- After enabling the screen sharing function on the sending end, there was high delay until the receiving end could see the shared screen. (macOS)
- Occasional crash after calling the `DestroyMediaPlayer` method. (iOS)
- When the sending end mixed and published two streams of video captured by two cameras locally, the video from the second camera was occasionally missing on the receiving end. (Windows)
- In screen sharing scenarios, some Android devices experienced choppy video on the receiving end. (Android)

## v4.2.0

v4.2.0 was released on May xx, 2023.

#### Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

**1. Video capture (Windows, iOS)**

This release optimizes the APIs for camera and screen capture function. As of v4.2.0, ensure you use the alternative methods listed in the table below and specify the video source by setting the `sourceType` parameter.

| Deleted Methods                                              | Alternative Methods       |
| :----------------------------------------------------------- | :------------------------ |
| <li>`StartPrimaryCameraCapture`（Windows）</li><li>`StartSecondaryCameraCapture`（Windows，iOS）<li> | `StartCameraCapture`      |
| <li>`StopPrimaryCameraCapture`（Windows）</li><li>`StopSecondaryCameraCapture`（Windows，iOS）</li> | `StopCameraCapture`       |
| <li>`StartPrimaryScreenCapture `（Windows）</li>`StartSecondaryScreenCapture`（Windows，iOS）</li> | `StartScreenCapture`[2/2] |
| <li>`StopPrimaryScreenCapture`（Windows）</li><li>`StopSecondaryScreenCapture`（Windows，iOS）</li> | `StopScreenCapture`[2/2]  |

**2. Video rendering**

As of v4.2.0, Agora Unity SDK does not support using `VideoSurface` and `VideoSurfaceYUV` at the same time for video rendering. After one `IRtcEngine` is created, if the first view is rendered through `VideoSurfaceYUV`, all views need to be rendered using `VideoSurfaceYUV` throughout the lifecycle of the `IRtcEngine`.

**3. Video data acquisition**

The `OnCaptureVideoFrame` and `OnPreEncodeVideoFrame` callbacks are added with a new parameter called `sourceType`, which is used to indicate the specific video source type.

**4. Channel media options**

- `PublishCustomAudioTrackEnableAec` in `ChannelMediaOptions` is deleted. Use `PublishCustomAudioTrack` instead.
- `PublishTrancodedVideoTrack` in `ChannelMediaOptions` is renamed to `PublishTranscodedVideoTrack`.
- `PublishCustomAudioSourceId` in `ChannelMediaOptions` is renamed to `PublishCustomAudioTrackId`.


**5. Local video mixing (Windows)**

- The `VideoInputStreams` in `LocalTranscoderConfiguration` is changed to `VideoInputStreams.`
- The `MEDIA_SOURCE_TYPE` in `TranscodingVideoStream` is changed to `VIDEO_SOURCE_TYPE.`

**6. Virtual sound card (macOS)**

As of v4.2.0, Agora supports third-party virtual sound cards. You can use a third-party virtual sound card as the audio input or output device for the SDK. You can use the `stateChanged` callback to see whether the current input or output device selected by the SDK is a virtual sound card.

<div class="alert info">If you set AgoraALD or Soundflower as the default input or output device when joining a channel, you will not hear audio.</div>

**7. Default video encoding resolution**

As of this release, the SDK optimizes the video encoder algorithm and upgrades the default video encoding resolution from 640 × 360 to 960 × 540 to accommodate improvements in device performance and network bandwidth, providing users with a full-link HD experience in various audio and video interaction scenarios.

You can call the `SetVideoEncoderConfiguration` method to set the expected video encoding resolution in the video encoding parameters configuration.

<div class="alert info">In scenarios such as 1-on-1 video calls and video group chats, the increase in the default resolution affects the aggregate resolution and thus the billing rate. For example, before this release, in a 1-on-1 video call scenario, the default aggregate resolution of subscribed video was 460,800 (640 × 360 × 2) and was billed as HD type; as of this release, the default aggregate resolution in the same scenario is 1,036,800 (960 × 540 × 2) and is billed as Full HD type.</div>

**8. Miscellaneous**

- `OnApiCallExecuted` is deleted. Agora recommends getting the results of the API implementation through relevant channels and media callbacks.

  The `IAudioFrameObserver` class is renamed to `IAudioPcmFrameSink`,thus the prototype of the following methods are updated accordingly:

  - `OnFrame`
  - `RegisterAudioFrameObserver` [1/2] and `RegisterAudioFrameObserver`[2/2] in `IMediaPlayer`

- `EnableDualStreamMode`[1/2] and `EnableDualStreamMode`[2/2] are depredated. Use `SetDualStreamMode`[1/2] and `SetDualStreamMode`[2/2] instead.

- `StartChannelMediaRelay`, `UpdateChannelMediaRelay`, `StartChannelMediaRelayEx` and `UpdateChannelMediaRelayEx` are deprecated. Use `StartOrUpdateChannelMediaRelay`And `StartOrUpdateChannelMediaRelayEx` instead.

#### New features

**1. AI noise reduction**

This release introduces the AI noise reduction function. Once enabled, the SDK automatically detects and reduces background noises. Whether in bustling public venues or real-time competitive arenas that demand lightning-fast responsiveness, this function guarantees optimal audio clarity, providing users with an elevated audio experience. You can enable this function through the newly-introduced `SetAINSMode` method and set the noise reduction mode as balance, aggressive or low latency according to your scenarios.

**2. Enhanced Virtual Background**

To increase the fun of real-time video calls and protect user privacy, this version has enhanced the virtual background feature. You can now set custom backgrounds of various types by calling the `EnableVirtualBackground` method, including:

- Process the background as alpha information without replacement, only separating the portrait and the background. This can be combined with the local video mixing feature to achieve a portrait-in-picture effect.
- Replace the background with various formats of local videos.

**3. Video scenario settings**

This release introduces `SetVideoScenario` for setting the video application scene. The SDK will automatically enable the best practice strategy based on different scenes, adjusting key performance indicators to optimize video quality and improve user experience. Whether it is a formal business meeting or a casual online gathering, this feature ensures that the video quality meets the requirements.

Currently, this feature provides targeted optimizations for real-time video conferencing scenarios, including:

- Automatically activate multiple anti-weak network technologies to enhance the capability and performance of low-quality video streams in meeting scenarios where high bitrates are required, ensuring smoothness when multiple streams are subscribed by the receiving end.
- Monitor the number of subscribers for the high-quality and low-quality video streams in real time, dynamically adjusting the configuration of the high-quality stream and dynamically enabling or disabling the low-quality stream, to save uplink bandwidth and consumption.

**4. Local video mixing**

On Windows, this release adds the `OnLocalVideoTranscoderError` callback. When there is an error in starting or updating the local video mixing, the SDK triggers this callback to report the reason for the failure.

On Android, iOS, and macOS, this release adds the local video mixing feature. You can use the `StartLocalVideoTranscoder` method to mix and render multiple video streams locally, such as camera-captured video, screen sharing streams, video files, images, etc. This allows you to achieve custom layouts and effects, making it easy to create personalized video display effects to meet various scenario requirements, such as remote meetings, live streaming, online education, while also supporting features like portrait-in-picture effect.

Additionally, the SDK provides the `UpdateLocalTranscoderConfiguration` method and the `OnLocalVideoTranscoderError` callback. After enabling local video mixing, you can use the `UpdateLocalTranscoderConfiguration` method to update the video mixing configuration. Where an error occurs in starting the local video mixing or updating the configuration, you can get the reason for the failure through the `OnLocalVideoTranscoderError` callback.

<div class="alert info">Local video mixing requires more CPU resources. Therefore, Agora recommends enabling this function on devices with higher performance.</div>


**5. Cross-device synchronization**

In real-time collaborative singing scenarios, network issues can cause inconsistencies in the downlinks of different client devices. To address this, this release introduces `GetNtpWallTimeInMs`For obtaining the current Network Time Protocol (NTP) time. By using this method to synchronize lyrics and music across multiple client devices, users can achieve synchronized singing and lyricsprogression, resulting in a better collaborative experience.

**6. Instant frame rendering**

This release adds the `EnableInstantMediaRendering` method to enable instant rendering mode for audio and video frames, which can speed up the first video or audio frame rendering after the user joins the channel.

**7. Video rendering tracing**

This release adds the `StartMediaRenderingTracing` and `StartMediaRenderingTracingEx` methods. The SDK starts tracing the rendering status of the video frames in the channel from the moment this method is called and reports information about the event through the `OnVideoRenderingTracingResult` callback.

Agora recommends that you use this method in conjunction with the UI settings (such as buttons and sliders) in your app. For example, call this method at the moment when the user clicks the "Join Channel" button, and then get the indicators in the video frame rendering process through the `OnVideoRenderingTracingResult` callback. This enables developers to facilitate developers to optimize the indicators to improve the user experience.


#### Improvements

**1. Voice changer**

This release introduces the `SetLocalVoiceFormant` method that allows you to adjust the formant ratio to change the timbre of the voice. This method can be used together with the `SetLocalVoicePitch` method to adjust the pitch and timbre of voice at the same time, enabling a wider range of voice transformation effects.


**2. Enhanced screen share (Android, iOS)**

This release adds the `QueryScreenCaptureCapability` method, which is used to query the screen capture capabilities of the current device. To ensure optimal screen sharing performance, particularly in enabling high frame rates like 60 fps, Agora recommends you to query the device's maximum supported frame rate using this method beforehand.

This release also adds the `SetScreenCaptureScenario` method, which is used to set the scenario type for screen sharing. The SDK automatically adjusts the smoothness and clarity of the shared screen based on the scenario type you set.


 **3. Improved compatibility with audio file types (Android)**

As of v4.2.0, you can use the following methods to open files with a URI starting with `Content://` : `StartAudioMixing` [2/2], `PlayEffect` [3/3], `Open`, and `OpenWithMediaSource`.


 **4. Enhanced rendering compatibility (Windows)**

This release enhances the rendering compatibility of the SDK. Issues like black screens caused by rendering failures on certain devices are fixed.

**5. Audio and video synchronization**

For custom video and audio capture scenarios, this release introduces `GetCurrentMonotonicTimeInMs` for obtaining the current Monotonic Time. By passing this value into the timestamps of audio and video frames, developers can accurately control the timing of their audio and video streams, ensuring proper synchronization.


**6. Multi-camera capture and multi-screen capture**

This release introduces `StartScreenCapture` [2/2] (PC only) and `StartCameraCapture`. By calling these methods multiple times and specifying the `sourceType` parameter, developers can start capturing video streams from multiple cameras and screens for local video mixing or multi-channel publishing. This is particularly useful for scenarios such as remote medical care and online education, where multiple cameras and displays need to be connected.

**7. Channel media relay**

This release introduces `StartOrUpdateChannelMediaRelay` and `StartOrUpdateChannelMediaRelayEx`, allowing for a simpler and smoother way to start and update media relay across channels. With these methods, developers can easily start the media relay across channels and update the target channels for media relay with a single method. Additionally, the internal interaction frequency has been optimized, effectively reducing latency in function calls.

**8. Custom audio tracks**

To better meet the needs of custom audio capture scenarios, this release adds `CreateCustomAudioTrack` and `DestroyCustomAudioTrack` for creating and destroying custom audio tracks. Two types of audio tracks are also provided for users to choose from, further improving the flexibility of capturing external audio source:

- Mixable audio track: Supports mixing multiple external audio sources and publishing them to the same channel, suitable for multi-channel audio capture scenarios.
- Direct audio track: Only supports publishing one external audio source to a single channel, suitable for low-latency audio capture scenarios.

**9. Super resolution (Android, iOS)**

This release improves the performance of super resolution. To optimize the usability of super resolution, this release removes `EnableRemoteSuperResolution`; super resolution no longer needs to be enabled manually. The SDK now automatically optimizes the resolution of the remote video based on the performance of the user's device.

#### Issues fixed

This release fixed the following issues:

**Windows**

- When using Agora Media Player to play RTSP video streams, the video images sometimes appeared pixelated.
- Adding an alpha channel to an image in PNG or GIF format failed when the local client mixed video streams.
- After joining the channel, remote users saw a watermark even though the watermark was deleted.
- If a watermark was added after starting screen sharing, the watermark did not display the screen.
- When joining a channel and accessing an external camera, calling `SetDevice` to specify the video capture device as the external camera did not take effect.
- When trying to outline the shared window and put it on top, the shared window did not stay on top of other windows.

**Android**

- Occasional crashes occur on Android devices when users joining or leaving a channel.
- Occational failure when enabling in-ear monitoring.
- Occational echo.
- Crashes occurred after users set the video resolution as 3840 × 2160 and started CDN streaming on Xiaomi Redmi 9A devices.
- In real-time chorus scenarios, remote users heard noises and echoes when an OPPO R11 device joined the channel in loudspeaker mode.
- When the playback of the local music finished, the `OnAudioMixingFinished` callback was not properly triggered.
- When using a video frame observer, the first video frame was occasionally missed on the receiver's end.
- When sharing screens in scenarios involving multiple channels, remote users occasionally saw black screens.
- Switching to the rear camera with the virtual background enabled occasionally caused the background to be inverted.
- Abnormal client status caused by an exception in the `OnRemoteAudioStateChanged` callback.

**iOS**

- Occasional loss of the `OnFirstRemoteVideoFrame` callback during channel media relay.
- The receiver actively subscribed to the high-quality stream but unexpectedly received a low-quality stream.
- Abnormal client status cased by an exception in the `OnRemoteAudioStateChanged` callback.

**macOS**

- The receiver was receiving the low-quality stream originally, and automatically switched to high-quality stream after a few seconds.
- Occasional screen jittering during screen sharing.
- The receiver was receiving the low-quality stream originally, and automatically switched to high-quality stream after a few seconds.
- Occasional screen jittering during screen sharing.
- If the rendering view of the player was set as a UIViewController's view, the video was zoomed from the bottom-left corner to the middle of the screen when entering full-screen mode.
- When joining a channel and accessing an external camera, calling `SetDevice` to specify the video capture device as the external camera did not take effect.

**All platforms**

- When the host frequently switching the user role between broadcaster and audience in a short period of time, the audience members cannot hear the audio of the host.
- Playing audio files with a sample rate of 48 kHz failed.
- When there were multiple video streams in a channel, calling some video enhancement APIs occasionally failed.

#### API changes

**Added**

- `StartCameraCapture`
- `StopCameraCapture`
- `StartScreenCapture`[2/2]  (Windows,macOS)
- `StopScreenCapture`[2/2]  (Windows,macOS)
- `StartOrUpdateChannelMediaRelay`
- `StartOrUpdateChannelMediaRelayEx`
- `GetNtpWallTimeInMs`
- `SetVideoScenario`
- `GetCurrentMonotonicTimeInMs`
- `OnLocalVideoTranscoderError`
- `startLocalVideoTranscoder`（macOS, iOS, Android）
- `updateLocalTranscoderConfiguration`（macOS, iOS, Android）
- `QueryScreenCaptureCapability`  (iOS, Android)
- `SetScreenCaptureScenario`  (iOS, Android)
- `CreateAudioCustomTrack`
- `DestroyAudioCustomTrack`
- `AudioTrackConfig`
- `AUDIO_TRACK_TYPE`
- `VIDEO_APPLICATION_SCENARIO_TYPE`
- `SCREEN_CAPTURE_FRAMERATE_CAPABILITY`
- The `domainLimit` and `autoRegisterAgoraExtensions` members in `RtcEngineContext`
- The `sourceType` parameter in `OnCaptureVideoFrame` and `OnPreEncodeVideoFrame` callbacks
- The `BACKGROUND_NONE` and `BACKGROUND_VIDEO` enumerators in `BACKGROUND_SOURCE_TYPE`
- `EnableInstantMediaRendering`
- `StartMediaRenderingTracing`
- `StartMediaRenderingTracingEx`
- `OnVideoRenderingTracingResult`
- `MEDIA_TRACE_EVENT`
- `VideoRenderingTracingInfo`

**Deprecated**

- `EnableDualStreamMode`[1/2]
- `EnableDualStreamMode`[2/2]
- `StartChannelMediaRelay`
- `StartChannelMediaRelayEx`
- `UpdateChannelMediaRelay`
- `UpdateChannelMediaRelayEx`
- `OnChannelMediaRelayEvent`
- `CHANNEL_MEDIA_RELAY_EVENT`

**Deleted**

- `StartPrimaryScreenCapture`  (Windows)
- `StartSecondaryScreenCapture`  (Windows)
- `StopPrimaryScreenCapture ` (Windows)
- `StopSecondaryScreenCapture ` (Windows)
- `StartPrimaryCameraCapture`  (Windows)
- `StartSecondaryCameraCapture` (Windows/iOS)
- `StopPrimaryCameraCapture`  (Windows)
- `StopSecondaryCameraCapture ` (Windows/iOS)
- `OnApiCallExecuted`
- `PublishCustomAudioTrackEnableAec ` in` ChannelMediaOptions`
- `EnableRemoteSuperResolution`
- `superResolutionType` in `RemoteVideoStats`
