---
title: In-ear Monitoring
platform: Unity
updatedAt: 2020-10-15 16:25:49
---
In-ear monitoring provides a mix of the audio sources (for example, a mix of the vocals and music) to the host with low latency, commonly used in professional scenarios, such as in concerts.
The Agora SDK supports the in-ear monitoring function and volume adjustment of the in-ear monitor.

## Implementation

Before using the in-ear monitoring function, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Voice Call](start_call_audio_unity) or [Start a Voice Broadcast](start_live_audio_unity) for details.

The Agora SDK provides the `EnableInEarMonitoring` and `SetInEarMonitoringVolume` methods to set the in-ear monitoring according to the scenario, you can use these methods no matter before or after `JoinChannelByKey`.

### Sample code

```c#
// Enables in-ear monitoring. The default value is false.
int ret = mRtcEngine.EnableInEarMonitoring(false);

// Sets the volume of the in-ear monitor as 80% of the original volume. The value ranges between 0 and 100. The default value is 100, which represents the original volume captured by the microphone.
int ret = mRtcEngine.SetInEarMonitoringVolume(80);
```

### API reference

- [`EnableInEarMonitoring`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ab5e3a1ccf03508f96af241cc25aefecd)
- [`SetInEarMonitoringVolume`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a0236c42fc3b664eb9e66f99e6209afc8)

## Considerations

- Call `EnableInEarMonitoring` before `SetInEarMonitoringVolume`.
- The API methods have return values. If the method call fails, the return value is < 0.