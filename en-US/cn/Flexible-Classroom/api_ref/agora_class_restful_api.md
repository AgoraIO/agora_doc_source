This page provides detailed help for the Flexible Classroom RESTful APIs.

<div class="alert info">See the changelog of Flexible Classroom Cloud Service<a href="./agora_class_restful_api_release"></a>.</div>

## Basic information

### Server

All requests are sent to the host: api.agora.io.

### Data format

The Content-Type of all requests is application/json.

### Authentication

Flexible Classroom Cloud Service uses tokens for authentication. You need to put the following information to the `x-agora-token` and `x-agora-uid` fields when sending your HTTP request:

- The RTM Token generated at your server.
- The uid you use to generate the RTM Token.

For details, see[ Generate an RTM Token](https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms).

## Set the classroom state

### Description

Call this method to set the classroom state: Not started, Started, Ended. For the detailed description of each state, see classroom [state management](./class_state).

### Prototype

- Method: PUT
- Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/states/{state}

### Request parameters

**URL parameters**

Pass the following parameter in the URL.

| Parameter | Category | Description |
| :--------- | :------ | :----------------------------------------------------------- |
| `appId` | String | (Required) The Agora App ID, see[ Get the Agora App ID](./agora_class_prep#step1). |
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `state` | Integer | (Required) The classroom state:<li>`0`: Not started.<li>`1`: Start recording.<li>`2`: Ended. |

### Request example

```html
// Set the state of the test_class as started
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/states/1
```

### Response parameters

| Parameter | Category | Description |
| :----- | :------ | :------------------------------------------------ |
| `code` | Integer | Business status code:<li>0: The request succeeds.<li>Non-zero: The request fails. |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |

### Response example

```json
"status": 200,
"body":
{
  "code": 0,
  "msg": "Success",
  "ts": 1610450153520
}
```

## Kick a user out of a classroom

### Description

Call this method to kick a specified user out of a classroom. After a successful method call, the server triggers an event indicating a user leaves the classroom. You can use the `dirty` parameter to determine whether the user can enter the classroom afterwards.

### Prototype

- Method: POST
- Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/users/{userUuid}/exit

### Request parameters

**URL parameters**

Pass the following parameters in the URL.

| Parameter | Category | Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `appId` | String | (Required) The Agora App ID, see[ Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z.</li><li>All numeric characters.</li><li>0-9</li><li>The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |
| `userUuid` | String | (Required) The user ID. This is the unique identifier of the user and also the user ID used when logging in to the Agora RTM system. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z.</li><li>All numeric characters.</li><li>0-9</li><li>The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |

**Request body parameters**

Pass in the following parameters in the request body.

| Parameter | Category | Description |
| :------ | :----- | :----------------------------------------------------------- |
| `dirty` | Object | (Optional) The user's taint settings, including the following fields:<ul><li>`state`: Boolean type, stain state:<ul><li>`0`: Not dirty. A dirty user cannot enter the classroom.</li><li>`0`: Not dirty.</li></ul><li>`duration`: Number, the duration of the dirty setting (seconds), starting from the time when the user is kicked out of the classroom.</li></ul> |

### Request example

**Request URL**

```html
// Kick the user with the ID 123 out of test_class
https://api.agora.io/edu/apps/{your_app_Id}/v2/rooms/test_class/users/123/exit
```

**Request Body**

```json
{
    "dirty": {
        "state": 1,
        "duration": 600
    }
}
```

### Response parameters

| Parameter | Category | Description |
| :----- | :------ | :------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |

### Response example

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## Set the recording state

### Description

Call this method to start or stop recording a specified classroom.

### Prototype

- Method: PUT
- Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/records/states/{state}

### Request parameters

**URL parameters**

Pass the following parameter in the URL.

| Parameter | Category | Description |
| :--------- | :------ | :----------------------------------------------------------- |
| `appId` | String | (Required) The Agora App ID, see[ Get the Agora App ID](./agora_class_prep#step1). |
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z.</li><li>All numeric characters.</li><li>0-9</li><li>The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |
| `state` | Integer | (Required) The recording state:<li>`0`: Stop recoding.</li><li>`1`: Start recording.</li> |

**Request body parameters**

Pass in the following parameters in the request body.

| Parameter | Category | Description |
| :---------------- | :----- | :----------------------------------------------------------- |
| `mode` | String | (Optional) The recording mode:<li>Set the recording](https://docs.agora.io/cn/Agora%20Platform/webpage_recording) as `web `to enable [page recording mode. The format of recorded files is MP4. When the length of the recorded file reaches around two hours, or when the size of the file exceeds around 2 GB, the recording service automatically creates another MP4 file.</li><li>If you do not set this parameter, Agora [Flexible Classroom ](https://docs.agora.io/cn/Agora%20Platform/composite_recording_mode)records the audio and video of the teachers in composite recording mode by default. The format of recorded files is M3U8 and TS.</li> |
| `webRecordConfig` | Object | (Optional) When` the `mode` is web`, you need to` set the detailed configuration of the web` page recording through webRecordConfig, including the following fields:<ul><li>`url`: (Required) String, the address of the web page to record. If you want to record a certain lesson of the  Flexible Classroom, you need to pass in the relevant parameters for starting the class in the URL, so that the Agora  Cloud Recording service can join the designated class as a "hidden user" for recording. You can refer to the URL example in the request example. The following parameters must be included in the URL:<ul><li>`userUuid`: The user ID used by the Agora  Cloud Recording service. Please make sure not to duplicate the ID of an existing user in the class, otherwise the Agora  Cloud Recording service will not be able to join the class.</li><li>`roomUuid`: The classroom ID of the classroom to be recorded.</li><li>`roomType`: The class type of the class to be recorded.</li><li>`roleType`: The role of the Agora  Cloud Recording service in the classroom to be recorded, set to 0 (dedicated to the recording classroom role).</li><li>`pretest`: Whether to start pre-class testing, set to `false`.</li><li>`rtmToken`: RTM Token used by Agora cloud Cloud Recording service.</li><li>`language`: interface` language, can be set to zh` or `en`.</li><li>`appId`: Your Agora App ID.</li></ul><li>`rootUrl`: fixed URL address, obtained from the GitHub demo.</li><li>`videoBitrate`: (Optional) Number, the[ bitrate of the video (Kbps). The value range is 50, 8000]. The default value of videoBitrate varies according to the resolution` of the output video`:<ul><li>1280 × 720: The default value is 1130.</li><li>960 × 720: The default value is 910.</li><li>848 × 480: The default value is 610.</li><li>640 × 480: The default value is 400.</li><li>For all other resolutions, the default value is 300.</li></ul><li>`videoFps`: (Optional) Number, the frame rate of the[ video (fps). The value range is 5,60]. The default value is 15.</li><li>`audioProfile`: (Optional) Number. The sample rate, encoding mode, number of audio channels, and bitrate.<ul><li>0: (Default) Sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 48 Kbps.</li><li>1: Sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 128 Kbps.</li><li>2: Sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 192 Kbps.</li></ul><li>`videoWidth`: Number, the width of the video (pixels). The value range is[  480, 1280]. The default is 1280. The product of`` videoWidth` and videoHeight` should not exceed 921,600 (1280 × 720).</li><li>`videoHeight`: Number, the height of the[ video (pixels). The value range is  480, 1280]. The default is 720. The product of`` videoWidth` and videoHeight` should not exceed 921,600 (1280 × 720).</li><li>`maxRecordingHour`: Number, the maximum recording length (hours). The value range is [1,720], and the default value is 3. If the limit set by `maxRecordingHour `is exceeded, the recording stops automatically. |

### Request example

**Request URL**

```html
// Start recording test_class
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records/states/1
```

**Request Body**

```json
{
    "mode": "web",
    "webRecordConfig": {
        "url":"https://webdemo.agora.io/xxxxx/?userUuid={recorder_id}&roomUuid={room_id_to_be_recorded}&roleType=0&roomType=4&pretest=false&rtmToken={recorder_token}&language=en&appId={your_app_id}"
    }
}
```

### Response parameters

| Parameter | Category | Description |
| :----- | :------ | :------------------------------------------------ |
| `code` | Integer | Business status code:<li>0: The request succeeds.<li>Non-zero: The request fails. |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |

### Response example

```json
"status": 200,
"body":
{
  "code": 0,
  "ts": 1610450153520
}
```

## Get the recording list

### Description

Get the recording list in a specified classroom.

You can fetch data in batches with the `nextId` parameter. You can get up to 100 pieces of data for each batch.

### Prototype

- Method: GET
- Endpoint: /edu/apps/{appId}/v2/rooms/{roomUuid}/records

### Request parameters

**URL parameters**

Pass the following parameter in the URL.

| Parameter | Category | Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `appId` | String | (Required) The Agora App ID, see[ Get the Agora App ID](./agora_class_prep#step1). |
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters.<li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |

**Query parameters**

| Parameter | Category | Description |
| :------- | :----- | :----------------------------------------------------------- |
| `nextId` | String | (Optional) The starting ID of the next batch of data. When you call this method to get the data for the first time, leave this parameter empty or set it as null. Afterward, you can set this parameter as the nextId that you get in the response of the previous method ``call. |

### Request example

```html
// Get the recording list in test_class
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records?nextId=xxx
```

### Response parameters

| Parameter | Category | Description |
| :----- | :------ | :----------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.<li>Non-zero: The request fails. |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data` | Object | Include the following parameters:<ul><li>`count`: Integer, the number of pieces of data in this batch.</li><li>`list`: JSONArray. An array of the recording list. A JSON object includes the following parameters:<ul><li>`appId`: Your Agora App ID.</li><li>`roomUuid`: The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel.</li><li>`recordId`: The unique identifier of a recording session. A recording session starts when you call a method to start recording and ends when you call this method to stop recording.</li><li>`startTime`: The UTC timestamp when a recording session starts, in milliseconds.</li><li>`endTime`: The UTC timestamp when a recording session ends, in milliseconds.</li><li>`resourceId`: The resourceId of the Agora Cloud Recording service``.</li><li>`sid`: The sid of the Agora Cloud Recording service``.</li><li>`recordUid`: The UID used by the Agora Cloud Recording service in the channel.</li><li>`boardAppId`: The App Identifier of the Agora Interactive Whiteboard service.</li><li>` boardToken`: The SDK Token of the Agora Interactive Whiteboard service.</li><li>`boardId`: The unique identifier of a whiteboard session.</li><li>`type`: Integer, the recording type:<ul><li>`1`: Individual Recording</li><li>`2`: Composite Recording</li></ul><li>`status`: Integer, the recording state:<ul><li>`1`: In recording.</li><li>`2`: Recording has ended.</li></ul><li>`url`: String, the URL address of the recorded files in composite recording mode.</li><li>`recordDetails`: JSONArray. The JSON object contains the following fields:<ul><li>`url`: String, the URL address of the recorded files in web page recording mode.</li></ul></ul><li>`nextId`: String, the starting ID of the next batch of data. If it is null, there is no next batch of data. If it is not null, use this `nextId` to continue the query until null is reported.</li><li>`total`: Integer, the total number of pieces of data.</li></ul> |

### Response example

```json
"status": 200,
"body":
  {
  "code": 0,
  "msg": "Success",
  "ts": 1610450153520,
  "data": {
    "total": 17,
    "list": [
      {
        "recordId": "xxxxxx",
        "appId": "xxxxxx",
        "roomUuid": "jason0",
        "startTime": 1602648426497,
        "endTime": 1602648430262,
        "resourceId": "xxxxxx",
        "sid": "xxxxxx",
        "recordUid": "xxxxxx",
        "boardId": "xxxxxx",
        "boardToken": "xxxxxx",
        "type": 2,
        "status": 2,
        "url": "scenario/recording/xxxxxx/xxxxxx/xxxxxx.m3u8",
        "recordDetails":[
            {
            "url":"xxxx/xxxx.mp4"
            }
        ]
      },
      {...},
    ],
    "count": 17
}
```

## Upload a public resource

### Description

Call this method to upload a public resource to the specified classroom. All users in the classroom can see this public resources.

### Prototype

- Method: PUT
- Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/states/{state}

### Request parameters

**URL parameters**

Pass the following parameters in the URL.

| Parameter | Category | Description |
| :------------- | :----- | :----------------------------------------------------------- |
| `appId` | String | (Required) The Agora App ID, see[ Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z.</li><li>All numeric characters.</li><li>0-9</li><li>The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |
| `resourceUuid`, | String | (Required) The resource ID. This is the unique identifier of a file. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z.</li><li>All numeric characters.</li><li>0-9</li><li>The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |

**Request body parameters**

Pass in the following parameters in the request body.

| Parameter | Category | Description |
| :------------- | :----- | :----------------------------------------------------------- |
| `resourceName` | String | The resource name for display in the classroom. The string length must be less than 64 bytes. |
| `size` | Number | (Required) The size (bytes) of the resource. |
| `ext` | String | (Required) Resource extension:<ul><li>`"ppt"`:{</li><li>`"pptx"`</li><li>`"pptm"`</li><li>`"docx"`</li><li>`"doc"`</li><li>`"xlsx"`</li><li>`"xls"`</li><li>`"csv"`</li><li>`"pdf"`</li></ul> |
| `url` | String | (Required) The URL address of the resource, such as `"https://xxx.com"`. |
| `conversion` | Object | (Optional) If you want to display resources such as a PPT on the whiteboard in the classroom, you need to set `conversion` to convert the resource into a static image or a dynamic HTML page. `conversion `contains the following fields:<ul><li>`type`: (Required) String, the conversion type:<ul><li>`"static"`: Convert the file to a static picture. If the file extension is `"ppt"`, `"doc"`,` "docx"` or `"pdf"`, you can enable static conversion.</li><li> `"dynamic"`: Convert the file to a dynamic HTML page. When the extension is `"pptx"`, you can enable the dynamic conversion.</li></ul></li><li>`preview`: (Optional) Boolean, whether to generate a preview image. This parameter is valid only when `type` is `"dynamic"`.<ul><li>`true`: Generate a preview image.</li><li>`false`: (Default) Do not generate a preview image.</li></ul><li>`scale`: (Optional) Number, the scale factor. The range is [0.1,3.0], and the default value is 1.2. This parameter is valid only when `type` is `"static"`.</li><li>`outputFormat`: (Optional) String, the format of theoutput picture. You can set this parameter as `"png"`, `"jpg"`, `"jpeg"`, or `"webp"`. The default value is `"png"`. This parameter is valid only when `type` is `"static"`.</li> |

### Request example

**Request URL**

```html
// Upload a public resource with the ID of class_file_1 to test_class
https://api.agora.io/edu/apps/{your_app_Id}/v1/rooms/test_class/resources/class_file_1
```

**Request Body**

```json
{
    "resourceName": "class_file",
    "size": 1024,
    "ext":"ppt",
    "url":"https://xxx.com",
    "conversion": {
        "type":"static",
        "preview": false,
        "scale": 1.2,
        "outputFormat": ""
    },
}
```

### Response parameters

| Parameter | Category | Description |
| :----- | :---------- | :----------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data` | Object Array | An array of republic resources. Each object represents a public resource and contains the following fields:<li>`resourceUuid`: String. The resource ID. This is the unique identifier of a file.</li><li>`resourceName`: String, the resource name for display in the classroom.</li> <li>`ext`: String, the resource extension.</li><li>`size`: Number, the resource size (bytes).</li><li>`url`: String, the URL address of the resource.</li><li>`updateTime`: Number, the update time of the resource, Unix timestamp (in milliseconds), UTC time.</li><li>`convert`: Boolean, whether to enable file conversion.</li><li>`taskUuid`: String, the ID of the file conversion task.</li><li>`taskToken`: String, the token used by the file conversion task.</li><li>`taskProgress`: Object, the progress of the file conversion task, including the following fields:<ul> <li>`totalPageSize`: Number, the total number of pages in the file.</li><li>`convertedPageSize`: Number, the number of pages that have been converted.</li> <li>`convertedPercentage`: Number, the progress (percentage) of the conversion task.</li> <li>`convertedFileList`: Object array, the list of converted pages. Each object represents a converted page and contains the following fields:<ul><li>`name`: String. The page name.<li>`ppt`: Object, a PPT page, containing the following fields:<ul><li>`width`: Number, the page width (pixel).<li>`height`: Number type field. The height of the page, the unit is pixel.<li>`src`: String, the URL address of the converted page.<li>`preview`: String, the URL address of the` preview image. This field is only available when the type` is set as `"dynamic"` and `preview` is set as` true`.</ul></ul><li>`currentStep`: The` current step of the conversion task. This field is only available when the type` is `"dynamic"`. This field can be `"Extracting"`, `"Packaging"`, `"GeneratingPreview"`, or `"MediaTranscode"`.</ul> |

### Response example

```json
{
    "msg":"Success",
    "code":0,
    "ts":1610433913533,
    "data":{
        "resourceUuid": "class_file_1",
        "resourceName": "class_file",
        "ext": "ppt",
        "size": 1024,
        "url": "https://xxx.com",
        "updateTime": 0,
        "convert": true,
        "taskUuid":"",
        "taskToken":"",
        "taskProgress": {
            "totalPageSize": 10,
            "convertedPageSize": 3,
            "convertedPercentage": 30,
            "convertedFileList": [{
                "name": 1,
                "ppt":{
                    "width": 1024,
                    "height": 960,
                    "src": "xxxx://xxxx.xxx.xx/xxxx.xxx",
                    "preview": "xxxx://xxxx.xxx.xx/xxxx.xxx",
                }
            },{...}],
            "currentStep": "Extracting"
        }
    }
}
```

## Delete public resources

### Description

Delete one or multiple public resources in the specified classroom.

### Prototype

- Method: DELETE
- Endpoint: /edu/apps/{appId}/v1/rooms/{roomUuid}/resources

### Request parameters

**URL parameters**

Pass the following parameters in the URL.

| Parameter | Category | Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `appId` | String | (Required) The Agora App ID, see[ Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z.</li><li>All numeric characters.</li><li>0-9</li><li>The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |

**Request body parameters**

Pass in the following parameters in the request body.

| Parameter | Category | Description |
| :------------- | :---------- | :----------------------------------------------------------- |
| `resourceUuid`, | String array | (Required) An array of resource IDs. The resource ID is the unique identifier of a resource. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z.</li><li>All numeric characters.</li><li>0-9</li><li>The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |

### Request example

**Request URL**

```html
https://api.agora.io/edu/apps/{your_app_Id}/v1/rooms/test_class/resources
```

**Request Body**

```json
{
    "resourceUuid": ["uuid1","uuid2"]
}
```

### Response parameters

| Parameter | Category | Description |
| :----- | :------ | :------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |

### Response example

```json
{
    "msg":"Success",
    "code":0,
    "ts":1610433913533
}
```

## Get public resources

### Description

Get all public resources in the specified classroom.

### Prototype

- Method: GET
- Endpoint: /edu/apps/{appId}/v1/rooms/{roomUuid}/resources

### Request parameters

**URL parameters**

Pass the following parameters in the URL.

| Parameter | Category | Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `appId` | String | (Required) The Agora App ID, see[ Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z.</li><li>All numeric characters.</li><li>0-9</li><li>The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |

### Request example

**Request URL**

```html
// Get the public resource with the ID of class_file_1 in test_class
https://api.agora.io/edu/apps/{your_app_Id}/v1/rooms/test_class/resources
```

### Response parameters

| Parameter | Category | Description |
| :----- | :---------- | :----------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data` | Object Array | An array of republic resources. Each object represents a public resource and contains the following fields:<li>`resourceUuid`: String. The resource ID. This is the unique identifier of a file.</li><li>`resourceName`: String, the resource name for display in the classroom.</li> <li>`ext`: String, the resource extension.</li><li>`size`: Number, the resource size (bytes).</li><li>`url`: String, the URL address of the resource.</li><li>`updateTime`: Number, the update time of the resource, Unix timestamp (in milliseconds), UTC time.</li><li>`convert`: Boolean, whether to enable file conversion.</li><li>`taskUuid`: String, the ID of the file conversion task.</li><li>`taskToken`: String, the token used by the file conversion task.</li><li>`taskProgress`: Object, the progress of the file conversion task, including the following fields:<ul> <li>`totalPageSize`: Number, the total number of pages in the file.</li><li>`convertedPageSize`: Number, the number of pages that have been converted.</li> <li>`convertedPercentage`: Number, the progress (percentage) of the conversion task.</li> <li>`convertedFileList`: Object array, the list of converted pages. Each object represents a converted page and contains the following fields:<ul><li>`name`: String. The page name.<li>`ppt`: Object, a PPT page, containing the following fields:<ul><li>`width`: Number, the page width (pixel).<li>`height`: Number type field. The height of the page, the unit is pixel.<li>`src`: String, the URL address of the converted page.<li>`preview`: String, the URL address of the` preview image. This field is only available when the type` is set as `"dynamic"` and `preview` is set as` true`.</ul></ul><li>`currentStep`: The` current step of the conversion task. This field is only available when the type` is `"dynamic"`. This field can be `"Extracting"`, `"Packaging"`, `"GeneratingPreview"`, or `"MediaTranscode"`.</ul> |

### Response example

```json
{
    "msg":"Success",
    "code":0,
    "ts":1610433913533,
    "data": {
        "resourceUuid": "",
        "resourceName": "",
        "ext": "",
        "size": 0,
        "url": "",
        "updateTime": 0,
        "convert": true,
        "taskUuid":"",
        "taskToken":"",
        "taskProgress": {
            "totalPageSize": 10,
            "convertedPageSize": 3,
            "convertedPercentage": 30,
            "convertedFileList": [{
                "name": 1,
                "ppt":{
                    "width": 1024,
                    "height": 960,
                    "src": "xxxx://xxxx.xxx.xx/xxxx.xxx",
                    "preview": "xxxx://xxxx.xxx.xx/xxxx.xxx",
                }
            },{...}],
            "currentStep": "Extracting"
        }
    }]
}
```

## Query a specified event

### Description

Query a specified type of event in a specified classroom.

You can fetch data in batches with the `nextId` parameter. You can get up to 100 pieces of data for each batch.

<div class="note info"><li>You can query the same event repeatedly.</li><li> You cannot query events in a destroyed classroom. A classroom is destroyed automatically one hour after it is ended.</li>

### Prototype

- Method: GET
- Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/sequences

### Request parameters

**URL parameters**

Pass the following parameters in the URL.

| Parameter | Category | Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `appId` | String | (Required) The Agora App ID, see[ Get the Agora App ID](https://docs.agora.io/cn/agora-class/agora_class_prep#step1). |
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z.</li><li>All numeric characters.</li><li>0-9</li><li>The space character.</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ","</li> |

**Query parameters**

| Parameter | Category | Description |
| :------- | :------ | :----------------------------------------------------------- |
| `nextId` | String | (Optional) The starting ID of the next batch of data. When you call this method to get the data for the first time, leave this parameter empty or set it as null. Afterward, you can set this parameter as the nextId that you get in the response of the previous method ``call. |
| `cmd` | Integer | (Optional) Event type. For details, see Flexible [Classroom Cloud Service Events](https://docs.agora.io/cn/agora-class/agora_class_restful_api_event). |

### Request example

**Request URL**

```html
// Get the event of classroom state update in test_class
https://api.agora.io/edu/apps/{appId}/v2/rooms/test_class/sequences?nextId=50&cmd=1
```

### Response parameters

| Parameter | Category | Description |
| :----- | :------ | :----------------------------------------------------------- |
| `code` | Integer | Business status code: 0: The request succeeds. Non-zero: The request fails. |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data` | Object | Include the following parameters:<ul><li>`total`: Integer, the total number of pieces of data.</li><li>`count`: Integer, the number of pieces of data in this batch.</li><li>`list`: JSONArray. An array of the recording list. A JSON object includes the following parameters:<ul><li>`roomUuid`: String, the classroom ID.</li><li>`cmd`: Integer, the event type. See [Flexible Classroom Events](https://docs.agora.io/cn/agora-class/agora_class_restful_api_event).</li><li>`sequence`: Integer. The event ID. This is the unique identifier of an event, which is automatically generated to ensure the order of events.</li><li>`version`: Integer, the service version.</li><li>`data`: Object, the detailed data of the event, The data varies depending on the event type. See [Flexible Classroom Events](https://docs.agora.io/cn/agora-class/agora_class_restful_api_event).</li></ul><li>`nextId`: String, the starting ID of the next batch of data. If it is null, there is no next batch of data. If it is not null, use this `nextId` to continue the query until null is reported.</li></ul> |

### Response example

```json
{
    "msg":"Success",
    "code":0,
    "ts":1610433913533,
    "data":{
        "total":1,
        "list":[
            {
                "roomUuid": "",
                "cmd": 20,
                "sequence": 1,
                "version": 1,
                "data":{}
            }
        ],
        "nextId": null,
        "count":1
    }
}
```

## Get classroom events

### Description

Get all events in the classrooms associated with a specified App ID.

You can call this method at regular intervals to listen for all the events that occur in the flexible classrooms.

<div class="alert note"><li>Each event can only be obtained once.</li><li>Note: You cannot get events one hour after a classroom is destroyed.</li></div>

### Prototype

- Method: GET
- Endpoint: /edu/polling/apps/{appId}/v2/rooms/sequences

### Request parameters

**URL parameters**

Pass the following parameter in the URL.

| Parameter | Category | Description |
| :------ | :----- | :----------------------------------------------------------- |
| `appId` | String | (Required) The Agora App ID, see[ Get the Agora App ID](./agora_class_prep#step1). |

### Request example

```html
https://api.agora.io/edu/polling/apps/{yourappId}/v2/rooms/sequences
```

### Response parameters

| Parameter | Category | Description |
| :----- | :------ | :----------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.<li>Non-zero: The request fails. |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data` | Object | Include the following parameters:<li>`roomUuid`: String, the classroom ID.<li>`cmd`: Integer, the event type. See [Flexible Classroom Events](./agora_class_restful_api_event).<li>`sequence`: Integer. The event ID. This is the unique identifier of an event, which is automatically generated to ensure the order of events.<li>`version`: Integer, the service version.<li>`data`: Object, the detailed data of the event, The data varies depending on the event type. See [Flexible Classroom Events](./agora_class_restful_api_event). |

### Response example

```json
"status": 200,
"body":
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309,
    "data":[
        {
            "roomUuid": "xxxxxx",
            "cmd": 20,
            "sequence": 1,
            "version": 1,
            "data":{}
        }
    ]
}
```

## Status code

| Response status code | Business status code | Description |
| :-------------- | :--------- | :----------------------------------------------------------- |
| 200 | 0 | The request succeeds. |
| 400 | 400 | The request parameter is incorrect. |
| 401 | N/A | Possible reasons:<li>The App ID is invalid.<li>Unauthorized. Incorrect `x-agora-uid` or `x-agora-token`. |
| 403 | 30403200 | The classroom is muted globally. Users cannot send chat messages. |
| 404 | N/A | The server cannot find the requested resource. |
| 404 | 20404100 | The classroom does not exist. |
| 404 | 20404200 | The user does not exist. |
| 409 | 30409410 | The recording has not been started. |
| 409 | 30409411 | The recording has not been ended. |
| 409 | 30409100 | The class has been started. |
| 409 | 30409101 | The class has been ended. |
| 500 | 500 | The server has an internal error and cannot process the request. |
| 503 | N/A | Internal server error. The gateway or proxy server does not receive a timely response from the upstream server. |