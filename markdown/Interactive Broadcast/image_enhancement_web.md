---
title: 美颜
platform: Web
updatedAt: 2020-12-30 09:02:05
---
## 功能描述

在社交娱乐或教育场景中，用户进行视频通话或直播时，常常希望向对方呈现良好的肌肤状态和精神面貌。Agora SDK 提供 API 方法，帮助开发者轻松实现基础美颜功能。用户可以开启美颜开关，调整美白、磨皮、祛痘、红润效果等美颜参数，实现自然的美颜效果。

具体效果可参考下图：

![](https://web-cdn.agora.io/docs-files/1553753110307)

## 实现方法

在实现美颜功能前，请确保已在你的项目中实现基本的实时音视频功能。详见[开始音视频通话](/cn/Video/start_call_web)或[开始互动直播](/cn/Interactive%20Broadcast/start_live_web)。

调用 [`setBeautyEffectOptions`](./API%20Reference/web/interfaces/agorartc.stream.html#setbeautyeffectoptions) 方法设置基础美颜功能。

<div class="alert note">该方法支持以下浏览器：
  <li>Safari 12 及以上版本</li>
<li>Chrome 65 及以上版本</li>
<li>Firefox 70.0.1 及以上版本</li></div>

该方法有 2 个参数：

* `enabled` 代表是否开启美颜功能。
* `options` 代表美颜选项，包含 `lighteningContrastLevel`（明暗对比度）、`lighteningLevel`（亮度）、`smoothnessLevel`（平滑度）、`rednessLevel`（红色度）四个参数，可用来实现美白、磨皮、红润等效果。

### 示例代码

```javascript
stream.setBeautyEffectOptions(true, {
    lighteningContrastLevel: 1,
    lighteningLevel: 0.7,
    smoothnessLevel: 0.5,
    rednessLevel: 0.1
});
```

同时，我们在 GitHub 提供已实现美颜功能的开源示例项目。你可以[在线体验](https://webdemo.agora.io/agora-web-showcase/examples/OpenLive-Web/#/)并参考 [`rtc-client.js`](https://github.com/AgoraIO/Basic-Video-Broadcasting/blob/master/OpenLive-Web/src/rtc-client.js#L82) 文件中的代码。

## 开发注意事项

- 该功能不支持移动端设备。
- 如果开启了双流模式，美颜选项仅对大流生效。
- 开启美颜后如需调用以下方法，必须先调用 `stream.setBeautyEffectOptions(false)` 关闭美颜功能。
 -  `leave`
 - `stop`
 - `removeTrack`
 - `unpublish`
- 美颜处理属于实时计算密集型操作，虽然基于硬件加速机制实现，但处理过程仍然会有较大的 GPU 和 CPU 开销。因此美颜功能的开启会对低端机的性能造成影响，以至于无法达到预期的要求。对于低端机，视频编码设置为 360p 30 fps，720p 15 fps 或更高分辨率时，我们不建议开启美颜。