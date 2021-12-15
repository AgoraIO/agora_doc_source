---
title: 为什么使用其他 app 后无法发送音视频？
platform: ["Android", "Web"]
updatedAt: 2020-07-09 21:29:37
Products: ["Voice", "Video", "Interactive Broadcast"]
---

### Android 设备使用第三方录音 App 时出现异常

**问题现象**：第三方录音应用使用时，用户加入频道后，无法发送本地音频，也没有收到 SDK 的任何错误信息

**问题原因**：第三方录音应用占用音频设备

**解决方案**：请参考以下逻辑部署代码：在用户进入频道前，先使用 Android 原生方法判断 Audio Recorder 的状态，当状态为 Available 时，如果用户加入频道 6 秒内连续收到警告码 WARN_ADM_RECORD_AUDIO_LOWLEVEL(1031)，或者错误码 ERR_ADM_RECORD_AUDIO_IS_ACTIVE(1033)，则判定录音设备已被占用。请提示用户关闭第三方录音应用。

### 使用 Agora Web SDK 通话过程中切换到其他 app 再切换回通话后，无法发送音频或视频

**问题现象**：在网页端通话时切换到其他使用音视频输入设备的 app （例如接听 QQ 语音电话），再切换回网页端后无法发送本地音频和视频。

**问题原因**：第三方应用占用音视频输入设备，切换回网页端时音视频设备不会自动恢复。

**解决方案**：刷新网页。
