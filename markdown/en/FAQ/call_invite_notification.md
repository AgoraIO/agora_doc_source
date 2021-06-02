---
title: How can I implement call notification in a call application?
platform: ["Android","iOS","macOS","Web","Windows","Linux"]
updatedAt: 2021-01-08 03:17:32
Products: ["Real-time-Messaging"]
---
## Description

To implement call notification, you need to integrate the Agora RTC SDK, the Agora RTM SDK, and platform-specific call APIs such as ConnectionService for Android, CallKit for iOS, and CallKeep for Flutter and React Native. The RTM SDK supports call notification only when the app is running. So, you also need to integrate platform-specific APIs to ensure that users can still receive call notifications when the app is on the background or the process is closed.

## Implementation

### Step 1: Integrate the RTC SDK and the RTM SDK

Refer to the following articles to learn how to integrate the RTC SDK and the RTM SDK:

- [RTC SDK quickstart](/en/Interactive%20Broadcast/start_live_android?platform=Android)
- [RTM SDK quickstart](/en/Real-time-Messaging/messaging_android?platform=Android)

### Step 2: Use the RTM SDK to implement the basic functionalities of call invitation

To implement call invitation for the RTM SDK, see [Call Invitation](/en/Real-time-Messaging/rtm_invite_android?platform=Android). 

### Step 3: Integrate platform-specific call APIs and implement call notification

- For the Android platform, see [ConnectionService official documentation](https://developer.android.com/reference/android/telecom/ConnectionService).
- For the iOS platform, see [CallKit official documentation](https://developer.apple.com/documentation/callkit).
- For the Flutter platform and the React Native platform, see [CallKeep official documentation](https://github.com/react-native-webrtc/react-native-callkeep).