---
title: In-ear Monitoring
platform: Android
updatedAt: 2018-12-05 03:03:30
---
In-ear monitoring provides a mix of the audio sources (for example, a mix of the vocals and music) to the host with low latency, commonly used in professional scenarios, such as in concerts.
The Agora SDK supports the in-ear monitoring function and volume adjustment of the in-ear monitor.

## Implementation
Ensure that you prepare the development environment. See [Integrate the SDK](./android_audio).

```java
// Enables in-ear monitoring. The default value is false.
rtcEngine.enableInEarMonitoring(true);
  
// Sets the volume of the in-ear monitor. The value ranges between 0 and 100. The default value is 100, which represents the original volume captured by the microphone.
int volume = 80;
rtcEngine.setInEarMonitoringVolume(volume);
```
	 

## Considerations

The API methods have return values. If the method call fails, the return value is < 0.