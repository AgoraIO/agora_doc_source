---
title: Release Notes
platform: Electron
updatedAt: 2021-03-12 05:51:45
---
This page provides the release notes for the Agora SDK for Electron.

## Introduction
 
The Agora SDK for Electron is developed upon Agora SDK for macOS 和 Agora SDK for Windows, with the Node.js C++ plug-in units. The Electron SDK supports the following scenarios:
 
- Voice and video communication
- Voice and video live broadcast
 
For key features included in each scenario, see [Voice Overview](product_voice), [Video Overview](product_video), [Audio Broadcast Overview](product_live_audio) and [Video Broadcast Overview](product_live).

## v2.9.0

v2.9.0 is released on Aug 16, 2019.

**Compatibility changes**


####  Reporting the state of the remote video

This release extends the `remoteVideoStateChanged` callback with more states of the remote video: `STOPPED(0)`, `STARTING(1)`, `DECODING(2)`, `FROZEN(3)`, and `FAILED(4)`. It adds a reason parameter to the callback to indicate why the remote video state changes. The original `remoteVideoStateChanged` callback is deleted. If you upgrade your Native SDK to the latest version, ensure that you re-implement the `remoteVideoStateChanged` callback.

The new callback reports most of the remote video states, and therefore deprecates the following callbacks. You can still use them, but we do not recommend doing so.

- `userEnableVideo`
- `userEnableLocalVideo`
- `addStream`

**New features**

#### 1. Faster switching to another channel

This release adds the [`switchChannel`](./API%20Reference/electron/v2.9.0/classes/agorartcengine.html#switchchannel) method to enable the audience in a Live Broadcast channel to quickly switch to another channel. With this method, you can achieve a much faster switch than with the `leaveChannel` and `joinChannel` methods. After the audience successfully switches to another channel by calling the `switchChannel` method, the SDK triggers the `leaveChannel` and `joinedChannel` callbacks to indicate that the audience has left the original channel and joined a new one. 

#### 2. Channel media stream relay

This release adds the following methods to relay the media streams of a host from a source channel to a destination channel. This feature applies to scenarios such as online singing contests, where hosts of different Live Broadcast channels interact with each other.

- [`startChannelMediaRelay`](./API%20Reference/electron/v2.9.0/classes/agorartcengine.html#startchannelmediarelay)
- [`updateChannelMediaRelay`](./API%20Reference/electron/v2.9.0/classes/agorartcengine.html#updatechannelmediarelay)
- [`stopChannelMediaRelay`](./API%20Reference/electron/v2.9.0/classes/agorartcengine.html#stopchannelmediarelay)

During the media stream relay, the SDK reports the states and events of the relay with the `channelMediaRelayState` and `channelMediaRelayEvent` callbacks.

#### 3. Reporting the local and remote audio state

This release adds the `localAudioStateChanged` and `remoteAudioStateChanged` callbacks to report the local and remote audio states. With these callbacks, the SDK reports the following states for the local and remote audio:

- The local audio: `STOPPED(0)`, `RECORDING(1)`, `ENCODING(2)`, or `FAILED(3)`. When the state is `FAILED(3)`, see the `error` parameter for troubleshooting.
- The remote audio: `STOPPED(0)`, `STARTING(1)`, `DECODING(2)`, `FROZEN(3)`, or `FAILED(4)`. See the `reason` parameter for why the remote audio state changes.

#### 4. Reporting the local audio statistics

This release adds the `localAudioStats` callback to report the statistics of the local audio during a call, including the number of channels, the sending sample rate, and the average sending bitrate of the local audio.

**Improvements**

#### 1. Reporting more statistics of the in-call quality

This release adds the following statistics in the [`RtcStats`](./API%20Reference/electron/v2.9.0/interfaces/rtcstats.html), [`LocalVideoStats`](./API%20Reference/electron/v2.9.0/interfaces/localvideostats.html), and [`RemoteVideoStats`](./API%20Reference/electron/v2.9.0/interfaces/remotevideostats.html) classes:

- `RtcStats`: The total number of the sent audio bytes, sent video bytes,  received audio bytes, and received video bytes during a session.
- `LocalVideoStats`: The encoding bitrate, the width and height of the encoding frame, the number of frames, and the codec type of the local video.
- `RemoteVideoStats`: The packet loss rate of the remote video.

#### 2. Improving the live broadcast video quality

This release minimizes the video freeze rate under poor network conditions, improves the video sharpness, and optimizes the video smoothness when the packet loss rate is high.

#### 3. Improving the screen sharing quality

This release improves the sharpness of text during screen sharing in the Communication profile, particularly when the network condition is poor. Note that this improvement takes effect only when you set ContentHint as Details(2).

#### 4. Other Improvements

- Improves the audio quality when the audio scenario is set to Game Streaming.
- Improves the audio quality after the user disables the microphone in the Communication profile.

**Issues fixed**

#### Audio

- When interoperating with a Web app, voice distortion occurs after the native app enables the remote sound position indication.
- Invalid call of the [`muteRemoteAudioStream`](./API%20Reference/electron/v2.9.0/classes/agorartcengine.html#muteremoteaudiostream) method.
- Occasionally no audio. 
- Crashes occur when testing the microphone.

#### Video

- Video freezes.
- The `remoteVideoStateChanged` callback behaves unexpectedly. 

#### Miscellaneous

- Occasionally mixed streams in RTMP streaming. 
- Occasional crashes occur.
- Failure to join the channel.

**API changes**

To improve the user experience, we made the following changes in v2.9.0:

#### Added

- `localAudioStats`
- `localAudioStateChanged`
- `remoteAudioStateChanged`
- [`switchChannel`](./API%20Reference/electron/v2.9.0/classes/agorartcengine.html#switchchannel)
- [`startChannelMediaRelay`](./API%20Reference/electron/v2.9.0/classes/agorartcengine.html#startchannelmediarelay)
- [`updateChannelMediaRelay`](./API%20Reference/electron/v2.9.0/classes/agorartcengine.html#updatechannelmediarelay)
- [`stopChannelMediaRelay`](./API%20Reference/electron/v2.9.0/classes/agorartcengine.html#stopchannelmediarelay)
- `channelMediaRelayState`
- `channelMediaRelayEvent`
- `remoteVideoStateChanged`
- [`RtcStats`](./API%20Reference/electron/v2.9.0/interfaces/rtcstats.html): `txAudioBytes`, `txVideoBytes`, `rxAudioBytes` and `rxVideoBytes`
- [`localVideoStats`](./API%20Reference/electron/v2.9.0/interfaces/localvideostats.html): `encodedBitrate`,`encodedFrameWidth`,`encodedFrameHeight`, `encodedFrameCount` and `codecType`
- [`remoteVideoStats`](./API%20Reference/electron/v2.9.0/interfaces/remotevideostats.html): `packetLossRate`

#### Deprecated

- `microphoneEnabled`. Use the `localAudioStateChanged` callback instead.
- `remoteVideoTransportStats`. Use the `remoteVideoStats` callback instead.
- `remoteAudioTransportStats`. Use the `remoteAudioStats` callback instead.
- `userEnableVideo`. Use the `remoteVideoStateChanged` callback instead.
- `userEnableLocalVideo`. Use the `remoteVideoStateChanged` callback instead.
- `addStream`. Use the `remoteVideoStateChanged` callback instead.
 
## v2.8.0

v2.8.0 is released on Jul 8, 2019.
 
This is the first release of the Agora SDK for Electron. Refer to the following documentation to quickly integrate the SDK and enable real-time voice and video communication in your project.
 
- [Integrate the SDK](electron_video)
- [API Reference](./API%20Reference/electron/index.html)
 
Agora also provides the open-source [Electron Github Demo](https://github.com/AgoraIO-Community/Agora-Electron-Quickstart) for you to download.