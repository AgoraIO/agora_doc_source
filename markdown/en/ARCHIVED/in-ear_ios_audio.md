---
title: In-ear Monitoring
platform: iOS
updatedAt: 2018-12-05 03:04:12
---
In-ear monitoring provides a mix of the audio sources (for example, a mix of the vocals and music) to the host with low latency, commonly used in professional scenarios, such as in concerts.
The Agora SDK supports the in-ear monitoring function and volume adjustment of the in-ear monitor.

## Implementation
Ensure that you prepare the development environment. See [Integrate the SDK](./ios_audio).

```swift
// swift
// Enables in-ear monitoring. The default value is false.
agoraKit.enable(inEarMonitoring: true)

// Sets the volume of the in-ear monitor. The value ranges between 0 and 100. The default is 100, which represents the original volume captured by the microphone.
agoraKit.setInEarMonitoringVolume(50)
```

```objective-c
// objective-c
// Enables in-ear monitoring. The default value is NO.
[agoraKit enableInEarMonitoring:YES];

// Sets the volume of the in-ear monitor. The value ranges between 0 and 100. The default value is 100, which represents the original volume captured by the microphone.
[agoraKit setInEarMonitoringVolume: 50];
```

## Considerations

The API methods have return values. If the method call fails, the return value is < 0.