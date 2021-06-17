---
title: 清晰优先和流畅优先
platform: Web
updatedAt: 2021-03-01 04:06:23
---
<div class="alert note">本文仅适用于 Agora Web SDK 4.x 版本。</div>

## 功能描述
声网致力于不断优化视频通话或互动直播中的视频体验，既保证视频画面的流畅，又追求清晰度。但是，弱网环境中，视频画面的清晰度和流畅度往往不可兼得，需要我们在两者之间进行取舍。

不同的场景或产品对视频体验有不同的需求：
- 有些场景，例如进行屏幕共享时，要求视频画面在网络波动时即使卡顿也要尽量保持清晰。
- 有些场景，允许视频画面在网络波动时模糊，但是不能出现卡顿。

基于以上两种不同的需求，Agora Web SDK 对本地视频轨道提供以下两种传输优化策略：
- 清晰优先：
  - SDK 会自动根据你采集分辨率和帧率设定一个最小码率。即使遭遇网络波动，发送码率也不会低于这个值，从而确保清晰的视频画面。
  - 大部分情况下，SDK 不会降低发送分辨率，但是可能会降低帧率。
- 流畅优先：
  - SDK 不会启用最小码率策略。遭遇网络波动时，发送端会降低码率来确保接收端的视频画面不会出现中断和卡顿。
  - 大部分情况下，SDK 不会降低帧率，但是可能会降低发送分辨率。

## 实现方法

在调用 `createCameraVideoTrack`、`createScreenVideoTrack` 或 `createCustomVideoTrack` 方法创建本地视频轨道时，你可以通过设置 `optimizationMode` 参数：
- `"motion"`: 流畅优先。
- `"detail"`: 清晰优先。

如果该参数留空，则使用 SDK 默认的优化策略：
- 对于屏幕共享视频轨道，SDK 默认的优化策略为清晰优先。
- 对于其他两种类型的本地视频轨道，SDK 默认的优化策略为兼顾清晰和流畅，也就是说弱网条件下，帧率和分辨率都会被调整。

在视频通话、视频直播或屏幕共享过程中，你可以调用 `setOptimizationMode` 方法动态调整视频传输模式。例如你想要把屏幕共享内容从演示文稿切换为视频时，你可以将传输优化模式从 `"detail"` 切换为 `"motion"`，确保视频画面在网络波动时不会出现卡顿。

### 示例代码

```js
const videoTrack = await AgoraRTC.createCameraVideoTrack({
  // 使用清晰优先
  optimizationMode: "detail",
});


const videoTrack2 = await AgoraRTC.createCameraVideoTrack({
  // 使用流畅优先
  optimizationMode: "motion",
});

// 使用默认策略
const videoTrack2 = await AgoraRTC.createScreenVideoTrack();
```

### API 参考

- [CameraVideoTrackInitConfig.optimizationMode](./API%20Reference/web/v4.2.1/interfaces/cameravideotrackinitconfig.html#optimizationmode)
- [ScreenVideoTrackInitConfig.optimizationMode](./API%20Reference/web/v4.2.1/interfaces/screenvideotrackinitconfig.html#optimizationmode)
- [CustomVideoTrackInitConfig.optimizationMode](./API%20Reference/web/v4.2.1/interfaces/screenvideotrackinitconfig.html#optimizationmode)