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

The SDK provides the `startEchoTest` method that tests whether the network connection and the audio devices, such as the microphone and the speakers, are working properly.

### Network probe test

The `startLastmileProbeTest` method probes the last-mile network before joining a channel and returns statistics about the network quality, including round-trip latency, packet loss rate, and network bandwidth.

The API call sequence is as follows:

![](https://web-cdn.agora.io/docs-files/1569464757177)

## Prerequisites

Before proceeding, ensure that you have implemented basic real-time functions in your project. See [Start a Call](./start_call_android?platform=Android) or [Start Interactive Live Streaming](./start_live_android?platform=Android).

## Implement pre-call testing

### Device test

To start an echo test, refer to the following steps.

1. Call `startEchoTest` before joining a channel. You need to set the `intervalInSeconds` parameter in this method to notify the SDK when to report the result of this test. The value range is [2,10], and the default value is 10 (in seconds).

2. When the echo test starts, let the user speak for a while. If the recording plays back within the set time interval, the audio devices and the network connection are working properly.

3. Once you get the test result, call `stopEchoTest` to stop the current test before joining a channel using `joinChannel`.

Refer to the following code to implement the device test in your project.

```java
// Start the echo test.
// Set the time interval between when you speak and when the recording plays back as 10 seconds.
// Only a broadcaster can call `startEchoTest`.
rtcEngine.startEchoTest(10);

// Wait and check if the user can hear the recorded audio.

// Stop the echo test.
// Once the echo test ends, you must call `stopEchoTest` to stop it. Otherwise, you cannot conduct another echo test or join a channel using `joinChannel`.
rtcEngine.stopEchoTest();
```

### Network probe test

To implement the network probe test, refer to the following steps.

1. Call the `startLastmileProbeTest` to start the network probe test before joining a channel or switching the user role. You need to specify the expected upstream and downstream bitrate in this method.
2.  After the method call, the SDK triggers the following callbacks:
    - `onLastmileQuality`: Triggered two seconds after the `startLastmileProbeTest` method is called. This callback rates the network conditions with a score and is more closely linked to the user experience.
    - `onLastmileProbeResult`: Triggered 30 seconds after the `startLastmileProbeTest` method is called. This callback returns the real-time statistics of the network conditions and is more objective.
3. After getting the network quality statistics, call the `stopLastmileProbeTest` method to stop the last-mile network probe test.

Refer to the following code to implement the last-mile test in your project.

```java
// Configure a LastmileProbeConfig instance.
LastmileProbeConfig config = new LastmileProbeConfig(){};
// Probe the uplink network quality.
config.probeUplink =  true;
// Probe the downlink network quality.
config.probeDownlink = true;
// The expected uplink bitrate (bps). The value range is [100000,5000000].
config.expectedUplinkBitrate = 100000;
// The expected downlink bitrate (bps). The value range is [100000,5000000].
config.expectedDownlinkBitrate = 100000;
// Start the last-mile network test before joining the channel.
// Calling `startLastmileProbeTest` for pre-call network quality detection consumes network traffic. Therefore, after calling this method, Agora recommends not calling any other method until you receive the `onLastmileProbeResult` callback.
rtcEngine.startLastmileProbeTest(config);

// Implemented in the global IRtcEngineEventHandler class.
// Triggered 2 seconds after starting the last-mile test.
// The `onLastmileQuality` callback may return `UNKNOWN` the first time it is triggered. Subsequent callbacks will return the test results.
public void onLastmileQuality(int quality){
    statisticsInfo.setLastMileQuality(quality);
    updateLastMileResult();
}


// Implemented in the global IRtcEngineEventHandler class.
// Triggered 30 seconds after starting the last-mile test.
public void onLastmileProbeResult(LastmileProbeResult) {
	// (1) Stop the test. Agora recommends not calling any other API method before the test ends.
	rtcEngine.stopLastmileProbeTest();
    statisticsInfo.setLastMileProbeResult(lastmileProbeResult);
    updateLastMileResult();
}

// (2) Stop the test in an alternate place. Agora recommends not calling any other API method before the test ends.
rtcEngine.stopLastmileProbeTest();
```

## Reference

This section includes reference information about the function.

### Sample project

Agora provides an open-source sample project that implements [pre-call tests](https://github.com/AgoraIO/API-Examples/blob/dev/3.6.200/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/PreCallTest.java) on GitHub. You can download the sample project to try it out or refer to the source code.

### API Reference

- [`startLastmileProbeTest`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a81c6541685b1c4437d9779a095a0f871)
- [`stopLastmileProbeTest`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ae21243b8da8bda9ee5f3a00621cbf959)
- [`onLastmileQuality`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a2887941e3c105c21309bd2643372e7f5)
- [`onLastmileProbeResult`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#ad74a9120325bfeccdec4af4611110281)
- [`startEchoTest`]()
- [`stopEchoTest`]()