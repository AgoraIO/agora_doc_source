---
title: How can I get the URL of the M3U8 file?
platform: ["RESTful"]
updatedAt: 2020-03-25 22:46:20
Products: ["cloud-recording"]
---
The URL of the M3U8 file consists of the domain of your cloud storage and the filename. You can copy the URL in your cloud storage.

![](https://web-cdn.agora.io/docs-files/1556174270602)

You can get the filename of the M3U8 file from the following fileds:
- The `fileList` field in the responses of [`query`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest#query) and [`stop`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest#stop) 
- The `fileList` field in the [`cloud_recording_file_infos`](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest#a-name4acloud_recording_file_infos) callback event