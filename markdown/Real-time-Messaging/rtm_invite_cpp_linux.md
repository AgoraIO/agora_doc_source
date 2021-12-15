---
title: 呼叫邀请
platform: Linux C++
updatedAt: 2020-10-10 18:59:09
---

## 概述

Agora RTM SDK 支持呼叫邀请功能，包含通用呼叫场景中的以下行为：

- 主叫被叫发送或取消呼叫邀请
- 被叫接受或拒绝呼叫邀请

![](https://web-cdn.agora.io/docs-files/1602313430536)

Agora RTM SDK 提供的呼叫邀请功能仅实现了呼叫邀请的基本控制逻辑，即发送、取消、接受和拒绝呼叫邀请。Agora RTM SDK 不会处理邀请接通之后的动作，也不会管理整个会话的生命周期。你需要根据自己的业务逻辑自行实现。

呼叫邀请可应用于以下场景：

- app 呼叫邀请的响铃功能。
- 邀请对方结合 Agora RTC Native SDK 进行屏幕共享。
- 两个用户之间同时或先后发起视频呼叫和白板共享功能。
- 需要同步状态的呼叫场景。

## 呼叫邀请的实现流程

在一个完整的呼叫邀请过程中，主叫和被叫的呼叫邀请状态分别由 `LocalInvitation` 和 `RemoteInvitation` 来定义。

![](https://web-cdn.agora.io/docs-files/1602313442227)

### 发送呼叫邀请

发送呼叫邀请的步骤如下：

1. 主叫通过调用 `createLocalInvitation` 创建 `LocalInvitation`。此时 `LocalInvitation` 生命周期开始。
2. 主叫调用 `sendLocalInvitation` 发送呼叫邀请。被叫收到 `onRemoteInvitationReceived` 回调，此时 `RemoteInvitation` 生命周期开始。主叫收到 `onLocalInvitationReceivedByPeer` 回调。

### 取消呼叫邀请

主叫调用 `cancelLocalInvitation` 取消呼叫邀请。被叫收到 `onRemoteInvitationCanceled` 回调，此时 `RemoteInvitation` 生命周期结束。主叫收到 `onLocalInvitationCanceled` 回调，此时 `LocalInvitation` 生命周期结束。

![](https://web-cdn.agora.io/docs-files/1598604324660)

### 接受呼叫邀请

被叫从 `onRemoteInvitationReceived` 回调获取 `RemoteInvitation` 并调用 `acceptRemoteInvitation` 接受呼叫邀请。主叫收到 `onRemoteInvitationAccepted` 回调，此时 `RemoteInvitation` 生命周期结束。主叫收到 `onLocalInvitationAccepted` 回调，此时 `LocalInvitation` 生命周期结束。

![](https://web-cdn.agora.io/docs-files/1598604332061)

### 拒绝呼叫邀请

被叫从 `onRemoteInvitationReceived` 回调获取 `RemoteInvitation` 并调用 `refuseRemoteInvitation` 拒绝呼叫邀请。主叫收到 `onRemoteInvitationRefused` 回调，此时 `RemoteInvitation` 生命周期结束。主叫收到 `onLocalInvitationRefused` 回调，此时 `LocalInvitation` 生命周期结束。

![](https://web-cdn.agora.io/docs-files/1598604339097)

## API 参考

API 详见[呼叫邀请 API 文档](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_cpp/index.html#callinvitation)。
