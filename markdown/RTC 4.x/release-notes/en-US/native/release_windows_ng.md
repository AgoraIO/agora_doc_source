## v4.4.0

This version was released on July x, 2024.

#### Compatibility changes

This version includes optimizations to some features, including changes to SDK behavior, API renaming and deletion. To ensure normal operation of the project, update the code in the app after upgrading to this release.

**Attention:** Starting from v4.4.0, the RTC SDK provides an API sunset notice, which includes information about deprecated and removed APIs in each version. See [API Sunset Notice](https://doc.shengwang.cn/api-ref/rtc/android/API/rtc_api_sunset).

1. To distinguish context information in different extension callbacks, this version removes the original extension callbacks and adds corresponding callbacks that contain context information (see the table below). You can identify the extension name, the user ID, and the service provider name through `ExtensionContext` in each callback.

   | Original Callback    | Current Callback                |
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

#### Improvements

1. **Adaptive Hardware Decoding Support**

   This release introduces adaptive hardware decoding support, enhancing rendering smoothness on low-end devices and effectively reducing system load.

2. **Rendering Performance Enhancement**

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

