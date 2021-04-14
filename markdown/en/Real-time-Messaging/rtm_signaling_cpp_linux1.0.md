---
title: Signaling vs. Agora RTM SDK
platform: Linux CPP
updatedAt: 2019-10-09 18:25:42
---
This page compares the legacy Agora Signaling APIs with the Agora Real-time Messaging APIs. 

## Login & Logout

| Method                 | Signaling                              | Real-time Messaging                  |
| ---------------------- | -------------------------------------- | ------------------------------------ |
| Creates an instance.   | `getInstance`/`createAgoraSDKInstance` | [createRtmService](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1base_1_1_i_agora_service.html#ae3dae3b461aed1b826e5162479530ff1)<sup>1</sup>       |
| Sets a callback.       | `callbackSet`                          | N/A                                  |
| Login                  | `login`/`login2`                       | [login](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a2433a0babbed76ab87084d131227346b)<sup>2</sup>                  |
| Logout                 | `logout`                               | [logout](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a24feb518a0bd4c22133f6d42f5a84d03)                             |
| Gets the login status. | `getStatus`                            | N/A. See [onConnectionStateChanged](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#aa2e25e87c6f06cfd71b3538786d23743). |
| Destroys the instance. | `destroy`                              | [release](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a6c1cf5a9f13640a4bbaaa4fdd2545200)                            |

| Event                     | Signaling             | Real-time Messaging        |
| ------------------------- | --------------------- | -------------------------- |
| Login succeeds.           | `onLoginSuccess`      | [onLoginSuccess](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a8cf1b2be30172004f595484e0a194d76)           |
| Login Fails.              | `onLoginFailed`       | [onLoginFailure](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a4070957075f00a9a54ed60290838fec4)           |
| Logout results.           | `onLogout`            | [onLogout](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a63250f876c60b52d278b43b8b2f0b1de)                 |
| Connection state changes. | N/A. See `getStatus`. | [onConnectionStateChanged](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#aa2e25e87c6f06cfd71b3538786d23743) |

> - Unless otherwise specified, most of the core APIs of the Agora RTM Android SDK should only be called after the [login](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a2433a0babbed76ab87084d131227346b) method call succeeds and after you receive the [onLoginSuccess](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a8cf1b2be30172004f595484e0a194d76) callback.
> - <sup>1</sup> You can create multiple IRtmService instances with the [createRtmService](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1base_1_1_i_agora_service.html#ae3dae3b461aed1b826e5162479530ff1) method. The Agora RTM SDK does not put a limit to the number of IRtmService instances you can create, but it only allows you to join a maximum of 20 channels at the same time. 
> - <sup>2</sup> The generation of the token you use to log in the Agora RTM system differs from the generation of the signalingToken you use to log in the Agora Signaling system. Ensure that you use the right token. See [Token Security](/en/Real-time-Messaging/RTM_key?platform=All%20Platforms) for more information.
> - <sup>2</sup> The token debugging mechanism, "\_no\_need\_token" for example, of the Agora Signaling SDK does not apply to the Agora RTM SDK. 
> - <sup>2</sup> The way that the Agora RTM SDK connects or reconnects to the Agora RTM system is completely different either. For more information, see [Manage Connection States](/en/Real-time-Messaging/RTM_reconnecting_android?platform=Android) for more information. 

## Sending a peer-to-peer message

| Method                        | Signaling            | Real-time Messaging         |
| ----------------------------- | -------------------- | --------------------------- |
| Creates a message instance.   | N/A                  | [createMessage](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#acbbfe84bc22fd161ec5dc4fe098a59ce)<sup>1</sup> |
| Sends a peer-to-peer message. | `messageInstantSend` | [sendMessageToPeer](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a08c1b3d444af5a2778ede48e4c677a52)         |

| Event                                  | Signaling                 | Real-time Messaging               |
| -------------------------------------- | ------------------------- | --------------------------------- |
| Peer-to-peer message sending succeeds. | `onMessageSendSuccess`    | [onSendMessageResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a533a658eac8e2567df79478fb1041c5c)<sup>2</sup> |
| Peer-to-peer message sending fails.    | `onMessageSendError`      | [onSendMessageResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a533a658eac8e2567df79478fb1041c5c)             |
| Receives a peer-to-peer message        | `onMessageInstantReceive` | [onMessageReceivedFromPeer](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#afaf1e899bc3d39dbe33f7fa769897c9a)       |

> <sup>1</sup> With the Agora RTM SDK, you must create a message instance before sending it. A message instance can be used either for a peer-to-peer or for a channel message. As of v0.9.3, the Agora RTM SDK allows you to send an offline message by configuring [SendMessageOptions](/en/Real-time-Messaging/API%20Reference/RTM_cpp/structagora_1_1rtm_1_1_send_message_options.html).
>
> <sup>2</sup> The Agora Signaling SDK returns the `onMessageSendSuccess` callback when the server receives the peer-to-peer message; the Agora RTM SDK returns the [onSendMessageResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a533a658eac8e2567df79478fb1041c5c) callback when the specified user receives the message. 

## Querying the online status of specified user(s)

| Method                                         | Signaling         | Real-time Messaging      |
| ---------------------------------------------- | ----------------- | ------------------------ |
| Queries the online status of a specified user. | `queryuserStatus` | [queryPeersOnlineStatus](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a3add0055c4455dc8d04bfc37edfd8e94) |



| Event                            | Signaling                 | Real-time Messaging              |
| -------------------------------- | ------------------------- | -------------------------------- |
| Returns the result of the query. | `OnQueryUserStatusResult` | [onQueryPeersOnlineStatusResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a782b4623d4dcbac5c99fd6a12c42f578) |

> With the Agora RTM SDK,  you can query the online status of a list of peer users, not of just one peer user.

## user-Attribute Operations

| Method                                              | Signaling        | Real-time Messaging                   |
| --------------------------------------------------- | ---------------- | ------------------------------------- |
| Sets the local user's attribute                     | `setAttr`        | [addOrUpdateLocalUserAttributes](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a0a63923bd1e81e60d6ca54213a329747)      |
| Gets an attribute of the local user.                | `getAttr`        | [getUserAttributesByKeys](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#af011235917c291df5581f92afa35532f)<sup>1</sup> |
| Gets all attributes of the local user.              | `getAttrAll`     | [getUserAttributes](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a14cac887f9adb390621dd0427092a65b)<sup>2</sup>       |
| Gets all attributes of the specified user.          | `getUserAttrAll` | [getUserAttributes](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a14cac887f9adb390621dd0427092a65b)                   |
| Replaces the local user's attributes with new ones. | N/A              | [setLocalUserAttributes](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a86dcbfc38c665be8565f06c534338d33)              |
| Deletes the specified attributes of the local user. | N/A              | [deleteLocaluserAttributeByKeys](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#acb669f6c4c28e08cdf889df11e1ddeb3)      |
| Clears the local user's attributes                  | N/A              | [clearLocalUserAttributes](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#acc5eee875f4166fe455cde7aff1ad738)            |
|                                                     |                  |                                       |

| Event                                                 | Signaling               | Real-time Messaging                                          |
| ----------------------------------------------------- | ----------------------- | ------------------------------------------------------------ |
| Returns the result of the user-attribute method call. | `onUserAttributeResult` | <li>[onSetLocalUserAttributesResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#ac01ea1ff17082bbf3c8cfbaccef4dfe8) <li> [onAddOrUpdateLocalUserAttributesResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#ab21ea7e02361debe4ebbf558cc80f268) <li> [onDeleteLocalUserAttributesResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a2b98a102d2bb9664552e30d257679887) <li> [onClearLocalUserAttributesResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a94bbff8cdfee2ee306d66f73c1a29aa3) <li> [onGetUserAttributesResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a76058e05b9a623645ba05ea1d1796007) |

> - <sup>1</sup> The [getuserAttributesBykeys](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#af011235917c291df5581f92afa35532f) method allows you to retrieve a list of attributes from the local user.
> - <sup>2</sup> The [getUserAttributes(/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a14cac887f9adb390621dd0427092a65b) method allows you to retrieve the attributes from either the local user or a specified peer user. 

## Joining or Leaving a Channel

| Method                      | Signaling      | Real-time Messaging         |
| --------------------------- | -------------- | --------------------------- |
| Creates a channel instance. | N/A            | [createChannel](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a0196e60ee165f6c97f561cf71499d377)<sup>1</sup> |
| Joins a specified channel.  | `channelJoin`  | [join](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a6a54cdd8e5db526514e0ca84aa9cba4c)<sup>2</sup>          |
| Leaves a channel.           | `channelLeave` | [leave](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#ae7eb3e8d0bb5d547fc8b705446a92f91)                     |

| Event                                                   | Signaling             | Real-time Messaging |
| ------------------------------------------------------- | --------------------- | ------------------- |
| Successfully joins the specified channel.               | `onChannelJoined`     | [onJoinSuccess](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a361966f42e09627268734e43b1f7edb2)     |
| Fails to join the specified channel                     | `onChannelJoinFailed` | [onJoinFailure](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#aee257d37a2fe9a0dedde08a38d4fd356)     |
| A remote user joins the current channel.                | `onChannelUserJoined` | [onMemberJoined](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a57a5d0e1a084c75e3c0ace3a99090fbd)    |
| Successfully leaves the current channel.                | `onChannelLeaved`     | [onLeave](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#acd127e2282aaf719241f3527c8252070)           |
| A remote channel member leaves the current channel.     | `onChannelUserLeaved` | [onMemberLeft](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#ae657b3507830a8162dc3a046dae2e60b)      |
| Returns a channel member list when joining the channel. | `onChannelUserList`   | N/A<sup>3</sup>     |
|                                                         |                       |                     |

> - <sup>1</sup> The Agora RTM SDK requires you to create a channel instance before joining it. 
> - <sup>2</sup> The Agora RTM SDK allows you to join a maximum of 20 channels at the same time. 
> - <sup>3</sup> The Agora RTM SDK does not return to the user a member list of the channel when he/she successfully joins it. 

## Sending a channel message

| Method                                          | Signaling                 | Real-time Messaging         |
| ----------------------------------------------- | ------------------------- | --------------------------- |
| Creates a message instance.                     | N/A                       | [createMessage](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#acbbfe84bc22fd161ec5dc4fe098a59ce)<sup>1</sup> |
| Sends a channel message from within a channel.  | `messageChannelSend`      | [sendMessage](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a4ae01f44d49f334f7c2950d95f327d30)<sup>2</sup>   |
| Sends a channel message from outside a channel. | `messageChannelSendForce` | N/A                         |



| Event                                     | Signaling                 | Real-time Messaging             |
| ----------------------------------------- | ------------------------- | ------------------------------- |
| Successfully sends out a channel message. | `onMessageSendSuccess`    | [onSendMessageResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a4ba5dd414b2164d5a3693032b64c64e3)           |
| Fails to send out a channel message.      | `onMessageSendError`      | [onSendMessageResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a4ba5dd414b2164d5a3693032b64c64e3)           |
| Receives a channel message.               | `onMessageChannelReceive` | [onMessageReceived](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#aabe8e78b46553645640479b862f2cae2)<sup>3</sup> |



> - <sup>1</sup> With the Agora RTM SDK, you must create a message instance before sending out a peer-to-peer or channel message. 
> - <sup>2</sup> The Agora RTM SDK does not support sending channel messages from outside a channel. That said, you must join a channel before being able to send out a channel message. 
> - <sup>3</sup> The [onMessageReceived](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#aabe8e78b46553645640479b862f2cae2) callback is returned to the remote channel members, not to the message sender. 

## CHANNEL-ATTRIBUTE OPERATIONS

| Method                               | Signaling          | Real-time Messaging |
| ------------------------------------ | ------------------ | ------------------- |
| Sets a channel attribute.            | `channelSetAttr`   | N/A                 |
| Deletes a channel attribute.         | `channelDelAttr`   | N/A                 |
| Deletes all attributes of a channel. | `channelClearAttr` | N/A                 |

> The Agora RTM SDK will support channel-attribute operations in release v1.1. 

| Event                           | Signaling              | Real-time Messaging |
| ------------------------------- | ---------------------- | ------------------- |
| A channel attribute is updated. | `onChannelAttrUpdated` | N/A                 |



## Retrieving a member list of the current channel

| Method                                                 | Signaling | Real-time Messaging      |
| ------------------------------------------------------ | --------- | ------------------------ |
| Retrieves the latest user list of a specified channel. | `invoke`  |[getMembers](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel.html#a3f9c943059ac48a568c81798da38c3cb)<sup>1</sup> |



| Event                                         | Signaling     | Real-time Messaging |
| --------------------------------------------- | ------------- | ------------------- |
| Returns the user list in a specified channel. | `onInvokeRet` | [onGetMembers](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_channel_event_handler.html#a5e3f5a5ae0b3861de2f0310841ad0b37)      |

> <sup>1</sup> You must join an IChannel before retrieving a member list of it. When the number of the channel members exceeds 512, the Agora RTM SDK only returns a list of randomly selected 512 channel members. 



## Retrieving the Number of Users in a Specified Channel

| Method                                                | Signaling             | Real-time Messaging |
| ----------------------------------------------------- | --------------------- | ------------------- |
| Retrieves the number of users in a specified channel. | `channelQueryUserNum` | N/A                 |



| Event                                               | Signaling                     | Real-time Messaging |
| --------------------------------------------------- | ----------------------------- | ------------------- |
| Returns the number of users in a specified channel. | `onChannelQueryUserNumResult` | N/A                 |

> The Agora RTM SDK v1.1 will support this feature. 

## Call Invitation



| Method                                                       | Signaling                                | Real-time Messaging                     |
| ------------------------------------------------------------ | ---------------------------------------- | --------------------------------------- |
| Gets an RTM call manager.                                    | N/A                                      | [getRtmCallManager](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ab59de9a4c6b31f97ced87a7c5a708007)<sup>1</sup>         |
| Allows the caller to create and manage a `LocalInvitation.`  | N/A                                      | [createLocalCallInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#a71f1d4f359e62f0a2ed83d19a69dd095)<sup>2</sup> |
| Allows the caller to send a call invite to a specified user (callee). | `channelInviteUser`/`channelInviteUser2` | [sendLocalInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#a5d1ea87573a3e65ded0886f42aefd445)<sup>3</sup>       |
| Allows the caller to send a call invite to land-line user.   | `channelInviteDTMF`                      | N/A                                     |
| Allows the caller to cancel a sent call invite.              | `channelInviteEnd`                       | [cancelLocalInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#ab92d7383de69eff8d8dbcc19114751bc)<sup>4</sup>     |
| Allows the callee to accept an incoming call invite.         | `channelInviteAccept`                    | [acceptRemoteInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#ac97ae6e4f8f7f3add980fdd15f9c47ba)                |
| Allows the callee to decline an incoming call invite.        | `channelInviteRefuse`                    | [refuseRemoteInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#ab6ca977d3075800ec014fa536622f2ff)                |
|                                                              |                                          |                                         |

> - <sup>1</sup> With the Agora RTM SDK, either a caller or a callee needs to get an [IRtmCallManager](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#ab59de9a4c6b31f97ced87a7c5a708007) instance before using its object methods to send, cancel, accept, or decline a call invite. 
> - <sup>2</sup> The Agora RTM SDK introduces the [ILocalInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_local_call_invitation.html) object and the [IRemoteInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_remote_call_invitation.html) object. The former is created by the caller using the [createLocalCallInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#a71f1d4f359e62f0a2ed83d19a69dd095) method, the latter is created automatically by the SDK when the callee receives the call invitation from the caller. You can take the two objects as the same call invitation taking in two different forms. The caller uses the [ILocalInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_local_call_invitation.html) object to specify the callee, set the content, or check the [LOCAL_INVITATION_STATE](/en/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a52b3ccc8e0807be99aed9a309f4a6bf6); the callee uses the [IRemoteInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_remote_call_invitation.html) object to set a response, check the caller ID, or check the [REMOTE_INVITATION_STATE](/en/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a8dcc0f37c3d22418ba75133999820af6). 
> - <sup>3</sup> The [sendLocalInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#a5d1ea87573a3e65ded0886f42aefd445) method does not has an `extra` argument as the `channelInviteUser2` method does. 
> - <sup>4</sup> The `channelInviteEnd` method can end a call invite any time, whilst the [cancelLocalInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#ab92d7383de69eff8d8dbcc19114751bc) method can only cancel a sent and ongoing call invite. 
> - To intercommunicate with the Agora Signaling SDK, you must upgrade your Agora RTM SDK to v1.0+ and set the channel ID.  Please also note that even if the callee accepts the call invite, the Agora RTM SDK does not add either the caller or the callee to the specified channel. 
> -  If a user calls [sendLocalInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#a5d1ea87573a3e65ded0886f42aefd445), [cancelLocalInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#ab92d7383de69eff8d8dbcc19114751bc), [acceptRemoteInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#ac97ae6e4f8f7f3add980fdd15f9c47ba) or [refuseRemoteInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_manager.html#ab6ca977d3075800ec014fa536622f2ff) before the life cycle of an [ILocalInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_local_call_invitation.html) starts or after the life cycle of an [IRemoteInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_remote_call_invitation.html) ends (either in failure or in success), the SDK returns the [INVITATION_API_CALL_ERR_CODE](/en/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#a699db038c2078a6cc2d80bd3b0a39acb) error code. 



| Event                                                        | Signaling                | Real-time Messaging                                          |
| ------------------------------------------------------------ | ------------------------ | ------------------------------------------------------------ |
| Returns to the caller: the callee receives the call invite.  | `oninviteReceivedByPeer` | [onLocalInvitationReceivedByPeer](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a0bce0b48810aea30bb057f2722c555ca)                            |
| Returns to the caller: the call invite successfully cancelled. | `onInviteEndByMyself`    | [onLocalInvitationCanceled](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#ac97269b4f483946456a3d0f9aabaf1e1)                                  |
| Returns to the caller: call invite accepted.                 | `onInviteAcceptedByPeer` | [onLocalInvitationAccepted](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a55e4dcc83699c4d2a17521e0c0dfdf30)                                  |
| Returns to the caller: call invite declined.                 | `onInviteRefusedByPeer`  | [onLocalInvitationRefused](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a5c87e054ec1c004fd11e721033a2359c)                                   |
| Returns to the caller: the outgoing call invite ends in failure. | `onInviteFailed`         | [onLocalInvitationFailure](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a34e366966b97603289288f229c83e2af). See [LOCAL_INVITATION_ERR_CODE](/en/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#aa83fb27d8066fb5aa6e591e5964edadc) for the error codes. <sup>5</sup> |
|                                                              |                          |                                                              |

> <sup>5</sup>: The SDK returns the [onLocalInvitationFailure](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a34e366966b97603289288f229c83e2af) to the caller if the call invitation process has started but ends in failure. Scenarios include: the callee is offline, the [ILocalCallInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_local_call_invitation.html) object times out, the [ILocalCallInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_local_call_invitation.html) object expires, and the callee receives the call invitation but fails to respond in time. 

| Event                                                   | Signaling           | Real-time Messaging                                          |
| ------------------------------------------------------- | ------------------- | ------------------------------------------------------------ |
| Returns to the land-line user: receives a call invite.  | `onInviteMsg`       | N/A                                                          |
| Returns to the callee: receives a call invite.          | `oninviteReceived`  | [onRemoteInvitationReceived](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#ad206023cad15b8a4b15d6465a6425a89)                                 |
| Returns to the callee: the caller cancels the invite.   | `onInviteEndByPeer` | [onRemoteInvitationCanceled](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a094f89aaa7d7eeb928fe90f537a6680b)                                 |
| Returns to the callee: call invite accepted.            | N/A                 | [onRemoteInvitationAccepted](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a3edc69d558bead97f882de0147df449e)                                 |
| Returns to the callee: call invite declined.            | N/A                 | [onRemoteInvitationRefused](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#aaf8ce8c0810625efd29e61bad19a98ad)                                  |
| Returns to the callee: the call invite ends in failure. | N/A                 | [onRemoteInvitationFailure](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a25af8d459354093f18580a41c64bbbf4). See [REMOTE_INVITATION_ERR_CODE](/en/Real-time-Messaging/API%20Reference/RTM_cpp/namespaceagora_1_1rtm.html#aedb89e7145338eb7a1b05df69f31e26f) for the error codes. <sup>6</sup> |
|                                                         |                     |                                                              |

> <sup>6</sup> The SDK returns the [onRemoteInvitationFailure](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_call_event_handler.html#a25af8d459354093f18580a41c64bbbf4) to the callee if the call invitation process has started but ends in failure. Scenarios include: the caller is offline, the [IRemoteCallInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_remote_call_invitation.html) object times out, and the [IRemoteCallInvitation](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_remote_call_invitation.html) ojbect expires. 

## Renewing a Token



| Method                    | Signaling | Real-time Messaging |
| ------------------------- | --------- | ------------------- |
| Renews the current Token. | N/A       | [renewToken](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service.html#a2c33be67bfec02d69041f1e8978f4559)        |



| Event                                  | Signaling | Real-time Messaging  |
| -------------------------------------- | --------- | -------------------- |
| Returns the result of the method call. | N/A       | [onRenewTokenResult](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a9745d741bb077d7c6938b42da045cfe5) |
| The token has expired.                 | N/A       | [onTokenExpired](/en/Real-time-Messaging/API%20Reference/RTM_cpp/classagora_1_1rtm_1_1_i_rtm_service_event_handler.html#a779fdd499d4322eef743f4eda2cc7fee)     |