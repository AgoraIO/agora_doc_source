---
title: 云信令（原实时消息）SDK 的调用频率限制是针对单个 RTM 客户端实例吗？
platform: ["Android","iOS","macOS","Web","Windows","Linux","RESTful"]
updatedAt: 2021-03-02 04:25:57
Products: ["Real-time-Messaging"]
---
云信令（Real-time Messaging，RTM）SDK 的调用频率限制针对单个 RTM 客户端实例。

- 在 Native 平台，你可以通过创建多实例提高 API 的调用频率；
- 在 Web 平台，我们*暂不建议*通过创建多实例提高 API 的调用频率。