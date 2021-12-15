---
title: 连接状态管理
platform: Linux Java
updatedAt: 2021-03-17 03:52:10
---

## 概述

当用户登录、登出 Agora RTM 系统，或者网络连接发生变化时，Agora RTM SDK 与 Agora RTM 系统之间的连接会在不同状态之间切换。可能的连接状态如下：

- CONNECTION_STATE_DISCONNECTED（用户未连接）
- CONNECTION_STATE_CONNECTING（用户正在连接）
- CONNECTION_STATE_CONNECTED（用户已连接）
- CONNECTION_STATE_RECONNECTING（用户正在重连）
- CONNECTION_STATE_ABORTED（用户被踢出）

如下图所示，实线表示 SDK 会根据条件自动实现部分状态切换。虚线表示需要用户主动调用 API 来实现。

<div class="alertnote">每当连接状态发生改变，RTM SDK 都会通过 <code>onConnectionStateChanged</code> 回调返回最新的状态 <code>ConnectionState</code> 枚举以及状态变化的原因 <code>ConnectionStateReason</code> 枚举。你可以通过此回调对连接状态进行管理。</div>

![](https://web-cdn.agora.io/docs-files/1602304327265)

## 调用 API 改变连接状态

你可以利用 `onConnectionStateChanged` 回调返回的状态和状态改变原因在下列情况中主动调用 API 变更连接状态。

### 用户登录 RTM 系统

在你调用 `login` 登录 RTM 系统时，连接状态会从 `CONNECTION_STATE_DISCONNECTED` 转换为 `CONNECTION_STATE_CONNECTING`，状态改变原因为 `CONNECTION_CHANGE_REASON_LOGIN`。处于 `CONNECTION_STATE_CONNECTING` 状态时，你不需要进行任何操作，连接状态会自动转换为下列状态之一：

- `CONNECTION_STATE_DISCONNECTED`：用户登录失败或登录超时（6 秒内未登录系统）。
- `CONNECTION_STATE_CONNECTED`：用户登录成功。

当连接状态变为 `CONNECTION_STATE_DISCONNECTED` 后，你需要重新调用 `login` 登录。

### 用户由于网络原因与 RTM 系统断开连接

当连接处于 `CONNECTION_STATE_CONNECTED` 状态时，如果由于网络原因与 Agora RTM 系统的连接中断超过 4 秒，连接状态会转换为 `CONNECTION_STATE_RECONNECTING`，状态改变原因为 `CONNECTION_CHANGE_REASON_INTERRUPTED`。处于 `CONNECTION_STATE_RECONNECTING` 状态时，RTM SDK 会持续自动重新登录 RTM 系统直至登录成功，因此你无需进行任何登录操作。重新登录成功后，连接状态会转换为 `CONNECTION_STATE_CONNECTED`，SDK 不会返回 `onLoginSuccess` 回调。

自动重连成功后，RTM 系统会对断开连接期间的消息进行补发：

- RTM 系统会补发断开连接期间的全部点对点消息。
- RTM 系统会补发重连成功之前 30 秒内的频道消息。最多补发 32 条频道消息。

如果一直无法重新登录成功，连接状态会保持在 `CONNECTION_STATE_RECONNECTING`。你可以调用 `logout` 先登出系统再根据实际业务情况调用 `login` 方法重新登录 RTM 系统。

根据连接中断到重新自动登录成功的时长不同，RTM 系统的行为也会有区别：

- 如果连接中断 30 秒内用户成功重新登录，连接状态会转换为 `CONNECTION_STATE_CONNECTED`。用户的在线状态不变。
- 如果连接中断 30 秒时用户仍然不在线，RTM 系统会将对应用户从在线用户列表和频道中移除，同一频道的用户会收到 `onMemberLeft` 回调。如果用户在之后重新成功登录系统，连接状态会转换为 `CONNECTION_STATE_CONNECTED。` SDK 会自动将用户加入之前加入的频道，同频道的用户会收到 `onMemberJoined` 回调。由于此时 RTM 系统已将用户从在线列表中移除， SDK 还会自动同步用户属性到 RTM 系统。

在 `CONNECTION_STATE_RECONNECTING` 状态下，由于 SDK 会一直重连 Agora RTM 系统，此时如果 Token 过期，SDK 会返回 `onTokenExpired` 回调。但是该回调不会对连接状态产生影响。

### 用户被踢出 RTM 系统

如果相同的用户 ID 从另一个客户端实例登录 RTM 系统，当前客户端实例中正在登录状态的用户会被 RTM 系统踢出，连接状态变为 `CONNECTION_STATE_ABORTED`。你可以调用 `logout` 先登出系统再根据实际业务情况调用 `login` 方法重新登录 RTM 系统。

### 用户登出 RTM 系统

如果你调用 logout 登出 RTM 系统，连接状态会转换为 `CONNECTION_STATE_DISCONNECTED`。

## 示例代码

参考以下示例代码监听连接状态：

```java
// 监听连接状态
public void onConnectionStateChanged(int state, int reason)
{
   System.out.println("on connection state changed to "+ state + " reason: " + reason);
 }
```

## API 参考

- [`onConnectionStateChanged`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_client_listener.html#a9b6f86cb2d7d5ec4adf0b6d645c16bf9) 回调
- [`ConnectionState`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_connection_state.html) 枚举类型
- [`ConnectionChangeReason`](/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_connection_change_reason.html) 枚举类型
