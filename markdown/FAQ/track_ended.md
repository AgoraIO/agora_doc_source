---
title: 如何处理音频或视频轨道停止导致的无声或黑屏？
platform: ["Web"]
updatedAt: 2021-03-19 06:20:32
Products: ["Voice","Video","live-streaming","Interactive Broadcast"]
---
## 问题描述

通话或直播过程中，Web 发送端突然无声或黑屏。查阅日志发现是由音频或视频轨道停止 (Audio Track Ended/Video Track Ended) 导致的。

## 问题原因

轨道停止很可能是由于设备松动、接触不良或拔出。 

## 解决方案

根据你使用的 Web SDK 版本查看解决方案。

### Web 3.x 版本

Web SDK 3.x 不支持热插拔，设备拔出再插入后必须要重新创建流。参考以下步骤在集成中处理音频或视频轨道停止导致的无声或黑屏：

1. 监听 `client.on("audioTrackEnded")` 和 `client.on("videoTrackEnded")` 事件。
2. 当 SDK 触发 `client.on("audioTrackEnded")` 或 `client.on("videoTrackEnded")` 事件后，提示终端用户确认设备是否正常工作，或重新插入设备。
3. 调用 `unpublish` 方法取消发布音视频流。
4. 调用 `createStream` 方法重新创建音视频流对象。

### Web 4.x 版本

Web SDK 4.x 支持热插拔。参考以下步骤在集成中处理音频或视频轨道停止导致的无声或黑屏：

1. 监听 `localTrack.on("track-ended")` 事件。
2. 当 SDK 触发 `localTrack.on("track-ended")` 事件后，提示终端用户确认设备是否正常工作，或重新插入设备。
3. 监听 `AgoraRTC.onMicrophoneChanged` 或 `AgoraRTC.onCameraChanged` 获取设备状态。当设备插入时，调用 `MicrophoneAudioTrack.setDevice` 或 `CameraVideoTrack.setDevice` 切换到新插入的设备。

## 相关链接

- [音视频采集设备热插拔（Web 4.x）](https://docs.agora.io/cn/Interactive%20Broadcast/test_switch_device_web_ng?platform=Web#hot-plugging)