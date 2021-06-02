---
title: Test a Media Device
platform: Android
updatedAt: 2020-07-06 15:58:27
---
## Introduction

To ensure smooth communications, we recommend conducting a media device test before joining a channel to check whether the microphone or camera works properly. This function applies to scenarios that have high-quality requirements, such as online education.

Before joining a channel, you can use the `startEchoTest` method to test if the audio devices, such as the microphone and the speaker, are working properly. This article explains how to use this method in your project.

## Implementation

Ensure that you understand how to [Start a Call](start_call_android) or [Start an Interactive Broadcast](start_live_android).

1. Call `startEchoTest` before joining a channel. You need to set the `intervalInSeconds` parameter in this method to notify the SDK when to report the result of this test. The value range is [2, 10], and the default value is 10 (in seconds).

2. When the echo test starts, let the user speak for a while. If the recording plays back within the set time interval, the audio devices and the network connection are working properly.

3. Once you get the test result, call `stopEchoTest` to stop the current test before joining a channel using joinChannel.

### Sample code

```java
// Start the echo test.
rtcEngine.startEchoTest(10);

// Wait and check if the user can hear the recorded audio.

// Stop the echo test.
rtcEngine.stopEchoTest();
```

### API Reference

- [`startEchoTest`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a712bb50be350186d097f4deed8e1aa37)
- [`stopEchoTest`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a01b8067275003c011f6d81bb41ee0fe1)

## Considerations

- Once the echo test ends, you must call `stopEchoTest` to stop it. Otherwise, you cannot take another echo test, or enter a call using `joinChannel`.
- In a Live-broadcast channel, only a broadcaster can call `startEchoTest`. 