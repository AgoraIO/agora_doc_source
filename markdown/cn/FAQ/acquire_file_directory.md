---
title: 如何获取 M3U8 文件地址？
platform: ["RESTful"]
updatedAt: 2020-07-09 21:12:30
Products: ["cloud-recording"]
---
完整的 M3U8 文件地址由云存储空间外链域名和 M3U8 文件名组成，一般在你的第三方云存储里可以直接复制。

![](https://web-cdn.agora.io/docs-files/1561621201492)

你可以通过以下方式获得 M3U8 文件名信息：

- [`query`](/cn/cloud-recording/cloud_recording_api_rest#query) 和 [`stop`](/cn/cloud-recording/cloud_recording_api_rest#stop) 的响应中 `fileList` 字段
- 回调事件 [`cloud_recording_file_infos`](/cn/cloud-recording/cloud_recording_callback_rest?platform=All%20Platforms#a-name4acloud_recording_file_infos) 的 `fileList` 字段