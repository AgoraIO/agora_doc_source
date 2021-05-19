---
title: 如何处理频道相关常见问题？
platform: ["Android","iOS","macOS","Windows"]
updatedAt: 2020-11-12 07:39:41
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
### In poor network conditions, does the SDK force users to leave a channel?

No, users will not automatically leave a channel unless they do so by themselves, for example, when the application calls `leaveChannel`.

### Does each channel or room need an administrator in a call?

No. You can create the administrator role with your own code. For example, you can manage a call by letting the signaling server send commands to the SDK to call an SDK API. 

### Does the client need to maintain the channel?

No, a channel is created and deleted automatically. When all users leave the channel, the channel is deleted automatically.

### How do I check who is speaking in the channel?

The following callbacks indicate who is speaking and the speakers' volumes.

* For Android and Windows: `onAudioVolumeIndication`
* iOS/macOS: `reportAudioVolumeIndicationOfSpeakers`

By default, this function is disabled. You can use the `enableAudioVolumeIndication` method to enable them.