---
title: Capture Screenshots
platform: All Platforms
updatedAt: 2020-12-10 14:14:03
---
This guide includes the key steps in using the Cloud Recording RESTful API to take screenshots of a video stream. For more information, see [Agora Cloud Recording RESTful API Quickstart](https://docs.agora.io/en/cloud-recording/cloud_recording_rest).

## Overview

You can use Cloud Recording RESTful API to take screenshots of a video stream in a channel and upload the screenshots to your third-party cloud storage.

> You cannot record a channel and take screenshots simultaneously in one session. To both record a channel and take screenshots, call [`acquire`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#acquire) twice to get two resource IDs, one for recording and the other for capturing screenshots. Both sessions are charged.



## Implementation

### Get a resource ID

Before recording, call the [`acquire`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#acquire) method to apply for a resource ID.

#### An HTTP request example of `acquire`

- Request URL: 
```
https://api.agora.io/v1/apps/<yourappid>/cloud_recording/acquire
```
- `Content-type:``application/json;charset=utf-8`
- `Authorization:` Basic authorization. For more information, see [How to pass the basic HTTP authentication](https://docs.agora.io/en/faq/restful_authentication).
- Request body:
```
{
    "cname": "httpClient463224",
    "uid": "527841",
    "clientRequest":{
      "resourceExpiredHour": 24,
      "scene": 0
   }
}
```

### Start recording

Set `mode` to `individual` when calling [`start`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#start) to enable [individual recording mode](https://docs.agora.io/en/Agora%20Platform/individual_recording_mode).

<div class="alert note">
You cannot switch to a different recording mode once you start recording.</div>

To capture screenshots, you need to configure the following parameters in `clientRequest`:

| Parameter         | Description                                                  | Note                                 |
| :---------------- | :----------------------------------------------------------- | :----------------------------------- |
| `token`           | The <a href="https://docs.agora.io/en/AgoraPlatform/terms?platform=AllPlatforms#token">dynamic key</a> used for the channel to record. | Required if the channel uses a token |
| `recordingConfig` | Configures stream subscription, transcoding, and the profile of the output audio and video. | Required                             |
| `snapshotConfig`  | Configures the time interval between two successive screenshots and the file format of the screenshots. | Required                             |
| `storageConfig`   | Configures the third-party cloud storage.                    | Required                             |



#### An HTTP request example of `start`

- Request URL:
```
https://api.agora.io/v1/apps/<yourappid>/cloud_recording/resourceid/<resourceid>/mode/individual/start
```
- `Content-type`: `application/json;charset=utf-8`
- `Authorization`: Basic authorization. For more information, see [How to pass the basic HTTP authentication](https://docs.agora.io/en/faq/restful_authentication).
- Request body:
```json
{
    "uid": "527841",
    "cname": "httpClient463224",
    "clientRequest": {
        "token": "<token if any>",
        "recordingConfig": {
            "channelType": 1,
            "subscribeUidGroup": 0
        },
        "snapshotConfig": {
            "captureInterval": 5,
            "fileType": ["jpg"]
        },
        "storageConfig": {
            "accessKey": "xxxxxxf",
            "region": 3,
            "bucket": "xxxxx",
            "secretKey": "xxxxx",
            "vendor": 2,
            "fileNamePrefix": ["directory1","directory2"]
        }
    }
}
```



## Screenshot files

The naming convention of screenshot files is `<sid>_<cname>__uid_s_<uid>__uid_e_video_<utc>.jpg`, where

- `<sid> `is the recording ID.
- `<cname>` is the channel name.
- `<uid>` is the user ID.
- `<utc>` is the UTC time when the screenshot was generated. The time zone is UTC+0, and the timestamp consists of the year, month, day, hour, minute, second, and millisecond. For example, if `utc` is `20190611073246073`, the screenshot was generated on June 11, 2019, at 07:32:46.073 a.m.

The screenshot file format is determined by `fileType` you set in `start`. Currently only the JPG format is supported.

When [a cloud recording server is disconnected or the process killed](https://docs.agora.io/en/faq/high-availability), the cloud recording service enables the high availability mechanism, where the fault processing center automatically switches to a new server within 90 seconds to resume the service. When the service enables the mechanism, the screenshot filenames are prepended with `bak<n>`, where `n` stands for the number of times the mechanism is enabled in a recording and starts off with `0`. Taking the filename `bak0_sid_channel1__uid_s_123__uid_e_video_20190611073246073.jpg` as an example, `bak0` indicates that this file was generated after the service enabled the high availability mechanism for the first time.

## Considerations

Pay attention to the following parameters as incorrect settings result in errors and failure to capture screenshots:

- In the URL of your request, you must set `mode` as `individual`.
- Do not set `recordingFileConfig`.
- `streamTypes` must be `1` or `2`.
- If you set `subscribeAudioUid`, you must also set `subscribeVideoUids`.

If a user stops sending video stream during a session, the Cloud Recording service stops taking screenshots until the stream resumes, and the [Agora message notification service](https://docs.agora.io/en/cloud-recording/cloud_recording_callback_rest) sends a callback notifying you of the event. The event does not affect other users in the channel.