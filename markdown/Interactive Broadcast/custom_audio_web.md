---
title: 自定义音频采集
platform: Web
updatedAt: 2020-12-30 09:01:55
---
## 功能介绍

实时音视频传输过程中，Agora SDK 通常会启动默认的音视频模块进行采集和渲染。在以下场景中，你可能会发现默认的音视频模块无法满足开发需求：

- app 中已有自己的音频或视频模块
- 希望使用非 Camera 采集的视频源，如录屏数据
- 需要使用自定义的美颜库或有前处理库
- 某些视频采集设备被系统独占。为避免与其它业务产生冲突，需要灵活的设备管理策略

本文介绍如何使用 Agora Web SDK 在项目中实现自定义的音频采集。

## 实现方法

在开始自定义音频采集前，请确保你已在项目中实现了基本的音视频通话或直播功能，详见[开始音视频通话](start_call_web)或[开始互动直播](start_live_web)。

在创建音频流 `createStream` 时，通过  [`audioSource`](./API%20Reference/web/interfaces/agorartc.streamspec.html#audiosource) 指定自定义的音频源，就可以实现自定义音频采集。例如，你可以通过 `mediaStream` 方法从 `MediaStreamTrack` 获得音频 track，然后指定 `audioSource`：

```javascript
navigator.mediaDevices.getUserMedia(
    {video: false, audio: true}
).then(function(mediaStream){
    var audioSource = mediaStream.getAudioTracks()[0];
    // After processing audioSource
    var localStream = AgoraRTC.createStream({
        video: false,
        audio: true,
        audioSource: audioSource
    });
    localStream.init(function(){
        client.publish(localStream, function(e){
            //...
        });
    });
});
```

<div class="alert info"><code>MediaStreamTrack</code> 对象是指浏览器原生支持的 <code>MediaStreamTrack</code> 对象，具体用法和浏览器支持状况请参考 <a href="https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamTrack">MediaStreamTrack API 说明</a>。</div>

同时，我们在 GitHub 提供一个开源的 [AgoraAudioIO-Web-Webpack](https://github.com/AgoraIO/Advanced-Audio/tree/master/Web/AgoraAudioIO-Web-Webpack) 示例项目。你可以下载体验，或查看 [rtc-client.js](https://github.com/AgoraIO/Advanced-Audio/blob/master/Web/AgoraAudioIO-Web-Webpack/src/rtc-client.js) 文件中的源代码。

## 开发注意事项

自定义音频采集功能目前仅支持 Chrome 浏览器。