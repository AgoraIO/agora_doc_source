---
title: Why is my video pixelated or jagged and green?
platform: ["Android","iOS","macOS","Windows"]
updatedAt: 2020-08-07 11:05:24
Products: ["Video","Interactive Broadcast"]
---
Pixelated video contains irregular pixels with incorrect colors, preventing the video from displaying an image.

<div class="alert note">Pixelated video is different from blurred video. Blurred video is usually caused by low resolution or bitrate. In a blurred video, the image is still intact.</div>

Green video contains jagged green blocks, preventing the video from displaying correctly.

The causes of pixelated or jagged, green video are due to any number of issues, including:

- Camera
- Third-party image enhancement SDK
- Resolution
- Video source module
- Video renderer module

Refer to following sections to troubleshoot.

## User self-check

<a id="pixelated_sender"></a>

### Pixelated video in the sender

1. Complete the following steps to check the camera, third-party image enhancement SDK, and resolution:

   1. Ensure that the camera works correctly.
   2. Check the third-party image enhancement SDK. If you are using a third-party image enhancement SDK, disable it and try again. If the video is no longer jagged and green, then this is the likely cause. Please contact the technical support of the third-party image enhancement SDK.
   3. Check whether the resolution is [recommended by Agora](https://docs.agora.io/en/Voice/API%20Reference/cpp/structagora_1_1rtc_1_1_video_encoder_configuration.html#af10ca07d888e2f33b34feb431300da69). If not, change the resolution.

2. Check the video source and the video renderer:

  - If the sender uses a custom source and renderer, check the custom source first and then check the custom renderer. See the sample projects for [custom source](https://github.com/AgoraIO/Advanced-Video/blob/dev/backup/Custom-Media-Device/Agora-Custom-Media-Device-Android/README.md) and [custom renderer](https://github.com/AgoraIO/Advanced-Video/tree/master/Android/sample-custom-render).
  - If the sender uses a custom source and an Agora RTC SDK renderer, check the custom source. See the [custom source](https://github.com/AgoraIO/Advanced-Video/blob/dev/backup/Custom-Media-Device/Agora-Custom-Media-Device-Android) sample project.
  - If the sender uses an Agora RTC SDK source and a custom renderer, check the custom renderer. See the [custom renderer](https://github.com/AgoraIO/Advanced-Video/blob/dev/backup/Custom-Media-Device/Agora-Custom-Media-Device-Android) sample project.
  - If the sender uses an Agora RTC SDK source and an Agora RTC SDK renderer, contact [support@agora.io](mailto:support@agora.io) for technical support.


<div class="alert note">When the sender uses YUV data with the custom renderer, check whether you have mistakenly used the <code>Stride</code> parameter and the <code>width</code> parameter in <code><a href="/en/Interactive%20Broadcast/API%20Reference/cpp/structagora_1_1media_1_1_i_video_frame_observer_1_1_video_frame.html">VideoFrame</a></code>.</div>

### Pixelated video in the receiver

If pixelated video appears in both the sender and the receiver, you need to [check pixelated video in the sender](#pixelated_sender) first. If pixelated video appears in only the receiver, refer to the following steps to troubleshoot:

1. Regardless of the renderer type, check the sender first. If the sender uses a custom source, you also need to check whether the video data is correctly sent from the custom source to the RTC SDK.
2. If the receiver uses custom renderer, check the custom renderer.

<div class="alert note">When the receiver uses YUV data with the custom renderer, check whether you have mistakenly used the <code>Stride</code> parameter and the <code>width</code> parameter in <code><a href="/en/Interactive%20Broadcast/API%20Reference/cpp/structagora_1_1media_1_1_i_video_frame_observer_1_1_video_frame.html">VideoFrame</a></code>.</div>


<a id="green_sender"></a>

### Jagged, green video in the sender

Complete the following steps to check the camera, third-party image enhancement SDK, and resolution:

1. Ensure that the camera works correctly.
2. Check the third-party image enhancement SDK. If you are using a third-party image enhancement SDK, disable it and try again. If the video is no longer jagged and green, then this is the likely cause. Please contact the technical support of the third-party image enhancement SDK.
3. Check whether the resolution is [recommended by Agora](/en/Voice/API%20Reference/cpp/structagora_1_1rtc_1_1_video_encoder_configuration.html#af10ca07d888e2f33b34feb431300da69). If not, change the resolution.

  - If the sender uses a custom source and renderer, when you use [`setVideoSource`](/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html?_ga=2.118557455.782459552.1593311578-73063204.1585890674#aa240e991d12b5240fc5fd362cbc0d521) to set a custom source, check whether the data formats in `getBufferType` and from `IVideoFrameConsumer` to the SDK are consistent. If the data formats are inconsistent, update the data formats and re-check. Then check the custom renderer.
  - If the sender uses a custom source and an Agora RTC SDK renderer, check the custom source. When you use [`setVideoSource`](/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html?_ga=2.118557455.782459552.1593311578-73063204.1585890674#aa240e991d12b5240fc5fd362cbc0d521) to set a custom source, check whether the data formats in `getBufferType` and from `IVideoFrameConsumer` to the SDK are consistent. If the data formats are inconsistent, update the data formats and re-check. Also check whether the video data is correctly sent from the custom source to the SDK.
  - If the sender uses an Agora RTC SDK source and a custom renderer, check the custom renderer.
  - If the sender uses an Agora RTC SDK source and an Agora RTC SDK renderer, please contact [support@agora.io](mailto:support@agora.io) for technical support.


In Android, if you use a custom source in the communication profile, check whether the video data format is Texture. The Agora RTC SDK for Android does not support receiving video data in Texture format. You need to update the video data format to YUV and re-check the video.

### Jagged, green video in the receiver

If jagged, green video appears for both the sender and the receiver, you need to [check jagged, green video in the sender](#green_sender) first. If jagged, green video appears for the receiver only, refer to the following steps to troubleshoot:

- Regardless of the renderer type, check the sender first. If the sender uses a custom source, you also need to check whether the video data is correctly transmitted from the custom source to the RTC SDK. When you use [`setVideoSource`](/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html?_ga=2.118557455.782459552.1593311578-73063204.1585890674#aa240e991d12b5240fc5fd362cbc0d521) to set a custom source, check whether the data format in `getBufferType` and from `IVideoFrameConsumer` to the SDK are consistent. If the data format is inconsistent, update the data format and re-check.

In Android, if you use a custom source in the communication profile, check whether the video data format is Texture. The Agora RTC SDK for Android does not support receiving video data in Texture format. You need to update the video data format to YUV and re-check the video.

## Contact customer support

If the previous steps in this article cannot help you fix this problem, please contact [support@agora.io](mailto:support@agora.io) for technical support. Please provide the following information to help with the troubleshooting:

### Necessary information

- Channel name with the pixelated or jagged, green video.
- UID of the users who send and receive the pixelated or jagged, green video and types of the devices.
- Steps to reproduce the problem.
- Screenshot of the pixelated or jagged, green video.
- The time frame of the problem.
- Source and renderer type: Agora RTC SDK source, custom source, Agora RTC SDK renderer, or custom renderer.
- SDK log files. See [How can I set the log file?](https://docs.agora.io/en/faq/logfile)

### Additional information

- Whether pixelated or jagged, green video is reproducible in other types of devices.
- Whether pixelated or jagged, green video is reproducible with other resolution.
- Whether pixelated or jagged, green video appears in other apps.