---
title: 如何将指定用户移出频道？
platform:
  [
    "Android",
    "iOS",
    "macOS",
    "Web",
    "Windows",
    "Linux",
    "Unity",
    "Cocos Creator",
    "Electron",
    "RESTful",
    "React Native",
    "Flutter",
  ]
updatedAt: 2020-10-30 11:29:13
Products: ["Voice", "Video", "Interactive Broadcast", "Real-time-Messaging"]
---

在实时音视频互动场景中，通常会有将指定用户移出频道的需求。Agora 根据实际场景需求，提供如下三种解决方案：

**方案一**

场景：通话结束后，用户（多见于 Web 用户）忘记离开频道。虽然没有实际通话，但会产生用量。
方案：为防止这种情况发生，可以使用音量提示回调（`onAudioVolumeIndication`），或在 app 层监测用户在一段时间内是否发布音频流，来确定用户是否在通话中。如否，则在 app 逻辑中，调用 `leaveChannel` 主动下线。

**方案二**

场景：有些日程安排类 app 需要按设定时间结束通话或会议。如会议定于 10 点开始，时长 1 个小时，则 app 需要在 11 点左右结束当前会议。
方案：你可以选择如下任意一种方案实现：

- 使用 Token 的有效时间戳 (`privilegeExpiredTs` 参数）。将 Token 的有效时间戳设为会议结束的时间，超过了这个时间，用户就自动被移出频道。详见[在服务端生成 Token](https://docs.agora.io/cn/Interactive%20Broadcast/token_server?platform=All%20Platforms)。
- 使用服务端 RESTful API 实现踢人功能。在 app 逻辑中记住用户 ID 以及频道名，然后使用创建踢人规则 API 将指定用户移出频道。你可以将封人时间（`time` 参数）设为 0，保证用户离开当前频道后，可以加入其他频道。详见[创建踢人规则](https://docs.agora.io/cn/rtc/restfulapi/?_ga=2.218864153.1695148571.1593515861-1969480941.1589793536#/%E8%B8%A2%E4%BA%BA%E8%A7%84%E5%88%99%E7%AE%A1%E7%90%86/createKickingRule)。

**方案三**

场景：在直播间，如果遇到连麦用户发表不良言论等情况，房主需要让该用户离开直播间。
方案：你可以搭配使用 RTM 的点对点消息功能。通过 `sendMessageToPeer` 发送下线通知，对方通过 `onMessageReceived` 回调收到该消息后，主动调用 RTC SDK 的 `leaveChannel` 方法离开频道。
