---
title: 互动播客
platform: Android
updatedAt: 2021-03-31 08:46:14
---
## Overview
Livecast is an interactive podcasting solution: audio-only live streaming that features audience participation. A Livecast room has a single host and unlimited audience members The host is responsible for live streaming audio to the audience, but audience members can become cohosts, which allows them to stream audio as well. There are an unlimited number of available cohost "seats," and everyone in the room can see who these cohosts are. The host and audience members have the following permissions:

- The host can publish audio streams, invite an audience member to become a cohost, mute a cohost, or remove an audience member from their cohost seat.
- Audience members cannot publish audio streams unless they have been granted a cohost seat. An audience member can become a cohost by accepting an invitation from the host.  Audience members can also request  a cohost seat.

Popular scenarios for Livecast in the voice social media industry include online radio stations, online board games, and multi-person voice chats.

## Feature list

A typical Livecast scenario implements the following features:

| Feature | Description |
| :----------- | :----------------------------------------------------------- |
| Real-time audio interaction | Audience members receive audio streams from the host and cohosts, and the host and cohosts receive audio streams from each other, all in real time with ultra-low latency. This ensures smooth audio interaction. |
| Cohost seat management | The host has complete control over the cohost seats. allowing them to nominate, mute, and remove cohosts. Cohost status is always displayed to everyone in the room.  .  |
| User management |  The list of all Livecast room participants is visible, and users can edit their nicknames. |



## Technical solutions

Agora uses the Agora RTC SDK and a third-party cloud storage SDK to build Livecast scenarios.

![img](https://confluence.agoralab.co/download/attachments/721393249/image2021-3-29_15-31-1.png?version=1&modificationDate=1617003061681&api=v2)

## Advantages

Agora’s Livecast has the following advantages:

**1. Ultra-low latency**

- End-to-end latency ranges between 200 ms to 300 ms on average and can be as low as 50 ms.
- This means that an audience member can switch to the co-host role before they notice.

**2. Stability and reliability**

The Agora SLA (Service Level Agreement) ensures a 99%+ login success rate and 99.99% service accessibility throughout the year.

**3. Excellent performance under poor network conditions**

Agora's industry-leading algorithm guarantees smooth audio and video calls even when the packet loss rate is 60%, and smooth audio calls even when the packet loss rate is 70%. This algorithm effectively minimizes freezes and prevents users from dropping out of their calls.

When the bandwidth is limited, Agora's self-adapting network algorithm gives transmission priority to the audio stream or the host's media stream.

**4. High sound quality**

The following technologies ensure that the speaker's voice always stands out from a noisy environment: a maximum audio sampling rate of 48 kHz for full band sampling frequency, and the 3A algorithm of automatic echo cancellation (AEC), automatic noise suppression (ANS), and automatic gain control (AGC).

**5. Rich voice effects**

During live streaming, adding voice changer and reverb effects can enhance the atmosphere of the Livecast room and increase audience engagement. The Agora API provides a wide  selection of audio effects that developers can choose without manual configuration. 