---
title: How can I solve audio problems relating to gaming scenario?
platform: ["iOS","Android"]
updatedAt: 2021-02-05 02:49:16
Products: ["Voice","Video","Interactive Broadcast"]
---
**Before joining a channel, the audio effects are muted. Why are they unmuted after the user joins a channel in Command mode?**

The SDK uses the in-call volume to play the audio effects after the user joins a channel, and the in-call volume is always set above 0.

**I unmute the audio effects and set the system volume at a fixed level. Why does the volume of the audio effects become louder after joining a channel ?**

The media volume and in-call volume are two separate systems; the settings of one do not interfere with the other. The playback audio volume is controlled by the in-call volume when you are in a call, and by the media volume when you leave the call.

**On iOS, when I unmute the audio and then immediately leave the channel, why does the volume of the background music decrease?**

Before the user joins a channel, the device uses the SDK to play the background music, and sets the `AudioSessionCategory` parameter as `AVAudioSessionCategoryAmbient` and `mode` as `AVAudioSessionModeDefault`. The background music uses the media volume.

After the user leaves a channel, the SDK changes the `AudioSessionCategory` parameter as `AVAudioSessionCategoryPlayAndRecord` and `mode` as `AVAudioSessionModeVoiceChat`. The background music uses the in-call volume.

To keep the audio volume steady when the user leaves the channel, we recommend you to set `AudioSessionCategory` to the same mode as before joining the channel. 

<div class="alert note">This is automatically set in AMG SDKs later than v2.2 and Native SDKs released after 2019.</div>

**Why are there conflicts between the audio effects and the voice after a user joins a channel?**

When a user joins a channel, audio interruptions may occur. To solve this problem, you can set the volume of both the audio effects and the voice as the media volume. This method may cause echo problems, and we recommend implementing this method only after testing.

**In the mahjong game, why do the users hear the background music during the call?**

This occurs when the users do not use the SDK to play the background music back in the game. In this case, the SDK records and plays it back during the call.

We recommend muting the background music and audio effects during the call, or decreasing the volume of the background music during the media relay across channels to avoid this problem.

**When a user plays background music in the app and joins a channel, why does the volume of the background music change? After the user leaves the channel, why is the background music muted?**

To solve this problem, call the `setParameters("{\"che.audio.keep.audiosession\":true}")` method before calling the `joinChannel` method.

**When a user plays background audio effects, why does the volume of the background audio effects decrease after the user joins a channel (Communication) or the SDK relays the media streams across channels (Live-Broadcast)?**

When the SDK relays the media streams across channels, your phone enables acoustic echo cancellation to ensure voice performance, so the SDK decreases the volume of both the voice and the background audio effects. To solve this problem, you can choose one of the following methods:

Ensure that the external speaker plays the voice. Call the `setEnableSpeakerphone` method to set the speaker as the external speaker.
Call the `startAudioMixing`/`playEffect` method to play the audio effects.

**The `onAudioVolumeIndication` callback can get the volume from 0 to 255. Is there any threshold value to distinguish whether a user is speaking or not?**

The recommended threshold value is between 40 and 50. A user is speaking when the volume is higher than the threshold value, and a user is not when the volume is lower than the threshold value. You can adjust the threshold value based on different definitions of speaking and not speaking.

**How do I mute the media volume of the SDK after the SDK relays the media streams across channels and uses the in-call volume?

To mute the media volume, you need to set the following methods before a user joins a channel.

#### iOS

`mRtcEngine.setParameters("{\"che.audio.use.remoteio\":true}");`

#### Android

`mRtcEngine.setParameters("{\"che.audio.stream_type\":3}");`
`mRtcEngine.setParameters("{\"che.audio.audioMode\":0}");`

#### Android and iOS

`mRtcEngine.setParameters("{\"che.audio.enable.aec\":true}");`
`mRtcEngine.setParameters("{\"che.audio.enable.agc\":true}");`
`mRtcEngine.setParameters("{\"che.audio.enable.ns\":true}");`

<div class="alert note">The settings above may cause echo problems, and we recommend implementing them only after testing.</div>

**Why is there no stereo playback when using the Bluetooth earphone?**

For a voice call, Bluetooth uses the Synchronous Connection-Oriented (SCO) link to play and record voice. In SCO, the Bluetooth earphone supports only mono playback. Bluetooth devices that use the Advanced Audio Distribution Profile (A2DP) link support stereo playback but cannot record, and hence, you cannot use them for voice calls.

- A2DP: A unidirectional link used to transmit high-quality stereo audio data. A2DP is usually used for stereo music playback.
- SCO: A bidirectional link used to transmit high-quality mono audio data in 8 K or 16 K. SCO is usually used for voice playback.