---
title: Offline-通信和直播场景有什么区别？
platform: ["All Platforms"]
updatedAt: 2020-07-09 21:29:05
Products: ["Voice","Video","Interactive Broadcast","Audio Broadcast"]
---
Agora 频道有通信和直播场景之分。这两种频道场景在如下方面是不同的：

| 差异项 | 通信场景 | 直播场景 |
| ---------------- | ---------------- | ---------------- |
| 默认用户角色      | 主播，且不可以切换用户角色      | 观众，可以通过 `setClientRole` 方法切换用户角色      |
| 移动端默认语音路由      | <ul><li>语音通话：听筒</li><li>视频通话：扬声器</li></ul>| 扬声器 |
| 默认视频编码码率 | 基准码率 | 基准码率 × 2 |

**相关文档**

* [视频编码码率](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a4b090cd0e9f6d98bcf89cb1c4c2066e8)