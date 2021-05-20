---
title: render the first video frame
platform: All Platforms
updatedAt: 2020-07-03 20:12:23
---
Rendering the first video frame is the action of rendering the first video frame on the local device. There are two scenarios:

- Rendering the first local video frame: The SDK renders the first video frame captured by the local camera on the local video view of the local device.
- Rendering the first remote video frame: The SDK renders the first video frame received from a remote user on the remote video view of the local device.

The time elapsed from the time when the local or remote user joins a channel to the time when the SDK renders the first local or the first remote video frame is correlated with the user's hardware and software capacity. Agora strives to reduce the time elapsed so that an application can render the video to less than a second.

<a href="./terms"><button>Back to glossary</button></a>