---
title: How can I switch between the screen-sharing stream and the camera stream?
platform: ["Web"]
updatedAt: 2020-12-23 08:20:28
Products: ["Interactive Broadcast","Video"]
---
<div class="alert note">This article only applies to the Agora Web SDK 3.x and earlier versions.</div>

This page introduces three solutions for switching between the screen-sharing stream and the stream captured by the camera in a [screen-sharing](https://docs.agora.io/en/Interactive%20Broadcast/screensharing_web?platform=Web) scenario using the Agora RTC SDK for Web.

Switching from the screen-sharing stream to the camera stream and vice versa are the same process. The following solutions take the first case as an example.

## Solution 1: Create two streams
Create two Client objects on the sender, which correspond to the screen-sharing stream and the camera stream. See [Enable both screen sharing and video](https://docs.agora.io/en/Interactive%20Broadcast/screensharing_web?platform=Web#a-name--bothaenable-both-screen-sharing-and-video) for details.

To switch from the screen-sharing stream to the camera stream, subscribe to the camera stream on the receiver.

We recommend this solution if your application scenario allows creating two streams at the same time.

## Solution 2: Close the current stream and publish a new stream
1. Call `Client.unpublish` and `Stream.close` in sequence to unpublish and close the current screen-sharing stream.
2. Call `AgoraRTC.createStream` to create a new local video stream.
3. Call `Stream.init` and `Stream.publish` to initialize and publish the stream.

This solution is reliable and works with multiple browsers and platforms, but it does not support dynamic switching. You may need to allow for a couple of seconds to switch streams.

## Solution 3: Replace the current video track
Call `Stream.replaceTrack` to replace the video track in the local stream with the screen-sharing stream.

<div class="alert note">After replacing the video track with the screen-sharing stream, the encoding frame rate decreases to 5 fps.</div>

This solution supports dynamic switching, but the `replaceTrack` method has the following limitations:

- Supports only Chrome 65+, Safari and the latest Firefox browser.
- Does not take effect on some mobile devices.
- Does not support switching to a screen-sharing stream in dual-stream mode.
