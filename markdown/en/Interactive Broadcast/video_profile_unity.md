---
title: Set the Video Profile
platform: Unity
updatedAt: 2020-11-16 04:31:56
---
## Introduction

You can set the video profile, either before or after a user joins a channel, for the user to enjoy better video quality during a video call or live broadcast.

The Agora SDK uses the `SetVideoEncoderConfiguration` method to set the video profile. Each video profile corresponds to a set of video parameters, including the resolution, frame rate, bitrate, and video orientation.

## Implementation

Before setting the video profile, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Video Call](start_call_unity) or [Start a Video Broadcast](start_live_unity).

After initializing `IRtcEngine`, you can call the `SetVideoEncoderConfiguration` method to set the video profile and set the video resolution, frame rate, birtate and orientation mode.

### API call sequence

You can also choose when to call the `SetVideoEncoderConfiguration` method according to your scenarios:

- Call this method after `EnableVideo` and `EnableVideoObserver` and before `JoinChannelByKey` to set the local video encoding parameters before joining the channel.
- If you do not set the video profile after joining the channel, we recommend calling this method before `EnableVideo` to reduce the render time of the first video frame.
- You can also call this method after joining the channel to update the video profile in real time.


### Sample code

```C#
// Create a VideoEncoderConfiguration instance. See the descriptions of the parameters in API Reference.
VideoEncoderConfiguration config = new VideoEncoderConfiguration();
// Sets the video resolution.
config.dimensions.width = 640;
config.dimensions.height = 480;
// Sets the video frame rate.
config.frameRate = FRAME_RATE.FRAME_RATE_FPS_15;
// Sets the video encoding bitrate (Kbps).
config.bitrate = 800;
// Sets the adaptive orientation mode. See the description in API Reference.
config.orientationMode = ORIENTATION_MODE.ORIENTATION_MODE_ADAPTIVE;
// Sets the video encoding degradation preference under limited bandwidth. MIANTAIN_QUALITY means to degrade the frame rate to maintain the video quality.
config.degradationPreference = DEGRADATION_PREFERENCE.MAINTAIN_QUALITY;
// Sets the video encoder configuration.
mRtcEngine.SetVideoEncoderConfiguration(config);
```

### API Reference
- [`SetVideoEncoderConfiguration`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a7dc9aa63ad1ba10f2451efd02e0f1f73)

## Considerations
- Setting [`DEGRADATION_PREFERENCE`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a1bda0e6bd3dcd1b0ca3764394800346c) as `MAINTAIN_QUALITY` means that the SDK degrades the frame rate under limited bandwidth so as to maintain the video quality. Developers can set the [`minFrameRate`](./API%20Reference/unity/structagora__gaming__rtc_1_1_video_encoder_configuration.html#a6de8eab8863e9bdf28ee49a080241c66) parameter to balance the frame rate and video quality under unreliable network connections:

	- When  `minFrameRate` is relatively low, the frame rate degrades significantly, so the poor network conditions have little impact on the video quality.
	- When `minFrameRate` is relatively high, the frame rate degrades within a limited range, so the poor network conditions can have huge impact on the video quality.

 Do not set the `minFrameRate` parameter to a value greater than `frameRate`. The default value of `minFrameRate` is experiment verified and can satisfy most use scenarios. We do not recommend changing it.
- If you do not need to set the video profile after joining the channel, you can call the `SetVideoEncoderConfiguration` method before the `EnableVideo` method to reduce the render time of the first video frame.
- The Agora Unity SDK may adjust the parameters under poor network conditions. 
-  A live broadcast channel generally requires a higher bitrate for better video quality. Therefore, Agora recommends setting the bitrate in the live broadcast profile to twice of that in the communication profile. See [Set the bitrate](./API%20Reference/unity/structagora__gaming__rtc_1_1_video_encoder_configuration.html#ae2fee92452a1914df68ec9a07a7938a5).
- For better video quality during a live broadcast, a stable network connection is recommended.
- Setting parameters in the `SetVideoEncoderConfiguration` method may affect your bill. For more information, see [Pricing and Billing](https://docs.agora.io/en/faq/video_billing).


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

You can also customize the video parameters with the `SetVideoEncoderConfiguration` method, such as increasing the bitrate to ensure the video quality according to the table below.

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


