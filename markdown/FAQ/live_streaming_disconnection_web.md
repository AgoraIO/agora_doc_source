---
title: 在推流到 CDN 过程中，连接断开后如何处理？
platform: ["Web"]
updatedAt: 2020-12-23 08:11:29
Products: ["Interactive Broadcast", "live-streaming"]
---

<div class="alert note">本文仅适用于 Agora Web SDK 3.x 及之前版本。</div>

[推流到 CDN](https://docs.agora.io/cn/Interactive%20Broadcast/cdn_streaming_web?platform=Web) 是指直播频道里的主播将自己的媒体流发布到 CDN (Content Delivery Network)。

推流时，SDK 会连接到专门用于推流服务的 Agora 服务器。当 SDK 与推流服务器的连接断开时会尝试自动重连。如果重连失败，SDK 会触发连接断开的回调。

根据推流时是否[设置转码](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.client.html#setlivetranscoding)，SDK 连接的推流服务器以及连接断开触发的回调也不一样：

| 是否转码 | 连接断开触发的回调                        |
| -------- | ----------------------------------------- |
| 转码     | `Client.on("mix-streaming-disconnected")` |
| 不转码   | `Client.on("raw-streaming-disconnected")` |

当监听到以上事件时，你可以先调用 [`stopLiveStreaming`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.client.html#stoplivestreaming) 停止所有的推流地址，再依次调用 [`startLiveStreaming`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.client.html#startlivestreaming) 重新开始推流。
