---
title: 在 Chrome 88 浏览器上无法正常发送视频流时如何处理？
platform: ["Web"]
updatedAt: 2021-02-02 11:16:07
Products: ["Voice", "Video", "Interactive Broadcast", "live-streaming", "Audio Broadcast"]
---

## 问题描述

在 macOS 的 Chrome 88 浏览器上使用 Agora Web SDK 时无法正常发送视频流。

## 问题原因

Chrome 88 浏览器在 macOS 上存在缺陷，在硬件加速被人为关闭或硬件加速由于其他原因不可用时，WebRTC 无法正常发送视频流。此缺陷影响 Agora Web SDK 所有版本。受影响的 macOS 系统版本为 Sierra 和 Mojave。详见 [Google 官方说明](https://bugs.chromium.org/p/chromium/issues/detail?id=1168948)。

## 解决方案

Agora 建议在 Google 修复此缺陷之前避免使用 Chrome 88。你可以使用 Chrome 其他版本或者 Agora Web SDK 支持的其他浏览器。
