---
title: Why can I see big headshot or letterbox?
platform: ["Android","iOS","macOS","Windows","Unity","Cocos Creator","Electron","React Native","Flutter"]
updatedAt: 2020-07-09 22:05:29
Products: ["Video","Interactive Broadcast"]
---

## Step 1: Self-check

Big headshot and letterbox issues occur when the video size does not match the display window size and under the following scenarios:

* If the video size is different from the camera output size, the video is cropped before it is encoded and then enlarged.
* If the video size is different from the display window size and the receiver uses the Hidden mode for rendering, the video is also cropped before it is encoded and then enlarged.
* If the video size is different from the display window size and the receiver uses the Fit mode for rendering, the video is reduced in size, resulting in dark bands on the margin of the screen.

## Step 2: Contact Agora Customer Support

If the issue persists, contact Agora customer support and submit the issue with the following information:

* SDK logs of the sender.
* If the sender uses a mobile phone, whether the sender’s screen is horizontal or vertical.
* The window aspect ratio of the receiver.