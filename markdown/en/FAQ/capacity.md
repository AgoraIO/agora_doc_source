---
title: How many users can Agora RTC SDK support at the same time?
platform: ["All Platforms"]
updatedAt: 2021-01-13 10:23:17
Products: ["Video","Voice","Audio Broadcast","Interactive Broadcast"]
---
Agora RTC SDK provides real-time audio and video services for multiple users. The following table shows the number of concurrent channels and users supported by the Agora RTC SDK:

| Channel profile | SDK version | Number of users in a channel | Number of channels |
| ---------------- | ---------------- | ---------------- | ---------------- |
|    `COMMUNICATION`   |   v3.0.0 or later    |   Up to one million users in a channel. Agora recommends limiting the number of users sending streams concurrently to 17 at most.    | No limit |
|    `COMMUNICATION`   |   Earlier than v3.0.0    |   Up to one million users in a channel. Agora recommends limiting the number of users sending streams concurrently to 7 at most.    | No limit |
|   `LIVE_BROADCASTING`   |   All    |   Up to one million users in a channel. Agora recommends limiting the number of hosts sending streams concurrently to 17 at most.    | No limit |


<div class="alert note"><li>If the number of users sending streams concurrently exceeds the recommended value, each user in the channel can only see or hear a random group of users who are sending streams. For example, if 18 hosts are sending streams concurrently in a live streaming channel, each user cannot see or hear a random one of the 18 hosts.<li>In group video call or live interactive streaming senarios, Agora recommends enabling <a href="https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#dual-stream">dual-stream</a > mode and using the default setting for the low-quality video stream.<li>Agora does not provide APIs for limiting the number of users sending streams concurrently, and you can implement the limitation in your application layer.</li></ul></div>