---
title: 自定义视频采集和渲染
platform: Web
updatedAt: 2020-12-30 09:01:56
---
## 功能介绍

实时通信过程中，Agora Web SDK 通常会启动浏览器默认的音视频模块进行采集和渲染。如果想要实现自定义音视频采集和渲染，则可以使用自定义的音视频源或渲染器，来进行实现。

**自定义采集和渲染**主要适用于以下场景：

- 当 SDK 内置的音视频源不能满足开发者需求时，比如需要使用自定义的美颜库或前处理库。
- 开发者的 app 中已有自己的音频或视频模块，为了复用代码，也可以自定义音视频源。
- 开发者希望使用非 Camera 采集的视频源，如录屏数据。
- 有些系统独占的视频采集设备，为避免与其他业务产生冲突，需要灵活的设备管理策略。

## 实现方法

在开始自定义采集和渲染前，请确保你已完成环境准备、安装包获取等步骤，详见[集成客户端](./web_prepare)。

### 自定义音视频源

在创建音视频流时，通过  [`audioSource`](./API%20Reference/web/interfaces/agorartc.streamspec.html#audiosource) 和  [`videoSource`](./API%20Reference/web/interfaces/agorartc.streamspec.html#videosource) 指定自定义的音视频源。例如，你可以通过 `mediaStream` 方法从 `MediaStreamTrack` 获得音视频 track，然后指定 `audioSource` 和 `videoSource`，如下所示：

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

> - `MediaStreamTrack` 对象是指浏览器原生支持的 `MediaStreamTrack` 对象，具体用法和浏览器支持状况请参考 [MediaStreamTrack API 说明](https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamTrack)。
> - 目前该功能仅支持 Chrome 浏览器。

### 自定义渲染器

你可以调用 [`Stream.getVideoTrack`](./API%20Reference/web/interfaces/agorartc.stream.html#getvideotrack)  方法，然后将视频 track 导到 canvas 里自己渲染。

我们提供自定义音视频采集和渲染的示例 demo，详见  [Agora Custom Media Device](https://github.com/AgoraIO/Advanced-Video/tree/master/Custom-Media-Device/Agora-Custom-VideoSource-Web)。