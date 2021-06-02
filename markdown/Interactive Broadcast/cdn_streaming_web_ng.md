---
title: 推流到 CDN
platform: Web
updatedAt: 2021-03-23 10:03:03
---
<div class="alert note">本文仅适用于 Agora Web SDK 4.x 版本。如果你使用的是 Web SDK 3.x 或更早版本，请查看<a href="./cdn_streaming_web?platform=Web">推流到 CDN</a>。</li></div>

## 功能描述

将直播媒体流发布到 CDN (Content Delivery Network) 的过程称为 CDN 直播推流。用户无需安装 App 即可通过 Web 浏览器观看直播。

在推流到 CDN 过程中，当频道中有多个主播时，通常会涉及到[转码](terms#transcoding)，将多个直播流组合成单个流，并设置这个流的音视频属性和合图布局。

<div class="alert note">本服务为收费服务，详见<a href="https://docs.agora.io/cn/Interactive%20Broadcast/faq/client_streaming_billing"> RTMP 推流收费</a>。</div>

![](https://web-cdn.agora.io/docs-files/1588993718649)

## 前提条件

请确保已开通 CDN 旁路推流功能，步骤如下：
1. 登录[控制台](https://console.agora.io)，点击左侧导航栏 ![img](https://web-cdn.agora.io/docs-files/1551250582235) 按钮进入**产品用量**页面。
2. 在页面左上角展开下拉列表选择需要开通 CDN 旁路推流的项目，然后点击旁路推流下的**分钟数**。
![](https://web-cdn.agora.io/docs-files/1569297956098)
<div class="alert note"><b>旁路推流服务</b>仅适用于 Native SDK 2.4.1 及以上版本和 Web SDK 2.9.0 及以上版本，若您使用的版本较低，建议升级至新版本。</div>
3. 点击**开启旁路推流服务**。
4. 点击**应用** 即可开通旁路推流服务，并得到 500 个最大并发频道数。

<div class="alert note"> 并发频道数 N，指用户可以同时使用 N 路流进行推流转码。</div>

开通成功后，你可以在用量页面看到旁路推流的使用情况。

## 实现方法

开始前，请确保你已参考快速开始在你的项目中实现基本的实时音视频功能。

参考如下步骤，在你的项目中实现推流到 CDN：

1. 在发布之前，在主播端调用 `AgoraRTCClient.setLiveTranscoding` 方法设置 CDN 推流的配置，如分辨率、码率、帧率、背景色和水印位置。如果你需要转码合图，请在 `transcodingUsers` 类中设置每个用户的视频参数，详见[示例代码](#示例代码)。

2. 在主播端调用 `AgoraRTCClient.startLiveStreaming` 方法向 CDN 推流直播中增加指定的一路媒体流。推流地址可以在推流后动态增删。你可以通过 `transcodingEnabled` 参数设置是否转码推流。

3. 在主播端调用 `AgoraRTCClient.stopLiveStreaming` 方法向 CDN 推流直播中删除指定的一路媒体流。

4. 通过监听 `AgoraRTCClient.on("live-streaming-error")`/`AgoraRTCClient.on("live-streaming-warning")` 来感知推流中途出现的异常情况

### 示例代码
`client` 是指通过 `AgoraRTC.createClient` 创建的本地客户端对象。

```js
// CDN 推流参数设置。
const LiveTranscoding = {
  // 用于旁路推流的输出视频流的总宽度 (px)。640 为默认值。
  width: 640,
  // 用于旁路推流的输出视频流的总高度 (px)。360 为默认值。
  height: 360,
  // 设置推流输出视频的码率 (Kbps)，默认值为 400。
  videoBitrate: 400,
  // 用于旁路推流的输出视频的帧率 (fps)。默认值为 15。
  videoFramerate: 15,
  audioSampleRate: 48000,
  audioBitrate: 48,
  audioChannels: 1,
  videoGop: 30,
  // 推流输出视频的编码规格。可以设置为 Baseline (66)、Main (77) 或 High (100)。如果设置其他值，Agora 会统一设为默认值 High (100)。
  videoCodecProfile: 100,
  userCount: 1,
  userConfigExtraInfo: "",
  backgroundColor: 0x000000,
  // 设置水印图片（仅支持在线 PNG 文件），只支持一个水印。
  watermark: {
          url: "http://www.com/watermark.png",
          x: 0,
          y: 0,
          width: 160,
          height: 160,
      },
  // 分配用户视窗的合图布局。
  transcodingUsers: [{
          x: 0,
          y: 0,
          width: 640,
          height: 360,
          zOrder: 0,
          alpha: 1.0,
          // 下面的 uid 应和 AgoraRTCClient.join 输入的 uid 保持一致。
          uid: 1232,
        }],
};

// 注意这是一个异步方法，请确保异步操作完成后再进行下一步操作。
client.setLiveTranscoding(LiveTranscoding).then(() => {
  console.log("set live transcoding success");
});

// 添加一个推流地址。transcodingEnabled 设置为 true，表示开启转码。如开启，则必须通过 setLiveTranscoding 接口配置 LiveTranscoding 类。单主播模式下，我们不建议使用转码。
// 注意这是一个异步方法，请确保异步操作完成后再进行下一步操作。
client.startLiveStreaming("your RTMP URL", true).then(() => {
  console.log("start live streaming success");
})

// 删除一个推流地址，停止推流。
// 注意这是一个异步方法，请确保异步操作完成后再进行下一步操作。
client.stopLiveStreaming("your RTMP URL").then(() => {
  console.log("stop live streaming success");
})

// 监听推流中途的错误, 错误码列表可以参考 API 文档
client.on("live-streaming-error", (url, err) => {
  console.log("url", url, "live streaming error!", err.code);
});
```

### API 参考
- [AgoraRTCClient.setLiveTranscoding](./API%20Reference/web_ng/interfaces/iagorartcclient.html#setlivetranscoding)
- [AgoraRTCClient.startLiveStreaming](./API%20Reference/web_ng/interfaces/iagorartcclient.html#startlivestreaming)
- [AgoraRTCClient.stopLiveStreaming](./API%20Reference/web_ng/interfaces/iagorartcclient.html#stoplivestreaming)
- [AgoraRTCClient.on("live-streaming-error")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_live_streaming_error)
- [AgoraRTCClient.on("live-streaming-warning")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_live_streaming_warning)

## 开发注意事项

- 同一频道内最多支持 17 位主播。
- 本服务为收费服务，Agora 按照音视频转码时长来计费。
- Agora 支持向 CDN 推送 RTMP 和 RTMPS 协议的媒体流。其中，RTMPS 协议仅在转码模式下支持。
- 你可以参考[视频分辨率表格](video_profile_web_ng#常用分辨率、帧率和码率)设置 `videoBitrate` 的值。如果设置的码率超出合理范围，Agora 服务器会在合理区间内自动调整码率值。
- 为了避免代码逻辑出错，我们建议你转码推流和非转码推流中使用不同推流地址。
- 如果你对单主播不经过转码直接推流，请略过步骤 1，直接调用 `Client.startLiveStreaming` 方法并将 `enableTranscoding` 参数设置为 `false`。不转码情况下，需要使用 `AgoraRTC.createClient({mode: "live", codec: "h264"})` 模式。