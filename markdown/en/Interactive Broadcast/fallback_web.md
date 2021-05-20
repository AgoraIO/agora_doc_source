---
title: Video Stream Fallback
platform: Web
updatedAt: 2021-01-05 06:17:50
---
## Introduction

Unstable network affects the audio and video quality in a video call or a live broadcast. To ensure smooth communication under poor network conditions, Agora supports video stream fallback. When the network condition deteriorates, the SDK automatically switches from the high-quality video stream to the low-quality video stream, or disables the video to ensure the audio quality under extremely poor network conditions.


## Implementation

Before proceeding, ensure that you have implemented live interactive video streaming or a video call in your project. See [Start a Live Broadcast](start_live_web) or [Start a Call](start_call_web) for details.

Follow these steps to enable video stream fallback:

1. Call `enableDualStreamMode` to enable [dual-stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#dual-steram) for the senders.
	
2. Call `Client.setStreamFallbackOption` to set the stream fallback option for the receivers.
	- Set `fallbackType` as `1` : Automatically subscribe to the low-quality video stream under poor network conditions.
	- Set `fallbackType` as `2` : Subscribe to the low-quality video stream when the network conditions worsen, and subscribe to audio only when the conditions become too poor to support video transmission.


You can monitor the switch between the audio-and-video stream and the audio-only stream by the `Client.on("stream-fallback")` callback; monitor the switch between the low-quality video stream and high-quality video stream by the `Client.on("stream-type-changed")` callback.

### Sample code

```javascript
// Enable dual-stream mode for the sender.
client.enableDualStream(function () {
  console.log("Enable dual stream success!");
}, function (err) {
  console.log(err);
});

// Configuration for the receiver. When the network condition is poor, receive audio only. 
client.setStreamFallbackOption(remoteStream, 2);
```

### API reference

- [`enableDualStream`](./API%20Reference/web/interfaces/agorartc.client.html#enabledualstream)
- [`setStreamFallbackOption`](./API%20Reference/web/interfaces/agorartc.client.html#setstreamfallbackoption)

## Considerations

- We do not recommend using the track methods ([addTrack](./API%20Reference/web/interfaces/agorartc.stream.html#addtrack)/[removeTrack](./API%20Reference/web/interfaces/agorartc.stream.html#removetrack)/[replaceTrack](./API%20Reference/web/interfaces/agorartc.stream.html#replacetrack)) on dual streams, which may cause different performance in the high-quality and low-quality video streams.

- The following scenarios do not support dual-stream mode:
  - Audio-only streams.
  - The Safari browser.
  - Screen-sharing.