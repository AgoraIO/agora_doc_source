---
title: 媒体流 (media stream)
platform: All Platforms
updatedAt: 2020-07-03 18:27:28
---
媒体流是指包含媒体数据的对象。

根据包含的媒体数据类型，媒体流主要分为以下几种：
* 音频流：只包含音频数据。
* 视频流：只包含视频数据。
* 音视频流：既包含音频数据，又包含视频数据。

媒体流通过 RTC [频道](./terms#channel)进行传输。在 RTC 频道中，用户可以[发布](./terms#pub)本地的流，[订阅](./terms#sub)其他用户的流。
一般情况下，一个用户同一时间只能发布一路媒体流，用户 ID 和流是一一对应的。如果开发者开启了[双流模式](./terms#dual-stream)，那么 SDK 会自动额外发布一路视频小流。

<a href="./terms"><button>返回术语库</button></a>