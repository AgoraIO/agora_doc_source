---
title: 双流模式 (dual-stream mode)
platform: All Platforms
updatedAt: 2020-11-05 16:00:36
---
实时音视频互动过程中，Agora 需要将发布的视频流传输给订阅了这路视频流的用户。发布一路视频流，就会传输一路视频流。

双流模式下，SDK 在发送一路视频流的同时，会自动额外发送一路低分辨率、低码率的视频流。其中，原视频流分辨率更大、码率更高，称为视频大流；更模糊、尺寸更小的视频流称为小流。

订阅视频小流可以降低带宽占用、提升流畅，因此在网络环境不稳定，或频道内发流用户较多的场景下，你可以设置接收小流。

大流与小流的关系如下：

- SDK 根据大流的视频属性自动设置小流的默认视频属性
- 小流的宽高比例默认与大流的宽高比例一致

<div class="alert info">相关链接：<li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/multi_user_video?platform=All%20Platforms">多人视频场景</a></li>
<li><a href="#fallback">流回退</a></li>
<li><a href="#high-stream">大流</a></li>
<li><a href="#low-stream">小流</a></li>
</div>

<a href="./terms"><button>返回术语库</button></a>