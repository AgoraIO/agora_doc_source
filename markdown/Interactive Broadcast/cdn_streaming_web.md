---
title: 推流到 CDN
platform: Web
updatedAt: 2021-03-03 08:04:36
---

## 功能描述

将直播媒体流发布到 CDN (Content Delivery Network) 的过程称为 CDN 直播推流。用户无需安装 App 即可通过 Web 浏览器观看直播。

在推流到 CDN 过程中，当频道中有多个主播时，通常会涉及到[转码](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#转码)，将多个直播流组合成单个流，并设置这个流的音视频属性和合图布局。

![](https://web-cdn.agora.io/docs-files/1569396817637)

### 前提条件

请确保已开通 CDN 旁路推流功能，步骤如下：

1. 登录[控制台](https://console.agora.io)，点击左侧导航栏 ![img](https://web-cdn.agora.io/docs-files/1551250582235) 按钮进入**产品用量**页面。
2. 在页面左上角展开下拉列表选择需要开通 CDN 旁路推流的项目，然后点击旁路推流下的**分钟数**。
   ![](https://web-cdn.agora.io/docs-files/1569297956098)
3. 点击**开启旁路推流服务**。
4. 点击**应用** 即可开通旁路推流服务，并得到 500 个最大并发频道数。

<div class="alert note"> 并发频道数 N，指用户可以同时使用 N 路流进行推流转码。</div>

开通成功后，你可以在用量页面看到旁路推流的使用情况。

## 实现方法

在实现推流到 CDN 功能前，请确保你已在项目中完成基本的音视频功能。详见[开始互动直播](start_live_web)。

> CDN 直播暂只支持推 H.264 流，使用该功能前，你需要在开始互动直播中调用 `createClient` 时将 codec 设为 H.264。

参考如下步骤，在你的项目中实现推流到 CDN：

<a name="single"></a>

1. 调用 `Stream.init` 成功后，频道内主播可以调用 `setLiveTranscoing` 方法设置音视频流的直播参数 （`LiveTranscoding`），如分辨率、码率、帧率、水印和背景色位置。如果你需要转码合图，请在 `TranscodingUser` 类中设置每个用户的视频参数，详见[示例代码](#trans)。

   > 如果直播参数（`LiveTranscoding`）有更新，`Client.on("liveTranscodingUpdated")` 回调会被触发并向主播报告更新信息。

2. 频道内主播可以调用 `startLiveStreaming` 方法向 CDN 推流直播中增加指定的一路媒体流。推流地址可以在推流后动态增删。

   > 请通过 `enableTranscoding` 设置是否转码推流。

3. 频道内主播可以调用 `stopLiveStreaming` 方法向 CDN 推流直播中删除指定的一路媒体流。

增加/删除一路媒体流时，SDK 会触发 `Client.on` 下的回调向主播报告当前推流状态。详见 [API 参考](#api)。

<a name="trans"></a>

### 示例代码

```javascript
// CDN 推流参数设置。
var LiveTranscoding = {
  // 用于旁路推流的输出视频流的总宽度 (px)。640 为默认值。width × height 的最小值为 16 × 16。如果推纯音频流，请将 width × height 设为 16 × 16。
  width: 640,
  // 用于旁路推流的输出视频流的总高度 (px)。360 为默认值。width × height 的最小值为 16 × 16。如果推纯音频流，请将 width × height 设为 16 × 16。
  height: 360,
  // 设置推流输出视频的码率 (Kbps)，默认值为 400。
  videoBitrate: 400,
  // 用于旁路推流的输出视频的帧率 (fps)。默认值为 15。取值范围为 [1,30]，Agora 服务器会将高于 30 的帧率设置改为 30。
  videoFramerate: 15,
  audioSampleRate: AgoraRTC.AUDIO_SAMPLE_RATE_48000,
  audioBitrate: 48,
  audioChannels: 1,
  videoGop: 30,
  // 推流输出视频的编码规格。可以设置为 Baseline (66)、Main (77) 或 High (100)。如果设置其他值，Agora 会统一设为默认值 High (100)。
  videoCodecProfile: AgoraRTC.VIDEO_CODEC_PROFILE_HIGH,
  userCount: 1,
  userConfigExtraInfo: {},
  backgroundColor: 0x000000,
  // 分配用户视窗的合图布局。
  transcodingUsers: [
    {
      x: 0,
      y: 0,
      width: 640,
      height: 360,
      zorder: 0,
      alpha: 1.0,
      // 下面的 uid 应和 Client.join 输入的 uid 保持一致。
      uid: 1232,
    },
  ],
};

client.setLiveTranscoding(LiveTranscoding);

// 添加一个推流地址。transcodingEnabled 设置为 true，表示开启转码。如开启，则必须通过 setLiveTranscoding 接口配置 LiveTranscoding 类。单主播模式下，我们不建议使用转码。
client.startLiveStreaming("your RTMP URL", true);

// 删除一个推流地址。
client.stopLiveStreaming("your RTMP URL");
```

同时，我们在 Github 提供一个开源的 [Live-Straming](https://github.com/AgoraIO/Advanced-Interactive-Broadcasting/tree/master/Live-Streaming/Agora-Interactive-Broadcasting-Live-Streaming-Web-Webpack) 示例项目。你可以前往下载，或者参考 [index.js](https://github.com/AgoraIO/Advanced-Interactive-Broadcasting/blob/master/Live-Streaming/Agora-Interactive-Broadcasting-Live-Streaming-Web-Webpack/src/index.js) 和 [rtc-clinet.js](https://github.com/AgoraIO/Advanced-Interactive-Broadcasting/blob/master/Live-Streaming/Agora-Interactive-Broadcasting-Live-Streaming-Web-Webpack/src/rtc-client.js) 的源代码。

<a name="api"></a>

### API 参考

- [`init`](./API%20Reference/web/interfaces/agorartc.stream.html#init)
- [`setLiveTranscoding`](./API%20Reference/web/interfaces/agorartc.client.html#setlivetranscoding)
- [`startLiveStreaming`](./API%20Reference/web/interfaces/agorartc.client.html#startlivestreaming)
- [`stopLiveStreaming`](./API%20Reference/web/interfaces/agorartc.client.html#stoplivestreaming)
- `liveTranscodingUpdated`
- `liveStreamingStarted`
- `liveStreamingFailed`

## 开发注意事项

- 同一频道内最多支持 17 位主播。

- 如果你对单主播不经过转码直接推流，请略过[步骤 1](#single)，直接调用 `startLiveStreaming` 方法并设置 `enableTranscoding (false)` 。

  > 目前只支持向 CDN 推 H.264 流。你需要在 `createClient` 方法中设置 codec 为 H.264。

- 你可以参考[视频分辨率表格](./API%20Reference/web/v2.9.0/interfaces/agorartc.videoencoderconfiguration.html?transId=2.9.0#bitrate)设置 `videoBitrate` 的值。如果设置的码率超出合理范围，Agora 服务器会在合理区间内自动调整码率值。

- 推流转码时，Agora 会收取转码费用。
