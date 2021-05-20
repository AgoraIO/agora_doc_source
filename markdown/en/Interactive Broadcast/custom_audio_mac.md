---
title: Custom Audio Source and Sink
platform: macOS
updatedAt: 2019-09-20 17:33:19
---
## Introduction

By default, an app uses the internal audio modules for capturing and rendering during real-time communication. You can use an external audio source and renderer. This page shows how to use the methods provided by Agora SDK to customize the audio source and renderer.

**Customizing the audio source and renderer** mainly applies to the following scenarios:

* When the audio source captured by the internal modules do not meet your needs. 
* When an app has its own audio module and uses a customized source for code reuse.
* When you need flexible device resource allocation to avoid conflicts with other services.

## Implementation

Ensure that you prepared the development environment. See [Integrate the SDK](./mac_video).

### Customize the Audio Source

Use the push method to customize the audio source, where the SDK by default conducts no data processing to the audio frame, such as noise reduction. Implement noise reduction on your own if you have such requirements.

```swift
// swift
// Push the video frame in the rawData format.
agoraKit.pushExternalAudioFrameRawData("your rawData", samples: "per push samples", timestamp: 0)

// Push the video frame in the CMSampleBuffer format.
agoraKit.pushExternalAudioFrameSampleBuffer("your CMSampleBuffer")
```

```objective-c
// objective-c
// Push the video frame in the rawData format.
[agoraKit pushExternalAudioFrameRawData: "your rawData" samples: "per push samples", timestamp: 0];

// Push the video frame in the CMSampleBuffer format,
[agoraKit pushExternalAudioFrameSampleBuffer: "your CMSampleBuffer"];
```

#### API Reference

* [`pushExternalAudioFrameRawData:samples:timestamp:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pushExternalAudioFrameRawData:samples:timestamp:)
* [`pushExternalAudioFrameSampleBuffer:`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/pushExternalAudioFrameSampleBuffer:)


## Considerations
Customizing the audio source and renderer is an advanced feature provided by Agora SDK. Ensure that you are experienced in audio application development.


	
