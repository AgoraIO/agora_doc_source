---
title: Agora RTC SDK 最多支持多少人同时在线？
platform:
  [
    "Android",
    "iOS",
    "macOS",
    "Web",
    "Windows",
    "Unity",
    "Cocos Creator",
    "微信小程序",
    "Electron",
    "React Native",
    "Flutter",
  ]
updatedAt: 2021-01-13 10:34:41
Products: ["Voice", "Video", "Interactive Broadcast"]
---

Agora RTC SDK 提供多人实时音视频服务。下表展示 Agora RTC SDK 支持的并发频道数及用户数：

| 场景 | SDK 版本     | 用户数                                                         | 频道数 |
| ---- | ------------ | -------------------------------------------------------------- | ------ |
| 通信 | 3.0.0 及之后 | 单个频道支持百万人同时在线。Agora 建议最多 17 人同时发流。     | 无限制 |
| 通信 | 3.0.0 之前   | 单个频道支持百万人同时在线。Agora 建议最多 7 人同时发流。      | 无限制 |
| 直播 | 所有版本     | 单个频道支持百万人同时在线，Agora 建议最多 17 位主播同时发流。 | 无限制 |

<div class="alert note"><li>如果同时发流人数超过 Agora 的建议值，用户只能随机听到或看到频道内某些发流用户。例如，在视频直播中，频道内有 18 位主播同时发流，每位用户都会随机听不见或看不见某一人的音视频。<li>多人视频场景下，Agora 建议开启<a href="https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#dual-stream">双流模式</a >，并使用小流的默认设置。<li>Agora 不提供限制同时发流人数的 API，你可以在应用层自行实现该功能。</li></div>
