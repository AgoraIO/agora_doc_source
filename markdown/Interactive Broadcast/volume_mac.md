---
title: 调整通话音量
platform: macOS
updatedAt: 2020-12-03 11:33:49
---

## 功能描述

在使用我们 SDK 时，开发者可以对 SDK 采集到的声音及 SDK 播放到声卡的声音音量进行调整，以满足产品在声音上的个性化需求。比如进行双人通话时，想实现静音操作，可以通过调整播放音量的接口将音量设置为 0。

本文梳理了在使用 SDK 从音频采集到播放各阶段中，用户可能需要调整音量的场景、各场景对应的 API 及其使用注意事项。

## 实现方法

开始前请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端](./mac_video)。

### 设置采集音量

**采集**是指音频信号由录音设备采集后传输到发送端的过程。你可以通过调整**录音设备音量**或**录音信号音量**来设置采集音量。Agora 推荐使用音频设备相关 API 调节录音音量。

#### 调整录音设备音量

录音设备音量的参数值范围是 0 - 255，0 代表设备静音，255 代表设备的最大音量。

```swift
// swift
// 设置录音设备音量
agoraKit.setDeviceVolume(.audioRecording, volume: 50)
```

```objective-c
// 设置录音设备音量
[agoraKit setDeviceVolume: AgoraMediaDeviceTypeAudioRecording, volume: 50]
```

其中 `volume` 的值与下图中**输入音量**的值一一对应。

![](https://web-cdn.agora.io/docs-files/1542772979683)

#### 调整录音信号音量

如果调整设备音量到极限值仍无法满足需求，Agora SDK 提供一套接口直接调整录制声音的信号幅度，由此实现调整录音音量。
调节音量的参数值范围是 0 - 400，默认值 100 表示原始音量，即不对信号做缩放，400 表示原始音量的 4 倍（把信号放大到原始信号的 4 倍）。

```swift
// swift
// 设置录音信号音量
agoraKit.adjustRecordingSignalVolume(50)
```

```objective-c
// objective-c
// 设置录音信号音量
[agoraKit adjustRecordingSignalVolume: 50];
```

#### API 参考

- [`setDeviceVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setDeviceVolume:volume:)
- [`adjustRecordingSignalVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustRecordingSignalVolume:)

### 设置播放音量

**播放**是指音频信号从发送端进入到接收端，然后使用播放设备进行播放的过程。你可以通过调整**播放设备音量**或**播放信号音量**来设置采集音量。Agora 推荐使用音频设备相关 API 调节播放音量。

#### 调整播放设备音量

播放设备音量的参数值范围是 0 - 255，0 代表设备静音，255 代表设备的最大音量。

```swift
// swift
// 设置播放设备音量
agoraKit.setDeviceVolume(.audioPlayout, volume: 50)
```

```objective-c
// objective-c
// 设置播放设备音量
[agoraKit setDeviceVolume: AgoraMediaDeviceTypeAudioPlayout, volume: 50];
```

其中 `volume` 的值与下图中**输出音量**的值一一对应。

![](https://web-cdn.agora.io/docs-files/1542772979683)

#### 调整播放信号音量

如果调整设备音量到极限值仍无法满足需求，Agora SDK 提供一套接口直接调整播放声音的信号幅度，由此实现调整播放的音量。
调节音量的参数值范围是 0 - 400，默认值 100 表示原始音量，即不对信号做缩放，400 表示原始音量的 4 倍（把信号放大到原始信号的 4 倍）。

```swift
// swift
// 设置播放信号音量
agoraKit.adjustPlaybackSignalVolume(50)
```

```objective-c
// objective-c
// 设置播放信号音量
[agoraKit adjustPlaybackSignalVolume: 50];
```

#### API 参考

- [`setDeviceVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setDeviceVolume:volume:)
- [`adjustPlaybackSignalVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustPlaybackSignalVolume:)

### 设置混音音量

混音是指播放本地或者在线音乐文件，同时让频道内的其他人听到此音乐。你可以参考[`音乐混音`](./effect_mixing_ios_audio?platform=iOS#音乐混音)开启混音功能。

调节混音音量的参数值范围是 0 - 100，默认值 100 表示原始文件音量，即不对信号做缩放。0 表示混音文件播放静音。

```swift
// swift
// 设置远端用户听到的音乐文件音量
agoraKit.adjustAudioMixingPublishVolume(50)
// 设置本地用户听到的音乐文件音量
agoraKit.adjustAudioMixingPlayoutVolume(50)
```

```objective-c
// objective-c
// 设置远端用户听到的音乐文件音量
[agoraKit adjustAudioMixingPublishVolume: 50]；
// 设置本地用户听到的音乐文件音量
[agoraKit adjustAudioMixingPlayoutVolume: 50];
```

你也可以直接调用 `adjustAudioMixingVolume`，同时设置本地及远端用户听到的音乐文件音量。

```swift
// swift
// 设置本地及远端用户听到的音乐文件音量
agoraKit.adjustAudioMixingVolume(50)
```

```objective-c
// objective-c
// 设置本地及远端用户听到的音乐文件音量
[agoraKit adjustAudioMixingVolume: 50];
```

#### API 参考

- [`adjustAudioMixingPublishVolume`]()
- [`adjustAudioMixingPlayoutVolume`]()
- [`adjustAudioMixingVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/adjustAudioMixingVolume:)

### 设置音效音量

播放音效是指播放短小的音频，如鼓掌、子弹撞击的声音等。你可以参考[播放音效](./effect_mixing_ios_audio?platform=iOS#播放音效文件)开启音效播放。

调节音效音量的参数值范围是 0.0 - 100.0，默认值 100.0 表示原始音效音量，即不对信号做缩放。0.0 表示音效文件播放静音。

```swift
// swift
// 设置所有音效文件的播放音量
agoraKit.setEffectsVolume(50.0)
// 设置单个音效文件的播放音量
// soundId 是你在调用 playEffect 时设置的音效 ID
agoraKit.setVolumeOfEffect(soundId:"1", 50.0)
```

```objective-c
// objective-c
// 设置所有音效文件的播放音量
[agoraKit setEffectsVolume: 50.0];
// 设置单个音效文件的播放音量
// soundId 是你在调用 playEffect 时设置的音效 ID
[agoraKit.setVolumeOfEffect: soundId:@"1" volume:50.0];
```

#### API 参考

- [`setEffectsVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setEffectsVolume:)
- [`setVolumeOfEffect`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVolumeOfEffect:withVolume:)

### 获取用户音量（回调方法）

在音频采集、混音、播放的整个过程中，你都可以使用下面的接口获取用户音量。

- 瞬时说话声音音量提示。如下回调获取瞬时说话音量最大的用户 ID，及音量大小。如果返回的用户 ID 为 0，则表示瞬时说话音量最大的是本地用户。

```swift
// swift
func rtcEngine(_ engine: AgoraRtcEngineKit, reportAudioVolumeIndicationOfSpeakers:
(NSArray<AgoraRtcAudioVolumeInfo*> *_Nonnull)speakers totalVolume:(NSInteger)totalVolume) {
// 获取瞬时说话音量最大的用户 ID
// speakers 为一个数组，包含说话者的用户 ID 及音量，音量范围为 0 - 255
// totalVolume 指混音后频道内的总音量，范围为 0 - 255
}
```

```objective-c
// objective-c
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine reportAudioVolumeIndicationOfSpeakers:(NSArray<AgoraRtcAudioVolumeInfo*> *_Nonnull)speakers totalVolume:(NSInteger)totalVolume {
// 获取瞬时说话音量最大的用户 ID
// speakers 为一个数组，包含说话者的用户 ID 及音量，音量范围为 0 - 255
// totalVolume 指混音后频道内的总音量，范围为 0 - 255
}
```

- 当前时间内累积音量最大者。如下回调获取获取特定时间段内，累积音量最大的用户 ID。如果返回的 uid 是 0，则表示当前时间段内累积音量最大的是本地用户。

```swift
// swift
func rtcEngine(_ engine: AgoraRtcEngineKit, activeSpeaker:(NSUInteger)speakerUid) {
// 获取当前时间段声音最大的用户 ID
}
```

```objective-c
// objective-c
- (void)rtcEngine:(AgoraRtcEngineKit *_Nonnull)engine activeSpeaker:(NSUInteger)speakerUid {
// 获取当前时间段声音最大的用户 ID
}
```

#### API 参考

- [`reportAudioVolumeIndicationOfSpeakers`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:reportAudioVolumeIndicationOfSpeakers:totalVolume:)
- [`activeSpeaker`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:activeSpeaker:)

## 开发注意事项

- 所有相关的方法都有返回值，返回值小于 0 表示方法调用失败。
- 用调整信号设置音量的方法，如果音量设置太大，由于硬件设备的限制，在某些设备上可能会出现声音不自然的效果。
