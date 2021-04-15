---
title: How can I implement the call rejection function when the line is busy?
platform: ["Android","iOS","macOS","Web","Windows","Unity","Cocos Creator","Linux","Electron","React Native","Flutter"]
updatedAt: 2020-11-12 08:29:50
Products: ["Real-time-Messaging","Voice","Video"]
---
## Issue description

When initiating a call invitation, if the callee already has an incoming call or is answering a call from another user, how can I implement such a scenario with the  call invitation function of the Agora RTM SDK?




## SDK function description

The call invitation function of the Agora RTM SDK only implements the basic logic in a call invitation, such as canceling, accepting, or refusing a call invitation. A call invitation is only the beginning of a call; it ends when the call begins. To implement a real-world call scenario, you must use both the Agora RTM SDK and an audio-and-video SDK, such as the Agora RTC SDK. 

## Implementation

Agora recommends using two flags (at the app level) to listen for each user's states. For example, you can use `inviteState` to indicate whether the user is in a call invitation and `callState` to indicate whether the user is in a call.  The initial state of both flags is `false`. A user with either of the flags being set as `true` cannot receive a new call invitation. 


| `inviteState` | `callState` | State of the User |
| ---------------- | ---------------- | ---------------- |
| `false`      | `false`      | Free.   |
| `true`      | `false`      | Busy.     |
| `false`      | `true`      | Busy.   |



1. Ensure that your project has implemented the Agora RTM SDK and an audio-and-video SDK, such as the Agora RTC SDK. 
2. When a user receives the `onRemoteInvitationReceived` callback triggered by the Agora RTM SDK, set the `inviteState` flag as `true`:
    - When receiving the following callbacks, set the`inviteState` as `false` to indicate that the call invitation has ended but the call will not begin, and then skip the following steps.
       - `onRemoteInvitationRefused`: The user has declined the call invitation;
       - `onRemoteInvitationCanceled`:  The call invitation has been cancelled;
       - `onRemoteInvitationFailure`: The cal invitation ends in failure. 
    - When a user receives the `onRemoteInvitationAccepted` callback (the user has accepted an incoming call invitation), set the `inviteState` as `false` and `callState` as `true` to indicate that the call invitation has ended and the call is about to begin. 
3. Listen for the `connectionState` state through the `onConnectionStateChanged` callback triggered by the Agora RTC SDK:
    - If `connectionState` is at any of the following state, set the `callState` flag as `true` to indicate that the user is setting up a call or is in a call: 
        - `CONNECTING`: The user is setting up a call; 
        - `CONNECTED`: The call connection is set up; 
        - `RECONNECTING`: The call is being re-established. 
    - If `connectionState` is at any of the following state, set the `callState` flag as `false` to indicate the user is not in a call: 
        - `DISCONNECTED`: The call is disconnected;
        - `FAILED`: The call ended in failure. 
4. Refer to the table above to judge whether a user is busy. If a user is busy, call `refuseRemoteInvitation` provided by the Agora RTM SDK and set the `content` property within the received `RemoteInvitation` object as `"busy"`.