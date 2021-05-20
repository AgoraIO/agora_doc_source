---
title: 频道连接状态管理
platform: Web
updatedAt: 2021-01-25 08:58:27
---
<div class="alert note">本文仅适用于 Agora Web SDK 4.x 版本。如果你使用的是 Web SDK 3.x 或更早版本，请查看<a href="./channel_connection_web?platform=Web">频道连接状态管理</a>。</li></div>

本文介绍 Agora 频道如何判断用户在通信的各个阶段处于什么连接状态以及各状态的转变过程。

## 频道内的连接状态

为帮助开发者更好地了解和管理用户在频道内的连接状态，Agora Web SDK 提供 [AgoraRTCClient.connectionState](./API%20Reference/web_ng/interfaces/iagorartcclient.html#connectionstate) 字段和 [AgoraRTCClient.on("connection-state-change")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_connection_state_change) 回调帮助你获取当前的连接状态。

当用户连接状态发生改变时，SDK 会触发 [AgoraRTCClient.on("connection-state-change")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_connection_state_change) 回调，并在回调中明确当前的连接状态和发生状态改变的原因。

下面列出所有的连接状态：

- `"DISCONNECTED"`: 连接断开。处于这个状态时，SDK 不会自动重连。该状态表示用户处于以下任一阶段：

  - 尚未通过 `join` 加入频道。
  - 已经通过 `leave` 离开频道。
  - 被 Agora 服务器踢出频道或者连接失败等异常情况。

- `"CONNECTING"`: 正在连接。调用 `join` 时为此状态。

- `"CONNECTED"`: 已连接。该状态表示用户已经加入频道，可以在频道内发布或订阅媒体轨道。

- `"RECONNECTING"`: 连接断开，正在尝试重连。因网络断开或切换导致 SDK 与服务器的连接中断，SDK 会自动重连，进入此状态。

- `"DISCONNECTING"`: 正在断开连接。调用 `leave` 时为此状态。

下图展示连接状态发生改变的触发时机：

![](https://web-cdn.agora.io/docs-files/1611564363184)

## 断线重连

通信过程中，如果 SDK 因网络等原因，断开与服务器的连接，SDK 会自动开启断线重连机制。

下图展示从本地用户 UID 1 加入频道，到连接中断，再到连接完全失败过程中，本地用户 UID 1 和远端用户 UID 2 会收到的回调：

![](https://web-cdn.agora.io/docs-files/1611564461345)

其中：

- T0：SDK 接收到 UID 1 的 `Client.join` 请求。
- T1：UID 1 成功加入频道。加入频道过程中，UID 1 会收到 `AgoraRTCClient.on("connection-state-change")` 回调报告 `"CONNECTING"`，加入后报告 `"CONNECTED"`。
- T2：因网间传输延迟，UID 2 感知 UID 1 加入频道约有 100 毫秒的延迟，此时 UID 2 收到 `AgoraRTCClient.on("user-joined")` 回调。
- T3：某个时间点 UID 1 调用 `AgoraRTCClient.publish` 发布本地轨道。
- T4：UID 2 收到 `AgoraRTCClient.on("user-published")` 回调，表示 UID 1 已发布轨道。UID 2 可以调用 `AgoraRTCClient.subscribe` 方法订阅 UID 1 的轨道。
- T5：通信过程中 UID 1 网络发生中断，SDK 自动开启断线重连机制。
- T6：SDK 自动重连过程中，触发 `AgoraRTCClient.on("connection-state-change")` 回调报告 `"RECONNECTING"`。
- T7：如果 Agora 服务器连续 10 秒没有收到 UID 1 的音视频包，Agora 服务器判断 UID 1 不再发布音视频，UID 2 会收到 `AgoraRTCClient.on("user-unpublished")` 回调。
- T8：如果 Agora 服务器连续 20 秒没有收到 UID 1 的心跳包，Agora 服务器判断 UID 1 离线，UID 2 会收到 `AgoraRTCClient.on("user-left")` 回调。
- T9：成功重新建立连接后，UID 1 会收到 `AgoraRTCClient.on("connection-state-change")` 回调报告 `"CONNECTED"`。
- T10：UID 2 再次收到 `AgoraRTCClient.on("user-joined")` 回调。

## API 参考

- [AgoraRTCClient.on("connection-state-change")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_connection_state_change)
- [AgoraRTCClient.on("user-joined")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_user_joined)
- [AgoraRTCClient.on("user-left")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_user_left)
- [AgoraRTCClient.on("user-published")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_user_published)
- [AgoraRTCClient.on("user-unpublished")](./API%20Reference/web_ng/interfaces/iagorartcclient.html#event_user_unpublished)

## 相关文档

进程被杀时 SDK 会触发的回调，请参考 [FAQ：SDK 对断网、杀进程的处理](https://docs.agora.io/cn/faq/sdk_behavior)。