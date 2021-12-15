---
title: 如何实现主播对观众进行上下麦操作？
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
    "React Native",
    "Flutter",
  ]
updatedAt: 2020-08-14 11:36:30
Products: ["Voice", "Video", "Interactive Broadcast", "Real-time-Messaging"]
---

## 简介

在实时音视频互动中，主播可以邀请观众上麦互动，也可以将上麦观众变回为普通观众。

在实际应用场景中，你可以结合 Agora RTM SDK 的消息发送与频道属性功能，和 Agora RTC SDK 的切换用户角色功能，实现主播对观众的上下麦操作。

## 实现方法

下文展示如何通过 RTM SDK 和 RTC SDK 实现上、下麦功能。使用前，请确保你的项目中已经集成了 RTM SDK 和 RTC SDK。具体的集成文档，请参考：

- [Agora RTM SDK 快速开始](https://docs.agora.io/cn/Real-time-Messaging/messaging_android?platform=Android)
- [Agora RTC SDK 快速开始](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_android?platform=Android)

主播邀请观众上麦的基本 API 时序图如下：

![](https://web-cdn.agora.io/docs-files/1585018260468)

具体步骤如下：

1. 主播端调用 RTM SDK 的 [`sendMessageToPeer`](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9) 方法，向观众发送点对点消息，邀请观众上麦；
2. 观众端通过 RTM SDK 的 [`onMessageReceived`](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#af760814981718fb31d88acb8251d19b6) 回调接收主播的邀请信息；
3. 观众端调用 RTC SDK 的 [`setClientRole`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa2affa28a23d44d18b6889fba03f47ec) 方法，并将用户角色设置为主播 `CLIENT_ROLE_BROADCASTER`；
4. 成功切换角色为主播后，观众端会收到 `onClientRoleChanged` 回调；
5. 观众端调用 RTM SDK 的 [`addOrUpdateChannelAttributes`](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a997a31e6bfe1edc9b6ef58a931ef3f23) 方法，将角色切换事件通知到频道内的所有用户；
6. 主播端再通过 RTM SDK 的 [`onAttributesUpdated`](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html#a2904a1f1f78c497b9176fffb853be96f) 得知该观众已成功切换角色，可以进行音视频互动。

同理，如果想要实现下麦功能，则观众端在收到主播要求下麦的消息后，再次调用 `setClientRole`，然后将用户角色设置为观众 `CLIENT_ROLE_AUDIENCE` 即可。

## 各语言方法对照表

本文提及的方法名均为 Java 语言。其他语言对应的方法名如下表所示：

| Java/C++                       | Objective-C                    | JavaScript                         |
| ------------------------------ | ------------------------------ | ---------------------------------- |
| `sendMessageToPeer`            | `sendMessage`                  | `sendMessage`                      |
| `onMessageReceived`            | `messageReceived`              | `MessageFromPeer`                  |
| `setClientRole`                | `setClientRole`                | `setClientRole`                    |
| `onClientRoleChanged`          | `didClientRoleChanged`         | `Client.on("client-role-changed")` |
| `addOrUpdateChannelAttributes` | `addOrUpdateChannelAttributes` | `addOrUpdateChannelAttributes`     |
| `onAttributesUpdated`          | `attributeUpdate`              | `AttributesUpdated`                |
