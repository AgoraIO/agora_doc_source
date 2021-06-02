---
title: 呼叫邀请
platform: Web
updatedAt: 2020-11-26 08:48:37
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
2. 主叫调用 `send` 发送呼叫邀请。被叫收到 `RemoteInvitationReceived` 回调，此时 `RemoteInvitation` 生命周期开始。主叫收到 `LocalInvitationReceivedByPeer` 回调。

发送呼叫邀请的示例代码如下：

```
// 创建 LocalInvitation
localInvitation = Client.createLocalInvitation(calleeId);
// 发送呼叫邀请
localInvitation.send();
```


### 取消呼叫邀请

主叫调用 `cancel` 取消呼叫邀请。被叫收到 `RemoteInvitationCanceled` 回调，此时 `RemoteInvitation` 生命周期结束。主叫收到 `LocalInvitationCanceled` 回调，此时 `LocalInvitation` 生命周期结束。

![](https://web-cdn.agora.io/docs-files/1599102255173)

取消呼叫邀请的示例代码如下：

```
// 取消呼叫邀请
cancelCall() {
    localInvitation.cancel();
  }
```



### 接受呼叫邀请

被叫从 `RemoteInvitationReceived` 回调获取 `RemoteInvitation` 并调用 `accept` 接受呼叫邀请。主叫收到 `RemoteInvitationAccepted` 回调，此时 `RemoteInvitation` 生命周期结束。主叫收到 `LocalInvitationAccepted` 回调，此时 `LocalInvitation` 生命周期结束。

![](https://web-cdn.agora.io/docs-files/1599102265686)

接受呼叫邀请的示例代码如下：

```
// 接受呼叫邀请
acceptCall() {
    remoteInvitation.accept();
  }
```

###  拒绝呼叫邀请

被叫从 `RemoteInvitationReceived` 回调获取 `RemoteInvitation` 并调用 `refuseRemoteInvitation` 拒绝呼叫邀请。主叫收到 `RemoteInvitationRefused` 回调，此时 `RemoteInvitation` 生命周期结束。主叫收到 `LocalInvitationRefused` 回调，此时 `LocalInvitation` 生命周期结束。

![](https://web-cdn.agora.io/docs-files/1599102275275)

拒绝呼叫邀请的示例代码如下：

```
// 拒绝呼叫邀请
refuseCall() {
    remoteInvitation.refuse();
  }
```

##  API 参考

API 详见[呼叫邀请 API 文档](/cn/Real-time-Messaging/API%20Reference/RTM_web/index.html#呼叫邀请管理)。

## 示例项目

我们在 GitHub 提供一个开源的[示例项目](https://github.com/AgoraIO-Usecase/Video-Calling)，你也可以前往下载体验并参考源代码。