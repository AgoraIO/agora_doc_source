---
title: 呼叫邀请
platform: Linux Java
updatedAt: 2020-11-26 08:49:29
---
## 概述

Agora RTM SDK 提供的呼叫邀请功能是基于 RTM 点对点消息的功能封装的类似 SIP 的协议，用于呼叫控制。呼叫邀请功能覆盖了通用呼叫场景中的以下行为：

- 主叫发送呼叫邀请；
- 主叫取消呼叫邀请；
- 被叫接受收到的呼叫邀请；
- 被叫拒绝收到的呼叫邀请。

Agora RTM SDK 还支持：

- 主叫在发送邀请时提供附加信息，比如：媒体频道名（channelId）和 content；
- 被叫在接受或拒绝邀请时提供相应内容（response）；
- 单个主叫同时发送多个呼叫邀请（支持向同一或多个被叫同时发送多个呼叫邀请）。

<div class="alert note">Agora RTM SDK 提供的呼叫邀请功能仅仅实现了通用呼叫邀请的基本的控制逻辑。Agora RTM SDK 不会处理邀请接通之后的动作（比如加入指定媒体频道），用户需要根据自己的业务逻辑自行实现。</div>

## 应用场景

- APP 的呼叫邀请的响铃功能；
- 邀请对方结合 Agora Native SDK 进行屏幕共享；

- 两个用户之间同时或先后发起视频呼叫和白板共享功能；
- 需要同步状态的呼叫场景

## 呼叫邀请生命周期定义

Agora RTM SDK 在一个呼叫邀请过程中引入了 LocalInvitation 和 RemoteInvitation 的概念。你可以将这两个呼叫邀请对象理解为同一个呼叫邀请的两种不同形式。

### 生命周期的开始

- LocalInvitation 由主叫通过显式调用 createLocalInvitation 方法创建，供主叫指定被叫、设置自定义内容，或查询呼叫邀请状态。
- RemoteInvitation 在被叫收到呼叫邀请时由 SDK 创建并通过 onRemoteInvitationReceived 回调返回，供被叫设置相应内容、查询主叫 ID，或查询呼叫邀请状态。

### 生命周期的结束

LocalInvitation 的生命周期在主叫收到以下回调时结束，并由 SDK 自动释放：

- [onLocalInvitationCanceled](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#ae3164e81772cd4d6171165b1705adcaa)：主叫已成功取消呼叫邀请。
- [onLocalInvitationAccepted](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a4dece02a62a187a66c2415fecf6b75dc)：被叫已接受呼叫邀请。
- onLocalInvitationRefused：被叫已拒绝呼叫邀请。
- onLocalInvittionFailure：呼叫邀请过程已开始但是以失败告终。该回调通过错误码 [LocalInvitationError](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_local_invitation_error.html) 概括了失败的主要原因：
  - [LOCAL_INVITATION_ERR_PEER_OFFLINE](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_local_invitation_error.html#a2b22ace552afdecf40f88b698e81c95c)：被叫不在线。
  - [LOCAL_INVITATION_ERR_PEER_NO_RESPONSE](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_local_invitation_error.html#ae06ee70dcd82a92b5c5ac667448f1726)：被叫无响应（呼叫邀请发出 30 秒后仍未收到被叫响应）
  - [LOCAL_INVITATION_ERR_INVITATION_EXPIRE](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_local_invitation_error.html#a3afb1a0747af53d9dbb6ee53866395ee)：呼叫邀请过期（被叫收到呼叫邀请 60 秒后呼叫邀请未被取消、接受，或拒绝）

RemoteInvitation 的生命周期在被叫收到以下回调时结束，并由 SDK 自动释放：

- [onRemoteInvitationCanceled](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a9d0409c87455d4d2b1315f67a5f7aa12)：主叫已成功取消呼叫邀请。
- [onRemoteInvitationAccepted](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a81d9d3de89d08c41408d8a94c8309d29)：接受呼叫邀请成功。
- [onRemoteInvitationRefused](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a7a21eaa9ff49bcf39e3c49b94f6e6ac7)：拒绝呼叫邀请成功。
- [onRemoteInvitationFailure](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_call_event_listener.html#a6f9f2bbbfbcb0a766c6f1b2e4a8314a1)：呼叫邀请过程以失败告终。该回调通过错误码 [RemoteInvitationError](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_remote_invitation_error.html) 概括了失败的主要原因：
  - [REMOTE_INVITATION_ERR_PEER_OFFLINE](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_remote_invitation_error.html#adb45fa9c16c640cbb311f3df86253498)：接受呼叫邀请时主叫不在线。
  - [REMOTE_INVITATION_ERR_ACCEPT_FAILURE](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_remote_invitation_error.html#aabcb42b9211e7693c6f17e379c8991d0)：被叫接受呼叫邀请后，主叫未响应。
  - [REMOTE_INVITATION_ERR_INVITATION_EXPIRE](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_remote_invitation_error.html#a363657cd78d4a9415f12c66c8115849d)：呼叫邀请过期（被叫收到呼叫邀请 60 秒后呼叫邀请未被取消、接受，或拒绝）

> 被叫接受来自主叫的呼叫邀请是一个三次握手的过程：
>
> - 一次握手：主叫调用 sendLocalInvitation 发送呼叫邀请，被叫收到 onRemoteInvitationReceived 回调；
> - 二次握手：被叫调用 [acceptRemoteinvitation](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#a5f6f97c84e426e2fbd8a5dda71e2fc6c) 方法接受呼叫邀请，主叫收到被叫已接受呼叫邀请的信息；
> - 三次握手：被叫确认主叫已经收到了被叫接受邀请的信息，呼叫邀请成功。

## 通用行为限定 

了解了呼叫邀请生命周期定义后，我们就能够理解 Agora RTM SDK 对于呼叫邀请的行为限定：所有的呼叫邀请操作都应在呼叫邀请的生命周期内进行。

在主叫显式调用 [sendLocalInvitation](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#af899697061305ca840e829b92c78e353) 或 [cancelLocalInvitation](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#a5f03bfe1cfd6987fbc7b5a4dc484f564) 方法发送或取消呼叫邀请时，或当被叫显式调用 [acceptRemoteinvitation](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#a5f6f97c84e426e2fbd8a5dda71e2fc6c) 或 [refuseRemoteInvitation](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/classio_1_1agora_1_1rtm_1_1_rtm_call_manager.html#a2ce4af944183976d18c055816f756bf6) 方法接受或拒绝呼叫邀请时，SDK 会对 APP 行为进行检查并通过 [onFailure](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_result_callback.html#a1f9145a3eb119e32cfc0afa938062396) 回调返回相应的 [InvitationApiCallError](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_invitation_api_call_error.html) 错误码：

| 回调                                                         | 描述                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| [INVITATION_API_CALL_ERR_NOT_STARTED](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_invitation_api_call_error.html#a0ee97849175f73c3122a44757162ad28) | 呼叫邀请未开始。错误情况包括：在 sendLocalInvitation 之前调用了 cancelLocalInvitation。 |
| [INVITATION_API_CALL_ERR_ALREADY_END](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_invitation_api_call_error.html#a3f7e4c72d1e3bf66ccba197e4ac9b9f5) | 呼叫邀请结束后又调用了 send、cancel、accept，或 refuse。     |
| [INVITATION_API_CALL_ERR_ALREADY_ACCEPT](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_invitation_api_call_error.html#a5b164917865f9524cd57ea5182ef55a1) | 被叫重复调用 accept 方法。                                   |
| [INVITATION_API_CALL_ERR_ALREADY_SENT](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_rtm_status_code_1_1_invitation_api_call_error.html#ae17aea35c9bd9241f62c35cc91fa8369) | 主叫重复调用 send 方法发送呼叫邀请。                         |

## 状态流转图

呼叫邀请中，主叫可以通过 [LocalInvitation](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_local_invitation.html) 对象提供的 [getState](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_local_invitation.html#a59608fbac8050f17ec0f855f28598d20) 方法查询当前呼叫邀请的有关状态；被叫可以通过 SDK 返回的 [RemoteInvitation](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_remote_invitation.html) 对象的 [getState](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/interfaceio_1_1agora_1_1rtm_1_1_remote_invitation.html#af77a4afabb19ff1468edf29720361a0f) 方法查询当前呼叫邀请的相关状态。

### LocalInvitationState 

下图描述了与主叫相关的呼叫邀请状态流转图：

![](https://web-cdn.agora.io/docs-files/1582270646018)

### RemoteInvitationState 

下图描述了与被叫相关的呼叫邀请状态流转图：

![](https://web-cdn.agora.io/docs-files/1582270656158)

## API 时序图

### 取消已发送呼叫邀请

![](https://web-cdn.agora.io/docs-files/1565426396109)

### 接受／拒绝呼叫邀请

![](https://web-cdn.agora.io/docs-files/1565427974586)

## 注意事项及限制条件

- 主叫设置的呼叫邀请 content 的字符串长度：8 KB，格式为 UTF-8。
- 被叫设置的呼叫邀请响应 response 的字符串长度：8 KB，格式为 UTF-8。
- 呼叫邀请的 channel ID 仅用于与老信令互通时设置。设置的 channel ID 必须与老信令 SDK 设置相同才能实现互通。字符串长度：64 字节，格式为 UTF-8。



## API 参考

详见：[呼叫邀请管理](https://docs.agora.io/cn/Real-time-Messaging/API%20Reference/RTM_java_linux/index.html#callinvitation)。