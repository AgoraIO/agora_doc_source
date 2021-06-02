---
title: 调整通话音量
platform: Android
updatedAt: 2020-12-03 12:01:01
---
## 功能描述

 在使用我们 SDK 时，开发者可以对 SDK 采集到的声音及 SDK 播放到声卡的声音音量进行调整，以满足产品在声音上的个性化需求。比如进行双人通话时，想实现静音操作，可以通过调整播放音量的接口将音量设置为 0。



## 实现方法
开始前请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端 ](./android_audio)。

Agora SDK 提供一套接口直接调整录制和播放声音的信号幅度，由此实现调整录音和播放的音量。

调节音量的参数值范围是 0 - 400，默认值 100 表示原始音量，即不对信号做缩放，400 表示原始音量的 4 倍（把信号放大到原始信号的 4 倍）。

```java
int volume = 200;
// 设置录音信号音量
rtcEngine.adjustRecordingSignalVolume(volume);
// 设置播放信号音量
rtcEngine.adjustPlaybackSignalVolume(volume);
```

### API 参考

- [`adjustRecordingSignalVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af3747f72256eb683feadbca2b742bd05)
- [`adjustPlaybackSignalVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af7d7f10fc96db2febb9c2590891d071b)

## 开发注意事项

- 所有相关的方法都有返回值。返回值小于 0 表示方法调用失败
- 如果信号音量设置太大，由于硬件设备的限制，在某些设备上可能会出现声音不自然的效果。