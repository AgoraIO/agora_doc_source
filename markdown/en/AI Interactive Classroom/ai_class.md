---
title: AI Interactive Classroom
platform: All Platforms
updatedAt: 2020-12-04 04:10:26
---
## Overview

In an AI Interactive Classroom, instead of a real teacher, a server-side AI teacher automatically sends pre-recorded educational videos to students.

![img](https://web-cdn.agora.io/docs-files/1579073897124)

The whole process of an AI-enabled interactive class is as follows:

- Before a class:
  - Record key points, questions and answers in video clips based on the curriculum.
  - Implement the Agora Media Streaming Server SDK on your server.

- During a class:
  - The AI teacher on the server pushes video files to students.
  - Students view the videos and answer the AI teacher's questions either by clicking the icons on the screen or speaking into the microphone.
  - The AI teacher on the server interprets feedback from the students, and acts accordingly. 

### Features

| Feature                         | Description                                                  |
| :------------------------------ | :----------------------------------------------------------- |
| Real-time communication         | Students can send and receive real-time audio and video data and interact with each other. |
| Real-time messaging             | Students can chat with text messages in real time.           |
| Sending media files to students | The server sends MP4 files to an Agora channel and generates a playback queue for switching between video clips seamlessly. |
| Noise reduction and audio gain  | Agora provides a tool for reducing noise and turning up the audio gain to improve the audio quality of your video files. |
| AI frame interpolation          | Agora provides a tool for frame interpolation to ensure smooth switch between the video files. |
| Oral English assessment         | Agora provides a sample app that demonstrates how to English spoken words captured by the Agora RTC SDK to a third-party platform for pronunciation assessment. |

### Demos

Agora provides demos of the AI Interactive Classroom on Android and iOS.

| Android                                                      | iOS                                                          |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| ![](https://web-cdn.agora.io/docs-files/1577098775056) | ![](https://web-cdn.agora.io/docs-files/1577098784555) |

## Technical Solution

### Technical architecture

![](https://web-cdn.agora.io/docs-files/1582851956676)

Students:

- Integrate the Agora RTC SDK and the Agora RTM SDK to implement real-time interaction by sending and receiving real-time messages, audio and video through the Agora SD-RTN™, an underlying real-time transmission network built by Agora. 
- Through the Agora RTC SDK, send the audio stream to the third-party platform for audio recognition and oral English assessment.

AI teacher on the server:

- Obtain the answer data and oral English assessment results from Agora SD-RTN™, and compare them with the answer key for judgement.
- Based on the students' responses, obtain the corresponding video clips from the video library, and push the video clips to the students' clients through the Agora Media Streaming Sever SDK.

### Advantages

#### 1. High-speed and stable real-time data transmission

Agora SD-RTNTM, a self-built real-time audio and video dedicated network, deploys nodes covering more than 200 countries and regions around the world. It particularly optimizes the last-mile transmission in areas such as North America, the Philippines, India, etc. to ensure high concurrency, high availability, high stability, and low latency.

#### 2. Excellent performance under poor network conditions

Agora is dedicated to improving the performance under poor network conditions by intelligently adjusting the bit rate and frame rate, optimizing the end-to-end algorithm, and utilizing the jitter buffer mechanism.

With an industry-leading algorithm designed to minimize the impact of packet loss, Agora guarantees smooth audio and video when the packet loss rate reaches 60%, and smooth audio when the packet loss rate is as high as 70%.

#### 3. AI frame interpolation

Agora provides a tool for inserting frames between two separate video files. By doing this, Agora ensures a seamless and smooth switch between the two video files.

#### 4. High audio quality

Agora provides a tool for reducing the noise in videos recorded in an indoor environment and turning up the audio gain.

#### 5. Compatibility

Agora SDKs are compatible with more than 6000 devices. Agora optimizes audio and video performance for low-end devices.

#### 6. Quality assurance during and after class

Agora Analytics can be used for tracking and analyzing the usage and quality of classes. You can use this tool to locate quality issues, track down root causes, and fix any problems to improve the final user experience.

## Implementation

### API call sequence

![](https://web-cdn.agora.io/docs-files/1582852021038)

### Build an AI teacher on a server

Integrate the Agora Media Streaming Server SDK on your server to successfully push media files to an Agora channel.

<div class="note alert">Click <a href="https://download.agora.io/ardsdk/release/Agora_MediaStreamingServer_SDK_for_Linux_v2_6_1_180_FULL_20200212_85.tar.gz">here</a> to download the Agora Media Streaming Server SDK. </div>

Agora provides:

- A media streaming command-line tool that can push a maximum of three video clips to a specified Agora live-broadcast channel in sequence. For details, see [Streaming by Command Line](/en/Server/use_streaming_command_line_tool).
- Three preprocessing tools, including:
  - mediaConvert: Use this tool to transcode video files and ensure that the format of the video files meets certain requirements. For details, see [Use mediaConvert](/en/Server/preprocess#transcoding).
  - mediaDenoise: Use this tool to reduce the background noise, turn up the audio gain of sound in video files, and change the resolution of output video files. For details, see [Use mediaDenoise](/en/Server/preprocess#denoise).
  - AIInterpolation: Use this tool to insert frames between two video files. For details, see [Use AIInterpolation](/en/Server/preprocess#interpolation).
- An Integration guide, which shows you how to integrate the Agora Media Streaming Server SDK into your project and call APIs for media streaming. For details, see [Implement Media Streaming on Server](/en/Server/media_streaming_on_server).

### Build a client for students

#### Real-time communication

You can download the Agora RTC SDK and follow the steps in the Quick Start to integrate the SDK into your project, and call the APIs to implement basic broadcasting on Android, Windows, iOS and macOS.

| Platform | SDK download                                                 | Open-source demo                                             | Integration guide                                            |
| :------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| Android | [v2.9.0.101](https://download.agora.io/sdk/release/Agora_Native_SDK_for_Android_v2_9_0_101_FULL_20191230_928.zip) | [Open Live (Java)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-Android) | [Quick start on Android](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_android?platform=Android) |
| iOS     | [v2.9.0.101](https://download.agora.io/sdk/release/Agora_Native_SDK_for_iOS_v2_9_0_101_FULL_20191227_1767.zip) | [Open Live (OC)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-iOS-Objective-C)<br>[Open Live (Swift)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-iOS) | [Quick start on iOS](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_ios?platform=iOS) |
| macOS   | [v2.9.0.101](https://download.agora.io/sdk/release/Agora_Native_SDK_for_Mac_v2_9_0_101_FULL_20191226_1001.zip) | [Open Live (OC)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-macOS-Objective-C)<br>[Open Live (Swift)](https://github.com/AgoraIO/Basic-Video-Broadcasting/tree/master/OpenLive-macOS) | [Quick start on macOS](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_mac?platform=macOS) |
| Windows | [v2.9.0.101](https://download.agora.io/sdk/release/Agora_Native_SDK_for_Windows(x86)_v2_9_0_101_20200102_FULL_86.zip) | [Open Live (C++)](https://github.com/AgoraIO/Basic-Video-Broadcasting/blob/master/OpenLive-Windows) | [Quick start on Windows](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_windows?platform=Windows) |
| Web     | [Web SDK](https://docs.agora.io/cn/Agora%20Platform/downloads) | [Demo (JS)](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-Web/README.zh.md) | [Quick start on Web](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_web?platform=Web)  |              

#### Real-time message

You can download the Agora RTM SDK and follow the steps in the Quick Start to integrate the SDK into your project, and call the APIs to implement basic real-time messaging on Android, Windows, iOS and macOS.

| Overview                                                     | SDK download                                                 | Integration guide                                            |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| [Real-time message](https://docs.agora.io/en/Real-time-Messaging/product_rtm?platform=All%20Platforms) | [Agora Real-time Message SDK download](https://docs.agora.io/en/Real-time-Messaging/downloads) | [Peer-to-peer or Channel Messaging](https://docs.agora.io/en/Real-time-Messaging/messaging_android?platform=Android) |

#### Oral English assessment

Agora provides the following demos that shows how to send the audio captured by the Agora RTC SDK to a third-party platform for oral English assessment.

| Platform | Open-source demo                                             |
| :------- | :----------------------------------------------------------- |
| Android  | [Pronunciation Assessment (Android)](https://github.com/AgoraIO/Advanced-Audio/tree/master/Pronunciation-Assess/Pronunciation-Assess-Android) |
| iOS      | [Pronunciation Assessment (iOS)](https://github.com/AgoraIO/Advanced-Audio/tree/master/Pronunciation-Assess/Pronunciation-Assess-iOS) |