---
title: 设置视频属性
platform: Web
updatedAt: 2020-12-30 09:01:58
---

<div class="alert note">本文仅适用于 Agora Web SDK 3.x 及之前版本。如果你使用 Web SDK 4.x，请查看<a href="./video_profile_web_ng?platform=Web">设置视频属性</a>。</div>

## 功能简介

在视频通话或互动直播中设置视频属性，可以根据用户喜好，调整视频画面的清晰度和流畅度，获得较高的用户体验。

Agora Web SDK 提供 `setVideoProfile` 和 `setVideoEncoderConfiguration` 两个方法支持设置视频属性。你可以根据实际场景需求，选择任一方法进行实现。这两个方法的区别在于：

- `setVideoEncoderConfiguration`： 灵活设置视频属性的各参数值。
- `setVideoProfile`：指定一个 Profile，每个 Profile 对应一套固定的分辨率、码率和帧率。

## 实现方法

在设置视频属性前，请确保你已在项目中实现基本的实时音视频功能。详见[开始音视频通话](start_call_web)或[开始互动直播](start_live_web)。

调用 `createStream` 方法创建音视频流对象后，你就可以在需要时调用 `setVideoProfile` 或 `setVideoEncoderConfiguration` 方法来设置视频属性，并在该方法中设置你想要的分辨率、帧率、码率、方向等参数。

### API 调用时序

参考下图在你的项目中设置视频属性：

![](https://web-cdn.agora.io/docs-files/1568876448537)

**Note:**

- 如果希望优先保证流畅度，建议使用 `setVideoProfile` 设置视频分辨率，Agora 会自适应调整码率；如果希望优先保证清晰度，建议使用 `setVideoEncoderConfiguration`，将 `bitrate` 属性中 `min` 的值设为参考表里码率的 0.4 到 0.5。
- `Stream.setVideoProfile` 方法一般在 `Stream.init` 之前调用。从 v2.7.0 开始，你也可以在 `Stream.init` 成功后调用本方法修改视频属性。
- `Stream.setVideoEncoderConfiguration` 方法在 `Stream.init` 方法前后均可调用。但有如下限制：

  - 该方法支持 Chrome 63 及以上版本。其他浏览器对该方法的支持不完整。已知问题包括 Safari 12 及以下版本对帧率的设置不生效；Safari 11 及以下版本只支持特定分辨率等。
  - 该方法中设置的各参数均为理想情况下的最大值。
  - 实际的视频分辨率宽高、帧率的取值范围与使用的设备有关。详细信息请参考 [MediaStreamTrack.applyConstraints()](https://developer.mozilla.org/zh-CN/docs/Web/API/MediaStreamTrack/applyConstraints)。

### 示例代码

```javascript
// 使用 setVideoEncoderConfiguration 设置视频属性
stream.setVideoEncoderConfiguration({
  // 视频分辨率
  resolution: {
    width: 640,
    height: 480,
  },
  // 视频编码帧率。通常建议是 15 帧，不超过 30 帧
  frameRate: {
    min: 15,
    max: 30,
  },
  // 码率。我们建议参考下面的视频属性参考表进行设置
  bitrate: {
    min: 1000,
    max: 5000,
  },
});

// 使用 setVideoProfile 设置视频属性
// 设置视频属性为 480p_3，对应分辨率 480 x 480，帧率 15， 码率 400
localStream.setVideoProfile("480p_3");
```

同时，我们在 GitHub 提供一个开源的 Agora-Web-Tutorial-1to1-Webpack 示例项目，你可以前往下载，或参考 [rtc-client.js](https://github.com/AgoraIO/Basic-Video-Call/blob/master/One-to-One-Video/Agora-Web-Tutorial-1to1-Webpack/src/rtc-client.js) 文件中 setVideoProfile 方法的源代码。

### API 参考

- [`setVideoEncoderConfiguration`](./API%20Reference/web/v3.3.1/interfaces/agorartc.stream.html#setvideoencoderconfiguration)
- [`setVideoProfile`](./API%20Reference/web/v3.3.1/interfaces/agorartc.stream.html#setvideoprofile)

## 开发注意事项

- 不同的浏览器对分辨率的支持可能不同，具体的支持情况可以在[这里](./API%20Reference/web/v3.3.1/interfaces/agorartc.stream.html#setvideoprofile)查看。
- 由于设备和浏览器的限制，部分浏览器对设置的 Video Profile 不一定能全部适配。这种情况下浏览器会自动调整分辨率，计费也将按照实际分辨率计算。
- 视频能否达到 1080P 以上的分辨率取决于设备的性能，在性能配备较低的设备上有可能无法实现。如果采用 720P 分辨率而设备性能跟不上，则有可能出现帧率过低的情况。
- Safari 浏览器视频帧率为 30 fps，不支持自定义视频帧率。
- 动态修改视频属性仅支持 Chrome 63 及以上版本和 Safari 11 及以上版本。在部分 iOS 设备上动态修改视频属性可能会导致视频出现黑边。
- 请避免在发布流时调用这两个方法。

## 常用分辨率、帧率和码率

通常来讲，视频参数的选择要根据产品实际情况来确定，比如，如果是 1 对 1，老师和学生的窗口比较大，要求分辨率会高一点，随之帧率和码率也要高一点；如果是 1 对 4， 老师和学生的窗口都比较小，分辨率可以低一点，对应的码率帧率也会低一点，以减少编解码的资源消耗和缓解下行带宽压力。一般可按下列场景中的推荐值进行设置。

- 双人视频通话场景：
  - 分辨率 320 x 240、帧率 15 fps、码率 200 Kbps
  - 分辨率 640 x 360、帧率 15 fps、码率 400 Kbps
- 多人视频通话场景：
  - 分辨率 160 x 120、帧率 15 fps、码率 65 Kbps
  - 分辨率 320 x 180、帧率 15 fps、码率 140 Kbps
  - 分辨率 320 x 240、帧率 15 fps、码率 200 Kbps

如果你希望通过调用 `setVideoEncoderConfiguration` 方法自定义视频参数，也可以参考下表对各参数进行自定义设置。

| 视频属性 | 分辨率（宽 × 高） | 帧率（fps） | 码率（Kbps） |
| -------- | ----------------- | ----------- | ------------ |
| 120p_1   | 160 × 120         | 15          | 65           |
| 120p_3   | 120 × 120         | 15          | 50           |
| 180p_1   | 320 × 180         | 15          | 140          |
| 180p_3   | 180 × 180         | 15          | 100          |
| 180p_4   | 240 × 180         | 15          | 120          |
| 240p_1   | 320 × 240         | 15          | 200          |
| 240p_3   | 240 × 240         | 15          | 140          |
| 240p_4   | 424 × 240         | 15          | 220          |
| 360p_1   | 640 × 360         | 15          | 400          |
| 360p_3   | 360 × 360         | 15          | 260          |
| 360p_4   | 640 × 360         | 30          | 600          |
| 360p_6   | 360 × 360         | 30          | 400          |
| 360p_7   | 480 × 360         | 15          | 320          |
| 360p_8   | 480 × 360         | 30          | 490          |
| 360p_9   | 640 × 360         | 15          | 800          |
| 360p_10  | 640 × 360         | 24          | 800          |
| 360p_11  | 640 × 360         | 24          | 1000         |
| 480p_1   | 640 × 480         | 15          | 500          |
| 480p_2   | 640 × 480         | 30          | 1000         |
| 480p_3   | 480 × 480         | 15          | 400          |
| 480p_4   | 640 × 480         | 30          | 750          |
| 480p_6   | 480 × 480         | 30          | 600          |
| 480p_8   | 848 × 480         | 15          | 610          |
| 480p_9   | 848 × 480         | 30          | 930          |
| 480p_10  | 640 × 480         | 10          | 400          |
| 720p_1   | 1280 × 720        | 15          | 1130         |
| 720p_2   | 1280 × 720        | 30          | 2000         |
| 720p_3   | 1280 × 720        | 30          | 1710         |
| 720p_5   | 960 × 720         | 15          | 910          |
| 720p_6   | 960 × 720         | 30          | 1380         |
| 1080p_1  | 1920 × 1080       | 15          | 2080         |
| 1080p_2  | 1920 × 1080       | 30          | 3000         |
| 1080p_3  | 1920 × 1080       | 30          | 3150         |
| 1080p_5  | 1920 × 1080       | 60          | 4780         |
| 1440p_1  | 2560 × 1440       | 30          | 4850         |
| 1440p_2  | 2560 × 1440       | 60          | 7350         |
| 4K_1     | 3840 × 2160       | 30          | 8910         |
| 4K_3     | 3840 × 2160       | 60          | 13500        |
