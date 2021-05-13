---
title: 互动播客
platform: Android
updatedAt: 2021-03-31 08:46:14
---
## Overview
Livecast is a live streaming scenario characterized by audio-only real-time interaction. A Livecast room has a single host and multiple audience members Normally, the host streams audio while the audience listens. Audience members can become co-hosts, however, which allows them to stream audio as well. There are an unlimited number of co-host "seats," and everyone in the room can see who the co-hosts are in real-time. The host and audience members have the following permissions,:

- The host can publish audio streams, invite an audience member to become a co-host, mute a co-host, or remove a co-host from their co-host seat.
- Regular audience members cannot publish audio streams, but any that have become a co-host can. An audience member can become a co-host by accepting an invitation from the host.  Audience members can also make a request to the host for a co-host seat.

Livecast is a popular scenario in the voice social media industry. Typical include online radio stations, online board games, and multi-person voice chats.

## Feature list

A typical Livecast scenario implements the following features:

| Feature | Description |
| :----------- | :----------------------------------------------------------- |
| Real-time audio interaction | With ultra-low latency, the audience members receive audio streams from the host and co-hosts in real time, and the host and co-hosts receive audio streams from each other in real time. This feature ensures smooth audio interaction. |
| Host seat management | The host can invite an audience member to become a co-host, mute a co-host, and remove a co-host from their co-host seat. All participants in the room can see the real-time status of each co-host seat. |
| User management | Everyone in the room can see the room member list and edit their nicknames. |



## Technical solutions

Agora uses the Agora RTC SDK and a third-party cloud storage SDK to build the Livecast scenario.

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

The following technologies ensure that the speaker's voice always stands out from a noisy environment: A maximum audio sampling rate of 48 kHz for full band frequency, and the 3A algorithm featuring automatic echo cancellation (AEC), automatic noise suppression (ANS), and automatic gain control (AGC).

**5. Rich voice effects**

During live streaming, adding voice changer and reverb effects brings much fun and enhances the atmosphere of the live room. Agora provides an enriched selection of voice effects. You can easily implement them by calling an API.