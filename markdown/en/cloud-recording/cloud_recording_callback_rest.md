---
title: Agora Cloud Recording RESTful API Callback Service
platform: All Platforms
updatedAt: 2021-02-01 03:35:49
---
You can set up an HTTP/HTTPS server to receive the event notifications of Agora Cloud Recording. When an event occurs, the Agora Cloud Recording service notifies the Agora notification center, and then the notification center notifies your server through an HTTP/HTTPS request.


## Agora message notification service

Contact us to configure and enable the callback service. See [Message Notification Service](https://docs-preview.agoralab.co/en/Agora%20Platform/ncs) for details.

## Callback information

After you enable the callback service, when a specified event occurs, the Agora notification center sends an HTTP/HTTPS request as a callback. The request body provides the main information of the callback in a JSON object. The JSON object contains different fields for different events.

The following is an example that shows the fields in the request body.
![](https://web-cdn.agora.io/docs-files/1567593635825)
- The fields in the red rectangle are the common fields of all the callback events. For details, see [Notification callback format](/en/Agora%20Platform/ncs?platform=All%20Platforms#notification-callback-format).
- The fields in the blue rectangle are the common fields in `payload` of all the cloud recording events. For details, see [Fields in payload](#payload).
- The values of `eventType`, `serviceType`, and `details` depend on the event. For details, see [Callback events](#event).

### <a name="payload"></a>Fields in payload

`payload` is a JSON object, which is the main body of the notification. `payload` in each type of event notification includes the following fields:

- `cname`: String. The name of the channel to be recorded.
- `uid`: String. The UID of the recording client.
- `sid`: String. The recording ID. The unique identifier of each recording.
- `sequence`: Number. The serial number of the notifications, starting from 0. You can use this parameter to identify notifications that are random, lost, or resent.
- `sendts`: Number. The time (UTC) when the event happens. Unix timestamp in ms.
- `serviceType`: Number. The type of Agora service.
  - `0`: The cloud recording service.
  - `1`: The recorder module.
  - `2`: The uploader module.
- `details`: JSON. The details of the callback events are described as follows.

## <a name="event"></a>Callback events

The event type and the corresponding service type of the Agora Cloud Recording callback events are listed below:

| eventType | serviceType                   | Event description                                            |
| :-------- | :---------------------------- | :----------------------------------------------------------- |
| [1](#1)   | 0 (cloud recording service)   | An error occurs during the recording.                        |
| [2](#2)   | 0 (cloud recording service)   | A warning occurs during the recording.                       |
| [3](#3)   | 0 (cloud recording service)   | The status of the Agora Cloud Recording service changes.     |
| [4](#4)   | 0 (cloud recording service)   | The M3U8 playlist file is generated.                         |
| [11](#11)   | 0 (cloud recording service)   | The cloud recording service has ended its tasks and exited.                    |
| [30](#30) | 2 (uploader module)           | The upload service starts.                                   |
| [31](#31) | 2 (uploader module)           | All the recorded files are uploaded to the specified third-party cloud storage. |
| [32](#32) | 2 (uploader module)           | All the recorded files are uploaded, but at least one file is uploaded to Agora Cloud Backup. |
| [33](#33) | 2 (uploader module)           | The progress of uploading the recorded files to the cloud storage. |
| [40](#40) | 1 (recorder module)           | The recording starts.                                        |
| [41](#41) | 1 (recorder module)           | The recording exits.                                         |
| [42](#42) | 1 (recorder module)           | The recording service syncs the information of the recorded files. |
| [43](#43) | 1 (recorder module)           | The state of the audio stream changes. |
| [44](#44) | 1 (recorder module)           | The state of the video stream changes. |

###  <a name="1"></a>1 cloud_recording_error

`eventType` 1 indicates that an error occurs during the recording. `details` includes the following fields:

- `msgName`: String. The name of the message, `"cloud_recording_error"`.
- `module`: Number. The module in which the error occurs.
  - `0`: The recorder
  - `1`: The uploader
  - `2`: The Agora Cloud Recording Service
- `errorLevel`: Number. The error level.
  - `1`: Debug
  - `2`: Minor
  - `3`: Medium
  - `4`: Major
  - `5`: Fatal. A fatal error may cause the recording to exit. If you receive a message of this level, call `query` to check the current status and process the error according to the error notifications.
- `errorCode`: Number. The error code. 
  - If the error occurs in the recorder, see [error code and warning code](https://docs.agora.io/en/Recording/the_error_native).
  - If the error occurs in the uploader, see [upload error code](#uploaderr). 
  - If the error occurs in the Agora Cloud Recording Service, see [cloud recording platform error code](#clouderr).
  - If you do not find any error code in the above-mentioned pages, contact our technical support.

- `stat`: Number. The event status. 0 indicates normal status; other values indicate abnormal status.
- `errorMsg`: String. The detailed description of the error.

###  <a name="2"></a>2 cloud_recording_warning

`eventType` 2 indicates that a warning occurs during the recording. `details` includes the following fields:

- `msgName`: String. The message name, `cloud_recording_warning`.
- `module`: Number. The name of the module where the warning occurs.
  - `0`: The recorder.
  - `1`: The uploader.
- `warnCode`: Number. The warning code. 
  - If the warning occurs in the recorder, see [error code and warning code](https://docs.agora.io/en/Recording/the_error_native).
  - If the warning occurs in the uploader, see [upload warning code](#uploadwarn).

###  <a name="3"></a>3 cloud_recording_status_update

`eventType` 3 indicates that the method call fails because it does not match the status of the cloud recording service. For example, the method call of `start` fails if the service has already started. `details` includes the following fields:

- `msgName`: String. The message name, `cloud_recording_status_update`.
- `status`: Number. The status of the cloud recording service. See [Status codes for the Agora Cloud Recording service](#state) for details.
- `recordingMode`: Number. The recording mode:
	- `0`: Individual recording mode
	- `1`: Composite recording mode
- `fileList`: String. The name of the M3U8 index file generated by the service.

###  <a name="4"></a>4 cloud_recording_file_infos

`eventType` 4 indicates that an M3U8 playlist file is generated and uploaded. Each recording instance has an M3U8 file as the playlist pointing to all the recorded TS/WebM files. You can play and manage your recordings with the M3U8 file.

`details` includes the following fields:

- `msgName`: String. The message name, `cloud_recording_file_infos`.
- `fileList`: String. The name of the M3U8 file.


### <a name="11"></a>11 session_exit

`eventType` 11 indicates that the cloud recording service has ended its tasks and exited. `details` includes the following fields:

- `msgName`: String. The message name, `session_exit`.
- `leaveStatus`: Number. The exit status. 
  - `0`: A normal exit, indicating that the recording service exits after the recording ends and the recorded files are uploaded.
  - `1`: An abnormal exit. An abnormal exist occurs when, for example, a parameter is incorrectly set.

###  <a name="30"></a>30 uploader_started

`eventType` 30 indicates that the upload service starts, and `details` includes the following fields:

- `msgName`: String. The message name, `uploader_started`.
- `status`: Number. The event status. 0 indicates normal status; other values indicate abnormal status.

###  <a name="31"></a>31 uploaded

`eventType` 31 indicates that all the recorded files are uploaded to the specified third-party cloud storage, and `details` includes the following fields:

- `msgName`: String. The message name, `uploaded`.
- `status`: Number. The event status. 0 indicates normal status; other values indicate abnormal status.

###  <a name="32"></a>32 backuped

`eventType` 32 indicates that all the recorded files are uploaded, but at least one of them is uploaded to Agora Cloud Backup. Agora Cloud Backup automatically uploads the files to the specified third-party cloud storage. `details` includes the following fields:

- `msgName`: String. The message name, `backuped`.
- `status`: Number. The event status. 0 indicates normal status; other values indicate abnormal status.

###  <a name="33"></a>33 uploading_progress

`eventType` 33 indicates the current upload progress. The Agora server notifies you of the upload progress once every minute after the recording starts. `details` includes the following fields:

- `msgName`: String. The message name, `uploading_progress`.
- `progress`: Number. An ever-increasing number between 0 and 10,000, equal to the ratio of the number of the uploaded files to the number of the recorded files multiplied by 10,000. After the recording service exits and when the number reaches 10,000, the upload completes.

###  <a name="40"></a>40 recorder_started

`eventType` 40 indicates that the recording service starts, and `details` includes the following fields:

- `msgName`: String. The message name, `recorder_started`.
- `status`: Number. The event status. 0 indicates normal status; other values indicate abnormal status.

###  <a name="41"></a>41 recorder_leave

`eventType` 41 indicates that the recording service leaves the channel, and `details` includes the following fields:

- `msgName`: String. The message name, `recorder_leave`.
- `leaveCode`: Number. The code that indicates why the recording service leaves the channel.
  - `0`: The initialization fails.
  - `1`: The AgoraCoreService process receives the SIGINT signal. 
  - `2`: The Agora Clouding Recording Service automatically leaves the channel and stops recording as there is no user in the channel.
  - `4`: The AgoraCoreService process receives the SIGTERM signal.
  - `8`: The recording application calls the stop cloud recording method to leave the channel.

### <a name="42"></a>42 recorder_slice_start

`eventType` 42 indicates that the recording service syncs the information of the recorded files, and `details` includes the following fields:

- `msgName`: String. The message name, `recorder_slice_start`.
- `startUtcMs`：Number. The time (ms) in UTC when the recording starts (the starting time of the first slice file).
- `discontinueUtcMs`：Number. In most cases, this field is the same as `startUtcMs`. When the recording is interrupted, the Agora Cloud Recording service automatically resumes the recording and  triggers this event. In this case, the value of this field is the time (ms) in UTC when the last slice file stops.
- `mixedAllUser`:  String. Whether the audio and video of all users are mixed into a single file.
  - `"true"`: All users are recorded in a single file.
  - `"false"`: Each user is recorded separately.
- `streamUid`: String. User ID. The user whose audio or video is recorded in the file. In composite mode, `streamUid` is `0`.
- `trackType`: String. Type of the recorded file.
  - `"audio"`: Audio file.
  - `"video"`: Video file (no audio).
  - `"audio_and_video"`: Video file (with audio).

For example, you start a recording session and get this event notification in which `startUtcMs` is the starting time of slice file 1. Then, the recording session continues and records slice file 2 to slice file N. If an error occurs when recording slice file N + 1, you lose this file and the recording session stops. Agora Cloud Recording automatically resumes the recording and triggers this event again. In the event notification, `startUtcMs` is the time when slice file N + 2 starts, and `discontinueUtcMs` is the time when slice file N stops.


### <a name="43"></a>43 recorder_audio_stream_state_changed

eventType 43 indicates that the state of the audio stream has changed, and `details` includes the following fields:

- `msgName`: String. The message name, `recorder_audio_stream_state_changed`.
- `streamUid`: String. The ID of the user whose audio is being recorded. In composite recording mode, `streamUid` can be `0`, which represents the combined stream of all or the specified UIDs.
- `state` : Number. Whether Agora Cloud Recording is receiving the audio stream.
  - `0`: Agora Cloud Recording is receiving the audio stream.
  - `1`: Agora Cloud Recording is not receiving the audio stream.
- `UtcMs`: Number. The UTC time (ms) when the state of the audio stream changes.



### <a name="44"></a>44 recorder_video_stream_state_changed

eventType 44 indicates that the state of the video stream has changed, and `details` includes the following fields:

- `msgName`: String. The message name, `recorder_video_stream_state_changed`.
- `streamUid`: String. The ID of the user whose video is being recorded. In composite recording mode, `streamUid` can be `0`, which represents the combined stream of all or the specified UIDs.
- `state`: Number. Whether Agora Cloud Recording is receiving the video stream.
  - `0`: Agora Cloud Recording is receiving the video stream.
  - `1`: Agora Cloud Recording is not receiving the video stream.
- `UtcMs`: Number. The UTC time (ms) when the state of the video stream changes.

## Reference

###  <a name="uploaderr"></a>Error codes related to uploading

| Error code | Description                                                  |
| :--------- | :----------------------------------------------------------- |
| 32         | An error occurs in the configuration of the third-party cloud storage. |
| 47         | The recording file upload fails.                             |
| 51         | An error occurs when the uploader processes the recorded files. |

### <a name="uploadwarn"></a>Warning codes related to uploading

| Warning code | Description                                                  |
| :----------- | :----------------------------------------------------------- |
| 31           | The recording service re-uploads the slice file to the specified cloud storage.                   |
| 32           | The recording service re-uploads the slice file to Agora Cloud Backup.                            |

### <a name="clouderr"></a>Error codes for the Agora Cloud Recording platform

| Error code | Description                                               |
| :--------- | :-------------------------------------------------------- |
| 50         | A timeout occurs in uploading the recorded files.         |
| 52         | A timeout occurs in starting the Cloud Recording Service. |

### <a name="state"></a>Status codes for the Agora Cloud Recording service

| Status code | Description                                                  |
| :---------- | :----------------------------------------------------------- |
| 0           | The recording has not started.                               |
| 1           | The initialization is complete.                              |
| 2           | The recorder is starting.                                    |
| 3           | The uploader is ready.                                       |
| 4           | The recorder is ready.                                       |
| 5           | The first recorded file is uploaded. After uploading the first file, the status is `5` when the recording is running. |
| 6           | The recording stops.                                         |
| 7           | The Agora Cloud Recording service stops.                     |
| 8           | The recording is ready to exit.                              |
| 20          | The recording exits abnormally.                              |