---
title: 云信令（原实时消息）SDK 支持从频道外向频道内发送消息吗？
platform: ["Android","iOS","macOS","Web","Windows","Linux","RESTful"]
updatedAt: 2021-03-02 04:33:43
Products: ["Real-time-Messaging"]
---
Agora RTM SDK 暂不支持从频道外向频道内发送消息。你必须加入频道才能向该频道成员发送频道消息。不过，你也可以通过设置频道属性并在每次 API 调用时开启 enableNotificationToChannelMembers 通知该频道所有成员本次更新。