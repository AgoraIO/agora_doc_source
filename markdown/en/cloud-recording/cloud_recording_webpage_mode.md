---
title: Web Page Recording
platform: RESTful
updatedAt: 2021-03-09 07:04:22
---
This guide includes the key steps in using the Cloud Recording RESTful API to make a web page recording. For more information, see [Agora Cloud Recording RESTful API Quickstart](https://docs.agora.io/en/cloud-recording/cloud_recording_rest).
<div class="alert info">
Web page recording mode is currently in public beta and is free to use by March 1, 2021.</div>

## Overview

Agora Cloud Recording supports three recording modes:

- Individual recording
- Composite recording
- Web page recording

In web page recording mode, the content and audio of a specified web page are recorded in a single file.

![](https://web-cdn.agora.io/docs-files/1607522069504)

You can use web page recording to reproduce scenarios such as online classes and video conferences. For example, if your web application integrates both the Agora SDK and a third-party whiteboard SDK, web page recording can record everything on the web page instead of only the audio and video streams.

![](https://web-cdn.agora.io/docs-files/1607522369171)

You can also record from a specific perspective. For example, if you want to record an online class from the teacher's perspective, you can develop a web page that contains every operation that the teacher performs and record that web page.

## Prerequisites

- If you want to use web page recording along with other cloud recording functions, such as individual recording or screenshot capturing, Agora suggests that you use a separate App ID for web page recording for more independent resource management.
- You need to provide a web application that can be accessed through a URL, so that the content can be recorded. (The hosts and the audience can use web or other platforms.)
- Your web application should support Chrome.
- The web page content is displayed completely in one screen, that is, no scrolling is needed.
- If you want to record every operation of the host on the screen, you need to sync the operations in your web application.

## Implementation

### Get a resource ID

Before recording, call the [`acquire`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#acquire) method to apply for a resource ID. Note that you must set `scene` as `1`.

#### An HTTP request example of `acquire`

- Request URL: 
```
https://api.agora.io/v1/apps/<yourappid>/cloud_recording/acquire
```
- `Content-type`: `application/json;charset=utf-8`
- `Authorization`: Basic authorization. For more information, see [How to pass the basic HTTP authentication](https://docs.agora.io/en/faq/restful_authentication).

- Request body:
```
{
   "cname": "httpClient463224",
    "uid": "527841",
    "clientRequest":{
      "resourceExpiredHour": 24,
      "scene": 1
   }
}
```

### Start recording

To enable [web page recording mode](/en/Agora%20Platform/webpage_recording), set `mode` to `web` when calling  [`start`](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#start). Use `extensionServiceConfig` to configure web page recording, and use `storageConfig` to configure your third-party cloud storage.

<div class="alert note">
You cannot switch to a different recording mode once you start recording.</div>

In web page recording mode, you can configure the following parameters in `clientRequest`:

| Parameter                | Description                               | Note     |
| :----------------------- | :---------------------------------------- | :------- |
| `storageConfig`          | Configures the third-party cloud storage. | Required |
| `recordingFileConfig`    | Configures the recorded files.            | Optional |
| `extensionServiceConfig` | Configures web page recording.            | Required |



#### An HTTP request example of `start`

- Request URL:
```
https://api.agora.io/v1/apps/<yourappid>/cloud_recording/resourceid/<resourceid>/mode/web/start
```

- `Content-type:` `application/json;charset=utf-8`
- `Authorization:` Basic authorization. For more information, see [How to pass the basic HTTP authentication](https://docs.agora.io/en/faq/restful_authentication).
- Request body:
```
{
  "cname":"httpClient463224",
    "uid":"527841",
    "clientRequest":{
        "token": "<token if any>",
        "extensionServiceConfig": {
             "errorHandlePolicy": "error_abort",
             "extensionServices":[{
                  "serviceName":"web_recorder_service",
                  "errorHandlePolicy": "error_abort",
                  "serviceParam": {
                      "url": "https://xxxxx",
                      "audioProfile":0,
                      "videoWidth":1280,
                      "videoHeight":720,
                      "maxRecordingHour":72
                 }
             }]
       },
        "recordingFileConfig":{
            "avFileType":[
                "hls",
                "mp4"
           ]
       },
        "storageConfig":{
            "vendor":2,
            "region":3,
            "bucket":"xxxxx",
            "accessKey":"xxxxx",
            "secretKey":"xxxxx",
            "fileNamePrefix":[
                "directory1",
                "directory2"
           ]
       }
   }
}
```


## Recorded files

A web page recording session generates one M3U8 file and multiple TS files. Depending on the value of `avFileType`, the recording session may also generate one or more MP4 files. For detailed information about the naming conventions of the recorded files, see [Manage Recorded Files](https://docs.agora.io/en/cloud-recording/cloud_recording_manage_files).

## Considerations

### Application restrictions

- The recorded web page should not contain any video that has a resolution higher than 1280 × 720.
- The recorded web page should not use WebGL.
- The downlink bitrate of your web application should not exceed 10 Mbps, and the uplink bitrate should not exceed 2 Mbps.
- Ensure that your web application does not consume excessive CPU memory and network bandwidth and that your application is used legally.
- If you enable the autoplay property for a video element in the recorded web page, the recording service can play the video without any user interaction. However, if you disable the autoplay property, the video cannot be played automatically, and the recording service cannot record the content of the video.
- Web page recording returns an error and exits when the main frame fails to load. If you also want the recording service to stop and exit when a sub iframe fails to load, you need to implement the logic by yourself. For example, you can call `Windows.close` when a sub iframe fails to load, which will cause the recording service to stop and exit.

### RESTful API requests

- Recording starts approximately five seconds after you send a request. We recommend you send the request in advance to ensure that everything you want to record is captured.
- Web page recording does not support the `update` and `updateLayout` methods.
- If the URL you specify in the `start` method cannot be accessed, the recording service exits automatically after the `start` call. To ensure that the recording service starts successfully, see [Best Practices in Integrating Cloud Recording](https://docs.agora.io/en/cloud-recording/integration_best_practices?platform=RESTful#a-namestart_successaensure-the-recording-service-starts-successfully).

### Other considerations

- During a recording,  when the length of the recorded file reaches two hours, or when the size of the file exceeds 2 GB, the recording service automatically creates another MP4 file.
- In a web page recording, the recording service can be considered a client of your web application.
  - If the URL you specify in the `start` method automatically enables the client to publish streams, the browser engine started by the recording server becomes a video sender. As a result, the recording server's video may be displayed as empty in the video panel of your application.
  - If your application displays a user list, we recommend you hide the recording server from the list to avoid confusion among other users.