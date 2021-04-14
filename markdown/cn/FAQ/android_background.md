---
title: 为什么 Android 9 应用锁屏或切后台后采集音视频无效？
platform: ["Android"]
updatedAt: 2020-04-28 18:05:05
Products: ["Voice","Video","Interactive Broadcast"]
---
**问题现象**：Android 9 设备锁屏 1 分钟内，音频无声或看不到视频。

**问题原因**：从 Android 官网来看，这是系统强制限制。原文如下：

> **Limited access to sensors in background**
> Android 9 limits the ability for background apps to access user input and sensor data. If your app is running in the background on a device running Android 9, the system applies the following restrictions to your app:
>
> - Your app cannot access the microphone or camera.
> - Sensors that use the continuous reporting mode, such as accelerometers and gyroscopes, don't receive events.
> - Sensors that use the on-change or one-shot reporting modes don't receive events.
>   If your app needs to detect sensor events on devices running Android 9, use a foreground service.

详见 [Android 行为变更](https://developer.android.com/about/versions/pie/android-9.0-changes-all)。

**解决方案：** 目前 Android 官网没有明确说明后台采集声音或视频应如何处理，但使用**前台服务**可以让应用正常工作。

如果 Android 9 设备用户有锁屏后采集音频或视频的需求，可以在锁屏或退至后台前起一个 Service，并在退出锁屏或返回前台前终止 Service。
关于如何起 Service，请参考 <https://developer.android.com/reference/android/app/Service> 。