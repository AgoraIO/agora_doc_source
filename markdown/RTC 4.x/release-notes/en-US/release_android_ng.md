## v4.2.0

v4.2.0 was released on May 23, 2023.

#### Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

**1. Video data acquisition**

The `onCaptureVideoFrame` and `onPreEncodeVideoFrame` callbacks are added with a new parameter called `sourceType`, which is used to indicate the specific video source type.

**2. Channel media options**

- `publishCustomAudioTrackEnableAec` is deleted. Use `publishCustomAudioTrack` instead.
- `publishTrancodedVideoTrack` is renamed to `publishTranscodedVideoTrack`.
- `publishCustomAudioSourceId` is renamed to `publishCustomAudioTrackId`.

**3. Miscellaneous**

- `onApiCallExecuted` is deleted. Agora recommends getting the results of the API implementation through relevant channels and media callbacks.
- `enableDualStreamMode`[1/2] and `enableDualStreamMode`[2/2] are depredated. Use setDualStreamMode[1/2] and setDualStreamMode[2/2] instead.
- `startChannelMediaRelay`, `updateChannelMediaRelay`, `startChannelMediaRelayEx` and `updateChannelMediaRelayEx` are deprecated. Use `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx` instead.


#### New features

**1. AI noise reduction**

This release introduces the AI noise reduction function. Once enabled, the SDK automatically detects and reduces background noises. Whether in bustling public venues or real-time competitive arenas that demand lightning-fast responsiveness, this function guarantees optimal audio clarity, providing users with an elevated audio experience. You can enable this function through the newly-introduced `setAINSMode` method and set the noise reduction mode as balance, aggressive or low latency according to your scenarios.

**2. Enhanced Virtual Background**

To increase the fun of real-time video calls and protect user privacy, this version has enhanced the virtual background feature. You can now set custom backgrounds of various types by calling the `enableVirtualBackground` method, including:

- Process the background as alpha information without replacement, only separating the portrait and the background. This can be combined with the local video mixing feature to achieve a portrait-in-picture effect.  
- Replace the background with various formats of local videos.

**3. Video scenario settings**

This release introduces `setVideoScenario` for setting the video application scene. The SDK will automatically enable the best practice strategy based on different scenes, adjusting key performance indicators to optimize video quality and improve user experience. Whether it is a formal business meeting or a casual online gathering, this feature ensures that the video quality meets the requirements.

Currently, this feature provides targeted optimizations for real-time video conferencing scenarios, including:

- Automatically activate multiple anti-weak network technologies to enhance the capability and performance of low-quality video streams in meeting scenarios where high bitrate are required, ensuring smoothness when multiple streams are subscribed by the receiving end.
- Monitor the number of subscribers for the high-quality and low-quality video streams in real time, dynamically adjusting the configuration of the high-quality stream and dynamically enabling or disabling the low-quality stream, to save uplink bandwidth and consumption.

**4. Local video mixing**

This release adds the local video mixing feature. You can use the `startLocalVideoTranscoder` method to mix and render multiple video streams locally, such as camera-captured video, screen sharing streams, video files, images, etc. This allows you to achieve custom layouts and effects, making it easy to create personalized video display effects to meet various scenario requirements, such as remote meetings, live streaming, online education, while also supporting features like portrait-in-picture effect.

Additionally, the SDK provides the `updateLocalTranscoderConfiguration` method and the `onLocalVideoTranscoderError` callback. After enabling local video mixing, you can use the `updateLocalTranscoderConfiguration` method to update the video mixing configuration. Where an error occurs in starting the local video mixing or updating the configuration, you can get the reason for the failure through the `onLocalVideoTranscoderError` callback.

<div class="alert note">Local video mixing requires more CPU resources. Therefore, Agora recommends enabling this function on devices with higher performance.</div>

**5. Cross-device synchronization**

In real-time collaborative singing scenarios, network issues can cause inconsistencies in the downlinks of different client devices. To address this, this release introduces `getNtpWallTimeInMs` for obtaining the current Network Time Protocol (NTP) time. By using this method to synchronize lyrics and music across multiple client devices, users can achieve synchronized singing and lyrics progression, resulting in a better collaborative experience.


#### Improvements

**1. Improved voice changer**

This release introduces the `setLocalVoiceFormant` method that allows you to adjust the formant ratio to change the timbre of the voice. This method can be used together with the `setLocalVoicePitch` method to adjust the pitch and timbre of voice at the same time, enabling a wider range of voice transformation effects.

**2. Enhanced screen share**

This release adds the `queryScreenCaptureCapability` method, which is used to query the screen capture capabilities of the current device. To ensure optimal screen sharing performance, particularly in enabling high frame rates like 60 fps, Agora recommends you to query the device's maximum supported frame rate using this method beforehand. 

This release also adds the `setScreenCaptureScenario` method, which is used to set the scenario type for screen sharing. The SDK automatically adjusts the smoothness and clarity of the shared screen based on the scenario type you set.

**3. Improved compatibility with audio file types**

As of v4.2.0, you can use the following methods to open files with a URI starting with `content://`:
- `startAudioMixing` [2/2]
- `playEffect` [3/3]
- `open` [2/2]
- `openWithMediaSource`

**4. Audio and video synchronization**

For custom video and audio capture scenarios, this release introduces `getCurrentMonotonicTimeInMs` for obtaining the current Monotonic Time. By passing this value into the timestamps of audio and video frames, developers can accurately control the timing of their audio and video streams, ensuring proper synchronization.

**5. Multi-camera capture**

This release introduces `startCameraCapture`. By calling this method multiple times and specifying the `sourceType` parameter, developers can start capturing video streams from multiple cameras for local video mixing or multi-channel publishing. This is particularly useful for scenarios such as remote medical care and online education, where multiple cameras need to be connected.

**6. Channel media relay**

This release introduces `startOrUpdateChannleMediaRelay` and `startOrUpdateChannleMediaRelayEx`, allowing for a simpler and smoother way to start and update media relay across channels. With these methods, developers can easily start the media relay across channels and update the target channels for media relay with a single method. Additionally, the internal interaction frequency has been optimized, effectively reducing latency in function calls.

**7. Custom audio tracks**

To better meet the needs of custom audio capture scenarios, this release adds `createCustomAudioTrack` and `destroyCustomAudioTrack` for creating and destroying custom audio tracks. Two types of audio tracks are also provided for users to choose from, further improving the flexibility of capturing external audio source:

- Mixable audio track: Supports mixing multiple external audio sources and publishing them to the same channel, suitable for multi-channel audio capture scenarios.
- Direct audio track: Only supports publishing one external audio source to a single channel, suitable for low-latency audio capture scenarios.


#### Issues fixed

This release fixed the following issues:

- Occasional crashes occur on Android devices when users joining or leaving a channel.
- When the host frequently switching the user role between broadcaster and audience in a short period of time, the audience members cannot hear the audio of the host.
- Occasional failure when enabling in-ear monitoring.
- Occasional echo.
- Abnormal client status cased by an exception in the `onRemoteAudioStateChanged` callback.


#### API changes

**Added**

- `startCameraCapture`
- `stopCameraCapture`
- `startOrUpdateChannelMediaRelay`
- `startOrUpdateChannelMediaRelayEx`
- `getNtpWallTimeInMs`
- `setVideoScenario`
- `getCurrentMonotonicTimeInMs`
- `startLocalVideoTranscoder`
- `updateLocalTranscoderConfiguration`
- `onLocalVideoTranscoderError`
- `queryScreenCaptureCapability`
- `setScreenCaptureScenario`
- `setAINSMode`
- `createAudioCustomTrack`
- `destroyAudioCustomTrack`
- `AudioTrackConfig`
- `AudioTrackType`
- `VideoScenario`
- The `mDomainLimit` and `mAutoRegisterAgoraExtensions` members in `RtcEngineConfig`
- The `sourceType` parameter in `onCaptureVideoFrame` and `onPreEncodeVideoFrame` callbacks
- `BACKGROUND_NONE`(0)
- `BACKGROUND_VIDEO`(4)

**Deprecated**

- `enableDualStreamMode`[1/2]
- `enableDualStreamMode`[2/2]
- `startChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelay`
- `updateChannelMediaRelayEx`
- `onChannelMediaRelayEvent`

**Deleted**

- `onApiCallExecuted`
- `publishCustomAudioTrackEnableAec` in `ChannelMediaOptions`


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
