---
title: Video Stream Fallback
platform: iOS
updatedAt: 2021-03-25 10:36:00
---
## Introduction

The audio and video quality of a live broadcast or a video call deteriorates under poor network conditions. To improve the efficiency of a live broadcast, the `setLocalPublishFallbackOption` and `setRemoteSubscribeFallbackOption` methods are used for the SDK automatically switch the high-video stream to low-video stream and disbale the video stream under these conditions.


## Implementation

Before proceeding, ensure that you implement a basic live broadcast in your project. See [Start a Live Broadcast](start_live_ios) for details.

Refer to the following steps to set the stream fallback under poor network conditions:

1. After joining the channel, the host calls the `enableDualStreamMode` method to enable [dual stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-dualadual-stream-mode).
2. The host calls the `setLocalPublishFallbackOption` method and set `AudioOnly (2)` to enable the fallback option for the locally published media stream based on the network conditions. SDK will disable the upstream video but enable audio only when the netwrok conditions deteriorate and cannot support both video and audio streams.
	> Agora does not recommend using this method for CDN live streaming, because the remote CDN live user will have a noticeable lag when the locally published video stream falls back to audio only.
	
	When the local video stream falls back to audio only or when the audio only stream switches back to video, SDK triggers the `didLocalPublishFallbackToAudioOnly` callback to report current stream state to the local host.
3. Users in the channel call the `setRemoteSubscribeFallbackOption` method to set the subscribed stream fallback under poor network conditions.
	- Set `StreamLow (1)` to only subscribe to the low-video stream from the host under poor network conditions.
	- Sets`AudioOnly (2)` to susbcribe to the low-video stream or even audio stream from the host under poor network conditions.
	
	Once the remote media stream switches to the low stream due to poor network conditions, you can monitor the stream switch between a high and low stream in the `remoteVideoStats` callback. When the remotely subscribed video stream falls back to audio only or when the audio-only stream switches back to the video stream, the SDK triggers the `didRemoteSubscribeFallbackToAudioOnly` callback. 


### Sample code

```swift
//Swift
// Enable the dual-stream mode (Configuration for the local).
agoraKit.enableDualStreamMode(true)

// Configurations for the publisher. When the network condition is poor, send video stream only. 
agoraKit.setLocalPublishFallbackOption(.audioOnly)

// Configurations for the subscriber. Try to receive low stream under poor network conditions. When the current network conditions are not sufficient for video streams, receive audio stream only. 
agoraKit.setRemoteSubscribeFallbackOption(.audioOnly)
```

```objective-c
//Objective-C
// Enable the dual-stream mode (Configuration for the local).
agoraKit.enableDualStreamMode(true);

// Configurations for the publisher. When the network condition is poor, send video stream only. 
[agoraKit setLocalPublishFallbackOption: AgoraStreamFallbackOptionAudioOnly];

// Configurations for the subscriber. Try to receive low stream under poor network conditions. When the current network conditions are not sufficient for video streams, receive audio stream only. 
[agoraKit setRemoteSubscribeFallbackOption: AgoraStreamFallbackOptionAudioOnly];
```

### API Reference

- [`enableDualStreamMode`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/enableDualStreamMode:)
- [`setLocalPublishFallbackOption`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setLocalPublishFallbackOption:)
- [`setRemoteSubscribeFallbackOption`](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setRemoteSubscribeFallbackOption:)
- [`didLocalPublishFallbackToAudioOnly`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didLocalPublishFallbackToAudioOnly:)
- [`didRemoteSubscribeFallbackToAudioOnly`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:didRemoteSubscribeFallbackToAudioOnly:byUid:)
- [`remoteVideoStats`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:remoteVideoStats:)