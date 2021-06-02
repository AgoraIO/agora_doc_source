---
title: Audio-related Issues
platform: Audio Related Issues
updatedAt: 2019-10-22 14:18:43
---
This page provides common troubleshooting strategies for Agora's audio products and services.

## Echo

Echo is commonly caused by the device of the user who hears the echo. This problem can be fixed by using a headset in most cases, and ensure that the headset does not cause an echo. The Agora SDK supports echo cancellation.

**Step 1: Self-check**

Check the following:
* Check if the echo is occasional or continuous. An occasional echo may be caused by CPU overload. If the CPU usage is too high, voice recording and playback will be unstable. You can check this in Agora Analytics in Console.
* Ensure that all users are in separated physical environments.
* Check the SDK version:
	* Android/iOS: v1.6.0+.
	* Windows/macOS: v1.7.0+.
* Check if you enabled an external audio source. In this case, echo cancellation is not supported and the echo may be caused by data loss during the audio transmission to the SDK. 
* In Windows, ensure the `Monitoring Microphone` option is not checked. 
* On iOS, ensure that the `Mixable` option is not enabled. If it is enabled and another app is using the microphone, echo may occur.
* On Android, check whether the app sets the `Game Streaming` scenario in the `setAudioProfile` method. In this scenario, echo cancellation is turned off by default.
* Use a headset:
	* In a one-to-one call, if you hear an echo, ask the other user to use a headset.
	* In a multi-user call, ask users to mute in turn to figure out who causes the echo. The users who cause the echo should use headsets or mute themselves.

**Step 2: Contact Agora Customer Support**

If the issue persists, contact Agora customer support and submit the issue with the following information:

<table>
  <tr>
    <th>Information</th>
    <th>Details</th>
  </tr>
  <tr>
    <td>Mandatory</td>
    <td>The name of the channel where the echo occurs.<br>The uids of the users who hear the echo.<br>The uid of the user who causes the echo.<br>The recording files, if available.</td>
  </tr>
  <tr>
    <td>Additional</td>
    <td>The time frame during which the users hear the echo.<br>If the issue exists after rejoining the channel.<br>If the issue exists after the user causing or hearing the echo switches the audio route (such as using a headset).</td>
  </tr>
</table>

## Noise
Noise may be caused by the physical environment or recording and playback devices rather than the SDK.

**Step 1: Self-check**

Check the following:
* Ensure that all users are in separated physical environments (no near-field tests).
* Check if an external audio source is used and if the captured external audio source is normal. In this case, noise cancellation is not supported and the noise may be caused by data loss during the audio transmission to the SDK.
* Check if any user is talking in a noisy environment. 
* Check if the recording device is working properly. For example, check whether the headset is plugged in correctly, use another headset, or switch to another audio route.

**Step 2: Contact Agora Customer Support**

If the issue persists, contact Agora customer support and submit the issue with the following information:

<table>
  <tr>
    <th>Information</th>
    <th>Details</th>
  </tr>
  <tr>
    <td>Mandatory</td>
    <td><li>The name of the channel where the noise occurs.</li><li>The uid of the user who causes the noise.</li><li>The recording files, if available.</li></td>
  </tr>
  <tr>
    <td>Additional</td>
    <td><li>The time frame during which the users hear the noise.<</li><li>If the issue remains after rejoining the channel.</li><li>If the device test result is normal on macOS or Windows.</li><li>If the noise is consistent or only when you speak, and disappears when the remote user speaks.</li></td>
  </tr>
</table>

## Volume Issues

### The other user's volume is very low.

**Step 1: Self-check**

Check the following:
* Turn up the system volume of the receiver.
* Check whether the issue is caused by the device. You can change your playback device or try other VoIP services on the same device.
* Check whether the user opens another app during the call, which may change the audio settings or routing.
* Call the following methods to adjust the volume: `enableAudioVolumeIndication`, `adjustRecordingSignalVolume`, `adjustPlaybackSignalVolume`, and `adjustAudioMixingVolume`.
* Check the `onAudioRouteChanged` callback to see whether the audio route is set to the headset or speaker. If the audio route is set to the headset, call the `setDefaultRouteToSpeakerphone` method and switch the audio route to the speaker.

**Step 2: Contact Agora Customer Support**

If the issue persists, contact Agora customer support and submit the issue with the following information:
* The name of the channel where the users encounter this issue.
* The uids of the users whose volume is too low.
* The time frame during which the volume is too low.

### The volume changes when users change their roles in a live broadcast.

To ensure better voice quality, the volume controls switch when the client role changes:
* The audience role uses the media volume control.
* The host role uses the call volume control. 

To avoid volume changes, you can set the media or call volume controls by setting `scenario` in `AudioProfile`. Select `CHATROOM_ENTERTAINMENT` for Android platforms and `GAME_STREAMING` for iOS platforms.

## No Voice

No voice may occur in the following scenarios:

* The local user cannot hear any voice from the remote user.
* The remote user cannot hear any voice from the local user.
* The local and remote users cannot hear each other.

**Step 1: Self-check**

Check the following:

* Ensure that the app grants access to audio devices.
* Ensure that the app receives the `onJoinChannelSuccess` callback, which means users join the channel successfully.
* Check if you muted yourself or others.
* Check if you called the `adjustRecordingSignalVolume` or `adjustPlaybackSignalVolume` method to mute the audio.
* Check if the recording device is working. You can call the `startEchoTest` method to test it.
* Check if the headset is working.
* Call the `setEnableSpeakphone` method and ensure that you cannot hear any voice from the headset when the speaker mode is on.
* Check if the headset is working and if the audio output is set to the headset.
* Test your device with the Agora Video Call demo (downloaded from [Agora.io](https://docs.agora.io/en/Voice/downloads)).
* In Windows, if users cannot hear any voice from the speaker or headset:
	* Right-click on the speaker icon and select Sounds.
    ![](https://web-cdn.agora.io/docs-files/1543547283115)
  
	* On the Playback tab, check whether the green bar of the speaker changes according to the volume. If not, the speaker is not working.
    ![](https://web-cdn.agora.io/docs-files/1539335709730)
		If the green bar changes according to the volume, check if you can hear any audio output with another app. If yes, there is something wrong with your app. If the green bar does not appear regardless of the app, unplug and plug the headset, change the playback device, or stop and restart the playback device.
   
	* If none of these methods work, check the recording device by clicking on the Recording tab and checking whether the green bar changes according to your voice volume. Ensure that you select the correct device when multiple devices are available.
    ![](https://web-cdn.agora.io/docs-files/1539335720712)

**Step 2: Contact Agora Customer Support**

If the issue persists, contact Agora customer support and submit the issue with the following information:

* The name of the channel where the users cannot hear the noise.
* The uids of the users who cannot hear any voice in the channel.
* The time frame during which the users cannot hear any voice.

## Jitter
Jitter may be caused by slow Internet connections, bad device performances, or the physical environment.

**Step 1: Self-check**

Check if the network is stable and in good condition. If not, switch to 4G or another Wi-Fi network.

**Step 2: Contact Agora Customer Support**

If the issue persists, contact Agora customer support and submit the issue with the following information:

<table>
  <tr>
    <th>Information</th>
    <th>Details</th>
  </tr>
  <tr>
    <td>Mandatory</td>
    <td><li>The name of the channel where the users hear the jitter.</li><li>The uids of the users who hear the jitters.</li><li>The uid of the user who causes the jitters.</li><li>The recording files, if available.</li></td>
  </tr>
  <tr>
    <td>Additional</td>
    <td><li>Live broadcast: If the jitter comes from the host.</li><li>Video mode: If the video is smooth and clear.</li></td>
  </tr>
</table>

**Step 3: Monitor the Quality of Experience in Agora Analytics in Console**

You can check the statistics of every call in [Agora Analytics](https://dashboard.agora.io/analytics/call/search) in Console. For more information, see [Agora Analytics Tutorial](https://dashboard.agora.io/analytics/call/tutorial?_ga=2.197716463.1125435494.1542623251-764614247.1539586349).

## Bluetooth Issues (iOS only)
A user connects a Bluetooth headset to a phone, but not all incoming calls are answered through the Bluetooth headset.

This is because iOS selects audio routes for phone and VoIP calls:

**Phone Call (Including FaceTime and CallKit)**

When a phone rings:
* If you press the answer button on iPhone, the iPhone handset is used by default.
* If you press the answer button on a Bluetooth device, the Bluetooth headset is used by default.

You can change the audio route setting in Settings > General > Accessibility > Call Audio Routing. When you select the Bluetooth Headset option, all incoming calls are answered through the headset even if you press the answer button on iPhone.

During a phone call, you can switch between the Bluetooth Headset, Handset, or Speaker options in the call interface. 

**VoIP Call**

When making a VoIP call, the default audio route is the one used by the last phone or VoIP call made after a Bluetooth device is connected. If no phone call is made since the Bluetooth device is connected, the VoIP calls are answered through the Bluetooth headset.

During a VoIP call, users can change the audio route in the iPhone Control Center (swipe up from the bottom of the screen). Apps can call the `setPreferredInput` method to change the audio route.

**Other Settings**

When users set the Bluetooth headset as the audio route on a VoIP app, the system switches to the Bluetooth headset mode accordingly.

Users can record calls with a Bluetooth speaker only when they make phone calls or use FaceTime or CallKit.

**Frequently Asked Questions**

* **Q:** When I am in a VoIP call with a Bluetooth headset and a phone call interrupts, why do I have to continue the VoIP call with the handset?
**A:** If you tap the answer button on your phone, the default audio route for the phone and VoIP calls switches to the iPhone handset. If you tap the answer button on your Bluetooth headset, you can continue your call with the Bluetooth headset.

* **Q:** My iPhone is connected to a Bluetooth headset. When I join a channel to make a VoIP call, why is the audio routed to the handset or speaker?
**A:** This is because the default route for the phone and VoIP calls is not the Bluetooth headset. Before making a VoIP call, you need to switch to the Bluetooth Headset mode in the Control Center (swipe up from the bottom of the screen).

* **Q:** Why I can switch back to the Bluetooth Headset mode for music playback?
**A:** Music playback is different from VoIP calls.

* **Q:** My iPhone is connected to a Bluetooth speaker. Why can't I use it to make a VoIP call?
**A:** VoIP calls cannot be recorded by a Bluetooth speaker unless the app uses the CallKit framework. Hence, users cannot answer VoIP calls with a Bluetooth speaker. In a live broadcast, the audience does not need to record the voice, so the audience can listen to the broadcast with a Bluetooth speaker.