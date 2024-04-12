
<!-- Generator: Widdershins v4.0.1 -->

# API Overview

Cloud Recording is a Agora for audio and video calls and live streaming. You can send HTTP requests from your business server to Agora's server to perform Cloud Recording on the server side.
- Call the` acquire` method to request a resource ID for cloud recording.
- Call the`  start` method within two seconds after getting the resource ID to` start` the recording. During the recording process, you can call the following methods as needed:
   - `Query`: Check the status Cloud Recording.
   - `Update`: Update recording settings.
   - `updateLayout`: Update the layout of the merged content.
- `stop`: After the recording is completed, call `stop` to leave the channel and stop the recording.

> Cloud Recording does not support completing multiple tasks in one recording. For example, if you need to simultaneously record a single stream and a mixed stream for a certain channel, you will need to start two recordings. That is, use two different `uids` to call `acquire` to obtain two `resourceIds`, and then call start separately to start two recording tasks. Both recording methods will incur costs.

To facilitate your monitoring of the cloud recording status, Agora provides [message notification service at ](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/enable-ncs). After enabling this service, you can receive cloud recording related events through Webhook [at ](https://doc.shengwang.cn/api-ref/cloud-recording/restful/webhook/ncs-events).

Because Agora will dynamically adjust the IP address of the notification server, in order to not affect your receipt of events, you need to[ regularly query the IP address ](#opIdget-v1-ncs-ip )and update the firewall whitelist configuration.

## Base URL

`https://api.sd-rtn.com`


## Authentication

When sending an HTTP request, you need to authenticate with Basic HTTP and fill in the generated credentials in the `Authorization `field of the HTTP request header. For specific instructions on how to generate the `Authorization` field, please refer to[ the implementation of HTTP Basic Authentication at ](https://doc.shengwang.cn/doc/cloud-recording/restful/get-started/authorization).

# Endpoint

## acquire

<a id="opIdpost-v1-apps-appid-cloud_recording-acquire"></a>


`Endpoint: /v1/apps/\<appid\>/cloud_recording/acquire`

*Acquire: Obtain a cloud transcoding resource*

Before starting a cloud recording, you need to call `this` method to get a resource ID. One resource ID can only be used for one recording session.


**Note**: To ensure successful Cloud Recording, please follow the following requirements:
- The requests for `acquire` and `start` need to be called in pairs.
- Within 2 seconds of acquiring the Resource ID for each `acquire` request, immediately initiate the corresponding [`start`](#opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start) request. Batch starting requests after batch acquiring Resource IDs may result in request failure.``
- Resource ID is valid within 5 minutes of obtaining it and should be used as soon as possible.

> Request body

```json
{
  "cname": "httpClient463224"
  "uid": "527841",
  "clientRequest": {
    "scene": 0,
    "resourceExpiredHour": 24
  }
}
```

### Parameters

| name | In | type | Required | 描述 |
|---|---|---|---|---|
| Content-Type | header | string |                     false | `application/json` |
| appid | path | string |                     true | Your project uses the[ App ID ](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id).<li>For web page recording mode, simply enter the App ID that has Cloud Recording service.</li><li>For single-stream and composite recording modes, you must use the same App ID as the channel to be recorded, and this App ID needs to have Cloud Recording service enabled.</li> |
| body | body | JSON Object |                     true | [acquire-request](#schemaacquire-request) |

> Example responses

> 200 Response

```json
{
  "cname": "string",
  "uid": "string",
  "resourceId": "string"
}
```

### Responses

| status | 描述 | Schema |
|---|---|---|
| 200 OK | If the returned HTTP status code is `200`, the request is successful. If you set the `startParameter `object in the request body and its value is invalid, it will not affect the success of the` acquire` request, but you will receive an error in the subsequent `start` request. | [acquire-response](#schemaacquire-response) |
| Not 200 | If the HTTP status code is not `200`, please refer to [the response status code at ](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code )to troubleshoot the issue. | Response [status ](code https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) |


## start

<a id="opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start"></a>


`POST /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/mode/{mode}/start`

*Start: Start Cloud Recording*

After obtaining cloud recording resources through the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) method, call the start method to begin `cloud recording`.

> After initiating the `start` request, you also need to check whether the recording service has [been successfully started based ](on best practices. Please refer to https://doc.shengwang.cn/doc/cloud-recording/restful/best-practices/integration#确认录制服务已成功启动 )for checking if the recording service has been successfully started.

> Request body

```json
{
  "cname": "httpClient463224"
  "uid": "527841",
  "clientRequest": {
    "recordingConfig": {
      "channelType": 1
      "streamTypes": 2,
      "streamMode": "default",
                    VideoStreamType
      "maxIdleTime": 30,
      "subscribeAudioUids": [
        "123",
        "456"
      ],
      "subscribeVideoUids": [
        "123",
        "456"
      ],
      "subscribeUidGroup": 0
    },
    You cannot set both recordingFileConfig and snapshotConfig at the same time.
      "avFileType": [
        "hls"
      ]
    },
    "storageConfig": {
      "vendor": 0,
      "region": 0,
      "bucket": "xxxxx",
      "accessKey": "xxxxx",
      "secretKey": "xxxxx",
      "fileNamePrefix": [
        "directory1",
        "directory2"
      ]
    }
  }
}
```

### Parameters

| name | In | type | Required | 描述 |
|---|---|---|---|---|
| Content-Type | header | string |                     false | `application/json` |
| appid | path | string |                     true | Your project uses the[ App ID ](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id).<li>For web page recording mode, simply enter the App ID that has Cloud Recording service.</li><li>For single-stream and composite recording modes, you must use the same App ID as the channel to be recorded, and this App ID needs to have Cloud Recording service enabled.</li> |
| resourceid | path | string |                     true | [`Resource ID`]( obtained through the acquire#opIdpost-v1-apps-appid-cloud_recording-acquire) request. |
| mode | path | string |                     true | Recording mode<li>individual: single-`Individual Recording `recording mode https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/set-individual).[](</li><li>`mix: Composite recording `mode https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite).[](</li><li>`web`: web [page ](recording recording mode https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/web-mode/set-webpage-recording).</li> |
| body | body | JSON Object |                     true | [start-request](#schema start-request) |

> Example responses

> 200 Response

```json
{
  "cname": "string",
  "uid": "string",
        "resourceId": "xxxxxx",
  "sid": "string"
}
```

### Responses

| status | 描述 | Schema |
|---|---|---|
| 200 | If the returned HTTP status code is `200`, the request is successful. To check if the recording service has been successfully started, please refer to the best practices [at ](https://doc.shengwang.cn/doc/cloud-recording/restful/best-practices/integration#confirming-that-the-recording-service-has-successfully-started). | [Response Schema]() |
| Not 200 | If the HTTP status code is not `200`, please refer to [the response status code at ](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code )to troubleshoot the issue. | Response [status ](code https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) |

#### Response Schema

Status Code **200**

| name | type | Required | 描述 |
|---|---|---|---|
| cname | string |                     false | The name of the channel to be recorded. |
| uid | string |                     false | The string content is the UID used by the Cloud Recording service in the RTC channel to identify the recording service within the channel. |
| resourceId | string |                     false | Cloud Recording resource ID. You can start Cloud Recording with this Resource ID. The validity period of this Resource ID is 5 minutes. If it times out, you need to request it again. |
| sid | string |                     false | Recording ID After successfully starting Cloud Recording, you will receive a Sid (recording ID). This ID is the unique identification of the current recording. |



## Update

<a id="opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-sid-sid-mode-mode-update"></a>


`POST /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/sid/{sid}/mode/{mode}/update`

*Update: Update Cloud Recording settings*

After starting the recording, you can call the `update` method to update the following recording configuration:
- Update the subscription list for Individual Recording and composite recording.
- To web page recording, set pause/resume web page recording, or update the streaming address (URL) web page recording to CDN.


> - The` update` request is only valid within the session. If you call query after a recording ends or after it starts with error, you get a 404 (Not Found) `error`.``
> - If you need to continuously call the `update` method to update the recording settings, please wait until you receive the response from the previous `update` before making the call, otherwise it may cause the request result to be inconsistent with expectations.

> Request body

```json
{
  "cname": "httpClient463224"
  "uid": "527841",
  "clientRequest": {
    "streamSubscribe": {
      "audioUidList": {
        "subscribeAudioUids": [
          "#allstream#"
        ]
      },
      "videoUidList": {
        "unSubscribeVideoUids": [
          "444",
          "555",
          "666"
        ]
      }
    }
  }
}
```

### Parameters

| name | In | type | Required | 描述 |
|---|---|---|---|---|
| Content-Type | header | string |                     false | `application/json` |
| appid | path | string |                     true | Your project uses the[ App ID ](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id).<li>For web page recording mode, simply enter the App ID that has Cloud Recording service.</li><li>For single-stream and composite recording modes, you must use the same App ID as the channel to be recorded, and this App ID needs to have Cloud Recording service enabled.</li> |
| resourceid | path | string |                     true | [`Resource ID`]( obtained through the acquire#opIdpost-v1-apps-appid-cloud_recording-acquire) request. |
| sid | path | string |                     true | [`Recording ID`]( obtained through start#opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start). |
| mode | path | string |                     true | Recording mode<li>individual: single-`Individual Recording `recording mode https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/set-individual).[](</li><li>`mix: Composite recording `mode https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite).[](</li><li>`web`: web [page ](recording recording mode https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/web-mode/set-webpage-recording).</li> |
| body | body | JSON Object |                     true | [update request schema update ](request) |

> Example responses

> 200 Response

```json
{
  "cname": "string",
  "uid": "string",
        "resourceId": "xxxxxx",
  "sid": "string"
}
```

### Responses

| status | 描述 | Schema |
|---|---|---|
| 200 | If the returned HTTP status code is `200`, the request is successful. | [Response Schema](#response-schema-1) |
| Not 200 | If the HTTP status code is not `200`, please refer to [the response status code at ](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code )to troubleshoot the issue. | Response [status ](code https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) |

#### Response Schema

Status Code **200**

| name | type | Required | 描述 |
|---|---|---|---|
| cname | string |                     false | The name of the channel to be recorded. |
| uid | string |                     false | The string content is the UID used by the Cloud Recording service in the RTC channel to identify the recording service within the channel. |
| resourceId | string |                     false | Resource ID used Cloud Recording. |
| sid | string |                     false | Recording ID Identify each recording cycle. |



## A request example of updateLayout

<a id="opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-sid-sid-mode-mode-updateLayout"></a>


`POST /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/sid/{sid}/mode/{mode}/updateLayout`

*UpdateLayout: Update the Cloud Recording layout.*

After starting the composite recording, you can call this method (`updateLayout`) to update the mixed layout.

This method call overrides the existing subscription configuration. For example, if the backgroundColor is set to `"#FF0000"` (red) when starting the recording, if the `updateLayout` method is called to update the layout of the mixed stream without setting the `backgroundColor` field again, the background color will become black (default value).``


> - The` updateLayout` request is only valid within the session. If you call query after a recording ends or after it starts with error, you get a `404 `(Not Found`) error`.
> - If you need to continuously call the `updateLayout` method to update the layout of the merged stream, please make the call after receiving the response from the previous `updateLayout`, otherwise it may result in inconsistent results with expectations.

> Request body

```json
{
  "cname": "httpClient463224"
  "uid": "527841",
  "clientRequest": {
    "mixedVideoLayout": 3,
    backgroundColor = 0xFF000000;
    "layoutConfig": [
      {
        uid: "",
         "x_axis": 0.1,
        "y_axis": 0.1,
        "width": 0.1,
        "height": 0.1,
        "alpha": 1,
        "render_mode": 1
      },
      {
        uid: "",
         "x_axis": 0.2,
        "y_axis": 0.2,
        "width": 0.1,
        "height": 0.1,
        "alpha": 1,
        "render_mode": 1
      }
    ]
  }
}
```

### Parameters

| name | In | type | Required | 描述 |
|---|---|---|---|---|
| Content-Type | header | string |                     false | `application/json` |
| appid | path | string |                     true | Your project uses the[ App ID ](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id).<li>For web page recording mode, simply enter the App ID that has Cloud Recording service.</li><li>For single-stream and composite recording modes, you must use the same App ID as the channel to be recorded, and this App ID needs to have Cloud Recording service enabled.</li> |
| resourceid | path | string |                     true | [`Resource ID`]( obtained through the acquire#opIdpost-v1-apps-appid-cloud_recording-acquire) request. |
| sid | path | string |                     true | [`Recording ID`]( obtained through start#opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start). |
| mode | path | string |                     true | Recording mode Only support mix, which represents the `composite recording mode`[. ](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite). |
| body | body | JSON Object |                     true | [updateLayout-request](#schemaupdatelayout-request) |

> Example responses

> 200 Response

```json
{
  "cname": "string",
  "uid": "string",
        "resourceId": "xxxxxx",
  "sid": "string"
}
```

### Responses

| status | 描述 | Schema |
|---|---|---|
| 200 | If the returned HTTP status code is `200`, the request is successful. | [Response Schema](#response-schema-2) |
| Not 200 | If the HTTP status code is not `200`, please refer to [the response status code at ](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code )to troubleshoot the issue. | Response [status ](code https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) |

#### Response Schema

Status Code **200**

| name | type | Required | 描述 |
|---|---|---|---|
| cname | string |                     false | The name of the channel to be recorded. |
| uid | string |                     false | The string content is the UID used by the Cloud Recording service in the RTC channel to identify the recording service within the channel. |
| resourceId | string |                     false | Resource ID used Cloud Recording. |
| sid | string |                     false | Recording ID Identify a recording cycle. |



## query

<a id="opIdget-v1-apps-appid-cloud_recording-resourceid-resourceid-sid-sid-mode-mode-query"></a>


`GET /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/sid/{sid}/mode/{mode}/query`

*Query: Check Cloud Recording status*

After you start a recording, you can call `query` to check its status.

> `query` works only with an ongoing recording session. If you call query after a recording ends or after it starts with error, you get a `404` (Not Found) error.``

### Parameters

| name | In | type | Required | 描述 |
|---|---|---|---|---|
| Content-Type | header | string |                     false | `application/json` |
| appid | path | string |                     true | Your project uses the[ App ID ](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id).<li>For web page recording mode, simply enter the App ID that has Cloud Recording service.</li><li>For single-stream and composite recording modes, you must use the same App ID as the channel to be recorded, and this App ID needs to have Cloud Recording service enabled.</li> |
| resourceid | path | string |                     true | [`Resource ID`]( obtained through the acquire#opIdpost-v1-apps-appid-cloud_recording-acquire) request. |
| sid | path | string |                     true | [`Recording ID`]( obtained through start#opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start). |
| mode | path | string |                     true | Recording mode<li>individual: single-`Individual Recording `recording mode https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/set-individual).[](</li><li>`mix: Composite recording `mode https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite).[](</li><li>`web`: web [page ](recording recording mode https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/web-mode/set-webpage-recording).</li> |

> Example responses

> 200 Response

```json
{
        "resourceId": "xxxxxx",
  "sid": "string",
  "serverResponse": {
        "status": 2,
    "extensionServiceState": [
      {
        "payload": {...}
          "fileList": [
            {
              "filename": "string",
              "sliceStartTime": 0
            }
          ],
          "on hold": true,
          "state": "string"
        },
        "serviceName": "string"
      }
    ]
  },
  "cname": "string",
  "uid": "string"
}
```

### Responses

| status | 描述 | Schema |
|---|---|---|
| 200 | If the returned HTTP status code is `200`, the request is successful. | [query-response](#schemaquery-response) |
| Not 200 | If the HTTP status code is not `200`, please refer to [the response status code at ](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code )to troubleshoot the issue. | Response [status ](code https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) |



##                         stop

<a id="opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-sid-sid-mode-mode-stop"></a>


`POST /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/sid/{sid}/mode/{mode}/stop`

*Stop: Stop Cloud Recording*

You can call the `stop` method to leave the channel and stop recording. To use Agora Cloud Recording again, you need to call the acquire method for a new resource ID.``

> - The` stop` request is only valid within the session. If you call query after a recording ends or after it starts with error, you get a 404 (Not `Found`) error.``
> - Agora Cloud Recording automatically leaves the channel and stops recording when no user is in the channel for more than 30 seconds by default.

> Request body

```json
{
  "cname": "httpClient463224"
  "uid": "527841",
  "clientRequest": {
    "async_stop": false
  }
}
```

### Parameters

| name | In | type | Required | 描述 |
|---|---|---|---|---|
| Content-Type | header | string |                     false | `application/json` |
| appid | path | string |                     true | Your project uses the[ App ID ](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id).<li>For web page recording mode, simply enter the App ID that has Cloud Recording service.</li><li>For single-stream and composite recording modes, you must use the same App ID as the channel to be recorded, and this App ID needs to have Cloud Recording service enabled.</li> |
| resourceid | path | string |                     true | [`Resource ID`]( obtained through the acquire#opIdpost-v1-apps-appid-cloud_recording-acquire) request. |
| sid | path | string |                     true | [`Recording ID`]( obtained through start#opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start). |
| mode | path | string |                     true | Recording mode<li>individual: single-`Individual Recording `recording mode https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/set-individual).[](</li><li>`mix: Composite recording `mode https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite).[](</li><li>`web`: web [page ](recording recording mode https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/web-mode/set-webpage-recording).</li> |
| body | body | JSON Object |                     true | [stop-request](#schemastop-request) |

> Example responses

> 200 Response

```json
{
        "resourceId": "xxxxxx",
  "sid": "string",
  "serverResponse": {
    "extensionServiceState": [
      {
        "payload": {
          "uploadingStatus": "string"
        },
        "serviceName": "string"
      }
    ]
  },
  "cname": "string",
  "uid": "string"
}
```

### Responses

| status | 描述 | Schema |
|---|---|---|
| 200 | If the returned HTTP status code is `200`, the request is successful. | [stop-response](#schema) |
| Not 200 | If the HTTP status code is not `200`, please refer to [the response status code at ](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code )to troubleshoot the issue. | Response [status ](code https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) |



## get-ncs-ip

<a id="opIdget-v1-ncs-ip"></a>

`GET request to retrieve the IP address from the ncs endpoint version 1.`

*Query the IP address of the message notification server.*

Query the IP address or IP address list of the message notification server.

After enabling the message notification service, Agora message notification service can notify your server of certain events that occur in the online media streaming business through HTTPS requests. Agora will dynamically adjust the IP address of the message notification server every 24 hours. You can query the IP address using this method. After the query, you need to add the IP address (or IP address list) to the whitelist.

> We strongly recommend that you perform a query at least every 24 hours and automatically update the firewall configuration, otherwise it may affect your receipt of notifications.

> Example responses

> If the returned HTTP status code is 200, the request is successful.

You only need to pay attention to the `PrimaryIP `field in the response Body, and you don't need to care about the response Header or other fields in the response Body.

```json
{
  "data": {
    "service": {
      "hosts": [
        {
          "primaryIP": "xxx.xxx.xxx.xxx"
        },
        {
          "primaryIP": "xxx.xxx.xxx.xxx"
        }
      ]
    }
  }
}
```

### Responses

| status | 描述 | Schema |
|---|---|---|
| 200 | If the returned HTTP status code is 200, the request is successful. You only need to pay attention to the `PrimaryIP `field in the response Body, and you don't need to care about the response Header or other fields in the response Body. | [Response Schema](#response-schema-3) |

#### Response Schema

Status Code **200**

| name | type | Required | 描述 |
|---|---|---|---|
| data | object |                     false | No need to understand. |
| » service | object |                     false | No need to understand. |
| hosts | arrayobject[] |                     false | No need to understand. |
| »»» primaryIP | string |                     false | Agora notification server IP address. |



# Schemas

## acquire-request
<!-- backwards compatibility -->
<a id="schemaacquire-request"></a>




```json
{
  "cname": "string",
  "uid": "string",
  "clientRequest": {
    "scene": 0,
    "resourceExpiredHour": 24
    "startParameter": {
      "token": "string",
      "storageConfig": {
        "vendor": 0,
        "region": 0,
        "bucket": "string",
        "accessKey": "string",
        "secretKey": "string",
        "fileNamePrefix": [
          String
        ],
        "extensionParams": {
          "sse": "string",
          "tag": "string"
        }
      },
      "recordingConfig": {
        "channelType": 0
        "decryptionMode": 0,
        "secret": "string"
        "salt": "string",
        "maxIdleTime": 30,
        "streamTypes": 2,
                    VideoStreamType
        "subscribeAudioUids": [
          String
        ],
        "unsubscribeAudioUids": [
          String
        ],
        "subscribeVideoUids": [
          String
        ],
        "unsubscribeVideoUids": [
          String
        ],
        "subscribeUidGroup": 0,
        "streamMode": "default",
        "audioProfile": 0,
        "transcodingConfig": {
          width: 160,
          height = 640;
          "fps": 15,
          bitrate: 120,
          "maxResolutionUid": "string",
          "mixedVideoLayout": 0,
          backgroundColor(0x000000),
          "backgroundImage": "string",
          "default user background image: "string""
          "layoutConfig": [
            {
              "uid": "string",
              "x_axis": 1,
              "y_axis": 1,
              "width": 1,
              "height": 1,
              "alpha": 1,
              "render_mode": 0
            }
          ],
          "backgroundConfig": [
            {
              "uid": "string",
              "image_url": "string",
              "render_mode": 0
            }
          ]
        }
      },
      You cannot set both recordingFileConfig and snapshotConfig at the same time.
        "avFileType": [
          "hls"
        ]
      },
      "snapshotConfig": {
        "captureInterval": 10,
        "fileType": [
          "jpg"
        ]
      },
      extensionServiceConfig has the following fields:
        "errorHandlePolicy": "error_abort",
        "extensionServices": [
          {
            "serviceName": "string",
            "errorHandlePolicy": "string",
            "serviceParam": {
              "url": "string",
              "audioProfile": 0,
              "videoWidth": 240,
              "videoHeight": 240,
              "maxRecordingHour": 1,
              VideoBitrate (400),
              "videoFps": 15,
              "mobile": false,
              "maxVideoDuration": 120,
              "on hold": false,
              "readyTimeout": 0
            }
          }
        ]
      },
      "appsCollection": {
        "combinationPolicy": "default"
      },
      transcodeOptions
        "transConfig": {
          "transMode": "string"
        },
        "container": {
          "format": "string"
        },
        "audio": {
          "sampleRate": "48000",
          "bitrate": "48000",
          "channels": "2"
        }
      }
    },
    "excludeResourceIds": [
      String
    ],
    "regionAffinity": 0
  }
}
```

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| cname | string |                     true | Channel Name:<br> - For single-Individual Recording and composite recording modes, this field is used to set the name of the channel to be recorded. <br>- For web page recording mode, this field is used to differentiate the recording process. The maximum length of this parameter is 1024 bytes. <br>**Note**: A unique recording instance can be located through `appid`, `cname`, and `uid`. Therefore, if you want to record multiple times for the same channel, you can use the same `appId` and `cname`, as well as different `uid` for management and differentiation. |
| uid | string |                     true | A string that contains the UID of the recording client, for example `"527841"`. The string content must meet the following conditions:<br> - The value range is from 1 to (<sup>232</sup>-1), and cannot be set to `0`. <br>It is unique and does not clash with any existing UID in the channel. <br>- The value inside the quotation marks is an integer UID, and all users in the channel use integer UIDs. |
| "clientRequest":{
 | object |                     false | As described below. |
| "Scene" | number |                     false | Cloud Recording resource usage scenarios:<br> - `0`: Real-time audio and video recording. <br>- `1`: web page recording. <br>- `2`: Single-Individual Recording mode, with delayed transcoding or delayed mixing enabled.<br>    - Transcoding delay: The recording service will transcode the recording file within 24 hours after recording (in special cases, it may take more than 48 hours) to generate an MP4 file, and upload the MP4 file to the third-party cloud storage you specified. This scene is only applicable to Individual Recording mode.<br>    - Delayed Mixing: The recording service will merge and transcode all recording files of specified UIDs within 24 hours after the recording ends (in special cases, it may take more than 48 hours) and generate an MP3/M4A/AAC file, then upload the file to your specified third-party cloud storage. This scenario is only applicable to the audio single-stream non-transcoding recording mode.<br>    - When` scene` is set to `2`, you need to set the `appsCollection `field in the `start` method at the same time.<br>    - In scenarios involving transcoding and audio mixing with delay, recorded files will be cached on Agora edge servers for up to 24 hours. If your business is sensitive to information security and to ensure data compliance, please carefully consider whether to use delayed transcoding and delayed mixing functions. If you have any doubts, please contact Agora technical support. |
| "resourceExpiredHour": 24 | number |                     false | For details, see Agora Cloud Recording RESTful API Callback Service. Start calculating after successfully initiating Cloud Recording and obtaining the `SID` (Recording ID). Unit is hours. <br><br>**The** time limit starts from when you successfully start a `cloud ``recording` and get sid(`the recording ID` ).``</br> |
| "startParameter" | [client-request](#schemaclient-request) |                     false | Setting this field can improve availability and optimize load balancing. <br><br>**Note**: If this field is filled out, it must be ensured that the `startParameter` object and the `clientRequest `object filled out in subsequent `start `requests are completely consistent and valid, otherwise the` start` request will receive an error. |
| » excludeResourceIds | arraystring[] |                     false | The resourceId of another or multiple recording tasks. ``This field is used to exclude specified recording resources so that newly initiated recording tasks can use resources from a new region, enabling cross-regional multi-channel recording. See [multi-channel task guarantee at ](https://doc.shengwang.cn/doc/cloud-recording/restful/best-practices/integration#multi-channel-task-guarantee). |
| "regionAffinity" | number |                     false | Specify the use of resources from a certain region for recording. The supported values are as follows:<br> - `0`: Call resources based on the region where the request is initiated. <br>- `1`: China. <br>- `2`: Southeast Asia. <br>- `3`: Europe. <br>- `4`: North America. <br>**Note**:<br> To speed up file uploads during recording, it is recommended that you set the field to the cloud storage region when the region you are using for cloud storage is different from the region you are requesting. <br>- When the available capacity in the specified region is insufficient, overflow will occur based on proximity to the geographical location. |

## client-request
<!-- backwards compatibility -->
<a id="schemaclient-request"></a>




```json
{
  "token": "string",
  "storageConfig": {
    "vendor": 0,
    "region": 0,
    "bucket": "string",
    "accessKey": "string",
    "secretKey": "string",
    "fileNamePrefix": [
      String
    ],
    "extensionParams": {
      "sse": "string",
      "tag": "string"
    }
  },
  "recordingConfig": {
    "channelType": 0
    "decryptionMode": 0,
    "secret": "string"
    "salt": "string",
    "maxIdleTime": 30,
    "streamTypes": 2,
                    VideoStreamType
    "subscribeAudioUids": [
      String
    ],
    "unsubscribeAudioUids": [
      String
    ],
    "subscribeVideoUids": [
      String
    ],
    "unsubscribeVideoUids": [
      String
    ],
    "subscribeUidGroup": 0,
    "streamMode": "default",
    "audioProfile": 0,
    "transcodingConfig": {
      width: 160,
      height = 640;
      "fps": 15,
      bitrate: 120,
      "maxResolutionUid": "string",
      "mixedVideoLayout": 0,
      backgroundColor(0x000000),
      "backgroundImage": "string",
      "default user background image: "string""
      "layoutConfig": [
        {
          "uid": "string",
          "x_axis": 1,
          "y_axis": 1,
          "width": 1,
          "height": 1,
          "alpha": 1,
          "render_mode": 0
        }
      ],
      "backgroundConfig": [
        {
          "uid": "string",
          "image_url": "string",
          "render_mode": 0
        }
      ]
    }
  },
  You cannot set both recordingFileConfig and snapshotConfig at the same time.
    "avFileType": [
      "hls"
    ]
  },
  "snapshotConfig": {
    "captureInterval": 10,
    "fileType": [
      "jpg"
    ]
  },
  extensionServiceConfig has the following fields:
    "errorHandlePolicy": "error_abort",
    "extensionServices": [
      {
        "serviceName": "string",
        "errorHandlePolicy": "string",
        "serviceParam": {
          "url": "string",
          "audioProfile": 0,
          "videoWidth": 240,
          "videoHeight": 240,
          "maxRecordingHour": 1,
          VideoBitrate (400),
          "videoFps": 15,
          "mobile": false,
          "maxVideoDuration": 120,
          "on hold": false,
          "readyTimeout": 0
        }
      }
    ]
  },
  "appsCollection": {
    "combinationPolicy": "default"
  },
  transcodeOptions
    "transConfig": {
      "transMode": "string"
    },
    "container": {
      "format": "string"
    },
    "audio": {
      "sampleRate": "48000",
      "bitrate": "48000",
      "channels": "2"
    }
  }
}
```


### properties

| name | type | Required | 描述 |
|---|---|---|---|
| token. | string |                     false | Dynamic key (Token) used for authentication. Ensure that you set this parameter if App Certificate is enabled for your application. See[ Token Authentication ](for details: https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication).<br><p><b>Note</b>:<br><li>Just need to set in <b>Individual Recording </b>and <b>composite recording </b>mode.</li><br><li>Cloud Recording service does not currently support updating tokens. To ensure normal recording, please make sure that the token is valid for a duration longer than your expected recording time, to avoid the token expiring and causing the recording task to exit the channel and end the recording.</li><br></p> |
| storageConfig | [storageConfig](#schemastorageconfig) |                     true | Configuration options for third-party cloud storage. |
| recordingConfig | [recordingConfig](#schemarecordingconfig) |                     false | Recorded audio and video stream configuration options.<br><p><b>Note: </b>Only need to set in <b>Individual Recording </b>and <b>composite recording </b>modes.</p> |
| You cannot set both recordingFileConfig and snapshotConfig at the same time. | [recordingFileConfig](#schemarecordingfileconfig) |                     false | Recording file configuration item.<br><p><b>Note</b>: <b>This field should not be set only when taking </b>screenshots, it needs to be set in all other cases. Other situations include the following:<br><li>Individual Recording mode, you can choose to record without transcoding, record with transcoding, or record and take screenshots simultaneously.</li><br><li>Composite recording</li><br><li>web page recording mode, only web page recording, or both web page recording to CDN.</li><br></p> |
| snapshotConfig | [snapshot ](configuration schema) |                     false | Video screenshot configuration item.<p><b>Note: </b>Only need to set when <b></b>using the screenshot function in single-stream recording mode.</p><br>**Screenshot **usage notice:<br> - The screenshot function is only applicable to Individual Recording mode (`individual`). <br>- You can either take screenshots in a single-stream recording process, or record and take screenshots at the same time. For more information, please refer to [the video screenshot at ](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/snapshot). The situation of simultaneous recording and screenshot requires setting the `recordingFileConfig` field. <br>- If the recording service or recording upload service is abnormal, the screenshot will fail. Recording is not affected when there is a screenshot exception. <br>`streamTypes` must be 1 or 2. If you have set `subscribeAudioUid`, you must also set `subscribeVideoUids`. |
| extensionServiceConfig has the following fields: | [extension service configuration ](for schema extensions.) |                     false | Extend service configuration options.<br><p><b>Note: </b>Only need to set in <b>web page recording </b>mode.</p> |
| appsCollection | [appsCollection](#schemaappscollection) |                     false | Application configuration item.<br><p><b>Note: </b>This setting is only required when in <b>Individual Recording mode </b>and when delayed transcoding or delayed mixing is enabled.</p> |
| transcodeOptions | [transcodeOptions](#schematranscodeoptions) |                     false | Configuration options for the recorded files generated under time-delay transcoding or time-delay mixing.<br><p><b>Note: </b>This setting is only required when in <b>Individual Recording mode </b>and when delayed transcoding or delayed mixing is enabled.</p> |

## storageConfig
<!-- backwards compatibility -->
<a id="schemastorageconfig"></a>




```json
{
  "vendor": 0,
  "region": 0,
  "bucket": "string",
  "accessKey": "string",
  "secretKey": "string",
  "fileNamePrefix": [
    String
  ],
  "extensionParams": {
    "sse": "string",
    "tag": "string"
  }
}
```

Configuration options for third-party cloud storage.

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| vendor | number |                     true | Third-party cloud storage platform. <br>- `1`:[ Amazon S3 ](https://aws.amazon.com/s3/)<br>
- `2`: [Alibaba ](Cloud https://www.aliyun.com/product/oss)<br>
- `3`: Tencent Cloud https://cloud.tencent.com/product/cos)<br>
- `5`:[ Microsoft Azure ](https://azure.microsoft.com/en-us/products/storage/blobs/)<br>
- `6`: Google Cloud https://cloud.google.com/storage)<br>
- `7`: Huawei Cloud https://www.huaweicloud.com/product/obs.html)<br>
- `8`: Baidu [Intelligent ](Cloud https://cloud.baidu.com/product/bos.html[]([]([]() |
| region | number |                     true | (Required) The region information specified for the third-party cloud storage. <br><br><b>Note:</b> To ensure the success rate and real-time upload of recorded files, the region of the third-party cloud storage must be the same as the` region` of the application server where you initiate the request. For example, if the app server you are requesting is located in mainland China, then the third-party cloud storage needs to be set within the mainland China region. See [the third-party storage area description at ](https://doc.shengwang.cn/api-ref/cloud-recording/restful/region-vendor).</br> |
| bucket | string |                     true | Third-party cloud storage bucket. The bucket name needs to comply with the naming rules of the corresponding third-party cloud storage service. |
| accessKey | string |                     true | Access Key for third-party cloud storage. If transcoding delay is required, the access key must have read and write permissions; otherwise, it is recommended to only provide write permissions. |
| secretKey | string |                     true | (Required) The secret key of the third-party cloud storage. |
| fileNamePrefix | arraystring[] |                     false | The storage location of the recorded files in the third-party cloud storage is related to the prefix of the file name. For example, if fileNamePrefix = `["directory1","directory2"]`, Agora Cloud Recording will add the prefix `"directory1/directory2/"` before the name of the recorded file, that is, `directory1/directory2/xxx.m3u8`. The prefix's length, including the slashes, should not exceed 128 characters. The string itself should not contain symbols such as slash, underscore, or parenthesis. The following are the supported character set ranges:<br> 26 lowercase English letters a-~z26<br> uppercase English letters A~-Z10<br> numbers 0-9 |
| extensionParams | [extensionParams](#schemaextensionparams) |                     false | Third-party cloud storage services will encrypt and tag the uploaded recording files according to this field setting. |

## extensionParams
<!-- backwards compatibility -->
<a id="schemaextensionparams"></a>




```json
{
  "sse": "string",
  "tag": "string"
}
```

Third-party cloud storage services will encrypt and tag the uploaded recording files according to this field setting.

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| see | string |                     true | The encryption mode. After setting this field, the third-party cloud storage service will encrypt the uploaded recording files according to this encryption mode. This field is only applicable to Amazon S3, see the[ official Amazon S3 documentation at ](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/UsingEncryption.html). <br>- `kms`: KMS encryption. <br>- `aes256`: AES256 encryption. |
| tag | string |                     true | Tag content. After setting this field, the third-party cloud storage service will tag the uploaded recording files according to the content of this tag. This field is only applicable to Alibaba Cloud and Amazon S3. For more information, please refer to [the official Alibaba Cloud documentation at ](https://help.aliyun.com/zh/oss/user-guide/object-tagging-8) and the[ official Amazon S3 documentation at ](https://docs.aws.amazon.com/zh_cn/AmazonS3/latest/userguide/UsingEncryption.html). |

## recordingConfig
<!-- backwards compatibility -->
<a id="schemarecordingconfig"></a>




```json
{
  "channelType": 0
  "decryptionMode": 0,
  "secret": "string"
  "salt": "string",
  "maxIdleTime": 30,
  "streamTypes": 2,
                    VideoStreamType
  "subscribeAudioUids": [
    String
  ],
  "unsubscribeAudioUids": [
    String
  ],
  "subscribeVideoUids": [
    String
  ],
  "unsubscribeVideoUids": [
    String
  ],
  "subscribeUidGroup": 0,
  "streamMode": "default",
  "audioProfile": 0,
  "transcodingConfig": {
    width: 160,
    height = 640;
    "fps": 15,
    bitrate: 120,
    "maxResolutionUid": "string",
    "mixedVideoLayout": 0,
    backgroundColor(0x000000),
    "backgroundImage": "string",
    "default user background image: "string""
    "layoutConfig": [
      {
        "uid": "string",
        "x_axis": 1,
        "y_axis": 1,
        "width": 1,
        "height": 1,
        "alpha": 1,
        "render_mode": 0
      }
    ],
    "backgroundConfig": [
      {
        "uid": "string",
        "image_url": "string",
        "render_mode": 0
      }
    ]
  }
}
```

Recorded audio and video stream configuration options.
<p><b>Note: </b>Only need to set in <b>Individual Recording </b>and <b>composite recording </b>modes.</p>

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| channelType | number |                     true | The channel profile. <br>- `0`: Communication scenario. <br>- `1`: Live streaming scene. <br>The channel scene must be consistent with the Agora RTC SDK, otherwise it may cause issues. |
| decryption mode | number |                     false | The encryption mode. If you have set channel encryption in the SDK client, you need to set the same decryption mode for the Cloud Recording recording service. <br>- `0`: No encryption. <br>- `1`: AES_128_XTS encryption mode. 128-bit AES encryption, XTS mode. <br>- `2`: AES_128_ECB encryption mode. 128-bit AES encryption, ECB mode. <br>- `3`: AES_256_XTS encryption mode. 256-bit AES encryption, XTS mode. <br>- `4`: SM4_128_ECB encryption mode. 128-bit SM4 encryption, ECB mode. <br>- `5`: AES_128_GCM encryption mode. 128-bit AES encryption, GCM mode. <br>- `6`: AES_256_GCM encryption mode. 256-bit AES encryption, GCM mode. <br>- `7`: AES_128_GCM2 encryption mode. 128-bit AES encryption, GCM mode. Compared to AES_128_GCM encryption mode, AES_128_GCM2 encryption mode has higher security and requires setting a key and salt. <br>- `8`: AES_256_GCM2 encryption mode. 256-bit AES encryption, GCM mode. Compared to the AES_256_GCM encryption mode, the AES_256_GCM2 encryption mode is more secure and requires setting a key and salt. |
| secret | string |                     false | Keys related to encryption and decryption. Only needs to be set when `decryptionMode` is not `0`. |
| salt | string |                     false | Salt related to encryption and decryption. Base64 encoding, 32-bit bytes. Only need to set when `decryptionMode` is `7` or `8`. |
| maxIdleTime | number |                     false | Maximum channel idle time. The unit is seconds. The parameter cannot exceed 30. The recording service will automatically exit after exceeding the maximum channel idle time. The value range is from 5 to 232-1. Once the recording stops, the recording service generates new recorded files if you call` start` for the second time.<br><p>Channel idle: There are no broadcasters in the live channel, or there are no users in the communication channel.</p> |
| streamTypes | number |                     false | Subscribed media stream type. <br>`0`: Subscribes to audio streams only. Suitable for smart voice review scenarios. <br>`1`: Subscribes to video streams only. <br>- `2`: Subscribe to audio and video. |
|                     VideoStreamType | number |                     false | Sets the stream type of the remote video. If you enable dual-stream mode in the SDK client, you can choose to subscribe to either the high-quality video stream or the low-quality video stream. <br>- `0`: Video high-quality video stream, which refers to high-resolution and high-bitrate video stream.<br>
- `1`: Video low-quality video stream, which refers to low-resolution and low-bitrate video stream. |
| subscribeAudioUids | arraystring[] |                     false | Specify which audio streams to subscribe to for the specified UIDs. If you want to subscribe to the audio stream of all UIDs, you don't need to set this field. The length of the array should not exceed 32 UIDs. Only one of the fields, ``unsubscribeAudioUids`` and `unsubscribeAudioUids`, can be set. See the [subscription list settings at ](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe).<br><p><b>Note:</b><br><li>This field is only applicable when the <b>streamTypes</b> are set to audio, or audio and video.</li><br><li>If you set up a subscription list for audio, but not for video, then Agora Cloud Recording will not subscribe to any video streams. If you set up a subscription list for video, but not for audio, then Agora Cloud Recording will not subscribe to any audio streams.</li><br><li>Set to <b>["#allstream#"]</b> to subscribe to the audio streams of all UIDs in the channel.</li><br></p> |
| unsubscribe audio UIDs | arraystring[] |                     false | Specify which UID audio streams not to subscribe to. Once you set this parameter, the recording service subscribes to the audio of all UIDs except the specified ones. The length of the array should not exceed 32 UIDs. Only one of the fields, subscribeAudioUid and `subscribeAudioUids`, can be set. See the [subscription list settings at ](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe). |
| subscribeVideoUids | arraystring[] |                     false | Specify which UID's video streams to subscribe to. If you want to subscribe to the video stream of all UIDs, you don't need to set this field. The length of the array should not exceed 32 UIDs. Only one of the fields, ``unsubscribeVideoUids``, can be set. See the [subscription list settings at ](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe).<br><p><b>Note:</b><br><li>This field is only applicable when the <b>streamTypes</b> are set to video, or audio and video.</li><br><li>If you set up a subscription list for audio, but not for video, then Agora Cloud Recording will not subscribe to any video streams. If you set up a subscription list for video, but not for audio, then Agora Cloud Recording will not subscribe to any audio streams.</li><br><li>Set to <b>["#allstream#"]</b> to subscribe to the video streams of all UIDs in the channel.</li><br></p> |
| unsubscribe video UIDs | arraystring[] |                     false | Specify which UID's video streams should not be subscribed to. Once you set this parameter, the recording service subscribes to the video of all UIDs except the specified ones. The length of the array should not exceed 32 UIDs. Only one of the fields, either this one or `subscribeVideoUids`, can be set. See the [subscription list settings at ](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe). |
| subscribeUidGroup | number |                     false | Estimated peak number of subscribers. <br>- `0`: 1 to 2 UIDs. <br>- `1`:3 to 7 UIDs. <br>`2`: 8 to 12 UIDs <br>`3`: 13 to 17 UIDs <br>- `4`:17 to 32 UIDs. <br>- `5`:32 to 49 UIDs. <br>**Note**:<br> - Only need to be set in **Individual Recording **mode, and must be filled in Individual Recording mode. <br>For example, if `subscribeVideoUids` is `["100","101","102"] `and `subscribeAudioUids` is `["101","102","103"]`, the number of subscribed users is 4. |
| streamMode | string |                     false | Output mode of media stream. See the [media stream output mode at ](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/stream-mode). <br>- `"default": Default `mode. During the recording process, audio transcoding is performed to generate separate M3U8 audio index files and video index files. <br>- `"standard": Standard `mode. Agora recommends using this mode. During the recording process, audio transcoding is performed to generate separate M3U8 audio index files, video index files, and merged audio and video index files. If VP8 encoding is used on the a Web client, a merged MPD audio-video index file will be generated. <br>- `"original": Original `encoding mode. For [single-stream audio ](non-transcoding recording, please refer to http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/set-individual-nontranscoding). This field only takes effect when subscribing to audio only (`streamTypes` is 0). During the recording process, the audio is not transcoded, and an M3U8 audio index file is generated. <br>**Note**: Only need to set in **Individual Recording **mode. |
|                     AudioProfile
                 | number |                     false | Set the sampling rate, bitrate, encoding mode, and number of channels for the output audio. <br>`0`: Sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 48 Kbps. <br>`1`: Sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 128 Kbps. <br>`2`: Sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 192 Kbps. <br>**Note**: Only need to set in the **composite recording **mode. |
| transcodingConfig | [transcodingConfig](#schematranscodingconfig) |                     false | Video encoding settings. The value can refer to [setting the resolution of the recorded ](output video at http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-output-video-profile).<br><p><b>Note: </b>Only need to set in <b>Individual Recording </b>and <b>composite recording </b>modes.</p> |




## transcodingConfig
<!-- backwards compatibility -->
<a id="schematranscodingconfig"></a>




```json
{
  width: 160,
  height = 640;
  "fps": 15,
  bitrate: 120,
  "maxResolutionUid": "string",
  "mixedVideoLayout": 0,
  backgroundColor(0x000000),
  "backgroundImage": "string",
  "default user background image: "string""
  "layoutConfig": [
    {
      "uid": "string",
      "x_axis": 1,
      "y_axis": 1,
      "width": 1,
      "height": 1,
      "alpha": 1,
      "render_mode": 0
    }
  ],
  "backgroundConfig": [
    {
      "uid": "string",
      "image_url": "string",
      "render_mode": 0
    }
  ]
}
```

Video encoding settings. The value can refer to [setting the resolution of the recorded ](output video at http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-output-video-profile).
<p><b>Note: </b>Only need to set in <b>Individual Recording </b>and <b>composite recording </b>modes.</p>

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| width | number |                     true | The width (pixels) of the video. The product of `width` and `height` cannot exceed 1920 × 1080. |
| height | number |                     true | The height (pixels) of the video. The product of `width` and `height` cannot exceed 1920 × 1080. |
| fps | number |                     true | The frame rate (fps) of the video. |
| bitrate | number |                     true | The bitrate (kbps) of the video. |
| maxResolutionUid | string |                     false | Just need to set it in **vertical layout**. Specify the user UID to display the large window screen. It is a 32</sup>-bit unsigned integer within the range between 1 and (232<sup>-1). |
| mixedVideoLayout | number |                     false | Video merging layout:<br> - `0`: Floating layout. The first user in the channel occupies the full canvas. The other users occupy the small regions on top of the canvas, starting from the bottom left corner. The small regions are arranged in the order of the users joining the channel. This layout supports one full-size region and up to four rows of small regions on top with four regions per row, comprising 17 users. <br>-`1`: Adaptive preference. This is a grid layout. The number of columns and rows and the grid size vary depending on the number of users in the channel. This layout supports up to 17 users. <br>`2`: Vertical layout. One large region is displayed on the left edge of the canvas, and several smaller regions are displayed along the right edge of the canvas. The space on the right supports up to 2 columns of small regions with 8 regions per column. This layout supports up to 17 users. ``<br>`3`: Customized layout. Set the `layoutConfig` parameter to customize the layout. |
| backgroundColor | string |                     false | The background color of the canvas. Fill in an RGB hex value starting with a "#". The default value is `"#000000"`, the black color. |
| backgroundImage | string |                     false | URL of the background image of the video canvas. The display mode of the background image is set to cropped mode.<br><p>cropped mode: prioritize filling the frame. Uniformly scales the video until it fills the visible boundaries (cropped). One dimension of the video may have clipped contents.</p> |
| defaultUserBackgroundImage | string |                     false | The URL of the default user interface background image.<br><p>After configuring this field, when any user stops sending video stream for more than 3.5 seconds, the screen will switch to the background image; if a background image is set separately for a specific UID, this setting will be overridden.</p> |
| layoutConfig | arrayobject[] |                     false | [layoutConfig](#schemalayoutconfig) |
| backgroundConfig | [backgroundConfig](#schemabackgroundconfig) |                     false | User's background image settings. |



## layoutConfig
<!-- backwards compatibility -->
<a id="schemalayoutconfig"></a>

```json
[
  {
    "uid": "string",
    "x_axis": 1,
    "y_axis": 1,
    "width": 1,
    "height": 1,
    "alpha": 1,
    "render_mode": 0
  }
]
```

Layout of the merged screen for users. An array of the configuration of each user's region.
<p><b>Note: </b>Only need to set in <b>custom layout</b>.</p>

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| uid | string |                     false | The string contains the UID of the user displaying the video in the region.<br><p>If this parameter is not specified, the configurations apply in the order of<b></b> the users joining the channel.</p> |
| x_axis | number(float) |                     true | The relative horizontal position of the top-left corner of the region. Layout from left to right, with `0.0` at the extreme left and `1.0` at the extreme right. This field can also be set to the integer 0 or 1. |
| y_axis | number(float) |                     true | The relative vertical position of the top-left corner of the region. Layout from top to bottom, with `0.0` at the top and `1.0` at the bottom. This field can also be set to the integer 0 or 1. |
| width | number(float) |                     true | The relative value of the width of this screen, accurate to six decimal places. This field can also be set to the integer 0 or 1. |
| height | number(float) |                     true | The relative value of the height of this screen, accurate to six decimal places. This field can also be set to the integer 0 or 1. |
| alpha | number(float) |                     false | The transparency of the image. Accurate to six decimal places. The default value is `1.0`.`` |
|                     RENDER_MODE
                 | number |                     false | Screen display mode:<br> - `0`: cropped mode. (Default) Cropped mode. Uniformly scales the video until it fills the visible boundaries (cropped). One dimension of the video may have clipped contents. <br>- `1`: Fit mode. Fit mode. Uniformly scales the video until one of its dimension fits the boundary (zoomed to fit). Areas that are not filled due to the disparity in the aspect ratio will be filled with black. |


## backgroundConfig
<!-- backwards compatibility -->
<a id="schemabackgroundconfig"></a>




```json
[
  {
    "uid": "string",
    "image_url": "string",
    "render_mode": 0
  }
]
```

User's background image settings.

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| uid | string |                     true | The string content is the user UID. |
| image_url | string |                     true | The URL of the user's background image. After setting the background image, if the user stops sending video stream for more than 3.5 seconds, the screen will switch to the background image. <br><br>URL supports the HTTP and HTTPS protocols, and the image formats supported are JPG and BMP. The image size must not exceed 6 MB. The settings will only take effect after the recording service successfully downloads the image; if the download fails, the settings will not take effect. Different field settings may overlap each other. For specific rules, please refer to [the setting background color or background image at ](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite-layout#%E8%BF%9B%E9%98%B6%E8%AE%BE%E7%BD%AE%E8%83%8C%E6%99%AF%E8%89%B2%E6%88%96%E8%83%8C%E6%99%AF%E5%9B%BE).</br> |
|                     RENDER_MODE
                 | number |                     false | Screen display mode:<br> - `0`: cropped mode. (Default) Cropped mode. Uniformly scales the video until it fills the visible boundaries (cropped). One dimension of the video may have clipped contents. <br>- `1`: Fit mode. Fit mode. Uniformly scales the video until one of its dimension fits the boundary (zoomed to fit). Areas that are not filled due to the disparity in the aspect ratio will be filled with black. |

## You cannot set both recordingFileConfig and snapshotConfig at the same time.
<!-- backwards compatibility -->
<a id="schemarecordingfileconfig"></a>


```json
{
  "avFileType": [
    "hls"
  ]
}
```

| name | type | Required | 描述 |
|---|---|---|---|
| avFileType | arraystring[] |                     false | Recorded video file type:<br> - `"hls"`: default value. The format of recorded files is M3U8 and TS. <br>- `"mp4"`: MP4 file. <br>**Note**:<br> - **Individual Recording **mode, and **not only in screenshot **mode, the default values can be used. <br>- **composite recording **and **web page recording** modes, you need to set it as `["hls","mp4"]`. Setting it as `["mp4"]` will result in an error. After setting, the recording file behavior is as follows:<br> - In the composite recording mode, the recording service will create a new MP4 file when the current file duration exceeds about 2 hours or the file size exceeds about 2 GB.<br>    - web page recording mode: The recording service will create a new MP4 file when the current file's duration exceeds `maxVideoDuration`. |

## snapshotConfig
<!-- backwards compatibility -->
<a id="schemasnapshotconfig"></a>




```json
{
  "captureInterval": 10,
  "fileType": [
    "jpg"
  ]
}
```


### properties

| name | type | Required | 描述 |
|---|---|---|---|
| captureInterval | number |                     false | Screenshot cycle for Cloud Recording regular screenshots. The unit is seconds. |
| file type | arraystring[] |                     true | Screenshot file format. fileType can only take `["jpg"]`, setting screenshots to the JPG format. |

## extensionServiceConfig has the following fields:
<!-- backwards compatibility -->
<a id="schemaextensionserviceconfig"></a>

```json
{
  "errorHandlePolicy": "error_abort",
  "extensionServices": [
    {
      "serviceName": "string",
      "errorHandlePolicy": "string",
      "serviceParam": {
        "url": "string",
        "audioProfile": 0,
        "videoWidth": 240,
        "videoHeight": 240,
        "maxRecordingHour": 1,
        VideoBitrate (400),
        "videoFps": 15,
        "mobile": false,
        "maxVideoDuration": 120,
        "on hold": false,
        "readyTimeout": 0
      }
    }
  ]
}
```

Extend service configuration options.
<p><b>Note: </b>Only need to set in <b>web page recording </b>mode.</p>

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| errorHandlePolicy | string |                     false | Error handling policy. You can only set it to the default value, `"error_abort"`, which means that once an error occurs to an extension service, all other non-extension services, such as stream subscription, also stop. |
| extension services | arrayobject[] |                     true | As described below. |
| » serviceName | string |                     true | Name of the extension service:<br> - web_recorder_service: Represents the extension `service for web web `**page recording**. <br>- `rtmp_publish_service`: Represents the extended service for** pushing web page recording to CDN from the relay page**. |
| "errorHandlePolicy" | string |                     false | Error handling strategy within the extension service:<br> - `"error_abort"`: the default and only value during **web page recording**. Stop other extension services when the current extension service encounters an error. <br>- `"error_ignore"`: The default and only value when** web page recording page to CDN**. Other extension services are not affected when the current extension service encounters an error.<br><p>If the web page recording service or recording upload service is abnormal, then pushing to CDN will fail, so if the <b>web page recording </b>service is wrong, it will affect the<b> forwarding of web page recording to CDN</b> service.</p><br><p>When an exception occurs during the process of pushing to CDN, web page recording is not affected.</p> |
| » serviceParam | [serviceParam](#schemaserviceparam) |                     true | Specific configuration items for extending services. |

## serviceParam
<!-- backwards compatibility -->
<a id="schemaserviceparam"></a>




```json
{
  "url": "string",
  "audioProfile": 0,
  "videoWidth": 240,
  "videoHeight": 240,
  "maxRecordingHour": 1,
  VideoBitrate (400),
  "videoFps": 15,
  "mobile": false,
  "maxVideoDuration": 120,
  "on hold": false,
  "readyTimeout": 0
}
```


### properties

#### Scenario One

The following fields need to be set when **web page recording**:

| name | type | Required | 描述 |
|---|---|---|---|
| url | string |                     true | The address of the page to be recorded. |
|                     AudioProfile
                 | number |                     true | Sampling rate, bitrate, encoding mode, and number of channels for audio output. <br>`0`: Sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 48 Kbps. <br>`1`: Sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 128 Kbps. <br>`2`: Sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 192 Kbps. |
| videoWidth | number |                     true | The video width (pixel). The product of` videoWidth` and `videoHeight` should not exceed 921,600 (1280 × 720). The recommended value can refer to [how to set the output video resolution of the ](page recording mobile web mode). |
| videoHeight | number |                     true | The video height (pixel). The product of` videoWidth` and `videoHeight` should not exceed 921,600 (1280 × 720). The recommended value can refer to [how to set the output video resolution of the ](page recording mobile web mode). |
| maxRecordingHour | number |                     true | The maximum duration web page recording, in hours. The web page recording will automatically stop after exceeding this value. <br>The recommended value should not exceed the value you set in the `acquire` method for `resourceExpiredHour`.<br><p><b>Billing related</b>: Billing will continue until web page recording is stopped, so please set a reasonable value or actively stop the web page recording based on the actual business situation.</p> |
| videoBitrate | number |                     false | The bitrate (Kbps) of the output video stream. For different output video resolutions, the default value of videoBitrate is different:<br> - Output` video` resolution greater than or equal to 1280 × 720: default value is 2000. <br>- Output video resolution is less than 1280 × 720: the default value is 1500. |
| videoFps | number |                     false | The frame rate (fps) of the video. |
| mobile | boolean |                     false | Whether to enable mobile web mode:<br> - `true`: enable. After enabling, the recording service uses the mobile web rendering mode to record the current page. *<br> - `false`: (default) not shown. |
| maxVideoDuration | number |                     false | web page recording maximum duration of the MP4 sliced files generated by page recording, in minutes. During the web page recording process, the recording service will create a new MP4 slice file when the current MP4 file duration exceeds approximately `maxVideoDuration`. |
| on hold | boolean |                     false | Should the web page recording be paused when starting a task on web page recording. <br>- `true`: Pause web page recording when starting a recording task web page recording. After starting the web page recording task, immediately pause the recording. The recording service will open and render the page to be recorded, but will not generate slice files. <br>- `false`: Start a web page recording task and perform web page recording. <br>We suggest using the `onhold` field<br> according to the following process: 1. Set onhold to `true` when calling the `start` method, which will start and pause web page recording. Determine the appropriate time to start web page recording `on `your own. <br>2. Call `update` and set `onhold` to `false`, continue with web page recording. If you need to pause or resume web page recording by continuously calling the` update` method, please make the call after receiving the response from the previous `update`, otherwise it may cause inconsistent results with expectations. |
| readyTimeout | number |                     false | Set the page load timeout in seconds. See [page load timeout detection at ](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/web-mode/detect-timeout). <br>Set to `0` or not set, which means the web page loading status is not detected. <br>-[ An integer between 1 and 60], representing the page load timeout. |

#### Scenario 2

**web page recording to the CDN**, the following fields need to be set.

| name | type | Required | 描述 |
|---|---|---|---|
| outputs | arrayobject[] |                     true | As described below. |
| rtmpUrl | string |                     true | The CDN streaming address. |


## appsCollection
<!-- backwards compatibility -->
<a id="schemaappscollection"></a>




```json
{
  "combinationPolicy": "default"
}
```

Application configuration item.
<p><b>Note: </b>This setting is only required when in <b>Individual Recording mode </b>and when delayed transcoding or delayed mixing is enabled.</p>

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| combinationPolicy | string |                     false | The combination of Cloud Recording applications. <br>- `postpone_transcoding`: Use this method if you need to delay transcoding or delay mixing. <br>- `default`: This method is used for everything except for delayed transcoding and delayed mixing. |

## transcodeOptions
<!-- backwards compatibility -->
<a id="schematranscodeoptions"></a>




```json
{
  "transConfig": {
    "transMode": "string"
  },
  "container": {
    "format": "string"
  },
  "audio": {
    "sampleRate": "48000",
    "bitrate": "48000",
    "channels": "2"
  }
}
```

Configuration options for the recorded files generated under time-delay transcoding or time-delay mixing.
<p><b>Note: </b>This setting is only required when in <b>Individual Recording mode </b>and when delayed transcoding or delayed mixing is enabled.</p>

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| transConfig | object |                     true | As described below. |
| » transMode | string |                     true | Mode: <br>`"postponeTranscoding"`: Delay transcoding. <br>- `"audioMix"`: Delayed mixing. |
| container | object |                     false | As described below. |
| format | string |                     false | The container format of the file, supports the following values:<br> - `"mp4"`: the default format for transcoding with delay. MP4 format. <br>- `"mp3"`: The default format for delay mixing. MP3 format. <br>- `"m4a"`: M4A format. <br>- `"aac"`: AAC format. <br>**Note**: Delayed transcoding can currently only be set to MP4 format. |
| audio | object |                     false | Audio properties of the file.<br><p><b>Note: </b>This setting is only required when recording in <b>Individual Recording mode </b>and enabling <b>delay mixing</b>.</p> |
| sampleRate | string |                     false | Audio sampling rate (Hz), supports the following values:<br> - `"48000"`: 48 kHz.<br> - `"32000"`：32 kHz。 <br>- `"16000"`：16 kHz。 |
| bitrate | string |                     false | Audio bitrate (Kbps), supports and defaults to `"48000"`. |
| channels | string |                     false | Audio channel number, supports the following values:<br> - `"1"`: mono. <br>- `"2"`: Stereo. |

## acquire-response
<!-- backwards compatibility -->
<a id="schemaacquire-response"></a>




```json
{
  "cname": "string",
  "uid": "string",
  "resourceId": "string"
}
```

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| cname | string |                     false | The name of the channel to be recorded. |
| uid | string |                     false | The string content is the UID used by the Cloud Recording service in the RTC channel to identify the recording service within the channel. |
| resourceId | string |                     false | Cloud Recording resource ID. You can start Cloud Recording with this Resource ID. The validity period of this Resource ID is 5 minutes. If it times out, you need to request it again. |



## start-request
<!-- backwards compatibility -->
<a id="schemastart-request"></a>




```json
{
  "cname": "string",
  "uid": "string",
  "clientRequest": {
    "token": "string",
    "storageConfig": {
      "vendor": 0,
      "region": 0,
      "bucket": "string",
      "accessKey": "string",
      "secretKey": "string",
      "fileNamePrefix": [
        String
      ],
      "extensionParams": {
        "sse": "string",
        "tag": "string"
      }
    },
    "recordingConfig": {
      "channelType": 0
      "decryptionMode": 0,
      "secret": "string"
      "salt": "string",
      "maxIdleTime": 30,
      "streamTypes": 2,
                    VideoStreamType
      "subscribeAudioUids": [
        String
      ],
      "unsubscribeAudioUids": [
        String
      ],
      "subscribeVideoUids": [
        String
      ],
      "unsubscribeVideoUids": [
        String
      ],
      "subscribeUidGroup": 0,
      "streamMode": "default",
      "audioProfile": 0,
      "transcodingConfig": {
        width: 160,
        height = 640;
        "fps": 15,
        bitrate: 120,
        "maxResolutionUid": "string",
        "mixedVideoLayout": 0,
        backgroundColor(0x000000),
        "backgroundImage": "string",
        "default user background image: "string""
        "layoutConfig": [
          {
            "uid": "string",
            "x_axis": 1,
            "y_axis": 1,
            "width": 1,
            "height": 1,
            "alpha": 1,
            "render_mode": 0
          }
        ],
        "backgroundConfig": [
          {
            "uid": "string",
            "image_url": "string",
            "render_mode": 0
          }
        ]
      }
    },
    You cannot set both recordingFileConfig and snapshotConfig at the same time.
      "avFileType": [
        "hls"
      ]
    },
    "snapshotConfig": {
      "captureInterval": 10,
      "fileType": [
        "jpg"
      ]
    },
    extensionServiceConfig has the following fields:
      "errorHandlePolicy": "error_abort",
      "extensionServices": [
        {
          "serviceName": "string",
          "errorHandlePolicy": "string",
          "serviceParam": {
            "url": "string",
            "audioProfile": 0,
            "videoWidth": 240,
            "videoHeight": 240,
            "maxRecordingHour": 1,
            VideoBitrate (400),
            "videoFps": 15,
            "mobile": false,
            "maxVideoDuration": 120,
            "on hold": false,
            "readyTimeout": 0
          }
        }
      ]
    },
    "appsCollection": {
      "combinationPolicy": "default"
    },
    transcodeOptions
      "transConfig": {
        "transMode": "string"
      },
      "container": {
        "format": "string"
      },
      "audio": {
        "sampleRate": "48000",
        "bitrate": "48000",
        "channels": "2"
      }
    }
  }
}
```

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| cname | string |                     true | The name of the channel where the recording service is located. The cname you input in the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request needs to be the same as` yours`. |
| uid | string |                     true | The string content is the UID used by the recording service in the RTC channel to identify the recording service. It needs to be the same as the UID you input in the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request.`` |
| "clientRequest":{
 | object |                     true | [client-request](#schemaclient-request) |


## update request
<!-- backwards compatibility -->
<a id="schemaupdate-request"></a>




```json
{
  "cname": "string",
  "uid": "string",
  "clientRequest": {
    "streamSubscribe": {
      "audioUidList": {
        "subscribeAudioUids": [
          String
        ],
        "unsubscribeAudioUids": [
          String
        ]
      },
      "videoUidList": {
        "subscribeVideoUids": [
          String
        ],
        "unsubscribeVideoUids": [
          String
        ]
      }
    },
    "webRecordingConfig": {
      "onhold": false
    },
    "rtmpPublishConfig": {
      "outputs": {
        {
          "rtmpUrl": "string"
        }
      ]
    }
  }
}
```

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| cname | string |                     true | The name of the channel where the recording service is located. The cname you input in the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request needs to be the same as` yours`. |
| uid | string |                     true | The string content is the UID used by the recording service in the RTC channel to identify the recording service. It needs to be the same as the UID you input in the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request.`` |
| "clientRequest":{
 | object |                     true | [clientRequest](#schemaclientrequest) |

## "clientRequest":{

<!-- backwards compatibility -->
<a id="schemaclientrequest"></a>




```json
{
  "streamSubscribe": {
    "audioUidList": {
      "subscribeAudioUids": [
        String
      ],
      "unsubscribeAudioUids": [
        String
      ]
    },
    "videoUidList": {
      "subscribeVideoUids": [
        String
      ],
      "unsubscribeVideoUids": [
        String
      ]
    }
  },
  "webRecordingConfig": {
    "onhold": false
  },
  "rtmpPublishConfig": {
    "outputs": {
      {
        "rtmpUrl": "string"
      }
    ]
  }
}
```

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| streamSubscribe | [streamSubscribe](#schemastreamsubscribe) |                     false | Update subscription lists<br><p><b>Note: </b>Only need to set in <b>Individual Recording </b>and <b>composite recording </b>modes.</p> |
| webRecordingConfig | [webRecordingConfig](#schemawebrecordingconfig) |                     false | Used to update web page recording items.<br><p><b>Note: </b>Only need to set in <b>web page recording </b>mode.</p> |
| rtmpPublishConfig | [rtmpPublishConfig](#schemaRtmpPublishConfig) |                     false | Used to update the configuration items recorded to CDN for web page recording.<br><p><b>Note: </b>Only need to set when recording in <b>web page recording </b>mode and<b> pushing web page recording to CDN</b>.<p> |

## streamSubscribe
<!-- backwards compatibility -->
<a id="schemastreamsubscribe"></a>




```json
{
  "audioUidList": {
    "subscribeAudioUids": [
      String
    ],
    "unsubscribeAudioUids": [
      String
    ]
  },
  "videoUidList": {
    "subscribeVideoUids": [
      String
    ],
    "unsubscribeVideoUids": [
      String
    ]
  }
}
```

Update subscription lists
<p><b>Note: </b>Only need to set in <b>Individual Recording </b>and <b>composite recording </b>modes.</p>

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| audioUidList | [audioUidList](#schemaaudiouidlist) |                     false | The audio subscription list.<br><p><b>Note:</b> This field only applies to <b>streamTypes</b> set to audio, or audio and video.</p> |
| videoUidList | [videoUidList](#schemavideouidlist) |                     false | The video subscription list.<br><p><b>Note:</b> This field only applies when the <b>streamTypes</b> are set to video, or audio and video.</p> |

## audioUidList
<!-- backwards compatibility -->
<a id="schemaaudiouidlist"></a>




```json
{
  "subscribeAudioUids": [
    String
  ],
  "unsubscribeAudioUids": [
    String
  ]
}
```

The audio subscription list.
<p><b>Note:</b> This field only applies to <b>streamTypes</b> set to audio, or audio and video.</p>

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| subscribeAudioUids | arraystring[] |                     false | Specify which audio streams to subscribe to for the specified UIDs. If you want to subscribe to the audio stream of all UIDs, you don't need to set this field. The length of the array should not exceed 32 UIDs. Only one of the fields, ``unsubscribeAudioUids`` and `unsubscribeAudioUids`, can be set. See the [subscription list settings at ](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe).<br><p><b>Note:</b><br><li>This field is only applicable when the <b>streamTypes</b> are set to audio, or audio and video.</li><br><li>If you set up a subscription list for audio, but not for video, then Agora Cloud Recording will not subscribe to any video streams. If you set up a subscription list for video, but not for audio, then Agora Cloud Recording will not subscribe to any audio streams.</li><br><li>Set to <b>["#allstream#"]</b> to subscribe to the audio streams of all UIDs in the channel.</li><br></p> |
| unsubscribe audio UIDs | arraystring[] |                     false | Specify which UID audio streams not to subscribe to. Once you set this parameter, the recording service subscribes to the audio of all UIDs except the specified ones. The length of the array should not exceed 32 UIDs. Only one of the fields, subscribeAudioUid and `subscribeAudioUids`, can be set. See the [subscription list settings at ](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe). |

## videoUidList
<!-- backwards compatibility -->
<a id="schemavideouidlist"></a>




```json
{
  "subscribeVideoUids": [
    String
  ],
  "unsubscribeVideoUids": [
    String
  ]
}
```

The video subscription list.
<p><b>Note:</b> This field only applies when the <b>streamTypes</b> are set to video, or audio and video.</p>

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| subscribeVideoUids | arraystring[] |                     false | Specify which UID's video streams to subscribe to. If you want to subscribe to the video stream of all UIDs, you don't need to set this field. The length of the array should not exceed 32 UIDs. Only one of the fields, ``unsubscribeVideoUids``, can be set. See the [subscription list settings at ](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe).<br><p><b>Note:</b><br><li>This field is only applicable when the <b>streamTypes</b> are set to video, or audio and video.</li><br><li>If you set up a subscription list for audio, but not for video, then Agora Cloud Recording will not subscribe to any video streams. If you set up a subscription list for video, but not for audio, then Agora Cloud Recording will not subscribe to any audio streams.</li><br><li>Set to <b>["#allstream#"]</b> to subscribe to the video streams of all UIDs in the channel.</li><br></p> |
| unsubscribeVideoUids | arraystring[] |                     false | Specify which UID's video streams should not be subscribed to. Once you set this parameter, the recording service subscribes to the video of all UIDs except the specified ones. The length of the array should not exceed 32 UIDs. Only one of the fields, either this one or `subscribeVideoUids`, can be set. See the [subscription list settings at ](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe). |

## webRecordingConfig
<!-- backwards compatibility -->
<a id="schemawebrecordingconfig"></a>




```json
{
  "onhold": false
}
```

Used to update web page recording items.
<p><b>Note: </b>Only need to set in <b>web page recording </b>mode.</p>

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| on hold | boolean |                     false | Should the web page recording be paused when starting a task on web page recording. <br>- `true`: Pause web page recording when starting a recording task web page recording. After starting the web page recording task, immediately pause the recording. The recording service will open and render the page to be recorded, but will not generate slice files. <br>- `false`: Start a web page recording task and perform web page recording. <br>We suggest using the `onhold` field<br> according to the following process: 1. Set onhold to `true` when calling the `start` method, which will start and pause web page recording. Determine the appropriate time to start web page recording `on `your own. <br>2. Call `update` and set `onhold` to `false`, continue with web page recording. If you need to pause or resume web page recording by continuously calling the` update` method, please make the call after receiving the response from the previous `update`, otherwise it may cause inconsistent results with expectations. |

## rtmpPublishConfig
<!-- backwards compatibility -->
<a id="schemartmppublishconfig"></a>




```json
{
  "outputs": {
    {
      "rtmpUrl": "string"
    }
  ]
}
```

Used to update the configuration items recorded to CDN for web page recording.
<p><b>Note: </b>Only need to set when recording in <b>web page recording </b>mode and<b> pushing web page recording to CDN</b>.<p>

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| outputs | arrayobject[] |                     false | As described below. |
| rtmpUrl | string |                     false | The CDN live streaming URL.<br><p><b>Note</b>:<br><li>URL only supports RTMP and RTMPS protocols.</li><br><li>The maximum number of supported CDN routes for retweeting is 1.</li><br></p> |

## updateLayout-request
<!-- backwards compatibility -->
<a id="schemaupdatelayout-request"></a>




```json
{
  "cname": "string",
  "uid": "string",
  "clientRequest": {
    "maxResolutionUid": "string",
    "mixedVideoLayout": 0,
    backgroundColor(0x000000),
    "backgroundImage": "string",
    "default user background image: "string""
    "layoutConfig": [
      {
        "uid": "string",
        "x_axis": 1,
        "y_axis": 1,
        "width": 1,
        "height": 1,
        "alpha": 1,
        "render_mode": 0
      }
    ],
    "backgroundConfig": [
      {
        "uid": "string",
        "image_url": "string",
        "render_mode": 0
      }
    ]
  }
}
```


### properties

| name | type | Required | 描述 |
|---|---|---|---|
| cname | string |                     true | The name of the channel where the recording service is located. The cname you input in the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request needs to be the same as` yours`. |
| uid | string |                     true | The string content is the UID used by the recording service in the RTC channel to identify the recording service. It needs to be the same as the UID you input in the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request.`` |
| "clientRequest":{
 | object |                     true | [clientRequest-updateLayout](#schemaclientrequest-updatelayout) |

## clientRequest-updateLayout
<!-- backwards compatibility -->
<a id="schemaclientrequest-updatelayout"></a>




```json
{
  "maxResolutionUid": "string",
  "mixedVideoLayout": 0,
  backgroundColor(0x000000),
  "backgroundImage": "string",
  "default user background image: "string""
  "layoutConfig": [
    {
      "uid": "string",
      "x_axis": 1,
      "y_axis": 1,
      "width": 1,
      "height": 1,
      "alpha": 1,
      "render_mode": 0
    }
  ],
  "backgroundConfig": [
    {
      "uid": "string",
      "image_url": "string",
      "render_mode": 0
    }
  ]
}
```

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| maxResolutionUid | string |                     false | Just need to set it in **vertical layout**. Specify the user UID to display the large window screen. It is a 32</sup>-bit unsigned integer within the range between 1 and (232<sup>-1). |
| mixedVideoLayout | number |                     false | Video merging layout:<br> - `0`: Floating layout. The first user in the channel occupies the full canvas. The other users occupy the small regions on top of the canvas, starting from the bottom left corner. The small regions are arranged in the order of the users joining the channel. This layout supports one full-size region and up to four rows of small regions on top with four regions per row, comprising 17 users. <br>-`1`: Adaptive preference. This is a grid layout. The number of columns and rows and the grid size vary depending on the number of users in the channel. This layout supports up to 17 users. <br>`2`: Vertical layout. One large region is displayed on the left edge of the canvas, and several smaller regions are displayed along the right edge of the canvas. The space on the right supports up to 2 columns of small regions with 8 regions per column. This layout supports up to 17 users. ``<br>`3`: Customized layout. Set the `layoutConfig` parameter to customize the layout. |
| backgroundColor | string |                     false | The background color of the canvas. Fill in an RGB hex value starting with a "#". The default value is `"#000000"`, the black color. |
| backgroundImage | string |                     false | URL of the background image of the video canvas. The display mode of the background image is set to cropped mode.<br><p>cropped mode: prioritize filling the frame. Uniformly scales the video until it fills the visible boundaries (cropped). One dimension of the video may have clipped contents.</p> |
| defaultUserBackgroundImage | string |                     false | The URL of the default user interface background image.<br><p>After configuring this field, when any user stops sending video stream for more than 3.5 seconds, the screen will switch to the background image; if a background image is set separately for a specific UID, this setting will be overridden.</p> |
| layoutConfig | arrayobject[] |                     false | [layoutConfig](#schemalayoutconfig) |
| backgroundConfig | arrayobject[] |                     false | [backgroundConfig](#schemabackgroundconfig) |

## query-response
<!-- backwards compatibility -->
<a id="schemaquery-response"></a>




```json
{
        "resourceId": "xxxxxx",
  "sid": "string",
  "serverResponse": {
        "status": 2,
    "extensionServiceState": [
      {
        "payload": {...}
          "fileList": [
            {
              "filename": "string",
              "sliceStartTime": 0
            }
          ],
          "on hold": true,
          "state": "string"
        },
        "serviceName": "string"
      }
    ]
  },
  "cname": "string",
  "uid": "string"
}
```

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| resourceId | string |                     false | Resource ID used Cloud Recording. |
| sid | string |                     false | Recording ID |
| serverResponse | object |                     false | [serverResponse](#schemaserverresponse) |
| cname | string |                     false | The name of the channel to be recorded. |
| uid | string |                     false | The string content is the UID used by the Cloud Recording service in the RTC channel to identify the recording service within the channel. |

## serverResponse
<!-- backwards compatibility -->
<a id="schemaserverresponse"></a>




```json
{
        "status": 2,
  "extensionServiceState": [
    {
      "payload": {...}
        "fileList": [
          {
            "filename": "string",
            "sliceStartTime": 0
          }
        ],
        "on hold": true,
        "state": "string"
      },
      "serviceName": "string"
    }
  ]
}
```

### properties

#### Scenario One

Fields returned in **web page recording **mode.

| name | type | Required | 描述 |
|---|---|---|---|
| status | number |                     false | Current status of cloud service:<br> - `0`: Cloud service has not started. <br>`1`: The initialization is complete. <br>`2`: The cloud service is starting. <br>`3`: The cloud service is partially ready. <br>`4`: The cloud service is ready. <br>`5`: The cloud service is in progress. <br>`6`: The cloud service receives the request to stop. <br>`7`: The cloud service stops. <br>`8`: The cloud service exits. <br>`20`: The cloud service exits abnormally. |
| arrayobject[] |                     false | extensionServiceState | [extensionServiceState](#schemaextensionservicestate) |

#### Scenario 2

**Individual Recording **when **video screenshot is enabled in single-stream recording **mode.

| name | type | Required | 描述 |
|---|---|---|---|
| status | number |                     false | Current status of cloud service:<br> - `0`: Cloud service has not started. <br>`1`: The initialization is complete. <br>`2`: The cloud service is starting. <br>`3`: The cloud service is partially ready. <br>`4`: The cloud service is ready. <br>`5`: The cloud service is in progress. <br>`6`: The cloud service receives the request to stop. <br>`7`: The cloud service stops. <br>`8`: The cloud service exits. <br>`20`: The cloud service exits abnormally. |
| sliceStartTime | number |                     false | The start time of the new file recording, the Unix timestamp, in seconds. |

#### Case three

Fields returned in scenes other than single-stream video screenshots and page recording.

| name | type | Required | 描述 |
|---|---|---|---|
| status | number |                     false | Current status of cloud service:<br> - `0`: Cloud service has not started. <br>`1`: The initialization is complete. <br>`2`: The cloud service is starting. <br>`3`: The cloud service is partially ready. <br>`4`: The cloud service is ready. <br>`5`: The cloud service is in progress. <br>`6`: The cloud service receives the request to stop. <br>`7`: The cloud service stops. <br>`8`: The cloud service exits. <br>`20`: The cloud service exits abnormally. |
| fileListMode | string |                     false | `fileList` 字段的数据格式：<br>- `"string"`：`fileList` 为 String 类型。 composite recording mode, if `avFileType` is set to `["hls"]`, `fileListMode` is `"string"`. <br>`"json"`: `fileList` is a JSONArray. When `avFileType` is set to `["hls","mp4"] in single-composite` recording recording mode, `fileListMode` is set to `"json"`. |
| fileList | [fileList-string](#schemafilelist-string) or [fileList-json](#schemafilelist-json) |                     false | [fileList-string](#schemafilelist-string) or [fileList-json](#schemafilelist-json) |
| sliceStartTime | number |                     false | The start time of the new file recording, the Unix timestamp, in seconds. |

## fileList-string
<a id="schemafilelist-string"></a>

| type | Required | 描述 |
|---|---|---|
| string |                     false | The file name of the M3U8 file generated during recording. |


## extensionServiceState
<!-- backwards compatibility -->
<a id="schemaextensionservicestate"></a>




```json
[
  {
    "payload": {...}
      "fileList": [
        {
          "filename": "string",
          "sliceStartTime": 0
        }
      ],
      "on hold": true,
      "state": "string"
    },
    "serviceName": "string"
  }
]
```

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| payload | object |                     false | [payload](#payload) |
| serviceName | string |                     false | Name of the extension service:<br> - web_recorder_service: Represents the extension `service for web web `**page recording**. <br>- `rtmp_publish_service`: Represents the extended service for** pushing web page recording to CDN from the relay page**. |

## payload

### properties

#### Scenario One

The following fields will be returned during web page recording.

| name | type | Required | 描述 |
|---|---|---|---|
| fileList | arrayobject[] |                     false | As described below. |
| filename | string |                     false | The file names of the M3U8 and MP4 files generated during recording. |
| » sliceStartTime | number |                     false | The start time of the new file recording, the Unix timestamp, in seconds. |
| on hold | boolean |                     false | web page recording in pause state:<br> - `true`: in pause state. <br>- `false`: in running state. |
| state | string |                     false | The status of uploading subscription content to the extension service:<br> - `"init"`: Service is initializing. <br>- `"inProgress"`: The service has started and is currently in progress. <br>- `"exit"`: Service exit. |

#### Scenario 2

When recording the web page recording to CDN, the following fields will be returned.

| name | type | Required | 描述 |
|---|---|---|---|
| outputs | arrayobject[] |                     false | As described below. |
| rtmpUrl | string |                     false | The CDN streaming address. |
| status | string |                     false | web page recording current streaming status:<br> - `"connecting": connecting` to the CDN server. <br>- `"publishing"`: currently streaming. <br>- `"onhold"`: Set whether to pause the live stream. <br>`"Disconnected"`: Failed to connect to the CDN server. Agora suggests that you change the CDN streaming address. |
| state | string |                     false | The status of uploading subscription content to the extension service:<br> - `"init"`: Service is initializing. <br>- `"inProgress"`: The service has started and is currently in progress. <br>- `"exit"`: Service exit. |


## fileList-json
<!-- backwards compatibility -->
<a id="schemafilelist-json"></a>


```json
[
  {
    "fileName": "string",
    "trackType": "string",
    "uid": "string",
    "mixedAllUser": true,
    "isPlayable": true,
    "sliceStartTime": 0
  }
]
```
arrayobject [type].

### properties

| name | type | Required | 描述 |
|---|---|---|---|
| filename | string |                     false | The file names of the M3U8 and MP4 files generated during recording. |
| trackType | string |                     false | The format of the recording file. <br>`"audio": Audio `file. <br>`"video": Video `file (no audio). <br>`"audio_and_video": Video `file (with audio). |
| uid | string |                     false | User UID, indicating which user's audio or video stream is being recorded. composite recording mode, the `uid` is `"0"`. |
| mixedAllUser | boolean |                     false | Is the user recorded separately. <br>`true`: All users are recorded in a single file. <br>`false`: Each user is recorded separately. |
| isPlayable | boolean |                     false | Can it be played online? `true`: <br>The file can be played online. `false`: <br>The file cannot be played online. |
| sliceStartTime | number |                     false | The start time of the new file recording, the Unix timestamp, in seconds. |

## stop-request
<!-- backwards compatibility -->
<a id="schemastop-request"></a>




```json
{
  "cname": "string",
  "uid": "string",
  "clientRequest": {
    "async_stop": false
  }
}
```


### properties

| name | type | Required | 描述 |
|---|---|---|---|
| cname | string |                     true | The name of the channel where the recording service is located. The cname you input in the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request needs to be the same as` yours`. |
| uid | string |                     true | The string content is the UID used by the recording service in the RTC channel to identify the recording service. It needs to be the same as the UID you input in the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request.`` |
| "clientRequest":{
 | object |                     true | As described below. |
| » async_stop | boolean |                     false | Set the response mechanism for the` stop` method:<br> - `true`: asynchronous. Immediately receive a response after calling` stop`. <br>- `false`: synchronous. After calling `stop`, you need to wait for all the recorded files to be uploaded to the third-party cloud storage before receiving a response. Agora expects the upload time to be no more than 20 seconds. If the upload exceeds the time limit, you will receive error code `50`. |

## stop response
<!-- backwards compatibility -->
<a id="schemastop-response"></a>




```json
{
        "resourceId": "xxxxxx",
  "sid": "string",
  "serverResponse": {
    "extensionServiceState": [
      {
        "payload": {
          "uploadingStatus": "string"
        },
        "serviceName": "string"
      }
    ]
  },
  "cname": "string",
  "uid": "string"
}
```


### properties

| name | type | Required | 描述 |
|---|---|---|---|
| resourceId | string |                     false | Resource ID used Cloud Recording. |
| sid | string |                     false | Recording ID Identify a recording cycle. |
| serverResponse | object |                     false | [serverResponse](#schemaserverresponse-stop) |
| cname | string |                     false | The name of the channel to be recorded. |
| uid | string |                     false | The string content is the UID used by the Cloud Recording service in the RTC channel to identify the recording service within the channel. |

## serverResponse-stop
<!-- backwards compatibility -->
<a id="schemaserverresponse-stop"></a>




```json
{
  "extensionServiceState": [
    {
      "payload": {
        "uploadingStatus": "string"
      },
      "serviceName": "string"
    }
  ]
}
```

### properties

#### Scenario One

Fields returned web page recording scene.

| name | type | Required | 描述 |
|---|---|---|---|
| extensionServiceState | arrayobject[] |                     false | As described below. |
| playload | object |                     false | [playload-stop](#playload-stop) |
| » serviceName | string |                     false | Service Type:<br> - `"upload_service": Upload service`. <br>- `"web_recorder_service": Web recording service`. |

#### Scenario 2

Fields returned in the screenshot scene of single-stream video.

| name | type | Required | 描述 |
|---|---|---|---|
| uploadingStatus | string |                     false | <br>`"uploaded"`: All the recorded files are uploaded to the third-party cloud storage. <br>`"backuped"`: Some of the recorded files fail to upload to the third-party cloud storage and upload to Agora Cloud Backup instead. Agora Cloud Backup automatically uploads these files to your cloud storage. <br>`"unknown": Unknown `status. |

#### Case three

Fields returned in scenes other than single-stream video screenshots and page recording.

| name | type | Required | 描述 |
|---|---|---|---|
| fileListMode | string |                     false | `fileList` 字段的数据格式：<br>- `"string"`：`fileList` 为 String 类型。 composite recording mode, if `avFileType` is set to `["hls"]`, `fileListMode` is `"string"`. <br>`"json"`: `fileList` is a JSONArray. When `avFileType` is set to `["hls","mp4"] in single-composite` recording recording mode, `fileListMode` is set to `"json"`. |
| fileList | [fileList-string](#schemafilelist-string) or [fileList-json](#schemafilelist-json) |                     false | [fileList-string](#schemafilelist-string) or [fileList-json](#schemafilelist-json) |
| uploadingStatus | string |                     false | <br>`"uploaded"`: All the recorded files are uploaded to the third-party cloud storage. <br>`"backuped"`: Some of the recorded files fail to upload to the third-party cloud storage and upload to Agora Cloud Backup instead. Agora Cloud Backup automatically uploads these files to your cloud storage. <br>`"unknown": Unknown `status. |

## playload-stop

### properties

#### Scenario One

Fields returned **by the upload service in ****web page recording **mode.

| name | type | Required | 描述 |
|---|---|---|---|
| uploadingStatus | string |                     false | <br>`"uploaded"`: All the recorded files are uploaded to the third-party cloud storage. <br>`"backuped"`: Some of the recorded files fail to upload to the third-party cloud storage and upload to Agora Cloud Backup instead. Agora Cloud Backup automatically uploads these files to your cloud storage. <br>`"unknown": Unknown `status. |

#### Scenario 2

**web page recording **by the **web page recording service in page recording mode**.

| name | type | Required | 描述 |
|---|---|---|---|
| fileList | arrayobject[] |                     false | As described below. |
| filename | string |                     false | The file names of the M3U8 and MP4 files generated during recording. |
| » sliceStartTime | number |                     false | The start time of the new file recording, the Unix timestamp, in seconds. |
| on hold | boolean |                     false | web page recording in pause state:<br> - `true`: in pause state. <br>- `false`: in running state. |
| state | string |                     false | The status of uploading subscription content to the extension service:<br> - `"init"`: Service is initializing. <br>- `"inProgress"`: The service has started and is currently in progress. <br>- `"exit"`: Service exit. |


