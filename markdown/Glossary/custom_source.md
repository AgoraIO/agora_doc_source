---
title: 自采集
platform: All Platforms
updatedAt: 2020-07-03 18:36:45
---
自采集，又称自定义采集，是指 app 自行采集音视频数据的过程。启用自采集后，Agora SDK 不采集音视频数据。

Agora SDK 默认会通过系统自带的音视频输入设备采集音视频数据，当 Agora SDK 采集无法满足开发需求时，开发者可以使用自采集方法对音视频数据进行采集。常见的自采集场景如下：

- 视频会议中，主持人需要分享非摄像头采集的录屏数据。
- 需将原始音视频数据传入其他的音视频引擎处理的场景。
- 当系统的采集器被其他业务占用时，为避免音视频服务与其它业务产生冲突，需使用外部音视频输入设备对原始音视频数据进行采集。

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/custom_audio_android?platform=Android">自定义音频采集和渲染</a></li><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/custom_video_android?platform=Android">自定义视频采集和渲染</a></li>
</div>

<a href="./terms"><button>返回术语库</button></a>