---
title: Video Stream Fallback
platform: Android
updatedAt: 2020-11-16 04:20:24
---
## Introduction
The audio and video quality of a live broadcast or a video call deteriorates under poor network conditions. To improve the efficiency of a live broadcast or a video call, the `setLocalPublishFallbackOption` and `setRemoteSubscribeFallbackOption` methods are used for the SDK to automatically disable the video stream when the network conditions cannot support both audio and video, and re-enable the video when the network conditions improve. The `onLocalPublishFallbackToAudioOnly` or `onRemoteSubscribeFallbackToAudioOnly` callback is triggered when the stream falls back to audio-only or when the stream switches back to the video.

## Implementation

```Java
    // Enable the dual-stream mode.
    rtcEngine.enableDualStreamMode(true);

    // Configuration for the publisher.
    // When the network condition is poor, send the audio stream only. 
    rtcEngine.setLocalPublishFallbackOption(Constants.STREAM_FALLBACK_OPTION_AUDIO_ONLY);

    // Configuration for the subscriber.
    // Try to receive the low-stream video under poor network conditions. When the network condition is not good for the video stream, receive the audio stream only. 
    rtcEngine.setRemoteSubscribeFallbackOption(Constants.STREAM_FALLBACK_OPTION_AUDIO_ONLY);

    // To switch between the remote high-stream and low-stream video:
    // Switch the remote video stream with a specified uid to a low stream. 
    // Note that you have to set the remote stream to dual-stream mode before receiving the low stream. 
    rtcEngine.setRemoteVideoStreamType(uid, Constants.VIDEO_STREAM_LOW);
```

### API References
* [`enableDualStreamMode`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a645cb7d0f3a59dda27b157cf130c8c9a)
* [`setLocalPublishFallbackOption`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#ac8c08e79844a4e62e0670553484cbe90)
* [`setRemoteSubscribeFallbackOption`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af64301ea1788dad0561aa678f3fe6ad3)
* [`setRemoteVideoStreamType`](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a51756b4d2e7997fbe6481d2deb5c0396)


