---
title: 如何避免直播上下麦音量变化？
platform: ["iOS", "Android"]
updatedAt: 2020-04-28 21:52:27
Products: ["Voice", "Video", "Interactive Broadcast"]
---

为了保证不同模式下更好的音质体验，默认情况下上下麦 SDK 会调整底层音频的设置。简单来说，非连麦模式下会使用媒体音量控制，连麦模式下会使用通话音量控制，两者有独立的音量控制机制。

如果想要避免音量变化，可通过 AudioProfile 中 Scenario 的设置来指定通话音量或者媒体音量，Android 平台建议使用 `CHATROOM_ENTERTAINMENT`，iOS 平台建议使用 `GAME_STREAMING` 模式。
