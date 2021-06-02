---
title: How can I determine whether a call is an audio call or a video call?
platform: ["Android","iOS","macOS","Web","Windows","Linux"]
updatedAt: 2020-06-02 11:29:20
Products: ["Real-time-Messaging","Video","Voice","Interactive Broadcast"]
---
In real-time audio or video communication, you can use the Agora RTM SDK or the Agora RTC SDK to determine whether an incoming or ongoing call is an audio call or a video call.

## Before a call

If you need to determine and send the call type to the receiver before a call, ensure that you have integrated the RTM SDK and the RTC SDK. Refer to the following articles to learn more about integration:

- [RTM SDK Quickstart](https://docs.agora.io/en/Real-time-Messaging/messaging_android?platform=Android)
- [RTC SDK Quickstart](https://docs.agora.io/en/Interactive%20Broadcast/start_live_android?platform=Android)

Complete the following steps to determine the call type:

1. When the caller sends a call, use the [Call Invitation API](/en/Real-time-Messaging/rtm_invite_android?platform=Android) of the RTM SDK to send a call invitation to the callee.
2. Call [`sendMessageToPeer`](/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9) to send the call type to the callee via peer-to-peer message. The callee gets the call type from the received peer-to-peer message.

## After a call

If you need to determine and send the call type to the receiver during a call, ensure that you have integrated the RTC SDK. Refer to the following article:

- [RTC SDK Quickstart](https://docs.agora.io/en/Interactive%20Broadcast/start_live_android?platform=Android)

During a call, the receiver can determine the call type according to the following guideline:

- If the receiver receives the [`onRemoteVideoStateChanged`](https://docs.agora.io/en/Video/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a93ebe88d2544253bf4b13faf34873131) callback, the current call is a video call.
- If the receiver does not receive the [`onRemoteVideoStateChanged`](https://docs.agora.io/en/Video/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a93ebe88d2544253bf4b13faf34873131) callback and receives the [`onRemoteAudioStateChanged`](https://docs.agora.io/cn/Video/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a24fd6b0d12214f6bc6fa7a9b6235aeff) callback, the current call is an audio call.

## Corresponding methods and callbacks

This article references the names of Java methods and callbacks. The following table shows the corresponding methods and callbacks for other languages.

| Java/C++                  | Objective-C                                       | JavaScript          |
| ------------------------- | ------------------------------------------------- | ------------------- |
| `sendMessageToPeer`         | `sendMessage:toPeer:sendMessageOptions:completion:` | `sendMessage`         |
| `onRemoteAudioStateChanged` | `remoteAudioStateChangedOfUid`                      | `getRemoteAudioStats` |
| `onRemoteVideoStateChanged` | `remoteVideoStateChangedOfUid`                      | `getRemoteVideoStats` |