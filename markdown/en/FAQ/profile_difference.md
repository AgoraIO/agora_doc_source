---
title: What are the differences between the COMMUNICATION and LIVE_BROADCASTING profiles?
platform: ["Android","iOS","macOS","Windows","Unity","Cocos Creator","Electron","React Native","Flutter"]
updatedAt: 2020-09-09 13:56:16
Products: ["Voice","Video","Interactive Broadcast"]
---
<div class="alert note">This article applies to the Agora RTC Native SDK only.</div>

To apply optimization algorithms for different real-time engagement scenarios, Agora provides a `setChannelProfile` method for the RTC channel. You can use this method to set the channel profile as either `CHANNEL_PROFILE_COMMUNICATION` or `CHANNEL_PROFILE_LIVE_BROADCASTING`. 

These two channel profiles differ in the following aspects:

- User role setting.
- The default audio route.
- The default video encoding bitrate.

## User role

An RTC channel differentiates users by roles. Once a user joins a channel, the user can be either of the following:

- A host, who can both publish and subscribe to streams.
- An audience member, who can subscribe to streams only.

The default user role in different channel profiles are different:

- `CHANNEL_PROFILE_COMMUNICATION`: Host. You cannot change the user role.
- `CHANNEL_PROFILE_LIVE_BROADCASTING`: Audience. You can call `setClientRole` to change the user role.

<div class="alert note">In scenarios involving co-host token authentication, if a user joins a channel with thalone does not take effect. For details, see <a href="https://docs.agora.io/en/faq/token_cohost">How can I use co-host token authentication</a>.</div>

## Audio route

The default audio route refers to the route that audio data takes within a device, such as the speakerphone or earpiece of a mobile phone.

On Android and iOS, Agora uses different default audio routes depending on the channel profile:

- `CHANNEL_PROFILE_COMMUNICATION`
  - In a voice call, the default audio route is the earpiece.
  - In a video call, the default audio route is the speakerphone.
- `CHANNEL_PROFILE_LIVE_BROADCASTING`: The default audio route is the speakerphone.

## Video encoding bitrate

The `bitrate` member in the `setVideoEncoderConfiguration` method sets the video encoding bitrate. Given the same resolution and frame rate, when you set `bitrate` as the default value, `STANDARD_BITRATE(0)`, the value of the encoding bitrate in the `LIVE_BROADCASTING` profile doubles that in the `COMMUNICATION` profile.

In the following table, the base bitrate applies to the `COMMUNICATION` profile, while the live bitrate applies to `LIVE_BROADCASTING`.

| Resolution (px) | Frame rate (fps) | Base bitrate (Kbps) | Live bitrate (Kbps) |
| ---------------- | ---------------- | ---------------- | ---------------- |
| 160 × 120      | 15      | 65      | 130 |
| 320 × 180      | 15      | 140      | 280 |
| 640 × 360      | 30      | 600      | 1,200 |
| 848 × 480      | 30      | 930      | 1,860 |

The values of bitrate in the table above are for reference only. For the detailed video profile table, see [API reference](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a4b090cd0e9f6d98bcf89cb1c4c2066e8).

## Recommended settings

Based on the differences above, Agora recommends setting the channel profile according to your scenario:
- In scenarios such as one-to-one call or group call, set the channel profile as `CHANNEL_PROFILE_COMMUNICATION`.
- In scenarios such as chatrooms, small classes, lecture halls, or interactive video streaming, set the channel profile as `CHANNEL_PROFILE_LIVE_BROADCASTING`.

