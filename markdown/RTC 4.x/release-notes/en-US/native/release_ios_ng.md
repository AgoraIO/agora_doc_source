## Known issues and limitations

**AirPods Pro Bluetooth connection issue**

AirPods Pro does not support A2DP protocol in communication audio mode, which may lead to connection failure in that mode.

## v4.5.2

v4.2.2 was released on April xx, 2025.

**Attention:**

- Starting from version 4.5.0, both RTC SDK and Signaling (version 2.2.0 and above) include the `aosl.xcframework` library. If you manually integrate Video SDK via CDN and also use Signaling SDK, delete the earlier version of the `aosl.xcframework` to avoid conflicts.
- 4.5.2 RTC SDK `aosl.xcframework` library version is 1.2.13. You can check the version information of the library in `Info.plist`.

#### Issues fixed

This release fixed the following issues:

- When playing a multi-track media file, noise can be heard after calling the `setAudioPitch:` method to adjust the audio pitch.
- The host called the `createCustomAudioTrack:config:` method to create custom audio track and set `trackType` to `AUDIO_TRACK_DIRECT`, called the `pushExternalAudioFrameRawData:samples:sampleRate:channels:trackId:timestamp:` to push custom audio frames into a channel and then called `playEffect:filePath:loopCount:pitch:pan:gain:publish:startPos:` to play audio effects, audience members in the channel would hear noise.
- Apps integrated with the SDK occasionally encountered UI lag caused by main thread blocking during audio and video interactions.
- Calling `openWithMediaSource:` and set `isLiveSource` in the `source` parameter to `YES` to play a video stream, the playback failed.
- Calling `enableVirtualBackground` to enable virtual background function, the virtual background image became larger and blurry when the phone was rotated.
- When the sender transmits multi-channel encoded audio, the receiver occasionally experienced noise.
- In scenarios where the App integrates a media player, when the open function is called twice to open different media resources consecutively, the second call to open unexpectedly resulted in the `AgoraRtcMediaPlayer:infoUpdated:` callback returning information for the first media resource.
- After calling `enableAudioVolumeIndication:smooth:reportVad:` to enable user volume indication, the `rtcEngine:reportAudioVolumeIndicationOfSpeakers:totalVolume:` callback returned a local user volume of 0 for both local streaming users and remote users.
- During audio and video communication, the App occasionally froze.
- When the App called `enableVideoImageSource:options:` to enable the video image source feature, the sending side occasionally succeeded in streaming, but `rtcEngine:didVideoPublishStateChange:sourceType:oldState:newState:elapseSinceLastState:` did not return the expected.
- In multi-channel scenarios, if the App called `setupRemoteVideoEx:connection:` to initialize the remote user's view before successfully calling `joinChannelExByToken:connection:delegate:mediaOptions:joinSuccess:`, the display of the first frame of the remote user's view occasionally experienced significant delay.

## v4.5.1

v4.5.1 was released on March 3, 2025.

**Attention:**

- As of v4.5.0, both Video SDK and Signaling SDK (v2.2.0 and above) include the `aosl.xcframework` library. If you manually integrate Video SDK via CDN and also use Signaling SDK, delete the earlier version of the `aosl.xcframework` library to avoid conflicts.
- The `aosl.xcframework` library version in Video SDK v4.5.1 is xxx. You can check the version in the `Info.plist` file.

#### New features

1. **AI conversation scenario**

   This version adds the `AgoraAudioScenarioAiClient` audio scenario specifically designed for interacting with the conversational AI agent created by [Conversational AI Engine](https://docs.agora.io/en/conversational-ai/overview/product-overview). This scenario optimizes the audio transmission algorithm based on the characteristics of AI agent voice generation, ensuring stable voice data transmission in weak network environments (for example, 80% packet loss rate), and ensuring the continuity and reliability of the conversation, adapting to a variety of complex network conditions.

#### Improvements

This release reduced the time of initializing the SDK on specific device models.

#### Issues fixed

This release fixed the following issues:

- When joining two or more channels simultaneously, and calling the `takeSnapshotEx:uid:filePath:` method to take screenshots of the local video streams in each channel consecutively, the screenshot of the first channel failed.
- When using the `pause` method to pause playback, then calling `seekToPosition:` to move to a specified position, and finally calling `play` to continue playback, the Media Player resumed from the position where it was paused, not the new specified position.
- When using the Media Player, the file path of the media resource returned by the `getPlaySrc` did not change after calling the `switchSrc:syncPts:` method to switch to a new media resource.
- When pushing video frames in i420 format to the channel, using CVPixelBuffer to handle these frames caused a crash.
- Calling `setupLocalVideo:` to set up two views, then calling `enableFaceDetection:` to start face detection, no face information can be detected in the subsequently passed views.
- In a screen sharing scenario, the receiving-end user saw a green line on the shared image.
- In the interactive live streaming scenario, after joining a channel to watch live streams using `string` user id, the audience members occasionally saw that the audio was not synchronized with the video.
- Plugins sometimes did not work when using AI noise suppression and AI echo cancellation plugins at the same time.

## v4.5.0

This version was released on November x, 2024.

#### Compatibility changes

This version includes optimizations to some features, including changes to SDK behavior, API renaming and deletion. To ensure normal operation of the project, update the code in the app after upgrading to this release.

**Attention:**

As of v4.5.0, both RTC SDK and RTM SDK (v2.2.0 and above) include the `aosl.xcframework` library. If you manually integrate RTC SDK via CDN and also use RTM SDK, delete the lower version of the `aosl.xcframework` library to avoid conflicts. The `aosl.xcframework` library version in RTC SDK v4.5.0 is 1.2.13. You can check the version in the `Info.plist` file.

1. **Changes in strong video denoising implementation**

   This version adjusts the implementation of strong video denoising. The `AgoraVideoDenoiserLevel` removes `AgoraVideoDenoiserLevelStrength`. Instead, after enabling video denoising by calling `setVideoDenoiserOptions:options:`, you can call the `setBeautyEffectOptions:options:` method to enable the beauty skin smoothing feature. Using both together will achieve better video denoising effects. For strong denoising, it is recommended to set the skin smoothing parameters as detailed in `setVideoDenoiserOptions:options:`.

   Additionally, due to this adjustment, to achieve the best low-light enhancement effect with a focus on image quality, you need to enable video denoising first and use specific settings as detailed in `setLowlightEnhanceOptions:options:`.

2. **Changes in video encoding preferences**

   To enhance the user's video interaction experience, this version optimizes the default preferences for video encoding:

   - In the `AgoraCompressionPreference` enumeration class, a new `AgoraCompressionAuto` (-1) enumeration is added, replacing the original `AgoraCompressionQuality` (1) as the default value. In this mode, the SDK will automatically choose between `AgoraCompressionLowLatency` or `AgoraCompressionQuality` based on your video scene settings to achieve the best user experience.
   - In the `AgoraDegradationPreference` enumeration class, a new `AgoraDegradationMaintainAuto` (-1) enumeration is added, replacing the original `AgoraDegradationMaintainQuality` (1) as the default value. In this mode, the SDK will automatically choose between `AgoraDegradationMaintainFramerate`, `AgoraDegradationBalanced`, or `AgoraDegradationMaintainResolution` based on your video scene settings to achieve the optimal overall quality experience (QoE).

#### New features

1. **Live show scenario**

   This version adds the `AgoraApplicationLiveShowScenario`(3) (Live Show) enumeration to the `AgoraApplicationScenarioType`. You can call `setVideoScenario:` to set the video business scenario to show room. To meet the high requirements for first frame rendering time and image quality in this scenario, the SDK has optimized strategies to significantly improve the first frame rendering experience and image quality, while enhancing the performance in weak network environments and on low-end devices.

2. **Maximum frame rate for video rendering**

   This version adds the `setLocalRenderTargetFps` and `setRemoteRenderTargetFps` methods, which support setting the maximum frame rate for video rendering locally and remotely. The actual frame rate for video rendering by the SDK will be as close to this value as possible.

   In scenarios where the frame rate requirement for video rendering is not high (e.g., screen sharing, online education) or when the remote end uses mid-to-low-end devices, you can use this set of methods to limit the video rendering frame rate, thereby reducing CPU consumption and improving system performance.

3. **Watching live streaming through URLs**

   As of this version, audience members can directly open a specific URL to play the real-time media stream through `openWithUrl:startTime:cb:`, instead of joining a channel and subscribing to the streams of hosts, which greatly simplifies the API calls for the audience end to watch a live stream.

4. **Filter effects**

   This version introduces the `setFilterEffectOptions:options:sourceType:` method. You can pass a cube map file (.cube) in the `config` parameter to achieve custom filter effects such as whitening, vivid, cool, black and white, etc. Additionally, the SDK provides a built-in `built_in_whiten_filter.cube` file for quickly achieving a whitening filter effect.

5. **Local audio mixing**

   This version introduces the local audio mixing feature. You can call the `startLocalAudioMixer` method to mix the audio streams from the local microphone, media player, sound card, and remote audio streams into a single audio stream, which can then be published to the channel. When you no longer need audio mixing, you can call the `stopLocalAudioMixer` method to stop local audio mixing. During the mixing process, you can call the `updateLocalAudioMixerConfiguration` method to update the configuration of the audio streams being mixed.

   Example use cases for this feature include:

   - By utilizing the local video mixing feature, the associated audio streams of the mixed video streams can be simultaneously captured and published.
   - In live streaming scenarios, users can receive audio streams within the channel, mix multiple audio streams locally, and then forward the mixed audio stream to other channels.
   - In educational scenarios, teachers can mix the audio from interactions with students locally and then forward the mixed audio stream to other channels.

6. **Color space settings**

   This version adds the `colorSpace` parameter to `AgoraOutputVideoFrame` and `AgoraVideoFrame`. You can use this parameter to set the color space properties of the video frame. By default, the color space uses Full Range and BT.709 standard configuration. You can flexibly adjust according to your own capture or rendering needs, further enhancing the customization capabilities of video processing.

#### Improvements

1. **Virtual background algorithm optimization**

   This version upgrades the virtual background algorithm, making the segmentation between the portrait and the background more accurate. There is no background exposure, the body contour of the portrait is complete, and the detail recognition of fingers is significantly improved. Additionally, the edges between the portrait and the background are more stable, reducing edge jumping and flickering in continuous video frames.

2. **Snapshot at specified video observation points**

   This version introduces the `takeSnapshotWithConfig:config:` and `takeSnapshotExWithConfig:uid:config:` methods. You can use the `config` parameter when calling these methods to take snapshots at specified video observation points, such as before encoding, after encoding, or before rendering, to achieve more flexible snapshot effects.

3. **Custom audio capture improvements**

   This version adds the `enableAudioProcessing` member parameter to `AgoraAudioTrackConfig`, which is used to control whether to enable 3A audio processing for custom audio capture tracks of the `AUDIO_TRACK_DIRECT` type. The default value of this parameter is `NO`, meaning that audio processing is not enabled. Users can enable it as needed, enhancing the flexibility of custom audio processing.

4. **Other Improvements**

   - In scenarios where Alpha transparency effects are achieved by stitching video frames and Alpha data, the rendering performance on the receiving end has been improved, effectively reducing stuttering and latency.
   - Optimizes the logic for calling `queryDeviceScore` to obtain device score levels, improving the accuracy of the score results.
   - After calling `enableLocalAudio:` to disable local audio capture within the channel, the mute side button on the phone can be used to mute the background sound effects played by the app.
   - When calling `switchSrc:syncPts:` to switch between live streams or on-demand streams of different resolutions, smooth and seamless switching can be achieved. An automatic retry mechanism has been added in case of switching failures. The SDK will automatically retry 3 times after a failure. If it still fails, the `AgoraRtcMediaPlayer:didOccurEvent:elapsedTime:message:` callback will report the `AgoraMediaPlayerEventSwitchError` event, indicating an error occurred during media resource switching.
   - When calling `setPlaybackSpeed:` to set the playback speed of an audio file, the minimum supported speed is 0.3x.

#### Bug fixes

This version fixes the following issues:

- When the video source type of the sender is in JPEG format, the frame rate on the receiving end occasionally falls below expectations.
- Occasional instances where the receiving end cannot hear the sender during audio and video interaction.
- During audio and video interaction, if the sender's device system version is iOS 17, the receiving end occasionally cannot hear the sender.
- In live streaming scenarios, the time taken to reconnect to the live room after the audience end disconnects due to network switching is longer than expected.
- No sound when playing online media resources using the media player after the app starts.
- Occasional instances of no sound in audio capture after resuming from being interrupted by other system apps during audio and video interaction.
- Calling `startAudioMixing:loopback:cycle:` and then immediately calling `pauseAudioMixing` to pause the music file playback does not take effect.

## v4.4.0

This version was released on July x, 2024.

#### Compatibility changes

This version includes optimizations to some features, including changes to SDK behavior, API renaming and deletion. To ensure normal operation of the project, update the code in the app after upgrading to this release.

**Attention:** Starting from v4.4.0, the RTC SDK provides an API sunset notice, which includes information about deprecated and removed APIs in each version. See [API Sunset Notice](https://doc.shengwang.cn/api-ref/rtc/ios/API/rtc_api_sunset).

1. To distinguish context information in different extension callbacks, this version removes the original extension callbacks and adds corresponding callbacks that contain context information (see the table below). You can identify the extension name, the user ID, and the service provider name through `AgoraExtensionContext` in each callback.

   | Original callback  | Current callback                |
   | ------------------ | ------------------------------- |
   | `onEvent`   | `onExtensionEventWithContext`   |
   | `onExtensionStarted` | `onExtensionStartedWithContext` |
   | `onExtensionStopped` | `onExtensionStoppedWithContext` |
   | `onExtensionError`   | `onExtensionErrorWithContext`   |

2. Prior to v4.4.0, if a user was set to the audience role and `setAudioScenario` was called with `AgoraAudioScenarioChatRoom`, the system showed the microphone-in-use indicator. As of v4.4.0, the SDK manages the microphone through native iOS APIs, so audience users in a chatroom scenario no longer see this indicator.

3. This version renames the `receiveMetadata` callback to `didMetadataReceived` and removes the `data` and `timeStamp` parameters. You can get metadata-related information, including `timeStamp` (timestamp of the sent data), `uid` (user ID), and `channelId` (channel name) through the newly-added `metadata` parameter.

#### New features

1. **Lite SDK**

   Starting from this version, Agora introduces the Lite SDK, which includes only the basic audio and video capabilities and partially cuts advanced features, effectively reducing the app size after integrating the SDK.

   - Lite SDK supports manual integration or third-party repository integration. For details, see [Download SDKs]() and [Integrate the SDK]().
   - For information on dynamic libraries included in the Lite SDK, see [App size optimization]().
   - For the list of APIs supported by the Lite SDK, see [Lite SDK API List](https://doc.shengwang.cn/api-ref/rtc/ios/API/rtc_lite_api).
   - For the limitations and precautions when using the Lite SDK to play media files, please refer to [Which audio file formats are supported by RTC SDK?](https://doc.shengwang.cn/faq/general-product-inquiry/audio-format)

2. **Alpha transparency effects**

   This version introduces the Alpha transparency effects feature, supporting the transmission and rendering of Alpha channel data in video frames for SDK capture and custom capture scenarios, enabling transparent gift effects, custom backgrounds on the receiver end, etc.:

   - `AgoraOutputVideoFrame` and `AgoraVideoFrame` add the `alphaBuffer` member: Sets the Alpha channel data.
   - `AgoraVideoFrame` adds the `fillAlphaBuffer` member: For BGRA or RGBA formatted video data, sets whether to automatically extract the Alpha channel data and fill it into `alphaBuffer`.
   - `AgoraOutputVideoFrame` and `AgoraVideoFrame` add the `alphaStitchMode` member: Sets the relative position of `alphaBuffer` and video frame stitching.

   Additionally, `AgoraAdvancedVideoOptions` adds a new member `encodeAlpha`, which is used to set whether to encode and send Alpha information to the remote end. By default, the SDK does not encode and send Alpha information; if you need to encode and send Alpha information to the remote end (for example, when virtual background is enabled), explicitly call `setVideoEncoderConfiguration` to set the video encoding properties and set `encodeAlpha` to `YES`.

3. **Voice AI tuner**

   This version introduces the voice AI tuner feature, which can enhance the sound quality and tone, similar to a physical sound card. You can enable the voice AI tuner feature by calling the `enableVoiceAITuner` method and passing in the sound effect types supported in the `AgoraVoiceAITunerType` enum to achieve effects like deep voice, cute voice, husky singing voice, etc.

4. **1v1 video call scenario**

   This version adds `AgoraApplication1V1Scenario` (1v1 video call) in `AgoraApplicationScenarioType`. You can call `setVideoScenario` to set the video application scenario to 1v1 video call, the SDK optimizes performance to achieve low latency and high video quality, enhancing image quality, first frame rendering, latency on mid-to-low-end devices, and smoothness under poor network conditions.

#### Improvements

1. **Facial region beautification**

   To avoid losing details in non-facial areas during heavy skin smoothing, this version improves the skin smoothing algorithm. The SDK now recognizes various parts of the face, applying smoothing to facial skin areas excluding the mouth, eyes, and eyebrows. In addition, the SDK supports smoothing up to two faces simultaneously.

2. **Other improvements**

   This version also includes the following improvements:

   - Optimizes transmission strategy: calling `enableInstantMediaRendering` no longer impacts the security of the transmission link.
   - Deprecates redundant enumeration values `AgoraClientRoleChangeFailedRequestTimeout` and `AgoraClientRoleChangeFailedConnectionFailed` in `AgoraClientRoleChangeFailedReason`.

#### Issues fixed

This release fixed the following issues:

- Occasional app crashes occurred when multiple remote users joined the channel simultaneously during real-time interaction.
- Remote video occasionally froze or displayed corrupted images when the app returned to the foreground after being in the background for a while.
- After the sender called `startDirectCdnStreaming` to start direct CDN streaming, frequent switching or toggling of the network occasionally resulted in a black screen on the receiver's end without a streaming failure callback on the sender's end.
- Audio playback failed when pushing external audio data using `pushExternalAudioFrameRawData` and the sample rate was not set as a recommended value, such as 22050 Hz and 11025 Hz.



## v4.3.2

This version was released on May x, 20xx.

#### Improvements

1. This release enhances the usability of the [setRemoteSubscribeFallbackOption](API/api_irtcengine_setremotesubscribefallbackoption.html) method by removing the timing requirements for invocation. It can now be called both before and after joining the channel to dynamically switch audio and video stream fallback options in weak network conditions.
2. The Agora media player supports playing mp4 files with an Alpha channel.

#### Issues fixed

This version fixed the following issues:

- The remote video froze or became pixelated when the app returned to the foreground after being in the background for a long time.
- The local preview image rotated by 90° on some iPad devices, which did not meet expectations.
- Occasional video smoothness issues during audio and video interactions.
- The app occasionally crashed when the decoded video resolution on the receiving end was an odd number.
- The app occasionally crashed when remote users left the channel.
- When playing an audio file using [startAudioMixing [1/2\]](API/api_irtcengine_startaudiomixing.html) and the playing finished, the SDK sometimes failed to trigger the [audioMixingStateChanged](API/callback_irtcengineeventhandler_onaudiomixingstatechanged.html)(AgoraAudioMixingStateTypeStopped, AgoraAudioMixingReasonAllLoopsCompleted) callback which reports that the playing is completed.
- When calling the [playEffect [3/3\]](API/api_irtcengine_playeffect3.html) method to play sound effect files shorter than 1 second with `loopCount` set to 0, there was no sound.
- When using the Agora media player to play a video and stopping it during playing, sometimes there was no sound for a short time after the playing was resumed.
-

## v4.3.1

This version is released on 2024 Month x, Day x.


#### New features

1. **Speech Driven Avatar**

   The SDK introduces a speech driven extension that converts speech information into corresponding facial expressions to animate avatar. You can access the facial information through the newly added [`setFaceInfoDelegate`](/api-ref/rtc/ios/API/toc_speech_driven#api_imediaengine_registerfaceinfoobserver) method and [`onFaceInfo`](/api-ref/rtc/ios/API/toc_speech_driven#callback_ifaceinfoobserver_onfaceinfo) callback. This facial information conforms to the ARKit standard for Blend Shapes (BS), which you can further process using third-party 3D rendering engines.

   The speech driven extension is a trimmable dynamic library, and details about the increase in app size are available at [reduce-app-size]().

   **Attention:**

   The speech driven avatar feature is currently in beta testing. To use it, please contact [technical support](mailto:support@agora.io).

2. **Privacy manifest file**

   To meet Apple's safety compliance requirements for app publication, the SDK now includes a privacy manifest file, `PrivacyInfo.xcprivacy`, detailing the SDK's API calls that access or use user data, along with a description of the types of data collected.

   **Note:** If you need to publish an app with SDK versions prior to v4.3.1 to the Apple App Store, you must manually add the `PrivacyInfo.xcprivacy` file to your Xcode project. For more details, see []().

3. **Portrait center stage**

   To enhance the presentation effect in online meetings, shows, and online education scenarios, this version introduces the [`enableCameraCenterStage`](/api-ref/rtc/ios/API/toc_center_stage#api_irtcengine_enablecameracenterstage) method to activate portrait center stage. This ensures that presenters, regardless of movement, always remain centered in the video frame, achieving better presentation effects.

   Before enabling portrait center stage it is recommended to verify whether your current device supports this feature by calling [`isCameraCenterStageSupported`](/api-ref/rtc/ios/API/toc_center_stage#api_irtcengine_iscameracenterstagesupported). A list of supported devices can be found in the API documentation at [`enableCameraCenterStage`](/api-ref/rtc/ios/API/toc_center_stage#api_irtcengine_enablecameracenterstage).

4. **Camera stabilization**

   To improve video stability in mobile filming, low-light environments, and hand-held shooting scenarios, this version introduces a camera stabilization feature. You can activate this feature and select an appropriate stabilization mode by calling [`setCameraStabilizationMode`](/api-ref/rtc/ios/API/toc_camera_capture#api_irtcengine_setcamerastabilizationmode), achieving more stable and clearer video footage.

5. **Wide and ultra-wide cameras**

   To allow users to capture a broader field of view and more complete scene content, this release introduces support for wide and ultra-wide cameras. You can first call [`queryCameraFocalLengthCapability`](/api-ref/rtc/ios/API/toc_video_device#api_irtcengine_querycamerafocallengthcapability) to check the device's focal length capabilities, and then call [`setCameraCapturerConfiguration`](/api-ref/rtc/ios/API/toc_video_device#api_irtcengine_setcameracapturerconfiguration) and set `cameraFocalLengthType` to the supported focal length types, including wide and ultra-wide.

6. **Data stream encryption**

   This version adds `datastreamEncryptionEnabled` to [`AgoraEncryptionConfig`](/api-ref/rtc/ios/API/class_encryptionconfig) for enabling data stream encryption. You can set this when you activate encryption with [`enableEncryption`](/api-ref/rtc/ios/API/toc_network#api_irtcengine_enableencryption). If there are issues causing failures in data stream encryption or decryption, these can be identified by the newly added `ENCRYPTION_ERROR_DATASTREAM_DECRYPTION_FAILURE` and `ENCRYPTION_ERROR_DATASTREAM_ENCRYPTION_FAILURE` enumerations.

7. **Local Video Rendering**

   This version adds the following members to [`AgoraRtcVideoCanvas`](/api-ref/rtc/ios/API/class_videocanvas) to support more local rendering capabilities:

   - enableAlphaMask: This member enables the receiving end to initiate alpha mask rendering. Alpha mask rendering can create images with transparent effects or extract human figures from video content.

8. **Adaptive configuration for low-quality video streams**

   This version introduces adaptive configuration for low-quality video streams. When you activate dual-stream mode and set up low-quality video streams on the sending side using [`setDualStreamMode`](/api-ref/rtc/ios/API/toc_dual_stream#api_irtcengine_setdualstreammode2)[2/2], the SDK defaults to the following behaviors:

   - The default encoding resolution for low-quality video streams is set to 50% of the original video encoding resolution.
   - The bitrate for the small streams is automatically matched based on the video resolution and frame rate, eliminating the need for manual specification.

9. **Other features**

   - New method [`enableEncryptionEx`](/api-ref/rtc/ios/API/toc_network#api_irtcengineex_enableencryptionex) is added for enabling media stream or data stream encryption in multi-channel scenarios.
   - New method [`setAudioMixingPlaybackSpeed`](/api-ref/rtc/ios/API/toc_audio_mixing#api_irtcengine_setaudiomixingplaybackspeed) is introduced for setting the playback speed of audio files.
   - New method [`getCallIdEx`](/api-ref/rtc/ios/API/toc_network#api_irtcengineex_getcallidex) is introduced for retrieving call IDs in multi-channel scenarios.

#### Improvements

1. **Virtual Background Algorithm Optimization**

   To enhance the accuracy and stability of human segmentation when activating virtual backgrounds against solid colors, this version optimizes the green screen segmentation algorithm:

   - Supports recognition of any solid color background, no longer limited to green screens.
   - Improves accuracy in recognizing background colors and reduces the background exposure during human segmentation.
   - After segmentation, the edges of the human figure (especially around the fingers) are more stable, significantly reducing flickering at the edges.

2. **Custom audio capture optimization**

   To enhance the flexibility of custom audio capture, this release deprecates [`pushExternalAudioFrameSampleBuffer`](/api-ref/rtc/ios/API/toc_audio_custom_capturenrendering#api_irtcengine_pushexternalaudioframesamplebuffer)[1/2] and introduces [`pushExternalAudioFrameSampleBuffer`](/api-ref/rtc/ios/API/toc_audio_custom_capturenrendering#api_irtcengine_pushexternalaudioframesamplebuffer2)[2/2]. Compared to the deprecated method, the new method adds parameters such as `sampleRate`, `channels`, and `trackId`. These support pushing external CMSampleBuffer audio data to the channel via custom audio tracks, and allow for the setting of sample rates and channel counts for external audio sources.

3. **CPU consumption reduction of in-ear monitoring**

   This release adds an enumerator `AgoraEarMonitoringFilterReusePostProcessingFilter` (1 << 15) in `AgoraEarMonitoringFilterType`. For complex audio processing scenarios, you can specify this option to reuse the audio filter post sender-side processing in in-ear monitoring, thereby reducing CPU consumption. Note that this option may increase the latency of in-ear monitoring, which is suitable for latency-tolerant scenarios requiring low CPU consumption.

4. **Other improvements**

   This version also includes the following improvements:

   - Optimization of video encoding and decoding strategies in non-screen sharing scenarios to save system performance overhead.
   - Improved stability in processing video by the raw video frame observer.
   - Enhanced media player capabilities to handle WebM format videos, including support for rendering alpha channels.
   - In [`AgoraAudioEffectPreset`](/api-ref/rtc/ios/API/enum_audioeffectpreset), a new enumeration `AgoraAudioEffectPresetRoomAcousticsChorus` (chorus effect) is added, enhancing the spatial presence of vocals in chorus scenarios.
   - In [`AgoraRtcRemoteAudioStats`](/api-ref/rtc/ios/API/class_remoteaudiostats), a new `e2eDelay` field is added to report the delay from when the audio is captured on the sending end to when the audio is played on the receiving end.

#### Issues fixed

This version fixed the following issues:

- Fixed an issue where SEI data output did not synchronize with video rendering when playing media streams containing SEI data using the media player.
- When the network conditions of the sender deteriorated (for example, in poor network environments), the receiver occasionally experienced a decrease in video smoothness and an increase in lag.

#### API Changes

**Added**

- [`enableCameraCenterStage`](/api-ref/rtc/ios/API/toc_center_stage#api_irtcengine_enablecameracenterstage)
- [`isCameraCenterStageSupported`](/api-ref/rtc/ios/API/toc_center_stage#api_irtcengine_iscameracenterstagesupported)
- [`setCameraStabilizationMode`](/api-ref/rtc/ios/API/toc_camera_capture#api_irtcengine_setcamerastabilizationmode)
- [`AgoraCameraStabilizationMode`](/api-ref/rtc/ios/API/enum_camerastabilizationmode)
- The `enableAlphaMask` member in [`AgoraRtcVideoCanvas`](/api-ref/rtc/ios/API/class_videocanvas)
- [`setFaceInfoDelegate`](/api-ref/rtc/ios/API/toc_speech_driven#api_imediaengine_registerfaceinfoobserver)
- [`AgoraFaceInfoDelegate`](/api-ref/rtc/ios/API/class_ifaceinfoobserver)
- [`onFaceInfo`](/api-ref/rtc/ios/API/toc_speech_driven#callback_ifaceinfoobserver_onfaceinfo)
- The `publishLipSyncTrack` member in [`AgoraRtcChannelMediaOptions`](/api-ref/rtc/ios/API/class_channelmediaoptions)
- [`AgoraMediaSourceType`](/api-ref/rtc/ios/API/enum_mediasourcetype) adds `AgoraMediaSourceTypeSpeechDriven`
- [`AgoraVideoSourceType`](/api-ref/rtc/ios/API/enum_videosourcetype) adds `AgoraVideoSourceTypeSpeechDriven`
- [`AgoraEncryptionConfig`](/api-ref/rtc/ios/API/class_encryptionconfig) adds `datastreamEncryptionEnabled`
- [``AgoraEncryptionErrorType``](/api-ref/rtc/ios/API/enum_encryptionerrortype)  adds the following enumerations:
  - `ENCRYPTION_ERROR_DATASTREAM_DECRYPTION_FAILURE`
  - `ENCRYPTION_ERROR_DATASTREAM_ENCRYPTION_FAILURE`
- [`AgoraRtcRemoteAudioStats`](/api-ref/rtc/ios/API/class_remoteaudiostats) adds `e2eDelay`
- [`AgoraErrorCode`](/api-ref/rtc/ios/API/enum_errorcodetype) adds `AgoraErrorCodeDatastreamDecryptionFailed`
- [`AgoraAudioEffectPreset`](/api-ref/rtc/ios/API/enum_audioeffectpreset) adds `AgoraAudioEffectPresetRoomAcousticsChorus`, enhancing the spatial presence of vocals in chorus scenarios.
- [`getCallIdEx`](/api-ref/rtc/ios/API/toc_network#api_irtcengineex_getcallidex)
- [`enableEncryptionEx`](/api-ref/rtc/ios/API/toc_network#api_irtcengineex_enableencryptionex)
- [`setAudioMixingPlaybackSpeed`](/api-ref/rtc/ios/API/toc_audio_mixing#api_irtcengine_setaudiomixingplaybackspeed)
- [`queryCameraFocalLengthCapability`](/api-ref/rtc/ios/API/toc_video_device#api_irtcengine_querycamerafocallengthcapability)
- [`AgoraFocalLengthInfo`](/api-ref/rtc/ios/API/class_focallengthinfo)
- [`AgoraFocalLength`](/api-ref/rtc/ios/API/enum_camerafocallengthtype)
- [`AgoraCameraCapturerConfiguration`](/api-ref/rtc/ios/API/class_cameracapturerconfiguration) adds a new member `cameraFocalLengthType`
- [`AgoraEarMonitoringFilterType`](/api-ref/rtc/ios/API/enum_earmonitoringfiltertype) adds a new enumeration `AgoraEarMonitoringFilterBuiltInAudioFilters`(1<<15)
- [`pushExternalAudioFrameSampleBuffer`](/api-ref/rtc/ios/API/toc_audio_custom_capturenrendering#api_irtcengine_pushexternalaudioframesamplebuffer2)[2/2]

**Deprecated**
- [`pushExternalAudioFrameSampleBuffer`](/api-ref/rtc/ios/API/toc_audio_custom_capturenrendering#api_irtcengine_pushexternalaudioframesamplebuffer)[1/2]


## v4.3.0

v4.3.0 was released on xx xx, 2024.


#### Compatibility changes

This release has optimized the implementation of some functions, involving renaming or deletion of some APIs. To ensure the normal operation of the project, you need to update the code in the app after upgrading to this release.

1. **Renaming parameters in callbacks**

   In order to make the parameters in some callbacks and the naming of enumerations in enumeration classes easier to understand, the following modifications have been made in this release. Please modify the parameter settings in the callbacks after upgrading to this release.

   | Callback                           | Original parameter name        | Existing parameter name |
   | ---------------------------------- | ------------------------------ | ----------------------- |
   | `localAudioStateChanged`           | `error`                        | `reason`                |
   | `localVideoStateChanged`           | `error`                        | `reason`                |
   | `onDirectCdnStreamingStateChanged` | `error`                        | `reason`                |
   | `didChangedToState`                | `error`                        | `reason`                |
   | `rtmpStreamingChangedToState`      | `errCode`                      | `reason`                |

   | Original enumeration class      | Current enumeration class       |
   | ------------------------------- | ------------------------------- |
   | `AgoraAudioLocalError`              | `AgoraAudioLocalReason`              |
   | `AgoraLocalVideoStreamError`        | `AgoraLocalVideoStreamReason`        |
   | `AgoraDirectCdnStreamingError`      | `AgoraDirectCdnStreamingReason`      |
   | `AgoraMediaPlayerError`             | `AgoraMediaPlayerReason`             |
   | `AgoraRtmpStreamingError`           | `AgoraRtmpStreamingReason`           |

   **Note:** For specific renaming of enumerations, please refer to <a href="#apichange">API changes</a>.

2. **Channel media relay**

   To improve interface usability, this release removes some methods and callbacks for channel media relay. Use the alternative options listed in the table below:

   | Deleted methods and callbacks | Alternative methods and callbacks  |
   | ----------------------------- | ---------------------------------- |
   | <li>`startChannelMediaRelay`</li><li>`updateChannelMediaRelay`</li>                          | `startOrUpdateChannelMediaRelay`   |
   | <li>`startChannelMediaRelayEx`</li><li>`updateChannelMediaRelayEx`</li>                          | `startOrUpdateChannelMediaRelayEx` |
   | `didReceiveChannelMediaRelayEvent`                            | `channelMediaRelayStateDidChange`  |

3. **Custom video source**

   Since this release, `pushExternalVideoFrame`[1/2] is migrated from `AgoraRtcEngineKit(Ex)` to `AgoraRtcEngineKit`.

4. **Audio route**

   Starting with this release, `AgoraAudioOutputRoutingBluetooth` in [AgoraAudioOutputRouting](API/enum_audioroute.html) is renamed to `AgoraAudioOutputRoutingBluetoothDeviceHfp`, representing a Bluetooth device using the HFP protocol. `AgoraAudioOutputRoutingBluetoothDeviceA2dp`(10) is added to represent the audio route to a Bluetooth device using the A2DP protocol.

5. **Reasons for local video state changes**

   This release makes the following modifications to the enumerations in the [AgoraLocalVideoStreamReason](API/enum_localvideostreamreason.html) class:

   - The `AgoraLocalVideoStreamErrorEncodeFailure` enumeration has been changed to `AgoraLocalVideoStreamReasonCodecNotSupport`.


6. **Log encryption behavior changes**

   For security and performance reasons, as of this release, the SDK encrypts logs and no longer supports printing plaintext logs via the console.

   Refer to the following solutions for different needs:
   - If you need to know the API call status, please check the API logs and print the SDK callback logs yourself.
   - For any other special requirements, please contact [technical support](mailto:support@agora.io) and provide the corresponding encrypted logs.

#### New features

1. **Custom mixed video layout on receiving end**

   To facilitate customized layout of mixed video stream at the receiver end, this release introduces the [didTranscodedStreamLayoutInfoUpdatedWithUserId](API/callback_irtcengineeventhandler_ontranscodedstreamlayoutinfo.html) callback. When the receiver receives the channel's mixed video stream sent by the video mixing server, this callback is triggered, reporting the layout information of the mixed video stream and the layout information of each sub-video stream in the mixed stream. The receiver can set a separate `view` for rendering the sub-video stream (distinguished by `subviewUid`) in the mixed video stream when calling the [setupRemoteVideo](API/api_irtcengine_setupremotevideo.html) method, achieving a custom video layout effect.

   When the layout of the sub-video streams in the mixed video stream changes, this callback will also be triggered to report the latest layout information in real time.

   Through this feature, the receiver end can flexibly adjust the local view layout. When applied in a multi-person video scenario, the receiving end only needs to receive and decode a mixed video stream, which can effectively reduce the CPU usage and network bandwidth when decoding multiple video streams on the receiving end.

2. **Local preview with multiple views**

   This release supports local preview with simultaneous display of multiple frames, where the videos shown in the frames are positioned at different observation positions along the video link. Examples of usage are as follows:

   1. Call [setupLocalVideo](API/api_irtcengine_setuplocalvideo.html) to set the first view: Set the `position` parameter to `AgoraVideoModulePositionPostCaptureOrigin` (introduced in this release) in `AgoraRtcVideoCanvas`. This corresponds to the position after local video capture and before preprocessing. The video observed here does not have preprocessing effects.
   2. Call [setupLocalVideo](API/api_irtcengine_setuplocalvideo.html) to set the second view: Set the `position` parameter to `AgoraVideoModulePositionPostCapture` in `AgoraRtcVideoCanvas`, the video observed here has the effect of video preprocessing.
   3. Observe the local preview effect: The first view is the original video of a real person; the second view is the virtual portrait after video preprocessing (including image enhancement, virtual background, and local preview of watermarks) effects.

3. **Query Device Score**

   This release adds the [queryDeviceScore](API/api_irtcengine_querydevicescore.html) method to query the device's score level to ensure that the user-set parameters do not exceed the device's capabilities. For example, in HD or UHD video scenarios, you can first call this method to query the device's score. If the returned score is low (for example, below 60), you need to lower the video resolution to avoid affecting the video experience. The minimum device score required for different business scenarios is varied. For specific score recommendations, please contact[technical support](mailto:support@agora.io).

4. **Select different audio tracks for local playback and streaming**

   This release introduces the [selectMultiAudioTrack](API/api_imediaplayer_selectmultiaudiotrack.html) method that allows you to select different audio tracks for local playback and streaming to remote users. For example, in scenarios like online karaoke, the host can choose to play the original sound locally and publish the accompaniment in the channel. Before using this function, you need to open the media file through the [openWithMediaSource](API/api_imediaplayer_openwithmediasource.html) method and enable this function by setting the `enableMultiAudioTrack` parameter in [AgoraMediaSource](API/class_mediasource.html).

5. **Device test for audio capturing and playback**

   This release introduces the following methods to test whether the audio capturing or playback devices work properly before joining a channel:

   - [startRecordingDeviceTest](API/api_iaudiodevicemanager_startrecordingdevicetest.html): Tests whether the local audio capturing device, such as the speaker, is working properly. After calling this method, the SDK triggers a callback at the time interval set in this method, which reports uid = 0 and the volume information of the capturing device. After the test is completed, you need to call the newly added [stopRecordingDeviceTest](API/api_iaudiodevicemanager_stoprecordingdevicetest.html) method to stop the test.
   - [startPlaybackDeviceTest](API/api_iaudiodevicemanager_startplaybackdevicetest.html): Tests whether the local audio playback device is working properly. You can specify the audio file to be played through the `testAudioFilePath` parameter and see if your audio device works properly. After the test is completed, you need to call the newly added [stopPlaybackDeviceTest](API/api_iaudiodevicemanager_stopplaybackdevicetest.html) method to stop the test.

6. **Others**

   This release has passed the test verification of the following APIs and can be applied to the entire series of RTC 4.x SDK.

   - [setRemoteSubscribeFallbackOption](API/api_irtcengine_setremotesubscribefallbackoption.html): Sets fallback option for the subscribed video stream in weak network conditions.
   - [didRemoteSubscribeFallbackToAudioOnly](API/callback_irtcengineeventhandler_onremotesubscribefallbacktoaudioonly.html): Occurs when the subscribed video stream falls back to audio-only stream due to weak network conditions or switches back to the video stream after the network conditions improve.
   - [setPlayerOption [1/2\]](API/api_imediaplayer_setplayeroption.html) and [setPlayerOption [2/2\]](API/api_imediaplayer_setplayeroption2.html): Sets media player options for providing technical previews or special customization features.
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
   - As of this release, it is no longer necessary to unsubscribe from the audio streams of all remote users within the channel before calling methods in [AgoraLocalSpatialAudioKit](API/class_ilocalspatialaudioengine.html).
   - This release introduces the [updateSelfTransform](API/api_ilocalspatialaudioengine_updateselftransform.html) method, designed to pass position vectors for direct rendering in iOS native frameworks such as SceneKit or RealityKit.

4. **Local audio state changed callback optimization**

   This release introduces the following enumerations in [AgoraAudioLocalReason](API/enum_localaudiostreamreason.html), enabling users to obtain more details about local audio errors through the [localAudioStateChanged](API/callback_irtcengineeventhandler_onlocalaudiostatechanged.html) callback:

   - `AgoraAudioLocalReasonInterrupted`: The local audio capture is interrupted by system calls, Siri, or alarm clocks. Remind your users to end the phone call, Siri, or alarm clock if the local audio capture is required.

5. **Optimization of video pre-processing methods**

   This release adds overloaded methods with the `souceType` parameter for the following 5 video preprocessing methods, which support specifying the media source type for applying video preprocessing effects by passing in `sourceType` (for example, applying on a custom video capture media source):

   - [setBeautyEffectOptions [2/2\]](API/api_irtcengine_setbeautyeffectoptions2.html)
   - [setLowlightEnhanceOptions [2/2\]](API/api_irtcengine_setlowlightenhanceoptions2.html)
   - [setVideoDenoiserOptions [2/2\]](API/api_irtcengine_setvideodenoiseroptions2.html)
   - [setColorEnhanceOptions [2/2\]](API/api_irtcengine_setcolorenhanceoptions2.html)
   - [enableVirtualBackground [2/2\]](API/api_irtcengine_enablevirtualbackground2.html)

6. **Other improvements**

   This release also includes the following improvements:

   - This release optimizes the SDK's domain name resolution strategy, improving the stability of calling to resolve domain names in complex network environments.
   - When passing in an image with transparent background as the virtual background image, the transparent background can be filled with customized color.
   - This release adds the `earMonitorDelay` and `aecEstimatedDelay` members in [AgoraRtcLocalAudioStats](API/class_localaudiostats.html) to report ear monitor delay and acoustic echo cancellation (AEC) delay, respectively.
   - The [cacheStats](API/callback_imediaplayersourceobserver_onplayercachestats.html) callback is added to report the statistics of the media file being cached. This callback is triggered once per second after file caching is started.
   - The [playbackStats](API/callback_imediaplayersourceobserver_onplayerplaybackstats.html) callback is added to report the statistics of the media file being played. This callback is triggered once per second after the media file starts playing. You can obtain information like the audio and video bitrate of the media file through [AgoraMediaPlayerPlaybackStats](API/class_playerplaybackstats.html).

#### Issues fixed

This release fixed the following issues:

- When sharing two screen sharing video streams simultaneously, the reported `captureFrameRate` in the [localVideoStats](API/callback_irtcengineeventhandler_onlocalvideostats.html) callback is 0, which is not as expected.

<a name="apichange"></a>
#### API changes

**Added**

- [didTranscodedStreamLayoutInfoUpdatedWithUserId](API/callback_irtcengineeventhandler_ontranscodedstreamlayoutinfo.html)
- [AgoraVideoLayoutInfo](API/class_videolayout.html)
- The `subviewUid` member in `[AgoraRtcVideoCanvas](API/class_videocanvas.html)`
- [updateSelfTransform](API/api_ilocalspatialaudioengine_updateselftransform.html)
- The following enumerations in [AgoraAudioLocalReason](API/enum_localaudiostreamreason.html):
  - `AgoraAudioLocalReasonInterrupted`
- [enableCustomAudioLocalPlayback](API/api_irtcengine_enablecustomaudiolocalplayback.html)
- [queryDeviceScore](API/api_irtcengine_querydevicescore.html)
- The `AgoraMediaSourceTypeCustomVideo` enumeration in [AgoraMediaSourceType](API/enum_mediasourcetype.html)
- [setBeautyEffectOptions [2/2\]](API/api_irtcengine_setbeautyeffectoptions2.html)
- [setLowlightEnhanceOptions [2/2\]](API/api_irtcengine_setlowlightenhanceoptions2.html)
- [setVideoDenoiserOptions [2/2\]](API/api_irtcengine_setvideodenoiseroptions2.html)
- [setColorEnhanceOptions [2/2\]](API/api_irtcengine_setcolorenhanceoptions2.html)
- [enableVirtualBackground [2/2\]](API/api_irtcengine_enablevirtualbackground2.html)
- The `AgoraAudioOutputRoutingBluetoothDeviceA2dp` enumeration in [AgoraAudioOutputRouting](API/enum_audioroute.html)
- Adds the `earMonitorDelay` and `aecEstimatedDelay` in [AgoraRtcLocalAudioStats](API/class_localaudiostats.html)
- [selectMultiAudioTrack](API/api_imediaplayer_selectmultiaudiotrack.html)
- [cacheStats](API/callback_imediaplayersourceobserver_onplayercachestats.html)
- [playbackStats](API/callback_imediaplayersourceobserver_onplayerplaybackstats.html)
- [AgoraMediaPlayerPlaybackStats](API/class_playerplaybackstats.html)
- [startPlaybackDeviceTest](API/api_iaudiodevicemanager_startplaybackdevicetest.html)
- [stopPlaybackDeviceTest](API/api_iaudiodevicemanager_stopplaybackdevicetest.html)

**Modified**

- `pushExternalVideoFrame`[1/2] is migrated from `AgoraRtcEngineKit(Ex)` to `AgoraRtcEngineKit`
- `AgoraAudioOutputRoutingBluetooth` is renamed as `AgoraAudioOutputRoutingBluetoothDeviceHfp`
- All `Error` fields in the following enumerations are changed to `Reason`:
  - `AgoraAudioLocalErrorOK`
  - `AgoraAudioLocalErrorFailure`
  - `AgoraAudioLocalErrorDeviceNoPermission`
  - `AgoraAudioLocalErrorDeviceBusy`
  - `AgoraAudioLocalErrorRecordFailure`
  - `AgoraAudioLocalErrorEncodeFailure`
  - `AgoraLocalVideoStreamErrorOK`
  - `AgoraLocalVideoStreamErrorFailure`
  - `AgoraLocalVideoStreamErrorDeviceNoPermission`
  - `AgoraLocalVideoStreamErrorDeviceBusy`
  - `AgoraLocalVideoStreamErrorCaptureFailure`
  - `AgoraLocalVideoStreamErrorCodecNotSupport`
  - `AgoraLocalVideoStreamErrorCaptureInBackGround`
  - `AgoraLocalVideoStreamErrorCaptureMultipleForegroundApps`
  - `AgoraLocalVideoStreamErrorCaptureNoDeviceFound`
  - `AgoraLocalVideoStreamErrorCaptureDeviceDisconnected`
  - `AgoraLocalVideoStreamErrorCaptureDeviceInvalidId`
  - `AgoraDirectCdnStreamingErrorOK`
  - `AgoraDirectCdnStreamingErrorFailed`
  - `AgoraDirectCdnStreamingErrorAudioPublication`
  - `AgoraDirectCdnStreamingErrorVideoPublication`
  - `AgoraDirectCdnStreamingErrorNetConnect`
  - `AgoraDirectCdnStreamingErrorBadName`
  - `AgoraMediaPlayerErrorNone`
  - `AgoraMediaPlayerErrorInvalidArguments`
  - `AgoraMediaPlayerErrorInternal`
  - `AgoraMediaPlayerErrorNoSource`
  - `AgoraMediaPlayerErrorInvalidMediaSource`
  - `AgoraMediaPlayerErrorUnknowStreamType`
  - `AgoraMediaPlayerErrorObjNotInitialized`
  - `AgoraMediaPlayerErrorCodecNotSupported`
  - `AgoraMediaPlayerErrorVideoRenderFailed`
  - `AgoraMediaPlayerErrorInvalidState`
  - `AgoraMediaPlayerErrorUrlNotFound`
  - `AgoraMediaPlayerErrorInvalidConnectState`
  - `AgoraMediaPlayerErrorSrcBufferUnderflow`
  - `AgoraMediaPlayerErrorInterrupted`
  - `AgoraMediaPlayerErrorNotSupported`
  - `AgoraMediaPlayerErrorTokenExpired`
  - `AgoraMediaPlayerErrorUnknown`
  - `AgoraRtmpStreamingErrorOK`
  - `AgoraRtmpStreamingErrorInvalidParameters`
  - `AgoraRtmpStreamingErrorEncryptedStreamNotAllowed`
  - `AgoraRtmpStreamingErrorConnectionTimeout`
  - `AgoraRtmpStreamingErrorInternalServerError`
  - `AgoraRtmpStreamingErrorRtmpServerError`
  - `AgoraRtmpStreamingErrorTooOften`
  - `AgoraRtmpStreamingErrorReachLimit`
  - `AgoraRtmpStreamingErrorNotAuthorized`
  - `AgoraRtmpStreamingErrorStreamNotFound`
  - `AgoraRtmpStreamingErrorFormatNotSupported`
  - `AgoraRtmpStreamingErrorNotBroadcaster`
  - `AgoraRtmpStreamingErrorTranscodingNoMixStream`
  - `AgoraRtmpStreamingErrorNetDown`
  - `AgoraRtmpStreamingErrorInvalidPrivilege`
  - `AgoraRtmpStreamingErrorUnpublishOK`

**Deleted**

- `startChannelMediaRelay`
- `updateChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelayEx`
- `didReceiveChannelMediaRelayEvent`
- `AgoraChannelMediaRelayEvent`

## v4.2.6

v4.2.6 was released on November xx, 2023.

#### Issues fixed


This version fixed the following issues:

- When using an iOS 16 or later device with Bluetooth headphones connected before joining the channel, the audio routing after joining the channel was not as expected: audio was played from the speaker, not the Bluetooth headphones.
- In specific scenarios (such as when the network packet loss rate was high or when the broadcaster left the channel without destroying the engine and then re-joined the channel), the video on the receiving end stuttered or froze.

## v4.2.3

v4.2.3 was released on September xx, 2023.

#### New features

1. **Update video screenshot and upload**

   To facilitate the integration of third-party video moderation services from Agora Extensions Marketplace, this version has the following changes:

   - The `AgoraContentInspectTypeImageModeration` enumeration is added in `AgoraContentInspectType` which means using video moderation extensions from Agora Extensions Marketplace to take video screenshots and upload them.
   - An optional parameter `serverConfig` is added in `AgoraContentInspectConfig`, which is for server-side configuration related to video screenshot and upload via extensions from Agora Extensions Marketplace. By configuring this parameter, you can integrate multiple third-party moderation extensions and achieve flexible control over extension switches and other features. For more details, please contact [technical support](mailto:support@agora.io).

   In addition, this version also introduces the `enableContentInspectEx` method, which supports taking screenshots for multiple video streams and uploading them.

2. **Check device support for advanced features**

   This version adds the `isFeatureAvailableOnDevice` method to check whether the capability of the current device meets the requirements of the specified advanced feature, such as virtual background and image enhancement.

   Before using advanced features, you can check whether the current device supports these features based on the call result. This helps to avoid performance degradation or unavailable features when enabling advanced features on low-end devices. Based on the return value of this method, you can decide whether to display or enable the corresponding feature button, or notify the user when the device's capabilities are insufficient.

   In addition, since this version, calling `enableVirtualBackground` and `setBeautyEffectOptions` automatically triggers a test on the capability of the current device. When the device is considered underperformed, the error code `-4` is returned, indicating the device does not support the feature.

#### Improvements

1. **Optimize virtual background memory usage**

   This version has upgraded the virtual background algorithm, reducing the memory usage of the virtual background feature. Compared to the previous version, the memory consumption of the app during the use of the virtual background feature on low-end devices has been reduced by approximately 4% to 10% (specific values may vary depending on the device model and platform).

**Other improvements**

This release includes the following additional improvements:

- Optimizes the logic of handling invalid parameters. When you call the `setPlaybackSpeed` method to set the playback speed of audio files, if you pass an invalid parameter, the SDK returns the error code -2, which means that you need to reset the parameter.
- Optimizes the logic of Token parsing, in order to prevent an app from crash when an invalid token is passed in.

#### Issues fixed

This release fixed the following issues:

- Occasional failure of joining a channel when the local system time was not set correctly.
- When calling the `playEffect [3/3]` method to play two audio files using the same `soundId`, the first audio file was sometimes played repeatedly.
- Calling `takeSnapshotEx` once receives the `snapshotTaken` callback for multiple times.

#### API changes

**Added**

- `enableContentInspectEx`
- `AgoraContentInspectTypeImageModeration` in `AgoraContentInspectType`.
- `serverConfig` in `AgoraContentInspectConfig`
- `isFeatureAvailableOnDevice`
- `AgoraFeatureType`
## v4.2.2

v4.2.2 was released on July xx, 2023.

#### New features

1. **Wildcard token**

   This release introduces wildcard tokens. Agora supports setting the channel name used for generating a token as a wildcard character. The token generated can be used to join any channel if you use the same user id. In scenarios involving multiple channels, such as switching between different channels, using a wildcard token can avoid repeated application of tokens every time users joining a new channel, which reduces the pressure on your token server. See [Wildcard Tokens](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).

   <div class="alert info">All 4.x SDKs support using wildcard tokens.</div>

2. **Preloading channels**

   This release adds `preloadChannelByToken [1/2]` and `preloadChannelByToken [2/2]` methods, which allows a user whose role is set as audience to preload channels before joining one. Calling the method can help shortening the time of joining a channel, thus reducing the time it takes for audience members to hear and see the host.

   When preloading more than one channels, Agora recommends that you use a wildcard token for preloading to avoid repeated application of tokens every time you joining a new channel, thus saving the time for switching between channels. See [Wildcard Token](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).

3. **Customized background color of video canvas**

   In this release, the `backgroundColor` member has been added to `AgoraRtcVideoCanvas`, which allows you to customize the background color of the video canvas when setting the properties of local or remote video display.

4. **Video source types for local preview**

   To allow users in selecting different types of video sources for local video preview, this release introduces `startPreview [2/2]` and `stopPreview [2/2]`. You can call `startPreview [2/2]` and specify the type of video source to be previewed by setting the `sourceType` parameter, and call `stopPreview [2/2]` to stop the video preview.

   <div class="alert info"> The video source type specified in this method must match the video source type set in the `AgoraRtcVideoCanvas` of the `setupLocalVideo` method.</div>

#### Improvements

1. **Improved camera capture effect**

   This release has improved camera capture effect in the following aspects:

   1. Support for camera exposure adjustment

      This release adds `isCameraExposureSupported` to query whether the device supports exposure adjustment and `setCameraExposureFactor` to set the exposure ratio of the camera.

   2. Optimization of default camera selection

      Since this release, the default camera selection behavior of the SDK is aligned with that of the iOS system camera. If the device has multiple rear cameras, better shooting perspectives, zooming capabilities, low-light performance, and depth sensing can be achieved during video capture, thereby improving the quality of video capture.

2. **Virtual Background Algorithm Upgrade**

   This version has upgraded the portrait segmentation algorithm of the virtual background, which comprehensively improves the accuracy of portrait segmentation, the smoothness of the portrait edge with the virtual background, and the fit of the edge when the person moves. In addition, it optimizes the precision of the person's edge in scenarios such as meetings, offices, homes, and under backlight or weak light conditions.

3. **Channel media relay**

   The number of target channels for media relay has been increased to 6. When calling `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx`, you can specify up to 6 target channels.

4. **Enhancement in video codec query capability**

   To improve the video codec query capability, this release adds the `codecLevels` member in `CodecCapAgoraVideoCodecCapInfoInfo`. After successfully calling `queryCodecCapability`, you can obtain the hardware and software decoding capability levels of the device for H.264 and H.265 video formats through `codecLevels`.

This release includes the following additional improvements:

1. The SDK automatically adjusts the frame rate of the sending end based on the screen sharing scenario. Especially in document sharing scenarios, this feature avoids exceeding the expected video bitrate on the sending end to improve transmission efficiency and reduce network burden.
2. To help users understand the reasons for more types of remote video state changes, the `AgoraVideoRemoteReasonCodecNotSupport` enumeration has been added to the `remoteVideoStateChangedOfUid` callback, indicating that the local video decoder does not support decoding the received remote video stream.

#### Issues fixed

This release fixed the following issues:

- Slow channel reconnection after the connection was interrupted due to network reasons.
- In screen sharing scenarios, the delay of seeing the shared screen was occasionally higher than expected on some devices.
- In custom video capturing scenarios, `setBeautyEffectOptions`, `setLowlightEnhanceOptions`, `setVideoDenoiserOptions`, and `setColorEnhanceOptions` could not load extensions automatically.

#### API changes

**Added**

- `startPreview [2/2]`
- `stopPreview [2/2]`
- `setCameraExposureFactor`
- `isCameraExposureSupported`
- `preloadChannelByToken [1/2]`
- `preloadChannelByToken [2/2]`
- `updatePreloadChannelToken`
- The following members in `AgoraRtcChannelMediaOptions`:
  - `publishThirdCameraTrack`
  - `publishFourthCameraTrack`
  - `publishThirdScreenTrack`
  - `publishFourthScreenTrack`
- `AgoraVideoCodecCapLevels`
- `AgoraVideoCodecCapabilityLevel`
- `backgroundColor` in `AgoraRtcVideoCanvas`
- `codecLevels` in `CodecCapAgoraVideoCodecCapInfoInfo`
- `AgoraVideoRemoteReasonCodecNotSupport` in `AgoraVideoRemoteReason`

## v4.2.1

This version was released on June 21, 2023.

#### Improvements

This version improves the network transmission strategy, enhancing the smoothness of audio and video interactions.

#### Fixed Issues

This version fixed the following issues:

- Inability to join channels caused by SDK's incompatibility with some older versions of AccessToken.
- After the sending end called `setAINSMode` to activate AI noise reduction, occasional echo was observed by the receiving end.
- Brief noise occurred while playing media files using the media player.
- Occasional crash after calling the `destroyMediaPlayer` method.


## v4.2.0

v4.2.0 was released on May 23, 2023.

#### Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

**1. Video capture**

This release optimizes the APIs for camera and screen capture function. As of v4.2.0, ensure you use the alternative methods listed in the table below and specify the video source by setting the `sourceType` parameter.

| Deleted Methods                                          | Alternative Methods       |
| :------------------------------------------------------- | :----------------------- |
| `startSecondaryCameraCapture` | `startCameraCapture`     |
| `stopSecondaryCameraCapture`   | `stopCameraCapture`      |

**2. Video data acquisition**

- The `onCaptureVideoFrame` and `onPreEncodeVideoFrame` callbacks are added with a new parameter called `sourceType`, which is used to indicate the specific video source type.
- The following callbacks are deleted. Get the video source type through the `sourceType` parameter in the `onPreEncodeVideoFrame` and `onCaptureVideoFrame` callbacks.
  - `onScreenCaptureVideoFrame`
  - `onPreEncodeScreenVideoFrame`

**3. Channel media options**

- `publishCustomAudioTrackEnableAec` in `AgoraRtcChannelMediaOptions` is deleted. Use `publishCustomAudioTrack` instead.
- `publishTrancodedVideoTrack` in `AgoraRtcChannelMediaOptions` is renamed to `publishTranscodedVideoTrack`.
- `publishCustomAudioSourceId` in `AgoraRtcChannelMediaOptions` is renamed to `publishCustomAudioTrackId`.

**4. Miscellaneous**

- `didApiCallExecute` is deleted. Agora recommends getting the results of the API implementation through relevant channels and media callbacks.
- `enableDualStreamMode`[1/2] and `enableDualStreamMode`[2/2] are depredated. Use `setDualStreamMode`[1/2] and `setDualStreamMode`[2/2] instead.
- `startChannelMediaRelay`, `updateChannelMediaRelay`, `startChannelMediaRelayEx` and `updateChannelMediaRelayEx` are deprecated. Use `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx` instead.

#### New features

**1. AI noise suppression**

This release introduces the AI noise suppression function. Once enabled, the SDK automatically detects and reduces background noises. Whether in bustling public venues or real-time competitive arenas that demand lightning-fast responsiveness, this function guarantees optimal audio clarity, providing users with an elevated audio experience. You can enable this function through the newly-introduced `setAINSMode` method and set the noise suppression mode as balance, aggressive or low latency according to your scenarios.

**2. Enhanced virtual background**

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

Additionally, the SDK provides the `updateLocalTranscoderConfiguration` method and the `didLocalVideoTranscoderErrorWithStream` callback. After enabling local video mixing, you can use the `updateLocalTranscoderConfiguration` method to update the video mixing configuration. Where an error occurs in starting the local video mixing or updating the configuration, you can get the reason for the failure through the `didLocalVideoTranscoderErrorWithStream` callback.

<div class="alert note">Local video mixing requires more CPU resources. Therefore, Agora recommends enabling this function on devices with higher performance.</div>

**5. Cross-device synchronization**

In real-time collaborative singing scenarios, network issues can cause inconsistencies in the downlinks of different client devices. To address this, this release introduces `getNtpWallTimeInMs` for obtaining the current Network Time Protocol (NTP) time. By using this method to synchronize lyrics and music across multiple client devices, users can achieve synchronized singing and lyrics progression, resulting in a better collaborative experience.
#### Improvements

**1. Voice changer**

This release introduces the `setLocalVoiceFormant` method that allows you to adjust the formant ratio to change the timbre of the voice. This method can be used together with the `setLocalVoicePitch` method to adjust the pitch and timbre of voice at the same time, enabling a wider range of voice transformation effects.

**2. Enhanced screen share**

This release adds the `queryScreenCaptureCapability` method, which is used to query the screen capture capabilities of the current device. To ensure optimal screen sharing performance, particularly in enabling high frame rates like 60 fps, Agora recommends you to query the device's maximum supported frame rate using this method beforehand.

This release also adds the `setScreenCaptureScenario` method, which is used to set the scenario type for screen sharing. The SDK automatically adjusts the smoothness and clarity of the shared screen based on the scenario type you set.

**3. Audio and video synchronization**

For custom video and audio capture scenarios, this release introduces `getCurrentMonotonicTimeInMs` for obtaining the current Monotonic Time. By passing this value into the timestamps of audio and video frames, developers can accurately control the timing of their audio and video streams, ensuring proper synchronization.

**4. Multi-camera capture**

This release introduces `startCameraCapture`. By calling this method multiple times and specifying the `sourceType` parameter, developers can start capturing video streams from multiple cameras for local video mixing or multi-channel publishing. This is particularly useful for scenarios such as remote medical care and online education, where multiple cameras need to be connected.

**5. Channel media relay**

This release introduces `startOrUpdateChannelMediaRelay` and `startOrUpdateChannelMediaRelayEx`, allowing for a simpler and smoother way to start and update media relay across channels. With these methods, developers can easily start the media relay across channels and update the target channels for media relay with a single method. Additionally, the internal interaction frequency has been optimized, effectively reducing latency in function calls.

**6. Custom audio tracks**

To better meet the needs of custom audio capture scenarios, this release adds `createCustomAudioTrack` and `destroyCustomAudioTrack` for creating and destroying custom audio tracks. Two types of audio tracks are also provided for users to choose from, further improving the flexibility of capturing external audio source:

- Mixable audio track: Supports mixing multiple external audio sources and publishing them to the same channel, suitable for multi-channel audio capture scenarios.
- Direct audio track: Only supports publishing one external audio source to a single channel, suitable for low-latency audio capture scenarios.
#### Issues fixed

This release fixed the following issues:

- When the host frequently switching the user role between broadcaster and audience in a short period of time, the audience members cannot hear the audio of the host.
- Occasional loss of the `firstRemoteVideoFrameOfUid` callback during channel media relay.
- The receiver actively subscribed to the high-quality stream but unexpectedly received a low-quality stream.
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
- `didLocalVideoTranscoderErrorWithStream`
- `startLocalVideoTranscoder`
- `updateLocalTranscoderConfiguration`
- `queryScreenCaptureCapability`
- `setScreenCaptureScenario`
- `setAINSMode`
- `createCustomAudioTrack`
- `destroyCustomAudioTrack`
- `AudioTrackConfig`
- `AgoraAudioTrackType`
- `AgoraApplicationScenarioType`
- `AgoraScreenCaptureFrameRateCapability`
- The `domainLimit` and `autoRegisterAgoraExtensions` members in `AgoraRtcEngineConfig`
- The `channelId` and `uid` parameters in `stateDidChanged` and `informationDidUpdated` callbacks
- The `sourceType` parameter in `onCaptureVideoFrame` and `onPreEncodeVideoFrame` callbacks
- The `AgoraVirtualBackgroundNone` and `AgoraVirtualBackgroundVideo` enumerators in `AgoraVirtualBackgroundSourceType`

**Deprecated**

- `enableDualStreamMode`[1/2]
- `enableDualStreamMode`[2/2]
- `startChannelMediaRelay`
- `startChannelMediaRelayEx`
- `updateChannelMediaRelay`
- `updateChannelMediaRelayEx`
- `didReceiveChannelMediaRelayEvent`
- `AgoraChannelMediaRelayEvent`

**Deleted**

- `startSecondaryCameraCapture`
- `stopSecondaryCameraCapture`
- `didApiCallExecute`
- `publishCustomAudioTrackEnableAec` in `AgoraRtcChannelMediaOptions` in `AgoraRtcChannelMediaOptions`
- `onScreenCaptureVideoFrame`
- `onPreEncodeScreenVideoFrame`

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

**1. Video frame observer**

As of this release, the SDK optimizes the `onRenderVideoFrame` callback, and the meaning of the return value is different depending on the video processing mode:

- When the video processing mode is `AgoraVideoFrameProcessModeReadOnly`, the return value is reserved for future use.
- When the video processing mode is `AgoraVideoFrameProcessModeReadWrite`, the SDK receives the video frame when the return value is `YES`; the video frame is discarded when the return value is `NO`.

**2. Super resolution**

This release improves the performance of super resolution. To optimize the usability of super resolution, this release removes `enableRemoteSuperResolution`. Super resolution is now included in the online strategies of video quality enhancement which does not require extra configuration.



#### Issues fixed

This release fixed the following issues:

- Playing audio files with a sample rate of 48 kHz failed.
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

#### **1. Multiple cameras for video capture**

This release supports multi-camera video capture. You can call `enableMultiCamera` to enable multi-camera capture mode, call `startSecondaryCameraCapture` to start capturing video from the second camera, and then publish the captured video to the second channel.

To stop using multi-camera capture, you need to call `stopSecondaryCameraCapture` to stop the second camera capture, then call `enableMultiCamera` and set `enabled` to `NO`.

**2. Headphone equalization effect**

This release adds the `setHeadphoneEQParameters` method, which is used to adjust the low- and high-frequency parameters of the headphone EQ. This is mainly useful in spatial audio scenarios. If you cannot achieve the expected headphone EQ effect after calling `setHeadphoneEQPreset`, you can call setHeadphoneEQParameters to adjust the EQ.

**3. Encoded video frame observer**

This release adds the `setRemoteVideo` method in the `AgoraRtcEngineKit` and `AgoraRtcEngineKitEx` classes. When you call the `setEncodedVideoFrameDelegate` method to register a video frame observer for the encoded video frames, the SDK subscribes to the encoded video frames by default. If you want to change the subscription options, you can call these new methods to set them.

For more information about registering video observers and subscription options, see the API reference.

**4. MPUDP (MultiPath UDP) (Beta)**

As of this release, the SDK supports MPUDP protocol, which enables you to connect and use multiple paths to maximize the use of channel resources based on the UDP protocol. You can use different physical NICs on both mobile and desktop and aggregate them to effectively combat network jitter and improve transmission quality.

> To enable this feature, contact [sales-us@agora.io](https://docs.agora.io/cn/video-call-4.x/sales-us@agora.io).

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

In general scenarios, the default video encoding configuration meets most requirements. For certain specific scenarios, this release adds the `advancedVideoOptions` member in `VideoEncoderConfiguration` for advanced settings of video encoding properties:

- `compressionPreference`: The compression preferences for video encoding, which is used to select low-latency or high-quality video preferences.
- `encodingPreference`: The video encoder preference, which is used to select adaptive preference, software encoder preference, or hardware encoder video preferences.

**8. Client role switching**

In order to enable users to know whether the switched user role is low-latency or ultra-low-latency, this release adds the `newRoleOptions` parameter to the `didClientRoleChanged` callback. The value of this parameter is as follows:

- `AgoraAudienceLatencyLevelLowLatency` (1): Low latency.
- `AgoraAudienceLatencyLevelUltraLowLatency` (2): Ultra-low latency.

#### Improvements

**1. Relaying media streams across channels**

This release optimizes the `updateChannelMediaRelay` method as follows:

- Before v4.1.0: If the target channel update fails due to internal reasons in the server, the SDK returns the error code `AgoraChannelMediaRelayEventUpdateDestinationChannelRefused`(8), and you need to call the `updateChannelMediaRelay` method again.
- v4.1.0 and later: If the target channel update fails due to internal server reasons, the SDK retries the update until the target channel update is successful.

**2. Reconstructed AIAEC algorithm**

This release reconstructs the AEC algorithm based on the AI method. Compared with the traditional AEC algorithm, the new algorithm can preserve the complete, clear, and smooth near-end vocals under poor echo-to-signal conditions, significantly improving the system's echo cancellation and dual-talk performance. This gives users a more comfortable call and live-broadcast experience. AIAEC is suitable for conference calls, chats, karaoke, and other scenarios.

**3. Virtual background**

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
- Enhances the ability to identify different network protocol stacks and improves the SDK's access capabilities in multiple-operator network scenarios.

#### **Issues fixed**

This release fixed the following issues:

- Calling `startAudioMixing` to play music files in the `ipod-library://item` path failed.
- Audience members heard buzzing noises when the host switched between speakers and earphones during live streaming.
- Different timestamps for audio and video data were obtained simultaneously and separately via `onRecordAudioFrame` and `onCaptureVideoFrame` callbacks.
- The call `getExtensionProperty` failed and returned an empty string.
- When entering a live streaming room that has been played for a long time as an audience, the time for the first frame to be rendered was shortened.

#### **API changes**

**Added**

- `enableMultiCamera`
- `startSecondaryCameraCapture`
- `stopSecondaryCameraCapture`
- `setHeadphoneEQParameters`
- `setRemoteVideo`
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
- Removes `AgoraChannelMediaRelayEventUpdateDestinationChannelRefused`(8) in `didReceiveChannelMediaRelayEvent`.


## v4.0.0

v4.0.0 was released on September 15, 2022.

#### New features


**2. Full HD and Ultra HD resolution**

In order to improve the interactive video experience, the SDK optimizes the whole process of video capturing, encoding, decoding and rendering. Starting from this version, it supports Full HD (FHD) and Ultra HD (UHD) video resolutions. You can set the `dimensions` parameter to 1920 × 1080 or higher resolution when calling the `setVideoEncoderConfiguration` method. If your device does not support high resolutions, the SDK will automatically fall back to an appropriate resolution.

<div class="alert info"><li>The UHD resolution (4K, 60 fps) is currently in beta and requires certain device performance and network bandwidth. If you want to experience this feature, contact <a href="mailto:support@agora.io">technical support</a>.
<li>High resolution typically means higher performance consumption. To avoid a decrease in experience due to insufficient device performance, Agora recommends that you enable FHD and UHD video resolutions on devices with better performance.
<li>The increase in the default resolution affects the aggregate resolution and thus the billing rate. See <a href="./billing_rtc_ng">Pricing</a>.</div>
