## Known issues and limitations

**AirPods Pro Bluetooth connection issue (iOS)**

AirPods Pro does not support A2DP protocol in communication audio mode, which may lead to connection failure in that mode.

## v4.5.1

v4.5.1 was released on March xx, 2025.

#### New features

1. **AI conversation scenario**

   This version adds the `AUDIO_SCENARIO_AI_CLIENT` audio scenario specifically designed for interacting with the conversational AI agent created by [Conversational AI Engine](https://docs.agora.io/en/conversational-ai/overview/product-overview). This scenario optimizes the audio transmission algorithm based on the characteristics of AI agent voice generation, ensuring stable voice data transmission in weak network environments (for example, 80% packet loss rate), and ensuring the continuity and reliability of the conversation, adapting to a variety of complex network conditions.

#### Improvements

1. Reduced the time of initializing the SDK on specific device models. (iOS)

#### Issues fixed

This release fixed the following issues:

- Apps that integrated the Agora SDK and set the `targetSdkVersion` to 34 encountered crashes when attempting to enable screen sharing for the first time on an Android 14 system. (Android)
- When joining two or more channels simultaneously, and calling the `TakeSnapshotEx [1/2]` method to take screenshots of the local video streams in each channel consecutively, the screenshot of the first channel failed.
- When using the `Pause` method to pause playback, then calling `Seek` to move to a specified position, and finally calling `Play` to continue playback, the Media Player resumed from the position where it was paused, not the new specified position.
- When using the Media Player, the file path of the media resource returned by the `GetPlaySrc` did not change after calling the `SwitchSrc` method to switch to a new media resource.
- When using Bluetooth headphones on specific device models for audio and video interactions, adjusting the phone volume would occassionally change the media volume instead of the Bluetooth volume. (Android)
- During audio and video interactions, the local user occasionally experienced a black screen when watching the video streams of remote users. (Android)
- On specific models of device, after calling `SetCameraExposureFactor` to set the exposure coefficient of the current camera at a specific angle of the device, the video screen occasionally became dark when the device was moved to another angle. (Android)
- When playing a CDN live stream, the video occasionally froze for an extended period after recovering from an interruption. (Android)
- When pushing video frames in i420 format to the channel, using CVPixelBuffer to handle these frames caused a crash. (iOS)
- Calling `SetupLocalVideo` to set up two views, then calling `EnableFaceDetection` to start face detection, no face information can be detected in the subsequently passed views. (iOS)
- In a screen sharing scenario, the receiving-end user saw a green line on the shared image. (iOS)
- In the interactive live streaming scenario, after joining a channel to watch live streams using `string` user id, the audience members occasionally saw that the audio was not synchronized with the video.
- Plugins sometimes did not work when using AI noise suppression and AI echo cancellation plugins at the same time.

## v4.5.0

This version was released on November x, 2024.

#### Compatibility changes

This version includes optimizations to some features, including changes to SDK behavior, API renaming and deletion. To ensure normal operation of the project, update the code in the app after upgrading to this release.

1. **Member Parameter Type Changes**

   This version has made the following modifications to some API members or parameters:

   | API                            | Members/Parameters                                         | Change                       |
   | ------------------------------ | ---------------------------------------------------------- | ---------------------------- |
   | `StartScreenCaptureByWindowId` | **windowId**                                               | Changed from view_t to long  |
   | `ScreenCaptureConfiguration`   | <ul><li>**displayId**</li><li>**windowId**<li></ul>        | Changed from unit to  long   |
   | `ScreenCaptureSourceInfo`      | <ul><li>**sourceDisplayId**</li><li>**sourceId**</li></ul> | Changed from view_t to  long |

2. **Changes in strong video denoising implementation**

   This version adjusts the implementation of strong video denoising.

   The `VIDEO_DENOISER_LEVEL` removes `VIDEO_DENOISER_LEVEL_STRENGTH`.

   Instead, after enabling video denoising by calling `SetVideoDenoiserOptions`, you can call the `SetBeautyEffectOptions` method to enable the beauty skin smoothing feature. Using both together will achieve better video denoising effects. For strong denoising, it is recommended to set the skin smoothing parameters as detailed in `SetVideoDenoiserOptions`.

   Additionally, due to this adjustment, to achieve the best low-light enhancement effect with a focus on image quality, you need to enable video denoising first and use specific settings as detailed in `SetLowlightEnhanceOptions`.

3. **Changes in camera plug and unplug status (macOS, Windows)**

   In previous versions, when the camera was unplugged and replugged, the `OnVideoDeviceStateChanged` callback would report the device status as `MEDIA_DEVICE_STATE_ACTIVE`(1) (device in use). Starting from this version, after the camera is replugged, the device status will change to `MEDIA_DEVICE_STATE_IDLE`(0) (device ready).

4. **Changes in video encoding preferences**

   To enhance the user’s video interaction experience, this version optimizes the default preferences for video encoding:

   - In the `COMPRESSION_PREFERENCE` enumeration class, a new `PREFER_COMPRESSION_AUTO` (-1) enumeration is added, replacing the original `PREFER_QUALITY` (1) as the default value. In this mode, the SDK will automatically choose between `PREFER_LOW_LATENCY` or `PREFER_QUALITY` based on your video scene settings to achieve the best user experience.
   - In the `DEGRADATION_PREFERENCE` enumeration class, a new `MAINTAIN_AUTO` (-1) enumeration is added, replacing the original `MAINTAIN_QUALITY` (1) as the default value. In this mode, the SDK will automatically choose between `MAINTAIN_FRAMERATE`, `MAINTAIN_BALANCED`, or `MAINTAIN_RESOLUTION` based on your video scene settings to achieve the optimal overall quality experience (QoE).

5. **16 KB memory page size**

   Starting from Android 15, the system adds support for 16 KB memory page size, as detailed in [Support 16 KB page sizes](https://developer.android.com/guide/practices/page-sizes). To ensure the stability and performance of the app, starting from this version, the SDK supports 16 KB memory page size, ensuring seamless operation on devices with both 4 KB and 16 KB memory page sizes, enhancing compatibility and preventing crashes.

#### New features

1. **Live show scenario**

   This version adds the `APPLICATION_SCENARIO_LIVESHOW`(3) (Live Show) enumeration to the `VIDEO_APPLICATION_SCENARIO_TYPE`. You can call `SetVideoScenario` to set the video business scenario to show room. To meet the high requirements for first frame rendering time and image quality in this scenario, the SDK has optimized strategies to significantly improve the first frame rendering experience and image quality, while enhancing the image quality in weak network environments and on low-end devices.

2. **Maximum frame rate for video rendering**

   This version adds the `SetLocalRenderTargetFps` and `SetRemoteRenderTargetFps` methods, which support setting the maximum frame rate for video rendering locally and remotely. The actual frame rate for video rendering by the SDK will be as close to this value as possible.

   In scenarios where the frame rate requirement for video rendering is not high (e.g., screen sharing, online education) or when the remote end uses mid-to-low-end devices, you can use this set of methods to limit the video rendering frame rate, thereby reducing CPU consumption and improving system performance.

3. **Filter effects**

   This version introduces the `SetFilterEffectOptions` method. You can pass a cube map file (.cube) in the `config` parameter to achieve custom filter effects such as whitening, vivid, cool, black and white, etc. Additionally, the SDK provides a built-in `built_in_whiten_filter.cube` file for quickly achieving a whitening filter effect.

4. **Local audio mixing**

   This version introduces the local audio mixing feature. You can call the `StartLocalAudioMixer` method to mix the audio streams from the local microphone, media player, sound card, and remote audio streams into a single audio stream, which can then be published to the channel. When you no longer need audio mixing, you can call the `StopLocalAudioMixer` method to stop local audio mixing. During the mixing process, you can call the `UpdateLocalAudioMixerConfiguration` method to update the configuration of the audio streams being mixed.

   Example use cases for this feature include:

   - By utilizing the local video mixing feature, the associated audio streams of the mixed video streams can be simultaneously captured and published.
   - In live streaming scenarios, users can receive audio streams within the channel, mix multiple audio streams locally, and then forward the mixed audio stream to other channels.
   - In educational scenarios, teachers can mix the audio from interactions with students locally and then forward the mixed audio stream to other channels.

5. **External MediaProjection (Android)**

   This version introduces the `SetExternalMediaProjection` method, which allows you to set an external `MediaProjection` and replace the `MediaProjection` applied by the SDK.

   If you have the capability to apply for `MediaProjection` on your own, you can use this feature to achieve more flexible screen capture.

6. **EGL context (Android)**

   This version introduces the `SetExternalRemoteEglContext` method, which is used to set the EGL context for rendering remote video streams. When using Texture format video data for remote video self-rendering, you can use this method to replace the SDK's default remote EGL context, achieving unified EGL context management.

7. **Color space settings**

   This version adds the **colorSpace** parameter to `VideoFrame` and `ExternalVideoFrame`. You can use this parameter to set the color space properties of the video frame. By default, the color space uses Full Range and BT.709 standard configuration. You can flexibly adjust according to your own capture or rendering needs, further enhancing the customization capabilities of video processing.

8. **Others**

   - `OnLocalVideoStateChanged` callback adds the `LOCAL_VIDEO_STREAM_REASON_DEVICE_DISCONNECTED` enumeration, indicating that the currently used video capture device has been disconnected (e.g., unplugged). (Windows)
   - `MEDIA_DEVICE_STATE_TYPE` adds the `MEDIA_DEVICE_STATE_PLUGGED_IN` enumeration, indicating that the device has been plugged in. (Windows)

#### Improvements

1. **Virtual background algorithm optimization**

   This version upgrades the virtual background algorithm, making the segmentation between the portrait and the background more accurate. There is no background exposure, the body contour of the portrait is complete, and the detail recognition of fingers is significantly improved. Additionally, the edges between the portrait and the background are more stable, reducing edge jumping and flickering in continuous video frames.

2. **Snapshot at specified video observation points**

   This version introduces the `TakeSnapshot [2/2]` and `TakeSnapshotEx [2/2]` methods. You can use the `config` parameter when calling these methods to take snapshots at specified video observation points, such as before encoding, after encoding, or before rendering, to achieve more flexible snapshot effects.

3. **Custom audio capture improvements**

   This version adds the `enableAudioProcessing` member parameter to `AudioTrackConfig`, which is used to control whether to enable 3A audio processing for custom audio capture tracks of the `AUDIO_TRACK_DIRECT` type. The default value of this parameter is `false`, meaning that audio processing is not enabled. Users can enable it as needed, enhancing the flexibility of custom audio processing.

4. **Other Improvements**

   - In scenarios where Alpha transparency effects are achieved by stitching video frames and Alpha data, the rendering performance on the receiving end has been improved, effectively reducing stuttering and latency. (Android, iOS)
   - Optimizes the logic for calling `QueryDeviceScore` to obtain device score levels, improving the accuracy of the score results.
   - Supports using virtual cameras in YV12 format as video capture devices. (Windows)
   - When calling `SwitchSrc` to switch between live streams or on-demand streams of different resolutions, smooth and seamless switching can be achieved. An automatic retry mechanism has been added in case of switching failures. The SDK will automatically retry 3 times after a failure. If it still fails, the `OnPlayerEvent` callback will report the `PLAYER_EVENT_SWITCH_ERROR` event, indicating an error occurred during media resource switching.
   - When calling `SetPlaybackSpeed` to set the playback speed of an audio file, the minimum supported speed is 0.3x.

#### Issues fixed

This version fixes the following issues:

- When calling `StartScreenCaptureByWindowId` to share the screen, the window capture area specified by **regionRect** was inaccurate, resulting in incorrect width and height of the screen sharing window seen by the receiving end. (Windows)
- When the video source type of the sender is in JPEG format, the frame rate on the receiving end occasionally falls below expectations. (Android, iOS)
- During audio and video interaction, after being interrupted by a system call, the user volume reported by the `OnAudioVolumeIndication` callback was incorrect. (Android)
- When the receiving end subscribes to the video small stream by default and does not automatically subscribe to any video stream when joining the channel, calling `MuteRemoteVideoStream``(uid, false)` after joining the channel to resume receiving the video stream results in receiving the video large stream, which is not as expected. (Android)
- Occasional errors of not finding system files during audio and video interaction on Windows 7 systems. (Windows)
- When calling `FollowSystemRecordingDevice` or `FollowSystemPlaybackDevice` to set the audio capture or playback device used by the SDK to not follow the system default audio playback device, the local audio state callback `OnLocalAudioStateChanged` is not triggered when the audio device is removed, which is not as expected. (Windows)
- Occasional instances where the receiving end cannot hear the sender during audio and video interaction. (iOS)
- During audio and video interaction, if the sender's device system version is iOS 17, the receiving end occasionally cannot hear the sender. (iOS)
- In live streaming scenarios, the time taken to reconnect to the live room after the audience end disconnects due to network switching is longer than expected. (iOS)
- No sound when playing online media resources using the media player after the app starts. (iOS)
- Occasional instances of no sound in audio capture after resuming from being interrupted by other system apps during audio and video interaction. (iOS)
- Calling `StartAudioMixing [1/2]` and then immediately calling `PauseAudioMixing` to pause the music file playback does not take effect.
- Occasional crashes during audio and video interaction. (Android)

## v4.4.0

This version was released on August x, 2024.

#### Compatibility changes

This version includes optimizations to some features, including changes to SDK behavior, API renaming and deletion. To ensure normal operation of the project, update the code in the app after upgrading to this release.

1. To distinguish context information in different extension callbacks, this version removes the original extension callbacks and adds corresponding callbacks that contain context information (see the table below). You can identify the extension name, the user ID, and the service provider name through `ExtensionContext` in each callback.

   | Original callback    | Current callback                |
   | -------------------- | ------------------------------- |
   | `onExtensionEvent`   | `OnExtensionEventWithContext`   |
   | `onExtensionStarted` | `OnExtensionStartedWithContext` |
   | `onExtensionStopped` | `OnExtensionStoppedWithContext` |
   | `onExtensionError`   | `OnExtensionErrorWithContext`   |

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

   Additionally, `AdvanceOptions` adds a new member `encodeAlpha`, which is used to set whether to encode and send Alpha information to the remote end. By default, the SDK does not encode and send Alpha information; if you need to encode and send Alpha information to the remote end (for example, when virtual background is enabled), explicitly call `SetVideoEncoderConfiguration` to set the video encoding properties and set `encodeAlpha` to `true`.

2. **Voice AI tuner**

   This version introduces the voice AI tuner feature, which can enhance the sound quality and tone, similar to a physical sound card. You can enable the voice AI tuner feature by calling the `EnableVoiceAITuner` method and passing in the sound effect types supported in the `VOICE_AI_TUNER_TYPE` enum to achieve effects like deep voice, cute voice, husky singing voice, etc.

3. **1v1 video call scenario**

   This version adds `APPLICATION_SCENARIO_1V1` (1v1 video call) in `VIDEO_APPLICATION_SCENARIO_TYPE`. You can call `SetVideoScenario` to set the video application scenario to 1v1 video call, the SDK optimizes performance to achieve low latency and high video quality, enhancing image quality, first frame rendering, latency on mid-to-low-end devices, and smoothness under poor network conditions.

#### Improvements

1. **Adaptive hardware decoding support (Android, Windows)**

   This release introduces adaptive hardware decoding support, enhancing rendering smoothness on low-end devices and effectively reducing system load.

2. **Rendering performance enhancement (Windows)**

   DirectX 11 renderer is now enabled by default on Windows devices, providing high-performance and high-quality graphics rendering capabilities.

3. **Facial region beautification**

   To avoid losing details in non-facial areas during heavy skin smoothing, this version improves the skin smoothing algorithm. The SDK now recognizes various parts of the face, applying smoothing to facial skin areas excluding the mouth, eyes, and eyebrows. In addition, the SDK supports smoothing up to two faces simultaneously.

4. **Other improvements**

   This version also includes the following improvements:

   - Optimizes transmission strategy: calling `EnableInstantMediaRendering` no longer impacts the security of the transmission link.
   - The `LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_DISPLAY_DISCONNECTED` enumerator is added in `OnLocalVideoStateChanged` callback, indicating that the display used for screen capture has been disconnected. (Windows, macOS)
   - Optimizes the video link for window sharing, reducing CPU usage. (macOS)
   - Improves echo cancellation for screen sharing scenarios.
   - Adds the `channelId` parameter to `Metadata`, which is used to get the channel name from which the metadata is sent.
   - Deprecates redundant enumeration values `CLIENT_ROLE_CHANGE_FAILED_REQUEST_TIME_OUT` and `CLIENT_ROLE_CHANGE_FAILED_CONNECTION_FAILED` in `CLIENT_ROLE_CHANGE_FAILED_REASON`.

#### Issues fixed

This release fixed the following issues:

- Occasional app crashes occurred when multiple remote users joined the channel simultaneously during real-time interaction. (iOS)
- Remote video occasionally froze or displayed corrupted images when the app returned to the foreground after being in the background for a while. (iOS)
- After the sender called `StartDirectCdnStreaming` to start direct CDN streaming, frequent switching or toggling of the network occasionally resulted in a black screen on the receiver's end without a streaming failure callback on the sender's end. (iOS)
- Audio playback failed when pushing external audio data using `PushAudioFrame` and the sample rate was not set as a recommended value, such as 22050 Hz and 11025 Hz.

## v4.3.2

This version was released on May x, 20xx.

#### Improvements

This release enhances the usability of the [SetRemoteSubscribeFallbackOption](API/api_irtcengine_setremotesubscribefallbackoption.html) method by removing the timing requirements for invocation. It can now be called both before and after joining the channel to dynamically switch audio and video stream fallback options in weak network conditions.

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
- The screen occasionally flickered on the receiver's side when sharing a PPT window using [StartScreenCaptureByWindowId](API/api_irtcengine_startscreencapturebywindowid.html) and playing PPT animations. (Windows)
- The window border did not retain its original size after exiting the presentation and then maximizing the PPT window when sharing a WPS PPT window on Windows 7 using [StartScreenCaptureByWindowId](API/api_irtcengine_startscreencapturebywindowid.html) and setting `enableHighLight` in [ScreenCaptureParameters](API/class_screencaptureparameters.html) to `true`. (Windows)
- The specified window could not be brought to the foreground if it was covered by other windows when sharing a window using [StartScreenCaptureByWindowId](API/api_irtcengine_startscreencapturebywindowid.html) and setting `windowFocus` and `enableHighLight` in [ScreenCaptureParameters](API/class_screencaptureparameters.html) to `true`. (Windows)
- Clicking on the desktop widget caused the outlined part to flicker when sharing and highlighting a window on a Windows 7 device. (Windows)
- When playing an audio file using [StartAudioMixing [1/2\]](API/api_irtcengine_startaudiomixing.html) and the playing finished, the SDK sometimes failed to trigger the [OnAudioMixingStateChanged](API/callback_irtcengineeventhandler_onaudiomixingstatechanged.html)(AUDIO_MIXING_STATE_STOPPED, AUDIO_MIXING_REASON_ALL_LOOPS_COMPLETED) callback which reports that the playing is completed. (iOS)
- When calling the [PlayEffect](API/api_irtcengine_playeffect3.html) method to play sound effect files shorter than 1 second with `loopCount` set to 0, there was no sound. (iOS)
- When using the Agora media player to play a video and stopping it during playing, sometimes there was no sound for a short time after the playing was resumed. (iOS)

## v4.3.1

This version is released on 2024 Month x, Day x.

#### New Features

1. **Speech Driven Avatar**

   The SDK introduces a speech driven extension that converts speech information into corresponding facial expressions to animate avatar. You can access the facial information through the newly added [`RegisterFaceInfoObserver`](/api-ref/rtc/unity/API/toc_speech_driven#api_imediaengine_registerfaceinfoobserver) method and [`OnFaceInfo`](/api-ref/rtc/unity/API/toc_speech_driven#callback_ifaceinfoobserver_onfaceinfo) callback. This facial information conforms to the ARKit standard for Blend Shapes (BS), which you can further process using third-party 3D rendering engines.

   The speech driven extension is a trimmable dynamic library, and details about the increase in app size are available at [reduce-app-size]().

   **Attention:** The speech driven avatar feature is currently in beta testing. To use it, please contact [technical support](mailto:support@agora.io).

2. **Privacy manifest file (iOS)**

   To meet Apple's safety compliance requirements for app publication, the SDK now includes a privacy manifest file, `PrivacyInfo.xcprivacy`, detailing the SDK's API calls that access or use user data, along with a description of the types of data collected.

   **Note:** If you need to publish an app with SDK versions prior to v4.3.1 to the Apple App Store, you must manually add the `PrivacyInfo.xcprivacy` file to your Xcode project.

3. **Portrait center stage (iOS, macOS)**

   To enhance the presentation effect in online meetings, shows, and online education scenarios, this version introduces the [`EnableCameraCenterStage`](/api-ref/rtc/unity/API/toc_center_stage#api_irtcengine_enablecameracenterstage) method to activate the portrait center stage feature. This ensures that presenters, regardless of movement, always remain centered in the video frame, achieving better presentation effects.

   Before enabling portrait center stage it is recommended to verify whether your current device supports this feature by calling [`IsCameraCenterStageSupported`](/api-ref/rtc/unity/API/toc_center_stage#api_irtcengine_iscameracenterstagesupported). A list of supported devices can be found in the API documentation at [`EnableCameraCenterStage`](/api-ref/rtc/unity/API/toc_center_stage#api_irtcengine_enablecameracenterstage).

4. **Camera stabilization (iOS)**

   To improve video stability in mobile filming, low-light environments, and hand-held shooting scenarios, this version introduces a camera stabilization feature. You can activate this feature and select an appropriate stabilization mode by calling [`SetCameraStabilizationMode`](/api-ref/rtc/unity/API/toc_camera_capture#api_irtcengine_setcamerastabilizationmode), achieving more stable and clearer video footage.

5. **Wide and ultra-wide cameras (Android, iOS)**

   To allow users to capture a broader field of view and more complete scene content, this release introduces support for wide and ultra-wide cameras. You can first call [`QueryCameraFocalLengthCapability`](/api-ref/rtc/unity/API/toc_video_device#api_irtcengine_querycamerafocallengthcapability) to check the device's focal length capabilities, and then call [`SetCameraCapturerConfiguration`](/api-ref/rtc/unity/API/toc_video_device#api_irtcengine_setcameracapturerconfiguration) and set `cameraFocalLengthType` to the supported focal length types, including wide and ultra-wide.

6. **Multi-camera capture (Android)**

   This release introduces additional functionalities for Android camera capture:

   1. Support for capturing and publishing video streams from the third and fourth cameras:

      - `VIDEO_SOURCE_CAMERA_THIRD` (11) and `VIDEO_SOURCE_CAMERA_FOURTH` (12) in [`VIDEO_SOURCE_TYPE`](/api-ref/rtc/unity/API/enum_videosourcetype) add support for Android, specifically for the third and fourth camera sources. This change allows you to specify up to four camera streams when initiating camera capture by calling [`StartCameraCapture`](/api-ref/rtc/unity/API/toc_camera_capture#api_irtcengine_startcameracapture).
      - `publishThirdCameraTrack` and `publishFourthCameraTrack` in [`ChannelMediaOptions`](/api-ref/rtc/unity/API/class_channelmediaoptions) add support for Android. Set these parameters to `true` when joining a channel with [`JoinChannel`](/api-ref/rtc/unity/API/toc_channel#api_irtcengine_joinchannel2)[2/2] to publish video streams captured from the third and fourth cameras.

   2. Support for specifying cameras by camera ID:

      A new parameter `cameraId` is added to [`CameraCapturerConfiguration`](/api-ref/rtc/unity/API/class_cameracapturerconfiguration). For devices with multiple cameras, where `cameraDirection` cannot identify or access all available cameras, you can obtain the camera ID through Android's native system APIs and specify the desired camera by calling [`StartCameraCapture`](/api-ref/rtc/unity/API/toc_camera_capture#api_irtcengine_startcameracapture) with the specific `cameraId`.

7. **Data stream encryption**

   This version adds `datastreamEncryptionEnabled` to [`EncryptionConfig`](/api-ref/rtc/unity/API/class_encryptionconfig) for enabling data stream encryption. You can set this when you activate encryption with [`EnableEncryption`](/api-ref/rtc/unity/API/toc_network#api_irtcengine_enableencryption). If there are issues causing failures in data stream encryption or decryption, these can be identified by the newly added `ENCRYPTION_ERROR_DATASTREAM_DECRYPTION_FAILURE` and `ENCRYPTION_ERROR_DATASTREAM_ENCRYPTION_FAILURE` enumerations.

8. **Adaptive configuration for low-quality video streams**

   This version introduces adaptive configuration for low-quality video streams. When you activate dual-stream mode and set up low-quality video streams on the sending side using [`SetDualStreamMode`](/api-ref/rtc/unity/API/toc_dual_stream#api_irtcengine_setdualstreammode2)[2/2], the SDK defaults to the following behaviors:

   - The default encoding resolution for low-quality video streams is set to 50% of the original video encoding resolution.
   - The bitrate for the small streams is automatically matched based on the video resolution and frame rate, eliminating the need for manual specification.

9. **Other features**

   - New method [`EnableEncryptionEx`](/api-ref/rtc/unity/API/toc_network#api_irtcengineex_enableencryptionex) is added for enabling media stream or data stream encryption in multi-channel scenarios.
   - New method [`SetAudioMixingPlaybackSpeed`](/api-ref/rtc/unity/API/toc_audio_mixing#api_irtcengine_setaudiomixingplaybackspeed) is introduced for setting the playback speed of audio files.
   - New method [`GetCallIdEx`](/api-ref/rtc/unity/API/toc_network#api_irtcengineex_getcallidex) is introduced for retrieving call IDs in multi-channel scenarios.

#### Improvements

1. **Optimization for game scenario screen sharing (Windows)**

   This version specifically optimizes screen sharing for game scenarios, enhancing performance, stability, and clarity in ultra-high definition (4K, 60 fps) game scenarios, resulting in a clearer, smoother, and more stable gaming experience for players.

2. **Audio device type detection (macOS)**

   This version adds the [GetPlaybackDefaultDevice [2/2]](/api-ref/rtc/unity/API/toc_audio_device#api_iaudiodevicemanager_getplaybackdefaultdevice2), [`GetRecordingDefaultDevice`](/api-ref/rtc/unity/API/toc_audio_device#api_iaudiodevicemanager_getrecordingdefaultdevice2)[2/2], [`GetPlaybackDeviceInfo`](/api-ref/rtc/unity/API/toc_audio_device#api_iaudiodevicemanager_getplaybackdeviceinfo2)[2/2], and [`GetRecordingDeviceInfo`](/api-ref/rtc/unity/API/toc_audio_device#api_iaudiodevicemanager_getrecordingdeviceinfo2)[2/2] method to obtain the information and type of audio playback and recording devices.

3. **Virtual Background Algorithm Optimization**

   To enhance the accuracy and stability of human segmentation when activating virtual backgrounds against solid colors, this version optimizes the green screen segmentation algorithm:

   - Supports recognition of any solid color background, no longer limited to green screens.
   - Improves accuracy in recognizing background colors and reduces the background exposure during human segmentation.
   - After segmentation, the edges of the human figure (especially around the fingers) are more stable, significantly reducing flickering at the edges.

4. **CPU consumption reduction of in-ear monitoring**

   This release adds an enumerator `EAR_MONITORING_FILTER_REUSE_POST_PROCESSING_FILTER` (1 << 15) in `EAR_MONITORING_FILTER_TYPE`. For complex audio processing scenarios, you can specify this option to reuse the audio filter post sender-side processing in in-ear monitoring, thereby reducing CPU consumption. Note that this option may increase the latency of in-ear monitoring, which is suitable for latency-tolerant scenarios requiring low CPU consumption.

5. **Other improvements**

   This version also includes the following improvements:

   - Optimization of video encoding and decoding strategies in non-screen sharing scenarios to save system performance overhead. (Windows)
   - Enhanced media player capabilities to handle WebM format videos, including support for rendering alpha channels.
   - In [`AUDIO_EFFECT_PRESET`](/api-ref/rtc/unity/API/enum_audioeffectpreset), a new enumeration `ROOM_ACOUSTICS_CHORUS` (chorus effect) is added, enhancing the spatial presence of vocals in chorus scenarios.
   - In [`RemoteAudioStats`](/api-ref/rtc/unity/API/class_remoteaudiostats), a new `e2eDelay` field is added to report the delay from when the audio is captured on the sending end to when the audio is played on the receiving end.

#### Issues fixed

This version fixed the following issues:

- Fixed an issue where SEI data output did not synchronize with video rendering when playing media streams containing SEI data using the media player.
- In screen sharing scenarios, when the app enabled sound card capture with [`EnableLoopbackRecording`](/api-ref/rtc/unity/API/toc_audio_capture#api_irtcengine_enableloopbackrecording) to capture audio from the shared screen, the transmission of sound card captured audio failed after a local user manually disabled the local audio capture device, causing remote users to not hear the shared screen's audio. (Windows)
- Broadcasters using certain models of devices under speaker mode experienced occasional local audio capture failures when switching the app process to the background and then back to the foreground, causing remote users to not hear the broadcaster's audio. (Android)
- An occasional echo was observed when playing the audio stream of a specified user before mixing. (macOS, Windows)
- During interactions, when a local user set the system default playback device to speakers using , there was no sound from the remote end. (Windows)
- On devices with Android 8.0, enabling screen sharing occasionally caused the app to crash. (Android)
- When sharing an Excel document window, remote users occasionally saw a green screen. (Windows)
- In scenarios using camera capture for local video, when the app was moved to the background and [`DisableVideo`](/api-ref/rtc/unity/API/toc_video_basic#api_irtcengine_disablevideo) or [`StopPreview`](/api-ref/rtc/unity/API/toc_video_basic#api_irtcengine_stoppreview)[1/2] was called to stop video capture, camera capture was unexpectedly activated when the app was brought back to the foreground. (Android)
- When the network conditions of the sender deteriorated (for example, in poor network environments), the receiver occasionally experienced a decrease in video smoothness and an increase in lag.

#### API Changes

**Added**

- [`EnableCameraCenterStage`](/api-ref/rtc/unity/API/toc_center_stage#api_irtcengine_enablecameracenterstage) (iOS, macOS)
- [`IsCameraCenterStageSupported`](/api-ref/rtc/unity/API/toc_center_stage#api_irtcengine_iscameracenterstagesupported) (iOS, macOS)
- [`SetCameraStabilizationMode`](/api-ref/rtc/unity/API/toc_camera_capture#api_irtcengine_setcamerastabilizationmode) (iOS)
- [`CAMERA_STABILIZATION_MODE`](/api-ref/rtc/unity/API/enum_camerastabilizationmode) (iOS)
- [`RegisterFaceInfoObserver`](/api-ref/rtc/unity/API/toc_speech_driven#api_imediaengine_registerfaceinfoobserver)
- [`UnregisterFaceInfoObserver`](/api-ref/rtc/unity/API/toc_speech_driven#api_imediaengine_unregisterfaceinfoobserver)
- [`IFaceInfoObserver`](/api-ref/rtc/unity/API/class_ifaceinfoobserver)
- [`OnFaceInfo`](/api-ref/rtc/unity/API/toc_speech_driven#callback_ifaceinfoobserver_onfaceinfo)
- The `publishLipSyncTrack` member in [`ChannelMediaOptions`](/api-ref/rtc/unity/API/class_channelmediaoptions)
- [`MEDIA_SOURCE_TYPE`](/api-ref/rtc/unity/API/enum_mediasourcetype) adds `SPEECH_DRIVEN_VIDEO_SOURCE`
- [`VIDEO_SOURCE_TYPE`](/api-ref/rtc/unity/API/enum_videosourcetype) adds `VIDEO_SOURCE_SPEECH_DRIVEN`
- [`EncryptionConfig`](/api-ref/rtc/unity/API/class_encryptionconfig) adds `datastreamEncryptionEnabled`
- [`ENCRYPTION_ERROR_TYPE`](/api-ref/rtc/unity/API/enum_encryptionerrortype) adds the following enumerations:
  - `ENCRYPTION_ERROR_DATASTREAM_DECRYPTION_FAILURE`
  - `ENCRYPTION_ERROR_DATASTREAM_ENCRYPTION_FAILURE`
- [`GetPlaybackDefaultDevice`](/api-ref/rtc/unity/API/toc_audio_device#api_iaudiodevicemanager_getplaybackdefaultdevice2)[2/2] (macOS)
- [`GetRecordingDefaultDevice`](/api-ref/rtc/unity/API/toc_audio_device#api_iaudiodevicemanager_getrecordingdefaultdevice2)[2/2] (macOS)
- [`GetPlaybackDeviceInfo`](/api-ref/rtc/unity/API/toc_audio_device#api_iaudiodevicemanager_getplaybackdeviceinfo2)[2/2] (macOS)
- [`GetRecordingDeviceInfo`](/api-ref/rtc/unity/API/toc_audio_device#api_iaudiodevicemanager_getrecordingdeviceinfo2)[2/2] (macOS)
- [`RemoteAudioStats`](/api-ref/rtc/unity/API/class_remoteaudiostats) adds `e2eDelay`
- [`ERROR_CODE_TYPE`](/api-ref/rtc/unity/API/enum_errorcodetype) adds `ERR_DATASTREAM_DECRYPTION_FAILED`
- [`AUDIO_EFFECT_PRESET`](/api-ref/rtc/unity/API/enum_audioeffectpreset) adds `ROOM_ACOUSTICS_CHORUS`, enhancing the spatial presence of vocals in chorus scenarios.
- [`GetCallIdEx`](/api-ref/rtc/unity/API/toc_network#api_irtcengineex_getcallidex)
- [`EnableEncryptionEx`](/api-ref/rtc/unity/API/toc_network#api_irtcengineex_enableencryptionex)
- [`SetAudioMixingPlaybackSpeed`](/api-ref/rtc/unity/API/toc_audio_mixing#api_irtcengine_setaudiomixingplaybackspeed)
- [`QueryCameraFocalLengthCapability`](/api-ref/rtc/unity/API/toc_video_device#api_irtcengine_querycamerafocallengthcapability) (Android, iOS)
- [`FocalLengthInfo`](/api-ref/rtc/unity/API/class_focallengthinfo) (Android, iOS)
- [`CAMERA_FOCAL_LENGTH_TYPE`](/api-ref/rtc/unity/API/enum_camerafocallengthtype) (Android, iOS)
- [`CameraCapturerConfiguration`](/api-ref/rtc/unity/API/class_cameracapturerconfiguration) adds a new member `cameraFocalLengthType` (Android, iOS)
- [`CameraCapturerConfiguration`](/api-ref/rtc/unity/API/class_cameracapturerconfiguration) adds a new member `cameraId` (Android)
- [`EAR_MONITORING_FILTER_TYPE`](/api-ref/rtc/unity/API/enum_earmonitoringfiltertype) adds a new enumeration `EAR_MONITORING_FILTER_BUILT_IN_AUDIO_FILTERS`(1 <<15)

## v4.3.0

v4.3.0 was released on xx xx, 2024.

#### Compatibility changes

This release has optimized the implementation of some functions, involving renaming or deletion of some APIs. To ensure the normal operation of the project, you need to update the code in the app after upgrading to this release.

1. **Renaming parameters in callbacks**

   In order to make the parameters in some callbacks and the naming of enumerations in enumeration classes easier to understand, the following modifications have been made in this release. Please modify the parameter settings in the callbacks after upgrading to this release.

   | Callback                           | Original parameter name | Existing parameter name |
   | ---------------------------------- | ----------------------- | ----------------------- |
   | `OnLocalAudioStateChanged`         | `error`                 | `reason`                |
   | `onLocalVideoStateChanged`         | `error`                 | `reason`                |
   | `OnDirectCdnStreamingStateChanged` | `error`                 | `reason`                |
   | `OnRtmpStreamingStateChanged`      | `errCode`               | `reason`                |

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

   This release makes the following modifications to the enumerations in the [LOCAL_VIDEO_STREAM_REASON](API/enum_localvideostreamreason.html) class:

   - The value of `LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_PAUSED` (formerly `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_PAUSED`) has been changed from 23 to 28.
   - The value of `LOCAL_VIDEO_STREAM_REASON_SCREEN_CAPTURE_RESUMED` (formerly `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_RESUMED`) has been changed from 24 to 29.
   - The `LOCAL_VIDEO_STREAM_ERROR_CODEC_NOT_SUPPORT` enumeration has been changed to `LOCAL_VIDEO_STREAM_REASON_CODEC_NOT_SUPPORT`

4. **Audio route**

   Starting with this release, `routeBluetooth` in [`AudioRoute`](/api-ref/rtc/unity/API/enum_audioroute) is renamed to `ROUTE_BLUETOOTH_DEVICE_HFP`, representing a Bluetooth device using the HFP protocol. `ROUTE_BLUETOOTH_DEVICE_A2DP`(10) is added to represent a Bluetooth device using the A2DP protocol

5. **Audio loopback capturing (Windows, macOS)**

- Before v4.3.0, if you call the [`DisableAudio`](/api-ref/rtc/unity/API/toc_audio_basic#api_irtcengine_disableaudio) method to disable the audio module, audio loopback capturing will not be disabled.
- As of v4.3.0, if you call the [`DisableAudio`](/api-ref/rtc/unity/API/toc_audio_basic#api_irtcengine_disableaudio) method to disable the audio module, audio loopback capturing will be disabled as well. If you need to enable audio loopback capturing, you need to enable the audio module by calling the [`EnableAudio`](/api-ref/rtc/unity/API/toc_audio_basic#api_irtcengine_enableaudio) method and then call [`EnableLoopbackRecording`](/api-ref/rtc/unity/API/toc_audio_capture#api_irtcengine_enableloopbackrecording).

6. **Log encryption behavior changes**

   For security and performance reasons, as of this release, the SDK encrypts logs and no longer supports printing plaintext logs via the console.

   Refer to the following solutions for different needs:

   - If you need to know the API call status, please check the API logs and print the SDK callback logs yourself.
   - For any other special requirements, please contact [technical support](mailto:support@agora.io) and provide the corresponding encrypted logs.

#### New features

1. **Local preview with multiple views**

   This release supports local preview with simultaneous display of multiple frames, where the videos shown in the frames are positioned at different observation positions along the video link. Examples of usage are as follows:

   1. Call [SetupLocalVideo](API/api_irtcengine_setuplocalvideo.html) to set the first view: Set the `position` parameter to `POSITION_POST_CAPTURER_ORIGIN` (introduced in this release) in `VideoCanvas`. This corresponds to the position after local video capture and before preprocessing. The video observed here does not have preprocessing effects.
   2. Call [SetupLocalVideo](API/api_irtcengine_setuplocalvideo.html) to set the second view: Set the `position` parameter to `POSITION_POST_CAPTURER` in `VideoCanvas`, the video observed here has the effect of video preprocessing.
   3. Observe the local preview effect: The first view is the original video of a real person; the second view is the virtual portrait after video preprocessing (including image enhancement, virtual background, and local preview of watermarks) effects.

2. **Custom mixed video layout on receiving end (Android, iOS)**

   To facilitate customized layout of mixed video stream at the receiver end, this release introduces the [OnTranscodedStreamLayoutInfo](API/callback_irtcengineeventhandler_ontranscodedstreamlayoutinfo.html) callback. When the receiver receives the channel's mixed video stream sent by the video mixing server, this callback is triggered, reporting the layout information of the mixed video stream and the layout information of each sub-video stream in the mixed stream. The receiver can set a separate `view` for rendering the sub-video stream (distinguished by `subviewUid`) in the mixed video stream when calling the [SetupRemoteVideo](API/api_irtcengine_setupremotevideo.html) method, achieving a custom video layout effect.

   When the layout of the sub-video streams in the mixed video stream changes, this callback will also be triggered to report the latest layout information in real time.

   Through this feature, the receiver end can flexibly adjust the local view layout. When applied in a multi-person video scenario, the receiving end only needs to receive and decode a mixed video stream, which can effectively reduce the CPU usage and network bandwidth when decoding multiple video streams on the receiving end.

3. **Query Device Score**

   This release adds the [QueryDeviceScore](API/api_irtcengine_querydevicescore.html) method to query the device's score level to ensure that the user-set parameters do not exceed the device's capabilities. For example, in HD or UHD video scenarios, you can first call this method to query the device's score. If the returned score is low (for example, below 60), you need to lower the video resolution to avoid affecting the video experience. The minimum device score required for different business scenarios is varied. For specific score recommendations, please contact [technical support](mailto:support@agora.io).

4. **Select different audio tracks for local playback and streaming**

   This release introduces the [SelectMultiAudioTrack](API/api_imediaplayer_selectmultiaudiotrack.html) method that allows you to select different audio tracks for local playback and streaming to remote users. For example, in scenarios like online karaoke, the host can choose to play the original sound locally and publish the accompaniment in the channel. Before using this function, you need to open the media file through the [OpenWithMediaSource](API/api_imediaplayer_openwithmediasource.html) method and enable this function by setting the `enableMultiAudioTrack` parameter in [MediaSource](API/class_mediasource.html).

5. **Others**

   This release has passed the test verification of the following APIs and can be applied to the entire series of RTC 4.x SDK.

   - [SetRemoteSubscribeFallbackOption](API/api_irtcengine_setremotesubscribefallbackoption.html): Sets fallback option for the subscribed video stream in weak network conditions.
   - [OnRemoteSubscribeFallbackToAudioOnly](API/callback_irtcengineeventhandler_onremotesubscribefallbacktoaudioonly.html): Occurs when the subscribed video stream falls back to audio-only stream due to weak network conditions or switches back to the video stream after the network conditions improve.
   - [GetRecordingDeviceVolume](API/api_iaudiodevicemanager_getrecordingdevicevolume.html)(Windows): Sets the volume of the audio capturing device.
   - [SetPlayerOption [1/2]](API/api_imediaplayer_setplayeroption.html) and [setPlayerOption [2/2]](API/api_imediaplayer_setplayeroption2.html): Sets media player options for providing technical previews or special customization features.
   - [EnableCustomAudioLocalPlayback](API/api_irtcengine_enablecustomaudiolocalplayback.html): Sets whether to enable the local playback of external audio source.

#### Improvements

1. **SDK task processing scheduling optimization**

   This release optimizes the scheduling mechanism for internal tasks within the SDK, with improvements in the following aspects:

   - The speed of video rendering and audio playback for both remote and local first frames improves by 10% to 20%.
   - The API call duration and response time are reduced by 5% to 50%.
   - The SDK's parallel processing capability significantly improves, delivering higher video quality (720P, 24 fps) even on lower-end devices. Additionally, image processing remains more stable in scenarios involving high resolutions and frame rates.
   - The stability of the SDK is further enhanced, leading to a noticeable decrease in the crash rate across various specific scenarios.

2. **In-ear monitoring volume boost**

   This release provides users with more flexible in-ear monitoring audio adjustment options, supporting the ability to set the in-ear monitoring volume to four times the original volume by calling [SetInEarMonitoringVolume](API/api_irtcengine_setinearmonitoringvolume.html).

3. **Spatial audio effects usability improvement**

   - This release optimizes the design of the [SetZones](API/api_ibasespatialaudioengine_setzones.html) method, supporting the ability to set the `zones` parameter to `NULL`, indicating the clearing of all echo cancellation zones.
   - As of this release, it is no longer necessary to unsubscribe from the audio streams of all remote users within the channel before calling the methods in [ILocalSpatialAudioEngine](API/class_ilocalspatialaudioengine.html).

4. **Other Improvements**

   This release also includes the following improvements:

   - This release optimizes the SDK's domain name resolution strategy, improving the stability of calling to resolve domain names in complex network environments.
   - When passing in an image with transparent background as the virtual background image, the transparent background can be filled with customized color.
   - This release adds the `earMonitorDelay` and `aecEstimatedDelay` members in [LocalAudioStats](API/class_localaudiostats.html) to report ear monitor delay and acoustic echo cancellation (AEC) delay, respectively.
   - The [OnPlayerCacheStats](API/callback_imediaplayersourceobserver_onplayercachestats.html) callback is added to report the statistics of the media file being cached. This callback is triggered once per second after file caching is started.
   - The [OnPlayerPlaybackStats](API/callback_imediaplayersourceobserver_onplayerplaybackstats.html) callback is added to report the statistics of the media file being played. This callback is triggered once per second after the media file starts playing. You can obtain information like the audio and video bitrate of the media file through [PlayerPlaybackStats](API/class_playerplaybackstats.html).

#### Issues fixed

This release fixed the following issues:

- When sharing two screen sharing video streams simultaneously, the reported `captureFrameRate` in the [OnLocalVideoStats](API/callback_irtcengineeventhandler_onlocalvideostats.html) callback is 0, which is not as expected.

#### API changes

<a name="change"></a>

**Added**

- [OnTranscodedStreamLayoutInfo](API/callback_irtcengineeventhandler_ontranscodedstreamlayoutinfo.html) (Android, iOS)
- [VideoLayout](API/class_videolayout.html) (Android, iOS)
- The `subviewUid` member in [VideoCanvas](API/class_videocanvas.html)
- [EnableCustomAudioLocalPlayback](API/api_irtcengine_enablecustomaudiolocalplayback.html)
- [QueryDeviceScore](API/api_irtcengine_querydevicescore.html)
- The `CUSTOM_VIDEO_SOURCE` enumeration in [MEDIA_SOURCE_TYPE](API/enum_mediasourcetype.html)
- The `ROUTE_BLUETOOTH_DEVICE_A2DP` enumeration in [AudioRoute](API/enum_audioroute.html)
- [SelectMultiAudioTrack](API/api_imediaplayer_selectmultiaudiotrack.html)
- [OnPlayerCacheStats](API/callback_imediaplayersourceobserver_onplayercachestats.html)
- [OnPlayerPlaybackStats](API/callback_imediaplayersourceobserver_onplayerplaybackstats.html)
- [PlayerPlaybackStats](API/class_playerplaybackstats.html)

**Modified**

- `ROUTE_BLUETOOTH` is renamed as`ROUTE_BLUETOOTH_DEVICE_HFP`
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

- `StartChannelMediaRelay`
- `UpdateChannelMediaRelay`
- `StartChannelMediaRelayEx`
- `UpdateChannelMediaRelayEx`
- `OnChannelMediaRelayEvent`
- `CHANNEL_MEDIA_RELAY_EVENT`

## v4.2.6

v4.2.6 was released on November xx, 2023.

#### Issues fixed

This version fixed the following issues that may occur when using Android 14:

- When switching between portrait and landscape modes during screen sharing, the screen sharing process was interrupted. To restart screen sharing, users need to confirm recording the screen in the pop-up window. (Android)
- When integrating the SDK, setting the Android `targetSdkVersion` to 34 may cause screen sharing to be unavailable or even cause the app to crash. (Android)
- Calling `StartScreenCapture`[1/2] without sharing video (setting `captureVideo` to `false`) and then calling `UpdateScreenCaptureParameters` to share video (setting `captureVideo`to `true`) resulted in a frozen shared screen at the receiving end. (Android)
- When screen sharing in landscape mode, the shared screen seen by the audience was divided into two parts: one side of the screen was compressed; the other side was black. (Android)

This version also fixed the following issues:

- When using an iOS 16 or later device with Bluetooth headphones connected before joining the channel, the audio routing after joining the channel was not as expected: audio was played from the speaker, not the Bluetooth headphones. (iOS)
- In live streaming scenarios, the video on the audience end occasionally distorted. (Android)
- In specific scenarios (such as when the network packet loss rate was high or when the broadcaster left the channel without destroying the engine and then re-joined the channel), the video on the receiving end stuttered or froze.

## v4.2.4

v4.2.4 was released on October xx, 2023.

This version fixes the incorrect `CFBundleShortVersionString` version number in `AgoraRtcWrapper` which caused the app to be unable to be submitted to the App Store. (iOS, macOS)

## v4.2.3

v4.2.3 was released on October xx, 2023.

#### New features

1. **Update video screenshot and upload**

   To facilitate the integration of third-party video moderation services from Agora Extensions Marketplace, this version has the following changes:

   - The `CONTENT_INSPECT_IMAGE_MODERATION` enumeration is added in `CONTENT_INSPECT_TYPE` which means using video moderation extensions from Agora Extensions Marketplace to take video screenshots and upload them.
   - An optional parameter `serverConfig` is added in `ContentInspectConfig`, which is for server-side configuration related to video screenshot and upload via extensions from Agora Extensions Marketplace. By configuring this parameter, you can integrate multiple third-party moderation extensions and achieve flexible control over extension switches and other features. For more details, please contact [technical support](mailto:support@agora.io).

   In addition, this version also introduces the `EnableContentInspectEx` method, which supports taking screenshots for multiple video streams and uploading them.

2. **ID3D11Texture2D Rendering** (Windows)

   As of this release, the SDK supports video formats of type ID3D11Texture2D, improving the rendering effect of video frames in game scenarios. You can set `format` to `VIDEO_TEXTURE_ID3D11TEXTURE2D` when pushing external raw video frames to the SDK by calling `PushVideoFrame`. By setting the `d3d11_texture_2d` and `texture_slice_index` properties, you can determine the ID3D11Texture2D texture object to use.

3. **Local video status error code update** (Windows, macOS)

   In order to help users understand the exact reasons for local video errors in screen sharing scenarios, the following sets of enumerations have been added to the `OnLocalVideoStateChanged` callback:

   - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_PAUSED`(23): Screen capture has been paused. Common scenarios for reporting this error code: The current screen may have been switched to a secure desktop, such as a UAC dialog box or Winlogon desktop.
   - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_RESUMED`(24): Screen capture has resumed from the paused state.
   - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_HIDDEN`(25): The window being captured on the current screen is in a hidden state and is not visible on the current screen.
   - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_HIDDEN`(26): The window for screen capture has been restored from the hidden state.
   - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_MINIMIZED`(27): The window for screen capture has been restored from the minimized state.

4. **Check device support for advanced features**

   This version adds the `IsFeatureAvailableOnDevice` method to check whether the capability of the current device meets the requirements of the specified advanced feature, such as virtual background and image enhancement.

   Before using advanced features, you can check whether the current device supports these features based on the call result. This helps to avoid performance degradation or unavailable features when enabling advanced features on low-end devices. Based on the return value of this method, you can decide whether to display or enable the corresponding feature button, or notify the user when the device's capabilities are insufficient.

   In addition, since this version, calling `EnableVirtualBackground` and `SetBeautyEffectOptions` automatically triggers a test on the capability of the current device. When the device is considered underperformed, the error code `-4:ERR_NOT_SUPPORTED` is returned, indicating the device does not support the feature.

#### Improvements

1. **Optimize virtual background memory usage**

   This version has upgraded the virtual background algorithm, reducing the memory usage of the virtual background feature. Compared to the previous version, the memory consumption of the app during the use of the virtual background feature on low-end devices has been reduced by approximately 4% to 10% (specific values may vary depending on the device model and platform).

2. **Screen sharing scenario optimization**

   This release optimizes the performance and encoding efficiency in ultra-high-definition (4K, 60 fps) game sharing scenarios, effectively reducing the system resource usage during screen sharing.

**Other Improvements**

This release includes the following additional improvements:

- Optimizes the logic of handling invalid parameters. When you call the `SetPlaybackSpeed` method to set the playback speed of audio files, if you pass an invalid parameter, the SDK returns the error code -2, which means that you need to reset the parameter.
- Optimizes the logic of Token parsing, in order to prevent an app from crash when an invalid token is passed in.

#### Issues fixed

This release fixed the following issues:

- Occasional crashes and dropped frames occurred in screen sharing scenarios. (Windows)
- Occasional crashes when joining a channel. (macOS)
- Occasional failure of joining a channel when the local system time was not set correctly.
- When calling the `PlayEffect` method to play two audio files using the same `soundId`, the first audio file was sometimes played repeatedly.
- When the host called the `StartAudioMixing` [2/2] method to play music, sometimes the host couldn't hear the music while the remote users could hear it. (Android)
- Occasional crashes occurred on certain Android devices. (Android)
- Calling `TakeSnapshotEx` once receives the `OnSnapshotTaken` callback for multiple times.
- In channels joined by calling `JoinChannelEx` exclusively, calling `SetEnableSpeakerphone` is unable to switch audio route from the speaker to the headphone. (Android)

#### API changes

**Added**

- The following enumerations in `OnLocalVideoStateChanged`: (Windows, macOS)
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_PAUSED`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_RESUMED`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_HIDDEN`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_HIDDEN`
  - `LOCAL_VIDEO_STREAM_ERROR_SCREEN_CAPTURE_WINDOW_RECOVER_FROM_MINIMIZED`
- `d3d11_texture_2d` and `texture_slice_index` members in `ExternalVideoFrame` (Windows)
- `VIDEO_TEXTURE_ID3D11TEXTURE2D` in `VIDEO_PIXEL_FORMAT` (Windows)
- `EnableContentInspectEx`
- `CONTENT_INSPECT_IMAGE_MODERATION` in `CONTENT_INSPECT_TYPE`
- `serverConfig` in `ContentInspectConfig`
- `IsFeatureAvailableOnDevice`
- `FeatureType`

## v4.2.2

This version was released on July, xx, 2023.

#### Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

1. **Audio frame observer**

The following methods in the `IAudioFrameObserver` class are deleted:

- `GetObservedAudioFramePosition`: Use the newly-added `position` parameter in  `RegisterAudioFrameObserver` instead.
- `GetPlaybackAudioParams`: Use `SetPlaybackAudioFrameParameters` instead.
- `GetRecordAudioParams`: Use `SetRecordingAudioFrameParameters` instead.
- `GetMixedAudioParams`: Use `SetMixedAudioFrameParameters` instead.
- `GetEarMonitoringAudioParams`: Use `SetEarMonitoringAudioFrameParameters` instead.

2. **Video frame observer**

The following methods in the `IVideoFrameObserver` class are deleted:

- `GetVideoFormatPreference`: Use the newly-added `formatPreference` parameter in  `RegisterVideoFrameObserver`.
- `GetObservedFramePosition`: Use the newly-added `position` parameter in  `RegisterVideoFrameObserver`.

3. **Metadata**

This release deletes `GetMaxMetadataSize` and `OnReadyToSendMetadata` in the `IMetadataObserver` class. You can use the newly-added `SetMaxMetadataSize` and `SendMetadata` methods instead.

#### New features

1. **Wildcard token**

   This release introduces wildcard tokens. Agora supports setting the channel name used for generating a token as a wildcard character. The token generated can be used to join any channel if you use the same user id. In scenarios involving multiple channels, such as switching between different channels, using a wildcard token can avoid repeated application of tokens every time users joining a new channel, which reduces the pressure on your token server. See [Wildcard Tokens](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).

   <div class="alert info">All 4.x SDKs support using wildcard tokens.</div>

2. **Preloading channels**

   This release adds `PreloadChannel[1/2]` and `PreloadChannel[2/2]` methods, which allows a user whose role is set as audience to preload channels before joining one. Calling the method can help shortening the time of joining a channel, thus reducing the time it takes for audience members to hear and see the host.

   When preloading more than one channels, Agora recommends that you use a wildcard token for preloading to avoid repeated application of tokens every time you joining a new channel, thus saving the time for switching between channels. See [Wildcard Tokens](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/wildcard_token?platform=All%20Platforms).

3. **Customized background color of video canvas**

   In this release, the `backgroundColor` member has been added to `VideoCanvas`, which allows you to customize the background color of the video canvas when setting the properties of local or remote video display.

4. **Publishing video streams from different sources** (Windows, macOS)

   This release adds the following members in `ChannelMediaOptions` to allow you publish video streams captured from the third and fourth camera or screen:

   - `publishThirdCameraTrack`: Publishing the video stream captured from the third camera.
   - `publishFourthCameraTrack`: Publishing the video stream captured from the fourth camera.
   - `publishThirdScreenTrack`: Publishing the video stream captured from the third screen.
   - `publishFourthScreenTrack`: Publishing the video stream captured from the fourth screen.

   <div class="alert info">For one <code>RtcConnection</code>, Agora supports publishing multiple audio streams and one video stream at the same time.</div>

#### Improvements

1. **Improved camera capture effect** (Android, iOS)

   This release has improved camera capture effect in the following aspects:

   1. Support for camera exposure adjustment

      This release adds `IsCameraExposureSupported` to query whether the device supports exposure adjustment and `SetCameraExposureFactor` to set the exposure ratio of the camera.

   2. Optimization of default camera selection (iOS)

      Since this release, the default camera selection behavior of the SDK is aligned with that of the iOS system camera. If the device has multiple rear cameras, better shooting perspectives, zooming capabilities, low-light performance, and depth sensing can be achieved during video capture, thereby improving the quality of video capture.

2. **Virtual Background Algorithm Upgrade**

   This version has upgraded the portrait segmentation algorithm of the virtual background, which comprehensively improves the accuracy of portrait segmentation, the smoothness of the portrait edge with the virtual background, and the fit of the edge when the person moves. In addition, it optimizes the precision of the person's edge in scenarios such as meetings, offices, homes, and under backlight or weak light conditions.

3. **Channel media relay**

   The number of target channels for media relay has been increased to 6. When calling `StartOrUpdateChannelMediaRelay` and `StartOrUpdateChannelMediaRelayEx`, you can specify up to 6 target channels.

4. **Enhancement in video codec query capability**

   To improve the video codec query capability, this release adds the `codecLevels` member in `CodecCapInfo`. After successfully calling `QueryCodecCapability`, you can obtain the hardware and software decoding capability levels of the device for H.264 and H.265 video formats through `codecLevels`.

This release includes the following additional improvements:

1. To improve the switching experience between multiple audio routes, this release adds the `SetRouteInCommunicationMode` method. This method can switch the audio route from a Bluetooth headphone to the earpiece, wired headphone or speaker in communication volume mode ([`MODE_IN_COMMUNICATION`](https://developer.android.google.cn/reference/kotlin/android/media/AudioManager?hl=en#mode_in_communication)). (Android)
2. The SDK automatically adjusts the frame rate of the sending end based on the screen sharing scenario. Especially in document sharing scenarios, this feature avoids exceeding the expected video bitrate on the sending end to improve transmission efficiency and reduce network burden.
3. To help users understand the reasons for more types of remote video state changes, the `REMOTE_VIDEO_STATE_REASON_CODEC_NOT_SUPPORT` enumeration has been added to the `OnRemoteVideoStateChanged` callback, indicating that the local video decoder does not support decoding the received remote video stream.

#### Issues fixed

This release fixed the following issues:

- Occasionally, noise occurred when the local user listened to their own and remote audio after joining the channel. (macOS)
- Slow channel reconnection after the connection was interrupted due to network reasons.
- In screen sharing scenarios, the delay of seeing the shared screen was occasionally higher than expected on some devices.
- In custom video capturing scenarios, `SetBeautyEffectOptions`, `SetLowlightEnhanceOptions`, `SetVideoDenoiserOptions`, and `SetColorEnhanceOptions` could not load extensions automatically.
- In multi-device audio recording scenarios, after repeatedly plugging and unplugging or enabling/disabling the audio recording device, no sound could be heard occasionally when calling the `StartRecordingDeviceTest` to start an audio capturing device test. (Windows)

#### API changes

**Added**

- `SetCameraExposureFactor` (Android, iOS)
- `IsCameraExposureSupported` (Android, iOS)
- `PreloadChannel[1/2]`
- `PreloadChannel[2/2]`
- `UpdatePreloadChannelToken`
- `SetRouteInCommunicationMode` (Android)
- The following members in `ChannelMediaOptions` (Windows, macOS):
  - `publishThirdCameraTrack`
  - `publishFourthCameraTrack`
  - `publishThirdScreenTrack`
  - `publishFourthScreenTrack`
- `CodecCapLevels`
- `VIDEO_CODEC_CAPABILITY_LEVEL`
- `backgroundColor` in `VideoCanvas`
- `codecLevels` in `CodecCapInfo`
- `REMOTE_VIDEO_STATE_REASON_CODEC_NOT_SUPPORT` in `REMOTE_VIDEO_STATE_REASON`
- `SetMaxMetadataSize`
- `SendMetadata`
- `position` parameter in `RegisterAudioFrameObserver`
- `formatPreference` and `position`  parameters in `RegisterVideoFrameObserver`

**Deleted**

- `GetObservedAudioFramePosition`
- `GetPlaybackAudioParams`
- `GetRecordAudioParams`
- `GetMixedAudioParams`
- `GetEarMonitoringAudioParams`
- `GetVideoFormatPreference`
- `GetObservedFramePosition`
- `GetMaxMetadataSize`
- `OnReadyToSendMetadata`

## v4.2.1

This version was released on June 21, 2023.

#### Improvements

This version improves the network transmission strategy, enhancing the smoothness of audio and video interactions.

#### Fixed Issues

This version fixed the following issues:

- Inability to join channels caused by SDK's incompatibility with some older versions of AccessToken.
- After the sending end called `SetAINSMode` to activate AI noise reduction, occasional echo was observed by the receiving end.
- Brief noise occurred while playing media files using the media player.
- After enabling the screen sharing function on the sending end, there was high delay until the receiving end could see the shared screen. (macOS)
- Occasional crash after calling the `DestroyMediaPlayer` method. (iOS)
- When the sending end mixed and published two streams of video captured by two cameras locally, the video from the second camera was occasionally missing on the receiving end. (Windows)
- In screen sharing scenarios, some Android devices experienced choppy video on the receiving end. (Android)

## v4.2.0

v4.2.0 was released on May xx, 2023.

#### Compatibility changes

If you use the features mentioned in this section, ensure that you modify the implementation of the relevant features after upgrading the SDK.

**1. Video capture (Windows, iOS)**

This release optimizes the APIs for camera and screen capture function. As of v4.2.0, ensure you use the alternative methods listed in the table below and specify the video source by setting the `sourceType` parameter.

| Deleted Methods                                              | Alternative Methods       |
| :----------------------------------------------------------- | :------------------------ |
| <li>`StartPrimaryCameraCapture`（Windows）</li><li>`StartSecondaryCameraCapture`（Windows，iOS）<li> | `StartCameraCapture`      |
| <li>`StopPrimaryCameraCapture`（Windows）</li><li>`StopSecondaryCameraCapture`（Windows，iOS）</li> | `StopCameraCapture`       |
| <li>`StartPrimaryScreenCapture `（Windows）</li>`StartSecondaryScreenCapture`（Windows，iOS）</li> | `StartScreenCapture`[2/2] |
| <li>`StopPrimaryScreenCapture`（Windows）</li><li>`StopSecondaryScreenCapture`（Windows，iOS）</li> | `StopScreenCapture`[2/2]  |

**2. Video rendering**

As of v4.2.0, Agora Unity SDK does not support using `VideoSurface` and `VideoSurfaceYUV` at the same time for video rendering. After one `IRtcEngine` is created, if the first view is rendered through `VideoSurfaceYUV`, all views need to be rendered using `VideoSurfaceYUV` throughout the lifecycle of the `IRtcEngine`.

**3. Video data acquisition**

The `OnCaptureVideoFrame` and `OnPreEncodeVideoFrame` callbacks are added with a new parameter called `sourceType`, which is used to indicate the specific video source type.

**4. Channel media options**

- `PublishCustomAudioTrackEnableAec` in `ChannelMediaOptions` is deleted. Use `PublishCustomAudioTrack` instead.
- `PublishTrancodedVideoTrack` in `ChannelMediaOptions` is renamed to `PublishTranscodedVideoTrack`.
- `PublishCustomAudioSourceId` in `ChannelMediaOptions` is renamed to `PublishCustomAudioTrackId`.


**5. Local video mixing (Windows)**

- The `VideoInputStreams` in `LocalTranscoderConfiguration` is changed to `VideoInputStreams.`
- The `MEDIA_SOURCE_TYPE` in `TranscodingVideoStream` is changed to `VIDEO_SOURCE_TYPE.`

**6. Virtual sound card (macOS)**

As of v4.2.0, Agora supports third-party virtual sound cards. You can use a third-party virtual sound card as the audio input or output device for the SDK. You can use the `stateChanged` callback to see whether the current input or output device selected by the SDK is a virtual sound card.

<div class="alert info">If you set AgoraALD or Soundflower as the default input or output device when joining a channel, you will not hear audio.</div>

**7. Default video encoding resolution**

As of this release, the SDK optimizes the video encoder algorithm and upgrades the default video encoding resolution from 640 × 360 to 960 × 540 to accommodate improvements in device performance and network bandwidth, providing users with a full-link HD experience in various audio and video interaction scenarios.

You can call the `SetVideoEncoderConfiguration` method to set the expected video encoding resolution in the video encoding parameters configuration.

<div class="alert info">In scenarios such as 1-on-1 video calls and video group chats, the increase in the default resolution affects the aggregate resolution and thus the billing rate. For example, before this release, in a 1-on-1 video call scenario, the default aggregate resolution of subscribed video was 460,800 (640 × 360 × 2) and was billed as HD type; as of this release, the default aggregate resolution in the same scenario is 1,036,800 (960 × 540 × 2) and is billed as Full HD type.</div>

**8. Miscellaneous**

- `OnApiCallExecuted` is deleted. Agora recommends getting the results of the API implementation through relevant channels and media callbacks.

  The `IAudioFrameObserver` class is renamed to `IAudioPcmFrameSink`,thus the prototype of the following methods are updated accordingly:

  - `OnFrame`
  - `RegisterAudioFrameObserver` [1/2] and `RegisterAudioFrameObserver`[2/2] in `IMediaPlayer`

- `EnableDualStreamMode`[1/2] and `EnableDualStreamMode`[2/2] are depredated. Use `SetDualStreamMode`[1/2] and `SetDualStreamMode`[2/2] instead.

- `StartChannelMediaRelay`, `UpdateChannelMediaRelay`, `StartChannelMediaRelayEx` and `UpdateChannelMediaRelayEx` are deprecated. Use `StartOrUpdateChannelMediaRelay`And `StartOrUpdateChannelMediaRelayEx` instead.

#### New features

**1. AI noise reduction**

This release introduces the AI noise reduction function. Once enabled, the SDK automatically detects and reduces background noises. Whether in bustling public venues or real-time competitive arenas that demand lightning-fast responsiveness, this function guarantees optimal audio clarity, providing users with an elevated audio experience. You can enable this function through the newly-introduced `SetAINSMode` method and set the noise reduction mode as balance, aggressive or low latency according to your scenarios.

**2. Enhanced Virtual Background**

To increase the fun of real-time video calls and protect user privacy, this version has enhanced the virtual background feature. You can now set custom backgrounds of various types by calling the `EnableVirtualBackground` method, including:

- Process the background as alpha information without replacement, only separating the portrait and the background. This can be combined with the local video mixing feature to achieve a portrait-in-picture effect.
- Replace the background with various formats of local videos.

**3. Video scenario settings**

This release introduces `SetVideoScenario` for setting the video application scene. The SDK will automatically enable the best practice strategy based on different scenes, adjusting key performance indicators to optimize video quality and improve user experience. Whether it is a formal business meeting or a casual online gathering, this feature ensures that the video quality meets the requirements.

Currently, this feature provides targeted optimizations for real-time video conferencing scenarios, including:

- Automatically activate multiple anti-weak network technologies to enhance the capability and performance of low-quality video streams in meeting scenarios where high bitrates are required, ensuring smoothness when multiple streams are subscribed by the receiving end.
- Monitor the number of subscribers for the high-quality and low-quality video streams in real time, dynamically adjusting the configuration of the high-quality stream and dynamically enabling or disabling the low-quality stream, to save uplink bandwidth and consumption.

**4. Local video mixing**

On Windows, this release adds the `OnLocalVideoTranscoderError` callback. When there is an error in starting or updating the local video mixing, the SDK triggers this callback to report the reason for the failure.

On Android, iOS, and macOS, this release adds the local video mixing feature. You can use the `StartLocalVideoTranscoder` method to mix and render multiple video streams locally, such as camera-captured video, screen sharing streams, video files, images, etc. This allows you to achieve custom layouts and effects, making it easy to create personalized video display effects to meet various scenario requirements, such as remote meetings, live streaming, online education, while also supporting features like portrait-in-picture effect.

Additionally, the SDK provides the `UpdateLocalTranscoderConfiguration` method and the `OnLocalVideoTranscoderError` callback. After enabling local video mixing, you can use the `UpdateLocalTranscoderConfiguration` method to update the video mixing configuration. Where an error occurs in starting the local video mixing or updating the configuration, you can get the reason for the failure through the `OnLocalVideoTranscoderError` callback.

<div class="alert info">Local video mixing requires more CPU resources. Therefore, Agora recommends enabling this function on devices with higher performance.</div>


**5. Cross-device synchronization**

In real-time collaborative singing scenarios, network issues can cause inconsistencies in the downlinks of different client devices. To address this, this release introduces `GetNtpWallTimeInMs`For obtaining the current Network Time Protocol (NTP) time. By using this method to synchronize lyrics and music across multiple client devices, users can achieve synchronized singing and lyricsprogression, resulting in a better collaborative experience.

**6. Instant frame rendering**

This release adds the `EnableInstantMediaRendering` method to enable instant rendering mode for audio and video frames, which can speed up the first video or audio frame rendering after the user joins the channel.

**7. Video rendering tracing**

This release adds the `StartMediaRenderingTracing` and `StartMediaRenderingTracingEx` methods. The SDK starts tracing the rendering status of the video frames in the channel from the moment this method is called and reports information about the event through the `OnVideoRenderingTracingResult` callback.

Agora recommends that you use this method in conjunction with the UI settings (such as buttons and sliders) in your app. For example, call this method at the moment when the user clicks the "Join Channel" button, and then get the indicators in the video frame rendering process through the `OnVideoRenderingTracingResult` callback. This enables developers to facilitate developers to optimize the indicators to improve the user experience.


#### Improvements

**1. Voice changer**

This release introduces the `SetLocalVoiceFormant` method that allows you to adjust the formant ratio to change the timbre of the voice. This method can be used together with the `SetLocalVoicePitch` method to adjust the pitch and timbre of voice at the same time, enabling a wider range of voice transformation effects.


**2. Enhanced screen share (Android, iOS)**

This release adds the `QueryScreenCaptureCapability` method, which is used to query the screen capture capabilities of the current device. To ensure optimal screen sharing performance, particularly in enabling high frame rates like 60 fps, Agora recommends you to query the device's maximum supported frame rate using this method beforehand.

This release also adds the `SetScreenCaptureScenario` method, which is used to set the scenario type for screen sharing. The SDK automatically adjusts the smoothness and clarity of the shared screen based on the scenario type you set.


 **3. Improved compatibility with audio file types (Android)**

As of v4.2.0, you can use the following methods to open files with a URI starting with `Content://` : `StartAudioMixing` [2/2], `PlayEffect` [3/3], `Open`, and `OpenWithMediaSource`.


 **4. Enhanced rendering compatibility (Windows)**

This release enhances the rendering compatibility of the SDK. Issues like black screens caused by rendering failures on certain devices are fixed.

**5. Audio and video synchronization**

For custom video and audio capture scenarios, this release introduces `GetCurrentMonotonicTimeInMs` for obtaining the current Monotonic Time. By passing this value into the timestamps of audio and video frames, developers can accurately control the timing of their audio and video streams, ensuring proper synchronization.


**6. Multi-camera capture and multi-screen capture**

This release introduces `StartScreenCapture` [2/2] (PC only) and `StartCameraCapture`. By calling these methods multiple times and specifying the `sourceType` parameter, developers can start capturing video streams from multiple cameras and screens for local video mixing or multi-channel publishing. This is particularly useful for scenarios such as remote medical care and online education, where multiple cameras and displays need to be connected.

**7. Channel media relay**

This release introduces `StartOrUpdateChannelMediaRelay` and `StartOrUpdateChannelMediaRelayEx`, allowing for a simpler and smoother way to start and update media relay across channels. With these methods, developers can easily start the media relay across channels and update the target channels for media relay with a single method. Additionally, the internal interaction frequency has been optimized, effectively reducing latency in function calls.

**8. Custom audio tracks**

To better meet the needs of custom audio capture scenarios, this release adds `CreateCustomAudioTrack` and `DestroyCustomAudioTrack` for creating and destroying custom audio tracks. Two types of audio tracks are also provided for users to choose from, further improving the flexibility of capturing external audio source:

- Mixable audio track: Supports mixing multiple external audio sources and publishing them to the same channel, suitable for multi-channel audio capture scenarios.
- Direct audio track: Only supports publishing one external audio source to a single channel, suitable for low-latency audio capture scenarios.

**9. Super resolution (Android, iOS)**

This release improves the performance of super resolution. To optimize the usability of super resolution, this release removes `EnableRemoteSuperResolution`; super resolution no longer needs to be enabled manually. The SDK now automatically optimizes the resolution of the remote video based on the performance of the user's device.

#### Issues fixed

This release fixed the following issues:

**Windows**

- When using Agora Media Player to play RTSP video streams, the video images sometimes appeared pixelated.
- Adding an alpha channel to an image in PNG or GIF format failed when the local client mixed video streams.
- After joining the channel, remote users saw a watermark even though the watermark was deleted.
- If a watermark was added after starting screen sharing, the watermark did not display the screen.
- When joining a channel and accessing an external camera, calling `SetDevice` to specify the video capture device as the external camera did not take effect.
- When trying to outline the shared window and put it on top, the shared window did not stay on top of other windows.

**Android**

- Occasional crashes occur on Android devices when users joining or leaving a channel.
- Occational failure when enabling in-ear monitoring.
- Occational echo.
- Crashes occurred after users set the video resolution as 3840 × 2160 and started CDN streaming on Xiaomi Redmi 9A devices.
- In real-time chorus scenarios, remote users heard noises and echoes when an OPPO R11 device joined the channel in loudspeaker mode.
- When the playback of the local music finished, the `OnAudioMixingFinished` callback was not properly triggered.
- When using a video frame observer, the first video frame was occasionally missed on the receiver's end.
- When sharing screens in scenarios involving multiple channels, remote users occasionally saw black screens.
- Switching to the rear camera with the virtual background enabled occasionally caused the background to be inverted.
- Abnormal client status caused by an exception in the `OnRemoteAudioStateChanged` callback.

**iOS**

- Occasional loss of the `OnFirstRemoteVideoFrame` callback during channel media relay.
- The receiver actively subscribed to the high-quality stream but unexpectedly received a low-quality stream.
- Abnormal client status cased by an exception in the `OnRemoteAudioStateChanged` callback.

**macOS**

- The receiver was receiving the low-quality stream originally, and automatically switched to high-quality stream after a few seconds.
- Occasional screen jittering during screen sharing.
- The receiver was receiving the low-quality stream originally, and automatically switched to high-quality stream after a few seconds.
- Occasional screen jittering during screen sharing.
- If the rendering view of the player was set as a UIViewController's view, the video was zoomed from the bottom-left corner to the middle of the screen when entering full-screen mode.
- When joining a channel and accessing an external camera, calling `SetDevice` to specify the video capture device as the external camera did not take effect.

**All platforms**

- When the host frequently switching the user role between broadcaster and audience in a short period of time, the audience members cannot hear the audio of the host.
- Playing audio files with a sample rate of 48 kHz failed.
- When there were multiple video streams in a channel, calling some video enhancement APIs occasionally failed.

#### API changes

**Added**

- `StartCameraCapture`
- `StopCameraCapture`
- `StartScreenCapture`[2/2]  (Windows,macOS)
- `StopScreenCapture`[2/2]  (Windows,macOS)
- `StartOrUpdateChannelMediaRelay`
- `StartOrUpdateChannelMediaRelayEx`
- `GetNtpWallTimeInMs`
- `SetVideoScenario`
- `GetCurrentMonotonicTimeInMs`
- `OnLocalVideoTranscoderError`
- `startLocalVideoTranscoder`（macOS, iOS, Android）
- `updateLocalTranscoderConfiguration`（macOS, iOS, Android）
- `QueryScreenCaptureCapability`  (iOS, Android)
- `SetScreenCaptureScenario`  (iOS, Android)
- `CreateAudioCustomTrack`
- `DestroyAudioCustomTrack`
- `AudioTrackConfig`
- `AUDIO_TRACK_TYPE`
- `VIDEO_APPLICATION_SCENARIO_TYPE`
- `SCREEN_CAPTURE_FRAMERATE_CAPABILITY`
- The `domainLimit` and `autoRegisterAgoraExtensions` members in `RtcEngineContext`
- The `sourceType` parameter in `OnCaptureVideoFrame` and `OnPreEncodeVideoFrame` callbacks
- The `BACKGROUND_NONE` and `BACKGROUND_VIDEO` enumerators in `BACKGROUND_SOURCE_TYPE`
- `EnableInstantMediaRendering`
- `StartMediaRenderingTracing`
- `StartMediaRenderingTracingEx`
- `OnVideoRenderingTracingResult`
- `MEDIA_TRACE_EVENT`
- `VideoRenderingTracingInfo`

**Deprecated**

- `EnableDualStreamMode`[1/2]
- `EnableDualStreamMode`[2/2]
- `StartChannelMediaRelay`
- `StartChannelMediaRelayEx`
- `UpdateChannelMediaRelay`
- `UpdateChannelMediaRelayEx`
- `OnChannelMediaRelayEvent`
- `CHANNEL_MEDIA_RELAY_EVENT`

**Deleted**

- `StartPrimaryScreenCapture`  (Windows)
- `StartSecondaryScreenCapture`  (Windows)
- `StopPrimaryScreenCapture ` (Windows)
- `StopSecondaryScreenCapture ` (Windows)
- `StartPrimaryCameraCapture`  (Windows)
- `StartSecondaryCameraCapture` (Windows/iOS)
- `StopPrimaryCameraCapture`  (Windows)
- `StopSecondaryCameraCapture ` (Windows/iOS)
- `OnApiCallExecuted`
- `PublishCustomAudioTrackEnableAec ` in` ChannelMediaOptions`
- `EnableRemoteSuperResolution`
- `superResolutionType` in `RemoteVideoStats`