---
title: 为什么 Android 10 无法使用 startAudioMixing 播放背景音乐？
platform: ["Android"]
updatedAt: 2020-05-18 17:10:43
Products: ["Voice", "Video", "Interactive Broadcast"]
---

## 问题描述

Android 10 手机上，调用 `startAudioMixing` 方法无法播放音乐。无法播放的音乐文件格式有 mp3、mp4 等。

## 问题原因

该问题是 Android 权限限制导致的。当 `targetSdkVersion` >= 29 时，需要添加 app 权限，否则会无法正常播放音乐文件。

## 解决方案

如果你的 Android 项目 `targetSdkVersion` >= 29，在项目的 AndroidManifest.xml 文件中 `application` 区域添加如下行，即可正常播放音乐文件：

```xml
<application
   android:usesCleartextTraffic="true"
   android:requestLegacyExternalStorage="true"
   …
</application>
```

## 相关链接

更多的 Android 权限配置及注意事项，请参考[添加项目权限](https://docs-preview.agoralab.co/cn/Interactive%20Broadcast/start_live_android?platform=Android#%E6%B7%BB%E5%8A%A0%E9%A1%B9%E7%9B%AE%E6%9D%83%E9%99%90)。
