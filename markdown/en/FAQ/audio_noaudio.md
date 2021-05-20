---
title: How can I troubleshoot the issue of no sound?
platform: ["Android","iOS","macOS","Windows","Unity","Cocos Creator","Electron","React Native","Flutter"]
updatedAt: 2021-02-23 03:52:28
Products: ["Voice","Video","Interactive Broadcast","Audio Broadcast","Interactive Gaming"]
---
## Issue description

During real-time engagement, users may experience a total loss of sound in the following scenarios:

- The local user cannot hear remote users.
- A remote user cannot hear the local user.
- The local and remote users cannot hear each other.

## Solution

### Step 1: Determine the issue

To determine the issue, Agora recommends the local user and remote users do the following:

1. Open [Agora Video Call](https://videocall.agora.io/), read the **Agora Terms of Use and Privacy Policy** carefully, and click **Accept**.

2. Enter the same channel name and password, enter a nickname, ensure that the microphone is enabled, and click **Join**.

3. Allow Agora Video Call to access the microphone, and start a conversation to check whether they can hear each other.

   - If they can hear each other, proceed to step 5 to check the app logic.
   - If they cannot hear each other, proceed to step 2 to check the audio input device.

### Step 2: Check the audio input device

1. Ensure that the audio input device is properly connected, and that the affected user has selected a suitable device when there are multiple device options.

2. In system settings, open the **audio input device** (or **recording device**) window. Ensure that the system uses a correct device and that the device is not muted.

3. Speak into the audio input device, and check whether the volume bar of the audio input device changes according to the volume.

   - If the volume bar changes, the audio input device is working. Proceed to step 3 to check the audio output device.
   - If the volume bar does not change, the audio input device is not working. Try restarting the device. If this does not help, try using another audio input device.

### Step 3: Check the audio output device

1. Ensure that the audio output device is properly connected, and that the affected user has selected a suitable device when there are multiple device options.
2. In system settings, open the **audio output device** (or **playback device**) window. Ensure that the system uses a correct device and that the device is not muted.
3. Play an audio file, and check whether the user can hear sound. If not, the audio output device is not working. Try restarting the device. If this does not help, try using another audio output device.
4. If you use a sound card and cannot solve the issue after trying another audio output device, proceed to step 4 to check the sound card.

### Step 4: Check the sound card

1. Ensure the sound card is properly connected. If the user plays an audio file, ensure that the user enables the audio mixing function of the sound card.
2. Reinstall the sound card driver, and check whether the user can hear sound. If not, the sound card is not working. Try replacing the sound card.

### Step 5: Check the app logic

1. Ensure that all users can access the correct audio devices.
2. Check whether each user joins the channel successfully through the `onJoinChannelSuccess`/`didJoinChannel` callback.
3. Check whether the audio is muted by the `adjustRecordingSignalVolume(0)`, `adjustPlaybackSignalVolume(0)`, or `mute`-related methods.
4. If a user uses headphones, check whether you call `setEnableSpeakerphone(false)` to route the audio to the headphones.

### Step 6: Contact Agora customer support

If the issue persists, contact Agora customer support and [submit a ticket](https://agora-ticket.agora.io/) with the following information:

- The name of the channel where the users cannot hear sound.
- The user IDs of the users who cannot hear sound in the channel.
- The time frame during which the users cannot hear sound.

You can also use [Agora Analytics](https://dashboard.agora.io/analytics/call/search) in Console to gain a broad view of call issues for every user. See [Agora Analytics Overview](https://docs.agora.io/en/Agora%20Analytics/aa_guide?platform=All%20Platforms) for details.