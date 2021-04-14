---
title: Why doesn't the music file resume playback after a phone call on an Android device?
platform: ["Android"]
updatedAt: 2021-02-05 07:24:24
Products: ["Voice","Video","Interactive Broadcast","live-streaming","Audio Broadcast"]
---
## Issue description

When calling `startAudioMixing` to play a music file on Android devices, if you make or receive a phone call, the music will pause. However, the music file does not automatically resume playing when the call finishes.

## Reason

The SDK cannot determine whether the phone call stops using the audio output device. Therefore, the music file does not resume playback automatically.

## Solution

After calling `startAudioMixing`, Agora recommends that you call `PhoneStateListener` (an Android API) to listen for phone calls, and perform the following steps:

1. When making or receiving a phone call, call `getAudioMixingCurrentPosition` to retrieve the current playback position.
2. After the phone call ends, call `startAudioMixing` again, and call `setAudioMixingPosition` to start playing from the retrieved playback position.