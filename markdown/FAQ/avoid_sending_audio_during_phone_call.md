---
title: 如何避免在打电话时将音频流发送给远端用户？
platform: ["Android"]
updatedAt: 2021-02-10 08:37:37
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
## 问题描述

在 Android 设备中，使用集成了 Agora RTC SDK 的 app 进行实时音视频互动，本地用户拨打或接听系统电话时仍将系统电话的声音发送给远端用户。

## 问题原因

默认情况下，SDK 会监听 Android 系统电话事件，在用户拨打或接听系统电话时调用 `disableAudio` 关闭音频模块。如果你在 app 中添加了拦截系统电话事件的业务逻辑，则 SDK 无法判断用户是否拨打或接收系统电话，从而造成该问题。

## 解决方案

请按如下步骤排查并解决问题：

1. 检查你的 app 拦截了什么 Android 系统电话事件：
   - `CALL_STATE_RINGING`
   - `CALL_STATE_OFFHOOK`
2. 恢复监听已拦截的系统电话事件。