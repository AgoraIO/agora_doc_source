---
title: 自定义视频采集
platform: Web
updatedAt: 2020-12-30 09:08:20
---
<div class="alert note">本文仅适用于 Agora Web SDK 4.x 版本。如果你使用的是 Web SDK 3.x 或更早版本，请查看<a href="./custom_video_web?platform=Web">自定义视频采集</a>。</li></div>

## 功能介绍

实时音视频传输过程中，Agora SDK 通常会启动默认的音视频模块进行采集。在以下场景中，你可能会发现默认的音视频模块无法满足开发需求：
- app 中已有自己的音频或视频模块。
- 希望使用非摄像头采集的视频源，比如 Canvas 数据。
- 需要使用自定义的视频前处理库。

本文介绍如何使用 Agora Web SDK 在项目中实现自定义的视频采集。

## 实现方法

开始前，请确保你已参考快速开始在你的项目中实现基本的实时音视频功能。

SDK 提供 `createCustomVideoTrack`，支持通过传入一个 [MediaStreamTrack](https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamTrack) 对象来创建本地视频轨道。

你可以通过获取 `MediaStreamTrack` 对象来实现自定义视频采集或者前处理。例如，你可以自己调用 `getUserMedia` 方法来获取 `MediaStreamTrack`，再通过 `createCustomVideoTrack` 来创建可以在 SDK 中使用的本地视频对象。

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

> `MediaStreamTrack` 对象是指浏览器原生支持的 `MediaStreamTrack` 对象，具体用法和浏览器支持状况请参考 [MediaStreamTrack API 说明](https://developer.mozilla.org/zh-CN/docs/Web/API/MediaStreamTrack)。你也可以利用 [HTMLMediaElement.captureStream](https://developer.mozilla.org/en-US/docs/Web/API/HTMLMediaElement/captureStream) 或 [HTMLCanvasElement.captureStream](https://developer.mozilla.org/en-US/docs/Web/API/HTMLCanvasElement/captureStream) 来获取 `MediaStreamTrack` 对象。

### API 参考
- [createCustomVideoTrack](./API%20Reference/web/v4.2.1/interfaces/iagorartc.html#createcustomvideotrack)
- [LocalVideoTrack](./API%20Reference/web/v4.2.1/interfaces/ilocalvideotrack.html)