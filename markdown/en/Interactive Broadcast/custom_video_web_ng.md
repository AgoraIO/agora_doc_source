---
title: Custom Video Source
platform: Web
updatedAt: 2020-12-30 09:08:51
---
<div class="alert note">This article only applies to the Agora Web SDK 4.x. If you use the Web SDK 3.x or earlier versions, see <a href="./custom_video_web?platform=Web">Custom Video Source</a>.</li></div>

## Introduction

Typically, the Agora Web SDK uses the default audio and video modules for capturing video in real-time communications.

However, the default modules may not meet your development requirements, such as in the following scenarios:

- Your app has its own audio or video module.
- You want to use a non-camera source, such as the canvas screen data.
- You need to process the captured video with a pre-processing library for functions such as image enhancement.

This article describes how to customize the video source with the Agora Web SDK.

## Implementation

Before proceeding, ensure that you have read the quickstart guides and implemented basic real-time audio and video functions in your project.

The SDK provides `createCustomVideoTrack` to support creating a video track from a [`MediaStreamTrack`](https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamTrack) object. You can use this method to customize the video source.

For example, you can call `getUserMedia` to get a `MediaStreamTrack` object, and then pass this object to `createCustomAudioTrack` to create an audio track to use in the SDK.

```js
navigator.mediaDevices.getUserMedia({ video: true, audio: false })
  .then((mediaStream) => {
    const videoMediaStreamTrack = mediaStream.getVideoTracks()[0];
    // Create a custom video track
    return AgoraRTC.createCustomVideoTrack({
      mediaStreamTrack: videoMediaStreamTrack,
    });
  })
  .then((localVideoTrack) => {
    // ...
  });
```

> `MediaStreamTrack` refers to the `MediaStreamTrack` object supported by the browser. See [MediaStreamTrack API](https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamTrack) for details. You can also call [HTMLMediaElement.captureStream](https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement/captureStream) or [HTMLCanvasElement.captureStream](https://developer.mozilla.org/en-US/docs/Web/API/HTMLCanvasElement/captureStream) to get the `MediaStreamTrack` object.

### API reference
- [`createCustomVideoTrack`](./API%20Reference/web/v4.2.1/interfaces/iagorartc.html#createcustomvideotrack)
- [`LocalVideoTrack`](./API%20Reference/web/v4.2.1/interfaces/ilocalvideotrack.html)

