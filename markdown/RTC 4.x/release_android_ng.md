## v4.1.0

v4.1.0 was released on November xx, 2022.

#### New features

**1. Headphone equalization effect**

This release adds the `setHeadphoneEQParameters` method, which is used to adjust the low- and high-frequency parameters of the headphone EQ. This is mainly useful in spatial audio scenarios. If you cannot achieve the expected headphone EQ effect after calling `setHeadphoneEQPreset`, you can call setHeadphoneEQParameters to adjust the EQ.

**2. Encoded video frame observer**

This release adds the `setRemoteVideoSubscriptionOptions` and `setRemoteVideoSubscriptionOptionsEx` methods. When you call the `registerVideoEncodedFrameObserver` method to register a video frame observer for the encoded video frames, the SDK subscribes to the encoded video frames by default. If you want to change the subscription options, you can call these new methods to set them.

For more information about registering video observers and subscription options, see the [API reference](./API%20Reference/java_ng/API/toc_video_observer.html#api_imediaengine_registervideoencodedframeobserver).

**3. MPUDP (MultiPath UDP)**

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


**Other improvements**

This release includes the following additional improvements:

- Reduces the latency when pushing external audio sources.
- Improves the performance of echo cancellation when using the `AUDIO_SCENARIO_MEETING` scenario.
- Improves the smoothness of SDK video rendering.
- Enhances the ability to identify different network protocol stacks and improves the SDK's access capabilities in multiple-operator network scenarios.

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