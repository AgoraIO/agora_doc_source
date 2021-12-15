---
title: 为什么 Android 设备进入频道后耳机无声？
platform: ["Android"]
updatedAt: 2020-07-09 21:52:25
Products: ["Voice", "Video", "Interactive Broadcast"]
---

**问题现象**：进频道后安卓设备上耳机无声，路由功能不正常等。

**问题原因**：

有些 Agora 的 Android 示例程序通过创建 WorkerThread 线程来维护一个全局的 RtcEngine 实例。WorkerThread 的生命周期与示例程序的生命周期是一致的。当应用程序进程销毁（调用 `destroy` 方法），WorkerThread 也随之消亡。

如果开发者没能正确退出 WorkerThread，就有可能会导致耳机无声，或语音路由不正常等问题。

在实际的应用开发中，开发者会通过操控 WorkerThread 来管理 RtcEngine 实例的生命周期。在创建引擎和加入频道时这么做是可以的。但是开发者在离开 WorkerThread 时，没有销毁 RtcEngine 实例。如果 WorkerThreader 和应用程序的生命周期不一致，这就很容易产生问题。

RtcEngine 调用 `destroy` 方法会移除所有注册过的系统 Listener （对于音频来说是 PhoneStateListener），这些监听可能会引用线程的 Looper。如果在退出 WorkerThread 时不移除系统 Listener，注册过的 Listener 会持续监听，但其引用的 Looper 已经随着 WorkerThread 线程的停止而被置为无效或清空。最终会以 Dead Binder 的形式出错。

**解决方案**：

Agora 建议你选择如下一种方法解决该问题：

- 全局只维护一个 WorkerThread 线程
- 退出频道时，还需要调用 `destroy` 方法销毁 RtcEngine
