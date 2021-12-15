---
title: 为什么无法使用 startAudioMixing 播放音乐文件？
platform: ["All Platforms"]
updatedAt: 2021-02-05 07:31:36
Products: ["Voice", "Video", "Interactive Broadcast", "live-streaming", "Audio Broadcast"]
---

## 问题描述

调用 `startAudioMixing` 方法播放本地或在线音乐文件时，音乐文件播放失败。

## 解决方案

### 步骤 1：自检

- 请确保在频道内调用该方法。
- 请检查音乐文件的格式。如果文件格式不支持，会返回警告码 `701`（“打开伴奏出错”）。各平台支持的音频格式如下：
  - Android：MP3、MP4、M4A、AAC、3GP、MKV 、WAV。
  - iOS/macOS：MP3、AAC、M4A、3GP、WAV。
  - Windows：3GP、ASF、ADTS、AVI、MP3、MP4、MPEG-4、SAMI、WAVE。
- 如果播放本地音乐文件，请确保填写的是正确的绝对路径。如果文件路径错误或不存在，会返回警告码 `701`。
- 如果播放在线音乐文件：
  - 请确保填写的 URL 可以访问，否则会返回警告码 `701`。
  - 在 Android 平台上，Agora 建议不要使用重定向地址，重定向地址在某些 Android 机型上可能无法打开。
  - 在 Android、iOS 和 macOS 平台上，请确保重复调用该方法的间隔大于 100 ms，否则会返回警告码 `702`（“音乐文件打开太频繁“）。
- 如果使用 Android 设备，请确保 Android 版本为 4.2 或以上，并且 API 级别为 16 或以上。
- 如果使用 iOS 设备，请确保 iOS 版本为 8.0 或以上。
- 如果使用 Android 模拟器，请确保播放的音乐文件为 MP3 格式并且存储在 `/sdcard/` 路径下。

如果上述方案都没有解决问题，请检查音乐文件是否能在系统播放器中播放：

- 如果无法播放，可判断是音乐文件的问题，请更换音乐文件。
- 如果可以播放，可判断音乐文件没有问题，请跳转至步骤 2。

### 步骤 2：联系技术支持

如果问题仍然存在，请联系技术支持并提供以下信息：

- 已经完成的排查步骤及结果。
- 你的音乐文件。
- SDK 日志文件，可参考[如何设置日志文件](https://docs.agora.io/cn/faq/logfile)。

## 相关链接

[为什么 Android 10 无法使用 startAudioMixing 播放背景音乐？](https://docs.agora.io/cn/Video/faq/android_startaudiomixing_permission)
