
<!-- Generator: Widdershins v4.0.1 -->

# API 概述

云端录制是声网针对音视频通话和直播研发的录制组件。你可以通过你的业务服务器向声网服务器发送 HTTP 请求，在服务端进行云端录制：
- `acquire`：请求获取一个 Resource ID 用于开启云端录制。
- `start`：获取 Resource ID 的 2 秒内调用 `start` 开始云端录制。在录制过程中，你可以按需调用如下方法：
   - `query`：查询云端录制的状态。
   - `update`：更新录制设置。
   - `updateLayout`：更新合流布局。
- `stop`：录制完成后，调用 `stop` 离开频道，停止录制。

> 云端录制不支持在一路录制中完成多个任务。例如，如果你需要同时对某个频道进行单流录制和合流录制，那么需要起两路录制。即，使用两个不同的 `uid` 分别调用 `acquire`，获取两个 `resourceId`，再分别调用 start 启动两路录制任务。两路录制均会产生费用。

为方便你监听云端录制的状态，声网提供[消息通知服务](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/enable-ncs)。开通该服务后，你可以通过 Webhook 接收[云端录制相关事件](https://doc.shengwang.cn/api-ref/cloud-recording/restful/webhook/ncs-events)。

因为声网会动态调整消息通知服务器的 IP 地址，为不影响你接收事件，你需要[定期查询 IP 地址](#opIdget-v1-ncs-ip)并更新防火墙白名单配置。

## Base URL

`https://api.sd-rtn.com`


## Authentication

发送 HTTP 请求时，你需要通过 Basic HTTP 认证，并将生成的凭证填入 HTTP 请求头部的 `Authorization` 字段。具体生成 `Authorization` 字段的方法请参考[实现 HTTP 基本认证](https://doc.shengwang.cn/doc/cloud-recording/restful/get-started/authorization)。

# Endpoint

## acquire

<a id="opIdpost-v1-apps-appid-cloud_recording-acquire"></a>


`POST /v1/apps/{appid}/cloud_recording/acquire`

*Acquire：获取云端录制资源*

在开始云端录制之前，你需要调用 `acquire` 方法获取一个 Resource ID。一个 Resource ID 只能用于一次云端录制服务。


**注意**：为确保成功开始云端录制，请按照如下要求操作：
- `acquire` 和 `start` 的请求需配对调用。
- 在每次 `acquire` 请求获取到 Resource ID 后的 2 秒内立即发起对应的 [`start`](#opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start) 请求。批量获取 Resource ID 后进行批量 `start` 请求可能导致请求失败。
- Resource ID 在获取到的 5 分钟内有效，需尽快使用。

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

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|Content-Type|header|string|false|`application/json`。|
|appid|path|string|true|你的项目使用的 [App ID](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id)。<li>对于页面录制模式，只需输入开通了云端录制服务的 App ID。</li><li>对于单流和合流录制模式，必须使用和待录制的频道相同的 App ID，且该 App ID 需要开通云端录制服务。</li>|
|body|body|json object|true|[acquire-request](#schemaacquire-request)|

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

|Status|Description|Schema|
|---|---|---|
|200 OK|如果返回的 HTTP 状态码为 `200`，表示请求成功。如果你在请求 Body 里设置 `startParameter` object，当其取值不合法时，不影响 `acquire` 请求成功，但是在后续 `start` 请求会收到报错。|[acquire-response](#schemaacquire-response)|
|非 200|如果 HTTP 状态码不为 `200`，请参考[响应状态码](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code)排查问题。|[响应状态码](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code)|


## start

<a id="opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start"></a>


`POST /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/mode/{mode}/start`

*Start：开始云端录制*

通过 [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) 方法获取云端录制资源后，调用 `start` 方法开始云端录制。

> 发起 `start` 请求后，你还需要依据[最佳实践](https://doc.shengwang.cn/doc/cloud-recording/restful/best-practices/integration#确认录制服务已成功启动)检查录制服务是否已经成功启动。

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

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|Content-Type|header|string|false|`application/json`。|
|appid|path|string|true|你的项目使用的 [App ID](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id)。<li>对于页面录制模式，只需输入开通了云端录制服务的 App ID。</li><li>对于单流和合流录制模式，必须使用和待录制的频道相同的 App ID，且该 App ID 需要开通云端录制服务。</li>|
|resourceid|path|string|true|通过 [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) 请求获取到的 Resource ID。|
|mode|path|string|true|录制模式：<li>`individual`：[单流录制模式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/set-individual)。</li><li>`mix`：[合流录制模式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite)。</li><li>`web`：[页面录制模式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/web-mode/set-webpage-recording)。</li>|
|body|body|json object|true|[start-request](#schemastart-request)|

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

|Status|Description|Schema|
|---|---|---|
|200|如果返回的 HTTP 状态码为 `200`，表示请求成功。如需检查录制服务是否已经成功启动，请参考[最佳实践](https://doc.shengwang.cn/doc/cloud-recording/restful/best-practices/integration#确认录制服务已成功启动)操作。|[Response Schema](#response-schema) |
|非 200|如果 HTTP 状态码不为 `200`，请参考[响应状态码](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code)排查问题。|[响应状态码](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code)|

#### Response Schema

Status Code **200**

|Name|Type|Required|Description|
|---|---|---|---|
|cname|string|false|录制的频道名。|
|uid|string|false|字符串内容为云端录制服务在 RTC 频道内使用的 UID，用于标识频道内的录制服务。|
|resourceId|string|false|云端录制资源 Resource ID。使用这个 Resource ID 可以开始一段云端录制。这个 Resource ID 的有效期为 5 分钟，超时需要重新请求。|
|sid|string|false|录制 ID。成功开始云端录制后，你会得到一个 Sid （录制 ID）。该 ID 是一次录制周期的唯一标识。|



## update

<a id="opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-sid-sid-mode-mode-update"></a>


`POST /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/sid/{sid}/mode/{mode}/update`

*Update：更新云端录制设置*

开始录制后，你可以调用 `update` 方法更新如下录制配置：
- 对单流录制和合流录制，更新订阅名单。
- 对页面录制，设置暂停/恢复页面录制，或更新页面录制转推到 CDN 的推流地址（URL）。


> - `update` 请求仅在会话内有效。如果录制启动错误，或录制已结束，调用 `update` 将返回 `404`。
> - 如果需要连续调用 `update` 方法更新录制设置，请在收到上一次 `update` 响应后再进行调用，否则可能导致请求结果与预期不一致。

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

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|Content-Type|header|string|false|`application/json`。|
|appid|path|string|true|你的项目使用的 [App ID](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id)。<li>对于页面录制模式，只需输入开通了云端录制服务的 App ID。</li><li>对于单流和合流录制模式，必须使用和待录制的频道相同的 App ID，且该 App ID 需要开通云端录制服务。</li>|
|resourceid|path|string|true|通过 [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) 请求获取到的 Resource ID。|
|sid|path|string|true|通过 [`start`](#opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start) 获取的录制 ID。|
|mode|path|string|true|录制模式：<li>`individual`：[单流录制模式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/set-individual)。</li><li>`mix`：[合流录制模式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite)。</li><li>`web`：[页面录制模式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/web-mode/set-webpage-recording)。</li>|
|body|body|json object|true|[update-request](#schemaupdate-request)|

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

|Status|Description|Schema|
|---|---|---|
|200|如果返回的 HTTP 状态码为 `200`，表示请求成功。|[Response Schema](#response-schema-1)|
|非 200|如果 HTTP 状态码不为 `200`，请参考[响应状态码](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code)排查问题。|[响应状态码](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code)|

#### Response Schema

Status Code **200**

|Name|Type|Required|Description|
|---|---|---|---|
|cname|string|false|录制的频道名。|
|uid|string|false|字符串内容为云端录制服务在 RTC 频道内使用的 UID，用于标识频道内的录制服务。|
|resourceId|string|false|云端录制使用的 Resource ID。|
|sid|string|false|录制 ID。标识每次录制周期。|



## updateLayout

<a id="opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-sid-sid-mode-mode-updateLayout"></a>


`POST /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/sid/{sid}/mode/{mode}/updateLayout`

*UpdateLayout：更新云端录制合流布局*

开始合流录制后，你可以调用该方法（`updateLayout`）更新合流布局。

每次调用该方法都会覆盖原来的布局设置。例如，在开始录制时设置了 `backgroundColor` 为 `"#FF0000"`（红色），如果调用 `updateLayout` 方法更新合流布局时如果不再设置 `backgroundColor` 字段，背景色就会变为黑色（默认值）。


> - `updateLayout` 请求仅在会话内有效。如果录制启动错误，或录制已结束，调用 `updateLayout` 将返回 `404`。
> - 如果需要连续调用 `updateLayout` 方法更新合流布局，请在收到上一次 `updateLayout` 响应后再进行调用，否则可能导致请求结果与预期不一致。

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

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|Content-Type|header|string|false|`application/json`。|
|appid|path|string|true|你的项目使用的 [App ID](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id)。<li>对于页面录制模式，只需输入开通了云端录制服务的 App ID。</li><li>对于单流和合流录制模式，必须使用和待录制的频道相同的 App ID，且该 App ID 需要开通云端录制服务。</li>|
|resourceid|path|string|true|通过 [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) 请求获取到的 Resource ID。|
|sid|path|string|true|通过 [`start`](#opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start) 获取的录制 ID。|
|mode|path|string|true|录制模式。只支持 `mix`，代表[合流录制模式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite)。|
|body|body|json object |true|[updateLayout-request](#schemaupdatelayout-request)|

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

|Status|Description|Schema|
|---|---|---|
|200|如果返回的 HTTP 状态码为 `200`，表示请求成功。|[Response Schema](#response-schema-2)|
|非 200|如果 HTTP 状态码不为 `200`，请参考[响应状态码](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code)排查问题。|[响应状态码](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code)|

#### Response Schema

Status Code **200**

|Name|Type|Required|Description|
|---|---|---|---|
|cname|string|false|录制的频道名。|
|uid|string|false|字符串内容为云端录制服务在 RTC 频道内使用的 UID，用于标识频道内的录制服务。|
|resourceId|string|false|云端录制使用的 Resource ID。|
|sid|string|false|录制 ID。标识一次录制周期。|



## query

<a id="opIdget-v1-apps-appid-cloud_recording-resourceid-resourceid-sid-sid-mode-mode-query"></a>


`GET /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/sid/{sid}/mode/{mode}/query`

*Query：查询云端录制状态*

开始录制后，你可以调用 `query` 方法查询录制状态。

> `query` 请求仅在会话内有效。如果录制启动错误，或录制已结束，调用 `query` 将返回 `404`。

### Parameters

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|Content-Type|header|string|false|`application/json`。|
|appid|path|string|true|你的项目使用的 [App ID](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id)。<li>对于页面录制模式，只需输入开通了云端录制服务的 App ID。</li><li>对于单流和合流录制模式，必须使用和待录制的频道相同的 App ID，且该 App ID 需要开通云端录制服务。</li>|
|resourceid|path|string|true|通过 [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) 请求获取到的 Resource ID。|
|sid|path|string|true|通过 [`start`](#opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start) 获取的录制 ID。|
|mode|path|string|true|录制模式：<li>`individual`：[单流录制模式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/set-individual)。</li><li>`mix`：[合流录制模式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite)。</li><li>`web`：[页面录制模式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/web-mode/set-webpage-recording)。</li>|

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

|Status|Description|Schema|
|---|---|---|
|200|如果返回的 HTTP 状态码为 `200`，表示请求成功。|[query-response](#schemaquery-response)|
|非 200|如果 HTTP 状态码不为 `200`，请参考[响应状态码](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code)排查问题。|[响应状态码](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code)|



## stop

<a id="opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-sid-sid-mode-mode-stop"></a>


`POST /v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/sid/{sid}/mode/{mode}/stop`

*Stop：停止云端录制*

开始录制后，你可以调用 `stop` 方法离开频道，停止录制。录制停止后如需再次录制，必须再调用 `acquire` 方法请求一个新的 Resource ID。

> - `stop` 请求仅在会话内有效。如果录制启动错误，或录制已结束，调用 `stop` 将返回 `404`。
> - 非页面录制模式下，当频道空闲（无用户）超过预设时间（默认为 30 秒） 后，云端录制也会自动退出频道，停止录制。

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

|Name|In|Type|Required|Description|
|---|---|---|---|---|
|Content-Type|header|string|false|`application/json`。|
|appid|path|string|true|你的项目使用的 [App ID](http://doc.shengwang.cn/doc/cloud-recording/restful/get-started/enable-service#%E8%8E%B7%E5%8F%96-app-id)。<li>对于页面录制模式，只需输入开通了云端录制服务的 App ID。</li><li>对于单流和合流录制模式，必须使用和待录制的频道相同的 App ID，且该 App ID 需要开通云端录制服务。</li>|
|resourceid|path|string|true|通过 [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) 请求获取到的 Resource ID。|
|sid|path|string|true|通过 [`start`](#opIdpost-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start) 获取的录制 ID。|
|mode|path|string|true|录制模式：<li>`individual`：[单流录制模式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/set-individual)。</li><li>`mix`：[合流录制模式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite)。</li><li>`web`：[页面录制模式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/web-mode/set-webpage-recording)。</li>|
|body|body|json object |true|[stop-request](#schemastop-request)|

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

|Status|Description|Schema|
|---|---|---|
|200|如果返回的 HTTP 状态码为 `200`，表示请求成功。|[stop-response](#schemastop-response)|
|非 200|如果 HTTP 状态码不为 `200`，请参考[响应状态码](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code)排查问题。|[响应状态码](https://doc.shengwang.cn/api-ref/cloud-recording/restful/response-code)|



## get-ncs-ip

<a id="opIdget-v1-ncs-ip"></a>

`GET /v1/ncs/ip`

*查询消息通知服务器的 IP 地址*

查询消息通知服务器的 IP 地址或 IP 地址列表。

开通消息通知服务后，声网消息通知服务可以将输入在线媒体流业务中的发生的一些事件以 HTTPS 请求的方式通知到你的服务器。声网会动态调整消息通知服务器的 IP 地址，周期为 24 小时。你可以通过本方法查询 IP 地址。查询后，你需要将 IP 地址（或 IP 地址列表）添加到白名单中。

> 我们强烈推荐你至少每 24 小时进行一次查询，并自动更新防火墙配置，否则可能会影响你接收通知。

> Example responses

> 如果返回的 HTTP 状态码为 200，表示请求成功。

你只需关心响应 Body 中的 `PrimaryIP` 字段，无需关心响应 Header 以及响应 Body 中的其他字段。

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

|Status|Description|Schema|
|---|---|---|
|200|如果返回的 HTTP 状态码为 200，表示请求成功。你只需关心响应 Body 中的 `PrimaryIP` 字段，无需关心响应 Header 以及响应 Body 中的其他字段。|[Response Schema](#response-schema-3)|

#### Response Schema

Status Code **200**

|Name|Type|Required|Description|
|---|---|---|---|
|data|object|false|无需了解。|
|» service|object|false|无需了解。|
|»» hosts|array[object]|false|无需了解。|
|»»» primaryIP|string|false|声网消息通知服务器的 IP 地址。|



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
    ],
    "regionAffinity": 0
  }
}
```

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|cname|string|true|频道名：<br>- 对于单流录制和合流录制模式，该字段用于设置待录制的频道名。<br>- 对于页面录制模式，该字段用于区分录制进程。字符串长度不得超过 128 字节。<br>**注意**：通过 `appid`、`cname` 和 `uid` 可以定位一个唯一的录制实例。因此，如果你想针对同一个频道进行多次录制，可以使用相同的 `appId` 和 `cname`，以及不同的 `uid` 来进行管理和区分。|
|uid|string|true|字符串内容为云端录制服务在频道内使用的 UID，用于标识频道内的录制服务，例如 `"527841"`。字符串内容需满足以下条件：<br>- 取值范围 1 到 (2<sup>32</sup>-1)，不可设置为 `0`。<br>- 不能与当前频道内的任何 UID 重复。<br>- 字段引号内为整型 UID，且频道内所有用户均使用整型 UID。|
|clientRequest|object|false|见下所述。|
|» scene|number|false|云端录制资源使用场景：<br>- `0`：实时音视频录制。<br>- `1`：页面录制。<br>- `2`：单流录制模式，且开启延时转码或延时混音。<br>    - 延时转码：录制服务会在录制后 24 小时内（特殊情况下会到 48 小时以上）对录制文件进行转码生成 MP4 文件，并将 MP4 文件上传至你指定的第三方云存储。该场景仅适用于单流录制模式。<br>    - 延时混音：录制服务会在录制结束后 24 小时内（特殊情况下会到 48 小时以上）将指定频道内所有 UID 的录制文件合并并转码生成一个 MP3/M4A/AAC 文件，并将文件上传至你指定的第三方云存储。该场景仅适用于音频单流不转码录制模式。<br>    > - `scene` 设为 `2` 时，你需要同时在 `start` 方法中设置 `appsCollection` 字段。<br>    > - 在延时转码和延时混音的场景下，录制文件会在声网边缘服务器上缓存，最长不超过 24 小时。如果你的业务对信息安全敏感，为了确保数据合规，请慎重考虑是否使用延时转码和延时混音功能。如有任何疑虑，请联系声网技术支持。|
|» resourceExpiredHour|number|false|云端录制 RESTful API 的调用时效。从成功开启云端录制并获得 `sid` （录制 ID）后开始计算。单位为小时。<br><br>**注意**：超时后，你将无法调用 `query`，`update`，`updateLayout` 和 `stop` 方法。</br>|
|» startParameter|[client-request](#schemaclient-request)|false|设置该字段后，可以提升可用性并优化负载均衡。<br><br>**注意**：如果填写该字段，则必须确保 `startParameter` object 和后续 `start` 请求中填写的 `clientRequest` object 完全一致，且取值合法，否则 `start` 请求会收到报错。|
|» excludeResourceIds|array[string]|false|另一路或几路录制任务的 `resourceId`。该字段用于排除指定的录制资源，以便新发起的录制任务可以使用新区域的资源，实现跨区域多路录制。详见[多路任务保障](https://doc.shengwang.cn/doc/cloud-recording/restful/best-practices/integration#多路任务保障)。|
|» regionAffinity|number|false|指定使用某个区域的资源进行录制。支持取值如下：<br>- `0`: 根据发起请求的区域就近调用资源。<br>- `1`: 中国。<br>- `2`: 东南亚。<br>- `3`: 欧洲。<br>- `4`: 北美。<br>**注意**：<br>- 为加速录制文件上传，当你使用的云存储区域和你发起请求的区域不同时，建议你将该字段设为云存储区域。<br>- 指定区域可用容量不足时，会依据地理位置就近溢出。|

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

|Name|Type|Required|Description|
|---|---|---|---|
|token|string|false|用于鉴权的动态密钥（Token）。如果你的项目已启用 App 证书，则务必在该字段中传入你项目的动态密钥。详见[使用 Token 鉴权](https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication)。<br><p><b>注意</b>：<br><li>仅需在<b>单流录制</b>和<b>合流录制</b>模式下设置。</li><br><li>云端录制服务暂不支持更新 Token。为保证录制正常，请确保 Token 有效时长大于你预计的录制时长，以避免 Token 过期导致录制任务退出频道而结束录制。</li><br></p>|
|storageConfig|[storageConfig](#schemastorageconfig)|true|第三方云存储的配置项。|
|recordingConfig|[recordingConfig](#schemarecordingconfig)|false|录制的音视频流配置项。<br><p><b>注意：</b>仅需在<b>单流录制</b>和<b>合流录制</b>模式下设置。</p>|
|recordingFileConfig|[recordingFileConfig](#schemarecordingfileconfig)|false|录制文件配置项。<br><p><b>注意</b>：<b>仅截图时不可设置</b>该字段，其他情况都需要设置该字段。其他情况包含如下：<br><li>单流录制模式下，不转码录制，转码录制，或同时录制和截图。</li><br><li>合流录制。</li><br><li>页面录制模式下，仅页面录制，或同时页面录制和转推到 CDN。</li><br></p>|
|snapshotConfig|[snapshotConfig](#schemasnapshotconfig)|false|视频截图配置项。<p><b>注意：</b>仅需在<b>单流录制</b>模式下，且使用截图功能时设置。</p><br>**截图**使用须知：<br>- 截图功能仅适用于单流录制模式（`individual`）。<br>- 你可以在一个单流录制进程中仅截图，或同时录制和截图，详见[视频截图](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/snapshot)。同时录制和截图的情况需要设置 `recordingFileConfig` 字段。<br>- 如果录制服务或录制上传服务异常，则截图失败。截图异常时，录制不受影响。<br>- 使用截图时，`streamTypes` 必须设置为 1 或 2。如果设置了 `subscribeAudioUid`，则必须同时设置 `subscribeVideoUids`。|
|extensionServiceConfig|[extensionServiceConfig](#schemaextensionserviceconfig)|false|扩展服务配置项。<br><p><b>注意：</b>仅需在<b>页面录制</b>模式下设置。</p>|
|appsCollection|[appsCollection](#schemaappscollection)|false|应用配置项。<br><p><b>注意：</b>仅需在<b>单流录制模式</b>下，且开启延时转码或延时混音时设置。</p>|
|transcodeOptions|[transcodeOptions](#schematranscodeoptions)|false|延时转码或延时混音下，生成的录制文件的配置项。<br><p><b>注意：</b>仅需在<b>单流录制模式</b>下，且开启延时转码或延时混音时设置。</p>|

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

第三方云存储的配置项。

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|vendor|number|true|第三方云存储平台。<br>- `1`：[Amazon S3](https://aws.amazon.com/cn/s3/?c=s&sec=srv)<br>- `2`：[阿里云](https://www.aliyun.com/product/oss)<br>- `3`：[腾讯云](https://cloud.tencent.com/product/cos)<br>- `5`：[Microsoft Azure](https://azure.microsoft.com/zh-cn/products/storage/blobs/)<br>- `6`：[谷歌云](https://cloud.google.com/storage)<br>- `7`：[华为云](https://www.huaweicloud.com/product/obs.html)<br>- `8`：[百度智能云](https://cloud.baidu.com/product/bos.html)|
|region|number|true|第三方云存储指定的地区信息。<br><br><b>注意：</b>为确保录制文件上传的成功率和实时性，第三方云存储的 `region` 与你发起请求的应用服务器必须在同一个区域中。例如：你发起请求的 App 服务器在中国大陆地区，则第三方云存储需要设置为中国大陆区域内。详见[第三方存储地区说明](https://doc.shengwang.cn/api-ref/cloud-recording/restful/region-vendor)。</br>|
|bucket|string|true|第三方云存储的 Bucket。Bucket 名称需要符合对应第三方云存储服务的命名规则。|
|accessKey|string|true|第三方云存储的 Access Key（访问密钥）。如需延时转码，则访问密钥必须具备读写权限；否则建议只需提供写权限。|
|secretKey|string|true|第三方云存储的 Secret Key。|
|fileNamePrefix|array[string]|false|录制文件在第三方云存储中的存储位置，与录制文件名前缀有关。如果设为 `["directory1","directory2"]`，那么录制文件名前缀为 `"directory1/directory2/"`，即录制文件名为 `directory1/directory2/xxx.m3u8`。前缀长度（包括斜杠）不得超过 128 个字符。字符串中不得出现斜杠、下划线、括号等符号字符。以下为支持的字符集范围：<br>- 26 个小写英文字母 a~z<br>- 26 个大写英文字母 A~Z<br>- 10 个数字 0-9|
|extensionParams|[extensionParams](#schemaextensionparams)|false|第三方云存储服务会按照该字段设置对已上传的录制文件进行加密和打标签。|

## extensionParams
<!-- backwards compatibility -->
<a id="schemaextensionparams"></a>




```json
{
  "sse": "string",
  "tag": "string"
}
```

第三方云存储服务会按照该字段设置对已上传的录制文件进行加密和打标签。

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|sse|string|true|加密模式。设置该字段后，第三方云存储服务会按照该加密模式将已上传的录制文件进行加密。该字段仅适用于 Amazon S3，详见 [Amazon S3 官方文档](https://docs.aws.amazon.com/zh_cn/AmazonS3/latest/userguide/UsingEncryption.html)。<br>- `kms`：KMS 加密。<br>- `aes256`：AES256 加密。|
|tag|string|true|标签内容。设置该字段后，第三方云存储服务会按照该标签内容将已上传的录制文件进行打标签操作。该字段仅适用于阿里云和 Amazon S3，详见[阿里云官方文档](https://help.aliyun.com/zh/oss/user-guide/object-tagging-8)和 [Amazon S3 官方文档](https://docs.aws.amazon.com/zh_cn/AmazonS3/latest/userguide/UsingEncryption.html)。|

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

录制的音视频流配置项。
<p><b>注意：</b>仅需在<b>单流录制</b>和<b>合流录制</b>模式下设置。</p>

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|channelType|number|true|频道场景。<br>- `0`：通信场景。<br>- `1`：直播场景。<br>频道场景必须与声网 RTC SDK 的设置一致，否则可能导致问题。|
|decryptionMode|number|false|解密模式。如果你在 SDK 客户端设置了频道加密，那么你需要对云端录制服务设置与加密相同的解密模式。<br>- `0`：不加密。<br>- `1`：AES_128_XTS 加密模式。128 位 AES 加密，XTS 模式。<br>- `2`：AES_128_ECB 加密模式。128 位 AES 加密，ECB 模式。<br>- `3`：AES_256_XTS 加密模式。256 位 AES 加密，XTS 模式。<br>- `4`：SM4_128_ECB 加密模式。128 位 SM4 加密，ECB 模式。<br>- `5`：AES_128_GCM 加密模式。128 位 AES 加密，GCM 模式。<br>- `6`：AES_256_GCM 加密模式。256 位 AES 加密，GCM 模式。<br>- `7`：AES_128_GCM2 加密模式。128 位 AES 加密，GCM 模式。相比于 AES_128_GCM 加密模式，AES_128_GCM2 加密模式安全性更高且需要设置密钥和盐。<br>- `8`：AES_256_GCM2 加密模式。256 位 AES 加密，GCM 模式。相比于 AES_256_GCM 加密模式，AES_256_GCM2 加密模式安全性更高且需要设置密钥和盐。|
|secret|string|false|与加解密相关的密钥。仅需在 `decryptionMode` 非 `0` 时设置。|
|salt|string|false|与加解密相关的盐。Base64 编码、32 位字节。仅需在 `decryptionMode` 为 `7` 或 `8` 时设置。|
|maxIdleTime|number|false|最大频道空闲时间。单位为秒。最大值不超过 30 天。超出最大频道空闲时间后，录制服务会自动退出。录制服务退出后，如果你再次发起 `start` 请求，会产生新的录制文件。<br><p>频道空闲：直播频道内无任何主播，或通信频道内无任何用户。</p>|
|streamTypes|number|false|订阅的媒体流类型。<br>- `0`：仅订阅音频。适用于智能语音审核场景。<br>- `1`：仅订阅视频。<br>- `2`：订阅音频和视频。|
|videoStreamType|number|false|设置订阅的视频流类型。如果你在 SDK 客户端开启了双流模式，你可以选择订阅视频大流或者小流。<br>- `0`：视频大流，即高分辨率高码率的视频流<br>- `1`：视频小流，即低分辨率低码率的视频流|
|subscribeAudioUids|array[string]|false|指定订阅哪几个 UID 的音频流。如需订阅全部 UID 的音频流，则无需设置该字段。数组长度不得超过 32，不推荐使用空数组。该字段和 `unsubscribeAudioUids` 只能设一个。详见[设置订阅名单](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe)。<br><p><b>注意：</b><br><li>该字段仅适用于 <b>streamTypes</b> 设为音频，或音频和视频的情况。</li><br><li>如果你设置了音频的订阅名单，但没有设置视频的订阅名单，云端录制服务不会订阅任何视频流。反之亦然。</li><br><li>设为 <b>["#allstream#"]</b> 可订阅频道内所有 UID 的音频流。</li><br></p>|
|unsubscribeAudioUids|array[string]|false|指定不订阅哪几个 UID 的音频流。云端录制会订阅频道内除指定 UID 外所有 UID 的音频流。数组长度不得超过 32，不推荐使用空数组。该字段和 `subscribeAudioUids` 只能设一个。详见[设置订阅名单](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe)。|
|subscribeVideoUids|array[string]|false|指定订阅哪几个 UID 的视频流。如需订阅全部 UID 的视频流，则无需设置该字段。数组长度不得超过 32，不推荐使用空数组。该字段和 `unsubscribeVideoUids` 只能设一个。详见[设置订阅名单](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe)。<br><p><b>注意：</b><br><li>该字段仅适用于 <b>streamTypes</b> 设为视频，或音频和视频的情况。</li><br><li>如果你设置了视频的订阅名单，但没有设置音频的订阅名单，云端录制服务不会订阅任何音频流。反之亦然。</li><br><li>设为 <b>["#allstream#"]</b> 可订阅频道内所有 UID 的视频流。</li><br></p>|
|unsubscribeVideoUids|array[string]|false|指定不订阅哪几个 UID 的视频流。云端录制会订阅频道内除指定 UID 外所有 UID 的视频流。数组长度不得超过 32，不推荐使用空数组。该字段和 `subscribeVideoUids` 只能设一个。详见[设置订阅名单](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe)。|
|subscribeUidGroup|number|false|预估的订阅人数峰值。<br>- `0`：1 到 2 个 UID。<br>- `1`：3 到 7 个 UID。<br>- `2`：8 到 12 个 UID。<br>- `3`：13 到 17 个 UID。<br>- `4`：17 到 32 个 UID。<br>- `5`：32 到 49 个 UID。<br>**注意**：<br>- 仅需在**单流录制**模式下设置，且单流录制模式下必填。<br>- 举例来说，如果 `subscribeVideoUids` 为 `["100","101","102"]`，`subscribeAudioUids` 为 `["101","102","103"]`，则订阅人数为 4 人。|
|streamMode|string|false|媒体流的输出模式。详见[媒体流输出模式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/stream-mode)。<br>- `"default"`：默认模式。录制过程中音频转码，分别生成 M3U8 音频索引文件和视频索引文件。<br>- `"standard"`：标准模式。声网推荐使用该模式。录制过程中音频转码，分别生成 M3U8 音频索引文件、视频索引文件和合并的音视频索引文件。如果在 Web 端使用 VP8 编码，则生成一个合并的 MPD 音视频索引文件。<br>- `"original"`：原始编码模式。适用于[单流音频不转码录制](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/individual-mode/set-individual-nontranscoding)。仅订阅音频时（`streamTypes` 为 0）时该字段生效，录制过程中音频不转码，生成 M3U8 音频索引文件。<br>**注意**：仅需在**单流录制**模式下设置。|
|audioProfile|number|false|设置输出音频的采样率、码率、编码模式和声道数。<br>- `0`：48 kHz 采样率，音乐编码，单声道，编码码率约 48 Kbps。<br>- `1`：48 kHz 采样率，音乐编码，单声道，编码码率约 128 Kbps。<br>- `2`：48 kHz 采样率，音乐编码，双声道，编码码率约 192 Kbps。<br>**注意**：仅需在**合流录制**模式下设置。|
|transcodingConfig|[transcodingConfig](#schematranscodingconfig)|false|转码输出的视频配置项。取值可参考[设置录制输出视频的分辨率](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-output-video-profile)。<br><p><b>注意：</b>仅需在<b>单流录制</b>和<b>合流录制</b>模式下设置。</p>|




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

转码输出的视频配置项。取值可参考[设置录制输出视频的分辨率](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-output-video-profile)。
<p><b>注意：</b>仅需在<b>单流录制</b>和<b>合流录制</b>模式下设置。</p>

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|width|number|true|视频的宽度，单位为像素。`width` 和 `height` 的乘积不能超过 1920 × 1080。|
|height|number|true|视频的高度，单位为像素。`width` 和 `height` 的乘积不能超过 1920 × 1080。|
|fps|number|true|视频的帧率，单位 fps。|
|bitrate|number|true|视频的码率，单位 Kbps。|
|maxResolutionUid|string|false|仅需在**垂直布局**下设置。指定显示大视窗画面的用户 UID。字符串内容的整型取值范围 1 到 (2<sup>32</sup>-1)，且不可设置为 0。|
|mixedVideoLayout|number|false|视频合流布局：<br>- `0`：悬浮布局。第一个加入频道的用户在屏幕上会显示为大视窗，铺满整个画布，其他用户的视频画面会显示为小视窗，从下到上水平排列，最多 4 行，每行 4 个画面，最多支持共 17 个画面。<br>- `1`：自适应布局。根据用户的数量自动调整每个画面的大小，每个用户的画面大小一致，最多支持 17 个画面。<br>- `2`：垂直布局。指定 `maxResolutionUid` 在屏幕左侧显示大视窗画面，其他用户的小视窗画面在右侧垂直排列，最多两列，一列 8 个画面，最多支持共 17 个画面。<br>- `3`：自定义布局。由你在 `layoutConfig` 字段中自定义合流布局。|
|backgroundColor|string|false|视频画布的背景颜色。支持 RGB 颜色表，字符串格式为 # 号和 6 个十六进制数。默认值 `"#000000"`，代表黑色。|
|backgroundImage|string|false|视频画布的背景图的 URL。背景图的显示模式为裁剪模式。<br><p>裁剪模式：优先保证画面被填满。背景图尺寸等比缩放，直至整个画面被背景图填满。如果背景图长宽与显示窗口不同，则背景图会按照画面设置的比例进行周边裁剪后填满画面。</p>|
|defaultUserBackgroundImage|string|false|默认的用户画面背景图的 URL。<br><p>配置该字段后，当任一⽤户停止发送视频流超过 3.5 秒，画⾯将切换为该背景图；如果针对某 UID 单独设置了背景图，则该设置会被覆盖。</p>|
|layoutConfig|array[object]|false|[layoutConfig](#schemalayoutconfig)|
|backgroundConfig|[backgroundConfig](#schemabackgroundconfig)|false|用户的背景图设置。|



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

用户的合流画面布局。由每个用户对应的布局画面设置组成的数组，支持最多 17 个用户。
<p><b>注意：</b>仅需在<b>自定义布局</b>下设置。</p>

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|uid|string|false|字符串内容为待显示在该区域的用户的 UID，32 位无符号整数。<br><p>如果不指定 UID，会按照用户加入频道的顺序自动匹配 <b>layoutConfig</b> 中的画面设置。</p>|
|x_axis|number(float)|true|屏幕里该画面左上角的横坐标的相对值，精确到小数点后六位。从左到右布局，`0.0` 在最左端，`1.0` 在最右端。该字段也可以设置为整数 0 或 1。|
|y_axis|number(float)|true|屏幕里该画面左上角的纵坐标的相对值，精确到小数点后六位。从上到下布局，`0.0` 在最上端，`1.0` 在最下端。该字段也可以设置为整数 0 或 1。|
|width|number(float)|true|该画面宽度的相对值，精确到小数点后六位。该字段也可以设置为整数 0 或 1。|
|height|number(float)|true|该画面高度的相对值，精确到小数点后六位。该字段也可以设置为整数 0 或 1。|
|alpha|number(float)|false|图像的透明度。精确到小数点后六位。`0.0` 表示图像为透明的，`1.0` 表示图像为完全不透明的。|
|render_mode|number|false|画面显示模式：<br>- `0`：裁剪模式。优先保证画面被填满。视频尺寸等比缩放，直至整个画面被视频填满。如果视频长宽与显示窗口不同，则视频流会按照画面设置的比例进行周边裁剪后填满画面。<br>- `1`：缩放模式。优先保证视频内容全部显示。视频尺寸等比缩放，直至视频窗口的一边与画面边框对齐。如果视频尺寸与画面尺寸不一致，在保持长宽比的前提下，将视频进行缩放后填满画面，缩放后的视频四周会有一圈黑边。|


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

用户的背景图设置。

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|uid|string|true|字符串内容为用户 UID。|
|image_url|string|true|该用户的背景图 URL。配置背景图后，当该⽤户停止发送视频流超过 3.5 秒，画⾯将切换为该背景图。<br><br>URL 支持 HTTP 和 HTTPS 协议，图片格式支持 JPG 和 BMP。图片大小不得超过 6 MB。录制服务成功下载图片后，设置才会生效；如果下载失败，则设置不⽣效。不同字段设置可能会互相覆盖，具体规则详见[设置背景色或背景图](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/mix-mode/set-composite-layout#%E8%BF%9B%E9%98%B6%E8%AE%BE%E7%BD%AE%E8%83%8C%E6%99%AF%E8%89%B2%E6%88%96%E8%83%8C%E6%99%AF%E5%9B%BE)。</br>|
|render_mode|number|false|画面显示模式：<br>- `0`：裁剪模式。优先保证画面被填满。视频尺寸等比缩放，直至整个画面被视频填满。如果视频长宽与显示窗口不同，则视频流会按照画面设置的比例进行周边裁剪后填满画面。<br>- `1`：缩放模式。优先保证视频内容全部显示。视频尺寸等比缩放，直至视频窗口的一边与画面边框对齐。如果视频尺寸与画面尺寸不一致，在保持长宽比的前提下，将视频进行缩放后填满画面，缩放后的视频四周会有一圈黑边。|

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

|Name|Type|Required|Description|
|---|---|---|---|
|avFileType|array[string]|false|录制生成的视频文件类型：<br>- `"hls"`：默认值。M3U8 和 TS 文件。<br>- `"mp4"`：MP4 文件。<br>**注意**：<br>- **单流录制**模式下，且**非仅截图**情况，使用默认值即可。<br>- **合流录制**和**页面录制**模式下，你需设为 `["hls","mp4"]`。仅设为 `["mp4"]` 会收到报错。设置后，录制文件行为如下：<br>    - 合流录制模式：录制服务会在当前 MP4 文件时长超过约 2 小时或文件大小超过约 2 GB 左右时，创建一个新的 MP4 文件。<br>    - 页面录制模式：录制服务会在当前 MP4 文件时长超过 `maxVideoDuration` 时，创建一个新的 MP4 文件。|

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

|Name|Type|Required|Description|
|---|---|---|---|
|captureInterval|number|false|云端录制定期截图的截图周期。单位为秒。|
|fileType|array[string]|true|截图的文件格式。目前只支持 `["jpg"]`，即生成 JPG 格式的截图文件。|

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

扩展服务配置项。
<p><b>注意：</b>仅需在<b>页面录制</b>模式下设置。</p>

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|errorHandlePolicy|string|false|错误处理策略。默认且仅可设为 `"error_abort"`，表示当扩展服务发生错误后，订阅和云端录制的其他非扩展服务都停止。|
|extensionServices|array[object]|true|见下所述。|
|» serviceName|string|true|扩展服务的名称：<br>- `web_recorder_service`：代表扩展服务为**页面录制**。<br>- `rtmp_publish_service`：代表扩展服务为**转推页面录制到 CDN**。|
|» errorHandlePolicy|string|false|扩展服务内的错误处理策略：<br>- `"error_abort"`：**页面录制**时默认且只能为该值。表示当前扩展服务出错时，停止其他扩展服务。<br>- `"error_ignore"`：**转推页面录制到 CDN** 时默认且只能为该值。表示当前扩展服务出错时，其他扩展服务不受影响。<br><p>如果页面录制服务或录制上传服务异常，那么推流到 CDN 失败，因此<b>页面录制</b>服务出错会影响<b>转推页面录制到 CDN</b> 服务。</p><br><p>转推到 CDN 的过程发生异常时，页面录制不受影响。</p>|
|» serviceParam|[serviceParam](#schemaserviceparam)|true|扩展服务的具体配置项。|

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

#### 情况一

**页面录制**时需设置如下字段

|Name|Type|Required|Description|
|---|---|---|---|
| url|string|true|待录制页面的地址。|
| audioProfile|number|true|输出音频的采样率、码率、编码模式和声道数。<br>- `0`：48 kHz 采样率，音乐编码，单声道，编码码率约 48 Kbps。<br>- `1`：48 kHz 采样率，音乐编码，单声道，编码码率约 128 Kbps。<br>- `2`：48 kHz 采样率，音乐编码，双声道，编码码率约 192 Kbps。|
| videoWidth|number|true|输出视频的宽度，单位为 pixel。`videoWidth` 和 `videoHeight` 的乘积需小于等于 1920 × 1080。推荐值可参考[如何设置页面录制移动端网页模式的输出视频分辨率](https://doc.shengwang.cn/faq/integration-issues/mobile-video-profile)。|
| videoHeight|number|true|输出视频的高度，单位为 pixel。`videoWidth` 和 `videoHeight` 的乘积需小于等于 1920 × 1080。推荐值可参考[如何设置页面录制移动端网页模式的输出视频分辨率](https://doc.shengwang.cn/faq/integration-issues/mobile-video-profile)。|
| maxRecordingHour|number|true|页面录制的最大时长，单位为小时。超出该值后页面录制会自动停止。<br>> 建议取值不超过你在 `acquire` 方法中设置的 `resourceExpiredHour` 的值。<br><p><b>计费相关</b>：页面录制停止前会持续计费，因此请根据实际业务情况设置合理的值或主动停止页面录制。</p>|
| videoBitrate|number|false|输出视频的码率，单位为 Kbps。针对不同的输出视频分辨率，`videoBitrate` 的默认值不同：<br>- 输出视频分辨率大于或等于 1280 × 720：默认值为 2000。<br>- 输出视频分辨率小于 1280 × 720：默认值为 1500。|
| videoFps|number|false|输出视频的帧率，单位为 fps。|
| mobile|boolean|false|是否开启移动端网页模式：<br>- `true`：开启。开启后，录制服务使用移动端网页渲染模式录制当前页面。<br>- `false`：（默认）不开启。|
| maxVideoDuration|number|false|页面录制生成的 MP4 切片文件的最大时长，单位为分钟。页面录制过程中，录制服务会在当前 MP4 文件时长超过约 `maxVideoDuration` 左右时创建一个新的 MP4 切片文件。|
| onhold|boolean|false|是否在启动页面录制任务时暂停页面录制。<br>- `true`：在启动页面录制任务时暂停页面录制。开启页面录制任务后立即暂停录制，录制服务会打开并渲染待录制页面，但不生成切片文件。<br>- `false`：启动页面录制任务并进行页面录制。<br>建议你按照如下流程使用 `onhold` 字段：<br>1. 调用 `start` 方法时将 `onhold` 设为 `true`，开启并暂停页面录制，自行判断页面录制开始的合适时机。<br>2. 调用 `update` 并将 `onhold` 设为 `false`，继续进行页面录制。如果需要连续调用 `update` 方法暂停或继续页面录制，请在收到上一次 `update` 响应后再进行调用，否则可能导致请求结果与预期不一致。|
| readyTimeout|number|false|设置页面加载超时时间，单位为秒。详见[页面加载超时检测](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/web-mode/detect-timeout)。<br>- `0` 或不设置，表示不检测页面加载状态。<br>- [1,60] 之间的整数，表示页面加载超时时间。|

#### 情况二

**转推页面录制到 CDN** 时需设置如下字段。

|Name|Type|Required|Description|
|---|---|---|---|
|outputs|array[object]|true|见下所述。|
|» rtmpUrl|string|true|CDN 推流地址。|


## appsCollection
<!-- backwards compatibility -->
<a id="schemaappscollection"></a>




```json
{
  "combinationPolicy": "default"
}
```

应用配置项。
<p><b>注意：</b>仅需在<b>单流录制模式</b>下，且开启延时转码或延时混音时设置。</p>

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|combinationPolicy|string|false|各云端录制应用的组合方式。<br>- `postpone_transcoding`：如需延时转码或延时混音，则选用此种方式。<br>- `default`：除延时转码和延时混音外，均选用此种方式。|

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

延时转码或延时混音下，生成的录制文件的配置项。
<p><b>注意：</b>仅需在<b>单流录制模式</b>下，且开启延时转码或延时混音时设置。</p>

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|transConfig|object|true|见下所述。|
|» transMode|string|true|模式：<br>- `"postponeTranscoding"`：延时转码。<br>- `"audioMix"`：延时混音。|
|container|object|false|见下所述。|
|» format|string|false|文件的容器格式，支持如下取值：<br>- `"mp4"`：延时转码时的默认格式。MP4 格式。<br>- `"mp3"`：延时混音时的默认格式。MP3 格式。<br>- `"m4a"`：M4A 格式。<br>- `"aac"`：AAC 格式。<br>**注意**：延时转码暂时只能设为 MP4 格式。|
|audio|object|false|文件的音频属性。<br><p><b>注意：</b>仅需在<b>单流录制模式</b>下，且开启<b>延时混音</b>时设置。</p>|
|» sampleRate|string|false|音频采样率 (Hz)，支持如下取值：<br>- `"48000"`：48 kHz。 <br>- `"32000"`：32 kHz。<br>- `"16000"`：16 kHz。|
|» bitrate|string|false|音频码率 (Kbps)，支持取值且默认取值为 `"48000"`。|
|» channels|string|false|音频声道数，支持如下取值：<br>- `"1"`：单声道。<br>- `"2"`：双声道。|

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

|Name|Type|Required|Description|
|---|---|---|---|
|cname|string|false|录制的频道名。|
|uid|string|false|字符串内容为云端录制服务在 RTC 频道内使用的 UID，用于标识频道内的录制服务。|
|resourceId|string|false|云端录制资源 Resource ID。使用这个 Resource ID 可以开始一段云端录制。这个 Resource ID 的有效期为 5 分钟，超时需要重新请求。|



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

|Name|Type|Required|Description|
|---|---|---|---|
|cname|string|true|录制服务所在频道的名称。需要和你在 [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) 请求中输入的 `cname` 相同。|
|uid|string|true|字符串内容为录制服务在 RTC 频道内使用的 UID，用于标识该录制服务，需要和你在 [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) 请求中输入的 `uid` 相同。|
|clientRequest|object|true|[client-request](#schemaclient-request)|


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

|Name|Type|Required|Description|
|---|---|---|---|
|cname|string|true|录制服务所在频道的名称。需要和你在 [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) 请求中输入的 `cname` 相同。|
|uid|string|true|字符串内容为录制服务在 RTC 频道内使用的 UID，用于标识该录制服务，需要和你在 [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) 请求中输入的 `uid` 相同。|
|clientRequest|object|true|[clientRequest](#schemaclientrequest)|

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

|Name|Type|Required|Description|
|---|---|---|---|
|streamSubscribe|[streamSubscribe](#schemastreamsubscribe)|false|更新订阅名单。<br><p><b>注意：</b>仅需在<b>单流录制</b>和<b>合流录制</b>模式下设置。</p>|
|webRecordingConfig|[webRecordingConfig](#schemawebrecordingconfig)|false|用于更新页面录制配置项。<br><p><b>注意：</b>仅需在<b>页面录制</b>模式下设置。</p>|
|rtmpPublishConfig|[rtmpPublishConfig](#schemartmppublishconfig)|false|用于更新转推页面录制到 CDN 的配置项。<br><p><b>注意：</b>仅需在<b>页面录制</b>模式下，且<b>转推页面录制到 CDN</b> 时设置。<p>|

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

更新订阅名单。
<p><b>注意：</b>仅需在<b>单流录制</b>和<b>合流录制</b>模式下设置。</p>

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|audioUidList|[audioUidList](#schemaaudiouidlist)|false|音频订阅名单。<br><p><b>注意：</b>该字段仅适用于 <b>streamTypes</b> 设为音频，或音频和视频的情况。</p>|
|videoUidList|[videoUidList](#schemavideouidlist)|false|视频订阅名单。<br><p><b>注意：</b>该字段仅适用于 <b>streamTypes</b> 设为视频，或音频和视频的情况。</p>|

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

音频订阅名单。
<p><b>注意：</b>该字段仅适用于 <b>streamTypes</b> 设为音频，或音频和视频的情况。</p>

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|subscribeAudioUids|array[string]|false|指定订阅哪几个 UID 的音频流。如需订阅全部 UID 的音频流，则无需设置该字段。数组长度不得超过 32，不推荐使用空数组。该字段和 `unsubscribeAudioUids` 只能设一个。详见[设置订阅名单](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe)。<br><p><b>注意：</b><br><li>该字段仅适用于 <b>streamTypes</b> 设为音频，或音频和视频的情况。</li><br><li>如果你设置了音频的订阅名单，但没有设置视频的订阅名单，云端录制服务不会订阅任何视频流。反之亦然。</li><br><li>设为 <b>["#allstream#"]</b> 可订阅频道内所有 UID 的音频流。</li><br></p>|
|unsubscribeAudioUids|array[string]|false|指定不订阅哪几个 UID 的音频流。云端录制会订阅频道内除指定 UID 外所有 UID 的音频流。数组长度不得超过 32，不推荐使用空数组。该字段和 `subscribeAudioUids` 只能设一个。详见[设置订阅名单](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe)。|

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

视频订阅名单。
<p><b>注意：</b>该字段仅适用于 <b>streamTypes</b> 设为视频，或音频和视频的情况。</p>

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|subscribeVideoUids|array[string]|false|指定订阅哪几个 UID 的视频流。如需订阅全部 UID 的视频流，则无需设置该字段。数组长度不得超过 32，不推荐使用空数组。该字段和 `unsubscribeVideoUids` 只能设一个。详见[设置订阅名单](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe)。<br><p><b>注意：</b><br><li>该字段仅适用于 <b>streamTypes</b> 设为视频，或音频和视频的情况。</li><br><li>如果你设置了视频的订阅名单，但没有设置音频的订阅名单，云端录制服务不会订阅任何音频流。反之亦然。</li><br><li>设为 <b>["#allstream#"]</b> 可订阅频道内所有 UID 的视频流。</li><br></p>|
|unsunscribeVideoUids|array[string]|false|指定不订阅哪几个 UID 的视频流。云端录制会订阅频道内除指定 UID 外所有 UID 的视频流。数组长度不得超过 32，不推荐使用空数组。该字段和 `subscribeVideoUids` 只能设一个。详见[设置订阅名单](http://doc.shengwang.cn/doc/cloud-recording/restful/user-guide/set-subscribe)。|

## webRecordingConfig
<!-- backwards compatibility -->
<a id="schemawebrecordingconfig"></a>




```json
{
  "onhold": false
}
```

用于更新页面录制配置项。
<p><b>注意：</b>仅需在<b>页面录制</b>模式下设置。</p>

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|onhold|boolean|false|是否在启动页面录制任务时暂停页面录制。<br>- `true`：在启动页面录制任务时暂停页面录制。开启页面录制任务后立即暂停录制，录制服务会打开并渲染待录制页面，但不生成切片文件。<br>- `false`：启动页面录制任务并进行页面录制。<br>建议你按照如下流程使用 `onhold` 字段：<br>1. 调用 `start` 方法时将 `onhold` 设为 `true`，开启并暂停页面录制，自行判断页面录制开始的合适时机。<br>2. 调用 `update` 并将 `onhold` 设为 `false`，继续进行页面录制。如果需要连续调用 `update` 方法暂停或继续页面录制，请在收到上一次 `update` 响应后再进行调用，否则可能导致请求结果与预期不一致。|

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

用于更新转推页面录制到 CDN 的配置项。
<p><b>注意：</b>仅需在<b>页面录制</b>模式下，且<b>转推页面录制到 CDN</b> 时设置。<p>

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|outputs|array[object]|false|见下所述。|
|» rtmpUrl|string|false|CDN 推流 URL。<br><p><b>注意</b>：<br><li>URL 仅支持 RTMP 和 RTMPS 协议。</li><br><li>支持的最大转推 CDN 路数为 1。</li><br></p>|

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

|Name|Type|Required|Description|
|---|---|---|---|
|cname|string|true|录制服务所在频道的名称。需要和你在 [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) 请求中输入的 `cname` 相同。|
|uid|string|true|字符串内容为录制服务在 RTC 频道内使用的 UID，用于标识该录制服务，需要和你在 [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) 请求中输入的 `uid` 相同。|
|clientRequest|object |true|[clientRequest-updateLayout](#schemaclientrequest-updatelayout)|

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

|Name|Type|Required|Description|
|---|---|---|---|
|maxResolutionUid|string|false|仅需在**垂直布局**下设置。指定显示大视窗画面的用户 UID。字符串内容的整型取值范围 1 到 (2<sup>32</sup>-1)，且不可设置为 0。|
|mixedVideoLayout|number|false|视频合流布局：<br>- `0`：悬浮布局。第一个加入频道的用户在屏幕上会显示为大视窗，铺满整个画布，其他用户的视频画面会显示为小视窗，从下到上水平排列，最多 4 行，每行 4 个画面，最多支持共 17 个画面。<br>- `1`：自适应布局。根据用户的数量自动调整每个画面的大小，每个用户的画面大小一致，最多支持 17 个画面。<br>- `2`：垂直布局。指定 `maxResolutionUid` 在屏幕左侧显示大视窗画面，其他用户的小视窗画面在右侧垂直排列，最多两列，一列 8 个画面，最多支持共 17 个画面。<br>- `3`：自定义布局。由你在 `layoutConfig` 字段中自定义合流布局。|
|backgroundColor|string|false|视频画布的背景颜色。支持 RGB 颜色表，字符串格式为 # 号和 6 个十六进制数。默认值 `"#000000"`，代表黑色。|
|backgroundImage|string|false|视频画布的背景图的 URL。背景图的显示模式为裁剪模式。<br><p>裁剪模式：优先保证画面被填满。背景图尺寸等比缩放，直至整个画面被背景图填满。如果背景图长宽与显示窗口不同，则背景图会按照画面设置的比例进行周边裁剪后填满画面。</p>|
|defaultUserBackgroundImage|string|false|默认的用户画面背景图的 URL。<br><p>配置该字段后，当任一⽤户停止发送视频流超过 3.5 秒，画⾯将切换为该背景图；如果针对某 UID 单独设置了背景图，则该设置会被覆盖。</p>|
|layoutConfig|array[object]|false|[layoutConfig](#schemalayoutconfig)|
|backgroundConfig|array[object]|false|[backgroundConfig](#schemabackgroundconfig)|

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

|Name|Type|Required|Description|
|---|---|---|---|
|resourceId|string|false|云端录制使用的 Resource ID。|
|sid|string|false|录制 ID。|
|serverResponse|object|false|[serverResponse](#schemaserverresponse)|
|cname|string|false|录制的频道名。|
|uid|string|false|字符串内容为云端录制服务在 RTC 频道内使用的 UID，用于标识频道内的录制服务。|

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

#### 情况一

**页面录制**模式下会返回的字段。

|Name|Type|Required|Description|
|---|---|---|---|
|status|number|false|当前云服务的状态：<br>- `0`：没有开始云服务。<br>- `1`：云服务初始化完成。<br>- `2`：云服务组件开始启动。<br>- `3`：云服务部分组件启动完成。<br>- `4`：云服务所有组件启动完成。<br>- `5`：云服务正在进行中。<br>- `6`：云服务收到停止请求。<br>- `7`：云服务所有组件均停止。<br>- `8`：云服务已退出。<br>- `20`：云服务异常退出。|
|array[object]|false|extensionServiceState|[extensionServiceState](#schemaextensionservicestate)|

#### 情况二

**单流录制**模式下且开启**视频截图**时会返回的字段。

|Name|Type|Required|Description|
|---|---|---|---|
|status|number|false|当前云服务的状态：<br>- `0`：没有开始云服务。<br>- `1`：云服务初始化完成。<br>- `2`：云服务组件开始启动。<br>- `3`：云服务部分组件启动完成。<br>- `4`：云服务所有组件启动完成。<br>- `5`：云服务正在进行中。<br>- `6`：云服务收到停止请求。<br>- `7`：云服务所有组件均停止。<br>- `8`：云服务已退出。<br>- `20`：云服务异常退出。|
|sliceStartTime|number|false|录制开始的时间，Unix 时间戳，单位为毫秒。|

#### 情况三

除单流视频截图和页面录制场景外的其他场景下会返回的字段。

|Name|Type|Required|Description|
|---|---|---|---|
|status|number|false|当前云服务的状态：<br>- `0`：没有开始云服务。<br>- `1`：云服务初始化完成。<br>- `2`：云服务组件开始启动。<br>- `3`：云服务部分组件启动完成。<br>- `4`：云服务所有组件启动完成。<br>- `5`：云服务正在进行中。<br>- `6`：云服务收到停止请求。<br>- `7`：云服务所有组件均停止。<br>- `8`：云服务已退出。<br>- `20`：云服务异常退出。|
|fileListMode|string|false|`fileList` 字段的数据格式：<br>- `"string"`：`fileList` 为 String 类型。合流录制模式下，如果 `avFileType` 设置为 `["hls"]`，`fileListMode` 为 `"string"`。<br>- `"json"`：`fileList` 为 JSON Array 类型。单流或合流录制模式下 `avFileType` 设置为 `["hls","mp4"]` 时，`fileListMode` 为 `"json"`。|
|fileList|[fileList-string](#schemafilelist-string) 或 [fileList-json](#schemafilelist-json)|false|[fileList-string](#schemafilelist-string) 或 [fileList-json](#schemafilelist-json)|
|sliceStartTime|number|false|录制开始的时间，Unix 时间戳，单位为毫秒。|

## fileList-string
<a id="schemafilelist-string"></a>

|Type|Required|Description|
|---|---|---|
|string|false|录制产生的 M3U8 文件的文件名。|


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

|Name|Type|Required|Description|
|---|---|---|---|
|payload|object|false|[payload](#payload)|
|serviceName|string|false|扩展服务的名称：<br>- `web_recorder_service`：代表扩展服务为**页面录制**。<br>- `rtmp_publish_service`：代表扩展服务为**转推页面录制到 CDN**。|

## payload

### Properties

#### 情况一

页面录制时会返回如下字段。

|Name|Type|Required|Description|
|---|---|---|---|
|fileList|array[object]|false|见下所述。|
|» filename|string|false|录制产生的 M3U8 文件和 MP4 文件的文件名。|
|» sliceStartTime|number|false|该文件的录制开始时间，Unix 时间戳，单位为毫秒。|
|onhold|boolean|false|页面录制是否处于暂停状态：<br>- `true`：处于暂停状态。<br>- `false`：处于运行状态。|
|state|string|false|将订阅内容上传至扩展服务的状态：<br>- `"init"`：服务正在初始化。<br>- `"inProgress"`：服务启动完成，正在进行中。<br>- `"exit"`：服务退出。|

#### 情况二

转推页面录制到 CDN 时会返回如下字段。

|Name|Type|Required|Description|
|---|---|---|---|
|outputs|array[object]|false|见下所述。|
|» rtmpUrl|string|false|CDN 推流地址。|
|» status|string|false|页面录制当前的推流状态：<br>- `"connecting"`：正在连接 CDN 服务器。<br>- `"publishing"`：正在推流。<br>- `"onhold"`：设置是否暂停推流。<br>- `"disconnected"`：连接 CDN 服务器失败，声网建议你更换 CDN 推流地址。|
|state|string|false|将订阅内容上传至扩展服务的状态：<br>- `"init"`：服务正在初始化。<br>- `"inProgress"`：服务启动完成，正在进行中。<br>- `"exit"`：服务退出。|


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
array[object] 类型。

### Properties

|Name|Type|Required|Description|
|---|---|---|---|
|fileName|string|false|录制产生的 M3U8 文件和 MP4 文件的文件名。|
|trackType|string|false|录制文件的类型。<br>- `"audio"`：纯音频文件。<br>- `"video"`：纯视频文件。<br>- `"audio_and_video"`：音视频文件。|
|uid|string|false|用户 UID，表示录制的是哪个用户的音频流或视频流。合流录制模式下，`uid` 为 `"0"`。|
|mixedAllUser|boolean|false|用户是否是分开录制的。<br>- `true`：所有用户合并在一个录制文件中。<br>- `false`：每个用户分开录制。|
|isPlayable|boolean|false|是否可以在线播放。<br>- `true`：可以在线播放。<br>- `false`：无法在线播放。|
|sliceStartTime|number|false|该文件的录制开始时间，Unix 时间戳，单位为毫秒。|

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

|Name|Type|Required|Description|
|---|---|---|---|
|cname|string|true|录制服务所在频道的名称。需要和你在 [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) 请求中输入的 `cname` 相同。|
|uid|string|true|字符串内容为录制服务在 RTC 频道内使用的 UID，用于标识该录制服务，需要和你在 [`acquire`](#opIdpost-v1-apps-appid-cloud_recording-acquire) 请求中输入的 `uid` 相同。|
|clientRequest|object|true|见下所述。|
|» async_stop|boolean|false|设置 `stop` 方法的响应机制：<br>- `true`：异步。调用 `stop` 后立即收到响应。<br>- `false`：同步。调用 `stop` 后，你需等待所有录制文件上传至第三方云存储方后会收到响应。声网预期上传时间不超过 20 秒，如果上传超时，你会收到错误码 `50`。|

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

|Name|Type|Required|Description|
|---|---|---|---|
|resourceId|string|false|云端录制使用的 Resource ID。|
|sid|string|false|录制 ID。标识一次录制周期。|
|serverResponse|object|false|[serverResponse](#schemaserverresponse-stop)|
|cname|string|false|录制的频道名。|
|uid|string|false|字符串内容为云端录制服务在 RTC 频道内使用的 UID，用于标识频道内的录制服务。|

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

#### 情况一

页面录制场景下会返回的字段。

|Name|Type|Required|Description|
|---|---|---|---|
|extensionServiceState|array[object]|false|见下所述。|
|» playload|object|false|[playload-stop](#playload-stop)|
|» serviceName|string|false|服务类型：<br>- `"upload_service"`：上传服务。<br>- `"web_recorder_service"`：页面录制服务。|

#### 情况二

单流视频截图场景下会返回的字段。

|Name|Type|Required|Description|
|---|---|---|---|
|uploadingStatus|string|false|当前录制上传的状态：<br>- `"uploaded"`：本次录制的文件已经全部上传至指定的第三方云存储。<br>- `"backuped"`：本次录制的文件已经全部上传完成，但是至少有一个 TS 文件上传到了声网备份云。声网服务器会自动将这部分文件继续上传至指定的第三方云存储。<br>- `"unknown"`：未知状态。|

#### 情况三

除单流视频截图和页面录制场景外的其他场景下会返回的字段。

|Name|Type|Required|Description|
|---|---|---|---|
|fileListMode|string|false|`fileList` 字段的数据格式：<br>- `"string"`：`fileList` 为 String 类型。合流录制模式下，如果 `avFileType` 设置为 `["hls"]`，`fileListMode` 为 `"string"`。<br>- `"json"`：`fileList` 为 JSON Array 类型。单流或合流录制模式下 `avFileType` 设置为 `["hls","mp4"]` 时，`fileListMode` 为 `"json"`。|
|fileList|[fileList-string](#schemafilelist-string) 或 [fileList-json](#schemafilelist-json)|false|[fileList-string](#schemafilelist-string) 或 [fileList-json](#schemafilelist-json)|
|uploadingStatus|string|false|当前录制上传的状态：<br>- `"uploaded"`：本次录制的文件已经全部上传至指定的第三方云存储。<br>- `"backuped"`：本次录制的文件已经全部上传完成，但是至少有一个 TS 文件上传到了声网备份云。声网服务器会自动将这部分文件继续上传至指定的第三方云存储。<br>- `"unknown"`：未知状态。|

## playload-stop

### Properties

#### 情况一

**页面录制**模式下，**上传服务**返回的字段。

|Name|Type|Required|Description|
|---|---|---|---|
|uploadingStatus|string|false|当前录制上传的状态：<br>- `"uploaded"`：本次录制的文件已经全部上传至指定的第三方云存储。<br>- `"backuped"`：本次录制的文件已经全部上传完成，但是至少有一个 TS 文件上传到了声网备份云。声网服务器会自动将这部分文件继续上传至指定的第三方云存储。<br>- `"unknown"`：未知状态。|

#### 情况二

**页面录制**模式下，**页面录制服务**返回的字段。

|Name|Type|Required|Description|
|---|---|---|---|
|fileList|array[object]|false|见下所述。|
|» filename|string|false|录制产生的 M3U8 文件和 MP4 文件的文件名。|
|» sliceStartTime|number|false|该文件的录制开始时间，Unix 时间戳，单位为毫秒。|
|onhold|boolean|false|页面录制是否处于暂停状态：<br>- `true`：处于暂停状态。<br>- `false`：处于运行状态。|
|state|string|false|将订阅内容上传至扩展服务的状态：<br>- `"init"`：服务正在初始化。<br>- `"inProgress"`：服务启动完成，正在进行中。<br>- `"exit"`：服务退出。|


