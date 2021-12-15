---
title: 连接状态管理
platform: iOS
updatedAt: 2021-03-17 03:52:08
---

## 状态定义

Agora RTM SDK 与 Agora RTM 系统的连接状态共有一下五种定义

- AgoraRtmConnectionStateDisconnected
- AgoraRtmConnectionStateConnecting
- AgoraRtmConnectionStateConnected
- AgoraRtmConnectionStateReconnecting
- AgoraRtmConnectionStateAborted

每当连接状态发生改变，SDK 都会通过 `rtmKit:connectionStateChanged:reason:` 回调返回最新的状态以及状态变化的原因。

### AgoraRtmConnectionStateDisconnected

该状态是指： App 未调用 `loginByToken` 方法前的 SDK 的初始状态。

- 一旦 App 调用 `loginByToken` 方法登录 Agora RTM 系统，本端收到回调 `rtmKit:connectionStateChanged:reason:` ， 显示：
  - 连接状态变为 `AgoraRtmConnectionStateConnecting` ；
  - 连接原因： `AgoraRtmConnectionChangeReasonLogin` 。

### AgoraRtmConnectionStateConnecting

该状态表示 App 已经调用 `loginByToken` 方法正在登录 Agora RTM 系统：

- 若 SDK 成功登录 Agora RTM 系统成功
  - 本端收到错误码 `AgoraRtmLoginErrorOk`
  - 本端收到回调 `rtmKit:connectionStateChanged:reason:` ，显示：
    - 连接状态变为： `AgoraRtmConnectionStateConnected ` ；
    - 连接状态改变原因： `AgoraRtmConnectionChangeReasonLoginSuccess` 。
- 若 SDK 未能成功登录 Agora RTM 系统：
  - 本端收到相应的错误码。
  - 本端收到回调 `rtmKit:connectionStateChanged:reason:` 显示：
    - 连接状态变为： `AgoraRtmConnectionStateDisconnected ` ；
    - 连接状态改变原因可能包括：
      - `AgoraRtmConnectionChangeReasonLoginFailure` 登录失败，原因未知；
      - `AgoraRtmConnectionChangeReasonLoginTimeout` 登录超时，6 秒内未能登录系统。

### AgoraRtmConnectionStateConnected

该状态表示 SDK 已成功登录 Agora RTM 系统，此时 SDK 对应的用户即处于“在线”状态。Agora RTM 系统会通过心跳测试不间断查询 SDK 的连接状态。

- 若 SDK 由于网络原因与 Agora RTM 系统的连接状态中断超过 4 秒：
  - 本端自动开始重连 Agora RTM 系统并收到回调 `rtmKit:connectionStateChanged:reason:` ，显示：
    - 连接状态变为： `AgoraRtmConnectionStateReconnecting` ;
    - 连接状态改变原因： `AgoraRtmConnectionChangeReasonInterrupted` 。
- 若有相同的 uid 从另一个实例登录 Agora RTM 系统，后登录的实例会导致当前的实例被 Agora RTM 系统踢出：
  - 本端收到 `rtmKit:connectionStateChanged:reason:` 回调，显示：
    - 连接状态变为： `AgoraRtmConnectionStateAborted` ；
    - 连接状态改变原因： `AgoraRtmConnectionChangeReasonRemoteLogin` 。
- 若 App 显式调用 `logoutWithCompletion:` 方法主动登出 Agora RTM 系统成功：
  - 本端收到回调 `rtmKit:connectionStateChanged:reason:` ，显示：
    - 链接状态变为： `AgoraRtmConnectionStateDisconnected` ;
    - 连接状态改变原因：`AgoraRtmConnectionChangeReasonlogoutWithCompletion:` 。

### AgoraRtmConnectionStateReconnecting

该状态是由于 SDK 因网络原因与 Agora RTM 系统连接断开超过 4 秒进入的状态。在这个状态下只要 App 不显式调用 `logoutWithCompletion:` 主动登出系统， SDK 会保持自动重连 Agora RTM 系统直至重连成功。

> 请注意由于 Agora RTM 系统存在 30 秒保活的机制，也就是说连接中断后系统会默认对应用户在线，并不间断查询对应用户的在线状态。如果 30 秒时用户仍然不在线，系统会将对应用户从在线用户列表中移除。

- 如果 SDK 在与系统断开 30 秒 内重新登录系统，SDK 会自动将用户加入之前加入的频道：
  - 本端收到 `rtmKit:connectionStateChanged:reason:` 回调，显示：
    - 连接状态变为： `AgoraRtmConnectionStateConnected ` ；
    - 连接状态改变原因： `AgoraRtmConnectionChangeReasonLoginSuccess` 。
- 如果 SDK 在与系统断开 30 秒后重新成功登录系统， SDK 会自动将用户加入之前加入的频道。由于此时系统已将用户从在线名单移除， SDK 还会自动同步用户属性到服务端。
  - 本端收到 `rtmKit:connectionStateChanged:reason:` 回调，显示：
    - 连接状态变为： `AgoraRtmConnectionStateConnected ` ；
    - 连接状态改变原因： `AgoraRtmConnectionChangeReasonLoginSuccess` 。
  - 用户之前所在频道的其他用户：
    - 在用户断线 30 秒时：收到 `channel:memberLeft:` 回调
    - 30 秒后用户重连成功时：收到 `channel:memberJoined:` 回调。
- 在 `AgoraRtmConnectionStateReconnecting` 状态下，由于 SDK 会一直重连 Agora RTM 系统，此时如果 Token 过期，SDK 会返回 `rtmKitTokenDidExpire:` 回调。该回调不会对状态产生影响。
- 如果 SDK 始终无法与系统重连成功，连接状态会保持不变。此时你可以通过调用 `logoutWithCompletion:` 方法显式登出系统。此时：
  - 本端收到 `rtmKit:connectionStateChanged:reason:` 回调，显示：
    - 连接状态变为： `AgoraRtmConnectionStateDisconnected`
    - 连接状态改变原因： `AgoraRtmConnectionChangeReasonLogout` 。
  - 本端收到错误码 `AgoraRtmLogoutErrorOk` 。

### AgoraRtmConnectionStateAborted

当有相同的 uid 从另一个实例登录 Agora RTM 系统，后登录的实例会导致当前的实例被 Agora RTM 系统踢出。被踢出的实例处于该状态。此时请调用 `logoutWithCompletion:` 先登出系统再根据实际业务情况调用 `loginByToken` 方法重新登录 Agora RTM 系统。

## 问题

<a name="reconnecting"></a>

### 连接状态变为 RECONNECTING 时我需要做什么吗？

[查看答案](#a1)

<a name="onLoginSuccess"></a>

### 在重连状态下自动登录成功会收到 `AgoraRtmLoginErrorOk` 错误码吗？

[查看答案](#a2)

<a name="keepalive"></a>

### 网络中断之后多久 Agora RTM 系统才会认为用户下线？

[查看答案](#a3)

<br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br>

## 答案

<a name="a1"></a>

### Q：连接状态变为 AgoraRtmConnectionStateReconnecting 时我需要做什么吗？

A：连接中断后，SDK 会自动重连 Agora RTM 系统直至登录成功，无需人为干预。

[查看其他问题](#reconnecting)

<br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br>

<a name="a2"></a>

### Q：在重连状态下自动登录成功会收到 `AgoraRtmLoginErrorOk` 错误码吗？

A：`AgoraRtmLoginErrorOk` 错误码只有在你主动调用 `loginByToken`方法成功时才会返回。重连状态下，SDK 会自动登录 Agora RTM 系统，所以重连成功时不会返回该回调。

[查看其他问题](#onLoginSuccess)

<br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br><br></br>

<a name="a3"></a>

### Q：网络中断之后多久 Agora RTM 系统才会认为用户下线？

A：当 Agora RTM 系统检测到 SDK 断开连接 30 秒时会将对应用户从在线用户列表移除。

[查看其他问题](#keepalive)#keepalive)
