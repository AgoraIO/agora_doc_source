# 频道连接状态管理

在实时音视频场景下，app 端与 Agora SD-RTN™ 之间的连接状态会随着客户端加入或离开频道而发生变化，也可能由于网络或鉴权问题而导致连接中断。

本文介绍各种频道连接状态，状态改变原因和处理方式，帮助你更好地管理用户和排除网络故障。


## 技术原理

### 连接状态

当连接状态发生变化时，Agora 会发送 `onConnectionStateChanged` 回调。 下图展示各种连接状态，以及用户从加入到离开频道的过程中连接状态如何改变：

![](https://web-cdn.agora.io/docs-files/1634185571858)

<a name="reconnection"> </a>

### 断线重连

通信过程中，如果因网络问题导致连接断开，SDK 会自动开启断线重连机制。下图展示本地用户（UID1）和远程用户（UID2）在以下过程中收到的回调：本地用户加入频道、发生网络异常、连接中断、重新加入频道。

![](https://web-cdn.agora.io/docs-files/1662515705077)

图解如下：

- T0：SDK 接收到 UID 1 的 `joinChannel` 请求。
- T1：调用` joinChannel` 200 ms 后，UID1 加入频道。 同时，UID 1 收到 `onConnectionStateChanged(connectionStateConnecting, connectionChangedConnecting)` 回调。 成功加入频道后，UID 1 收到 ` onConnectionStateChanged(connectionStateConnected, connectionChangedJoinSuccess)` 和 `onJoinChannelSuccess` 回调。
- T2：因网间传输延迟，UID 2 感知 UID 1 加入频道约有 100 毫秒的延迟，此时 UID 2 收到 `onUserJoined` 回调。
- T3：某个时间点 UID 1 客户端因断网等原因导致上行网络变差。 SDK 自动尝试重新加入频道。
- T4：如果 UID 1 连续 4 秒没有收到服务器发送的任何数据，UID 1 收到 `onConnectionStateChanged(connectionStateReconnecting, connectionChangedInterrupted)` 回调；同时 SDK 继续尝试重新加入频道。
- T5：UID 1 收到 `onConnectionStateChanged(connectionStateReconnecting, connectionChangedInterrupted)` 后连续 10 秒没有收到服务器发送的任何数据，UID 1 会收到 `onConnectionLost` 回调；同时 SDK 继续尝试重新加入频道。
- T6：如果 UID 2 连续 20 秒没有收到来自 UID 1 的任何数据，则 SDK 判断 UID 1 离线。UID 2 收到 `onUserOffline` 回调。
- T7：如果 UID 1 收到 `onConnectionStateChanged(connectionStateReconnecting, connectionChangedInterrupted)` 后连续 20 分钟无法重新加入频道，SDK 不再继续尝试。UID 1 收到 `onConnectionStateChanged(connectionStateFailed, connectionChangedJoinFailed)` 回调；用户需要退出当前频道，然后重新加入频道。


## 前提条件

在进行操作之前，请确保你已经在项目中实现了基本的实时音视频功能。详见[开始视频通话](./start_call_flutter_ng)。

## 操作步骤

本节介绍如何使用 `onConnectionStateChanged` 回调来监控频道连接状态的变化。

在你的项目中，打开管理 `RtcEngineEventHandler` 的文件，在 `RtcEngineEventHandler` 初始化进程中加入 `onConnectionStateChanged`。


你可以从日志中读取当前连接状态，以及状态更改的触发原因。

另外，`onConnectionStateChanged` 中的 `reason` 参数也解释了连接状态改变的原因，可帮助你进行网络故障排除。 有关频道连接状态变化的原因以及排障方式，详见[状态说明及排障指导](#connection_reason)。


## 参考信息

介绍更多相关信息和参考页面的链接。

### 连接状态

如前文图中所示，app 在加入和离开频道前后可能出现以下 5 种连接状态：

| 连接状态     | 描述                |
| ------------ | ------------------ |
| Disconnected | 初始连接状态。 它通常发生在：<ul><li>调用 `joinChannel` 之前。</li><li>调用 `leaveChannel` 之后。</li></ul> |
| Connecting   | 调用 `joinChannel` 方法后的瞬时状态。                        |
| Connected    | 发生在 app 成功加入频道后。 SDK还会触发 `onJoinChannelSuccess` 回调，上报本地客户端已经加入频道。 此时用户可以发布或订阅频道中的音频和视频。 |
| Reconnecting | 发生在连接中断时。 SDK 会在中断后自动尝试重新连接。<ul><li>如果重新加入频道成功，SDK 会触发 `onRejoinChannelSuccess` 回调。</li><li>如果 10 秒内没有加入频道，SDK 会触发 `onConnectionStateChanged(connectionStateReconnecting, connectionChangedLost)`，同时继续尝试重新加入频道。</li></ul> |
| Failed       | 连接失败。 发生在 SDK 在 20 分钟内无法加入频道、并且 SDK 停止重新连接频道时。 此时需调用 `leaveChannel` 离开当前频道，再调用 `joinChannel` 再次加入频道。 |

<a name="connection_reason"></a>

### 状态说明及排障指导

`onConnectionStateChanged` 中的 `reason` 参数描述了连接状态更改原因。

下表列出了不同连接状态和状态变化原因之间的映射关系，以及发生网络中断时故障时的处理方法。

| 连接状态     | 状态说明和排障指导                                           |
| ------------ | ------------------------------------------------------------ |
| Disconnected | <ul><li>`LeaveChannel`(5)：用户离开频道。</li><li>`InvalidToken`(8)：使用有效的 token 加入频道。</li></ul> |
| Connecting   | <ul><li>`Connecting`(0)：app 正在尝试加入 Agora 频道。</li></ul> |
| Connected    | <ul><li>`JoinSuccess`(1)：app 已成功加入频道。</li></ul>    |
| Reconnecting | <ul><li>`Interrupted`(2)：当网络连接中断时，SDK 自动重新连接频道，连接状态持续变化。 关于自动重连时连接状态如何改变， 详见[断线重连](#reconnection)。</li><li>`Lost`(16)：等待 SDK 成功重新连接服务器。</li><li>`SettingProxyServer`(11)：等待 SDK 成功重新连接服务器。</li><li>`ClientIpAddressChanged`(13)：等待 SDK 成功重新连接服务器。</li><li>`KeepAliveTimeout`(14)：等待 SDK 成功重新连接服务器。</li><li>`RenewToken`(12)：token 已更新，app 正在尝试重新加入频道。</li></ul> |
| Failed       | <ul><li>`InvalidAppId`(6)：使用有效的 app ID 加入频道。</li><li>`InvalidChannelName`(7)：使用有效的 channel name 加入频道。</li><li>`TokenExpired`(9)：从 app 服务器获取新的 token，然后调用  `joinChannel` 加入频道。</li><li>`BannedByServer`(3)：用户被服务器禁止。<li>`JoinFailed`(4)：SDK 在 20 分钟内持续尝试加入频道失败，停止尝试重连。 调用 `leaveChannel` 离开当前频道，然后调用 `joinChannel` 重新加入频道。</li><li>`RejectedByServer`(10)：发生在以下情况。<ul><li>本地用户已加入频道后，app 调用 `joinChannel`。</li><li>app 调用了 `startEchoTest`，但没有调用 `stopEchoTest` 结束回声测试。</ul></li></li> |

### API 参考

- [getConnectionState](./API%20Reference/flutter_ng/API/toc_core_method.html#api_irtcengine_getconnectionstate)
- [onConnectionStateChanged](./API%20Reference/flutter_ng/API/toc_network.html#callback_irtcengineeventhandler_onconnectionstatechanged)