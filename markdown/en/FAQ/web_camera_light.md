---
title: Why is the camera light still on after I disable my video on the Web?
platform: ["Web"]
updatedAt: 2020-04-11 16:56:06
Products: ["Voice","Video","Interactive Broadcast"]
---
## Problem

When you use the Agora RTC Web SDK to disable local video through `muteVideo`, the camera light stays on.

## Reason

The Web SDK does not support enabling/disabling video capture independently. Calling  `muteVideo` for a local stream essentially sets  `MediaStreamTrack.enabled` to `false`, but black video frames are still being sent, and the video capture is not disabled. Therefore, the camera light remains on.

## Solution

Calling `close` stops the video capture and turns off the camera light, but it unauthorizes both the microphone and the camera, so audio sampling stops too. In the Agora Web SDK, the published object is a media stream that contains an audio track and a video track, so any operation of the stream affects both audio and video.

To quickly stop capturing and sending the local video without affecting the local audio, Agora recommends using next-generation Agora Web SDK ([Agora Web SDK NG](https://agoraio-community.github.io/AgoraWebSDK-NG/en/)). Agora Web SDK NG publishes the audio and video track as separate objects, enabling you to disable the local video and turn off the camera light by using the [`close`](https://agoraio-community.github.io/AgoraWebSDK-NG/api/en/interfaces/ilocaltrack.html#close) method of the video track object, without affecting the audio track.