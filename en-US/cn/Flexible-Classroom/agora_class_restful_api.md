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
- The uid you use to generate the RTM token.

For details, see[ Generate an RTM Token](https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms).

## Set the classroom state

### Description

Call this method to set the classroom state: Not started, Started, Ended. For the detailed description of each state, seeclassroom [state management](./class_state).

### Prototype

- Method: PUT
- Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/states/{state}

### Request parameters

**URL parameters**

Pass the following parameter in the URL.

| Parameter | Type | Description |
| :--------- | :------ | :----------------------------------------------------------- |
| `appId` | String | (Required) The Agora App ID, see[ Get the Agora App ID](./agora_class_prep#step1). |
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters: <li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `state` | integer | (Required) The classroom state:<li>` 0`: Not started.<li>` 1`: Start recording.<li>` 2`: Stop recording. |

### Request example

```
// See the state of test_class as started
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/states/1
```

### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :------------------------------------------------ |
| `code` | integer | Business status code:<li>0: The request succeeds.<li>Non-zero: The request fails. |
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

## Set the recording state

### Description

Start or stop recording a specified classroom.

### Prototype

- Method: PUT
- Endpoint: /edu/apps/{appId}/v2/rooms/{roomUUid}/records/states/{state}

### Request parameters

**URL parameters**

Pass the following parameter in the URL.

| Parameter | Type | Description |
| :--------- | :------ | :----------------------------------------------------------- |
| `appId` | String | (Required) The Agora App ID, see[ Get the Agora App ID](./agora_class_prep#step1). |
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters: <li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `state` | integer | (Required) The recording state:<li>`0`: 结束<li>` 1`: Start recording. |

### Request example

```
// Start recording test_class
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records/states/1
```

### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :------------------------------------------------ |
| `code` | integer | Business status code:<li>0: The request succeeds.<li>Non-zero: The request fails. |
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

You can fetch data in batches with the `nextId` parameter. You can get up to 100 pieces of data each batch.

### Prototype

- Method: GET
- Endpoint: /edu/apps/{appId}/v2/rooms/{roomUuid}/records

### Request parameters

**URL parameters**

Pass the following parameter in the URL.

| Parameter | Type | Description |
| :--------- | :----- | :----------------------------------------------------------- |
| `appId` | String | (Required) The Agora App ID, see[ Get the Agora App ID](./agora_class_prep#step1). |
| `roomUuid` | String | (Required) The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel. The string length must be less than 64 bytes. Supported character scopes are:<li>All lowercase English letters: a to z.<li>All uppercase English letters: A to Z.<li>All numeric characters: <li>0-9<li>The space character.<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |

**Query parameters**

| Parameter | Type | Description |
| :------- | :----- | :----------------------------------------------------------- |
| `nextId` | String | (Optional) The starting ID of the next batch of data. When you call this method to get the data for the first time, leave this parameter empty or set is as null. Afterwards, you can set this parameter as the nextId that you get in the response of previous method ``call. |

### Request example

```
// Get the recording list in test_class
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records?nextId=xxx
```

### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :----------------------------------------------------------- |
| `code` | integer | Business status code:<li>0: The request succeeds.<li>Non-zero: The request fails. |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data` | object | Include the following parameters:<ul><li>`count`: Integer, the number of pieces of data in this batch.</li><li>`list`: JSONArray. An array of the recording list. A JSON object includes the following parameters:<ul><li>`appId`: Your Agora App ID.</li><li>`roomUuid`: The classroom ID. This is the globally unique identifier of a classroom. It is also used as the channel name when a user joins an RTC or RTM channel.</li><li>`recordId`: The unique identifier of a recording session. 调用设置录制状态 API 开始录制然后结束录制视为一次录制。</li><li>`startTime`: The UTC timestamp when a recording session starts, in milliseconds.</li><li>`endTime`: The UTC timestamp when a recording session stops, in milliseconds.</li><li>`resourceId`: The resourceId of Agora cloud recording service``.</li><li>`sid`: The sid of Agora cloud recording service``.</li><li>`recordUid`: The UID used by Agora cloud recording service in the channel.</li><li>`boardAppId`: The AppIdentifier of Netless whiteboard service.</li><li>`boardToken`: The sdkToken of Netless whiteboard service. 。 </li><li>`boardId`: The unique identifier of a whiteboard session.</li><li>`type`: Integer, the recording type:<ul><li>`1`: Individual Recording</li><li>`2`: Composite Recording</li></ul><li>`status`: Integer, the recording state:<ul><li>`1`: In recording.</li><li>`2`: Recording has ended.</li></ul><li>`url`: String, the url of the recording file.</li></ul><li>`nextId`: String, the starting ID of the next batch of data. If it is null, there is no next batch of data. 如不为 null，则可用此 `nextId` 继续查询，直到查到 null 为止。</li><li>`total`: Integer, the total number of pieces of data.</li></ul> |

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
        "url": "scenario/recording/xxxxxx/xxxxxx/xxxxxx.m3u8"
      },
      {...},
    ],
    "count": 17
}
```
## Get classroom events

### Description

Get all events in the classrooms associated with a specified App ID on the server.

You can keep polling the server at regular intervals to listen for events that occur in the classrooms.

<div class="alert note"><li>Each event can only be obtained once.</li><li>Note: You cannot get events any longer one hour after a classroom is destroyed.</li></div>

### Prototype

- Method: GET
- Endpoint: /edu/polling/apps/{appId}/v2/rooms/sequences

### Request parameters

**URL parameters**

Pass the following parameter in the URL.

| Parameter | Type | Description |
| :------ | :----- | :----------------------------------------------------------- |
| `appId` | String | (Required) The Agora App ID, see[ Get the Agora App ID](./agora_class_prep#step1). |

### Request example

```
https://api.agora.io/edu/polling/apps/{yourappId}/v2/rooms/sequences
```

### Response parameters

| Parameter | Type | Description |
| :----- | :------ | :----------------------------------------------------------- |
| `code` | integer | Business status code:<li>0: The request succeeds.<li>Non-zero: The request fails. |
| `msg` | String | The detailed information. |
| `ts` | Number | The current Unix timestamp (in milliseconds) of the server in UTC. |
| `data` | object | Include the following parameters:<li>` roomUuid`: String, the classroom ID.<li>` cmd`: Integer, the event type. See [Flexible Classroom Events](./agora_class_restful_api_event).<li>`  sequence`: Integer. The event ID. This is the unique identifier of each event, which is automatically incremented in the classroom to ensure the order of events.<li>` version`: Integer, the service version.<li>` data`: Object, the detailed data of the event, The data varies depending on the event type. See [Flexible Classroom Events](./agora_class_restful_api_event). |

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

| HTTP response status code | Business status code | Description |
| :-------------- | :--------- | :----------------------------------------------------------- |
| 200 | 0 | The request is successful. |
| 400 | 400 | The request parameter is incorrect. |
| 401 | N/A | Possible reasons:<li>The App ID is invalid.<li>Unauthorized. Incorrect `x-agora-uid` or `x-agora-token`. |
| 403 | 30403200 | The classroom is muted globally. You cannot send chat messages. |
| 404 | N/A | The requested resource could not be found. |
| 404 | 20404100 | The classroom does not exist. |
| 404 | 20404200 | The user does not exist. |
| 409 | 30409410 | The recording has not been started. |
| 409 | 30409411 | The recording has not been ended. |
| 409 | 30409100 | The class has been started. |
| 409 | 30409101 | The class has been ended. |
| 500 | 500 | Internal server error. |
| 503 | N/A | Internal server error. The gateway or proxy server did not receive a timely response from the upstream server. |