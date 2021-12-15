---
title: 信令 与 RTM 功能对照表
platform: Linux CPP
updatedAt: 2019-10-09 20:41:48
---

本页对比 Agora Signaling SDK 与 Agora RTM SDK 的区别。

## 登录登出

| 方法         | 信令                                   | RTM 实时消息                                                                                                                                                                   |
| ------------ | -------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 创建实例     | `getInstance`/`createAgoraSDKInstance` | [createRtmService](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1base_1_1_i_agora_service.html#ae3dae3b461aed1b826e5162479530ff1)<sup>1</sup>                  |
| 设置回调对象 | `callbackSet`                          | N/A                                                                                                                                                                            |
| 登录         | `login`/`login2`                       | [login](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a2433a0babbed76ab87084d131227346b)<sup>2</sup>                                |
| 登出         | `logout`                               | [logout](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a24feb518a0bd4c22133f6d42f5a84d03)                                           |
| 获取登录状态 | `getStatus`                            | N/A。详见 [onConnectionStateChanged](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#aa2e25e87c6f06cfd71b3538786d23743) |
| 销毁实例     | `destroy`                              | [release](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a6c1cf5a9f13640a4bbaaa4fdd2545200)                                          |

| 事件         | 信令                  | RTM 实时消息                                                                                                                                                         |
| ------------ | --------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 登录成功     | `onLoginSuccess`      | [onLoginSuccess](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a8cf1b2be30172004f595484e0a194d76)           |
| 登录失败     | `onLoginFailed`       | [onLoginFailure](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a4070957075f00a9a54ed60290838fec4)           |
| 登出结果     | `onLogout`            | [onLogout](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a63250f876c60b52d278b43b8b2f0b1de)                 |
| 连接状态改变 | N/A。详见 `getStatus` | [onConnectionStateChanged](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#aa2e25e87c6f06cfd71b3538786d23743) |

> - 若无特别说明，Agora RTM Android SDK 的所有核心 API 都应在调用 [login](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a2433a0babbed76ab87084d131227346b) 方法成功并收到 [onLoginSuccess](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a8cf1b2be30172004f595484e0a194d76) 回调后调用。Agora Signaling SDK 只允许你每次进入一个频道。
> - <sup>1</sup> 你可以通过调用 [createRtmService](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1base_1_1_i_agora_service.html#ae3dae3b461aed1b826e5162479530ff1) 方法创建多个 IRtmService 实例。Agora RTM SDK 不会限制你创建 IRtmService 实例的个数，但某个 IRtmService 实例最多只能同时加入 20 个 IChannel 频道。
> - <sup>2</sup> RTM 的 Token 生成方式与老信令的 Token 生成方式完全不同。详见[校验用户权限](/cn/Real-time-Messaging/RTM_key?platform=All%20Platforms)。
> - <sup>2</sup> 信令 Token 采用的 "\_no_need_token" 机制不适用于 RTM Token。
> - <sup>2</sup> Agora RTM SDK 连接或重连 Agora RTM 系统的方式也完全不同。详情请见[连接状态管理](/cn/Real-time-Messaging/RTM_reconnecting_cpp?platform=Linux%20CPP)。

## 发送点对点消息

| 方法           | 信令                 | RTM 实时消息                                                                                                                                            |
| -------------- | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 创建消息实例   | N/A                  | [createMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#acbbfe84bc22fd161ec5dc4fe098a59ce)<sup>1</sup> |
| 发送点对点消息 | `messageInstantSend` | [sendMessageToPeer](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a08c1b3d444af5a2778ede48e4c677a52)         |

| 事件               | 信令                      | RTM 实时消息                                                                                                                                                                |
| ------------------ | ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 点对点消息发送成功 | `onMessageSendSuccess`    | [onSendMessageResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a533a658eac8e2567df79478fb1041c5c)<sup>2</sup> |
| 点对点消息发送失败 | `onMessageSendError`      | [onSendMessageResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a533a658eac8e2567df79478fb1041c5c)             |
| 收到一条点对点消息 | `onMessageInstantReceive` | [onMessageReceivedFromPeer](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#afaf1e899bc3d39dbe33f7fa769897c9a)       |

> <sup>1</sup> 使用 Agora RTM SDK 发送消息之前你必须创建一个消息实例。消息实例既适用于点对点消息也适用于频道消息。Agora RTM SDK 自版本 v0.9.3 起支持通过设置 [SendMessageOptions](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/structagora_1_1rtm_1_1_send_message_options.html) 发送点对点的离线消息。
>
> <sup>2</sup> Agora Signaling SDK 会在服务端收到点对点消息时返回 `onMessageSendSuccess` 回调而 Agora RTM SDK 会在指定用户收到点对点消息后返回 [onSendMessageResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a533a658eac8e2567df79478fb1041c5c) 回调。

## 查询指定用户的在线状态

| 方法                   | 信令              | RTM 实时消息                                                                                                                                         |
| ---------------------- | ----------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| 查询指定用户的在线状态 | `queryuserStatus` | [queryPeersOnlineStatus](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3add0055c4455dc8d04bfc37edfd8e94) |

| 事件         | 信令                      | RTM 实时消息                                                                                                                                                               |
| ------------ | ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 返回查询结果 | `OnQueryUserStatusResult` | [onQueryPeersOnlineStatusResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a782b4623d4dcbac5c99fd6a12c42f578) |

> Agora RTM SDK 允许你查询一组用户的在线状态，而不只一个用户的在线状态。

## 用户属性相关操作

| 方法                       | 信令             | RTM 实时消息                                                                                                                                                      |
| -------------------------- | ---------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 设置本地用户属性           | `setAttr`        | [addOrUpdateLocalUserAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a0a63923bd1e81e60d6ca54213a329747)      |
| 获取本地用户的某个属性     | `getAttr`        | [getUserAttributesBykeys](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#af011235917c291df5581f92afa35532f)<sup>1</sup> |
| 获取本地用户的全部属性     | `getAttrAll`     | [getUserAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a14cac887f9adb390621dd0427092a65b)<sup>2</sup>       |
| 获取指定用户的某个属性     | `getUserAttrAll` | [getUserAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a14cac887f9adb390621dd0427092a65b)                   |
| 全量替换本地用户的全部属性 | N/A              | [setLocalUserAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a86dcbfc38c665be8565f06c534338d33)              |
| 删除本地用户的指定属性     | N/A              | [deleteLocaluserAttributeByKeys](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#acb669f6c4c28e08cdf889df11e1ddeb3)      |
| 清空本地用户全部属性       | N/A              | [clearLocalUserAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#acc5eee875f4166fe455cde7aff1ad738)            |
|                            |                  |                                                                                                                                                                   |

| 事件                   | 信令                    | RTM 实时消息                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| ---------------------- | ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 返回用户属性相关的结果 | `onUserAttributeResult` | <li>[onSetLocalUserAttributesResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#ac01ea1ff17082bbf3c8cfbaccef4dfe8) <li> [onAddOrUpdateLocalUserAttributesResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#ab21ea7e02361debe4ebbf558cc80f268) <li> [onDeleteLocalUserAttributesResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a2b98a102d2bb9664552e30d257679887) <li> [onClearLocalUserAttributesResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a94bbff8cdfee2ee306d66f73c1a29aa3) <li> [onGetUserAttributesResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a76058e05b9a623645ba05ea1d1796007) |

> - <sup>1</sup> [getuserAttributesBykeys](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#af011235917c291df5581f92afa35532f) 方法允许你获取本地用户的一系列属性。
> - <sup>2</sup> [getUserAttributes](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a14cac887f9adb390621dd0427092a65b) 方法允许你获取本地用户或指定远端用户的用户属性。

## 加入离开频道相关

| 方法         | 信令           | RTM 实时消息                                                                                                                                            |
| ------------ | -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 创建频道实例 | N/A            | [createChannel](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a0196e60ee165f6c97f561cf71499d377)<sup>1</sup> |
| 加入指定频道 | `channelJoin`  | [join](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a6a54cdd8e5db526514e0ca84aa9cba4c)<sup>2</sup>              |
| 离开频道     | `channelLeave` | [leave](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#ae7eb3e8d0bb5d547fc8b705446a92f91)                         |

| 事件                       | 信令                  | RTM 实时消息                                                                                                                                              |
| -------------------------- | --------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 成功加入指定频道           | `onChannelJoined`     | [onJoinSuccess](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a361966f42e09627268734e43b1f7edb2)     |
| 加入指定频道失败           | `onChannelJoinFailed` | [onJoinFailure](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a4070957075f00a9a54ed60290838fec4) |
| 远端用户加入当前频道       | `onChannelUserJoined` | [onMemberJoined](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a57a5d0e1a084c75e3c0ace3a99090fbd)    |
| 成功离开当前频道           | `onChannelLeaved`     | [onLeave](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#acd127e2282aaf719241f3527c8252070)           |
| 远端频道成员离开当前频道   | `onChannelUserLeaved` | [onMemberLeft](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#ae657b3507830a8162dc3a046dae2e60b)      |
| 加入频道时返回频道成员列表 | `onChannelUserList`   | N/A<sup>3</sup>                                                                                                                                           |

> - <sup>1</sup> Agora RTM SDK 要求你在加入频道前先创建频道实例。
> - <sup>2</sup> Agora RTM SDK 允许你最多同时加入 20 个频道。
> - <sup>3</sup> Agora RTM SDK 不会在用户成功加入频道时返回当前频道成员列表。
> - Agora RTM SDK 不支持特殊频道功能。

## 频道消息

| 方法                 | 信令                      | RTM 实时消息                                                                                                                                            |
| -------------------- | ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 创建消息实例         | N/A                       | [createMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#acbbfe84bc22fd161ec5dc4fe098a59ce)<sup>1</sup> |
| 从频道内发送频道消息 | `messageChannelSend`      | [sendMessage](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a4ae01f44d49f334f7c2950d95f327d30)<sup>2</sup>       |
| 从频道外发送频道消息 | `messageChannelSendForce` | N/A                                                                                                                                                     |

| 事件             | 信令                      | RTM 实时消息                                                                                                                                                          |
| ---------------- | ------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 频道消息发送成功 | `onMessageSendSuccess`    | [onSendMessageResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a4ba5dd414b2164d5a3693032b64c64e3)           |
| 频道消息         | `onMessageSendError`      | [onSendMessageResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a4ba5dd414b2164d5a3693032b64c64e3)           |
| 收到一条频道消息 | `onMessageChannelReceive` | [onMessageReceived](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#aabe8e78b46553645640479b862f2cae2)<sup>3</sup> |

> - <sup>1</sup> Agora RTM SDK 要求你在发送频道消息或点对点消息之前必须创建一个消息实例。
> - <sup>2</sup> Agora RTM SDK 暂不支持从频道外发送频道消息。也就是说，你必须加入频道才能向其他频道成员发送频道消息。
> - <sup>3</sup> 与 Agora Signaling SDK 的行为不同，[onMessageReceived](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#aabe8e78b46553645640479b862f2cae2) 回调返回给频道内的其他频道成员，而非返回给发送人。

## 频道属性相关

| 方法                 | 信令               | RTM 实时消息 |
| -------------------- | ------------------ | ------------ |
| 设置一条频道属性     | `channelSetAttr`   | N/A          |
| 删除一条频道属性     | `channelDelAttr`   | N/A          |
| 删除频道的全部属性。 | `channelClearAttr` | N/A          |

> Agora RTM SDK v1.1 将支持频道属性相关操作。

| 事件           | 信令                   | RTM 实时消息 |
| -------------- | ---------------------- | ------------ |
| 频道属性已更新 | `onChannelAttrUpdated` | N/A          |

## 获取当前频道用户列表

| 方法                   | 信令     | RTM 实时消息                                                                                                                                     |
| ---------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| 获取指定频道的成员列表 | `invoke` | [getMembers](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a3f9c943059ac48a568c81798da38c3cb)<sup>1</sup> |

| 事件                   | 信令          | RTM 实时消息                                                                                                                                         |
| ---------------------- | ------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| 返回指定频道的成员列表 | `onInvokeRet` | [onGetMembers](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a5e3f5a5ae0b3861de2f0310841ad0b37) |

> <sup>1</sup> 你必须加入一个 RtmChannel 频道后才能获取该频道的成员列表。当频道人员超过 512 人上限，Agora RTM SDK 会随机返回频道内的 512 个当前频道成员。

## 获取指定频道用户人数

| 方法                 | 信令                  | RTM 实时消息 |
| -------------------- | --------------------- | ------------ |
| 获取指定频道成员人数 | `channelQueryUserNum` | N/A          |

| 事件                   | 信令                          | RTM 实时消息 |
| ---------------------- | ----------------------------- | ------------ |
| 返回指定频道的用户人数 | `onChannelQueryUserNumResult` | N/A          |

> Agora RTM SDK v1.1 将支持该功能。

## 呼叫邀请

| 方法                                          | 信令                                     | RTM 实时消息                                                                                                                                                             |
| --------------------------------------------- | ---------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 创建 RTM 呼叫管理器                           | N/A                                      | [getRtmCallManager](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ab59de9a4c6b31f97ced87a7c5a708007)<sup>1</sup>              |
| 供主叫创建并管理一个 `LocalInvitation` 实例。 | N/A                                      | [createLocalCallInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#a71f1d4f359e62f0a2ed83d19a69dd095)<sup>2</sup> |
| 供主叫向指定用户（被叫）发送呼叫邀请          | `channelInviteUser`/`channelInviteUser2` | [sendLocalInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#a5d1ea87573a3e65ded0886f42aefd445)<sup>3</sup>       |
| 供主叫发送 DTMF 呼叫邀请。                    | `channelInviteDTMF`                      | N/A                                                                                                                                                                      |
| 供主叫取消一个发出的呼叫邀请                  | `channelInviteEnd`                       | [cancelLocalInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#ab92d7383de69eff8d8dbcc19114751bc)<sup>4</sup>     |
| 供被叫接收一个呼叫邀请                        | `channelInviteAccept`                    | [acceptRemoteInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#ac97ae6e4f8f7f3add980fdd15f9c47ba)                |
| 供被叫拒绝一个呼叫邀请                        | `channelInviteRefuse`                    | [refuseRemoteInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#ab6ca977d3075800ec014fa536622f2ff)                |

> - <sup>1</sup> Agora RTM SDK 要求主叫或被叫在发送、取消、接收或拒绝一个呼叫邀请前必须创建一个 [IRtmCallManager](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ab59de9a4c6b31f97ced87a7c5a708007) 实例。
> - <sup>2</sup> Agora RTM SDK 引入了 [ILocalInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_local_call_invitation.html) 和 [IRemoteInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_remote_call_invitation.html) 对象。前者由主叫通过调用 [createLocalCallInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#a71f1d4f359e62f0a2ed83d19a69dd095) 方法创建，后者在被叫收到呼叫邀请时由 SDK 自动创建。你可以将这两个对象理解为同一个呼叫邀请的两种不同形式。主叫通过 [ILocalInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_local_call_invitation.html) 对象指定被叫，设置自定义内容或检查 [LOCAL_INVITATION_STATE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a52b3ccc8e0807be99aed9a309f4a6bf6) 状态，被叫通过 [IRemoteInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_remote_call_invitation.html) 对象设置响应内容，检查主叫 ID，或者检查 [REMOTE_INVITATION_STATE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a8dcc0f37c3d22418ba75133999820af6) 状态。
> - <sup>3</sup> [sendLocalInvitation(/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#a5d1ea87573a3e65ded0886f42aefd445) 函数不带 `channelInviteUser2` 函数中的 `extra` 参数。
> - <sup>4</sup> `channelInviteEnd` 方法可以在任意时间取消一个呼叫邀请，而 [cancelLocalInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#ab92d7383de69eff8d8dbcc19114751bc) 方法只能取消一个已发送的正在进行的呼叫邀请。
> - 为了和 Agora Signaling SDK 互通，你必须把你的 Agora RTM SDK 版本升级到 v1.0 以上并设置 channel ID。请注意即使被叫接收了呼叫邀请，Agora RTM SDK 也不会将主叫或被叫加入指定频道。
>   如果用户在 [ILocalInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_local_call_invitation.html) 生命周期开始之前或生命周期结束之后调用了 [sendLocalInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#a5d1ea87573a3e65ded0886f42aefd445)、 [cancelLocalInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#ab92d7383de69eff8d8dbcc19114751bc)、 [acceptRemoteInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#ac97ae6e4f8f7f3add980fdd15f9c47ba) 或 [refuseRemoteInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#ab6ca977d3075800ec014fa536622f2ff) ，Agora RTM SDK 会返回 [INVITATION_API_CALL_ERR_CODE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a699db038c2078a6cc2d80bd3b0a39acb) 错误码。

| 事件                           | 信令                     | RTM 实时消息                                                                                                                                                                                                                                                                                                                          |
| ------------------------------ | ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 返回给主叫：被叫已收到呼叫邀请 | `oninviteReceivedByPeer` | [onLocalInvitationReceivedByPeer](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a0bce0b48810aea30bb057f2722c555ca)                                                                                                                                                              |
| 返回给主叫：呼叫邀请已被取消   | `onInviteEndByMyself`    | [onLocalInvitationCanceled](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#ac97269b4f483946456a3d0f9aabaf1e1)                                                                                                                                                                    |
| 返回给主叫：被叫已接收呼叫邀请 | `onInviteAcceptedByPeer` | [onLocalInvitationAccepted](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a55e4dcc83699c4d2a17521e0c0dfdf30)                                                                                                                                                                    |
| 返回给主叫：被叫已拒绝呼叫邀请 | `onInviteRefusedByPeer`  | [onLocalInvitationRefused](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a5c87e054ec1c004fd11e721033a2359c)                                                                                                                                                                     |
| 返回给主叫：呼叫邀请过程失败   | `onInviteFailed`         | [onLocalInvitationFailure](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a34e366966b97603289288f229c83e2af)。错误码详见 [LOCAL_INVITATION_ERR_CODE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#aa83fb27d8066fb5aa6e591e5964edadc)。<sup>5</sup> |

> <sup>5</sup>: 如果呼叫邀请过程已经开始但以失败告终，Agora RTM SDK 会返回 [onLocalInvitationFailure](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a34e366966b97603289288f229c83e2af) 。场景包括：被叫离线，[ILocalCallInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_local_call_invitation.html) 对象发送超时 [ILocalCallInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_local_call_invitation.html) 过期，或者被叫收到了呼叫邀请但未能在指定时间内响应呼叫邀请。

| 事件                               | 信令                | RTM 实时消息                                                                                                                                                                                                                                                                                                                            |
| ---------------------------------- | ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 返回给 DTMF 用户：收到一个呼叫邀请 | `onInviteMsg`       | N/A                                                                                                                                                                                                                                                                                                                                     |
| 返回给被叫：收到一个呼叫邀请       | `oninviteReceived`  | [onRemoteInvitationReceived](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#ad206023cad15b8a4b15d6465a6425a89)                                                                                                                                                                     |
| 返回给被叫：主叫已取消呼叫邀请     | `onInviteEndByPeer` | [onRemoteInvitationCanceled](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a094f89aaa7d7eeb928fe90f537a6680b)                                                                                                                                                                     |
| 返回给被叫：已成功接受呼叫邀请     | N/A                 | [onRemoteInvitationAccepted](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a3edc69d558bead97f882de0147df449e)                                                                                                                                                                     |
| 返回给被叫：已拒绝呼叫邀请         | N/A                 | [onRemoteInvitationRefused](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#aaf8ce8c0810625efd29e61bad19a98ad)                                                                                                                                                                      |
| 返回给被叫：呼叫邀请过程失败       | N/A                 | [onRemoteInvitationFailure](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a25af8d459354093f18580a41c64bbbf4)。错误码详见 [REMOTE_INVITATION_ERR_CODE](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#aedb89e7145338eb7a1b05df69f31e26f)。<sup>6</sup> |

> <sup>6</sup> 如果呼叫邀请进程已经开始但以失败告终，Agora RTM SDK 会返回 [onRemoteInvitationFailure](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a25af8d459354093f18580a41c64bbbf4) 回调给被叫。通用场景包括：[IRemoteCallInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_remote_call_invitation.html) 发送超时或 [IRemoteCallInvitation](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_remote_call_invitation.html) 过期。

## 更新 Token

| 方法           | 信令 | RTM 实时消息                                                                                                                             |
| -------------- | ---- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 更新当前 Token | N/A  | [renewToken](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a2c33be67bfec02d69041f1e8978f4559) |

| 事件             | 信令 | RTM 实时消息                                                                                                                                                   |
| ---------------- | ---- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 返回方法调用结果 | N/A  | [onRenewTokenResult](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a9745d741bb077d7c6938b42da045cfe5) |
| Token 已过期     | N/A  | [onTokenExpired](/cn/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a779fdd499d4322eef743f4eda2cc7fee)     |
