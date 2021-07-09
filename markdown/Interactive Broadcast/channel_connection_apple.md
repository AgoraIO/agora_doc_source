---
title: 频道连接状态管理
platform: iOS
updatedAt: 2020-09-22 11:37:20
---
当用户使用 Agora SDK 进行音视频通话或互动直播时，他会有多个 Agora 频道连接状态。本文介绍 Agora 频道如何判断用户在通信的各个阶段处于什么连接状态以及各状态的转变过程。

## 连接状态

为帮助开发者更好地了解和管理用户在频道内的连接状态，Agora 从 v2.3.2 起新增 `connectionChangedToState` 回调。当用户连接状态发生改变时，SDK 会触发该回调，并在回调中明确当前的连接状态和发生状态改变的原因。

该回调下，SDK 有以下连接状态：

- DISCONNECTED(1)：连接断开
- CONNECTING(2)：建立网络连接中
- CONNECTED(3)：网络已连接
- RECONNECTING(4)：重新建立网络连接中
- FAILED(5)：网络连接失败

下图展示连接状态发生改变的触发时机：

![](https://web-cdn.agora.io/docs-files/1569297859333)

通信过程中，你可以通过调用 `getConnectionState` 方法获取当前的连接状态。也可以搭配使用 `connectionChangedToState` 回调中的 `reason` 参数，了解网络状态发生变化的原因。

## 断线重连

通信过程中，如果 SDK 因网络等原因，断开与服务器的连接，SDK 会自动开启断线重连机制。

下图展示从用户 UID 1 加入频道，到连接中断，再到连接完全失败过程中，本地及远端用户 UID 2 会收到的回调：

![](https://web-cdn.agora.io/docs-files/1569298035806)

其中：

- T0：SDK 接收到本地用户 joinChannelByToken 请求
- T1：通常在调用 joinChannelByToken 200 毫秒后，用户可以加入频道。加入频道过程中，UID 1 会收到 `connectionChangedToState(AgoraConnectionStateConnecting, AgoraConnectionChangedConnecting)`；加入后收到 `connectionChangedToState(AgoraConnectionStateConnected, AgoraConnectionChangedJoinSuccess)` 和 `didJoinChannel` 回调
- T2：因网间传输延迟，UID 2 感知 UID 1 加入频道约有 100 毫秒的延迟，此时 UID 2 收到 `didJoinedOfUid` 回调，
T3：某个时间点 UID 1 客户端因断网等原因导致上行网络变差。SDK 自动尝试重新加入频道
T4：如果 UID 1 连续 4 秒没有收到服务器发送的任何数据，UID 1 会收到 `connectionChangedToState(AgoraConnectionStateReconnecting, AgoraConnectionChangedInterrupted)` 回调；同时 SDK 继续尝试重新加入频道
T5：如果 UID 1 连续 10 秒没有收到服务器发送的任何数据，UID 1 会收到 `rtcEngineConnectionDidLost` 回调；同时 SDK 继续尝试重新加入频道
T6：如果 UID 2 连续 20 秒没有收到 UID 1 的任何数据，SDK 判断远端用户掉线，UID 2 会收到 `didOfflineOfUid` 回调
T7：如果 UID 1 连续 20 分钟无法重新加入频道，SDK 不再继续尝试。UID 1 收到 `connectionChangedToState(AgoraConnectionStateFailed, AgoraConnectionChangedJoinFailed)` 回调；用户需要退出当前频道，然后重新加入频道

## API 参考
- [getConnectionState](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/getConnectionState)
- [connectionChangedToState](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:)
- [rtcEngineConnectionDidLost](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngineConnectionDidLost:)

## 相关文档

v2.3.2 版本及之前的断线重连机制， 以及进程被杀时 SDK 会触发的回调，请参考 [FAQ：SDK 对断网、杀进程的处理](https://docs.agora.io/cn/faq/sdk_behavior)。