---
title: Set the Video Profile
platform: Android
updatedAt: 2020-12-04 09:51:07
---
## Introduction

You can set the video profile, either before or after a user joins a channel, for the user to enjoy better video quality during a video call or live broadcast.

The Agora SDK uses the `setVideoEncoderConfiguration` method to set the video profile. Each video profile corresponds to a set of video parameters, including the resolution, frame rate, bitrate, and video orientation.

## Implementation

Before setting the video profile, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Call](start_call_android) or [Start a Live Broadcast](start_live_android).

After initializing RtcEngine, you can call the `setVideoEncoderConfiguration` method to set the video profile and set the video resolution, frame rate, birtate and orientation mode.

### API call sequence

Refer to the following diagram to set the video profile in your project:

![](https://web-cdn.agora.io/docs-files/1568867300257)

You can also choose when to call the `setVideoEncoderConfiguration` method according to your scenarios:

- Call this method after `enableVideo` and before `joinChannel` to set the local video encoding parameters before joining the channel.
- If you do not set the video profile after joining the channel, we recommend calling this method before `enableVideo` to reduce the render time of the first video frame.
- You can also call this method after joining the channel to update the video profile in real time.


### Sample code

```java
// Create a VideoEncoderConfiguration instance. See the descriptions of the parameters in API Reference.
VideoEncoderConfiguration config = new VideoEncoderConfiguration(
	// Choose a video resolution or customize one.
	VideoDimensions.VD_640x480,
	// Frame rate. 15 is the default setting. Agora recommends not setting to over 30.
	FRAME_RATE_FPS_15,
	// The standard bitrate. See the description in API Reference. Agora recommends setting the bitrate to the standard mode.
	STANDARD_BITRATE,
	// The adaptive orientation mode. See the description in API Reference.
	ORIENTATION_MODE_ADAPTIVE,
	// The degradation preference under limited bandwidth. MIANTAIN_QUALITY means to degrade the frame rate to maintain the video quality.
	MAINTAIN_QUALITY,
);

rtcEngine.setVideoEncoderConfiguration(config);
```

We provide an open-source Agora-Android-Tutorial-1to1 demo project on GitHub. You can try the demo and view the source code of the `setupVideoConfig` method in the [VideoChatViewActivity.java](https://github.com/AgoraIO/Basic-Video-Call/blob/master/One-to-One-Video/Agora-Android-Tutorial-1to1/app/src/main/java/io/agora/tutorials1v1vcall/VideoChatViewActivity.java) file.

### API Reference
- [`setVideoEncoderConfiguration`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#af5f4de754e2c1f493096641c5c5c1d8f)

## Considerations
- Setting [`degradationPrefer`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html?transId=2.4#a47f36783c1f9da09454c19cafb489b3c) as [`MAINTAIN_QUALITY`](./API%20Reference/java/enumio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration_1_1_d_e_g_r_a_d_a_t_i_o_n___p_r_e_f_e_r_e_n_c_e.html?transId=2.4#a654947f783b27ef8da2e7b1f1045ef50) means that the SDK degrades the frame rate under limited bandwidth so as to maintain the video quality. Developers can set the [`minFrameRate`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#ad8d377cd077587ee0991d297b1a8c8bc) parameter to balance the frame rate and video quality under unreliable network connections:

	- When  `minFrameRate` is relatively low, the frame rate degrades significantly, so the poor network conditions have little impact on the video quality.
	- When `minFrameRate` is relatively high, the frame rate degrades within a limited range, so the poor network conditions can have huge impact on the video quality.

 Do not set the `minFrameRate` parameter to a value greater than `frameRate`. The default value of `minFrameRate` is experiment verified and can satisfy most use scenarios. We do not recommend changing it.
- If you do not need to set the video profile after joining the channel, you can call the `setVideoEncoderConfiguration` method before the `enableVideo` method to reduce the render time of the first video frame.
- The Agora SDK may adjust the parameters under poor network conditions. 
-  A live broadcast channel generally requires a higher bitrate for better video quality. Therefore, Agora recommends setting the bitrate in the live broadcast profile to twice of that in the communication profile. See [Set the bitrate](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a4b090cd0e9f6d98bcf89cb1c4c2066e8).
- For better video quality during a live broadcast, a stable network connection is recommended.
- Setting parameters in the `setVideoEncoderConfiguration` method may affect your bill. For more information, see [Pricing and Billing](https://docs.agora.io/en/faq/video_billing).


## Recommended video profiles

Video profiles vary from case to case. For example, in a one-to-one online class, the video windows of the teacher and student are both large, which requires higher resolutions, frame rates, and bitrates. While in a one-to-four online class, the video windows of the teacher and students are smaller, so lower resolutions, frame rates, and bitrates are used to accommodate the downward bandwidth.

The following profiles for different scenarios are recommended:

- One-to-one video call: 
  - Resolution: 320 x 240; frame rate: 15 fps; bitrate: 200 Kbps
  - Resolution: 640 x 360; frame rate: 15 fps; bitrate: 400 Kbps
- One-to-many video call: 
  - Resolution: 160 x 120; frame rate: 15 fps; bitrate: 65 Kbps
  - Resolution: 320 x 180; frame rate: 15 fps; bitrate: 140 Kbps
  - Resolution: 320 x 240; frame rate: 15 fps; bitrate: 200 Kbps 

You can also customize the video parameters with the `setVideoEncoderConfiguration` method, such as increasing the bitrate to ensure the video quality according to the table below.

| Resolution<br>(width x height) | Frame rate<br>(fps) | Base bitrate<br>(Kbps, for Communication) | Live bitrate<br>(Kbps, for Live Broadcast) |
| ------------------------------ | ------------------- | ----------------------------------------- | ------------------------------------------ |
| 160 x 120                      | 15                  | 65                                        | 130                                        |
| 120 x 120                      | 15                  | 50                                        | 100                                        |
| 320 x 180                      | 15                  | 140                                       | 280                                        |
| 180 x 180                      | 15                  | 100                                       | 200                                        |
| 240 x 180                      | 15                  | 120                                       | 240                                        |
| 320 x 240                      | 15                  | 200                                       | 400                                        |
| 240 x 240                      | 15                  | 140                                       | 280                                        |
| 424 x 240                      | 15                  | 220                                       | 440                                        |
| 640 x 360                      | 15                  | 400                                       | 800                                        |
| 360 x 360                      | 15                  | 260                                       | 520                                        |
| 640 x 360                      | 30                  | 600                                       | 1200                                       |
| 360 x 360                      | 30                  | 400                                       | 800                                        |
| 480 x 360                      | 15                  | 320                                       | 640                                        |
| 480 x 360                      | 30                  | 490                                       | 980                                        |
| 640 x 480                      | 15                  | 500                                       | 1000                                       |
| 480 x 480                      | 15                  | 400                                       | 800                                        |
| 640 x 480                      | 30                  | 750                                       | 1500                                       |
| 480 x 480                      | 30                  | 600                                       | 1200                                       |
| 848 x 480                      | 15                  | 610                                       | 1220                                       |
| 848 x 480                      | 30                  | 930                                       | 1860                                       |
| 640 x 480                      | 10                  | 400                                       | 800                                        |
| 1280 x 720                     | 15                  | 1130                                      | 2260                                       |
| 1280 x 720                     | 30                  | 1710                                      | 3420                                       |
| 960 x 720                      | 15                  | 910                                       | 1820                                       |
| 960 x 720                      | 30                  | 1380                                      | 2760                                       |

