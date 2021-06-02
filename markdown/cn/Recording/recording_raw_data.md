---
title: 获取原始音视频数据
platform: All Platforms
updatedAt: 2021-03-01 06:06:40
---
# 原始音视频数据

Agora 录制 SDK 目前支持单流模式下的原始音视频数据，以及合流模式下音频混音后的原始音频数据。

录制模式与录制内容的设置，详见[使用录制模式](/cn/Recording/recording_mode)。

## 单流模式下录制原始音视频数据

设置参数 isMixingEnabled = 0，即启动单流模式录制。 

你可以根据需要生成的文件类型，选择不同的录制模式：

| **录制内容**        | 参数设置及生成文件                                           |
| ------------------- | ------------------------------------------------------------ |
| 原始音频数据          | <li>`getAudioFrame = 1` : AAC 格式<li>`getAudioFrame = 2` : PCM 格式 |
| 原始视频数据          | <li>`getVideoFrame = 1` : H.264 帧格式<li>`getVideoFrame = 2` : YUV 帧格式<li>`getVideoFrame = 3` : JPG 帧格式<li>`getVideoFrame = 4` : JPG 文件格式 <li>`getVideoFrame = 5` : JPG 文件格式 + MP4 视频文件格式|

> Web 端不支持 H.264 的原始音视频数据，支持 YUV 的原始音视频数据。

## 合流模式下录制原始音视频数据
	
设置参数 isMixingEnabled = 1，即启动合流模式录制。 

Agora 录制 SDK 目前仅支持多个音频流混音后的原始音频数据，并生成 PCM 文件。

| **录制内容**        | 参数设置及生成文件                                           |
| ------------------- | ------------------------------------------------------------ |
| 原始音频数据          | `getAudioFrame = 3` ：PCM 混音格式。 |


