---
title: Video Stream Fallback
platform: Unity
updatedAt: 2020-11-16 04:32:08
---
## Introduction

The audio and video quality of live interactive video streaming or a video call deteriorates under poor network conditions. To improve the efficiency of live interactive video streaming or a video call, the `SetLocalPublishFallbackOption` and `SetRemoteSubscribeFallbackOption` methods are used for the SDK to automatically switch the high-video stream to low-video stream and disable the video stream under these conditions.


## Implementation

Before proceeding, ensure that you implement live interactive video streaming or call in your project. See [Start a Video Call](start_call_unity) or [Start Live Interactive Video Streaming](start_live_unity) for details.

Refer to the following steps to set the stream fallback under poor network conditions:

1. After joining the channel, the publisher calls the `EnableDualStreamMode` method to enable [dual stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-dualadual-stream-mode).
2. The publisher calls the `SetLocalPublishFallbackOption` method and set `AUDIO_ONLY (2)` to enable the fallback option for the locally published media stream based on the network conditions. The SDK will disable the upstream video and enable audio only when the network conditions deteriorate and cannot support both video and audio streams.

<div class="alert note">Agora does not recommend using this method for CDN live streaming, because the remote CDN live user will have a noticeable lag when the locally published video stream falls back to `audio only`.</div>
	
When the local video stream falls back to audio only or when the audio-only stream switches back to the video, the SDK triggers the `OnLocalPublishFallbackToAudioOnlyHandler` callback to report current stream state to the local publisher.
3. The subscriber in the channel calls the `SetRemoteSubscribeFallbackOption` method to set the subscribed stream fallback under poor network conditions.
	- Sets `STREAM_LOW (1)` to only subscribe to the low-video stream sent from the publisher under poor network conditions.
	- Sets `AUDIO_ONLY (2)` to subscribe to the low-video stream sent or even audio stream from the publisher under poor network conditions.
	
	Once the remote media stream is switched to the low stream due to poor network conditions, you can monitor the stream change between a high and low stream in the `OnRemoteVideoStatsHandler` callback. When the remotely subscribed video stream falls back to audio only or when the audio-only stream switches back to the video stream, the SDK triggers the `OnRemoteSubscribeFallbackToAudioOnlyHandler` callback. 


### Sample code

```C#
// Enables the dual-stream mode (Configuration for the local).
mRtcEngine.EnableDualStreamMode(true);

// Configuration for the publisher. When the network condition is poor, send audio only. 
mRtcEngine.SetLocalPublishFallbackOption(STREAM_FALLBACK_OPTIONS.STREAM_FALLBACK_OPTION_AUDIO_ONLY);

// Configuration for the subscriber. Try to receive low stream under poor network conditions. When the current network conditions are not sufficient for video streams, receive audio stream only.    
mRtcEngine.SetRemoteSubscribeFallbackOption(STREAM_FALLBACK_OPTIONS.STREAM_FALLBACK_OPTION_AUDIO_ONLY);
```

### API reference

- [`EnableDualStreamMode`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a2ed16751006195361282bf82edbeccde)
- [`SetLocalPublishFallbackOption`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ad4e6fc7e4f6d226a729af6cd98f049bb)
- [`SetRemoteSubscribeFallbackOption`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ae8c98153bac5c94f05cd08ccf9c1cceb)
- [`OnLocalPublishFallbackToAudioOnlyHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a2332869b4b21af5c29939c444ffc106a)
- [`OnRemoteSubscribeFallbackToAudioOnlyHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a1579ffe847479f2a4963ec2cdb670df1)
- [`OnRemoteVideoStatsHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a4a0e9e6402f4e279446a0e048423e30d)