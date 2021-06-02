---
title: How do I avoid sending audio streams to remote users during a phone call?
platform: ["Android"]
updatedAt: 2021-02-19 03:31:47
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
## Issue description

On Android devices, when the local user uses an app that integrates the Agora RTC SDK for real-time engagement, and then dials or answers a phone call, the audio stream is still sent to remote users.

## Reason

The SDK listens for Android call events and calls `disableAudio` to disable the audio module by default when the user dials or answers a phone call. If you add business logic that intercepts call events in your app, the SDK can no longer determine when a user is dialing or receiving a call, so this issue occurs.

## Solution

To solve the issue, do the following:

1. Check which Android call events your app intercepted: 
   - `CALL_STATE_RINGING`
   - `CALL_STATE_OFFHOOK`
2. Change your business logic to resume listening for the intercepted call events.