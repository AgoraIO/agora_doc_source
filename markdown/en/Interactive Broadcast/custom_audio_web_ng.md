---
title: Custom Audio Source
platform: Web
updatedAt: 2020-12-30 09:08:47
---
<div class="alert note">This article only applies to the Agora Web SDK 4.x. If you use the Web SDK 3.x or earlier versions, see <a href="./custom_audio_web?platform=Web">Custom Audio Source</a>.</li></div>

## Introduction

The Agora Web SDK uses the default audio module for sampling and rendering in real-time communications.

However, the default module may not meet your requirements, such as in the following situations:

- Your app already has an audio module.
- You want to use a non-microphone source.
- You need to process the sampled audio with a pre-processing library for functions such as voice changer.

This article describes how to use the Agora Web SDK to customize audio source.

## Implementation

Before proceeding, ensure that you have read the quickstart guides and implemented basic real-time audio and video functions in your project.

The SDK provides the `createCustomAudioTrack` method to support creating an audio track from a [`MediaStreamTrack`](https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamTrack) object. You can use this method to customize audio source.

For example, call `getUserMedia` to get a `MediaStreamTrack` object, and then pass this object to `createCustomAudioTrack` to create a customized audio track.

```js
navigator.mediaDevices.getUserMedia({ video: false, audio: true })
  .then((mediaStream) => {
    const audioMediaStreamTrack = mediaStream.getAudioTracks()[0];
    // create custom audio track
    return AgoraRTC.createCustomAudioTrack({
      mediaStreamTrack: audioMediaStreamTrack,
    });
  })
  .then((localAudioTrack) => {
    // ...
  });
```

> `MediaStreamTrack` refers to the `MediaStreamTrack` object supported by the browser. See [MediaStreamTrack API](https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamTrack) for details.

Alternatively, use the [Web Audio API](https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API) to get the `MediaStreamTrack` object for customization.

### API reference

- [`createCustomAudioTrack`](./API%20Reference/web/v4.2.1/interfaces/iagorartc.html#createcustomaudiotrack)
- [`LocalAudioTrack`](./API%20Reference/web/v4.2.1/interfaces/ilocalaudiotrack.html)
