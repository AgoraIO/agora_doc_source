## v4.1.0

v4.1.0 was released on November xx, 2022.

#### Compatibility changes

This release deletes the `EnableDualStreamMode` [2/3] method and the `sourceType` parameter in `EnableDualStreamMode` [3/3], because the SDK supports enabling dual-stream mode for various video sources captured by custom capture or SDK; you no longer need to specify the video source type.

#### New features

**1. In-ear monitoring**

This release adds support for in-ear monitoring. You can call `EnableInEarMonitoring` to enable the in-ear monitoring function.

After successfully enabling the in-ear monitoring function, you can call `RegisterAudioFrameObserver` to register the audio observer, and the SDK triggers the `OnEarMonitoringAudioFrame` callback to report the audio frame data. You can use your own audio effect processing module to preprocess the audio frame data of the in-ear monitoring to implement custom audio effects. Agora recommends that you choose one of the following two methods to set the audio data format of the in-ear monitoring:

- Call the `SetEarMonitoringAudioFrameParameters` method to set the audio data format of in-ear monitoring. The SDK calculates the sampling interval based on the parameters in this method and triggers the `OnEarMonitoringAudioFrame` callback based on the sampling interval.
- Set the audio data format in the return value of the `GetEarMonitoringAudioParams` callback. The SDK calculates the sampling interval based on the return value of the callback and triggers the `OnEarMonitoringAudioFrame` callback based on the sampling interval.

To adjust the in-ear monitoring volume, you can call `SetInEarMonitoringVolume`.

**2. Audio capture device test (Android)**

This release adds support for testing local audio capture devices before joining a channel. You can call `StartRecordingDeviceTest` to start the audio capture device test. After the test is complete, call the `StopPlaybackDeviceTest` method to stop the audio capture device test.

**3. Local network connection types**

To make it easier for users to know the connection type of the local network at any stage, this release adds the `GetNetworkType` method. You can use this method to get the type of network connection in use. The available values are UNKNOWN, DISCONNECTED, LAN, WIFI, 2G, 3G, 4G, and 5G. When the local network connection type changes, the SDK triggers the `OnNetworkTypeChanged` callback to report the current network connection type.

**4. Audio stream filter**

This release introduces filtering audio streams based on volume. Once this function is enabled, the Agora server ranks all audio streams by volume and transports the three audio streams with the highest volumes to the receivers by default. The number of audio streams to be transported can be adjusted; contact [support@agora.io](support@agora.io) to adjust this number according to your scenarios. 

Agora also supports publishers in choosing whether the audio streams being published are to be filtered based on volume. Streams that are not filtered bypass this filter mechanism and are transported directly to the receivers. In scenarios with a number of publishers, enabling this function helps reduce the bandwidth and device system pressure for the receivers.

<div class="alert info">To enable this function, contact <a href="support@agora.io">support@agora.io</a>.</div>

**5. Dual-stream mode**

This release optimizes the dual-stream mode. You can call `EnableDualStreamMode` and `EnableDualStreamModeEx` before and after joining a channel.

The implementation of subscribing to a low-quality video stream is expanded. The SDK enables the low-quality video stream auto mode on the sender by default (the SDK does not send low-quality video streams). Follow these steps to enable sending low-quality video streams:

1. The host at the receiving end calls `SetRemoteVideoStreamType` or `SetRemoteDefaultVideoStreamType` to initiate a low-quality video stream request.
2. After receiving the application, the sender automatically switches to sending low-quality video stream mode.

If you want to modify this default behavior, you can call `SetDualStreamMode`[1/2] or `SetDualStreamMode`[2/2] and set the `mode` parameter to `DISABLE_SIMULCAST_STREAM` (never send low-quality video streams) or `ENABLE_SIMULCAST_STREAM` (always send low-quality video streams).

**6. Loopback device (Windows)** 

The SDK uses the playback device as the loopback device by default. As of 4.1.0, you can specify a loopback device separately and publish the captured audio to the remote end.

- `SetLoopbackDevice`: Specifies the loopback device. If you do not want the current playback device to be the loopback device, you can call this method to specify another device as the loopback device.
- `GetLoopbackDevice`: Gets the current loopback device.
- `FollowSystemLoopbackDevice`: Whether the loopback device follows the default playback device of the system.

**7. Spatial audio effect**

This release adds the following features applicable to spatial audio effect scenarios, which can effectively enhance the user's sense-of-presence experience in virtual interactive scenarios.

- Sound insulation area: You can set a sound insulation area and sound attenuation parameter by calling `SetZones`. When the sound source (which can be a user or the media player) and the listener belong to the inside and outside of the sound insulation area, the listener experiences an attenuation effect similar to that of the sound in the real environment when it encounters a building partition. You can also set the sound attenuation parameter for the media player and the user by calling `SetPlayerAttenuation` and `SetRemoteAudioAttenuation` respectively, and specify whether to use that setting to force an override of the sound attenuation parameter in `SetZones`.
- Doppler sound: You can enable Doppler sound by setting the `enable_doppler` parameter in `SpatialAudioParams`. The receiver experiences noticeable tonal changes in the event of a high-speed relative displacement between the source source and receiver (such as in a racing game scenario).
- Headphone equalizer: You can use a preset headphone equalization effect by calling the `SetHeadphoneEQPreset` method to improve the audio experience for users with headphones.

**8. Multiple cameras for video capture (iOS)**

This release supports multi-camera video capture. You can call `EnableMultiCamera` to enable multi-camera capture mode, call `StartSecondaryCameraCapture` to start capturing video from the second camera, and then publish the captured video to the second channel.

To stop using multi-camera capture, you need to call `StopSecondaryCameraCapture` to stop the second camera capture, then call `EnableMultiCamera` and set `enabled` to `false`.

**9. Headphone equalization effect**

This release adds the `SetHeadphoneEQParameters` method, which is used to adjust the low- and high-frequency parameters of the headphone EQ. This is mainly useful in spatial audio scenarios. If you cannot achieve the expected headphone EQ effect after calling `SetHeadphoneEQPreset`, you can call setHeadphoneEQParameters to adjust the EQ.

**10. Encoded video frame observer**

This release adds the `SetRemoteVideoSubscriptionOptions` and `SetRemoteVideoSubscriptionOptionsEx` methods. When you call the `RegisterVideoEncodedFrameObserver` method to register a video frame observer for the encoded video frames, the SDK subscribes to the encoded video frames by default. If you want to change the subscription options, you can call these new methods to set them.

For more information about registering video observers and subscription options, see API reference.

**11. MPUDP (MultiPath UDP) (Beta)** 

As of this release, the SDK supports MPUDP protocol, which enables you to connect and use multiple paths to maximize the use of channel resources based on the UDP protocol. You can use different physical NICs on both mobile and desktop and aggregate them to effectively combat network jitter and improve transmission quality.

To enable this feature, contact [sales-us@agora.io](https://docs.agora.io/cn/video-call-4.x/sales-us@agora.io).

**12. Register extensions (Windows)**

This release adds the `RegisterExtension` method for registering extensions. When using a third-party extension, you need to call the extension-related APIs in the following order:

`loadExtensionProvider` -> `registerExtension` -> `setExtensionProviderProperty` -> `enableExtension`

**13. Device management (Windows,macOS)**

This release adds a series of callbacks to help you better understand the status of your audio and video devices:

- `OnVideoDeviceStateChanged`: Occurs when the status of the video device changes. 
- `OnAudioDeviceStateChanged`: Occurs when the status of the audio device changes. 
- `OnAudioDeviceVolumeChanged`: Occurs when the volume of an audio device or app changes. 

**14. Camera capture options**

This release adds the `followEncodeDimensionRatio` member in `CameraCapturerConfiguration`, which enables you to set whether to follow the video aspect ratio already set in `SetVideoEncoderConfiguration` when capturing video with the camera.

**15. Multi-channel management**

This release adds a series of multi-channel related methods that you can call to manage audio and video streams in multi-channel scenarios.

- The `MuteLocalAudioStreamEx` and `MuteLocalVideoStreamEx` methods are used to cancel or resume publishing a local audio or video stream, respectively.
- The `MuteAllRemoteAudioStreamsEx` and `MuteAllRemoteVideoStreamsEx` are used to cancel or resume the subscription of all remote users to audio or video streams, respectively.
- The `StartRtmpStreamWithoutTranscodingEx`, `StartRtmpStreamWithTranscodingEx`, `UpdateRtmpTranscodingEx`, and `StopRtmpStreamEx` methods are used to implement Media Push in multi-channel scenarios.
- The `StartChannelMediaRelayEx`, `UpdateChannelMediaRelayEx`, `PauseAllChannelMediaRelayEx`, `ResumeAllChannelMediaRelayEx`, and `StopChannelMediaRelayEx` methods are used to relay media streams across channels in multi-channel scenarios.
- Adds the `LeaveChannelEx` [2/2] method. Compared with the `LeaveChannelEx` [1/2] method, a new `options` parameter is added, which is used to choose whether to stop recording with the microphone when leaving a channel in a multi-channel scenario.

**16. Video encoding preferences**

In general scenarios, the default video encoding configuration meets most requirements. For certain specific scenarios, this release adds the `advanceOptions` member in `VideoEncoderConfiguration` for advanced settings of video encoding properties:

- `compressionPreference`: The compression preferences for video encoding, which is used to select low-latency or high-quality video preferences.
- `encodingPreference`: The video encoder preference, which is used to select adaptive preference, software encoder preference, or hardware encoder video preferences.

**17. Client role switching**

In order to enable users to know whether the switched user role is low-latency or ultra-low-latency, this release adds the `newRoleOptions` parameter to the `OnClientRoleChanged` callback. The value of this parameter is as follows:

- `AUDIENCE_LATENCY_LEVEL_LOW_LATENCY` (1): Low latency.
- `AUDIENCE_LATENCY_LEVEL_ULTRA_LOW_LATENCY` (2): Ultra-low latency.

#### Improvements

**1. Video information change callback**

This release optimizes the trigger logic of `OnVideoSizeChanged`, which can also be triggered and report the local video size change when `StartPreview` is called separately.

**2. First video frame rendering（Windows）**

This release speeds up the first video frame rendering time to improve the video experience.

**3. Screen sharing**

In addition to the usability enhancements detailed in the fixed issued section, this release includes a number of functional improvements to screen sharing, as follows:

Windows:

- New `minimizeWindow` member in `ScreenCaptureSourceInfo` to indicate whether the target window is minimized. 
- New `enableHighLight`, `highLightColor`, and `highLightWidth` members in `ScreenCaptureParameters` so that you can place a border around the target window or screen when screen sharing. 
- Compatibility with a greater number of mainstream apps, including WPS Office, Microsoft Office PowerPoint, Visual Studio Code, Adobe Photoshop, Windows Media Player, and Scratch. 
- Compatibility with additional devices and operating systems, including: Window 8 systems, devices without discrete graphics cards, and dual graphics devices. 
- Support for Ultra HD video (4K, 60 fps) on devices that meet the requirements. Agora recommends a device with an Intel Core i7-9750H CPU @ 2.60 GHz or better. 

macOS:

- Compatibility with additional devices and scenarios, including: dual graphics devices and screen sharing using external screens. 
- Support for Ultra HD video (4K, 60 fps) on devices that meet the requirements. Agora recommends a 2021 16" M1 Macbook Pro or better. 

**4. Bluetooth permissions (Android)**

To simplify integration, as of this release, you can use the SDK to enable Android users to use Bluetooth normally without adding the `BLUETOOTH_CONNECT`permission.

**5. Relaying media streams across channels**

This release optimizes the `UpdateChannelMediaRelay` method as follows:

- Before v4.1.0: If the target channel update fails due to internal reasons in the server, the SDK returns the error code `RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_REFUSED`(8), and you need to call the `UpdateChannelMediaRelay` method again.
- v4.1.0 and later: If the target channel update fails due to internal server reasons, the SDK retries the update until the target channel update is successful.

**6. Reconstructed AIAEC algorithm**

This release reconstructs the AEC algorithm based on the AI method. Compared with the traditional AEC algorithm, the new algorithm can preserve the complete, clear, and smooth near-end vocals under poor echo-to-signal conditions, significantly improving the system's echo cancellation and dual-talk performance. This gives users a more comfortable call and live-broadcast experience. AIAEC is suitable for conference calls, chats, karaoke, and other scenarios.

**7. Virtual background**

This release optimizes the virtual background algorithm. Improvements include the following:

- The boundaries of virtual backgrounds are handled in a more nuanced way and image matting is is now extremely thin.
- The stability of the virtual background is improved whether the portrait is still or moving, effectively eliminating the problem of background flickering and exceeding the range of the picture.
- More application scenarios are now supported, and a user obtains a good virtual background effect day or night, indoors or out.
- A larger variety of postures are now recognized, when half the body is motionless, the body is shaking, the hands are swinging, or there is fine finger movement. This helps to achieve a good virtual background effect in conjunction with many different gestures.

#### **Other improvements**

This release includes the following additional improvements:

- Reduces the latency when pushing external audio sources.
- Improves the performance of echo cancellation when using the `AUDIO_SCENARIO_MEETING` scenario.
- Improves the smoothness of SDK video rendering.
- Enhances the ability to identify different network protocol stacks and improves the SDK's access capabilities in multiple-operator network scenarios.
- Reduces the CPU usage and power consumption of the local device when the host calls the `MuteLocalVideoStream` method. (Windows, macOS)

#### Issues fixed

This release fixed the following issues:

**Screen sharing issues**：

- macOS：

  - In screen sharing scenarios on Mac devices, when the user minimized or closed a shared application window, another window of the same application was automatically shared. 
  - In screen sharing scenarios, the system volume of the local user occasionally decreased.
  - In screen sharing scenarios, the shared window of a split screen was not highlighted correctly. 
  - In screen sharing scenarios, the screen seen by the remote user occasionally crashed, lagged, or displayed a black screen.
  - The uplink network quality reported by the `OnNetworkQuality` callback was inaccurate for the user who was sharing a screen.

- Windows:
  - In screen sharing scenarios, when the user minimized and then restored the shared window, the remote video occasionally switched to the low-quality stream. 
  - When the host started screen sharing during live streaming, the audience members sometimes heard echoes.
  - In screen sharing scenarios, the system volume of the local user occasionally decreased.
  - In screen sharing scenarios, a black screen appeared when sharing a screen between a landscape monitor and a portrait monitor. 
  - In screen sharing scenarios with a window excluded, the application crashed when the specified shared area exceeded the screen resolution. 
  - The application failed to exclude a window using the `StartScreenCaptureByDisplayId` method for screen sharing.
  - In screen sharing scenarios, the screen seen by the remote user occasionally crashed, lagged, or displayed a black screen.
  - In screen sharing scenarios, when the user shared the screen by window, the mouse in the shared screen was not in its actual position. 
  - When switching from a non-screen sharing scenario to a screen sharing one, the application occasionally crashed if the user did not switch the resolution accordingly. 

**Other issues**：

- All platforms：
  - The call `GetExtensionProperty` failed and returned an empty string.
  - When entering a live streaming room that has been played for a long time as an audience, the time for the first frame to be rendered was shortened.
  - When calling `SetVideoEncoderConfigurationEx` in the channel to increase the resolution of the video, it occasionally failed.
  - When using the Agora media player to play videos, after you played and paused the video, and then called the seek method to specify a new position for playback, the video image occasionally remained unchanged; if you called the `Resume` method to resume playback, the video was sometimes played at a speed faster than the original one. 
  - Audience members heard buzzing noises when the host switched between speakers and earphones during live streaming.
  - Crashes occurred if you call the `RegisterAudioEncodedFrameObserver` method after failing to initialize  `RtcEngine`.

- Windows：
  - When `StopPreview` was called to disable the local video preview, the virtual background that had been set up was occasionally invalidated. 
  - Crashes occasionally occurred when exiting a channel and joining it multiple times with virtual background enabled and set to blur effect.
  - If the local client used a camera with a resolution set to 1920 × 1080 as the video capture source, the resolution of the remote video was occasionally inconsistent with the local client.
  - When capturing video through the camera, if the video aspect ratio set in `CameraCapturerConfiguration` was inconsistent with that set in `SetVideoEncoderConfiguration`, the aspect ratio of the local video preview was not rendered according to the latter setting. 

- Android：
  - After calling `SetCloudProxy` to set the cloud proxy, calling `JoinChannelEx` to join multiple channels failed.

  - In online meeting scenarios, the local user and the remote user occasionally could not hear each other after the local user was interrupted by a call.

- iOS：
  - Calling `StartAudioMixing` to play music files in the `ipod-library://item` path failed.
  - Different timestamps for audio and video data were obtained simultaneously and separately via `OnRecordAudioFrame` and `OnCaptureVideoFrame` callbacks. 

- macOS：
  - After starting and stopping the audio capture device test, there was no sound when the audio playback device was subsequently started.
  - The `OnVideoPublishStateChanged` callback reported an inaccurate video source type.
  - When capturing video through the camera, if the video aspect ratio set in `CameraCapturerConfiguration` was inconsistent with that set in `SetVideoEncoderConfiguration`, the aspect ratio of the local video preview was not rendered according to the latter setting. 

#### API changes

**Added** 

- `EnableInEarMonitoring`
- `SetEarMonitoringAudioFrameParameters`
- `OnEarMonitoringAudioFrame`
- `SetInEarMonitoringVolume`
- `GetEarMonitoringAudioParams`
- `StartRecordingDeviceTest` (Android)
- `StopRecordingDeviceTest` (Android)
- `GetNetworkType`
- `SetRecordingDeviceVolume`  (Windows)
- `isAudioFilterable` in `ChannelMediaOptions` 
- `SetDualStreamMode` [1/2]
- `SetDualStreamMode` [2/2]
- `SetDualStreamModeEx`
- `SIMULCAST_STREAM_MODE`
- `SetLoopbackDevice` 
- `GetLoopbackDevice`
- `FollowSystemLoopbackDevice`
- `SetZones`
- `SetPlayerAttenuation`
- `SetRemoteAudioAttenuation`
- `MuteRemoteAudioStream`
- `SpatialAudioParams`
- `SetHeadphoneEQPreset`
- `HEADPHONE_EQUALIZER_PRESET`
- `EnableMultiCamera` (iOS)
- `StartSecondaryCameraCapture` (iOS)
- `StopSecondaryCameraCapture` (iOS)
- `SetHeadphoneEQParameters`
- `SetRemoteVideoSubscriptionOptions`
- `SetRemoteVideoSubscriptionOptionsEx`
- `LeaveChannelEx` [2/2]
- `VideoSubscriptionOptions`
- `MuteLocalAudioStreamEx`
- `MuteLocalVideoStreamEx`
- `MuteAllRemoteAudioStreamsEx`
- `MuteAllRemoteVideoStreamsEx`
- `StartRtmpStreamWithoutTranscodingEx`
- `StartRtmpStreamWithTranscodingEx`
- `UpdateRtmpTranscodingEx`
- `StopRtmpStreamEx`
- `StartChannelMediaRelayEx`
- `UpdateChannelMediaRelayEx`
- `PauseAllChannelMediaRelayEx`
- `ResumeAllChannelMediaRelayEx`
- `StopChannelMediaRelayEx`
- `followEncodeDimensionRatio` in `CameraCapturerConfiguration` 
- `hwEncoderAccelerating` in `LocalVideoStats` 
- `advanceOptions` in `VideoEncoderConfiguration` 
- `newRoleOptions` in `OnClientRoleChanged` 
- `AdjustUserPlaybackSignalVolumeEx`
- `EnableAudioVolumeIndicationEx`
- `OnVideoDeviceStateChanged` (Windows,macOS)
- `OnAudioDeviceStateChanged ` (Windows,macOS)
- `OnAudioDeviceVolumeChanged ` (Windows,macOS)
- `SetParameters` in `IRtcEngine` (Windows)

**Modified**

- `EnableDualStreamMode` [3/3]

**Deprecated**

- `StartEchoTest` [2/3]
- `OnApiCallExecuted`. Use the callbacks triggered by specific methods instead.

**Deleted**

- `EnableDualStreamMode` [2/3] 
- Removes deprecated member parameters `backgroundImage` and `watermark` in `LiveTranscoding` class (Android/iOS/macOS)
- Removes `RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_REFUSED`(8) in `OnChannelMediaRelayEvent callback`

## v4.0.0

#### New features

**2. Ultra HD resolution (Beta) (Windows, macOS)**

In order to improve the interactive video experience, the SDK optimizes the whole process of video capture, encoding, decoding and rendering, and now supports 4K resolution. The improved FEC (Forward Error Correction) algorithm enables adaptive switches according to the frame rate and number of video frame packets, which further reduces the video stuttering rate in 4K scenes.

Additionally, you can set the encoding resolution to 4K (3840 × 2160) and the frame rate to 60 fps when calling `SetVideoEncoderConfiguration`. The SDK supports automatic fallback to the appropriate resolution and frame rate if your device does not support 4K.

<div class="alert info"><li>This feature has certain requirements with regards to device performance and network bandwidth, and the supported upstream and downstream frame rates vary on different platforms. To experience this feature, contact [support@agora.io](mailto:support@agora.io).
<li>The increase in the default resolution affects the aggregate resolution and thus the billing rate. See <a href="./billing_rtc_ng">Pricing</a>.</div>


**3. Full HD and Ultra HD resolution (Android, iOS)**

In order to improve the interactive video experience, the SDK optimizes the whole process of video capturing, encoding, decoding and rendering. Starting from this version, it supports Full HD (FHD) and Ultra HD (UHD) video resolutions. You can set the `dimensions` parameter to 1920 × 1080 or higher resolution when calling the `SetVideoEncoderConfiguration` method. If your device does not support high resolutions, the SDK will automatically fall back to an appropriate resolution.

<div class="alert info"><li>The UHD resolution (4K, 60 fps) is currently in beta and requires certain device performance and network bandwidth. If you want to experience this feature, contact <a href="mailto:support@agora.io">technical support</a>.
<li>High resolution typically means higher performance consumption. To avoid a decrease in experience due to insufficient device performance, Agora recommends that you enable FHD and UHD video resolutions on devices with better performance.
<li>The increase in the default resolution affects the aggregate resolution and thus the billing rate. See <a href="./billing_rtc_ng">Pricing</a>.</div>