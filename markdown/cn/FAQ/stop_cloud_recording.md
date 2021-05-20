---
title: 如何停止云端录制？
platform: ["RESTful"]
updatedAt: 2020-07-09 21:12:49
Products: ["cloud-recording"]
---
你可以调用  [`stop`](./cloud_recording_api_rest?platform=All%20Platforms#stop) 方法离开频道，停止录制。

当频道空闲（无用户）超过预设的时间（默认 30 秒）后，云端录制也会自动退出频道停止录制。你可以在开始录制的时候设置 `maxIdleTime` 参数来控制超时退出的时间。