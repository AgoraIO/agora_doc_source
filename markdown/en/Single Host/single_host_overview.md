---
title: Single Host
platform: All Platforms
updatedAt: 2020-11-12 11:37:11
---
## Introduction

The Single Host scenario is an interactive streaming scenario which has only one host in the channel. In the scenario, all other users join the channel as audience and can watch the host, send text messages, and send gifts to the host.
This article describes how to use the Agora SDKs to implement a Single Host scenario.

## Feature list

You can use the Agora SDKs to implement the following features in your project:

| Feature | Description |
| ---------------- | ---------------- |
| Real-time communication	      | With ultra low latency, the audience see and hear the host in real time. |
| Real-time messaging	| Both the host and the audience can chat with each other through text messages. The audience can also send gifts to the host through real-time messaging.|
| Room management              | The host and the audience can get the following information of the current room:<li>Room type.<li>Number of users in the room.<li>User list.<li>User role and status.<li>Whether the user can send audio and video. |
| User status	| Both the host and the audience are notified when a user joins or leaves the channel. |
| Real-time quality statistics	| Before joining a channel or during interactive streaming, all users can check the network quality in real time. |
| Background music |  For better interaction effects, the host can play background music when talking or singing. |
| Image enhancement	 | Basic image enhancement effects, including whitening, skin smoothening, and cheek blushing, help the host look better. |

## Try the demo app

Agora provides the Single Host demo apps on the following platforms:

| Android | iOS | 
| ---------------- | ---------------- |
| ![](https://web-cdn.agora.io/docs-files/1594287476322)      | ![](https://web-cdn.agora.io/docs-files/1594287505817)      | 

Since a Single Host scenario has a host and audience members, Agora recommends downloading and installing the demo app on **two** mobile devices. After installation, follow these steps to test the demo app:

1. Click **Agora Live** and choose **Solo Host**.
2. On one device, click the **Camera** icon on the lower right and enter a room name to create a channel. Join the channel as the host.
3. On the other device, join the created channel as an audience member.

<div class="alert note">During the test, the demo app prompts to request authorization for the camera and audio recording. Grant permissions accordingly.</div>

## Technical solutions

Agora recommends using the following SDKs or services to implement a Single Host scenario:

![](https://web-cdn.agora.io/docs-files/1594611424400)

| Product | Function |
| ---------------- | ---------------- |
| Agora RTC SDK      | Joins an RTC channel for real-time audio and video communication.      |
| Agora RTM SDK | Logs into the RTM system and joins an RTM channel for sending and receiving text messages. |
| Third-party Image Enhancement SDK | Sets basic image enhancement effects, including whitening, skin smoothening, and cheek blushing. |


## Advantages

**Ultra low latency** 

Agora SD-RTN<sup>TM</sup> is the Agora proprietary network for audio and video transmission, covering more than 200 countries and regions. It uses the intelligent routing algorithms to ensure that the average end-to-end latency worldwide is less than 300 ms.

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

During a live broadcast, adding voice changer and reverberation effects brings much fun and enhances the atmosphere of the live room. Agora provides an enriched selection of voice changer options, which developers can easily implement by calling an API.

**High-definition video**

Agora optimizes the video experience from the following perspectives:

- Supports a maximum resolution of 4K to accommodate the growing demand for high-definition video.
- Works with most main-stream devices, platforms, and scenarios by supporting H.265 codec, super resolution, and perceptual video coding.
- Uses a dynamic bitrate algorithm to adapt the video bitrate to the real-time network conditions for resolutions from 48p to 1080p.
- For a set resolution and frame rate, consumes less bandwidth and renders higher quality video.

**Support for third-party services**

For more enriched and diversified scenarios, you can easily import third-party services into your project, such as content moderation, image enhancement, and AR.

**Traceability**

- Agora provides a variety of methods for measuring network quality. We also have callbacks that report on communication quality during a live broadcast. Use these methods to ensure a smooth experience and to troubleshoot quality issues.
- You can also use [Agora Analytics](https://console.agora.io/analytics/call/search) to monitor the quality, user behavior, device state, and Quality of Experience (QoE)/Quality of Service (QoS) statistics.

**Compatibility**

Agora SDKs are compatible with more than 6,000 devices, covering over 18 platforms and development architectures, including Windows, macOS, Web, iOS, Android, and Electron. This ensures that all users share the same experience.