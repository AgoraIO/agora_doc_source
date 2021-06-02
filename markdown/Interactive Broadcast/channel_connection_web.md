---
title: 频道连接状态管理
platform: Web
updatedAt: 2021-01-25 08:59:31
---
<div class="alert note">本文仅适用于 Agora Web SDK 3.x 及之前版本。</div>

当用户使用 Agora SDK 进行音视频通话或互动直播时，他会有多个 Agora 频道连接状态。本文介绍 Agora 频道如何判断用户在通信的各个阶段处于什么连接状态以及各状态的转变过程。

## 连接状态

为帮助开发者更好地了解和管理用户在频道内的连接状态，Agora Web SDK 从 v2.5.1 起新增 `connection-state-change` 回调。当用户连接状态发生改变时，SDK 会触发该回调，并在回调中明确当前的连接状态和发生状态改变的原因。

该回调下，SDK 有以下连接状态：

- DISCONNECTED(1)：连接断开
- CONNECTING(2)：建立网络连接中
- CONNECTED(3)：网络已连接
- DISCONNECTING(4)：断开网络连接中

下图展示连接状态发生改变的触发时机：

![](https://web-cdn.agora.io/docs-files/1569296695282)

通信过程中，你可以通过调用 `Client.getConnectionState` 方法获取当前的连接状态。

## 断线重连

通信过程中，如果 SDK 因网络等原因，断开与服务器的连接，SDK 会自动开启断线重连机制。

下图展示从用户 UID 1 加入频道，到连接中断，再到连接完全失败过程中，本地及远端用户 UID 2 会收到的回调：

![](https://web-cdn.agora.io/docs-files/1604479301342)

其中：

- T0：SDK 接收到 UID 1 的 `Client.join` 请求。
- T1：UID 1 成功加入频道。加入频道过程中，UID 1 会收到 `Client.on("connection-state-change", CONNECTING)` 回调；加入后收到 `Client.on("connection-state-change", CONNECTED)` 和 `Client.on("connected")` 回调。
- T2：因网间传输延迟，UID 2 感知 UID 1 加入频道约有 100 毫秒的延迟，此时 UID 2 收到 `Client.on("peer-online")` 回调。
- T3：某个时间点 UID 1 调用 `Stream.publish` 发布本地流。
- T4：UID 2 收到 `Client.on("stream-added")` 回调，表示 UID 1 已发布音视频流。UID 2 可以调用 `Stream.subscribe` 方法注册 UID 1 用户的音视频流。
- T5：通信过程中 UID 1 网络发生中断，SDK 开始自动重连。
- T6：如果 UID 2 连续 10 秒没有收到 UID 1 的任何数据，SDK 判断 UID 1 不在发布音视频流，UID 2 会收到 `Client.on("stream-removed")` 回调。同时，SDK 继续尝试重连。
- T7：SDK 自动重连过程中，网络连接状态会先变为 `Client.on("connection-state-change", CONNECTING)`。
- T8：如果服务端连续 10 秒内没有收到 UID 1 的任何数据，SDK 判断 UID 1 掉线，UID 2 会收到 `Client.on("peer-leave")` 回调。同时，SDK 仍旧尝试重连。
- T9：成功重连建立连接后，网络状态会改变为 `Client.on("connection-state-change", CONNECTED)`。
- T10：UID 2 重新收到 UID 1 的 `Client.on("peer-online")`。

## API 参考

- [Client.getConnectionState](./API%20Reference/web/interfaces/agorartc.client.html#getconnectionstate)
- [Client.on](./API%20Reference/web/interfaces/agorartc.client.html#on)("connection-state-change")

## 相关文档

进程被杀时 SDK 会触发的回调，请参考 [FAQ：SDK 对断网、杀进程的处理](https://docs.agora.io/cn/faq/sdk_behavior)。