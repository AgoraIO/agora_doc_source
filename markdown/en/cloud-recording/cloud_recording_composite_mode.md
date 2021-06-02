---
title: Composite Recording
platform: All Platforms
updatedAt: 2021-04-01 03:21:03
---
## Overview

Agora Cloud Recording supports two recording modes:

- Individual recording mode: Records the audio and video of each UID or each specified UID in a channel separately.
- Composite recording mode: Records the audio and video of all or specified UIDs in a channel together.

This article explains how to record a call in composite recording mode by using the RESTful API.

Before proceeding, ensure that you know how to use Agora Cloud Recording by using the RESTful API. For more information, see [Agora Cloud Recording RESTful API Quickstart](/en/cloud-recording/cloud_recording_rest). You must select a recording mode before a recording starts. You cannot switch between the two modes after a recording starts. See [How to choose the right recording mode](#choose_mode) to decide which mode you should use.


> We assume that each UID in the channel sends audio and video streams. If a UID does not send any audio or video stream, such as the audience in a live broadcast, no file is generated, except for Web users.

## Implementation

To enable composite recording mode, set `mode` to `mix` when calling [`start`](/en/cloud-recording/cloud_recording_api_rest#start).

Based on the setting of `streamTypes`, the recorded files are as follows:

| Settings                                   | Recorded content      | Recorded files                                               |
| :----------------------------------------- | :-------------------- | :----------------------------------------------------------- |
| Set `streamTypes` as `0`                   | Audio only            | One M3U8 file and several TS files. The TS files store only audio. |
| Set `streamTypes` as `1`                   | Video only (no audio) | One M3U8 file and several TS files. The TS files store only video (no audio). |
| Set `streamTypes` as `2` (default setting) | Audio and video       | One M3U8 file and several TS files. The TS files store video (with audio). |

The following diagram illustrates the recorded files generated in composite recording mode when the channel has two users, and when you set `streamTypes` as `2`:

![](https://web-cdn.agora.io/docs-files/1575011002382)

The cloud recording service generates one M3U8 file and several TS/WebM files, which combine the audio and video of all users. After converting the files using the [Format Converter script](https://docs.agora.io/en/cloud-recording/cloud_recording_convert_format?platform=All%20Platforms), you get one MP4 file.

For detailed information about the naming convention of the recorded files, see [Manage Recorded Files](/en/cloud-recording/cloud_recording_manage_files).

### An HTTP request example of `start`

- To enable composite recording mode, the request URL should be: 

```
https://api.agora.io/v1/apps/<yourappid>/cloud_recording/resourceid/<resourceid>/mode/mix/start
```
- `Content-type` is `application/json;charset=utf-8`.
- `Authorization` is Basic authorization. For more information, see [How to pass the basic HTTP authentication](https://docs.agora.io/en/faq/restful_authentication).
- The request body is:
  
```json
{
    "uid": "527841",
    "cname": "httpClient463224",
    "clientRequest": {
        "token": "<token if any>",
        "recordingConfig": {
            "maxIdleTime": 30,
            "streamTypes": 2,
            "audioProfile": 1,
            "channelType": 0, 
            "videoStreamType": 1, 
            "transcodingConfig": {
                "height": 640, 
                "width": 360,
                "bitrate": 500, 
                "fps": 15, 
                "mixedVideoLayout": 1,
                "backgroundColor": "#FF0000",
            "subscribeVideoUids": ["123","456"], 
            "subscribeAudioUids": ["123","456"],
            "subscribeUidGroup": 0
           }
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

## Considerations

If you record only video (no audio) or both video and audio, Agora Cloud Recording generates a black video file for a Web user who does not send any video stream.

## <a name="choose_mode"></a>How to choose the right recording mode

If you want more flexibility in processing the recorded files, choose individual recording mode. For example, in an online classroom, if parents want to see the video of the teacher and their child only, you can use individual recording mode to record the teacher and all students separately, and then combine the teacher's video with each of the students' video. Or, if you want to moderate the content in the recorded files and identify the UID that has the violating content, choose individual recording mode so that you can moderate the audio and video of each user separately.

In other cases, choose composite recording mode. For example, if you want to record a live broadcast with multiple hosts, composite recording mode allows you to store the audio and video of all hosts in one file, with no need to combine them after recording.