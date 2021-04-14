---
title: How do I get the user's call duration?
platform: ["Android","iOS","macOS","Web","Windows","Unity","Cocos Creator","Electron","React Native","Flutter"]
updatedAt: 2020-06-17 23:18:13
Products: ["Voice","Video","Interactive Broadcast","Agora Analytics"]
---
## Introduction

During a call, a user may join and leave a RTC channel for multiple times, and the user's call duration is the actual time when the user is in the channel. You can use the user's call duration as one of the calculation standards for business applications such as billing.

## Implementation

### Use the Agora RTC SDK

By design, the SDK triggers the [`onRtcStats`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ada7aa10b092a6de23b598a9f77d4deee) callback after a user successfully joins a RTC channel. To get the duration between each channel-join and channel-leave, use the `totalDuration` parameter of the last `onRtcStats` callback triggered before the user leaves the channel. If a user joins and leaves a RTC channel for multiple times, you can calculate the user's call duration by adding up the values of `totalDuration`.

<div class="alert note">The above callback is in Java. For other programming languages, use the following parameters to get the user's call duration:<li>C++: The <tt>duration</tt> parameter of the <tt>onRtcStats</tt> callback.<li>Objective-C: The <tt>duration</tt> parameter of the <tt>reportRtcStats</tt> callback.<li>Javascript: The <tt>Duration</tt> parameter of the <tt>Client.getSessionStats</tt> method.</li></div>

If the connection is lost under poor network conditions, the calculated duration maybe inaccurate. Use [Agora RTM SDK](https://docs.agora.io/en/Real-time-Messaging/reconnecting_android?platform=Android#connection_state_connected) or a different signaling system to implement a heartbeat mechanism, and get the disconnected time of the client. You can calculate the user's call duration by subtracting the disconnected time of the client from the call duration obtained from the Agora RTC SDK.

### Use Agora Analytics

On the **Call Search** page of **Agora Analytics**, you can find a user's call duration in the **In-call Periods** column. See [Call Search](https://docs.agora.io/en/Agora%20Platform/aa_call_search?platform=All%20Platforms).

![](https://web-cdn.agora.io/docs-files/1592406406894)