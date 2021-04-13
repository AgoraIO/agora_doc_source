---
title: Push Streams to CDN
platform: Unity
updatedAt: 2021-03-26 02:38:31
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

Before proceeding, ensure that you implement a basic live broadcast in your project. See [Start a Live Broadcast](start_live_unity) for details.

Refer to the following steps to push streams to the CDN:

<a name="single"></a>
1. The host in a channel calls the `SetLiveTranscoding` method to set the transcoding parameters of media streams (`LiveTranscoding`), such as the resolution, bitrate, frame rate and position of watermark/background. If you need a transcoded picture, set the picture-in-picture layout for each user in the `TranscodingUser` class, as described in [Sample Code](#sample).

   <div class="alert note">The <tt>OnTranscodingUpdatedHandler</tt> callback occurs when the <tt>LiveTranscoding</tt> class updates, and reports update information to the local host.</div>

2. The host in a channel calls the `AddPublishStreamUrl` method to add a media stream to the CDN. 

   <div class="alert note">Use <tt>transcodingEnabled</tt> to set whether transcoding is enabled or not.</div>

3. The host in a channel cans the `RemovePublishStreamUrl` method to remove a media stream from the CDN live broadcast.

When the state of media streams pushed to the CDN changes, SDK triggers the `OnRtmpStreamingStateChangedHandler` callback to report current state of pushing streams to the local host. The local host can troubleshoot with the error code when exceptions occur.

<a name="sample"></a>
### Sample code

```c#
// CDN transcoding settings.
LiveTranscoding transcoding = new LiveTranscoding();
transcoding.audioSampleRate = AUDIO_SAMPLE_RATE_TYPE.AUDIO_SAMPLE_RATE_44100;
transcoding.audioChannels = 2;
transcoding.audioBitrate = 48;
// Width of the video (px). The default value is 360.
transcoding.width = 360;
// Height of the video (px). The default value is 640.
transcoding.height = 640;
// Video bitrate of the video (Kbps). The default value is 400.
transcoding.videoBitrate = 400;
// Video framerate of the video (fps). The default value is 15. Agora adjusts all values over 30 to 30.
transcoding.videoFramerate = 15;
// If userCount > 1，set the layout for each user with transcodingUsers.
transcoding.userCount = 1;
// Video codec profile. Choose to set as Baseline (66), Main (77) or High (100). If you set this parameter to other values, Agora adjusts it to the default value 100.
transcoding.videoCodecProfile = VIDEO_CODEC_PROFILE_TYPE.VIDEO_CODEC_PROFILE_HIGH;
// Sets the output layout for each user.
TranscodingUser user = new TranscodingUser();
// The uid must be identical to the uid used in joinChannel().
user.uid = 123456;
user.x = 0;
user.y = 0;
user.audioChannel = 0;
user.width = 640;
user.height = 480;
transcoding.transcodingUsers = user;

// CDN transcoding settings when using transcoding.
mRtcEngine.SetLiveTranscoding(LiveTranscoding);
// Adds a URL to which the host pushes a stream. Set the transcodingEnabled parameter as true to enable the transcoding service. Once transcoding is enabled, you need to set the live transcoding configurations by calling the SetLiveTranscoding method. We do not recommend transcoding in the case of a single host.
mRtcEngine.AddPublishStreamUrl(url, true);
// Removes a URL to which the host pushes a stream.
mRtcEngine.RemovePublishStreamUrl(url);
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

### API reference

- [`SetLiveTranscoding`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#ade2c42adc26d8c56d8adfebf5c19e310)
- [`AddPublishStreamUrl`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a7af36af97846ff7f0535316ccabc7d05)
- [`RemovePublishStreamUrl`](./API%20Reference/unity/classagora__gaming__rtc_1_1_i_rtc_engine.html#a7b41d47fdce55b8a82e4ef4cee72b5cd)
- [`OnTranscodingUpdatedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#abfa4d0ed623cf7b5776f2651caeea936)
- [`OnRtmpStreamingStateChangedHandler`](./API%20Reference/unity/namespaceagora__gaming__rtc.html#a589c11ed19b0638824aa1b2e23971271)

## Considerations

- Up to 17 hosts can be supported in the same live broadcast channel.

- In the case of a single host, we do not recommend transcoding . You can skip [Step1](#single), and call the `AddPublishStreamUrl` method directly with `transcodingEnabled (false)`.

  <div class="alert note">Currently, Agora only supports pushing H.264 (default) streams to the CDN.</div>

- Agora charges a transcoding usage fee for CDN live streaming.