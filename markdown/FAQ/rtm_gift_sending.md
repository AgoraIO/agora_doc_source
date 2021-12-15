---
title: 如何使用云信令（原实时消息）SDK 实现直播间礼物发送功能？
platform: ["Android", "iOS", "macOS", "Web", "Windows", "Linux", "RESTful"]
updatedAt: 2021-03-02 04:29:15
Products: ["Real-time-Messaging"]
---

## 简介

为增添实时音视频互动的趣味性，你可以结合云信令（RTM）SDK 实现虚拟礼物发送功能。观众可以向主播发送虚拟礼物，且直播间中所有用户都可以看到礼物。

## 实现方法

下文展示如何通过 RTM SDK 实现礼物发送功能。使用前，请确保你的项目中已经集成了 RTM SDK。具体的集成文档，请参考 [Agora RTM SDK 快速开始](https://docs.agora.io/cn/Real-time-Messaging/messaging_android?platform=Android)。

使用 RTM SDK 发送礼物的基本 API 时序图如下：

![](https://web-cdn.agora.io/docs-files/1595560115116)

具体步骤如下:

1. 客户端调用 [`sendMessageToPeer`](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9) 向服务端发送点对点消息，标记礼物请求和类型。
2. 服务端校验之后调用 `sendMessageToPeer` 向客户端发送点对点消息，标记礼物类型。
3. 客户端收到点对点消息后，调用 [`sendMessage`](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a6e16eb0e062953980a92e10b0baec235) 发送频道消息实现礼物发送功能。客户端根据接收到的频道消息渲染礼物画面。
4. 客户端在收到 [`onSuccess`](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_result_callback.html#a7206b30500655c4a73d146acf50cb6f5) 回调后，调用 `sendMessageToPeer` 通知服务端频道消息已成功发送。为了保证频道消息可以成功发送，你可以增加代码逻辑，使服务端在未及时收到 [`onMessageReceived`](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#af760814981718fb31d88acb8251d19b6) 回调时提醒客户端重新发送频道消息。

<div class="alert note">为保障数据安全，Agora 建议你对所有客户端与服务端之间的消息加密。</div>

## 各语言方法对照表

本文提及的方法名均为 Java 语言。其他语言对应的方法名如下表所示：

| Java                | C++                         | Objective-C                    | JavaScript              |
| :------------------ | :-------------------------- | :----------------------------- | :---------------------- |
| `sendMessageToPeer` | `sendMessageToPeer`         | `sendMessage`                  | `sendMessageToPeer`     |
| `sendMessage`       | `sendMessage`               | `sendMessage`                  | `sendMessage`           |
| `onSuccess`         | `onSendMessageResult`       | `AgoraRtmSendPeerMessageBlock` | `PeerMessageSendResult` |
| `onMessageReceived` | `onMessageReceivedFromPeer` | `messageReceived`              | `MessageFromPeer`       |
