---
title: How can a host change the role of a remote user?
platform: ["Android","iOS","macOS","Web","Windows","Linux","Unity","Cocos Creator","Electron","React Native","Flutter"]
updatedAt: 2020-08-14 11:36:05
Products: ["Voice","Video","Interactive Broadcast","Real-time-Messaging"]
---
## Introduction

In a live interactive streaming channel, the host can invite an audience to take on the role of co-host, or change role back to audience.

You can implement this function by combining the following features:

- Real-time messaging and channel attributes using methods from the Agora RTM SDK.
- Setting the user role using methods from the Agora RTC SDK.

## Implementation

Before proceeding, ensure that you have integrated both the Agora RTM SDK and RTC SDK in your project. For how to integrate these SDKs, see the following guides:

- [Agora RTM SDK Quickstart](https://docs.agora.io/en/Real-time-Messaging/messaging_android?platform=Android)
- [Agora RTC SDK Quickstart](https://docs.agora.io/en/Interactive%20Broadcast/start_live_android?platform=Android)

The basic API call sequence is as follows:

![](https://web-cdn.agora.io/docs-files/1585030025387)

Refer to the detailed steps for implementation:

1. The host calls [`sendMessageToPeer`](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9) to send a peer-to-peer message that invites an audience to take on the role pf co-host.
2. The audience receives the invitation message in the [`onMessageReceived`](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#af760814981718fb31d88acb8251d19b6) callback.
3. The audience calls [`setClientRole`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aa2affa28a23d44d18b6889fba03f47ec) to change the user role to `CLIENT_ROLE_BROADCASTER`.
4. After successfully changing the user role, the audience receives the `onClientRoleChanged` callback, and becomes a co-host.
5. The new co-host calls [`addOrUpdateChannelAttributes`](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a997a31e6bfe1edc9b6ef58a931ef3f23) to notify the role change to all users in the channel.
6. The host receives the [`onAttributesUpdated`](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/interfaceio_1_1agora_1_1rtm_1_1_rtm_channel_listener.html#a2904a1f1f78c497b9176fffb853be96f) callback, and starts co-hosting with the new co-host.

To change a co-host back to an audience, follow the same steps, except when calling `setClientRole`, set the user role as `CLIENT_ROLE_AUDIENCE`.

## Relative methods in different programming languages

The methods mentioned in this article are in Java. Refer to the following table if you are programming in a different language:

| Java/C++ | Objective-C | JavaScript |
| ---------------- | ---------------- | ---------------- |
| `sendMessageToPeer`      | `sendMessage`     | `sendMessage`      |
| `onMessageReceived` | `messageReceived` | `MessageFromPeer` |
| `setClientRole` | `setClientRole` | `setClientRole` |
| `onClientRoleChanged` | `didClientRoleChanged` | `Client.on("client-role-changed")` |
| `addOrUpdateChannelAttributes` | `addOrUpdateChannelAttributes` | `addOrUpdateChannelAttributes` |
| `onAttributesUpdated` | `attributeUpdate` | `AttributesUpdated` |