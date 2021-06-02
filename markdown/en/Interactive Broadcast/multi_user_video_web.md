---
title: Video for Multiple Users
platform: Web
updatedAt: 2021-01-04 07:59:03
---
## Introduction
A video conference with too many hosts may cause network latency and packet loss.

If we set the subscribing stream to the 1-N Mode (set one stream as high and the rest as low), then a maximum of 17 users can join as hosts in an interactive broadcast without any network latency.


## Implementation

Before proceeding, ensure that you implement a basic live broadcast in your project. See [Start a Live Broadcast](start_live_web) for details.

Refer to the following steps to enable the video conference of 7+ users:

1. After calling the `Stream.init` method successfully, the hosts in the live broadcast channel call the `enableDualStreamMode` method to enable the [video dual stream mode](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-name-dualadual-stream-mode).
	> After calling the method successfully, the SDK automatically sets the parameters of the low-video stream according to the parameters of the high-video stream. See the [Correlation Table](#corr).
	
2. The hosts in the channel call the `setRemoteVideoStreamType` method to set one subscribed video stream as the high-video stream and other susbcribed streams as the low-video stream.
	> Agora does not recommend using video profiles that exceed either a resolution of 640 x 480 or a frame rate of 30 fps.
	> | **Resolution** | **Frame Rate** | **Bitrate** |
| -------------- | -------------- | ------------ |
| 640 x 480      | 15 fps         | 500 Kbps     |
| 640 x 360      | 15 fps         | 400 Kbps     |
| 640 x 360      | 30 fps         | 600 Kbps     |

3. (Optional) Call the `Client.setLowStreamParameter` method to customize the default low-video stream parameters at the application level.
> - The aspect ratio of the low-stream video profile (width x height) should be identical to that of the preset video profile. 
> - Different web browsers have different restrictions on the video profile, and the parameters that you set here may fail to take effect. The Firefox browser has a fixed frame rate of 30 fps, therefore the frame rate settings do not work on the Firefox browser.

4. [Publish a local stream](https://docs.agora.io/en/Interactive%20Broadcast/start_live_web?platform=Web#publish-a-local-stream) and [subscribe to a remote stream](https://docs.agora.io/en/Interactive%20Broadcast/start_live_web?platform=Web#subscribe-to-a-remote-stream)

### Sample code

```javascript
//Javascript
// Enable the video dual stream mode.
client.enableDualStream()

// Set the received stream as the high-video stream or the low-video stream.
client.setRemoteVideoStreamType(stream, streamType)

// Customize the low-video stream video profile : 120 × 120 (px), 15 fps, 120 Kbps.
client.setLowStreamParameter({
  width: 120,
  height: 120,
  framerate: 15,
  bitrate: 120,
})
```

### API reference

- [`enableDualStream`](./API%20Reference/web/interfaces/agorartc.client.html#enabledualstream)
- [`setRemoteVideoStreamType`](./API%20Reference/web/interfaces/agorartc.client.html#setremotevideostreamtype)
- [`setLowStreamParameter`](./API%20Reference/web/interfaces/agorartc.client.html#setlowstreamparameter)

## Considerations
Agora recommends using a layout with one big window and multiple small windows: Use a high-stream layout for the big window; Use a low-stream layout for small windows.

<a name="corr"></a>
## Correlation Table

**See the following table for the correlation between the high stream and low stream.**

> Since web browsers use an internal algorithm to adjust the stream, the actual low stream may be slightly different from that shown in the table.

| **High-stream Profile** | **Low-stream Profile** |
| ----------------------- | ---------------------- |
| 720P_5                  | 120P_1                 |
| 720P_6                  | 120P_1                 |
| 480P                    | 120P_1                 |
| 480P_1                  | 120P_1                 |
| 480P_2                  | 120P_1                 |
| 480P_4                  | 120P_1                 |
| 480P_10                 | 120P_1                 |
| 360P_7                  | 120P_1                 |
| 360P_8                  | 120P_1                 |
| 240P                    | 120P_1                 |
| 240P_1                  | 120P_1                 |
| 180P_4                  | 120P_1                 |
| 120P_3                  | 120P_1                 |
| 120P                    | 120P_1                 |
| 120P_1                  | 120P_1                 |
| 480P_3                  | 120P_3                 |
| 480P_6                  | 120P_3                 |
| 360P_3                  | 120P_3                 |
| 360P_6                  | 120P_3                 |
| 240P_3                  | 120P_3                 |
| 180P_3                  | 120P_3                 |
| 480P_8                  | 120P_4                 |
| 480P_9                  | 120P_4                 |
| 240P_4                  | 120P_4                 |
| 720P                    | 90P_1                  |
| 720P_1                  | 90P_1                  |
| 720P_2                  | 90P_1                  |
| 720P_3                  | 90P_1                  |
| 360P                    | 90P_1                  |
| 360P_1                  | 90P_1                  |
| 360P_4                  | 90P_1                  |
| 360P_9                  | 90P_1                  |
| 360P_10                 | 90P_1                  |
| 360P_11                 | 90P_1                  |
| 180P                    | 90P_1                  |
| 180P_1                  | 90P_1                  |

**Video Profile Definition**

| **Profile** | **Resolution**   | **Frame Rate** |
| ----------- | ---------------- | -------------- |
| 90P_1       | 160 x 90         | 15             |
| 120P        | 160 x 120        | 15             |
| 120P_1      | 160 x 120        | 15             |
| 120P_3      | 120 x 120        | 15             |
| 120P_4      | 212 x 120        | 15             |
| 180P        | 320 x 180        | 15             |
| 180P_1      | 320 x 180        | 15             |
| 180P_3      | 180 x 180        | 15             |
| 180P_4      | 424 x 240        | 15             |
| 240P        | 320 x 240        | 15             |
| 240P_1      | 320 x 240        | 15             |
| 240P_3      | 240 x 240        | 15             |
| 240P_4      | 424 x 240        | 15             |
| 360P        | 640 x 360        | 15             |
| 360P_1      | 640 x 360        | 15             |
| 360P_3      | 360 x 360        | 15             |
| 360P_4      | 640 x 360        | 30             |
| 360P_6      | 360 x 360        | 30             |
| 360P_7      | 480 x 360        | 15             |
| 360P_8      | 480 x 360        | 30             |
| 360P_9      | 640 x 360        | 15             |
| 360P_10     | 640 x 360        | 24             |
| 360P_11     | 640 x 360        | 24             |
| 480P        | 640 x 480        | 15             |
| 480P_1      | 640 x 480        | 15             |
| 480P_2      | 648 x 480        | 30             |
| 480P_3      | 480 x 480        | 15             |
| 480P_4      | 640 x 480        | 30             |
| 480P_6      | 480 x 480        | 30             |
| 480P_8      | 848 x 480        | 15             |
| 480P_9      | 848 x 480        | 30             |
| 480P_10     | 640 x 480        | 10             |
| 720P        | 1280 x 720       | 15             |
| 720P_1      | 1280 x 720       | 15             |
| 720P_2      | 1280 x 720       | 15             |
| 720P_3      | 1280 x 720       | 30             |
| 720P_5      | 960 x 720        | 15             |
| 720P_6      | 960 x 720        | 30             |
