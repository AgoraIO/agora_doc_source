---
title: 呼叫邀请
platform: iOS
updatedAt: 2020-11-26 08:47:56
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

在一个完整的呼叫邀请过程中，主叫和被叫的呼叫邀请状态分别由 `AgoraRtmLocalInvitation` 和 `AgoraRtmRemoteInvitation` 来定义。

![](https://web-cdn.agora.io/docs-files/1602321612917)


### 发送呼叫邀请

发送呼叫邀请的步骤如下：


1. 主叫通过调用 `createLocalInvitation` 创建 `AgoraRtmLocalInvitation`。此时 `AgoraRtmLocalInvitation` 生命周期开始。
2. 主叫调用 `sendLocalInvitation` 发送呼叫邀请。被叫收到 `remoteInvitationReceived` 回调，此时 `AgoraRtmRemoteInvitation` 生命周期开始。主叫收到 `localInvitationReceivedByPeer` 回调。


### 取消呼叫邀请

主叫调用 `cancelLocalInvitation` 取消呼叫邀请。被叫收到 `remoteInvitationCanceled` 回调，此时 `AgoraRtmRemoteInvitation` 生命周期结束。主叫收到 `localInvitationCanceled` 回调，此时 `AgoraRtmLocalInvitation` 生命周期结束。

![](https://web-cdn.agora.io/docs-files/1598604630795)


### 接受呼叫邀请

被叫从 `remoteInvitationReceived` 回调获取 `AgoraRtmRemoteInvitation` 并调用 `acceptRemoteInvitation` 接受呼叫邀请。主叫收到 `remoteInvitationAccepted` 回调，此时 `AgoraRtmRemoteInvitation` 生命周期结束。主叫收到 `localInvitationAccepted` 回调，此时 `AgoraRtmLocalInvitation` 生命周期结束。

![](https://web-cdn.agora.io/docs-files/1598604639933)


###  拒绝呼叫邀请

被叫从 `remoteInvitationReceived` 回调获取 `AgoraRtmRemoteInvitation` 并调用 `refuseRemoteInvitation` 拒绝呼叫邀请。主叫收到 `remoteInvitationRefused` 回调，此时 `AgoraRtmRemoteInvitation` 生命周期结束。主叫收到 `localInvitationRefused` 回调，此时 `AgoraRtmLocalInvitation` 生命周期结束。

![](https://web-cdn.agora.io/docs-files/1598604647326)


## API 参考

[呼叫邀请管理](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_oc/docs/API-Overview.html#callinvitation)。

## 示例项目

我们在 GitHub 提供一个开源的[示例项目](https://github.com/AgoraIO-Usecase/Video-Calling)，你也可以前往下载体验并参考源代码。


