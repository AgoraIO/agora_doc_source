---
title: Release Notes
platform: Android
updatedAt: 2021-03-02 03:41:55
---
## Overview

Designed as a substitute for the legacy Agora Signaling SDK, the Agora Real-time Messaging SDK provides a more streamlined implementation and more stable messaging mechanism for you to quickly implement real-time messaging scenarios.

> For more information about the SDK features and applications, see [Agora RTM Overview](/en/Real-time-Messaging/RTM_product).

## v0.9.1

v0.9.1 is released on May 20th, 2019.

### New Features

This release adds the call invitation feature, allowing you to create, send, cancel, accept, and decline a call invitation in a one-to-one or one-to-many voice/video call. 



### API Changes

#### Adds

- [createLocalInvitation](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmclient.html#createlocalinvitation): Creates a call invitation. 
- [LocalInvitation.send](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/localinvitation.html#send): Allows the caller to send a call invitation to a specified user (callee). 
- [LocalInvitation.cancel](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/localinvitation.html#send)Allows the caller to cancel a sent call invitation. 
- [LocalInvitationState](): **RETURNED TO THE CALLER** Call invitation status codes. 
- [LocalInvitationFailureReason](): **RETURNED TO THE CALLER** Reason for failure of the outgoing call invitation. 
- [RemoteInvitationReceived](/en/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmclientevents.html#remoteinvitationreceived): Occurs when the callee receives a call invitation. 
- [RemoteInvitation.accept](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/remoteinvitation.html#accept): Allows the callee to accept an incoming call invitation. 
- [RemoteInvitation.refuse](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/remoteinvitation.html#refuse): Allows the callee to declien an incoming call invitation. 
- [RemoteInvitationState](/en/Real-time-Messaging/API%20Reference/RTM_web/enums/remoteinvitationstate.html): **RETURNED TO THE CALLEE**: Call invitation status codes. 
- [RemoteInvitationFailureReason](): **RETURNED TO THE CALLEE**: Reason for the failure of the incoming call invitation.

#### Renames

- `RtmClient.ConnectionStateChange` to [ConnectionStateChanged](/en/Real-time-Messaging/API%20Reference/RTM_web/interfaces/rtmclientevents.html#connectionstatechanged) .

#### Deletes

- The `RtmChannel.getId()` method. Uses the [channelId](/en/Real-time-Messaging/API%20Reference/RTM_web/classes/rtmchannel.html#channelid) property instead.

## v0.9.0

v0.9.0 is released on February 14th, 2019.

Initial version. 

Key features:

- Sends or receives peer-to-peer messages.
- Joins or leaves a channel.
- Sends or receives channel messages.
