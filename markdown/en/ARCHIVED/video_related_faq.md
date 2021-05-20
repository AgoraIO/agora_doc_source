---
title: Video-related Issues
platform: Video Related Issues
updatedAt: 2019-10-22 14:18:44
---
This page provides common troubleshooting strategies for Agora's video products and services.

## Choppy Video

Choppy videos may be caused by slow Internet connections or bad device performances. 

Check the following:
* Check if the choppy videos are intermittent or consistent. Intermittent choppy videos are normal due to the nature of the network and device.
* Check if the Internet connection is stable. If it is stable but the video is still choppy, switch to 4G or another Wi-Fi network and check the video performance.
* Try the video call on another device.
* Turn off all pre-processing options, such as image enhancement, to ensure that the choppy video is not caused by any pre-processing option.

If the issue persists, contact Agora customer support and submit the issue with the following information:
* The uid of the user who sees the choppy video playback (in a live broadcast, whether the user is the host or audience).
* The time frame during which the choppy video playback appears.
* SDK logs and screen recording files of the user.

You can check the statistics of every call in [Agora Analytics](https://dashboard.agora.io/analytics/call/search) in Console. See [Agora Analytics Tutorial](https://dashboard.agora.io/analytics/call/tutorial?_ga=2.197716463.1125435494.1542623251-764614247.1539586349).

## Blurry Video

Blurry videos may be caused by low bitrates and resolution ratios. 

Check the following:
* Check `videoProfile`. If possible, set `videoProfile` to a higher level to see whether the video is clearer.
* Check the stream type of the receiver. If the stream type is low, call the `setRemoteVideoStreamType` method to switch from a low stream to high stream.
* Switch to 4G or another Wi-Fi network to ensure that the blurry video is not caused by poor Internet connections.
* Turn off all pre-processing options.

If the issue persists, contact Agora customer support and submit the issue with the following information:
* The uid of the user who sees the blurry video.
* The time frame during which the blurry video appears.
* SDK logs and screen recording files of the user.

You can check the statistics of every call in [Agora Analytics](https://dashboard.agora.io/analytics/call/search) in Console. See [Agora Analytics Tutorial](https://dashboard.agora.io/analytics/call/tutorial?_ga=2.197716463.1125435494.1542623251-764614247.1539586349).

## Black Screens

Common reasons for black screens:
* Network failure: If the local network connection is poor or interrupted, the user cannot see other users. If any user in the call has network issues, none of the other users in the call can see this user.
* The user disabled the video. 

Black screen scenarios:

**Black screen on the local side**

This may be caused by a video capture failure on the local side. The camera does not work properly or is used by another application.

Check the following:
* Check the camera hardware. Start the built-in video camera to test the recording function.
* Check if the camera access permission is enabled. Both Android and iOS systems have a runtime access permission function under System Settings. Additionally, security software on Android may control camera access permissions.
* Check if another app is using the camera. Close all apps, restart your phone, and try again.
* If the app enabled the External Source Mode, check the data collected from the external video sources.

**Black screen on the remote side**

This may be caused by a video capture failure on the remote side or slow downlink on the local side.

Check the following:

* Check if the user disabled the remote video.
* Switch to 4G or another Wi-Fi network to ensure that the problem is not caused by poor Internet connections.

**Black screen on the local and remote sides**

This problem occurs when the video is not rendered correctly or the video function is not enabled.

Check the following:
* Check if the app calls the enableVideo method to enable the video.
* Check if the video is enabled on the local and remote sides.
* Check the rendering type in the SDK log in Windows. If the rendering type is D2D, ensure that you update to the latest graphics card driver. If the issue persists after updating the driver, switch to GDI rendering, which means the app calls the following function before the user joins the channel:
	* `AParameter apm(*pRTCEngine)`;
	* `nRet = apm->setInt("che.video.renderer.type", 9)`;
* If the app enables the Other Rendering Method Mode, check for any rendering issue.

If the issue persists, contact Agora customer support and submit the issue with the following information:
* The uid of the user whose screen goes black.
* The time frame during which the black screen appears.
* SDK logs and screen recording files of the user.

## Mirror Images
Mirror images may occur in the following scenarios:

* If the user sees mirror images on the remote side, check if the app calls the `setParameters(audioEngine.remoteVideoMirroring)` method.
* If the user sees mirror images on the local side:
	* Images taken by the front camera are commonly mirrored.
	* If the images are not taken by the front camera, check if the app calls the `setParameters(che.video.localViewMirrorSetting)` method.

If the issue persists, contact Agora customer support and submit the issue with the following information:
* If the front or rear camera is used.
* If the mirror image is on the local or remote side.
* If you prefer the mirror or true image.

## Cannot Turn on the Camera
Check the following:
* Check if the camera access permission is enabled. Both Android and iOS systems have a runtime access permission function under System Settings. Additionally, security software on Android may control camera access permissions.
* Check if another application is using the camera. Close all applications, restart your phone, and try again.
* Check the camera hardware. Start the built-in video camera to test the recording function.

## Big Headshot and Letterbox
Big headshot and letterbox issues occur when the video size does not match the display window size and under the following scenarios:

* If the video size is different from the camera output size, the video is cropped before it is encoded and then enlarged.
* If the video size is different from the display window size and the receiver uses the Hidden mode for rendering, the video is also cropped before it is encoded and then enlarged.
* If the video size is different from the display window size and the receiver uses the Fit mode for rendering, the video is reduced in size, resulting in dark bands on the margin of the screen.

If the issue persists, contact Agora customer support and submit the issue with the following information:

* SDK logs of the sender.
* If the sender uses a mobile phone, whether the sender’s screen is horizontal or vertical.
* The window aspect ratio of the receiver.


