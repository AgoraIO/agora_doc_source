## v4.1.1

v4.1.1 was released on January xx, 2023.

#### Compatibility changes

As of this release, the SDK optimizes the video encoder algorithm and upgrades the default video encoding resolution from 640 × 360 to 960 × 540 to accommodate improvements in device performance and network bandwidth, providing users with a full-link HD experience in various audio and video interaction scenarios.

You can call the `setVideoEncoderConfiguration` method to set the expected video encoding resolution in the video encoding parameters configuration.

<div class="alert note">The increase in the default resolution affects the aggregate resolution and thus the billing rate. See <a href="./billing_rtc_ng">Pricing</a>.</div>


#### New features

**1. Instant frame rendering**

This release adds the `enableInstantMediaRendering` method to enable instant rendering mode for audio and video frames, which can speed up the first video or audio frame rendering after the user joins the channel.

**2. Video rendering tracing**

This release adds the `startMediaRenderingTracing` and `startMediaRenderingTracingEx` methods. The SDK starts tracing the rendering status of the video frames in the channel from the moment this method is called and reports information about the event through the `onVideoRenderingTracingResult` callback.

Agora recommends that you use this method in conjunction with the UI settings (such as buttons and sliders) in your app. For example, call this method at the moment when the user clicks the "Join Channel" button, and then get the indicators in the video frame rendering process through the `onVideoRenderingTracingResult` callback. This enables developers to facilitate developers to optimize the indicators to improve the user experience.



#### Improvements

**1. Video frame observer**

As of this release, the SDK optimizes the `onRenderVideoFrame` callback, and the meaning of the return value is different depending on the video processing mode:

- When the video processing mode is `PROCESS_MODE_READ_ONLY`, the return value is reserved for future use.
- When the video processing mode is `PROCESS_MODE_READ_WRITE`, the SDK receives the video frame when the return value is `true`; the video frame is discarded when the return value is `false`.

**2. Super resolution**

This release improves the performance of super resolution. To optimize the usability of super resolution, this release removes `enableRemoteSuperResolution`. Super resolution is now included in the online strategies of video quality enhancement which does not require extra configuration.



#### Issues fixed

This release fixed the following issues:

- Playing audio files with a sample rate of 48 kHz failed.
- Crashes occurred after users set the video resolution as 3840 × 2160 and started CDN streaming on Xiaomi Redmi 9A devices.
- In real-time chorus scenarios, remote users heard noises and echoes when an OPPO R11 device joined the channel in loudspeaker mode.
- When the playback of the local music finished, the `onAudioMixingFinished` callback was not properly triggered.
- When using a video frame observer, the first video frame was occasionally missed on the receiver's end.
- When sharing screens in scenarios involving multiple channels, remote users occasionally saw black screens.
- Switching to the rear camera with the virtual background enabled occasionally caused the background to be inverted.
- When there were multiple video streams in a channel, calling some video enhancement APIs occasionally failed. 



#### API changes

**Added**

- `enableInstantMediaRendering`
- `startMediaRenderingTracing`
- `startMediaRenderingTracingEx`
- `onVideoRenderingTracingResult`
- `MEDIA_RENDER_TRACE_EVENT`
- `VideoRenderingTracingInfo`

**Deleted**

- `enableRemoteSuperResolution`
- Deleted `superResolutionType` in `RemoteVideoStats`
## v4.1.0-1

v4.1.0-1 was released on November xx, 2022.

#### New features

**1. Headphone equalization effect**

This release adds the `setHeadphoneEQParameters` method, which is used to adjust the low- and high-frequency parameters of the headphone EQ. This is mainly useful in spatial audio scenarios. If you cannot achieve the expected headphone EQ effect after calling `setHeadphoneEQPreset`, you can call `setHeadphoneEQParameters` to adjust the EQ.

**2. Encoded video frame observer**

This release adds the `setRemoteVideoSubscriptionOptions` and `setRemoteVideoSubscriptionOptionsEx` methods. When you call the `registerVideoEncodedFrameObserver` method to register a video frame observer for the encoded video frames, the SDK subscribes to the encoded video frames by default. If you want to change the subscription options, you can call these new methods to set them.

For more information about registering video observers and subscription options, see the [API reference](./API%20Reference/java_ng/API/toc_video_observer.html#api_imediaengine_registervideoencodedframeobserver).

**3. MPUDP (MultiPath UDP) (Beta)**

As of this release, the SDK supports MPUDP protocol, which enables you to connect and use multiple paths to maximize the use of channel resources based on the UDP protocol. You can use different physical NICs on both mobile and desktop and aggregate them to effectively combat network jitter and improve transmission quality.

<div class="alert info">To enable this feature, contact <a href="mailto:sales-us@agora.io">sales-us@agora.io</a>.

**4. Camera capture options**

This release adds the `followEncodeDimensionRatio` member in `CameraCapturerConfiguration`, which enables you to set whether to follow the video aspect ratio already set in `setVideoEncoderConfiguration` when capturing video with the camera.

**5. Multi-channel management**

This release adds a series of multi-channel related methods that you can call to manage audio and video streams in multi-channel scenarios.

- The `muteLocalAudioStreamEx` and `muteLocalVideoStreamEx` methods are used to cancel or resume publishing a local audio or video stream, respectively.
- The `muteAllRemoteAudioStreamsEx` and `muteAllRemoteVideoStreamsEx` are used to cancel or resume the subscription of all remote users to audio or video streams, respectively.
- The `startRtmpStreamWithoutTranscodingEx`, `startRtmpStreamWithTranscodingEx`, `updateRtmpTranscodingEx`, and `stopRtmpStreamEx` methods are used to implement Media Push in multi-channel scenarios.
- The `startChannelMediaRelayEx`, `updateChannelMediaRelayEx`, `pauseAllChannelMediaRelayEx`, `resumeAllChannelMediaRelayEx`, and `stopChannelMediaRelayEx` methods are used to relay media streams across channels in multi-channel scenarios.
- Adds the `leaveChannelEx` [2/2] method. Compared with the `leaveChannelEx` [1/2] method, a new options parameter is added, which is used to choose whether to stop recording with the microphone when leaving a channel in a multi-channel scenario.

**6. Video encoding preferences**

In general scenarios, the default video encoding configuration meets most requirements. For certain specific scenarios, this release adds the `advanceOptions` member in `VideoEncoderConfiguration` for advanced settings of video encoding properties:

- `compressionPreference`: The compression preferences for video encoding, which is used to select low-latency or high-quality video preferences.
- `encodingPreference`: The video encoder preference, which is used to select adaptive preference, software encoder preference, or hardware encoder video preferences.

**7. Client role switching**

In order to enable users to know whether the switched user role is low-latency or ultra-low-latency, this release adds the `newRoleOptions` parameter to the `onClientRoleChanged` callback. The value of this parameter is as follows:

- `AUDIENCE_LATENCY_LEVEL_LOW_LATENCY` (1): Low latency.
- `AUDIENCE_LATENCY_LEVEL_ULTRA_LOW_LATENCY` (2): Ultra-low latency.

#### Improvements 

**1. Bluetooth permissions**

To simplify integration, as of this release, you can use the SDK to enable Android users to use Bluetooth normally without adding the `BLUETOOTH_CONNECT` permission.

**2. CDN streaming**

To improve user experience during CDN streaming, when your camera does not support the video resolution you set when streaming, the SDK automatically adjusts the resolution to the closest value that is supported by your camera and has the same aspect ratio as the original video resolution you set. The actual video resolution used by the SDK for streaming can be obtained through the `onDirectCdnStreamingStats` callback.

**3. Relaying media streams across channels**

This release optimizes the `updateChannelMediaRelay` method as follows:

- Before v4.1.0: If the target channel update fails due to internal reasons in the server, the SDK returns the error code `RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_REFUSED`(8), and you need to call the `updateChannelMediaRelay` method again.
- v4.1.0 and later: If the target channel update fails due to internal server reasons, the SDK retries the update until the target channel update is successful.

**4. Reconstructed AIAEC algorithm**

This release reconstructs the AEC algorithm based on the AI method. Compared with the traditional AEC algorithm, the new algorithm can preserve the complete, clear, and smooth near-end vocals under poor echo-to-signal conditions, significantly improving the system's echo cancellation and dual-talk performance. This gives users a more comfortable call and live-broadcast experience. AIAEC is suitable for conference calls, chats, karaoke, and other scenarios.

**5. Virtual background**

This release optimizes the virtual background algorithm. Improvements include the following:

- The boundaries of virtual backgrounds are handled in a more nuanced way and image matting is is now extremely thin.
- The stability of the virtual background is improved whether the portrait is still or moving, effectively eliminating the problem of background flickering and exceeding the range of the picture.
- More application scenarios are now supported, and a user obtains a good virtual background effect day or night, indoors or out.
- A larger variety of postures are now recognized, when half the body is motionless, the body is shaking, the hands are swinging, or there is fine finger movement. This helps to achieve a good virtual background effect in conjunction with many different gestures.


**Other improvements**

This release includes the following additional improvements:

- Reduces the latency when pushing external audio sources.
- Improves the performance of echo cancellation when using the `AUDIO_SCENARIO_MEETING` scenario.
- Improves the smoothness of SDK video rendering.
- Enhances the ability to identify different network protocol stacks and improves the SDK's access capabilities in multiple-operator network scenarios.
- At the moment when a user left a channel, a request for leaving was not sent to the server and the leaving behavior was incorrectly determined by the server as timed out.

#### Issues fixed

This release fixed the following issues:

- Audience members heard buzzing noises when the host switched between speakers and earphones during live streaming.
- The call `getExtensionProperty` failed and returned an empty string. 
- When entering a live streaming room that has been played for a long time as an audience, the time for the first frame to be rendered was shortened.

#### API changes

**Added**

- `setHeadphoneEQParameters`

- `setRemoteVideoSubscriptionOptions`

- `setRemoteVideoSubscriptionOptionsEx`

- `VideoSubscriptionOptions`

- `leaveChannelEx` [2/2]

- `muteLocalAudioStreamEx`

- `muteLocalVideoStreamEx`

- `muteAllRemoteAudioStreamsEx`

- `muteAllRemoteVideoStreamsEx`

- `startRtmpStreamWithoutTranscodingEx`

- `startRtmpStreamWithTranscodingEx`

- `updateRtmpTranscodingEx`

- `stopRtmpStreamEx`

- `startChannelMediaRelayEx`

- `updateChannelMediaRelayEx`

- `pauseAllChannelMediaRelayEx`

- `resumeAllChannelMediaRelayEx`

- `stopChannelMediaRelayEx`

- `followEncodeDimensionRatio` in `CameraCapturerConfiguration`

- `hwEncoderAccelerating` in `LocalVideoStats` 

- `advanceOptions` in `VideoEncoderConfiguration`

- `newRoleOptions` in `onClientRoleChanged`

- `adjustUserPlaybackSignalVolumeEx`

- `IAgoraMusicContentCenter` interface class and methods in it

- `IAgoraMusicPlayer` interface class and methods in it

- `IMusicContentCenterEventHandler` interface class and callbacks in it

- `Music` class

- `MusicChartInfo` class

- `MusicContentCenterConfiguration` class

- `MvProperty` class

- `ClimaxSegment` class

**Deprecated**

- `onApiCallExecuted`. Use the callbacks triggered by specific methods instead.

**Deleted**

- Removes deprecated member parameters `backgroundImage` and `watermark` in `LiveTranscoding` class.
- Removes `RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_REFUSED`(8) in `onChannelMediaRelayEvent` callback.

## v4.0.0

v4.0.0 was released on September 15, 2022.

#### New features


**2. Full HD and Ultra HD resolution**

In order to improve the interactive video experience, the SDK optimizes the whole process of video capturing, encoding, decoding and rendering. Starting from this version, it supports Full HD (FHD) and Ultra HD (UHD) video resolutions. You can set the `dimensions` parameter to 1920 × 1080 or higher resolution when calling the `setVideoEncoderConfiguration` method. If your device does not support high resolutions, the SDK will automatically fall back to an appropriate resolution.

<div class="alert info"><li>The UHD resolution (4K, 60 fps) is currently in beta and requires certain device performance and network bandwidth. If you want to experience this feature, contact <a href="mailto:support@agora.io">technical support</a>.
<li>High resolution typically means higher performance consumption. To avoid a decrease in experience due to insufficient device performance, Agora recommends that you enable FHD and UHD video resolutions on devices with better performance.
<li>The increase in the default resolution affects the aggregate resolution and thus the billing rate. See <a href="./billing_rtc_ng">Pricing</a>.</div>
