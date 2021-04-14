---
title: Lastmile Tests
platform: Unity
updatedAt: 2020-07-06 11:40:28
---
## Introduction

To check if the uplink network condition is good enough to support the audio bitrate or target bitrate of the chosen video profile, you can conduct a last-mile network quality test before joining the channel.

This function particularly applies to scenarios which have high requirements on the network quality.



## Implementation

Before conducting the last-mile test, ensure that you have implemented the basic real-time communication functions in your project. For details, see the following documents:

- [Start a Voice Call](start_call_audio_unity) or [Start Live Interactive Audio Streaming](start_live_audio_unity)
- [Start a Video Call](start_call_unity) or [Start Live Interactive Video Streaming](start_live_unity)


1. Call the `StartLastmileProbeTest` method before joining a channel to get the uplink and downlink last-mile network statistics, including the bandwidth, packet loss, jitter, and round-trip time (RTT).

2. Once this method is enabled, the SDK triggers the following callbacks:

   - `OnLastmileQualityHandler`: Triggered 2 seconds after the `StartLastmileProbeTest` method is called. This callback rates the network conditions with a score and is more closely linked to the user experience.
   - `OnLastmileProbeResultHandler`: Triggered 30 seconds after the `StartLastmileProbeTest` method is called. This callback returns the real-time statistics of the network conditions and is more objective.

3. Call the `StopLastmileProbeTest` method to stop the last-mile network probe test.

   <div class="alert note">Before the test ends, Agora recommends not calling any other API methods.</div>

   
### API call sequence

Refer to the following diagram to implement the last-mile test in your project.

![](https://web-cdn.agora.io/docs-files/1582858108947)

### Sample code

Refer to the following code to implement the last-mile test in your project.

```c#
// Registers the callback events.
// Triggered 2 seconds after starting the last-mile test.
void OnLastmileQualityHandler(int quality)
{
  
}
  
// Triggered 30 seconds after starting the last-mile test.
void OnLastmileProbeResultHandler(LastmileProbeResult result)
{ 
    // (1) Stops the test. Agora recommends not calling any other API method before the test ends.
    mRtcEngine.StopLastmileProbeTest();
}
  
mRtcEngine.OnLastmileQuality = OnLastmileQualityHandler;
mRtcEngine.OnLastmileProbeResult = OnLastmileProbeResultHandler;
// Configures a LastmileProbeConfig instance.
LastmileProbeConfig config = new LastmileProbeConfig();
// Probes the uplink network quality.
config.probeUplink = true;
// Probes the downlink network quality.
config.probeDownlink = true;
// The expected uplink bitrate (bps). The value range is [100000, 5000000].
config.expectedUplinkBitrate = 100000;
// The expected downlink bitrate (bps). The value range is [100000, 5000000].
config.expectedDownlinkBitrate = 100000;
// Starts the last-mile network test before joining the channel.
mRtcEngine.StartLastmileProbeTest(config);
// (2) Stops the test in an alternate place. Agora recommends not calling any other API method before the test ends.
mRtcEngine.StopLastmileProbeTest();
```



### API Reference

- [`StartLastmileProbeTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a1d70042741eed8fd27234d43f0bdd86e)
- [`StopLastmileProbeTest`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a7097b5aa40f1124c5cb5ae7cc68d636f)
- [`OnLastmileQualityHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#ad91eb7212a21d5596d4a96dfedaa7753)
- [`OnLastmileProbeResultHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#afa2ac45e7687a97653fedb80c5346019)

## Considerations

- You can conduct a last mile test only before joining a channel. Before the test ends, Agora recommends not calling any other API methods.
- The `OnLastmileQualityHandler` callback may return `UNKNOWN` the first time it is triggered. Subsequent callbacks will return the test results.
- The audio SDK uses a fixed bitrate of 48 Kbps. The video SDK adjusts the actual bitrate according to the chosen video profile.