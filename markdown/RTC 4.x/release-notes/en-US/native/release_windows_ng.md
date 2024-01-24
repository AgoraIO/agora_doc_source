## v4.2.6

v4.2.6 was released on November xx, 2023.

#### Issues fixed


This version fixed the issue that the video on the receiving end stuttered or froze in specific scenarios, such as when the network packet loss rate was high or when the broadcaster left the channel without destroying the engine and then re-joined the channel.

## v4.2.3

v4.2.3 was released on October xx, 2023.

#### New features

1. **Update video screenshot and upload**

   To facilitate the integration of third-party video moderation services from Agora Extensions Marketplace, this version has the following changes:

   - The `CONTENT_INSPECT_IMAGE_MODERATION` enumeration is added in `CONTENT_INSPECT_TYPE` which means using video moderation extensions from Agora Extensions Marketplace to take video screenshots and upload them.
   - An optional parameter `serverConfig` is added in `ContentInspectConfig`, which is for server-side configuration related to video screenshot and upload via extensions from Agora Extensions Marketplace. By configuring this parameter, you can integrate multiple third-party moderation extensions and achieve flexible control over extension switches and other features. For more details, please contact [technical support](mailto:support@agora.io).

   In addition, this version also introduces the `enableContentInspectEx` method, which supports taking screenshots for multiple video streams and uploading them.

2. **ID3D11Texture2D Rendering**

   As of this release, the SDK supports video formats of type ID3D11Texture2D, improving the rendering effect of video frames in game scenarios. You can set `format` to `VIDEO_TEXTURE_ID3D11TEXTURE2D` when pushing external raw video frames to the SDK by calling `pushVideoFrame`. By setting the `d3d11_texture_2d` and `texture_slice_index` properties, you can determine the ID3D11Texture2D texture object to use.

3. **Local video status error code update**

   In order to help users understand the exact reasons for local video errors in screen sharing scenarios, the following sets of enumerations have been added to the `onLocalVideoStateChanged` callback:

   - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_PAUSED`(23): Screen capture has been paused. Common scenarios for reporting this error code: The current screen may have been switched to a secure desktop, such as a UAC dialog box or Winlogon desktop.
   - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_RESUMED`(24): Screen capture has resumed from the paused state.
   - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_HIDDEN`(25): The window being captured on the current screen is in a hidden state and is not visible on the current screen.
   - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_HIDDEN`(26): The window for screen capture has been restored from the hidden state.
   - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_MINIMIZED`(27): The window for screen capture has been restored from the minimized state.

4. **Check device support for advanced features**

   This version adds the `isFeatureAvailableOnDevice` method to check whether the capability of the current device meets the requirements of the specified advanced feature, such as virtual background and image enhancement.

   Before using advanced features, you can check whether the current device supports these features based on the call result. This helps to avoid performance degradation or unavailable features when enabling advanced features on low-end devices. Based on the return value of this method, you can decide whether to display or enable the corresponding feature button, or notify the user when the device's capabilities are insufficient.

   In addition, since this version, calling `enableVirtualBackground` and `setBeautyEffectOptions` automatically triggers a test on the capability of the current device. When the device is considered underperformed, the error code `-4:ERR_NOT_SUPPORTED` is returned, indicating the device does not support the feature.

#### Improvements

1. **Optimize virtual background memory usage**

   This version has upgraded the virtual background algorithm, reducing the memory usage of the virtual background feature. Compared to the previous version, the memory consumption of the app during the use of the virtual background feature on low-end devices has been reduced by approximately 4% to 10% (specific values may vary depending on the device model and platform).

2. **Screen sharing scenario optimization**

   This release optimizes the performance and encoding efficiency in ultra-high-definition (4K, 60 fps) game sharing scenarios, effectively reducing the system resource usage during screen sharing.

**Other Improvements**

This release includes the following additional improvements:

- Optimizes the logic of handling invalid parameters. When you call the `setPlaybackSpeed` method to set the playback speed of audio files, if you pass an invalid parameter, the SDK returns the error code -2, which means that you need to reset the parameter.
- Optimizes the logic of Token parsing, in order to prevent an app from crash when an invalid token is passed in.

#### Issues fixed

This release fixed the following issues:

- Occasional crashes and dropped frames occurred in screen sharing scenarios.
- Occasional failure of joining a channel when the local system time was not set correctly.
- When calling the `playEffect` method to play two audio files using the same `soundId`, the first audio file was sometimes played repeatedly.
- Calling `takeSnapshotEx` once receives the `onSnapshotTaken` callback for multiple times.

#### API changes

**Added**

- The following enumerations in `onLocalVideoStateChanged`:
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_PAUSED`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_RESUMED`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_HIDDEN`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_HIDDEN`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_MINIMIZED`
- `d3d11_texture_2d` and `texture_slice_index` members in `ExternalVideoFrame`.
- `VIDEO_TEXTURE_ID3D11TEXTURE2D` in `VIDEO_PIXEL_FORMAT`.
- `enableContentInspectEx`
- `CONTENT_INSPECT_IMAGE_MODERATION` in `CONTENT_INSPECT_TYPE`.
- `serverConfig` in `ContentInspectConfig`
- `isFeatureAvailableOnDevice`
- `FeatureType`

## v4.2.2

v4.2.2 was released on July xx, 2023.

#### New features

1. **Wildcard token**

   This release introduces wildcard tokens. Agora supports setting the channel name used for generating a token as a wildcard character. The token generated can be used to join any channel if you use the same user id. In scenarios involving multiple channels, such as switching between different channels, using a wildcard token can avoid repeated application of tokens every time users joining a new channel, which reduces the pressure on your token server. See [Wildcard tokens](links).

   <div class="alert note"> All 4.x SDKs support using wildcard tokens.</div>

2. **Preloading channels**

   This release adds `preloadChannel[1/2]` and `preloadChannel[2/2]` methods, which allows a user whose role is set as audience to preload channels before joining one. Calling the method can help shortening the time of joining a channel, thus reducing the time it takes for audience members to hear and see the host.

   When preloading more than one channels, Agora recommends that you use a wildcard token for preloading to avoid repeated application of tokens every time you joining a new channel, thus saving the time for switching between channels. See [Wildcard tokens](links).

3. **Customized background color of video canvas**

   In this release, the `backgroundColor` member has been added to `VideoCanvas`, which allows you to customize the background color of the video canvas when setting the properties of local or remote video display.

4. **Publishing video streams from different sources**

   This release adds the following members in `ChannelMediaOptions` to allow you publish video streams captured from the third and fourth camera or screen:

   - `publishThirdCameraTrack`: Publishing the video stream captured from the third camera.
   - `publishFourthCameraTrack`: Publishing the video stream captured from the fourth camera.
   - `publishThirdScreenTrack`: Publishing the video stream captured from the third screen.
   - `publishFourthScreenTrack`: Publishing the video stream captured from the fourth screen.

   <div class="alert note">For one <code>RtcConnection</code>, Agora supports publishing multiple audio streams and one video stream at the same time.</div>

#### Improvements

1. **Virtual Background Algorithm Upgrade**

   This version has upgraded the portrait segmentation algorithm of the virtual background, which comprehensively improves the accuracy of portrait segmentation, the smoothness of the portrait edge with the virtual background, and the fit of the edge when the person moves. In addition, it optimizes the precision of the person's edge in scenarios such as meetings, offices, homes, and under backlight or weak light conditions.

2. **Channel media relay**

   The number of target channels for media relay has been increased to 6. When calling `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx`, you can specify up to 6 target channels.

3. **Enhancement in video codec query capability**

   To improve the video codec query capability, this release adds the `codecLevels` member in `CodecCapInfo`. After successfully calling `queryCodecCapability`, you can obtain the hardware and software decoding capability levels of the device for H.264 and H.265 video formats through `codecLevels`.

This release includes the following additional improvements:

1. The SDK automacially adjusts the frame rate of the sending end based on the screen sharing scenario. Especially in document sharing scenarios, this feature avoids exceeding the expected video bitrate on the sending end to improve transmission efficiency and reduce network burden.
2. To help users understand the reasons for more types of remote video state changes, the `REMOTE_VIDEO_STATE_REASON_CODEC_NOT_SUPPORT` enumeration has been added to the `onRemoteVideoStateChanged` callback, indicating that the local video decoder does not support decoding the received remote video stream.

#### Issues fixed

This release fixed the following issues:

- Slow channel reconnection after the connection was interrupted due to network reasons.
- In screen sharing scenarios, the delay of seeing the shared screen was occasionally higher than expected on some devices.
- In custom video capturing scenarios, `setBeautyEffectOptions`, `setLowlightEnhanceOptions`, `setVideoDenoiserOptions`, and `setColorEnhanceOptions` could not load extensions automatically.
- In multi-device audio recording scenarios, after repeatedly plugging and unplugging or enabling/disabling the audio recording device, no sound could be heard occasionally when calling the `startRecordingDeviceTest` to start an audio capturing device test.

#### API changes

**Added**

- `preloadChannel[1/2]`
- `preloadChannel[2/2]`
- `updatePreloadChannelToken`
- The following members in `ChannelMediaOptions`:
  - `publishThirdCameraTrack`
  - `publishFourthCameraTrack`
  - `publishThirdScreenTrack`
  - `publishFourthScreenTrack`
- `CodecCapLevels`
- `VIDEO_CODEC_CAPABILITY_LEVEL`
- `backgroundColor` in `VideoCanvas`
- `codecLevels` in `CodecCapInfo`
- `REMOTE_VIDEO_STATE_REASON_CODEC_NOT_SUPPORT` in `REMOTE_VIDEO_STATE_REASON`

## v4.2.1

This version was released on June 21, 2023.

#### Improvements

This version improves the network transmission strategy, enhancing the smoothness of audio and video interactions.

#### Fixed Issues

This version fixed the following issues:

- Inability to join channels caused by SDK's incompatibility with some older versions of AccessToken.
- After the sending end called `setAINSMode` to activate AI noise reduction, occasional echo was observed by the receiving end.
- Brief noise occurred while playing media files using the media player.
- When the sending end mixed and published two streams of video captured by two cameras locally, the video from the second camera was occasionally missing on the receiving end.

## v4.2.0

v4.2.0 was released on May xx, 2023.

#### Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

**1. Video capture**

This release optimizes the APIs for camera and screen capture function. As of v4.2.0, ensure you use the alternative methods listed in the table below and specify the video source by setting the `sourceType` parameter.

| Deleted Methods                                              | Alternative Methods       |
| :----------------------------------------------------------- | :------------------------ |
| <li>`startPrimaryCameraCapture`</li><li>`startSecondaryCameraCapture`</li> | `startCameraCapture`      |
| <li>`stopPrimaryCameraCapture`</li><li>`stopSecondaryCameraCapture`</li> | `stopCameraCapture`       |
| <li>`startPrimaryScreenCapture`</li><li>`startSecondaryScreenCapture`</li> | `startScreenCapture`[2/2] |
| <li>`stopPrimaryScreenCapture`</li><li>`stopSecondaryScreenCapture`</li> | `stopScreenCapture`[2/2]  |

**2. Video data acquisition**

- The `onCaptureVideoFrame` and `onPreEncodeVideoFrame` callbacks are added with a new parameter called `sourceType`, which is used to indicate the specific video source type.
- The following callbacks are deleted. Get the video source type through the `sourceType` parameter in the `onPreEncodeVideoFrame` and `onCaptureVideoFrame` callbacks.
  - `onSecondaryPreEncodeCameraVideoFrame`
  - `onScreenCaptureVideoFrame`
  - `onPreEncodeScreenVideoFrame`
  - `onSecondaryPreEncodeScreenVideoFrame`

**3. Channel media options**

- `publishCustomAudioTrackEnableAec` in `ChannelMediaOptions` is deleted. Use `publishCustomAudioTrack` instead.
- `publishTrancodedVideoTrack` in `ChannelMediaOptions` is renamed to `publishTranscodedVideoTrack`.
- `publishCustomAudioSourceId` in `ChannelMediaOptions` is renamed to `publishCustomAudioTrackId`.

**4. Local video mixing**

- The `VideoInputStreams` in `LocalTranscoderConfiguration` is changed to `videoInputStreams`.
- The `MEDIA_SOURCE_TYPE` in `TranscodingVideoStream` is changed to `VIDEO_SOURCE_TYPE`.

**5. Miscellaneous**

- `onApiCallExecuted` is deleted. Agora recommends getting the results of the API implementation through relevant channels and media callbacks.
- The `IAudioFrameObserver` class is renamed to `IAudioPcmFrameSink`, thus the prototype of the following methods are updated accordingly:
  - `onFrame`
  - `registerAudioFrameObserver` [1/2] and `registerAudioFrameObserver`[2/2] in `IMediaPlayer`
- `enableDualStreamMode`[1/2] and `enableDualStreamMode`[2/2] are depredated. Use `setDualStreamMode`[1/2] and `setDualStreamMode`[2/2] instead.
- `startChannelMediaRelay`, `updateChannelMediaRelay`, `startChannelMediaRelayEx` and `updateChannelMediaRelayEx` are deprecated. Use `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx` instead.
- `OnRecordAudioEncodedFrame` is renamed to `onRecordAudioEncodedFrame`
- `OnPlaybackAudioEncodedFrame` is renamed to `onPlaybackAudioEncodedFrame`
- `OnMixedAudioEncodedFrame` is renamed to `onPlaybackAudioEncodedFrame`

#### New features

**1. AI noise reduction**

This release introduces the AI noise reduction function. Once enabled, the SDK automatically detects and reduces background noises. Whether in bustling public venues or real-time competitive arenas that demand lightning-fast responsiveness, this function guarantees optimal audio clarity, providing users with an elevated audio experience. You can enable this function through the newly-introduced `setAINSMode` method and set the noise reduction mode as balance, aggressive or low latency according to your scenarios.

**2.** **Enhanced Virtual Background**

To increase the fun of real-time video calls and protect user privacy, this version has enhanced the virtual background feature. You can now set custom backgrounds of various types by calling the `enableVirtualBackground` method, including:

- Process the background as alpha information without replacement, only separating the portrait and the background. This can be combined with the local video mixing feature to achieve a portrait-in-picture effect.
- Replace the background with various formats of local videos.

**3. Video scenario settings**

This release introduces `setVideoScenario` for setting the video application scene. The SDK will automatically enable the best practice strategy based on different scenes, adjusting key performance indicators to optimize video quality and improve user experience. Whether it is a formal business meeting or a casual online gathering, this feature ensures that the video quality meets the requirements.

Currently, this feature provides targeted optimizations for real-time video conferencing scenarios, including:

- Automatically activate multiple anti-weak network technologies to enhance the capability and performance of low-quality video streams in meeting scenarios where high bitrates are required, ensuring smoothness when multiple streams are subscribed by the receiving end.
- Monitor the number of subscribers for the high-quality and low-quality video streams in real time, dynamically adjusting the configuration of the high-quality stream and dynamically enabling or disabling the low-quality stream, to save uplink bandwidth and consumption.

**4. Local video mixing**

This release adds the `onLocalVideoTranscoderError` callback. When there is an error in starting or updating the local video mixing, the SDK triggers this callback to report the reason for the failure.

**5. Cross-device synchronization**

In real-time collaborative singing scenarios, network issues can cause inconsistencies in the downlinks of different client devices. To address this, this release introduces `getNtpWallTimeInMs` for obtaining the current Network Time Protocol (NTP) time. By using this method to synchronize lyrics and music across multiple client devices, users can achieve synchronized singing and lyrics progression, resulting in a better collaborative experience.

#### Improvements

**1. Voice changer**

This release introduces the `setLocalVoiceFormant` method that allows you to adjust the formant ratio to change the timbre of the voice. This method can be used together with the `setLocalVoicePitch` method to adjust the pitch and timbre of voice at the same time, enabling a wider range of voice transformation effects.

 **2. Enhanced rendering compatibility**

This release enhances the rendering compatibility of the SDK. Issues like black screens caused by rendering failures on certain devices are fixed.

**3. Audio and video synchronization**

For custom video and audio capture scenarios, this release introduces `getCurrentMonotonicTimeInMs` for obtaining the current Monotonic Time. By passing this value into the timestamps of audio and video frames, developers can accurately control the timing of their audio and video streams, ensuring proper synchronization.

**4. Multi-camera capture and multi-screen capture**

This release introduces `startCameraCapture` and `startScreenCapture`[2/2]. By calling these methods multiple times and specifying the `sourceType` parameter, developers can start capturing video streams from multiple cameras and screens for local video mixing or multi-channel publishing. This is particularly useful for scenarios such as remote medical care and online education, where multiple cameras and displays need to be connected.

**5. Channel media relay**

This release introduces `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx`, allowing for a simpler and smoother way to start and update media relay across channels. With these methods, developers can easily start the media relay across channels and update the target channels for media relay with a single method. Additionally, the internal interaction frequency has been optimized, effectively reducing latency in function calls.

**6. Custom audio tracks**

To better meet the needs of custom audio capture scenarios, this release adds `createCustomAudioTrack` and `destroyCustomAudioTrack` for creating and destroying custom audio tracks. Two types of audio tracks are also provided for users to choose from, further improving the flexibility of capturing external audio source:

- Mixable audio track: Supports mixing multiple external audio sources and publishing them to the same channel, suitable for multi-channel audio capture scenarios.
- Direct audio track: Only supports publishing one external audio source to a single channel, suitable for low-latency audio capture scenarios.

#### Issues fixed

This release fixed the issue that when the host frequently switching the user role between broadcaster and audience in a short period of time, the audience members cannot hear the audio of the host.

#### API changes

**Added**

- `startCameraCapture`
- `stopCameraCapture`
- `startScreenCapture`[2/2]
- `stopScreenCapture`[2/2]
- `startOrUpdateChannelMediaRelay`
- `startOrUpdateChannelMediaRelayEx`
- `getNtpWallTimeInMs`
- `setVideoScenario`
- `getCurrentMonotonicTimeInMs`
- `onLocalVideoTranscoderError`
- `setAINSMode`
- `createAudioCustomTrack`
- `destroyAudioCustomTrack`
- `AudioTrackConfig`
- `AUDIO_TRACK_TYPE`
- `VIDEO_APPLICATION_SCENARIO_TYPE`
- `SCREEN_CAPTURE_FRAMERATE_CAPABILITY`
- The `domainLimit` and `autoRegisterAgoraExtensions` members in `RtcEngineContext`
- The `sourceType` parameter in `onCaptureVideoFrame` and `onPreEncodeVideoFrame` callbacks
- The `BACKGROUND_NONE` and `BACKGROUND_VIDEO` enumerators in `BACKGROUND_SOURCE_TYPE`

**Modified**

- `OnRecordAudioEncodedFrame` is renamed to `onRecordAudioEncodedFrame`
- `OnPlaybackAudioEncodedFrame` is renamed to `onPlaybackAudioEncodedFrame`
- `OnMixedAudioEncodedFrame` is renamed to `onPlaybackAudioEncodedFrame`

**Deprecated**

- `enableDualStreamMode`[1/2]
- `enableDualStreamMode`[2/2]
- `startChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelay`
- `updateChannelMediaRelayEx`
- `onChannelMediaRelayEvent`
- `CHANNEL_MEDIA_RELAY_EVENT`

**Deleted**

- `startPrimaryScreenCapture`
- `startSecondaryScreenCapture`
- `stopPrimaryScreenCapture`
- `stopSecondaryScreenCapture`
- `startPrimaryCameraCapture`
- `startSecondaryCameraCapture`
- `stopPrimaryCameraCapture`
- `stopSecondaryCameraCapture`
- `onSecondaryPreEncodeCameraVideoFrame`
- `onScreenCaptureVideoFrame`
- `onPreEncodeScreenVideoFrame`
- `onSecondaryPreEncodeScreenVideoFrame`
- `onApiCallExecuted`
- `publishCustomAudioTrackEnableAec ` in ` ChannelMediaOptions`

