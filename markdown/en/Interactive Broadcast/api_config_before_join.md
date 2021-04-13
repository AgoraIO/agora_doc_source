---
title: Additional Configurations Before Joining a Channel
platform: All Platforms
updatedAt: 2021-02-02 02:33:28
---
This article describes possible API calls and configurations before joining a channel. Usually, you can quickly implement real-time communications by calling one or two APIs, but if your scenarios require high quality and stability, refer to the additional configurations here.

Unless otherwise specified, this article applies to the following platforms of Agora RTC SDK:

- Android
- iOS
- macOS
- Windows
- Electron
- Unity

<div class="alert note">Before you start, ensure that you understand how to implement a <a href="https://docs.agora.io/en/Video/start_call_android?platform=Android">basic call</a> or <a href="https://docs.agora.io/en/Interactive%20Broadcast/start_live_android?platform=Android">interactive live streaming</a>.</div>

## Log file configurations

For easier debugging and to ensure that the SDK outputs complete log files, Agora recommends calling `setLogFile` immediately after initializing the Agora service. You can also use `setLogFileSize` and `setLogFilter` to configure the log file size and output level. See [How can I set the log file](https://docs.agora.io/en/faqs/logfile).

## Audio configurations

If your scenarios require high-fidelity audio, call `setAudioProfile` before joining a channel, and set `profile` as `MUSIC_HIGH_QUALITY`(4) and `scenario` as `GAME_STREAMING`(3). See [Set the Audio Profile](./audio_profile_android?platform=Android) for more configurations.

<div class="alert note">The actual code may vary on different platforms. Adjust your code accordingly.</div>

## Video configurations

The SDK disables the video function by default. To enable video, call `enableVideo` before joining a channel.

Calling `enableVideo` enables capturing, encoding, sending the local video, and receiving the remote video. Agora recommends using the following methods for more precise control:

- `enableLocalVideo`: Enables/Disables the local video capture.
- `muteLocalVideoStream`: Stops/Resumes sending the local video stream.
- `muteRemoteVideoStream`: Stops/Resumes receiving a specified remote video stream.
- `muteAllRemoteVideoStreams`: Stops/Resumes receiving all remote video streams.

<div class="alert note">Note:
	<li>To enable the local video capture, call either <code>enableLocalVideo</code> or <code>enableVideo</code> before joining a channel. Avoid calling both <code>enableLocalVideo</code> and <code>enableVideo</code> before joining a channel. This action turns the camera on twice, and it takes longer to join the channel.</li>
	<li>Because the call of <code>enableVideo</code> resets the entire video module, Agora recommends you use the above four APIs to control different phases of video processing.</li>
</div>

Calling `startPreview` before joining a channel reduces the render time of the first video frame. If you have called `startPreview`, ensure that you call `stopPreview` before `destroy`.

## Interoperability with the Web SDK

If you are using Native SDKs earlier than v3.0.0 in interactive live streaming scenario, and your scenario involves the RTC SDK for Web, ensure that you call `enableWebSdkInteroperability` before joining a channel.

<div class="alert info">As of v3.0.0, the interoperability between the Native SDK and the Web SDK is enabled by default.</div>