---
title: 呼叫邀请
platform: Linux C++
updatedAt: 2020-10-10 18:01:39
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

发送呼叫邀请的示例代码如下：

```
// 示例代码基于 Qt


// 获取呼叫邀请管理器。
bool CAgoraRtmInstance::InitCallManager()
{
    if(!m_callService)
        return false;
    m_callManager =m_callService->getRtmCallManager(m_callEventHandler.get());
    return m_callManager != nullptr;
}


bool CAgoraRtmInstance::CallRemoteUser(QString remoteUserId)
{
    if(!m_callManager)
        return false;
    m_remoteUserId   = remoteUserId;
		//创建 LocalInvitation
    m_callInvitation = m_callManager->createLocalCallInvitation(remoteUserId.toUtf8());
    if(m_callInvitation){
		    //发送呼叫邀请
        int ret = m_callManager->sendLocalInvitation(m_callInvitation);
        return ret == 0 ? true : false;
    }
    return false;
}
```

### 取消呼叫邀请

主叫调用 `cancelLocalInvitation` 取消呼叫邀请。被叫收到 `onRemoteInvitationCanceled` 回调，此时 `RemoteInvitation` 生命周期结束。主叫收到 `onLocalInvitationCanceled` 回调，此时 `LocalInvitation` 生命周期结束。

![](https://web-cdn.agora.io/docs-files/1598604324660)

取消呼叫邀请的示例代码如下：

```
// 示例代码基于 Qt


//取消呼叫邀请
bool CAgoraRtmInstance::CancelLocalInvitation()
{
    if(!m_callManager || !m_callInvitation)
        return false;
    int ret = m_callManager->cancelLocalInvitation(m_callInvitation);
    return ret == 0 ? true : false;
}
```

### 接受呼叫邀请

被叫从 `onRemoteInvitationReceived` 回调获取 `RemoteInvitation` 并调用 `acceptRemoteInvitation` 接受呼叫邀请。主叫收到 `onRemoteInvitationAccepted` 回调，此时 `RemoteInvitation` 生命周期结束。主叫收到 `onLocalInvitationAccepted` 回调，此时 `LocalInvitation` 生命周期结束。

![](https://web-cdn.agora.io/docs-files/1598604332061)

接受呼叫邀请的示例代码如下：

```
// 示例代码基于 Qt

// 从 onRemoteInvitationReceived 回调获取 RemoteInvitation
void onRemoteInvitationReceived(void* invitation)
{
    IRemoteCallInvitation* remoteInvitation = (IRemoteCallInvitation*)invitation;
}

// 接受呼叫邀请
bool CAgoraRtmInstance::AcceptRemoteInvitation(IRemoteCallInvitation* invitation)
{
    int ret = m_callManager->acceptRemoteInvitation(invitation);
    return ret == 0 ? true : false;
}
```

### 拒绝呼叫邀请

被叫调用 `refuseRemoteInvitation` 拒绝呼叫邀请。主叫收到 `onRemoteInvitationRefused` 回调，此时 `RemoteInvitation` 生命周期结束。主叫收到 `onLocalInvitationRefused` 回调，此时 `LocalInvitation` 生命周期结束。

![](https://web-cdn.agora.io/docs-files/1598604339097)

拒绝呼叫邀请的示例代码如下：

```
// 示例代码基于 Qt

// 从 onRemoteInvitationReceived 回调获取 RemoteInvitation
void onRemoteInvitationReceived(void* invitation)
{
    IRemoteCallInvitation* remoteInvitation = (IRemoteCallInvitation*)invitation;
}

//拒绝呼叫邀请
bool RefuseRemoteInvitation(IRemoteCallInvitation* invitation)
{
    int ret = m_callManager->refuseRemoteInvitation(invitation);
    return ret == 0 ? true : false;
}
```

## API 参考

API 详见[呼叫邀请 API 文档](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_cpp/index.html#callinvitation)。

## 示例项目

我们在 GitHub 提供一个开源的[示例项目](https://github.com/AgoraIO-Usecase/Video-Calling)，你也可以前往下载体验并参考源代码。
