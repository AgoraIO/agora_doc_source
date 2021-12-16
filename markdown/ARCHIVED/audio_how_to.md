---
title: 音频相关
platform: 音频相关
updatedAt: 2019-06-14 09:56:58
---
### iOS 端集成 H5 游戏音量低

**背景信息：**iOS SDK 2.2.0 集成 H5 游戏；

**问题现象：**用 layabox 自带的引擎播放 WkWebview，主播加入声网的频道，游戏里面的声音很低。该问题仅在 iOS 端发现，Android 端表现正常。

**问题原因：**WKWebView 加载的 H5 是另外一个进程通过 AVAudioSession 播放声音，不是通过 SDK 播放的。

**解决方案：**
`self.agoraEngine setAudioProfile:(AgoraRtc_AudioProfile_Default) scenario:(AgoraRtc_AudioScenario_GameStreaming);`  //选择 `GameStreaming` 模式。

**方案缺点：**

* 采用 `GameStreaming` 模式可能会出现一点回声，理论不影响使用，如有必现或大概率复现的情况可联系技术支持。
* H5 的声音不是通过 SDK 播放的，无法消除回声。

### Android 9 设备上应用退到后台或锁屏后，采集不到声音

**背景信息：** Android 9 系统行为变更。

**问题现象：** Android 9 设备锁屏 1 分钟内，音频无声

**问题原因：** 从 Android 官网来看，这是系统强制限制。原文如下：

> **Limited access to sensors in background**
> Android 9 limits the ability for background apps to access user input and sensor data. If your app is running in the background on a device running Android 9, the system applies the following restrictions to your app:
> * Your app cannot access the microphone or camera.
> * Sensors that use the continuous reporting mode, such as accelerometers and gyroscopes, don't receive events.
> * Sensors that use the on-change or one-shot reporting modes don't receive events.
> If your app needs to detect sensor events on devices running Android 9, use a foreground service.


详见 [Android 行为变更](https://developer.android.com/about/versions/pie/android-9.0-changes-all)。


**解决方案：** 目前 Android 官网没有明确说明后台采集声音应如何处理，但使用**前台服务**可以让应用正常工作。

如果 Android 9 设备用户有锁屏后采集音频的需求，可以在锁屏或退至后台前起一个 Service，并在退出锁屏或返回前台前终止 Service。
关于如何起 Service，请参考 https://developer.android.com/reference/android/app/Service 。