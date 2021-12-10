This page provides detailed help for the Flexible Classroom RESTful APIs.

## Basic information

### Server

All requests are sent to the host: api.agora.io.

### Data format

The Content-Type of all requests is application/json.

### Authentication

Flexible Classroom Cloud Service uses tokens for authentication. You need to put the following information to the `x-agora-token` and `x-agora-uid` fields when sending your HTTP request:

- The RTM Token generated at your server.
- The uid you use to generate the RTM Token.

For details, see [Generate an RTM Token](/en/Real-time-Messaging/token_server_rtm).

## Kick a user out of a classroom

#### Description

Call this method to kick a specified user out of a classroom. After a successful method call, the server triggers an event indicating a user leaves the classroom. You can use the `dirty` parameter to determine whether the user can enter the classroom afterwards.

#### Prototype

- Method: POST
- Endpoint: /{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/users/{userUuid}/exit

#### Request parameters

**URL parameters**

Pass the following parameters in the URL.

| Parameter | Type | Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `region` | String | (Required) The region for connection. For details, see [Network geofencing](/en/agora-class/agora_class_security#network-geofencing). Flexible Classroom supports the following regions:<li>`cn`: Mainland China.</li><li>`ap`: Asia Pacific.</li><li>`eu`: Europe.</li><li>`na`: North America.</li> |
| `appId` | String | (Required) Agora App ID.|
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |
| `userUuid` | String | (Required) The user ID. This is the unique identifier of the user and also the user ID used when logging in to the Agora RTM system. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |

**Request body parameters**

Pass in the following parameters in the request body.

| Parameter | Type | Description |
| :------ | :----- | :----------------------------------------------------------- |
| `dirty` | Object | (Optional) The user privilege:<ul><li>`state`: Boolean, whether the user is dirty:<ul><li>`1`: Dirty. A dirty user cannot enter the classroom.</li><li>`0`: Not dirty.</li></ul><li>`duration`: Number, the duration of the dirty state (seconds), starting from the time when the user is kicked out of the classroom.</li></ul> |

#### Request example

**Request URL**

```html
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

#### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |

#### Response example

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## Set the classroom state

#### Description

Call this method to set the classroom state: Not started, Started, Ended. For details, see [What classroom states does Flexible Classroom support?](/en/agora-class/faq/agora_class_state)

#### Prototype

- Method: PUT
- Endpoint: /{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/states/{state}

#### Request parameters

**URL parameters**

Pass the following parameter in the URL.

| Parameter | Type | Description |
| :--------- | :------ | :----------------------------------------------------------- |
| `region` | String | (Required) The region for connection. For details, see [Network geofencing](/en/agora-class/agora_class_security#network-geofencing). Flexible Classroom supports the following regions:<li>`cn`: Mainland China.</li><li>`ap`: Asia Pacific.</li><li>`eu`: Europe.</li><li>`na`: North America.</li> |
| `appId` | String | (Required) Agora App ID. |
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |
| `state` | Integer | (Required) The classroom state:<li>`0`: Not started.</li><li>`1`: Started.</li><li>`2`: Ended.</li> |

#### Request example

```html
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/states/1
```

#### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :------------------------------------------------ |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |

#### Response example

```json
"status": 200,
"body":
{
  "code": 0,
  "msg": "Success",
  "ts": 1610450153520
}
```

## Set the recording state

#### Description

Call this method to start or stop recording a specified classroom.

#### Prototype

- Method: PUT
- Endpoint: /{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/records/states/{state}

#### Request parameters

**URL parameters**

Pass the following parameter in the URL.

| Parameter | Type | Description |
| :--------- | :------ | :----------------------------------------------------------- |
| `region` | String | (Required) The region for connection. For details, see [Network geofencing](/en/agora-class/agora_class_security#network-geofencing). Flexible Classroom supports the following regions:<li>`cn`: Mainland China.</li><li>`ap`: Asia Pacific.</li><li>`eu`: Europe.</li><li>`na`: North America.</li> |
| `appId` | String | (Required) Agora App ID.|
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |
| `state` | Integer | (Required) The recording state:<li>`0`: Stop recoding.</li><li>`1`: Started.</li> |

**Request body parameters**

Pass in the following parameters in the request body.

| Parameter | Type | Description |
| :---------------- | :----- | :----------------------------------------------------------- |
| `mode` | String | (Optional) The recording mode:<li>Set this parameter as `web` to enable [web page recording mode](/en/Agora%20Platform/webpage_recording).  The format of recorded files is MP4. When the length of the recorded file reaches around two hours, or when the size of the file exceeds around 2 GB, the recording service automatically creates another MP4 file.</li><li>If you do not set this parameter, Flexible Classroom records the audio and video of the teachers in [composite recording mode](/en/Agora%20Platform/composite_recording_mode) by default.  The format of recorded files is M3U8 and TS.</li> |
| `webRecordConfig` | Object | (Optional) When the `mode` is set as `web`, you need to set the detailed configuration of the web page recording through `webRecordConfig`, including the following fields:<ul><li>`url`: (Required) String, the address of the web page to record. If you want to record a certain flexible classroom, you need to pass in the parameters required for launching a classroom in the URL. The Agora Cloud Recording service can join the specified classroom as an "invisible user" for recording. See the URL example in the request example. The following parameters are required in the URL:<ul><li>`userUuid`: The user ID used by the Agora Cloud Recording service. Please ensure that the user ID used by the Agora Cloud Recording service is not the same as that of existing users in the classroom, otherwise, the Agora Cloud Recording service will fail to join the classroom.</li><li>`roomUuid`: The ID of the classroom to be recorded.</li><li>`roomType`: The type of the classroom to be recorded.</li><li>`roleType`: The role of the Agora Cloud Recording service in the classroom to be recorded. Set this parameter as 0.</li><li>`pretest`: Whether to enable the pre-class test. Set this parameter as `false`.</li><li>`rtmToken`: The RTM Token used by the Agora Cloud Recording service.</li><li>`language`: The language of the user interface. Set this parameter as `zh` or `en`.</li><li>`appId`: Your Agora App ID.</li></ul></li><li>`rootUrl`: (Required) String, the root address of the web page to be recorded. During the recording, Agora Edu Cloud Service automatically gets the full address of the web page to be recorded by putting `rootUrl`, `roomUuid`, `roomType`,and other parameters together. If you set both `url` and `rootUrl`, `url` overrides `rootUrl`.</li><li>`onHold`: (Required) Boolean. You can set this parameter as:<ul><li>`true`: Pauses recording immediately after the web page recording task is enabled. The recording service opens and renders the web page to be recorded, but does not generate a slice file.</li><li>`false`: (Default) Enables the web page recording task and starts recording.</li></ul></li><li>`videoBitrate`: (Optional) Number. The bitrate of the video (Kbps). The value range is [50, 8000]. The default value of `videoBitrate` varies according to the resolution of the output video:<ul><li>If the resolution of the output video is less than 1280 × 720, the default value of `videoBitrate` is 1500. </li><li>If the resolution of the output video is greater than or equal to 1280 × 720, the default value of `videoBitrate` is 2000.</li></ul></li><li>`videoFps`: (Optional) Number. The frame rate of the video (fps). The value range is [5, 60]. The default value is 15.</li><li>`audioProfile`: (Optional) Number. The sample rate, encoding mode, number of audio channels, and bitrate.<ul><li>0: (Default) Sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 48 Kbps.</li><li>1: Sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 128 Kbps.</li><li>2: Sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 192 Kbps.</li></ul></li><li>`videoWidth`: Number. The width of the video (pixels). The value range is [480, 1280]. The default value is 1280. The product of `videoWidth` and `videoHeight` should not exceed 921,600 (1280 × 720).</li><li>`videoHeight`: Number. The height of the video (pixels). The value range is [480, 1280]. The default value is 720. The product of `videoWidth` and `videoHeight` should not exceed 921,600 (1280 × 720).</li><li>`maxRecordingHour`: Number, the maximum recording length (hours). The value range is [1,720]. If you set the class duration, Agora Edu Cloud Service gets the maximum recording length by rounding up the class duration. For example, if the class duration is 1800 seconds, `maxRecordingHour` is one hour. If you do not set the class duration, the default value of `maxRecordingHour` is two hours. If the limit set by `maxRecordingHour` is exceeded, the recording stops automatically.</li></ul> |
| `retryTimeout` | Number | The amount of time (seconds) that the Flexible Classroom cloud service waits between tries. The Flexible Classroom cloud service reties twice at most. |

#### Request example

**Request URL**

```html
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records/states/1
```

**Request Body**

```json
{
    "mode": "web",
    "webRecordConfig": {
        "url":"https://webdemo.agora.io/xxxxx/?userUuid={recorder_id}&roomUuid={room_id_to_be_recorded}&roleType=0&roomType=4&pretest=false&rtmToken={recorder_token}&language=en&appId={your_app_id}",
        "rootUrl":"https://xxx.yyy.zzz"
    },
    "retryTimeout": 60
}
```

#### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :------------------------------------------------ |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |

#### Response example

```json
"status": 200,
"body":
{
    "code": 0,
    "ts": 1610450153520
}
```

## Update the recording configurations

#### Description

Call this method during the recording to update the recording configurations. Every time this method is called, the previous configurations are overwritten.

#### Prototype

- Method: PATCH
- Endpoint: /{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/records/states/{state}

#### Request parameters

**URL parameters**

Pass the following parameter in the URL.

| Parameter | Type | Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `region` | String | (Required) The region for connection. For details, see [Network geofencing](/en/agora-class/agora_class_security#network-geofencing). Flexible Classroom supports the following regions:<li>`cn`: Mainland China.</li><li>`ap`: Asia Pacific.</li><li>`eu`: Europe.</li><li>`na`: North America.</li> |
| `appId` | String | (Required) Agora App ID. |
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |

**Request body parameters**

Pass in the following parameters in the request body.

| Parameter | Type | Description |
| :---------------- | :----- | :----------------------------------------------------------- |
| `webRecordConfig` | Object | (Optional) Recording configurations:<ul><li>`onHold`: (Required) Boolean. You can set this parameter as:<ul><li>`true`: Pauses the web page recording. The recording service no longer generates any slice file.</li><li>`false`: (Default) Continues the web page recording. After the recording is paused, you can call this method and set the `onHold` parameter as `false` to continue the web page recording.</li></ul></li></ul> |

#### Request example

**Request URL**

```html
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records/states/1
```

**Request Body**

```json
{
    "webRecordConfig": {
        "onHold": false
    }
}
```

#### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |

#### Response example

```json
"status": 200,
"body":
{
    "code": 0,
    "ts": 1610450153520
}
```

## Get the recording list

#### Description

Get the recording list in a specified classroom.

You can fetch data in batches with the `nextId` parameter. You can get up to 100 pieces of data for each batch.

#### Prototype

- Method: GET
- Endpoint: /{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/records

#### Request parameters

**URL parameters**

Pass the following parameter in the URL.

| Parameter | Type | Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `region` | String | (Required) The region for connection. For details, see [Network geofencing](/en/agora-class/agora_class_security#network-geofencing). Flexible Classroom supports the following regions:<li>`cn`: Mainland China.</li><li>`ap`: Asia Pacific.</li><li>`eu`: Europe.</li><li>`na`: North America.</li> |
| `appId` | String | (Required) Agora App ID.|
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |

**Query parameters**

| Parameter | Type | Description |
| :------- | :----- | :----------------------------------------------------------- |
| `nextId` | String | (Optional) The starting ID of the next batch of data. When you call this method to get the data for the first time, leave this parameter empty or set it as null. Afterward, you can set this parameter as the `nextId` that you get in the response of the previous method call. |

#### Request example

Example one:

```html
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records?null
```

Example two:

```html
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records?nextId=xxx
```

#### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :----------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data` | Object | Include the following parameters:<ul><li>`count`: Integer, the number of pieces of data in this batch.</li><li>`list`: JSONArray. An array of the recording list. A JSON object includes the following parameters:<ul><li>`appId`: Your Agora App ID.</li><li>`roomUuid`: The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel.</li><li>`recordId`: The unique identifier of a recording session. A recording session starts when you call a method to start recording and ends when you call this method to stop recording.</li><li>`startTime`: The UTC timestamp when a recording session starts, in milliseconds.</li><li>`endTime`: The UTC timestamp when a recording session ends, in milliseconds.</li><li>`resourceId`: The `resourceId` of the Agora Cloud Recording service.</li><li>`sid`: The `sid` of the Agora Cloud Recording service.</li><li>`recordUid`: The UID used by the Agora Cloud Recording service in the channel.</li><li>`boardAppId`: The App Identifier of the Agora Interactive Whiteboard service.</li><li>` boardToken`: The SDK Token of the Agora Interactive Whiteboard service.</li><li>`boardId`: The unique identifier of a whiteboard session.</li><li>`type`: Integer, the recording type:<ul><li>`1`: Individual Recording</li><li>`2`: Composite Recording</li></ul></li><li>`status`: Integer, the recording state:<ul><li>`1`: In recording.</li><li>`2`: Recording has ended.</li></ul></li><li>`url`: String, the URL address of the recorded files in composite recording mode.</li><li>`recordDetails`: JSONArray. The JSON object contains the following fields:<ul><li>`url`: String, the URL address of the recorded files in web page recording mode.</li></ul></li><li>`nextId`: String, the starting ID of the next batch of data. If it is null, there is no next batch of data. If it is not null, use this `nextId` to continue the query until null is reported.</li><li>`total`: Integer, the total number of pieces of data.</li></ul></li></ul> |

#### Response example

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
}
```

## Upload a public resource

#### Description

Call this method to upload a public resource to the specified classroom. All users in the classroom can see these public resources.

#### Prototype

- Method: PUT
- Endpoint: /{region}/edu/apps/{appId}/v1/rooms/{roomUuid}/resources/{resourceUuid}

#### Request parameters

**URL parameters**

Pass the following parameters in the URL.

| Parameter | Type | Description |
| :------------- | :----- | :----------------------------------------------------------- |
| `region` | String | (Required) The region for connection. For details, see [Network geofencing](/en/agora-class/agora_class_security#network-geofencing). Flexible Classroom supports the following regions:<li>`cn`: Mainland China.</li><li>`ap`: Asia Pacific.</li><li>`eu`: Europe.</li><li>`na`: North America.</li> |
| `appId` | String | (Required) Agora App ID.|
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |
| `resourceUuid` | String | (Required) The resource ID. This is the unique identifier of a file. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |

**Request body parameters**

Pass in the following parameters in the request body.

| Parameter | Type | Description |
| :------------- | :----- | :----------------------------------------------------------- |
| `resourceName` | String | The resource name for display in the classroom. The string length must be less than 64 bytes. |
| `size` | Number | (Required) The size (bytes) of the resource. |
| `ext` | String | (Required) The resource extension:<ul><li>`"ppt"`</li><li>`"pptx"`</li><li>`"pptm"`</li><li>`"docx"`</li><li>`"doc"`</li><li>`"xlsx"`</li><li>`"xls"`</li><li>`"csv"`</li><li>`"pdf"`</li></ul> |
| `url` | String | (Required) The URL address of the resource, such as `"https://xxx.com"`. |
| `conversion` | Object | (Optional) If you want to display resources such as a PPT on the whiteboard in the classroom, you need to set `conversion` to convert the resource into a static image or a dynamic HTML page. `conversion` contains the following fields:<ul><li>`type`: (Required) String, the conversion type:<ul><li>`"static"`: Convert the file to a static picture. If the file extension is `"ppt"`, `"doc"`, `"docx"`, or `"pdf"`, you can enable static conversion.</li><li> `"dynamic"`: Convert the file to a dynamic HTML page. When the extension is `"pptx"`, you can enable the dynamic conversion.</li></ul></li><li>`preview`: (Optional) Boolean, whether to generate a preview image. This parameter is valid only when `type` is `"dynamic"`.<ul><li>`true`: Generate a preview image.</li><li>`false`: (Default) Do not generate a preview image.</li></ul></li><li>`scale`: (Optional) Number, the scale factor. The range is [0.1,3.0], and the default value is 1.2. This parameter is valid only when `type` is `"static"`.</li><li>`outputFormat`: (Optional) String, the format of theoutput picture. You can set this parameter as `"png"`, `"jpg"`, `"jpeg"`, or `"webp"`. The default value is `"png"`. This parameter is valid only when `type` is `"static"`.</li></ul> |

#### Request example

**Request URL**

```html
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

#### Response parameters

| Parameter | Type | Description |
| :----- | :---------- | :----------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data` | Object Array | An array of republic resources. Each object represents a public resource and contains the following fields:<ul><li>`resourceUuid`: String. The resource ID. This is the unique identifier of a file.</li><li>`resourceName`: String, the resource name for display in the classroom.</li><li>`ext`: String, the resource extension.</li><li>`size`: Number, the resource size (bytes).</li><li>`url`: String, the URL address of the resource.</li><li>`updateTime`: Number, the update time of the resource, Unix timestamp (in milliseconds), UTC time.</li><li>`convert`: Boolean, whether to enable file conversion.</li><li>`taskUuid`: String, the ID of the file conversion task.</li><li>`taskToken`: String, the token used by the file conversion task.</li><li>`taskProgress`: Object, the progress of the file conversion task, including the following fields:<ul> <li>`totalPageSize`: Number, the total number of pages in the file.</li><li>`convertedPageSize`: Number, the number of pages that have been converted.</li> <li>`convertedPercentage`: Number, the progress (percentage) of the conversion task.</li> <li>`convertedFileList`: Object array, the list of converted pages. Each object represents a converted page and contains the following fields:<ul><li>`name`: String. The page name.</li><li>`ppt`: Object, a PPT page, containing the following fields:<ul><li>`width`: Number, the page width (pixel).</li><li>`height`: Number. The page height (pixel).</li><li>`src`: String, the URL address of the converted page.</li><li>`preview`: String, the URL address of the preview image. This field is only available when the `type` is set as `"dynamic"` and `preview` is set as `true`.</li></ul></li><li>`currentStep`: The current step of the conversion task. This field is only available when the `type` is `"dynamic"`. This field can be `"Extracting"`, `"Packaging"`, `"GeneratingPreview"`, or `"MediaTranscode"`.</li></ul></li></ul></li></ul> |

#### Response example

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

#### Description

Delete one or multiple public resources in the specified classroom.

#### Prototype

- Method: DELETE
- Endpoint: /{region}/edu/apps/{appId}/v1/rooms/{roomUuid}/resources

#### Request parameters

**URL parameters**

Pass the following parameters in the URL.

| Parameter | Type | Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `region` | String | (Required) The region for connection. For details, see [Network geofencing](/en/agora-class/agora_class_security#network-geofencing). Flexible Classroom supports the following regions:<li>`cn`: Mainland China.</li><li>`ap`: Asia Pacific.</li><li>`eu`: Europe.</li><li>`na`: North America.</li> |
| `appId` | String | (Required) Agora App ID.|
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |

**Request body parameters**

Pass in the following parameters in the request body.

| Parameter | Type | Description |
| :-------------- | :---------- | :----------------------------------------------------------- |
| `resourceUuids` | String array | (Required) An array of resource IDs. The resource ID is the unique identifier of a resource. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |

#### Request example

**Request URL**

```html
https://api.agora.io/edu/apps/{your_app_Id}/v1/rooms/test_class/resources
```

**Request Body**

```json
{
    "resourceUuids": ["uuid1","uuid2"]
}
```

#### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |

#### Response example

```json
{
    "msg":"Success",
    "code":0,
    "ts":1610433913533
}
```

## Get public resources

#### Description

Get all public resources in the specified classroom.

#### Prototype

- Method: GET
- Endpoint: /{region}/edu/apps/{appId}/v1/rooms/{roomUuid}/resources

#### Request parameters

**URL parameters**

Pass the following parameters in the URL.

| Parameter | Type | Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `region` | String | (Required) The region for connection. For details, see [Network geofencing](/en/agora-class/agora_class_security#network-geofencing). Flexible Classroom supports the following regions:<li>`cn`: Mainland China.</li><li>`ap`: Asia Pacific.</li><li>`eu`: Europe.</li><li>`na`: North America.</li> |
| `appId` | String | (Required) Agora App ID.|
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |

#### Request example

**Request URL**

```html
https://api.agora.io/edu/apps/{your_app_Id}/v1/rooms/test_class/resources
```

#### Response parameters

| Parameter | Type | Description |
| :----- | :---------- | :----------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data` | Object Array | An array of republic resources. Each object represents a public resource and contains the following fields:<ul><li>`resourceUuid`: String. The resource ID. This is the unique identifier of a file.</li><li>`resourceName`: String, the resource name for display in the classroom.</li><li>`ext`: String, the resource extension.</li><li>`size`: Number, the resource size (bytes).</li><li>`url`: String, the URL address of the resource.</li><li>`updateTime`: Number, the update time of the resource, Unix timestamp (in milliseconds), UTC time.</li><li>`convert`: Boolean, whether to enable file conversion.</li><li>`taskUuid`: String, the ID of the file conversion task.</li><li>`taskToken`: String, the token used by the file conversion task.</li><li>`taskProgress`: Object, the progress of the file conversion task, including the following fields:<ul><li>`totalPageSize`: Number, the total number of pages in the file.</li><li>`convertedPageSize`: Number, the number of pages that have been converted.</li><li>`convertedPercentage`: Number, the progress (percentage) of the conversion task.</li><li>`convertedFileList`: Object array, the list of converted pages. Each object represents a converted page and contains the following fields:<ul><li>`name`: String. The page name.</li><li>`ppt`: Object, a PPT page, containing the following fields:<ul><li>`width`: Number, the page width (pixel).</li><li>`height`: Number. The page height (pixel).</li><li>`src`: String, the URL address of the converted page.</li><li>`preview`: String, the URL address of the preview image. This field is only available when the `type` is set as `"dynamic"` and `preview` is set as `true`.</li></ul></li></ul></li><li>`currentStep`: The current step of the conversion task. This field is only available when the `type` is `"dynamic"`. This field can be `"Extracting"`, `"Packaging"`, `"GeneratingPreview"`, or `"MediaTranscode"`.</li></ul></li></ul> |

#### Response example

```json
{
    "msg":"Success",
    "code":0,
    "ts":1610433913533,
    "data":[{
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

#### Description

Query a specified type of event in a specified classroom.

You can fetch data in batches with the `nextId` parameter. You can get up to 100 pieces of data for each batch.

<div class="note info"><li>You can query the same event repeatedly.</li><li> You cannot query events in a destroyed classroom. A classroom is destroyed automatically one hour after it is ended.</li></div>

#### Prototype

- Method: GET
- Endpoint: /{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/sequences

#### Request parameters

**URL parameters**

Pass the following parameters in the URL.

| Parameter | Type | Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `region` | String | (Required) The region for connection. For details, see [Network geofencing](/en/agora-class/agora_class_security#network-geofencing). Flexible Classroom supports the following regions:<li>`cn`: Mainland China.</li><li>`ap`: Asia Pacific.</li><li>`eu`: Europe.</li><li>`na`: North America.</li> |
| `appId` | String | (Required) Agora App ID.|
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |

**Query parameters**

| Parameter | Type | Description |
| :------- | :------ | :----------------------------------------------------------- |
| `nextId` | String | (Optional) The starting ID of the next batch of data. When you call this method to get the data for the first time, leave this parameter empty or set it as null. Afterward, you can set this parameter as the `nextId` that you get in the response of the previous method call. |
| `cmd` | Integer | (Optional) Event type. For details, see [Flexible Classroom Cloud Service Events](/en/agora-class/agora_class_restful_api_event). |

#### Request example

**Request URL**

Example one:

```html
https://api.agora.io/edu/apps/{appId}/v2/rooms/test_class/sequences?null&cmd=1
```

Example two:

```html
https://api.agora.io/edu/apps/{appId}/v2/rooms/test_class/sequences?nextId=50&cmd=1
```

#### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :----------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data` | Object | Include the following parameters:<ul><li>`total`: Integer, the total number of pieces of data.</li><li>`count`: Integer, the number of pieces of data in this batch.</li><li>`list`: JSONArray. An array of the recording list. A JSON object includes the following parameters:<ul><li>`roomUuid`: String, the classroom ID.</li><li>`cmd`: Integer, the event type. For details, see [Flexible Classroom Cloud Service Events](/en/agora-class/agora_class_restful_api_event).</li><li>`sequence`: Integer. The event ID. This is the unique identifier of an event, which is automatically generated to ensure the order of events.</li><li>`version`: Integer, the service version.</li><li>`data`: Object, the detailed data of the event. The data varies depending on the event type. For details, see [Flexible Classroom Cloud Service Events](/en/agora-class/agora_class_restful_api_event).</li></ul><li>`nextId`: String, the starting ID of the next batch of data. If it is null, there is no next batch of data. If it is not null, use this `nextId` to continue the query until null is reported.</li></ul> |

#### Response example

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

#### Description

Get all events in the classrooms associated with a specified App ID.

You can call this method at regular intervals to listen for all the events that occur in the flexible classrooms.

<div class="alert note"><li>Each event can only be obtained once.</li><li>Note: You cannot get events one hour after a classroom is destroyed.</li></div>

#### Prototype

- Method: GET
- Endpoint: /{region}/edu/polling/apps/{appId}/v2/rooms/sequences

#### Request parameters

**URL parameters**

Pass the following parameter in the URL.

| Parameter | Type | Description |
| :------ | :----- | :--------------------- |
| `region` | String | (Required) The region for connection. For details, see [Network geofencing](/en/agora-class/agora_class_security#network-geofencing). Flexible Classroom supports the following regions:<li>`cn`: Mainland China.</li><li>`ap`: Asia Pacific.</li><li>`eu`: Europe.</li><li>`na`: North America.</li> |
| `appId` | String | (Required) Agora App ID.|

#### Request example

```html
https://api.agora.io/edu/polling/apps/{yourappId}/v2/rooms/sequences
```

#### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :----------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data` | Object | Include the following parameters:<li>`roomUuid`: String, the classroom ID.</li><li>`cmd`: Integer, the event type. For details, see [Flexible Classroom Cloud Service Events](/en/agora-class/agora_class_restful_api_event).</li><li>`sequence`: Integer. The event ID. This is the unique identifier of an event, which is automatically generated to ensure the order of events.<li>`version`: Integer, the service version.</li><li>`data`: Object, the detailed data of the event. The data varies depending on the event type. For details, see [Flexible Classroom Cloud Service Events](/en/agora-class/agora_class_restful_api_event).</li> |

#### Response example

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

## Update custom classroom properties

#### Description

Add or update the custom properties of a specified classroom. For details, see [How can I set user properties and classroom properties? ](/en/agora-class/faq/agora_class_custom_properties)

#### Prototype

- Method: PUT
- Endpoint: /{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/properties

#### Request parameters

**URL parameters**

Pass the following parameters in the URL.

| Parameter | Type | Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `region` | String | (Required) The region for connection. For details, see [Network geofencing](/en/agora-class/agora_class_security#network-geofencing). Flexible Classroom supports the following regions:<li>`cn`: Mainland China.</li><li>`ap`: Asia Pacific.</li><li>`eu`: Europe.</li><li>`na`: North America.</li> |
| `appId` | String | (Required) Agora App ID.|
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |

**Request body parameters**

Pass in the following parameters in the request body.

| Parameter | Type | Description |
| :----------- | :----- | :--------- |
| `properties` | Object | Classroom properties. |
| `cause` | Object | The update reason. |

#### Request example

**Request Body**

```json
{
    "properties" :{
        "key1":"value1",
        "key2":"value2"
    },
    "cause":{}
}
```

#### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |

#### Response example

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## Delete custom classroom properties

#### Description

Delete the custom properties of a specified classroom. For details, see [How can I set user properties and classroom properties? ](/en/agora-class/faq/agora_class_custom_properties)

#### Prototype

- Method: DELETE
- Endpoint: /{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/properties

#### Request parameters

**URL parameters**

Pass the following parameters in the URL.

| Parameter | Type | Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `region` | String | (Required) The region for connection. For details, see [Network geofencing](/en/agora-class/agora_class_security#network-geofencing). Flexible Classroom supports the following regions:<li>`cn`: Mainland China.</li><li>`ap`: Asia Pacific.</li><li>`eu`: Europe.</li><li>`na`: North America.</li> |
| `appId` | String | (Required) Agora App ID.|
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |

**Request body parameters**

Pass in the following parameters in the request body.

| Parameter | Type | Description |
| :----------- | :---------- | :--------- |
| `properties` | String array | Classroom properties. |
| `cause` | Object | Reason for deletion. |

#### Request example

**Request Body**

```json
{
    "properties" :[
        "key1",
        "key2"
    ],
    "cause":{}
}
```

#### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |

#### Response example

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## Update custom user properties

#### Description

Add or update the custom properties of a specified user. For details, see [How can I set user properties and classroom properties? ](/en/agora-class/faq/agora_class_custom_properties)

#### Prototype

- Method: PUT
- Endpoint: /{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/users/{userUuid}/properties

#### Request parameters

**URL parameters**

Pass the following parameters in the URL.

| Parameter | Type | Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `region` | String | (Required) The region for connection. For details, see [Network geofencing](/en/agora-class/agora_class_security#network-geofencing). Flexible Classroom supports the following regions:<li>`cn`: Mainland China.</li><li>`ap`: Asia Pacific.</li><li>`eu`: Europe.</li><li>`na`: North America.</li> |
| `appId` | String | (Required) Agora App ID.|
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |
| `userUuid` | String | (Required) The user ID. This is the unique identifier of the user and also the user ID used when logging in to the Agora RTM system. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |

**Request body parameters**

Pass in the following parameters in the request body.

| Parameter | Type | Description |
| :----------- | :----- | :--------- |
| `properties` | Object | The user properties. |
| `cause` | Object | The update reason. |

#### Request example

**Request Body**

```json
{
    "properties" :{
        "key1":"value1",
        "key2":"value2"
    },
    "cause":{}
}
```

#### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |

#### Response example

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## Delete custom user properties

#### Description

Delete the custom properties of a specified user. For details, see [How can I set user properties and classroom properties? ](/en/agora-class/faq/agora_class_custom_properties)

#### Prototype

- Method: DELETE
- Endpoint: /{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/users/{userUuid}/properties

#### Request parameters

**URL parameters**

Pass the following parameters in the URL.

| Parameter | Type | Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `region` | String | (Required) The region for connection. For details, see [Network geofencing](/en/agora-class/agora_class_security#network-geofencing). Flexible Classroom supports the following regions:<li>`cn`: Mainland China.</li><li>`ap`: Asia Pacific.</li><li>`eu`: Europe.</li><li>`na`: North America.</li> |
| `appId` | String | (Required) Agora App ID.|
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |
| `userUuid` | String | (Required) The user ID. This is the unique identifier of the user and also the user ID used when logging in to the Agora RTM system. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |

**Request body parameters**

Pass in the following parameters in the request body.

| Parameter | Type | Description |
| :----------- | :---------- | :--------- |
| `properties` | String array | The user properties. |
| `cause` | Object | Reason for deletion. |

#### Request example

**Request Body**

```json
{
    "properties" :[
        "key1",
        "key2"
    ],
    "cause":{}
}
```

#### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |

#### Response example

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## Set the extApp properties

#### Description

Add or update the properties of the extApp in a specified classroom.

#### Prototype

- Method: PUT
- Endpoint: /{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/extApps/{extAppUuid}/properties

#### Request parameters

**URL parameters**

Pass the following parameters in the URL.

| Parameter | Type | Description |
| :----------- | :----- | :----------------------------------------------------------- |
| `region` | String | (Required) The region for connection. For details, see [Network geofencing](/en/agora-class/agora_class_security#network-geofencing). Flexible Classroom supports the following regions:<li>`cn`: Mainland China.</li><li>`ap`: Asia Pacific.</li><li>`eu`: Europe.</li><li>`na`: North America.</li> |
| `appId` | String | (Required) Agora App ID.|
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |
| `extAppUuid` | String | (Required) The extApp ID. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |

**Request body parameters**

Pass in the following parameters in the request body.

| Parameter | Type | Description |
| :----------- | :----- | :----------------------------------------------------------- |
| `properties` | Object | The user properties. |
| `common` | Object | The JSON object contains the following fields:<li>`state`: Integer, the state of extApp. `0` means disabled, and `1` means enabled.</li> |
| `cause` | Object | The update reason. |

#### Request example

**Request Body**

```json
{
    "properties" :{},
    "common":{
        "state":0
    },
    "cause":{}
}
```

#### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |

#### Response example

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## Delete the extApp properties

#### Description

Delete the properties of the extApp in a specified classroom.

#### Prototype

- Method: DELETE
- Endpoint: /{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/extApps/{extAppUuid}/properties

#### Request parameters

**URL parameters**

Pass the following parameters in the URL.

| Parameter | Type | Description |
| :----------- | :----- | :----------------------------------------------------------- |
| `region` | String | (Required) The region for connection. For details, see [Network geofencing](/en/agora-class/agora_class_security#network-geofencing). Flexible Classroom supports the following regions:<li>`cn`: Mainland China.</li><li>`ap`: Asia Pacific.</li><li>`eu`: Europe.</li><li>`na`: North America.</li> |
| `appId` | String | (Required) Agora App ID.|
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |
| `extAppUuid` | String | (Required) The extApp ID. The string length must be less than 64 bytes. ~dcf68310-2d96-11ec-837a-476ce6215fac~ |

**Request body parameters**

Pass in the following parameters in the request body.

| Parameter | Type | Description |
| :----------- | :---------- | :--------- |
| `properties` | String array | The user properties. |
| `cause` | Object | Reason for deletion. |

#### Request example

**Request Body**

```json
{
    "properties" :[
        "key-path1",
        "key-path2"
    ],
    "cause":{}
}
```

#### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | Business status code:<li>0: The request succeeds.</li><li>Non-zero: The request fails.</li> |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |

#### Response example

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## Status code

| Response status code | Business status code | Description |
| :-------------- | :--------- | :----------------------------------------------------------- |
| 200 | 0 | The request succeeds. |
| 400 | 400 | The request parameter is incorrect. |
| 401 | N/A | Possible reasons:<li>The App ID is invalid.</li><li>Unauthorized. Incorrect `x-agora-uid` or `x-agora-token`.</li> |
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