---
title: How do I enable virtual gift sending in interactive live streaming using the Agora RTM SDK?
platform: ["Android","iOS","macOS","Windows","Web","Linux","RESTful"]
updatedAt: 2020-11-16 04:40:59
Products: ["Real-time-Messaging"]
---
## Introduction

To add more fun to interactive live streaming, you can enable virtual gift sending with the Agora RTM SDK.  An audience member can send virtual gifts to the host. All members in the live streaming room can see the gift.

## Implementation

Before proceeding, ensure that you have integrated the Agora RTM SDK into your project. To learn more about integration, refer to [Agora RTM SDK Quickstart](https://docs.agora.io/en/Real-time-Messaging/messaging_android?platform=Android).

The basic API call sequence is as follows:

![](https://web-cdn.agora.io/docs-files/1595560205836)

The steps are as follows:

1. The client calls [`sendMessageToPeer`](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9) to send a peer-to-peer message (gift type) to the server.
2. The server checks the messages and calls `sendMessageToPeer` to send a peer-to-peer message (gift type) to the client.
3. The client receives the peer-to-peer message and calls [`sendMessage`](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a57087adf4227a17c774ea292840148a0) to send a channel message to all members in the room as a gift. The client renders the gift per the channel message.
4. The client calls `sendMessageToPeer` to notify the server that the channel message is sent after receiving [`onSuccess`](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_result_callback.html#a7206b30500655c4a73d146acf50cb6f5). You can add more code logic to ensure that the channel message is successfully sent. In the code logic, the server notifies the client to resend the channel message if the server did not receive [`onMessageReceived`](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html?_ga=2.40828960.36209356.1595832008-73063204.1585890674#af760814981718fb31d88acb8251d19b6) in time.

<div class="alert note">To ensure data security, Agora recommends that you encrypt all messages between the client and the server.</div>

## Relative methods in different programming languages

The methods mentioned in this article are in Java. Refer to the following table if you are programming in a different language:

| Java   |    C++       | Objective-C       | JavaScript        |
| :----------|:-------- | :---------------- | :---------------- |
| `sendMessageToPeer` | `sendMessageToPeer` | `sendMessage`     | `sendMessageToPeer`     |
| `sendMessage`  |   `sendMessage`  |  `sendMessage` |  `sendMessage`  |
|   `onSuccess`  |   `onSendMessageResult`  |   `AgoraRtmSendPeerMessageBlock`  |     `PeerMessageSendResult`   |
| `onMessageReceived` | `onMessageReceivedFromPeer`   | `messageReceived` | `MessageFromPeer` | 