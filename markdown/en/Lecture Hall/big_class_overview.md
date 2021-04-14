---
title: Lecture Hall
platform: Android
updatedAt: 2020-03-11 11:40:31
---
## Introduction

The growth of the online education sector has given rise to the Big Online Classroom scenario. In this scenario, thousands of students watch an online lecture. Students can "raise their hands" to interact with the teacher, and their responses are viewed by all the other students at the same time.

This article describes how to use the Agora SDKs to implement a Big Online Classroom.

![](https://web-cdn.agora.io/docs-files/1582270298743)

## Feature list

You can use the Agora SDKs to implement the following features for your project.

| Feature | Description | 
| ---------------- | ---------------- | 
| Real-time communication     | The students attend an online class given by the teacher. They can see and hear their teacher in real time.<br>Students can "raise their hands" to interact with the teacher, and their responses are viewed by all the other students at the same time.      | 
| Real-time messaging | Both the teacher and the students can chat with each other through text messages. |
| Whiteboard | The teacher can share a Powerpoint slide, a Word or PDF file, or even an audio or video file on it.<br>   |
| Recording | The teacher can record the class and share the recording through a link for future review or evaluation. |
| Class management | The teacher starts or ends the class, and manages the students' privilege for sending audio, video, or real-time messages. |
| Device and network test | Before the class, the teacher can test whether the microphone and camera are working properly. <br> During the class, both the teacher and the students can monitor the network quality in real time. |
| Screen share | The teacher can share the screen with the students.|


## Try the demo

Agora provides the Big Online Classroom demos on the following platforms. 

<style> table th:first-of-type {     width: 120px; } th:second-of-type {     width: 100px; }</style>
| Android | iOS | PC Web | Windows | macOS |
| ---------------- | ---------------- | ---------------- | ---------------- | ---------------- |
| [Try it out](https://download.agora.io/demo/release/app-AgoraCloudClass-release.apk) | ![](https://web-cdn.agora.io/docs-files/1581407452682) |  [Try it out](https://solutions.agora.io/education/web/#/)      | Coming up soon | Coming up soon |

In which:
- The client for a student can be Android, iOS, or Web for now.
- The client for the teacher is Web for now.

Follow these steps to try the demo:
1. Fill in the classroom number and username.
2. Choose **Lecture Hall**.
3. Set your role as either **Teacher** or **Student**.
4. Click **Join** to enter the classroom.

## 技术方案

Agora 使用 [Agora RTC SDK](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#agora-rtc-sdk)、[Agora RTM SDK](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#agora-rtm-sdk)、[Agora 云端录制服务](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#cloud-recording)、[Agora 房间管理服务](https://agoradoc.github.io/cn/edu-cloud-service/restfulapi/)和第三方白板 SDK 共同搭建互动直播大班课场景。

![](https://web-cdn.agora.io/docs-files/1589179187327)

各 SDK 或服务实现的功能如下：

| SDK 或服务 | 实现功能 | 
| ---------------- | ---------------- | 
| Agora RTC SDK      | 加入 RTC 频道，进行实时音视频互动。      | 
| Agora RTM SDK      | 登录 RTM 系统并加入 RTM 频道，实现收发实时文字消息。      | 
| Agora 云端录制服务 | 录制实时音视频、录制完成后即时回放。 |
| Agora 房间管理服务      | 为教师端和学生端提供教室后台服务，实现教室信息管理、权限控制等功能。      | 
| 第三方白板 SDK | 实现互动白板相关功能。|

## 方案优势

该方案有如下优势：

**超低延时**

Agora SD-RTN™ 网络节点覆盖全球 200 多个国家和地区，通过就近接入、智能路由等控制策略，保证全球平均端到端延时 < 400 ms。

**稳定可靠**

提供 SLA 质量保证，登录成功率 > 99%，全年可用时间高达 99.99%。

**极致弱网对抗能力**

业界领先的弱网对抗算法，保证在 60% 丢包情况下，音视频通话流畅；70% 丢包情况下，音频通话流畅，真正做到低卡顿、不掉线。


**高音质**

支持 48 kHz 全频带采样，业界领先的 3A 算法（回声消除、噪声抑制、自动增益）和 AI 音频降噪算法，在嘈杂环境下也能保持语音清澈，提供高品质的教学体验。

**高清画质**

支持 48p - 1080p 动态适配，最高支持 4K 极致高清。支持 H.265、超分辨率和感知视频编码，在同等分辨率、帧率情况下，视频占有带宽更低，画质体验更好。


**支持更多互动玩法**

根据实际应用场景，你还可以扩展出更多玩法，增进老师和学生的互动。

- 在线答题。
- 学生端即时上麦，且连麦时间几乎无感知。


**丰富的功能组件**

- 支持教学白板，包括多种可扩展教具、动态 PPT、H5 课件等；
- 支持屏幕共享、课件共享、笔记共享等；
- 支持课程录制，包括本地录制、云录制、精彩集锦录制等。

**方便易用的后台服务**

为后端开发能力稍弱的开发者提供 Agora Edu 云服务。接入后，开发者无需自研教室后台业务，通过调用 RESTful API 就能轻松快速实现教室信息管理、权限控制等功能。

**课堂质量透明可溯**

Agora 通过如下接口及产品，保障实时音视频的质量：

- 丰富的课前网络和设备检测接口以及完整的课中通话质量回调，排除潜在问题，扫清上课障碍；
- [水晶球](https://console.agora.io/analytics/call/search)工具，显示端到端全链路的质量监控数据，上课过程可追溯，提供用户行为、运行状态、QoE/QoS 的质量数据，帮助排查定位问题。

**全平台适配**

- 支持 Windows、macOS、Web、iOS、Android、Electron 等多达 18 种平台和开发架构适配；
- 支持 6000+ 款机形适配，保证全球师生体验的一致性。