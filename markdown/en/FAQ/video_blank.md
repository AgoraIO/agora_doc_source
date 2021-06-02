---
title: How can I fix black screen issues?
platform: ["Android","iOS","macOS","Web","Windows","Unity","Electron","React Native","Flutter"]
updatedAt: 2021-01-05 04:53:39
Products: ["Video","Interactive Broadcast"]
---
## Issue description

A user may encounter black screen issues in the following scenarios:
- Black screen on the local side.
- Black screen on the remote side.
- Black screen on the local and remote sides.

## Reason
Typical reasons for black screens include:
* Wrong token. When you set the local or remote video view before calling `joinChannel`, but the user fails to join the channel, the local video preview or the remote video view appears black. This can happen if you pass the wrong token.
* Network failure: If the local network connection is poor or interrupted, the user cannot see other users. If any user in the call has network issues, none of the other users can see this user.
* The user disabled the video. 

## Solution

### Step 1: Self-check

Before proceeding, ensure that your token is properly set. Refer to FAQ: [How to solve token-related errors](https://docs.agora.io/en/All/faq/token_error) for troubleshooting.

<a name="localblack"></a>**Black screen on the local side**

This is likely caused by a video capture failure on the local side. Do the following:

1. Check the camera hardware. Start the built-in video camera to test the recording function.
2. Check if the camera access permission is enabled. Both Android and iOS have a runtime access permission function under System Settings. 
    <div class="alert note"><ul><li>On Android, see <a href="https://docs.agora.io/en/Interactive%20Broadcast/start_live_android?platform=Android#add-project-permissions">Add project permissions</a > and <a href="https://docs.agora.io/en/Interactive%20Broadcast/start_live_android?platform=Android#3-get-the-device-permission">Get the device permission</a >.</li><li>On iOS, see <a href="https://docs.agora.io/en/Interactive%20Broadcast/start_live_ios?platform=iOS#add-project-permissions">Add project permissions</a >.</li></ul></div>
4. Check if another app is using the camera. Close all apps, restart your phone, and re-check.
5. If the app enabled the External Source Mode, check the data collected from the external video sources.

**Black screen on the remote side**

This is likely caused by a video capture failure on the remote side or slow downlink network on the local side. Do the following:

1. Check if the user disabled the remote video.
2. Switch to another network to ensure that the problem is not caused by a poor Internet connection.
3. Check whether the remote user uses the [channel encryption](https://docs.agora.io/en/Video/channel_encryption_windows?platform=Windows) function but the local user doesn't.
4. Check whether the remote user can preview their video on their own device. If not, then the cause of the black video probably lies on the remote side. Perform the steps in <a href="#localblack">Black screen on the local side</a>.

**Black screen on both sides**

This occurs when the video is not rendered correctly or the video function is not enabled. Do the following:

1. Check if the app calls the `enableVideo` method to enable the video.
2. Check if the video is enabled on both the local and remote sides.
3. Check the rendering type in the SDK log in Windows. If the rendering type is D2D, update to the latest graphics card driver. If the issue persists after updating the driver, switch to GDI rendering, which has the app call the following function before the user joins the channel:
	- 	`AParameter apm(*pRTCEngine);`
	- 	`nRet = apm->setInt("che.video.renderer.type", 9);`
4. If the app enables the Other Rendering Method Mode, check for any rendering issue.
5. Check if you are using the video SDK and not the voice SDK.
6. Check if the local and remote video views are set correctly. For example:
     - Neither the width nor height of the video view are set to 0.
     - The video display window is not covered by any black view.

### Step 2: Contact Agora customer support
If the issue persists, contact support@agora.io. Please provide the following information to help with the troubleshooting:
* The UIDs of the users sending and receiving the black video.
* The time frame when the black screen appears.
* Screen recording files.
* SDK log files. See [How can I set the log file](https://docs.agora.io/en/faq/logfile)?

### Step 3: Monitor the quality of experience in Agora Analytics in Console

You can monitor the statistics of every call in [Agora Analytics](https://dashboard.agora.io/analytics/call/search) in Console. For more information, see [Agora Analytics Tutorial](https://docs.agora.io/en/Agora%20Platform/aa_guide?platform=All%20Platforms).