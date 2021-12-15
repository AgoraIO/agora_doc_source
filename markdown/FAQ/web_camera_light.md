---
title: 为什么网页端禁用自己的视频后摄像头灯还是亮着？
platform: ["Web"]
updatedAt: 2020-04-09 10:51:26
Products: ["Voice", "Video", "Interactive Broadcast"]
---

## 问题描述

使用 Agora RTC Web SDK 时，调用 `muteVideo` 禁用本地视频成功后，摄像头的指示灯仍然亮着。

## 问题原因

Web SDK 不支持单独开启/关闭采集视频，对本地流调用 `muteVideo` 实际上是将 [` MediaStreamTrack.enabled`](https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamTrack/enabled) 属性设为 `false`，调用 `muteVideo` 后仍会发送视频黑帧，并未关闭视频采集，因此摄像头的指示灯不会熄灭。

## 解决方案

调用 `close` 方法关闭本地流可以关闭视频采集，此时摄像头指示灯会熄灭。但是调用 `close` 方法会同时取消摄像头和麦克风的访问权限，即本地的音频和视频采集都会关闭。这是因为 Web SDK 发布的对象是流，包含音频轨道和视频轨道，因此对流的操作会同时影响音频和视频。

如果想要方便快速地关闭本地视频的采集和发送，而不影响音频功能，我们推荐你使用下一代 Agora Web SDK ([Agora Web SDK NG](https://agoraio-community.github.io/AgoraWebSDK-NG/zh-CN/))。在下一代 Web SDK 中，发布的对象是音频轨道和视频轨道，因此可以直接关闭 ([`close`](https://agoraio-community.github.io/AgoraWebSDK-NG/api/cn/interfaces/ilocaltrack.html#close)) 视频轨道来关闭本地视频的采集和发送，这样摄像头的指示灯也会熄灭。
