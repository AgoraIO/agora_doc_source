---
title: How can I choose the video resolution, frame rate and bitrate?
platform: ["Android","iOS","macOS","Web","Windows","Unity","Electron","React Native","Flutter"]
updatedAt: 2020-07-06 14:56:56
Products: ["Video","Interactive Broadcast"]
---
Video parameters vary on a case-by-case basis. For example:

- In a one-to-one online class, the video windows of the teacher and student are both large, which requires higher resolutions, frame rates, and bitrates.
- In a one-to-four online class, the video windows of the teacher and students are smaller, so lower resolutions, frame rates, and bitrates are used to accommodate the downward bandwidth.

The recommended parameters for different cases are as follows:
- One-to-one video call: 240p (320 x 240, 15 fps, 200 Kbps) or 360p (640 x 360, 15 fps, 400 Kbps).
- One-to-many video call: 120p (160 x 120, 15 fps, 65 Kbps), 180p (320 x 180, 15 fps, 140 Kbps), or 240p (320 x 240, 15 fps, 200 Kbps). 

You can also call the `setVideoEncoderConfiguration` method to set the video encoding parameters, such as by increasing the bitrate to ensure the video quality. Higher bitrates, frame rates, and resolutions improve the video quality but may cause jitter and increase costs.

Generally speaking, a live stream requires a higher bitrate to ensure high-video quality. Agora recommends setting the bitrate of live interactive streaming to two times that of a voice/video call. See [Set the bitrate](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a4b090cd0e9f6d98bcf89cb1c4c2066e8).