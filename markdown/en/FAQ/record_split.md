---
title: Why is the recording file split?
platform: ["Linux"]
updatedAt: 2019-06-28 10:43:16
Products: ["Recording"]
---
Normally, file splitting does not occur in the composite recording mode. If you choose the individual recording mode, the following situations result in file splitting: 

-  A user rejoins a channel after leaving the channel, or resumes sending audio/video after not sending for a period of time. The specific rules are as follows:

  - For audio recording files:
    - The user sends the audio data again after not sending for more than 15 seconds.
    - The user rejoins the channel after leaving for more than 15 seconds.
  - For video recording files:
    - The user sends the video data again after not sending for more than 15 seconds.
    - The user changes the video resolution.
    - The user leaves and rejoins the channel.

- In the manual recording mode, you pause and then resume recording.

If the file splits and the above situations do not apply, check the following: 

- Ensure that the same channel profile is used between the Native/Web SDK and Recording SDK.
- Call `enableWebSdkInteroperability` in the Native SDK when the recording channel uses both the Native and Web SDK.