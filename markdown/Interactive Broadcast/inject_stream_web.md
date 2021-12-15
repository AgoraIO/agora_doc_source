---
title: 输入在线媒体流
platform: Web
updatedAt: 2021-02-26 08:19:57
---

## 功能描述

输入在线媒体流功能可以将音视频流作为一个发送端输入正在进行的直播房间。通过将正在播放的音视频输入到直播频道中，主播和观众可以一起收听/观看该媒体流并实时互动。

### 常用场景

- 赛事直播中，主播直接拉比赛的音视频流，实现主播和观众边看比赛边点评的功能。
- 同一直播间内，主播与观众一同欣赏电影、音乐、演出，并实时交流讨论。
- 无人机或网络摄像头直接采集视频，该视频作为在线媒体流输入直播频道中。

### 工作原理

![](https://web-cdn.agora.io/docs-files/1576059223619)

直播频道中的主播通过 Video Inject 服务器将在线媒体流拉到 Agora SD-RTN 中，输入到直播频道内。

- 频道内的连麦主播、普通观众都可以听/看到该媒体流。
- 如果主播开启了 CDN 旁路推流，该媒体流也会被推送到 CDN 上， CDN 观众就可以听/看到这路媒体流。

> - 频道内同一时间只允许输入一个在线媒体流。
> - 支持的编码格式：音频 AAC，视频 H.264。
> - 纯音频流也可作为在线媒体流输入直播频道。
> - 只有主播可以输入/删除在线媒体流，连麦主播、普通观众和 CDN 观众都不可以。

## 实现方法

在实现输入在线媒体流功能前，请确保你已在项目中完成基本的实时音视频功能。详见[开始互动直播](start_live_web)。

参考如下步骤，在你的项目中实现输入在线媒体流功能：

1. 频道内主播调用 `addInjectStreamUrl` 方法向直播频道内导入指定在线媒体流。你也可以修改 config 的参数设置媒体流导入的分辨率、码率和帧率等参数，详见[`InjectStreamConfig`](./API%20Reference/web/interfaces/agorartc.injectstreamconfig.html)。

   > 频道内同一时间只允许输入一个在线媒体流。

   导入媒体流成功后，该媒体流会在直播频道内自动播放，频道内所有用户都会收到 `Client.on("stream-added")` 和 `Client.on("peer-online")` 回调，导入媒体流的主播同时还会收到 `Client.on("streamInjectedStatus")` 回调。

   > 如果导入媒体流失败，查阅 [API 参考](#api)排查问题。

2. 频道内主播调用 `removeInjectStreamUrl` 方法从直播频道内删除指定的已导入在线媒体流。

   删除媒体流成功后，频道内所有用户都会收到 `Client.on("peer-leave")` 和 `Client.on("stream-removed")` 回调。

   > 主播退出频道后，无需再调用 `removeInjectStreamUrl` 接口。

### 示例代码

```javascript
// Javascript
// 导入在线媒体流
var InjectStreamConfig = {
   width: 0,
   height: 0,
   videoGop: 30,
   videoFramerate: 15,
   videoBitrate: 400,
   audioSampleRate: 44100,
   audioChannels: 1,
  });

  Client.addInjectStreamUrl(url, config);

// 删除在线媒体流
Client.removeInjectStreamUrl(url);
```

同时，我们在 Github 提供一个开源的 [Live-Streaming-Injection](https://github.com/AgoraIO/Advanced-Interactive-Broadcasting/tree/master/Live-Streaming-Injection) 示例项目。

<a name="api"></a>

### API 参考

- [`addInjectStreamUrl`](./API%20Reference/web/interfaces/agorartc.client.html#addinjectstreamurl)
- [`removeInjectStreamUrl`](./API%20Reference/web/interfaces/agorartc.client.html#removeinjectstreamurl)
- `streamInjectedStatus`

## 开发注意事项

主播在直播过程中启用输入在线媒体流，观众需要订阅主播才能观看外部视频。
