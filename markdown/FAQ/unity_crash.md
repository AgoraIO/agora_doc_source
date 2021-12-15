---
title: 如何处理 v3.0.1 及之前的 Unity SDK 崩溃问题
platform: ["Unity"]
updatedAt: 2021-01-05 03:18:26
Products: ["Voice", "Video", "Interactive Broadcast", "live-streaming"]
---

## 问题描述

使用 v3.0.1 及之前的 Unity SDK 时，如果不授予摄像头或麦克风权限，app 会出现白屏甚至崩溃。这个问题在 macOS 上出现频繁，在 Android 上也有偶现。

## 问题原因

这个问题是由于没有正确授予摄像头或麦克风权限导致的。在 macOS 上，由于 Apple 自 macOS 10.14 起实行了更为严格的隐私保护政策，未授予权限会直接导致 app 崩溃。SDK 本身不会检测用户是否授予了权限。

## 解决方案

这个问题可以通过手动添加权限解决。在你的 **Unity Editor** 中，点击 **File** -> **Build Settings** -> **Player Settings**，在 **Player** 界面点击 **Other Settings**，然后添加 **Camera Usage Description** 和 **Microphone Usage Description** 的描述，设置摄像头和麦克风的使用权限。
