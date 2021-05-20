---
title: In-ear Monitoring
platform: iOS
updatedAt: 2020-11-17 03:02:31
---
In-ear monitoring provides a mix of the audio sources (for example, a mix of the vocals and music) to the host with low latency, commonly used in professional scenarios, such as in concerts.
The Agora SDK supports the in-ear monitoring function and volume adjustment of the in-ear monitor.

## Implementation

Before using the in-ear monitoring function, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_ios) or [Start a Live Broadcast](start_live_ios).

The Agora SDK provides the `enableInEarMonitoring` and `setInEarMonitoringVolume` methods to set the in-ear monitoring according to the scenario, you can use these methods no matter before or after `joinChannelByToken`.

### Sample code

```swift
// swift
// Enables in-ear monitoring. The default value is false.
agoraKit.enable(inEarMonitoring: true)

// Sets the volume of the in-ear monitor. The value ranges between 0 and 100. The default value is 100, which represents the original volume captured by the microphone.
agoraKit.setInEarMonitoringVolume(50)
```

```objective-c
// objective-c
// Enables in-ear monitoring. The default value is NO.
[agoraKit enableInEarMonitoring:YES];

// Sets the volume of the in-ear monitor. The value ranges between 0 and 100. The default value is 100, which represents the original volume captured by the microphone.
[agoraKit setInEarMonitoringVolume: 50];
```

### API reference

- [`enableInEarMonitoring`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableInEarMonitoring:)
- [`setInEarMonitoringVolume`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setInEarMonitoringVolume:)

## Considerations

The API methods have return values. If the method call fails, the return value is < 0.