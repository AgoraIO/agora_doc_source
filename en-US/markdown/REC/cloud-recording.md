
<!-- Generator: Widdershins v4.0.1 -->

# API Overview

Agora Cloud Recording is a component provided by Agora to record and save voice calls, video calls, and interactive streaming. You can send HTTP requests from your business server to the Agora server to perform Cloud Recording on the server side.
- ` acquire`: Request a resource ID for cloud recording.
- ` start`: Call this method within two seconds after getting the resource ID to` start` a cloud recording. During the recording, you can call the following methods as needed:
   - `query`: Check the status of the cloud recording.
   - `update`: Update recording settings.
   - `updateLayout`: Update the video mixing layout.
- `stop`: When a recording finishes, call `stop` to leave the channel and stop the recording.

> Cloud Recording does not support completing multiple tasks in one recording session. For example, if you need to start individual and composite recording for a channel simultaneously, start two recording sessions. More specifically, use two different `uid`s to call `acquire` to obtain two `resourceId`s, and then call `start` separately to start two recording tasks. Both recording sessions are charged.

To monitor the status of your cloud recording, Agora provides the [message notification service](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/enable-ncs). After enabling this service, you can receive [the events related to cloud recording](https://doc.shengwang.cn/api-ref/cloud-recording/restful/webhook/ncs-events) through Webhook.

Because Agora dynamically adjusts the IP addresses of the message notification server, to not affect your reception of events, you need to regularly [query the IP addresses](#opIdget-v1-ncs-ip) and update the firewall whitelist configuration.

## Base URL

`https://api.sd-rtn.com`


## Authentication

When sending an HTTP request, you must use Basic HTTP authentication and fill in the `Authorization `field in the HTTP request header with the generated credentials. For details on generating the `Authorization` field, see [the implementation of HTTP Basic Authentication](https://doc.shengwang.cn/doc/cloud-recording/restful/get-started/authorization).

# Endpoint

## acquire

<a id="opIdpost-v1-apps-appid-cloud_recording-acquire"></a>


`POST /v1/apps/{appid}/cloud_recording/acquire`

*Acquire: Get a cloud recording resource*

Before starting a cloud recording, you need to call the `acquire` method to get a resource ID. One resource ID can only be used for one recording session.


**Note**: To ensure successfully starting cloud recording, proceed as follows:
- The requests for `acquire` and `start` need to be called in pairs.
- Immediately start the corresponding [`start`](#opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start) request within two seconds of getting the resource ID for each `acquire` request. Batch fetching of Resource IDs followed by batch `start` requests may lead to request failure.
- The resource ID is valid within five minutes of getting it and should be used as soon as possible.

> Request body

```json
{
  "cname": "httpClient463224",
  "uid": "527841",
  "clientRequest": {
    "scene": 0,
    "resourceExpiredHour": 24
  }
}
```

### Parameters

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| Content-Type | header | string | false | `application/json`. |
| appid | path | string | true | The [App ID](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id) that your project uses.<li>For web page recording mode, simply enter the App ID for which the cloud recording service is enabled.</li><li>For individual and composite recording modes, you must use the same App ID as the channel to be recorded. Ensure that the cloud recording service has been enabled for this App ID.</li> |
| body | body | JSON Object | true | [acquire-request](#schemaacquire-request) |

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

| status | Description | Schema |
|---|---|---|
| 200 OK | If the returned HTTP status code is `200`, the request is successful. If you set the `startParameter` object in the request body and its value is invalid, it will not affect the success of the` acquire` request, but you will receive an error in the subsequent `start` request. | [acquire-response](#schemaacquire-response) |
| Not 200 | If the HTTP status code is not `200`, see [the response status code](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) for troubleshooting. | [Response status code](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) |


## start

<a id="opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start"></a>


`POST /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/mode/{mode}/start`

*Start: Start a cloud recording*

After getting a cloud recording resources with the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) method, call the `start` method to start a cloud recording.

> After starting the `start` request, you further need to check that the recording service has started successfully according to the [best practices](https://doc.shengwang.cn/doc/cloud-recording/restful/best-practices/integration#确认录制服务已成功启动).

> Request body

```json
{
  "cname": "httpClient463224",
  "uid": "527841",
  "clientRequest": {
    "recordingConfig": {
      "channelType": 1,
      "streamTypes": 2,
      "streamMode": "default",
      "videoStreamType": 0,
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
    "recordingFileConfig": {
      "avFileType": [
        "hls"
      ]
    },
    "storageConfig": {
      "vendor": 2,
      "region": 3,
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

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| Content-Type | header | string | false | `application/json`. |
| appid | path | string | true | The [App ID](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id) that your project uses.<li>For web page recording mode, simply enter the App ID for which the cloud recording service is enabled.</li><li>For individual and composite recording modes, you must use the same App ID as the channel to be recorded. Ensure that the cloud recording service has been enabled for this App ID.</li> |
| resourceid | path | string | true | The resource ID obtained by the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request. |
| mode | path | string | true | The recording modes:<li>`individual`: [Individual recording mode](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/set-individual).</li><li>`mix`: [Composite recording mode](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite).</li><li>`web`: [Web page recording mode](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/web-mode/set-webpage-recording).</li> |
| body | body | JSON Object | true | [start-request](#schema start-request) |

> Example responses

> 200 Response

```json
{
  "cname": "string",
  "uid": "string",
  "resourceId": "string",
  "sid": "string"
}
```

### Responses

| status | Description | Schema |
|---|---|---|
| 200 | If the returned HTTP status code is `200`, the request is successful. To check whether the recording service has started successfully, see the [best practices](https://doc.shengwang.cn/doc/cloud-recording/restful/best-practices/integration#确认录制服务已成功启动) to proceed. | [Response Schema](#response-schema) |
| Not 200 | If the HTTP status code is not `200`, see [the response status code](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) for troubleshooting. | [Response status code](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) |

#### Response Schema

Status Code **200**

| Name | Type | Required | Description |
|---|---|---|---|
| cname | string | false | The name of the channel to be recorded. |
| uid | string | false | The string content is the user ID used by the cloud recording service in the RTC channel to identify the recording service in the channel. |
| resourceId | string | false | The cloud recording resource ID. You can start a cloud recording with this resource ID. The resource ID is valid for five minutes, after which time you need to re-request it. |
| sid | string | false | The recording ID. After successfully starting a cloud recording, you will receive a Sid (the recording ID). This ID uniquely identifies a recording cycle. |



## update

<a id="opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-sid-sid-mode-mode-update"></a>


`POST /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/sid/{sid}/mode/{mode}/update`

*Update: Update the cloud recording settings*

After starting the recording, you can call the `update` method to update the following recording configuration:
- For individual and composite recordings, update the subscription list.
- For the web page recording, set pause/resume the web page recording, or update the CDN streaming address (URL) where the web page recording is pushed to.


> - The` update` request is only valid within the session. If the recording is started incorrectly, or if the recording is finished, the `update` call will return `404`.
> - If you need to call the `update` method successively to update the recording settings, repeat the call after receiving the last `update` response; otherwise, the request result might not be as expected.

> Request body

```json
{
  "cname": "httpClient463224",
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

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| Content-Type | header | string | false | `application/json`. |
| appid | path | string | true | The [App ID](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id) that your project uses.<li>For web page recording mode, simply enter the App ID for which the cloud recording service is enabled.</li><li>For individual and composite recording modes, you must use the same App ID as the channel to be recorded. Ensure that the cloud recording service has been enabled for this App ID.</li> |
| resourceid | path | string | true | The resource ID obtained by the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request. |
| sid | path | string | true | The recording ID obtained through [`start`](#opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start). |
| mode | path | string | true | The recording modes:<li>`individual`: [Individual recording mode](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/set-individual).</li><li>`mix`: [Composite recording mode](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite).</li><li>`web`: [Web page recording mode](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/web-mode/set-webpage-recording).</li> |
| body | body | JSON Object | true | [update-request](#schemaupdate-request) |

> Example responses

> 200 Response

```json
{
  "cname": "string",
  "uid": "string",
  "resourceId": "string",
  "sid": "string"
}
```

### Responses

| status | Description | Schema |
|---|---|---|
| 200 | If the returned HTTP status code is `200`, the request is successful. | [Response Schema](#response-schema-1) |
| Not 200 | If the HTTP status code is not `200`, see [the response status code](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) for troubleshooting. | [Response status code](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) |

#### Response Schema

Status Code **200**

| Name | Type | Required | Description |
|---|---|---|---|
| cname | string | false | The name of the channel to be recorded. |
| uid | string | false | The string content is the user ID used by the cloud recording service in the RTC channel to identify the recording service in the channel. |
| resourceId | string | false | The resource ID used by Cloud Recording. |
| sid | string | false | The recording ID, identifying each recording cycle. |



## updateLayout

<a id="opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-sid-sid-mode-mode-updateLayout"></a>


`POST /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/sid/{sid}/mode/{mode}/updateLayout`

*UpdateLayout: Update the mixing layout of the cloud recording.*

After starting the composite recording, you can call this method (`updateLayout`) to update the mixing layout.

Each call to this method overrides the original layout settings. For example, if you set the `backgroundColor` field as `"#FF0000"` (red) when starting a recording and call the `updateLayout` method to update the mixing layout without setting the `backgroundColor` field again, the background color will change to black (the default value).


> - The `updateLayout` request is only valid within the session. If the recording is started incorrectly, or if the recording is finished, the `updateLayout` call will return `404`.
> - If you need to call the `updateLayout` method successively to update the recording settings, repeat the call after receiving the last `updateLayout` response; otherwise, the request result might not be as expected.

> Request body

```json
{
  "cname": "httpClient463224",
  "uid": "527841",
  "clientRequest": {
    "mixedVideoLayout": 3,
    "backgroundColor": "#FF0000",
    "layoutConfig": [
      {
        "uid": "1",
        "x_axis": 0.1,
        "y_axis": 0.1,
        "width": 0.1,
        "height": 0.1,
        "alpha": 1,
        "render_mode": 1
      },
      {
        "uid": "2",
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

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| Content-Type | header | string | false | `application/json`. |
| appid | path | string | true | The [App ID](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id) that your project uses.<li>For web page recording mode, simply enter the App ID for which the cloud recording service is enabled.</li><li>For individual and composite recording modes, you must use the same App ID as the channel to be recorded. Ensure that the cloud recording service has been enabled for this App ID.</li> |
| resourceid | path | string | true | The resource ID obtained by the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request. |
| sid | path | string | true | The recording ID obtained through [`start`](#opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start). |
| mode | path | string | true | The recording modes. Supports `mix` only, which means [composite recording mode](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite). |
| body | body | JSON Object | true | [updateLayout-request](#schemaupdatelayout-request) |

> Example responses

> 200 Response

```json
{
  "cname": "string",
  "uid": "string",
  "resourceId": "string",
  "sid": "string"
}
```

### Responses

| status | Description | Schema |
|---|---|---|
| 200 | If the returned HTTP status code is `200`, the request is successful. | [Response Schema](#response-schema-2) |
| Not 200 | If the HTTP status code is not `200`, see [the response status code](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) for troubleshooting. | [Response status code](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) |

#### Response Schema

Status Code **200**

| Name | Type | Required | Description |
|---|---|---|---|
| cname | string | false | The name of the channel to be recorded. |
| uid | string | false | The string content is the user ID used by the cloud recording service in the RTC channel to identify the recording service in the channel. |
| resourceId | string | false | The resource ID used by Cloud Recording. |
| sid | string | false | The recording ID, identifying a recording cycle. |



## query

<a id="opIdget-v1-apps-appid-cloud_recording-resourceid-resourceid-sid-sid-mode-mode-query"></a>


`GET /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/sid/{sid}/mode/{mode}/query`

*Query: Query the status of the cloud recording*

After you start recording, you can call `query` to query the recording status.

> The `query` request is only valid within the session. If the recording is started incorrectly, or if the recording is finished, the `query` call will return `404`.

### Parameters

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| Content-Type | header | string | false | `application/json`. |
| appid | path | string | true | The [App ID](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id) that your project uses.<li>For web page recording mode, simply enter the App ID for which the cloud recording service is enabled.</li><li>For individual and composite recording modes, you must use the same App ID as the channel to be recorded. Ensure that the cloud recording service has been enabled for this App ID.</li> |
| resourceid | path | string | true | The resource ID obtained by the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request. |
| sid | path | string | true | The recording ID obtained through [`start`](#opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start). |
| mode | path | string | true | The recording modes:<li>`individual`: [Individual recording mode](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/set-individual).</li><li>`mix`: [Composite recording mode](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite).</li><li>`web`: [Web page recording mode](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/web-mode/set-webpage-recording).</li> |

> Example responses

> 200 Response

```json
{
  "resourceId": "string",
  "sid": "string",
  "serverResponse": {
    "status": 0,
    "extensionServiceState": [
      {
        "payload": {
          "fileList": [
            {
              "filename": "string",
              "sliceStartTime": 0
            }
          ],
          "onhold": true,
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

| status | Description | Schema |
|---|---|---|
| 200 | If the returned HTTP status code is `200`, the request is successful. | [query-response](#schemaquery-response) |
| Not 200 | If the HTTP status code is not `200`, see [the response status code](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) for troubleshooting. | [Response status code](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) |



## stop

<a id="opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-sid-sid-mode-mode-stop"></a>


`POST /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/sid/{sid}/mode/{mode}/stop`

*Stop: Stop the cloud recording*

After starting recording, you can call the `stop` method to leave the channel and stop recording. To re-record after the recording has stopped, you must call the `acquire` method again to request a new resource ID.

> - The `stop` request is only valid within the session. If the recording is started incorrectly, or if the recording is finished, the `stop` call will return `404`.
> - In non-web page recording mode, when the channel is idle (without users) for more than the predefined duration (default is 30 seconds), cloud recording automatically leaves the channel and stops recording.

> Request body

```json
{
  "cname": "httpClient463224",
  "uid": "527841",
  "clientRequest": {
    "async_stop": false
  }
}
```

### Parameters

| Name | In | Type | Required | Description |
|---|---|---|---|---|
| Content-Type | header | string | false | `application/json`. |
| appid | path | string | true | The [App ID](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id) that your project uses.<li>For web page recording mode, simply enter the App ID for which the cloud recording service is enabled.</li><li>For individual and composite recording modes, you must use the same App ID as the channel to be recorded. Ensure that the cloud recording service has been enabled for this App ID.</li> |
| resourceid | path | string | true | The resource ID obtained by the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request. |
| sid | path | string | true | The recording ID obtained through [`start`](#opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start). |
| mode | path | string | true | The recording modes:<li>`individual`: [Individual recording mode](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/set-individual).</li><li>`mix`: [Composite recording mode](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite).</li><li>`web`: [Web page recording mode](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/web-mode/set-webpage-recording).</li> |
| body | body | JSON Object | true | [stop-request](#schemastop-request) |

> Example responses

> 200 Response

```json
{
  "resourceId": "string",
  "sid": "string",
  "serverResponse": {
    "extensionServiceState": [
      {
        "playload": {
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

| status | Description | Schema |
|---|---|---|
| 200 | If the returned HTTP status code is `200`, the request is successful. | [stop-response](#schemastop-response) |
| Not 200 | If the HTTP status code is not `200`, see [the response status code](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) for troubleshooting. | [Response status code](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code) |



## get-ncs-ip

<a id="opIdget-v1-ncs-ip"></a>

`GET /v1/ncs/ip`

*Query the IP addresses of the message notification server*

Query the IP address or IP address list of the message notification server.

After you enable the message notification service, the Agora message notification service can notify your server of events that occur during a cloud recording with HTTPS requests. Agora dynamically adjusts the IP addresses of the message notification server every 24 hours. You can query the IP addresses using this method. After the query, add the IP address (or IP address list) to the whitelist.

> We strongly recommend performing a query at least every 24 hours and automatically updating the firewall configuration; otherwise, it may affect your reception of notifications.

> Example responses

> If the returned HTTP status code is 200, the request is successful.

You only need to pay attention to the `PrimaryIP` field in the response body, but not the response header or other fields in the response body.

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

| status | Description | Schema |
|---|---|---|
| 200 | If the returned HTTP status code is 200, the request is successful. You only need to pay attention to the `PrimaryIP` field in the response body, but not the response header or other fields in the response body. | [Response Schema](#response-schema-3) |

#### Response Schema

Status Code **200**

| Name | Type | Required | Description |
|---|---|---|---|
| data | object | false | Unnecessary to know. |
| » service | object | false | Unnecessary to know. |
| »» hosts | array[object] | false | Unnecessary to know. |
| »»» primaryIP | string | false | The IP address of the Agora message notification server. |



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
    "resourceExpiredHour": 72,
    "startParameter": {
      "token": "string",
      "storageConfig": {
        "vendor": 0,
        "region": 0,
        "bucket": "string",
        "accessKey": "string",
        "secretKey": "string",
        "fileNamePrefix": [
          "string"
        ],
        "extensionParams": {
          "sse": "string",
          "tag": "string"
        }
      },
      "recordingConfig": {
        "channelType": 0,
        "decryptionMode": 0,
        "secret": "string",
        "salt": "string",
        "maxIdleTime": 30,
        "streamTypes": 2,
        "videoStreamType": 0,
        "subscribeAudioUids": [
          "string"
        ],
        "unsubscribeAudioUids": [
          "string"
        ],
        "subscribeVideoUids": [
          "string"
        ],
        "unsubscribeVideoUids": [
          "string"
        ],
        "subscribeUidGroup": 0,
        "streamMode": "default",
        "audioProfile": 0,
        "transcodingConfig": {
          "width": 360,
          "height": 640,
          "fps": 15,
          "bitrate": 500,
          "maxResolutionUid": "string",
          "mixedVideoLayout": 0,
          "backgroundColor": "#000000",
          "backgroundImage": "string",
          "defaultUserBackgroundImage": "string",
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
      "recordingFileConfig": {
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
      "extensionServiceConfig": {
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
              "videoBitrate": 0,
              "videoFps": 15,
              "mobile": false,
              "maxVideoDuration": 120,
              "onhold": false,
              "readyTimeout": 0
            }
          }
        ]
      },
      "appsCollection": {
        "combinationPolicy": "default"
      },
      "transcodeOptions": {
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
      "string"
    ]
  }
}
```

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| cname | string | true | Channel name:<br> - For individual recording and composite recording modes, this field is used to set the name of the channel to be recorded. <br>- For web page recording mode, this field is used to differentiate the recording process. The string length cannot exceed 1024 bytes. <br>**Note**: A unique recording instance can be located through `appid`, `cname`, and `uid`. Therefore, if you intend to record the same channel multiple times, you can effectively manage this by using the same `appId` and `cname`, while differentiating them with different `uid`s. |
| uid | string | true | The string contains the UID used by the cloud recording service within the channel to identify the recording service, for example, `"527841"`. The string must meet the following conditions:<br>- The value is ranged from 1 to (2<sup>32</sup>-1), and cannot be set to `0`. <br>- It must not duplicate any UID within the current channel. <br>- The field value within the quotation marks is an integer UID, and all users in the channel should use the integer UIDs. |
| clientRequest | object | false | See the following. |
| » scene | number | false | Use cases for cloud recording resources:<br> - `0`: (default) Real-time audio and video recording. <br>- `1`: Web page recording. <br>- `2`: Individual recording mode, with postponed transcoding or audio mixing enabled.<br>    - Postponed transcoding: The recording service will transcode the recorded files into the MP4 format within 24 hours after the recording ends (in special cases, it may take more than 48 hours), and then upload the MP4 files to your third-party cloud storage. This scene is only applicable to the individual recording mode.<br>    - Postponed audio mixing: The recording service will merge and transcode the recorded files of all UIDs in the specified channel into a single MP3/M4A/AAC file within 24 hours after the recording ends (in special cases, it may take more than 48 hours), and then upload the file to your specified third-party cloud storage. This scene is only applicable to the individual audio non-transcoding recording mode.<br>    > - When `scene` is set to `2`, you need to set the `appsCollection`field in the `start` method at the same time.<br>    > - In scenarios involving postponed transcoding and audio mixing, the recorded files will be cached on the Agora edge servers for up to 24 hours. If your business is sensitive to information security and to ensure data compliance, please carefully consider whether to use postponed transcoding and audio mixing functions. Contact Agora technical support if you need assistance. |
| » resourceExpiredHour | number | false | The validity period for calling the cloud recording RESTful API Start calculating after you successfully initiate the cloud recording service and obtain the `sid` (Recording ID). The calculation unit is hours. The value range is [1,720]. The default value is 72. <br><br>**Note**: After the timeout, you will not be able to call the `query`, `update`, `updateLayout`, and `stop` methods.</br> |
| » startParameter | [client-request](#schemaclient-request) | false | Setting this field can improve availability and optimize load balancing. <br><br>**Note**: When populating the `startParameter` object, make sure the values are valid and consistent with the `clientRequest` object in the subsequent `start` request body; otherwise, the `start` request will receive an error response. |
| » excludeResourceIds | array[string] | false | The `resourceId` of another or several other recording tasks. This field is used to exclude specified recording resources so that newly initiated recording tasks can use resources from a new region, enabling cross-regional multi-stream recording. See [multi-stream task guarantee]( https://doc.shengwang.cn/doc/cloud-recording/restful/best-practices/integration#多路任务保障). |
| » region | string | false | Specify regions that the cloud recording service can access. By default, the cloud recording service accesses the region where the server you initiated the request is located. Once you specify the access region through `region`, the cloud recording service will not access servers outside the specified region. The region can be set as:<br>- `"CN"`: Mainland China<br> - `"AP"`: Asia excluding Mainland China<br> - `"EU"`: Europe<br> - `"NA"`: North America<br>**Note**: When calling the `start` method, the `region` of the third-party cloud storage must be consistent with this field. In scenarios of postponed transcoding and audio mixing, Agora recommends that you do not set the `region` field. Otherwise, due to the data compliance risks arising from the dynamic adjustment of Agora edge servers and the caching of recording files in scenarios of postponed transcoding and audio mixing, the Agora recording service may fail to function properly. |

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
      "string"
    ],
    "extensionParams": {
      "sse": "string",
      "tag": "string"
    }
  },
  "recordingConfig": {
    "channelType": 0,
    "decryptionMode": 0,
    "secret": "string",
    "salt": "string",
    "maxIdleTime": 30,
    "streamTypes": 2,
    "videoStreamType": 0,
    "subscribeAudioUids": [
      "string"
    ],
    "unsubscribeAudioUids": [
      "string"
    ],
    "subscribeVideoUids": [
      "string"
    ],
    "unsubscribeVideoUids": [
      "string"
    ],
    "subscribeUidGroup": 0,
    "streamMode": "default",
    "audioProfile": 0,
    "transcodingConfig": {
      "width": 360,
      "height": 640,
      "fps": 15,
      "bitrate": 500,
      "maxResolutionUid": "string",
      "mixedVideoLayout": 0,
      "backgroundColor": "#000000",
      "backgroundImage": "string",
      "defaultUserBackgroundImage": "string",
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
  "recordingFileConfig": {
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
  "extensionServiceConfig": {
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
          "videoBitrate": 0,
          "videoFps": 15,
          "mobile": false,
          "maxVideoDuration": 120,
          "onhold": false,
          "readyTimeout": 0
        }
      }
    ]
  },
  "appsCollection": {
    "combinationPolicy": "default"
  },
  "transcodeOptions": {
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


### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| token | string | false | A dynamic key used for authentication. If your project has enabled the App certificate, pass in the dynamic key of your project in this field. See [Token Authentication]( https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication) for details.<br><p><b>Note:</b><br><li>You only need to set the authentication token in <b>individual recording</b> and <b>composite recording</b> modes.</li><br><li>Cloud recording service does not support updating tokens currently. To ensure normal recording, guarantee the effective duration of the Token is longer than your expected recording time, to avoid the token expiring and causing the recording task to exit the channel and end the recording.</li><br></p> |
| storageConfig | [storageConfig](#schemastorageconfig) | true | Configurations for third-party cloud storage. |
| recordingConfig | [recordingConfig](#schemarecordingconfig) | false | Configurations for recorded audio and video streams.<br><p><b>Note: </b>You only need to set this field in <b>individual recording</b> and <b>composite recording</b> modes.</p> |
| recordingFileConfig | [recordingFileConfig](#schemarecordingfileconfig) | false | Configurations for recorded files.<br><p><b>Note</b>: This field <b>cannot be set when only taking screenshots</b>, but it needs to be set in all other cases. Other cases include the following:<br><li>Recording without transcoding, recording with transcoding, or recording and taking screenshots simultaneously in individual recording mode.</li><br><li>Composite recording.</li><br><li>In the web page recording mode, you can do page recording only, or simultaneously do the page recording and push it to the CDN.</li><br></p> |
| snapshotConfig | [snapshotConfig](#schemasnapshotconfig) | false | Configurations for screenshot capture.<p><b>Note: </b>Only need to set this field when using the screenshot function in <b>individual recording mode</b>.</p><br>**Screenshot** usage instructions:<br> - The screenshot function is only applicable to individual recording mode (`individual`). <br>- You can either take screenshots in an individual recording process, or record and take screenshots at the same time. For more information, see [Capture Screenshots](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/snapshot). The scenario of simultaneous recording and screenshot capture requires setting the `recordingFileConfig` field. <br>- If the recording service or recording upload service is abnormal, the screenshot will fail. Recording is not affected when there is a screenshot exception. <br>- `streamTypes` must be set as 1 or 2 when capturing screenshots. If you have set `subscribeAudioUid`, you must also set `subscribeVideoUids`. |
| extensionServiceConfig | [extensionServiceConfig](#schemaextensionserviceconfig) | false | Configurations for extended services.<br><p><b>Note</b>: Only need to set in <b>web page recording</b> mode.</p> |
| appsCollection | [appsCollection](#schemaappscollection) | false | Application configurations<br><p><b>Note</b>: This setting is only required when in <b>individual recording mode</b> and when postponed transcoding or audio mixing is enabled.</p> |
| transcodeOptions | [transcodeOptions](#schematranscodeoptions) | false | Configurations for the recorded files generated under postponed transcoding or audio mixing.<br><p><b>Note</b>: This setting is only required when in <b>individual recording mode</b> and when postponed transcoding or audio mixing is enabled.</p> |

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
    "string"
  ],
  "extensionParams": {
    "sse": "string",
    "tag": "string"
  }
}
```

Configurations for third-party cloud storage.

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| vendor | number | true | Third-party cloud storage platforms. <br>- `1`: [ Amazon S3 ](https://aws.amazon.com/s3/)<br>- `2`: [Alibaba Cloud]( https://www.aliyun.com/product/oss)<br>- `3`: [Tencent Cloud]( https://cloud.tencent.com/product/cos)<br>- `5`: [Microsoft Azure](https://azure.microsoft.com/en-us/products/storage/blobs/)<br>- `6`: [Google Cloud]( https://cloud.google.com/storage)<br>- `7`: [Huawei Cloud](https://www.huaweicloud.com/product/obs.html)<br>- `8`: [Baidu IntelligentCloud]( https://cloud.baidu.com/product/bos.html) |
| region | number | true | (Required) The region information specified for the third-party cloud storage. <br><br><b>Note</b>: To ensure the success rate and real-time performance of the upload of the recording file, the region of the third-party cloud storage must be the same as the `region` of the application server where you initiate the request. For example: If the App server from which you initiate the request is in mainland China, and meanwhile the third-party cloud storage needs to be set to a region within mainland China. See [Third-party Cloud Storage Service]( https://doc.shengwang.cn/api-ref/cloud-recording/restful/region-vendor).</br> |
| bucket | string | true | Third-party cloud storage bucket. The bucket name needs to comply with the naming rules of the corresponding third-party cloud storage service. |
| accessKey | string | true | Access Key for third-party cloud storage. If postponed transcoding is required, the Access Key must have read and write permissions; otherwise, it is recommended to only provide the write permission. |
| secretKey | string | true | (Required) The secret key of the third-party cloud storage. |
| fileNamePrefix | array[string] | false | The storage location of the recorded files in the third-party cloud is related to the prefix of the file name. If it is set to `["directory1","directory2"]`, then the prefix of the recording file name is `"directory1/directory2/"`, that is, the recording file name is `directory1/directory2/xxx.m3u8`. The prefix's length, including the slashes, should not exceed 128 characters. The string itself should not contain symbols such as slash, underscore, or parenthesis. The following are the supported character set ranges:<br>- 26 lowercase English letters: a~z<br>- 26 uppercase English letters: A~Z<br>- 10 numbers: 0-9 |
| extensionParams | [extensionParams](#schemaextensionparams) | false | Third-party cloud storage services will encrypt and tag the uploaded recording files according to this field. |

## extensionParams
<!-- backwards compatibility -->
<a id="schemaextensionparams"></a>




```json
{
  "sse": "string",
  "tag": "string"
}
```

Third-party cloud storage services will encrypt and tag the uploaded recording files according to this field.

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| sse | string | true | The encryption mode. After setting this field, the third-party cloud storage service will encrypt the uploaded recording files according to this encryption mode. This field is only applicable to Amazon S3, see the [official Amazon S3 documentation](https://docs.aws.amazon.com/en_us/AmazonS3/latest/userguide/UsingEncryption.html). <br>- `kms`: KMS encryption. <br>- `aes256`: AES256 encryption. |
| tag | string | true | Tag content. After setting this field, the third-party cloud storage service will tag the uploaded recording files according to the content of this tag. This field is only applicable to Alibaba Cloud and Amazon S3. For details, see [the Alibaba Cloud official documentation]( https://www.alibabacloud.com/help/en/doc-detail/106678.html) and the [Amazon S3 official documentation](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-tagging.html). |

## recordingConfig
<!-- backwards compatibility -->
<a id="schemarecordingconfig"></a>




```json
{
  "channelType": 0,
  "decryptionMode": 0,
  "secret": "string",
  "salt": "string",
  "maxIdleTime": 30,
  "streamTypes": 2,
  "videoStreamType": 0,
  "subscribeAudioUids": [
    "string"
  ],
  "unsubscribeAudioUids": [
    "string"
  ],
  "subscribeVideoUids": [
    "string"
  ],
  "unsubscribeVideoUids": [
    "string"
  ],
  "subscribeUidGroup": 0,
  "streamMode": "default",
  "audioProfile": 0,
  "transcodingConfig": {
    "width": 360,
    "height": 640,
    "fps": 15,
    "bitrate": 500,
    "maxResolutionUid": "string",
    "mixedVideoLayout": 0,
    "backgroundColor": "#000000",
    "backgroundImage": "string",
    "defaultUserBackgroundImage": "string",
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

Configurations for recorded audio and video streams.
<p><b>Note: </b>You only need to set this field in <b>individual recording</b> and <b>composite recording</b> modes.</p>

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| channelType | number | true | The channel profile. <br>- `0`: (Default) The communication scenario. <br>- `1`: Live streaming scene. <br>The channel scene must be consistent with the Agora RTC SDK, otherwise it may cause issues. |
| decryptionMode | number | false | The decryption mode. If you have set channel encryption in the SDK client, you need to set the same decryption mode for the cloud recording service. <br>- `0`: (Default) Not encrypted. <br>- `1`: AES_128_XTS encryption mode. 128-bit AES encryption, XTS mode. <br>- `2`: AES_128_ECB encryption mode. 128-bit AES encryption, ECB mode. <br>- `3`: AES_256_XTS encryption mode. 256-bit AES encryption, XTS mode. <br>- `4`: SM4_128_ECB encryption mode. 128-bit SM4 encryption, ECB mode. <br>- `5`: AES_128_GCM encryption mode. 128-bit AES encryption, GCM mode. <br>- `6`: AES_256_GCM encryption mode. 256-bit AES encryption, GCM mode. <br>- `7`: AES_128_GCM2 encryption mode. 128-bit AES encryption, GCM mode. Compared to AES_128_GCM encryption mode, AES_128_GCM2 encryption mode has higher security and requires setting a key and salt. <br>- `8`: AES_256_GCM2 encryption mode. 256-bit AES encryption, GCM mode. Compared to the AES_256_GCM encryption mode, the AES_256_GCM2 encryption mode is more secure and requires setting a key and salt. |
| secret | string | false | Keys related to encryption and decryption. Only needs to be set when `decryptionMode` is not `0`. |
| salt | string | false | Salt related to encryption and decryption. Base64 encoding, 32-bit bytes. Only need to set when `decryptionMode` is `7` or `8`. |
| maxIdleTime | number | false | Maximum channel idle time. The unit is seconds. The value range is [5,259,200]. The default value is 30. The maximum value can not exceed 30 days. The recording service will automatically exit after exceeding the maximum channel idle time. After the recording service exits, if you initiate a `start` request again, a new recording file will be generated.<br><p>Channel idle: There are no broadcasters in the live channel, or there are no users in the communication channel.</p> |
| streamTypes | number | false | Subscribed media stream type. <br>- `0`: Subscribes to audio streams only. Suitable for smart voice review scenarios. <br>- `1`: Subscribes to video streams only. <br>- `2`: (Default) Subscribes to both audio and video streams. |
| videoStreamType | number | false | Sets the stream type of the remote video. If you enable dual-stream mode in the SDK client, you can choose to subscribe to either the high-quality video stream or the low-quality video stream. <br>- `0`: High-quality video stream refers to high-resolution and high-bitrate video stream.<br> - `1`: Low-quality video stream refers to low-resolution and low-bitrate video stream. |
| subscribeAudioUids | array[string] | false | Specify which UIDs' audio streams to subscribe to. If you want to subscribe to the audio stream of all UIDs, no need to set this field. The array length should not exceed 32, and using an empty array is not recommended. Only one of the fields can be set: this field or `unsubscribeAudioUids`. For details, see [Set up subscription lists](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe).<br><p><b>Note:</b><br><li>This field is only applicable when the <b>streamTypes</b> field is set to audio, or both audio and video.</li><br><li>If you have set up a subscription list for audio or video only, but not at the same time, then the cloud recording service will not subscribe to any video streams. If you set up a subscription list for video, but not for audio, then Agora Cloud Recording will not subscribe to any audio streams.</li><br><li>Set as <b>["#allstream#"]</b> to subscribe to the audio streams of all UIDs in the channel.</li><br></p> |
| unsubscribeAudioUids | array[string] | false | Specify which UIDs' audio streams not to subscribe to. The cloud recording service will subscribe to the audio streams of all other UIDs except the specified ones. The array length should not exceed 32, and using an empty array is not recommended. Only one of the fields can be set: this field or `subscribeAudioUids`. For details, see [Set up subscription lists](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe). |
| subscribeVideoUids | array[string] | false | Specify which UID's video streams to subscribe to. If you want to subscribe to the video streams of all UIDs, no need to set this field. The array length should not exceed 32, and using an empty array is not recommended. Only one of the fields can be set: this field or `unsubscribeVideoUids`. For details, see [Set up subscription lists](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe).<br><p><b>Note:</b><br><li>This field is only applicable when the <b>streamTypes</b> field is set to video, or both audio and video.</li><br><li>If you have set up a subscription list for audio or video only, but not at the same time, then the cloud recording service will not subscribe to any video streams. If you set up a subscription list for video, but not for audio, then Agora Cloud Recording will not subscribe to any audio streams.</li><br><li>Set as <b>["#allstream#"]</b> to subscribe to the video streams of all UIDs in the channel.</li><br></p> |
| unsubscribeVideoUids | array[string] | false | Specify which UIDs' audio streams not to subscribe to. The cloud recording service will subscribe to the video streams of all UIDs except the specified ones. The array length should not exceed 32, and using an empty array is not recommended. Only one of the fields can be set: this field or `subscribeVideoUids`. For details, see [Set up subscription lists](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe). |
| subscribeUidGroup | number | false | Estimated peak number of subscribers. <br>- `0`: 1 to 2 UIDs. <br>- `1`:3 to 7 UIDs. <br>- `2`: 8 to 12 UIDs <br>- `3`: 13 to 17 UIDs <br>- `4`: 18 to 32 UIDs. <br>- `5`: 33 to 49 UIDs. <br>**Note**:<br>- Only need to be set in **individual recording**mode, and it is required in this mode. <br>- For example, if `subscribeVideoUids` is `["100","101","102"]` and `subscribeAudioUids` is `["101","102","103"]`, the number of subscribers is 4. |
| streamMode | string | false | Output mode of media stream. See the [Output mode of media stream](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/stream-mode). <br>- `"default"`: Default mode. Recording with audio transcoding will separately generate an M3U8 audio index file and a video index file. <br>- `"standard"`: Standard mode. Agora recommends using this mode. Recording with audio transcoding will separately generate an M3U8 audio index file, a video index file, and a merged audio and video index file. If VP8 encoding is used on the Web client, a merged MPD audio-video index file will be generated. <br>- `"original"`: Original encoding mode. It is applicable to [individual non-transcoding audio recording](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/set-individual-nontranscoding). This field only takes effect when subscribing to audio only (`streamTypes` is 0). During the recording process, the audio is not transcoded, and an M3U8 audio index file is generated. <br>**Note**: Only need to set in **individual recording** mode. |
| audioProfile | number | false | Set the sampling rate, bitrate, encoding mode, and number of channels for the output audio. <br>- `0`: (Default) 48 kHz sampling rate, music encoding, mono audio channel, and the encoding bitrate is about 48 Kbps. <br>`1`: 48 kHz sampling rate, music encoding, mono audio channel, and the encoding bitrate is approximately 128 Kbps. <br>`2`: 48 kHz sampling rate, music encoding, stereo audio channel, and the encoding bitrate is approximately 192 Kbps. <br>**Note**: Only need to set in the **composite recording** mode. |
| transcodingConfig | [transcodingConfig](#schematranscodingconfig) | false | Configurations for transcoded video output The value can refer to [Setting the Resolution of the Recorded Video Output](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-output-video-profile).<br><p><b>Note</b>: Only need to set in the <b>composite recording</b> mode.</p> |




## transcodingConfig
<!-- backwards compatibility -->
<a id="schematranscodingconfig"></a>




```json
{
  "width": 360,
  "height": 640,
  "fps": 15,
  "bitrate": 500,
  "maxResolutionUid": "string",
  "mixedVideoLayout": 0,
  "backgroundColor": "#000000",
  "backgroundImage": "string",
  "defaultUserBackgroundImage": "string",
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

Configurations for transcoded video output The value can refer to [Setting the Resolution of the Recorded Video Output](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-output-video-profile).
<p><b>Note</b>: Only need to set in the <b>composite recording</b> mode.</p>

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| width | number | false | The width of the video (pixels). `width` × `height` cannot exceed 1920 × 1080. The default value is 360. |
| height | number | false | The height of the video (pixels). `width` × `height` cannot exceed 1920 × 1080. The default value is 640. |
| fps | number | false | The frame rate of the video (fps). The default value is 15. |
| bitrate | number | false | The bitrate of the video (Kbps). The default value is 500. |
| maxResolutionUid | string | false | Only need to set it in **vertical layout**. Specify the user ID of the large video window. The string value should be an integer ranging from 1 to (2<sup>32</sup>-1), and cannot be set to 0. |
| mixedVideoLayout | number | false | Composite video layout:<br>- `0`: (Default) Floating layout. The first user to join the channel will be displayed as a large window, filling the entire canvas. The video windows of other users will be displayed as small windows, arranged horizontally from bottom to top, up to 4 rows, each with 4 windows. It supports up to a total of 17 windows of different users' videos. <br>- `1`: Adaptive layout. Automatically adjust the size of each user's video window according to the number of users, each user's video window size is consistent, and supports up to 17 windows. <br>- `2`: Vertical layout. The `maxResolutionUid` is specified to display the large video window on the left side of the screen, and the small video windows of other users are vertically arranged on the right side, with a maximum of two columns, 8 windows per column, supporting up to 17 windows. <br>- `3`: Customized layout. Set the `layoutConfig` field to customize the mixed layout. |
| backgroundColor | string | false | The background color of the video canvas. The RGB color table is supported, with strings formatted as a # sign and 6 hexadecimal digits. The default value is `"#000000"`, representing the black color. |
| backgroundImage | string | false | The URL of the background image of the video canvas. The display mode of the background image is set to cropped mode.<br><p>Cropped mode: Will prioritize to ensure that the screen is filled. The background image size is scaled in equal proportion until the entire screen is filled with the background image. If the length and width of the background image differ from the video window, the background image will be peripherally cropped to fill the window.</p> |
| defaultUserBackgroundImage | string | false | The URL of the default user screen background image.<br><p>After configuring this field, when any user stops sending the video streams for more than 3.5 seconds, the screen will switch to the background image; this setting will be overridden if the background image is set separately for a UID.</p> |
| layoutConfig | array[object] | false | [layoutConfig](#schemalayoutconfig) |
| backgroundConfig | [backgroundConfig](#schemabackgroundconfig) | false | Configurations of user's background image. |



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

The mixed video layout of users. An array of screen layout settings for each user, supporting up to 17 users.
<p><b>Note</b>: Only need to set in <b>custom layout</b>.</p>

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| uid | string | false | The content of the string is the UID of the user to be displayed in the area, 32-bit unsigned integer.<br><p>If the UID is not specified, the screen settings in <b>layoutConfig</b> will be matched automatically in the order that users join the channel.</p> |
| x_axis | number(float) | true | The relative value of the horizontal coordinate of the upper-left corner of the screen, accurate to six decimal places. Layout from left to right, with `0.0` at the far left and `1.0` at the far right. This field can also be set to the integer 0 or 1. The value range is [0,1]. |
| y_axis | number(float) | true | The relative value of the vertical coordinate of the upper-left corner of this screen in the screen, accurate to six decimal places. Layout from top to bottom, with `0.0` at the top and `1.0` at the bottom. This field can also be set to the integer 0 or 1. The value range is [0,1]. |
| width | number(float) | true | The relative value of the width of this screen, accurate to six decimal places. This field can also be set to the integer 0 or 1. The value range is [0,1]. |
| height | number(float) | true | The relative value of the height of this screen, accurate to six decimal places. This field can also be set to the integer 0 or 1. The value range is [0,1]. |
| alpha | number(float) | false | The transparency of the user's video window. Accurate to six decimal places. `0.0` means the user's video window is transparent, and `1.0` indicates that it is completely opaque. The value range is [0,1]. The default value is 1. |
| render_mode | number | false | The display mode of users' video windows:<br>- `0`: (Default) cropped mode. Prioritize to ensure the screen is filled. The video window size is proportionally scaled until it fills the screen. If the video's length and width differ from the video window, the video stream will be cropped from its edges to fit the  window, under the aspect ratio set for the video window. <br>- `1`: Fit mode. Prioritize to ensure that all video content is displayed. The video size is scaled proportionally until one side of the video window is aligned with the screen border. If the video scale does not comply with the window size, the video will be scaled to fill the screen while maintaining its aspect ratio. This scaling may result in a black border around the edges of the video. |


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

Configurations of user's background image.

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| uid | string | true | The string content is the UID. |
| image_url | string | true | The URL of the user's background image. After setting the background image, if the user stops sending the video stream for more than 3.5 seconds, the screen will switch to the background image. <br><br>URL supports the HTTP and HTTPS protocols, and the image formats supported are JPG and BMP. The image size must not exceed 6 MB. The settings will only take effect after the recording service successfully downloads the image; if the download fails, the settings will not take effect. Different field settings may overlap each other. For specific rules, see [Set the background color or background image](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite-layout#%E8%BF%9B%E9%98%B6%E8%AE%BE%E7%BD%AE%E8%83%8C%E6%99%AF%E8%89%B2%E6%88%96%E8%83%8C%E6%99%AF%E5%9B%BE).</br> |
| render_mode | number | false | The display mode of users' video windows:<br>- `0`: (Default) cropped mode. Prioritize to ensure the screen is filled. The video window size is proportionally scaled until it fills the screen. If the video's length and width differ from the video window, the video stream will be cropped from its edges to fit the  window, under the aspect ratio set for the video window. <br>- `1`: Fit mode. Prioritize to ensure that all video content is displayed. The video size is scaled proportionally until one side of the video window is aligned with the screen border. If the video scale does not comply with the window size, the video will be scaled to fill the screen while maintaining its aspect ratio. This scaling may result in a black border around the edges of the video. |

## recordingFileConfig
<!-- backwards compatibility -->
<a id="schemarecordingfileconfig"></a>


```json
{
  "avFileType": [
    "hls"
  ]
}
```

| Name | Type | Required | Description |
|---|---|---|---|
| avFileType | array[string] | false | Type of video files generated by recording:<br>- `"hls"`: default value. M3U8 and TS files. <br>- `"mp4"`: MP4 files. <br>**Note**:<br>- In **individual recording** mode and **not in screenshot-only** case, you can use the default value. <br>- In the **composite recording** and **web page recording** modes, if you need to generate MP4 files, set it to `["hls","mp4"]`. Setting it as `["mp4"]` will result in an error. After setting, the recording file behavior is as follows:<br> - In the composite recording mode, the recording service will create a new MP4 file when the current recording duration exceeds about 2 hours or the file size roughly exceeds 2 GB.<br>    - Web page recording mode: The recording service will create a new MP4 file when the current file's duration exceeds `maxVideoDuration`. |

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


### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| captureInterval | number | false | The cycle for regular screenshots in the cloud recording. The unit is seconds. The value range is [5,3600]. The default value is 10. |
| fileType | array[string] | true | The file format of screenshots. Currently only `["jpg"]` is supported, which generates screenshot files in JPG format. |

## extensionServiceConfig
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
        "videoBitrate": 0,
        "videoFps": 15,
        "mobile": false,
        "maxVideoDuration": 120,
        "onhold": false,
        "readyTimeout": 0
      }
    }
  ]
}
```

Configurations for extended services.
<p><b>Note</b>: Only need to set in <b>web page recording</b> mode.</p>

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| errorHandlePolicy | string | false | Error handling policy. You can only set it to the default value, `"error_abort"`, which means that once an error occurs to an extension service, all other non-extension services, such as stream subscription, also stop. |
| extensionServices | array[object] | true | See the following. |
| » serviceName | string | true | Name of the extended service:<br>- `web_recorder_service`: Represents the extended service is **web page recording**. <br>- `rtmp_publish_service`: Represents the extended service is to **push web page recording to the CDN**. |
| » errorHandlePolicy | string | false | Error handling strategy within the extension service:<br>- `"error_abort"`: the default and only value during **web page recording**. Stop other extension services when the current extension service encounters an error. <br>- `"error_ignore"`: The only default value when you **push the web page recording to the CDN**. Other extension services are not affected when the current extension service encounters an error.<br><p>If the web page recording service or the recording upload service is abnormal, pushing the stream to the CDN will fail. Therefore, errors in the <b>web page recording</b> service can affect the service of <b>pushing page recording to the CDN</b>.</p><br><p>When an exception occurs during the process of pushing to the CDN, web page recording is not affected.</p> |
| » serviceParam | [serviceParam](#schemaserviceparam) | true | Specific configurations for extension services. |

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
  "videoBitrate": 0,
  "videoFps": 15,
  "mobile": false,
  "maxVideoDuration": 120,
  "onhold": false,
  "readyTimeout": 0
}
```


### Properties

#### Scenario 1

The following fields need to be set during **web page recording**:

| Name | Type | Required | Description |
|---|---|---|---|
| url | string | true | The address of the page to be recorded. |
| audioProfile | number | true | Sampling rate, bitrate, encoding mode, and number of channels for the audio output. <br>`0`: 48 kHz sampling rate, music encoding, mono audio channel, and the encoding bitrate is approximately 48 Kbps. <br>`1`: 48 kHz sampling rate, music encoding, mono audio channel, and the encoding bitrate is approximately 128 Kbps. <br>`2`: 48 kHz sampling rate, music encoding, stereo audio channel, and the encoding bitrate is approximately 192 Kbps. |
| videoWidth | number | true | The output video width (pixel). The product of `videoWidth` and `videoHeight` should be less than or equal to 1920 × 1080. For recommended values, see [How to Set Output Video Resolution for Web Page Recording in the Mobile Mode](https://doc.shengwang.cn/faq/integration-issues/mobile-video-profile). |
| videoHeight | number | true | The height of the output video (pixel). The product of `videoWidth` and `videoHeight` should be less than or equal to 1920 × 1080. For recommended values, see [How to Set Output Video Resolution for Web Page Recording in the Mobile Mode](https://doc.shengwang.cn/faq/integration-issues/mobile-video-profile). |
| maxRecordingHour | number | true | The maximum duration of web page recording (hours). The web page recording will automatically stop after exceeding this value. The value range is [1,720]. <br>> The recommended value should not exceed the value you set in the `acquire` method for `resourceExpiredHour`.<br><p><b>Billing related</b>: The charge will continue until the web page recording stops, so you need to set a reasonable value according to the actual business situation or stop the page recording voluntarily.</p> |
| videoBitrate | number | false | The bitrate of the output video (Kbps). For different output video resolutions, the default value of `videoBitrate` is different: <br>- Output video resolution is greater than or equal to 1280 × 720, and the default value is 2000. <br>- Output video resolution is less than 1280 × 720, and the default value is 1500. |
| videoFps | number | false | The frame rate of the output video (fps). The value range is [5,60]. The default value is 15. |
| mobile | boolean | false | Whether to enable the mobile web mode:<br>- `true`: Enables the mode. After enabling, the recording service uses the mobile web rendering mode to record the current page. <br>- `false`: (default) Disables the mode. |
| maxVideoDuration | number | false | Maximum length of MP4 slice file generated by web page recording, in minutes During the web page recording process, the recording service will create a new MP4 slice file when the current MP4 file duration exceeds the `maxVideoDuration` approximately. The value range is [30,240]. The default value is 120. |
| onhold | boolean | false | Whether to pause page recording when starting a web page recording task. <br>- `true`: Pauses the web page recording that has been started. Immediately pause the recording after starting the web page recording task. The recording service will open and render the page to be recorded, but will not generate slice files. <br>- `false`: (Default) Starts a web page recording task and performs web page recording. <br>We suggest using the `onhold` field according to the following process: <br>1. Set `onhold` to `true` when calling the `start` method, which will start and pause the web page recording, and you need to determine the appropriate time to start the web page recording on your own. <br>2. Call `update` and set `onhold` to `false`, continue with the web page recording. If you need to pause or resume the web page recording by continuously calling the `update` method, please make the call after receiving the response from the previous `update`, otherwise it may cause inconsistent results with your expectations. |
| readyTimeout | number | false | Set the page load timeout in seconds. See [Page Load Timeout Detection](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/web-mode/detect-timeout). The value range is [0,60]. The default value is 0. <br>- Set to `0` or not set, which means the web page loading status is not detected. <br>-An integer between [1,60], representing the page load timeout. |

#### Scenario 2

**Pushing web page recording to the CDN** requires configuring the following fields.

| Name | Type | Required | Description |
|---|---|---|---|
| outputs | array[object] | true | See the following. |
| » rtmpUrl | string | true | The CDN address to which you push the stream. |


## appsCollection
<!-- backwards compatibility -->
<a id="schemaappscollection"></a>




```json
{
  "combinationPolicy": "default"
}
```

Application configurations
<p><b>Note</b>: This setting is only required when in <b>individual recording mode</b> and when postponed transcoding or audio mixing is enabled.</p>

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| combinationPolicy | string | false | The combination of cloud recording applications. <br>- `postpone_transcoding`: Use this method if you need to postpone transcoding or audio mixing. <br>- `default`: (Default) Use this method except for postponed transcoding and audio mixing. |

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

Configurations for the recorded files generated under postponed transcoding or audio mixing.
<p><b>Note</b>: This setting is only required when in <b>individual recording mode</b> and when postponed transcoding or audio mixing is enabled.</p>

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| transConfig | object | true | See the following. |
| » transMode | string | true | Mode:<br>- `"postponeTranscoding"`: Postponed transcoding. <br>- `"audioMix"`: Postponed audio mixing. |
| container | object | false | See the following. |
| » format | string | false | The container format of the file, which supports the following values:<br>- `"mp4"`: the default format for the postponed transcoding. MP4 format. <br>- `"mp3"`: The default format for postponed audio mixing. MP3 format. <br>- `"m4a"`: M4A format. <br>- `"aac"`: AAC format. <br>**Note**: Postponed transcoding can currently only be set to MP4 format. |
| audio | object | false | Audio properties of the file.<br><p><b>Note</b>: This setting is only required in <b>individual recording mode</b> with <b>postponed audio mixing</b> turned on.</p> |
| » sampleRate | string | false | Audio sampling rate (Hz) supports the following values:<br>- `"48000"`: (Default) 48 kHz.<br> - `"32000"`: 32 kHz. <br>- `"16000"`: 16 kHz. |
| » bitrate | string | false | Audio bit rate (Kbps) supports a customized value and the default value is `"48000"`. |
| » channels | string | false | The number of audio channels supports the following values:<br>- `"1"`: Mono. <br>- `"2"`: (Default) Stereo. |

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

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| cname | string | false | The name of the channel to be recorded. |
| uid | string | false | The string content is the user ID used by the cloud recording service in the RTC channel to identify the recording service in the channel. |
| resourceId | string | false | The cloud recording resource ID. You can start a cloud recording with this resource ID. The resource ID is valid for five minutes, after which time you need to re-request it. |



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
        "string"
      ],
      "extensionParams": {
        "sse": "string",
        "tag": "string"
      }
    },
    "recordingConfig": {
      "channelType": 0,
      "decryptionMode": 0,
      "secret": "string",
      "salt": "string",
      "maxIdleTime": 30,
      "streamTypes": 2,
      "videoStreamType": 0,
      "subscribeAudioUids": [
        "string"
      ],
      "unsubscribeAudioUids": [
        "string"
      ],
      "subscribeVideoUids": [
        "string"
      ],
      "unsubscribeVideoUids": [
        "string"
      ],
      "subscribeUidGroup": 0,
      "streamMode": "default",
      "audioProfile": 0,
      "transcodingConfig": {
        "width": 360,
        "height": 640,
        "fps": 15,
        "bitrate": 500,
        "maxResolutionUid": "string",
        "mixedVideoLayout": 0,
        "backgroundColor": "#000000",
        "backgroundImage": "string",
        "defaultUserBackgroundImage": "string",
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
    "recordingFileConfig": {
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
    "extensionServiceConfig": {
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
            "videoBitrate": 0,
            "videoFps": 15,
            "mobile": false,
            "maxVideoDuration": 120,
            "onhold": false,
            "readyTimeout": 0
          }
        }
      ]
    },
    "appsCollection": {
      "combinationPolicy": "default"
    },
    "transcodeOptions": {
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

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| cname | string | true | The name of the channel where the recording service locates. The `cname` field you input in the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request needs to be the same. |
| uid | string | true | The string content is the UID used by the recording service in the RTC channel to identify the recording service. It needs to be the same as the `uid` field you input in the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request. |
| clientRequest | object | true | [client-request](#schemaclient-request) |


## update-request
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
          "string"
        ],
        "unsubscribeAudioUids": [
          "string"
        ]
      },
      "videoUidList": {
        "subscribeVideoUids": [
          "string"
        ],
        "unsunscribeVideoUids": [
          "string"
        ]
      }
    },
    "webRecordingConfig": {
      "onhold": false
    },
    "rtmpPublishConfig": {
      "outputs": [
        {
          "rtmpUrl": "string"
        }
      ]
    }
  }
}
```

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| cname | string | true | The name of the channel where the recording service locates. The `cname` field you input in the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request needs to be the same. |
| uid | string | true | The string content is the UID used by the recording service in the RTC channel to identify the recording service. It needs to be the same as the `uid` field you input in the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request. |
| clientRequest | object | true | [clientRequest](#schemaclientrequest) |

## clientRequest
<!-- backwards compatibility -->
<a id="schemaclientrequest"></a>




```json
{
  "streamSubscribe": {
    "audioUidList": {
      "subscribeAudioUids": [
        "string"
      ],
      "unsubscribeAudioUids": [
        "string"
      ]
    },
    "videoUidList": {
      "subscribeVideoUids": [
        "string"
      ],
      "unsunscribeVideoUids": [
        "string"
      ]
    }
  },
  "webRecordingConfig": {
    "onhold": false
  },
  "rtmpPublishConfig": {
    "outputs": [
      {
        "rtmpUrl": "string"
      }
    ]
  }
}
```

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| streamSubscribe | [streamSubscribe](#schemastreamsubscribe) | false | Update subscription lists.<br><p><b>Note: </b>You only need to set this field in <b>individual recording</b> and <b>composite recording</b> modes.</p> |
| webRecordingConfig | [webRecordingConfig](#schemawebrecordingconfig) | false | Used to update the web page recording configurations.<br><p><b>Note</b>: Only need to set in <b>web page recording</b> mode.</p> |
| rtmpPublishConfig | [rtmpPublishConfig](#schemartmppublishconfig) | false | Used to update the configurations for pushing web page recording to the CDN. <br><p><b>Note</b>: This should only be set when you <b>push media stream to the CDN</b> during a<b>web page recording</b>.<p> |

## streamSubscribe
<!-- backwards compatibility -->
<a id="schemastreamsubscribe"></a>




```json
{
  "audioUidList": {
    "subscribeAudioUids": [
      "string"
    ],
    "unsubscribeAudioUids": [
      "string"
    ]
  },
  "videoUidList": {
    "subscribeVideoUids": [
      "string"
    ],
    "unsunscribeVideoUids": [
      "string"
    ]
  }
}
```

Update subscription lists.
<p><b>Note: </b>You only need to set this field in <b>individual recording</b> and <b>composite recording</b> modes.</p>

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| audioUidList | [audioUidList](#schemaaudiouidlist) | false | The audio subscription list.<br><p><b>Note: </b> This field is only applicable when the <b>streamTypes</b> field is set to audio, or both audio and video.</p> |
| videoUidList | [videoUidList](#schemavideouidlist) | false | The video subscription list.<br><p><b>Note</b>: This field only applies when the <b>streamTypes</b> field is set to video, or both audio and video.</p> |

## audioUidList
<!-- backwards compatibility -->
<a id="schemaaudiouidlist"></a>




```json
{
  "subscribeAudioUids": [
    "string"
  ],
  "unsubscribeAudioUids": [
    "string"
  ]
}
```

The audio subscription list.
<p><b>Note: </b> This field is only applicable when the <b>streamTypes</b> field is set to audio, or both audio and video.</p>

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| subscribeAudioUids | array[string] | false | Specify which UIDs' audio streams to subscribe to. If you want to subscribe to the audio stream of all UIDs, no need to set this field. The array length should not exceed 32, and using an empty array is not recommended. Only one of the fields can be set: this field or `unsubscribeAudioUids`. For details, see [Set up subscription lists](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe).<br><p><b>Note:</b><br><li>This field is only applicable when the <b>streamTypes</b> field is set to audio, or both audio and video.</li><br><li>If you have set up a subscription list for audio or video only, but not at the same time, then the cloud recording service will not subscribe to any video streams. If you set up a subscription list for video, but not for audio, then Agora Cloud Recording will not subscribe to any audio streams.</li><br><li>Set as <b>["#allstream#"]</b> to subscribe to the audio streams of all UIDs in the channel.</li><br></p> |
| unsubscribeAudioUids | array[string] | false | Specify which UIDs' audio streams not to subscribe to. The cloud recording service will subscribe to the audio streams of all other UIDs except the specified ones. The array length should not exceed 32, and using an empty array is not recommended. Only one of the fields can be set: this field or `subscribeAudioUids`. For details, see [Set up subscription lists](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe). |

## videoUidList
<!-- backwards compatibility -->
<a id="schemavideouidlist"></a>




```json
{
  "subscribeVideoUids": [
    "string"
  ],
  "unsunscribeVideoUids": [
    "string"
  ]
}
```

The video subscription list.
<p><b>Note</b>: This field only applies when the <b>streamTypes</b> field is set to video, or both audio and video.</p>

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| subscribeVideoUids | array[string] | false | Specify which UID's video streams to subscribe to. If you want to subscribe to the video streams of all UIDs, no need to set this field. The array length should not exceed 32, and using an empty array is not recommended. Only one of the fields can be set: this field or `unsubscribeVideoUids`. For details, see [Set up subscription lists](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe).<br><p><b>Note:</b><br><li>This field is only applicable when the <b>streamTypes</b> field is set to video, or both audio and video.</li><br><li>If you have set up a subscription list for audio or video only, but not at the same time, then the cloud recording service will not subscribe to any video streams. If you set up a subscription list for video, but not for audio, then Agora Cloud Recording will not subscribe to any audio streams.</li><br><li>Set as <b>["#allstream#"]</b> to subscribe to the video streams of all UIDs in the channel.</li><br></p> |
| unsubscribeVideoUids | array[string] | false | Specify which UIDs' audio streams not to subscribe to. The cloud recording service will subscribe to the video streams of all UIDs except the specified ones. The array length should not exceed 32, and using an empty array is not recommended. Only one of the fields can be set: this field or `subscribeVideoUids`. For details, see [Set up subscription lists](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe). |

## webRecordingConfig
<!-- backwards compatibility -->
<a id="schemawebrecordingconfig"></a>




```json
{
  "onhold": false
}
```

Used to update the web page recording configurations.
<p><b>Note</b>: Only need to set in <b>web page recording</b> mode.</p>

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| onhold | boolean | false | Set whether to pause the web page recording. <br>- `true`: Pauses web page recording and generating recording files. <br>- `false`: (Default) Continues web page recording and generates recording files. <br>If you want to resume a paused web page recording, you can call the `update` method and set `onhold` to `false`. |

## rtmpPublishConfig
<!-- backwards compatibility -->
<a id="schemartmppublishconfig"></a>




```json
{
  "outputs": [
    {
      "rtmpUrl": "string"
    }
  ]
}
```

Used to update the configurations for pushing web page recording to the CDN.
<p><b>Note</b>: This should only be set when you <b>push media stream to the CDN</b> during a<b>web page recording</b>.<p>

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| outputs | array[object] | false | See the following. |
| » rtmpUrl | string | false | The CDN URL where you push the stream to.<br><p><b>Note:</b><br><li>URLs only support the RTMP and RTMPS protocols.</li><br><li>The maximum number of streams being pushed to the CDN is 1.</li><br></p> |

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
    "backgroundColor": "#000000",
    "backgroundImage": "string",
    "defaultUserBackgroundImage": "string",
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


### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| cname | string | true | The name of the channel where the recording service locates. The `cname` field you input in the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request needs to be the same. |
| uid | string | true | The string content is the UID used by the recording service in the RTC channel to identify the recording service. It needs to be the same as the `uid` field you input in the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request. |
| clientRequest | object | true | [clientRequest-updateLayout](#schemaclientrequest-updatelayout) |

## clientRequest-updateLayout
<!-- backwards compatibility -->
<a id="schemaclientrequest-updatelayout"></a>




```json
{
  "maxResolutionUid": "string",
  "mixedVideoLayout": 0,
  "backgroundColor": "#000000",
  "backgroundImage": "string",
  "defaultUserBackgroundImage": "string",
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

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| maxResolutionUid | string | false | Only need to set it in **vertical layout**. Specify the user ID of the large video window. The string value should be an integer ranging from 1 to (2<sup>32</sup>-1), and cannot be set to 0. |
| mixedVideoLayout | number | false | Composite video layout:<br>- `0`: (Default) Floating layout. The first user to join the channel will be displayed as a large window, filling the entire canvas. The video windows of other users will be displayed as small windows, arranged horizontally from bottom to top, up to 4 rows, each with 4 windows. It supports up to a total of 17 windows of different users' videos. <br>- `1`: Adaptive layout. Automatically adjust the size of each user's video window according to the number of users, each user's video window size is consistent, and supports up to 17 windows. <br>- `2`: Vertical layout. The `maxResolutionUid` is specified to display the large video window on the left side of the screen, and the small video windows of other users are vertically arranged on the right side, with a maximum of two columns, 8 windows per column, supporting up to 17 windows. <br>- `3`: Customized layout. Set the `layoutConfig` field to customize the mixed layout. |
| backgroundColor | string | false | The background color of the video canvas. The RGB color table is supported, with strings formatted as a # sign and 6 hexadecimal digits. The default value is `"#000000"`, representing the black color. |
| backgroundImage | string | false | The URL of the background image of the video canvas. The display mode of the background image is set to cropped mode.<br><p>Cropped mode: Will prioritize to ensure that the screen is filled. The background image size is scaled in equal proportion until the entire screen is filled with the background image. If the length and width of the background image differ from the video window, the background image will be peripherally cropped to fill the window.</p> |
| defaultUserBackgroundImage | string | false | The URL of the default user screen background image.<br><p>After configuring this field, when any user stops sending the video streams for more than 3.5 seconds, the screen will switch to the background image; this setting will be overridden if the background image is set separately for a UID.</p> |
| layoutConfig | array[object] | false | [layoutConfig](#schemalayoutconfig) |
| backgroundConfig | array[object] | false | [backgroundConfig](#schemabackgroundconfig) |

## query-response
<!-- backwards compatibility -->
<a id="schemaquery-response"></a>




```json
{
  "resourceId": "string",
  "sid": "string",
  "serverResponse": {
    "status": 0,
    "extensionServiceState": [
      {
        "payload": {
          "fileList": [
            {
              "filename": "string",
              "sliceStartTime": 0
            }
          ],
          "onhold": true,
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

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| resourceId | string | false | The resource ID used by Cloud Recording. |
| sid | string | false | The recording ID. |
| serverResponse | object | false | [serverResponse](#schemaserverresponse) |
| cname | string | false | The name of the channel to be recorded. |
| uid | string | false | The string content is the user ID used by the cloud recording service in the RTC channel to identify the recording service in the channel. |

## serverResponse
<!-- backwards compatibility -->
<a id="schemaserverresponse"></a>




```json
{
  "status": 0,
  "extensionServiceState": [
    {
      "payload": {
        "fileList": [
          {
            "filename": "string",
            "sliceStartTime": 0
          }
        ],
        "onhold": true,
        "state": "string"
      },
      "serviceName": "string"
    }
  ]
}
```

### Properties

#### Scenario 1

Fields returned in **web page recording **mode.

| Name | Type | Required | Description |
|---|---|---|---|
| status | number | false | Current status of the cloud service:<br>- `0`: Cloud service has not started. <br>- `1`: The cloud service initialization is complete. <br>- `2`: The cloud service components are starting. <br>- `3`: Some cloud service components are ready. <br>- `4`: All cloud service components are ready. <br>- `5`: The cloud service is in progress. <br>- `6`: The cloud service receives the request to stop. <br>- `7`: All components of the cloud service stop. <br>- `8`: The cloud service exits. <br>- `20`: The cloud service exits abnormally. |
| extensionServiceState | array[object] | false | [extensionServiceState](#schemaextensionservicestate) |

#### Scenario 2

Fields returned when in **individual recording** mode and **video screenshot capture** is turned on.

| Name | Type | Required | Description |
|---|---|---|---|
| status | number | false | Current status of the cloud service:<br>- `0`: Cloud service has not started. <br>- `1`: The cloud service initialization is complete. <br>- `2`: The cloud service components are starting. <br>- `3`: Some cloud service components are ready. <br>- `4`: All cloud service components are ready. <br>- `5`: The cloud service is in progress. <br>- `6`: The cloud service receives the request to stop. <br>- `7`: All components of the cloud service stop. <br>- `8`: The cloud service exits. <br>- `20`: The cloud service exits abnormally. |
| sliceStartTime | number | false | Recording start time, the Unix timestamp, in milliseconds. |

#### Scenario 3

Fields returned in scenarios other than video screenshot capturing during the individual recording and web page recording.

| Name | Type | Required | Description |
|---|---|---|---|
| status | number | false | Current status of the cloud service:<br>- `0`: Cloud service has not started. <br>- `1`: The cloud service initialization is complete. <br>- `2`: The cloud service components are starting. <br>- `3`: Some cloud service components are ready. <br>- `4`: All cloud service components are ready. <br>- `5`: The cloud service is in progress. <br>- `6`: The cloud service receives the request to stop. <br>- `7`: All components of the cloud service stop. <br>- `8`: The cloud service exits. <br>- `20`: The cloud service exits abnormally. |
| fileListMode | string | false | Data format of `fileList` field: <br>- `"string"`: `fileList` is of String type. In composite recording mode, if `avFileType` is set to `["hls"]`, `fileListMode` is `"string"`. <br>- `"json"`: `fileList` is a JSON Array. When `avFileType` is set to `["hls","mp4"] in the individual or composite` recording mode, `fileListMode` is set to `"json"`. |
| fileList | [fileList-string](#schemafilelist-string) or [fileList-json](#schemafilelist-json) | false | [fileList-string](#schemafilelist-string) or [fileList-json](#schemafilelist-json) |
| sliceStartTime | number | false | Recording start time, the Unix timestamp, in milliseconds. |

## fileList-string
<a id="schemafilelist-string"></a>

| Type | Required | Description |
|---|---|---|
| string | false | The filename of the M3U8 file generated by the recording. |


## extensionServiceState
<!-- backwards compatibility -->
<a id="schemaextensionservicestate"></a>




```json
[
  {
    "payload": {
      "fileList": [
        {
          "filename": "string",
          "sliceStartTime": 0
        }
      ],
      "onhold": true,
      "state": "string"
    },
    "serviceName": "string"
  }
]
```

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| payload | object | false | [payload](#payload) |
| serviceName | string | false | Name of the extended service:<br>- `web_recorder_service`: Represents the extended service is **web page recording**. <br>- `rtmp_publish_service`: Represents the extended service is to **push web page recording to the CDN**. |

## payload

### Properties

#### Scenario 1

The following fields will be returned during web page recording.

| Name | Type | Required | Description |
|---|---|---|---|
| fileList | array[object] | false | See the following. |
| » filename | string | false | The file names of the M3U8 and MP4 files generated during recording. |
| » sliceStartTime | number | false | The recording start time of the file, the Unix timestamp, in seconds. |
| onhold | boolean | false | Whether the page recording is in pause state:<br>- `true`: In pause state. <br>- `false`: The page recording is running. |
| state | string | false | The status of uploading subscription content to the extension service:<br>- `"init"`: The service is initializing. <br>- `"inProgress"`: The service has started and is currently in progress. <br>- `"exit"`: Service exits. |

#### Scenario 2

When pushing the web page recording to CDN, the following fields will be returned.

| Name | Type | Required | Description |
|---|---|---|---|
| outputs | array[object] | false | See the following. |
| » rtmpUrl | string | false | The CDN address to which you push the stream. |
| » status | string | false | The current status of stream pushing of the web page recording:<br> - `"connecting"`: Connecting to the CDN server. <br>- `"publishing"`: The stream pushing is going on. <br>- `"onhold"`: Set whether to pause the stream pushing. <br>- `"disconnected"`: Failed to connect to the CDN server. Agora recommends that you change the CDN address to push the stream. |
| state | string | false | The status of uploading subscription content to the extension service:<br>- `"init"`: The service is initializing. <br>- `"inProgress"`: The service has started and is currently in progress. <br>- `"exit"`: Service exits. |


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
The array[object] type.

### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| fileName | string | false | The file names of the M3U8 and MP4 files generated during recording. |
| trackType | string | false | The recording file type. <br>- `"audio"`: Audio-only files. <br>- `"video"`: Video-only files. <br>- `"audio_and_video"`: audio and video files |
| uid | string | false | User UID, indicating which user's audio or video stream is being recorded. In composite recording mode, the `uid` is `"0"`. |
| mixedAllUser | boolean | false | Whether the users were recorded separately. <br>- `true`: All users are recorded in a single file. <br>- `false`: Each user is recorded separately. |
| isPlayable | boolean | false | Whether or not can be played online. <br>- `true`: The file can be played online. <br>- `false`: The file cannot be played online. |
| sliceStartTime | number | false | The recording start time of the file, the Unix timestamp, in seconds. |

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


### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| cname | string | true | The name of the channel where the recording service locates. The `cname` field you input in the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request needs to be the same. |
| uid | string | true | The string content is the UID used by the recording service in the RTC channel to identify the recording service. It needs to be the same as the `uid` field you input in the [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) request. |
| clientRequest | object | true | See the following. |
| » async_stop | boolean | false | Set the response mechanism for the `stop` method:<br>- `true`: Asynchronous. Immediately receive a response after calling `stop`. <br>- `false`: (Default) Synchronous. After calling `stop`, you need to wait for all the recorded files to be uploaded to the third-party cloud storage before receiving a response. Agora expects the upload time to be no more than 20 seconds. If the upload exceeds the time limit, you will receive an error code of `50`. |

## stop-response
<!-- backwards compatibility -->
<a id="schemastop-response"></a>




```json
{
  "resourceId": "string",
  "sid": "string",
  "serverResponse": {
    "extensionServiceState": [
      {
        "playload": {
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


### Properties

| Name | Type | Required | Description |
|---|---|---|---|
| resourceId | string | false | The resource ID used by Cloud Recording. |
| sid | string | false | The recording ID, identifying a recording cycle. |
| serverResponse | object | false | [serverResponse](#schemaserverresponse-stop) |
| cname | string | false | The name of the channel to be recorded. |
| uid | string | false | The string content is the user ID used by the cloud recording service in the RTC channel to identify the recording service in the channel. |

## serverResponse-stop
<!-- backwards compatibility -->
<a id="schemaserverresponse-stop"></a>




```json
{
  "extensionServiceState": [
    {
      "playload": {
        "uploadingStatus": "string"
      },
      "serviceName": "string"
    }
  ]
}
```

### Properties

#### Scenario 1

Fields returned in the web page recording scenario.

| Name | Type | Required | Description |
|---|---|---|---|
| extensionServiceState | array[object] | false | See the following. |
| » playload | object | false | [playload-stop](#playload-stop) |
| » serviceName | string | false | Service type:<br>- `"upload_service"`: Upload service. <br>- `"web_recorder_service"`: Web recording service. |

#### Scenario 2

Fields returned in the case of video screenshot capturing during individual recording.

| Name | Type | Required | Description |
|---|---|---|---|
| uploadingStatus | string | false | Current upload status of the recording file:<br>- `"uploaded"`: All recording files have been uploaded to the specified third-party cloud storage. <br>- `"backuped"`: All files of this recording have been uploaded, but at least one TS file has been uploaded to the Agora Backup Cloud. The Agora server will automatically continue to upload this portion of the file to the designated third-party cloud storage. <br>- `"unknown"`: Unknown status. |

#### Scenario 3

Fields returned in scenarios other than video screenshot capturing during the individual recording and web page recording.

| Name | Type | Required | Description |
|---|---|---|---|
| fileListMode | string | false | Data format of `fileList` field: <br>- `"string"`: `fileList` is of String type. In composite recording mode, if `avFileType` is set to `["hls"]`, `fileListMode` is `"string"`. <br>- `"json"`: `fileList` is a JSON Array. When `avFileType` is set to `["hls","mp4"] in the individual or composite` recording mode, `fileListMode` is set to `"json"`. |
| fileList | [fileList-string](#schemafilelist-string) or [fileList-json](#schemafilelist-json) | false | [fileList-string](#schemafilelist-string) or [fileList-json](#schemafilelist-json) |
| uploadingStatus | string | false | Current upload status of the recording file:<br>- `"uploaded"`: All recording files have been uploaded to the specified third-party cloud storage. <br>- `"backuped"`: All files of this recording have been uploaded, but at least one TS file has been uploaded to the Agora Backup Cloud. The Agora server will automatically continue to upload this portion of the file to the designated third-party cloud storage. <br>- `"unknown"`: Unknown status. |

## playload-stop

### Properties

#### Scenario 1

Fields returned by the **upload service** in **web page recording** mode.

| Name | Type | Required | Description |
|---|---|---|---|
| uploadingStatus | string | false | Current upload status of the recording file:<br>- `"uploaded"`: All recording files have been uploaded to the specified third-party cloud storage. <br>- `"backuped"`: All files of this recording have been uploaded, but at least one TS file has been uploaded to the Agora Backup Cloud. The Agora server will automatically continue to upload this portion of the file to the designated third-party cloud storage. <br>- `"unknown"`: Unknown status. |

#### Scenario 2

Fields returned by the **page recording service** in **web page recording** mode.

| Name | Type | Required | Description |
|---|---|---|---|
| fileList | array[object] | false | See the following. |
| » filename | string | false | The file names of the M3U8 and MP4 files generated during recording. |
| » sliceStartTime | number | false | The recording start time of the file, the Unix timestamp, in seconds. |
| onhold | boolean | false | Whether the page recording is in pause state:<br>- `true`: In pause state. <br>- `false`: The page recording is running. |
| state | string | false | The status of uploading subscription content to the extension service:<br>- `"init"`: The service is initializing. <br>- `"inProgress"`: The service has started and is currently in progress. <br>- `"exit"`: Service exits. |
