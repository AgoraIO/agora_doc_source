---
title: 如何处理频道相关常见问题？
platform: ["Android", "iOS", "macOS", "Windows"]
updatedAt: 2020-11-12 07:39:41
Products: ["Voice", "Video", "Interactive Broadcast", "live-streaming"]
---

### 网络环境差时，SDK 会强行让用户自动退出频道么？

SDK 不会让用户自动退出频道，除非用户自己主动退出，例如，应用程序调用 `leaveChannel`。

### 在每个房间，每个频道内，通话中是否有管理员？

没有管理员的概念，管理员是属于业务管理层的范围。可以由信令层实现，由信令服务器主动下发命令，调用 SDK 的接口来实现通话管理。

### 客户端是否需要维护频道？

频道是自动创建和删除的，客户端无需处理和维护。当所有客户端都离开一个频道时，频道自动被删除。

### 如何监听频道内谁在说话？

以下各平台回调方法提示了频道内谁在说话，以及说话者的音量：

- Android/Windows: `onAudioVolumeIndication`
- iOS/macOS: `reportAudioVolumeIndicationOfSpeakers`

该提醒默认为关闭状态。如需启用，请调用 `enableAudioVolumeIndication` 方法进行配置。
