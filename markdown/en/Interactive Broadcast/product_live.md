---
title: Interactive Live Streaming Premium Overview
platform: All_Platforms
updatedAt: 2021-02-02 04:32:43
---
Agora Live Interactive Video Streaming enables one-to-many and many-to-many audio or video live streaming with the Agora RTC SDK. 

The difference between [Agora Video Call ](https://docs.agora.io/en/Video/product_video?platform=All%20Platforms)and Agora Live Interactive Video Streaming is:

- Agora Video Call prioritizes smoothness and low latency. All users are the same role and can talk to each other freely. A typical scenario of Agora Video Call is a video conference call for many persons.
- Agora Live Interactive Video Streaming prioritizes high video quality. Users can be the host or audience, where only the host can talk. A user who wants to talk must change the role to a host. A typical scenario of Agora Live Interactive Video Streaming is an interactive online class.

Different from the traditional CDN live broadcast, which only allows one-way communication from the hosts to the audience, the Agora RTC SDK empowers the audience to interact with the hosts by [becoming a host](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#becoming-host), like a viewer jumping onto the stage in the middle of a play to perform. 

The Agora RTC SDK is applicable to scenarios that encourage active engagement, such as game-playing, online classes for students in small groups, and Q&A sessions during E-commerce live streaming. You can also use this SDK for one-to-one video calls that require high image quality.

## Functions and scenarios

Agora Live Interactive Video Streaming boasts a flexible combination of functions for different scenarios.

<style> table th:first-of-type {     width: 150px; } th:third-of-type {     width: 170px; }</style>

| Function                                | Description                                                  | Scenario                                                     |
| --------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Co-hosting in a channel                 | An audience switches to a co-host and interacts with the existing host. | <li>Large-scale live streams where hosts can invite the audience to interact with them. <li>Online games such as Murder Mystery and Werewolf Killing. |
| Co-hosting across channels              | Hosts interact with each other across channels.              | PK Hosting.                                                  |
| Audio mixing                            | Sends the local and online audio with the user's voice to other audience members in the channel. | <li>Online KTV. <li>Interactive music classes for children.  |
| Screen sharing                          | Hosts share their screens with the audience in the channel. Supports specifying which screen or which window to share, and supports specifying the sharing region. | <li>Interactive online classes.<li>Live streaming of gaming hosts. |
| Basic image enhancement                 | Sets basic beauty effects, including skin smoothening, whitening, and cheek blushing. | Image enhancement in a video call.                           |
| Modify the raw data                     | Developers obtain and modify the raw voice or video data of the SDK engine to create special effects, such as a voice change. | <li>To change the voice in an online voice chatroom.<li>Image enhancement in a live stream. |
| Inject an online media stream           | Injects an external audio or video stream to an ongoing live broadcast channel. The host and audience in the channel can listen to or watch the stream while interacting with each other. You can set the attributes of the video source. | <li>The host and audience watching a movie or game together. |
| Customize the video source and renderer | Users process videos (from self-built cameras, screen sharing, or files) for image enhancement and filtering. | <li>To use a customized image enhancement library or pre-processing library.<li>To customize the application's built-in image and video modules.<li>To use other video sources, such as a recorded video.<li>To provide flexible device management for exclusive video capture devices to avoid conflicts with other services. |
| Push streams to the CDN                 | Sends the audio and video of your channel to other RTMP servers through the CDN:<li>Starts or stops publishing at any time.<li>Adds or removes an address while continuously publishing the stream. <li>Adjusts the picture-in-picture layout. | <li>To send a live stream to WeChat or Weibo.<li>To allow more people to watch the live stream when the number of audience members in the channel reached the limit. |

See the following sample code for application scenarios:

- [PK Hosting](https://github.com/AgoraIO/ARD-Agora-Online-PK/blob/master/README.zh.md)
- [Trivia Game](https://github.com/AgoraIO/HQ)
- [Online KTV](https://github.com/AgoraIO/Agora-Online-KTV/blob/master/README.zh.md)
- [Online Voice Chatroom](https://github.com/AgoraIO-Usecase/Chatroom)
- [Clip Doll Machine](https://github.com/AgoraIO/Wawaji)
- [Murder Mystery Game](https://github.com/AgoraIO-Usecase/Murder-Mystery-Game)

## Key properties

| Property                                 | Agora Live Interactive Video Streaming specifications        |
| ---------------------------------------- | ------------------------------------------------------------ |
| SDK package size                         | 4.61 MB to 10.41 MB                                          |
| Host capacity                            | 17 users                                                     |
| Audience capacity                        | One million users                                            |
| Video profile                            | <li>SDK video source: Up to 1080p @ 60fps.<li>Custom video source: Up to 4K |
| Audio profile                            | <li>Sample rate: 16 kHz to 48 kHz.<li>Support for mono and stereo sound |
| Audio anti-packet-loss rate              | 80% (uplink and downlink)                                    |
| Latency between the host and the co-host | 200 ms to 600 ms                                             |

## Compatibility

Agora Live Interactive Video Streaming is supported on platforms such as iOS, Android, Windows, macOS, Electron, Unity, and Web, and allows for cross-platform connections. The following is a list of supported platforms and their versions.

| Platform             | Supported Version                                            |
| -------------------- | ------------------------------------------------------------ |
| Android              | <p>4.1+</p><p>The Android SDK supports the following ABIs:<li>armeabi-v7a<li>arm64-v8a<li>x86<li>x86-64 |
| iOS                  | 8.0+                                                         |
| Windows              | <p>Windows 7+</p><p>The Windows SDK supports the following architecture:<li>x86<li>x86-64                                                      |
| macOS                | <p>10.0+</p><p>The macOS SDK supports the x86 architecture.                                                        |
| Unity                | <p>2017+</p><p>The Unity SDK supports the following platforms:<p><ul><li>Android (armeabi-v7a, arm64-v8a, x86)<li>iOS<li>Windows (x86, x86-64)<li>macOS                                                        |
| Web                  | <li>Chrome 58+<li>Chrome 49 on Windows XP<li>Firefox 56+<li>Safari 11+<li>Opera 45+<li>QQ Browser 10.5+<li>360 Security Browser 9.1+<li>Edge Browser 80+<p>The browser support on the Web platform varies with the device and system. See [Which browsers does the Agora Web SDK support?](https://docs.agora.io/en/All/faq/browser_support) |
	|Electron |Electron 1.8.3 or later|
	|Flutter  |Flutter 1.0.0 or later (Flutter 2.x is not supported)|
	|React Native |React Native 0.59.10 or later|