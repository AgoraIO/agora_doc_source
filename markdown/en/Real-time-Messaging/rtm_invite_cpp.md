---
title: Call Invitation
platform: Windows C++
updatedAt: 2020-10-10 18:01:59
---
## Overview

The Agora RTM SDK supports the call invitation function, including the following behaviors in common call scenarios:

- Caller: Sends or cancels a call invitation.
- Callee: Accepts or refuses a call invitation.

![](https://web-cdn.agora.io/docs-files/1602314541995)

The call invitation function provided by the Agora RTM SDK only implements the basic control logic of the call invitation: sending, canceling, accepting, and refusing the call invitation. The Agora RTM SDK does not handle operations after a callee accepts the invitation, nor does it manage the entire lifecycle. You must implement that yourself according to your requirements.

The call invitation can be applied to the following scenarios:

- A call invitation requiring notification of an incoming call.
- A screen-sharing scenario requiring call invitations.
- A whiteboard-sharing scenario requiring a video call between two parties.
- A call invitation requiring synchronizing the states of both parties.

## Implementation

In a complete call invitation process, the call invitation states of the caller and the callee are defined by `LocalInvitation` and `RemoteInvitation,` respectively.

![](https://web-cdn.agora.io/docs-files/1602314550083)


### Send a call invitation

The steps to send a call invitation are as follows:

1. The caller creates the `LocalInvitation` by calling `createLocalInvitation`; at the same time, the lifecycle of the `LocalInvitation` begins.
2. The caller sends a call invitation by calling `sendLocalInvitation`. The lifecycle of the `RemoteInvitation` begins as the callee receives the `onRemoteInvitationReceived` callback, and then the caller receives the `onLocalInvitationReceivedByPeer` callback.

The sample code for sending a call invitation is as follows:

```
// The sample code is based on Qt.
 
// Get call manager.
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
		// Create the LocalInvitation.
    m_callInvitation = m_callManager->createLocalCallInvitation(remoteUserId.toUtf8());
    if(m_callInvitation){
		    // Send a call invitation.
        int ret = m_callManager->sendLocalInvitation(m_callInvitation);
        return ret == 0 ? true : false;
    }
    return false;
}
```



### Cancel a call invitation

The caller cancels the call invitation by calling `cancelLocalInvitation`. The lifecycle of the `RemoteInvitation` ends as the callee receives the `onRemoteInvitationCanceled` callback. And then the lifecycle of the `LocalInvitation` ends as the caller receives the `onLocalInvitationCanceled` callback.

![img](https://web-cdn.agora.io/docs-files/1598604387439)

The sample code for canceling a call invitation is as follows:

```
// The sample code is based on Qt.
 
 
// Cancel a call invitation.
bool CAgoraRtmInstance::CancelLocalInvitation()
{
    if(!m_callManager || !m_callInvitation)
        return false;
    int ret = m_callManager->cancelLocalInvitation(m_callInvitation);
    return ret == 0 ? true : false;
}
```



### Accept a call invitation

The callee gets RemoteInvitation from `onRemoteInvitationReceived` and accepts the call invitation by calling `acceptRemoteInvitation`. The lifecycle of the `RemoteInvitation` ends as the caller receives the `onRemoteInvitationAccepted` callback. The lifecycle of the `LocalInvitation` ends as the caller receives the `onLocalInvitationAccepted` callback.



![img](https://web-cdn.agora.io/docs-files/1598604394009)

The sample code for accepting a call invitation is as follows:

```
// The sample code is based on QT

// Accept call invitation
bool CAgoraRtmInstance::AcceptRemoteInvitation(IRemoteCallInvitation* invitation)
{
    int ret = m_callManager->acceptRemoteInvitation(invitation);
    return ret == 0 ? true : false;
}
```

###  Refuse a call invitation

The callee gets RemoteInvitation from `onRemoteInvitationReceived` and refuses the call invitation by calling `refuseRemoteInvitation`. The lifecycle of the `RemoteInvitation` ends as the caller receives the `onRemoteInvitationRefused` callback. The lifecycle of the `LocalInvitation` ends as the caller receives the `onLocalInvitationRefused` callback.

![img](https://web-cdn.agora.io/docs-files/1598604400671)

The sample code for refusing a call invitation is as follows:

```
// The sample code is based on QT

// Decline call invitation
bool RefuseRemoteInvitation(IRemoteCallInvitation* invitation)
{
    int ret = m_callManager->refuseRemoteInvitation(invitation);
    return ret == 0 ? true : false;
}
```

##  API Reference

See [Call invitation](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_cpp/index.html#callinvitation).

## Sample Project

We provide a [demo project](https://github.com/AgoraIO-Usecase/Video-Calling) on GitHub. You can try the demo and view the source code.