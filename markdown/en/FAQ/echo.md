---
title: How can I solve echo problems?
platform: ["Android","iOS","macOS","Windows"]
updatedAt: 2021-03-05 10:55:51
Products: ["Voice","Video","Interactive Broadcast"]
---
The Agora SDK supports echo cancellation. In most cases, this problem can be fixed by using a headset, and ensure that the headset does not cause an echo. 

In a channel joined by multiple users, if a device does not work properly, chances are that all other users in the channel can hear echoes. Therefore, beware that the user hearing the echo may not necessarily be the one having the problem.

## Step 1: Self-check

Check the following:

- Find the source of the echo. You can mute users in the channel one by one to find the source of the echo.
- Check if the echo is occasional or continuous. An occasional echo may be caused by CPU overload. By using [Call Search](https://docs.agora.io/en/Agora%20Platform/aa_call_search?platform=All%20Platforms#analyze-quality-issues) function of Agora Analytics, you can check the CPU usage on the **End-to-End Details** page.
- Ensure that all users are in separated physical environments and do not sit too close to each other.
- Check the SDK version:
	- Android/iOS: v1.6.0+.
	- Windows/macOS: v1.7.0+.
- Check if you enabled an external audio source. If so, echo cancellation is turned off by default.
- In Windows, ensure the `Monitoring Microphone` option is not checked. 
- On iOS, check whether the app sets Audio Session as `AVAudioSessionCategoryOptionMixWithOthers`. If so, you may encounter echoes when other apps use the audio device at the same time.
- Systems of some Android or Windows devices support echo cancellation function by default, and you may encounter echoes if the echo cancellation of the system is poor. In this case, Agora recommends disableing the echo cancellation in system and using the echo cancellation of Agora.
- Use a headset:
	- In a one-to-one call, if you hear an echo, ask the other user to use a headset.
	- In a multi-user call, ask users to mute in turn to figure out who causes the echo. The users who cause the echo should use headsets or mute themselves.

## Step 2: Contact Agora Customer Support

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

## Step 3: Monitor the Quality of Experience in Agora Analytics in Console

You can check the statistics of every call in [Agora Analytics](https://dashboard.agora.io/analytics/call/search) in Console. For more information, see [Agora Analytics Tutorial](https://dashboard.agora.io/analytics/call/tutorial?_ga=2.197716463.1125435494.1542623251-764614247.1539586349).
