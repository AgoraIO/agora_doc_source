---
title: Release Notes
platform: Android
updatedAt: 2021-03-29 03:54:19
---
This page provides the release notes for the Agora Video SDK for Android.

## Overview

The Agora Video SDK supports the following scenarios:

-   Voice and Video Call
-   Live Interactive Video and Audio Streaming

For the key features included in each scenario, see [Agora Voice Call Overview](https://docs.agora.io/en/Voice/product_voice?platform=All%20Platforms), [Agora Video Call Overview](https://docs.agora.io/en/Video/product_video?platform=All%20Platforms), [Agora Live Interactive Audio Streaming Overview](https://docs.agora.io/en/Audio%20Broadcast/product_live_audio?platform=All_Platforms), and [Agora Live Interactive Video Streaming Overview](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=All%20Platforms).

#### Known Issues and Limitations

##### Privacy changes
If your app targets Android 9, you should keep the following behavior changes in mind. These updates to device serial and DNS information enhance user privacy.

**Build serial number deprecation**

In Android 9, `Build.SERIAL` is always set to "UNKNOWN" to protect users' privacy.
If your app needs to access a device's hardware serial number, you should instead request the READ_PHONE_STATE permission, then call `getSerial()`.

**DNS privacy**

Apps targeting Android 9 should honor the private DNS APIs. In particular, apps should ensure that, if the system resolver is doing DNS-over-TLS, any built-in DNS client either uses encrypted DNS to the same hostname as the system, or is disabled in favor of the system resolver.

For more information about privacy changes, see [Android Privacy Changes](https://developer.android.com/about/versions/pie/android-9.0-changes-28#privacy-changes-p).

## v3.2.0
v3.2.0 was released on October 23, 2020.

**Compatibility changes**

#### 1. Integration change

Since v3.2.0, the following files have been added to the SDK package:

- `libagora-fdkaac.so`: The Fraunhofer FDK AAC dynamic library.
- `libagora-mpg123.so`: The mpg123 dynamic library.
- `libagora-soundtouch.so`: The SoundTouch dynamic library.
- `libagora-ffmpeg.so`: The FFmpeg dynamic library.

If you upgrade the SDK to v3.2.0 or later, ensure that you have copied the above files to the folder where the `libagora-rtc-sdk.so` file is located.

#### 2. Security and compliance

Agora has passed ISO 27001, ISO 27017, and ISO 27018 international certifications, providing safe and reliable real-time interactive cloud services for users worldwide. See [ISO Certificates](https://docs.agora.io/en/Agora%20Platform/iso_cert?platform=All%20Platforms#iso-27018-认证).

This release supports transport layer encryption by adding TLS (Transport Layer Security) and UDP (User Datagram Protocol) encryption methods.

> Transport layer encryption affects the following indicators:
>
> - Size of the SDK package: For details, see *Product Overview*.
> - The rendering time of the first video frame: The rendering time (median) of the first video frame increases by 0 ~ 70 ms compared to that in v3.1.0.

#### 3. Cloud proxy

To improve user experience, this release optimizes the Agora cloud proxy architecture. If you upgrade the SDK to v3.2.0 or later, you need to reconfigure IP addresses and ports. See [Cloud Proxy](./cloudproxy_native).

**Improvements**

#### 1. Meeting scenario

To improve the user experience in the meeting scenario, this release adds the following:

- Audio profile: To improve the audio experience for multi-person meetings, this release adds `AUDIO_SCENARIO_MEETING(8)` in `setAudioProfile`.

#### 2. Voice beautifier and audio effects

To improve the usability of the APIs related to voice beautifier and audio effects, this release deprecates `setLocalVoiceChanger` and `setLocalVoiceReverbPreset`, and adds the following methods instead:

- `setVoiceBeautifierPreset`: Compared with `setLocalVoiceChanger`, this method deletes audio effects such as a little boy’s voice and a more spatially resonant voice.
- `setAudioEffectPreset`: Compared with `setLocalVoiceReverbPreset`, this method adds audio effects such as the 3D voice, the pitch correction, a little boy’s voice and a more spatially resonant voice.
- `setAudioEffectParameters`: This method sets detailed parameters for a specified audio effect. In this release, the supported audio effects are the 3D voice and pitch correction.

#### 3. Interactive streaming delay

This release reduces the delay of audio and video from a local user's capturing to a remote user's rendering during interactive streaming by about 500 ms.

**Issues fixed**

#### Audio

- Occasional audio sampling issues with Xiaomi speakers.

#### Video

- When a remote user called with vivo X30, the local user saw a black screen.
- On iPhone 5s and iPhone 6, after the user enabled the basic image enhancement function, the screen flickered when users switched between apps.
- When a remote user frequently joined and left a channel on an Android TV, the local user occasionally saw a black screen.

**API changes**

#### Added

- [`setAudioEffectPreset`](./API%20Reference/java/v3.2.0/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af12f990d231904787e1cfc3d9097af04)
- [`setVoiceBeautifierPreset`](./API%20Reference/java/v3.2.0/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a5977ae8d823d23314faab78fa1a72a29)
- [`setAudioEffectParameters`](./API%20Reference/java/v3.2.0/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a62beca2921fbd86a9b0041a051d8564e)
- [`AUDIO_SCENARIO_MEETING`](/API%20Reference/java/v3.2.0/classio_1_1agora_1_1rtc_1_1_constants.html#a085184565a4807f7e2b4d0fc0beaa1d6)(8)

#### Deprecated

- [`setLocalVoiceChanger`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ade6883c7878b7a596d5b2563462597dd)
- [`setLocalVoiceReverbPreset`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a10dd25bc8e129512cd6727133b7fc42f)
## v3.1.3

v3.1.3 was released on October 13, 2020. This release fixed the occasional crashes when leaving a channel.

## v3.1.2
v3.1.2 was released on September 14, 2020. This release fixed the following issues:

- When you use MediaIO to switch to a different video source, the screen gets frozen.
- The `onFirstLocalVideoFrame` and `onFirstRemoteVideoFrame` callbacks are not triggered at the right time.


## v3.1.1
v3.1.1 was released on August 27, 2020. This release changes the `AreaCode` for regional connection. The latest area codes are as follows:

- `AREA_CODE_CN`: Mainland China.
- `AREA_CODE_NA`: North America.
- `AREA_CODE_EU`: Europe.
- `AREA_CODE_AS`: Asia, excluding Mainland China.
- `AREA_CODE_JP`: Japan.
- `AREA_CODE_IN`: India.
- `AREA_CODE_GLOB`: (Default) Global.

If you have specified a region for connection when calling [`create`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a45832a91b1051bc7641ccd8958288dba), ensure that you use the latest area code when migrating from an earlier SDK version.

## v3.1.0
v3.1.0 was released on August 11, 2020.

**New features**

#### 1. Publishing and subscription states

This release adds the following callbacks to report the current publishing and subscribing states:

- `onAudioPublishStateChanged`: Reports the change of the audio publishing state.
- `onVideoPublishStateChanged`: Reports the change of the video publishing state.
- `onAudioSubscribeStateChanged`: Reports the change of the audio subscribing state.
- `onVideoSubscribeStateChanged`: Reports the change of the video subscribing state.

#### 2. First local frame published callback

This release adds the `onFirstLocalAudioFramePublished` and `onFirstLocalVideoFramePublished` callbacks to report that the first audio or video frame is published. The `onFirstLocalAudioFrame` callback is deprecated from v3.1.0.

#### 3. Support for TextureView

This release adds the `CreateTextureView` method to return the Android `TextureView`, enabling you to zoom, rotate, and move the video view. This feature applies to scenarios such as screen sharing. You can use either `CreateRendererView` or `CreateTextureView` to implement a video scenario according to your needs.

#### 4. Custom data report

This release adds the `sendCustomReportMessage` method for reporting customized messages. To try out this function, contact [support@agora.io](mailto:support@agora.io) and discuss the format of customized messages with us.

**Improvement**

#### 1. Regional connection

This release adds the following regions for regional connection. After you specify the region for connection, your app that integrates the Agora SDK connects to the Agora servers within that region.

- `AREA_CODE_JAPAN`: Japan.
- `AREA_CODE_INDIA`: India.

#### 2. Advanced screen sharing

This release adds the following callbacks in the `IVideoSource` interface for screen sharing:

- `getCaptureType`: Gets the capture type of the custom video source.
- `getContentHint`: Gets the content hint of the custom video source.

#### 3. CDN live streaming

This release adds the `onRtmpStreamingEvent` callback to report events during CDN live streaming, such as failure to add a background image or watermark image.

#### 4. Encryption

This release adds the `enableEncryption` method for enabling built-in encryption, and deprecates the following methods:

- `setEncryptionSecret`
- `setEncryptionMode`

#### 5. More in-call statistics

This release adds the following attributes to provide more in-call statistics:

- Adds `txPacketLossRate` in `LocalAudioStats`, which represents the audio packet loss rate (%) from the local client to the Agora edge server before applying anti-packet loss strategies.
- Adds the following attributes in `LocalVideoStats`: 
    - `txPacketLossRate`: The video packet loss rate (%) from the local client to the Agora edge server before applying anti-packet loss strategies.
    - `captureFrameRate`: The capture frame rate (fps) of the local video.
- Adds `publishDuration` in `RemoteAudioStats` and `RemoteVideoStats`, which represents the total publish duration (ms) of the remote media stream.

#### 6. Audio profile

To improve audio performance, this release adjusts the maximum audio bitrate of each audio profile as follows:

| Profile                                   | v3.1.0                                                       | Earlier than v3.1.0                                          |
| :---------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| `AUDIO_PROFILE_DEFAULT`                   | <li>For the interactive streaming profile: 64 Kbps</li><li>For the communication profile: 18 Kbps</li> | <li>For the interactive streaming profile: 52 Kbps</li><li>For the communication profile: 18 Kbps</li> |
| `AUDIO_PROFILE_SPEECH_STANDARD`           | 18 Kbps                                                      | 18 Kbps                                                      |
| `AUDIO_PROFILE_MUSIC_STANDARD`            | 64 Kbps                                                      | 48 Kbps                                                      |
| `AUDIO_PROFILE_MUSIC_STANDARD_STEREO`     | 80 Kbps                                                      | 56 Kbps                                                      |
| `AUDIO_PROFILE_MUSIC_HIGH_QUALITY`        | 96 Kbps                                                      | 128 Kbps                                                     |
| `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO` | 128 Kbps                                                     | 192 Kbps                                                     |

#### 7. Log files

This release increases the default number of log files that the Agora SDK outputs from 2 to 5, and increases the default size of each log file from 512 KB to 1024 KB. By default, the SDK outputs five log files, `agorasdk.log`, `agorasdk_1.log`, `agorasdk_2.log`, `agorasdk_3.log`, `agorasdk_4.log`. The SDK writes the latest logs in `agorasdk.log`. When `agorasdk.log` is full, the SDK deletes the log file with the earliest modification time among the other four, renames `agorasdk.log ` to the name of the deleted log file, and creates a new `agorasdk.log` to record the latest logs.

#### 8. In-ear monitoring improvement on OPPO models (Android)

This release reduces the delay of in-ear monitoring on the following OPPO models:

- Reno4 Pro 5G
- Reno4 5G 

#### 9. Others

- Reduces the audio delay.
- Reduces the playback time of the first remote audio frame.

**Issues fixed**

This release fixed the following issues:

- `setAudioMixingPitch` did not work when setting the `pitch` parameter to certain values.
- Occasional video freeze.
- Occasional crashes when using external video source.

**API changes**

#### Added

- [`onAudioPublishStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a19d2c72ed37bc3c1e8fbb9744060cec8)
- [`onVideoPublishStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a180eb7fcfd46e28b0eca70c074f58b1d)
- [`onAudioSubscribeStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a3fdd1d93b146c58e7bf69f36766b2f3a)
- [`onVideoSubscribeStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a6a8e37eb47679d0b8a49c792e031fa06)
- [`onFirstLocalAudioFramePublished`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a94c87921fc48dbd80048efc785270808)
- [`onFirstLocalVideoFramePublished`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#af06bd501878b9d594d406497fdf1db89)
- [`CreateTextureView`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ae12df01b67f756ce4abdeba4b08242e4)
- [`enableEncryption`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8d283886c17dbd2555e1f967c7faff2d)
- [`txPacketLossRate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_audio_stats.html#a3f39c69e3a02c05044603b28da879e9c) in `LocalAudioStats`
- [`txPacketLossRate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#a5aabe8c34e6e59808808fb7e688e01d8) and [`captureFrameRate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#ae60a432682957ff8d4d2cddf359d84d7) in `LocalVideoStats`
- `publishDuration` in [`RemoteAudioStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_audio_stats.html#ad56757c408074784356bbfac47f58af2) and [`RemoteVideoStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html#a85301bc33f0169afe6d66177d8cae9fe)
- [`getCaptureType`](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1mediaio_1_1_i_video_source.html#a6e0bc3921a9c1a076a63d3ab5eeaf236) and [`getContentHint`](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1mediaio_1_1_i_video_source.html#a34f90e4af3735c9542ca8e4d439fe25c) callbacks in `IVideoSource`
- [`onRtmpStreamingEvent`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a2c26ecc40133c2bb18b30f4752edc61c)
- Error code: [`ERR_NO_SERVER_RESOURCES(103)`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#ab0e9fe12b5357df5f03019d084183799)
- Warning code:
  - [`WARN_ADM_RECORD_IS_OCCUPIED(1033)`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#adead939e929d2a89b458ae7ece72f797)
  - [`WARN_ADM_RECORD_ABNORMAL_FREQUENCY(1021)`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#a1c0d1e891192c8a37a59cb9f32b7ba64)
  - [`WARN_ADM_PLAYOUT_ABNORMAL_FREQUENCY(1020)`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#a67dfe3691ed974e46f6f37cb696b01b3)
  - [`WARN_APM_RESIDUAL_ECHO(1053)`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#a449523bb31a7ce15f38006531244d537)

#### Deprecated

- `setEncryptionSecret`
- `setEncryptionMode`
- `onFirstLocalAudioFrame`

## v3.0.1.1
v3.0.1.1 was released on Jun 18, 2020. This release fixed the following issues:

- Crashes on x86 phones running on Android 6 and later.
- Crashes after calling `registerVideoRenderFactory` (deprecated).
- The image enhancement feature does not work.
- Occasional failures to capture the external video source.

## v3.0.1

v3.0.1 was released on May 27, 2020.

**Compatibility changes**

#### Frame position for the video observer (C++)

As of this release, to get the video frame from the `onPreEncodeVideoFrame` callback, you must set `POSITION_PRE_ENCODER(1<<2)` in [`getObservedFramePosition`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#ad4c174389264630ffb1b2d24c6030013) as the frame position to observe, as well as implementing the `onPreEncodeVideoFrame` callback.

**New features**

#### 1. Audio mixing pitch

To set the pitch of the local music file during audio mixing, this release adds `setAudioMixingPitch`. You can set the `pitch` parameter to increase or decrease the pitch of the music file. This method sets the pitch of the local music file only. It does not affect the pitch of a human voice.

#### 2. Voice enhancement

To improve the audio quality, this release adds the following enumerate elements in `setLocalVoiceChanger` and `setLocalVoiceReverbPreset`:

- `VOICE_CHANGER_PRESET` adds several elements that have the prefixes `VOICE_BEAUTY` and `GENERAL_BEAUTY_VOICE`. The `VOICE_BEAUTY` elements enhance the local voice, and the `GENERAL_BEAUTY_VOICE` enumerations add gender-based enhancement effects.
- `AUDIO_REVERB_PRESET` adds the enumeration `AUDIO_VIRTUAL_STEREO` and several enumerations that have the prefix `AUDIO_REVERB_FX`. The `AUDIO_VIRTUAL_STEREO` enumeration implements reverberation in the virtual stereo, and the `AUDIO_REVERB_FX` enumerations implement additional enhanced reverberation effects.

See [Set the Voice Changer and Reverberation Effects](./voice_changer_android) for more information.

#### 3. Face detection

This release enables local face detection. After you call `enableFaceDetection` to enable this function, the SDK triggers the `onFacePositionChanged` callback in real time to report the detection results, including the distance between the human face and the device screen. This function can remind users to keep a certain distance from the screen.

#### 4. Fill mode

To improve the user experience of watching videos, this release adds a video display mode `RENDER_MODE_FILL`. This mode zooms and stretches the video to fill the display window. You can select this mode when calling the following methods:

- `setupLocalVideo`
- `setupRemoteVideo`
- `setLocalRenderMode`
- `setRemoteRenderMode`

#### 5. Remote video renderer in multiple channels

This release adds `setRemoteVideoRenderer` in the `RtcChannel` class to enable users who join the channel using the `RtcChannel` object to customize the remote video renderer.

#### 6. Data post-processing in multiple channels (C++)

This release adds support for post-processing remote audio and video data in a multi-channel scenario by adding the following C++ methods:

- The `IAudioFrameObserver` class:  [`isMultipleChannelFrameWanted`](./API%20Reference/cpp/classagora_1_1media_1_1_i_audio_frame_observer.html#a4b6bdf2a975588cd49c2da2b6eff5956) and [`onPlaybackAudioFrameBeforeMixingEx`](./API%20Reference/cpp/v3.0.1/classagora_1_1media_1_1_i_audio_frame_observer.html#ab0cf02ba307e91086df04cda4355905b).
- The `IVideoFrameObserver` class: [`isMultipleChannelFrameWanted`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#aa6bf2611907a097ec359b83f1e3ba49a) and [`onRenderVideoFrameEx`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#ad325db8ee3a04e667e6db3d1a84f381d).

After successfully registering the audio or video observer, if you set the return value of `isMultipleChannelFrameWanted` as `true`, you can get the corresponding audio or video data from `onPlaybackAudioFrameBeforeMixingEx` or `onRenderVideoFrameEx`. In a multi-channel scenario, Agora recommends setting the return value as `true`.

**Improvements**

#### Frame position (C++)

After successfully registering the video observer, you can observe and get the video frame at each node of video processing. To conserve power consumption, this release enables customizing the frame position for the video observer. Set the return value of the [`getObservedFramePosition`](./API%20Reference/cpp/v3.0.1/classagora_1_1media_1_1_i_video_frame_observer.html#ad4c174389264630ffb1b2d24c6030013)  callback to set the position to observe:

- The position after capturing the video frame.
- The position before receiving the remote video frame.
- The position before encoding the frame.

#### Others

- Implements low in-ear device latency on Huawei phones with EMUI v10 and above.
- Improves in-call audio quality. When multiple users speak at the same time, the SDK does not decrease volume of any speaker.
- Reduces overall CPU usage of the device.

**Fixed issues**

- Inaccurate report of the `onRemoteAudioStateChanged` callback, no audio, audio mixing and audio freezing.
- An occasional black screen issue.
- Failure to end a call, inaccurate report of the `onClientRoleChanged` callback, occasional crashes, and interoperability when using encryption.

**API changes**

This release adds the following APIs:

- [`setAudioMixingPitch`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a1ffa38f7445ff0ba71515c931f2f4f6a)
- The enumeration [`AUDIO_VIRTUAL_STEREO`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#a4488f5ef2274a3e2e0dff5721f3bb708) and several elements that have the prefixes [`VOICE_BEAUTY`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#a6e16001b5e0f252460d584131fc11750), [`GENERAL_BEAUTY_VOICE`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#ab77b264331a44b104e5d1b333fc39ed8), and [`AUDIO_REVERB_FX`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_constants.html#a238965ba87ce04aaaa50c45f57c8727d)
- [`enableFaceDetection`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a20ee30231265a5f898384a7974e3f2b1)
- [`onFacePositionChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a629081c0db3ecf7dfc057d5f04598c77)
- [`RENDER_MODE_FILL`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_canvas.html#a80d484794fab78276f5d55d3d95851d8)
- [`setRemoteVideoRenderer`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_channel.html#a25538dc7eb3c2fe34e103f86c555f130) in `RtcChannel`
- [`totalActiveTime`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_audio_stats.html#a18b02fb2d2af40bc0730c2c916a5729d) in `RemoteAudioStats`
- [`totalActiveTime`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html#adc903aec128b9094b5f85b9286d3486a) in `RemoteVideoStats`

## v3.0.0.2

v3.0.0.2 was released on Apr 22, 2020.

**New features**

#### Specify the area of connection

This release adds `create` for specifying the area of connection when creating an `RtcEngine` instance. This advanced feature applies to scenarios that have regional restrictions. You can choose from areas including Mainland China, North America, Europe, Asia (excluding Mainland China), and global (default).

After specifying the area of connection:

- When the app that integrates the Agora SDK is used within the specified area, it connects to the Agora servers within the specified area under normal circumstances.
- When the app that integrates the Agora SDK is used out of the specified area, it connects to the Agora servers either in the specified area or in the area where the SDK is located.

**Issues fixed**

This release fixed the occasional no-audio issue.

**API changes**

#### Added

[`create`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a45832a91b1051bc7641ccd8958288dba)

## v3.0.0

v3.0.0 was released on Mar 4, 2020. 

On Mar 24, 2020, we fixed occasional issues relating to no audio, audio mixing, multiple `onClientRoleChanged` callbacks, and SDK crashes.

In this release, Agora improves the user experience under poor network conditions for both the `COMMUNICATION` and `LIVE_BROADCASTING` profiles through the following measures:

- Adopting a new architecture for the `COMMUNICATION` profile.
- Upgrading the last-mile network strategy for both the `COMMUNICATION` and `LIVE_BROADCASTING` profiles,  which enhances the SDK's anti-packet-loss capacity by maximizing the net bitrate when the uplink and downlink bandwidth are insufficient.

To deal with any incompatibility issues caused by the architecture change, Agora uses the fallback mechanism to ensure that users of different versions of the SDKs can communicate with each other: if a user joins the channel from a client using a previous version, all clients using v3.0.0 automatically fall back to the older version. This has the effect that none of the users in the channel can enjoy the improved experience. Therefore we strongly recommend upgrading all your clients to v3.0.0.

We also upgrade the On-premise Recording SDK to v3.0.0. Ensure that you upgrade your On-premise Recording SDK to v3.0.0 so that all users can enjoy the improvements brought by the new architecture and network strategy.

**Compatibility changes**

#### 1. Dual-stream mode not enabled in the `COMMUNICATION` profile

As of v3.0.0, the native SDK does not enable the [dual-stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-dualadual-stream-mode) by default in the `COMMUNICATION` profile. Call the [`enableDualStreamMode (true)`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a645cb7d0f3a59dda27b157cf130c8c9a) method after joining the channel to enable it. In video scenarios with multiple users, we recommend enabling the dual-stream mode.

#### 2. Default log file path change

To avoid privilege issues, this release changes the default log file path from `/storage/emulated/0/<package name>/` to `/storage/emulated/0/Android/data/<package name>/files/`.

**New features**

#### 1. Multiple channel management

To enable a user to join an unlimited number of channels at a time, this release adds the [`RtcChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_channel.html) and [`IRtcChannelEventHandler`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_channel_event_handler.html) classes. By creating multiple `RtcChannel` objects, a user can join the corresponding channels at the same time.

After joining multiple channels, users can receive the audio and video streams of all the channels, but publish one stream to only one channel at a time. This feature applies to scenarios where users need to receive streams from multiple channels, or frequently switch between channels to publish streams. See [Join multiple channels](multiple_channel_android) for details.

#### 2. Raw video data
Adds the following C++ callbacks to the [`IVideoFrameObserver`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html) class to provide raw video data at different video transmission stages, and to accommodate more scenarios.

- [`onPreEncodeVideoFrame`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a2be41cdde19fcc0f365d4eb14a963e1c): Gets the video data after pre-processing and prior to encoding. This method applies to the scenarios where you need to pre-process the video data.
- [`getSmoothRenderingEnabled`](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#aaa6c67373bb237a067318015749e8e51): Sets whether to smooth the acquired video frames. The smoothed video frames are more evenly spaced, providing a better rendering experience.

#### 3. Adjusting the playback volume of the specified remote user

Adds [`adjustUserPlaybackSignalVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aac9c5135996428d9a238fe8e66858268) for adjusting the playback volume of a specified remote user. You can call this method as many times as necessary in a call or the live interactive streaming to adjust the playback volume of different remote users, or to repeatedly adjust the playback volume of the same remote user.

#### 4. Agora Mediaplayer Kit

To enrich the playability of the live interactive streaming, Agora releases the Mediaplayer Kit plug-in, which supports the host playing local or online media resources and sharing them with all users in the channel during the live interactive streaming. See [Mediaplayer Kit release notes](https://docs.agora.io/en/Interactive%20Broadcast/mediaplayer_release_android?platform=Android) for details.

**Improvements**

#### 1. Audio profiles

To meet the need for higher audio quality, this release adjusts the corresponding audio profile of `AUDIO_PROFILE_DEFAULT (0)` in the `LIVE_BROADCASTING` profiles.

| SDK | AUDIO_PROFILE_DEFAULT (0) | 
| ---------------- | ---------------- | 
| v3.0.0      | A sample rate of 48 KHz, music encoding, mono, and a bitrate of up to 52 Kbps.     | 
| Earlier than v3.0.0   | A sample rate of 32 KHz, music encoding, mono, and a bitrate of up to 44 Kbps.   |

#### 2. Mirror mode

The mirror mode determines how the SDK mirrors the video in different stages of transmission. To improve user experience with the mirror mode, this release updates the following methods:

- Setting a mirror mode for the stream to be encoded: This release adds the `mirrorMode` member to the [`VideoEncoderConfiguration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html) struct for setting a mirror effect for the stream to be encoded and transmitted.
- Setting a mirror mode for the streams to be rendered: 
	- We add the `mirrorMode` member to the [`VideoCanvas`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_canvas.html) struct. You can use [`setupLocalVideo`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a1fa43a5ce24196e840bcb1062cadbf23) to set the mirror effect for the local view or use [`setupRemoteVideo`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0e9f693c9bc2ccb91554c2c7dc6b7140) to set the mirror effect for the remote view.
	- This release also adds the  [`setLocalRenderMode`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8978be2e06307e632abee88c4824b8f6) and [`setRemoteRenderMode`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a5a8498025206a5680ef391c4e812f45f) methods, both of which take an extra `mirrorMode` parameter. During a call, you can use `setLocalRenderMode` to update the mirror effect of the local view or `setRemoteRenderMode` to update the mirror effect of the remote view on the local device.

#### 3. Quality statistics

Adds the following members in the [`RtcStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html) class for providing more in-call statistics, making it easier to monitor the call quality and memory usage in real time:

- `gatewayRtt`
- `memoryAppUsageRatio`
- `memoryTotalUsageRatio`
- `memoryAppUsageInKbytes`

#### Others

This release enables interoperability between the RTC Native SDK and the RTC Web SDK by default, and deprecates the `enableWebSdkInteroperability` method. 

**Issues fixed**

- Audio issues relating to audio mixing, audio encoding, and echoing.
- Video issues relating to the watermark, aspect ratio, video sharpness, black outline appearing while screen sharing and toggling to full-screen.
- Other issues relating to app crashes, log file, and unstable service during CDN live streaming.

**API changes**

#### Behavior change

- Calling `enableLocalAudio`(false) does not change the in-call volume to media volume. 
- When the device is connected to the earpiece or Bluetooth, calling `setEnableSpeakerphone`(true) does not route the audio to the speakerphone.

#### Added

- [`setLocalRenderMode`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8978be2e06307e632abee88c4824b8f6)
- [`setRemoteRenderMode`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a5a8498025206a5680ef391c4e812f45f)
- `mirrorMode` in [`VideoEncoderConfiguration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html)
- `channelId` and `mirrorMode` in [`VideoCanvas`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_canvas.html)
- `channelId` in [`AudioVolumeInfo`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_audio_volume_info.html)
- `gatewayRtt`, `memoryAppUsageRatio`, `memoryTotalUsageRatio`, and `memoryAppUsageInKbytes` in [`RtcStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html)
- [`createRtcChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a9eb0770851a8ba489564f72f9b280bca)
- [`RtcChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_channel.html)
- [`IRtcChannelEventHandler`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_channel_event_handler.html)


#### Deprecated

- `enableWebSdkInteroperability`.
- `setLocalRenderMode¹`, replaced by [`setLocalRenderMode`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8978be2e06307e632abee88c4824b8f6).
- `setRemoteRenderMode¹`, replaced by [`setRemoteRenderMode`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a5a8498025206a5680ef391c4e812f45f).
- `setLocalVideoMirrorMode`, replaced by `mirrorMode` in [`setupLocalVideo`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a1fa43a5ce24196e840bcb1062cadbf23) and [`setupRemoteVideo`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0e9f693c9bc2ccb91554c2c7dc6b7140).
- `onFirstRemoteVideoFrame`, replaced by [`onRemoteVideoStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a93ebe88d2544253bf4b13faf34873131).
- `onUserMuteAudio`, `onFirstRemoteAudioDecoded`, and `onFirstRemoteAudioFrame`, replaced by [`onRemoteAudioStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a24fd6b0d12214f6bc6fa7a9b6235aeff).
- `onStreamPublished` and `onStreamUnpublished`, replaced by [`onRtmpStreamingStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7b9f1a5d87480cfd6187c3da0ade3f94).

## v2.9.4

v2.9.4 was released on Feb 17, 2020.

This release fixed some abnormal behaviors on Android devices.

## v2.9.3

v2.9.3 was released on Feb 10, 2020.

This release fixed the following issues:
- The `setRemoteSubscribeFallbackOption` method, which should work in the `LIVE_BROADCASTING` profiles only, also works in the `COMMUNICATION` profile.
- In some one-to-one communication, the downlink media stream falls back to audio-only under poor network conditions.
- On some devices, the camera fails to capture the video after a system upgrade. 

## v2.9.2

v2.9.2 is released on Oct 18, 2019.

This release fixed crashes on some Android device.

## v2.9.1

v2.9.1 is released on Sep 19, 2019.

**New features**

#### 1. Detecting local voice activity
This release adds the `report_vad`(bool) parameter to the [enableAudioVolumeIndication](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aaec0b8db9458b45d14cdcb3003f76fbe) method to enable local voice activity detection. Once it is enabled, you can check the [AudioVolumeInfo](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_audio_volume_info.html) struct of the `onAudioVolumeIndication` callback for the voice activity status of the local user.

#### 2. Choosing front and rear cameras
Users can select the front or rear camera before joining a channel. This release adds the [cameraDirection](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_camera_capturer_configuration.html#a9d3182d0003faf617125a4f9b1a12d54) member variable to the [CameraCapturerConfiguration](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_camera_capturer_configuration.html) class to accomplish this. Choose the front or rear camera by selecting `CAMERA_FRONT (1)` or `CAMERA_REAR (0)` respectively.

#### 3. Supporting RGBA raw video data
This release supports RGBA raw video data. Use the C++ method [getVideoFormatPreference](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a440e2a33140c25dfd047d1b8f7239369) to set the format of the raw video data format.

You can also rotate or mirror the RGBA raw data using the C++ methods [getRotationApplied](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#afd5bb439a9951a83f08d8c0a81468dcb) or [getMirrorApplied](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#afc5cce81bf1c008e9335a0423ca45991) methods respectively.

#### 4. Removing the event handler
This release adds the [removeHandler](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a5e807ee4302756e6912a4fd1ed7a0db3) method to remove specified IRtcEngineEventHandler objects when you want to stop listening for specific events.

**Improvements**

#### 1. Improving the watermark function in the live interactive streaming
This release adds a new [addVideoWatermark](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a63d94cda85b76e77b9016bbdac04a32d) method with the following settings:

- The `visiblePreview` member sets whether the watermark is visible in the local preview.
- The `positionInLandscapeMode`/`positionInPortraitMode` member sets the watermark position when the encoding video is in landscape/portrait mode.

This release optimizes the watermark function, reducing the CPU usage by 5% to 20%.

The original `addVideoWatermark` method is deprecated.

#### 2. Supporting more audio sample rates for recording
To enable more audio sample rate options for recording, this release adds a new [startAudioRecording](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ac2ad403a7a75617316673f251615ef92) method with a `sampleRate` parameter. In the new method, you can set the sample rate as 16, 32, 44.1 or 48 kHz. The original method supports only a fixed sample rate of 32 kHz and is deprecated.

#### 3. Adding error codes

This release adds the following error codes in the ErrorCode class:

- `ERR_ALREADY_IN_USE(19)`
- `ERR_WATERMARK_PATH(125)`
- `ERR_INVALID_USER_ACCOUNT(134)`
- `ERR_AUDIO_BT_SCO_FAILED(1030)`
- `ERR_ADM_NO_RECORDING_DEVICE(1359)`
- `ERR_VCM_UNKNOWN_ERROR(1600)`
- `ERR_VCM_ENCODER_INIT_ERROR(1601)`
- `ERR_VCM_ENCODER_ENCODE_ERROR(1602)`
- `ERR_VCM_ENCODER_SET_ERROR(1603)`

For detailed descriptions for each error, see [Error Codes](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_error_code.html).

**Issues fixed**

#### Audio
- A user makes a call after connecting to a Bluetooth device. After the call ends, the user watches YouTube and cannot hear any sound.
- The audio route is different from the settings in the `setEnableSpeakerphone` method when Bluetooth is connected in the `COMMUNICATION` profile.
- Exceptions occur in the audio route when a user is in the channel.
- The app crashes when using external audio sources in the push mode. 
- Audio freezes.
- After turning off the Bluetooth headset, the audio route becomes the earpiece instead of the loudspeaker.
- Echos occur when a user is in the channel.
- Occasional noise occurs in the `LIVE_BROADCASTING` profile.
- The app fails to play online music files using the `startAudioMixing` method on devices running Android 10.

#### Miscellaneous

- The OpenSSL version is outdated.

**API Changes**

#### Added

- [startAudioRecording](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ac2ad403a7a75617316673f251615ef92)
- [addVideoWatermark](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a63d94cda85b76e77b9016bbdac04a32d)
- [getVideoFormatPreference](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#a440e2a33140c25dfd047d1b8f7239369)
- [getRotationApplied](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#afd5bb439a9951a83f08d8c0a81468dcb)
- [getMirrorApplied](./API%20Reference/cpp/classagora_1_1media_1_1_i_video_frame_observer.html#afc5cce81bf1c008e9335a0423ca45991)
- [removeHandler](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a5e807ee4302756e6912a4fd1ed7a0db3)
- The `report_vad` parameter in [enableAudioVolumeIndication](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aaec0b8db9458b45d14cdcb3003f76fbe)
- The `vad` member in [AudioVolumeInfo](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_audio_volume_info.html) 
- The `cameraDirection` member in [CameraCapturerConfiguration](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_camera_capturer_configuration.html) 

#### Deprecated

- `startAudioRecording`
- `addVideoWatermark`


## v2.9.0

v2.9.0 is released on Aug 16, 2019.

**Compatibility changes**

#### 1. RTMP streaming

In this release, we deleted the following methods:

- `configPublisher`
- `setVideoCompositingLayout`
- `clearVideoCompositingLayout`

If your app implements RTMP streaming with the methods above, ensure that you upgrade the SDK to the latest version and use the following methods for the same function:

- [`setLiveTranscoding`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a3cb9804ae71819038022d7575834b88c)
- [`addPublishStreamUrl`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a4445b4ca9509cc4e2966b6d308a8f08f)
- [`removePublishStreamUrl`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a87b3f2f17bce8f4cc42b3ee6312d30d4)
- [`onRtmpStreamingStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7b9f1a5d87480cfd6187c3da0ade3f94)

For how to implement the new methods, see [Push Streams to the CDN](cdn_streaming_android).

#### 2. Reporting the state of the remote video

This release extends the [`onRemoteVideoStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a93ebe88d2544253bf4b13faf34873131) callback with more states of the remote video: STOPPED(0), STARTING(1), DECODING(2), FROZEN(3), and FAILED(4). It adds a reason parameter to the callback to indicate why the remote video state changes. The original `onRemoteVideoStateChanged` callback is deleted. If you upgrade your Native SDK to the latest version, ensure that you re-implement the `onRemoteVideoStateChanged` callback.

The new callback reports most of the remote video states, and therefore deprecates the following callbacks. You can still use them, but we do not recommend doing so.

- [`onUserEnableVideo`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#af87247218ec1ef398a9478672ad4dd49)
- [`onUserEnableLocalVideo`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a2640b0eef8b7f1b105c485b4f1c9d8b5)
- [`onFirstRemoteVideoDecoded`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ac7144e0124c3d8f75e0366b0246fbe3b)

<div class="alert note">The triggering timing of the new callback is different from the old one. The new <code>onRemoteVideoStateChanged</code> callback is triggered only when the remote video state has changed.</div>

#### 3. Disabling/enabling the local audio

To improve the audio quality in the `COMMUNICATION` profile, this release sets the system volume to the media volume after you call the `enableLocalAudio`(true) method. Calling `enableLocalAudio`(false) switches the system volume back to the in-call volume.

**New features**

#### 1. Faster switching to another channel

This release adds the  [`switchChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a72f13225defc1b14dfb29820a0495da2) method to enable the audience in a live-streaming channel to quickly switch to another channel. With this method, you can achieve a much faster switch than with the `leaveChannel` and `joinChannel` methods. After the audience successfully switches to another channel by calling the `switchChannel` method, the SDK triggers the `onLeaveChannel` and `onJoinChannelSuccess` callbacks to indicate that the audience has left the original channel and joined a new one. 

#### 2. Channel media stream relay

This release adds the following methods to relay the media streams of a host from a source channel to a destination channel. This feature applies to scenarios such as online singing contests, where hosts of different live-streaming channels interact with each other.

- [`startChannelMediaRelay`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6f09ba685f8ab01d7dc06173286950f6)
- [`updateChannelMediaRelay`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#abd40d706379d27cf617376a504f394bd)
- [`stopChannelMediaRelay`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0f9f19e48c21190dd4e697dec632c328)

During the media stream relay, the SDK reports the states and events of the relay with the [`onChannelMediaRelayStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a89fd95b3536e8e6afd5f001926162f66) and [`onChannelMediaRelayEvent`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a6fe2367e9ea61e48a4cc3b373d198b54) callbacks.

For more information on the implementation, API call sequence, sample code, and considerations, see [Co-host across Channels](media_relay_android).

#### 3. Reporting the local and remote audio state

This release adds the [`onLocalAudioStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a59946a989f87c737899e2284539adf09) and [`onRemoteAudioStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a24fd6b0d12214f6bc6fa7a9b6235aeff) callbacks to report the local and remote audio states. With these callbacks, the SDK reports the following states for the local and remote audio:

- The local audio: STOPPED(0), RECORDING(1), ENCODING(2), or FAILED(3). When the state is FAILED(3), see the `error` parameter for troubleshooting.
- The remote audio: STOPPED(0), STARTING(1), DECODING(2), FROZEN(3), or FAILED(4). See the `reason` parameter for why the remote audio state changes.

#### 4. Reporting the local audio statistics

This release adds the [`onLocalAudioStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aeba2aa3fc29404fc6f25bff5c00bfdf9) callback to report the statistics of the local audio during a call, including the number of channels, the sending sample rate, and the average sending bitrate of the local audio.

#### 5. Pulling the remote audio data

To improve the experience in audio playback, this release adds the following methods to pull the remote audio data. After getting the audio data, you can process it and play it with the audio effects that you want.

- [`setExternalAudioSink`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a270c0607d443790e92cdbd0d45ba1732)
- [`pullPlaybackAudioFrame`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ae15064944870692e9a0a59fdc87654c4)

The difference between the [`onPlaybackFrame`](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_frame_observer.html#a3781dd30d34a0634140872a9dd131488) callback and the `pullPlaybackAudioFrame` method is as follows:

- `onPlaybackFrame`: The SDK sends the audio data to the app once every 10 ms. Any delay in processing the audio frames may result in an audio delay.
- `pullPlaybackAudioFrame`: The app pulls the remote audio data. After setting the audio data parameters, the SDK adjusts the frame buffer and avoids problems caused by jitter in external audio playback.

**Improvements**

#### 1. Reporting more statistics of the in-call quality

This release adds the following statistics in the `RtcStats`, `LocalVideoStats`, and `RemoteVideoStats` classes:

- [`RtcStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html): The total number of the sent audio bytes, sent video bytes,  received audio bytes, and received video bytes during a session.
- [`LocalVideoStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html): The encoding bitrate, the width and height of the encoding frame, the number of frames, and the codec type of the local video.
- [`RemoteVideoStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html): The packet loss rate of the remote video.

#### 2. Improving the video quality of the live streaming

This release minimizes the video freeze rate under poor network conditions, improves the video sharpness, and optimizes the video smoothness when the packet loss rate is high.

#### 3. Other Improvements

- Reduces the earpiece delay.
- Improves the audio quality when the audio scenario is set to Game Streaming.
- Improves the audio quality after the user disables the microphone in the `COMMUNICATION` profile.

**Issues fixed**

#### Audio

- When interoperating with a Web app, voice distortion occurs after the native app enables the remote sound position indication.
- The audience cannot hear the host after the host sets the in-ear monitoring volume to 0.
- Failure to play the audio file by calling the `startAudioMixing` method. 
- The audio route cannot be set to Bluetooth on some devices.
- Crashes occur when using the raw audio data.
- The audio route does not conform to the default settings after the device disconnects from Bluetooth.

#### Video

- Occasional crashes occur when using the external video source.
- The audience sees a black screen for the host's view.

#### Miscellaneous

- Occasionally mixed streams in CDN streaming. 
- Occasional crashes occur after joining the channel on some devices.

**API Changes**

To improve the user experience, we made the following changes in v2.9.0:

#### Added

- [`setExternalAudioSink`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a270c0607d443790e92cdbd0d45ba1732)
- [`pullPlaybackAudioFrame`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ae15064944870692e9a0a59fdc87654c4)
- [`onLocalAudioStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a59946a989f87c737899e2284539adf09)
- [`onRemoteAudioStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a24fd6b0d12214f6bc6fa7a9b6235aeff)
- [`onRemoteVideoStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a93ebe88d2544253bf4b13faf34873131)
- [`onLocalAudioStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aeba2aa3fc29404fc6f25bff5c00bfdf9)
- [`switchChannel`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a72f13225defc1b14dfb29820a0495da2)
- [`startChannelMediaRelay`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6f09ba685f8ab01d7dc06173286950f6)
- [`updateChannelMediaRelay`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#abd40d706379d27cf617376a504f394bd)
- [`stopChannelMediaRelay`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0f9f19e48c21190dd4e697dec632c328)
- [`onChannelMediaRelayStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a89fd95b3536e8e6afd5f001926162f66)
- [`onChannelMediaRelayEvent`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a6fe2367e9ea61e48a4cc3b373d198b54)
- [`RtcStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html): `txAudioBytes`, `txVideoBytes`, `rxAudioBytes`, and `rxVideoBytes`
- [`LocalVideoStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html): `encodedBitrate`, `encodedFrameWidth`, `encodedFrameHeight`, `encodedFrameCount`, and `codedType`
- [`RemoteVideoStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html): `packetLossRate`

#### Deprecated

- `onMicrophoneEnabled`. Use LOCAL_AUDIO_STREAM_STATE_CHANGED(0) or LOCAL_AUDIO_STREAM_STATE_RECORDING(1) in the [`onLocalAudioStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aeba2aa3fc29404fc6f25bff5c00bfdf9) callback instead. 
- `onRemoteAudioTransportStats`. Use the [`onRemoteAudioStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a9eaf8021d6f0c97d056e400b50e02d54) callback instead.
- `onRemoteVideoTransportStats`. Use the [`onRemoteVideoStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#abb7af6e2827bbd03c6ab8338a0f616ca) callback instead.
- `onUserEnableVideo`. Use the [`onRemoteVideoStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a93ebe88d2544253bf4b13faf34873131) callback with the following parameters instead:
	- REMOTE_VIDEO_STATE_STOPPED(0) and REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED(5).
	- REMOTE_VIDEO_STATE_DECODING(2) and REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED(6).

- `onUserEnableLocalVideo`. Use the [`onRemoteVideoStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a93ebe88d2544253bf4b13faf34873131) callback with the following parameters instead:
	- REMOTE_VIDEO_STATE_STOPPED(0) and REMOTE_VIDEO_STATE_REASON_REMOTE_MUTED(5).
	- REMOTE_VIDEO_STATE_DECODING(2) and REMOTE_VIDEO_STATE_REASON_REMOTE_UNMUTED(6).

- `onFirstRemoteVideoDecoded`. Use REMOTE_VIDEO_STATE_STARTING(1) or REMOTE_VIDEO_STATE_DECODING(2) in the [`onRemoteVideoStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a93ebe88d2544253bf4b13faf34873131) callback instead.

#### Deleted

- `configPublisher`
- `setVideoCompositingLayout`
- `clearVideoCompositingLayout`
- `onRemoteVideoStateChanged`


## v2.8.2

v2.8.2 is released on Aug 1, 2019. 

This release fixed the interoperating problem with the Agora Web SDK.

## v2.8.1

v2.8.1 is released on Jul. 20, 2019.

**New features**

- Support for the x86-64 architecture.
- Support for Android Q.

## v2.8.0

v2.8.0 is released on Jul. 8, 2019.

**New features**

#### 1. Supporting string user IDs

Many apps use string user IDs. This release adds the following methods to enable apps to join an Agora channel directly with string user IDs as user accounts:

- [registerLocalUserAccount](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa37ea6307e4d1513c0031084c16c9acb)
- [joinChannelWithUserAccount](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a310dbe072dcaec3892c4817cafd0dd88)

For other methods, Agora uses the integer uid parameter. The Agora Engine maintains a mapping table that contains the user ID and string user account, and you can get the corresponding user account or ID by calling the getUserInfoByUid or getUserInfoByUserAccount method.

To ensure smooth communication, use the same parameter type to identify all users within a channel, that is, all users should use either the integer user ID or the string user account to join a channel. 

**Note**:
- Do not mix parameter types within the same channel. The following Agora SDKs support string user accounts:
	- The Native SDK: v2.8.0 and later.
	- The Web SDK: v2.5.0 and later.

 If you use SDKs that do not support string user accounts, only integer user IDs can be used in the channel.
- If you change your user IDs into string user accounts, ensure that all app clients are upgraded to the latest version.
- If you use string user accounts, ensure that the token generation script on your server is updated to the latest version. If you join the channel with a user account, ensure that you use the same user account or its corresponding integer user ID to generate a token. Call the `getUserInfoByUserAccount` method to get the user ID that corresponds to the user account.

#### 2. Adding remote audio and video statistics

To monitor the audio and video transmission quality during a call or the live interactive streaming , this release adds the `totalFrozenTime` and `frozenRate` members in the [RemoteAudioStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_audio_stats.html) and [RemoteVideoStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html) classes, to report the audio and video freeze time and freeze rate of the remote user.

This release also adds the `numChannels`, `receivedSampleRate`, and `receivedBitrate` members in the [RemoteAudioStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_audio_stats.html) class.

**Improvements**

This release adds a `CONNECTION_CHANGED_KEEP_ALIVE_TIMEOUT(14)` member to the `reason` parameter of the [onConnectionStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a31b2974a574ec45e62bb768e17d1f49e) callback. This member indicates a connection state change caused by the timeout of the connection keep-alive between the SDK and Agora's edge server.


**Issues Fixed**

#### Audio

- Occasional audio freezes. 

#### Video

- When the user resumes receiving the remote video streams, the video stream switches to a low stream (low-resolution and low-bitrate video stream), and takes a long time to switch to a high stream.

#### Miscellaneous

- When the log file path specified in the `setLogFile` method does not exist, no log file is generated and the default log file is incomplete.

**API Changes**

To improve your experience, we made the following changes to the APIs:

#### Added

- [registerLocalUserAccount](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa37ea6307e4d1513c0031084c16c9acb)
- [joinChannelWithUserAccount](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a310dbe072dcaec3892c4817cafd0dd88)
- [getUserInfoByUid](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a9a787b8d0784e196b08f6d0ae26ea19c)
- [getUserInfoByUserAccount](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#afd4119e2d9cc360a2b99eef56f74ae22)
- [onLocalUserRegistered](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aca1987909703d84c912e2f1e7f64fb0b)
- [onUserInfoUpdated](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aa3e9ead25f7999272d5700c427b2cb3d)
- The `numChannels`, `receivedSampleRate`, `receivedBitrate`, `totalFrozenTime`, and `frozenRate` members in the [RemoteAudioStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_audio_stats.html) class
- The `totalFrozenTime` and `frozenRate` members in the [RemoteVideoStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html) class

#### Deprecated

- The lowLatency member in the [LiveTranscoding](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding.html) class


## v2.4.1
v2.4.1 is released on Jun 12, 2019.

**Compatibility changes**

Ensure that you read the following SDK behavior changes if you migrate from an earlier SDK version.

#### 1. Publishing streams to the CDN

To improve the usability of the CDN streaming service, v2.4.1 defines the following parameter limits:

| Class **/** Interface  | Parameter Limit                                              |
| ---------------------- | ------------------------------------------------------------ |
| [LiveTranscoding](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding.html)        | <li>[videoFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding.html#a514340a98a537fdc4f91003aed2068a6): Frame rate (fps) of the CDN live output video stream. The value range is [0, 30], and the default value is 15. Agora adjusts all values over 30 to 30.<li>[videoBitrate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding.html#a514340a98a537fdc4f91003aed2068a6): Bitrate (Kbps) of the CDN live output video stream. The default value is 400. Set this parameter according to the [Video Bitrate Table](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a4b090cd0e9f6d98bcf89cb1c4c2066e8). If you set a bitrate beyond the proper range, the SDK automatically adapts it to a value within the range.<li>[videoCodecProfile](./API%20Reference/java/enumio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding_1_1_video_codec_profile_type.html): The video codec profile. Set it as **BASELINE**, **MAIN**, or **HIGH** (default). If you set this parameter to other values, Agora adjusts it to the default value of **HIGH**.<li>[width](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding.html#a514340a98a537fdc4f91003aed2068a6) and [height](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding.html#a80960c1a972e9b3851fd16d921f8a75c): Pixel of the video. The minimum value of width x height is 16 x 16.</li> |
| [AgoraImage](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_agora_image.html)             | `url`: The maximum length of this parameter is **1024** bytes. |
| [addPublishStreamUrl](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a4445b4ca9509cc4e2966b6d308a8f08f)    | `url`: The maximum length of this parameter is **1024** bytes. |
| [removePublishStreamUrl](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a4445b4ca9509cc4e2966b6d308a8f08f) | `url`: The maximum length of this parameter is **1024** bytes. |

This release also adds the [audioCodecProfile](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding.html#ac7d4a839af2994e68d8f14544d323ae9) parameter in the `LiveTranscoding` class to set the audio codec profile type. The default type is LC-AAC, which means the low-complexity audio codec profile.

v2.4.1 also adds five error codes to the `error` parameter in the [onStreamPublished](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7b9f1a5d87480cfd6187c3da0ade3f94) method for quick troubleshooting.

#### 2. Renaming the receivedFrameRate parameter in the RemoteVideoStats class

v2.4.1 renames the `receivedFrameRate` parameter to [rendererOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html#aa09441cb1b9a0f4318cd59b0ca5b3ffb) in the  [RemoteVideoStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html) class to more accurately describe the statistics of the remote video stream.

**New features**

#### 1. Adding media metadata

In live streaming scenarios, the host can send shopping links, digital coupons, and online quizzes to the audience for more diversified live interactions. v2.4.1 adds the  [registerMediaMetadataObserver](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aeb1a5691094a10cb047d106d6c6c32b7) interface and the [IMediaMetadataObserver](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_metadata_observer.html) class, allowing the host to add metadata to the output video and to send media attached information.

#### 2. State of the local video

v2.4.1 adds the [onLocalVideoStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aface271c0606ab99bb08a0d00267306c) callback to indicate the local video state. In this callback, the SDK returns the `STOPPED`,` CAPTURING`, `ENCODING`, or `FAILED` state. When the state is `FAILED`, you can use the error code for troubleshooting. This callback indicates whether or not the interruption is caused by capturing or encoding. This release deprecates the `onCameraReady` and `onVideoStopped` callbacks.

#### 3. State of the RTMP streaming

v2.4.1 adds the [onRtmpStreamingStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7b9f1a5d87480cfd6187c3da0ade3f94) callback to indicate the state of the RTMP streaming and help you troubleshoot issues when exceptions occur. In this callback, the SDK returns the IDLE, `CONNECTING`, `RUNNING`, `RECOVERING`, or `FAILURE` state. When the state is `FAILURE`, you can use the error code for troubleshooting. You can still use the `onStreamPublished` and `onStreamUnpublished` callbacks, but we do not recommend using them.

#### 4. More reasons for a network connection state change

In the [onConnectionStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a31b2974a574ec45e62bb768e17d1f49e) callback, v2.4.1 adds error codes to the `reason` parameter to help you troubleshoot issues when exceptions occur. The SDK returns the `onConnectionStateChanged` callback whenever the connection state changes. This release also deprecates `WARN_LOOK_UP_CHANNEL_REJECTED(105)`, `ERR_TOKEN_EXPIRED(109)`, and `ERR_INVALID_TOKEN(110)`.

#### 5. State of the local network type 

v2.4.1 adds the  [onNetworkTypeChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a75b014a87d0ead6cd4fa519a630f6f90) callback to indicate the local network type. In this callback, the SDK returns the `UNKNOWN`, `DISCONNECTED`, `LAN`, `WIFI`, `2G`, `3G`, or `4G` type. When the network connection is interrupted, this callback indicates whether or not the interruption is caused by a network type change or poor network conditions.

#### 6. Getting the audio mixing volume

v2.4.1 adds the [getAudioMixingPlayoutVolume](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6eef6e4d3d148c25993376f93ebbb8e9) and [getAudioMixingPublishVolume](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a962819abd0e5458b89cefb756bb9e631) methods, which respectively gets the audio mixing volume for local playback and remote playback, to help you troubleshoot audio volume related issues.

#### 7. Reporting when the first remote audio frame is received and decoded

To get the more accurate time of the first audio frame from a specified remote user, v2.4.1 adds the  [onFirstRemoteAudioDecoded](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a0fcac6cafae63e4ef453ddd041e80f8a) callback to report to the app that the SDK decodes first remote audio. This callback is triggered in either of the following scenarios:

- The remote user joins the channel and sends the audio stream.
- The remote user stops sending the audio stream and re-sends it after 15 seconds.

The difference between the onFirstRemoteAudioDecoded and `onFirstRemoteAudioFrame` callbacks is that the `onFirstRemoteAudioFram`e callback occurs when the SDK receives the first audio packet. It occurs before the `onFirstRemoteAudioDecoded` callback.

**Improvements**

#### 1. Playing multiple online audio effect files simultaneously

v2.4.1 adds the support for playing multiple online audio effect files simultaneously by allowing you to call the [playEffect](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_audio_effect_manager.html#a6fd330db3e3e5735f7f8d5c36bc3fea1) method multiple times with the URLs of the online audio effect files.

#### 2. Reporting more statistics

- v2.4.1 adds the [txPacketLossRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html#a6b0c3798427c6bf07b829896e29ace5e) and [rxPacketLossRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html#a72df02822bfcc37dfcdb543fd2ba46af) parameters in the [RtcStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html) class. These parameters return the packet loss rate from the local client to the server and vice versa.

- To provide more accurate statistics of the local and remote video, v2.4.1 makes the following changes to the following classes:
  - [LocalVideoStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html): Adds the  [encoderOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#af6350acef5578bf0501a234fc36d86a3) and [rendererOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#aa754035a384b502a45c6fed6f17038da) parameters.
  - [RemoteVideoStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html): Adds the[decoderOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html#aafc03c6a890c36dc9810537c47ce0cd9) parameter, and renames the `receivedFrameRate` parameter to the [rendererOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html#aa09441cb1b9a0f4318cd59b0ca5b3ffb) parameter.

#### 3. Image enhancement

v2.4.1 assigns default values to various parameters in the [BeautyOptions](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_beauty_options.html) class to improve the image enhancement experience. This release also optimizes the image enhancement algorithm. Test results from Agora Lab suggest that the updated algorithm leads to lower GPU and CPU consumption. The power consumption is optimized by over 30%.

#### 4. Miscellaneous

- Improved the sound quality of the [GAME_STREAMING](./API%20Reference/java/enumio_1_1agora_1_1rtc_1_1_constants_1_1_audio_scenario.html#aedcb78447298f4794ba8df7a72d71909) audio scenario.
- Reduced the audio and video latency.
- Reduced the SDK package size by 0.5 M.
- Improved the accuracy of the network quality after users change the video bitrate.
- Enabled the audio quality notification callback by default, that is, enabled the [onRemoteAudioStats](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a9eaf8021d6f0c97d056e400b50e02d54) callback without calling the `enableAudioVolumeIndication` method.
- Improved the stability of video services.
- Improved the stability of CDN streaming services.

**Issues fixed**

#### Audio

- The audio stream is played through the loudspeaker even after the user plugs in the earphone. 
- The user cannot hear the audio mixing file through Bluetooth in the single-host scenario.
- Exceptions occur when playing the audio mixing file in the `LIVE_BROADCASTING` profile.

#### Video

- In the `LIVE_BROADCASTING` profile, the view of the host is a black screen.

#### Miscellaneous

- Users still receive the `onNetworkQuality` callback after leaving the channel.
- Occasional crashes.
- The app quits after calling `joinChannel`.

**API changes**

To improve your experience, we made the following changes to the APIs:

#### Unified the C++ interface for all platforms

v2.4.1 unifies the behavior of the C++ interfaces across different platforms so that you can apply the same code logic on different platforms. v2.4.1 implements the methods of the `RtcEngineParameters` class in the `IRtcEngine` class. Refer to [Agora C++ API Reference for All Platforms home page](./API%20Reference/cpp/index.html) for the applicable platforms and considerations of each interface.

#### Added

- [getAudioMixingPlayoutVolume](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6eef6e4d3d148c25993376f93ebbb8e9)
- [getAudioMixingPublishVolume](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a962819abd0e5458b89cefb756bb9e631)
-  [onFirstRemoteAudioDecoded](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a0fcac6cafae63e4ef453ddd041e80f8a)
- [onLocalVideoStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aface271c0606ab99bb08a0d00267306c)
- [onNetworkTypeChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a75b014a87d0ead6cd4fa519a630f6f90)
- [onRtmpStreamingStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7b9f1a5d87480cfd6187c3da0ade3f94)
- [registerMediaMetadataObserver](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aeb1a5691094a10cb047d106d6c6c32b7)
- The [IMetadataObserver](./API%20Reference/java/interfaceio_1_1agora_1_1rtc_1_1_i_metadata_observer.html) class
- The  [audioCodecProfile](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1live_1_1_live_transcoding.html#ac7d4a839af2994e68d8f14544d323ae9) parameter in the `LiveTranscoding` class
- The [txPacketLossRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html#a6b0c3798427c6bf07b829896e29ace5e) and [rxPacketLossRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_rtc_stats.html#a72df02822bfcc37dfcdb543fd2ba46af) parameters in the `RtcStats` class
- The [encoderOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#af6350acef5578bf0501a234fc36d86a3) and [rendererOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#aa754035a384b502a45c6fed6f17038da) parameters in the `LocalVideoStats` class
- The [decoderOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html#aafc03c6a890c36dc9810537c47ce0cd9) and [rendererOutputFrameRate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_remote_video_stats.html#aa09441cb1b9a0f4318cd59b0ca5b3ffb) parameters in the `RemoteVideoStats` class

#### Deprecated

- `enableAudioQualityIndication`
- `onCameraReady`. Use LOCAL_VIDEO_STREAM_STATE_CAPTURING(1) in the [onLocalVideoStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aface271c0606ab99bb08a0d00267306c) callback instead.
- `onVideoStopped`. Use in LOCAL_VIDEO_STREAM_STATE_STOPPED(0) the [onLocalVideoStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aface271c0606ab99bb08a0d00267306c)  callback instead.
- The `WARN_LOOKUP_CHANNEL_REJECTED(105)` warning code. Use CONNECTION_CHANGED_REJECTED_BY_SERVER(10) in the [onConnectionStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a31b2974a574ec45e62bb768e17d1f49e) callback instead.
- The `ERR_TOKEN_EXPIRED(109)` error code. Use CONNECTION_CHANGED_TOKEN_EXPIRED(9) in the [onConnectionStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a31b2974a574ec45e62bb768e17d1f49e) callback instead.
- The `ERR_INVALID_TOKEN(110)` error code. Use CONNECTION_CHANGED_INVALID_TOKEN(8) in the [onConnectionStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a31b2974a574ec45e62bb768e17d1f49e) callback instead.
- The `ERR_START_CAMERA(1003)` error code. Use LOCAL_VIDEO_STREAM_ERROR_CAPTURE_FAILURE(4) in the [onLocalVideoStateChanged](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aface271c0606ab99bb08a0d00267306c)  callback instead.


## v2.4.0 and Earlier

**v2.4.0**

v2.4.0 is released on April 1, 2019.

##### New Features

##### 1. Image enhancement

In scenarios such as the video chat, interactive streaming, and online education, basic beautification is a popular feature. v2.4.0 adds the [`setBeautyEffectOptions`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa9327de4fb0c29f840b1e68ca2e83fc6) method, allowing you to adjust the contrast, brightness, smoothness and red saturation of an image. For more information, see [Image Enhancement](image_enhancement_android).

##### 2. Voice changer and voice reverberation

Adding voice changer and reverberation effects in an audio chat room brings much more fun. v2.4.0 adds the [`setLocalVoiceChanger`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ade6883c7878b7a596d5b2563462597dd) and [`setLocalVoiceReverbPreset`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a10dd25bc8e129512cd6727133b7fc42f) methods, allowing you to change your voice or reverberation by choosing from the preset options. See [Voice changer](voice_changer_android).

##### 3. Tracking the sound position of a remote user 

v2.4.0 adds the [`enableSoundPositionIndication`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aaeb3e1df5d2cb091bd2e9c41f156d3c0) and [`setRemoteVoicePosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a7d851c2cabde18c2438c1ebe8bf763de) methods. Call the [`enableSoundPositionIndication`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aaeb3e1df5d2cb091bd2e9c41f156d3c0) method before joining a channel to enable stereo panning for the remote users, and then you can call the [`setRemoteVoicePosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a7d851c2cabde18c2438c1ebe8bf763de) method to track the position of a remote user.

##### 4. Pre-call last-mile network probe test

Conducting a last-mile probe test before joining the channel helps the local user to evaluate or predict the uplink network conditions. v2.4.0 adds the [`startLastmileProbeTest`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a81c6541685b1c4437d9779a095a0f871), [`stopLastmileProbeTest`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ae21243b8da8bda9ee5f3a00621cbf959), and [`onLastmileProbeResult`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ad74a9120325bfeccdec4af4611110281) APIs, allowing you to get the uplink and downlink last-mile network statistics, including the bandwidth, packet loss, jitter, and round-trip time (RTT).

##### 5. Setting the priority of a remote user's stream

v2.4.0 adds the [`setRemoteUserPriority`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ad4705f9e56f0cf7e0a3e9cbd09ec8f61) method for setting the priority of a remote user's media stream. You can use this method with the [`setRemoteSubscribeFallbackOption`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af64301ea1788dad0561aa678f3fe6ad3) method. If the fallback function is enabled for a remote stream, the SDK ensures the high-priority user gets the best possible stream quality.

##### 6. State of an audio mixing file 

v2.4.0 adds the [`onAudioMixingStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aee0aa9286a39654312b162750713e986) callback to report any change of the audio-mixing file playback state (playback succeeds or fails) and the corresponding reason. This release also adds the warning code 701, which is triggered if the local audio-mixing file does not exist, or if the SDK does not support the file format or cannot access the music file URL when playing the audio-mixing file.

##### 7. Setting the log file size

The SDK has two log files, each with a default size of 512 KB. In case some customers require more than the default size, v2.4.0 adds the [`setLogFileSize`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a50fd37c6f5b8fc144b18ed4620aee6fc) method for setting the log file size (KB).

##### 8. Cloud proxy

Supports the cloud proxy service. See [Use Cloud Proxy](./cloudproxy_native?platform=Android) for details.

#### Improvements

##### 1. Accuracy of call quality statistics

- v2.4.0 adds the `intervalInSeconds` parameter to the [`startEchoTest`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a712bb50be350186d097f4deed8e1aa37) method, allowing you to set the interval between when you speak and when the recording plays back.
- v2.4.0 adds three parameters to the [`LocalVideoStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html) class: [`targetBitrate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#a4e5c046867a773a74096663bd894e843) for setting the target bitrate of the current encoder, [`targetFrameRate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#a01b15bb718064ed086edbafcd1678c9a) for setting the target frame rate, and [`qualityAdaptIndication`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler_1_1_local_video_stats.html#a7a93886b530e5f9ed2fec22ca9d3f5c0) for reporting the quality of the local video since last count.

##### 2. Video encoder preferences

v2.4.0 provides the following options for setting video encoder preferences:

- Setting preferences under limited bandwidth. v2.4.0 adds two parameters to the [`VideoEncoderConfiguration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html) class: [`minFrameRate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#ad8d377cd077587ee0991d297b1a8c8bc) and [`degradationPrefer`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a47f36783c1f9da09454c19cafb489b3c). You can use these parameters together to set the minimum video encoder frame rate and the video encoding degradation preference under limited bandwidth. For more information, see [Set the Video Profile](video_profile_android).

- Setting the camera capture preference. v2.4.0 adds the [`setCameraCapturerConfiguration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab241578c1baf67e68bcabe1a07eb3363) method, allowing you to set the camera capture preference. You can choose system performance over video quality or vice versa as needed. For more information, see the [API Reference](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab241578c1baf67e68bcabe1a07eb3363).

##### 3. Core quality improvements

- Reduces the audio delay.
- Improves the video quality and stability. 
- Shortens the time to render the first remote video frame. 
- Reduces the time delay when playing through the earpiece and minimizes the echo.

#### Issues Fixed

##### Audio

- Calling the `enableLocalAudio` method disconnects all connected Bluetooth devices.
- The SDK does not support audio mixing URLs with Chinese characters.
- Volume levels of the high-pitch sound are lowered.
- Sounds are occasionally played fast.
- The app cannot adjust the volume on some devices.

##### Video

- If you skip the `renderMode` setting, the video stretches due to a mismatch with the display.
- Video freezes on some lower-end devices.
- It takes too long to render the first received video frame.

##### Miscellaneous

- The user drop-offline time between Android and iOS is not unified.
- The SEI information does not synchronize with the media stream when publishing transcoded streams to the CDN.

#### API Changes

To improve your experience, we made the following changes to the APIs:

##### Added

- [`setBeautyEffectOptions`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa9327de4fb0c29f840b1e68ca2e83fc6)
- [`setLocalVoiceChanger`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ade6883c7878b7a596d5b2563462597dd)
- [`setLocalVoiceReverbPreset`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a10dd25bc8e129512cd6727133b7fc42f)
- [`enableSoundPositionIndication`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aaeb3e1df5d2cb091bd2e9c41f156d3c0)
- [`setRemoteVoicePosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a7d851c2cabde18c2438c1ebe8bf763de)
- [`startLastmileProbeTest`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a81c6541685b1c4437d9779a095a0f871)
- [`stopLastmileProbeTest`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ae21243b8da8bda9ee5f3a00621cbf959)
- [`setRemoteUserPriority`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ad4705f9e56f0cf7e0a3e9cbd09ec8f61)
- [`startEchoTest`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a712bb50be350186d097f4deed8e1aa37)
- [`setCameraCapturerConfiguration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab241578c1baf67e68bcabe1a07eb3363)
- [`setLogFileSize`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a50fd37c6f5b8fc144b18ed4620aee6fc)
- [`onAudioMixingStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aee0aa9286a39654312b162750713e986)
- [`onLastmileProbeResult`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ad74a9120325bfeccdec4af4611110281)

##### Deprecated

- `startEchoTest`
- `setVideoQualityParameters`

##### Miscellaneous

v2.4.0 changes the type of the [`frameRate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a8ab46f09a0c6eee1f3f2b6f04efeab2b) parameter in the [`VideoEncoderConfiguration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html) class from `enum` to `int`.


**v2.3.3**

v2.3.3 is released on January 24, 2019. 

#### Issues Fixed

- Occasional inaccurate statistics returned in the `onNetworkQuality` callback.
- Occasional crashes on Huawei P9.

**v2.3.2**

v2.3.2 is released on January 16, 2019.

#### Compatibility changes

Besides the new features and improvements mentioned below, it is worth noting that v2.3.2:

- Improves the SDK's ability to counter packet loss under unreliable network conditions.
- Improves the communication smoothness.
- Reduces video freezes in the `LIVE_BROADCASTING` profile. 

Before upgrading your SDK, ensure that the version is:

- Native SDK v1.11 or later.
- Web SDK v2.1 or later.

#### New Features

##### 1. Automatic exposure at a point of interest

v2.3.2 adds the following methods and callback to support camera exposure and improve the captured video quality: 

- [`isCameraExposurePositionSupported`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6818c2a98bebeb72e4802b1c585da99b): Checks whether the device supports camera exposure.
- [`setCameraExposurePosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0ac20919f60df42635850c53c9cbdefd): Sets the camera exposure position.
- [`onCameraExposureAreaChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ab6bc82a55191e596d5bf5a7c56bdf95e): Occurs when the camera exposure area changes.

You can send the touch point coordinates in the view to the SDK for automatic exposure.

##### 2. Video quality in the live interactive streaming

v2.3.2 adds the [`minBitrate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a9cd44566bc19eca4006fda264ea96dc7) parameter (minimum encoding bitrate) in the [`setVideoEncoderConfiguration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af5f4de754e2c1f493096641c5c5c1d8f) method. The SDK automatically adjusts the encoding bitrate to adapt to the network conditions. Using a value greater than the default value forces the video encoder to output high-quality images but may cause more packet loss and hence sacrifice the smoothness of the video transmission. Agora does not recommend changing this value unless you have special requirements for image quality.

##### 3. Independent audio mixing volume adjustments for local playback and remote publishing

v2.3.2 adds the [`adjustAudioMixingPlayoutVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0308c6bc82af433ae8340e0b3cd228c9) and [`adjustAudioMixingPublishVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a16c4dc66d9c43eef9bee7afc86762c00) methods to complement the [`adjustAudioMixingVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a13c5737248d5a5abf6e8eb3130aba65a) method, allowing you to independently adjust the audio mixing volume for local playback and remote publishing. 

This release also changes the behavior of the [adjustPlaybackSignalVolume](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af7d7f10fc96db2febb9c2590891d071b) method to control only the voice volume. Therefore, to mute the local audio playback, call both the `adjustPlaybackSignalVolume(0)` and `adjustAudioMixingVolume(0)` methods.

See [Adjust the Volume](./volume_android) for the scenarios and corresponding APIs.

#### Improvements

##### 1. Improves the accuracy of the call quality statistics

v2.3.2 deprecates the `onAudioQuality` callback and replaces it with the `onRemoteAudioStats` callback to improve the accuracy of the call quality statistics. The `onRemoteAudioStats` callback returns parameters such as the audio frame loss rate, end-to-end audio delay, and jitter buffer delay at the receiver, which are more closely linked to the real user experience. In addition, v2.3.2 optimizes the algorithm of the `onNetworkQuality` callback for the uplink and downlink network qualities.

- [`onRemoteAudioStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a9eaf8021d6f0c97d056e400b50e02d54): Reports the statistics of the remote audio stream from each user/host. This callback replaces the onAudioQuality callback. 
- [`onNetworkQuality`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a76be982389183c5fe3f6e4b03eaa3bd4): Reports the last mile network quality of each user in the channel.

We plan to improve the following callback in subsequent versions:

- [`onLastmileQuality`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a2887941e3c105c21309bd2643372e7f5): Reports the last mile network quality of the local user before the user joins a channel.

For the list of API methods related to the call quality statistics and on how and when to use them, see [Report In-call Statistics](./in-call_quality_android).

##### 2. New network connection policy 

v2.3.2 adds the following API method and callback to get the current network connection state and the reason for a connection state change:

- [`getConnectionState`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8635e3c9e26ffe95e7ab9a518af533b9): Gets the connection state of the SDK.
- [`onConnectionStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a31b2974a574ec45e62bb768e17d1f49e): Occurs when the connection state of the SDK to the server changes.

v2.3.2 deprecates the [`onConnectionInterrupted`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a0841fb3453a1a271249587fa3d3b3c88) and [`onConnectionBanned`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a80cfde2c8b1b9ae499f6d7a91481c5db) callbacks.

In the new API method, the network connection states are "disconnected", "connecting", "connected", "reconnecting", and "failed". The SDK triggers the `onConnectionStateChanged` callback when the network connection state changes. The SDK also triggers the `onConnectionInterrupted` and `onConnectionBanned` callbacks under certain circumstances, but we do not recommend using them.

##### 3. Improves the call rating system

v2.3.2 changes the rating parameter in the [`rate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ab7083355af531cc43d455024bd1f7662) method to "1 to 5" to encourage more feedback from end-users on the quality of a call or the live interactive streaming. You can use this feedback for future product improvement. We strongly recommend integrating this method in your app.

##### 4. Other improvements

- Minimizes packet loss under unreliable network conditions in the `LIVE_BROADCASTING` profile.
- Accelerates the video quality recovery under network congestion.
- Improves the stability in pushing streams.
- Improves the performance of the SDK on Android 6.0 or later.
- Optimizes the API calling threads.
- Checks the headset and Bluetooth device connection.
- Reduces the audio delay.
- Supports Smartisan camera.

#### Issues Fixed

The following issues are fixed in v2.3.2:

##### SDK

- Crashes on emulators, such as Yeshen and mumu. 
- Crashes on Android 6.0+ due to x86 .so relocation.

##### Audio

- A user joins a live-streaming channel with a Bluetooth headset. The audio is not played through the Bluetooth headset when the user leaves the channel and opens another app.
- Crashes when calling the `startAudioMixing` method to play music files.
- A previously disabled microphone becomes enabled when the device connects to a headset.
- On Huawei Mate 20 X, a remote user cannot hear any voice when the app switches to the background and the user opens another app.
- Echo on Pixel 2.
- Cannot adjust the volume of the speaker when users change roles, join and leave channels, or a system phone or Siri interrupts.
- Users do not hear any voice for a while when an app switches back from the background. 

##### Video

- Occasional issues when using an external video source.
- The cursor on the remote side is not in the same position as the local side when sharing the desktop.

#### API Changes

To improve your experience, we made the following changes to the APIs:

##### Added:

- [`isCameraExposurePositionSupported`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a6818c2a98bebeb72e4802b1c585da99b)
- [`setCameraExposurePosition`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0ac20919f60df42635850c53c9cbdefd)
- [`getConnectionState`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8635e3c9e26ffe95e7ab9a518af533b9)
- [`adjustAudioMixingPlayoutVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a0308c6bc82af433ae8340e0b3cd228c9)
- [`adjustAudioMixingPublishVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a16c4dc66d9c43eef9bee7afc86762c00)
- [`onConnectionStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a31b2974a574ec45e62bb768e17d1f49e)
- [`onCameraExposureAreaChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ab6bc82a55191e596d5bf5a7c56bdf95e)
- [`onRemoteAudioStats`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a9eaf8021d6f0c97d056e400b50e02d54)

##### Deprecated

- [`onAudioQuality`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#abeac442a777e103536dcf9c8ce2d7135)
- [`onConnectionInterrupted`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a0841fb3453a1a271249587fa3d3b3c88)
- [`onConnectionBanned`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a80cfde2c8b1b9ae499f6d7a91481c5db)

**v2.3.1**

v2.3.1 is released on October 12, 2018. 

#### New features

##### Disables/Re-enables the Local Audio Function

When a user joins a channel, the audio function is enabled by default.
To receive audio streams without sending any audio stream after joining a channel, this version adds the `enableLocalAudio` method is to disable or re-enable the local audio function.
Once the local audio function is disabled or re-enabled, the SDK returns the `onMicrophoneEnabled` callback, and the local audio capturing stops.
This method does not affect receiving or playing the remote audio streams.

The difference between this method and the `muteLocalAudioStream` method is that the `enableLocalAudio` method does not capture or send any audio stream, while the `muteLocalAudioStream` method captures but does not send audio streams.


#### Improvements

- Improves the SDK's adaptiveness to the Android video encoder.

#### Issues Fixed

- Occasional crashes when switching between front and rear cameras.
- Occasionally, failing to render the video on some Android devices.
- Occasional image freezes on some Android devices.
- Occasionally on some Android devices, a user hears a popping sound if the user leaves the channel at the same time another user is speaking.
- Communication profile: If a user disables the video and re-enables it during a one-to-one call, it takes a long time for the other user to see the image.
- `LIVE_BROADCASTING` profiles: Delay at the client due to incorrect statistics.
- `LIVE_BROADCASTING` profiles: Occasional crashes on some Android devices after a user repeats the process of switching roles between `BROADCASTER` and `AUDIENCE`.
- The timestamp in the captured raw video frames does not refresh with the frame.

**v2.3.0**

v2.3.0 is released on August 31, 2018.

#### Compatibility changes

-   To support video rotation and enable better quality for the custom video source, this version deprecates the `setVideoProfile` method and uses the `setVideoEncoderConfiguration` method instead to set the video encoding configurations. You can still use the `setVideoProfile` method, but Agora recommends using the `setVideoEncoderConfiguration` method to set the video profile because:
    -   During the live interactive streaming, users can set the video orientation mode as adaptive, under which the SDK can transfer rotated video frames without cropping them, thus avoiding the “big headshot” or blurry images at the player.
    -   In scenarios involving external video sources, the SDK adjusts the width and height of the output video frames based on the inputting video frames, avoiding unnecessary cropping and thereby rendering more image frames at the player.
-   From v2.3.0, the `LiveTranscoding` class is moved from the *io.agora.live* package to the `io.agora.rtc.live` package.
-   Fixed a typo in the constants.java API in v2.3.0.
    -   Before:

    ```
    public static final int SOFEWARE_ENCODER = 1;
    ```

    -   After:

    ```
    public static final int SOFTWARE_ENCODER = 1;
    ```

-   The security keys are improved and updated in v2.1.0. If you are using an Agora SDK version below v2.1.0 and wish to migrate to the latest version, see [Token Migration Guide](/en/Agora%20Platform/token_migration).

#### New Features

##### 1. Fallback options for the live interactive streaming under unreliable network conditions

The audio and video quality of the live interactive streaming deteriorate under unreliable network conditions. To improve the efficiency of the live interactive streaming, the `setLocalPublishFallbackOption` and `setRemoteSubscribeFallbackOption` methods are added. These interfaces allow the SDK to automatically disable the video stream when the network conditions cannot support both audio and video, and enable the video when the network conditions improve. The SDK triggers the `onLocalPublishFallbackToAudioOnly` or `onRemoteSubscribeFallbackToAudioOnly` callback when the stream falls back to audio-only or when the stream switches back to the video.

##### 2. Notifies the user that the token expires in 30 seconds

The SDK returns the `onTokenPrivilegeWillExpire` callback 30 seconds before a token expires to notify the app to renew it. When this callback is received, you need to generate a new token on your server and call the `renewToken` method to pass the newly-generated token to the SDK.

##### 3. Returns user-specific upstream and downstream statistics, including the bitrate, frame rate, packet loss rate, and time delay

The `onRemoteAudioTransportStats` and `onRemoteVideoTransportStats` callbacks are added to provide user-specific upstream and downstream statistics, including the bitrate, frame rate, and packet loss rate. During a call or the live interactive streaming, the SDK triggers these callbacks once every two seconds after the user receives audio/video packets from a remote user. The callbacks include the user ID, audio bitrate at the receiver, packet loss rate, and time delay (ms).

##### 4. Sets the video encoder configurations

To support scenarios with video rotation and enable better quality for the custom video source, this version deprecates the `setVideoProfile` method and uses the `setVideoEncoderConfiguration` method instead to set the video encoding configurations. You can still use the `setVideoProfile` method, but Agora recommends using the `setVideoEncoderConfiguration` method to set the video profile because:

-   During the live interactive streaming, users can set the video orientation mode as adaptive, under which the SDK can transfer rotated video frames without cropping them, thus avoiding the “big headshot” or blurry images at the player.

-   In scenarios involving external video sources, the SDK adjusts the width and height of the output video frames based on the inputting video frames, avoiding unnecessary cropping and thereby rendering more image frames at the player.


The <code>VideoEncoderConfiguration</code> class provides a set of configurable video parameters, including the dimension, frame rate, bitrate, and orientation. For more information on the API, see `Set the Video Encoder Configuration`.

##### 5. Adds support for background image settings in setLiveTranscoding

The `backgroundImage` parameter is added to the `setLiveTranscoding` method allowing you to set the background image in the combined video of the live interactive streaming.

#### Improvements

-   Improves the quality for one-on-one voice/video scenarios with optimized latency and smoothness, especially for areas like Southeast Asia, South America, Africa, and the Middle East.
-   Improves the audio encoder efficiency in the live interactive streaming to reduce user traffic while ensuring the call quality.
-   Improves the audio quality during a call or the live interactive streaming using the deep-learning algorithm.

#### Issues Fixed

- The users on the Web client cannot see the video sent from the Native client due to codec bugs.
- Excessive increase in memory usage when multiple delegated hosts start streaming in the channel.
- Occasional crashes on some Android devices.
- The remote view does not display on some devices.
- The local video cannot be enabled on some Android devices.
- Occasional ghost images.
- Occasional green lines at the bottom of the video when a user switches from a low stream to a high stream video in the `COMMUNICATION` profile.
- Occasional crashes after interoperating with devices of other platforms for some Android devices.
- Excessive increase in the memory usage for the host when the host frequently joins and leaves a channel that has multiple delegated hosts.
- Occasional black screens on some Android devices.
- Occasionally, the remote user cannot hear the host when the host switches between `AUDIENCE` and `BROADCASTER`.
- Occasionally, the settings applied to the background image in live transcoding do not take effect.
- Occasionally on some devices, the video height and width are swapped in the `COMMUNICATION` profile.
- Occasionally, the `destroy` method does not respond after a user enables the video and joins a channel.
- Occasional crashes on Android devices when remote users frequently join and leave the channel.
- Black screen due to failure to render the remote video on some Android devices.
- Occasionally, the audience cannot adjust the channel volume.
- Occasionally, apps do not respond on some Android devices.
- Occasional crashes on some Android devices when switching video resolutions in the live interactive streaming.
- A delegated host cannot see the video of the other hosts in the channel on some Android devices.
- The bitrates cannot reach the target values on some Android devices when a user frequently joins and leaves the communication channel with different video profiles.
- Occasional failures to capture the video of the delegated host when the hosts and the audience members frequently change roles.
- Occasional failures to capture video or publish streams on some Android devices when a user frequently joins and leaves a communication channel with different video profiles.
- Occasional crashes when calling the <code>setCameraFocusPositionInPreview</code> method on some devices.
- Occasional failures to enable the camera during communication on some Android devices.
- Occasional video freezes and stream publishing hangs on some Android devices after a user joins a communication or live-streaming channel.
- Occasional crashes when one of the two hosts mutes or disables the local audio while playing the background music.
- A user cannot join a communication channel after frequently changing the video encoder profiles.
- Occasional crashes on some devices when preloading the sound effects.
- Failure to render videos of lower resolutions on some Android devices.
- Occasionally, an Android client still interoperates in a communication channel when removed from Console.
- Video resolution inconsistencies between the encoder and the decoder in the `LIVE_BROADCASTING` profiles.
- Failure to enable the hardware encoder on some Android devices.
- Occasional video freezes in the Communication or `LIVE_BROADCASTING` profiles.
- Occasional crashes when calling the <code>muteRemoteVideoStream</code> method after joining the channel.
- Occasional video freezes on some Android devices when switching from the `COMMUNICATION` profile to the `LIVE_BROADCASTING` profiles.
- Occasional crashes on some Android devices when frequently turning on and off the camera flash during the live interactive streaming.
- The host cannot receive the audio/video stream of the delegated host on some Android devices.
- Occasional crashes on some Android devices when setting the video encoder profile of an external video source during the live interactive streaming.
- Incorrect video orientation on some Android devices when setting the video profile of an external video source during the live interactive streaming.
- Occasionally on some Android devices, the video fallback option does not take effect under poor network conditions.
- Occasional crashes on some Android devices when a user frequently changes the token.
- Occasional failures to split the screen on some Android devices.
- The CDN audience on some Android devices cannot see the video of the host.
- Occasional video freezes when switching from multiple hosts to a single host.
- Occasional inter-operational failures between SIP devices and the SDK.
- Occasionally on Mi 8, the local video cannot be seen locally or remotely.
- Occasionally on some Android devices, users cannot see each other.
- Occasional echo issues when using a specific audio card.
- Occasional video delays on some Android devices.
- Occasional crashes on some Android devices when transmitting the video streams.

#### API Changes

To improve your experience, we made the following changes to the APIs:

To avoid adding too many users with the same uid into the CDN publishing channel, the following API method is deleted in v2.3.0, and the return value type of `addUser` is changed from void to int.

-   <code>setUser</code>


The following API methods are deleted and no longer supported in v2.3.0. Agora provides the Recording SDK for better recording services. For more information on the Recording SDK, see [Release Notes for Agora Recording SDK](./release_recording).

-   <code>startRecordingService</code>
-   <code>stopRecordingService</code>
-   <code>refreshRecordingServiceStatus</code>


The following deprecated API methods are deleted and no longer supported from v2.3.0:

-   <code>monitorConnectionEvent</code>
-   <code>monitorBluetoothHeadsetEvent</code>
-   <code>monitorHeadsetEvent</code>
-   <code>setPreferHeadset</code>
-   <code>switchView</code>
-   <code>setSpeakerphoneVolume</code>

**v2.2.3** 

v2.2.3 is released on July 5, 2018. 

#### Compatiblity changes

The security keys are improved and updated in v2.1.0. If you are using an Agora SDK version below v2.1.0 and wish to migrate to the latest version, see `Token Migration Guide`.

#### Issues Fixed

- Occasional online statistics crashes.
- The host’s voice distorts occasionally on some Android devices.
- Occasional crashes during the live interactive streaming.
- Excessive increase in the memory usage when multiple delegated hosts start streaming in the channel.
- Receiving the <code>onLeaveChannel</code> callback long after a user has left the channel on some Android devices.
- Failing to report the uid and volume of the speaker in a channel.
- Unsteady voice volume of the host in the live interactive streaming.
- Occasional video freezes during the live interactive streaming.
- Occasional ANR (application no response) problem on some Android devices after a user turns off the camera to end a video session.
- Occasional video freeze after a view size change.

**v2.2.2**

v2.2.2 is released on June 21, 2018.

#### Issues Fixed

- Fixed occasional online statistics crashes.
- Fixed occasional audio crashes on some Android devices.
- Fixed the issue that the host’s voice distorts occasionally on some Android devices.
- Fixed the issue of failing to report the uid and volume of the speaker in a channel.
- Fixed the issue of receiving the onLeaveChannel callback long after a user has left the channel on some Android devices.
- Fixed the issue of occasional video freeze after a view size change.
- Fixed the occasional ANR (application no response) problem on some Android devices after the user turns off the camera to end a video session.

**v2.2.1**

v2.2.1 is released on May 30, 2018.

#### Issues Fixed

- Occasional crashes during gaming on some Android devices.
- The soundtrack pointer cannot be retrieved on some Android devices.
- Occasional crashes on some Android devices.
- The audio volume on some Android devices cannot be adjusted after a headset is plugged in.


**v2.2.0**

v2.2.0 is released on May 4, 2018. 

#### New Features

##### 1. Play the audio effect in the channel

Adds a <code>publish</code> parameter in the <code>playEffect</code> method for the remote user in the channel to hear the audio effect played locally. 

>  If your SDK is upgraded to v2.2 from a previous version, pay attention to the functional changes of this API.

##### 2. Deploy the proxy at the server

We provide a proxy package for enterprise users with corporate firewalls to deploy before accessing our services.

##### 3. Get the remote video state

Adds the <code>remoteVideoStateChangedOfUid</code> method to get the state of the remote video stream. 

##### 4. Add watermarks on the streaming video

Adds the watermark function for users to add a PNG file to the local or CDN streaming as a watermark. Adds the <code>addVideoWatermark</code> and <code>clearVideoWatermarks</code> methods to add and delete watermarks in the local live streaming. Adds the <code>watermark</code> parameter in the <code>LiveTranscording</code> interface to add watermarks in CDN streaming.

#### Improvements

##### 1. Audio volume indication

Improves the <code>enableAudioVolumeIndication</code> method. This method once enabled, sends the audio volume indication of the speaker in its callback at set intervals, regardless of whether anyone is speaking in the channel.

##### 2. Network quality detection during a session

To meet the customers’ need for real-time network quality detection in the channel, the <code>onNetworkQuality</code> method improves its data accuracy. 

##### 3. Last mile network quality detection before joining a channel

To test if the customers’ network condition can support voice or video calls before joining the channel, the <code>onLastmileQuality</code> callback changes the detection from a fixed bitrate to the bitrate set by the customer in the <code>setVideoProfile</code> method to improve data accuracy. When the network condition is unknown, the SDK triggers this callback once every two seconds. 

##### 4. Audio quality enhancement

Improves the audio quality in scenarios that involve music playback.

#### Issues Fixed

- Occasional screen display abnormalities when a large number of audience members join as the host in a live-streaming channel.
- Fixes occasional CDN streaming abnormalities when some app switches to run in the background during the live interactive streaming.


**v2.1.3**

v2.1.3 is released on April 19, 2018. 

In v2.1.3, Agora updates the bitrate values of the <code>setVideoProfile</code> method in the `LIVE_BROADCASTING` profiles. The bitrate values in v2.1.3 stay consistent with those in v2.0. 

#### Issues Fixed

Occasional recording failures on some phones when a user leaves a channel and turns on the built-in recording device.

#### Improvements

Improves the performance of screen sharing by shortening the time interval between which users switch from screen sharing to the normal Communication or `LIVE_BROADCASTING` profiles.

**v2.1.2**

v2.1.2 is released on April 2, 2018. 

>  If you upgrade the SDK to v2.1.2 from a previous version, the live-streaming video quality is better than the communication video quality in the same resolutions, resulting in the live streaming using more bandwidth.

#### New Features

Extends the <code>setVideoProfile</code> method to enable users to manually set the resolution, frame rate, and bitrate of the video. 

#### Issues Fixed

Video freeze in DTX + AAC mode.

**v2.1.1**

v2.1.1 is released on March 16, 2018. 

Agora has identified a critical issue in SDK v2.1. Upgrade to v2.1.1 if you are using Agora SDK v2.1.

**v2.1.0**

v2.1.0 is released on March 7, 2018.

#### New Features

##### 1. Voice Optimization

Adds a scenario for the game chat room to reduce the bandwidth and cancel the noise with the <code>setAudioProfile</code> method.

##### 2. Enhance the audio effect input from the built-in microphone

In an interactive streaming scenario, the host can enhance the local audio effects from the built-in microphone with the <code>setLocalVoiceEqualization</code> and <code>setLocalVoiceReverb</code> methods by implementing the voice equalization and reverberation effects.

##### 3. Online statistics query

Adds RESTful APIs to check the status of the users in the channel, the channel list of a specific company, and whether the user is an audience or a host. For details, see [Online Statistics Query API](./dashboard_restful_communication).

##### 4. 17-way video

Adds the support of 17-way video in the live interactive streaming, see [Video for 7+ Users](./multi_user_video_android).

##### 5. Video source customization

Supports the default video-capturing features provided by the camera and the customized video source. 

##### 6. Renderer customization

Supports the default functions provided by the renderers to display the local and remote videos to meet your requirements. We provide a set of interfaces for customized renderers. 

##### 7. Injecting an external video stream

Adds the function of injecting an external video stream to the ongoing live streaming.

##### 8. Camera focus change

Adds an <code>onCameraFocusAreaChanged</code> callback to report to the app when the camera focus area changes.

#### Improvements

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
<tr><td>Hardware Encoder</td>
<td>Enables the H.264 hardware encoder on the Qualcomm, MTK, HiSilicon, and Orion chips.</td>
</tr>
<tr><td>Hardware Encoder</td>
<td>Improves the bitrate control for the hardware encoder.</td>
</tr>
<tr><td>Billing Optimization</td>
<td>Small video resolutions are charged according to the voice-only mode. For example, 16 &times; 16.</td>
</tr>
</tbody>
</table>

#### Issues Fixed

-   Occasional playback noise on specific devices.
-   Occasional crackling voice playback on specific devices.
-   Occasional crashes.

**v2.0.2**

v2.0.2 is released on December 15, 2017, and fixes occasional audio routing issues.

**v2.0**

v2.0 is released on December 6, 2017. 

#### New Features

-   Adds the <code>setRemoteVideoStreamType</code> and <code>enableDualStreamMode</code> methods in the `COMMUNICATION` profile to support dual streams.
-   Adds the camera management function in the `COMMUNICATION` and `LIVE_BROADCASTING` profiles by adding the following API methods:

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
<tr><td><code>isCameraZoomSupported</code></td>
<td>Checks whether the device supports camera zoom.</td>
</tr>
<tr><td><code>isCameraTorchSupported</code></td>
<td>Checks whether the device supports camera flash.</td>
</tr>
<tr><td><code>isCameraFocusSupported</code></td>
<td>Checks whether the device supports camera manual focus.</td>
</tr>
<tr><td><code>isCameraAutoFocusFaceModeSupported</code></td>
<td>Checks whether the device supports camera auto-face focus.</td>
</tr>
<tr><td><code>setCameraZoomFactor</code></td>
<td>Sets the camera zoom ratio.</td>
</tr>
<tr><td><code>getCameraMaxZoomFactor</code></td>
<td>Gets the maximum zoom ratio of the camera.</td>
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



-   Supports external audio sources in the `COMMUNICATION` and `LIVE_BROADCASTING` profiles by adding the following API methods:

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
<tr><td><code>setExternalAudioSource</code></td>
<td>Enables the external audio source function.</td>
</tr>
<tr><td><code>pushExternalAudioFrame</code></td>
<td>Pushes the external audio frame to the Agora SDK.</td>
</tr>
</tbody>
</table>



-   Provides a set of RESTful APIs to ban a peer user from the server in the `COMMUNICATION` and `LIVE_BROADCASTING` profiles. Contact [support@agora.io](mailto:support@agora.io) to enable this function, if required.
-   Supports the following Android emulators: NOX, Lightning, and Xiaoyao.


#### Improvements

Optimizes the hardware encoder by supporting encoding resolutions as low as 64 x 64.

#### Issues Fixed

-   Audio routing and Bluetooth issues.
-   Optimizes the volume balance control.


**v1.14**

v1.14 is released on October 20, 2017. 

#### New Features

-   Adds the <code>setAudioProfile</code> method to set the audio parameters and scenarios
-   Adds the <code>setLocalVoicePitch</code> method to set the local voice pitch
-   `LIVE_BROADCASTING`: Adds the <code>setInEarMonitoringVolume</code> method to adjust the volume of the in-ear monitor


#### Improvements

-   Optimizes the audio at high bitrates.
-   `LIVE_BROADCASTING`: The audience can view the host within one second in a single-stream mode (226 ms on average, and 204 ms under good network conditions).
-   Adds the ability to reduce the bandwidth.
    -   Before v1.14: If you muted the audio of a specific user, the network still sent the stream.
    -   Starting from v1.14: If you mute the audio of a specific user, the network will not send the stream of the user to reduce the bandwidth.
-   Accurate control over the bitrate:
    -   Before v1.14: Inaccurate control over the bitrate often caused huge fluctuations, leading to network congestion and higher rates of packet and frame loss. This affected the accuracy of the bandwidth estimation module, especially under poor network conditions.
    -   Starting from v1.14: Accurate control over the bitrate prevents huge fluctuations avoiding network congestion and shortening the transmission latency.


#### Issues Fixed

Camera related issues on Android devices.

**v1.13.1**

v1.13.1 is released on September 28, 2017, and optimizes the echo issue under certain circumstances.

**v1.13**

v1.13 is released on September 4, 2017. 

#### New Features

-   Adds the function to dynamically enable and disable acquiring the sound card in the live interactive streaming.
-   Adds the function to disable the audio playback.
-   Supports the profile configuration for stream-pushing on the client side.
-   Adds the <code>onClientRoleChanged</code> callback to report to the app on a user role switch between the host and the audience in the live interactive streaming.
-   Supports the push-stream failure callback on the server side.


#### Improvements:

The video profile is controllable by the software codec.

#### Issues Fixed:

Occasional crashes on some devices

**v1.12**

v1.12 is released on July 25, 2017.

#### New Features:

-   Adds the <code>aes-128-ecb</code> encryption mode in the <code>setEncryptionMode</code> method.
-   Adds the <code>quality</code> parameter in the <code>startAudioRecording</code> method to set the recording audio quality.

#### Issues Fixed:

-   Android: Bluetooth issues related to audio routing.
-   Android/iOS/Mac/Windows: Occasional crashes.