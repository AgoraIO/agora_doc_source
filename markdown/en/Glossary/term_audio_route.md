---
title: audio route
platform: All Platforms
updatedAt: 2020-07-03 20:02:17
---
The audio route is the pathway audio data takes through audio hardware components during playback. Earpieces, headphones, speakerphones, and Bluetooth devices that output sound (such as Bluetooth earpieces), can all work as an audio route.

Mobile apps, once integrated with the Agora RTC SDK, use different default audio routes in different scenarios:

- Voice call: Earpiece
- Audio broadcast: Speakerphone
- Video call: Speakerphone
- Video broadcast: Speakerphone

The default audio route is subject to user behavior, such as plugging in or unplugging an external device. It is also subject to the restrictions of the operating system. To better control the audio route, developers need to have a clear picture of how audio route changes under various circumstances.

<a href="./terms"><button>Back to glossary</button></a>