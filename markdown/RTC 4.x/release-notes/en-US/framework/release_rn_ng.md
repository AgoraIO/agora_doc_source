## Known issues and limitations

**Android 14 screen sharing issue**

On Android 14 devices (such as OnePlus 11), screen sharing may not be available when `targetSdkVersion` is set to 34. For example, half of the shared screen may be black. To avoid this issue, Agora recommends setting `targetSdkVersion` to 34 or below. However, this may cause the screen sharing process to be interrupted when switching between portrait and landscape mode. In this case, a window will pop up on the device asking if you want to start recording the screen. After confirming, you can resume screen sharing.

**AirPods Pro Bluetooth connection issue (iOS)**

AirPods Pro does not support A2DP protocol in communication audio mode, which may lead to connection failure in that mode.

## v4.4.0

This version was released on July x, 2024.

#### Compatibility changes

This version includes optimizations to some features, including changes to SDK behavior, API renaming and deletion. To ensure normal operation of the project, update the code in the app after upgrading to this release.

1. To distinguish context information in different extension callbacks, this version removes the original extension callbacks and adds corresponding callbacks that contain context information (see the table below). You can identify the extension name, the user ID, and the service provider name through `ExtensionContext` in each callback.

   | Original callback  | Current callback |
   | ------------------ | ---------------- |
   | `onExtensionEvent` | `onExtensionEventWithContext`   |
   | `onExtensionStarted` | `onExtensionStartedWithContext` |
   | `onExtensionStopped` | `onExtensionStoppedWithContext` |
   | `onExtensionError` | `onExtensionErrorWithContext`   |

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

   This version introduces the voice AI tuner feature, which can enhance the sound quality and tone, similar to a physical sound card. You can enable the voice AI tuner feature by calling the `enableVoiceAITuner` method and passing in the sound effect types supported in the `VoiceAiTunerType`enum to achieve effects like deep voice, cute voice, husky singing voice, etc.

3. **1v1 video call scenario**

   This version adds `ApplicationScenario1v1`(1v1 video call) in `VideoApplicationScenarioType`. You can call `setVideoScenario` to set the video application scenario to 1v1 video call, the SDK optimizes performance to achieve low latency and high video quality, enhancing image quality, first frame rendering, latency on mid-to-low-end devices, and smoothness under poor network conditions.

#### Improvements

1. **Adaptive hardware decoding support (Android)**

   This release introduces adaptive hardware decoding support, enhancing rendering smoothness on low-end devices and effectively reducing system load.

2. **Facial region beautification**

   To avoid losing details in non-facial areas during heavy skin smoothing, this version improves the skin smoothing algorithm. The SDK now recognizes various parts of the face, applying smoothing to facial skin areas excluding the mouth, eyes, and eyebrows. In addition, the SDK supports smoothing up to two faces simultaneously.

3. **Other improvements**

   This version also includes the following improvements:

   - Optimizes transmission strategy: calling `enableInstantMediaRendering` no longer impacts the security of the transmission link.
   - Adds the `channelId` parameter to `Metadata`, which is used to get the channel name from which the metadata is sent.
   - Deprecates redundant enumeration values `ClientRoleChangeFailedRequestTimeOut` and `ClientRoleChangeFailedConnectionFailed` in `ClientRoleChangeFailedReason`.

#### Issues fixed

This release fixed the following issues:

- Occasional app crashes occurred when multiple remote users joined the channel simultaneously during real-time interaction. (iOS)
- Remote video occasionally froze or displayed corrupted images when the app returned to the foreground after being in the background for a while. (iOS)
- After the sender called `startDirectCdnStreaming` to start direct CDN streaming, frequent switching or toggling of the network occasionally resulted in a black screen on the receiver's end without a streaming failure callback on the sender's end. (iOS)
- Audio playback failed when pushing external audio data using `pushAudioFrame` and the sample rate was not set as a recommended value, such as 22050 Hz and 11025 Hz.

## v4.3.2

This version was released on May x, 20xx.

#### Improvements

This release enhances the usability of the [setRemoteSubscribeFallbackOption](API/api_irtcengine_setremotesubscribefallbackoption.html) method by removing the timing requirements for invocation. It can now be called both before and after joining the channel to dynamically switch audio and video stream fallback options in weak network conditions.

#### Issues fixed

This version fixed the following issues:

- The remote video froze or became pixelated when the app returned to the foreground after being in the background for a long time. (iOS)
- The local preview image rotated by 90° on some iPad devices, which did not meet expectations. (iOS)
- Occasional video smoothness issues during audio and video interactions.
- The app occasionally crashed when the decoded video resolution on the receiving end was an odd number.
- The app crashed when opening the app and starting screen sharing after the first installation or system reboot. (Android)
- Local audio capture failed after joining a channel while answering a system phone call and hanging up, causing remote users to not hear any sound. (Android)
- During the interaction process on certain devices (for example, Redmi Note8), after answering and hanging up a system call, local media files were played without sound and no sound was heard from the remote end. (Android)
- The app occasionally crashed when remote users left the channel.
- When playing an audio file using and the playing finished, the SDK sometimes failed to trigger the [onAudioMixingStateChanged](API/callback_irtcengineeventhandler_onaudiomixingstatechanged.html)(AudioMixingStateStopped, AudioMixingReasonAllLoopsCompleted) callback which reports that the playing is completed. (iOS)
- When calling the [playEffect](API/api_irtcengine_playeffect3.html) method to play sound effect files shorter than 1 second with `loopCount` set to 0, there was no sound. (iOS)
- When using the Agora media player to play a video and stopping it during playing, sometimes there was no sound for a short time after the playing was resumed. (iOS)


## v4.3.1

This version is released on 2024 Month x, Day x.

#### New Features

1. **Speech Driven Avatar**

   The SDK introduces a speech driven extension that converts speech information into corresponding facial expressions to animate avatar. You can access the facial information through the newly added [`registerFaceInfoObserver`](/api-ref/rtc/rn/API/toc_speech_driven#api_imediaengine_registerfaceinfoobserver) method and [`onFaceInfo`](/api-ref/rtc/rn/API/toc_speech_driven#callback_ifaceinfoobserver_onfaceinfo) callback. This facial information conforms to the ARKit standard for Blend Shapes (BS), which you can further process using third-party 3D rendering engines.

   The speech driven extension is a trimmable dynamic library, and details about the increase in app size are available at [reduce-app-size]().

   **Attention:** The speech driven avatar feature is currently in beta testing. To use it, please contact [technical support](mailto:support@agora.io).

2. **Privacy manifest file (iOS)**

   To meet Apple's safety compliance requirements for app publication, the SDK now includes a privacy manifest file, `PrivacyInfo.xcprivacy`, detailing the SDK's API calls that access or use user data, along with a description of the types of data collected.

   **Note:** If you need to publish an app with SDK versions prior to v4.3.1 to the Apple App Store, you must manually add the `PrivacyInfo.xcprivacy` file to your Xcode project.

3. **Portrait center stage (iOS)**

   To enhance the presentation effect in online meetings, shows, and online education scenarios, this version introduces the [`enableCameraCenterStage`](/api-ref/rtc/rn/API/toc_center_stage#api_irtcengine_enablecameracenterstage) method to activate portrait center stage. This ensures that presenters, regardless of movement, always remain centered in the video frame, achieving better presentation effects.

   Before enabling portrait center stage, it is recommended to verify whether your current device supports this feature by calling [`isCameraCenterStageSupported`](/api-ref/rtc/rn/API/toc_center_stage#api_irtcengine_iscameracenterstagesupported). A list of supported devices can be found in the API documentation at [`enableCameraCenterStage`](/api-ref/rtc/rn/API/toc_center_stage#api_irtcengine_enablecameracenterstage).

4. **Camera stabilization (iOS)**

   To improve video stability in mobile filming, low-light environments, and hand-held shooting scenarios, this version introduces a camera stabilization feature. You can activate this feature and select an appropriate stabilization mode by calling [`setCameraStabilizationMode`](/api-ref/rtc/rn/API/toc_camera_capture#api_irtcengine_setcamerastabilizationmode), achieving more stable and clearer video footage.

5. **Wide and ultra-wide cameras (Android, iOS)**

   To allow users to capture a broader field of view and more complete scene content, this release introduces support for wide and ultra-wide cameras. You can first call [`queryCameraFocalLengthCapability`](/api-ref/rtc/rn/API/toc_video_device#api_irtcengine_querycamerafocallengthcapability) to check the device's focal length capabilities, and then call [`setCameraCapturerConfiguration`](/api-ref/rtc/rn/API/toc_video_device#api_irtcengine_setcameracapturerconfiguration) and set `cameraFocalLengthType` to the supported focal length types, including wide and ultra-wide.

6. **Multi-camera capture (Android)**

   This release introduces additional functionalities for Android camera capture:

   1. Support for capturing and publishing video streams from the third and fourth cameras:

      - `VideoSourceCameraThird` (11) and `VideoSourceCameraFourth` (12) in [`VideoSourceType`](/api-ref/rtc/rn/API/enum_videosourcetype) add support for Android, specifically for the third and fourth camera sources. This change allows you to specify up to four camera streams when initiating camera capture by calling [`startCameraCapture`](/api-ref/rtc/rn/API/toc_camera_capture#api_irtcengine_startcameracapture).
      - `publishThirdCameraTrack` and `publishFourthCameraTrack` in [`ChannelMediaOptions`](/api-ref/rtc/rn/API/class_channelmediaoptions) add support for Android. Set these parameters to `true` when joining a channel with [`joinChannel`](/api-ref/rtc/rn/API/toc_channel#api_irtcengine_joinchannel2) to publish video streams captured from the third and fourth cameras.

   2. Support for specifying cameras by camera ID:

      A new parameter `cameraId` is added to [`CameraCapturerConfiguration`](/api-ref/rtc/rn/API/class_cameracapturerconfiguration). For devices with multiple cameras, where `cameraDirection` cannot identify or access all available cameras, you can obtain the camera ID through Android's native system APIs and specify the desired camera by calling [`startCameraCapture`](/api-ref/rtc/rn/API/toc_camera_capture#api_irtcengine_startcameracapture) with the specific `cameraId`.

7. **Data stream encryption**

   This version adds `datastreamEncryptionEnabled` to [`EncryptionConfig`](/api-ref/rtc/rn/API/class_encryptionconfig) for enabling data stream encryption. You can set this when you activate encryption with [`enableEncryption`](/api-ref/rtc/rn/API/toc_network#api_irtcengine_enableencryption). If there are issues causing failures in data stream encryption or decryption, these can be identified by the newly added `EncryptionErrorDatastreamDecryptionFailure` and `EncryptionErrorDatastreamEncryptionFailure` enumerations.

8. **Adaptive configuration for low-quality video streams**

   This version introduces adaptive configuration for low-quality video streams. When you activate dual-stream mode and set up low-quality video streams on the sending side using [`setDualStreamMode`](/api-ref/rtc/rn/API/toc_dual_stream#api_irtcengine_setdualstreammode2), the SDK defaults to the following behaviors:

   - The default encoding resolution for low-quality video streams is set to 50% of the original video encoding resolution.
   - The bitrate for the small streams is automatically matched based on the video resolution and frame rate, eliminating the need for manual specification.

9. **Other features**

   - New method [`enableEncryptionEx`](/api-ref/rtc/rn/API/toc_network#api_irtcengineex_enableencryptionex) is added for enabling media stream or data stream encryption in multi-channel scenarios.
   - New method [`setAudioMixingPlaybackSpeed`](/api-ref/rtc/rn/API/toc_audio_mixing#api_irtcengine_setaudiomixingplaybackspeed) is introduced for setting the playback speed of audio files.
   - New method [`getCallIdEx`](/api-ref/rtc/rn/API/toc_network#api_irtcengineex_getcallidex) is introduced for retrieving call IDs in multi-channel scenarios.

#### Improvements

1. **Virtual Background Algorithm Optimization**

   To enhance the accuracy and stability of human segmentation when activating virtual backgrounds against solid colors, this version optimizes the green screen segmentation algorithm:

   - Supports recognition of any solid color background, no longer limited to green screens.
   - Improves accuracy in recognizing background colors and reduces the background exposure during human segmentation.
   - After segmentation, the edges of the human figure (especially around the fingers) are more stable, significantly reducing flickering at the edges.

2. **CPU consumption reduction of in-ear monitoring**

   This release adds an enumerator `EarMonitoringFilterReusePostProcessingFilter` (1 << 15) in `EarMonitoringFilterType`. For complex audio processing scenarios, you can specify this option to reuse the audio filter post sender-side processing in in-ear monitoring, thereby reducing CPU consumption. Note that this option may increase the latency of in-ear monitoring, which is suitable for latency-tolerant scenarios requiring low CPU consumption.

3. **Other improvements**

   This version also includes the following improvements:

   - Optimization of video encoding and decoding strategies in non-screen sharing scenarios to save system performance overhead. (iOS)
   - Enhanced performance and stability of the local compositing feature, reducing its CPU usage. (Android)
   - Enhanced media player capabilities to handle WebM format videos, including support for rendering alpha channels.
   - In [`AudioEffectPreset`](/api-ref/rtc/rn/API/enum_audioeffectpreset), a new enumeration `RoomAcousticsChorus` (chorus effect) is added, enhancing the spatial presence of vocals in chorus scenarios.
   - In [`RemoteAudioStats`](/api-ref/rtc/rn/API/class_remoteaudiostats), a new `e2eDelay` field is added to report the delay from when the audio is captured on the sending end to when the audio is played on the receiving end.

#### Issues fixed

This version fixed the following issues:

- Fixed an issue where SEI data output did not synchronize with video rendering when playing media streams containing SEI data using the media player.
- Broadcasters using certain models of devices under speaker mode experienced occasional local audio capture failures when switching the app process to the background and then back to the foreground, causing remote users to not hear the broadcaster's audio. (Android)
- On devices with Android 8.0, enabling screen sharing occasionally caused the app to crash. (Android)
- In scenarios using camera capture for local video, when the app was moved to the background and [`disableVideo`](/api-ref/rtc/rn/API/toc_video_basic#api_irtcengine_disablevideo) or was called to stop video capture, camera capture was unexpectedly activated when the app was brought back to the foreground. (Android)
- When the network conditions of the sender deteriorated (for example, in poor network environments), the receiver occasionally experienced a decrease in video smoothness and an increase in lag.

#### API Changes

**Added**

- [`enableCameraCenterStage`](/api-ref/rtc/rn/API/toc_center_stage#api_irtcengine_enablecameracenterstage) (iOS)
- [`isCameraCenterStageSupported`](/api-ref/rtc/rn/API/toc_center_stage#api_irtcengine_iscameracenterstagesupported) (iOS)
- [`setCameraStabilizationMode`](/api-ref/rtc/rn/API/toc_camera_capture#api_irtcengine_setcamerastabilizationmode) (iOS)
- [`CameraStabilizationMode`](/api-ref/rtc/rn/API/enum_camerastabilizationmode) (iOS)
- [`registerFaceInfoObserver`](/api-ref/rtc/rn/API/toc_speech_driven#api_imediaengine_registerfaceinfoobserver)
- [`unregisterFaceInfoObserver`](/api-ref/rtc/rn/API/toc_speech_driven#api_imediaengine_unregisterfaceinfoobserver)
- [`IFaceInfoObserver`](/api-ref/rtc/rn/API/class_ifaceinfoobserver)
- [`onFaceInfo`](/api-ref/rtc/rn/API/toc_speech_driven#callback_ifaceinfoobserver_onfaceinfo)
- The `publishLipSyncTrack` member in [`ChannelMediaOptions`](/api-ref/rtc/rn/API/class_channelmediaoptions)
- [`MediaSourceType`](/api-ref/rtc/rn/API/enum_mediasourcetype) adds `SpeechDrivenVideoSource`
- [`VideoSourceType`](/api-ref/rtc/rn/API/enum_videosourcetype) adds `VideoSourceSpeechDriven`
- [`EncryptionConfig`](/api-ref/rtc/rn/API/class_encryptionconfig) adds `datastreamEncryptionEnabled`
- [`EncryptionErrorType`](/api-ref/rtc/rn/API/enum_encryptionerrortype) adds the following enumerations:
  - `EncryptionErrorDatastreamDecryptionFailure`
  - `EncryptionErrorDatastreamEncryptionFailure`
- [`RemoteAudioStats`](/api-ref/rtc/rn/API/class_remoteaudiostats) adds `e2eDelay`
- [`ErrorCodeType`](/api-ref/rtc/rn/API/enum_errorcodetype) adds `ErrDatastreamDecryptionFailed`
- [`AudioEffectPreset`](/api-ref/rtc/rn/API/enum_audioeffectpreset) adds `RoomAcousticsChorus`, enhancing the spatial presence of vocals in chorus scenarios.
- [`getCallIdEx`](/api-ref/rtc/rn/API/toc_network#api_irtcengineex_getcallidex)
- [`enableEncryptionEx`](/api-ref/rtc/rn/API/toc_network#api_irtcengineex_enableencryptionex)
- [`setAudioMixingPlaybackSpeed`](/api-ref/rtc/rn/API/toc_audio_mixing#api_irtcengine_setaudiomixingplaybackspeed)
- [`queryCameraFocalLengthCapability`](/api-ref/rtc/rn/API/toc_video_device#api_irtcengine_querycamerafocallengthcapability) (Android, iOS)
- [`FocalLengthInfo`](/api-ref/rtc/rn/API/class_focallengthinfo) (Android, iOS)
- [`CameraFocalLengthType`](/api-ref/rtc/rn/API/enum_camerafocallengthtype) (Android, iOS)
- [`CameraCapturerConfiguration`](/api-ref/rtc/rn/API/class_cameracapturerconfiguration) adds a new member `cameraFocalLengthType` (Android, iOS)
- [`CameraCapturerConfiguration`](/api-ref/rtc/rn/API/class_cameracapturerconfiguration) adds a new member `cameraId` (Android)
- [`EarMonitoringFilterType`](/api-ref/rtc/rn/API/enum_earmonitoringfiltertype) adds a new enumeration `EarMonitoringFilterBuiltInAudioFilters`(1 << 15)

## v4.3.0-build.1

v4.3.0-build.1 was released on xx xx, 2024.

#### Issues fixed

This release fixed the following issue:

Directly calling `engine.release` to destroy the engine without prior call of `engine.unregisterEventHandler` to remove all callback events may lead to App crashes. (Android)

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
   | `onRtmpStreamingStateChanged`      | `errCode`               | `reason`                |

   | Original enumeration class   | Current enumeration class  |
   | ---------------------------- | -------------------------- |
   | `LocalAudioStreamError`      | `LocalAudioStreamReason`   |
   | `LocalVideoStreamError`      | `LocalVideoStreamReason`   |
   | `DirectCdnStreamingError`    | `DirectCdnStreamingReason` |
   | `MediaPlayerError`           | `MediaPlayerReason`        |
   | `RtmpStreamPublishErrorType` | `RtmpStreamPublishReason`  |

   **Note:** For specific renaming of enumerations, please refer to [API changes](Chunk327692110.html#apichange).

2. **Channel media relay**

   To improve interface usability, this release removes some methods and callbacks for channel media relay. Use the alternative options listed in the table below:

   | Deleted methods and callbacks                         | Alternative methods and callbacks  |
   | ----------------------------------------------------- | ---------------------------------- |
   | `startChannelMediaRelay``updateChannelMediaRelay`     | `startOrUpdateChannelMediaRelay`   |
   | `startChannelMediaRelayEx``updateChannelMediaRelayEx` | `startOrUpdateChannelMediaRelayEx` |
   | `onChannelMediaRelayEvent`                            | `onChannelMediaRelayStateChanged`  |

3. **Audio route**

   Starting with this release, `RouteBluetooth` in [AudioRoute](API/enum_audioroute.html) is renamed to `RouteBluetoothDeviceHFP`, representing a Bluetooth device using the HFP protocol. `RouteBluetoothDeviceA2DP`(10) is added to represent a Bluetooth device using the A2DP protocol.

4. **Reasons for local video state changes**

   This release makes the following modifications to the enumerations in the [LocalVideoStreamReason](API/enum_localvideostreamreason.html) class:

   - The value of `LocalVideoStreamReasonScreenCapturePaused` (formerly `LocalVideoStreamReasonScreenCapturePaused`) has been changed from 23 to 28.
   - The value of `LocalVideoStreamReasonScreenCaptureResumed` (formerly `LocalVideoStreamReasonScreenCaptureResumed`) has been changed from 24 to 29.
   - The `LocalVideoStreamReasonCodecNotSupport` enumeration has been changed to `LocalVideoStreamReasonCodecNotSupport`.

5. **Log encryption behavior changes**
   
   For security and performance reasons, as of this release, the SDK encrypts logs and no longer supports printing plaintext logs via the console. 
   
   Refer to the following solutions for different needs:
   - If you need to know the API call status, please check the API logs and print the SDK callback logs yourself.
   - For any other special requirements, please contact [technical support](mailto:support@agora.io) and provide the corresponding encrypted logs.

#### New features

1. **Custom mixed video layout on receiving end **

   To facilitate customized layout of mixed video stream at the receiver end, this release introduces the [onTranscodedStreamLayoutInfo](API/callback_irtcengineeventhandler_ontranscodedstreamlayoutinfo.html) callback. When the receiver receives the channel's mixed video stream sent by the video mixing server, this callback is triggered, reporting the layout information of the mixed video stream and the layout information of each sub-video stream in the mixed stream. The receiver can set a separate `view` for rendering the sub-video stream (distinguished by `subviewUid`) in the mixed video stream when calling the method, achieving a custom video layout effect.

   When the layout of the sub-video streams in the mixed video stream changes, this callback will also be triggered to report the latest layout information in real time.

   Through this feature, the receiver end can flexibly adjust the local view layout. When applied in a multi-person video scenario, the receiving end only needs to receive and decode a mixed video stream, which can effectively reduce the CPU usage and network bandwidth when decoding multiple video streams on the receiving end.

2. **Local preview with multiple views**

   This release supports local preview with simultaneous display of multiple frames, where the videos shown in the frames are positioned at different observation positions along the video link. Examples of usage are as follows:

   1. Create the first view: Set the `position` parameter to `PositionPostCapturerOrigin` (introduced in this release) in `VideoCanvas`. This corresponds to the position after local video capture and before preprocessing. The video observed here does not have preprocessing effects.
   2. Create the second view: Set the `position` parameter to `PositionPostCapturer` in `VideoCanvas`, the video observed here has the effect of video preprocessing.
   3. Observe the local preview effect: The first view is the original video of a real person; the second view is the virtual portrait after video preprocessing (including image enhancement, virtual background, and local preview of watermarks) effects.

3. **Query Device Score**

   This release adds the [queryDeviceScore](API/api_irtcengine_querydevicescore.html) method to query the device's score level to ensure that the user-set parameters do not exceed the device's capabilities. For example, in HD or UHD video scenarios, you can first call this method to query the device's score. If the returned score is low (for example, below 60), you need to lower the video resolution to avoid affecting the video experience. The minimum device score required for different business scenarios is varied. For specific score recommendations, please contact [technical support](mailto:support@agora.io).

4. **Select different audio tracks for local playback and streaming**

   This release introduces the [selectMultiAudioTrack](API/api_imediaplayer_selectmultiaudiotrack.html) method that allows you to select different audio tracks for local playback and streaming to remote users. For example, in scenarios like online karaoke, the host can choose to play the original sound locally and publish the accompaniment in the channel. Before using this function, you need to open the media file through the [openWithMediaSource](API/api_imediaplayer_openwithmediasource.html) method and enable this function by setting the `enableMultiAudioTrack` parameter in [MediaSource](API/class_mediasource.html).

5. **Others**

   This release has passed the test verification of the following APIs and can be applied to the entire series of RTC 4.x SDK.

   - [setRemoteSubscribeFallbackOption](API/api_irtcengine_setremotesubscribefallbackoption.html): Sets fallback option for the subscribed video stream in weak network conditions.
   - [onRemoteSubscribeFallbackToAudioOnly](API/callback_irtcengineeventhandler_onremotesubscribefallbacktoaudioonly.html): Occurs when the subscribed video stream falls back to audio-only stream due to weak network conditions or switches back to the video stream after the network conditions improve.
   - [setPlayerOptionInInt](API/api_imediaplayer_setplayeroption.html) and [setPlayerOptionInString](API/api_imediaplayer_setplayeroption2.html): Sets media player options for providing technical previews or special customization features.
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
   - As of this release, it is no longer necessary to unsubscribe from the audio streams of all remote users within the channel before calling the [ILocalSpatialAudioEngine](API/class_ilocalspatialaudioengine.html) method.

4. **Other Improvements**

   This release also includes the following improvements:

   - This release optimizes the SDK's domain name resolution strategy, improving the stability of calling to resolve domain names in complex network environments.
   - When passing in an image with transparent background as the virtual background image, the transparent background can be filled with customized color.
   - This release adds the `earMonitorDelay` and `aecEstimatedDelay` members in [LocalAudioStats](API/class_localaudiostats.html) to report ear monitor delay and acoustic echo cancellation (AEC) delay, respectively.
   - The [onPlayerCacheStats](API/callback_imediaplayersourceobserver_onplayercachestats.html) callback is added to report the statistics of the media file being cached. This callback is triggered once per second after file caching is started.
   - The [onPlayerPlaybackStats](API/callback_imediaplayersourceobserver_onplayerplaybackstats.html) callback is added to report the statistics of the media file being played. This callback is triggered once per second after the media file starts playing. You can obtain information like the audio and video bitrate of the media file through [PlayerPlaybackStats](API/class_playerplaybackstats.html).

#### Issues fixed

This release fixed the following issues:

- When sharing two screen sharing video streams simultaneously, the reported `captureFrameRate` in the [onLocalVideoStats](API/callback_irtcengineeventhandler_onlocalvideostats.html) callback is 0, which is not as expected.

#### API changes

**Added**

- [onTranscodedStreamLayoutInfo](API/callback_irtcengineeventhandler_ontranscodedstreamlayoutinfo.html)
- [VideoLayout](API/class_videolayout.html)
- The `subviewUid` member in [`VideoCanvas`](API/class_videocanvas.html)
- [enableCustomAudioLocalPlayback](API/api_irtcengine_enablecustomaudiolocalplayback.html)
- [queryDeviceScore](API/api_irtcengine_querydevicescore.html)
- The `CustomVideoSource` enumeration in [MediaSourceType](API/enum_mediasourcetype.html)
- The `RouteBluetoothDeviceA2DP` enumeration in [AudioRoute](API/enum_audioroute.html)
- [LocalAudioStats](API/class_localaudiostats.html)Adds the `earMonitorDelay` and `aecEstimatedDelay`
- [selectMultiAudioTrack](API/api_imediaplayer_selectmultiaudiotrack.html)
- [onPlayerCacheStats](API/callback_imediaplayersourceobserver_onplayercachestats.html)
- [onPlayerPlaybackStats](API/callback_imediaplayersourceobserver_onplayerplaybackstats.html)
- [PlayerPlaybackStats](API/class_playerplaybackstats.html)

**Modified**

- `routeBluetooth` is renamed as`RouteBluetoothDeviceHFP`
- All `ERROR` fields in the following enumerations are changed to `REASON`:
  - `LocalAudioStreamErrorOk`
  - `LocalAudioStreamErrorFailure`
  - `LocalAudioStreamErrorDeviceNoPermission`
  - `LocalAudioStreamErrorDeviceBusy`
  - `LocalAudioStreamErrorRecordFailure`
  - `LocalAudioStreamErrorEncodeFailure`
  - `LocalVideoStreamErrorOk`
  - `LocalVideoStreamErrorFailure`
  - `LocalVideoStreamErrorDeviceNoPermission`
  - `LocalVideoStreamErrorDeviceBusy`
  - `LocalVideoStreamErrorCaptureFailure`
  - `LocalVideoStreamErrorCodecNotSupport`
  - `LocalVideoStreamErrorCaptureInbackground` (iOS)
  - `LocalVideoStreamErrorCaptureMultipleForegroundApps` (iOS)
  - `LocalVideoStreamErrorDeviceNotFound`
  - `LocalVideoStreamErrorDeviceDisconnected`
  - `LocalVideoStreamErrorDeviceInvalidId`
  - `DirectCdnStreamingErrorOk`
  - `DirectCdnStreamingErrorFailed`
  - `DirectCdnStreamingErrorAudioPublication`
  - `DirectCdnStreamingErrorVideoPublication`
  - `DirectCdnStreamingErrorNetConnect`
  - `DirectCdnStreamingErrorBadName`
  - `PlayerErrorNone`
  - `PlayerErrorInvalidArguments`
  - `PlayerErrorInternal`
  - `PlayerErrorNoResource`
  - `PlayerErrorInvalidMediaSource`
  - `PlayerErrorUnknownStreamType`
  - `PlayerErrorObjNotInitialized`
  - `PlayerErrorCodecNotSupported`
  - `PlayerErrorVideoRenderFailed`
  - `PlayerErrorInvalidState`
  - `PlayerErrorUrlNotFound`
  - `PlayerErrorInvalidConnectionState`
  - `PlayerErrorSrcBufferUnderflow`
  - `PlayerErrorInterrupted`
  - `PlayerErrorNotSupported`
  - `PlayerErrorTokenExpired`
  - `PlayerErrorUnknown`
  - `RtmpStreamPublishErrorOk`
  - `RtmpStreamPublishErrorInvalidArgument`
  - `RtmpStreamPublishErrorEncryptedStreamNotAllowed`
  - `RtmpStreamPublishErrorConnectionTimeout`
  - `RtmpStreamPublishErrorInternalServerError`
  - `RtmpStreamPublishErrorRtmpServerError`
  - `RtmpStreamPublishErrorTooOften`
  - `RtmpStreamPublishErrorReachLimit`
  - `RtmpStreamPublishErrorNotAuthorized`
  - `RtmpStreamPublishErrorStreamNotFound`
  - `RtmpStreamPublishErrorFormatNotSupported`
  - `RtmpStreamPublishErrorNotBroadcaster`
  - `RtmpStreamPublishErrorTranscodingNoMixStream`
  - `RtmpStreamPublishErrorNetDown`
  - `RtmpStreamPublishErrorInvalidPrivilege`
  - `RtmpStreamUnpublishErrorOk`

**Deleted**

- `startChannelMediaRelay`
- `updateChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelayEx`
- `onChannelMediaRelayEvent`
- `ChannelMediaRelayEvent`


## v4.2.6

v4.2.6 was released on November xx, 2023.

#### Issues fixed

This version fixed the following issues that may occur when using Android 14:

- When switching between portrait and landscape modes during screen sharing, the screen sharing process was interrupted. To restart screen sharing, users need to confirm recording the screen in the pop-up window. (Android)
- When integrating the SDK, setting the Android `targetSdkVersion` to 34 may cause screen sharing to be unavailable or even cause the app to crash. (Android)
- Calling `startScreenCapture` without sharing video (setting `captureVideo` to `false`) and then calling `updateScreenCaptureParameters` to share video (setting `captureVideo` to `true`) resulted in a frozen shared screen at the receiving end. (Android)
- When screen sharing in landscape mode, the shared screen seen by the audience was divided into two parts: one side of the screen was compressed; the other side was black. (Android)

This version also fixed the following issues:

- When using an iOS 16 or later device with Bluetooth headphones connected before joining the channel, the audio routing after joining the channel was not as expected: audio was played from the speaker, not the Bluetooth headphones. (iOS)
- In live streaming scenarios, the video on the audience end  occasionally distorted. (Android)
- In specific scenarios (such as when the network packet loss rate was high or when the broadcaster left the channel without destroying the engine and then re-joined the channel), the video on the receiving end stuttered or froze.

## v4.2.5

v4.2.5 was released on October xx, 2023.

#### Issues fixed

This release fixed an incorrect path in the `types` filed in `package.json` which causes the error `Could not find a declaration file for module 'react-native-agora'` when integrating the SDK into a TypeScript project.

## v4.2.4

v4.2.4 was released on October xx, 2023.

This version fixes the incorrect `CFBundleShortVersionString` version number in `AgoraRtcWrapper` which caused the app to be unable to be submitted to the App Store. (iOS)

## v4.2.3

v4.2.3 was released on September xx, 2023.

#### New features

1. **Update video screenshot and upload**

   To facilitate the integration of third-party video moderation services from Agora Extensions Marketplace, this version has the following changes:

   - An optional parameter `serverConfig` is added in `ContentInspectConfig`, which is for server-side configuration related to video screenshot and upload via extensions from Agora Extensions Marketplace. By configuring this parameter, you can integrate multiple third-party moderation extensions and achieve flexible control over extension switches and other features. For more details, please contact [technical support](mailto:support@agora.io).

   In addition, this version also introduces the `enableContentInspectEx` method, which supports taking screenshots for multiple video streams and uploading them.

2. **Check device support for advanced features**

   This version adds the `isFeatureAvailableOnDevice` method to check whether the capability of the current device meet the requirements of the specified advanced feature, such as virtual background and image enhancement.

   Before using advanced features, you can check whether the current device supports these features based on the call result. This helps to avoid performance degradation or unavailable features when enabling advanced features on low-end devices. Based on the return value of this method, you can decide whether to display or enable the corresponding feature button, or notify the user when the device's capabilities are insufficient.

   In addition, since this version, calling `enableVirtualBackground` and `setBeautyEffectOptions` automatically triggers a test on the capability of the current device. When the device is considered underperformed, the error code `-4: ErrNotSupported` is returned, indicating the device does not support the feature.

3. **Wildcard token**

   This release introduces wildcard tokens. Agora supports setting the channel name used for generating a token as a wildcard character. The token generated can be used to join any channel if you use the same user id. In scenarios involving multiple channels, such as switching between different channels, using a wildcard token can avoid repeated application of tokens every time users joining a new channel, which reduces the pressure on your token server. See [Wildcard tokens](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).

   <div class="alert note">All 4.x SDKs support using wildcard tokens.</div>

4. **Preloading channels**

   This release adds `preloadChannel` and `preloadChannelWithUserAccount` methods, which allows a user whose role is set as audience to preload channels before joining one. Calling the method can help shortening the time of joining a channel, thus reducing the time it takes for audience members to hear and see the host.

   When preloading more than one channels, Agora recommends that you use a wildcard token for preloading to avoid repeated application of tokens every time you joining a new channel, thus saving the time for switching between channels. See [Wildcard tokens](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).

5. **Customized background color of video canvas**

   In this release, the `backgroundColor` member has been added to `VideoCanvas`, which allows you to customize the background color of the video canvas when setting the properties of local or remote video display.


#### Improvements

1. **Improved camera capture effect**

   This release has improved camera capture effect in the following aspects:

   1. Support for camera exposure adjustment

      This release adds `isCameraExposureSupported` to query whether the device supports exposure adjustment and `setCameraExposureFactor` to set the exposure ratio of the camera.

   2. Optimization of default camera selection (iOS)

      Since this release, the default camera selection behavior of the SDK is aligned with that of the iOS system camera. If the device has multiple rear cameras, better shooting perspectives, zooming capabilities, low-light performance, and depth sensing can be achieved during video capture, thereby improving the quality of video capture.


2. **Virtual Background Algorithm Upgrade**

   This version has upgraded the portrait segmentation algorithm of the virtual background, which comprehensively improves the accuracy of portrait segmentation, the smoothness of the portrait edge with the virtual background, and the fit of the edge when the person moves. In addition, it optimizes the precision of the person's edge in scenarios such as meetings, offices, homes, and under backlight or weak light conditions.

   This version reduces the memory usage of the virtual background feature. Compared to the previous version, the memory consumption of the app during the use of the virtual background feature on low-end devices has been reduced by approximately 4% to 10% (specific values may vary depending on the device model and platform).

3. **Screen sharing scenario optimization**

   This release also optimizes the video encoding configuration in screen sharing scenarios. When users customize the `width` and `height` properties of the video, the SDK rounds down the actual encoding resolution while maintaining the aspect ratio of the video and the screen, ensuring that the final encoding resolution does not exceed the user-defined encoding resolution, thereby improving the accuracy of billing for screen sharing streams.

4. **Channel media relay**

   The number of target channels for media relay has been increased to 6. When calling `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx`, you can specify up to 6 target channels.

5. **Enhancement in video codec query capability**

   To improve the video codec query capability, this release adds the `codecLevels` member in `CodecCapInfo`. After successfully calling `queryCodecCapability`, you can obtain the hardware and software decoding capability levels of the device for H.264 and H.265 video formats through `codecLevels`.


**Other Improvements**

This release includes the following additional improvements:

- Optimizes the logic of handling invalid parameters. When you call the `setPlaybackSpeed` method to set the playback speed of audio files, if you pass an invalid parameter, the SDK returns the error code -2, which means that you need to reset the parameter.
- Optimizes the logic of Token parsing, in order to prevent an app from crash when an invalid token is passed in.
- To improve the switching experience between multiple audio routes, this release adds the `setRouteInCommunicationMode` method. This method can switch the audio route from a Bluetooth headphone to the earpiece, wired headphone or speaker in communication volume mode ([`MODE_IN_COMMUNICATION`](https://developer.android.google.cn/reference/kotlin/android/media/AudioManager?hl=en#mode_in_communication)). (Android)
- The SDK automatically adjusts the frame rate of the sending end based on the screen sharing scenario. Especially in document sharing scenarios, this feature avoids exceeding the expected video bitrate on the sending end to improve transmission efficiency and reduce network burden.
- To help users understand the reasons for more types of remote video state changes, the `remoteVideoStateReasonCodecNotSupport` enumeration has been added to the `onRemoteVideoStateChanged` callback, indicating that the local video decoder does not support decoding the received remote video stream.

#### Issues fixed

This release fixed the following issues:

- Occasional failure of joining a channel when the local system time was not set correctly.
- When calling the `playEffect` method to play two audio files using the same `soundId`, the first audio file was sometimes played repeatedly.
- Calling `takeSnapshotEx` once receives the `onSnapshotTaken` callback for multiple times.
- When the host called the `startAudioMixing` method to play music, sometimes the host couldn't hear the music while the remote users could hear it. (Android)
- Occasional crashes occurred on certain Android devices. (Android)
- In channels joined by calling `joinChannelEx` exclusively, calling `setEnableSpeakerphone` is unable to switch audio route from the speaker to the headphone. (Android)
- Occasionally, noise occurred when the local user listened to their own and remote audio after joining the channel. (macOS)
- Slow channel reconnection after the connection was interrupted due to network reasons.
- In screen sharing scenarios, the delay of seeing the shared screen was occasionally higher than expected on some devices.
- In custom video capturing scenarios, `setBeautyEffectOptions`, `setLowlightEnhanceOptions`, `setVideoDenoiserOptions`, and `setColorEnhanceOptions` could not load extensions automatically.


#### API changes

**Added**

- `enableContentInspectEx`
- `contentInspectImageModeration` in `ContentInspectType`
- `serverConfig` in `ContentInspectConfig`
- `isFeatureAvailableOnDevice`
- `FeatureType`
- `setCameraExposureFactor`
- `isCameraExposureSupported`
- `preloadChannel`
- `preloadChannelWithUserAccount`
- `updatePreloadChannelToken`
- `setRouteInCommunicationMode` (Android)
- `CodecCapLevels`
- `VideoCodecCapabilityLevel`
- `backgroundColor` in `VideoCanvas`
- `codecLevels` in `CodecCapInfo`
- `remoteVideoStateReasonCodecNotSupport` in `RemoteVideoStateReason`



## v4.2.1

This version was released on June 21, 2023.

#### Improvements

This version improves the network transmission strategy, enhancing the smoothness of audio and video interactions.

#### Issues fixed

This version fixed the following issues:

- Inability to join channels caused by SDK's incompatibility with some older versions of AccessToken.
- After the sending end called `setAINSMode` to activate AI noise reduction, occasional echo was observed by the receiving end.
- Brief noise occurred while playing media files using the media player.
- Occasional crash after calling the `destroyMediaPlayer` method. (iOS)
- In screen sharing scenarios, some Android devices experienced choppy video on the receiving end. (Android)



## v4.2.0

v4.2.0 was released on May xx, 2023.

#### Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

**1. Video capture**

This release optimizes the APIs for camera and screen capture function. As of v4.2.0, ensure you use the alternative methods listed in the table below and specify the video source by setting the `sourceType` parameter.

| Deleted Methods                                              | Alternative Methods       |
| :----------------------------------------------------------- | :------------------------ |
|  `startSecondaryCameraCapture` | `startCameraCapture`             |
| `stopSecondaryCameraCapture`   | `stopCameraCapture`              |

**2. Video data acquisition**

- The `onCaptureVideoFrame` and `onPreEncodeVideoFrame` callbacks are added with a new parameter called `sourceType`, which is used to indicate the specific video source type.
- The following callbacks are deleted. Get the video source type through the `sourceType` parameter in the `onPreEncodeVideoFrame` and `onCaptureVideoFrame` callbacks.
  - `onScreenCaptureVideoFrame`
  - `onPreEncodeScreenVideoFrame`


**3. Channel media options**

- `publishCustomAudioTrackEnableAec` is deleted. Use `publishCustomAudioTrack` instead.
- `publishTrancodedVideoTrack` is renamed to `publishTranscodedVideoTrack`.
- `publishCustomAudioSourceId` is renamed to `publishCustomAudioTrackId`.



**4. Upgrade the default video encoding resolution**

As of this release, the SDK optimizes the video encoder algorithm and upgrades the default video encoding resolution from 640 × 360 to 960 × 540 to accommodate improvements in device performance and network bandwidth, providing users with a full-link HD experience in various audio and video interaction scenarios.

Call the setVideoEncoderConfiguration method to set the expected video encoding resolution in the video encoding parameters configuration.

<div class="note">The increase in the default resolution affects the aggregate resolution and thus the billing rate. See <a href="https://docs.agora.io/en/video-calling/reference/pricing">Pricing</a>.</div>

**5. Miscellaneous**

- `onApiCallExecuted` is deleted. Agora recommends getting the results of the API implementation through relevant channels and media callbacks.
- The `IAudioFrameObserver` class is renamed to `IAudioPcmFrameSink`, thus the prototype of the following methods are updated accordingly:
  - `onFrame`
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

- Automatically activate multiple anti-weak network technologies to enhance the capability and performance of low-quality video streams in meeting scenarios where high bitrates are required, ensuring smoothness when multiple streams are subscribed by the receiving end.
- Monitor the number of subscribers for the high-quality and low-quality video streams in real time, dynamically adjusting the configuration of the high-quality stream and dynamically enabling or disabling the low-quality stream, to save uplink bandwidth and consumption.

**4. Local video mixing**

This release adds the local video mixing feature. You can use the `startLocalVideoTranscoder` method to mix and render multiple video streams locally, such as camera-captured video, screen sharing streams, video files, images, etc. This allows you to achieve custom layouts and effects, making it easy to create personalized video display effects to meet various scenario requirements, such as remote meetings, live streaming, online education, while also supporting features like portrait-in-picture effect.

Additionally, the SDK provides the `updateLocalTranscoderConfiguration` method and the `onLocalVideoTranscoderError` callback. After enabling local video mixing, you can use the `updateLocalTranscoderConfiguration` method to update the video mixing configuration. Where an error occurs in starting the local video mixing or updating the configuration, you can get the reason for the failure through the `onLocalVideoTranscoderError` callback.

<div class="alert note">Local video mixing requires more CPU resources. Therefore, Agora recommends enabling this function on devices with higher performance.</div>

**5. Cross-device synchronization**

In real-time collaborative singing scenarios, network issues can cause inconsistencies in the downlinks of different client devices. To address this, this release introduces `getNtpWallTimeInMs` for obtaining the current Network Time Protocol (NTP) time. By using this method to synchronize lyrics and music across multiple client devices, users can achieve synchronized singing and lyricsprogression, resulting in a better collaborative experience.

**6. Instant frame rendering**

This release adds the `enableInstantMediaRendering` method to enable instant rendering mode for audio and video frames, which can speed up the first video or audio frame rendering after the user joins the channel.

**7. Video rendering tracing**

This release adds the `startMediaRenderingTracing` and `startMediaRenderingTracingEx` methods. The SDK starts tracing the rendering status of the video frames in the channel from the moment this method is called and reports information about the event through the `onVideoRenderingTracingResult` callback.

Agora recommends that you use this method in conjunction with the UI settings, such as buttons and sliders, in your app. For example, call this method when the user clicks **Join Channel** button and then get the indicators in the video frame rendering process through the `onVideoRenderingTracingResult` callback. This enables developers to optimize the indicators and improve the user experience.

#### Improvements

**1. Voice changer**

This release introduces the `setLocalVoiceFormant` method that allows you to adjust the formant ratio to change the timbre of the voice. This method can be used together with the `setLocalVoicePitch` method to adjust the pitch and timbre of voice at the same time, enabling a wider range of voice transformation effects.

**2. Enhanced screen share**

This release adds the `queryScreenCaptureCapability` method, which is used to query the screen capture capabilities of the current device. To ensure optimal screen sharing performance, particularly in enabling high frame rates like 60 fps, Agora recommends you to query the device's maximum supported frame rate using this method beforehand.

This release also adds the `setScreenCaptureScenario` method, which is used to set the scenario type for screen sharing. The SDK automatically adjusts the smoothness and clarity of the shared screen based on the scenario type you set.

**3. Improved compatibility with audio file types (Android)**

As of v4.2.0, you can use the following methods to open files with a URI starting with `content://` : `startAudioMixing`, `playEffect`, and `openWithMediaSource`.

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


**8. Video frame observer**

As of this release, the SDK optimizes the `onRenderVideoFrame` callback, and the meaning of the return value is different depending on the video processing mode:

When the video processing mode is `ProcessModeReadOnly`, the return value is reserved for future use.
When the video processing mode is `ProcessModeReadWrite`, the SDK receives the video frame when the return value is `true`. The video frame is discarded when the return value is `false`.

**9. Super resolution**

This release improves the performance of super resolution. To optimize the usability of super resolution, this release removes `enableRemoteSuperResolution`; super resolution no longer needs to be enabled manually. The SDK now automatically optimizes the resolution of the remote video based on the performance of the user's device.

#### Issues fixed

This release fixed the following issues:
- Occasional crashes occur on Android devices when users joining or leaving a channel. (Android)
- When the host frequently switching the user role between broadcaster and audience in a short period of time, the audience members cannot hear the audio of the host.
- Occasional failure when enabling in-ear monitoring.(Android)
- Occasional loss of the `firstRemoteVideoFrameOfUid` callback during channel media relay. (iOS)
- The receiver actively subscribed to the high-quality stream but unexpectedly received a low-quality stream. (iOS)
- Occasional echo. (Android)
- Abnormal client status cased by an exception in the `onRemoteAudioStateChanged` callback.
- Playing audio files with a sample rate of 48 kHz failed.
- Crashes occurred after users set the video resolution as 3840 × 2160 and started CDN streaming on Xiaomi Redmi 9A devices. (Android)
- In real-time chorus scenarios, remote users heard noises and echoes when an OPPO R11 device joined the channel in loudspeaker mode. (Android)
- When the playback of the local music finished, the onAudioMixingFinished callback was not properly triggered. (Android)
- When using a video frame observer, the first video frame was occasionally missed on the receiver's end. (Android)
- When sharing screens in scenarios involving multiple channels, remote users occasionally saw black screens. (Android)
- Switching to the rear camera with the virtual background enabled occasionally caused the background to be inverted.  (Android)
- When there were multiple video streams in a channel, calling some video enhancement APIs occasionally failed.

#### API changes

**Added**

- `startCameraCapture`
- `stopCameraCapture`
- `startOrUpdateChannelMediaRelay`
- `startOrUpdateChannelMediaRelayEx`
- `getNtpWallTimeInMs`
- `setVideoScenario`
- `getCurrentMonotonicTimeInMs`
- `onLocalVideoTranscoderError`
- `startLocalVideoTranscoder`
- `updateLocalTranscoderConfiguration`
- `queryScreenCaptureCapability`
- `setScreenCaptureScenario`
- `setAINSMode`
- `createCustomAudioTrack`
- `destroyCustomAudioTrack`
- `AudioTrackConfig`
- `AudioAinsMode`
- `AudioTrackType`
- `VideoApplicationScenarioType`
- `ScreenCaptureFramerateCapability`
- The `domainLimit` and `autoRegisterAgoraExtensions` members in `RtcEngineContext`
- The `sourceType` parameter in `onCaptureVideoFrame` and `onPreEncodeVideoFrame` callbacks
- The `BackgourndNone` and `BackgroundVideo` enumerators in `BackgroundSourceType`

**Deprecated**

- `startChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelay`
- `updateChannelMediaRelayEx`
- `onChannelMediaRelayEvent`
- `ChannelMediaRelayEvent`

**Deleted**

- `onApiCallExecuted`
- `publishCustomAudioTrackEnableAec` in `ChannelMediaOptions`
- `onScreenCaptureVideoFrame`
- `onPreEncodeScreenVideoFrame`


## v4.1.0

v4.1.0 was released on December xx, 2022.


#### Compatibility changes

This release deletes the `sourceType` parameter in `enableDualStreamMode`, because the SDK supports enabling dual-stream mode for various video sources captured by custom capture or SDK; you no longer need to specify the video source type.

#### New features

**1. In-ear monitoring**

This release adds support for in-ear monitoring. You can call `enableInEarMonitoring` to enable the in-ear monitoring function.

To adjust the in-ear monitoring volume, you can call `setInEarMonitoringVolume`.

**2. Audio capture device test (Android)**

This release adds support for testing local audio capture devices before joining a channel. You can call `startRecordingDeviceTest` to start the audio capture device test. After the test is complete, call the `stopPlaybackDeviceTest` method to stop the audio capture device test.

**3. Local network connection types**

To make it easier for users to know the connection type of the local network at any stage, this release adds the `getNetworkType` method. You can use this method to get the type of network connection in use. The available values are UNKNOWN, DISCONNECTED, LAN, WIFI, 2G, 3G, 4G, and 5G. When the local network connection type changes, the SDK triggers the `onNetworkTypeChanged` callback to report the current network connection type.

**4. Audio stream filter**

This release introduces filtering audio streams based on volume. Once this function is enabled, the Agora server ranks all audio streams by volume and transports the three audio streams with the highest volumes to the receivers by default. The number of audio streams to be transported can be adjusted; contact [support@agora.io](mailto:support@agora.io) to adjust this number according to your scenarios.

Agora also supports publishers in choosing whether the audio streams being published are to be filtered based on volume. Streams that are not filtered bypass this filter mechanism and are transported directly to the receivers. In scenarios with a number of publishers, enabling this function helps reduce the bandwidth and device system pressure for the receivers.

<div class="alert info">To enable this function, contact <a href="mailto:support@agora.io/">support@agora.io</a>.</div>

**5. Dual-stream mode**

This release optimizes the dual-stream mode. You can call `enableDualStreamMode` and `enableDualStreamModeEx` before and after joining a channel.

The implementation of subscribing to a low-quality video stream is expanded. The SDK enables the low-quality video stream auto mode on the sender by default (the SDK does not send low-quality video streams). Follow these steps to enable sending low-quality video streams:

1. The host at the receiving end calls `setRemoteVideoStreamType` or `setRemoteDefaultVideoStreamType` to initiate a low-quality video stream request.
2. After receiving the application, the sender automatically switches to sending low-quality video stream mode.

If you want to modify this default behavior, you can call `setDualStreamMode` and set the `mode` parameter to `disableSimulcastStream` (never send low-quality video streams) or `enableSimulcastStream` (always send low-quality video streams).

**6. Spatial audio effect**

This release adds the following features applicable to spatial audio effect scenarios, which can effectively enhance the user's sense-of-presence experience in virtual interactive scenarios.

- Sound insulation area: You can set a sound insulation area and sound attenuation parameter by calling `setZones`. When the sound source (which can be a user or the media player) and the listener belong to the inside and outside of the sound insulation area, the listener experiences an attenuation effect similar to that of the sound in the real environment when it encounters a building partition. You can also set the sound attenuation parameter for the media player and the user by calling `setPlayerAttenuation` and `setRemoteAudioAttenuation` respectively, and specify whether to use that setting to force an override of the sound attenuation parameter in `setZones`.
- Doppler sound: You can enable Doppler sound by setting the `enable_doppler` parameter in `SpatialAudioParams`. The receiver experiences noticeable tonal changes in the event of a high-speed relative displacement between the source source and receiver (such as in a racing game scenario).
- Headphone equalizer: You can use a preset headphone equalization effect by calling the `setHeadphoneEQPreset` method to improve the audio experience for users with headphones. If you cannot achieve the expected headphone EQ effect after calling `setHeadphoneEQPreset`, you can call `setHeadphoneEQParameters` to adjust the EQ.

**7. Multiple cameras for video capture (iOS)**

This release supports multi-camera video capture. You can call `enableMultiCamera` to enable multi-camera capture mode, call `startSecondaryCameraCapture` to start capturing video from the second camera, and then publish the captured video to the second channel.

To stop using multi-camera capture, you need to call `stopSecondaryCameraCapture` to stop the second camera capture, then call `enableMultiCamera` and set `enabled` to `false`.

**8. Encoded video frame observer**

This release adds the `setRemoteVideoSubscriptionOptions` and `setRemoteVideoSubscriptionOptionsEx` methods. When you call the `registerVideoEncodedFrameObserver` method to register a video frame observer for the encoded video frames, the SDK subscribes to the encoded video frames by default. If you want to change the subscription options, you can call these new methods to set them.

For more information about registering video observers and subscription options, see the [API reference](./API%20Reference/rn_ng/API/toc_video_observer.html#api_imediaengine_registervideoencodedframeobserver).



**9. MPUDP (MultiPath UDP) (Beta)**

As of this release, the SDK supports MPUDP protocol, which enables you to connect and use multiple paths to maximize the use of channel resources based on the UDP protocol. You can use different physical NICs on both mobile and desktop and aggregate them to effectively combat network jitter and improve transmission quality.

<div class="alert info">To enable this feature, contact <a href="mailto:sales@agora.io">sales@agora.io</a>.</div>

**10. Camera capture options**

This release adds the `followEncodeDimensionRatio` member in `CameraCapturerConfiguration`, which enables you to set whether to follow the video aspect ratio already set in `setVideoEncoderConfiguration` when capturing video with the camera.


**11. Multi-channel management**

This release adds a series of multi-channel related methods that you can call to manage audio and video streams in multi-channel scenarios.

- The `muteLocalAudioStreamEx` and `muteLocalVideoStreamEx` methods are used to cancel or resume publishing a local audio or video stream, respectively.
- The `muteAllRemoteAudioStreamsEx` and `muteAllRemoteVideoStreamsEx` are used to cancel or resume the subscription of all remote users to audio or video streams, respectively.
- The `startRtmpStreamWithoutTranscodingEx`, `startRtmpStreamWithTranscodingEx`, `updateRtmpTranscodingEx`, and `stopRtmpStreamEx` methods are used to implement Media Push in multi-channel scenarios.
- The `startChannelMediaRelayEx`, `updateChannelMediaRelayEx`, `pauseAllChannelMediaRelayEx`, `resumeAllChannelMediaRelayEx`, and `stopChannelMediaRelayEx` methods are used to relay media streams across channels in multi-channel scenarios.
- The `options` parameter in the `leaveChannelEx` method, which is used to choose whether to stop recording with the microphone when leaving a channel in a multi-channel scenario.


**12. Video encoding preferences**

In general scenarios, the default video encoding configuration meets most requirements. For certain specific scenarios, this release adds the `advanceOptions` member in `VideoEncoderConfiguration` for advanced settings of video encoding properties:

- `CompressionPreference`: The compression preferences for video encoding, which is used to select low-latency or high-quality video preferences.
- `EncodingPreference`: The video encoder preference, which is used to select adaptive preference, software encoder preference, or hardware encoder video preferences.

**13. Client role switching**

In order to enable users to know whether the switched user role is low-latency or ultra-low-latency, this release adds the `newRoleOptions` parameter to the `onClientRoleChanged` callback. The value of this parameter is as follows:

- `AudienceLatencyLevelLowLatency (1)`: Low latency.
- `AudienceLatencyLevelUltraLowLatency (2)`: Ultra-low latency.

#### Improvements

**1. Video information change callback**

This release optimizes the trigger logic of `onVideoSizeChanged`, which can also be triggered and report the local video size change when `startPreview` is called separately.

**2. Bluetooth permissions (Android)**

To simplify integration, as of this release, you can use the SDK to enable Android users to use Bluetooth normally without adding the `BLUETOOTH_CONNECT` permission.

**3. Relaying media streams across channels**

This release optimizes the `updateChannelMediaRelay` method as follows:

- Before v4.1.0: If the target channel update fails due to internal reasons in the server, the SDK returns the error code `RelayEventPacketUpdateDestChannelRefused (8)`, and you need to call the `updateChannelMediaRelay` method again.
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
- Improves the performance of echo cancellation when using the `audioScenarioMeeting` scenario.
- Improves the smoothness of SDK video rendering.
- Enhances the ability to identify different network protocol stacks and improves the SDK's access capabilities in multiple-operator network scenarios.



#### Issue fixed

This release fixed the following issues:

**All**
- When calling `setVideoEncoderConfigurationEx` in the channel to increase the resolution of the video, it occasionally failed.
- When using the Agora media player to play videos, after you played and paused the video, and then called the `seek` method to specify a new position for playback, the video image occasionally remained unchanged; if you called the `resume` method to resume playback, the video was sometimes played at a speed faster than the original one.
- When entering a live streaming room that has been played for a long time as an audience, the time for the first frame to be rendered was shortened.
- The call `getExtensionProperty` failed and returned an empty string.
- Audience members heard buzzing noises when the host switched between speakers and earphones during live streaming.


**Android**
- In online meeting scenarios, the local user and the remote user occasionally could not hear each other after the local user was interrupted by a call.
- After calling `setCloudProxy` to set the cloud proxy, calling `joinChannelEx` to join multiple channels failed.


**iOS**
- Calling `startAudioMixing` to play music files in the ipod-library://item path failed.
- Different timestamps for audio and video data were obtained simultaneously and separately via `onRecordAudioFrame` and `onCaptureVideoFrame` callbacks.

#### API changes

**Added**

- `getNativeHandle`
- `getMusicContentCenter`
- `getPlaybackDefaultDevice`
- `getRecordingDefaultDevice`
- `enableDualStreamModeEx`
- `setDualStreamMode`
- `setDualStreamModeEx`
- `SimulcastStreamMode`
- `getNetworkType`
- `setZones`
- `setPlayerAttenuation`
- `setRemoteAudioAttenuation`
- `setHeadphoneEQPreset`
- `setHeadphoneEQParameters`
- `HeadphoneEqualizerPreset`
- `enableMultiCamera` (iOS)
- `setRemoteVideoSubscriptionOptions`
- `setRemoteVideoSubscriptionOptionsEx`
- `VideoSubscriptionOptions`
- `AdvancedOptions`
- `EncodingPreference`
- `CompressionPreference`
- `adjustUserPlaybackSignalVolumeEx`
- `onRhythmPlayerStateChanged`
- `RhythmPlayerStateType`
- `RhythmPlayerErrorType`
- `enableAudioVolumeIndicationEx`
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

**Modified**

- Adds `isAudioFilterable` in `ChannelMediaOptions`
- Adds `enable_doppler` in `SpatialAudioParams`
- Adds `minimizeWindow` in `ScreenCaptureSourceInfo`
- Adds `followEncodeDimensionRatio` in `CameraCapturerConfiguration`
- Adds `options` in `leaveChannelEx`
- Adds `advanceOptions` in `VideoEncoderConfiguration`
- Adds `newRoleOptions` in `onClientRoleChanged`
- Adds `setupMode`, `mediaPlayerId`, and `cropArea` in `VideoCanvas`
- Adds `hwEncoderAccelerating` in `LocalVideoStats`
- Removes `sourceType` in `enableDualStreamMode`

**Deprecated**

- `onApiCallExecuted`: Use the callbacks triggered by specific methods instead.
- `RelayEventPacketUpdateDestChannelRefused (8)` in `ChannelMediaRelayEvent`


## v4.0.0

v4.0.0 was released on September 15, 2022.

#### New features

**3. Full HD and Ultra HD resolution**

In order to improve the interactive video experience, the SDK optimizes the whole process of video capturing, encoding, decoding and rendering. Starting from this version, it supports Full HD (FHD) and Ultra HD (UHD) video resolutions. You can set the `dimensions` parameter to 1920 × 1080 or higher resolution when calling the `setVideoEncoderConfiguration` method. If your device does not support high resolutions, the SDK will automatically fall back to an appropriate resolution.

<div class="alert info"><li>The UHD resolution (4K, 60 fps) is currently in beta and requires certain device performance and network bandwidth. If you want to experience this feature, contact <a href="mailto:support@agora.io">technical support</a>.
<li>High resolution typically means higher performance consumption. To avoid a decrease in experience due to insufficient device performance, Agora recommends that you enable FHD and UHD video resolutions on devices with better performance.
<li>The increase in the default resolution affects the aggregate resolution and thus the billing rate. See <a href="./billing_rtc_ng">Pricing</a>.</div>