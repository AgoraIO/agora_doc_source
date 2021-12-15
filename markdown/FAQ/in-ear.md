---
title: 如何开启耳返？
platform: ["Android", "iOS", "Unity"]
updatedAt: 2020-12-16 06:52:03
Products: ["Voice", "Video", "Interactive Broadcast", "live-streaming"]
---

耳返主要实现监听的功能，在低延时的情况下可以给主播一个比较真实的反馈，在演唱会等专业场景里比较常用。Agora RTC SDK 支持耳返功能，同时支持调节耳返的音量。

## 实现方法

> 在实现耳返功能前，请确保已在你的项目中实现基本的实时音视频功能。

Agora SDK 提供 `enableInEarMonitoring` 和 `setInEarMonitoringVolume` 方法给开发者根据场景需求灵活配置耳返功能。该方法在加入频道前、后均可调用，且仅支持 Android 和 iOS 平台。

### 示例代码

```java
// Java
// 设置开启耳返监听功能，默认为 false
rtcEngine.enableInEarMonitoring(true);

// 设置耳返的音量，volume的取值范围为0 ~ 100，默认值是 100，代表麦克风录到的原始音量
int volume = 80;
rtcEngine.setInEarMonitoringVolume(volume);
```

```swift
// Swift
// 设置开启耳返监听功能，默认为 false
agoraKit.enable(inEarMonitoring: true)

// 设置耳返的音量，volume 的取值范围为 0 ~ 100，默认为 100，代表麦克风录到的原始音量
agoraKit.setInEarMonitoringVolume(50)
```

```objective-c
// Objective-C
// 设置开启耳返监听功能，默认为 NO
[agoraKit enableInEarMonitoring:YES];

// 设置耳返的音量，volume的取值范围为 0 ~ 100，默认为 100，代表麦克风录到的原始音量
[agoraKit setInEarMonitoringVolume: 50];
```

```c#
// C#
// 设置开启耳返监听功能，默认为 false
int ret = mRtcEngine.EnableInEarMonitoring(true);

// 设置耳返的音量，volume的取值范围为 0 ~ 100，默认为 100，代表麦克风录到的原始音量
int ret = mRtcEngine.SetInEarMonitoringVolume(50);
```

### API 参考

- Java

  - [`enableInEarMonitoring`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aeb014fcf7ec84291b9b39621e09772ea)
  - [`setInEarMonitoringVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af71afdf140660b10c4fb0c40029c432d)

- Objective-C

  - [`enableInEarMonitoring`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableInEarMonitoring:)
  - [`setInEarMonitoringVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setInEarMonitoringVolume:)

- C#
  - [`EnableInEarMonitoring`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ab5e3a1ccf03508f96af241cc25aefecd)
  - [`SetInEarMonitoringVolume`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a0236c42fc3b664eb9e66f99e6209afc8)

## 开发注意事项

- 在 `enableInEarMonitoring` 后调用 `setInEarMonitoringVolume`。
- 以上方法都有返回值，返回值小于 0 表示方法调用失败。
- 自 v3.1.0 起，你可以在以下 Android 设备中体验更低的耳返延迟：
  - OPPO Reno4 Pro 5G
  - OPPO Reno4 5G
