---
title: Call Invitation
platform: iOS
updatedAt: 2020-11-06 10:47:53
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

In a complete call invitation process, the call invitation states of the caller and the callee are defined by `AgoraRtmLocalInvitation` and `AgoraRtmRemoteInvitation`, respectively.

![](https://web-cdn.agora.io/docs-files/1602321763031)


### Send a call invitation

The steps to send a call invitation are as follows:

1. The caller creates the `AgoraRtmLocalInvitation` by calling `createLocalInvitation`; at the same time, the lifecycle of the `AgoraRtmLocalInvitation` begins.
2. The caller sends a call invitation by calling `sendLocalInvitation`. The lifecycle of the `AgoraRtmRemoteInvitation` begins as the callee receives the `remoteInvitationReceived` callback, and then the caller receives the `localInvitationReceivedByPeer` callback.



### Cancel a call invitation

The caller cancels the call invitation by calling `cancelLocalInvitation`. The lifecycle of the `AgoraRtmRemoteInvitation` ends as the callee receives the `remoteInvitationCanceled` callback. And then the lifecycle of the `AgoraRtmLocalInvitation` ends as the caller receives the `localInvitationCanceled` callback.

![img](https://web-cdn.agora.io/docs-files/1598604688759)



### Accept a call invitation

The callee accepts the call invitation by calling `acceptRemoteInvitation`. The lifecycle of the `AgoraRtmRemoteInvitation` ends as the caller receives the `remoteInvitationAccepted` callback. The lifecycle of the `AgoraRtmLocalInvitation` ends as the caller receives the `localInvitationAccepted` callback.



![img](https://web-cdn.agora.io/docs-files/1598604695722)


###  Refuse a call invitation

The callee refuses the call invitation by calling `refuseRemoteInvitation`. The lifecycle of the `AgoraRtmRemoteInvitation` ends as the caller receives the `remoteInvitationRefused` callback. The lifecycle of the `AgoraRtmLocalInvitation` ends as the caller receives the `localInvitationRefused` callback.

![img](https://web-cdn.agora.io/docs-files/1598604702210)



##  API Reference

See [Call invitation](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_cpp/index.html#callinvitation).

## Sample Project

We provide a [demo project](https://github.com/AgoraIO-Usecase/Video-Calling) on GitHub. You can try the demo and view the source code.