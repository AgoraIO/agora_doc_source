---
title: Release Notes
platform: Unity
updatedAt: 2021-03-12 08:40:28
---
This page provides the release notes for the Agora Unity SDK.

## v3.2.1

v3.2.1 was released on December 30, 2020.

#### Compatibility changes

**1. Integration change**

Since v3.2.1, the following libraries have been added to the SDK package:

- The Fraunhofer FDK AAC dynamic library.
- The mpg123 dynamic library.
- The SoundTouch dynamic library.
- The FFmpeg dynamic library.

See the added files for each platform as follows:

| Platform | File name                                                    |
| :------- | :----------------------------------------------------------- |
| Android | <li>`libagora-fdkaac.so`</li><li>`libagora-mpg123.so`</li><li>`libagora-soundtouch.so`</li><li>`libagora-ffmpeg.so`</li> |
| iOS     | <li>`Agorafdkaac.framework`</li><li>`AgoraSoundTouch.framework`</li><li>`Agoraffmpeg.framework`</li> |
| macOS     | <li>`Agorafdkaac.framework`</li><li>`AgoraSoundTouch.framework`</li><li>`Agoraffmpeg.framework`</li> |
| Windows | <li>`libagora-fdkaac.dll`</li><li>`libagora-mpg123.dll`</li><li>`libagora-soundtouch.dll`</li><li>`libagora-ffmpeg.dll`</li> |

If you upgrade the SDK to v3.2.1, ensure that you have added the above files in your project according to [Quickstart Guide](https://docs.agora.io/en/Interactive%20Broadcast/start_live_unity?platform=Unity#integrate-the-sdk).

**2. Cloud proxy**

This release optimizes the Agora cloud proxy architecture. If you are already using cloud proxy, to avoid compatibility issues between the new SDK and the old cloud proxy, please contact [support@agora.io](mailto:support@agora.io) before upgrading the SDK. See [Cloud Proxy](./cloudproxy_unity?platform=Unity).

**3. Security and compliance**

Agora has passed ISO 27001, ISO 27017, and ISO 27018 international certifications, providing safe and reliable real-time interactive cloud services for users worldwide. See [ISO Certificates](https://docs.agora.io/cn/Agora%20Platform/iso_cert?platform=Unity).

This release supports transport layer encryption by adding TLS (Transport Layer Security) and UDP (User Datagram Protocol) encryption methods.

<div class="alert note">Transport layer encryption affects the size of the SDK package. For details, see *Product Overview*.</div>

#### New features

**1. Interactive Live Streaming Standard**

This release adds `SetClientRole` for setting the latency level of an audience member. You can use this method to switch between Interactive Live Streaming Premium and Interactive Live Streaming Standard as follows:

- Set the latency level as ultra low latency to use Interactive Live Streaming Premium.
- Set the latency level as low latency to use Interactive Live Streaming Standard.

For details, see the [product overview](https://docs.agora.io/en/live-streaming/product_live_standard?platform=Unity) of Interactive Live Streaming Standard.

**2. Publishing and subscription states**

This release adds the following callbacks to report the current publishing and subscribing states:

- `OnAudioPublishStateChangedHandler`: Reports the change of the audio publishing state.
- `OnVideoPublishStateChangedHandler`: Reports the change of the video publishing state.
- `OnAudioSubscribeStateChangedHandler`: Reports the change of the audio subscribing state.
- `OnVideoSubscribeStateChangedHandler`: Reports the change of the video subscribing state.

**3. First local frame published callback**

This release adds the `OnFirstLocalAudioFramePublishedHandler` and `OnFirstLocalVideoFramePublishedHandler` callbacks to report that the first audio or video frame is published. The `OnFirstLocalAudioFrameHandler` callback is deprecated from v3.1.0.

**4. Custom data report**

This release adds the `SendCustomReportMessage` method for reporting customized messages. To try out this function, contact [support@agora.io](mailto:support@agora.io) and discuss the format of customized messages with us.

#### Improvement

**1. Regional connection**

This release changes the `AREA_CODE` for regional connection, and adds area codes for Japan and India. The latest area codes are as follows:

- `AREA_CODE_CN`: Mainland China.
- `AREA_CODE_NA`: North America.
- `AREA_CODE_EU`: Europe.
- `AREA_CODE_AS`: Asia, excluding Mainland China.
- `AREA_CODE_JP`: Japan.
- `AREA_CODE_IN`: India.
- `AREA_CODE_GLOB`: (Default) Global.

If you have specified a region for connection when calling `GetEngine`, ensure that you use the latest area code when migrating from an earlier SDK version.

**2. Meeting scenario**

To improve the audio experience for multi-person meetings, this release adds `AUDIO_SCENARIO_MEETING(8)` in `SetAudioProfile`.

**3. Voice beautifier and audio effects**

To improve the usability of the APIs related to voice beautifier and audio effects, this release deprecates `SetLocalVoiceChanger` and `SetLocalVoiceReverbPreset`, and adds the following methods instead:

- `SetVoiceBeautifierPreset`: Compared with `SetLocalVoiceChanger`, this method deletes audio effects such as a little boy’s voice and a more spatially resonant voice.
- `SetAudioEffectPreset`: Compared with `SetLocalVoiceReverbPreset`, this method adds audio effects such as the 3D voice, the pitch correction, a little boy’s voice and a more spatially resonant voice.
- `SetAudioEffectParameters`: This method sets detailed parameters for a specified audio effect. In this release, the supported audio effects are the 3D voice and pitch correction.

**4. CDN live streaming**

To improve the user experience in CDN live streaming, this release adds the `OnRtmpStreamingEventHandler` callback to report events during CDN live streaming, such as failure to add a background image or watermark image.

**5. Encryption**

This release adds the `EnableEncryption` method for enabling built-in encryption, and deprecates the following methods:

- `SetEncryptionSecret`
- `SetEncryptionMode`

**6. More in-call statistics**

This release adds the following attributes to provide more in-call statistics:

- Adds `txPacketLossRate` in `LocalAudioStats`, which represents the audio packet loss rate (%) from the local client to the Agora edge server before applying anti-packet loss strategies.

- Adds the following attributes in `LocalVideoStats`:

  - `txPacketLossRate`: The video packet loss rate (%) from the local client to the Agora edge server before applying anti-packet loss strategies.
  - `captureFrameRate`: The capture frame rate (fps) of the local video.

- Adds `publishDuration` in `RemoteAudioStats` and `RemoteVideoStats`, which represents the total publish duration (ms) of the remote media stream.

**7. Audio profile**

To improve audio performance, this release adjusts the maximum audio bitrate of each audio profile as follows:

| Profile                                   | v3.2.1                                                       | Earlier than v3.2.1                                          |
| :---------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| `AUDIO_PROFILE_DEFAULT`                   | For the interactive streaming profile: 64 KbpsFor the communication profile:Windows: 16 KbpsAndroid/iOS/macOS: 18 Kbps | For the interactive streaming profile: 52 KbpsFor the communication profile:Windows: 16 KbpsAndroid/iOS/macOS: 18 Kbps |
| `AUDIO_PROFILE_SPEECH_STANDARD`           | 18 Kbps                                                      | 18 Kbps                                                      |
| `AUDIO_PROFILE_MUSIC_STANDARD`            | 64 Kbps                                                      | 48 Kbps                                                      |
| `AUDIO_PROFILE_MUSIC_STANDARD_STEREO`     | 80 Kbps                                                      | 56 Kbps                                                      |
| `AUDIO_PROFILE_MUSIC_HIGH_QUALITY`        | 96 Kbps                                                      | 128 Kbps                                                     |
| `AUDIO_PROFILE_MUSIC_HIGH_QUALITY_STEREO` | 128 Kbps                                                     | 192 Kbps                                                     |

**8. Log files**

This release increases the default number of log files that the Agora SDK outputs from 2 to 5, and increases the default size of each log file from 512 KB to 1024 KB. By default, the SDK outputs five log files, `agorasdk.log`, `agorasdk_1.log`, `agorasdk_2.log`, `agorasdk_3.log`, `agorasdk_4.log`. The SDK writes the latest logs in `agorasdk.log`. When `agorasdk.log` is full, the SDK deletes the log file with the earliest modification time among the other four, renames `agorasdk.log` to the name of the deleted log file, and creates a new `agorasdk.log` to record the latest logs.

**9. Image enhancement**

This release adds support for calling `SetBeautyEffectOptions` on macOS. You can call this method to set parameters including contrast, brightness, smoothness, and red saturation.

**10. Audio route**

To play audio on more macOS devices, this release adds four enumerators in `AUDIO_ROUTE`, and supports USB, HDMI, DisplayPort peripherals, and Apple AirPlay.

**11. In-ear monitoring improvement on OPPO models**

This release reduces the delay of in-ear monitoring on the following OPPO models:

- Reno4 Pro 5G
- Reno4 5G

**12. Video experience under poor network conditions**

- Starting with this release, the SDK automatically reduces video resolution under poor network conditions in order to improve the smoothness of the video.
- This release improves video quality by ensuring that the video does not become blurry due to changing network conditions.

**13. Local video quality**

This release improves the quality of the video captured by the local camera of the iOS devices:

- This release optimizes the autofocus function of the rear camera.
- For video with a resolution not lower than 960 × 540 pixels, this release improves the local overexposure of the image under strong light by enabling the HDR attribute of the camera by default.

#### Issues fixed

This release fixed the following issues:

**Audio**

- `SetAudioMixingPitch` did not work when setting the `pitch` parameter to certain values.
- On iOS devices, occasional audio freeze when disconnecting from a Bluetooth device.
- On macOS devices, the app failed to record any audio because the audio device module failed to start.

**Video**

- When a remote user called with vivo X30, the local user saw a black screen.
- On iOS devices, when a remote user leaves the channel, the view of the remote user becomes black.
- On macOS devices, when other video apps were running, the SDK could not turn on the local camera.

**SDK**

- The occasional crashes when leaving a channel on Android devices.
- Crashes on x86 phones running on Android 6 and later.
- On iOS devices, occasional crashes when the user left the channel after talking in multiple channels.

#### API changes

**Added**

- [`SetClientRole`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a9a31f9b8e45c6528d6f56914619de314)
- [`SetAudioEffectPreset`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a4bbf600b51a400fe6ab261a95e47bad6)
- [`SetVoiceBeautifierPreset`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ab4953c6ce75adc42a13297af41676d9a)
- [`SetAudioEffectParameters`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a9ccf7abdd5f7b4bc0e7f0a7807e34390)
- [`EnableEncryption`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a54214baf0b421161990eded9c7401976)
- [`OnAudioPublishStateChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#aabfff11675d45572de8eb5f28d80ac33)
- [`OnVideoPublishStateChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#acbe99ccc22853645819110b5cf311142)
- [`OnAudioSubscribeStateChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#aa0283db27464a1cc827515853db924c5)
- [`OnVideoSubscribeStateChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#aae17c7a5b5eee64af5402f9f93a5616f)
- [`OnFirstLocalAudioFramePublishedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a2be635d5257a7673102e0e0e62c73793)
- [`OnFirstLocalVideoFramePublishedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#abc5c6cb1cfb6e7340fc10dc554d6ab3a)
- [`OnRtmpStreamingEventHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a78104eee847716bfd43f7efd5cdd8b58)
- `txPacketLossRate` in [`LocalAudioStats`](./API%20Reference/unity/structagora__gaming__rtc_1_1_local_audio_stats.html)
- `txPacketLossRate` and `captureFrameRate` in [`LocalVideoStats`](./API%20Reference/unity/structagora__gaming__rtc_1_1_local_video_stats.html)
- `publishDuration` in [`RemoteAudioStats`](./API%20Reference/unity/structagora__gaming__rtc_1_1_remote_audio_stats.html) and [`RemoteVideoStats`](./API%20Reference/unity/structagora__gaming__rtc_1_1_remote_video_stats.html)
- `AUDIO_SCENARIO_MEETING(8)` in [`AUDIO_SCENARIO_TYPE`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a7630f2ee913986430344d4aad26098a3) enum
- `AUDIO_ROUTE_USB`, `AUDIO_ROUTE_HDMI`, `AUDIO_ROUTE_DISPLAYPORT` and `AUDIO_ROUTE_AIRPLAY` in [`AUDIO_ROUTE`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#aca310af5a1412fa7a7475b245994b3ae) enum

**Deprecated**

- `SetLocalVoiceChanger`
- `SetLocalVoiceReverbPreset`
- `SetEncryptionSecret`
- `SetEncryptionMode`
- `OnFirstLocalAudioFrameHandler`

## v3.0.1

v3.0.1 was released on September 16, 2020.

In this release, Agora improves the user experience under poor network conditions for both the `COMMUNICATION` and `LIVE_BROADCASTING` profiles through the following measures:

- Adopting a new architecture for the `COMMUNICATION` profile.
- Upgrading the last-mile network strategy for both the `COMMUNICATION` and `LIVE_BROADCASTING` profiles, which enhances the SDK's anti-packet-loss capacity by maximizing the net bitrate when the uplink and downlink bandwidth are insufficient.

To deal with any incompatibility issues caused by the architecture change, Agora uses the fallback mechanism to ensure that users of different versions of the SDKs can communicate with each other: if a user joins the channel from a client using a previous version, all clients using v3.0.1 automatically fall back to the older version. This has the effect that none of the users in the channel can enjoy the improved experience. Therefore we strongly recommend upgrading all your clients to v3.0.1.

If you also use the On-premise Recording SDK, ensure that you upgrade your On-premise Recording SDK to v3.0.0 so that all users can enjoy the improvements brought by the new architecture and network strategy.

#### Compatibility changes

**1. Dynamic library replaces the static library (for macOS and iOS)**

This release adds support for a dynamic library and removes the static library. This release renames the library from `AgoraRtcEngineKit.framework` to `AgoraRtcKit.framework`. If you upgrade your SDK to v3.0.1, you must re-import the `AgoraRtcKit` class in Xcode, and set the **Embed** attribute as **Embed & Sign**.

If you integrated the encryption library `AgoraRtcCryptoLoader.framework`, you must re-import the `AgoraRtcCryptoLoader` class in Xcode, and set the **Embed** attribute as **Embed & Sign**.

![](https://web-cdn.agora.io/docs-files/1600240476016)

**2. Enumerator names change**

This release changes `CLIENT_ROLE` to `CLIENT_ROLE_TYPE`, and changes the name of the following members:

- `BROADCASTER` to `CLIENT_ROLE_BROADCASTER`
- `AUDIENCE` to `CLIENT_ROLE_AUDIENCE`

**3. Dual-stream mode not enabled in the `COMMUNICATION` profile**

As of v3.0.1, the native SDK does not enable the [dual-stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#dual-stream) by default in the `COMMUNICATION` profile. Call the `EnableDualStreamMode (true)` method after joining the channel to enable it. In video scenarios with multiple users, we recommend enabling the dual-stream mode.

#### New features

**1. Specifying the area of connection**

This release adds `GetEngine2` for specifying the area of connection when creating an `IRtcEngine` instance. This advanced feature applies to scenarios that have regional restrictions. You can choose from areas including Mainland China, North America, Europe, Asia (excluding Mainland China), and global (default).

**2. Multiple channel management**

To enable a user to join an unlimited number of channels at a time, this release adds the `AgoraChannel` class. By creating multiple `AgoraChannel` objects, a user can join the corresponding channels at the same time. Besides, this release adds `SetMultiChannelWant` for enabling the multi-channel mode, and `SetForMultiChannelUser` for setting the local or remote video of users in multiple channels.

After joining multiple channels, users can receive the audio and video streams of all the channels, but publish one stream to only one channel at a time. This feature applies to scenarios where users need to receive streams from multiple channels, or frequently switch between channels to publish streams. See [Join multiple channels](./multiple_channel_unity) for details.

**3. Audio mixing pitch**

To set the pitch of the local music file during audio mixing, this release adds `SetAudioMixingPitch`. You can set the `pitch` parameter to increase or decrease the pitch of the music file. This method sets the pitch of the local music file only. It does not affect the pitch of a human voice.

**4. Adjusting the playback volume of the specified remote user**

Adds `AdjustUserPlaybackSignalVolume` for adjusting the playback volume of a specified remote user. You can call this method as many times as necessary in a call or the interactive live streaming to adjust the playback volume of different remote users, or to repeatedly adjust the playback volume of the same remote user.

**5. Voice beautifier and audio effects**

To improve the audio quality, this release adds the following enumerate elements in `SetLocalVoiceChanger` and `SetLocalVoiceReverbPreset`:

- `VOICE_CHANGER_PRESET` adds several enumerations that have the prefixes `VOICE_BEAUTY` and `GENERAL_BEAUTY_VOICE`. The `VOICE_BEAUTY`enumerations implement voice timbre transformation, and the `GENERAL_BEAUTY_VOICE` enumerations beautify chat voice.
- `AUDIO_REVERB_PRESET` adds the enumeration `AUDIO_VIRTUAL_STEREO` and several enumerations that have the prefix `AUDIO_REVERB_FX`. The `AUDIO_VIRTUAL_STEREO` enumeration implements reverberation in the virtual stereo, and the `AUDIO_REVERB_FX` enumerations implement voice changer effects, new style transformation effects, and new room acoustics effects.

**6. Face detection**

This release enables local face detection on Android and iOS. After you call `EnableFaceDetection` to enable this function, the SDK triggers the `OnFacePositionChangedHandler` callback in real time to report the detection results, including the distance between the human face and the device screen. This function can remind users to keep a certain distance from the screen.

#### Improvements

**1. Audio profiles**

To meet the need for higher audio quality, this release adjusts the corresponding audio profile of `AUDIO_PROFILE_DEFAULT(0)` in the `LIVE_BROADCASTING` profiles.

| SDK                 | `AUDIO_PROFILE_DEFAULT(0)`                                    |
| :------------------ | :----------------------------------------------------------- |
| v3.0.1              | A sample rate of 48 KHz, music encoding, mono, and a bitrate of up to 52 Kbps. |
| Earlier than v3.0.1 | A sample rate of 32 KHz, music encoding, mono, and a bitrate of up to 44 Kbps. |

**2. Quality statistics**

Adds the following members in the `RtcStats` class for providing more in-call statistics, making it easier to monitor the call quality and memory usage in real time:

- `gatewayRtt`
- `memoryAppUsageRatio`
- `memoryTotalUsageRatio`
- `memoryAppUsageInKbytes`

On iOS, to prevent the prompt to find local network devices from popping up when an end user launches the app on an iOS 14.0 device, the `gatewayRtt` parameter is disabled by default. See the [FAQ](https://docs.agora.io/en/faq/local_network_privacy) for details. If you do not mind the prompt, and want to enable the `gatewayRtt` parameter, please contact Agora technical support via [support@agora.io](mailto:support@agora.io).

**3. Screen sharing**

This release enables window sharing of [UWP](https://docs.microsoft.com/en-us/windows/uwp/get-started/universal-application-platform-guide) (Universal Windows Platform) applications when you call `StartScreenCaptureByWindowId`.

**4. Image enhancement**

This release adds `SetBeautyEffectOptions` on Windows for enabling image enhancement in scenarios such as video social networking, an online class, or interactive live streaming. You can call this method to set parameters including contrast, brightness, smoothness, red saturation, and so on.

**5. Others**

- This release adds `VIDEO_PIXEL_RGBA` in `VIDEO_PIXEL_FORMAT`. You can capture the RGBA data from an external video source and send the data to the SDK.
- This release enables interoperability between the RTC Unity SDK and the RTC Web SDK by default, and deprecates the `EnableWebSdkInteroperability` method.

#### Issues fixed

- Audio issues relating to audio mixing, audio encoding, and echoing.
- Video issues relating to no response on `OnVideoSizeChangedHandler` callback, no buffer data in `VideoFrame`, an unexpected watermark, incorrect aspect ratio, poor video sharpness, or a black outline appearing while screen sharing and toggling to full-screen.
- Issues relating to app crashes, log file, and unstable service during CDN live streaming.
- Issues on `SetRemoteSubscribeFallbackOption`, which should work in the `LIVE_BROADCASTING` profile only, also works in the `COMMUNICATION` profile.
- In some one-to-one calls, the downlink media stream falls back to audio-only under poor network conditions.
- Issues relating to `SendStreamMessage` and the `TranscodingUser` of `SetLiveTranscoding`, which do not support an array format.
- Inaccurate report of the `OnClientRoleChangedHandler` callback, authentication issues with an App ID and token, and a garbled log directory.

#### API changes

**Added**

- [`GetEngine2`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac1a02000088c915aa36065325f42d166)
- [`CreateChannel`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac14119e2505e2f44931bed0181c5624f)
- [`AgoraChannel`](./API%20Reference/unity/classagora__gaming__rtc_1_1_agora_channel.html) class
- [`SetMultiChannelWant`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a50ddfe8050fd11f1537bd0dddc2eb8a3)
- [`SetForMultiChannelUser`](./API%20Reference/unity/class_video_surface.html#a2c751c8013e9a20c9f7929ca427b04b9)
- [`SetAudioMixingPitch`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ac1f7b492430f2c3f38826804a418c2a7)
- [`AdjustUserPlaybackSignalVolume`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a6ae88c74d0dc4e80837cd0a351f81c00)
- Nine enumerations in [`VOICE_CHANGER_PRESET`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a710b9754965ccb92ed968a562968df2c), such as `VOICE_BEAUTY_VIGOROUS`
- Twelve enumerations in [`AUDIO_REVERB_PRESET`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a1e681589411dd2f5df62dab5c1fca7b9), such as `AUDIO_REVERB_FX_KTV`
- [`EnableFaceDetection`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a45f7776f4fd3a6d73186c83e4e15e917)
- [`OnFacePositionChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a2425866f7157395b0f6cc04e7854d0f5)
- The [`gatewayRtt`](./API%20Reference/unity/structagora__gaming__rtc_1_1_rtc_stats.html#aef762b5910ca3a7a06a4e37869c34fed), [`memoryAppUsageRatio`](./API%20Reference/unity/structagora__gaming__rtc_1_1_rtc_stats.html#a5b7d328a6f8e6aca9e1b8b6c8ce16e02), [`memoryTotalUsageRatio`](./API%20Reference/unity/structagora__gaming__rtc_1_1_rtc_stats.html#a232d695be9b723df8dae4ca219c6745f) and [`memoryAppUsageInKbytes`](./API%20Reference/unity/structagora__gaming__rtc_1_1_rtc_stats.html#aeb37b39c64362e3954b279c6dfc5e774) members in the `RtcStats` class
- The [`totalActiveTime`](./API%20Reference/unity/structagora__gaming__rtc_1_1_remote_audio_stats.html#a7453a27b08439186f35b3b7bb9eafd3b) member in the `RemoteAudioStats` struct
- The [`totalActiveTime`](./API%20Reference/unity/structagora__gaming__rtc_1_1_remote_audio_stats.html#a7453a27b08439186f35b3b7bb9eafd3b) member in the `RemoteVideoStats` struct
- The [`channelId`](./API%20Reference/unity/structagora__gaming__rtc_1_1_audio_volume_info.html#a0b95567512ed7c6642671e805207a8e1) member in the `AudioVolumeInfo` struct

**`Renamed`**

Enum type `CLIENT_ROLE` changed to [`CLIENT_ROLE_TYPE`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a901253f94f78da34371bf7eb656a19ff). Enum name `BROADCASTER` and `AUDIENCE` changed to `CLIENT_ROLE_BROADCASTER` and `CLIENT_ROLE_AUDIENCE`.

**Deprecated**

- `EnableWebSdkInteroperability`
- `OnFirstRemoteVideoFrameHandler`, replaced by [`OnRemoteVideoStateChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a53d577f5c1c2d863f7946d86d76adb13)
- `OnUserMutedAudioHandler`, `OnFirstRemoteAudioDecodedHandler`, and `OnFirstRemoteAudioFrameHandler`, replaced by [`OnRemoteAudioStateChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a92f016ea980eba06cf38192191d17e01)
- `OnStreamPublishedHandler` and `OnStreamUnpublishedHandler`, replaced by [`OnRtmpStreamingStateChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a589c11ed19b0638824aa1b2e23971271)

## v2.9.2

v2.9.2 is released on Feb 17, 2020.

- This release fixed some abnormal behaviors on Android devices.
- This release fixed the stuck behavior of using the Editor debug mode on Windows platform.

## v2.9.1

Agora Unity SDK is widely used in games, education, AR, VR and other scenarios.

v2.9.1 was released on December 23, 2019.

#### Functions and features

**1. Multi-platform support**
Supports iOS, Android, macOS and Windows (x86/x86-64) platforms.

**2. Interoperability with the Agora Web SDK**
Provides the `EnableWebSdkInteroperability` method for enabling interoperability with the Agora Web SDK in `LIVE_BROADCASTING` profile. 

**3. Video rendering method**
Supports multiple video rendering methods. You can choose any method in  **Auto Graphics API**.
![](https://web-cdn.agora.io/docs-files/1576826628073)

**4. Multithreaded rendering**
Supports multithreaded rendering. You can click the **Multithreaded Rendering** option for rendering in multiple threads.

**5. Raw data**
Supports raw audio data and raw video data in RGBA format. You can capture and process the raw data according to your needs. See details in [Raw Video Data](raw_data_video_unity).

**6. External data source**
Provides APIs for accessing to the external data source. You can configure the external audio and video source, and push the data to the Agora Unity SDK. See details in [Custom Video Source and Renderer](custom_video_unity)

**7. Encryption**
Supports encryption of audio and video streaming. The following table shows the information of the encryption libraries for the Android and iOS platforms. If you do not intend to use this function, you can remove the encryption libraries to decrease the SDK size.

   | Platform | Encryption libraries                          |
   | :------- | :-------------------------------------------- |
   | Android  | libagora-crypto.so                            |
   | iOS      | <ul><li>AgoraRtcCryptoLoader.framework <li>libcrypto.a</li></ul> |

**8. Cloud proxy**

Supports the cloud proxy service. See [Use Cloud Proxy](cloudproxy_unity) for details.

#### Related documentation

See the following documentation to quickly integrate the SDK and implement real-time voice and video communication in your project.

- [Start a Video Call](https://docs.agora.io/en/Video/start_call_unity?platform=Unity) or [Start Live Interactive Video Streaming](https://docs.agora.io/en/Interactive%20Broadcast/start_live_unity?platform=Unity)
- [API Reference](./API%20Reference/unity/index.html) 

Agora also provides an open-source [Unity Sample](https://github.com/AgoraIO/Agora-Unity-Quickstart/tree/master/video/Hello-Video-Unity-Agora) on GitHub.