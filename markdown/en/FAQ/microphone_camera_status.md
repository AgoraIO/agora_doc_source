---
title: How can I listen for the status of a user's microphone and camera?
platform: ["Android","iOS","macOS","Web","Windows","Unity","Cocos Creator","微信小程序","Electron","React Native","Flutter","RESTful"]
updatedAt: 2020-07-06 15:10:52
Products: ["Voice","Video","Interactive Broadcast","Real-time-Messaging"]
---
## Introduction

When using the Agora RTC SDK to implement a real-time call or interactive streaming, to listen for the status of a user's microphone and camera in a channel, you can use the Agora RTM SDK.

## Implementation

You can use the following functions of the Agora RTM SDK to listen for the status of a user's microphone and camera in a channel:
- User attributes: Listen for the status of a specified user's microphone and camera by adding user attributes.
- Channel attributes: Listen for the status of all users' microphones and cameras in a specified channel by adding channel attributes.

### Listen for user attributes

1. After joining a channel, call `addOrUpdateLocalUserAttributes` to add or update the attributes of the local user's microphone and camera.
2. Call `getUserAttributesByKeys` to get the attributes of a specified user's microphone and camera, which can be used to show the microphone and camera status.

### Listen for channel attributes

1. (This step is for Linux/Windows C++ only, skip to step 2 when using other platforms.) After joining a channel, call `createChannelAttribute` to create and return an `IRtmChannelAttribute` instance.

<div class="alert note">After getting the microphone and camera status, call <tt>release</tt> to release the <tt>IRtmChannelAttribute</tt> instance.</div>

2. Call `addOrUpdateChannelAttributes` to add or update the attributes of all users' microphones and cameras in a specified channel.

3. Call `getChannelAttributesByKeys` to get the attributes of all users' microphones and cameras in a specified channel, which can be used to show the microphone and camera status.

## Reference

Refer to the following documents for detailed integration guide and API reference:

- [RTM quickstart](https://docs.agora.io/en/Real-time-Messaging/messaging_android?platform=Android)
- [RTM APIs for user attributes](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/index.html#attributes)
- [RTM APIs for channel attributes](https://docs.agora.io/en/Real-time-Messaging/API%20Reference/RTM_java/index.html#channelattributes)