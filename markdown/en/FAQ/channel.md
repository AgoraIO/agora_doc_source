---
title: How can I solve channel-related issues?
platform: ["Android","iOS","macOS","Windows"]
updatedAt: 2020-11-12 07:39:19
Products: ["Voice","Video","Interactive Broadcast"]
---
### In poor network conditions, does the SDK force users to leave a channel?

No, users do not automatically leave a channel unless they do so themselves. For example, the application calls the `leaveChannel` method.

### Does each channel/room need an administrator in a call?

No, an administrator is only implemented in the business management layer. Your signaling server sends commands and calls the SDK interfaces for call management.

### Does the client need to maintain the channel?

No, a channel is created and deleted automatically. When all users leave the channel, the channel is deleted automatically.

### What are the App ID and Dynamic Key? How can I use them?

See [Use Security Keys](/en/voice/token) for details.

### How do I check who is speaking in the channel?

The following callbacks indicate who is speaking and the speakers' volume.

* For Android and Windows: `onAudioVolumeIndication`
* For iOS and macOS: `reportAudioVolumeIndicationOfSpeakers`

By default, these callbacks are disabled. You can use the `enableAudioVolumeIndication` method to enable them.