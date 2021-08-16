## Description

In real-time scenarios requiring high quality, conducting tests before joining a channel helps troubleshoot in advance and improve the overall user experience. You can perform the following pre-call tests:

- Network test: Detects the network quality by probing the uplink and downlink last-mile network quality.
- Device test: Checks if the local audio recording and playback devices work properly.

This article describes how to implement these tests.

## Sample project

Agora provides an open-source iOS sample project on GitHub that implements pre-call detection in the [PrecallTest.swift](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/iOS/APIExample/Examples/Advanced/PrecallTest/PrecallTest.swift) file. You can download the sample project to try it out or refer to the source code.

## Network probe test

The SDK provides the `startLastmileProbeTest` method that probes the last-mile network before joining a channel and returns statistics about the network quality, including round-trip latency, packet loss rate, and network bandwidth.

### Implementation

Before proceeding, ensure that you have implemented basic real-time functions in your project.

Refer to the following steps to implement the network probe test.

1. Call `startLastmileProbeTest` to start the network probe test before joining a channel or switching the user role. You need to specify the expected upstream and downstream bitrate in this method.
2. After the method call, the SDK returns the following two callbacks
	- `lastmileQuality`: Triggered two seconds after `startLastmileProbeTest` is called. This callback provides ratings of the uplink and downlink network quality and reflects the user experience.
	- `lastmileProbeResult`: Triggered 30 seconds after `startLastmileProbeTest` is called. This callback provides real-time statistics of the network quality and is more objective.
3. After getting the network quality statistics, call `stopLastmileProbeTest` to stop the network probe test.

The API call sequence is as follows:

![](https://web-cdn.agora.io/docs-files/1603946038258)

### Sample code

Refer to the following sample code to implement this function in your project.

```swift
// Swift
let config = AgoraLastmileProbeConfig()
// Probes the uplink network
config.probeUplink = true;
// Probes the downlink network
config.probeDownlink = true;
// The expected uplink bitrate(bps). The value range is [100000,5000000]
config.expectedUplinkBitrate = 100000;
// The expected downlink bitrate(bps). The value range is [100000,5000000]
config.expectedDownlinkBitrate = 100000;

// Call startLastmileProbeTest to start the network probe test
agoraKit.startLastmileProbeTest(config)
```

```swift
// Swift
// Receives the lastmileQuality callback two seconds after calling startLastmileProbeTest. This callback is triggered once every 2 seconds.
func rtcEngine(_ engine: AgoraRtcEngineKit, lastmileQuality quality: AgoraNetworkQuality) {
    lastmileResultLabel.text = "Quality: \(quality.description())"
}


// Receives the lastmileProbeResult callback 30 seconds after calling startLastmileProbeTest. This callback provides more detailed network quality statistics.
func rtcEngine(_ engine: AgoraRtcEngineKit, lastmileProbeTest result: AgoraLastmileProbeResult) {
  // The round trip time delay
  let rtt = "Rtt: \(result.rtt)ms"
  // The downlink network bandwidth
  let downlinkBandWidth = "DownlinkAvailableBandwidth: \(result.downlinkReport.availableBandwidth)Kbps"
  // The downlink jitterbuffer
  let downlinkJitter = "DownlinkJitter: \(result.downlinkReport.jitter)ms"
  // The downlink jitterbuffer
  let downlinkLoss = "DownlinkLoss: \(result.downlinkReport.packetLossRate)%"

  // The uplink network bandwidth
  let uplinkBandwidth = "UplinkAvailableBandwidth: \(result.uplinkReport.availableBandwidth)Kbps"
  // The uplink jitter buffer
  let uplinkJitter = "UplinkJitter: \(result.uplinkReport.jitter)ms"
  // The uplink packet loss rate
  let uplinkLoss = "UplinkLoss: \(result.uplinkReport.packetLossRate)%"

  lastmileProbResultLabel.text = [rtt, downlinkBandwidth, downlinkJitter, downlinkLoss, uplinkBandwidth, uplinkJitter, uplinkLoss].joined(separator: "\n")
}
```

```swift
// Swift
// Stops the last-mile network probe test.
// You can call stopLastmileProbeTest either within the lastmileProbeResult callback, or at other time before joining a channel.
agoraKit.stopLastmileProbeTest()
```

### API reference

- [`startLastmileProbeTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startLastmileProbeTest:)
- [`stopLastmileProbeTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopLastmileProbeTest)
- [`lastmileQuality`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileQuality:)
- [`lastmileProbeResult`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileProbeTestResult:)

## Device test

As of v2.4.0, the Agora RTC Native SDK provides the `startEchoTestWithInterval` method that tests whether the network connection and the audio devices, such as the microphone and the speakers, are working properly.

### Implementation

Before proceeding, ensure that you have implemented basic real-time functions in your project. See [Start a Call](start_call_ios) or [Start Live Interactive Streaming](start_live_ios).

Refer to the following steps to start an echo test.

1. Call `startEchoTestWithInterval` before joining a channel. You need to set the `interval` parameter in this method to notify the SDK when to report the result of this test. The value range is [2,10], and the default value is 10 (in seconds).
2. When the echo test starts, let the user speak for a while. If the recording plays back within the set time interval, the audio devices and the network connection are working properly.
3. Once you get the test result, call `stopEchoTest` to stop the current test before joining a channel using `joinChannelByToken`.

### Sample code

Refer to the following sample code to implement this function.

```swift
// Swift
// Starts the echo test.
agoraKit.startEchoTestWithInterval(10)

// Wait and check if the user can hear the recorded audio.

// Stops the echo test.
agoraKit.stopEchoTest
```

### API reference

- [`startEchoTestWithInterval`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startEchoTestWithInterval:successBlock:)
- [`stopEchoTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopEchoTest)

## Considerations

- Calling `startLastmileProbeTest` for pre-call network quality detection consumes network traffic. Therefore, after calling this method, Agora recommends not calling any other method until you receive the `lastmileProbeTest` callback.
- The `lastmileQuality` callback may return `Unknown` the first time it is triggered. Subsequent callbacks will return the test results.
- When conducting the last-mile probe test, the voice SDK uses a fixed bitrate of 48 Kbps. The video SDK adjusts the actual bitrate according to the video profile.
- Only a broadcaster can call `startEchoTestWithInterval`.
- Once the echo test ends, you must call `stopEchoTest` to stop it. Otherwise, you cannot conduct another echo test or join a channel using `joinChannelByToken`.

