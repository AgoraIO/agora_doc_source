# v4.6.0

v4.6.0 was released on August  xx, 2025.

**Attention:**

- Starting from version 4.5.0, both RTC SDK and Signaling (version 2.2.0 and above) include the `libaosl.dll` library. If you manually integrate Video SDK via CDN and also use Signaling SDK, delete the earlier version of the `libaosl.dll` to avoid conflicts.
- 4.6.0 RTC SDK `libaosl.dll` library version is 1.3.0. You can find out the version information of the library by checking the properties of the `libaosl.dll` file.

## Compatibility changes

This version enhances the implementation of certain features, involving SDK behavior changes, API deprecations, and deletions. To ensure your app functions correctly, you need to update your code after upgrading to this version.

For details on deprecated and deleted APIs in each version, see the [API Sunset Notice](#link).

1. **Deprecation of direct CDN streaming APIs**

   This version deprecates the APIs related to direct CDN streaming, which will be removed in a future release. We recommend using Media Push instead.

   - `setDirectCdnStreamingAudioConfiguration`
   - `setDirectCdnStreamingVideoConfiguration`
   - `startDirectCdnStreaming`
   - `stopDirectCdnStreaming`
   - `updateDirectCdnStreamingMediaOptions`
   - `DirectCdnStreamingMediaOptions`
   - `DirectCdnStreamingStats`
   - `DIRECT_CDN_STREAMING_STATE`
   - `DIRECT_CDN_STREAMING_REASON`

2. **Deprecation of virtual metronome APIs**

   This version deprecates the APIs for the virtual metronome feature, which will be removed in a future release.

   - `startRhythmPlayer`
   - `configRhythmPlayer`
   - `onRhythmPlayerStateChanged`

3. **Deprecation of watermark APIs**

   This version deprecates the old watermark APIs. We recommend using the new watermark APIs introduced in this version.

   - `addVideoWatermark2`
   - `addVideoWatermarkEx`

4. **Deletion of redundant APIs**

   This version removes the following redundant APIs and parameters:

   - `setLocalPublishFallbackOption`
   - `onLocalPublishFallbackToAudioOnly`
   - `onDownlinkNetworkInfoUpdated`
   - `onWlAccStats`
   - `WlAccStats`
   - `onWlAccMessage`
   - `WLACC_MESSAGE_REASON`
   - `WLACC_SUGGEST_ACTION`
   - `enableWirelessAccelerate`

5. **Changes to Int UID and String UID mapping**

   - Before v4.6.0: If you used `registerLocalUserAccount` to register a string UID (e.g., "aa") and obtain an int UID (e.g., 123), when you later joined a channel using this int UID, the SDK automatically mapped it to the original string UID ("aa").
   - From v4.6.0: The SDK no longer automatically maps an int UID to the original string UID used for registration. If you have called `registerLocalUserAccount` to get an int UID but need to join the channel with the original string UID, call `joinChannelWithUserAccount` directly with the string UID. After upgrading, check and adjust your app logic to ensure users join the channel with the expected identity.

6. **Changes to dual-stream mode behavior**

   - Before v4.6.0: When the sender enabled adaptive simulcast stream mode (`AUTO_SIMULCAST_STREAM`), they would not proactively send the low-resolution stream. The sender would only start sending the low-resolution stream after a receiver with host priority called `setRemoteVideoStreamType` to request it.
   - From v4.6.0: When the sender enables adaptive simulcast stream mode (`AUTO_SIMULCAST_STREAM`), the SDK automatically determines whether to send or stop sending the low-resolution stream based on the downlink network conditions of the subscribers. This adaptive function is disabled if `mode` is set to another sending mode or if the width, height, bitrate, or frame rate of the low-resolution stream is explicitly configured.

## New features

1. **Adaptive Video Publishing (Beta)**

   This version supports sending multiple video streams with different resolutions from the same video source, with support for multi-channel scenarios. You can use `setSimulcastConfig` to configure video streams of different resolutions (up to four layers: one high-resolution main stream and three lower-resolution streams) and use `SimulcastConfig` to flexibly control stream publishing by setting options like resolution, bitrate, and whether to automatically disable multiple streams when uplink network or device performance is poor. When layered streaming fallback is enabled, the SDK automatically falls back to a lower-resolution stream in poor network conditions to ensure a smooth viewing experience.

   Subscribers can choose which video stream to receive based on their needs by calling `setRemoteVideoStreamType`. This feature is ideal for scenarios with multiple terminals and varying network conditions, such as conferences, large classes, and interactive live streaming, as it significantly improves the viewing experience under poor network conditions.

2. **Multipath network transmission**

   This version introduces a multipath transmission feature for devices that support multiple network interfaces (such as 5G, Wi-Fi, and LAN). It effectively reduces or eliminates experience degradation caused by poor network conditions, making it suitable for real-time audio and video communication scenarios that demand high transmission stability, such as in-vehicle systems, IoT, trains, and highways. You can enable multipath transmission by setting `enableMultipath` in `ChannelMediaOptions` to `true`. Two transmission modes are supported (`MultipathMode`):

   - Dynamic mode: The SDK dynamically selects the optimal path for transmission based on network conditions. This mode is suitable for scenarios sensitive to data consumption but with high experience requirements, such as meetings and educational settings. Additionally, you can specify a preferred network path type (such as Wi-Fi or cellular) using `preferMultipathType`. If not set, all path types have the same default weight.
   - Duplicate mode: Data is transmitted simultaneously over all available network paths (such as LAN, Wi-Fi, and cellular) to enhance anti-packet loss and stability. This mode eliminates the impact of poor network conditions and is suitable for scenarios that are not sensitive to data consumption but have extreme experience requirements, such as outdoor broadcasting and parallel control.

   Uplink and downlink transmission can be configured separately using `uplinkMultipathMode` and `downlinkMultipathMode` in `ChannelMediaOptions`. When enabled, the SDK reports real-time transmission statistics for each path through the `onMultipathStats` callback, including the data consumption of each path, which allows you to monitor and optimize network performance.

3. **Video quality scoring**

   This version adds the `mosValue` member to `RemoteVideoStats`, which reports the quality score of the received remote video stream. The score ranges from 1 to 5, where 5 indicates excellent video quality with a clear image and no artifacts, and 1 indicates extremely poor video quality with severe blurring. You can use this parameter to monitor the subjective quality of remote video streams in real-time, which helps in dynamically adjusting video parameters for quality monitoring and alerting. To enable this feature, please contact [technical support](mailto:support@agora.io).

4. **Support for adding multiple watermarks**

   This version deprecates the `addVideoWatermark2` and `addVideoWatermarkEx` methods and introduces `addVideoWatermark3` and `addVideoWatermarkEx1`. These new methods allow you to add multiple watermarks to a video using a watermark ID and to set their layering order. To remove a specific watermark, you can call the `removeVideoWatermark` method.

5. **Asynchronous engine destruction**

   Starting from this version, the `release` method adds a `callback` parameter, supporting both synchronous and asynchronous engine destruction. When destroying the engine asynchronously, the SDK triggers the `RtcEngineReleaseCallback` callback.

6. **Token renewal result callback**

   This version introduces the `onRenewTokenResult` callback and the `RENEW_TOKEN_ERROR_CODE` error code. After calling the `renewToken` method to update a Token, the SDK notifies the result of the update through the `onRenewTokenResult` callback and provides a detailed error code via `RENEW_TOKEN_ERROR_CODE`. This allows developers to handle Token renewal failures promptly within the callback.

7. **Advanced Beauty (Beta)**

   This version introduces a brand-new advanced beauty feature, delivering a powerful yet easy-to-use beautification solution. Key capabilities include:

   - **Precision Beauty Effects:**
     - Face Shaping: Supports independent fine-tuning of 29 facial areas (e.g., slimming face, enlarging eyes, narrowing nose) or one-click natural effects via presets.
     - Style Makeup: Offers rich effects including eyeshadow, colored contacts, eyeliner, eyebrow shaping, lipstick, blush, under-eye highlights, and facial contouring.
     - Skin Enhancement: Includes professional skin optimizations like teeth whitening, nasolabial fold removal, dark circle reduction, and eye brightening.

   - **Unified and Simple API**: Manage all beauty, makeup, and filter functions through three core nodes   – `BEAUTY`, `STYLE_MAKEUP`, and `FILTER` – using `IVideoEffectObject` for unified parameter setup and lifecycle control.

   - **Ready-to-Use Presets**: Integrates multiple out-of-the-box style templates (e.g., "Natural Beauty," "Senior Makeup," "Cool White Filter") for instant polished results.

   - **Dynamic Parameter Control**: Enables real-time reading/modifying of granular parameters (e.g., smoothing strength, lipstick type) via key-value pairs, with support for saving custom configurations and resetting defaults.

   - **Local Resource Guarantee**: All beauty resources (effects, filters, makeup) are packaged as local bundle files, ensuring stability and reliability.

8. **Other new features**

   - Adds the `setPlaybackAudioFrameBeforeMixingParameters2` method to set the format of the audio frames returned in the `onPlaybackAudioFrameBeforeMixing` callback, including sample rate, number of channels, and the number of samples per callback. After calling this method, the SDK returns the raw audio data before mixing according to the set parameters.
   - Adds the `preloadEffectEx` method to preload a specified audio effect file into a specific channel. It supports both local and online audio files, enabling faster playback later and is suitable for multi-channel scenarios.
   - Adds the `playEffectEx` method to play an audio effect file in a specified channel. It supports setting parameters such as loop count, pitch, spatial position, volume, whether to publish to the channel, and the starting playback position to meet diverse audio effect needs.
   - The local screenshot upload feature now supports setting the video observation position for screenshots via the new `position` member in `ContentInspectModule`. This enables capturing and uploading screenshots from either the raw video data or the video stream before or after effects processing.
   - To improve the accuracy and stability of portrait segmentation when using a green or blue screen for the virtual background feature, this version adds the `screenColorType` member to `SegmentationProperty`. This member allows specifying the background screen color as green, blue, or auto-detected.

## Improvements

This version introduces the following improvements:

- Optimizes permission requests on Windows 11 24H2 and later versions to avoid unnecessarily acquiring location information.
- Adds support for g711 and g722 audio codecs when interoperating with the Web SDK, further improving cross-platform audio playback compatibility and clarity.
- Improves video clarity in screen sharing scenarios involving documents.

## Bug fixes

This version fixed the following issues:

- When playing an online audio effect, calling `seek` to set a new playback position caused the audio file to restart from the beginning.
- Occasional echoes occurred in media volume mode when a broadcaster published a microphone audio stream while simultaneously playing an audio effect with `playEffect3` and a music file with `startAudioMixing2`.
- The SDK crashed on Windows when handling file paths containing Chinese characters due to an encoding conversion error.
- In scenarios where a user joined a channel with `joinChannelEx`, started a media relay, unpublished, left the channel, rejoined, and then started the relay again, the `ChannelMediaRelayStateChanged` callback occasionally reported `state` as `RELAY_STATE_FAILURE` and `code` as `RELAY_ERROR_SERVER_ERROR_RESPONSE`.
- Receivers occasionally heard echoes when the sender shared their screen and audio from certain laptop models with power-saving mode enabled.
- In online education scenarios, the teacher's local view of multiple students' video and audio was occasionally out of sync.

## v4.5.2

v4.5.2 was released on April xx, 2025.

**Attention:**

- Starting from version 4.5.0, both RTC SDK and Signaling (version 2.2.0 and above) include the `libaosl.dll` library. If you manually integrate Video SDK via CDN and also use Signaling SDK, delete the earlier version of the `libaosl.dll` to avoid conflicts.
- 4.5.2 RTC SDK `libaosl.dll` library version is 1.2.13. You can find out the version information of the library by checking the properties of the `libaosl.dll` file.

#### Issues fixed

This release fixed the following issues:

- When playing a multi-track media file, noise can be heard after calling the `setAudioPitch` method to adjust the audio pitch.
- The host called the `createCustomAudioTrack` method to create custom audio track and set `trackType` to `AUDIO_TRACK_DIRECT`, called the ```pushAudioFrame` to push custom audio frames into a channel and then called `playEffect` to play audio effects, audience members in the channel would hear noise.
- Apps integrated with the SDK occasionally encountered UI lag caused by main thread blocking during audio and video interactions.
- The local preview of the shared screen flickered after calling the `startScreenCapture [2/2]` to start screen sharing and set `enableHighLight` in `ScreenCaptureParameters` to `true` through the `config` parameter to outline the shared window, and then placed the window on the top layer and maximizing it.
- Calling `startScreenCaptureByDisplayId` to share the video stream of specified screen and specifying the windows to be blocked through `excludeWindowList` in `ScreenCaptureParameters`, occasionally some windows fail to be blocked.
- The application occasionally crashed after sharing the video stream of the external screen and disconnecting the external screen connection.
- Calling `openWithMediaSource` and set `isLiveSource` in the `source` parameter to `true` to play a video stream, the playback failed.
- When the sender transmits multi-channel encoded audio, the receiver occasionally experienced noise.
- In scenarios where the App integrates a media player, when the open function is called twice to open different media resources consecutively, the second call to open unexpectedly resulted in the `onPlayerInfoUpdated [1/2]` callback returning information for the first media resource.
- After calling `enableAudioVolumeIndication` to enable user volume indication, the `onAudioVolumeIndication` callback returned a local user volume of 0 for both local streaming users and remote users.
- In scenarios of audio and video communication and screen sharing using a 21:9 display (ultrawide screen), setting a high resolution such as 3840x2160 resulted in the screen sharing image being cropped in both local preview and on the receiver's display.
- When the App called `enableVideoImageSource` to enable the video image source feature, the sending side occasionally succeeded in streaming, but `onVideoPublishStateChanged` did not return the expected.
- In multi-channel scenarios, if the App called `setupRemoteVideoEx` to initialize the remote user's view before successfully calling `joinChannelEx`, the display of the first frame of the remote user's view occasionally experienced significant delay.

## v4.5.1

v4.5.1 was released on March 3, 2025.

**Attention:**

- As of v4.5.0, both Video SDK and Signaling SDK (v2.2.0 and above) include the `libaosl.dll` library. If you manually integrate Video SDK via CDN and also use Signaling SDK, delete the earlier version of the `libaosl.dll` library to avoid conflicts.
- The `libaosl.dll` library version in Video SDK v4.5.1 is xxx. You can check the version by viewing the `libaosl.dll` file properties.

#### New features

**AI conversation scenario**

This version adds the `AUDIO_SCENARIO_AI_CLIENT` audio scenario specifically designed for interacting with the conversational AI agent created by [Conversational AI Engine](https://docs.agora.io/en/conversational-ai/overview/product-overview). This scenario optimizes the audio transmission algorithm based on the characteristics of AI agent voice generation, ensuring stable voice data transmission in weak network environments (for example, 80% packet loss rate), and ensuring the continuity and reliability of the conversation, adapting to a variety of complex network conditions.

#### Issues fixed

This release fixed the following issues:

- When joining two or more channels simultaneously, and calling the `takeSnapshotEx [1/2]` method to take screenshots of the local video streams in each channel consecutively, the screenshot of the first channel failed.
- When using the `pause` method to pause playback, then calling `seek` to move to a specified position, and finally calling `play` to continue playback, the Media Player resumed from the position where it was paused, not the new specified position.
- When using the Media Player, the file path of the media resource returned by the `getPlaySrc` did not change after calling the `switchSrc` method to switch to a new media resource.
- In the interactive live streaming scenario, after joining a channel to watch live streams using `string` user id, the audience members occasionally saw that the audio was not synchronized with the video.
- Plugins sometimes did not work when using AI noise suppression and AI echo cancellation plugins at the same time.

## v4.5.0

This version was released on November x, 2024.

#### Compatibility changes

This version includes optimizations to some features, including changes to SDK behavior, API renaming and deletion. To ensure normal operation of the project, update the code in the app after upgrading to this release.

**Attention:**

As of v4.5.0, both RTC SDK and RTM SDK (v2.2.0 and above) include the `aosl.dll` library. If you manually integrate RTC SDK via CDN and also use RTM SDK, delete the lower version of the `aosl.dll` library to avoid conflicts. The `aosl.dll` library version in RTC SDK v4.5.0 is 1.2.13. You can check the version by viewing the `aosl.dll` file properties.

1. **Member Parameter Type Changes**

   To enhance the adaptability of various frameworks to the Native SDK, this version has made the following modifications to some API members or parameters:

   | API                             | Members/Parameters                                         | Change                                                       |
   | ------------------------------- | ---------------------------------------------------------- | ------------------------------------------------------------ |
   | `startScreenCaptureByDisplayId` | **displayId**                                              | Changed from uint32_t to int64_t                             |
   | `startScreenCaptureByWindowId`  | **windowId**                                               | Changed from view_t to int64_t                               |
   | `ScreenCaptureConfiguration`    | <ul><li>**displayId**</li><li>**windowId**</li></ul>       | <ul><li>**displayId**: Changed from uint32_t to int64_t</li><li>**windowId**: Changed from view_t to int64_t</li></ul> |
   | `ScreenCaptureSourceInfo`       | <ul><li>**sourceDisplayId**</li><li>**sourceId**</li></ul> | <ul><li>**sourceDisplayId**： Changed from view_t to int64_t</li><li>**sourceId**：Default value changed from `nullptr` to 0</li></ul> |

2. **Changes in strong video denoising implementation**

   This version adjusts the implementation of strong video denoising. The `VIDEO_DENOISER_LEVEL` removes `VIDEO_DENOISER_LEVEL_STRENGTH`. Instead, after enabling video denoising by calling `setVideoDenoiserOptions`, you can call the `setBeautyEffectOptions` method to enable the beauty skin smoothing feature. Using both together will achieve better video denoising effects. For strong denoising, it is recommended to set the skin smoothing parameters as detailed in `setVideoDenoiserOptions`.

   Additionally, due to this adjustment, to achieve the best low-light enhancement effect with a focus on image quality, you need to enable video denoising first and use specific settings as detailed in `setLowlightEnhanceOptions`.

3. **Changes in camera plug and unplug status**

   In previous versions, when the camera was unplugged and replugged, the `onVideoDeviceStateChanged` callback would report the device status as `MEDIA_DEVICE_STATE_ACTIVE`(1) (device in use). Starting from this version, after the camera is replugged, the device status will change to `MEDIA_DEVICE_STATE_IDLE`(0) (device ready).

4. **Changes in video encoding preferences**

   To enhance the user’s video interaction experience, this version optimizes the default preferences for video encoding:

   - In the `COMPRESSION_PREFERENCE` enumeration class, a new `PREFER_COMPRESSION_AUTO` (-1) enumeration is added, replacing the original `PREFER_QUALITY` (1) as the default value. In this mode, the SDK will automatically choose between `PREFER_LOW_LATENCY` or `PREFER_QUALITY` based on your video scene settings to achieve the best user experience.
   - In the `DEGRADATION_PREFERENCE` enumeration class, a new `MAINTAIN_AUTO` (-1) enumeration is added, replacing the original `MAINTAIN_QUALITY` (1) as the default value. In this mode, the SDK will automatically choose between `MAINTAIN_FRAMERATE`, `MAINTAIN_BALANCED`, or `MAINTAIN_RESOLUTION` based on your video scene settings to achieve the optimal overall quality experience (QoE).

#### New features

1. **Live show scenario**

   This version adds the `APPLICATION_SCENARIO_LIVESHOW`(3) (Live Show) enumeration to the `VIDEO_APPLICATION_SCENARIO_TYPE`. You can call `setVideoScenario` to set the video business scenario to showroom. To meet the high requirements for first frame rendering time and image quality in this scenario, the SDK has optimized strategies to significantly improve the first frame rendering experience and image quality, while enhancing the image quality in weak network environments and on low-end devices.

2. **Maximum frame rate for video rendering**

   This version adds the `setLocalRenderTargetFps` and `setRemoteRenderTargetFps` methods, which support setting the maximum frame rate for video rendering locally and remotely. The actual frame rate for video rendering by the SDK will be as close to this value as possible.

   In scenarios where the frame rate requirement for video rendering is not high (e.g., screen sharing, online education) or when the remote end uses mid-to-low-end devices, you can use this set of methods to limit the video rendering frame rate, thereby reducing CPU consumption and improving system performance.

3. **Watching live streaming through URLs**

   As of this version, audience members can directly open a specific URL to play the real-time media stream through `OpenWithUrl`, instead of joining a channel and subscribing to the streams of hosts, which greatly simplifies the API calls for the audience end to watch a live stream.

4. **Filter effects**

   This version introduces the `setFilterEffectOptions` method. You can pass a cube map file (.cube) in the `config` parameter to achieve custom filter effects such as whitening, vivid, cool, black and white, etc. Additionally, the SDK provides a built-in `built_in_whiten_filter.cube` file for quickly achieving a whitening filter effect.

5. **Local audio mixing**

   This version introduces the local audio mixing feature. You can call the `startLocalAudioMixer` method to mix the audio streams from the local microphone, media player, sound card, and remote audio streams into a single audio stream, which can then be published to the channel. When you no longer need audio mixing, you can call the `stopLocalAudioMixer` method to stop local audio mixing. During the mixing process, you can call the `updateLocalAudioMixerConfiguration` method to update the configuration of the audio streams being mixed.

   Example use cases for this feature include:

   - By utilizing the local video mixing feature, the associated audio streams of the mixed video streams can be simultaneously captured and published.
   - In live streaming scenarios, users can receive audio streams within the channel, mix multiple audio streams locally, and then forward the mixed audio stream to other channels.
   - In educational scenarios, teachers can mix the audio from interactions with students locally and then forward the mixed audio stream to other channels.

6. **Color space settings**

   This version adds the **colorSpace** parameter to `VideoFrame` and `ExternalVideoFrame`. You can use this parameter to set the color space properties of the video frame. By default, the color space uses Full Range and BT.709 standard configuration. You can flexibly adjust according to your own capture or rendering needs, further enhancing the customization capabilities of video processing.

7. **Others**

   - `onLocalVideoStateChanged` callback adds the `LOCAL_VIDEO_STREAM_REASON_DEVICE_DISCONNECTED` enumeration, indicating that the currently used video capture device has been disconnected (e.g., unplugged).
   - `MEDIA_DEVICE_STATE_TYPE` adds the `MEDIA_DEVICE_STATE_PLUGGED_IN` enumeration, indicating that the device has been plugged in.

#### Improvements

1. **Virtual background algorithm optimization**

   This version upgrades the virtual background algorithm, making the segmentation between the portrait and the background more accurate. There is no background exposure, the body contour of the portrait is complete, and the detail recognition of fingers is significantly improved. Additionally, the edges between the portrait and the background are more stable, reducing edge jumping and flickering in continuous video frames.

2. **Snapshot at specified video observation points**

   This version introduces the `takeSnapshot [2/2]` and `takeSnapshotEx [2/2]` methods. You can use the `config` parameter when calling these methods to take snapshots at specified video observation points, such as before encoding, after encoding, or before rendering, to achieve more flexible snapshot effects.

3. **Custom audio capture improvements**

   This version adds the `enableAudioProcessing` member parameter to `AudioTrackConfig`, which is used to control whether to enable 3A audio processing for custom audio capture tracks of the `AUDIO_TRACK_DIRECT` type. The default value of this parameter is `false`, meaning that audio processing is not enabled. Users can enable it as needed, enhancing the flexibility of custom audio processing.

4. **Other Improvements**

   - Optimizes the logic for calling `queryDeviceScore` to obtain device score levels, improving the accuracy of the score results.
   - Supports using virtual cameras in YV12 format as video capture devices.
   - When calling `switchSrc` to switch between live streams or on-demand streams of different resolutions, smooth and seamless switching can be achieved. An automatic retry mechanism has been added in case of switching failures. The SDK will automatically retry 3 times after a failure. If it still fails, the `onPlayerEvent` callback will report the `PLAYER_EVENT_SWITCH_ERROR` event, indicating an error occurred during media resource switching.
   - When calling `setPlaybackSpeed` to set the playback speed of an audio file, the minimum supported speed is 0.3x.

#### Bug fixes

This version fixes the following issues:

- When calling `startScreenCaptureByWindowId` to share the screen, the window capture area specified by `regionRect` was inaccurate, resulting in incorrect width and height of the screen sharing window seen by the receiving end.
- Occasional errors of not finding system files during audio and video interaction on Windows 7 systems.
- When calling `followSystemRecordingDevice` or `followSystemPlaybackDevice` to set the audio capture or playback device used by the SDK to not follow the system default audio playback device, the local audio state callback `onLocalAudioStateChanged` is not triggered when the audio device is removed, which is not as expected.
- Calling `startAudioMixing [1/2]` and then immediately calling `pauseAudioMixing` to pause the music file playback does not take effect.

## v4.4.0

This version was released on July x, 2024.

#### Compatibility changes

This version includes optimizations to some features, including changes to SDK behavior, API renaming and deletion. To ensure normal operation of the project, update the code in the app after upgrading to this release.

**Attention:** Starting from v4.4.0, the RTC SDK provides an API sunset notice, which includes information about deprecated and removed APIs in each version. See [API Sunset Notice](https://doc.shengwang.cn/api-ref/rtc/android/API/rtc_api_sunset).

1. To distinguish context information in different extension callbacks, this version removes the original extension callbacks and adds corresponding callbacks that contain context information (see the table below). You can identify the extension name, the user ID, and the service provider name through `ExtensionContext` in each callback.

   | Original callback    | Current callback                |
   | -------------------- | ------------------------------- |
   | `onExtensionEvent`   | `onExtensionEventWithContext`   |
   | `onExtensionStarted` | `onExtensionStartedWithContext` |
   | `onExtensionStopped` | `onExtensionStoppedWithContext` |
   | `onExtensionError`   | `onExtensionErrorWithContext`   |

2. This version renames the following members in `ExternalVideoFrame`:

   - `d3d11_texture_2d` is renamed to `d3d11Texture2d`.
   - `texture_slice_index` is renamed to `textureSliceIndex`.
   - `metadata_buffer` is renamed to `metadataBuffer`.
   - `metadata_size` is renamed to `metadataSize`.


#### New features

1. **Alpha transparency effects**

   This version introduces the Alpha transparency effects feature, supporting the transmission and rendering of Alpha channel data in video frames for SDK capture and custom capture scenarios, enabling transparent gift effects, custom backgrounds on the receiver end, etc.:

   - `VideoFrame` and `ExternalVideoFrame` add the `alphaBuffer` member: Sets the Alpha channel data.
   - `ExternalVideoFrame` adds the `fillAlphaBuffer` member: For BGRA or RGBA formatted video data, sets whether to automatically extract the Alpha channel data and fill it into `alphaBuffer`.
   - `VideoFrame` and `ExternalVideoFrame` add the `alphaStitchMode` member: Sets the relative position of `alphaBuffer` and video frame stitching.

   Additionally, `AdvanceOptions` adds a new member `encodeAlpha`, which is used to set whether to encode and send Alpha information to the remote end. By default, the SDK does not encode and send Alpha information; if you need to encode and send Alpha information to the remote end (for example, when virtual background is enabled), explicitly call `setVideoEncoderConfiguration` to set the video encoding properties and set `encodeAlpha` to `true`.

2. **Voice AI tuner**

   This version introduces the voice AI tuner feature, which can enhance the sound quality and tone, similar to a physical sound card. You can enable the voice AI tuner feature by calling the `enableVoiceAITuner` method and passing in the sound effect types supported in the `VOICE_AI_TUNER_TYPE` enum to achieve effects like deep voice, cute voice, husky singing voice, etc.

3. **1v1 video call scenario**

   This version adds `APPLICATION_SCENARIO_1V1` (1v1 video call) in `VIDEO_APPLICATION_SCENARIO_TYPE`. You can call `setVideoScenario` to set the video application scenario to 1v1 video call, the SDK optimizes performance to achieve low latency and high video quality, enhancing image quality, first frame rendering, latency on mid-to-low-end devices, and smoothness under poor network conditions.

#### Improvements

1. **Adaptive hardware decoding support**

   This release introduces adaptive hardware decoding support, enhancing rendering smoothness on low-end devices and effectively reducing system load.

2. **Rendering performance enhancement**

   DirectX 11 renderer is now enabled by default on Windows devices, providing high-performance and high-quality graphics rendering capabilities.

3. **Facial region beautification**

   To avoid losing details in non-facial areas during heavy skin smoothing, this version improves the skin smoothing algorithm. The SDK now recognizes various parts of the face, applying smoothing to facial skin areas excluding the mouth, eyes, and eyebrows. In addition, the SDK supports smoothing up to two faces simultaneously.

4. **Other improvements**

   This version also includes the following improvements:

   - Optimizes transmission strategy: calling `enableInstantMediaRendering` no longer impacts the security of the transmission link.
   - The `LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_DISPLAY_DISCONNECTED` enumerator is added in `onLocalVideoStateChanged` callback, indicating that the display used for screen capture has been disconnected.
   - Improves echo cancellation for screen sharing scenarios.
   - Adds the `channelId` parameter to `Metadata`, which is used to get the channel name from which the metadata is sent.
   - Deprecates redundant enumeration values `CLIENT_ROLE_CHANGE_FAILED_REQUEST_TIME_OUT` and `CLIENT_ROLE_CHANGE_FAILED_CONNECTION_FAILED` in `CLIENT_ROLE_CHANGE_FAILED_REASON`.

## v4.3.2

This version was released on May x, 20xx.

#### Improvements

This release enhances the usability of the [setRemoteSubscribeFallbackOption](API/api_irtcengine_setremotesubscribefallbackoption.html) method by removing the timing requirements for invocation. It can now be called both before and after joining the channel to dynamically switch audio and video stream fallback options in weak network conditions.

#### Issues fixed

This version fixed the following issues:

- Occasional video smoothness issues during audio and video interactions.
- The app occasionally crashed when the decoded video resolution on the receiving end was an odd number.
- The app occasionally crashed when remote users left the channel.
- The screen occasionally flickered on the receiver's side when sharing a PPT window using [startScreenCaptureByWindowId](API/api_irtcengine_startscreencapturebywindowid.html) and playing PPT animations.
- The window border did not retain its original size after exiting the presentation and then maximizing the PPT window when sharing a WPS PPT window on Windows 7 using [startScreenCaptureByWindowId](API/api_irtcengine_startscreencapturebywindowid.html) and setting `enableHighLight` in [ScreenCaptureParameters](API/class_screencaptureparameters.html) to `true`.
- The specified window could not be brought to the foreground if it was covered by other windows when sharing a window using [startScreenCaptureByWindowId](API/api_irtcengine_startscreencapturebywindowid.html) and setting `windowFocus` and `enableHighLight` in [ScreenCaptureParameters](API/class_screencaptureparameters.html) to `true`.
- Clicking on the desktop widget caused the outlined part to flicker when sharing and highlighting a window on a Windows 7 device.

## v4.3.1

This version is released on 2024 Month x, Day x.

#### New features

1. **Speech Driven Avatar**

   The SDK introduces a speech driven extension that converts speech information into corresponding facial expressions to animate avatar. You can access the facial information through the newly added [`registerFaceInfoObserver`](/api-ref/rtc/windows/API/toc_speech_driven#api_imediaengine_registerfaceinfoobserver) method and [`onFaceInfo`](/api-ref/rtc/windows/API/toc_speech_driven#callback_ifaceinfoobserver_onfaceinfo) callback. This facial information conforms to the ARKit standard for Blend Shapes (BS), which you can further process using third-party 3D rendering engines.

   The speech driven extension is a trimmable dynamic library, and details about the increase in app size are available at [reduce-app-size]().

   **Attention:**

   The speech driven avatar feature is currently in beta testing. To use it, please contact [technical support](mailto:support@agora.io).

2. **Data stream encryption**

   This version adds `datastreamEncryptionEnabled` to [`EncryptionConfig`](/api-ref/rtc/windows/API/class_encryptionconfig) for enabling data stream encryption. You can set this when you activate encryption with [`enableEncryption`](/api-ref/rtc/windows/API/toc_network#api_irtcengine_enableencryption). If there are issues causing failures in data stream encryption or decryption, these can be identified by the newly added `ENCRYPTION_ERROR_DATASTREAM_DECRYPTION_FAILURE` and `ENCRYPTION_ERROR_DATASTREAM_ENCRYPTION_FAILURE` enumerations.

3. **Adaptive configuration for low-quality video streams**

   This version introduces adaptive configuration for low-quality video streams. When you activate dual-stream mode and set up low-quality video streams on the sending side using [`setDualStreamMode`](/api-ref/rtc/windows/API/toc_dual_stream#api_irtcengine_setdualstreammode2)[2/2], the SDK defaults to the following behaviors:

   - The default encoding resolution for low-quality video streams is set to 50% of the original video encoding resolution.
   - The bitrate for the small streams is automatically matched based on the video resolution and frame rate, eliminating the need for manual specification.

4. **Other features**

   - New method [`enableEncryptionEx`](/api-ref/rtc/windows/API/toc_network#api_irtcengineex_enableencryptionex) is added for enabling media stream or data stream encryption in multi-channel scenarios.
   - New method [`setAudioMixingPlaybackSpeed`](/api-ref/rtc/windows/API/toc_audio_mixing#api_irtcengine_setaudiomixingplaybackspeed) is introduced for setting the playback speed of audio files.
   - New method [`getCallIdEx`](/api-ref/rtc/windows/API/toc_network#api_irtcengineex_getcallidex) is introduced for retrieving call IDs in multi-channel scenarios.

#### Improvements

1. **Optimization for game scenario screen sharing (Windows)**

   This version specifically optimizes screen sharing for game scenarios, enhancing performance, stability, and clarity in ultra-high definition (4K, 60 fps) game scenarios, resulting in a clearer, smoother, and more stable gaming experience for players.

2. **Virtual Background Algorithm Optimization**

   To enhance the accuracy and stability of human segmentation when activating virtual backgrounds against solid colors, this version optimizes the green screen segmentation algorithm:

   - Supports recognition of any solid color background, no longer limited to green screens.
   - Improves accuracy in recognizing background colors and reduces the background exposure during human segmentation.
   - After segmentation, the edges of the human figure (especially around the fingers) are more stable, significantly reducing flickering at the edges.

3. **CPU consumption reduction of in-ear monitoring**

   This release adds an enumerator `EAR_MONITORING_FILTER_REUSE_POST_PROCESSING_FILTER` (1 << 15) in `EAR_MONITORING_FILTER_TYPE`. For complex audio processing scenarios, you can specify this option to reuse the audio filter post sender-side processing in in-ear monitoring, thereby reducing CPU consumption. Note that this option may increase the latency of in-ear monitoring, which is suitable for latency-tolerant scenarios requiring low CPU consumption.

4. **Other improvements**

   This version also includes the following improvements:

   - Optimization of video encoding and decoding strategies in non-screen sharing scenarios to save system performance overhead.
   - Enhanced media player capabilities to handle WebM format videos, including support for rendering alpha channels.
   - In [`AUDIO_EFFECT_PRESET`](/api-ref/rtc/windows/API/enum_audioeffectpreset), a new enumeration `ROOM_ACOUSTICS_CHORUS` (chorus effect) is added, enhancing the spatial presence of vocals in chorus scenarios.
   - In [`RemoteAudioStats`](/api-ref/rtc/windows/API/class_remoteaudiostats), a new `e2eDelay` field is added to report the delay from when the audio is captured on the sending end to when the audio is played on the receiving end.

#### Issues fixed

This version fixed the following issues:

- Fixed an issue where SEI data output did not synchronize with video rendering when playing media streams containing SEI data using the media player.
- In screen sharing scenarios, when the app enabled sound card capture with [`enableLoopbackRecording`](/api-ref/rtc/windows/API/toc_audio_capture#api_irtcengine_enableloopbackrecording) to capture audio from the shared screen, the transmission of sound card captured audio failed after a local user manually disabled the local audio capture device, causing remote users to not hear the shared screen's audio.
- When a user plugged and unplugged a Bluetooth or wired headset once, the audio state change callback [`onAudioDeviceStateChanged`](/api-ref/rtc/windows/API/toc_audio_device#callback_irtcengineeventhandler_onaudiodevicestatechanged) was triggered multiple times.
- During interactions, when a local user set the system default playback device to speakers using [`setDevice`](/api-ref/rtc/windows/API/toc_audio_device#api_iaudiodevicecollection_setdevice), there was no sound from the remote end.
- When sharing an Excel document window, remote users occasionally saw a green screen.
- On devices using Intel graphics cards, occasionally there was a performance regression when publishing a small video stream.
- When the network conditions of the sender deteriorated (for example, in poor network environments), the receiver occasionally experienced a decrease in video smoothness and an increase in lag.

#### API Changes

**Added**

- [registerFaceInfoObserver](API/api_imediaengine_registerfaceinfoobserver.html)

- [IFaceInfoObserver](API/class_ifaceinfoobserver.html)

- [onFaceInfo](API/callback_ifaceinfoobserver_onfaceinfo.html)

- The `publishLipSyncTrack` member in [ChannelMediaOptions](API/class_channelmediaoptions)

- [MEDIA_SOURCE_TYPE](API/enum_mediasourcetype.html) adds `SPEECH_DRIVEN_VIDEO_SOURCE`

- [VIDEO_SOURCE_TYPE](API/enum_videosourcetype.html) adds `VIDEO_SOURCE_SPEECH_DRIVEN`

- [EncryptionConfig](API/class_encryptionconfig.html) adds `datastreamEncryptionEnabled`

- [ENCRYPTION_ERROR_TYPE](API/enum_encryptionerrortype.html) adds the following enumerations:
- `ENCRYPTION_ERROR_DATASTREAM_DECRYPTION_FAILURE`
  - `ENCRYPTION_ERROR_DATASTREAM_ENCRYPTION_FAILURE`

- [RemoteAudioStats](API/class_remoteaudiostats.html) adds `e2eDelay`

- [ERROR_CODE_TYPE](API/enum_errorcodetype.html) adds `ERR_DATASTREAM_DECRYPTION_FAILED`

- [AUDIO_EFFECT_PRESET](API/enum_audioeffectpreset.html) adds `ROOM_ACOUSTICS_CHORUS`, enhancing the spatial presence of vocals in chorus scenarios.

- [getCallIdEx](API/api_irtcengineex_getcallidex.html)

- [enableEncryptionEx](API/api_irtcengineex_enableencryptionex.html)

- [setAudioMixingPlaybackSpeed](API/api_irtcengine_setaudiomixingplaybackspeed.html)

- [EAR_MONITORING_FILTER_TYPE](API/enum_earmonitoringfiltertype.html) adds a new enumeration `EAR_MONITORING_FILTER_BUILT_IN_AUDIO_FILTERS`(1<<15)

## v4.3.0

v4.3.0 was released on xx xx, 2024.

#### Compatibility changes

This release has optimized the implementation of some functions, involving renaming or deletion of some APIs. To ensure the normal operation of the project, you need to update the code in the app after upgrading to this release.

1. **Renaming parameters in callbacks**

   In order to make the parameters in some callbacks and the naming of enumerations in enumeration classes easier to understand, the following modifications have been made in this release. Please modify the parameter settings in the callbacks after upgrading to this release.

   | Callback                           | Original parameter name | Existing parameter name |
   | ---------------------------------- | ----------------------- | ----------------------- |
   | `onLocalAudioStateChanged`         | `error`                 | `reason`                |
   | `onLocalVideoStateChanged`         | `error`                 | `reason`                |
   | `onDirectCdnStreamingStateChanged` | `error`                 | `reason`                |
   | `onPlayerSourceStateChanged`       | `ec`                    | `reason`                |
   | `onRtmpStreamingStateChanged`      | `errCode`               | `reason`                |

   | Original enumeration class   | Current enumeration class     |
   | ---------------------------- | ----------------------------- |
   | `LOCAL_AUDIO_STREAM_ERROR`   | `LOCAL_AUDIO_STREAM_REASON`   |
   | `LOCAL_VIDEO_STREAM_ERROR`   | `LOCAL_VIDEO_STREAM_REASON`   |
   | `DIRECT_CDN_STREAMING_ERROR` | `DIRECT_CDN_STREAMING_REASON` |
   | `MEDIA_PLAYER_ERROR`         | `MEDIA_PLAYER_REASON`         |
   | `RTMP_STREAM_PUBLISH_ERROR`  | `RTMP_STREAM_PUBLISH_REASON`  |

   **Note:** For specific renaming of enumerations, please refer to [API changes](#change).

2. **Channel media relay**

   To improve interface usability, this release removes some methods and callbacks for channel media relay. Use the alternative options listed in the table below:

   | Deleted methods and callbacks                                | Alternative methods and callbacks  |
   | ------------------------------------------------------------ | ---------------------------------- |
   | <li>`startChannelMediaRelay`</li><li>`updateChannelMediaRelay`</li> | `startOrUpdateChannelMediaRelay`   |
   | <li>`startChannelMediaRelayEx`</li><li>`updateChannelMediaRelayEx`</li> | `startOrUpdateChannelMediaRelayEx` |
   | `onChannelMediaRelayEvent`                                   | `onChannelMediaRelayStateChanged`  |

3. **Reasons for local video state changes**

   This release makes the following modifications to the enumerations in the [LOCAL_VIDEO_STREAM_ERROR](API/enum_localvideostreamreason.html) class:

   - The value of `LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_PAUSED` (formerly `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_PAUSED`) has been changed from 23 to 28.
   - The value of `LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_RESUMED` (formerly `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_RESUMED`) has been changed from 24 to 29.
   - The `LOCAL_VIDEO_STREAM_ERROR_CODEC_NOT_SUPPORT` enumeration has been changed to `LOCAL_VIDEO_STREAM_REASON_CODEC_NOT_SUPPORT`.

4. **Audio loopback capturing**

   - Before v4.3.0, if you call the [disableAudio](API/api_irtcengine_disableaudio.html) method to disable the audio module, audio loopback capturing will not be disabled.
- As of v4.3.0, if you call the [disableAudio](API/api_irtcengine_disableaudio.html) method to disable the audio module, audio loopback capturing will be disabled as well. If you need to enable audio loopback capturing, you need to enable the audio module by calling the [enableAudio](API/api_irtcengine_enableaudio.html) method and then call [enableLoopbackRecording](API/api_irtcengine_enableloopbackrecording.html).

5. **Log encryption behavior changes**

   For security and performance reasons, as of this release, the SDK encrypts logs and no longer supports printing plaintext logs via the console.

   Refer to the following solutions for different needs:

   - If you need to know the API call status, please check the API logs and print the SDK callback logs yourself.
   - For any other special requirements, please contact [technical support](mailto:support@agora.io) and provide the corresponding encrypted logs.

#### New features

1. **Local preview with multiple views**

   This release supports local preview with simultaneous display of multiple frames, where the videos shown in the frames are positioned at different observation positions along the video link. Examples of usage are as follows:

   1. Call [setupLocalVideo](API/api_irtcengine_setuplocalvideo.html) to set the first view: Set the `position` parameter to `POSITION_POST_CAPTURER_ORIGIN` (introduced in this release) in `VideoCanvas`. This corresponds to the position after local video capture and before preprocessing. The video observed here does not have preprocessing effects.
   2. Call [setupLocalVideo](API/api_irtcengine_setuplocalvideo.html) to set the second view: Set the `position` parameter to `POSITION_POST_CAPTURER` in `VideoCanvas`, the video observed here has the effect of video preprocessing.
   3. Observe the local preview effect: The first view is the original video of a real person; the second view is the virtual portrait after video preprocessing (including image enhancement, virtual background, and local preview of watermarks) effects.

2. **Query Device Score**

   This release adds the [queryDeviceScore](API/api_irtcengine_querydevicescore.html) method to query the device's score level to ensure that the user-set parameters do not exceed the device's capabilities. For example, in HD or UHD video scenarios, you can first call this method to query the device's score. If the returned score is low (for example, below 60), you need to lower the video resolution to avoid affecting the video experience. The minimum device score required for different business scenarios is varied. For specific score recommendations, please contact [technical support](mailto:support@agora.io).

3. **Select different audio tracks for local playback and streaming**

   This release introduces the [selectMultiAudioTrack](API/api_imediaplayer_selectmultiaudiotrack.html) method that allows you to select different audio tracks for local playback and streaming to remote users. For example, in scenarios like online karaoke, the host can choose to play the original sound locally and publish the accompaniment in the channel. Before using this function, you need to open the media file through the [openWithMediaSource](API/api_imediaplayer_openwithmediasource.html) method and enable this function by setting the `enableMultiAudioTrack` parameter in [MediaSource](API/class_mediasource.html).

4. **Others**

   This release has passed the test verification of the following APIs and can be applied to the entire series of RTC 4.x SDK.

   - [setRemoteSubscribeFallbackOption](API/api_irtcengine_setremotesubscribefallbackoption.html): Sets fallback option for the subscribed video stream in weak network conditions.
   - [onRemoteSubscribeFallbackToAudioOnly](API/callback_irtcengineeventhandler_onremotesubscribefallbacktoaudioonly.html): Occurs when the subscribed video stream falls back to audio-only stream due to weak network conditions or switches back to the video stream after the network conditions improve.
   - [setPlaybackDeviceVolume](API/api_iaudiodevicemanager_setplaybackdevicevolume.html): Sets the volume of the audio playback device.
   - [getRecordingDeviceVolume](API/api_iaudiodevicemanager_getrecordingdevicevolume.html): Sets the volume of the audio capturing device.
   - [setPlayerOption](API/api_imediaplayer_setplayeroption.html) and : Sets media player options for providing technical previews or special customization features.
   - [enableCustomAudioLocalPlayback](API/api_irtcengine_enablecustomaudiolocalplayback.html): Sets whether to enable the local playback of external audio source.

#### Improvements

1. **SDK task processing scheduling optimization**

   This release optimizes the scheduling mechanism for internal tasks within the SDK, with improvements in the following aspects:

   - The speed of video rendering and audio playback for both remote and local first frames improves by 10% to 20%.
   - The API call duration and response time are reduced by 5% to 50%.
   - The SDK's parallel processing capability significantly improves, delivering higher video quality (720P, 24 fps) even on lower-end devices. Additionally, image processing remains more stable in scenarios involving high resolutions and frame rates.
   - The stability of the SDK is further enhanced, leading to a noticeable decrease in the crash rate across various specific scenarios.

2. **In-ear monitoring volume boost**

   This release provides users with more flexible in-ear monitoring audio adjustment options, supporting the ability to set the in-ear monitoring volume to four times the original volume by calling [setInEarMonitoringVolume](API/api_irtcengine_setinearmonitoringvolume.html).


3. **Spatial audio effects usability improvement**

   - This release optimizes the design of the [setZones](API/api_ibasespatialaudioengine_setzones.html) method, supporting the ability to set the `zones` parameter to `NULL`, indicating the clearing of all echo cancellation zones.
   - As of this release, it is no longer necessary to unsubscribe from the audio streams of all remote users within the channel before calling the methods in [ILocalSpatialAudioEngine](API/class_ilocalspatialaudioengine.html) class.

4. **Other improvements**

   This release also includes the following improvements:

   - The [onLocalVideoStateChanged](API/callback_irtcengineeventhandler_onlocalvideostatechanged.html) callback is improved with the inclusion of the `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_AUTO_FALLBACK` enumeration, singaling unexpected errors during the screen sharing process (potentially due to window blocking failure), resulting in performance degradation without impacting the screen sharing process itself. (Windows)
   - This release optimizes the SDK's domain name resolution strategy, improving the stability of calling to resolve domain names in complex network environments.
   - When passing in an image with transparent background as the virtual background image, the transparent background can be filled with customized color.
   - This release adds the `earMonitorDelay` and `aecEstimatedDelay` members in [LocalAudioStats](API/class_localaudiostats.html) to report ear monitor delay and acoustic echo cancellation (AEC) delay, respectively.
   - The [onPlayerCacheStats](API/callback_imediaplayersourceobserver_onplayercachestats.html) callback is added to report the statistics of the media file being cached. This callback is triggered once per second after file caching is started.
   - The [onPlayerPlaybackStats](API/callback_imediaplayersourceobserver_onplayerplaybackstats.html) callback is added to report the statistics of the media file being played. This callback is triggered once per second after the media file starts playing. You can obtain information like the audio and video bitrate of the media file through [PlayerPlaybackStats](API/class_playerplaybackstats.html).

#### Issues fixed

This release fixed the following issues:

- When sharing two screen sharing video streams simultaneously, the reported `captureFrameRate` in the [onLocalVideoStats](API/callback_irtcengineeventhandler_onlocalvideostats.html) callback is 0, which is not as expected.
- When sharing in a specified screen area, the mouse coordinates within the shared area are inaccurate. When the mouse is near the border of the shared area, the mouse may not be visible in the shared screen. (Windows)
- The SDK failed to detect any changes in the audio routing after plugging in and out 3.5mm earphones.

#### API changes

#### <a name="change"></a>

**Added**

- The `subviewUid` member in [VideoCanvas](API/class_videocanvas.html)
- [enableCustomAudioLocalPlayback](API/api_irtcengine_enablecustomaudiolocalplayback.html)
- [queryDeviceScore](API/api_irtcengine_querydevicescore.html)
- The `CUSTOM_VIDEO_SOURCE` enumeration in [MEDIA_SOURCE_TYPE](API/enum_mediasourcetype.html)
- The `ROUTE_BLUETOOTH_DEVICE_A2DP` enumeration in [AudioRoute](API/enum_audioroute.html)
- [selectMultiAudioTrack](API/api_imediaplayer_selectmultiaudiotrack.html)
- [onPlayerCacheStats](API/callback_imediaplayersourceobserver_onplayercachestats.html)
- [onPlayerPlaybackStats](API/callback_imediaplayersourceobserver_onplayerplaybackstats.html)
- [PlayerPlaybackStats](API/class_playerplaybackstats.html)

**Modified**

- All `ERROR` fields in the following enumerations are changed to `REASON`:
  - `LOCAL_AUDIO_STREAM_ERROR_OK`
  - `LOCAL_AUDIO_STREAM_ERROR_FAILURE`
  - `LOCAL_AUDIO_STREAM_ERROR_DEVICE_NO_PERMISSION`
  - `LOCAL_AUDIO_STREAM_ERROR_DEVICE_BUSY`
  - `LOCAL_AUDIO_STREAM_ERROR_RECORD_FAILURE`
  - `LOCAL_AUDIO_STREAM_ERROR_ENCODE_FAILURE`
  - `LOCAL_AUDIO_STREAM_ERROR_RECORD_INVALID_ID`
  - `LOCAL_AUDIO_STREAM_ERROR_PLAYOUT_INVALID_ID`
  - `LOCAL_VIDEO_STREAM_ERROR_OK`
  - `LOCAL_VIDEO_STREAM_ERROR_FAILURE`
  - `LOCAL_VIDEO_STREAM_ERROR_DEVICE_NO_PERMISSION`
  - `LOCAL_VIDEO_STREAM_ERROR_DEVICE_BUSY`
  - `LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE`
  - `LOCAL_VIDEO_STREAM_ERROR_CODEC_NOT_SUPPORT`
  - `LOCAL_VIDEO_STREAM_ERROR_DEVICE_NOT_FOUND`
  - `LOCAL_VIDEO_STREAM_ERROR_DEVICE_DISCONNECTED`
  - `LOCAL_VIDEO_STREAM_ERROR_DEVICE_INVALID_ID`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_MINIMIZED`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_CLOSED`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_OCCLUDED`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_NO_PERMISSION`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_PAUSED`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_RESUMED`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_HIDDEN`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_HIDDEN`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_MINIMIZED`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_FAILURE`
  - `LOCAL_VIDEO_STREAM_ERROR_DEVICE_SYSTEM_PRESSURE`
  - `DIRECT_CDN_STREAMING_ERROR_OK`
  - `DIRECT_CDN_STREAMING_ERROR_FAILED`
  - `DIRECT_CDN_STREAMING_ERROR_AUDIO_PUBLICATION`
  - `DIRECT_CDN_STREAMING_ERROR_VIDEO_PUBLICATION`
  - `DIRECT_CDN_STREAMING_ERROR_NET_CONNECT`
  - `DIRECT_CDN_STREAMING_ERROR_BAD_NAME`
  - `PLAYER_ERROR_NONE`
  - `PLAYER_ERROR_INVALID_ARGUMENTS`
  - `PLAYER_ERROR_INTERNAL`
  - `PLAYER_ERROR_NO_RESOURCE`
  - `PLAYER_ERROR_INVALID_MEDIA_SOURCE`
  - `PLAYER_ERROR_UNKNOWN_STREAM_TYPE`
  - `PLAYER_ERROR_OBJ_NOT_INITIALIZED`
  - `PLAYER_ERROR_CODEC_NOT_SUPPORTED`
  - `PLAYER_ERROR_VIDEO_RENDER_FAILED`
  - `PLAYER_ERROR_INVALID_STATE`
  - `PLAYER_ERROR_URL_NOT_FOUND`
  - `PLAYER_ERROR_INVALID_CONNECTION_STATE`
  - `PLAYER_ERROR_SRC_BUFFER_UNDERFLOW`
  - `PLAYER_ERROR_INTERRUPTED`
  - `PLAYER_ERROR_NOT_SUPPORTED`
  - `PLAYER_ERROR_TOKEN_EXPIRED`
  - `PLAYER_ERROR_UNKNOWN`
  - `RTMP_STREAM_PUBLISH_ERROR_OK`
  - `RTMP_STREAM_PUBLISH_ERROR_INVALID_ARGUMENT`
  - `RTMP_STREAM_PUBLISH_ERROR_ENCRYPTED_STREAM_NOT_ALLOWED`
  - `RTMP_STREAM_PUBLISH_ERROR_CONNECTION_TIMEOUT`
  - `RTMP_STREAM_PUBLISH_ERROR_INTERNAL_SERVER_ERROR`
  - `RTMP_STREAM_PUBLISH_ERROR_RTMP_SERVER_ERROR`
  - `RTMP_STREAM_PUBLISH_ERROR_TOO_OFTEN`
  - `RTMP_STREAM_PUBLISH_ERROR_REACH_LIMIT`
  - `RTMP_STREAM_PUBLISH_ERROR_NOT_AUTHORIZED`
  - `RTMP_STREAM_PUBLISH_ERROR_STREAM_NOT_FOUND`
  - `RTMP_STREAM_PUBLISH_ERROR_FORMAT_NOT_SUPPORTED`
  - `RTMP_STREAM_PUBLISH_ERROR_NOT_BROADCASTER`
  - `RTMP_STREAM_PUBLISH_ERROR_TRANSCODING_NO_MIX_STREAM`
  - `RTMP_STREAM_PUBLISH_ERROR_NET_DOWN`
  - `RTMP_STREAM_PUBLISH_ERROR_INVALID_PRIVILEGE`
  - `RTMP_STREAM_UNPUBLISH_ERROR_OK`

**Deleted**

- `startChannelMediaRelay`
- `updateChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelayEx`
- `onChannelMediaRelayEvent`
- `CHANNEL_MEDIA_RELAY_EVENT`

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

**Other improvements**

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

1. The SDK automatically adjusts the frame rate of the sending end based on the screen sharing scenario. Especially in document sharing scenarios, this feature avoids exceeding the expected video bitrate on the sending end to improve transmission efficiency and reduce network burden.
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

