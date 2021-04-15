---
title: Video for Multiple Users
platform: All Platforms
updatedAt: 2021-01-04 07:52:27
---
## Introduction

In a video call or video broadcast, if multiple users publish video streams at the same time, user experience may be affected by limited device performance and excessive bandwidth consumption.

Use this article as a best practice for implementing a video scenario that enables multiple users to publish video streams simultaneously.

To minimize bandwidth consumption and ensure smooth communication in a video scenario with multiple users, Agora recommends the following:

- All publishers enable [dual-stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#dual-stream). 
- Every subscriber receives the high-quality video stream of only one publisher, and the low-quality stream of the other publishers.

## Implementation

Before proceeding, ensure that you have implemented the basic real-time audio and video functions in your project. For details, see [Start a Video Call](https://docs.agora.io/en/Video/start_call_android?platform=Android) or [Start a Video Broadcast](https://docs.agora.io/en/Interactive%20Broadcast/start_live_android?platform=Android).

<div class="alert note">In this articel, Native SDK refers to the Agora RTC SDK supported on Android, iOS, macOS, Windows, Electron, and Unity; Web SDK refers to the Agora RTC SDK for Web.</div>

### Native SDK

<div class="alert note">If you set the channel profile as communication, Agora suggests calling <code>setParameters("{"che.audio.live_for_comm": true}")</code> before joining a channel, to apply the optimization strategy for communication scenarios with multiple users.<br>
For the Agora RTC Native SDK v2.3.2 or earlier, you also need to call <code>setParameters("{\"che.video.moreFecSchemeEnabled\": true}")</code> to enable ULP FEC, which improves the reliability of video data transmission.</div>


#### 1. Enable dual-stream mode

After joining a channel, call `enableDualStreamMode` to enable dual-stream mode on the publishers' clients. In dual-stream mode, the SDK transmits a high-quality video stream and a low-quality video stream from the publisher. The high-quality video stream has a higher resolution and bitrate than the low-quality video stream.

The SDK sets the default video profile of the low-quality video stream based on that of the high-quality video stream.

#### 2. Set the remote video stream type

Call `setRemoteVideoStreamType` on each subscriber's client to subscribe to the high-quality stream from only one publisher and the low-quality stream of the other publishers.

#### 3. Set the video profile for the low-quality stream

To reduce bandwidth consumption, Agora recommends calling the following method to set the video profile of the low-quality stream:

```
// Sets the video profile of the low-quality stream as 320 × 180 px, 5 fps, and 140 Kps.
setParameters(``"{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":5,\"bitRate\":140}}"``);
```

The low-quality video stream supports a maximum profile of 640 × 480 px, 30 fps, and 1000 Kbps. To ensure smooth communication, Agora recommends that the resolution of the low-quality video stream not exceed 320 × 180 px, and the bitrate not exceed 140 Kbps. Ensure that the bitrate of the low-quality stream is lower than that of the high-quality stream.

#### API Reference

- [enableDualStreamMode](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a645cb7d0f3a59dda27b157cf130c8c9a)
- [setRemoteVideoStreamType](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#a51756b4d2e7997fbe6481d2deb5c0396)

### Web SDK

#### 1. Enable dual-stream mode

After calling `Stream.init` successfully, call `enableDualStream` to enable dual-stream mode on the publishers' clients. In dual-stream mode, the SDK transmits a high-quality video stream and a low-quality video stream from the publisher. The high-quality video stream has a higher resolution and bitrate than the low-quality video stream.

For the Agora Web SDK v3.1.0 or later, the low-quality stream has a fixed default video profile: A resolution (width × height) of 160 × 120 px, a bitrate of 50 Kbps, and a frame rate of 15 fps. For the Agora Web SDK earlier than v3.1.0, the SDK sets the default video profile of the low-quality video stream based on that of the high-quality video stream.

#### 2. Set the remote video stream type

Call `setRemoteVideoStreamType` on each subscriber's client to receive the high-quality stream from only one publisher and the low-quality stream of the other publishers.

#### 3. Set the video profile for the low-quality stream

To reduce bandwidth consumption, Agora recommends calling `Client.setLowStreamParameter` to customize the video profile of the low-quality stream.

<div class="alert note"><ul><li>From v3.1.0, the low-quality video stream keeps the aspect ratio of the high-quality video stream. If the resolution of the low-quality stream has a different aspect ratio, the SDK automatically adjusts the height of the low-quality stream.</li><li>Different web browsers have different restrictions on the video profile, and the parameters that you set here may fail to take effect. The Firefox browser has a fixed frame rate of 30 fps, therefore the frame rate settings do not work on the Firefox browser.</li></ul></div>

#### 4. Publish and subscribe to a stream

Call  `Client.publish` to [Publish a local stream](https://docs.agora.io/en/Interactive%20Broadcast/start_live_web?platform=Web#publish-a-local-stream), and call `Client.subscribe` to [Subscribe to a remote stream](https://docs.agora.io/en/Interactive%20Broadcast/start_live_web?platform=Web#subscribe-to-a-remote-stream).

#### API Reference

- [enableDualStream](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.client.html#enabledualstream)
- [setRemoteVideoStreamType](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.client.html#setremotevideostreamtype)
- [setLowStreamParameter](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.client.html#setlowstreamparameter)

## Relation between the high-quality and low-quality streams

### Native SDK

The SDK sets the video profile of the low-quality video stream based on that of the high-quality video stream. This section introduces the relation between the video profiles of the high-quality and low-quality video stream in scenarios where you do not set the video profile of the low-quality video stream.

#### Communication profile

The default video profile of the low-quality video stream conforms to the following rules:

- Width and height: The width of the low-quality stream = the width of the high-quality stream × 0.45. The same applies to height. The maximum width value is 288 px, and the minimum 64. The aspect ratio of the low-quality stream is identical to that of the high-quality stream.
- Frame rate: The frame rate of the low-quality stream stays at 5 fps.
- Bitrate: The bitrate of the low-quality stream = the bitrate of the high-quality stream × 0.1.
- The width of the low-quality stream should be the multiples of 4, and the height an even number.

#### Live-broadcast profile

The following table shows the default resolution, bitrate, and frame rate of the low-quality video stream when the high-quality video stream uses different mainstream video profiles.

| Aspect ratio of the high-quality stream | Resolution (width x height)                                  | Bitrate | Frame rate |
| --------------------------------------- | ------------------------------------------------------------ | ------- | ---------- |
| 1:1                                     | 160 × 160                                                    | 68      | 5          |
| 3:4                                     | 120 × 160                                                    | 45      | 5          |
| 4:3                                     | 160 × 120                                                    | 45      | 5          |
| 9:16                                    | 108 × 192                                                    | 50      | 5          |
| 16:9                                    | 192 × 108                                                    | 50      | 5          |
| Others                                  | The larger of either width or height takes 160 as the value. Calculate the lower value according to the aspect ratio. | 68      | 5          |

#### Mainstream video profiles

The following table shows the default resolution, frame rate, and bitrate of the low-quality video stream, given different mainstream video profiles of the high-quality video stream. For the high-quality stream, this table only lists the video profiles in the communication profile. In the live-broadcast profile, the bitrate of the high-quality stream doubles that in the communication profile, and does not exceed 6500.

| High-quality stream<br>(px, fps, Kbps) | Low-quality stream (Communication)<br>(px, fps, Kbps) | Low-quality stream (Live-broadcast)<br>(px, fps, Kbps) |
| ---------------------------------- | ------------------------------------------------- | -------------------------------------------------- |
| 320 × 240, 15, 200                 | 144 × 108, 5, 20                                  | 160 × 120, 5, 45                                   |
| 640 × 360, 15, 400                 | 288 × 162, 5, 40                                  | 192 × 108, 5, 50                                   |
| 640 × 480, 15, 500                 | 288 × 216, 5, 50                                  | 160 × 120, 5, 45                                   |
| 1280 × 720, 15, 1130               | 288 × 162, 5, 113                                 | 192 × 108, 5, 50                                   |
| 240 × 320, 15, 200                 | 108 × 144, 5, 20                                  | 120 × 160, 5, 45                                   |
| 240 × 320, 15, 200                 | 108 × 144, 5, 20                                  | 120 × 160, 5, 45                                   |
| 360 × 640, 15, 400                 | 164 × 288, 5, 40                                  | 108 × 192, 5, 50                                   |
| 480 × 640, 15, 500                 | 216 × 288, 5, 50                                  | 120 × 160, 5, 45                                   |
| 720 × 1280, 15, 1130               | 164 × 288, 5, 113                                 | 108 × 192, 5, 50                                   |

### Web SDK

<div class="alert note">This section applies to the Agora Web SDK earlier than v3.1.0.</div>

The SDK sets the video profile of the low-quality video stream based on that of the high-quality video stream. This following table shows the relation between the video profiles of the high-quality and low-quality video streams.

| Video profile of high-quality stream                         | Video profile of low-quality stream |
| :----------------------------------------------------------- | :---------------------------------- |
| <ul><li>360P_1</li><li>360P_4</li><li>360P_9</li><li>360P_10</li><li>360P_11</li></ul> | 90P_1                               |
| <ul><li>360P_3</li><li>360P_6</li></ul>                      | 120P_3                              |
| <ul><li>360P_7</li><li>360P_8</li></ul>                      | 120P_1                              |
| <ul><li> 480P_1</li><li>480P_2</li><li>480P_4</li><li>480P_10</li></ul> | 120P_1                              |
| <ul><li> 480P_3</li><li>480P_6</li>                          | 120P_3                              |

For the resolution, frame rate, and bitrate of each video profile, see [API Reference](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/web/interfaces/agorartc.stream.html#setvideoprofile).

## Considerations

- Video dual-stream does not apply to scenarios involving screen sharing, or a custom video source.
- To ensure smooth communication, Agora recommends that the resolution of the high-quality video stream not exceed 640 × 480 px, and the frame rate not exceed 15 fps.
- Unless otherwise specified, the video profile uses the following units: px for resolution, fps for frame rate and Kbps for bitrate.
- Agora recommends using a layout with one big window and multiple small windows: The big window for the high-quality stream and small windows for the low-quality streams.
- For the Web SDK, if you want to customize the default video profile of the low-quality stream, ensure that the low-quality video stream keeps the aspect ratio of the high-quality video stream.
- For the Native SDK, during a call or live broadcast, when a publisher leaves the channel, call `setupRemoteVideo` and set the view as `NULL` to release all memory resources of the view used by the publisher.