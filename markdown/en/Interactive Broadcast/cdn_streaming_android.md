---
title: Push Streams to CDN
platform: Android
updatedAt: 2021-01-07 08:41:05
---
## Introduction

The process of publishing streams into the CDN (Content Delivery Network) is called CDN live streaming, where users can view the live streaming through a web browser.

When multiple hosts are in a channel in CDN live streaming, [transcoding](terms#transcoding) is used to combine the streams of all the hosts into a single stream. Transcoding sets the audio and/or video profiles and the picture-in-picture layout for the stream to be pushed to the CDN.

![](https://web-cdn.agora.io/docs-files/1588993691567)


## Prerequisites

Ensure that you enable the RTMP Converter service before using this function.

1. Log in [Console](https://dashboard.agora.io/), and click ![img](https://web-cdn.agora.io/docs-files/1551260936285) in the left navigation menu to go to the **Products & Usage** page. 
2. Select a project from the drop-down list in the upper-left corner, and click **Duration** under **RTMP Converter**. 
![](https://web-cdn.agora.io/docs-files/1569302661254)
3. Click **Enable RTMP Converter**.
4. Click **Apply** to enable the RTMP Converter service and get 500 max concurrent channels.

<div class="alert note"> The number of concurrent channels, N, means that users can push streams to the CDN with transcoding in N channels of media streams. </div>

Now, you can use the function and see the usage statistics.


## Implementation 

Before proceeding, ensure that you implement the basic interactive live streaming in your project. See [Start Live Interactive Streaming](start_live_android) for details.

Refer to the following steps to push streams to the CDN:

<a name="single"></a>
1. The host in a channel calls the `setLiveTranscoding` method to set the transcoding parameters of media streams (`LiveTranscoding`), such as the resolution, bitrate, frame rate and position of watermark/background. If you need a transcoded picture, set the picture-in-picture layout for each user in the `TranscodingUser` class, as described in [Sample Code](#sample).

   > The `onTranscodingUpdated` callback occurs when the `LiveTranscoding` class updates, and reports update information to the local host.

2. The host in a channel calls the `addPublishStreamUrl` method to add a media stream to the CDN. 

   > Use `transcodingEnabled` to set whether transcoding is enabled or not.

3. The host in a channel calls the `removePublishStreamUrl` method to remove a media stream from the CDN live broadcast.


When the state of media streams pushed to the CDN changes, SDK triggers the `onRtmpStreamingStateChanged` callback to report current state of pushing streams to the local host. The local host can troubleshoot with the error code when exceptions occur.

<a name="sample"></a>
### Sample code

```java
// Java
// CDN transcoding settings.
LiveTranscoding config = new LiveTranscoding();
config.audioSampleRate = TYPE_44100;
config.audioChannels = 2;
config.audioBitrate = 48;
// Width of the video (px). The default value is 360.
config.width = 360;
// Height of the video (px). The default value is 640.
config.height = 640;
// Video bitrate of the video (Kbps). The default value is 400.
config.videoBitrate = 400;
// Video framerate of the video (fps). The default value is 15. Agora adjusts all values over 30 to 30.
config.videoFramerate = 15;
// If userCount > 1，set the layout for each user with transcodingUser.
config.userCount = 1;  
// Video codec profile. Choose to set as Baseline (66), Main (77) or High (100). If you set this parameter to other values, Agora adjusts it to the default value 100.
config.videoCodecProfile = HIGH;

// Sets the output layout for each user.
LiveTranscoding transcoding = new LiveTranscoding();
LiveTranscoding.TranscodingUser user = new LiveTranscoding.TranscodingUser();
// The uid must be identical to the uid used in joinChannel().
user.uid = 123456;
transcoding.addUser(user);
user.x = 0;
user.audioChannel = 0;
user.y = 0;
user.width = 640;
user.height = 720;

// CDN transcoding settings when using transcoding.
rtcEngine.setLiveTranscoding(transcoding);

// Adds a URL to which the host pushes a stream. Set the transcodingEnabled parameter as true to enable the transcoding service. Once transcoding is enabled, you need to set the live transcoding configurations by calling the setLiveTranscoding method. We do not recommend transcoding in the case of a single host.
rtcEngine.addPublishStreamUrl(url, true);

// Removes a URL to which the host pushes a stream.
rtcEngine.removePublishStreamUrl(url);
```

**Example 1: Two-host tile horizontally**


<img alt="../_images/sei_2host.png" src="https://web-cdn.agora.io/docs-files/en/sei_2host.png" style="width: 416.0px; height: 240.0px;"/>


```
Canvas:
     width: 640
     height: 360
     backgroundColor: #FFFFFF

User0:
      userId: 123
      x: 0
      y: 0
      width: 320
      height: 360
      zOrder: 1
      alpha: 1.0

User1:
      userId: 456
      x: 320
      y: 0
      width: 320
      height: 360
      zOrder: 1
      alpha: 1.0
```

**Example 2: Three-host tile vertically**

<img alt="../_images/sei_3host.png" src="https://web-cdn.agora.io/docs-files/en/sei_3host.png" style="width: 236.0px; height: 416.0px;"/>

```
Canvas:
      width: 360
      height: 640
      backgroundColor: #FFFFFF

   User0:
      userId: 123
      x: 0
      y: 0
      width: 360
      height: 640
      zOrder: 1
      alpha: 1.0

   User1:
       userId: 456
       x: 0
       y: 320
       width: 180
       height: 320
       zOrder: 2
       alpha: 1.0

   User2:
       userId: 789
       x: 180
       y: 320
       width: 180
       height: 320
       zOrder: 2
       alpha: 1.0
```

**Example 3: One full screen + floating thumbnails**

<img alt="../_images/sei_random.png" src="https://web-cdn.agora.io/docs-files/en/sei_random.png" style="width: 828.0px; height: 416.0px;"/>


```
Canvas:
   width: 360
   height: 640
   backgroundColor: #FFFFFF

User0:
   userId: 123
   x: 0
   y: 0
   width: 360
   height: 640
   zOrder: 1
   alpha: 1.0

User1:
    userId: 456
    x: 45
    y: 390
    width: 110
    height: 213
    zOrder: 2
    alpha: 1.0

User2:
    userId: 789
    x: 185
    y: 390
    width: 110
    height: 213
    zOrder: 2
    alpha: 1.0
```

We also provide an open-source [Live-Streaming](https://github.com/AgoraIO/Advanced-Interactive-Broadcasting/tree/master/Live-Streaming) demo project on GitHub.

### API reference

- [`setLiveTranscoding`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a3cb9804ae71819038022d7575834b88c)
- [`addPublishStreamUrl`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a4445b4ca9509cc4e2966b6d308a8f08f)
- [`removePublishStreamUrl`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a87b3f2f17bce8f4cc42b3ee6312d30d4)
- [`onTranscodingUpdated`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#afcacc60191697a4105364d1b0c411eb1)
- [`onRtmpStreamingStateChanged`](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1_i_rtc_engine_event_handler.html#a7b9f1a5d87480cfd6187c3da0ade3f94)

## Considerations

- Up to 17 hosts can be supported in the same live streaming channel.

- In the case of a single host, we do not recommend transcoding . You can skip [Step1](#single), and call the `addPublishStreamUrl` method directly with `transcodingEnabled (false)`.

  > Currently, Agora only supports pushing H.264 (default) streams to the CDN.

- Set the value of `videoBitrate` by referring to [Video Bitrate Table](./API%20Reference/java/classio_1_1agora_1_1rtc_1_1video_1_1_video_encoder_configuration.html#a4b090cd0e9f6d98bcf89cb1c4c2066e8). If you set a bitrate beyond the proper range, the SDK automatically adjusts it to a value within the range. 

- Agora charges a transcoding usage fee for CDN live streaming.