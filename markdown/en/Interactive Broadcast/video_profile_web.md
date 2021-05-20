---
title: Set the Video Profile
platform: Web
updatedAt: 2021-01-05 06:11:19
---
## Introduction

You can set the video profile, either before or after a user joins a channel, for the user to enjoy better video quality during a video call or live interactive streaming.

The Agora Web SDK provides two interfaces to set the video profile: `setVideoProfile` and `setVideoEncoderConfiguration`. You can choose either one according to your video scenario. The difference between these two interfaces is as follows:

- `setVideoEncoderConfiguration`: You can set each parameter of the video profile.
- `setVideoProfile`: You can choose one profile, which includes a fixed set of parameters.

## Implementation

Before setting the video profile, ensure that you have implemented the basic real-time communication functions in your project. For details, see [Start a Video Call](start_call_web) or [Start a Live Interactive Video Streaming](start_live_web).

After creating a stream object, you can call the `setVideoProfile` or `setVideoEncoderConfiguration` method to set the video resolution, frame rate, birtate and orientation mode.

### API call sequence

Refer to the following diagram to set the video profile in your project:

![](https://web-cdn.agora.io/docs-files/1568878370519)

**Note:**

- If you prefer video smoothness to sharpness, use `setVideoProfile` to set the video resolution and Agora self-adapts the video bitrate according to the network condition. If you prefer video sharpness to smoothness, use `setVideoEncoderConfiguration`, and set `min` in `bitrate` as 0.4 - 0.5 times the bitrate value in the video profile table.
- The `setVideoProfile` method is usually called before `Stream.init`. From v2.7, you can also call this method after `Stream.init` to change the video encoding profile.
- The `setVideoEncoderConfiguration` method can be called before or after `Stream.init`, but has the following known limitations:

	- This method works on Chrome 63 or later and is not fully functional on other. Known issues are as follows:

		 - The frame rate setting does not take effect on Safari 12 or earlier.
		 - Safari 11 or earlier only supports specific resolutions.

	- The parameters specified in this method are ideal values under ideal network conditions. .
	- The actual resolution, frame rate, and bitrate depend on the device. See [MediaStreamTrack.applyConstraints()](https://developer.mozilla.org/zh-CN/docs/Web/API/MediaStreamTrack/applyConstraints) for more information.

### Sample code

```javascript
// Set the video profile with the setVideoEncoderConfiguration method.
stream.setVideoEncoderConfiguration({
  // The video resolution.
  resolution: {
    width: 640,
    height: 480
  },
  // The video frame rate (fps). We recommend setting it as 15. Do not set it to a value greater than 30.
  frameRate: {
    min: 15,
    max: 30
  },
  // The video bitrate (Kbps). Refer to the video profile table below to set this parameter.
  bitrate: {
    min: 1000,
    max: 5000
  }
});

// Set the video profile with the setVideoProfile` method.
// Sets the video profile as 480p_3, which means a resolution of 480 x 480, a frame rate of 15, and a bitrate of 400.
localStream.setVideoProfile("480p_3");
});
```

###  API Reference

- [`setVideoEncoderConfiguration`](./API%20Reference/web/interfaces/agorartc.stream.html#setvideoencoderconfiguration)
- [`setVideoProfile`](./API%20Reference/web/interfaces/agorartc.stream.html#setvideoprofile)

## Considerations
- Supported resolutions vary from browser to browser. See [video profile and supported Browsers](./API%20Reference/web/interfaces/agorartc.stream.html#setvideoprofile) for details.
- Due to the limitations of some devices and browsers, the resolution you set may fail to take effect and be adjusted by the browser. In this case, your charges will be calculated based on the actual resolution.
- Whether the 1080 resolution or above can be supported depends on the device. If the device cannot support 1080p, the frame rate will be lower than the set value.
- The Safari browser has a fixed video frame rate of 30 fps and does not support customization.
- Changing the video profile after `Stream.init` only works on Chrome 63 or later and Safari 11 or later. On some iOS devices, when you update the video profile after `Stream.init`, black bars might appear around your video.
- Do not call these two methods when publishing streams.

## Recommended video profiles

Video profiles vary from case to case. For example, in a one-to-one online class, the video windows of the teacher and student are both large, which requires higher resolutions, frame rates, and bitrates. While in a one-to-four online class, the video windows of the teacher and students are smaller, so lower resolutions, frame rates, and bitrates are used to maintan the bandwidth.

We recommend the following profiles for different scenarios:

- One-to-one video call: 
  - Resolution: 320 x 240; frame rate: 15 fps; bitrate: 200 Kbps
  - Resolution: 640 x 360; frame rate: 15 fps; bitrate: 400 Kbps
- One-to-many video call: 
  - Resolution: 160 x 120; frame rate: 15 fps; bitrate: 65 Kbps
  - Resolution: 320 x 180; frame rate: 15 fps; bitrate: 140 Kbps
  - Resolution: 320 x 240; frame rate: 15 fps; bitrate: 200 Kbps 

If you want to customize the video parameters with the setVideoEncoderConfiguration method, refer to the table below to set the parameters:

| Video profile | Resolution（Width x Height） | Frame rate（fps） | Bitrate（Kbps） |
| ------------- | ---------------------------- | ----------------- | --------------- |
| 120p          | 160 x 120                    | 15                | 65              |
| 120p_1        | 160 x 120                    | 15                | 65              |
| 120p_3        | 120 x 120                    | 15                | 50              |
| 180p          | 320 x 180                    | 15                | 140             |
| 180p_1        | 320 x 180                    | 15                | 140             |
| 180p_3        | 180 x 180                    | 15                | 100             |
| 180p_4        | 240 x 180                    | 15                | 120             |
| 240p          | 320 x 240                    | 15                | 200             |
| 240p_1        | 320 x 240                    | 15                | 200             |
| 240p_3        | 240 x 240                    | 15                | 140             |
| 240p_4        | 424 x 240                    | 15                | 220             |
| 360p          | 640 x 360                    | 15                | 400             |
| 360p_1        | 640 x 360                    | 15                | 400             |
| 360p_3        | 360 x 360                    | 15                | 260             |
| 360p_4        | 640 x 360                    | 30                | 600             |
| 360p_6        | 360 x 360                    | 30                | 400             |
| 360p_7        | 480 x 360                    | 15                | 320             |
| 360p_8        | 480 x 360                    | 30                | 490             |
| 360p_9        | 640 x 360                    | 15                | 800             |
| 360p_10       | 640 x 360                    | 24                | 800             |
| 360p_11       | 640 x 360                    | 24                | 1000            |
| 480p          | 640 x 480                    | 15                | 500             |
| 480p_1        | 640 x 480                    | 15                | 500             |
| 480p_2        | 648 x 480                    | 30                | 1000            |
| 480p_3        | 480 x 480                    | 15                | 400             |
| 480p_4        | 640 x 480                    | 30                | 750             |
| 480p_6        | 480 x 480                    | 30                | 600             |
| 480p_8        | 848 x 480                    | 15                | 610             |
| 480p_9        | 848 x 480                    | 30                | 930             |
| 480p_10       | 640 x 480                    | 10                | 400             |
| 720p          | 1280 x 720                   | 15                | 1130            |
| 720p_1        | 1280 x 720                   | 15                | 1130            |
| 720p_2        | 1280 x 720                   | 15                | 2080            |
| 720p_3        | 1280 x 720                   | 30                | 1710            |
| 720p_5        | 960 x 720                    | 15                | 910             |
| 720p_6        | 960 x 720                    | 30                | 1380            |
| 1080p         | 1920 x 1080                  | 15                | 2080            |
| 1080p_1       | 1920 x 1080                  | 15                | 2080            |
| 1080p_2       | 1920 x 1080                  | 30                | 3000            |
| 1080p_3       | 1920 x 1080                  | 30                | 3150            |
| 1080p_5       | 1920 x 1080                  | 60                | 4780            |
| 1440p         | 2560 x 1440                  | 30                | 4850            |
| 1440p_1       | 2560 x 1440                  | 30                | 4850            |
| 1440p_2       | 2560 x 1440                  | 60                | 7350            |
| 4K            | 3840 x 2160                  | 30                | 8910            |
| 4K_1          | 3840 x 2160                  | 30                | 8910            |
| 4k_3          | 3840 x 2160                  | 60                | 13500           |
