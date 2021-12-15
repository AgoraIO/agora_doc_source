---
title: 如何判断一个通话是语音通话还是视频通话？
platform: ["Android", "iOS", "macOS", "Web", "Windows", "Linux"]
updatedAt: 2020-05-12 17:15:38
Products: ["Real-time-Messaging", "Video", "Voice"]
---

在实时音视频通话场景中，你可以通过 Agora RTM SDK 或 Agora RTC SDK 判断一个即将开始或正在进行的通话是语音通话还是视频通话。

## 通话前判断

如果需要在通话前进行判断并将通话类型发送给接收端，请确保你的项目中已经集成了 RTM SDK 和 RTC SDK。具体的集成文档请参考：

- [RTM SDK 快速开始](https://docs.agora.io/cn/Real-time-Messaging/messaging_android?platform=Android)
- [RTC SDK 快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_android?platform=Android)

具体实现步骤如下：

1. 在主叫发送通话时使用 RTM SDK 的[呼叫邀请相关 API](https://docs.agora.io/cn/Real-time-Messaging/rtm_invite_android?platform=Android) 对被叫进行呼叫邀请。
2. 调用 [`sendMessageToPeer`](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9) 方法把通话类型以点对点消息的方式发送给被叫。被叫在收到呼叫邀请时也会收到这条点对点消息，从而获取通话类型。

## 通话中判断

如果需要在通话中进行判断并将通话类型发送给接收端，请确保你的项目中已经集成了 RTC SDK。具体的集成文档请参考：

- [RTC SDK 快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_android?platform=Android)

在通话中，接收端可以直接通过以下方法判断通话类型：

- 如果收到了 [`onRemoteVideoStateChanged`](https://docs.agora.io/cn/Video/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a93ebe88d2544253bf4b13faf34873131) 回调，则可判断当前通话为视频通话。
- 如果未收到 [`onRemoteVideoStateChanged`](https://docs.agora.io/cn/Video/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a93ebe88d2544253bf4b13faf34873131) 回调，且收到了 [`onRemoteAudioStateChanged`](https://docs.agora.io/cn/Video/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a24fd6b0d12214f6bc6fa7a9b6235aeff) 回调，则可判断当前通话为音频通话。

## 各语言方法对照表

本文提及的方法和回调名均为 Java 语言。其他语言对应的方法名如下表所示：

| Java/C++                    | Objective-C                                         | JavaScript            |
| --------------------------- | --------------------------------------------------- | --------------------- |
| `sendMessageToPeer`         | `sendMessage:toPeer:sendMessageOptions:completion:` | `sendMessage`         |
| `onRemoteAudioStateChanged` | `remoteAudioStateChangedOfUid`                      | `getRemoteAudioStats` |
| `onRemoteVideoStateChanged` | `remoteVideoStateChangedOfUid`                      | `getRemoteVideoStats` |
