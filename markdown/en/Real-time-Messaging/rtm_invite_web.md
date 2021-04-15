---
title: Call Invitation
platform: Web
updatedAt: 2020-10-10 18:47:47
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
2. The caller sends a call invitation by calling `send`. The lifecycle of the `RemoteInvitation` begins as the callee receives the `RemoteInvitationReceived` callback, and then the caller receives the `LocalInvitationReceivedByPeer` callback.

The sample code for sending a call invitation is as follows:

```
// Create LocalInvitation
localInvitation = Client.createLocalInvitation(calleeId);
// Send call invitation
localInvitation.send();
```



### Cancel a call invitation

The caller cancels the call invitation by calling `cancelLocalInvitation`. The lifecycle of the `RemoteInvitation` ends as the callee receives the `RemoteInvitationCanceled` callback. And then the lifecycle of the `LocalInvitation` ends as the caller receives the `LocalInvitationCanceled` callback.

![img](https://web-cdn.agora.io/docs-files/1599102442687)

The sample code for canceling a call invitation is as follows:


```
// Cancel call invitation
cancelCall() {
    localInvitation.cancel();
  }
```


### Accept a call invitation

The callee gets `RemoteInvitation` from `RemoteInvitationReceived` and accepts the call invitation by calling `accept`. The lifecycle of the `RemoteInvitation` ends as the caller receives the `RemoteInvitationAccepted` callback. The lifecycle of the `LocalInvitation` ends as the caller receives the `LocalInvitationAccepted` callback.



![img](https://web-cdn.agora.io/docs-files/1599102452730)

The sample code for accepting a call invitation is as follows:

```
// Accept call invitation
acceptCall() {
    remoteInvitation.accept();
  }
```

###  Refuse a call invitation

The callee gets `RemoteInvitation` from `RemoteInvitationReceived` and refuses the call invitation by calling `refuse`. The lifecycle of the `RemoteInvitation` ends as the caller receives the `RemoteInvitationRefused` callback. The lifecycle of the `LocalInvitation` ends as the caller receives the `LocalInvitationRefused` callback.

![img](https://web-cdn.agora.io/docs-files/1599102463698)

The sample code for refusing a call invitation is as follows:

```
// Decline call invitation
refuseCall() {
    remoteInvitation.refuse();
  }
```

##  API Reference

See [Call invitation](/en/Real-time-Messaging/API%20Reference/RTM_web/index.html#call-invitation-management).

## Sample Project

We provide a [demo project](https://github.com/AgoraIO-Usecase/Video-Calling) on GitHub. You can try the demo and view the source code.