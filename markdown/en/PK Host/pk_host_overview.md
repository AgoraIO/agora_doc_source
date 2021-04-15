---
title: PK Host
platform: All Platforms
updatedAt: 2020-11-12 12:28:09
---
## Introduction

To attract an audience quickly, the host of a live broadcast often invites the host of another channel for co-hosting. Both hosts then engage in online contests, and audiences of both channels watch the hosts, send gifts, or cast votes for whichever host they like. This scenario, known as PK Host, is widely applied in entertainment apps.

This article describes how to use the Agora SDKs to implement a PK Host scenario.

## Feature list

You can use the Agora SDKs to implement the following features in your project:

| Feature | Description |
| ---------------- | ---------------- |
| Real-time communication	      | With ultra low latency, the audience see and hear the host in real time. |
| Co-host across channels	| Hosts from two channels engage in online contests, and audiences from both channels watch the hosts, send gifts, or cast votes.|
| Real-time messaging	| Both the host and the audience can chat with each other through text messages.|
| Switching channels	| Audiences can switch between channels to send gifts or cast votes to whichever host they like.  |
| User status	| Both the host and the audience are notified when a user joins or leaves the channel. |
| Real-time quality statistics	| Before joining a channel or during the live broadcast, all users can check the network quality in real time. |
| Background music |  For better interaction effects, the host can play background music when talking or singing. |
| Image enhancement	 | Basic image enhancement effects, including skin smoothening and cheek blushing, help the host look better. |

## Try the demo app

Agora provides the PK Host demo apps on the following platforms:

| Android | iOS | 
| ---------------- | ---------------- |
| [App Downloads](./downloads?platform=Android)   |[App Downloads](./downloads?platform=iOS)     | 

Since a PK Host scenario has two hosts across two channels, Agora recommends downloading and installing the demo app on **two** mobile devices. After installation, follow these steps to test the demo app:

1. Click **Agora Live** and choose **PK Host**.
2. Click the **Camera** icon on the lower right, and enter a room name to create a channel. Repeat this step on the other device to create a second channel. Ensure that you use different names for the channels.
3. On one device, join a channel and click the **PK** icon on the lower right. From the room listing, choose the name of the other channel, and click **Invite**.
4. On the other device, join the corresponding channel and click **Accept**. When the co-hosting begins, you should be able to see the video of both channels on both devices.

<div class="alert note">During the test, the demo app prompts to request authorization for the camera and audio recording. Grant permissions accordingly.</div>

## Technical solutions

Agora recommends using the following SDKs or services to implement a PK Host scenario:

![](https://web-cdn.agora.io/docs-files/1592897748158)

| Product | Function |
| ---------------- | ---------------- |
| Agora RTC SDK      | Joins an RTC channel for real-time audio and video communication.      |
| Agora RTM SDK | Logs into the RTM system and joins an RTM channel for sending and receiving text messages. |
| Third-party Image Enhancement SDK | Sets basic image enhancement effects, including skin smoothening and cheek blushing. |


## Advantages

**Ultra low latency** 

Agora SD-RTN™ is the Agora proprietary network for audio and video transmission, covering more than 200 countries and regions. It uses the intelligent routing algorithms to ensure that the average end-to-end latency worldwide is less than 400 ms.

**Stability and reliability**

The Agora SLA (Service Level Agreement) ensures a 99%+ login success rate and 99.99% service accessibility throughout the year.

**Excellent performance under poor network conditions**

With an industry-leading algorithm designed to minimize the impact of packet loss, Agora guarantees smooth audio and video communication when the packet loss rate reaches 70%, and smooth audio communication when the packet loss rate is as high as 80%.

When a user's network bandwidth is poor, our self-adaptive strategy prioritizes the communication of the audio and the host.

**High audio quality**

The following technologies ensure that the speaker's voice always stands out from a noisy environment:

- A maximum audio sampling rate of 48 kHz for full band frequency.
- The 3A algorithm featuring automatic echo cancellation (AEC), automatic noise suppression (ANS), and automatic gain control (AGC).

**Voice changer**

During interactive live streaming, adding voice changer and reverberation effects brings much fun and enhances the atmosphere of the live room. Agora provides an enriched selection of voice changer options, which developers can easily implement by calling an API.

**High-definition video**

Agora optimizes the video experience from the following perspectives:

- Supports a maximum resolution of 4K to accommodate the growing demand for high-definition video.
- Works with most main-stream devices, platforms, and scenarios by supporting H.265 codec, super resolution, and perceptual video coding.
- Uses a dynamic bitrate algorithm to adapt the video bitrate to the real-time network conditions for resolutions from 48p to 1080p.
- For a set resolution and frame rate, consumes less bandwidth and renders higher quality video.

**Support for third-party services**

For more enriched and diversified scenarios, you can easily import third-party services into your project, such as content moderation, image enhancement, and AR.

**Traceability**

- Agora provides a variety of methods for measuring network quality. We also have callbacks that report on communication quality during interactive live streaming. Use these methods to ensure a smooth experience and to troubleshoot quality issues.
- You can also use [Agora Analytics](https://console.agora.io/analytics/call/search) to monitor the quality, user behavior, device state, and Quality of Experience (QoE)/Quality of Service (QoS) statistics.

**Compatibility**

Agora SDKs are compatible with more than 6,000 devices, covering over 18 platforms and development architectures, including Windows, macOS, Web, iOS, Android, and Electron. This ensures that all users share the same experience.