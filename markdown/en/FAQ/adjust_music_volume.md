---
title: Why can't I adjust the volume of the background music through the system volume?
platform: ["iOS","Android"]
updatedAt: 2021-01-27 12:26:24
Products: ["Voice","Video","Interactive Broadcast","live-streaming"]
---
## Problem

When users play background music in mobile devices and join an RTC channel, they cannot adjust the volume of the background music by adjusting the system volume.

## Reason

Mobile devices have two volume types: in-call volume and media volume. Generally speaking, users use the in-call volume control to adjust audio or video calls, and the media volume control to adjust background music. See [What is the difference between the in-call volume and the media volume](./faq/system_volume) for details.

After users join an RTC channel, the Agora RTC SDK determines which volume type the system volume controls. When the SDK controls the in-call volume and the background music uses the media volume, users cannot adjust the volume of the background music through the system volume.

## Solution

#### Solution one

Call `startAudioMixingPlay` to play the background music, and the SDK can control both the background music and the user's voice. Regardless of whether the SDK uses in-call volume or media volume, users can adjust the volume of both the background music and the user's voice through the system volume.

#### Solution two

Set the `scenario` parameter of `setAudioProfile` as `GAME_STREAMING`/`AgoraAudioScenarioGameStreaming` to make the SDK use the media volume. Users can then adjust the volume of both the background music and the user's voice through the system volume.

#### Solution three

If the above solutions cannot meet your requirements, you can use platform-specific APIs to intercept volume key events and adjust the volume as follows:

- Android: Use [AudioManager](https://developer.android.com/reference/android/media/AudioManager.html).
- iOS: Use [MPVolumeView](https://developer.apple.com/documentation/mediaplayer/mpvolumeview).