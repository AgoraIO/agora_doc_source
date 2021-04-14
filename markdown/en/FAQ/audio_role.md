---
title: How can I prevent volume changes when the users switch their roles in an interactive live streaming channel?
platform: ["Android","iOS"]
updatedAt: 2020-11-16 08:19:46
Products: ["Voice","Video","Interactive Broadcast"]
---
For better audio experience, the SDK automatically switches the volume control when the client role changes:
- The audience role uses the media volume control.
- The host role uses the call volume control. 

To avoid volume control changes, you can specify using the media or call volume control by setting `scenario` in the `setAudioProfile` method. Select `CHATROOM_ENTERTAINMENT` for Android and `GAME_STREAMING` for iOS.