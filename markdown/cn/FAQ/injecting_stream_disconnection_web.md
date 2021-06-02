---
title: 在输入在线媒体流过程中，连接断开后如何处理？
platform: ["Web"]
updatedAt: 2021-02-26 08:26:20
Products: ["Interactive Broadcast","live-streaming"]
---
<div class="alert note">客户端输入在线媒体流功能即将停服。如果你尚未集成该功能，Agora 建议你不要使用。详见<a href="https://docs.agora.io/cn/Interactive%20Broadcast/rtc_sunset">部分服务下架计划</a>。</div>

[输入在线媒体流](https://docs.agora.io/cn/Interactive%20Broadcast/inject_stream_web?platform=Web)是指将频道外的在线媒体流输入到正在进行的直播频道中。

输入在线媒体流时，SDK 会连接到专门用于拉取外部媒体流的 Agora 服务器。当 SDK 与拉流服务器的连接断开时会尝试自动重连。如果重连失败，SDK 会触发 `Client.on("inject-streaming-disconnected")` 回调。监听到该事件时，你可以先调用 [`removeInjectStreamUrl`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.client.html#removeinjectstreamurl) 停止拉流，再调用 [`addInjectStreamUrl`](https://docs.agora.io/cn/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.client.html#addinjectstreamurl) 重新开始拉流。