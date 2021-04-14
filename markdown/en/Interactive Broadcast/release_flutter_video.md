---
title: Release Notes
platform: Flutter
updatedAt: 2021-03-12 05:24:55
---
This page provides the release notes for the Agora Flutter SDK.

## v3.3.1

v3.3.1 was released on March 12, 2020.

#### Compatibility changes

This release deprecates `setDefaultMuteAllRemoteAudioStreams` and `setDefaultMuteAllRemoteVideoStreams `and changes the behavior of `mute`-related methods as follows:

- `mute`-related methods must be called after joining or switching to a channel; otherwise, the method call does not take effect.
- Methods with the prefix `muteAll` are no longer the master switch, and each `mute`-related method independently controls the user's subscribing state. When you call methods with the prefixes `muteAll` and `muteRemote` together, the method that is called later takes effect.
- Methods with the prefix `muteAll` set whether to subscribe to the audio or video streams of all remote users, including all subsequent users, which means methods with the prefix `muteAll` contain the function of methods with the prefix `setDefaultMute`. Agora recommends not calling methods with the prefixes `muteAll` and `setDefaultMute` together; otherwise, the setting may not take effect.

#### New features

**1. Channel media options**

To help developers control media subscription more flexibly, this release adds the `options` parameter to `joinChannel` and `switchChannel` methods to set whether users subscribe to all remote audio or video streams in a channel when joining and switching channels.

**2. Cloud proxy**

To improve the usability of the Agora Cloud Proxy, this release adds the `setCloudProxy` method to set the cloud proxy and allows you to select a cloud proxy that uses the UDP protocol. For details, see [Cloud Proxy](./cloudproxy_native?platform=Flutter).

**3. Deep-learning noise reduction**

To eliminate non-stationary noise based on traditional noise reduction, this release adds `enableDeepLearningDenoise` to enable deep-learning noise reduction.

**4. Singing beautifier**

To beautify the voice and add reverberation effects in a singing scenario, this release adds the `setVoiceBeautifierParameters` method and adds the `SingingBeautifier` constant to `VoiceBeautifierPreset`.

You can call `setVoiceBeautifierPreset(SingingBeautifier)` to beautify the male voice and add the reverberation effect for a voice in a small room. For more settings, you can call `setVoiceBeautifierParameters(SingingBeautifier, param1, param2)` to beautify male or female voices and add reverberation effects for a voice in a small room, large room, or hall.

**5. Log files**

To ensure the integrity of log content, this release adds the `createWithConfig` method and adds the `logConfig` property to the `log` parameter. You can use `logConfig` to set the log files output by the Agora SDK when you initialize `RtcEngine`. See [How can I set the log file?](https://docs.agora.io/en/Interactive%20Broadcast/faq/logfile) for details.

As of v3.3.0, Agora does not recommend using the `setLogFile`, `setLogFileSize`, or `setLogFilter` methods to set the log files.

**6. Quality of captured video**

To control the quality of video captured by the local camera, this release adds support for customizing the capture resolution and listening for abnormalities.

- Customize the capture resolution: Call the `setCameraCapturerConfiguration` method to set the capture preference to `Manual(3)` and set the width and height of the captured video image.
- Listen for abnormalities:
  - The abnormal brightness level of captured video images: Use `captureBrightnessLevel` in the `localVideoStats` callback.
  - The camera fails to output the captured video: Use the `localVideoStateChanged(Failed, CaptureFailure)` callback.
  - The camera repeatedly outputs the captured video: Use the `localVideoStateChanged(Capturing, CaptureFailure)` callback.

(iOS only) To improve the user experience, this release adds the following reasons for local video capture errors in the `localVideoStateChanged` callback:

- `CaptureInBackGround(6)`: The application is running in the background.
- `CaptureMultipleForegroundApps(7)`: The application is running in Slide Over, Split View, or Picture in Picture mode.

**7. Data streams**

To support scenarios such as lyrics synchronization and courseware synchronization, this release deprecates the previous `createDataStream` method and replaces it with `createDataStreamWithConfig`. You can use this new method to create a data stream and set whether to synchronize the data stream with the audio stream sent to the Agora channel and whether the received data is ordered.

**8. Voice Conversion**

This release adds the `setVoiceConversionPreset` method to set a voice conversion effect (to disguise a user's voice). You can use this method to make a male-sounding voice sound steady or deep, and a female-sounding voice sound gender-neutral or sweet.



#### Improvements

**1. AES-GCM encryption mode**

For scenarios requiring high security, to guarantee the confidentiality, integrity, and authenticity of data, and to improve the computational efficiency of data encryption, this release adds the following enumerators in `EncryptionMode`:

- `AES128GCM`: 128-bit AES encryption, GCM mode.
- `AES256GCM`: 256-bit AES encryption, GCM mode.

<div class="alert note">Once you enable the built-in encryption, all users in the same channel must use the same encryption mode and key, including the server-side users such as the Agora recording service.</div>

**2. Remote audio statistics**

To monitor quality of experience (QoE) of the local user when receiving a remote audio stream, this release adds:
- `mosValue` to `remoteAudioStats`, which reports the quality of the remote audio stream as determined by the Agora real-time audio MOS (Mean Opinion Score) measurement system.
- `qoeQuality` and `qualityChangedReason` to `remoteAudioStats`, which report QoE of the local user and the reason for poor QoE, respectively.

#### Issues fixed

**Android**

- The audio sampling failed on some Android devices after a headset was plugged in.
- Local audio sampling occasionally failed on Android 10.
- After enabling the sound position indication, you could not get the remote user's volume by the `audioVolumeIndication` callback.
- Occasional abnormality with the hardware encoders on certain devices after continuously encoding key frames for a short period of time.

**iOS**

- After enabling the sound position indication, you could not get the remote user's volume by the `audioVolumeIndication` callback.
- Occasional crashes when you called `enableLocalVideo(false)` while the application window was switching to Slide Over, Split View, or Picture in Picture mode.

#### API changes

This release adds the following APIs:


**Added**

- [`createWithConfig`](./API%20Reference/flutter/rtc_engine/RtcEngine/createWithConfig.html)
- [`setVoiceConversionPreset`](./API%20Reference/flutter/rtc_engine/RtcEngine/setVoiceConversionPreset.html)
- `AES128GCM` and `AES256GCM` in [`EncryptionMode`](./API%20Reference/flutter/rtc_engine/EncryptionConfig-class.html)
- `mosValue` in [`RemoteAudioStats`](./API%20Reference/flutter/rtc_engine/RemoteAudioStats-class.html)
- [`setVoiceBeautifierParameters`](./API%20Reference/flutter/rtc_engine/RtcEngine/setVoiceBeautifierParameters.html)
- `SingingBeautifier` in the [`VoiceBeautifierPreset`](./API%20Reference/flutter/rtc_engine/VoiceBeautifierPreset-class.html) constant
- [`enableDeepLearningDenoise`](./API%20Reference/flutter/rtc_engine/RtcEngine/enableDeepLearningDenoise.html)
- `options` in [`joinChannel`](./API%20Reference/flutter/rtc_channel/RtcChannel/joinChannel.html)
- `options` in [`switchChannel`](./API%20Reference/flutter/rtc_engine/RtcEngine/switchChannel.html)
- [`createDataStreamWithConfig`](./API%20Reference/flutter/rtc_channel/RtcChannel/createDataStreamWithConfig.html)
- `qoeQuality` and `qualityChangedReason` in [`RemoteAudioStats`](./API%20Reference/flutter/rtc_engine/RemoteAudioStats-class.html)
- [`setCloudProxy`](./API%20Reference/flutter/rtc_engine/RtcEngine/setCloudProxy.html)
- The `captureBrightnessLevel` property in the [`LocalVideoStats`](./API%20Reference/flutter/rtc_engine/LocalVideoStats-class.html)
- The `captureWidth` and `captureHeight` properties in the [`CameraCapturerConfiguration`](./API%20Reference/flutter/rtc_engine/CameraCapturerConfiguration-class.html) class
- `Manual(3)` in the [`CameraCaptureOutputPreference`](./API%20Reference/flutter/rtc_engine/CameraCaptureOutputPreference-class.html) constant
- `CaptureInBackGround(6)` and `CaptureMultipleForegroundApps(7)` in the [`LocalVideoStreamError`](./API%20Reference/flutter/rtc_engine/LocalVideoStreamError-class.html) constant
- Error code: [`ModuleNotFound(157)`](./API%20Reference/flutter/rtc_engine/ErrorCode-class.html)

**Deprecated**

- `createWithAreaCode`
- `setDefaultMuteAllRemoteVideoStreams`
- `setDefaultMuteAllRemoteAudioStreams`
- `setLogFile`
- `setLogFileSize`
- `setLogFilter`
- `createDataStream`

## v3.2.1

v3.2.1 was released on December 23, 2020.

#### Compatibility changes

**1. Cloud proxy**

This release optimizes the Agora cloud proxy architecture. If you are already using cloud proxy, to avoid compatibility issues between the new SDK and the old cloud proxy, please contact [support@agora.io](mailto:support@agora.io) before upgrading the SDK. See [Cloud Proxy](./cloudproxy_native?platform=Flutter).

**2. Security and compliance**

Agora has passed ISO 27001, ISO 27017, and ISO 27018 international certifications, providing safe and reliable real-time interactive cloud services for users worldwide. See [ISO Certificates](https://docs.agora.io/en/Agora%20Platform/iso_cert?platform=Flutter).

This release supports transport layer encryption by adding TLS (Transport Layer Security) and UDP (User Datagram Protocol) encryption methods.

####  New features

**Interactive live streaming standard**

This release adds `options` in `setClientRole` for setting the latency level of an audience member. You can use this method to switch between Interactive Live Streaming Premium and Interactive Live Streaming Standard as follows:

- Set the latency level as ultra low latency to use Interactive Live Streaming Premium.
- Set the latency level as low latency to use Interactive Live Streaming Standard.

For details, see the [product overview](https://docs.agora.io/en/live-streaming/product_live_standard?platform=Flutter) of Interactive Live Streaming Standard.

#### Improvements

**1. Meeting scenario**

To improve the audio experience for multi-person meetings, this release adds `MEETING(8)` in `setAudioProfile`.

**2. Voice beautifier and audio effects**

To improve the usability of the APIs related to voice beautifier and audio effects, this release deprecates `setLocalVoiceChanger` and `setLocalVoiceReverbPreset`, and adds the following methods instead:

- `setVoiceBeautifierPreset`: Compared with `setLocalVoiceChanger`, this method deletes audio effects such as a little boy’s voice and a more spatially resonant voice.
- `setAudioEffectPreset`: Compared with `setLocalVoiceReverbPreset`, this method adds audio effects such as the 3D voice, the pitch correction, a little boy’s voice and a more spatially resonant voice.
- `setAudioEffectParameters`: This method sets detailed parameters for a specified audio effect. In this release, the supported audio effects are the 3D voice and pitch correction.

**3. Interactive streaming delay**

This release reduces the latency on the audience's client during an interactive live streaming by about 500 ms.

#### Issues fixed

**Android**

- Occasional audio sampling issues with Xiaomi speakers.
- When a remote user called with vivo X30, the local user saw a black screen.
- When a remote user frequently joined and left a channel on an Android TV, the local user occasionally saw a black screen.
- Crashes occurred when using IPv6.
- After you called `enableEncryption`, the SDK did not trigger the `firstLocalVideoFramePublished` callback.
- When Native clients integrated with the Agora Voice SDK interoperated with Web clients, the Web clients continuously reported the `Client.on(disable-local-video)` or `Client.on(mute-video)` callback.

**iOS**

- On iPhone 5s and iPhone 6, after the user enabled the basic image enhancement function, the screen flickered when users switched between apps.
- The `stopChannelMediaRelay` method did not take effect.
- The SDK mistakenly returned the `AdmStartRecording(1012)` error.
- Crashes occurred when using IPv6.
- After you called `enableEncryption`, the SDK did not trigger the `firstLocalVideoFramePublished` callback.
- When Native clients integrated with the Agora Voice SDK interoperated with Web clients, the Web clients continuously reported the `Client.on(disable-local-video)` or `Client.on(mute-video)` callback.

#### API changes

**Added**

- `options`in [`setClientRole`](./API%20Reference/flutter/rtc_channel/RtcChannel/setClientRole.html)
- [`setAudioEffectPreset`](./API%20Reference/flutter/rtc_engine/RtcEngine/setAudioEffectPreset.html)
- [`setVoiceBeautifierPreset`](./API%20Reference/flutter/rtc_engine/RtcEngine/setVoiceBeautifierPreset.html)
- [`setAudioEffectParameters`](./API%20Reference/flutter/rtc_engine/RtcEngine/setAudioEffectParameters.html)
- `MEETING(8)` in [`AudioScenario`](./API%20Reference/flutter/rtc_engine/AudioScenario-class.html)

**Deprecated**

- `setLocalVoiceChanger`
- `setLocalVoiceReverbPreset`

## v3.1.2

v3.1.2 was released on September 30th, 2020.

**Functions and features**

- Adapts to Agora RTC SDK v3.1.2.
- Supports asynchronous programming with `async/await`.
- Supports multiple channels.
- Supports TextureView on Android platform.
- Supports callbacks to report the current publishing and subscribing states, and whether the first audio or video frame is published.

**Related documentation**

See the following documentation to quickly integrate the SDK and implement real-time voice and video communication in your project.
- [Start a Voice Call](/en/Video/start_call_audio_flutter?platform=Flutter)
- [Start a Video Call](/en/Video/start_call_flutter?platform=Flutter)
- [Start Live Interactive Video Streaming](/en/Video/start_live_flutter?platform=Flutter)
- [Start Live Interactive Audio Streaming](/en/Video/start_live_audio_flutter?platform=Flutter)
- [API Reference](/en/Video/API%20Reference/flutter/v3.1.2/index.html)

Agora also provides an open-source [Agora Flutter Quickstart](https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart) on GitHub.

<div class="alert note">To improve user experience, this version disables the local network connection quality report by default, to prevent the prompt to find local network devices from popping up when an end user launches the app on an iOS 14.0 device. The <code>gatewayRtt</code> parameter in the <code>RtcStats</code> callback is disabled by default. Do not use <code>gatewayRtt</code> to obtain the round-trip delay between the client and the local router. See the <a href="https://docs.agora.io/en/faq/local_network_privacy">FAQ</a> for details.</div>