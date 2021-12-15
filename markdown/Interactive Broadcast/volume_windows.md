---
title: 调整通话音量
platform: Windows
updatedAt: 2020-12-03 11:38:56
---

## 功能描述

在使用我们 SDK 时，开发者可以对 SDK 采集到的声音及 SDK 播放到声卡的声音音量进行调整，以满足产品在声音上的个性化需求。比如进行双人通话时，想实现静音操作，可以通过调整播放音量的接口将音量设置为 0。

本文梳理了在使用 SDK 从音频采集到播放各阶段中，用户可能需要调整音量的场景、各场景对应的 API 及其使用注意事项。

![](https://web-cdn.agora.io/docs-files/1545991278347)

## 实现方法

开始前请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端](./windows_video)。

### 设置采集音量

**采集**是指音频信号由录音设备采集后传输到发送端的过程。你可以通过调整**录音设备音量**或**录音信号音量**来设置采集音量。在 Windows 系统上，Agora 推荐使用音频设备相关 API 调节录音音量。

#### 调整录音设备音量

录音设备音量的参数值范围是 0 - 255，0 代表设备静音，255 代表设备的最大音量。

```cpp
// 设置录音设备音量
int setRecordingDeviceVolume(int volume);
```

`volume` 的值与 Windows 系统中音频设备属性里的值是一一对应的，255 对应于下图中麦克风阵列的音量值调到最右：

![](https://web-cdn.agora.io/docs-files/1545124821348)

#### 调整录音信号音量

如果调整设备音量到极限值仍无法满足需求，Agora 提供另一套接口直接调整录制声音的信号幅度，由此实现调整录音和播放的音量。
调节音量的参数值范围是 0 - 400，默认值 100 表示原始音量，即不对信号做缩放，400 表示原始音量的 4 倍（把信号放大到原始信号的 4 倍）。

```cpp
// 初始化参数对象
RtcEngineParameters rep(*lpAgoraEngine);

// 将录音音量设置为 200
int ret = rep.adjustRecordingSignalVolume(200);
```

#### API 参考

- [`setRecordingDeviceVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#ac24424e86ded2727a532df739ebf8086)
- [`adjustRecordingSignalVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#aa9e9b5ae052022fe2e81232b9e6e7290)

### 设置播放音量

**播放**是指音频信号从发送端进入到接收端，然后使用播放设备进行播放的过程。你可以通过调整**播放设备音量**或**播放信号音量**来设置采集音量。在 Windows 系统上，Agora 推荐使用音频设备相关 API 调节播放音量。

#### 调整播放设备音量

录音设备音量的参数值范围是 0 - 255，0 代表设备静音，255 代表设备的最大音量。

```cpp
// 设置播放音量
int setPlaybackDeviceVolume(int volume);
```

其中 `volume` 的值与 Windows 系统中音频设备属性里的值是一一对应的。255 对应下图中麦克风阵列的音量值调到最右。

![](https://web-cdn.agora.io/docs-files/1545124835160)

#### 调整播放信号音量

如果调整设备音量到极限值仍无法满足需求，Agora SDK 提供一套接口直接调整播放声音的信号幅度，由此实现调整播放的音量。
调节音量的参数值范围是 0 - 400，默认值 100 表示原始音量，即不对信号做缩放，400 表示原始音量的 4 倍（把信号放大到原始信号的 4 倍）。

```cpp
// 初始化参数对象
RtcEngineParameters rep(*lpAgoraEngine);

// 将播放音量设置为 200
int ret = rep.adjustPlaybackSignalVolume(200);
```

#### API 参考

- [`setPlaybackDeviceVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_audio_device_manager.html#ac14a1238e83303abed2f36e02fcc9366)
- [`adjustPlaybackSignalVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a8bed09e12b8e2d9934aafad50b77d364)

### 设置混音音量

**混音**是指播放本地或者在线音乐文件，同时让频道内的其他人听到此音乐。你可以参考[音乐混音](https://docs.agora.io/cn/Video/effect_mixing_windows?platform=Windows#音乐混音)开启混音功能。

调节混音音量的参数值范围是 0 - 100，默认值 100 表示原始文件音量，即不对信号做缩放。0 表示混音文件播放静音。

```cpp
// 初始化参数对象
RtcEngineParameters rep(*lpAgoraEngine);

// 设置远端用户听到的音乐文件音量
int ret = rep.adjustAudioMixingPublishVolume(50);
// 设置本地用户听到的音乐文件音量
int ret = rep.adjustAudioMixingPlayoutVolume(50);
```

你也可以直接调用 `adjustAudioMixingVolume` ，同时设置本地及远端用户听到的音乐文件音量。

```cpp
// 初始化参数对象
RtcEngineParameters rep(*lpAgoraEngine);

// 设置本地及远端用户听到的音乐文件音量
int ret = rep.adjustAudioMixingVolume(50);
```

#### API 参考

- [`adjustAudioMixingPublishVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a8f8d2af4b4c7988934e152e3b281d734)
- [`adjustAudioMixingPlayoutVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a99ab2878e0c4fbf1be6970a2c545d085)
- [`adjustAudioMixingVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a5e117be71d38d813208198f4064aa964)

### 设置音效音量

播放**音效**是指播放短小的音频，如鼓掌、子弹撞击的声音等。你可以参考[播放音效](https://docs.agora.io/cn/Video/effect_mixing_windows?platform=Windows#播放音效文件)开启音效播放。

调节音效音量的参数值范围是 0 - 100，默认值 100 表示原始音效音量，即不对信号做缩放。0 表示音效文件播放静音。

```cpp
// 初始化参数对象
RtcEngineParameters rep(*lpAgoraEngine);

// 设置所有音效文件的播放音量
int ret = rep.setEffectsVolume(50);
// 设置单个音效文件的播放音量
int ret = rep.setVolumeOfEffect(soundId, 50);
```

#### API 参考

- [`setEffectsVolume`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#aa3041ef19bfe10ffc5a1130cda91ab7b)
- [`setVolumeOfEffect`](./API%20Reference/cpp/classagora_1_1rtc_1_1_rtc_engine_parameters.html#a71fac1633ea84c892879781bee56d001)

### 获取用户音量（回调方法）

在音频采集、混音、播放的整个过程中，你都可以使用下面的接口获取用户音量。

- 瞬时说话声音音量提示。如下回调获取瞬时说话音量最大的用户 ID，及音量大小。如果返回的用户 ID 为 0，则表示瞬时说话音量最大的是本地用户。

```cpp
void onAudioVolumeIndication(const AudioVolumeInfo* speakers, unsigned int speakerNumber, int totalVolume)  {
// 获取瞬时说话音量最大的几个用户 ID
// speakers 为一个数组，包含说话者的用户 ID 及音量，音量范围为 0 - 255
// speakerNumber Speakers 数组的大小
// totalVolume 指混音后频道内的总音量，范围为 0 - 255
}
```

- 当前时间内累积音量最大者。如下回调获取获取特定时间段内，累积音量最大的用户 ID。

```cpp
void onActiveSpeaker(uid_t uid) {
// 获取当前时间段声音最大的用户 ID（仅 1 个）
}
```

#### API 参考

- [`onAudioVolumeIndication`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#aab1184a2b276f509870c055a9ff8fac4)
- [`onActiveSpeaker`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ae643c9dbf94360a23a8b3a56c93f90bc)

## 开发注意事项

- 所有相关的方法都有返回值。返回值小于 0 表示方法调用失败
- 用调整信号设置音量的方法，如果音量设置太大，由于硬件设备的限制，在某些设备上可能会出现失真的声音效果。
