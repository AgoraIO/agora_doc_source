---
title: How do I remove a specified user from a channel?
platform: ["Android","iOS","macOS","Web","Windows","Linux","Unity","Cocos Creator","Electron","RESTful","React Native","Flutter"]
updatedAt: 2020-10-30 11:29:58
Products: ["Voice","Video","Interactive Broadcast","Real-time-Messaging"]
---
In real-time engagement scenarios, you may need to remove a specified user from a channel. Refer to the following solutions according to your scenario:

**Scenario one**

After a call ends, some user (most often a Web user) forgets to leave the channel. Even though no call takes place, Agora adds up service minutes.

To prevent this from happening, you can detect whether a user is active by using the `onAudioVolumeIndication` callback, or by monitoring whether the user publishes an audio stream within a certain amount of time. If the user is inactive, call `leaveChannel` in the app logic to remove the user from the channel. 

**Scenario two**

For scheduling apps, calls usually start and end at pre-set time points. For example, if a meeting starts at 10 and lasts for one hour, then the scheduling app should end the meeting at 11.

Choose either of the following methods to remove the user:

- Set the token expiration timestamp (the `privilegeExpiredTs` parameter) as the timestamp when the meeting ends. Once the token expires, the user is kicked out of the channel. For details, see [generate a token](https://docs.agora.io/en/Interactive%20Broadcast/token_server?platform=All%20Platforms).
- Use the server RESTful API to kick a specified user out of the channel. Call the kicking-rule method, and fill the channel name and user ID in the method. Set the `time` parameter as 0, so that the user can join other channels after being kicked. For details, see [create a kicking rule](https://docs.agora.io/en/rtc/restfulapi/#/Banning%20rule%20management/createKickingRule).

**Scenario three**

In a live streaming channel, the host can kick off a co-host or audience member who violates chatroom rules.

You can use the peer-to-peer messaging function of the Agora RTM SDK. On the host's client, call `sendMessageToPeer` to notify the remote user to leave channel, and on the remote user's client, call `leaveChannel` after receiving the peer message in the `onMessageReceived` callback.