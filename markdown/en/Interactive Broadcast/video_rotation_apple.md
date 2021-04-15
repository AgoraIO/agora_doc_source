---
title: Rotate the Video
platform: iOS
updatedAt: 2020-07-06 17:58:25
---
## Introduction

The following figure shows how the Agora SDK captures, processes, and outputs videos.

<img alt="../_images/rotation_encoding_decoding.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_encoding_decoding.jpg" style="width: 840px; "/>

Video rotation involves the video capturer and the video player, where:

- The video capturer captures the video and outputs the video information, that is, the relative position of the video and the status bar.
- The video player renders the received video and rotates the video according to the rotation information.

To avoid issues such as video scaling and scropping caused by video rotation, the Agora SDK provides a `orientationMode` parameter in the `setVideoEncoderConfiguration` method. You can use this parameter to set the video orientation mode according to your scenario to get the video you want.

## Implementation

Before setting the video orientation mode, ensure that you have implemented basic real-time communication functions in your project. For details, see the following documents:

- iOS: [Start a Call](start_call_ios) or [Start a Live Broadcast](start_live_ios)
- macOS: [Start a Call](start_call_mac) or [Start a Live Broadcast](start_live_mac)

The `orientationMode` parameter provides three modes, `ADAPTIVE`, `FIXED_LANDSCAPE`, and `FIXED_PORTRAIT` for different user needs. 

<div class="alert note">The relative position of the video and the status bar on the video capturer and the player remain the same for all modes.</div>

### ADAPTIVE

In the ADAPTIVE mode, the output video always follows the orientation of the captured video, because the receiver takes the rotational information passed on from the video encoder. This mode is mainly used between Agora’s SDKs.

The following figures show the video orientations at the video capturer and player when a rear camera is used as the video capturer. Note that the video orientation differs according to the UI lock of your app.

**UI lock (or UI unlock with the app disabling the screen auto-rotation)**

The relative position of the status bar remains the same as the screen and not according to the phone tilt \(for example in WeChat\). Therefore, the relative position of the video and the screen remains the same for the video capturer and the player.
		
- For a landscape capturer:

  <img alt="../_images/rotation_adaptive_uilock_landscape.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_adaptive_uilock_landscape.jpg" />

- For a portrait capturer:
   
   <img alt="../_images/rotation_adaptive_uilock_portrait.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_adaptive_uilock_portrait.jpg" />

**UI unlock with the app enabling the screen auto-rotation**

The status bar of the app remains horizontal, regardless of the orientation of the screen \(for example in Facetime\). Therefore, the relative position of the video and the phone tilt remains the same for the video capturer and the player.

- For a landscape capturer:

    <img alt="../_images/rotation_adaptive_uiunlock_landscape.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_adaptive_uiunlock_landscape.jpg" />

- For a portrait capturer:

    <img alt="../_images/rotation_adaptive_uiunlock_portrait.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_adaptive_uiunlock_portrait.jpg" />


### FIXED_LANDSCAPE

In the Fixed_LANDSCAPE mode, the video capturer sends the video in the landscape orientation relative to the status bar. If the captured video is in portrait mode, the video encoder crops it to fit the output. 

This mode applies to situations where the receiving end cannot process the rotational information. For example, CDN live streaming.

The following figures show the video orientations at the video capturer and the player when a rear camera is used as the video capturer.

-   The captured video in the landscape mode (video cropping is not needed):

    <img alt="../_images/rotation_fixed_landscape.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_fixed_landscape.jpg" />

-   The captured video in the portrait mode (video cropping **is** needed):

    <img alt="../_images/rotation_fixed_landscape_cut.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_fixed_landscape_cut.jpg" />


### FIXED_PORTRAIT

In the Fixed_PORTRAIT mode, the video capturer sends out the video in the portrait orientation relative to the status bar. If the captured video is in landscape mode, the video encoder crops it to fit the output. 

This mode applies to situations where the receiving end cannot process the rotational information. For example, CDN live streaming.

The following figures show the video orientations at the video capturer and the player when a rear camera is used as the video capturer.

-   The captured video in the portrait mode (video cropping is not needed):

    <img alt="../_images/rotation_fixed_portrait.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_fixed_portrait.jpg" />

-   The captured video in the landscape mode (video cropping **is** needed):

    <img alt="../_images/rotation_fixed_portrait_cut.jpg" src="https://web-cdn.agora.io/docs-files/en/rotation_fixed_portrait_cut.jpg" />

### API reference

- [setVideoEncoderConfiguration](./API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/setVideoEncoderConfiguration:)
- [orientationMode](./API%20Reference/oc/Classes/AgoraVideoEncoderConfiguration.html#//api/name/orientationMode)

## Considerations

Set the `orientationMode` parameter in the `setVideoEncoderConfiguraion` method. For the API call sequence and sample code of this method, see [Video Profiles](video_profile_apple).