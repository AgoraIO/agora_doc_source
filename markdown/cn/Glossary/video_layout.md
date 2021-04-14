---
title: 合流布局 (video layout)
platform: All Platforms
updatedAt: 2020-07-03 18:18:03
---
合流布局，指将多个用户的音视频流混合为一路音视频流时，频道内各用户画面的大小及其在视频画布上的位置。有时也称作**合图布局**。推流到 CDN 中的合流转码，以及云端录制和本地服务端录制的合流录制，都涉及到多个视频流混合为一路视频流的过程。

我们将视频的背景称为**画布**，每个用户的视频占据一个**画面**。下图展示了视频画布和用户画面之间的关系。

![img](https://web-cdn.agora.io/docs-files/1562906845265)

在使用云端录制、本地服务端录制，以及 Agora RTC SDK 的推流到 CDN 功能时，都有可能需要设置合流布局。

- 录制：使用本地服务端录制或云端录制进行合流录制时，开发者可以选择三种预设的合流布局：悬浮布局、自适应布局和垂直布局。开发者也可以选择自定义合流布局，灵活设置用户画面的大小和在视频画布上的相对位置。

- 推流到 CDN：推流到 CDN 的过程中，当频道中有多个主播，通常需要通过转码将多个主播的音视频流组合成单个流。开发者需要通过设置每个主播的视频参数来设置合流布局。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/cloud-recording/cloud_recording_layout">合流布局</a>（云端录制）</li><li><a href="https://docs.agora.io/cn/Recording/recording_layout">合流布局</a>（本地服务端录制）</li><li><a href="https://docs.agora.io/cn/Audio%20Broadcast/cdn_streaming_apple">推流到 CDN</a></li></div>

<a href="./terms"><button>返回术语库</button></a>