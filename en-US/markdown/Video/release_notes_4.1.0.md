## v4.1.0

v4.1.0 was released on November xx, 2022.

### New features

#### 1. Multipule cameras for video capture （iOS）

This release supports mult-camera video capture. You can call `enableMultiCamera` to ennable multi-camera capture mode, and call `startSecondaryCameraCapture` to start capuring video from the second camera, and then publish the captured video to the second channel.

To stop the multi-camera capture, you need to call `stopSecondaryCameraCapture` to stop the second camera capture, then call `enableMultiCamera` and set `enabled` to `NO`.

#### 2. DRM-protected music （iOS，Android）

To free users from music copyright issues, this release allows users to use music that has Digital Rights Management(DRM) protection. You can call the APIs in the `IMusicContentCenter`, `IMusicPlayer` and `IMusicContentCenterEventHandler` classes to play DRM-protected music in real-time interaction scenarios. You can also search and preload music, get music charts and their detailed information, and download lyrics and posters.

#### 3. Headphone equalization effect

This release adds `setHeadphoneEQParameters` method, which is used to adjust the low and high frequency parameters of the headphone EQ, mainly used in spatial audio scenarios. If after calling `setHeadphoneEQPreset` you still can't achieve the expected headphone EQ effect, you can call this method to adjust it.

#### 4. Encoded video frame observer

This release adds the `setRemoteVideoSubscriptionOptions` and `setRemoteVideoSubscriptionOptionsEx` methods. When you call the `registerVideoEncodedFrameObserver` method to register a video frame observer for the encoded video frames, the SDK subscribes to the encoded video frames by default. If you want to change the subscription options, you can call these new methods to set them.

For more information about registering video observers and subscription options, see the [API reference]().

#### 5. MPUDP (MultiPath UDP)

Starting from this version, the SDK supports MPUDP protocol, which allows to connect and use multiple paths to maximize the use of channel resources based on the UDP protocol. You can use different physical NICs on both mobile and desktop and aggregate them to effectively combat network jitter and improve transmission quality.

To enable this feature, contact sales-us@agora.io。


#### 6. Register extensions (Windows)

This release adds `registerExtension` method for registering extensions. When using a third-party extension, you need to call the extension-related APIs in the following order.

Call `loadExtensionProvider` -> `registerExtension` -> `setExtensionProviderProperty` -> `enableExtension`.


#### 7. Device management （Windows,macOS）

This release adds a series of callbacks to help you better understand the status of your audio and video devices.

// (DELETE BEFORE PUBLISH) For the macOS release note, please note that they're C++ methods.

- `onVideoDeviceStateChanged`: Occurs when the status of the video device changes. 
- `onAudioDeviceStateChanged`: Occurs when the status of the audio device changes. 
- `onAudioDeviceVolumeChanged`: Occurs when the volume of an audio device or app changes. 


#### 8. Camera capture options

This release adds the `followEncodeDimensionRatio` member in `CameraCapturerConfiguration`, which allows you to set whether to follow the video aspect ratio already set in `setVideoEncoderConfiguration` when capturing video with the camera.


#### 9. Option for leaving multi-channel

This release adds the `options` parameter in `leaveChannelEx` method, which is used to select whether to stop the microphone recording when leaving a channel in a multi-channel scenario.

The `options` parameter only supports setting whether to stop microphone recording (`stopMicrophoneRecording`), and setting other members in `LeaveChannelOptions` does not take effect.



#### 10. Video encoding preferences

In general scenarios, the default video encoding configuration of can meet the requirements. For specific scenarios, this release adds the following video encoding preferences configuration:

- Compression preferences for video encoding. This release adds a `compressionPreference` member in `VideoEncoderConfiguration`, which is used to select low-latency or high-quality video preferences.
- Video encoder preferences. This release adds an `advanceOptions` member in `VideoEncoderConfiguration` for advanced video encoding configuration. You can set video encoder preferences in `advanceOptions`, including default preference, hardware encoding preference, and software encoding preference.


#### 11. Client role switching

In order to facilitate users to know whether the switched user role is low-latency or ultra-low-latency, this release adds the `newRoleOptions` parameter to the `onClientRoleChanged` callback. The value of this parameter is as follows:

- `AUDIENCE_LATENCY_LEVEL_LOW_LATENCY (1)`: Low latency.
- `AUDIENCE_LATENCY_LEVEL_ULTRA_LOW_LATENCY (2)`: Ultra-low latency.


### Improvements

#### 1. Screen share

This release has a number of optimizations to the screen share feature. In addition to the functional improvements listed below, there are also some usability enhancements, as detailed in the issue fixed section.

- Adds `minimizeWindow` member to `ScreenCaptureSourceInfo` to indicate whether the target window is minimized. (Windows)
- Adds `enableHighLight`, `highLightColor`, and `highLightWidth` members to `ScreenCaptureParameters` so that you can place a border around the target window or screen when screen sharing. (Windows)
- Compatible with more mainstream apps, including but not limited to: WPS Office, Microsoft Office PowerPoint, Visual Studio Code, Adobe Photoshop, Windows Media Player, Scratch.(Windows)
- Compatible with more devices and scenarios, including but not limited to: dual graphics devices, screen sharing using external screens. (macOS)
- Compatible with more devices and operating systems, including but not limited to: Window 8 systems, devices without discrete graphics cards, dual graphics devices. (Windows)
- Supports Ultra HD video (4K, 60 fps), you can apply this feature on devices that meet the requirements. The minimum device specifications recommended by Agora is: inter(R) Core(TM) i7-9750H CPU @ 2.60GHZ.(Windows)
- Supports Ultra HD video (4K, 60 fps), and you can apply this feature on a device that meets the requirements. The minimum device specifications recommended by Agora is: 2021 m1 MacBook pro 16" (macOS)

#### 2. Bluetooth permissions (Android)

To simplify the integration steps, since this release, the SDK supports you to allow Android users to use Bluetooth normally without adding the `BLUETOOTH_CONNECT` permission.

#### 3. CDN streaming

To improve user experience during CDN streaming, when your camera does not support the video resolution you set when streaming, the SDK automatically adjusts the resolution to the closest value that is supported by your camera and has the same length-to-width ratio as that of the original video resolution you set. The actual video resolution used by the SDK for streaming can be obtained through the `onDirectCdnStreamingStats` callback.

#### 4. Relaying media streams across channels

This release optimizes the `updateChannelMediaRelay` method as follows:

- Before v4.1.0: If the target channel update fails due to internal reasons in the server, the SDK returns the error code `RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_REFUSED(8)`, and you need to call the `updateChannelMediaRelay` method again.
- v4.1.0 and later: If the target channel update fails due to internal server reasons, the SDK will retry the update until the target channel update is successful.

#### 5. Reconstructed AIAEC algorythem

Compared with the traditional AEC algorithm, AIAEC is able to preserve complete, clear, and smooth near-end vocals under the condition of a higher echo/signal ratio, which significantly improves the echo cancellation and double talk performances of the system. Featuring a comfortable call/live broadcast experience, AIAEC applies to scenarios such as conferences, chats, and karaoke.


#### Other improvements

- Reduces the latency when pushing external audio sources.
- Improves the performance of echo cancellation when using the AUDIO_SCENARIO_MEETING scenario.
- Improves the smoothness of SDK video rendering.
- Reduces the CPU usage and power consumption of the local device when the host calls the muteLocalVideoStream method. (Windows, macOS)
- Enhances the ability to identify different network protocol stacks and improve the SDK's access capabilities in multiple operator network scenarios.


### Issues fixed

This release fixed the following issues.

- In screen sharing scenarios, when the user minimized and then restored the shared window, the remote video occasionally switched to the low-quality stream. (Windows)
- In screen sharing scenarios on Mac devices, when the user minimized or closed a shared application window, another window of the same application was automatically shared. (macOS)
- When the host started screen sharing during live streaming, the audience members sometimes heard echoes. (Windows)
- In screen sharing scenarios, the system volume of the local user occasionally decreased. (Windows, macOS)
- In screen sharing scenarios, a black screen appears when sharing a screen between a landscape monitor and a portrait monitor. （Windows）
- In screen sharing scenarios with a window excluded, the application crashed when the specified shared area exceeded the screen resolution. (Windows)
- The application failed to exclude a window using the `startScreenCaptureByDisplayId` method for screen sharing. (Windows)
- In screen sharing scenarios, the shared window of a split screen was not highlighted correctly. (macOS)
- In screen sharing scenarios, the screen seen by the remote user occasionally showed black screen, lag, or crash.  (Windows，macOS)
- The uplink network quality reported by the `onNetworkQuality` callback was inaccurate for the user who was sharing a screen. (Windows，macOS)
- In screen sharing scenarios, when the user shared the screen by window, the mouse in the shared screen was not in its actual position. (Windows)
- When switching from a non-screen sharing scenario to a screen sharing one, the application occasionally crashed if the user did not switch the resolution accordingly. (Windows)
- Calling `startAudioMixing` to play music files in `ipod-library://item` path failed. (iOS)
- After starting and stopping the audio capture device test, there was no sound when the audio playback device was subsequently started. (macOS)
- Audience members heard buzzing noises when the host switched between speakers and earphones during live streaming.
- The `onVideoPublishStateChanged` callback reported an inaccurate video source type. (macOS)
- Different timestamps for audio and video data were obtained simultaneously and separately via `onRecordAudioFrame` and `onCaptureVideoFrame` callbacks. (iOS)
- The call `getExtensionProperty` failed and returned an empty string. (All)

### API changes

#### Added

- `enableMultiCamera` （iOS）
- `startSecondaryCameraCapture` （iOS）
- `stopSecondaryCameraCapture` （iOS）
- `setHeadphoneEQParameters`
- `setRemoteVideoSubscriptionOptions`
- `setRemoteVideoSubscriptionOptionsEx`
- `VideoSubscriptionOptions`
- `followEncodeDimensionRatio` in `CameraCapturerConfiguration`
- `hwEncoderAccelerating` in `LocalVideoStats`
- `options` in `leaveChannelEx`
- `advanceOptions` in `VideoEncoderConfiguration`
- `advancedConfig` in `LocalAccessPointConfiguration`
- `newRoleOptions` in `onClientRoleChanged`
- `adjustUserPlaybackSignalVolumeEx`
- `onVideoDeviceStateChanged` (Windows,macOS)
- `onAudioDeviceStateChanged` (Windows,macOS)
- `onAudioDeviceVolumeChanged` (Windows,macOS)
- `AgoraMusicContentCenterPreloadStatus` (iOS)
- `AgoraMusicContentCenterStatusCode` (iOS)
- `IAgoraMusicContentCenter class` （Android，iOS）
  - `destroy`
  - `initialize`
  - `createMusicPlayer`
  - `registerEventHandler`
  - `renewToken`
  - `unregisterEventHandler` （Android）
  - `preload`
  - `isPreloaded`
  - `getMusicCharts`
  - `getMusicCollectionByMusicChartId` [1/2]
  - `getMusicCollectionByMusicChartId` [2/2] (Android)
  - `searchMusic` [1/2]
  - `searchMusic` [2/2] (Android)
  - `getLyric`
  - `release` (Android)
  - `enableMainQueueDispatch` (iOS)
- `IAgoraMusicPlayer` class （Android，iOS）
  - `open`
  - `destroy` (Android)
- `IMusicContentCenterEventHandler` class （Android，iOS）
  - `onPreLoadEvent`
  - `onMusicCollectionResult`
  - `onMusicChartsResult`
  - `onLyricResult
- `Music` class （Android，iOS）
- `MusicChartInfo` class（Android，iOS）
- `MusicContentCenterConfiguration` class（Android，iOS）
- `MvProperty` class（Android，iOS）
- `ClimaxSegment` class（Android，iOS）
- `AgoraMusicCollection` class（iOS）





Deprecated

onApiCallExecuted, use the callbacks triggered by specific methods instead.


Deleted

Removes deprecated member parameters backgroundImage and watermark in LiveTranscoding class (Android/iOS/macOS)
Removes RELAY_EVENT_PACKET_UPDATE_DEST_CHANNEL_REFUSED(8) in onChannelMediaRelayEvent callback