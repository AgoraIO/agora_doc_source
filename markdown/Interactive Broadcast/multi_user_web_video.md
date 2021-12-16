---
title: 多人视频场景
platform: Web
updatedAt: 2021-01-04 07:50:11
---
<div class="alert note">本文仅适用于 Agora Web SDK 3.x 及之前版本。</div>

## 概述

在视频通话或直播场景中，如果多个用户同时发流，由于设备性能消耗和网络流量的上升，可能带来比较大的体验下降。

本文展示如何使用 Agora RTC SDK 实现多人视频通话或直播，以及相关的集成注意事项。通过合理的集成方式，Agora 可以支持多达 17 人同时发视频流。

多人视频通信或直播场景下，为降低带宽占用、确保通话流畅，Agora 建议所有发流端开启[双流模式](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#dual-stream)，接收端设置 1-N 订阅模式，即订阅一路大流和 N 路小流。

## 实现方法

在实现如下步骤前，请确保已在你的项目中实现基本的实时音视频通信功能。

### 1. 开启双流模式

成功调用 `Stream.init `方法后，各发流端调用 `enableDualStreamMode` 方法开启双流模式。开启后，SDK 会在发送视频流的同时，额外发送一路分辨率低、码率低的视频流。其中，原视频流也称为大流，分辨率和码率更低的那路流则为小流。

对于 v3.1.0 版本及之后的 Web SDK，小流的视频属性默认值固定为分辨率（宽 × 高） 160 × 120，码率 50 Kbps，帧率 15 fps。在 v3.1.0 之前的版本中，SDK 会根据大流的视频属性设置默认的小流视频属性。

### 2. 设置订阅流类型

接收端再调用 `setRemoteVideoStreamType` 方法，将订阅的一路视频流设为大流，其它视频流均设置为小流。

### 3. 手动设置小流视频属性

如果你不想要使用默认的小流视频属性，还可以调用` Client.setLowStreamParameter` 自定义小流参数，防止因小流码率过高而造成带宽压力。

```javascript
switchStream = function (){
  if (highOrLow === 0) {
    highOrLow = 1
    console.log("Set to low");
  }
  else {
    highOrLow = 0
    console.log("Set to high");
  }

  client.setRemoteVideoStreamType(stream, highOrLow);
}
```

* 从 v3.1.0 版本开始，手动设置的小流的宽高比如果和大流不一致，SDK 会自动修改小流的高，以保持宽高比一致。
* 由于不同的浏览器对于视频属性有不同的限制，通过该接口设置的视频参数不一定都会生效。目前发现的未能充分适配的浏览器有 Firefox：在 Firefox 浏览器上，设置帧率不生效。浏览器本身会将帧率固定在 30 fps。

### 4. 发布和订阅流

完成设置后，调用` Client.publish` 方法[发布本地流](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_web?platform=Web#发布本地流)，调用`Client.subscribe`方法[订阅远端流](https://docs.agora.io/cn/Interactive%20Broadcast/start_live_web?platform=Web#订阅远端流)。

## 大小流视频属性对应关系

 <div class="alert note">本节内容仅适用于 v3.1.0 之前版本的 RTC Web SDK。</div>

对于 v3.1.0 之前的版本，SDK 会根据大流的视频属性自动设置小流的视频属性。参考下表了解不同的大流视频属性下对应的小流视频属性。

| 大流视频参数                     | 小流视频参数 |
| :-------------------------------------- | :----------- |
| <ul><li>360P_1</li><li>360P_4</li><li>360P_9</li><li>360P_10</li><li>360P_11</li></ul> | 90P_1     |
|<ul><li>360P_3</li><li>360P_6</li></ul>   | 120P_3   |
|<ul><li>360P_7</li><li>360P_8</li></ul>   | 120P_1     |
|<ul><li> 480P_1</li><li>480P_2</li><li>480P_4</li><li>480P_10</li></ul>    | 120P_1    |
| <ul><li> 480P_3</li><li>480P_6</li></ul>                   | 120P_3      |

各视频属性对应的视频分辨率、帧率和码率请参考 [API 文档](./API%20Reference/web/interfaces/agorartc.stream.html#setvideoprofile)。

## 集成注意事项

- 视频双流不适用于屏幕共享和视频自采集的场景。
- 为保证通信质量，我们建议大流视频分辨率不超过 640 x 480，帧率不超过 15 fps。
- 本文各视频属性参数的单位，如无特别说明，分辨率为 px，帧率为 fps，码率为 Kbps。
- Agora 建议你在界面布局里采用一大多小的窗口布局：大窗口显示大流的画面，小窗口显示小流的画面。
- 如果你手动设置小流视频属性，请确保小流宽高比与大流宽高比一致。