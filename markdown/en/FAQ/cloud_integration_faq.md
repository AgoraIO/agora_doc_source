---
title: Cloud recording FAQ
platform: ["Linux Java","Linux","Linux C++"]
updatedAt: 2019-10-28 09:39:01
Products: ["cloud-recording"]
---
## Why the recorded files are not uploaded to the cloud storage

Uploading the recorded files to the cloud storage fails if:

- No user is sending a stream in the channel, and the recording times out.
- Token has expired, or the token authentication has failed.
- When calling the [`acquire`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=All%20Platforms#a-nameacquireagets-the-recording-resource) method to get the recording resource, you set the `uid` parameter that matches that of a user ID already in the channel. For example, suppose three users are in the channel with user IDs as `123`, `234`, and `345`. If you set `uid` as `123` when calling the `acquire` method, the recording fails. 
- The settings of `transcodingConfig` in the [`start`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=All%20Platforms#a-namestartastarts-cloud-recording) method do not follow the recommended settings, which causes the recording to fail. See [How do I set the video profile of the recorded video?](https://docs.agora.io/en/faq/recording_video_profile) before setting `transcodingConfig`.
- Your cloud storage settings are incorrect. Ensure that the following settings are correct:
  - bucket: the name you have given to your cloud storage bucket, previously created in your cloud storage account.
  - accessKey: the access key of your cloud storage account.
  - secretKey: the secret key of your cloud storage account.

## How to get the URL of the M3U8 file

The URL of the M3U8 file consists of the domain of your cloud storage and the filename. You can copy the URL in your cloud storage.

![](https://web-cdn.agora.io/docs-files/1556174270602)

You can get the filename of the M3U8 file from the following fileds:
- The `fileList` field in the responses of [`query`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest#query) and [`stop`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest#stop) 
- The `fileList` field in the [`cloud_recording_file_infos`](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest#a-name4acloud_recording_file_infos) callback event

## How to stop cloud recording?
You can call the [`stop`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=All%20Platforms#stop) method to leave the channel and stop recording.

Agora Cloud Recording automatically stops recording and leaves the channel when there is no user in the recording channel after a time period (30 seconds by default). You can set this timeout interval by the `maxIdleTime` parameter when you start the recording.

## 101 error

The `"ErrorUint32":101` error in the log file is usually caused by a token error, such as in the following situations:

- A wrong token.
- An expired token.
- The Native/Web SDK uses a token while the cloud recording does not use a token.
- The cloud recording uses a token while the Native/Web SDK does not use a token.

## Abnormal exit

The recording exits abnormally when the app crashes. As long as the call or live broadcast is ongoing, the Agora Cloud Recording service keeps recording and uploading. You can use the original App ID, channel name, and UID to join the channel again and take control of the original recording instance.

## Why can't I call the Cloud Recording RESTful API through a web browser?

A Web API needs to make a cross-origin request in accordance with Cross-Origin Resource Sharing (CORS) to call the Cloud Recording RESTful API. The browser must first send an OPTIONS request to the server to query if the server accepts cross-origin requests before sending a cross-origin POST request. However, the Cloud Recording RESTful API does not support the OPTIONS method, and therefore you cannot call it with a Web API.