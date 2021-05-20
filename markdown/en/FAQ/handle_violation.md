---
title: Handle Violations
platform: ["All Platforms"]
updatedAt: 2020-04-29 17:36:58
Products: ["content-moderation"]
---
Refer to the following measures to handle violating video streams.

### Stop sending local video stream

From the client, call `muteLocalVideoStream` provided by the Agora RTC SDK to stop the violating UID from sending the video stream.

### Kick out violating UID or shut down the channel

Send RESTful API requests from your application server to remove the violating UID from the channel, or shut down the channel. See [Ban Users at the Server](https://docs.agora.io/en/Agora%20Platform/dashboard_restful_communication#ban-users-at-the-server).

### Blur the video

Process the raw video data to blur the violating video. See [Raw Video Data](https://docs.agora.io/en/Interactive%20Broadcast/raw_data_video_android?platform=Android) for capturing the raw data from a channel.

<div class="alert note">Agora does not provide any API for blurring a video stream. You need to implement this function yourself.</div>

