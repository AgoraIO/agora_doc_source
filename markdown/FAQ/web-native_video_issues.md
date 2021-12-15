---
title: 如何解决 Web 端和 Native 端互通时出现的黑屏、绿屏、花屏等画面异常问题？
platform: ["Web"]
updatedAt: 2021-03-30 03:26:24
Products: ["Video", "Interactive Broadcast", "live-streaming"]
---

## 问题描述

Web 端用户接收 Native 端用户的视频，或者 Native 端用户接收 Web 端用户的视频，接收端看到的画面为黑屏、绿屏、花屏等。

## 问题原因

由于 Native SDK 发送的视频流均为 H.264 编码，该问题主要是解码 H.264 视频流时出现异常导致的。

## 解决方案

按照以下步骤依次排查问题：

1. 调用 `getSupportedCodec` 方法获取 Web SDK 与当前浏览器同时支持的编解码格式。如果不支持 H.264 则无法与 Native 端互通。

2. 建议 Web 端用户使用桌面端 Chrome 浏览器最新正式版本，并按照以下步骤关闭硬件加速编解码：

   1. 在浏览器地址栏输入 `chrome://flags`。
   2. 将 **Hardware-accelerated video decode** 和 **Hardware-accelerated video encode** 均设置为 **Disabled。**
   3. 点击 **Relaunch** 重启浏览器，如下图所示：
      ![](https://web-cdn.agora.io/docs-files/1616748192326)

3. 将 Native SDK 升级至最新版本。

4. 如果发送视频流的用户为 Web 桌面端，可以建议用户尝试使用以下命令行启动 Chrome 浏览器。

   **Windows**

   ```shell
   chrome.exe --forcefieldtrials="WebRTCSpsPpsIdrIsH264Keyframe/Enabled/"
   ```

   **macOS**

   ```shell
   /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --force-fieldtrials="WebRTC-SpsPpsIdrIsH264Keyframe/Enabled/"
   ```

## 相关链接

- [如何处理视频黑屏问题？](https://docs.agora.io/cn/faq/video_blank)
- [为什么我的视频会出现花屏或绿屏？](https://docs.agora.io/cn/faq/pixelated_green_video)
