---
title: Multiple Hosts
platform: All Platforms
updatedAt: 2020-11-16 08:30:25
---
## Introduction

Co-hosted interactive streaming is a scenario where multiple hosts interact with each other in a live interactive streaming channel. During interactive streaming, the host can manage the host seats and invite the audience members to become a co-host. Additionally, the audience members can apply to become a co-host.

This article describes how to use the Agora SDKs to implement a co-hosted interactive streaming scenario.

## Feature list

You can use the Agora SDKs to implement the following features in your project:

<style> table th:first-of-type {     width: 150px; } th:third-of-type {     width: 170px; }</style>
| Feature | Description |
| ---------------- | ---------------- |
| Real-time communication	      | With ultra low latency, the audience see and hear the host in real time. |
| Interactive co-hosting       | The host invites the audience members or the audience members apply to become a co-host. All audience members in the channel can see and hear the host and co-hosts interacting with each other in real time. |
| Host seat management         | A host seat is a seat in the interactive streaming room. An audience member who takes up a host seat can interact with the host. The host has the following control privileges over the co-hosts and host seats:<ul><li>Invite a co-host: The host invites an audience member to become a co-host, who then can interact with the host.</li><li>Stop co-hosting: The host switches a co-host back to an audience member.</li><li>Mute a co-host: The host revokes a co-host's privilege of sending audio and video streams.</li><li>Unmute a co-host: The host restores a co-host's privilege of sending audio and video streams.</li><li>Close a host seat: The host closes a host seat, thus banning an audience member from applying for the seat.</li><li>Reopen a host seat: The host reopens a host seat, thus allowing an audience member to apply for the seat.</li></ul>All users in the channel can see the state changes of each host seat in real time. |
| Real-time messaging	| The host, co-hosts, and the audience can chat with each other through text messages.|
| User status	| The host, co-hosts, and the audience are notified when a user joins or leaves the channel. |
| Real-time quality statistics	| Before joining a channel or during interactive streaming, all users can check the network quality in real time. |
| Background music |  For better interaction effects, the host and co-hosts can play background music when talking or singing. |
| Image enhancement	 | Basic image enhancement effects, including whitening, skin smoothening, and cheek blushing, help the host and co-hosts look better. |

## Try the demo app

Agora provides the Co-hosted Interactive Streaming demo apps on the following platforms:

| Android | iOS | 
| ---------------- | ---------------- |
| ![](https://web-cdn.agora.io/docs-files/1594287476322)      | ![](https://web-cdn.agora.io/docs-files/1594287505817)      | 

Since a co-hosted interactive streaming scenario has multiple users, Agora recommends downloading and installing the demo app on **two** mobile devices. After installation, follow these steps to test the demo app:

1. On one device, click **Agora Live** and choose **Multi Hosts**.
2. Click the **Camera** icon on the lower right and enter a room name to create a channel. The user who first joins the channel becomes the host.
3. On the other device, click **Agora Live**, choose **Multi Hosts**, and join the created channel as an audience member.
4. On the host side, tap the user profile to invite an audience member for co-hosting; on the audience side, tap a vacant host seat to apply for co-hosting.
5. During co-hosting, the host can tap a host seat to stop co-hosting, mute and unmute a co-host, and close a host seat.

<div class="alert note">During the test, the demo app prompts to request authorization for the camera and audio recording. Grant permissions accordingly.</div>

## Technical solutions

Agora recommends using the following SDKs or services to implement a co-hosted interactive streaming scenario:

![](https://web-cdn.agora.io/docs-files/1594363370865)

| Product | Function |
| ---------------- | ---------------- |
| Agora RTC SDK      | Joins an RTC channel for real-time audio and video communication.      |
| Agora RTM SDK | Logs into the RTM system and joins an RTM channel for sending and receiving text messages. |
| Third-party Image Enhancement SDK | Sets basic image enhancement effects, including whitening, skin smoothening, and cheek blushing. |
| Cloud Service | Manages host seats, room information, and user information.|

<div class="alert note">The Cloud Service in the demo app is implemented by Agora, and you need to deploy your own cloud service for the same purposes.</div>

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