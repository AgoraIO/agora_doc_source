---
title: How can I stop cloud recording?
platform: ["RESTful"]
updatedAt: 2020-03-25 22:45:59
Products: ["cloud-recording"]
---
You can call the [`stop`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=All%20Platforms#stop) method to leave the channel and stop recording.

Agora Cloud Recording automatically stops recording and leaves the channel when there is no user in the recording channel after a time period (30 seconds by default). You can set this timeout interval by the `maxIdleTime` parameter when you start the recording.