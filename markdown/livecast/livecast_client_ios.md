---
title: 客户端实现
platform: iOS
updatedAt: 2021-03-31 08:46:50
---

本文介绍如何使用 Agora RTC SDK 实现互动播客的重要功能。

## 业务流程图

参考下图实现相关业务：
![](https://web-cdn.agora.io/docs-files/1617009861278)

## 集成指引

根据下表提供的链接，下载对应平台的 SDK 并集成到你的项目中。

| 产品                                                                                                   | SDK 下载                                              | 集成文档                                                                   |
| :----------------------------------------------------------------------------------------------------- | :---------------------------------------------------- | :------------------------------------------------------------------------- |
| [Agora RTC (Real-time Communication) SDK](/cn/InteractiveBroadcast/product_live?platform=AllPlatforms) | [音频直播 SDK](/cn/livecast/downloads?platform=iOS)   | [实现音频直播](/cn/InteractiveBroadcast/start_live_audio_ios?platform=iOS) |
| [第三方云对象存储 SDK](https://leancloud.cn/)                                                          | [第三方 SDK](https://leancloud.cn/docs/sdk_down.html) | [数据存储开发指南](https://leancloud.cn/docs/leanstorage_guide-java.html)  |

## 核心 API 时序图

参考下图调用 Agora RTC SDK 的 API 实现互动播客场景。

<div class="alert note">下图仅提供 Agora RTC SDK 的 API 调用时序，与云对象存储有关的功能需要自行实现。</div>

**创建和加入房间**

![](https://web-cdn.agora.io/docs-files/1617073965299)

**麦位控制**

![img](https://confluence.agoralab.co/download/attachments/721393269/%E9%BA%A6%E4%BD%8D.png?version=1&modificationDate=1615803522208&api=v2)

## 核心 API 参考

| API                                                                                                                                   | 实现功能                                                                                                                                                                                  |
| :------------------------------------------------------------------------------------------------------------------------------------ | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [sharedEngineWithAppId](API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/sharedEngineWithAppId:delegate:)                 | 调用其他 API 之前，需要调用该方法创建 `AgoraRtcEngineKit` 实例。                                                                                                                          |
| [setClientRole](API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setClientRole:)                                          | 设置用户角色。加入频道时，需要将房主的用户角色设为 `BROADCASTER、`听众的用户角色设为 `AUDIENCE`。听众成功上麦后，需要先调用该方法将用户角色切换为 `BROADCASTER`，才能在房间里发布音频流。 |
| [joinChannelByToken](API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/joinChannelByToken:channelId:info:uid:joinSuccess:) | 加入房间。用户加入房间后才能接收或发布音频流。                                                                                                                                            |
| [leaveChannel](API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/leaveChannel:)                                            | 离开房间。房主离开房间后，房间对象自动销毁，其他成员会自动离开房间。                                                                                                                      |
| [muteLocalAudioStream](API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/muteLocalAudioStream:)                            | 禁用/开启本地麦克风。该方法搭配云存储的状态管理功能可以实现下麦、禁麦功能。                                                                                                               |

## 附加功能

**混音及音效**

加入房间后，调用 `startAudioMixing` 方法播放音乐文件，可以实现播放背景音乐的功能；调用 `playEffect` 方法播放音效文件，可以实现鼓掌、欢呼、尖叫等氛围音效果。详见[播放音效/音乐混音](/cn/InteractiveBroadcast/effect_mixing_ios?platform=iOS)。

**设置人声效果**

`加入房间后，调用 setVoiceBeautifierPreset` 和 `setAudioEffectPreset` 方法使用 SDK 预设的人声效果，增强互动氛围；或者调用 `setLocalVoicePitch`、`setLocalVoiceEqualization` 和 `setLocalVoiceReverb` 调整音调、均衡和混响设置，实现自定义的人声效果。详见[设置人声效果](/cn/InteractiveBroadcast/voice_changer_apple?platform=iOS)。

**语音审核**

使用阿里智能语音审核 RESTful API ，可以对房间内的音频进行实时审核。详见[审核频道内的音频](/cn/AliyunAudioModeration/quickstart_ali_audio?platform=RESTful)。

## 开源示例代码

Agora 在 GitHub 上提供了互动播客的开源示例项目，你可以前往下载，或者查看其中的源代码。

| Android                                                                                       | iOS                                                                                   |
| :-------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------ |
| [Livecast (Android)](https://github.com/AgoraIO-Usecase/InteractivePodcast/tree/main/Android) | [Livecast (iOS)](https://github.com/AgoraIO-Usecase/InteractivePodcast/tree/main/iOS) |

## 常见问题

- [如何处理炸房捣乱现象或行为？](https://docs.agora.io/cn/InteractiveBroadcast/faq/stream_bombing)
- [如何使用连麦鉴权功能？](https://docs.agora.io/cn/InteractiveBroadcast/faq/token_cohost)
