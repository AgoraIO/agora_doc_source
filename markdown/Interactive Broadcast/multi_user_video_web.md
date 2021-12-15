---
title: 多人视频场景
platform: Web
updatedAt: 2021-01-04 08:02:50
---

## 功能描述

在一般的视频直播场景中，如果参与的主播超过七人，可能会引起音画不同步和信息丢失的问题。如果参与连麦的各方将订阅流设置为 1-N 模式，即订阅 1 路大流和 N 路小流，那么直播频道内的主播最多可以支持 17 人。本页为你展示如何使用 Agora SDK 实现七人以上视频互动直播和相关的注意事项。

## 实现方法

在实现七人以上视频场景前，请确保已在你的项目中实现基本的实时音视频功能。详见[开始互动直播](statr_live_web)。

> 目前本功能支持 PC 端，不支持移动端。支持的平台详见[前提条件](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_web?platform=Web#前提条件)。

参考如下步骤，在你的项目中实现七人以上视频场景功能：

1. 调用 `Stream.init` 成功后，频道内主播各方调用 `enableDualStream` 方法开启[双流模式](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-duala双流模式)。

   > 开启双流模式后，SDK 会根据视频大流参数默认设置对应的视频小流参数，详见[大小流对应关系表](#corr)。

2. 频道内主播各方调用 `setRemoteVideoStreamType` 方法将订阅的一路视频流设置为大流，其余路视频流均设置为小流。

   > 大流理论上可以设置为所有支持的视频属性（Video Profile），但建议使用不超过 640x480，15 fps 的视频属性，例如：
   >
   > | **分辨率** | **帧率** | **比特率** |
   > | ---------- | -------- | ---------- |
   > | 640x480    | 15 fps   | 500 Kbps   |
   > | 640x360    | 15 fps   | 400 Kbps   |
   > | 640x360    | 30 fps   | 600 Kbps   |

3. （可选）调用 `Client.setLowStreamParameter` 定制视频小流参数设置。

   > - 小流的分辨率（宽高）比例需要和大流的分辨率（宽高）比例相同。
   > - 由于不同的浏览器对于视频参数设置有不同的限制，通过使用该接口设置的视频参数不一定都会生效。目前发现的未能充分适配的浏览器有 Firefox 浏览器，对其设置帧率不生效，浏览器本身会把帧率固定在 30 fps。

4. [发布本地流](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_web?platform=Web#发布本地流)，[订阅远端流](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_web?platform=Web#订阅远端流)。

### 示例代码

```javascript
//Javascript
// 开启视频双流模式。
client.enableDualStream();

// 将订阅的该路视频流设置为大流/小流。
client.setRemoteVideoStreamType(stream, streamType);

// 定制视频小流参数设置。设置 Video Profile (非必填，SDK 会自动适配一个默认的值) 为 120 (px) × 120 (px), 15 fps, 120 Kbps。
client.setLowStreamParameter({
  width: 120,
  height: 120,
  framerate: 15,
  bitrate: 120,
});
```

同时，我们在 Github 提供一个开源的 [17-Multistream](https://github.com/AgoraIO/Advanced-Video/tree/master/17-Multistream) 示例项目。你可以前往下载，或者参考 [index.js](https://github.com/AgoraIO/Advanced-Video/blob/master/17-Multistream/src/index.js) 和 [rtc-clinet.js](https://github.com/AgoraIO/Advanced-Video/blob/master/17-Multistream/src/rtc-client.js) 的源代码。

### API 参考

- [`enableDualStream`](./API%20Reference/web/interfaces/agorartc.client.html#enabledualstream)
- [`setRemoteVideoStreamType`](./API%20Reference/web/interfaces/agorartc.client.html#setremotevideostreamtype)
- [`setLowStreamParameter`](./API%20Reference/web/interfaces/agorartc.client.html#setlowstreamparameter)

## 开发注意事项

Agora 建议你在界面布局里采用一大多小的窗口布局：大窗口申请大流；小窗口申请小流。

<a name="corr"></a>

## 大小流对应关系表

> 由于各浏览器对小流的适配存在差异，部分浏览器的部分分辨率大小流对应关系可能存在一些偏差。

| **大流参数** | **对应小流参数** |
| ------------ | ---------------- |
| 720P_5       | 120P_1           |
| 720P_6       | 120P_1           |
| 480P         | 120P_1           |
| 480P_1       | 120P_1           |
| 480P_2       | 120P_1           |
| 480P_4       | 120P_1           |
| 480P_10      | 120P_1           |
| 360P_7       | 120P_1           |
| 360P_8       | 120P_1           |
| 240P         | 120P_1           |
| 240P_1       | 120P_1           |
| 180P_4       | 120P_1           |
| 120P_3       | 120P_1           |
| 120P         | 120P_1           |
| 120P_1       | 120P_1           |
| 480P_3       | 120P_3           |
| 480P_6       | 120P_3           |
| 360P_3       | 120P_3           |
| 360P_6       | 120P_3           |
| 240P_3       | 120P_3           |
| 180P_3       | 120P_3           |
| 480P_8       | 120P_4           |
| 480P_9       | 120P_4           |
| 240P_4       | 120P_4           |
| 720P         | 90P_1            |
| 720P_1       | 90P_1            |
| 720P_2       | 90P_1            |
| 720P_3       | 90P_1            |
| 360P         | 90P_1            |
| 360P_1       | 90P_1            |
| 360P_4       | 90P_1            |
| 360P_9       | 90P_1            |
| 360P_10      | 90P_1            |
| 360P_11      | 90P_1            |
| 180P         | 90P_1            |
| 180P_1       | 90P_1            |

其中，各参数对应的属性如下：

| **参数** | **对应分辨率** | **对应帧率** |
| -------- | -------------- | ------------ |
| 90P_1    | 160x90         | 15           |
| 120P     | 160x120        | 15           |
| 120P_1   | 160x120        | 15           |
| 120P_3   | 120x120        | 15           |
| 120P_4   | 212x120        | 15           |
| 180P     | 320x180        | 15           |
| 180P_1   | 320X180        | 15           |
| 180P_3   | 180x180        | 15           |
| 180P_4   | 424x240        | 15           |
| 240P     | 320x240        | 15           |
| 240P_1   | 320X240        | 15           |
| 240P_3   | 240x240        | 15           |
| 240P_4   | 424x240        | 15           |
| 360P     | 640x360        | 15           |
| 360P_1   | 640X360        | 15           |
| 360P_3   | 360x360        | 15           |
| 360P_4   | 640x360        | 30           |
| 360P_6   | 360x360        | 30           |
| 360P_7   | 480x360        | 15           |
| 360P_8   | 480x360        | 30           |
| 360P_9   | 640x360        | 15           |
| 360P_10  | 640x360        | 24           |
| 360P_11  | 640x360        | 24           |
| 480P     | 640x480        | 15           |
| 480P_1   | 640x480        | 15           |
| 480P_2   | 648x480        | 30           |
| 480P_3   | 480x480        | 15           |
| 480P_4   | 640x480        | 30           |
| 480P_6   | 480x480        | 30           |
| 480P_8   | 848x480        | 15           |
| 480P_9   | 848x480        | 30           |
| 480P_10  | 640x480        | 10           |
| 720P     | 1280x720       | 15           |
| 720P_1   | 1280x720       | 15           |
| 720P_2   | 1280x720       | 15           |
| 720P_3   | 1280x720       | 30           |
| 720P_5   | 960x720        | 15           |
| 720P_6   | 960x720        | 30           |
