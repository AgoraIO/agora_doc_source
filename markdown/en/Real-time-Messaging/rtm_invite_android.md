---
title: Call Invitation
platform: Android
updatedAt: 2020-10-11 21:09:19
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
// Gets RtmCallManager instance
RtmCallManager = RtmClient.getRtmCallManager();
```

```
void inviteCall(final String peerUid, final String channel) {
    // Creates LocalInvitation
    LocalInvitation invitation = RtmCallManager.createLocalInvitation(peerUid);
    invitation.setContent(channel);
    // Sends call invitation
    RtmCallManager.sendLocalInvitation(invitation);
}
```



### Cancel a call invitation

The caller cancels the call invitation by calling `cancelLocalInvitation`. The lifecycle of the `RemoteInvitation` ends as the callee receives the `onRemoteInvitationCanceled` callback. And then the lifecycle of the `LocalInvitation` ends as the caller receives the `onLocalInvitationCanceled` callback.

![img](https://web-cdn.agora.io/docs-files/1598604551624)

The sample code for canceling a call invitation is as follows:

```
// Cancel a call invitation.
void cancelLocalInvitation() {
        if (RtmCallManager != null && invitation != null) {
            RtmCallManager.cancelLocalInvitation(invitation);
        }
    }
```



### Accept a call invitation

The callee gets `RemoteInvitation` from `onRemoteInvitationReceived` and accepts the call invitation by calling `acceptRemoteInvitation`. The lifecycle of the `RemoteInvitation` ends as the caller receives the `onRemoteInvitationAccepted` callback. The lifecycle of the `LocalInvitation` ends as the caller receives the `onLocalInvitationAccepted` callback.

![img](https://web-cdn.agora.io/docs-files/1598604558155)

The sample code for accepting a call invitation is as follows:

```
// Accept a call invitation.
void answerCall(final RemoteInvitation invitation) {
        if (RtmCallManager != null && invitation != null) {
            RtmCallManager.acceptRemoteInvitation(invitation);
        }
    }
```

###  Refuse a call invitation

The callee gets `RemoteInvitation` from `onRemoteInvitationReceived` and refuses the call invitation by calling `refuseRemoteInvitation`. The lifecycle of the `RemoteInvitation` ends as the caller receives the `onRemoteInvitationRefused` callback. The lifecycle of the `LocalInvitation` ends as the caller receives the `onLocalInvitationRefused` callback.

![img](https://web-cdn.agora.io/docs-files/1598604564189)

The sample code for refusing a call invitation is as follows:

```
// Refuse a call invitation.
void refuseRemoteInvitation(@NonNull RemoteInvitation invitation) {
        if (RtmCallManager != null) {
            RtmCallManager.refuseRemoteInvitation(invitation);
        }
    }
```

##  API Reference

See [Call invitation](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/index.html#callinvitation).

## Sample Project

We provide a [demo project](https://github.com/AgoraIO-Usecase/Video-Calling) on GitHub. You can try the demo and view the source code.