---
title: SDK 是否支持断线重连机制？
platform:
  ["Android", "iOS", "macOS", "Windows", "Unity", "Cocos Creator", "Cocos2d-x", "Electron", "React Native", "Flutter"]
updatedAt: 2021-02-23 09:04:13
Products: ["Voice", "Video", "Interactive Broadcast", "Recording", "live-streaming"]
---

在 app 断网或进程被杀时，SDK 会自动启用断线重连机制。本文展示 Agora SDK 在这两个情况下连接状态的处理逻辑。

<div class="alert note">本文不适用于 Agora RTC Web SDK。</div>

## 断网

Agora SDK 在 v2.3.2 新增了 [`onConnectionStateChanged`](./API%20Reference/cpp/classagora_1_1rtc_1_1_i_rtc_engine_event_handler.html#af409b2e721d345a65a2c600cea2f5eb4) 或 [`connectionStateChangedToState`](./API%20Reference/oc/Protocols/AgoraRtcEngineDelegate.html#//api/name/rtcEngine:connectionChangedToState:reason:) 回调，用以报告当前的网络连接状态，及引起连接状态改变的原因。因此本文内容会分 v2.3.2 之前及 v2.3.3 之后两个版本来介绍。

### v2.3.2 之前

下图展示从用户 UID 1 加入频道，到连接中断，再到重新加入频道过程中，本地及远端用户 UID 2 的应用层会收到的回调：

![](https://web-cdn.agora.io/docs-files/1557479717335)

其中：

- T0 = 0 s：SDK 接收到应用层发起的 `joinChannel` 或 `joinChannelByToken` 请求
- T1 ≈ T0 + 200 ms：通常在调用 `joinChannel` 或 `joinChannelByToken` 200 毫秒后，应用层可以加入频道。加入频道后 UID 1 的应用层收到 `onJoinChannelSuccess` 或 `didJoinChannel` 回调
- T2 ≈ T1 + 100 ms：因网间传输延迟，UID 2 感知 UID 1 加入频道约有 100 毫秒的延迟，此时 UID 2 的应用层收到 `onUserJoined` 或 `didJoinedOfUid` 回调
- T3：某个时间点 UID 1 客户端因断网等原因导致上行网络变差。SDK 会尝试重新加入频道
- T4 = T3 + 4 s：如果 UID 1 连续 4 秒没有收到服务器发送的任何数据，应用层会收到 `onConnectionInterrupted` 或 `rtcEngineConnectionDidInterrupted` 回调；同时 SDK 继续尝试重新加入频道
- T5 = T3 + 10 s：如果 UID 1 连续 10 秒没有收到服务器发送的任何数据，应用层会收到 `onConnectionLost` 或 `rtcEngineConnectionDidLost` 回调；同时 SDK 继续尝试重新加入频道
- T6 = T3 + 20 s：如果 UID 2 连续 20 秒没有收到 UID 1 的任何数据，SDK 判断远端用户掉线，UID 2 的应用层会收到 `onUserOffline` 或 `didOfflineOfUid` 回调
- T7：如果 UID 1 重新加入频道成功，UID 1 的应用层会收到 `onRejoinChannelSuccess` 或 `didRejoinChannel` 回调
- T8 ≈ T7 + 100 ms：大约 100 毫秒的延迟后，UID 2 的应用层再次收到 `onUserJoined` 或 `didJoinOfUid` 回调，表示远端用户重新上线

### v2.3.2 及之后

下图展示从用户 UID 1 加入频道，到连接中断，再到连接完全失败过程中，本地及远端用户 UID 2 的应用层会收到的回调：

![](https://web-cdn.agora.io/docs-files/1557480056385)

其中：

- T0 = 0 s：SDK 接收到应用层发起的 `joinChannel` 或 `joinChannelByToken` 请求
- T1 ≈ T0 + 200 ms：通常在调用 `joinChannel` 或 `joinChannelByToken` 200 毫秒后，应用层可以加入频道。加入频道过程中，UID 1 的应用层会收到 `onConnectionStateChanged(CONNECTION_STATE_CONNECTING, CONNECTION_CHANGED_CONNECTING)` 或 `connectionChangedToState(AgoraConnectionStateConnecting, AgoraConnectionChangedConnecting`)；加入后收到 `onConnectionStateChanged(CONNECTION_STATE_CONNECTED, CONNECTION_CHANGED_JOIN_SUCCESS)` 或 `connectionChangedToState(AgoraConnectionStateConnected, AgoraConnectionChangedJoinSuccess)` 和 `onJoinChannelSuccess` 或 `didJoinChannel` 回调
- T2 ≈ T1 + 100 ms：因网间传输延迟，UID 2 感知 UID 1 加入频道约有 100 毫秒的延迟，此时 UID 2 的应用层收到 `onUserJoined` 或 `didJoinedOfUid` 回调，
- T3：某个时间点 UID 1 客户端因断网等原因导致上行网络变差。SDK 会尝试重新加入频道
- T4 = T3 + 4 s：如果 UID 1 连续 4 秒没有收到服务器发送的任何数据，应用层会收到 `onConnectionStateChanged(CONNECTION_STATE_RECONNECTING, CONNECTION_CHANGED_INTERRUPTED)` 或 `connectionChangedToState(AgoraConnectionStateReconnecting, AgoraConnectionChangedInterrupted)` 回调；同时 SDK 继续尝试重新加入频道
- T5 = T3 + 10 s：如果 UID 1 连续 10 秒没有收到服务器发送的任何数据，应用层会收到 `onConnectionLost` 或 `rtcEngineConnectionDidLost` 回调；同时 SDK 继续尝试重新加入频道
- T6 = T3 + 20 s：如果 UID 2 连续 20 秒没有收到 UID 1 的任何数据，SDK 判断远端用户掉线，UID 2 的应用层会收到 `onUserOffline` 或 `didOfflineOfUid` 回调
- T7 = T6 + 20 min：如果 UID 1 连续 20 分钟无法重新加入频道，SDK 不再继续尝试。UID 1 的应用层收到 `onConnectionStateChanged(CONNECTION_STATE_FAILED, CONNECTION_CHANGED_JOIN_FAILED)` 或 `connectionChangedToState(AgoraConnectionStateFailed, AgoraConnectionChangedJoinFailed)` 回调；用户需要退出当前频道，然后重新加入频道

> 如果 UID 2 是 Web 客户端，则 Web 端在 UID 1 加入和重新接入频道时，会收到 `client.on("stream-added")` 回调；如果 UID 2 在 10 秒内未收到 UID 1 的任何数据，会收到 `client.on("stream-removed")` 回调；如果服务器在 3 分钟内未收到 UID 1 的任何数据，会收到 `client.on("peer-leave")` 回调。

## 进程被杀

进程被杀包括以下各种情况：

- 打开或关闭 voip 模式
- 前台或后台运行时进程被杀
- 网页关闭（Web 端）

假设有 UID 1， UID 2 两个用户处于同一个频道内进行音视频直播或通话。
当 UID 1 的进程被杀：

- 如果 UID 1 是 iOS 或 macOS 平台：UID 1 自动触发 `leaveChannel`，UID 2 有回调：

  - 如果 UID 2 是 Android 或 Windows 平台：` onUserOffline`
  - 如果 UID 2 是 iOS 或 macOS 平台： `didOfflineOfUid`
  - 如果 UID 2 是 Web 平台： `client.on("peer-leave")`

- 如果 UID 1 是 Android， Windows，或 Linux 平台，且 UID 2 使用的是 Native SDK：
  - 如果 20 秒内， UID 1 没有重启 app 并加入原频道，UID 2 有回调：
    - 如果 UID 2 是 Android 或 Windows 平台： `onUserOffline`
    - 如果 UID 2 是 iOS 或 macOS 平台：` didOfflineOfUid`
  - 如果 20 秒内， UID 1 重启 app 并加入原频道，UID 2 不会收到回调。
- 如果 UID 1 是 Android 或 Windows 台，且 UID 2 使用的是 Web SDK：
  - 如果 10 秒内， UID 1 没有重启 app 并加入原频道，UID 2 有回调：`client.on("stream-removed")`
  - 如果 10 秒内， UID 1 重启 app 并加入原频道，UID 2 不会收到回调。
- 如果 UID 1 使用的是 Web SDK，进程被杀与掉线的行为是一样的。
- 如果 UID 1 是频道内最后一个用户，服务端会在 10s 后销毁频道。
