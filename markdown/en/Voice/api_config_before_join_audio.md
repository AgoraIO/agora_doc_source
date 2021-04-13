---
title: Additional Configurations Before Joining a Channel
platform: All Platforms
updatedAt: 2021-02-02 02:31:48
---
This article describes possible API calls and configurations before joining a channel. Usually, you can quickly implement real-time communications by calling one or two APIs, but if your scenarios require high quality and stability, refer to the additional configurations here.

<div class="alert note">Before you start, ensure that you understand how to implement a <a href="https://docs.agora.io/en/Voice/start_call_audio_android?platform=Android">basic call</a> or <a href="https://docs.agora.io/en/Audio%20Broadcast/start_live_audio_android?platform=Android">interactive live streaming</a>.</div>

## Log file configurations

For easier debugging and to ensure that the SDK outputs complete log files, Agora recommends calling `setLogFile` immediately after initializing the Agora service. You can also use `setLogFileSize` and `setLogFilter` to configure the log file size and output level. See [How can I set the log file](https://docs.agora.io/en/faqs/logfile).

## Audio configurations

If your scenarios require high-fidelity audio, call `setAudioProfile` before joining a channel, and set `profile` as `MUSIC_HIGH_QUALITY`(4) and `scenario` as `GAME_STREAMING`(3). See [Set the Audio Profile](./audio_profile_android?platform=Android) for more configurations.

<div class="alert note">The actual code may vary on different platforms. Adjust your code accordingly.</div>

## Interoperability with the Web SDK

If you are using Native SDKs earlier than v3.0.0 in the interactive live streaming scenario, and your scenario involves the RTC SDK for Web, ensure that you call `enableWebSdkInteroperability` before joining a channel.

<div class="alert info">As of v3.0.0, the interoperability between the Native SDK and the Web SDK is enabled by default.</div>