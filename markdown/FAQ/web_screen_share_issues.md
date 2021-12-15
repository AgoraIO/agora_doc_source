---
title: 如何解决 Web 端屏幕共享的质量问题？
platform: ["Web"]
updatedAt: 2021-03-26 08:58:43
Products: ["Video", "Interactive Broadcast", "live-streaming"]
---

## 问题描述

Web 端用户共享屏幕时，共享画面卡顿、模糊。

## 解决方案

根据你使用的 Web SDK 版本查看解决方案。

### Web 3.x 版本

按照以下步骤依次排查问题：

1. 建议用户使用桌面端 Chrome 浏览器最新正式版本。
2. 在 `createClient` 时将 `codec` 设置为 `vp8`。
3. 确认用户共享的是否为应用窗口。
   - 如果是，建议用户改为共享浏览器标签页或者共享整个屏幕。
   - 如果不是，检查你在 `setScreenProfile` 方法中设置的屏幕编码配置是否正常。
4. 将 SDK 升级至 3.2.0 或之后版本，在创建屏幕共享流时设 `optimizationMode`，根据屏幕共享的内容选择合适的传输优化模式：
   - 如果屏幕共享的内容主要为幻灯片、文字或者静态的图片，将 `optimizationMode` 设置为 `"details"`。
   - 如果屏幕共享的内容主要为视频、游戏等动态画面，将 `optimizationMode` 设置为 `"motion"`。

### Web 4.x 版本

按照以下步骤依次排查问题：

1. 建议用户使用桌面端 Chrome 浏览器最新正式版本。

2. 在 `createClient` 时将 `codec` 设置为 `vp8`。

3. 确认用户共享的是否为应用窗口。

   - 如果是，建议用户改为共享浏览器页签或者共享整个屏幕。
   - 如果不是，检查你在 `createScreenVideoTrack` 方法中设置的屏幕编码配置是否正常。

4. 在创建屏幕共享的视频轨道时设置 `optimizationMode`，根据屏幕共享的内容选择合适的传输优化模式：

   - 如果屏幕共享的内容主要为幻灯片、文字或者静态的图片，将 `optimizationMode` 设置为 `"details"`。
   - 如果屏幕共享的内容主要为视频、游戏等动态画面，将 `optimizationMode` 设置为 `"motion"`。

   <div class="alert info">自 4.2.0 版本起，你还可以通过 <a href="https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web_ng/interfaces/ilocalvideotrack.html#setoptimizationmode">setOptimizaitonMode</a> 方法在屏幕共享过程中动态调整传输优化模式。</div>

## 相关链接

- [屏幕共享（Web 3.x）](https://docs.agora.io/cn/Interactive%20Broadcast/screensharing_web?platform=Web)
- [屏幕共享（Web 4.x）](https://docs.agora.io/cn/Interactive%20Broadcast/screensharing_web_ng?platform=Web)
- [如何切换屏幕共享流和摄像头视频流？](https://docs.agora.io/cn/faq/switch_screen_camera_web)
