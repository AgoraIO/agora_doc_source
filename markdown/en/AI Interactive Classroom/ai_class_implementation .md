---
title: AI Interactive Classroom
platform: All Platforms
updatedAt: 2020-11-17 07:23:49
---
## API call sequence

![](https://web-cdn.agora.io/docs-files/1582852021038)

## Build an AI teacher on a server

Integrate the Agora Media Streaming Server SDK on your server to successfully push media files to an Agora channel.

<div class="note alert">Click <a href="https://download.agora.io/ardsdk/release/Agora_MediaStreamingServer_SDK_for_Linux_v2_6_1_180_FULL_20200212_85.tar.gz">here</a> to download the Agora Media Streaming Server SDK. </div>

Agora provides:

- A media streaming command-line tool that can push a maximum of three video clips to a specified Agora live-broadcast channel in sequence. For details, see [Streaming by Command Line](https://docs-preview.agoralab.co/en/Server/use_streaming_command_line_tool).
- Three preprocessing tools, including:
  - mediaConvert: Use this tool to transcode video files and ensure that the format of the video files meets certain requirements. For details, see [Use mediaConvert](https://docs-preview.agoralab.co/en/Server/preprocess#transcoding).
  - mediaDenoise: Use this tool to reduce the background noise, turn up the audio gain of sound in video files, and change the resolution of output video files. For details, see [Use mediaDenoise](https://docs-preview.agoralab.co/en/Server/preprocess#denoise).
  - AIInterpolation: Use this tool to insert frames between two video files. For details, see [Use AIInterpolation](https://docs-preview.agoralab.co/en/Server/preprocess#interpolation).
- An Integration guide, which shows you how to integrate the Agora Media Streaming Server SDK into your project and call APIs for media streaming. For details, see [Implement Media Streaming on Server](https://docs-preview.agoralab.co/en/Server/media_streaming_on_server).
- The [API reference](https://docs.agora.io/en/AI%20Interactive%20Classroom/API%20Reference/server_cpp/index.html) of Agora Media Streaming Server SDK.

## Build a client for students

### Real-time communication

You can download the Agora RTC SDK and follow the steps in the Quick Start to integrate the SDK into your project, and call the APIs to implement basic broadcasting on Android, Windows, iOS and macOS.

| Platform | SDK download                                                 | Open-source demo                                             | Integration guide                                            |
| :------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| Android | [v2.9.0.107](https://download.agora.io/sdk/release/Agora_Native_SDK_for_Android_v2_9_0_107_FULL_20201011_788.zip) | [Open Live (Java)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-Android) | [Quick start on Android](https://docs.agora.io/en/Interactive%20Broadcast/start_live_android?platform=Android) |
| iOS     | [v2.9.0.107](https://download.agora.io/sdk/release/Agora_Native_SDK_for_iOS_v2_9_0_107_FULL_20201012_3677.zip) | [Open Live (OC)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-iOS-Objective-C)<br>[Open Live (Swift)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-iOS) | [Quick start on iOS](https://docs.agora.io/en/Interactive%20Broadcast/start_live_ios?platform=iOS) |
| macOS   | [v2.9.0.107](https://download.agora.io/sdk/release/Agora_Native_SDK_for_Mac_v2_9_0_107_FULL_20201012_2373.zip) | [Open Live (OC)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-macOS-Objective-C)<br>[Open Live (Swift)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-macOS) | [Quick start on macOS](https://docs.agora.io/en/Interactive%20Broadcast/start_live_mac?platform=macOS) |
| Windows | [v2.9.0.107](ttps://download.agora.io/sdk/release/Agora_Native_SDK_for_Windows(x86)_v2_9_0_107_20201012_FULL_420.zip) | [Open Live (C++)](https://github.com/AgoraIO/Basic-Video-Broadcasting/blob/master/OpenLive-Windows) | [Quick start on Windows](https://docs.agora.io/en/Interactive%20Broadcast/start_live_windows?platform=Windows) |
| Web     | [Web SDK](https://docs.agora.io/en/Agora%20Platform/downloads) | [Demo (JS)](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-Web/README.zh.md) | [Quick start on Web](https://docs.agora.io/en/Interactive%20Broadcast/start_live_web?platform=Web)  |              

### Real-time message

You can download the Agora RTM SDK and follow the steps in the Quick Start to integrate the SDK into your project, and call the APIs to implement basic real-time messaging on Android, Windows, iOS and macOS.

| Overview                                                     | SDK download                                                 | Integration guide                                            |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| [Real-time message](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [Agora Real-time Message SDK download](https://docs.agora.io/en/Real-time-Messaging/downloads) | [Peer-to-peer or Channel Messaging](https://docs.agora.io/en/Real-time-Messaging/messaging_android?platform=Android) |

### Oral English assessment

Agora provides the following demos that shows how to send the audio captured by the Agora RTC SDK to a third-party platform for oral English assessment.

| Platform | Open-source demo                                             |
| :------- | :----------------------------------------------------------- |
| Android  | [Pronunciation Assessment (Android)](https://github.com/AgoraIO/Advanced-Audio/tree/dev/backup/Pronunciation-Assess/Pronunciation-Assess-Android) |
| iOS      | [Pronunciation Assessment (iOS)](https://github.com/AgoraIO/Advanced-Audio/tree/dev/backup/Pronunciation-Assess/Pronunciation-Assess-iOS) |