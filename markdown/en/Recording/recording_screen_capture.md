---
title: Capture Screenshots
platform: All Platforms
updatedAt: 2021-01-13 07:59:11
---

The Agora On-premise Recording SDK supports screen capture in individual recording only. No subsequent transcoding is needed.

For details of the recording profile, see [Set the Recording Profile](/en/Recording/recording_mode).

| **Recording Profile** | **Parameter**                              | **File**                                                 |
| ------------ | ----------------------------------------- | ------------------------------------------------------------ |
| Video-only   | `decodeVideo = 3 or 4`, `captureInterval = 1` | <li>JPEG file<li>JPEG buffer.                                     |
| Screen capture + recording | `decodeVideo = 5`, `captureInterval = 1` | <li>An MPEG-4 file (untranscoded) for each user ID on the Agora Native SDK.<li>A WebM file (untranscoded) for each user ID on the Agora Web SDK.<li>A JPEG file.|

The `captureInterval` parameter sets the time interval for each screen capture. The minimum value is 1 second and the default value is 5 seconds. 