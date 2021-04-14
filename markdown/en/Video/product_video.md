---
title: Agora Video Call Overview
platform: All_Platforms
updatedAt: 2020-12-01 03:03:39
---
The Agora Native SDK for Video Call enables easy and convenient one-to-one or one-to-many calls and supports voice-only and video modes.

The difference between an Agora Video Call and [Agora Video Interactive Broadcast](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=All%20Platforms) is: 
* An Agora Video Call prioritizes smoothness and low latency. All users are the same role and can talk to each other freely. A typical scenario of an Agora Video Call is a video conference call for many persons. 
* An Agora Video Interactive Broadcast prioritizes high voice quality. Users can be the host or audience, where only the host can talk. A user who wants to talk must change the role to a host. A typical scenario of an Agora Video Interactive Broadcast is an interactive online class.

## Functions and Scenarios

The Agora Native SDK for Video Call boasts a flexible combination of functions for different scenarios.

<style> table th:first-of-type {     width: 150px; } th:third-of-type {     width: 170px; }</style>

| Function                              | Description                                                  | Scenario                                                     |
| ----------------- | ------------------------------------------------------------ | --------------------------------------- |
| Audio mixing          | Sends the local and online audio with the user's voice to other users in the channel. | <li>Online KTV. <li>Interactive music classes. |
| Screen sharing             | Enables the local user to share the screen to other users in the channel. Supports specifying which screen or which window to share, and supports specifying the sharing region.            | Interactive online classes.     |
| Basic image enhancement     | Sets basic beauty effects, including skin smoothening, whitening, and cheek blushing. | Image enhancement in a video call.    |
| Modify the raw data   | Enables developers to obtain and modify the raw voice or video data and to create special effects, such as a voice change. | <li>To change the voice in an online chatroom. <li>Image enhancement in a video call.                  |
| Customize the video source and renderer | Enables customization of the video sources and renderers. This allows users to use self-built cameras and videos from screen sharing or files to process videos, such as for image enhancement and filtering. | <li>To use a customized image enhancement library or pre-processing library.<li>To customize the application's built-in image and video modules.<li>To use other video sources, such as a recorded video.<li>To provide flexible device management for exclusive video capture devices to avoid conflicts with other services. |

## Key Properties

| Property                                          | Agora Video Call Specifications                          |
| ------------ | ------------------------------------------------------------ |
| SDK Package Size                                  | 3.69 MB to 7.75 MB                                              |
| Capacity     | Seventeen users  |
| Video Profile                                     | <li>SDK video source: Up to 1080p @ 60 fps<li>Custom video source: Up to 4K |
| Audio Profile                                     | <li>Sample rate: 16 kHz to 48 kHz<li>Support for mono and stereo sound |
| Audio Anti-packet-loss Rate                       | 70% (uplink and downlink)                               |

## Compatibility

The Agora Native SDK for Video Call is supported on platforms such as iOS, Android, Windows, macOS, Electron, Linux, and Web, and allows for cross-platform connections. The following is a list of supported platforms and their versions.

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
	
## Reference
[How many users can Agora RTC SDK support at the same time?](https://docs.agora.io/en/faq/capacity)