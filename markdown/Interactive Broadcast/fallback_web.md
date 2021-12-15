---
title: 视频流回退
platform: Web
updatedAt: 2020-12-30 09:01:52
---

## 功能描述

网络不理想的环境下，音视频的质量都会下降。Agora 支持视频流回退，在网络条件差、无法同时保证音视频质量的情况下，SDK 会自动将视频流从大流切换为小流，或将媒体流回退为音频流，从而确保音频质量。

## 实现方法

在实现视频流回退机制前，请确保已在你的项目中实现基本的音视频功能。详见[开始互动直播](start_live_web)或[开始音视频通话](start_call_web)。

参考如下步骤，在你的项目中实现视频流回退功能：

1. 发送端调用 `Client.enableDualStream` 方法开启[双流模式](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#dual-stream)。

2. 接收端调用 `Client.setStreamFallbackOption` 方法设置弱网环境下接收媒体流的回退选项。

   - `fallbackType` 设为 `1`，则下行网络较弱时，只接收发流用户的视频小流。
   - `fallbackType` 设为 `2`，则下行网络较弱时，先尝试只接收发流用户的视频小流。如果网络环境无法显示视频，则只接收发流用户的音频流。

用户接收到的流从音视频流切换到音频流，或从音频流切换到音视频流时，SDK 会触发 `Client.on("stream-fallback")` 回调，该用户可以了解当前接收流的状态。当接收到的视频流从大流切换到小流，或从小流切换到大流时，SDK 会触发 `Client.on("stream-type-changed")` 回调，帮助了解当前接收到的视频流类型。

### 示例代码

```javascript
// 发送端开启视频双流模式。
client.enableDualStream(
  function () {
    console.log("Enable dual stream success!");
  },
  function (err) {
    console.log(err);
  },
);

// 接收端的配置。弱网环境下先尝试接收小流；若当前网络环境无法显示视频，则只接收音频流。
client.setStreamFallbackOption(remoteStream, 2);
```

### API 参考

- [`enableDualStream`](./API%20Reference/web/interfaces/agorartc.client.html#enabledualstream)
- [`setStreamFallbackOption`](./API%20Reference/web/interfaces/agorartc.client.html#setstreamfallbackoption)

### 开发注意事项

- 建议不要对双流进行 track 操作（包括 [addTrack](./API%20Reference/web/interfaces/agorartc.stream.html#addtrack)/[removeTrack](./API%20Reference/web/interfaces/agorartc.stream.html#removetrack)/[replaceTrack](./API%20Reference/web/interfaces/agorartc.stream.html#replacetrack)），否则会导致大流和小流的表现不一致。
- 以下场景不支持双流模式：
  - 纯音频流。
  - Safari 浏览器。
  - 共享屏幕的场景。
