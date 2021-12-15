---
title: Agora Web SDK 如何与 Agora Native SDK 互通？
platform: ["Android", "iOS", "macOS", "Web", "Windows"]
updatedAt: 2020-07-09 21:07:04
Products: ["Voice", "Video", "Interactive Broadcast", "live-streaming"]
---

对于 v3.0.0 及以上版本的 RTC Native SDK，与 Web SDK 的互通是默认打开的，无需设置。

而 v3.0.0 之前的 SDK，通信场景下，Web SDK 和 Native SDK 默认互通，无需额外设置。在直播场景下，移动端/桌面端和 Web 端必须同时手动设置，才能实现互通：

- 移动端/桌面端：调用 `enableWebSdkInteroperability` API 方法。

  ```java
  // java
  // 移动端调用 enableWebSdkInteroperability 方法开启与 Web SDK 的互通
  rtcEngine.enableWebSdkInteroperability(true);
  ```

  ```swift
  // swift
  // 移动端/桌面端调用 enableWebSdkInteroperability 方法开启与 Web SDK 的互通
  agoraKit.enableWebSdkInteroperability(true)
  ```

  ```objective-c
  // objective-c
  // 移动端/桌面端调用 enableWebSdkInteroperability 方法开启与 Web SDK 的互通
  [agoraKit enableWebSdkInteroperability: YES];
  ```

  ```cpp
  // cpp
  // 桌面端调用 enableWebSdkInteroperability 方法开启与 Web SDK 的互通
  lpAgoraEngine->enableWebSdkInteroperability
  ```

- Web 端：将 `createClient` 方法中的 `mode` 设置为 `'live'` 实现互通。

  ```javascript
  // javascript
  // Web 端在创建客户端时，选择正确的 mode 和 codec 参数
  var client = AgoraRTC.createClient({mode: "live", codec: "h264"});
  ```

<div class="alert note">根据已知经验，如果场景中有 Safari 浏览器，则建议在 Web 端将 <code>codec</code> 设为 <code>h264</code>；如果没有，则建议设为 <code>vp8</code>。</div>
