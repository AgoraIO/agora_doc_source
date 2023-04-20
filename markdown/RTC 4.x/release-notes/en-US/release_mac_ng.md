## v4.1.1 

v4.1.1 was released on January xx, 2023.


#### Compatibility changes

**1. Default video encoding resolution**
As of this release, the SDK optimizes the video encoder algorithm and upgrades the default video encoding resolution from 640 × 360 to 960 × 540 to accommodate improvements in device performance and network bandwidth, providing users with a full-link HD experience in various audio and video interaction scenarios.

You can call the `setVideoEncoderConfiguration` method to set the expected video encoding resolution in the video encoding parameters configuration.

<div class="alert note">The increase in the default resolution affects the aggregate resolution and thus the billing rate. See <a href="./billing_rtc_ng">Pricing</a>.</div>

**2. Options for subscribing to remote video streams**
This release changes the name of `setRemoteVideo` to `setRemoteVideoSubscriptionOptions`, and the name of `setRemoteVideoEx` to `setRemoteVideoSubscriptionOptionsEx`. If you upgrade the SDK to this version or later, to avoid affecting your service, ensure that you modify the names of these two methods.



#### New features

**1. Instant frame rendering**

This release adds the `enableInstantMediaRendering` method to enable instant rendering mode for audio and video frames, which can speed up the first video or audio frame rendering after the user joins the channel.

**2. Video rendering tracing**

This release adds the `startMediaRenderingTracing` and `startMediaRenderingTracingEx` methods. The SDK starts tracing the rendering status of the video frames in the channel from the moment this method is called and reports information about the event through the `videoRenderingTracingResultOfUid` callback.

Agora recommends that you use this method in conjunction with the UI settings (such as buttons and sliders) in your app. For example, call this method at the moment when the user clicks the "Join Channel" button, and then get the indicators in the video frame rendering process through the `videoRenderingTracingResultOfUid` callback. This enables developers to facilitate developers to optimize the indicators to improve the user experience.



#### Improvements

**Video frame observer**

As of this release, the SDK optimizes the `onRenderVideoFrame` callback, and the meaning of the return value is different depending on the video processing mode:

- When the video processing mode is `AgoraVideoFrameProcessModeReadOnly`, the return value is reserved for future use.
- When the video processing mode is `AgoraVideoFrameProcessModeReadWrite`, the SDK receives the video frame when the return value is `YES`; the video frame is discarded when the return value is `NO`.



#### Issues fixed

This release fixed the following issues:

- Playing audio files with a sample rate of 48 kHz failed.
- If the rendering view of the player was set as a `UIViewController`'s view, the video was zoomed from the bottom-left corner to the middle of the screen when entering full-screen mode.
- When joining a channel and accessing an external camera, calling `setDevice` to specify the video capture device as the external camera did not take effect.
- When there were multiple video streams in a channel, calling some video enhancement APIs occasionally failed.
- At the moment when a user left a channel, a request for leaving was not sent to the server and the leaving behavior was incorrectly determined by the server as timed out.



#### API changes

**Added**

- `enableInstantMediaRendering`
- `startMediaRenderingTracing`
- `startMediaRenderingTracingEx`
- `videoRenderingTracingResultOfUid`
- `AgoraMediaRenderTraceEvent`
- `VideoRenderingTracingInfo`

**Modified**
- `setRemoteVideo` to `setRemoteVideoSubscriptionOptions`
- `setRemoteVideoEx` to `setRemoteVideoSubscriptionOptionsEx`

**Deleted**

- `enableRemoteSuperResolution`
- Deleted `superResolutionType` in `AgoraRtcRemoteVideoStats`


## v4.1.0

v4.1.0 was released on November xx, 2022.

#### New features

**1. Headphone equalization effect**

This release adds the `setHeadphoneEQParameters` method, which is used to adjust the low- and high-frequency parameters of the headphone EQ. This is mainly useful in spatial audio scenarios. If you cannot achieve the expected headphone EQ effect after calling `setHeadphoneEQPreset`, you can call setHeadphoneEQParameters to adjust the EQ.

**2. Encoded video frame observer**

This release adds the `setRemoteVideo` method in the `AgoraRtcEngineKit` and `AgoraRtcEngineKitEx` classes. When you call the `setEncodedVideoFrameDelegate` method to register a video frame observer for the encoded video frames, the SDK subscribes to the encoded video frames by default. If you want to change the subscription options, you can call these new methods to set them.

For more information about registering video observers and subscription options, see the API reference.

**3. MPUDP (MultiPath UDP) (Beta)**

As of this release, the SDK supports MPUDP protocol, which enables you to connect and use multiple paths to maximize the use of channel resources based on the UDP protocol. You can use different physical NICs on both mobile and desktop and aggregate them to effectively combat network jitter and improve transmission quality.

To enable this feature, contact [sales-us@agora.io](https://docs.agora.io/cn/video-call-4.x/sales-us@agora.io).

**4. Device management**

This release adds a series of callbacks to help you better understand the status of your audio and video devices:

- `onVideoDeviceStateChanged` (C++) : Occurs when the status of the video device changes. 
- `onAudioDeviceStateChanged`(C++) : Occurs when the status of the audio device changes. 
- `onAudioDeviceVolumeChanged` (C++) : Occurs when the volume of an audio device or app changes. 

**5. Camera capture options**

This release adds the `followEncodeDimensionRatio` member in `AgoraCameraCapturerConfiguration`, which enables you to set whether to follow the video aspect ratio already set in `setVideoEncoderConfiguration` when capturing video with the camera.

**6. Multi-channel management**

This release adds a series of multi-channel related methods that you can call to manage audio and video streams in multi-channel scenarios.

- The `muteLocalAudioStreamEx` and `muteLocalVideoStreamEx` methods are used to cancel or resume publishing a local audio or video stream, respectively.
- The `muteAllRemoteAudioStreamsEx` and `muteAllRemoteVideoStreamsEx` are used to cancel or resume the subscription of all remote users to audio or video streams, respectively.
- The `startRtmpStreamWithoutTranscodingEx`, `startRtmpStreamWithTranscodingEx`, `updateRtmpTranscodingEx`, and `stopRtmpStreamEx` methods are used to implement Media Push in multi-channel scenarios.
- The `startChannelMediaRelayEx`, `updateChannelMediaRelayEx`, `pauseAllChannelMediaRelayEx`, `resumeAllChannelMediaRelayEx`, and `stopChannelMediaRelayEx` methods are used to relay media streams across channels in multi-channel scenarios.
- Adds the `leaveChannelEx` [2/2] method. Compared with the `leaveChannelEx` [1/2] method, a new `options` parameter is added, which is used to choose whether to stop recording with the microphone when leaving a channel in a multi-channel scenario.

**7. Video encoding preferences**

In general scenarios, the default video encoding configuration meets most requirements. For certain specific scenarios, this release adds the `advancedVideoOptions` member in `AgoraVideoEncoderConfiguration` for advanced settings of video encoding properties:

- `compressionPreference`: The compression preferences for video encoding, which is used to select low-latency or high-quality video preferences.
- `encodingPreference`: The video encoder preference, which is used to select adaptive preference, software encoder preference, or hardware encoder video preferences.

**8. Client role switching**

In order to enable users to know whether the switched user role is low-latency or ultra-low-latency, this release adds the `newRoleOptions` parameter to the `didClientRoleChanged` callback. The value of this parameter is as follows:

- `AgoraAudienceLatencyLevelLowLatency` (1): Low latency.
- `AgoraAudienceLatencyLevelUltraLowLatency` (2): Ultra-low latency.

#### Improvements 

**1. Screen sharing**

In addition to the usability enhancements detailed in the fixed issued section, this release includes a number of functional improvements to screen sharing, as follows:

- Compatibility with additional devices and scenarios, including: dual graphics devices and screen sharing using external screens.
- Support for Ultra HD video (4K, 60 fps) on devices that meet the requirements. Agora recommends a 2021 16" M1 Macbook Pro or better. 

**2. Relaying media streams across channels**

This release optimizes the `updateChannelMediaRelay` method as follows:

- Before v4.1.0: If the target channel update fails due to internal reasons in the server, the SDK returns the error code `AgoraChannelMediaRelayEventUpdateDestinationChannelRefused`(8), and you need to call the `updateChannelMediaRelay` method again.
- v4.1.0 and later: If the target channel update fails due to internal server reasons, the SDK retries the update until the target channel update is successful.

**3. Reconstructed AIAEC algorithm**

This release reconstructs the AEC algorithm based on the AI method. Compared with the traditional AEC algorithm, the new algorithm can preserve the complete, clear, and smooth near-end vocals under poor echo-to-signal conditions, significantly improving the system's echo cancellation and dual-talk performance. This gives users a more comfortable call and live-broadcast experience. AIAEC is suitable for conference calls, chats, karaoke, and other scenarios.

**4. Virtual background**

This release optimizes the virtual background algorithm. Improvements include the following:

- The boundaries of virtual backgrounds are handled in a more nuanced way and image matting is is now extremely thin.
- The stability of the virtual background is improved whether the portrait is still or moving, effectively eliminating the problem of background flickering and exceeding the range of the picture.
- More application scenarios are now supported, and a user obtains a good virtual background effect day or night, indoors or out.
- A larger variety of postures are now recognized, when half the body is motionless, the body is shaking, the hands are swinging, or there is fine finger movement. This helps to achieve a good virtual background effect in conjunction with many different gestures.

#### **Other improvements**

This release includes the following additional improvements:

- Reduces the latency when pushing external audio sources.
- Improves the performance of echo cancellation when using the `AgoraAudioScenarioMeeting` scenario.
- Improves the smoothness of SDK video rendering.
- Reduces the CPU usage and power consumption of the local device when the host calls the `muteLocalVideoStream` method. 
- Enhances the ability to identify different network protocol stacks and improves the SDK's access capabilities in multiple-operator network scenarios.

#### **Issues fixed**

This release fixed the following issues:

- In screen sharing scenarios on Mac devices, when the user minimized or closed a shared application window, another window of the same application was automatically shared. 
- In screen sharing scenarios, the system volume of the local user occasionally decreased. 
- In screen sharing scenarios, the shared window of a split screen was not highlighted correctly. 
- In screen sharing scenarios, the screen seen by the remote user occasionally crashed, lagged, or displayed a black screen. 
- The uplink network quality reported by the `networkQuality` callback was inaccurate for the user who was sharing a screen.
- After starting and stopping the audio capture device test, there was no sound when the audio playback device was subsequently started. 
- Audience members heard buzzing noises when the host switched between speakers and earphones during live streaming.
- The `didVideoPublishStateChange` callback reported an inaccurate video source type. 
- The call `getExtensionProperty` failed and returned an empty string. 
- When entering a live streaming room that has been played for a long time as an audience, the time for the first frame to be rendered was shortened.

#### **API changes**

**Added**

- `setHeadphoneEQParameters`
- `setRemoteVideoSubscriptionOptions`
- `setRemoteVideoSubscriptionOptionsEx`
- `AgoraVideoSubscriptionOptions`
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
- `followEncodeDimensionRatio` in `AgoraCameraCapturerConfiguration` 
- `hwEncoderAccelerating` in `AgoraRtcLocalVideoStats` 
- `leaveChannelEx` [2/2]
- `advancedVideoOptions` in `AgoraVideoEncoderConfiguration` 
- `newRoleOptions` in `didClientRoleChanged` 
- `adjustUserPlaybackSignalVolumeEx`
- `enableAudioVolumeIndicationEx`

**Deprecated**

- `didApiCallExecute`. Use the callbacks triggered by specific methods instead.

**Deleted**

- Removes deprecated member parameters `backgroundImage` and `watermark` in `AgoraLiveTranscoding` class.
- Removes `AgoraChannelMediaRelayEventUpdateDestinationChannelRefused`(8) in `didReceiveChannelMediaRelayEvent` callback.

## v4.0.0

#### New features

**2. Ultra HD resolution (Beta)**

In order to improve the interactive video experience, the SDK optimizes the whole process of video capture, encoding, decoding and rendering, and now supports 4K resolution. The improved FEC (Forward Error Correction) algorithm enables adaptive switches according to the frame rate and number of video frame packets, which further reduces the video stuttering rate in 4K scenes.

Additionally, you can set the encoding resolution to 4K (3840 × 2160) and the frame rate to 60 fps when calling `setVideoEncoderConfiguration`. The SDK supports automatic fallback to the appropriate resolution and frame rate if your device does not support 4K.

<div class="alert info"><li>This feature has certain requirements with regards to device performance and network bandwidth, and the supported upstream and downstream frame rates vary on different platforms. To experience this feature, contact [support@agora.io](mailto:support@agora.io).
<li>The increase in the default resolution affects the aggregate resolution and thus the billing rate. See <a href="./billing_rtc_ng">Pricing</a>.</div>
