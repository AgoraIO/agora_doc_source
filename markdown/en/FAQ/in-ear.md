---
title: How can I enable in-ear monitoring?
platform: ["Android","iOS","Unity"]
updatedAt: 2020-12-16 06:51:24
Products: ["Voice","Video","Interactive Broadcast"]
---
In-ear monitoring provides a mix of the audio sources (for example, a mix of the vocals and music) to the host with low latency, commonly used in professional scenarios, such as in concerts.

The Agora RTC SDK supports the in-ear monitoring function and volume adjustment of the in-ear monitor.

## Implementation

> Before using the in-ear monitoring function, ensure that you have implemented the basic real-time communication functions in your project.

The Agora SDK provides the `enableInEarMonitoring` and `setInEarMonitoringVolume` methods to set the in-ear monitoring according to the scenario. These methods can be called before and after joining a channel, and only supports Android and iOS platforms.

### Sample code

```java
// Java
// Enables in-ear monitoring. The default value is false.
rtcEngine.enableInEarMonitoring(true);

// Sets the volume of the in-ear monitor. The value ranges between 0 and 100. The default value is 100, which represents the original volume captured by the microphone.
int volume = 80;
rtcEngine.setInEarMonitoringVolume(volume);
```

```swift
// Swift
// Enables in-ear monitoring. The default value is false.
agoraKit.enable(inEarMonitoring: true)

// Sets the volume of the in-ear monitor. The value ranges between 0 and 100. The default value is 100, which represents the original volume captured by the microphone.
agoraKit.setInEarMonitoringVolume(50)
```

```objective-c
// Objective-C
// Enables in-ear monitoring. The default value is NO.
[agoraKit enableInEarMonitoring:YES];

// Sets the volume of the in-ear monitor. The value ranges between 0 and 100. The default value is 100, which represents the original volume captured by the microphone.
[agoraKit setInEarMonitoringVolume: 50];
```

```c#
// C#
// Enables in-ear monitoring. The default value is false.
int ret = mRtcEngine.EnableInEarMonitoring(true);

// Sets the volume of the in-ear monitor. The value ranges between 0 and 100. The default value is 100, which represents the original volume captured by the microphone.
int ret = mRtcEngine.SetInEarMonitoringVolume(50);
```

### API reference
- Java for Android
    - [`enableInEarMonitoring`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#aeb014fcf7ec84291b9b39621e09772ea)
    - [`setInEarMonitoringVolume`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af71afdf140660b10c4fb0c40029c432d)

- Objective-C for iOS
    - [`enableInEarMonitoring`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableInEarMonitoring:)
    - [`setInEarMonitoringVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setInEarMonitoringVolume:)

- C# for Unity (Android and iOS only)
    - [`EnableInEarMonitoring`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ab5e3a1ccf03508f96af241cc25aefecd)
    - [`SetInEarMonitoringVolume`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a0236c42fc3b664eb9e66f99e6209afc8)

## Considerations

- Call `enableInEarMonitoring` before `setInEarMonitoringVolume`.
- The API methods have return values. If the method call fails, the return value is < 0.
- Since v3.1.0, you can experience a shorter delay of in-ear monitoring on the following Android devices:
  - OPPO Reno4 Pro 5G
  - OPPO Reno4 5G