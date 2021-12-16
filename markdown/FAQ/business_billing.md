---
title: 如何获取用户的通话时长？
platform: ["Android","iOS","macOS","Web","Windows","Unity","Cocos Creator","Electron","React Native","Flutter"]
updatedAt: 2020-06-17 23:17:36
Products: ["Voice","Video","Interactive Broadcast","Agora Analytics"]
---
## 介绍

在一个通话中，某个用户可能多次加入和离开 RTC 频道，该用户累计在频道内的时间为该用户的通话时长，你可以将用户的通话时长作为计费等业务的计量标准之一。通过 Agora RTC SDK 或水晶球，你可以获取用户的通话时长。

## 实现方法

### 使用 Agora RTC SDK

正常情况下，用户成功加入 RTC 频道后会触发 [`onRtcStats`](https://docs.agora.io/cn/Audio%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ada7aa10b092a6de23b598a9f77d4deee) 回调，用户离开频道前收到的最后一次 `onRtcStats` 回调中的 `totalDuration` 参数即为该用户的通话时长。如果用户在通话中多次进出频道，你需要累计多个 `totalDuration` 值算出用户的通话时长。

<div class="alert note">上述示例为 Java 语言，其他语言可通过如下参数获取用户单次在频道内的时间：<li>C++: <tt>onRtcStats</tt> 回调中的 <tt>duration</tt> 参数<li>Objective-C: <tt>reportRtcStats</tt> 回调中的 <tt>duration</tt> 参数<li>Javascript: <tt>Client.getSessionStats</tt> 方法中的 <tt>Duration</tt> 参数</li></div>

如果遇到断线等异常情况，通过 Agora RTC SDK 获取的通话时长可能不准确。你需要通过 Agora RTM SDK 或自己的信令系统开启心跳检测机制，从而获取客户端和服务端断开连接的时长。在 Agora RTC SDK 获取的通话时长中减去客户端断开连接的时长，即为该用户准确的通话时长。

### 使用水晶球

你可以通过水晶球通话调查界面，查看用户**在频道内时间**，即该用户的通话时长。详见[通话调查](https://docs.agora.io/cn/Agora%20Platform/aa_call_search?platform=All%20Platforms)。

![](https://web-cdn.agora.io/docs-files/1592406841873)