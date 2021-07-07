---
title: 客户端实现
platform: iOS
updatedAt: 2021-03-31 08:46:50
---
This document describes how to implement the basic features of Livecast using the Agora RTC SDK.



## Flowchart

Refer to the following chart to implement your app service:![](https://web-cdn.agora.io/docs-files/1617009861278)


## Integrate the SDK

Refer to the following table to download the SDKs and integrate them into your project:

| Product | SDK | Help document |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| [Agora RTC (Real-time Communication) SDK](/cn/InteractiveBroadcast/product_live?platform=AllPlatforms) | [音频直播 SDK](/cn/livecast/downloads?platform=iOS) | [Start Interactive Live Audio Streaming](/cn/InteractiveBroadcast/start_live_audio_ios?platform=iOS) |
| [Third-party cloud storage SDK](https://leancloud.cn/) | [Third-party SDK](https://leancloud.cn/docs/sdk_down.html) | [Integration guide](https://leancloud.cn/docs/leanstorage_guide-java.html) |

## API call sequence

Refer to the following diagram to call the core APIs of the Agora RTC SDK and implement the basic features of Livecast.

<div class="alert note">You need to implement the cloud storage functions in the following diagram on your own.</div>

**Creating and joining a room**

![](https://web-cdn.agora.io/docs-files/1617073965299)

**Managing cohost seats**

![img](https://confluence.agoralab.co/download/attachments/721393269/%E9%BA%A6%E4%BD%8D.png?version=1&modificationDate=1615803522208&api=v2)


## Core API reference

| API | Functions |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [sharedEngineWithAppId](API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/sharedEngineWithAppId:delegate:) | 调用其他 API 之前，需要调用该方法创建 `AgoraRtcEngineKit` 实例。 |
| [setClientRole](API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setClientRole:) | Sets the client role. 加入频道时，需要将房主的用户角色设为 `BROADCASTER、`听众的用户角色设为 `AUDIENCE`。 After an audience member becomes a cohost, you need to call this method to set the role of the audience member to `BROADCASTER` so that they can publish audio streams. |
| [joinChannelByToken](API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:) | Joins the room. A user must join the room before publishing or receiving audio streams. |
| [leaveChannel](API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/leaveChannel:) | Leaves the room. If the host leaves the room, the room object is destroyed and other room members leave the room automatically. |
| [muteLocalAudioStream](API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/muteLocalAudioStream:) | 禁用/开启本地麦克风。 This method is used together with the state management function of cloud storage so that the host can mute  or remove a cohost. |

## Additional functions

**Audio mixing and effects**

After joining the channel, call `startAudioMixing` to play a music file for background music, or call `playEffect` to play an audio effect file  to enhance the room's atmosphere with applause, cheering, or other ambient noise.. See [Play Audio Effect or Music File](/cn/InteractiveBroadcast/effect_mixing_ios?platform=iOS).

**Set the Voice Effect**

`加入房间后，调用 setVoiceBeautifierPreset` 和 `setAudioEffectPreset` 方法使用 SDK 预设的人声效果，增强互动氛围；或者调用 `setLocalVoicePitch`、`setLocalVoiceEqualization` 和 `setLocalVoiceReverb` 调整音调、均衡和混响设置，实现自定义的人声效果。 See [Set the Voice Effect](/cn/InteractiveBroadcast/voice_changer_apple?platform=iOS).

**Content moderation**

Using the Alibaba Smart Voice Audit RESTful API, the audio in the room can be audited in real time. See the audio in the audit channel for details.[](/cn/AliyunAudioModeration/quickstart_ali_audio?platform=RESTful)

## Open-source demo

Agora provides an open-source demo for Livecast on GitHub. You can view the source code and run the demo.

| Android | iOS |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [Livecast (Android)](https://github.com/AgoraIO-Usecase/InteractivePodcast/tree/main/Android) | [Livecast (iOS)](https://github.com/AgoraIO-Usecase/InteractivePodcast/tree/main/iOS) |

## FAQ

- [How do I protect interactive live streaming from stream bombing?](https://docs.agora.io/cn/InteractiveBroadcast/faq/stream_bombing)
- [How do I use cohost token authentication?](https://docs.agora.io/cn/InteractiveBroadcast/faq/token_cohost)