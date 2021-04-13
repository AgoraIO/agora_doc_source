---
title: 流回退 (stream fallback)
platform: All Platforms
updatedAt: 2020-07-03 20:42:36
---
在多人实时音视频场景中，如果网络环境不理想，无法同时保证音频和视频的质量，实时音视频的质量就会下降。为保证通信或直播不受影响，发送端和接收端可以启用流回退的功能，设置弱网下音视频流回退为音频流，或视频由大流回退为小流，以保证或提高音频质量。

当网络环境改善时，回退的音频流或视频小流又可以恢复为原来的音视频流或视频大流。

<div class="alert info">相关链接：<li><a href="#dual-stream">双流模式</a></li><li><a href="#high-stream">大流</a></li><li><a href="#low-stream">小流</a></li><li><a href="https://docs.agora.io/cn/Interactive%20Broadcast/fallback_android?platform=Android">视频流回退</a></li></div>

<a href="./terms"><button>返回术语库</button></a>