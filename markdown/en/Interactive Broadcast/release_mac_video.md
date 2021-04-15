---
title: Release Notes
platform: macOS
updatedAt: 2021-03-29 03:52:48
---
This page provides the release notes for the Agora Video SDK for macOS.

## Known issues and limitations

**USB device driver issue**

A USB device driver issue occurs when you do not hear any audio or the audio is corrupted with a USB headset. USB is not user-friendly on macOS, and we recommend using higher quality headsets.

**Rosetta translation issue**

If your app is integrated with the SDK earlier than v3.3.0, the app can only run under Rosetta translation on Mac devices with the M1 chip, which causes a memory leak when a user frequently joins and leaves a channel.

To avoid this issue, upgrade the SDK to v3.3.0 or later and adapt the app to x86-64 and arm64 architectures.

## v3.3.0

v3.3.0 was released on January 22, 2021.

#### Compatibility changes

**1. Integration change**

This release adds the following frameworks:

- `AgoraCore.framework`: The Agora basic calculation framework. 
- `av1.framework`: The AV1 framework for screen sharing.

To integrate the SDK into your project, see [Integrate the SDK](./start_live_mac?platform=macOS#integrate_sdk).

**2. Behavior change**

This release deprecates `setDefaultMuteAllRemoteAudioStreams` and `setDefaultMuteAllRemoteVideoStreams `and changes the behavior of `mute`-related methods as follows:

- `mute`-related methods must be called after joining or switching to a channel; otherwise, the method call does not take effect.
- Methods with the prefix `muteAll` are no longer the master switch, and each `mute`-related method independently controls the user's subscribing state. When you call methods with the prefixes `muteAll` and `muteRemote` together, the method that is called later takes effect.
- Methods with the prefix `muteAll` set whether to subscribe to the audio or video streams of all remote users, including all subsequent users, which means methods with the prefix `muteAll` contain the function of methods with the prefix `setDefaultMute`. Agora recommends not calling methods with the prefixes `muteAll` and `setDefaultMute` together; otherwise, the setting may not take effect.

See details in [Set the Subscribing State](./set_subscribing_state?platform=macOS).

#### New features

**1. Native support for the M1 chip**

This release adds native support for the M1 chip, which means the Agora SDK supports both x86-64 and arm64 architectures. As of v3.3.0, apps that integrate the Agora SDK can natively run on Mac devices with the M1 chip, and you no longer need to set the Rosetta translation.

**2. Channel media options**

To help developers control media subscription more flexibly, this release adds the `joinChannelByToken`2 and `switchChannelByToken`2 methods to set whether users subscribe to all remote audio or video streams in a channel when joining and switching channels.

**3. Cloud proxy**

To improve the usability of the Agora Cloud Proxy, this release adds the `setCloudProxy` method to set the cloud proxy and allows you to select a cloud proxy that uses the UDP protocol. For details, see [Cloud Proxy](./cloudproxy_native?platform=macOS).

**4. Deep-learning noise reduction**

To eliminate non-stationary noise based on traditional noise reduction, this release adds `enableDeepLearningDenoise` to enable deep-learning noise reduction.

Before enabling deep-learning noise reduction, integrate the `AgoraAIDenoiseExtension.framework` dynamic library into your project files.

**5. Singing beautifier**

To beautify the voice and add reverberation effects in a singing scenario, this release adds the `setVoiceBeautifierParameters` method and adds the `AgoraSingingBeautifier` constant to `AgoraVoiceBeautifierPreset`. 

You can call `setVoiceBeautifierPreset(AgoraSingingBeautifier)` to beautify the male voice and add the reverberation effect for a voice in a small room. For more settings, you can call `setVoiceBeautifierParameters(AgoraSingingBeautifier, param1, param2)` to beautify male or female voices and add reverberation effects for a voice in a small room, large room, or hall. 

**6. Log files**

To ensure the integrity of log content, this release adds the `logConfig` property to `AgoraRtcEngineConfig`. You can use `logConfig` to set the log files output by the Agora SDK when you initialize `AgoraRtcEngineKit`. See [How can I set the log file?](https://docs.agora.io/en/Interactive%20Broadcast/faq/logfile) for details.

As of v3.3.0, Agora does not recommend using the `setLogFile`, `setLogFileSize`, or `setLogFilter` methods to set the log files.

**7. Quality of captured video**

To control the quality of video captured by the local camera, this release adds support for customizing the capture resolution and listening for abnormalities.

- Customize the capture resolution: Call the `setCameraCapturerConfiguration` method to set the capture preference to `AgoraCameraCaptureOutputPreferenceManual(3)` and set the width and height of the captured video image.
- Listen for abnormalities:
  - The abnormal brightness level of captured video images: Use `captureBrightnessLevel` in the `localVideoStats` callback.
  - The camera fails to output the captured video: Use the `localVideoStateChange(AgoraLocalVideoStreamStateFailed, AgoraLocalVideoStreamErrorCaptureFailure)` callback.
  - The camera repeatedly outputs the captured video: Use the `localVideoStateChange(AgoraLocalVideoStreamStateCapturing, AgoraLocalVideoStreamErrorCaptureFailure)` callback.

**8. Data streams**

To support scenarios such as lyrics synchronization and courseware synchronization, this release deprecates the previous `createDataStream` method and replaces it with a new method of the same name. You can use this new method to create a data stream and set whether to synchronize the data stream with the audio stream sent to the Agora channel and whether the received data is ordered.

#### Improvements

**1. Raw audio data**

This release adds raw audio data APIs for the macOS platform. Once you obtain raw audio data through the following APIs, you can pre-process or post-process it for desired playback effects:

- `setAudioFrameDelegate`
- `onRecordAudioFrame`
- `onPlaybackAudioFrame`
- `onMixedAudioFrame`
- `onPlaybackAudioFrameBeforeMixing`

**2. Remote audio statistics**

To monitor quality of experience (QoE) of the local user when receiving a remote audio stream, this release adds `qoeQuality` and `qualityChangedReason` to `AgoraRtcRemoteAudioStats`, which report QoE of the local user and the reason for poor QoE, respectively.

#### API changes

**Added**

- [`setVoiceBeautifierParameters`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVoiceBeautifierParameters:param1:param2:)
- `AgoraSingingBeautifier` in the [`AgoraVoiceBeautifierPreset`](./API%20Reference/oc/Constants/AgoraVoiceBeautifierPreset.html) constant
- [`enableDeepLearningDenoise`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableDeepLearningDenoise:)
- [`joinChannelByToken`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:options:)2
- [`switchChannelByToken`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/switchChannelByToken:channelId:options:)2
- [`createDataStream`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/createDataStream:config:)
- The `logConfig` property in the [`AgoraRtcEngineConfig`](./API%20Reference/oc/Classes/AgoraRtcEngineConfig.html) class
- [`setAudioFrameDelegate`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setAudioFrameDelegate:)
- [`onRecordAudioFrame`](./API%20Reference/oc/Protocols/AgoraAudioFrameDelegate.html#//api/name/onRecordAudioFrame:)
- [`onPlaybackAudioFrame`](./API%20Reference/oc/Protocols/AgoraAudioFrameDelegate.html#//api/name/onPlaybackAudioFrame:)
- [`onMixedAudioFrame`](./API%20Reference/oc/Protocols/AgoraAudioFrameDelegate.html#//api/name/onMixedAudioFrame:)
- [`onPlaybackAudioFrameBeforeMixing`](./API%20Reference/oc/Protocols/AgoraAudioFrameDelegate.html#//api/name/onPlaybackAudioFrameBeforeMixing:uid:)
- The `qoeQuality` and `qualityChangedReason` properties in the [`AgoraRtcRemoteAudioStats`](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) class
- [`setCloudProxy`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setCloudProxy:)
- The `captureBrightnessLevel` property in the [`AgoraRtcLocalVideoStats`](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html) class
- The `captureWidth` and `captureHeight` properties in the [`AgoraCameraCapturerConfiguration`](./API%20Reference/oc/Classes/AgoraCameraCapturerConfiguration.html) class
- `AgoraCameraCaptureOutputPreferenceManual(3)` in the [`AgoraCameraCaptureOutputPreference`](./API%20Reference/oc/Constants/AgoraCameraCaptureOutputPreference.html) constant
- Error code: [`AgoraErrorCodeModuleNotFound(157)`](./API%20Reference/oc/Constants/AgoraErrorCode.html)

**Deprecated**

- `setDefaultMuteAllRemoteVideoStreams`
- `setDefaultMuteAllRemoteAudioStreams`
- `setLogFile`
- `setLogFileSize`
- `setLogFilter`
- `createDataStream`

## v3.2.1

v3.2.1 was released on December 17, 2020. This release fixed the following issues:

- Crashes occurred when using IPv6.
- After you called `enableEncryption`, the SDK did not trigger the `firstLocalVideoFramePublished` callback.

## v3.2.0

v3.2.0 was released on November 30, 2020.

#### Compatibility changes
**1. Integration change**

Since v3.2.0, the following files have been added to the SDK package:

- `Agorafdkaac.framework`: The Fraunhofer FDK AAC dynamic library.
- `AgoraSoundTouch.framework`: The SoundTouch dynamic library.
- `Agoraffmpeg.framework`: The FFmpeg dynamic library.

If you upgrade the SDK to v3.2.0 or later, refer to the following steps to add the above dynamic libraries when integrating the SDK:

1. Copy the above files to the folder where the `AgoraRtcKit.framework` file is located.
2. Open **Xcode**, go to **TARGETS > Project Name > General > Frameworks, Libraries, and Embedded Content** menu, click **+**, then click **Add Other…** to add `Agorafdkaac.framework`, `AgoraSoundTouch.framework`, and `Agoraffmpeg.framework`. Ensure the status of these dynamic libraries is **Embed & Sign**.

**2. Cloud proxy**
This release optimizes the Agora cloud proxy architecture. If you are already using cloud proxy, to avoid compatibility issues between the new SDK and the old cloud proxy, please contact support@agora.io before upgrading the SDK. See [Cloud Proxy](./cloudproxy_native?platform=macOS).

**3. Security and compliance**

Agora has passed ISO 27001, ISO 27017, and ISO 27018 international certifications, providing safe and reliable real-time interactive cloud services for users worldwide. See [ISO Certificates](https://docs.agora.io/en/Agora%20Platform/iso_cert?platform=All%20Platforms).

This release supports transport layer encryption by adding TLS (Transport Layer Security) and UDP (User Datagram Protocol) encryption methods.

<div class="alert note">Transport layer encryption affects the following indicators:
<li>Size of the SDK package: For details, see <I>Product Overview</I>.</li>
<li>The rendering time of the first video frame: The rendering time (median) of the first video frame increases by 0 ~ 70 ms compared to that in v3.1.0.</li></div>

#### New features

**1. Image enhancement**

To enable image enhancement in scenarios such as video social networking, an online class, or live interactive streaming, this release adds `setBeautyEffectOptions`. You can call this method to set parameters including contrast, brightness, smoothness, and red saturation.

**2. Interactive Live Streaming Standard**

This release adds `setClientRole` for setting the latency level of an audience member. You can use this method to switch between Interactive Live Streaming Premium and Interactive Live Streaming Standard as follows:

- Set the latency level as ultra low latency to use Interactive Live Streaming Premium.
- Set the latency level as low latency to use Interactive Live Streaming Standard.

For details, see the [product overview](https://docs.agora.io/en/live-streaming/product_live_standard?platform=macOS) of Interactive Live Streaming Standard. 

#### Improvements

**1. Meeting scenario**

To improve the user experience in the meeting scenario, this release adds the following:

- Audio profile: To improve the audio experience for multi-person meetings, this release adds `AgoraAudioScenarioMeeting(8)` in `setAudioProfile`.
- Screen sharing: 
  - To allow a user to enable shared slides in presentation mode, this release adds support for enabling the shared window (such as slides, web video, or web document) in full-screen mode during the window sharing.
  - This release adds the `AgoraLocalVideoStreamErrorScreenCaptureWindowClosed(12)` error code, notifying you that a window shared by the window ID has been closed, or a full-screen window shared by the window ID has exited full-screen mode.
  - This release optimizes smoothness and image quality of screen sharing with the `AgoraVideoContentHintDetails` type in a poor network environment.

**2. Voice beautifier and audio effects**

To improve the usability of the APIs related to voice beautifier and audio effects, this release deprecates `setLocalVoiceChanger` and `setLocalVoiceReverbPreset`, and adds the following methods instead:

- `setVoiceBeautifierPreset`: Compared with `setLocalVoiceChanger`, this method deletes audio effects such as a little boy’s voice and a more spatially resonant voice.
- `setAudioEffectPreset`: Compared with `setLocalVoiceReverbPreset`, this method adds audio effects such as the 3D voice, the pitch correction, a little boy’s voice and a more spatially resonant voice.
- `setAudioEffectParameters`: This method sets detailed parameters for a specified audio effect. In this release, the supported audio effects are the 3D voice and pitch correction.

**3. Interactive streaming delay**

This release reduces the latency on the audience's client during an interactive live streaming by about 500 ms.

#### Issues fixed

This release fixed the following issues:

- Users could not hear the audio when calling with AirPods.
- When other video apps were running, the SDK could not turn on the local camera.
- When calling `enumerateDevices`, the SDK unnecessarily requested permission to use the microphone.

#### API changes

**Added**

- [`setClientRole`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setClientRole:options:)
- [`setBeautyEffectOptions`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setBeautyEffectOptions:options:)
- [`setAudioEffectPreset`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setAudioEffectPreset:)
- [`setVoiceBeautifierPreset`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVoiceBeautifierPreset:)
- [`setAudioEffectParameters`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setAudioEffectParameters:param1:param2:)
- `AgoraAudioScenarioMeeting(8)` in [`AgoraAudioScenario`](./API%20Reference/oc/Constants/AgoraAudioScenario.html)
- `AgoraLocalVideoStreamErrorScreenCaptureWindowClosed(12)` in [`AgoraLocalVideoStreamError`](./API%20Reference/oc/Constants/AgoraLocalVideoStreamError.html) enum

**Deprecated**

- `setLocalVoiceChanger`
- `setLocalVoiceReverbPreset`

## v3.1.2

v3.1.2 was released on September 15, 2020. 

This release fixed the issue that the [`firstLocalVideoFrameWithSize`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:firstLocalVideoFrameWithSize:elapsed:) and [`firstRemoteVideoFrameOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:firstRemoteVideoFrameOfUid:size:elapsed:) callbacks are not triggered at the right time.

## v3.1.1

v3.1.1 was released on August 27, 2020.

#### Compatibility changes

This release changes the `AgoraAreaCode` for regional connection. The latest area codes are as follows:

- `AgoraAreaCodeCN`: Mainland China.
- `AgoraAreaCodeNA`: North America.
- `AgoraAreaCodeEU`: Europe.
- `AgoraAreaCodeAS`: Asia, excluding Mainland China.
- `AgoraAreaCodeJP`: Japan.
- `AgoraAreaCodeIN`: India.
- `AgoraAreaCodeGLOB`: (Default) Global.

If you have specified a region for connection when calling [`sharedEngineWithConfig`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/sharedEngineWithConfig:delegate:), ensure that you use the latest area code when migrating from an earlier SDK version.

## v3.1.0

v3.1.0 was released on August 11, 2020.

#### New features

**1. Publishing and subscription states**

This release adds the following callbacks to report the current publishing and subscribing states:

- `didAudioPublishStateChange`: Reports the change of the audio publishing state.
- `didVideoPublishStateChange`: Reports the change of the video publishing state.
- `didAudioSubscribeStateChange`: Reports the change of the audio subscribing state.
- `didVideoSubscribeStateChange`: Reports the change of the video subscribing state.

**2. First local frame published callback**

This release adds the `firstLocalAudioFramePublished` and `firstLocalVideoFramePublished` callbacks to report that the first audio or video frame is published. The `firstLocalAudioFrame` callback is deprecated from v3.1.0.

**3. Custom data report**

This release adds the `sendCustomReportMessage` method for reporting customized messages. To try out this function, contact [support@agora.io](mailto:support@agora.io) and discuss the format of customized messages with us.

#### Improvement

**1. Regional connection**

This release adds the following regions for regional connection. After you specify the region for connection, your app that integrates the Agora SDK connects to the Agora servers within that region.

- `AgoraIpAreaCode_JAPAN`: Japan.
- `AgoraIpAreaCode_INDIA`: India.

**2. Advanced screen sharing**

This release adds the following features for screen sharing:

- Bringing the window to the front: By adding the `windowFocus` member to the `AgoraScreenCaptureParameters` class.
- Excluding specified windows from screen sharing: By adding the `excludeWindowList` member to the `AgoraScreenCaptureParameters` class.
- Reporting more specific local video states during a screen share: By adding the state code `AgoraLocalVideoStreamStateCapturing(1)` and the error code `AgoraLocalVideoStreamErrorScreenCaptureWindowMinimized(11)` to the `localVideoStateChange` callback.
- Getting the capture type of the custom video source: By adding the `captureType` callback to the `AgoraVideoSourceProtocol` protocol.
- Getting the content hint of the custom video source: By adding the `contentHint` callback to the `AgoraVideoSourceProtocol` protocol.

**3. CDN live streaming**

This release adds the `rtmpStreamingEventWithUrl` callback to report events during CDN live streaming, such as failure to add a background image or watermark image.

**4. Encryption**

This release adds the `enableEncryption` method for enabling built-in encryption, and deprecates the following methods:

- `setEncryptionSecret`
- `setEncryptionMode`

**5. More in-call statistics**

This release adds the following attributes to provide more in-call statistics:

- Adds `txPacketLossRate` in `AgoraRtcLocalAudioStats`, which represents the audio packet loss rate (%) from the local client to the Agora edge server before applying anti-packet loss strategies.
- Adds the following attributes in `AgoraRtcLocalVideoStats`: 
  - `txPacketLossRate`: The video packet loss rate (%) from the local client to the Agora edge server before applying anti-packet loss strategies.
  - `captureFrameRate`: The capture frame rate (fps) of the local video.
- Adds `publishDuration` in `AgoraRtcRemoteAudioStats` and `AgoraRtcRemoteVideoStats`, which represents the total publish duration (ms) of the remote media stream.

**6. Audio profile**

To improve audio performance, this release adjusts the maximum audio bitrate of each audio profile as follows:

| Profile                                   | v3.1.0                                                       | Earlier than v3.1.0                                          |
| :---------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| `AgoraAudioProfileDefault`                   | <li>For the interactive streaming profile: 64 Kbps</li><li>For the communication profile: 18 Kbps</li> | <li>For the interactive streaming profile: 52 Kbps</li><li>For the communication profile: 18 Kbps</li> |
| `AgoraAudioProfileSpeechStandard`           | 18 Kbps                                                      | 18 Kbps                                                      |
| `AgoraAudioProfileMusicStandard`            | 64 Kbps                                                      | 48 Kbps                                                      |
| `AgoraAudioProfileMusicStandardStereo`     | 80 Kbps                                                      | 56 Kbps                                                      |
| `AgoraAudioProfileMusicHighQuality`        | 96 Kbps                                                      | 128 Kbps                                                     |
| `AgoraAudioProfileMusicHighQualityStereo` | 128 Kbps                                                     | 192 Kbps                                                     |

**7. Log files**

This release increases the default number of log files that the Agora SDK outputs from 2 to 5, and increases the default size of each log file from 512 KB to 1024 KB. By default, the SDK outputs five log files, `agorasdk.log`, `agorasdk_1.log`, `agorasdk_2.log`, `agorasdk_3.log`, `agorasdk_4.log`. The SDK writes the latest logs in `agorasdk.log`. When `agorasdk.log` is full, the SDK deletes the log file with the earliest modification time among the other four, renames `agorasdk.log` to the name of the deleted log file, and create a new `agorasdk.log` to record the latest logs.

**8. Audio route**

To play audio on more devices, this release adds four enumerators in `AgoraAudioOutputRouting`, and supports USB, HDMI, DisplayPort peripherals, and Apple AirPlay.

**9. Video experience under poor network conditions**

- Starting with this release, the SDK automatically reduces video resolution under poor network conditions in order to improve the smoothness of the video.
- This release improves video quality by ensuring that the video does not become blurry due to changing network conditions.

#### Issues fixed

This release fixed the issue that the app failed to record any audio because the audio device module failed to start.

#### API changes

**Added**

- [`didAudioPublishStateChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didAudioPublishStateChange:oldState:newState:elapseSinceLastState:)
- [`didVideoPublishStateChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didVideoPublishStateChange:oldState:newState:elapseSinceLastState:)
- [`didAudioSubscribeStateChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didAudioSubscribeStateChange:withUid:oldState:newState:elapseSinceLastState:)
- [`didVideoSubscribeStateChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didVideoSubscribeStateChange:withUid:oldState:newState:elapseSinceLastState:)
- [`firstLocalAudioFramePublished`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:firstLocalAudioFramePublished:)
- [`firstLocalVideoFramePublished`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:firstLocalVideoFramePublished:)
- [`enableEncryption`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableEncryption:encryptionConfig:)
- `txPacketLossRate` in [`AgoraRtcLocalAudioStats`](./API%20Reference/oc/Classes/AgoraRtcLocalAudioStats.html) class
- `txPacketLossRate` and `captureFrameRate` in [`AgoraRtcLocalVideoStats`](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html) class
- `publishDuration` in [`AgoraRtcRemoteAudioStats`](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) and [`AgoraRtcRemoteVideoStats`](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html) class
- `windowFocus` and `excludeWindowList` in [`AgoraScreenCaptureParameters`](./API%20Reference/oc/Classes/AgoraScreenCaptureParameters.html) class
- `AgoraLocalVideoStreamStateCapturing(1)` in [`AgoraLocalVideoStreamState`](./API%20Reference/oc/Constants/AgoraLocalVideoStreamState.html) class
- `AgoraLocalVideoStreamErrorScreenCaptureWindowMinimized(11)` in [`AgoraLocalVideoStreamError`](./API%20Reference/oc/Constants/AgoraLocalVideoStreamError.html) class
- `captureType` and `contentHint` in [`AgoraVideoSourceProtocol`](./API%20Reference/oc/Protocols/AgoraVideoSourceProtocol.html) protocol
- [`rtmpStreamingEventWithUrl`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:rtmpStreamingEventWithUrl:eventCode:)
- Warning code: `AgoraWarningCodeAdmCategoryNotPlayAndRecord(1029)` and `AgoraWarningCodeApmResidualEcho(1053)`
- Error code: `AgoraErrorCodeNoServerResources(103)`

**Deprecated**

- `setEncryptionSecret`
- `setEncryptionMode`
- `firstLocalAudioFrame`

**Deleted**

- Warning code: `AgoraWarningCodeAdmImproperSettings(1053)`

## v3.0.1.1

v3.0.1.1 was released on Jun 18, 2020. This release fixed the crashes after calling `registerVideoRenderFactory` (deprecated).

## v3.0.1

v3.0.1 was released on May 27, 2020.

#### Compatibility changes

**1. Dynamic library**

This release replaces the static library with a dynamic library for the following reasons:

- Improving overall security.
- Avoiding incompatibility issues with other third-party libraries.
- Making it easier to upload the app to the App Store.

To upgrade the RTC Native SDK, you must re-integrate the dynamic library, `AgoraRtcKit.framework`. This process should take no more than five minutes. See [Migration Guide](migration_apple).

**2. Frame position for the video observer (C++)**

As of this release, to get the video frame from the `onPreEncodeVideoFrame` callback, you must set `POSITION_PRE_ENCODER(1<<2)` in [`getObservedFramePosition`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#ad4c174389264630ffb1b2d24c6030013) as the frame position to observe, as well as implementing the `onPreEncodeVideoFrame` callback.

#### New features

**1. Audio mixing pitch**

To set the pitch of the local music file during audio mixing, this release adds `setAudioMixingPitch`. You can set the `pitch` parameter to increase or decrease the pitch of the music file. This method sets the pitch of the local music file only. It does not affect the pitch of a human voice.

**2. Voice enhancement**

To improve the audio quality, this release adds the following enumerate elements in `setLocalVoiceChanger` and `setLocalVoiceReverbPreset`:

- `AgoraAudioVoiceChanger` adds several elements that have the prefixes `AgoraAudioVoiceBeauty` and `AgoraAudioGeneralBeautyVoice`. The `AgoraAudioVoiceBeauty` elements enhance the local voice, and the `AgoraAudioGeneralBeautyVoice` enumerations add gender-based enhancement effects.
- `AgoraAudioReverbPreset` adds the enumeration `AgoraAudioReverbPresetVirtualStereo` and several enumerations that have the prefix `AgoraAudioReverbPresetFx`. The `AgoraAudioReverbPresetVirtualStereo` enumeration implements reverberation in the virtual stereo, and the `AgoraAudioReverbPresetFx` enumerations implement additional enhanced reverberation effects.

See [Set the Voice Changer and Reverberation Effects](voice_changer_apple) for more information.

**3. Face detection**

This release enables local face detection. After you call `enableFaceDetection` to enable this function, the SDK triggers the `facePositionDidChangeWidth` callback in real time to report the detection results, including the distance between the human face and the device screen. This function can remind users to keep a certain distance from the screen.

**4. Fill mode**

To improve the user experience of watching videos, this release adds a video display mode `AgoraVideoRenderModeFill(4)`. This mode zooms and stretches the video to fill the display window. You can select this mode when calling the following methods:

- `setupLocalVideo`
- `setupRemoteVideo`
- `setLocalRenderMode`
- `setRemoteRenderMode`

**5. Remote video renderer in multiple channels**

This release adds `setRemoteVideoRenderer` and `remoteVideoRendererOfUserId` in the `AgoraRtcChannel` class to enable users who join the channel using the `AgoraRtcChannel` object to customize the remote video renderer.

**6. Data post-processing in multiple channels (C++)**

This release adds support for post-processing remote audio and video data in a multi-channel scenario by adding the following C++ methods:

- The `IAudioFrameObserver` class:  [`isMultipleChannelFrameWanted`](./API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#a4b6bdf2a975588cd49c2da2b6eff5956) and [`onPlaybackAudioFrameBeforeMixingEx`](./API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#ab0cf02ba307e91086df04cda4355905b).
- The `IVideoFrameObserver` class: [`isMultipleChannelFrameWanted`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#aa6bf2611907a097ec359b83f1e3ba49a) and [`onRenderVideoFrameEx`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#ad325db8ee3a04e667e6db3d1a84f381d).

After successfully registering the audio or video observer, if you set the return value of `isMultipleChannelFrameWanted` as `true`, you can get the corresponding audio or video data from `onPlaybackAudioFrameBeforeMixingEx` or `onRenderVideoFrameEx`. In a multi-channel scenario, Agora recommends setting the return value as `true`.

#### Improvements

**Frame position (C++)**

After successfully registering the video observer, you can observe and get the video frame at each node of video processing. To conserve power consumption, this release enables customizing the frame position for the video observer. Set the return value of the [`getObservedFramePosition`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#ad4c174389264630ffb1b2d24c6030013)  callback to set the position to observe:

- The position after capturing the video frame.
- The position before receiving the remote video frame.
- The position before encoding the frame.

#### Fixed issues

- This release fixed audio mixing issues.
- This release fixed issues relating to authentication with an App ID and a token.

#### API changes

This release adds the following APIs:

-  [`setAudioMixingPitch`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setAudioMixingPitch:)
- Several elements that have the prefixes `AgoraAudioVoiceBeauty` and `AgoraAudioGeneralBeautyVoice` in the [`AgoraAudioVoiceChanger`](./API%20Reference/oc/Constants/AgoraAudioVoiceChanger.html) enumeration
- `AgoraAudioReverbPresetVirtualStereo` and several elements that have the prefixes `AgoraAudioReverbPresetFx` in the [`AgoraAudioReverbPreset`](./API%20Reference/oc/Constants/AgoraAudioReverbPreset.html) enumeration
- [`enableFaceDetection`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableFaceDetection:)
- [`facePositionDidChangeWidth`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:facePositionDidChangeWidth:previewHeight:faces:)
- `AgoraVideoRenderModeFill` in the [`AgoraVideoRenderMode`](./API%20Reference/oc/Constants/AgoraVideoRenderMode.html) enumeration 
-  [`setRemoteVideoRenderer`](./API%20Reference/oc/Classes/AgoraRtcChannel.html#//api/name/setRemoteVideoRenderer:forUserId:) and [`remoteVideoRendererOfUserId`](./API%20Reference/oc/Classes/AgoraRtcChannel.html#//api/name/remoteVideoRendererOfUserId:) in the `AgoraRtcChannel` class
- `totalActiveTime` in the [`AgoraRtcRemoteAudioStats`](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) class
- `totalActiveTime` in the [`AgoraRtcRemoteVideoStats`](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html) class

## v3.0.0.2

v3.0.0.2 was released on Apr 22, 2020.

#### New features

**Specifying the area of connection**

This release adds `sharedEngineWithConfig` for specifying the area of connection when creating an `AgoraRtcEngineKit` instance. This advanced feature applies to scenarios that have regional restrictions. You can choose from areas including Mainland China, North America, Europe, Asia (excluding Mainland China), and global (default).

After specifying the area of connection:

- When the app that integrates the Agora SDK is used within the specified area, it connects to the Agora servers within the specified area under normal circumstances.
- When the app that integrates the Agora SDK is used out of the specified area, it connects to the Agora servers either in the specified area or in the area where the SDK is located.

#### Issues fixed

This release fixed issues relating to no audio, disconnecting from a Bluetooth device after joining a channel, and the occasional failure to join a channel.

#### API changes

**Added**

[`sharedEngineWithConfig`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/sharedEngineWithConfig:delegate:)

## v3.0.0

v3.0.0 was released on Mar 4, 2020.

In this release, Agora improves the user experience under poor network conditions for both the `Communication` and `LiveBroadcasting` profiles through the following measures:

- Adopting a new architecture for the `Communication` profile.
- Upgrading the last-mile network strategy for both the `Communication` and `LiveBroadcasting` profiles,  which enhances the SDK's anti-packet-loss capacity by maximizing the net bitrate when the uplink and downlink bandwidth are insufficient.

To deal with any incompatibility issues caused by the architecture change, Agora uses the fallback mechanism to ensure that users of different versions of the SDKs can communicate with each other: if a user joins the channel from a client using a previous version, all clients using v3.0.0 automatically fall back to the older version. This has the effect that none of the users in the channel can enjoy the improved experience. Therefore we strongly recommend upgrading all your clients to v3.0.0.

We also upgrade the On-premise Recording SDK to v3.0.0. Ensure that you upgrade your On-premise Recording SDK to v3.0.0 so that all users can enjoy the improvements brought by the new architecture and network strategy.

#### Compatibility changes

**1. Renaming the static library and adding support for dynamic library**

To unify the library names across platforms, this release renames the library from `AgoraRtcEngineKit.framework` to `AgoraRtcKit.framework`. If you upgrade your SDK to v3.0.0, you must re-import the `AgoraRtcKit` class. For details, see [Import the class](https://docs.agora.io/en/Interactive%20Broadcast/start_live_mac?platform=macOS#a-nameimportclassa2-import-the-class) in the Quickstart.

To improve your development experience, this release also adds support for the dynamic library. You can integrate either the static or the dynamic library in your project, and the name of the dynamic library package is Agora_Native_SDK_for_macOS_v3_0_0_FULL_Dynamic. 

Integrating the dynamic library has the following advantages:

- The overall security level is improved.
- Incompatibility issues with other third-party libraries are avoided.
- Uploading the app onto App Store is easier.

If you prefer the dynamic library, you need to re-integrate the SDK and re-import the `AgoraRtcKit` class. This process should take no more than five minutes. See [Integrate the SDK](https://docs.agora.io/en/Interactive%20Broadcast/start_live_mac?platform=macOS#a-nameintegratesdkaintegrate-the-sdk) and [Import the class](https://docs.agora.io/en/Interactive%20Broadcast/start_live_mac?platform=macOS#a-nameimportclassa2-import-the-class) in the Quickstart.

<div class="alert info">The following table shows the difference in the file size when generating ipa files with a dynamic and static library:

<table>
    <tr>
        <td width="8%"><b>Library type</b></td>
        <td width="15%"><b>ipa size (M)</b></td>
        <td width="10%"><b>Decompressed ipa size (M)</b></td>
        <td width="17%"><b>Frameworks folder size (M)</b></td>
        <td width="15%"><b>Binary file size (M)</b></td>
        <td width="25%"><b>Total size of frameworks folder + binary file (M)</b></td>
    </tr>
    <tr>
        <td>Dynamic library</td>
        <td>31.1</td>
        <td>65</td>
        <td>51.47</td>
        <td>2.4</td>
        <td>53.87</td>
    </tr>
    <tr>
        <td>Static library</td>
        <td>30.6</td>
        <td>63.7</td>
        <td>30.1</td>
        <td>22.5</td>
        <td>52.6</td>
    </tr>
</table>

The dynamic library is located in the framework folder as an independent library. Note that the corresponding binary file size does not include the SDK size. Overall, this decreases the binary file size by 20.1 M and increases the framework folder size by 21.37 M.</div>

**2. Dual-stream mode not enabled in the Communication profile**

As of v3.0.0, the native SDK does not enable the [dual-stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-dualadual-stream-mode) by default in the `Communication` profile. Call the [`enableDualStreamMode (YES)`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableDualStreamMode:) method after joining the channel to enable it. In video scenarios with multiple users, we recommend enabling the dual-stream mode.

#### New features

**1. Multiple channel management**

To enable a user to join an unlimited number of channels at a time, this release adds the [`AgoraRtcChannel`](./API%20Reference/oc/Classes/AgoraRtcChannel.html) and [`AgoraRtcChannelDelegate`](./API%20Reference/oc/Protocols/AgoraRtcChannelDelegate.html) classes. By creating multiple `AgoraRtcChannel` objects, a user can join the corresponding channels at the same time.

After joining multiple channels, users can receive the audio and video streams of all the channels, but publish one stream to only one channel at a time. This feature applies to scenarios where users need to receive streams from multiple channels, or frequently switch between channels to publish streams. See [Join multiple channels](./multiple_channel_apple) for details.

**2. Raw video data**
Adds the following C++ callbacks to the `IVideoFrameObserver` class to provide raw video data at different video transmission stages, and to accommodate more scenarios.

- `onPreEncodeVideo`: Gets the video data after pre-processing and prior to encoding. This method applies to the scenarios where you need to pre-process the video data.
- `getSmoothRenderingEnabled`: Sets whether to smooth the acquired video frames. The smoothed video frames are more evenly spaced, providing a better rendering experience.

**3. Adjusting the playback volume of the specified remote user**

Adds [`adjustUserPlaybackSignalVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustUserPlaybackSignalVolume:volume:) for adjusting the playback volume of a specified remote user. You can call this method as many times as necessary in a call or interactive live streaming to adjust the playback volume of different remote users, or to repeatedly adjust the playback volume of the same remote user.

#### Improvements

**1. Audio profiles**

To meet the need for higher audio quality, this release adjusts the corresponding audio profile of `AgoraAudioProfileDefault(0)` in the `LiveBroadcasting` profile.

| SDK   | `AgoraAudioProfileDefault(0)`                                  |
| :--------- | :---------------------------------------------------------- |
| v3.0.0      | A sample rate of 48 KHz, music encoding, mono, and a bitrate of up to 52 Kbps. |
| Earlier than v3.0.0 | A sample rate of 32 KHz, music encoding, mono, and a bitrate of up to 52 Kbps. |

**2. Mirror mode**

The mirror mode determines how the SDK mirrors the video in different stages of transmission. This release supports setting the video mirror mode when encoding and rendering the video:

- Setting a mirror mode for the stream to be encoded: This release adds the `mirrorMode` member to the [`AgoraVideoEncoderConfiguration`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html) struct struct for setting a mirror effect for the stream to be encoded and transmitted.
- Setting a mirror mode for the streams to be rendered: 
	- We add the `mirrorMode` member to the [`AgoraRtcVideoCanvas`](./API%20Reference/oc/Classes/AgoraRtcVideoCanvas.html) struct. You can use [`setupLocalVideo`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setupLocalVideo:), to set a mirror effect for the local view, or use [`setupRemoteVideo`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setupRemoteVideo:) to set a mirror effect for the remote view on the local device.
	- This release also adds the [`setLocalRenderMode`](./API%20Reference/oc/v3.0.0/Classes/AgoraRtcEngineKit.html#//api/name/setLocalRenderMode:mirrorMode:) and [`setRemoteRenderMode`](./API%20Reference/oc/v3.0.0/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteRenderMode:renderMode:mirrorMode:) methods, both of which take an extra `mirrorMode` parameter. During a call, you can use `setLocalRenderMode` to update the mirror effect of the local view or `setRemoteRenderMode` to update the mirror effect of the remote view on the local device.

**3. Quality statistics**

Adds the following members in the [`AgoraChannelStats`](./API%20Reference/oc/Classes/AgoraChannelStats.html) class for providing more in-call statistics, making it easier to monitor the call quality and memory usage in real time:

- `gatewayRtt`
- `memoryAppUsageRatio`
- `memoryTotalUsageRatio`
- `memoryAppUsageInKbytes`

**4. Others**

This release enables interoperability between the Native SDK and the Web SDK by default, and deprecates the `enableWebSdkInteroperability` method.

#### Issues fixed

- Audio issues concerning audio mixing, audio encoding, and echo.
- Video issues concerning the watermark, video aspect ratio, video sharpness, full-screen video, and black outline during the screen share.
- Other issues related to app crashes, log file, and unstable service when pushing streams to the CDN.

#### API changes

**Behavior change**

- Calling [`enableLocalAudio (NO)`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableLocalAudio:) does not change the in-call volume to media volume.
- When connected to a headset or Bluetooth,  the macOS device changes its audio route to be uniform as the audio route shown in the device manager. 

**Added**

- [`setLocalRenderMode`](./API%20Reference/oc/v3.0.0/Classes/AgoraRtcEngineKit.html#//api/name/setLocalRenderMode:mirrorMode:)
- [`setRemoteRenderMode`](./API%20Reference/oc/v3.0.0/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteRenderMode:renderMode:mirrorMode:) 
- The `mirrorMode` parameter in the [`AgoraVideoEncoderConfiguration`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html) struct
- The `mirrorMode` and `channelId` parameter in the [`AgoraRtcVideoCanvas`](./API%20Reference/oc/Classes/AgoraRtcVideoCanvas.html) struct
- The `channelId` parameter in the [`AgoraRtcAudioVolumeInfo`](./API%20Reference/oc/Classes/AgoraRtcAudioVolumeInfo.html) struct
- [`createRtcChannel`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/createRtcChannel:)
- [`AgoraRtcChannel`](./API%20Reference/oc/Classes/AgoraRtcChannel.html) class
- [`AgoraRtcChannelDelegate`](./API%20Reference/oc/Protocols/AgoraRtcChannelDelegate.html) class
- The `gatewayRtt`, `memoryAppUsageRatio`, `memoryTotalUsageRatio` and `memoryAppUsageInKbytes` members in the [`AgoraChannelStats`](./API%20Reference/oc/Classes/AgoraChannelStats.html) class

**Deprecated**

- `enableWebSdkInteroperability`
- `setLocalRenderMode`¹. Use the new [`setLocalRenderMode`](./API%20Reference/oc/v3.0.0/Classes/AgoraRtcEngineKit.html#//api/name/setLocalRenderMode:mirrorMode:) method instead.
- `setRemoteRenderMode`¹. Use the new [`setRemoteRenderMode`](./API%20Reference/oc/v3.0.0/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteRenderMode:renderMode:mirrorMode:) method instead.
- `setLocalVideoMirrorMode`. Use the `mirrorMode` parameter in the [`setupLocalVideo`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setupLocalVideo:) and [`setLocalRenderMode`](./API%20Reference/oc/v3.0.0/Classes/AgoraRtcEngineKit.html#//api/name/setLocalRenderMode:mirrorMode:) methods instead.
- `firstRemoteVideoFrameOfUid`. Use the [remoteVideoStateChangedOfUid](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStateChangedOfUid:state:reason:elapsed:) callback instead.
- `didAudioMuted`, `firstRemoteAudioFrameDecodedOfUid` and `firstRemoteAudioFrameOfUid`. Use the [`remoteAudioStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStateChangedOfUid:state:reason:elapsed:) callback instead.
- `streamPublishedWithUrl` and `streamUnpublishedWithUrl`. Use the [`rtmpStreamingChangedToState`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:rtmpStreamingChangedToState:state:errorCode:) callback instead.

## v2.9.3

v2.9.3 was released on Feb 10, 2020.

This release fixed the following issues:
- The `setRemoteSubscribeFallbackOption` method, which should work in the `LiveBroadcasting` profile only, also works in the `Communication` profile.
- In some one-to-one communication, the downlink media stream falls back to audio-only under poor network conditions.
- Occasionally, the UI of the system window is abnormal on macOS 10.15. 

## v2.9.1
v2.9.1 is released on Sep 19, 2019.

#### New features

**1. Detecting local voice activity**

This release adds the `report_vad(bool)` parameter to the [`enableAudioVolumeIndication`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableAudioVolumeIndication:smooth:report_vad:) method to enable local voice activity detection. Once it is enabled, you can check the [`AgoraRtcAudioVolumeInfo`](./API%20Reference/oc/Classes/AgoraRtcAudioVolumeInfo.html) struct of the [`reportAudioVolumeIndicationOfSpeakers`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:reportAudioVolumeIndicationOfSpeakers:totalVolume:) callback for the voice activity status of the local user.

**2. Supporting RGBA raw video data**

This release supports RGBA raw video data. Use the C++ method [`getVideoFormatPreference`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a440e2a33140c25dfd047d1b8f7239369) to set the format of the raw video data format.

You can also rotate or mirror the RGBA raw data using the C++ methods [`getRotationApplied`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#afd5bb439a9951a83f08d8c0a81468dcb) or [`getMirrorApplied`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#afc5cce81bf1c008e9335a0423ca45991) respectively.

#### Improvements

**1. Improving the watermark function in interactive live streaming**

This release adds a new [`addVideoWatermark`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/addVideoWatermark:options:) method with the following settings:

- The `visibleInPreview` member sets whether the watermark is visible in the local preview.
- The `positionInLandscapeMode`/`positionInPortraitMode` member sets the watermark position when the encoding video is in landscape/portrait mode.

This release optimizes the watermark function, reducing the CPU usage by 5% to 20%.

The original `addVideoWatermark` method is deprecated.

**2. Supporting more audio sample rates for recording**

To enable more audio sample rate options for recording, this release adds a new [`startAudioRecording`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startAudioRecording:sampleRate:quality:) method with a `sampleRate` parameter. In the new method, you can set the sample rate as 16, 32, 44.1 or 48 kHz. The original method supports only a fixed sample rate of 32 kHz and is deprecated.

#### Issues fixed

**Video**

The return value of the [`getDeviceInfo`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getDeviceInfo:) method does not match the actual available device.

#### API changes

To improve the user experience, we made the following changes in v2.9.1:

**Added**

- [`startAudioRecording`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startAudioRecording:sampleRate:quality:)
- [`addVideoWatermark`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/addVideoWatermark:options:)
- [`getVideoFormatPreference`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a440e2a33140c25dfd047d1b8f7239369)
- [`getRotationApplied`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#afd5bb439a9951a83f08d8c0a81468dcb)
- [`getMirrorApplied`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#afc5cce81bf1c008e9335a0423ca45991)
- The `report_vad` parameter in the [`enableAudioVolumeIndication`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableAudioVolumeIndication:smooth:report_vad:) method
- The `vad` member in the [`AgoraRtcAudioVolumeInfo`](./API%20Reference/oc/Classes/AgoraRtcAudioVolumeInfo.html) class

**Deprecated**

- `startAudioRecording`
- `addVideoWatermark`

## v2.9.0
v2.9.0 is released on Aug. 16, 2019.

#### Compatibility changes

**1. RTMP streaming**

In this release, we deleted the following methods:

- `configPublisher`
- `setVideoCompositingLayout`
- `clearVideoCompositingLayout`

If your app implements RTMP streaming with the methods above, ensure that you upgrade the SDK to the latest version and use the following methods for the same function:

- [`setLiveTranscoding`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLiveTranscoding:)
- [`addPublishStreamUrl`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/addPublishStreamUrl:transcodingEnabled:)
- [`removePublishStreamUrl`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/removePublishStreamUrl:)
- [`rtmpStreamingChangedToState`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:rtmpStreamingChangedToState:state:errorCode:)

For how to implement the new methods, see [Push Streams to the CDN](cdn_streaming_apple).

**2. Reporting the state of the remote video**

This release extends the [`remoteVideoStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStateChangedOfUid:state:reason:elapsed:) callback with more states of the remote video: Stopped(0), Starting(1), Decoding(2), Frozen(3), and Failed(4). It adds a reason parameter to the callback to indicate why the remote video state changes. The original `remoteVideoStateChangedOfUid` callback is deleted. If you upgrade your Native SDK to the latest version, ensure that you re-implement the [`remoteVideoStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStateChangedOfUid:state:reason:elapsed:) callback.

The new callback reports most of the remote video states, and therefore deprecates the following callbacks. You can still use them, but we do not recommend doing so.

- [`didVideoEnabled`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didVideoEnabled:byUid:)
- [`didLocalVideoEnabled`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didLocalVideoEnabled:byUid:)
- [`firstRemoteVideoDecodedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:firstRemoteVideoDecodedOfUid:size:elapsed:)

<div class="alert note">The triggering timing of the new callback is different from the old one. The new <code>remoteVideoStateChangedOfUid</code> callback is triggered only when the remote video state has changed.</div>

**3. Disabling/enabling the local audio**

To improve the audio quality in the `Communication` profile, this release sets the system volume to the media volume after you call the `enableLocalAudio`(true) method. Calling `enableLocalAudio`(false) switches the system volume back to the in-call volume.

#### New features

**1. Faster switching to another channel**

This release adds the [`switchChannelByToken`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/switchChannelByToken:channelId:joinSuccess:) method to enable the audience in an interactive streaming channel to quickly switch to another channel. With this method, you can achieve a much faster switch than with the [`leaveChannel`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/leaveChannel:) and [`joinChannelByToken`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:) methods. After the audience successfully switches to another channel by calling the [`switchChannelByToken`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/switchChannelByToken:channelId:joinSuccess:) method, the SDK triggers the [`didLeaveChannelWithStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didLeaveChannelWithStats:) and [`didJoinChannel`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didJoinChannel:withUid:elapsed:) callbacks to indicate that the audience has left the original channel and joined a new one. 

**2. Channel media stream relay**

This release adds the following methods to relay the media streams of a host from a source channel to a destination channel. This feature applies to scenarios such as online singing contests, where hosts of different interactive streaming channels interact with each other.

- [`startChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startChannelMediaRelay:)
- [`updateChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/updateChannelMediaRelay:)
- [`stopChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopChannelMediaRelay)

During the media stream relay, the SDK reports the states and events of the relay with the  [`channelMediaRelayStateDidChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:channelMediaRelayStateDidChange:error:) and [`didReceiveChannelMediaRelayEvent`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didReceiveChannelMediaRelayEvent:) callbacks.

For more information on the implementation, API call sequence, sample code, and considerations, see [Co-host across Channels](media_relay_apple).

**3. Reporting the local and remote audio state**

This release adds the [`localAudioStateChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioStateChange:error:) and [`remoteAudioStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStateChangedOfUid:state:reason:elapsed:) callbacks to report the local and remote audio states. With these callbacks, the SDK reports the following states for the local and remote audio:

- The local audio: Stopped(0), Recording(1), Encoding(2), or Failed(3). When the state is Failed(3), see the `error` parameter for troubleshooting.
- The remote audio: Stopped(0), Starting(1), Decoding(2), Frozen(3), or Failed(4). See the `reason` parameter for why the remote audio state changes.

**4. Reporting the local audio statistics**

This release adds the [`localAudioStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioStats:) callback to report the statistics of the local audio during a call, including the number of channels, the sending sample rate, and the average sending bitrate of the local audio.

**5. Pulling the remote audio data**

To improve the experience in audio playback, this release adds the following methods to pull the remote audio data. After getting the audio data, you can process it and play it with the audio effects that you want.

- [`enableExternalAudioSink`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableExternalAudioSink:channels:)
- [`disableExternalAudioSink`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/disableExternalAudioSink)
- [`pullPlaybackAudioFrameRawData`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pullPlaybackAudioFrameRawData:lengthInByte:)
- [`pullPlaybackAudioFrameSampleBufferByLengthInByte`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pullPlaybackAudioFrameSampleBufferByLengthInByte:)

The difference between the `onPlaybackAudioFrame` callback and the `pullPlaybackAudioFrameRawData` / `pullPlaybackAudioFrameSampleBufferByLengthInByte` method is as follows:

- `onPlaybackAudioFrame`: The SDK sends the audio data to the app once every 10 ms. Any delay in processing the audio frames may result in an audio delay.
- `pullPlaybackAudioFrameRawData` / `pullPlaybackAudioFrameSampleBufferByLengthInByte`: The app pulls the remote audio data. After setting the audio data parameters, the SDK adjusts the frame buffer and avoids problems caused by jitter in external audio playback.

#### Improvements

**1. Reporting more statistics of the in-call quality**

This release adds the following statistics in the [`AgoraChannelStats`](./API%20Reference/oc/Classes/AgoraChannelStats.html), [`AgoraRtcLocalVideoStats`](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html), and [`AgoraRtcRemoteVideoStats`](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html) classes:

- `AgoraChannelStats`: The total number of the sent audio bytes, sent video bytes,  received audio bytes, and received video bytes during a session.
- `AgoraRtcLocalVideoStats`: The encoding bitrate, the width and height of the encoding frame, the number of frames, and the codec type of the local video.
- `AgoraRtcRemoteVideoStats`: The packet loss rate of the remote video.

**2. Improving the interactive live video streaming quality**

This release minimizes the video freeze rate under poor network conditions, improves the video sharpness, and optimizes the video smoothness when the packet loss rate is high.

**3. Improving the screen sharing quality**

This release improves the sharpness of text during screen sharing in the `Communication` profile, particularly when the network condition is poor. Note that this improvement takes effect only when you set `contentHint` as Details(2).

**4. Other improvements**

- Improves the audio quality when the audio scenario is set to `GameStreaming`.
- Improves the audio quality after the user disables the microphone in the `Communication` profile.

#### Issues fixed

**Audio**

- When interoperating with a Web app, voice distortion occurs after the native app enables the remote sound position indication.
- Crashes occur when testing the microphone.

**Video**

- Video freezes.

**Miscellaneous**

- Occasionally mixed streams in RTMP streaming. 

#### API changes

To improve the user experience, we made the following changes in v2.9.0:

**Added**
- [`enableExternalAudioSink`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableExternalAudioSink:channels:)
- [`disableExternalAudioSink`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/disableExternalAudioSink)
- [`pullPlaybackAudioFrameRawData`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pullPlaybackAudioFrameRawData:lengthInByte:)
- [`pullPlaybackAudioFrameSampleBufferByLengthInByte`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pullPlaybackAudioFrameSampleBufferByLengthInByte:)
- [`localAudioStateChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioStateChange:error:)
- [`remoteAudioStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStateChangedOfUid:state:reason:elapsed:)
- [`remoteVideoStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStateChangedOfUid:state:reason:elapsed:)
- [`localAudioStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioStats:)
- [`switchChannelByToken`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/switchChannelByToken:channelId:joinSuccess:) 
- [`startChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startChannelMediaRelay:)
- [`updateChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/updateChannelMediaRelay:)
- [`stopChannelMediaRelay`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopChannelMediaRelay)
- [`channelMediaRelayStateDidChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:channelMediaRelayStateDidChange:error:)
- [`didReceiveChannelMediaRelayEvent`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didReceiveChannelMediaRelayEvent:)
- [`AgoraChannelStats`](./API%20Reference/oc/Classes/AgoraChannelStats.html): `txAudioBytes`, `txVideoBytes`, `rxAudioBytes` and `rxVideoBytes`
- [`AgoraRtcLocalVideoStats`](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html): `encodedBitrate`, `encodedFrameWidth`, `encodedFrameHeight`, `encodedFrameCount` and `codedType`
- [`AgoraRtcRemoteVideoStats`](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html): `packetLossRate`

**Deprecated**

- [`didMicrophoneEnabled`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didMicrophoneEnabled:). Use AgoraAudioLocalStateStopped(0) or AgoraAudioLocalStateRecording(1) in the [`localAudioStateChange`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioStateChange:error:) callback instead.
- [`audioTransportStatsOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:audioTransportStatsOfUid:delay:lost:rxKBitRate:). Use the [`remoteAudioStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStats:) callback instead.
- [`videoTransportStatsOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:videoTransportStatsOfUid:delay:lost:rxKBitRate:). Use the [`remoteVideoStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStats:) callback instead.
- [`didVideoEnabled`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didVideoEnabled:byUid:). Use the [`remoteVideoStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStateChangedOfUid:state:reason:elapsed:) callback with the following parameters instead:
	- AgoraVideoRemoteStateStopped(0) and AgoraVideoRemoteStateReasonRemoteMuted(5).
	- AgoraVideoRemoteStateDecoding(2) and AgoraVideoRemoteStateReasonRemoteUnmuted(6).
- [`didLocalVideoEnabled`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didLocalVideoEnabled:byUid:). Use the [`remoteVideoStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStateChangedOfUid:state:reason:elapsed:) callback with the following parameters instead:
	- AgoraVideoRemoteStateStopped(0) and AgoraVideoRemoteStateReasonRemoteMuted(5).
	- AgoraVideoRemoteStateDecoding(2) and AgoraVideoRemoteStateReasonRemoteUnmuted(6).
- [`firstRemoteVideoDecodedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:firstRemoteVideoDecodedOfUid:size:elapsed:). Use AgoraVideoRemoteStateStarting(1) or AgoraVideoRemoteStateDecoding(2) in the [`remoteVideoStateChangedOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStateChangedOfUid:state:reason:elapsed:) callback instead.

**Deleted**

- `configPublisher`
- `setVideoCompositingLayout`
- `clearVideoCompositingLayout`
- `remoteVideoStateChangedOfUid`

## v2.8.0

v2.8.0 is released on Jul. 8, 2019.

#### New features

**1. Supporting string user IDs**

Many apps use string user IDs. This release adds the following methods to enable apps to join an Agora channel directly with string user IDs as user accounts:

- [registerLocalUserAccount](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/registerLocalUserAccount:appId:)
- [joinChannelByUserAccount](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByUserAccount:token:channelId:joinSuccess:)

For other methods, Agora uses the integer uid parameter. The Agora Engine maintains a mapping table that contains the user ID and string user account, and you can get the corresponding user account or ID by calling the getUserInfoByUid or getUserInfoByUserAccount method.

To ensure smooth communication, use the same parameter type to identify all users within a channel, that is, all users should use either the integer user ID or the string user account to join a channel. 

**Note**:
- Do not mix parameter types within the same channel. The following Agora SDKs support string user accounts:
	- The Native SDK: v2.8.0 and later.
	- The Web SDK: v2.5.0 and later.

 If you use SDKs that do not support string user accounts, only integer user IDs can be used in the channel.
- If you change your user IDs into string user accounts, ensure that all app clients are upgraded to the latest version.
- If you use string user accounts, ensure that the token generation script on your server is updated to the latest version. If you join the channel with a user account, ensure that you use the same user account or its corresponding integer user ID to generate a token. Call the `getUserInfoByUserAccount` method to get the user ID that corresponds to the user account.

**2. Adding remote audio and video statistics**

To monitor the audio and video transmission quality during a call or interactive live streaming, this release adds the `totalFrozenTime` and `frozenRate` members in the [AgoraRtcRemoteAudioStats](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) and [AgoraRtcRemoteVideoStats](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html) classes, to report the audio and video freeze time and freeze rate of the remote user.

This release also adds the `numChannels`, `receivedSampleRate`, and `receivedBitrate` members in the [AgoraRtcRemoteAudioStats](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) class.


#### Improvements

This release adds a `AgoraConnectionChangedKeepAliveTimeout(14)` member to the `AgoraConnectionChangedReason` parameter of the [connectionChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:) callback. This member indicates a connection state change caused by the timeout of the connection keep-alive between the SDK and Agora's edge server.


#### Issues fixed

**Video**

- Occasional deadlocks when calling the `MediaIO` methods.

**Miscellaneous**

- Occasional crashes.

#### API changes

To improve your experience, we made the following changes to the APIs:

**Added**

- [registerLocalUserAccount](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/registerLocalUserAccount:appId:)
- [joinChannelByUserAccount](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByUserAccount:token:channelId:joinSuccess:)
- [getUserInfoByUid](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getUserInfoByUid:withError:)
- [getUserInfoByUserAccount](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getUserInfoByUserAccount:withError:)
- [didRegisteredLocalUser](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didRegisteredLocalUser:withUid:)
- [didUpdatedUserInfo](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didUpdatedUserInfo:withUid:)
- The `numChannels`, `receivedSampleRate`, `receivedBitrate`, `totalFrozenTime`, and `frozenRate` members in the [AgoraRtcRemoteAudioStats](./API%20Reference/oc/Classes/AgoraRtcRemoteAudioStats.html) class
- The `totalFrozenTime` and `frozenRate` members in the [AgoraRtcRemoteVideoStats](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html) class

**Deprecated**

- The `lowLatency` member in the [AgoraLiveTranscoding](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html) class


## v2.4.1

V2.4.1 is released on Jun 12th, 2019.

#### Compatibility changes

Ensure that you read the following SDK behavior changes if you migrate from an earlier SDK version.

**1. Publishing streams to the RTMP**

To improve the usability of the RTMP streaming service, v2.4.1 defines the following parameter limits:

| Class **/** Interface  | Parameter Limit                                              |
| ---------------------- | ------------------------------------------------------------ |
| [AgoraLiveTranscoding](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html)        | <li>[videoFrameRate](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html#//api/name/videoFramerate): Frame rate (fps) of the CDN live output video stream. The value range is [0, 30], and the default value is 15. Agora adjusts all values over 30 to 30.<li>[videoBitrate](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html#//api/name/videoBitrate): Bitrate (Kbps) of the RTMP live output video stream. The default value is 400. Set this parameter according to the [Video Bitrate Table](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/bitrate). If you set a bitrate beyond the proper range, the SDK automatically adapts it to a value within the range.<li>[videoCodecProfile](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html#//api/name/videoCodecProfile): The video codec profile. Set it as **BASELINE**, **MAIN**, or **HIGH** (default). If you set this parameter to other values, Agora adjusts it to the default value of **HIGH**.<li>[size](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html#//api/name/size): Pixel of the video. The minimum value of size is **16 x 16**.</li> |
| [AgoraImage](./API%20Reference/oc/Classes/AgoraImage.html)             | url: The maximum length of this parameter is **1024** bytes. |
| [addPublishStreamUrl](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/addPublishStreamUrl:transcodingEnabled:)     | url: The maximum length of this parameter is **1024** bytes. |
| [removePublishStreamUrl](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/removePublishStreamUrl:) | url: The maximum length of this parameter is **1024** bytes. |

This release also adds the  [audioCodecProfile](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html#//api/name/audioCodecProfile) parameter in the `LiveTranscoding` class to set the audio codec profile type. The default type is LC-AAC, which means the low-complexity audio codec profile.

v2.4.1 also adds five error codes to the error parameter in the [streamPublishedWithUrl](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/removePublishStreamUrl:) method for quick troubleshooting.

**2. Renaming the receivedFrameRate parameter in the RemoteVideoStats class**

v2.4.1 renames the `receivedFrameRate` parameter to [rendererOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html#//api/name/rendererOutputFrameRate) in the [AgoraRtcRemoteVideoStats](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html) class to more accurately describe the statistics of the remote video stream.

#### New features

**1. Adding media metadata**

In interactive live streaming scenarios, the host can send shopping links, digital coupons, and online quizzes to the audience for more diversified interactive live streaming. v2.4.1 adds the [setMediaMetadataSource](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setMediaMetadataDataSource:withType:) and the [setMediaMetadataDelegate](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setMediaMetadataDelegate:withType:) interface and the [AgoraMediaMetadataDataSource](./API%20Reference/oc/Protocols/AgoraMediaMetadataDataSource.html) and the [AgoraMediaMetadataDelegate](./API%20Reference/oc/Protocols/AgoraMediaMetadataDelegate.html) protocol, allowing the host to add metadata to the output video and to send media attached information.

**2. Optimized screen sharing**

To avoid image cropping and distortion in screen sharing, v2.4.1 optimizes the encoding algorithms. In this release Agora applies the following encoding algorithms:

Suppose the value of **dimensions** is 1920 x 1080 pixels, that is, 2073600 pixels:

- If the value of the screen `dimensions` is lower than that of the encoding dimensions, for example, 1000 x 1000 pixels, the SDK uses 1000 x 1000 pixels for encoding.
- If the value of the screen `dimensions` is higher than that of the encoding dimensions, for example, 2000 x 2000 pixels, the SDK uses the maximum value under 1920 x 1080 pixels with the aspect ratio of the screen dimension (1:1) for encoding, that is, 1440 x 1440 pixels.

Agora uses the [dimensions](./API%20Reference/oc/Classes/AgoraScreenCaptureParameters.html#//api/name/dimensions) value in the  [AgoraScreenCaptureParameters](./API%20Reference/oc/Classes/AgoraScreenCaptureParameters.html)  class to calculate the charges. If you do not set the value of **dimensions**, the SDK uses the default value of 1920 x 1080 to calculate the charges.

You can also choose whether or not to capture the mouse cursor when sharing the screen. v2.4.1 adds the  [captureMouseCursor](./API%20Reference/oc/Classes/AgoraScreenCaptureParameters.html#//api/name/captureMouseCursor) parameter in the `AgoraScreenCaptureParameters` class and captures the mouse by default.

**3. State of the local video**

v2.4.1 adds the [localVideoStateChange](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localVideoStateChange:error:) callback to indicate the local video state. In this callback, the SDK returns the `Stopped`,` Capturing`, `Encoding`, or `Failed` state. When the state is `Failed`, you can use the error code for troubleshooting. This callback indicates whether or not the interruption is caused by capturing or encoding. This release deprecates the `rtcEngineCameraDidReady` and `rtcEngineVideoDidStop` callbacks.

**4. State of the RTMP streaming**

v2.4.1 adds the [rtmpStreamingChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:rtmpStreamingChangedToState:state:errorCode:) callback to indicate the state of the RTMP streaming and help you troubleshoot issues when exceptions occur. In this callback, the SDK returns the `Idle`, `Connecting`, `Runing`, `Recovering`, or `Failure` state. When the state is `Failure`, you can use the error code for troubleshooting. You can still use the `streamPublishedWithUrl` and `streamUnpublishedWithUrl` callbacks, but we do not recommend using them.

**5. More reasons for a network connection state change**

In the onConnectionStateChanged callback, v2.4.1 adds error codes to the reason parameter to help you troubleshoot issues when exceptions occur. The SDK returns the [connectionChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:) callback whenever the connection state changes. This release also deprecates `AgoraWarningCodeLookupChannelRejected(105)`, `AgoraErrorCodeTokenExpired(109)`, and `AgoraErrorCodeInvalidToken(110)`.

**6. State of the local network type **

v2.4.1 adds the [networkTypeChangedToType](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:networkTypeChangedToType:) callback to indicate the local network type. In this callback, the SDK returns the `Unknown`, `Disconnected`, `Lan`, `Wifi`, `2G`, `3G`, or `4G` type. When the network connection is interrupted, this callback indicates whether or not the interruption is caused by a network type change or poor network conditions.

**7. Getting the audio mixing volume**

v2.4.1 adds the  [getAudioMixingPlayoutVolume](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPlayoutVolume:) and [getAudioMixingPublishVolume](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPublishVolume:) methods, which respectively gets the audio mixing volume for local playback and remote playback, to help you troubleshoot audio volume related issues.

**8. Reporting when the first remote audio frame is received and decoded**

To get the more accurate time of the first audio frame from a specified remote user, v2.4.1 adds the [firstRemoteAudioFrameDecodedOfUid](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:firstRemoteAudioFrameDecodedOfUid:elapsed:) callback to report to the app that the SDK decodes first remote audio. This callback is triggered in either of the following scenarios:

- The remote user joins the channel and sends the audio stream.
- The remote user stops sending the audio stream and re-sends it after 15 seconds.

The difference between the onFirstRemoteAudioDecoded and `onFirstRemoteAudioFrame` callbacks is that the `onFirstRemoteAudioFram`e callback occurs when the SDK receives the first audio packet. It occurs before the `onFirstRemoteAudioDecoded` callback.


#### Improvements

**1. Reporting more statistics**

- v2.4.1 adds the [txPacketLossRate](./API%20Reference/oc/Classes/AgoraChannelStats.html#//api/name/txPacketLossRate) and  [rxPacketLossRate](./API%20Reference/oc/Classes/AgoraChannelStats.html#//api/name/rxPacketLossRate) parameters in the  [AgoraChannelStats](./API%20Reference/oc/Classes/AgoraChannelStats.html) class. These parameters return the packet loss rate from the local client to the server and vice versa.

- To provide more accurate statistics of the local and remote video, v2.4.1 makes the following changes to the following classes:
  - [AgoraRtcLocalVideoStats](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html): Adds the  [encoderOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html#//api/name/encoderOutputFrameRate) and [rendererOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html#//api/name/rendererOutputFrameRate) parameters
  - [AgoraRtcRemoteVideoStats](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html): Adds the [decoderOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html#//api/name/decoderOutputFrameRate) parameter, and renames the receivedFrameRate parameter to the [rendererOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html#//api/name/rendererOutputFrameRate) parameter

**2. Miscellaneous**

- Improved the sound quality of the GameStreaming audio scenario.
- Reduced the audio and video latency.
- Reduced the SDK package size by 0.5 M.
- Improved the accuracy of the network quality after users change the video bitrate.
- Enabled the audio quality notification callback by default, that is, enabled the [remoteAudioStats](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStats:) callback without calling the `enableAudioVolumeIndication` method.
- Improved the stability of video services.
- Improved the stability of RTMP streaming.

#### Issues fixed

**Video**

- The user cannot switch between the screen sharing stream and the camera stream.

**Miscellaneous**

- Users still receive the `onNetworkQuality` callback after leaving the channel. 
- Occasional crashes. 


#### API changes

To improve your experience, we made the following changes to the APIs:

**Unified the C++ interface for all platforms**

v2.4.1 unifies the behavior of the C++ interfaces across different platforms so that you can apply the same code logic on different platforms. v2.4.1 implements the methods of the `RtcEngineParameters` class in the `IRtcEngine` class. Refer to [Agora C++ API Reference for All Platforms home page](./API%20Reference/cpp/index.html) for the applicable platforms and considerations of each interface.

**Added**

- [getAudioMixingPlayoutVolume](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getAudioMixingPlayoutVolume)
- [getAudioMixingPublishVolume](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getAudioMixingPublishVolume)
- [firstRemoteAudioFrameDecodedOfUid](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:firstRemoteAudioFrameDecodedOfUid:elapsed:)
- [localVideoStateChange](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localVideoStateChange:error:)
- [networkTypeChangedToType](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:networkTypeChangedToType:)
- [rtmpStreamingChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:rtmpStreamingChangedToState:state:errorCode:)
- [setMediaMetadataSource](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setMediaMetadataDataSource:withType:) 
- [setMediaMetadataDelegate](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setMediaMetadataDelegate:withType:) 
-  [AgoraMediaMetadataSource](./API%20Reference/oc/Protocols/AgoraMediaMetadataDataSource.html) 
- [AgoraMediaMetadataDelegate](./API%20Reference/oc/Protocols/AgoraMediaMetadataDelegate.html)
- The [audioCodecProfile](./API%20Reference/oc/Classes/AgoraLiveTranscoding.html#//api/name/audioCodecProfile) parameter in the `LiveTranscoding` class
- The  [captureMouseCursor](./API%20Reference/oc/Classes/AgoraScreenCaptureParameters.html#//api/name/captureMouseCursor) parameter in the `AgoraScreenCaptureParameters` class
- The [txPacketLossRate](./API%20Reference/oc/Classes/AgoraChannelStats.html#//api/name/txPacketLossRate) and [rxPacketLossRate](./API%20Reference/oc/Classes/AgoraChannelStats.html#//api/name/rxPacketLossRate) parameters in the `AgoraChannelStats` class
- The [encoderOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html#//api/name/encoderOutputFrameRate) and [rendererOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html#//api/name/rendererOutputFrameRate) parameters in the `AgoraRtcLocalVideoStats` class
- The [decoderOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html#//api/name/decoderOutputFrameRate) and [rendererOutputFrameRate](./API%20Reference/oc/Classes/AgoraRtcRemoteVideoStats.html#//api/name/rendererOutputFrameRate) (to replace `receivedRemoteRate`) parameters in the `AgoraRtcRemoteVideoStats` class

**Deprecated**

- `enableAudioQualityIndication`
- `rtcEngineCameraDidReady`. Use  AgoraLocalVideoStreamStateCapturing(1) in the [localVideoStateChange](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localVideoStateChange:error:) callback instead.
- `rtcEngineVideoDidStop`. Use AgoraLocalVideoStreamStateStopped(0) in the [localVideoStateChange](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localVideoStateChange:error:) callback instead.
- The `AgoraWarningCodeLookupChannelRejected(105)` warning code. Use AgoraConnectionChangedRejectedByServer(10) in the [connectionChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:) callback instead.
- The `AgoraErrorCodeTokenExpired(109)` error code. Use AgoraConnectionChangedTokenExpired(9) in the [connectionChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:) callback instead.
- The `AgoraErrorCodeInvalidToken(110)` error code. Use  AgoraConnectionChangedInvalidToken(8) in the [connectionChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:) callback instead.
- The `AgoraErrorCodeStartCamera(1003)` error code. Use AgoraLocalVideoStreamErrorCaptureFailure(4) in the [localVideoStateChange](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localVideoStateChange:error:) callback instead.

## v2.4.0 and Earlier

**v2.4.0**

v2.4.0 is released on April 1, 2019.

#### **Compatibility changes**

If you integrate the SDK by using CocoaPods，ensure that you run `pod update` in your Terminal before `pod install`. If you prefer to specify the SDK version to obtain the latest release, ensure that you specify it as `'AgoraRtcEngine_macOS', '2.4.0.1'` in the Podfile.

#### **New features**

##### 1. Advanced screen sharing

v2.4.0 upgrades screen sharing and provides the following advanced functions:

- Shares the whole or part of a specified screen in a multi-display environment ([`startScreenCaptureByDisplayId`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startScreenCaptureByDisplayId:rectangle:parameters:)).
- Shares the whole or part of a specified window ([`startScreenCaptureByWindowId`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startScreenCaptureByWindowId:rectangle:parameters:)).
- Sets the content hint of the screen sharing to prioritize motion or detail ([`setScreenCaptureContentHint`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setScreenCaptureContentHint:)).
- Sets the dimensions, frame rate and bitrate for screen sharing ([`updateScreenCaptureParameters`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/updateScreenCaptureParameters:)).

v2.4.0 deprecates the `startScreenCapture` method. We recommend using the new methods for screen sharing. With the new methods, developers need to design the code logic to obtain the `displayId` and `windowId`. For more information, see [Share the Screen](screensharing_mac).

##### 2. Voice changer and voice reverberation

Adding voice changer and reverberation effects in an audio chat room brings much more fun. v2.4.0 adds the [`setLocalVoiceChanger`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceChanger:) and [`setLocalVoiceReverbPreset`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceReverbPreset:) methods, allowing you to change your voice or reverberation by choosing from the preset options. See Adjust the pitch and tone.

##### 3. Tracking the sound position of a remote user 

v2.4.0 adds the [`enableSoundPositionIndication`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableSoundPositionIndication:) and [`setRemoteVoicePosition`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteVoicePosition:pan:gain:) methods. Call the [`enableSoundPositionIndication`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableSoundPositionIndication:) method before joining a channel to enable stereo panning for the remote users, and then you can call the [`setRemoteVoicePosition`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteVoicePosition:pan:gain:) method to track the position of a remote user.

##### 4. Pre-call last-mile network probe test

Conducting a last-mile probe test before joining the channel helps the local user to evaluate or predict the uplink network conditions. v2.4.0 adds the [`startLastmileProbeTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startLastmileProbeTest:), [`stopLastmileProbeTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopLastmileProbeTest), and [`lastmileProbeResult`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileProbeTestResult:) APIs, allowing you to get the uplink and downlink last-mile network statistics, including the bandwidth, packet loss, jitter, and round-trip time (RTT).

##### 5. Audio device loopback test

v2.4.0 adds the [`startAudioDeviceLoopbackTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startAudioDeviceLoopbackTest:) and [`stopAudioDeviceLoopbackTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopAudioDeviceLoopbackTest) methods for testing whether the local audio devices are working properly. The test involves only the local audio devices and does not report the network condition.

##### 6. Setting the priority of a remote user's stream

v2.4.0 adds the [`setRemoteUserPriority`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteUserPriority:type:) method for setting the priority of a remote user's media stream. You can use this method with the [`setRemoteSubscribeFallbackOption`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteSubscribeFallbackOption:) method. If the fallback function is enabled for a remote stream, the SDK ensures the high-priority user gets the best possible stream quality.

##### 7. State of an audio mixing file 

v2.4.0 adds the [`localAudioMixingStateDidChanged`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioMixingStateDidChanged:errorCode:) callback to report any change of the audio-mixing file playback state (playback succeeds or fails) and the corresponding reason. This release also adds the warning code 701, which is triggered if the local audio-mixing file does not exist, or if the SDK does not support the file format or cannot access the music file URL when playing the audio-mixing file.

##### 8. Setting the log file size

The SDK has two log files, each with a default size of 512 KB. In case some customers require more than the default size, v2.4.0 adds the [`setLogFileSize`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLogFileSize:) method for setting the log file size (KB).

#### 9. Cloud proxy

Supports the cloud proxy service. See [Use Cloud Proxy](cloudproxy_native) for details.

#### **Improvements**

##### 1. Accuracy of call quality statistics

- v2.4.0 replaces the [`startEchoTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startEchoTest:) method with the [`startEchoTestWithInterval`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startEchoTestWithInterval:successBlock:) method. The `intervalInSeconds` parameter of `startEchoTestWithIntervals` allows you to set the interval between when you speak and when the recording plays back.
- v2.4.0 adds three parameters to the [`AgoraRtcLocalVideoStats`](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html) class: [`sentTargetBitrate`](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html#//api/name/sentTargetBitrate) for setting the target bitrate of the current encoder, [`sentTargetFrameRate`](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html#//api/name/sentTargetFrameRate) for setting the target frame rate, and [`qualityAdaptIndication`](./API%20Reference/oc/Classes/AgoraRtcLocalVideoStats.html#//api/name/qualityAdaptIndication) for reporting the quality of the local video since last count.

##### 2. Video encoder preferences

v2.4.0 provides the following options for setting video encoder preferences:

- Setting preferences under limited bandwidth. v2.4.0 adds two parameters to the [`AgoraVideoEncoderConfiguration`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html) class: [`minFrameRate`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/minFrameRate) and [`degradationPreference`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/degradationPreference). You can use these parameters together to set the minimum video encoder frame rate and the video encoding degradation preference under limited bandwidth. For more information, see [Set the Video Profile](video_profile_apple).
- Setting the camera capture preference. v2.4.0 adds the [`setCameraCapturerConfiguration`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setCameraCapturerConfiguration:) method, allowing you to set the camera capture preference. You can choose system performance over video quality or vice versa as needed. For more information, see the [API Reference](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setCameraCapturerConfiguration:).

##### 3. Core quality improvements

- Reduces the audio delay.
- Improves the video quality and stability.
- Shortens the time to render the first remote video frame. 
- Improves the video smoothness and reduces the time delay when sharing a screen under poor network conditions. 
- Optimizes the usage of CPU and RAM resources.

#### **Issues fixed**

##### Audio

- Calling the `enableLocalAudio` method disconnects all connected Bluetooth devices.
- The SDK does not support audio mixing URLs with Chinese characters.
- The SDK does not return YES after the `pushExternalAudioFrameSampleBuffer` method call succeeds.
- Volume levels of the high-pitch sound are lowered.
- Sounds are occasionally played fast.
- The app cannot get the virtual sound card information with the `getAudioPlaybackDevices` method.

##### Video

- If you skip the `renderMode` setting, the video stretches due to a mismatch with the display.
- Video freezes on some lower-end devices.
- It takes too long to render the first received video frame.
- The Electron SDK crashes if the virtual camera does not support 640 x 480.
- The cursor on the local screen is not accurately projected onto the remote screen.

##### Miscellaneous:

- The SEI information does not synchronize with the media stream when publishing transcoded streams to the RTMP.

#### **API changes**

To improve your experience, we made the following changes to the APIs:

##### Added

- [`setBeautyEffectOptions`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setBeautyEffectOptions:options:)
- [`startScreenCaptureByDisplayId`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startScreenCaptureByDisplayId:rectangle:parameters:)
- [`startScreenCaptureByWindowId`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startScreenCaptureByWindowId:rectangle:parameters:)
- [`updateScreenCaptureParameters`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/updateScreenCaptureParameters:)
- [`setScreenCaptureContentHint`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setScreenCaptureContentHint:)
- [`setLocalVoiceChanger`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceChanger:)
- [`setLocalVoiceReverbPreset`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalVoiceReverbPreset:)
- [`enableSoundPositionIndication`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableSoundPositionIndication:)
- [`setRemoteVoicePosition`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteVoicePosition:pan:gain:)
- [`startLastmileProbeTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startLastmileProbeTest:)
- [`stopLastmileProbeTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopLastmileProbeTest)
- [`setRemoteUserPriority`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteUserPriority:type:)
- [`startEchoTestWithInterval`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startEchoTestWithInterval:successBlock:)
- [`startAudioDeviceLoopbackTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startAudioDeviceLoopbackTest:)
- [`stopAudioDeviceLoopbackTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopAudioDeviceLoopbackTest)
- [`setCameraCapturerConfiguration`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setCameraCapturerConfiguration:)
- [`setLogFileSize`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLogFileSize:)
- [`localAudioMixingStateDidChanged`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:localAudioMixingStateDidChanged:errorCode:)
- [`lastmileProbeResult`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileProbeTestResult:)

##### Deprecated

- `startEchoTest`
- `startScreenCapture`
- `setVideoQualityParameters`

##### Miscellaneous

v2.4.0 changes the type of the [`frameRate`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/frameRate) parameter in the [`AgoraVideoEncoderConfiguration`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html) class from `enum` to `int`.

**v2.3.3**

v2.3.3 is released on January 24, 2019. 

#### **Improvements**

v2.3.3 optimizes the screen-sharing algorithm for different scenarios. The video smoothness and quality are enhanced when a user presents slides or browses websites. v2.3.3 also improves the initial image quality in the `Communication` profile.

#### **Issues fixed**

Occasional inaccurate statistics returned in the `networkQuality` callback.

**v2.3.2**

v2.3.2 is released on January 16, 2019. 

#### **Compatibility changes**

Besides the new features and improvements mentioned below, it is worth noting that v2.3.2:

- Improves the SDK's ability to counter packet loss under unreliable network conditions.
- Improves the communication smoothness.
- Reduces video freezes in the `LiveBroadcasting` profile.

Before upgrading your SDK, ensure that the version is:

- Native SDK v1.11 or later.
- Web SDK v2.1 or later.

#### **New features**

##### 1. Video quality in the interactive live streaming

v2.3.2 adds the [minBitrate](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/minBitrate) parameter (minimum encoding bitrate) in the [setVideoEncoderConfiguration](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoEncoderConfiguration:) method. The SDK automatically adjusts the encoding bitrate to adapt to the network conditions. Using a value greater than the default value forces the video encoder to output high-quality images but may cause more packet loss and hence sacrifice the smoothness of the video transmission. Agora does not recommend changing this value unless you have special requirements for image quality.

##### 2. Independent audio mixing volume adjustments for local playback and remote publishing

v2.3.2 adds the [`adjustAudioMixingPlayoutVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPlayoutVolume:) and [`adjustAudioMixingPublishVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPublishVolume:) methods to complement the [`adjustAudioMixingVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingVolume:) method, allowing you to independently adjust the audio mixing volume for local playback and remote publishing.

This release also changes the behavior of the [adjustPlaybackSignalVolume](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustPlaybackSignalVolume:) method to control only the voice volume. Therefore, to mute the local audio playback, call both the `adjustPlaybackSignalVolume(0)` and `adjustAudioMixingVolume(0)` methods.

See [Adjust the Volume](./volume_mac) for the scenarios and corresponding APIs.

##### 3. Fallback options for the interactive streaming under unreliable network conditions

Unreliable network conditions affect the overall quality of the interactive live streaming. v2.3.2 adds the [`setLocalPublishFallbackOption`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalPublishFallbackOption:) and [`setRemoteSubscribeFallbackOption`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteSubscribeFallbackOption:) methods to allow the SDK to:

- Automatically disable the video stream when the network conditions cannot support both audio and video, or
- Enable the video when the network conditions improve. 

The SDK triggers the [`didLocalPublishFallbackToAudioOnly`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didLocalPublishFallbackToAudioOnly:) or [`didRemoteSubscribeFallbackToAudioOnly`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didRemoteSubscribeFallbackToAudioOnly:byUid:) callback when the stream falls back to audio-only or switches back to the video.

##### 4. Upstream and downstream statistics of each remote user/host

v2.3.2 adds the [`audioTransportStatsOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:audioTransportStatsOfUid:delay:lost:rxKBitRate:) and [`videoTransportStatsOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:videoTransportStatsOfUid:delay:lost:rxKBitRate:) callbacks to provide the upstream and downstream statistics of each remote user/host. During a call or interactive live streaming, the SDK triggers these callbacks once every two seconds after the local user receives audio/video packets from a remote user. The callbacks return the user ID, received audio/video bitrate, packet loss rate, and network time delay (ms).

##### 5. New video encoder configuration

To support video rotation scenarios and improve the quality of the custom video source, v2.3.2 deprecates the [`setVideoProfile`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoProfile:swapWidthAndHeight:) method and replaces it with the [`setVideoEncoderConfiguration`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoEncoderConfiguration:) method to set the video encoder configurations. The [`AgoraVideoEncoderConfiguration`](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html) class provides a set of configurable video parameters, including the dimension, frame rate, bitrate, and orientation. You can still use the `setVideoProfile` method, but we recommend using the `setVideoEncoderConfiguration` method to set the video profile.

##### 6. Virtual sound card

v2.3.2 adds the `deviceName` parameter in the [enableLoopbackRecording](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableLoopbackRecording:deviceName:) method, allowing you to use a virtual sound card for audio recording:

- To use the current sound card, set `deviceName` as NULL.
- To use a virtual card, set `deviceName` as the name of the virtual card.

#### **Improvements**

##### 1. Improves the accuracy of the call quality statistics

v2.3.2 deprecates the `audioQualityOfUid` callback and replaces it with the `remoteAudioStats` callback to improve the accuracy of the call quality statistics. The `remoteAudioStats` callback returns parameters such as the audio frame loss rate, end-to-end audio delay, and jitter buffer delay at the receiver, which are more closely linked to the real-user experience. In addition, v2.3.2 optimizes the algorithm of the `networkQuality` callback for the uplink and downlink network qualities.

- [`remoteAudioStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStats:): Reports the statistics of the remote audio stream from each user/host. This callback replaces the onAudioQuality callback. 
- [`networkQuality`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:networkQuality:txQuality:rxQuality:): Reports the last mile network quality of each user in the channel.

Agora plans to improve the following callback in subsequent versions:

- [`lastmileQuality`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileQuality:): Reports the last mile network quality of the local user before the user joins a channel.

For the list of API methods related to the call quality statistics and on how and when to use them, see [Report In-call Statistics](in-call_quality_apple).

##### 2. New network connection policy

v2.3.2 adds the following API method and callback to get the current network connection state and the reason for a connection state change:

- [`getConnectionState`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getConnectionState): Gets the connection state of the SDK.
- [`connectionChangedToState`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:): Occurs when the connection state of the SDK to the server changes.

v2.3.2 deprecates the [`rtcEngineConnectionDidInterrupted`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngineConnectionDidInterrupted:) and [`rtcEngineConnectionDidBanned`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngineConnectionDidBanned:) callbacks.

In the new API method, the network connection states are "disconnected", "connecting", "connected", "reconnecting", and "failed". The SDK triggers the `connectionChangedToState` callback when the network connection state changes. The SDK also triggers the `rtcEngineConnectionDidInterrupted` and `rtcEngineConnectionDidBanned` callbacks under certain circumstances, but we do not recommend using them.

##### 3. Improves the call rating system

v2.3.2 changes the rating parameter in the [`rate`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/rate:rating:description:) method to "1 to 5" to encourage more feedback from end-users on the quality of a call or interactive live streaming. You can use this feedback for future product improvement. We strongly recommend integrating this method in your application.

##### 4. Other improvements

- Minimizes packet loss under unreliable network conditions in the `LiveBroadcasting` profile.
- Accelerates the video quality recovery under network congestion.
- Optimizes the API calling threads.
- Checks the headset and Bluetooth device connection.
- Reduces the audio delay.
- Optimizes video capture methods on macOS and reduces performance loss.

#### **Issues fixed**

The following issues are fixed in v2.3.2:

##### SDK

- Crashes on macOS.

##### Audio

- A user joins the interactive live streaming with a Bluetooth headset. The audio is not played through the Bluetooth headset when the user leaves the channel and opens another application.
- Crashes when calling the `startAudioMixing` method to play music files.
- A previously disabled microphone becomes enabled when the device connects to a headset.
- Cannot adjust the volume of the speaker when users change roles, join and leave channels, or a system phone or Siri interrupts.
- Users do not hear any voice for a while when an application switches back from the background. 

##### Video

- The users on the Web client cannot see the video sent from the Native client due to codec bugs.
- Occasional issues when using an external video source.
- The cursor on the remote side is not in the same position as the local side when sharing the desktop.

#### **API changes**

To improve your experience, we made the following changes to the APIs:

##### Added

- [`setVideoEncoderConfiguration`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoEncoderConfiguration:)
- [`setLocalPublishFallbackOption`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalPublishFallbackOption:)
- [`setRemoteSubscribeFallbackOption`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteSubscribeFallbackOption:)
- [`getConnectionState`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getConnectionState)
- [`adjustAudioMixingPlayoutVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPlayoutVolume:)
- [`adjustAudioMixingPublishVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingPublishVolume:)
- [`connectionChangedToState`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:)
- [`didLocalPublishFallbackToAudioOnly`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didLocalPublishFallbackToAudioOnly:)
- [`didRemoteSubscribeFallbackToAudioOnly`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didRemoteSubscribeFallbackToAudioOnly:byUid:)
- [`remoteAudioStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteAudioStats:)
- [`audioTransportStatsOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:audioTransportStatsOfUid:delay:lost:rxKBitRate:)
- [`videoTransportStatsOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:videoTransportStatsOfUid:delay:lost:rxKBitRate:)

##### Deprecated

- [`setVideoProfile`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoProfile:swapWidthAndHeight:)
- [`audioQualityOfUid`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:audioQualityOfUid:quality:delay:lost:)
- [`rtcEngineConnectionDidInterrupted`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngineConnectionDidInterrupted:)
- [`rtcEngineConnectionDidBanned`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngineConnectionDidBanned:)

**v2.2.3**

v2.2.3 is released on July 5, 2018. 

> The security keys are improved and updated in v2.1.0. If you are using an Agora SDK version earlier than v2.1.0 and wish to migrate to the latest version, see [Token Migration Guide](/en/Agora%20Platform/token_migration).

#### **Issues Fixed**

- Occasional online statistics crashes.
- Occasional crashes during the interactive live streaming.
- Excessive increase in the memory usage when multiple delegated hosts start streaming in the channel.
- Occasional video freeze after a view size change.
- Failing to report the uid and volume of the speaker in a channel.

**v2.2.2**

v2.2.2 is released on June 21, 2018.

#### **Issues fixed**

- Fixed occasional online statistics crashes.
- Fixed the issue of failing to report the uid and volume of the speaker in a channel.
- Fixed the issue of occasional video freeze after a view size change.

**v2.2.1**

v2.2.1 is released on May 30th, 2018 and improves the internal code implementation.

**v2.2.0**

v2.2.0 is released on May 4, 2018. 

#### **New features**

##### 1. Play the audio effect in the channel

Adds a <code>publish</code> parameter in the <code>playEffect</code> method to enable the remote user in the channel to hear the audio effect played locally. 

> If your SDK is upgraded to v2.2 from a previous version, pay attention to the functional changes of this API.

##### 2. Deploy the proxy at the server

We provide a proxy package for enterprise users with corporate firewalls to deploy before accessing our services. 

##### 3. Get the remote video state

Adds the <code>remoteVideoStateChangedOfUid</code> method to get the state of the remote video stream. 

##### 4. Add watermarks on the interactive video streaming

Adds the watermark function for users to add a PNG file to the local or RTMP streaming as a watermark. Adds the <code>addVideoWatermark</code> and <code>clearVideoWatermarks</code> methods to add and delete watermarks in the interactive video streaming. Adds the <code>watermark</code> parameter in the <code>LiveTranscording</code> interface to add watermarks in RTMP streaming. 

#### **Improvements**

##### 1. Audio volume indication

Improves the <code>enableAudioVolumeIndication</code> method. This method once enabled, sends the audio volume indication of the speaker in its callback at set intervals, regardless of whether anyone is speaking in the channel.

##### 2. Network quality detection during a session

To meet the customers’ need for real-time network quality detection in the channel, the <code>onNetworkQuality</code> method improves its data accuracy. 

##### 3. Last mile network quality detection before joining a channel

To test if the customers’ network condition can support voice or video calls before joining the channel, the <code>onLastmileQuality</code> callback changes its detection from a fixed bitrate to the bitrate set by the customer in <code>videoProfile</code> to improve data accuracy. When the network condition is unknown, the SDK still triggers this callback once every 2 seconds. 

##### 4. Audio Quality Enhancement

Improves the audio quality in scenarios that involve music playback.

#### **Issues fixed**

- Occasional crashes on the macOS device.
- Occasional screen display abnormalities when a large number of audience members join as the host in an interactive streaming channel.

**v2.1.3**

v2.1.3 is released on April 19, 2018. 

In v2.1.3, we updated the bitrate values of the <code>setVideoProfile</code> method in the `LiveBroadcasting` profile. The bitrate values in v2.1.3 stay consistent with those in v2.0. 

#### **Issues fixed**

- Block callbacks are occasionally not received if the delegate is not set.
- NSAssertionHandler appears in external links to the SDK.
- Occasional recording failures on some phones when a user leaves a channel and turns on the built-in recording device.

#### **Improvements**

Improves the performance of screen sharing by shortening the time interval between which users switch from screen sharing to the normal `Communication` or `LiveBroadcasting` profile.

**v2.1.2**

v2.1.2 is released on April 2, 2018. 

> If you upgraded the SDK to v2.1.2 from a previous version, the `LiveBroadcasting` video quality will be better than the `Communication` video quality in the same resolutions, resulting in the live broadcasts using more bandwidth. 

#### **New features**

Extends the <code>setVideoProfile</code> method to enable users to manually set the resolution, frame rate, and bitrate of the video. 

#### **Issues fixed**

The video resolution of the shared screen is worse in the `Communication` profile than in `LiveBroadcasting` profile.

**v2.1.1**

v2.1.1 is released on March 16, 2018. 

We identified a critical bug in SDK v2.1. Upgrade to v2.1.1 if you are using the Agora SDK v2.1.

**v2.1.0**

V2.1.0 is released on March 7, 2018. 

#### **New features**

##### 1. Voice optimization

Adds a scenario for the game chat room to reduce the bandwidth and cancel the noise with the <code>setAudioProfile</code> method.

##### 2. Enhances the audio effect input from the built-in microphone

In an interactive streaming, the host can enhance the local audio effects from the built-in microphone with the <code>setLocalVoiceEqualization</code> and <code>setLocalVoiceReverb</code> methods by implementing the voice equalization and reverberation effects.

##### 3. Online statistics query

Adds RESTful APIs to check the status of the users in the channel, the channel list of a specific company, and whether the user is an audience or a host:

- Voice or video calls: See [Online Statistics Query API](/en/API%20Reference/dashboard_restful_communication).
- Interactive streaming: See [Online Statistics Query API](/en/API%20Reference/dashboard_restful_live).

##### 4. 17-way Video

Adds the support of 17-way video in interactive streaming, see:

- [Start Live interactive streaming](start_live_mac)
- [Video Conference of 7+ Users](multi_user_video_apple)

##### 5. Video source customization

Supports the default video-capturing features provided by the camera and the customized video source. 

##### 6. Renderer customization

Supports the default functions provided by the renderers to display the local and remote videos to meet your requirements. We provide a set of interfaces for customized renderers. 

##### 7. Screen sharing for interactive streaming

- Before v2.1.0: The Agora SDK only supported the screen-sharing function in video calls
- From v2.1.0: The Agora SDK added the screen-sharing function in interactive streaming.

#### **Improvements**

<table>
<colgroup>
<col/>
<col/>
</colgroup>
<thead>
<tr><th>Improvement</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr><td>Video Freeze Rate</td>
<td>Reduces the video freeze rate in the audience mode and for specific devices.</td>
</tr>
<tr><td>Authentication</td>
<td>Supports a new authentication mechanism. Each legacy Dynamic Key (Channel Key) corresponds to a single privilege (for example, joining a channel), but each token in the new authentication mechanism includes all privileges (for example, joining a channel, hosting in, and stream-pushing).</td>
</tr>
<tr><td>Billing Optimization</td>
<td>Small video resolutions are charged according to voice-only mode. For example, 16 x 16.</td>
</tr>
<tr><td>API Naming Optimization</td>
<td>Modifies a set of names for the API attributes and enumeration values.</td>
</tr>
</tbody>
</table>



**v2.0.2**

v2.0.2 is released on December 15, 2017 and fixes the FFmpeg symbol conflict.


**v2.0**

v2.0 is released on December 6, 2017. 

#### New features

- Adds the <code>setRemoteVideoStreamType</code> and <code>enableDualStreamMode</code> methods in the `Communication` profile to support dual streams.

- Updates the following callbacks for audio mixing and sound effects:

  <table>
  <colgroup>
  <col/>
  <col/>
  </colgroup>
  <thead>
  <tr><th>Name</th>
  <th>Description</th>
  </tr>
  </thead>
  <tbody>
  <tr><td><code>rtcEngineMediaEngineDidAudioMixingFinish</code></td>
  <td>Removed. Replaced by rtcEngineLocalAudioMixingDidFinish.</td>
  </tr>
  <tr><td><code>rtcEngineDidAudioEffectFinish</code></td>
  <td>Added. Notifies the app when the local audio effect playback stops.</td>
  </tr>
  <tr><td><code>rtcEngineRemoteAudioMixingDidStart</code></td>
  <td>Added. Notifies the app when the remote user starts audio mixing.</td>
  </tr>
  <tr><td><code>rtcEngineRemoteAudioMixingDidFinish</code></td>
  <td>Added. Notifies the app when the remote user stops audio mixing.</td>
  </tr>
  </tbody>
  </table>

- Adds the camera management function in the `Communication` and `LiveBroadcasting` profiles by adding the following API methods:

  <table>
  <colgroup>
  <col/>
  <col/>
  </colgroup>
  <tbhead>
  <tr><th>Name</th>
  <th>Description</th>
  </tr>
  </thead>
  <tbody>
  <tr><td><code>isCameraZoomSupported</code></td>
  <td>Checks whether the device supports camera zoom.</td>
  </tr>
  <tr><td><code>isCameraTorchSupported</code></td>
  <td>Checks whether the device supports camera flash.</td>
  </tr>
  <tr><td><code>isCameraFocusPositionInReviewSupported</code></td>
  <td>Checks whether the device supports camera manual focus.</td>
  </tr>
  <tr><td><code>isCameraAutoFocusFaceModeSupported</code></td>
  <td>Checks whether the device supports camera auto-face focus.</td>
  </tr>
  <tr><td><code>setCameraZoomFactor</code></td>
  <td>Sets the camera zoom ratio.</td>
  </tr>
  <tr><td><code>setCameraFocusPositionInPreview</code></td>
  <td>Sets the position for manual focus and activates focusing.</td>
  </tr>
  <tr><td><code>setCameraTorchOn</code></td>
  <td>Sets the device to turn on the camera flash.</td>
  </tr>
  <tr><td><code>setCameraAutoFocusFaceModeEnabled</code></td>
  <td>Sets the device to start auto-face focusing.</td>
  </tr>
  </tbody>
  </table>



- Supports the external audio source in the `Communication` and `LiveBroadcasting` profiles by adding the following API methods:

  <table>
  <colgroup>
  <col/>
  <col/>
  </colgroup>
  <thead>
  <tr><th>Name</th>
  <th>Description</th>
  </tr>
  </thead>
  <tbody>
  <tr><td><code>enableExternalAudioSourceWithSampleRate</code></td>
  <td>Enables the external audio source.</td>
  </tr>
  <tr><td><code>disableExternalAudioSource</code></td>
  <td>Disables the external audio source.</td>
  </tr>
  <tr><td><code>pushExternalAudioFrameRawData</code></td>
  <td>Pushes the external audio frame to the Agora SDK.</td>
  </tr>
  </tbody>
  </table>



- Provides a set of RESTful APIs to ban a peer user from the server in the `Communication` and `LiveBroadcasting` profiles. Contact [support@agora.io](mailto:support@agora.io) to enable this function, if required.

#### Issues fixed

Audio routing and Bluetooth issues.

**v1.14**

v1.14 is released on October 20, 2017. 

#### New features

- Adds the <code>setAudioProfile</code> method to set the audio parameters and scenarios.
- Adds the <code>setLocalVoicePitch</code> method to set the local voice pitch.
- `LiveBroadcasting`: Adds the <code>setInEarMonitoringVolume</code> method to adjust the volume of the in-ear monitor.

#### Improvements

- Optimizes the audio at high bitrates.
- `LiveBroadcasting`: The audience can view the host within one second in a single-stream mode (858 ms on average, and 625 ms in good network conditions).
- Adds the ability to reduce the bandwidth.
  - Before v1.14: If you muted the audio of a specific user, the network still sent the stream.
  - Starting from v1.14: If you mute the audio of a specific user, the network will not send the stream of the user to reduce the bandwidth.
- Accurate control over the bitrate:
  - Before v1.14: Inaccurate control over the bitrate often caused huge fluctuations, leading to network congestion and higher rates of packet and frame loss. This affected the accuracy of the bandwidth estimation module, especially when the network was in poor conditions.
  - Starting from v1.14: Accurate control over the bitrate prevents huge fluctuations avoiding network congestion and shortening the transmission latency.

**v1.13.1**

v1.13.1 is released on September 28, 2017 and optimizes the echo issue under certain circumstances.

**v1.13**

v1.13 is released on September 4, 2017. 

#### New features

- Adds the function to dynamically enable and disable acquiring the sound card in the interactive live streaming.
- Adds the function to disable the audio playback.
- Adds the module map for the SDK, which means bridging header files are not necessary for Swift projects.
- Supports the profile configuration for stream-pushing on the client side.
- Adds the <code>didClientRoleChanged</code> callback to indicate a user role change between the host and audience in the interactive live streaming.
- Supports the push-stream failure callback on the server side.

#### Improvements:

- Screen Sharing: Enhances the video definition and fluency.
- Screen Sharing: Supports updating the captured region dynamically.
- The video profile is controllable by the software codec.

#### Issues fixed:

Occasional crashes on some devices.

**v1.12**

v1.12  is released on July 25, 2017. 

#### New functions:

- Adds the <code>injectStream</code> method to inject an RTMP stream into the current channel in the `LiveBroadcasting` profile.
- Adds the <code>aes-128-ecb</code> encryption mode in the `setEncryptionMode` method.
- Adds the <code>quality</code> parameter in the <code>startAudioRecording</code> method to set the recording audio quality.
- Adds a set of API methods to manage the audio effect.
- Adds the <code>ActiveSpeaker</code> method to report on the active speaker in the current channel.
- Removes the <code>setScreenCaptureWindow</code> method, and updates the <code>startScreenCapture</code> method to share the whole screen and specify the window or region in the `Communication` profile.
- Adds displaying the mouse function when the screen-sharing function is enabled in the `Communication` profile.

#### Improvements:

In the `Communication` profile, the 320 &times; 180 resolution profile is improved.

- Keeps the video smooth under poor network and equipment conditions.
- Enhances the image quality to be better than 180p under good network and equipment conditions.

#### Issues fixed:

Occasional crashes.