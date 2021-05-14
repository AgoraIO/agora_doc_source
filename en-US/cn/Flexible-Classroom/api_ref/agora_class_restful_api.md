This page provides detailed help for the Flexible Classroom RESTful APIs. This page provides detailed help for the Flexible Classroom RESTful APIs.

<div class="alert info">See the <a href="./agora_class_restful_api_release">changelog</a> of Flexible Classroom Cloud Service. See the <a href="./agora_class_restful_api_release">changelog</a> of Flexible Classroom Cloud Service.</div>

## Basic information Basic information

### Server Server

All requests are sent to the host: api.agora.io. All requests are sent to the host: api.agora.io.

### Data format Data format

The Content-Type of all requests is application/json. The Content-Type of all requests is application/json.

### Authentication Authentication

Flexible Classroom Cloud Service uses tokens for authentication. Flexible Classroom Cloud Service uses tokens for authentication. You need to put the following information to the `x-agora-token` and `x-agora-uid` fields when sending your HTTP request: You need to put the following information to the `x-agora-token` and `x-agora-uid` fields when sending your HTTP request:

- The RTM Token generated at your server. The RTM Token generated at your server.
- The uid you use to generate the RTM Token. The uid you use to generate the RTM Token.

For details, see [Generate an RTM Token](https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms). For details, see [Generate an RTM Token](https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms).

## Set the classroom state Set the classroom state

### Description Description

Call this method to set the classroom state: Not started, Started, Ended. Call this method to set the classroom state: Not started, Started, Ended. For the detailed description of each state, see classroom [state management](./class_state). For the detailed description of each state, see classroom [state management](./class_state).

### Prototype Prototype

- Method: PUT Method: PUT
- Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/states/{state} Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/states/{state}

### Request parameters Request parameters

**URL parameters ****URL parameters**

Pass the following parameter in the URL. Pass the following parameter in the URL.

| Parameter Parameter | Type Type | Description Description |
| :--------- | :------ | :----------------------------------------------------------- |
| `appId ``appId` | String String | (Required) The Agora App ID, see [Get the Agora App ID](./agora_class_prep#step1). (Required) The Agora App ID, see [Get the Agora App ID](./agora_class_prep#step1). |
| `roomUuid ``roomUuid` | String String | (Required) The classroom ID. (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. The string length must be less than 64 bytes. Supported character scopes are: Supported character scopes are:<li>All lowercase English letters: a to z. All lowercase English letters: a to z.<li>All uppercase English letters: A to Z. All uppercase English letters: A to Z.<li>All numeric characters. All numeric characters.<li>0-9 0-9<li>The space character. The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `state ``state` | Integer Integer | (Required) The classroom state: (Required) The classroom state:<li>`0`: Not started. `0`: Not started.<li>`1`: Start recording. `1`: Start recording.<li>`2`: Ended. `2`: Ended. |

### Request example Request example

```html
// Set the state of the test_class as started
// Set the state of the test_class as started
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/states/1 https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/states/1
```

### Response parameters Response parameters

| Parameter Parameter | Type Type | Description Description |
| :----- | :------ | :------------------------------------------------ |
| `code ``code` | Integer Integer | Business status code: Business status code:<li>0: The request succeeds. 0: The request succeeds.<li>Non-zero: The request fails. Non-zero: The request fails. |
| `msg ``msg` | String String | The detailed information. The detailed information. |
| `ts ``ts` | Number Number | The current Unix timestamp (in milliseconds) of the server in UTC. The current Unix timestamp (in milliseconds) of the server in UTC. |

### Response example Response example

```json
"status": 200,
"status": 200,
"body":
"body":
{
{
  "code": 0,
  "code": 0,
  "msg": "Success",
  "msg": "Success",
  "ts": 1610450153520
  "ts": 1610450153520
} }
```

## Kick a user out of a classroom Kick a user out of a classroom

### Description Description

Call this method to kick a specified user out of a classroom. Call this method to kick a specified user out of a classroom. After a successful method call, the server triggers an event indicating a user leaves the classroom. After a successful method call, the server triggers an event indicating a user leaves the classroom. You can use the `dirty` parameter to determine whether the user can enter the classroom afterwards. You can use the `dirty` parameter to determine whether the user can enter the classroom afterwards.

### Prototype Prototype

- Method: POST Method: POST
- Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/users/{userUuid}/exit Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/users/{userUuid}/exit

### Request parameters Request parameters

**URL parameters ****URL parameters**

Pass the following parameters in the URL. Pass the following parameters in the URL.

| Parameter Parameter | Type Type | Description Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `appId ``appId` | String String | (Required) The Agora App ID, see [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). (Required) The Agora App ID, see [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
| `roomUuid ``roomUuid` | String String | (Required) The classroom ID. (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. The string length must be less than 64 bytes. Supported character scopes are: Supported character scopes are:<li>All lowercase English letters: a to z. All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z. All uppercase English letters: A to Z.</li><li>All numeric characters. All numeric characters.</li><li>0-9 0-9</li><li>The space character. The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |
| `userUuid ``userUuid` | String String | (Required) The user ID. (Required) The user ID. This is the unique identifier of the user and also the user ID used when logging in to the Agora RTM system. This is the unique identifier of the user and also the user ID used when logging in to the Agora RTM system. The string length must be less than 64 bytes. The string length must be less than 64 bytes. Supported character scopes are: Supported character scopes are:<li>All lowercase English letters: a to z. All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z. All uppercase English letters: A to Z.</li><li>All numeric characters. All numeric characters.</li><li>0-9 0-9</li><li>The space character. The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |

**Request body parameters ****Request body parameters**

Pass in the following parameters in the request body. Pass in the following parameters in the request body.

| Parameter Parameter | Type Type | Description Description |
| :------ | :----- | :----------------------------------------------------------- |
| `dirty ``dirty` | Object Object | (Optional) The user privilege: (Optional) The user privilege:<ul><li>`state`: Boolean, whether the user is dirty: `state`: Boolean, whether the user is dirty:<ul><li>`1`: Dirty. `1`: Dirty. A dirty user cannot enter the classroom. A dirty user cannot enter the classroom.</li><li>`0`: Not dirty. `0`: Not dirty.</li></ul><li>`duration`: Number, the duration of the dirty state (seconds), starting from the time when the user is kicked out of the classroom. `duration`: Number, the duration of the dirty state (seconds), starting from the time when the user is kicked out of the classroom.</li></ul> |

### Request example Request example

**Request URL ****Request URL**

```html
// Kick the user with the ID 123 out of test_class
// Kick the user with the ID 123 out of test_class
https://api.agora.io/edu/apps/{your_app_Id}/v2/rooms/test_class/users/123/exit https://api.agora.io/edu/apps/{your_app_Id}/v2/rooms/test_class/users/123/exit
```

**Request Body ****Request Body**

```json
{
{
    "dirty": {
    "dirty": {
        "state": 1,
        "state": 1,
        "duration": 600
        "duration": 600
    }
    }
} }
```

### Response parameters Response parameters

| Parameter Parameter | Type Type | Description Description |
| :----- | :------ | :------------------------------------------- |
| `code ``code` | Integer Integer | Business status code: Business status code:<li>0: The request succeeds. 0: The request succeeds.</li><li>Non-zero: The request fails. Non-zero: The request fails.</li> |
| `msg ``msg` | String String | The detailed information. The detailed information. |
| `ts ``ts` | Number Number | The current Unix timestamp (in milliseconds) of the server in UTC. The current Unix timestamp (in milliseconds) of the server in UTC. |

### Response example Response example

```json
{
{
    "msg": "Success",
    "msg": "Success",
    "code": 0,
    "code": 0,
    "ts": 1610167740309
    "ts": 1610167740309
} }
```

## Set the recording state Set the recording state

### Description Description

Call this method to start or stop recording a specified classroom. Call this method to start or stop recording a specified classroom.

### Prototype Prototype

- Method: PUT Method: PUT
- Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/records/states/{state} Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/records/states/{state}

### Request parameters Request parameters

**URL parameters ****URL parameters**

Pass the following parameter in the URL. Pass the following parameter in the URL.

| Parameter Parameter | Type Type | Description Description |
| :--------- | :------ | :----------------------------------------------------------- |
| `appId ``appId` | String String | (Required) The Agora App ID, see [Get the Agora App ID](./agora_class_prep#step1). (Required) The Agora App ID, see [Get the Agora App ID](./agora_class_prep#step1). |
| `roomUuid ``roomUuid` | String String | (Required) The classroom ID. (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. The string length must be less than 64 bytes. Supported character scopes are: Supported character scopes are:<li>All lowercase English letters: a to z. All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z. All uppercase English letters: A to Z.</li><li>All numeric characters. All numeric characters.</li><li>0-9 0-9</li><li>The space character. The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |
| `state ``state` | Integer Integer | (Required) The recording state: (Required) The recording state:<li>`0`: Stop recoding. `0`: Stop recoding.</li><li>`1`: Start recording. `1`: Start recording.</li> |

**Request body parameters ****Request body parameters**

Pass in the following parameters in the request body. Pass in the following parameters in the request body.

| Parameter Parameter | Type Type | Description Description |
| :---------------- | :----- | :----------------------------------------------------------- |
| `mode ``mode` | String String | (Optional) The recording mode: (Optional) The recording mode:<li>Set the recording](https://docs.agora.io/cn/Agora%20Platform/webpage_recording) as `web `to enable [page recording mode. Set the recording](https://docs.agora.io/cn/Agora%20Platform/webpage_recording) as `web `to enable [page recording mode. The format of recorded files is MP4. The format of recorded files is MP4. When the length of the recorded file reaches around two hours, or when the size of the file exceeds around 2 GB, the recording service automatically creates another MP4 file. When the length of the recorded file reaches around two hours, or when the size of the file exceeds around 2 GB, the recording service automatically creates another MP4 file.</li><li>If you do not set this parameter, Flexible Classroom records the audio and video of the teachers in [composite recording mode](https://docs.agora.io/cn/Agora%20Platform/composite_recording_mode) by default. If you do not set this parameter, Flexible Classroom records the audio and video of the teachers in [composite recording mode](https://docs.agora.io/cn/Agora%20Platform/composite_recording_mode) by default. The format of recorded files is M3U8 and TS. The format of recorded files is M3U8 and TS.</li> |
| `webRecordConfig ``webRecordConfig` | Object Object | (Optional) When the `mode` is set as `web`, you need to set the detailed configuration of the webpage recording through `webRecordConfig`, including the following fields: (Optional) When the `mode` is set as `web`, you need to set the detailed configuration of the webpage recording through `webRecordConfig`, including the following fields:<ul><li>`url`: (Required) String, the address of the web page to record. `url`: (Required) String, the address of the web page to record. If you want to record a certain flexible classroom, you need to pass in the parameters required for launching a classroom in the URL. The Agora Cloud Recording service can join the specified classroom as an "invisible user" for recording. If you want to record a certain flexible classroom, you need to pass in the parameters required for launching a classroom in the URL. The Agora Cloud Recording service can join the specified classroom as an "invisible user" for recording. See the URL example in the request example. See the URL example in the request example. The following parameters are required in the URL: The following parameters are required in the URL:<ul><li>`userUuid`: The user ID used by the Agora Cloud Recording service. `userUuid`: The user ID used by the Agora Cloud Recording service. Please ensure that the user ID used by the Agora Cloud Recording service is not the same as that of existing users in the classroom, otherwise, the Agora Cloud Recording service will fail to join the classroom. Please ensure that the user ID used by the Agora Cloud Recording service is not the same as that of existing users in the classroom, otherwise, the Agora Cloud Recording service will fail to join the classroom.</li><li>`roomUuid`: The ID of the classroom to be recorded. `roomUuid`: The ID of the classroom to be recorded.</li><li>`roomType`: The type of the classroom to be recorded. `roomType`: The type of the classroom to be recorded.</li><li>`roleType`: The role of the Agora Cloud Recording service in the classroom to be recorded. Set this parameter as 0. `roleType`: The role of the Agora Cloud Recording service in the classroom to be recorded. Set this parameter as 0.</li><li>`pretest`: Whether to enable the pre-class test. Set this parameter as `false`. `pretest`: Whether to enable the pre-class test. Set this parameter as `false`.</li><li>`rtmToken`: The RTM Token used by the Agora Cloud Recording service. `rtmToken`: The RTM Token used by the Agora Cloud Recording service.</li><li>`language`: The language of the user interface. Set this parameter as `zh` or `en`. `language`: The language of the user interface. Set this parameter as `zh` or `en`.</li><li>`appId`: Your Agora App ID. `appId`: Your Agora App ID.</li></ul><li>`videoBitrate`: (Optional) Number. The bitrate of the video (Kbps). The value range is [50, 8000]. `videoBitrate`: (Optional) Number. The bitrate of the video (Kbps). The value range is [50, 8000]. The default value of `videoBitrate` varies according to the resolution of the output video: The default value of `videoBitrate` varies according to the resolution of the output video:<ul><li>1280 × 720: The default value is 1130. 1280 × 720: The default value is 1130.</li><li>960 × 720: The default value is 910. 960 × 720: The default value is 910.</li><li>848 × 480: The default value is 610. 848 × 480: The default value is 610.</li><li>640 × 480: The default value is 400. 640 × 480: The default value is 400.</li><li>For all other resolutions, the default value is 300. For all other resolutions, the default value is 300.</li></ul><li>`videoFps`: (Optional) Number. The frame rate of the video (fps). The value range is [5,60]. The default value is 15. `videoFps`: (Optional) Number. The frame rate of the video (fps). The value range is [5,60]. The default value is 15.</li><li>`audioProfile`: (Optional) Number. The sample rate, encoding mode, number of audio channels, and bitrate. `audioProfile`: (Optional) Number. The sample rate, encoding mode, number of audio channels, and bitrate.<ul><li>0: (Default) Sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 48 Kbps. 0: (Default) Sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 48 Kbps.</li><li>1: Sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 128 Kbps. 1: Sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 128 Kbps.</li><li>2: Sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 192 Kbps. 2: Sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 192 Kbps.</li></ul><li>`videoWidth`: Number. The width of the video (pixels). The value range is [480, 1280]. `videoWidth`: Number. The width of the video (pixels). The value range is [480, 1280]. The default value is 1280. The default value is 1280. `The product of `videoWidth` and videoHeight` should not exceed 921,600 (1280 × 720). `The product of `videoWidth` and videoHeight` should not exceed 921,600 (1280 × 720).</li><li>`videoHeight`: Number. The height of the video (pixels). The value range is [480, 1280]. `videoHeight`: Number. The height of the video (pixels). The value range is [480, 1280]. The default value is 720. The default value is 720. `The product of `videoWidth` and videoHeight` should not exceed 921,600 (1280 × 720). `The product of `videoWidth` and videoHeight` should not exceed 921,600 (1280 × 720).</li><li>`maxRecordingHour`: Number, the maximum recording length (hours). The value range is [1,720], and the default value is 24. `maxRecordingHour`: Number, the maximum recording length (hours). The value range is [1,720], and the default value is 24. If the limit set by `maxRecordingHour` is exceeded, the recording stops automatically. If the limit set by `maxRecordingHour` is exceeded, the recording stops automatically. |

### Request example Request example

**Request URL ****Request URL**

```html
// Start recording test_class
// Start recording test_class
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records/states/1 https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records/states/1
```

**Request Body ****Request Body**

```json
{
{
    "mode": "web",
    "mode": "web",
    "webRecordConfig": {
    "webRecordConfig": {
        "url":"https://webdemo.agora.io/xxxxx/?userUuid={recorder_id}&roomUuid={room_id_to_be_recorded}&roleType=0&roomType=4&pretest=false&rtmToken={recorder_token}&language=en&appId={your_app_id}"
        "url":"https://webdemo.agora.io/xxxxx/?userUuid={recorder_id}&roomUuid={room_id_to_be_recorded}&roleType=0&roomType=4&pretest=false&rtmToken={recorder_token}&language=en&appId={your_app_id}"
    }
    }
} }
```

### Response parameters Response parameters

| Parameter Parameter | Type Type | Description Description |
| :----- | :------ | :------------------------------------------------ |
| `code ``code` | Integer Integer | Business status code: Business status code:<li>0: The request succeeds. 0: The request succeeds.<li>Non-zero: The request fails. Non-zero: The request fails. |
| `msg ``msg` | String String | The detailed information. The detailed information. |
| `ts ``ts` | Number Number | The current Unix timestamp (in milliseconds) of the server in UTC. The current Unix timestamp (in milliseconds) of the server in UTC. |

### Response example Response example

```json
"status": 200,
"status": 200,
"body":
"body":
{
{
  "code": 0,
  "code": 0,
  "ts": 1610450153520
  "ts": 1610450153520
} }
```

## Get the recording list Get the recording list

### Description Description

Get the recording list in a specified classroom. Get the recording list in a specified classroom.

You can fetch data in batches with the `nextId` parameter. You can get up to 100 pieces of data for each batch. You can fetch data in batches with the `nextId` parameter. You can get up to 100 pieces of data for each batch.

### Prototype Prototype

- Method: GET Method: GET
- Endpoint: /edu/apps/{appId}/v2/rooms/{roomUuid}/records Endpoint: /edu/apps/{appId}/v2/rooms/{roomUuid}/records

### Request parameters Request parameters

**URL parameters ****URL parameters**

Pass the following parameter in the URL. Pass the following parameter in the URL.

| Parameter Parameter | Type Type | Description Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `appId ``appId` | String String | (Required) The Agora App ID, see [Get the Agora App ID](./agora_class_prep#step1). (Required) The Agora App ID, see [Get the Agora App ID](./agora_class_prep#step1). |
| `roomUuid ``roomUuid` | String String | (Required) The classroom ID. (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. The string length must be less than 64 bytes. Supported character scopes are: Supported character scopes are:<li>All lowercase English letters: a to z. All lowercase English letters: a to z.<li>All uppercase English letters: A to Z. All uppercase English letters: A to Z.<li>All numeric characters. All numeric characters.<li>0-9 0-9<li>The space character. The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |

**Query parameters ****Query parameters**

| Parameter Parameter | Type Type | Description Description |
| :------- | :----- | :----------------------------------------------------------- |
| `nextId ``nextId` | String String | (Optional) The starting ID of the next batch of data. (Optional) The starting ID of the next batch of data. When you call this method to get the data for the first time, leave this parameter empty or set it as null. Afterward, you can set this parameter as the `nextId` that you get in the response of the previous method call. When you call this method to get the data for the first time, leave this parameter empty or set it as null. Afterward, you can set this parameter as the `nextId` that you get in the response of the previous method call. |

### Request example Request example

```html
// Get the recording list in test_class
// Get the recording list in test_class
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records?nextId=xxx https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records?nextId=xxx
```

### Response parameters Response parameters

| Parameter Parameter | Type Type | Description Description |
| :----- | :------ | :----------------------------------------------------------- |
| `code ``code` | Integer Integer | Business status code: Business status code:<li>0: The request succeeds. 0: The request succeeds.<li>Non-zero: The request fails. Non-zero: The request fails. |
| `msg ``msg` | String String | The detailed information. The detailed information. |
| `ts ``ts` | Number Number | The current Unix timestamp (in milliseconds) of the server in UTC. The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data ``data` | Object Object | Include the following parameters: Include the following parameters:<ul><li>`count`: Integer, the number of pieces of data in this batch. `count`: Integer, the number of pieces of data in this batch.</li><li>`list`: JSONArray. An array of the recording list. `list`: JSONArray. An array of the recording list. A JSON object includes the following parameters: A JSON object includes the following parameters:<ul><li>`appId`: Your Agora App ID. `appId`: Your Agora App ID.</li><li>`roomUuid`: The classroom ID. `roomUuid`: The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel.</li><li>`recordId`: The unique identifier of a recording session. `recordId`: The unique identifier of a recording session. A recording session starts when you call a method to start recording and ends when you call this method to stop recording. A recording session starts when you call a method to start recording and ends when you call this method to stop recording.</li><li>`startTime`: The UTC timestamp when a recording session starts, in milliseconds. `startTime`: The UTC timestamp when a recording session starts, in milliseconds.</li><li>`endTime`: The UTC timestamp when a recording session ends, in milliseconds. `endTime`: The UTC timestamp when a recording session ends, in milliseconds.</li><li>`resourceId`: The `resourceId` of the Agora Cloud Recording service. `resourceId`: The `resourceId` of the Agora Cloud Recording service.</li><li>`sid`: The `sid` of the Agora Cloud Recording service. `sid`: The `sid` of the Agora Cloud Recording service.</li><li>`recordUid`: The UID used by the Agora Cloud Recording service in the channel. `recordUid`: The UID used by the Agora Cloud Recording service in the channel.</li><li>`boardAppId`: The App Identifier of the Agora Interactive Whiteboard service. `boardAppId`: The App Identifier of the Agora Interactive Whiteboard service.</li><li>` boardToken`: The SDK Token of the Agora Interactive Whiteboard service. ` boardToken`: The SDK Token of the Agora Interactive Whiteboard service.</li><li>`boardId`: The unique identifier of a whiteboard session. `boardId`: The unique identifier of a whiteboard session.</li><li>`type`: Integer, the recording type: `type`: Integer, the recording type:<ul><li>`1`: Individual Recording `1`: Individual Recording</li><li>`2`: Composite Recording `2`: Composite Recording</li></ul><li>`status`: Integer, the recording state: `status`: Integer, the recording state:<ul><li>`1`: In recording. `1`: In recording.</li><li>`2`: Recording has ended. `2`: Recording has ended.</li></ul><li>`url`: String, the URL address of the recorded files in composite recording mode. `url`: String, the URL address of the recorded files in composite recording mode.</li><li>`recordDetails`: JSONArray. `recordDetails`: JSONArray. The JSON object contains the following fields: The JSON object contains the following fields:<ul><li>`url`: String, the URL address of the recorded files in web page recording mode. `url`: String, the URL address of the recorded files in web page recording mode.</li></ul></ul><li>`nextId`: String, the starting ID of the next batch of data. `nextId`: String, the starting ID of the next batch of data. If it is null, there is no next batch of data. If it is null, there is no next batch of data. If it is not null, use this `nextId` to continue the query until null is reported. If it is not null, use this `nextId` to continue the query until null is reported.</li><li>`total`: Integer, the total number of pieces of data. `total`: Integer, the total number of pieces of data.</li></ul> |

### Response example Response example

```json
"status": 200,
"status": 200,
"body":
"body":
  {
  {
  "code": 0,
  "code": 0,
  "msg": "Success",
  "msg": "Success",
  "ts": 1610450153520,
  "ts": 1610450153520,
  "data": {
  "data": {
    "total": 17,
    "total": 17,
    "list": [
    "list": [
      {
      {
        "recordId": "xxxxxx",
        "recordId": "xxxxxx",
        "appId": "xxxxxx",
        "appId": "xxxxxx",
        "roomUuid": "jason0",
        "roomUuid": "jason0",
        "startTime": 1602648426497,
        "startTime": 1602648426497,
        "endTime": 1602648430262,
        "endTime": 1602648430262,
        "resourceId": "xxxxxx",
        "resourceId": "xxxxxx",
        "sid": "xxxxxx",
        "sid": "xxxxxx",
        "recordUid": "xxxxxx",
        "recordUid": "xxxxxx",
        "boardId": "xxxxxx",
        "boardId": "xxxxxx",
        "boardToken": "xxxxxx",
        "boardToken": "xxxxxx",
        "type": 2,
        "type": 2,
        "status": 2,
        "status": 2,
        "url": "scenario/recording/xxxxxx/xxxxxx/xxxxxx.m3u8",
        "url": "scenario/recording/xxxxxx/xxxxxx/xxxxxx.m3u8",
        "recordDetails":[
        "recordDetails":[
            {
            {
            "url":"xxxx/xxxx.mp4"
            "url":"xxxx/xxxx.mp4"
            }
            }
        ]
        ]
      },
      },
      {...},
      {...},
    ],
    ],
    "count": 17
    "count": 17
} }
```

## Upload a public resource Upload a public resource

### Description Description

Call this method to upload a public resource to the specified classroom. Call this method to upload a public resource to the specified classroom. All users in the classroom can see this public resources. All users in the classroom can see this public resources.

### Prototype Prototype

- Method: PUT Method: PUT
- Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/states/{state} Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/states/{state}

### Request parameters Request parameters

**URL parameters ****URL parameters**

Pass the following parameters in the URL. Pass the following parameters in the URL.

| Parameter Parameter | Type Type | Description Description |
| :------------- | :----- | :----------------------------------------------------------- |
| `appId ``appId` | String String | (Required) The Agora App ID, see [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). (Required) The Agora App ID, see [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
| `roomUuid ``roomUuid` | String String | (Required) The classroom ID. (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. The string length must be less than 64 bytes. Supported character scopes are: Supported character scopes are:<li>All lowercase English letters: a to z. All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z. All uppercase English letters: A to Z.</li><li>All numeric characters. All numeric characters.</li><li>0-9 0-9</li><li>The space character. The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |
| `resourceUuid ``resourceUuid` | String String | (Required) The resource ID. (Required) The resource ID. This is the unique identifier of a file. This is the unique identifier of a file. The string length must be less than 64 bytes. The string length must be less than 64 bytes. Supported character scopes are: Supported character scopes are:<li>All lowercase English letters: a to z. All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z. All uppercase English letters: A to Z.</li><li>All numeric characters. All numeric characters.</li><li>0-9 0-9</li><li>The space character. The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |

**Request body parameters ****Request body parameters**

Pass in the following parameters in the request body. Pass in the following parameters in the request body.

| Parameter Parameter | Type Type | Description Description |
| :------------- | :----- | :----------------------------------------------------------- |
| `resourceName ``resourceName` | String String | The resource name for display in the classroom. The string length must be less than 64 bytes. The resource name for display in the classroom. The string length must be less than 64 bytes. |
| `size ``size` | Number Number | (Required) The size (bytes) of the resource. (Required) The size (bytes) of the resource. |
| `ext ``ext` | String String | (Required) The resource extension: (Required) The resource extension:<ul><li>`"ppt" ``"ppt"`</li><li>`"pptx" ``"pptx"`</li><li>`"pptm" ``"pptm"`</li><li>`"docx" ``"docx"`</li><li>`"doc" ``"doc"`</li><li>`"xlsx" ``"xlsx"`</li><li>`"xls" ``"xls"`</li><li>`"csv" ``"csv"`</li><li>`"pdf" ``"pdf"`</li></ul> |
| `url ``url` | String String | (Required) The URL address of the resource, such as `"https://xxx.com"`. (Required) The URL address of the resource, such as `"https://xxx.com"`. |
| `conversion ``conversion` | Object Object | (Optional) If you want to display resources such as a PPT on the whiteboard in the classroom, you need to set `conversion` to convert the resource into a static image or a dynamic HTML page. (Optional) If you want to display resources such as a PPT on the whiteboard in the classroom, you need to set `conversion` to convert the resource into a static image or a dynamic HTML page. `conversion` contains the following fields: `conversion` contains the following fields:<ul><li>`type`: (Required) String, the conversion type: `type`: (Required) String, the conversion type:<ul><li>`"static"`: Convert the file to a static picture. `"static"`: Convert the file to a static picture. If the file extension is `"ppt"`, `"doc"`, `"docx"` or `"pdf"`, you can enable static conversion. If the file extension is `"ppt"`, `"doc"`, `"docx"` or `"pdf"`, you can enable static conversion.</li><li> `"dynamic"`: Convert the file to a dynamic HTML page. `"dynamic"`: Convert the file to a dynamic HTML page. When the extension is `"pptx"`, you can enable the dynamic conversion. When the extension is `"pptx"`, you can enable the dynamic conversion.</li></ul></li><li>`preview`: (Optional) Boolean, whether to generate a preview image. `preview`: (Optional) Boolean, whether to generate a preview image. This parameter is valid only when `type` is `"dynamic"`. This parameter is valid only when `type` is `"dynamic"`.<ul><li>`true`: Generate a preview image. `true`: Generate a preview image.</li><li>`false`: (Default) Do not generate a preview image. `false`: (Default) Do not generate a preview image.</li></ul><li>`scale`: (Optional) Number, the scale factor. The range is [0.1,3.0], and the default value is 1.2. `scale`: (Optional) Number, the scale factor. The range is [0.1,3.0], and the default value is 1.2. This parameter is valid only when `type` is `"static"`. This parameter is valid only when `type` is `"static"`.</li><li>`outputFormat`: (Optional) String, the format of theoutput picture. You can set this parameter as `"png"`, `"jpg"`, `"jpeg"`, or `"webp"`. The default value is `"png"`. `outputFormat`: (Optional) String, the format of theoutput picture. You can set this parameter as `"png"`, `"jpg"`, `"jpeg"`, or `"webp"`. The default value is `"png"`. This parameter is valid only when `type` is `"static"`. This parameter is valid only when `type` is `"static"`.</li> |

### Request example Request example

**Request URL ****Request URL**

```html
// Upload a public resource with the ID of class_file_1 to test_class
// Upload a public resource with the ID of class_file_1 to test_class
https://api.agora.io/edu/apps/{your_app_Id}/v1/rooms/test_class/resources/class_file_1 https://api.agora.io/edu/apps/{your_app_Id}/v1/rooms/test_class/resources/class_file_1
```

**Request Body ****Request Body**

```json
{
{
    "resourceName": "class_file",
    "resourceName": "class_file",
    "size": 1024,
    "size": 1024,
    "ext":"ppt",
    "ext":"ppt",
    "url":"https://xxx.com",
    "url":"https://xxx.com",
    "conversion": {
    "conversion": {
        "type":"static",
        "type":"static",
        "preview": false,
        "preview": false,
        "scale": 1.2,
        "scale": 1.2,
        "outputFormat": ""
        "outputFormat": ""
    },
    },
} }
```

### Response parameters Response parameters

| Parameter Parameter | Type Type | Description Description |
| :----- | :---------- | :----------------------------------------------------------- |
| `code ``code` | Integer Integer | Business status code: Business status code:<li>0: The request succeeds. 0: The request succeeds.</li><li>Non-zero: The request fails. Non-zero: The request fails.</li> |
| `msg ``msg` | String String | The detailed information. The detailed information. |
| `ts ``ts` | Number Number | The current Unix timestamp (in milliseconds) of the server in UTC. The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data ``data` | Object Array Object Array | An array of republic resources. An array of republic resources. Each object represents a public resource and contains the following fields: Each object represents a public resource and contains the following fields:<li>`resourceUuid`: String. The resource ID. `resourceUuid`: String. The resource ID. This is the unique identifier of a file. This is the unique identifier of a file.</li><li>`resourceName`: String, the resource name for display in the classroom. `resourceName`: String, the resource name for display in the classroom.</li> <li>`ext`: String, the resource extension. `ext`: String, the resource extension.</li><li>`size`: Number, the resource size (bytes). `size`: Number, the resource size (bytes).</li><li>`url`: String, the URL address of the resource. `url`: String, the URL address of the resource.</li><li>`updateTime`: Number, the update time of the resource, Unix timestamp (in milliseconds), UTC time. `updateTime`: Number, the update time of the resource, Unix timestamp (in milliseconds), UTC time.</li><li>`convert`: Boolean, whether to enable file conversion. `convert`: Boolean, whether to enable file conversion.</li><li>`taskUuid`: String, the ID of the file conversion task. `taskUuid`: String, the ID of the file conversion task.</li><li>`taskToken`: String, the token used by the file conversion task. `taskToken`: String, the token used by the file conversion task.</li><li>`taskProgress`: Object, the progress of the file conversion task, including the following fields: `taskProgress`: Object, the progress of the file conversion task, including the following fields:<ul> <li>`totalPageSize`: Number, the total number of pages in the file. `totalPageSize`: Number, the total number of pages in the file.</li><li>`convertedPageSize`: Number, the number of pages that have been converted. `convertedPageSize`: Number, the number of pages that have been converted.</li> <li>`convertedPercentage`: Number, the progress (percentage) of the conversion task. `convertedPercentage`: Number, the progress (percentage) of the conversion task.</li> <li>`convertedFileList`: Object array, the list of converted pages. `convertedFileList`: Object array, the list of converted pages. Each object represents a converted page and contains the following fields: Each object represents a converted page and contains the following fields:<ul><li>`name`: String. The page name. `name`: String. The page name.<li>`ppt`: Object, a PPT page, containing the following fields: `ppt`: Object, a PPT page, containing the following fields:<ul><li>`width`: Number, the page width (pixel). `width`: Number, the page width (pixel).<li>`height`: Number. `height`: Number. The page height (pixel). The page height (pixel).<li>`src`: String, the URL address of the converted page. `src`: String, the URL address of the converted page.<li>`preview`: String, the URL address of the preview image. This field is only available when the `type` is set as `"dynamic"` and `preview` is set as `true`. `preview`: String, the URL address of the preview image. This field is only available when the `type` is set as `"dynamic"` and `preview` is set as `true`.</ul></ul><li>`currentStep`: The current step of the conversion task. This field is only available when the `type` is `"dynamic"`. `currentStep`: The current step of the conversion task. This field is only available when the `type` is `"dynamic"`. This field can be `"Extracting"`, `"Packaging"`, `"GeneratingPreview"`, or `"MediaTranscode"`. This field can be `"Extracting"`, `"Packaging"`, `"GeneratingPreview"`, or `"MediaTranscode"`.</ul> |

### Response example Response example

```json
{
{
    "msg":"Success",
    "msg":"Success",
    "code":0,
    "code":0,
    "ts":1610433913533,
    "ts":1610433913533,
    "data":{
    "data":{
        "resourceUuid": "class_file_1",
        "resourceUuid": "class_file_1",
        "resourceName": "class_file",
        "resourceName": "class_file",
        "ext": "ppt",
        "ext": "ppt",
        "size": 1024,
        "size": 1024,
        "url": "https://xxx.com",
        "url": "https://xxx.com",
        "updateTime": 0,
        "updateTime": 0,
        "convert": true,
        "convert": true,
        "taskUuid":"",
        "taskUuid":"",
        "taskToken":"",
        "taskToken":"",
        "taskProgress": {
        "taskProgress": {
            "totalPageSize": 10,
            "totalPageSize": 10,
            "convertedPageSize": 3,
            "convertedPageSize": 3,
            "convertedPercentage": 30,
            "convertedPercentage": 30,
            "convertedFileList": [{
            "convertedFileList": [{
                "name": 1,
                "name": 1,
                "ppt":{
                "ppt":{
                    "width": 1024,
                    "width": 1024,
                    "height": 960,
                    "height": 960,
                    "src": "xxxx://xxxx.xxx.xx/xxxx.xxx",
                    "src": "xxxx://xxxx.xxx.xx/xxxx.xxx",
                    "preview": "xxxx://xxxx.xxx.xx/xxxx.xxx",
                    "preview": "xxxx://xxxx.xxx.xx/xxxx.xxx",
                }
                }
            },{...}],
            },{...}],
            "currentStep": "Extracting"
            "currentStep": "Extracting"
        }
        }
    }
    }
} }
```

## Delete public resources Delete public resources

### Description Description

Delete one or multiple public resources in the specified classroom. Delete one or multiple public resources in the specified classroom.

### Prototype Prototype

- Method: DELETE Method: DELETE
- Endpoint: /edu/apps/{appId}/v1/rooms/{roomUuid}/resources Endpoint: /edu/apps/{appId}/v1/rooms/{roomUuid}/resources

### Request parameters Request parameters

**URL parameters ****URL parameters**

Pass the following parameters in the URL. Pass the following parameters in the URL.

| Parameter Parameter | Type Type | Description Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `appId ``appId` | String String | (Required) The Agora App ID, see [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). (Required) The Agora App ID, see [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
| `roomUuid ``roomUuid` | String String | (Required) The classroom ID. (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. The string length must be less than 64 bytes. Supported character scopes are: Supported character scopes are:<li>All lowercase English letters: a to z. All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z. All uppercase English letters: A to Z.</li><li>All numeric characters. All numeric characters.</li><li>0-9 0-9</li><li>The space character. The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |

**Request body parameters ****Request body parameters**

Pass in the following parameters in the request body. Pass in the following parameters in the request body.

| Parameter Parameter | Type Type | Description Description |
| :------------- | :---------- | :----------------------------------------------------------- |
| `resourceUuid ``resourceUuid` | String array String array | (Required) An array of resource IDs. (Required) An array of resource IDs. The resource ID is the unique identifier of a resource. The resource ID is the unique identifier of a resource. The string length must be less than 64 bytes. The string length must be less than 64 bytes. Supported character scopes are: Supported character scopes are:<li>All lowercase English letters: a to z. All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z. All uppercase English letters: A to Z.</li><li>All numeric characters. All numeric characters.</li><li>0-9 0-9</li><li>The space character. The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |

### Request example Request example

**Request URL ****Request URL**

```html
https://api.agora.io/edu/apps/{your_app_Id}/v1/rooms/test_class/resources https://api.agora.io/edu/apps/{your_app_Id}/v1/rooms/test_class/resources
```

**Request Body ****Request Body**

```json
{
{
    "resourceUuid": ["uuid1","uuid2"]
    "resourceUuid": ["uuid1","uuid2"]
} }
```

### Response parameters Response parameters

| Parameter Parameter | Type Type | Description Description |
| :----- | :------ | :------------------------------------------- |
| `code ``code` | Integer Integer | Business status code: Business status code:<li>0: The request succeeds. 0: The request succeeds.</li><li>Non-zero: The request fails. Non-zero: The request fails.</li> |
| `msg ``msg` | String String | The detailed information. The detailed information. |
| `ts ``ts` | Number Number | The current Unix timestamp (in milliseconds) of the server in UTC. The current Unix timestamp (in milliseconds) of the server in UTC. |

### Response example Response example

```json
{
{
    "msg":"Success",
    "msg":"Success",
    "code":0,
    "code":0,
    "ts":1610433913533
    "ts":1610433913533
} }
```

## Get public resources Get public resources

### Description Description

Get all public resources in the specified classroom. Get all public resources in the specified classroom.

### Prototype Prototype

- Method: GET Method: GET
- Endpoint: /edu/apps/{appId}/v1/rooms/{roomUuid}/resources Endpoint: /edu/apps/{appId}/v1/rooms/{roomUuid}/resources

### Request parameters Request parameters

**URL parameters ****URL parameters**

Pass the following parameters in the URL. Pass the following parameters in the URL.

| Parameter Parameter | Type Type | Description Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `appId ``appId` | String String | (Required) The Agora App ID, see [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). (Required) The Agora App ID, see [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
| `roomUuid ``roomUuid` | String String | (Required) The classroom ID. (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. The string length must be less than 64 bytes. Supported character scopes are: Supported character scopes are:<li>All lowercase English letters: a to z. All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z. All uppercase English letters: A to Z.</li><li>All numeric characters. All numeric characters.</li><li>0-9 0-9</li><li>The space character. The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |

### Request example Request example

**Request URL ****Request URL**

```html
// Get the public resource with the ID of class_file_1 in test_class
// Get the public resource with the ID of class_file_1 in test_class
https://api.agora.io/edu/apps/{your_app_Id}/v1/rooms/test_class/resources https://api.agora.io/edu/apps/{your_app_Id}/v1/rooms/test_class/resources
```

### Response parameters Response parameters

| Parameter Parameter | Type Type | Description Description |
| :----- | :---------- | :----------------------------------------------------------- |
| `code ``code` | Integer Integer | Business status code: Business status code:<li>0: The request succeeds. 0: The request succeeds.</li><li>Non-zero: The request fails. Non-zero: The request fails.</li> |
| `msg ``msg` | String String | The detailed information. The detailed information. |
| `ts ``ts` | Number Number | The current Unix timestamp (in milliseconds) of the server in UTC. The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data ``data` | Object Array Object Array | An array of republic resources. An array of republic resources. Each object represents a public resource and contains the following fields: Each object represents a public resource and contains the following fields:<li>`resourceUuid`: String. The resource ID. `resourceUuid`: String. The resource ID. This is the unique identifier of a file. This is the unique identifier of a file.</li><li>`resourceName`: String, the resource name for display in the classroom. `resourceName`: String, the resource name for display in the classroom.</li> <li>`ext`: String, the resource extension. `ext`: String, the resource extension.</li><li>`size`: Number, the resource size (bytes). `size`: Number, the resource size (bytes).</li><li>`url`: String, the URL address of the resource. `url`: String, the URL address of the resource.</li><li>`updateTime`: Number, the update time of the resource, Unix timestamp (in milliseconds), UTC time. `updateTime`: Number, the update time of the resource, Unix timestamp (in milliseconds), UTC time.</li><li>`convert`: Boolean, whether to enable file conversion. `convert`: Boolean, whether to enable file conversion.</li><li>`taskUuid`: String, the ID of the file conversion task. `taskUuid`: String, the ID of the file conversion task.</li><li>`taskToken`: String, the token used by the file conversion task. `taskToken`: String, the token used by the file conversion task.</li><li>`taskProgress`: Object, the progress of the file conversion task, including the following fields: `taskProgress`: Object, the progress of the file conversion task, including the following fields:<ul> <li>`totalPageSize`: Number, the total number of pages in the file. `totalPageSize`: Number, the total number of pages in the file.</li><li>`convertedPageSize`: Number, the number of pages that have been converted. `convertedPageSize`: Number, the number of pages that have been converted.</li> <li>`convertedPercentage`: Number, the progress (percentage) of the conversion task. `convertedPercentage`: Number, the progress (percentage) of the conversion task.</li> <li>`convertedFileList`: Object array, the list of converted pages. `convertedFileList`: Object array, the list of converted pages. Each object represents a converted page and contains the following fields: Each object represents a converted page and contains the following fields:<ul><li>`name`: String. The page name. `name`: String. The page name.<li>`ppt`: Object, a PPT page, containing the following fields: `ppt`: Object, a PPT page, containing the following fields:<ul><li>`width`: Number, the page width (pixel). `width`: Number, the page width (pixel).<li>`height`: Number. `height`: Number. The page height (pixel). The page height (pixel).<li>`src`: String, the URL address of the converted page. `src`: String, the URL address of the converted page.<li>`preview`: String, the URL address of the preview image. This field is only available when the `type` is set as `"dynamic"` and `preview` is set as `true`. `preview`: String, the URL address of the preview image. This field is only available when the `type` is set as `"dynamic"` and `preview` is set as `true`.</ul></ul><li>`currentStep`: The current step of the conversion task. This field is only available when the `type` is `"dynamic"`. `currentStep`: The current step of the conversion task. This field is only available when the `type` is `"dynamic"`. This field can be `"Extracting"`, `"Packaging"`, `"GeneratingPreview"`, or `"MediaTranscode"`. This field can be `"Extracting"`, `"Packaging"`, `"GeneratingPreview"`, or `"MediaTranscode"`.</ul> |

### Response example Response example

```json
{
{
    "msg":"Success",
    "msg":"Success",
    "code":0,
    "code":0,
    "ts":1610433913533,
    "ts":1610433913533,
    "data":[{
    "data":[{
        "resourceUuid": "",
        "resourceUuid": "",
        "resourceName": "",
        "resourceName": "",
        "ext": "",
        "ext": "",
        "size": 0,
        "size": 0,
        "url": "",
        "url": "",
        "updateTime": 0,
        "updateTime": 0,
        "convert": true,
        "convert": true,
        "taskUuid":"",
        "taskUuid":"",
        "taskToken":"",
        "taskToken":"",
        "taskProgress": {
        "taskProgress": {
            "totalPageSize": 10,
            "totalPageSize": 10,
            "convertedPageSize": 3,
            "convertedPageSize": 3,
            "convertedPercentage": 30,
            "convertedPercentage": 30,
            "convertedFileList": [{
            "convertedFileList": [{
                "name": 1,
                "name": 1,
                "ppt":{
                "ppt":{
                    "width": 1024,
                    "width": 1024,
                    "height": 960,
                    "height": 960,
                    "src": "xxxx://xxxx.xxx.xx/xxxx.xxx",
                    "src": "xxxx://xxxx.xxx.xx/xxxx.xxx",
                    "preview": "xxxx://xxxx.xxx.xx/xxxx.xxx",
                    "preview": "xxxx://xxxx.xxx.xx/xxxx.xxx",
                }
                }
            },{...}],
            },{...}],
            "currentStep": "Extracting"
            "currentStep": "Extracting"
        }
        }
    }]
    }]
} }
```

## Query a specified event Query a specified event

### Description Description

Query a specified type of event in a specified classroom. Query a specified type of event in a specified classroom.

You can fetch data in batches with the `nextId` parameter. You can get up to 100 pieces of data for each batch. You can fetch data in batches with the `nextId` parameter. You can get up to 100 pieces of data for each batch.

<div class="note info"><li>You can query the same event repeatedly. You can query the same event repeatedly.</li><li> You cannot query events in a destroyed classroom.  You cannot query events in a destroyed classroom. A classroom is destroyed automatically one hour after it is ended. A classroom is destroyed automatically one hour after it is ended.</li>

### Prototype Prototype

- Method: GET Method: GET
- Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/sequences Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/sequences

### Request parameters Request parameters

**URL parameters ****URL parameters**

Pass the following parameters in the URL. Pass the following parameters in the URL.

| Parameter Parameter | Type Type | Description Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `appId ``appId` | String String | (Required) The Agora App ID, see [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). (Required) The Agora App ID, see [Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
| `roomUuid ``roomUuid` | String String | (Required) The classroom ID. (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. The string length must be less than 64 bytes. Supported character scopes are: Supported character scopes are:<li>All lowercase English letters: a to z. All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z. All uppercase English letters: A to Z.</li><li>All numeric characters. All numeric characters.</li><li>0-9 0-9</li><li>The space character. The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |

**Query parameters ****Query parameters**

| Parameter Parameter | Type Type | Description Description |
| :------- | :------ | :----------------------------------------------------------- |
| `nextId ``nextId` | String String | (Optional) The starting ID of the next batch of data. (Optional) The starting ID of the next batch of data. When you call this method to get the data for the first time, leave this parameter empty or set it as null. Afterward, you can set this parameter as the `nextId` that you get in the response of the previous method call. When you call this method to get the data for the first time, leave this parameter empty or set it as null. Afterward, you can set this parameter as the `nextId` that you get in the response of the previous method call. |
| `cmd ``cmd` | Integer Integer | (Optional) Event type. For details, see Flexible [Classroom Cloud Service Events](https://docs.agora.io/cn/agora-class/agora_class_restful_api_event). (Optional) Event type. For details, see Flexible [Classroom Cloud Service Events](https://docs.agora.io/cn/agora-class/agora_class_restful_api_event). |

### Request example Request example

**Request URL ****Request URL**

```html
// Get the event of classroom state update in test_class
// Get the event of classroom state update in test_class
https://api.agora.io/edu/apps/{appId}/v2/rooms/test_class/sequences?nextId=50&cmd=1 https://api.agora.io/edu/apps/{appId}/v2/rooms/test_class/sequences?nextId=50&cmd=1
```

### Response parameters Response parameters

| Parameter Parameter | Type Type | Description Description |
| :----- | :------ | :----------------------------------------------------------- |
| `code ``code` | Integer Integer | Business status code: 0: The request succeeds. Business status code: 0: The request succeeds. Non-zero: The request fails. Non-zero: The request fails. |
| `msg ``msg` | String String | The detailed information. The detailed information. |
| `ts ``ts` | Number Number | The current Unix timestamp (in milliseconds) of the server in UTC. The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data ``data` | Object Object | Include the following parameters: Include the following parameters:<ul><li>`total`: Integer, the total number of pieces of data. `total`: Integer, the total number of pieces of data.</li><li>`count`: Integer, the number of pieces of data in this batch. `count`: Integer, the number of pieces of data in this batch.</li><li>`list`: JSONArray. An array of the recording list. `list`: JSONArray. An array of the recording list. A JSON object includes the following parameters: A JSON object includes the following parameters:<ul><li>`roomUuid`: String, the classroom ID. `roomUuid`: String, the classroom ID.</li><li>`cmd`: Integer, the event type. `cmd`: Integer, the event type. See [Flexible Classroom Events](https://docs.agora.io/cn/agora-class/agora_class_restful_api_event). See [Flexible Classroom Events](https://docs.agora.io/cn/agora-class/agora_class_restful_api_event).</li><li>`sequence`: Integer. `sequence`: Integer. The event ID. This is the unique identifier of an event, which is automatically generated to ensure the order of events. The event ID. This is the unique identifier of an event, which is automatically generated to ensure the order of events.</li><li>`version`: Integer, the service version. `version`: Integer, the service version.</li><li>`data`: Object, the detailed data of the event, The data varies depending on the event type. `data`: Object, the detailed data of the event, The data varies depending on the event type. See [Flexible Classroom Events](https://docs.agora.io/cn/agora-class/agora_class_restful_api_event). See [Flexible Classroom Events](https://docs.agora.io/cn/agora-class/agora_class_restful_api_event).</li></ul><li>`nextId`: String, the starting ID of the next batch of data. `nextId`: String, the starting ID of the next batch of data. If it is null, there is no next batch of data. If it is null, there is no next batch of data. If it is not null, use this `nextId` to continue the query until null is reported. If it is not null, use this `nextId` to continue the query until null is reported.</li></ul> |

### Response example Response example

```json
{
{
    "msg":"Success",
    "msg":"Success",
    "code":0,
    "code":0,
    "ts":1610433913533,
    "ts":1610433913533,
    "data":{
    "data":{
        "total":1,
        "total":1,
        "list":[
        "list":[
            {
            {
                "roomUuid": "",
                "roomUuid": "",
                "cmd": 20,
                "cmd": 20,
                "sequence": 1,
                "sequence": 1,
                "version": 1,
                "version": 1,
                "data":{}
                "data":{}
            }
            }
        ],
        ],
        "nextId": null,
        "nextId": null,
        "count":1
        "count":1
    }
    }
} }
```

## Get classroom events Get classroom events

### Description Description

Get all events in the classrooms associated with a specified App ID. Get all events in the classrooms associated with a specified App ID.

You can call this method at regular intervals to listen for all the events that occur in the flexible classrooms. You can call this method at regular intervals to listen for all the events that occur in the flexible classrooms.

<div class="alert note"><li>Each event can only be obtained once. Each event can only be obtained once.</li><li>Note: You cannot get events one hour after a classroom is destroyed. Note: You cannot get events one hour after a classroom is destroyed.</li></div>

### Prototype Prototype

- Method: GET Method: GET
- Endpoint: /edu/polling/apps/{appId}/v2/rooms/sequences Endpoint: /edu/polling/apps/{appId}/v2/rooms/sequences

### Request parameters Request parameters

**URL parameters ****URL parameters**

Pass the following parameter in the URL. Pass the following parameter in the URL.

| Parameter Parameter | Type Type | Description Description |
| :------ | :----- | :----------------------------------------------------------- |
| `appId ``appId` | String String | (Required) The Agora App ID, see [Get the Agora App ID](./agora_class_prep#step1). (Required) The Agora App ID, see [Get the Agora App ID](./agora_class_prep#step1). |

### Request example Request example

```html
https://api.agora.io/edu/polling/apps/{yourappId}/v2/rooms/sequences https://api.agora.io/edu/polling/apps/{yourappId}/v2/rooms/sequences
```

### Response parameters Response parameters

| Parameter Parameter | Type Type | Description Description |
| :----- | :------ | :----------------------------------------------------------- |
| `code ``code` | Integer Integer | Business status code: Business status code:<li>0: The request succeeds. 0: The request succeeds.<li>Non-zero: The request fails. Non-zero: The request fails. |
| `msg ``msg` | String String | The detailed information. The detailed information. |
| `ts ``ts` | Number Number | The current Unix timestamp (in milliseconds) of the server in UTC. The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data ``data` | Object Object | Include the following parameters: Include the following parameters:<li>`roomUuid`: String, the classroom ID. `roomUuid`: String, the classroom ID.<li>`cmd`: Integer, the event type. `cmd`: Integer, the event type. See [Flexible Classroom Events](./agora_class_restful_api_event). See [Flexible Classroom Events](./agora_class_restful_api_event).<li>`sequence`: Integer. `sequence`: Integer. The event ID. This is the unique identifier of an event, which is automatically generated to ensure the order of events. The event ID. This is the unique identifier of an event, which is automatically generated to ensure the order of events.<li>`version`: Integer, the service version. `version`: Integer, the service version.<li>`data`: Object, the detailed data of the event, The data varies depending on the event type. `data`: Object, the detailed data of the event, The data varies depending on the event type. See [Flexible Classroom Events](./agora_class_restful_api_event). See [Flexible Classroom Events](./agora_class_restful_api_event). |

### Response example Response example

```json
"status": 200,
"status": 200,
"body":
"body":
{
{
    "msg": "Success",
    "msg": "Success",
    "code": 0,
    "code": 0,
    "ts": 1610167740309,
    "ts": 1610167740309,
    "data":[
    "data":[
        {
        {
            "roomUuid": "xxxxxx",
            "roomUuid": "xxxxxx",
            "cmd": 20,
            "cmd": 20,
            "sequence": 1,
            "sequence": 1,
            "version": 1,
            "version": 1,
            "data":{}
            "data":{}
        }
        }
    ]
    ]
} }
```

## Status code Status code

| Response status code Response status code | Business status code Business status code | Description Description |
| :-------------- | :--------- | :----------------------------------------------------------- |
| 200 200 | 0 0 | The request succeeds. The request succeeds. |
| 400 400 | 400 400 | The request parameter is incorrect. The request parameter is incorrect. |
| 401 401 | N/A N/A | Possible reasons: Possible reasons:<li>The App ID is invalid. The App ID is invalid.<li>Unauthorized. Incorrect `x-agora-uid` or `x-agora-token`. Unauthorized. Incorrect `x-agora-uid` or `x-agora-token`. |
| 403 403 | 30403200 30403200 | The classroom is muted globally. Users cannot send chat messages. The classroom is muted globally. Users cannot send chat messages. |
| 404 404 | N/A N/A | The server cannot find the requested resource. The server cannot find the requested resource. |
| 404 404 | 20404100 20404100 | The classroom does not exist. The classroom does not exist. |
| 404 404 | 20404200 20404200 | The user does not exist. The user does not exist. |
| 409 409 | 30409410 30409410 | The recording has not been started. The recording has not been started. |
| 409 409 | 30409411 30409411 | The recording has not been ended. The recording has not been ended. |
| 409 409 | 30409100 30409100 | The class has been started. The class has been started. |
| 409 409 | 30409101 30409101 | The class has been ended. The class has been ended. |
| 500 500 | 500 500 | The server has an internal error and cannot process the request. The server has an internal error and cannot process the request. |
| 503 503 | N/A N/A | Internal server error. Internal server error. The gateway or proxy server does not receive a timely response from the upstream server. The gateway or proxy server does not receive a timely response from the upstream server. |