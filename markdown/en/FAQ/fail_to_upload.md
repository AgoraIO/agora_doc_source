---
title: Why are there no recorded files in the cloud storage?
platform: ["RESTful"]
updatedAt: 2020-03-12 11:47:25
Products: ["cloud-recording"]
---
If you cannot find any recorded files in the cloud storage after a cloud recording session, check if any of the following situations occurred:

- No user is sending a stream in the channel, and the recording times out.
- The token has expired, or token authentication has failed.
- When calling the [`acquire`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=All%20Platforms#a-nameacquireagets-the-recording-resource) method to get the recording resource, you set the `uid` parameter that matches that of a user ID already in the channel. For example, suppose three users are in the channel with user IDs as `123`, `234`, and `345`. If you set `uid` as `123` when calling the `acquire` method, the recording fails. 
- The settings of `transcodingConfig` in the [`start`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=All%20Platforms#a-namestartastarts-cloud-recording) method do not follow the recommended settings, which causes the recording to fail. See [How do I set the video profile of the recorded video?](https://docs.agora.io/en/faq/recording_video_profile) before setting `transcodingConfig`.
- Your cloud storage settings are incorrect. Check the following:
  - bucket: The name of your cloud storage bucket, which was created in your cloud storage account.
  - accessKey: The access key of your cloud storage account.
  - secretKey: The secret key of your cloud storage account.

  If you have enabled Agora Message Notification Service, you will receive the [`cloud_recording_error`](https://docs.agora.io/en/cloud-recording/cloud_recording_callback_rest?platform=All%20Platforms#a-name1a1-cloud_recording_error) callback when the service detects that your cloud storage settings are incorrect.