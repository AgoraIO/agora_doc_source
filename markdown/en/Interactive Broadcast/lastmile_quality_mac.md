---
title: Pre-call Network and Device Tests
platform: iOS
updatedAt: 2020-12-20 15:27:04
---
## Introduction

To check if the uplink network condition is good enough to support the audio bitrate or target bitrate of the chosen video profile, you can conduct a last-mile network quality test before joining the channel.

This function particularly applies to scenarios which have high requirements on the network quality.



## Implementation

Before conducting the last-mile test, ensure that you have implemented the basic real-time communication functions in your project. For details, see the following documents:
- iOS: [Start a Call](start_call_ios) or [Start a Live Broadcast](start_live_ios)
- macOS: [Start a Call](start_call_mac) or [Start a Live Broadcast](start_live_mac)

Call the `startLastmileProbeTest` method before joining a channel to get the uplink and downlink last-mile network statistics, including the bandwidth, packet loss, jitter, and round-trip time (RTT).

Once this method is enabled, the SDK triggers the following callbacks:

- `lastmileQuality`: Triggered two seconds after the `startLastmileProbeTest` method is called. This callback rates the network conditions with a score and is more closely linked to the user experience.
- `lastmileProbeResult`: Triggered 30 seconds after the `startLastmileProbeTest` method is called. This callback returns the real-time statistics of the network conditions and is more objective.

### API call sequence

Refer to the following diagram to implement the last-mile test in your project.

![](https://web-cdn.agora.io/docs-files/1569465569670)

### Sample code

Refer to the following code to implement the last-mile test in your project.

```swift
// Swift
//  Configure a LastmileProbeConfig instance.
let config = AgoraLastmileProbeConfig(
  //Probe the uplink network quality.
  probeUplink: true, 
  // Probe the downlink network quality.
  probeDownlink: true,
  // The expected uplink bitrate (Kbps). The value range is [100, 5000].
  expectedUplinkBitrate: 1000, 
  // The expected downlink bitrate (Kbps). The value range is [100, 5000].
  expectedDownlinkBitrate: 1000)
// Start the last-mile network test before joining the channel.
agoraKit.startLastmileProbeTest(config)

// Register the callback events.
// Triggered 2 seconds after starting the last-mile test.
// quality means the detected network quality type.
func rtcEngine(_ engine: AgoraRtcEngineKit, lastmileQuality quality: AgoraNetworkQuality) {
}

// Triggered 30 seconds after starting the last-mile test.
// result means the last-mile probe test result.
func rtcEngien(_ engine: AgoraRtcEngineKit, lastmileProbeResult result: AgoraLastmileProbeResult){
  // (1) Stop the test. Agora recommends not calling any other API method before the test ends.
  agoraKit.stopLastmileProbeTest()  
}

// (2) Stop the test. Agora recommends not calling any other API method before the test ends.
agoraKit.stopLastmileProbeTest()
```

```objective-c
// Objective-C
//  Configure a LastmileProbeConfig instance.
AgoraLastmileProbeConfig *config = [[AgoraLastmileProbeConfig alloc] probeUplink: YES probeDownlink: YES expectedUplinkBitrate: 1000 expectedDownlinkBitrate: 1000];
// Start the last-mile network test before joining the channel.
[agoraKit startLastmileProbeTest: config];

// Register the callback events.
// Triggered 2 seconds after starting the last-mile test.
// quality means the detected network quality type.
- (void)rtcEngine:(AgoraRtcEngine * _Nonnull)engine lastmileQuality: (AgoraNetworkQuality)quality {
}

// Triggered 30 seconds after starting the last-mile test.
// result means the last-mile probe test result.
- (void)rtcEngine:(AgoraRtcEngine * _Nonnull)engine lastmileProbeResult: (AgoraLastmileProbeResult)result {
  // (1) Stop the test. Agora recommends not calling any other API method before the test ends.
  [agoraKit stopLastmileProbeTest];
}

// (2) Stop the test. Agora recommends not calling any other API method before the test ends.
[agoraKit stopLastmileProbeTest];
```

We also provide an open-source [OpenVideoCall-iOS](https://github.com/AgoraIO/Basic-Video-Call/tree/master/Group-Video/OpenVideoCall-iOS) demo project on Github. You can try the demo, or view the source code in the [LastmileViewController.swift](https://github.com/AgoraIO/Basic-Video-Call/blob/master/Group-Video/OpenVideoCall-iOS/OpenVideoCall/LastmileViewController.swift) file.

### API Reference

- [`startLastmileProbeTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startLastmileProbeTest:)
- [`stopLastmileProbeTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopLastmileProbeTest)
- [`lastmileQuality`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileQuality:)
- [`lastmileProbeResult`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileProbeTestResult:)

## Considerations
- You can conduct a last mile test only before joining a channel. Before the test ends, Agora recommends not calling any other API methods.
- The `lastmileQuality` callback may return UNKNOWN the first time it is triggered. Subsequent callbacks will return the test results.
- The audio SDK uses a fixed bitrate of 48 Kbps. The video SDK adjusts the actual bitrate according to the chosen video profile.




