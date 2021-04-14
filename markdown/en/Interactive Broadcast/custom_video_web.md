---
title: Custom Video Source and Renderer
platform: Web
updatedAt: 2021-01-05 06:15:31
---
## Introduction

By default, the Agora SDK uses default audio and video modules for capturing and rendering in real-time communications. 

However, the default modules might not meet your development requirements, such as in the following scenarios:

- Your app has its own audio or video module.
- You want to use a non-camera source, such as recorded screen data.
- You need to process the captured video with a pre-processing library for functions such as image enhancement.
- You need flexible device resource allocation to avoid conflicts with other services.

This article explains how to customize the video source and renderer with the Agora Web SDK.


<div class="alert info">Click the <a href="https://webdemo.agora.io/agora-web-showcase/examples/Agora-Custom-VideoSource-Web/">online demo</a> to try this feature out.</div>

## Implementation

Before customizing the video source and renderer, ensure that you have implemented the basic real-time communication functions. For details, see [Start a Video Call](start_call_web) or [Start Interactive Video Streaming](start_live_web).

### Customize the audio/video source

When creating a stream with the `createStream` method, you can specify customized audio/video sources by the [`audioSource`](./API%20Reference/web/interfaces/agorartc.streamspec.html#audiosource) and [`videoSource`](./API%20Reference/web/interfaces/agorartc.streamspec.html#videosource) properties. 

For example, you can use the `mediaStream` method to get the audio and video tracks from `MediaStreamTrack`, and then set `audioSource` and `videoSource`:

```javascript
navigator.mediaDevices.getUserMedia(
    {video: true, audio: true}
).then(function(mediaStream){
    var videoSource = mediaStream.getVideoTracks()[0];
    var audioSource = mediaStream.getAudioTracks()[0];
    // After processing videoSource and audioSource
    var localStream = AgoraRTC.createStream({
        video: true,
        audio: true,
        videoSource: videoSource,
        audioSource: audioSource
    });
    localStream.init(function(){
        client.publish(localStream, function(e){
            //...
        });
    });
});
```

<div class="alert info"><code>MediaStreamTrack</code> refers to the <code>MediaStreamTrack</code> object supported by the browser. See <a href="https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamTrack">MediaStreamTrack API</a> for details.</div>


### Customize the video renderer

Call the [`Stream.getVideoTrack`](./API%20Reference/web/interfaces/agorartc.stream.html#getvideotrack) method and attach the track to the local canvas.

### Sample code

We provide an open-source [Agora-Custom-VideoSource-Web-Webpack](https://github.com/AgoraIO/Advanced-Video/tree/master/Web/Agora-Custom-VideoSource-Web-Webpack) demo project on GitHub. You can try the demo, or view the source code in the [rtc-client.js](https://github.com/AgoraIO/Advanced-Video/blob/master/Web/Agora-Custom-VideoSource-Web-Webpack/src/rtc-client.js) file.

## Considerations

Customizing the audio and video sources supports the Chrome browser only.