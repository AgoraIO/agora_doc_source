---
title: What is the difference between the in-call volume and the media volume?
platform: ["Android","iOS","macOS","Windows","Unity","Cocos Creator","Electron","React Native","Flutter"]
updatedAt: 2020-04-17 10:29:51
Products: ["Voice","Video","Interactive Broadcast"]
---
When you set the volume of a device, you set either the in-call volume or the media volume.

- In-call volume: During an audio or video call, you set the in-call volume.
- Media volume: When you play background music, video or games, you set the media volume.

The differences between the two are as follows:

- In-call volume features acoustic echo cancelling, and should always be above 0.
- Media volume features quality sound performance, and can be set 0.

The SDK provides six audio scenarios with the `setAudioProfile` method: `CHATROOM_ENTERTAINMENT`, `EDUCATION`, `GAME_STREAMING`, `SHOWROOM`, `CHATROOM_GAMING and DEFAULT`.

- If you set scenario to `GAME_STREAMING`, all users use the media volume.
- If you set scenario to `EDUCATION`, `SHOWROOM` or `DEFAULT`, audience users in the Live-broadcast profile use the media volume, while host users in the Live-broadcast profile and all users in the Communication profile use the in-call volume.
- If you set scenario to `CHATROOM_ENTERTAINMENT` and `CHATROOM_GAMING`, all users use the in-call volume.

Given the system restrictions, the media volume can be set to 0, but the in-call volume cannot. If you want to adjust the volume to 0, ensure that you set an audio scenario where the system uses the media volume.