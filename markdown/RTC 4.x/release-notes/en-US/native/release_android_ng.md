## Known issues and limitations

**Android 14 screen sharing issue**

On Android 14 devices (such as OnePlus 11), screen sharing may not be available when `targetSdkVersion` is set to 34. For example, half of the shared screen may be black. To avoid this issue, Agora recommends setting `targetSdkVersion` to 34 or below. However, this may cause the screen sharing process to be interrupted when switching between portrait and landscape mode. In this case, a window will pop up on the device asking if you want to start recording the screen. After confirming, you can resume screen sharing.



## v4.4.0

This version was released on July x, 2024.


#### Compatibility changes

This version includes optimizations to some features, including changes to SDK behavior, API renaming and deletion. To ensure normal operation of the project, update the code in the app after upgrading to this release.

**Attention:** Starting from v4.4.0, the RTC SDK provides an API sunset notice, which includes information about deprecated and removed APIs in each version. See [API Sunset Notice](https://doc.shengwang.cn/api-ref/rtc/android/API/rtc_api_sunset).

1. To distinguish context information in different extension callbacks, this version removes the original extension callbacks and adds corresponding callbacks that contain context information (see the table below). You can identify the extension name, the user ID, and the service provider name through `ExtensionContext` in each callback.

   | Original callback  | Current callback       |
   | ------------------ | ---------------------- |
   | `onEvent`   | `onEventWithContext`   |
   | `onStarted` | `onStartedWithContext` |
   | `onStopped` | `onStoppedWithContext` |
   | `onError`   | `onErrorWithContext`   |

2. This version removes the `buffer`, `uid`, and `timeStampMs` parameters of the `onMetadataReceived` callback. You can get metadata-related information, including `timeStampMs` (timestamp of the sent data), `uid` (user ID), and `channelId` (channel name) through the newly-added `metadata` parameter.

#### New features

1. **Lite SDK**

   Starting from this version, Agora introduces the Lite SDK, which includes only the basic audio and video capabilities and partially cuts advanced features, effectively reducing the app size after integrating the SDK.

   - Lite SDK supports manual integration or third-party repository integration. For details, see [Download SDKs]() and [Integrate the SDK]().
   - For information on dynamic libraries included in the Lite SDK, see [App size optimization]().
   - For the list of APIs supported by the Lite SDK, see [Lite SDK API List](https://doc.shengwang.cn/api-ref/rtc/android/API/rtc_lite_api).
   - For the limitations and precautions when using the Lite SDK to play media files, please refer to [Which audio file formats are supported by RTC SDK?](https://doc.shengwang.cn/faq/general-product-inquiry/audio-format)

2. **Alpha transparency effects**

   This version introduces the Alpha transparency effects feature, supporting the transmission and rendering of Alpha channel data in video frames for SDK capture and custom capture scenarios, enabling transparent gift effects, custom backgrounds on the receiver end, etc.:

   - `VideoFrame` and `AgoraVideoFrame` add the `alphaBuffer` member: Sets the Alpha channel data.
   - `AgoraVideoFrame` adds the `fillAlphaBuffer` member: For BGRA or RGBA formatted video data, sets whether to automatically extract the Alpha channel data and fill it into `alphaBuffer`.
   - `VideoFrame` and `AgoraVideoFrame` add the `alphaStitchMode` member: Sets the relative position of `alphaBuffer` and video frame stitching.

   Additionally, `AdvanceOptions` adds a new member `encodeAlpha`, which is used to set whether to encode and send Alpha information to the remote end. By default, the SDK does not encode and send Alpha information; if you need to encode and send Alpha information to the remote end (for example, when virtual background is enabled), explicitly call `setVideoEncoderConfiguration` to set the video encoding properties and set `encodeAlpha` to `true`.

3. **Voice AI tuner**

   This version introduces the voice AI tuner feature, which can enhance the sound quality and tone, similar to a physical sound card. You can enable the voice AI tuner feature by calling the `enableVoiceAITuner` method and passing in the sound effect types supported in the `VOICE_AI_TUNER_TYPE` enum to achieve effects like deep voice, cute voice, husky singing voice, etc.

4. **1v1 video call scenario**

   This version adds `APPLICATION_SCENARIO_1V1` (1v1 video call) in `VideoScenario`. You can call `setVideoScenario` to set the video application scenario to 1v1 video call, the SDK optimizes performance to achieve low latency and high video quality, enhancing image quality, first frame rendering, latency on mid-to-low-end devices, and smoothness under poor network conditions.

#### Improvements

1. **Adaptive hardware decoding support**

   This release introduces adaptive hardware decoding support, enhancing rendering smoothness on low-end devices and effectively reducing system load.

2. **Facial region beautification**

   To avoid losing details in non-facial areas during heavy skin smoothing, this version improves the skin smoothing algorithm. The SDK now recognizes various parts of the face, applying smoothing to facial skin areas excluding the mouth, eyes, and eyebrows. In addition, the SDK supports smoothing up to two faces simultaneously.

3. **Other improvements**

   This version also includes the following improvements:

   - Optimizes the parameter types of the following APIs. These improvements enhance code readability, reduce potential errors, and facilitate future maintenance.
     - Deprecates the `option` parameter of type int in `setRemoteSubscribeFallbackOption` [1/2], and adds an overloaded function `setRemoteSubscribeFallbackOption` [2/2] with the `option` parameter of type `StreamFallbackOptions`.
     - Deprecates the `streamType` parameter of type int in `setRemoteVideoStreamType` [1/2], `setRemoteDefaultVideoStreamType` [1/2], and `setRemoteVideoStreamTypeEx` [1/2], and adds overloaded functions `setRemoteVideoStreamType` [2/2], `setRemoteDefaultVideoStreamType` [2/2], and `setRemoteVideoStreamTypeEx` [2/2] with the `streamType` parameter of type `VideoStreamType`.
   - Optimizes transmission strategy: calling `enableInstantMediaRendering` no longer impacts the security of the transmission link.
   - Deprecates redundant enumeration values `CLIENT_ROLE_CHANGE_FAILED_REQUEST_TIME_OUT` and `CLIENT_ROLE_CHANGE_FAILED_CONNECTION_FAILED`.

#### Issues fixed

This release fixed the following issues:

- Audio playback failed when pushing external audio data using `pushExternalAudioFrame` and the sample rate was not set as a recommended value, such as 22050 Hz and 11025 Hz.



## v4.3.2

This version was released on May x, 20xx.

#### Improvements

1. This release enhances the usability of the [setRemoteSubscribeFallbackOption](API/api_irtcengine_setremotesubscribefallbackoption.html) method by removing the timing requirements for invocation. It can now be called both before and after joining the channel to dynamically switch audio and video stream fallback options in weak network conditions.
2. The Agora media player supports playing MP4 files with an Alpha channel.
3. The Agora media player fully supports playing music files located in the `/assets/` directory or from URI starting with `content://`. 

#### Issues fixed

This version fixed the following issues:

- Occasional video smoothness issues during audio and video interactions.
- The app occasionally crashed when the decoded video resolution on the receiving end was an odd number.
- The app crashed when opening the app and starting screen sharing after the first installation or system reboot.
- Local audio capture failed after joining a channel while answering a system phone call and hanging up, causing remote users to not hear any sound.
- During the interaction process on certain devices (for example, Redmi Note8), after answering and hanging up a system call, local media files were played without sound and no sound was heard from the remote end. (Android)
- The app occasionally crashed when remote users left the channel.
- The values of `cameraDirection` and `focalLengthType` in returned by [queryCameraFocalLengthCapability](API/api_irtcengine_querycamerafocallengthcapability.html) could not be read directly.


## v4.3.1

This version is released on 2024 Month x, Day x.

#### Compatibility changes

To ensure parameter naming consistency, this version renames `channelName` to `channelId` and `optionalUid` to `uid` in `joinChannel` [1/2]. You must update your app's code after upgrading to this version to ensure normal project operations.

#### New features

1. **Speech Driven Avatar**

   The SDK introduces a speech driven extension that converts speech information into corresponding facial expressions to animate avatar. You can access the facial information through the newly added [`registerFaceInfoObserver`](/api-ref/rtc/android/API/toc_speech_driven#api_imediaengine_registerfaceinfoobserver) method and [`onFaceInfo`](/api-ref/rtc/android/API/toc_speech_driven#callback_ifaceinfoobserver_onfaceinfo) callback. This facial information conforms to the ARKit standard for Blend Shapes (BS), which you can further process using third-party 3D rendering engines.

   The speech driven extension is a trimmable dynamic library, and details about the increase in app size are available at [reduce-app-size]().

   **Attention:**

   The speech driven avatar feature is currently in beta testing. To use it, please contact [technical support](mailto:support@agora.io).

2. **Wide and ultra-wide cameras**

   To allow users to capture a broader field of view and more complete scene content, this release introduces support for wide and ultra-wide cameras. You can first call [`queryCameraFocalLengthCapability`](/api-ref/rtc/android/API/toc_video_device#api_irtcengine_querycamerafocallengthcapability) to check the device's focal length capabilities, and then call [`setCameraCapturerConfiguration`](/api-ref/rtc/android/API/toc_video_device#api_irtcengine_setcameracapturerconfiguration) and set `cameraFocalLengthType` to the supported focal length types, including wide and ultra-wide.

3. **Multi-camera capture**

   This release introduces additional functionalities for Android camera capture:

   1. Support for capturing and publishing video streams from the third and fourth cameras:
      - New enumerators `VIDEO_SOURCE_CAMERA_THIRD`(11) and `VIDEO_SOURCE_CAMERA_FOURTH`(12) are added to [`VideoSourceType`](/api-ref/rtc/android/API/enum_videosourcetype), specifically for the third and fourth camera sources. This change allows you to specify up to four camera streams when initiating camera capture by calling [`startCameraCapture`](/api-ref/rtc/android/API/toc_camera_capture#api_irtcengine_startcameracapture).
      - New parameters `publishThirdCameraTrack` and `publishFourthCameraTrack` are added to [`ChannelMediaOptions`](/api-ref/rtc/android/API/class_channelmediaoptions). Set these parameters to `true` when joining a channel with [`joinChannel`](/api-ref/rtc/android/API/toc_channel#api_irtcengine_joinchannel2)[2/2] to publish video streams captured from the third and fourth cameras.
   2. Support for specifying cameras by camera ID:
      - A new parameter `cameraId` is added to [`CameraCapturerConfiguration`](/api-ref/rtc/android/API/class_cameracapturerconfiguration). For devices with multiple cameras, where `cameraDirection` cannot identify or access all available cameras, you can obtain the camera ID through Android's native system APIs and specify the desired camera by calling [`startCameraCapture`](/api-ref/rtc/android/API/toc_camera_capture#api_irtcengine_startcameracapture) with the specific `cameraId`.
      - New method [`switchCamera`](/api-ref/rtc/android/API/toc_video_device#api_irtcengine_switchcamera2)[2/2] supports switching cameras by `cameraId`, allowing apps to dynamically adjust camera usage during runtime based on available cameras.

4. **Data stream encryption**

   This version adds `datastreamEncryptionEnabled` to [`EncryptionConfig`](/api-ref/rtc/android/API/class_encryptionconfig) for enabling data stream encryption. You can set this when you activate encryption with [`enableEncryption`](/api-ref/rtc/android/API/toc_network#api_irtcengine_enableencryption). If there are issues causing failures in data stream encryption or decryption, these can be identified by the newly added `ENCRYPTION_ERROR_DATASTREAM_DECRYPTION_FAILURE` and `ENCRYPTION_ERROR_DATASTREAM_ENCRYPTION_FAILURE` enumerations.

5. **Local Video Rendering**

   This version adds the following members to [`VideoCanvas`](/api-ref/rtc/android/API/class_videocanvas) to support more local rendering capabilities:

   - `surfaceTexture`: Set a native Android `SurfaceTexture` object as the container providing video imagery, then use SDK external methods to perform OpenGL texture rendering.
   - `enableAlphaMask`: This member enables the receiving end to initiate alpha mask rendering. Alpha mask rendering can create images with transparent effects or extract human figures from video content.

6. **Adaptive configuration for low-quality video streams**

   This version introduces adaptive configuration for low-quality video streams. When you activate dual-stream mode and set up low-quality video streams on the sending side using [`setDualStreamMode`](/api-ref/rtc/android/API/toc_dual_stream#api_irtcengine_setdualstreammode2)[2/2], the SDK defaults to the following behaviors:

   - The default encoding resolution for low-quality video streams is set to 50% of the original video encoding resolution.
   - The bitrate for the small streams is automatically matched based on the video resolution and frame rate, eliminating the need for manual specification.

7. **Other features**

   - New method [`enableEncryptionEx`](/api-ref/rtc/android/API/toc_network#api_irtcengineex_enableencryptionex) is added for enabling media stream or data stream encryption in multi-channel scenarios.
   - New method [`setAudioMixingPlaybackSpeed`](/api-ref/rtc/android/API/toc_audio_mixing#api_irtcengine_setaudiomixingplaybackspeed) is introduced for setting the playback speed of audio files.
   - New method [`getCallIdEx`](/api-ref/rtc/android/API/toc_network#api_irtcengineex_getcallidex) is introduced for retrieving call IDs in multi-channel scenarios.

#### Improvements

1. **Optimization of local video status callbacks**

   This version introduces the following enumerations, allowing you to understand more about the reasons behind changes in local video status through the [`onLocalVideoStateChanged`](/api-ref/rtc/android/API/toc_video_basic#callback_irtcengineeventhandler_onlocalvideostatechanged) callback:

   - `LOCAL_VIDEO_STREAM_REASON_DEVICE_INTERRUPT` (14): Video capture is interrupted due to the camera being occupied by another app or the app moving to the background.
   - `LOCAL_VIDEO_STREAM_REASON_DEVICE_FATAL_ERROR` (15): Video capture device errors, possibly due to camera equipment failure.

2. **Camera capture improvements**

   Improvements have been made to the video processing mechanism of camera capture, reducing noise, enhancing brightness, and improving color, making the captured images clearer, brighter, and more realistic.

3. **Virtual Background Algorithm Optimization**

   To enhance the accuracy and stability of human segmentation when activating virtual backgrounds against solid colors, this version optimizes the green screen segmentation algorithm:

   - Supports recognition of any solid color background, no longer limited to green screens.
   - Improves accuracy in recognizing background colors and reduces the background exposure during human segmentation.
   - After segmentation, the edges of the human figure (especially around the fingers) are more stable, significantly reducing flickering at the edges.

4. **CPU consumption reduction of in-ear monitoring**

   This release adds an enumerator `EAR_MONITORING_FILTER_REUSE_POST_PROCESSING_FILTER` (1<<15). For complex audio processing scenarios, you can specify this option to reuse the audio filter post sender-side processing in in-ear monitoring, thereby reducing CPU consumption. Note that this option may increase the latency of in-ear monitoring, which is suitable for latency-tolerant scenarios requiring low CPU consumption.

5. **Other improvements**

   This version also includes the following improvements:

   - Enhanced performance and stability of the local compositing feature, reducing its CPU usage.
   - Enhanced media player capabilities to handle WebM format videos, including support for rendering alpha channels.
   - New chorus effect `ROOM_ACOUSTICS_CHORUS` is added to enhances the spatial presence of vocals in chorus scenarios.
   - In [`RemoteAudioStats`](/api-ref/rtc/android/API/class_remoteaudiostats), a new `e2eDelay` field is added to report the delay from when the audio is captured on the sending end to when the audio is played on the receiving end.

#### Issues fixed

This version fixed the following issues:

- Fixed an issue where SEI data output did not synchronize with video rendering when playing media streams containing SEI data using the media player.
- After joining a channel and calling [`disableAudio`](/api-ref/rtc/android/API/toc_audio_basic#api_irtcengine_disableaudio), audio playback did not immediately stop.
- Broadcasters using certain models of devices under speaker mode experienced occasional local audio capture failures when switching the app process to the background and then back to the foreground, causing remote users to not hear the broadcaster's audio.
- On devices with Android 8.0, enabling screen sharing occasionally caused the app to crash.
- In scenarios using camera capture for local video, when the app was moved to the background and [`disableVideo`](/api-ref/rtc/android/API/toc_video_basic#api_irtcengine_disablevideo) or [`stopPreview`](/api-ref/rtc/android/API/toc_video_basic#api_irtcengine_stoppreview)[1/2] was called to stop video capture, camera capture was unexpectedly activated when the app was brought back to the foreground.
- When the network conditions of the sender deteriorated (for example, in poor network environments), the receiver occasionally experienced a decrease in video smoothness and an increase in lag.

#### API Changes

**Added**

- The `surfaceTexture` and `enableAlphaMask` members in [`VideoCanvas`](/api-ref/rtc/android/API/class_videocanvas)
- `LOCAL_VIDEO_STREAM_REASON_DEVICE_INTERRUPT`
- `LOCAL_VIDEO_STREAM_REASON_DEVICE_FATAL_ERROR`
- [`registerFaceInfoObserver`](/api-ref/rtc/android/API/toc_speech_driven#api_imediaengine_registerfaceinfoobserver)
- [`IFaceInfoObserver`](/api-ref/rtc/android/API/class_ifaceinfoobserver)
- [`onFaceInfo`](/api-ref/rtc/android/API/toc_speech_driven#callback_ifaceinfoobserver_onfaceinfo)
- [`MediaSourceType`](/api-ref/rtc/android/API/enum_mediasourcetype) adds `SPEECH_DRIVEN_VIDEO_SOURCE`
- [`VideoSourceType`](/api-ref/rtc/android/API/enum_videosourcetype) adds `VIDEO_SOURCE_SPEECH_DRIVEN`
- [`EncryptionConfig`](/api-ref/rtc/android/API/class_encryptionconfig) adds `datastreamEncryptionEnabled`
- `ENCRYPTION_ERROR_DATASTREAM_DECRYPTION_FAILURE`
- `ENCRYPTION_ERROR_DATASTREAM_ENCRYPTION_FAILURE`
- [`RemoteAudioStats`](/api-ref/rtc/android/API/class_remoteaudiostats) adds `e2eDelay`
- `ERR_DATASTREAM_DECRYPTION_FAILED`
- `ROOM_ACOUSTICS_CHORUS` is added, enhancing the spatial presence of vocals in chorus scenarios.
- [`getCallIdEx`](/api-ref/rtc/android/API/toc_network#api_irtcengineex_getcallidex)
- [`enableEncryptionEx`](/api-ref/rtc/android/API/toc_network#api_irtcengineex_enableencryptionex)
- [`setAudioMixingPlaybackSpeed`](/api-ref/rtc/android/API/toc_audio_mixing#api_irtcengine_setaudiomixingplaybackspeed)
- [`queryCameraFocalLengthCapability`](/api-ref/rtc/android/API/toc_video_device#api_irtcengine_querycamerafocallengthcapability)
- [`AgoraFocalLengthInfo`](/api-ref/rtc/android/API/class_focallengthinfo)
- [`CAMERA_FOCAL_LENGTH_TYPE`](/api-ref/rtc/android/API/enum_camerafocallengthtype)
- [`CameraCapturerConfiguration`](/api-ref/rtc/android/API/class_cameracapturerconfiguration) adds a new member `cameraFocalLengthType`
- [`VideoSourceType`](/api-ref/rtc/android/API/enum_videosourcetype) adds the following enumerations:
  - `VIDEO_SOURCE_CAMERA_THIRD`(11)
  - `VIDEO_SOURCE_CAMERA_FOURTH`(12)
- [`ChannelMediaOptions`](/api-ref/rtc/android/API/class_channelmediaoptions) adds the following members:
  - `publishThirdCameraTrack`
  - `publishFourthCameraTrack`
  - `publishLipSyncTrack`
- [`CameraCapturerConfiguration`](/api-ref/rtc/android/API/class_cameracapturerconfiguration) adds a new member `cameraId`
- [`CAMERA_DIRECTION`](/api-ref/rtc/android/API/enum_cameradirection) adds `CAMERA_EXTRA`(2)
- [`switchCamera`](/api-ref/rtc/android/API/toc_video_device#api_irtcengine_switchcamera2)[2/2]
- `EAR_MONITORING_FILTER_BUILT_IN_AUDIO_FILTERS`(1<<15)

## v4.3.0

v4.3.0 was released on xx xx, 2024.

#### Compatibility changes

This release has optimized the implementation of some functions, involving renaming or deletion of some APIs. To ensure the normal operation of the project, you need to update the code in the app after upgrading to this release.

1. **Raw video data callback behavior change**

   As of this release, the callback processing related to raw video data changes from the previous fixed single thread to a random thread, meaning that callback processing can occur on different threads. Due to limitations in the Android system, OpenGL must be tightly bound to a specific thread. Therefore, Agora suggests that you make one of the following modifications to your code:

   - (Recommended) Use the `TextureBufferHelper` class to create a dedicated OpenGL thread for video pre-processing or post-processing (for example, image enhancement, stickers, etc.).
   - Use the `eglMakeCurrent` method to associate the necessary OpenGL context for each video frame with the current thread.

2. **Renaming parameters in callbacks**

   In order to make the parameters in some callbacks and the naming of enumerations in enumeration classes easier to understand, the following modifications have been made in this release. Please modify the parameter settings in the callbacks after upgrading to this release.

   | Callback                           | Original parameter name | Existing parameter name |
   | ---------------------------------- | ----------------------- | ----------------------- |
   | `onLocalAudioStateChanged`         | `error`                 | `reason`                |
   | `onLocalVideoStateChanged`         | `error`                 | `reason`                |
   | `onDirectCdnStreamingStateChanged` | `error`                 | `reason`                |
   | `onPlayerStateChanged`             | `error`                 | `reason`                |
   | `onRtmpStreamingStateChanged`      | `errCode`               | `reason`                |

   | Original enumeration class | Current enumeration class  |
   | -------------------------- | -------------------------- |
   | `DirectCdnStreamingReason` | `DirectCdnStreamingReason` |
   | `MediaPlayerReason`        | `MediaPlayerReason`        |

   **Note:** For specific renaming of enumerations, please refer to [API changes](C#apichange).

3. **Channel media relay**

   To improve interface usability, this release removes some methods and callbacks for channel media relay. Use the alternative options listed in the table below:

   | Deleted methods and callbacks                         | Alternative methods and callbacks  |
   | ----------------------------------------------------- | ---------------------------------- |
   | <ul><li>`startChannelMediaRelay`</li><li>`updateChannelMediaRelay`</li></ul>     | `startOrUpdateChannelMediaRelay`   |
   | <ul><li>`startChannelMediaRelayEx`</li><li>`updateChannelMediaRelayEx`</li></ul> | `startOrUpdateChannelMediaRelayEx` |
   | `onChannelMediaRelayEvent`                            | `onChannelMediaRelayStateChanged`  |

4. **Custom video source**

   Since this release, `pushExternalVideoFrameEx`[1/2] and `pushExternalVideoFrameEx`[2/2] are renamed to `pushExternalVideoFrameById`[1/2] and `pushExternalVideoFrame`[1/2], and are migrated from `RtcEngineEx` to `RtcEngine`.

5. **Audio route**

   Since this release, `RouteBluetooth` is renamed to `AUDIO_ROUTE_BLUETOOTH_DEVICE_HFP`, representing a Bluetooth device using the HFP protocol. The `AUDIO_ROUTE_BLUETOOTH_DEVICE_A2DP`(10) is added to represent a Bluetooth device using the A2DP protocol.

6. **The state of the remote video**

   To make the name of the enumeration easier to understand, this release changes the name of the enumeration from `REMOTE_VIDEO_STATE_PLAYING` to `REMOTE_VIDEO_STATE_DECODING`, while the meaning of the enumeration remains unchanged.

7. **Reasons for local video state changes**

   The `LOCAL_VIDEO_STREAM_ERROR_ENCODE_FAILURE` enumeration has been changed to `LOCAL_VIDEO_STREAM_REASON_CODEC_NOT_SUPPORT`.

8. **Log encryption behavior changes**
   
   For security and performance reasons, as of this release, the SDK encrypts logs and no longer supports printing plaintext logs via the console. 
   
   Refer to the following solutions for different needs:
   - If you need to know the API call status, please check the API logs and print the SDK callback logs yourself.
   - For any other special requirements, please contact [technical support](mailto:support@agora.io) and provide the corresponding encrypted logs.
   
9. **Removing IAgoraEventHandler interface**

   This release deletes the `IAgoraEventHandler` interface class. All callback events that were previously managed under this class are now processed through the `IRtcEngineEventHandler` interface class.

#### New features

1. **Custom mixed video layout on receiving end**

   To facilitate customized layout of mixed video stream at the receiver end, this release introduces the [`onTranscodedStreamLayoutInfo`](API/callback_irtcengineeventhandler_ontranscodedstreamlayoutinfo.html) callback. When the receiver receives the channel's mixed video stream sent by the video mixing server, this callback is triggered, reporting the layout information of the mixed video stream and the layout information of each sub-video stream in the mixed stream. The receiver can set a separate `view` for rendering the sub-video stream (distinguished by `subviewUid`) in the mixed video stream when calling the [`setupRemoteVideo`](API/api_irtcengine_setupremotevideo.html) method, achieving a custom video layout effect.

   When the layout of the sub-video streams in the mixed video stream changes, this callback will also be triggered to report the latest layout information in real time.

   Through this feature, the receiver end can flexibly adjust the local view layout. When applied in a multi-person video scenario, the receiving end only needs to receive and decode a mixed video stream, which can effectively reduce the CPU usage and network bandwidth when decoding multiple video streams on the receiving end.

2. **Local preview with multiple views**

   This release supports local preview with simultaneous display of multiple frames, where the videos shown in the frames are positioned at different observation positions along the video link. Examples of usage are as follows:

   1. Call [`setupLocalVideo`](API/api_irtcengine_setuplocalvideo.html) to set the first view: Set the `position` parameter to `VIDEO_MODULE_POSITION_POST_CAPTURER_ORIGIN` (introduced in this release) in `VideoCanvas`. This corresponds to the position after local video capture and before preprocessing. The video observed here does not have preprocessing effects.
   2. Call [`setupLocalVideo`](API/api_irtcengine_setuplocalvideo.html) to set the second view: Set the `position` parameter to `VIDEO_MODULE_POSITION_POST_CAPTURER` in `VideoCanvas`, the video observed here has the effect of video preprocessing.
   3. Observe the local preview effect: The first view is the original video of a real person; the second view is the virtual portrait after video preprocessing (including image enhancement, virtual background, and local preview of watermarks) effects.

3. **Query device score**

   This release adds the [`queryDeviceScore`](API/api_irtcengine_querydevicescore.html) method to query the device's score level to ensure that the user-set parameters do not exceed the device's capabilities. For example, in HD or UHD video scenarios, you can first call this method to query the device's score. If the returned score is low (for example, below 60), you need to lower the video resolution to avoid affecting the video experience. The minimum device score required for different business scenarios is varied. For specific score recommendations, please contact [technical support](mailto:support@agora.io).

4. **Select different audio tracks for local playback and streaming**

   This release introduces the [`selectMultiAudioTrack`](API/api_imediaplayer_selectmultiaudiotrack.html) method that allows you to select different audio tracks for local playback and streaming to remote users. For example, in scenarios like online karaoke, the host can choose to play the original sound locally and publish the accompaniment in the channel. Before using this function, you need to open the media file through the [`openWithMediaSource`](API/api_imediaplayer_openwithmediasource.html) method and enable this function by setting the `enableMultiAudioTrack` parameter in [`MediaPlayerSource`](API/class_mediasource.html).

5. **Audio playback device test**

   This release introduces the [`startPlaybackDeviceTest`](API/api_iaudiodevicemanager_startplaybackdevicetest.html) method to allow you to test whether you local audio device for playback works properly. You can specify the audio file to be played through the `testAudioFilePath` parameter and see if your audio device works properly. After the test is completed, you need to call the newly added [`stopPlaybackDeviceTest`](API/api_iaudiodevicemanager_stopplaybackdevicetest.html) method to stop the test.

6. **Others**

   This release has passed the test verification of the following APIs and can be applied to the entire series of RTC 4.x SDK.

   - [`setRemoteSubscribeFallbackOption`](API/api_irtcengine_setremotesubscribefallbackoption.html): Sets fallback option for the subscribed video stream in weak network conditions.
   - [`onRemoteSubscribeFallbackToAudioOnly`](API/callback_irtcengineeventhandler_onremotesubscribefallbacktoaudioonly.html): Occurs when the subscribed video stream falls back to audio-only stream due to weak network conditions or switches back to the video stream after the network conditions improve.
   - [`setPlayerOption`](API/api_imediaplayer_setplayeroption.html) and [`setPlayerOptionString`](API/api_imediaplayer_setplayeroption2.html): Sets media player options for providing technical previews or special customization features.
   - [`enableCustomAudioLocalPlayback`](API/api_irtcengine_enablecustomaudiolocalplayback.html): Sets whether to enable the local playback of external audio source.

#### Improvements

1. **SDK task processing scheduling optimization**

   This release optimizes the scheduling mechanism for internal tasks within the SDK, with improvements in the following aspects:

   - The speed of video rendering and audio playback for both remote and local first frames improves by 10% to 20%.
   - The API call duration and response time are reduced by 5% to 50%.
   - The SDK's parallel processing capability significantly improves, delivering higher video quality (720P, 24 fps) even on lower-end devices. Additionally, image processing remains more stable in scenarios involving high resolutions and frame rates.
   - The stability of the SDK is further enhanced, leading to a noticeable decrease in the crash rate across various specific scenarios.

2. **In-ear monitoring volume boost**

   This release provides users with more flexible in-ear monitoring audio adjustment options, supporting the ability to set the in-ear monitoring volume to four times the original volume by calling [`setInEarMonitoringVolume`](API/api_irtcengine_setinearmonitoringvolume.html).


3. **Spatial audio effects usability improvement**

   - This release optimizes the design of the [`setZones`](API/api_ibasespatialaudioengine_setzones.html) method, supporting the ability to set the `zones` parameter to `NULL`, indicating the clearing of all echo cancellation zones.
   - As of this release, it is no longer necessary to unsubscribe from the audio streams of all remote users within the channel before calling the [`ILocalSpatialAudioEngine`](API/class_ilocalspatialaudioengine.html) method.

4. **Optimization of video pre-processing methods**

   This release adds overloaded methods with the `sourceType` parameter for the following 5 video preprocessing methods, which support specifying the media source type for applying video preprocessing effects by passing in `sourceType` (for example, applying on a custom video capture media source):

   - [`setBeautyEffectOptions` [2/2]](API/api_irtcengine_setbeautyeffectoptions2.html)
   - [`setLowlightEnhanceOptions` [2/2]](API/api_irtcengine_setlowlightenhanceoptions2.html)
   - [`setVideoDenoiserOptions` [2/2]](API/api_irtcengine_setvideodenoiseroptions2.html)
   - [`setColorEnhanceOptions` [2/2]](API/api_irtcengine_setcolorenhanceoptions2.html)
   - [`enableVirtualBackground` [2/2]](API/api_irtcengine_enablevirtualbackground2.html)

5. **Other improvements**

   This release also includes the following improvements:

   - Adds `codecType` in [`VideoEncoderConfiguration`](API/class_videoencoderconfiguration.html) to set the video encoding type.
   - Adds `allowCaptureCurrentApp` member in [`AudioCaptureParameters`](API/class_screenaudioparameters.html), which is used to set whether to capture audio from the current app during screen sharing. The default value of this member is `true`, which means it collects the audio from the current app by default. In certain scenarios, the shared screen audio captured by the app may cause echo on the remote side due to signal delay and other reasons. Agora suggests setting this member as `false` to eliminate the remote echo introduced during the screen sharing process.
   - This release optimizes the SDK's domain name resolution strategy, improving the stability of calling `setLocalAccessPoint` to resolve domain names in complex network environments.
   - When passing in an image with transparent background as the virtual background image, the transparent background can be filled with customized color.
   - This release adds the `earMonitorDelay` and `aecEstimatedDelay` members in [`LocalAudioStats`](API/class_localaudiostats.html) to report ear monitor delay and acoustic echo cancellation (AEC) delay, respectively.
   - The [`onPlayerCacheStats`](API/callback_imediaplayersourceobserver_onplayercachestats.html) callback is added to report the statistics of the media file being cached. This callback is triggered once per second after file caching is started.
   - The [`onPlayerPlaybackStats`](API/callback_imediaplayersourceobserver_onplayerplaybackstats.html) callback is added to report the statistics of the media file being played. This callback is triggered once per second after the media file starts playing. You can obtain information like the audio and video bitrate of the media file through [`PlayerPlaybackStats`](API/class_playerplaybackstats.html).

#### Issues fixed

This release fixed the following issues:

- When sharing two screen sharing video streams simultaneously, the reported `captureFrameRate` in the [`onLocalVideoStats`](API/callback_irtcengineeventhandler_onlocalvideostats.html) callback is 0, which is not as expected.
- In a online meeting scenario, occasional audio freezes occurred when the local user was listening to remote users.

#### API changes

<a name="apichange"></a>

**Added**

- [`onTranscodedStreamLayoutInfo`](API/callback_irtcengineeventhandler_ontranscodedstreamlayoutinfo.html)
- [`VideoLayout`](API/class_videolayout.html)
- The `subviewUid` and `uid` members in `VideoCanvas`
- The `codecType` member in [`VideoEncoderConfiguration`](API/class_videoencoderconfiguration.html)
- The `allowCaptureCurrentApp` member in [AudioCaptureParameters](API/class_screenaudioparameters.html)
- [`enableCustomAudioLocalPlayback`](API/api_irtcengine_enablecustomaudiolocalplayback.html)
- [`selectMultiAudioTrack`](API/api_imediaplayer_selectmultiaudiotrack.html)
- [`onPlayerCacheStats`](API/callback_imediaplayersourceobserver_onplayercachestats.html)
- [`onPlayerPlaybackStats`](API/callback_imediaplayersourceobserver_onplayerplaybackstats.html)
- [`PlayerPlaybackStats`](API/class_playerplaybackstats.html)
- [`startPlaybackDeviceTest`](API/api_iaudiodevicemanager_startplaybackdevicetest.html)
- [`stopPlaybackDeviceTest`](API/api_iaudiodevicemanager_stopplaybackdevicetest.html)
- The `earMonitorDelay` and `aecEstimatedDelay` members in [LocalAudioStats](API/class_localaudiostats.html)
- [`queryDeviceScore`](API/api_irtcengine_querydevicescore.html)
- The `CUSTOM_VIDEO_SOURCE` enumeration in [MediaSourceType](API/enum_mediasourcetype.html)
- [`setBeautyEffectOptions` [2/2]](API/api_irtcengine_setbeautyeffectoptions2.html)
- [`setLowlightEnhanceOptions` [2/2]](API/api_irtcengine_setlowlightenhanceoptions2.html)
- [`setVideoDenoiserOptions` [2/2]](API/api_irtcengine_setvideodenoiseroptions2.html)
- [`setColorEnhanceOptions` [2/2]](API/api_irtcengine_setcolorenhanceoptions2.html)
- [`enableVirtualBackground` [2/2]](API/api_irtcengine_enablevirtualbackground2.html)
- The `AUDIO_ROUTE_BLUETOOTH_DEVICE_A2DP` enumeration

**Modified**

- `pushExternalVideoFrameEx`[1/2] and `pushExternalVideoFrameEx`[2/2] are renamed to `pushExternalVideoFrameById`[1/2] and `pushExternalVideoFrameById`[2/2], and are migrated from `RtcEngineEx` to `RtcEngine`
- `REMOTE_VIDEO_STATE_PLAYING` enumeration name changed to`REMOTE_VIDEO_STATE_DECODING`
- `ROUTE_BLUETOOTH` is renamed as `AUDIO_ROUTE_BLUETOOTH_DEVICE_HFP`
- All `ERROR` fields in the following enumerations are changed to `REASON`:
  - `LOCAL_AUDIO_STREAM_ERROR_OK`
  - `LOCAL_AUDIO_STREAM_ERROR_FAILURE`
  - `LOCAL_AUDIO_STREAM_ERROR_DEVICE_NO_PERMISSION`
  - `LOCAL_AUDIO_STREAM_ERROR_DEVICE_BUSY`
  - `LOCAL_AUDIO_STREAM_ERROR_CAPTURE_FAILURE`
  - `LOCAL_AUDIO_STREAM_ERROR_ENCODE_FAILURE`
  - `LOCAL_VIDEO_STREAM_ERROR_OK`
  - `LOCAL_VIDEO_STREAM_ERROR_FAILURE`
  - `LOCAL_VIDEO_STREAM_ERROR_DEVICE_NO_PERMISSION`
  - `LOCAL_VIDEO_STREAM_ERROR_DEVICE_BUSY`
  - `LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE`
  - `LOCAL_VIDEO_STREAM_ERROR_CODEC_NOT_SUPPORT`
  - `LOCAL_VIDEO_STREAM_ERROR_DEVICE_NOT_FOUND`
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


## v4.2.6

v4.2.6 was released on November xx, 2023.

#### Issues fixed

This version fixed the following issues that may occur when using Android 14:

- When switching between portrait and landscape modes during screen sharing, the screen sharing process was interrupted. To restart screen sharing, users need to confirm recording the screen in the pop-up window.
- When integrating the SDK, setting the Android `targetSdkVersion` to 34 may cause screen sharing to be unavailable or even cause the app to crash.
- Calling `startScreenCapture` without sharing video (setting `captureVideo` to `false`) and then calling `updateScreenCaptureParameters` to share video (setting `captureVideo` to `true`) resulted in a frozen shared screen at the receiving end.
- When screen sharing in landscape mode, the shared screen seen by the audience was divided into two parts: one side of the screen was compressed; the other side was black.

This version also fixed the following issues:

- In live streaming scenarios, the video on the audience end occasionally distorted.
- In specific scenarios (such as when the network packet loss rate was high or when the broadcaster left the channel without destroying the engine and then re-joined the channel), the video on the receiving end stuttered or froze.

## v4.2.3

v4.2.3 was released on September xx, 2023.

#### New features

1. **Update video screenshot and upload**

   To facilitate the integration of third-party video moderation services from Agora Extensions Marketplace, this version has the following changes:

   - The `CONTENT_INSPECT_TYPE_IMAGE_MODERATION` enumeration is added in the `type` parameter of `ContentInspectModule`, which means using video moderation extensions from Agora Extensions Marketplace to take video screenshots and upload them.
   - An optional parameter `serverConfig` is added in `ContentInspectConfig`, which is for server-side configuration related to video screenshot and upload via extensions from Agora Extensions Marketplace. By configuring this parameter, you can integrate multiple third-party moderation extensions and achieve flexible control over extension switches and other features. For more details, please contact [technical support](mailto:support@agora.io).

   In addition, this version also introduces the `enableContentInspectEx` method, which supports taking screenshots for multiple video streams and uploading them.

2. **Check device support for advanced features**

   This version adds the `isFeatureAvailableOnDevice` method to check whether the capability of the current device meets the requirements of the specified advanced feature, such as virtual background and image enhancement.

   Before using advanced features, you can check whether the current device supports these features based on the call result. This helps to avoid performance degradation or unavailable features when enabling advanced features on low-end devices. Based on the return value of this method, you can decide whether to display or enable the corresponding feature button, or notify the user when the device's capabilities are insufficient.

   In addition, since this version, calling `enableVirtualBackground` and `setBeautyEffectOptions` automatically triggers a test on the capability of the current device. When the device is considered underperformed, the error code `-4:ERR_NOT_SUPPORTED` is returned, indicating the device does not support the feature.

#### Improvements

1. **Optimize virtual background memory usage**

   This version has upgraded the virtual background algorithm, reducing the memory usage of the virtual background feature. Compared to the previous version, the memory consumption of the app during the use of the virtual background feature on low-end devices has been reduced by approximately 4% to 10% (specific values may vary depending on the device model and platform).

2. **Screen sharing scenario optimization**

   This release also optimizes the video encoding configuration in screen sharing scenarios. When users customize the `width` and `height` properties of the video, the SDK rounds down the actual encoding resolution while maintaining the aspect ratio of the video and the screen, ensuring that the final encoding resolution does not exceed the user-defined encoding resolution, thereby improving the accuracy of billing for screen sharing streams.

**Other improvements**

This release includes the following additional improvements:

- Optimizes the management method of Texture Buffer for SDK capture and custom video capture scenarios, effectively eliminating frame dropping and crash risks.
- Optimizes the logic of handling invalid parameters. When you call the `setPlaybackSpeed` method to set the playback speed of audio files, if you pass an invalid parameter, the SDK returns the error code -2, which means that you need to reset the parameter.
- Optimizes the logic of Token parsing, in order to prevent an app from crash when an invalid token is passed in.

#### Issues fixed

This release fixed the following issues:

- When using the H.265 encoding mode, when a Web client joined the interactivity, it caused a redundant `onUserEnableLocalVideo` callback on the native side: when the host called `enableLocalVideo (true)`, the receiving end first received a `onUserEnableLocalVideo` callback (with `enabled` as `false`) before receiving a `onUserEnableLocalVideo` callback (with `enabled` as `true`).
- Occasional failure of joining a channel when the local system time was not set correctly.
- When calling the `playEffect [2/2]` method to play two audio files using the same `soundId`, the first audio file was sometimes played repeatedly.
- When the host called the `startAudioMixing [2/2]` method to play music, sometimes the host couldn't hear the music while the remote users could hear it.
- Occasional crashes occurred on certain Android devices.
- Calling `takeSnapshotEx` once receives the `onSnapshotTaken` callback for multiple times.
- In channels joined by calling `joinChannelEx` exclusively, calling `setEnableSpeakerphone` is unable to switch audio route from the speaker to the headphone.

#### API changes

**Added**

- `enableContentInspectEx`
- `CONTENT_INSPECT_TYPE_IMAGE_MODERATION` in `type` of `ContentInspectModule`.
- `serverConfig` in `ContentInspectConfig`
- `isFeatureAvailableOnDevice`
- `FeatureType`


## v4.2.2

v4.2.2 was released on July xx, 2023.

#### Compatibility changes

In this version, some constructors have been removed from the `VideoCanvas` class.

#### New features

1. **Wildcard token**

   This release introduces wildcard tokens. Agora supports setting the channel name used for generating a token as a wildcard character. The token generated can be used to join any channel if you use the same user id. In scenarios involving multiple channels, such as switching between different channels, using a wildcard token can avoid repeated application of tokens every time users joining a new channel, which reduces the pressure on your token server. See [Wildcard tokens](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).

   <div class="alert note">All 4.x SDKs support using wildcard tokens.</div>

2. **Preloading channels**

   This release adds `preloadChannel[1/2]` and `preloadChannel[2/2]` methods, which allows a user whose role is set as audience to preload channels before joining one. Calling the method can help shortening the time of joining a channel, thus reducing the time it takes for audience members to hear and see the host.

   When preloading more than one channels, Agora recommends that you use a wildcard token for preloading to avoid repeated application of tokens every time you joining a new channel, thus saving the time for switching between channels. See [Wildcard tokens](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).

3. **Customized background color of video canvas**

   In this release, the `backgroundColor` member has been added to `VideoCanvas`, which allows you to customize the background color of the video canvas when setting the properties of local or remote video display.

#### Improvements

1. **Improved camera capture effect**

   Since this release, camera exposure adjustment is supported. This release adds `isCameraExposureSupported` to query whether the device supports exposure adjustment and `setCameraExposureFactor` to set the exposure ratio of the camera.

2. **Virtual Background Algorithm Upgrade**

   This version has upgraded the portrait segmentation algorithm of the virtual background, which comprehensively improves the accuracy of portrait segmentation, the smoothness of the portrait edge with the virtual background, and the fit of the edge when the person moves. In addition, it optimizes the precision of the person's edge in scenarios such as meetings, offices, homes, and under backlight or weak light conditions.

3. **Channel media relay**

   The number of target channels for media relay has been increased to 6. When calling `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx`, you can specify up to 6 target channels.

4. **Enhancement in video codec query capability**

   To improve the video codec query capability, this release adds the `codecLevels` member in `CodecCapInfo`. After successfully calling `queryCodecCapability`, you can obtain the hardware and software decoding capability levels of the device for H.264 and H.265 video formats through `codecLevels`.

This release includes the following additional improvements:

1. To improve the switching experience between multiple audio routes, this release adds the `setRouteInCommunicationMode` method. This method can switch the audio route from a Bluetooth headphone to the earpiece, wired headphone or speaker in communication volume mode ([`MODE_IN_COMMUNICATION`](https://developer.android.google.cn/reference/kotlin/android/media/AudioManager?hl=en#mode_in_communication)).
2. The SDK automatically adjusts the frame rate of the sending end based on the screen sharing scenario. Especially in document sharing scenarios, this feature avoids exceeding the expected video bitrate on the sending end to improve transmission efficiency and reduce network burden.
3. To help users understand the reasons for more types of remote video state changes, the `REMOTE_VIDEO_STATE_REASON_CODEC_NOT_SUPPORT` enumeration has been added to the `onRemoteVideoStateChanged` callback, indicating that the local video decoder does not support decoding the received remote video stream.

#### Issues fixed

This release fixed the following issues:

- Slow channel reconnection after the connection was interrupted due to network reasons.
- In screen sharing scenarios, the delay of seeing the shared screen was occasionally higher than expected on some devices.
- In custom video capturing scenarios, `setBeautyEffectOptions`, `setLowlightEnhanceOptions`, `setVideoDenoiserOptions`, and `setColorEnhanceOptions` could not load extensions automatically.

#### API changes

**Added**

- `setCameraExposureFactor`
- `isCameraExposureSupported`
- `preloadChannel[1/2]`
- `preloadChannel[2/2]`
- `updatePreloadChannelToken`
- `setRouteInCommunicationMode`
- `CodecCapLevels`
- `VideoCodecCapLevel`
- `backgroundColor` in `VideoCanvas`
- `codecLevels` in `CodecCapInfo`
- `REMOTE_VIDEO_STATE_REASON_CODEC_NOT_SUPPORT`

**Deleted**

- Some constructors in `VideoCanvas`

## v4.2.1

This version was released on June 21, 2023.

#### Improvements

This version improves the network transmission strategy, enhancing the smoothness of audio and video interactions.

#### Issues fixed

This version fixed the following issues:
- Inability to join channels caused by SDK's incompatibility with some older versions of AccessToken.
- After the sending end called `setAINSMode` to activate AI noise reduction, occasional echo was observed by the receiving end.
- Brief noise occurred while playing media files using the media player.
- In screen sharing scenarios, some Android devices experienced choppy video on the receiving end.

## v4.2.0

v4.2.0 was released on May 23, 2023.

#### Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

**1. Video data acquisition**

- The `onCaptureVideoFrame` and `onPreEncodeVideoFrame` callbacks are added with a new parameter called `sourceType`, which is used to indicate the specific video source type.
- The following callbacks are deleted. Get the video source type through the `sourceType` parameter in the `onPreEncodeVideoFrame` and `onCaptureVideoFrame` callbacks.
- `onScreenCaptureVideoFrame`
- `onPreEncodeScreenVideoFrame`

**2. Channel media options**

- `publishCustomAudioTrackEnableAec` in `ChannelMediaOptions` is deleted. Use `publishCustomAudioTrack` instead.
- `publishTrancodedVideoTrack` in `ChannelMediaOptions` is renamed to `publishTranscodedVideoTrack`.
- `publishCustomAudioSourceId` in `ChannelMediaOptions` is renamed to `publishCustomAudioTrackId`.

**3. Miscellaneous**

- `onApiCallExecuted` is deleted. Agora recommends getting the results of the API implementation through relevant channels and media callbacks.
- `enableDualStreamMode`[1/2] and `enableDualStreamMode`[2/2] are depredated. Use `setDualStreamMode`[1/2] and `setDualStreamMode`[2/2] instead.
- `startChannelMediaRelay`, `updateChannelMediaRelay`, `startChannelMediaRelayEx` and `updateChannelMediaRelayEx` are deprecated. Use `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx` instead.


#### New features

**1. AI noise reduction**

This release introduces the AI noise reduction function. Once enabled, the SDK automatically detects and reduces background noises. Whether in bustling public venues or real-time competitive arenas that demand lightning-fast responsiveness, this function guarantees optimal audio clarity, providing users with an elevated audio experience. You can enable this function through the newly-introduced `setAINSMode` method and set the noise reduction mode as balance, aggressive or low latency according to your scenarios.

**2. Enhanced virtual background**

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

This release introduces `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx`, allowing for a simpler and smoother way to start and update media relay across channels. With these methods, developers can easily start the media relay across channels and update the target channels for media relay with a single method. Additionally, the internal interaction frequency has been optimized, effectively reducing latency in function calls.

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
- `createCustomAudioTrack`
- `destroyCustomAudioTrack`
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
- `publishCustomAudioTrackEnableAec` in `ChannelMediaOptions` in `ChannelMediaOptions`
- `onScreenCaptureVideoFrame`
- `onPreEncodeScreenVideoFrame`



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
