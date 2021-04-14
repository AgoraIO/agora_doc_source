---
title: Test a Media Device
platform: macOS
updatedAt: 2020-07-06 16:05:32
---
## Introduction

To ensure smooth communications, we recommend conducting a media device test before joining a channel to check whether the microphone or camera works properly. This function applies to scenarios that have high-quality requirements, such as online education.

## Implementation

Ensure that you understand how to [Start a Call](start_call_mac) or [Start an Interactive Broadcast](start_live_mac).

- Choose either of the following ways to test the audio devices:
	- Call the `startRecordingDeviceTest` method to test the audio recording devices, and call the `startPlaybackDeviceTest` method to test the audio playback devices.
	- Call the `startAudioDeviceLoopbackTest` method to test the audio device loopback (including the recording and playback devices).
- Call the `startCaptureDeviceTest` method to test the video capture devices.

<div class="alert note">Test the devices before joining a channel.</div>

### Recording device test

Call the `startRecordingDeviceTest` method to test whether the local audio recording device, such as the microphone, is working properly.

To conduct the test, the user speaks, and the SDK reports the audio volume information in the `reportAudioVolumeIndication` callback. A UID of 0 indicates the local user.

When the test finishes, call the `stopRecordingDeviceTest` method to stop the current test.

```swift	
// swift
// Starts the recording device test.
agoraKit.startRecordingDeviceTest(1000)
	
// Stops the recording device test.
agoraKit.stopRecordingDeviceTest()
```

```oc
// objective-c
// Starts the recording device test.
[agoraKit startRecordingDeviceTest: 1000];

// Stops the recording device test.
[agoraKit stopRecordingDeviceTest];
```

### Audio playback device test

Call the `startPlaybackDeviceTest` method to test whether the local audio playback device, such as the speaker, is working properly.

To conduct the test, specify an audio file for playback. If you can hear the audio file, the audio playback device works properly.

When the test finishes, call the `stopPlaybackDeviceTest` method to stop the current test.

```swift
// swift
// Starts the playback device test.
agoraKit.startPlaybackDeviceTest("audio file path")
	
// Stops the playback device test.
agoraKit.stopPlaybackDeviceTest()
```

```oc
// objective-c
// Starts the playback device test.
[agoraKit startPlaybackDeviceTest: @"audio file path"];

// Stops the playback device test.
[agoraKit stopPlaybackDeviceTest];
```

### Audio device loopback test

Call the `startAudioDeviceLoopbackTest` method to test whether the local audio devices, including the microphones and speakers, are working properly.

To conduct the test, the user speaks, then the microphone captures the local audio and plays it through the speaker. The SDK reports the audio volume information in the `reportAudioVolumeIndication` callback. A UID of 0 indicates the local user.

When the test finishes, call the `stopAudioDeviceLoopbackTest` method to stop the current test.

### Video capture device test

After calling the `enableVideo` method, call the `startCaptureDeviceTest` method to test whether the local video devices, such as the camera, are working properly.

To conduct the test, specify a window view that displays the image. If you can see the local video view, the video devices work properly.

When the test finishes, call the `stopCaptureDeviceTest` method to stop the current test.

```swift
// swift
// Starts the video capture device test.
agoraKit.startCaptureDeviceTest("view window")

// Stops the video capture device test.
agoraKit.stopCaptureDeviceTest
```

```objective-c
// objective-c
// Starts the video capture device test.
[agoraKit startCaptureDeviceTest: "view window"];

// Stops the video capture device test.
[agoraKit stopCaptureDeviceTest];
```

### API Reference

* [`startRecordingDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopRecordingDeviceTest)
* [`stopRecordingDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopRecordingDeviceTest)
* [`startPlaybackDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startPlaybackDeviceTest:)
* [`stopPlaybackDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopPlaybackDeviceTest)
* [`startCaptureDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startCaptureDeviceTest:)
* [`stopCaptureDeviceTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopCaptureDeviceTest)
* [`startAudioDeviceLoopbackTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/startAudioDeviceLoopbackTest:)
* [`stopAudioDeviceLoopbackTest`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/stopAudioDeviceLoopbackTest)

## Considerations

If the input device fails to initialize, check the error message in [Developer Center](./API%20Reference/oc/Constants/AgoraErrorCode.html).