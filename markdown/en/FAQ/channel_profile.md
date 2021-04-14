---
title: What is the difference between the Communication and Live-broadcast profile?
platform: ["All Platforms"]
updatedAt: 2020-05-18 12:43:05
Products: ["Voice","Video","Interactive Broadcast","Audio Broadcast"]
---
Agora provides two channel profiles for an Agora RTC channel: Communication and Live-broadcast.

These two channel profiles differ in the following aspects:

| Difference | Communication | Live-broadcast |
| ---------------- | ---------------- | ---------------- |
| The default user role      | Broadcaster, and you cannot change the user role in this profile.      | Audience, and you can change the user role by calling `setClientRole`.      |
| The default audio route      | <ul><li>Voice call: Earpiece.</li><li>Video call: Speakerphone.</li></ul>| Speakerphone. |
| The default video encoding<br> bitrate	 | The base bitrate.	 | Twice the base bitrate. |


**Reference**

* [Video encoding bitrate](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a4b090cd0e9f6d98bcf89cb1c4c2066e8)