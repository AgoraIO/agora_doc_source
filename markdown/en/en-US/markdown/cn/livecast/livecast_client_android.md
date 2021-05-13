---
title: 客户端实现
platform: Android
updatedAt: 2021-03-31 08:46:45
---
This document describes how to implement the basic features of Livecast using the Agora RTC SDK.



## Flowchart

Refer to the following chart to implement your app service:![](https://web-cdn.agora.io/docs-files/1617009861278)


## Integrate the SDK

Refer to the following table to download the SDKs and integrate them into your project:

| Product | SDK | Help document |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| [Agora RTC (Real-time Communication) SDK](/cn/InteractiveBroadcast/product_live?platform=AllPlatforms) | [Agora Audio SDK for Android](/cn/livecast/downloads?platform=Android) | [Start Interactive Live Audio Streaming](/cn/InteractiveBroadcast/start_live_audio_android?platform=Android) |
| [Third-party cloud storage SDK](https://leancloud.cn/) | [Third-party SDK](https://leancloud.cn/docs/sdk_down.html) | [Integration guide](https://leancloud.cn/docs/leanstorage_guide-java.html) |

## API call sequence

Refer to the following diagram to call the core APIs of the Agora RTC SDK and implement the basic features of Livecast.

<div class="alert note">You need to implement the cloud storage functions in the following diagram on your own.</div>

**Creating and joining a room**

![](https://web-cdn.agora.io/docs-files/1617160624925)

**Managing co-host seats**

![](https://web-cdn.agora.io/docs-files/1617160644420)


## Core API reference

| API | Functions |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [create](API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a35466f690d0a9332f24ea8280021d5ed) | Before calling other APIs, you need to call this method to create and initialize `RtcEngine`. |
| [setClientRole](API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa2affa28a23d44d18b6889fba03f47ec) | Sets the client role. When joining a room, you need to set the role of the host to `BROADCASTER`, and the role of the audience members to `AUDIENCE`. After an audience member becomes a co-host, you need to call this method to set the role of the audience member to `BROADCASTER` so that they can publish audio streams. |
| [joinChannel](API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a8b308c9102c08cb8dafb4672af1a3b4c) | Joins the room. A user must joins the room before publishing or receiving audio streams. |
| [leaveChannel](API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a2929e4a46d5342b68d0deb552c29d597) | Leaves the room. If the host leaves the room, the room object is destroyed and other room members leave the room automatically. |
| [muteLocalAudioStream](API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a838a04b744e6fb53bd1548d30bff1302) | Disables/Enables the local microphone. This method is used together with the state management function of cloud storage so that the host can mute a co-host and remove a co-host. |

## Additional functions

**Audio mixing and effects**

After joining the channel, call `startAudioMixing` to play a music file for background music, or call `playEffect` to play an audio effect file for a better atmosphere. See [Play Audio Effect or Music File](/cn/InteractiveBroadcast/effect_mixing_android?platform=Android).

**Set the Voice Effect**

After joining the room, call `setVoiceBeautifierPreset` and `setAudioEffectPreset` to use the voice presets provided by the SDK for a better atmosphere; or call `setLocalVoicePitch`, `setLocalVoiceEqualization`, and `setLocalVoiceReverb` to adjust the pitch, equalization, and reverb settings for custom voice effects. See [Set the Voice Effect](/cn/InteractiveBroadcast/voice_changer_android?platform=Android).

**Content moderation**

(Ignore this) Use the Alibaba RESTful API to perform real-time content moderation on the audio streams in the room. (Ignore this) See [Moderate audio streams](/cn/AliyunAudioModeration/quickstart_ali_audio?platform=RESTful).

## Open-source demo

Agora provides an open-source demo for Livecast on GitHub. You can view the source code and run the demo.

| Android | iOS |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [Livecast (Android)](https://github.com/AgoraIO-Usecase/InteractivePodcast/tree/main/Android) | [Livecast (iOS)](https://github.com/AgoraIO-Usecase/InteractivePodcast/tree/main/iOS) |

## FAQ

- [How to protect interactive live streaming from stream bombing?](https://docs.agora.io/cn/InteractiveBroadcast/faq/stream_bombing)
- [How do I use co-host token authentication?](https://docs.agora.io/cn/InteractiveBroadcast/faq/token_cohost)