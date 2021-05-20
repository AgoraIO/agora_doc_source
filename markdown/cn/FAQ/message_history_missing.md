---
title: 为什么我查询不到历史消息？
platform: ["RESTful"]
updatedAt: 2021-01-20 02:12:43
Products: ["Real-time-Messaging"]
---
## 问题描述

虽然某时间段存在消息发送，但是 RTM 历史消息 RESTful API 中的 **获取历史消息 API** 查询不到该时间段的历史消息。

## 解决方案

请按照以下步骤进行排查：

1. 确认**创建历史消息查询资源 API** 中 `start_time` 和 `end_time` 参数使用的起始时间和结束时间的时区是否和要查询的时间段一致。如果时区不一致，可能无法返回正确结果。
2. 确认在调用  `sendMessageToPeer` 或 `sendMessage` 发送点对点或频道消息时是否将 `sendMessageOptions` 参数中的 `enableHistoricalMessaging` 成员变量设为 `true`。如果设为 `false`，则发送的消息无法保存为历史消息。

## 核心 API 对照表

上文使用的 API 名均为 C++ API。你可以参考下表获取其他平台的 API 信息：

|  平台 | 发送点对点和频道消息  |
|---|---|
| Windows/Linux C++  | [`sendMessageToPeer`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a08c1b3d444af5a2778ede48e4c677a52), [`sendMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a056dfe9e83c168c3c94e47a017a6ec3f) |
| Android Java  |  [`sendMessageToPeer`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9), [`sendMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a6e16eb0e062953980a92e10b0baec235)  |
| Linux Java  |  [`sendMessageToPeer`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_client.html#a729079805644b3307297fb2e902ab4c9), [`sendMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_channel.html#a6e16eb0e062953980a92e10b0baec235)  |
| iOS/macOS Objective-C  | [`sendMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmKit.html#//api/name/sendMessage:toPeer:sendMessageOptions:completion:), [ `sendMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_oc/Classes/AgoraRtmChannel.html#//api/name/sendMessage:sendMessageOptions:completion:) |
| Web  |   [`sendMessageToPeer`](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#sendmessagetopeer), [`sendMessage`](/cn/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#sendmessage)|

## 相关链接

[事件与历史消息 RESTful API](/cn/Real-time-Messaging/rtm_get_event?platform=All%20Platforms)