---
title: Why do I get a 404 error when I call query after successfully starting a cloud recording?
platform: ["RESTful"]
updatedAt: 2020-05-22 15:05:10
Products: ["cloud-recording"]
---
You may get a 404 error for the following reasons:

- The recording service checks if the parameters are correctly set after a cloud recording starts. The recording may stop if there are issues. Please pay particular attention to your `transcoding` settings. See [How do I set the video profile of the recorded video?](https://docs.agora.io/en/faq/recording_video_profile) for detailed information about setting `transcoding`.
- The third-party storage information, such as `accessKey` or `secretKey,` is incorrect, resulting in a failure to upload the recorded files. If you have enabled [Agora Message Notification Service](https://docs-preview.agoralab.co/en/Agora%20Platform/ncs), you will receive the [`cloud_recording_error`](https://docs.agora.io/en/cloud-recording/cloud_recording_callback_rest?platform=All%20Platforms#a-name1a1-cloud_recording_error) callback when the service detects that your cloud storage settings are incorrect.
- The cloud recording service fails to join the channel because `token` in `clientRequest` is incorrect. Check if your application has App Certificate enabled. If so, ensure you enter the correct [dynamic key](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#token); otherwise, you do not need to set this parameter. See [Set up Authentication](https://docs.agora.io/en/Agora%20Platform/token?platform=All%20Platforms).
- The ongoing cloud recording service ends automatically, if no user is in the channel for more than the time period specified by `maxIdleTime`.
- The cloud recording server is disconnected or the process is killed. At this point, you get a 404 for the method call of `query`, `updateLayout`, or `stop`. It may take the fault processing center a maximum of 90 seconds to troubleshoot and act accordingly. You can call `query` again after a certain period of time to query whether the service is back up. See [Fault processing when a cloud recording server is disconnected or the process killed](/en/faq/high-availability) for details.