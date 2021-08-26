For calls and events that require high quality audio and video, best practice is to ensure that the hardware your app is running on and the last mile between the device and Agora Platform are good enough to assure the quality you require. This improves the user experience and helps you troubleshoot.

This page shows you how to implement device and network tests in your app.

## Understand the tech

In telecommunications, a probe is an action taken or an object used for the purpose of learning something about the state of the network. For example, an empty message can be sent simply to see whether the destination actually exists.

The following measures are important:

- Bandwidth - commonly measured in bits/second is the maximum rate that information can be transferred
- Throughput - the actual rate that information is transferred
- Latency - the delay between the sender and the receiver decoding it, this is mainly a function of the signals travel time, and processing time at any nodes the information traverses
- Jitter - variation in packet delay at the receiver of the information
- Error rate - the number of corrupted bits expressed as a percentage or fraction of the total sent

A device test checks if audio captured from a device can be played back after the it has passed through a network. The Agora tests captures audio from the device microphone, sends it to Agora Platform with a defined wait time. For example, five seconds. After the wait time Agora Platform sends the audio back to the device and it is played to the device loudspeaker. You can then judge if the audio is of adequate quality.

### Device test

The `startEchoTestWithInterval` method that tests whether the network connection and the audio devices, such as the microphone and the speakers, are working properly.

### Network probe test

The `startLastmileProbeTest` method that probes the last-mile network before joining a channel and returns statistics about the network quality, including round-trip latency, packet loss rate, and network bandwidth.

The API call sequence is as follows:

![](https://web-cdn.agora.io/docs-files/1603946038258)

When conducting the last-mile probe test, the voice SDK uses a fixed bitrate of 48 Kbps. The video SDK adjusts the actual bitrate according to the video profile.

## Prerequisites

Before adjusting the audio volume, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_ios) or [Start Interactive Live Streaming](start_live_ios).

## Implement pre-call testing

Agora recommends that you start device test before starting network probe test.

### Device test

To start an echo test, refer to the following steps.

1. Call `startEchoTestWithInterval` before joining a channel. You need to set the `interval` parameter in this method to notify the SDK when to report the result of this test. The value range is [2,10], and the default value is 10 (in seconds).
2. When the echo test starts, let the user speak for a while. If the recording plays back within the set time interval, the audio devices and the network connection are working properly.
3. Once you get the test result, call `stopEchoTest` to stop the current test before joining a channel using `joinChannelByToken`.

Refer to the following sample code to implement this function.

```swift
// Swift
// Starts the echo test.
// Only a broadcaster can call `startEchoTestWithInterval`.
agoraKit.startEchoTestWithInterval(10)

// Wait and check if the user can hear the recorded audio.

// Stops the echo test.
// Once the echo test ends, you must call `stopEchoTest` to stop it. Otherwise, you cannot conduct another echo test or join a channel using `joinChannelByToken`.
agoraKit.stopEchoTest
```

### Network probe test

To implement the network probe test, refer to the following steps.

1. Call `startLastmileProbeTest` to start the network probe test before joining a channel or switching the user role. You need to specify the expected upstream and downstream bitrate in this method.

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
  // Calling `startLastmileProbeTest` for pre-call network quality detection consumes network traffic. Therefore, after calling this method, Agora recommends not calling any other method until you receive the `lastmileProbeTest` callback.
  agoraKit.startLastmileProbeTest(config)
  ```

2. After the method call, the SDK returns the following two callbacks
	- `lastmileQuality`: Triggered two seconds after `startLastmileProbeTest` is called. This callback provides ratings of the uplink and downlink network quality and reflects the user experience.
	- `lastmileProbeResult`: Triggered 30 seconds after `startLastmileProbeTest` is called. This callback provides real-time statistics of the network quality and is more objective.

  ```swift
  // Swift
  // Receives the lastmileQuality callback two seconds after calling startLastmileProbeTest. This callback is triggered once every 2 seconds.
  // The `lastmileQuality` callback may return `Unknown` the first time it is triggered. Subsequent callbacks will return the test results.
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

3. After getting the network quality statistics, call `stopLastmileProbeTest` to stop the network probe test.

  ```swift
  // Swift
  // Stops the last-mile network probe test.
  // You can call stopLastmileProbeTest either within the lastmileProbeResult callback, or at other time before joining a channel.
  agoraKit.stopLastmileProbeTest()
  ```

## Reference

This section includes in depth information about the methods you used in this page, and links to related pages.

### Sample project

Agora provides an open-source iOS sample project on GitHub that implements pre-call detection in the [PrecallTest.swift](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/iOS/APIExample/Examples/Advanced/PrecallTest/PrecallTest.swift) file. You can download the sample project to try it out or refer to the source code.

### API reference

- [`startEchoTestWithInterval`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startEchoTestWithInterval:successBlock:)
- [`stopEchoTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopEchoTest)
- [`startLastmileProbeTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startLastmileProbeTest:)
- [`stopLastmileProbeTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopLastmileProbeTest)
- [`lastmileQuality`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileQuality:)
- [`lastmileProbeResult`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:lastmileProbeTestResult:)