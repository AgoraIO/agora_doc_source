---
title: 阿里语音智能审核 RESTful API
platform: All Platforms
updatedAt: 2021-02-20 04:26:41
---
在使用阿里语音智能审核 RESTful API 之前，你必须首先[开通 Agora 云端录制服务](https://docs.agora.io/cn/cloud-recording/cloud_recording_rest?platform=All%20Platforms#开通云端录制服务)。

> 在使用阿里语音智能审核时，你需要为云端录制服务支付费用。如欲了解相关的计费标准，请咨询 [sales@agora.io](mailto:sales@agora.io) 或 400 6326626。

## 认证

阿里语音智能审核 RESTful API 仅支持 HTTPS 协议。发送请求时，你需要提供 `api_key:api_secret` 通过 Basic HTTP 认证并填入 HTTP 请求头部的 Authorization 字段：

- `api_key`: Customer ID （客户 ID）
- `api_secret`: Customer Certificate （客户证书）

你可以在控制台的 [RESTful API](https://console.agora.io/restful) 页面找到你的 Customer ID 和 Customer Certificate。具体生成 `Authorization` 字段的方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。

## 数据格式

所有的请求都发送给域名：`api.agora.io`。

- 请求：请求的格式详见下面各个 API 中的示例
- 响应：响应内容的格式为 JSON

> 所有的请求 URL 和请求包体内容都是区分大小写的。

## 调用步骤

一般进行审核的步骤如下：

1. 通过 [`acquire`](#acquire) 请求获取一个 resource ID 用于开启阿里语音智能审核。
2. 获取 resource ID 后在 5 分钟内调用 [`start`](#start) 开始审核。
3. 审核完成后调用 [`stop`](#stop) 停止审核。

在整个过程中可以通过 [`query`](#query) 请求查询审核的状态。 


## <a name="acquire"></a>获取审核资源的 API


在开始审核之前，你需要调用该方法获取一个 resource ID，用于开启阿里语音智能审核。

> 一个 resource ID 只能用于一次审核。

- 方法：POST
- 接入点：/v1/apps/\<appid\>/cloud_recording/acquire

> 请求数限制为每秒钟 10 次。

调用该方法成功后，你可以从 HTTP 响应包体中的 `resourceId` 字段得到一个 resource ID。这个 resource ID 的时效为 5 分钟，你需要在 5 分钟内用这个 resource ID 去调用[开始审核的 API](#start)。

### 参数

该 API 需要在 URL 中传入以下参数。

| 参数    | 类型   | 描述                                                         |
| :------ | :----- | :----------------------------------------------------------- |
| `appid` | String | 你的项目使用的 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id)。必须使用和待审核的频道相同的 App ID。 |

该 API 需要在请求包体中传入以下参数。

| 参数            | 类型   | 描述                                                         |
| :-------------- | :----- | :----------------------------------------------------------- |
| `cname`         | String | 待审核的频道名。                 |
| `uid`           | String | 字符串内容为阿里语音智能审核在频道内使用的用户 ID，32 位无符号整数，例如`"527841"`。需满足以下条件：<li>取值范围 1 到 (2<sup>32</sup>-1)，不可设置为 0。</li><li>不能与当前频道内的任何 UID 重复。</li><li>阿里语音智能审核不支持 String 用户名（User Account），请确保该字段引号内为整型 UID，且频道内所有用户均使用整型 UID。</li> |
| `clientRequest` | JSON   | 客户请求参数，包含 `resourceExpiredHour` 字段。`resourceExpiredHour` 为 Number 类型，单位为小时，用于设置阿里语音智能审核 RESTful API 的调用时效，从成功开启审核并获得 `sid` （审核 ID）后开始计算。超时后，你将无法调用 `query` 和 `stop` 方法。`resourceExpiredHour` 需大于等于 `1`， 且小于等于 `720`，默认值为 `72`。 |

### `acquire` 请求示例

- 请求 URL：

```
https://api.agora.io/v1/apps/<yourappid>/cloud_recording/acquire
```

- `Content-type` 为 `application/json;charset=utf-8`
- `Authorization` 为 Basic authorization，生成方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。
- 请求包体内容：

```json
{
  "cname": "httpClient463224",
  "uid": "527841",
  "clientRequest":{
    "resourceExpiredHour":  24
  }
}
```

### `acquire` 响应示例

```json
"Code": 200,
"Body":
{
 "resourceId": "JyvK8nXHuV1BE64GDkAaBGEscvtHW7v8BrQoRPCHxmeVxwY22-x-kv4GdPcjZeMzoCBUCOr9q-k6wBWMC7SaAkZ_4nO3JLqYwM1bL1n6wKnnD9EC9waxJboci9KUz2WZ4YJrmcJmA7xWkzs_L3AnNwdtcI1kr_u1cWFmi9BWAWAlNd7S7gfoGuH0tGi6CNaOomvr7-ILjPXdCYwgty1hwT6tbAuaW1eqR0kOYTO0Z1SobpBxu1czSFh1GbzGvTZG"
}
```

- `code`：Number 类型，[响应状态码](#response_status)。
- `resourceId`：String 类型，阿里语音智能审核的 resource ID，使用这个 resource ID 可以开始一段审核。这个 resource ID 的有效期为 5 分钟，超时需要重新请求。


## <a name="start"></a>开始审核的 API

获取 resource ID 后，调用该方法开始审核。

- 方法：POST
- 接入点：/v1/apps/\<appid\>/cloud_recording/resourceid/\<resourceid\>/mode/\<mode\>/start

> 请求数限制为每秒钟 10 次。

### 参数

该 API 需要在 URL 中传入以下参数。

| 参数         | 类型   | 描述                                                         |
| :----------- | :----- | :----------------------------------------------------------- |
| `appid`      | String | 你的项目使用的 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id)。必须使用和待审核的频道相同的 App ID。 |
| `resourceid` | String | 通过 [`acquire`](#acquire) 请求获取的 resource ID。          |
| `mode`       | String | 审核模式，目前只支持合流模式 (`mix`)。合流模式下，阿里语音智能审核会将频道内所有（或指定） UID 的音视频混合成一路流后进行审核。 |

该 API 需要在请求包体中传入以下参数。

| 参数            | 类型   | 描述                                                         |
| :-------------- | :----- | :----------------------------------------------------------- |
| `cname`         | String | 待审核的频道名。                                             |
| `uid`           | String | 字符串内容为阿里语音智能审核在频道内使用的用户 ID，需要和你在 [`acquire` ](#acquire)请求中输入的 `uid` 相同。 |
| `clientRequest` | JSON   | 特定的客户请求参数，对于该请求包含以下参数：<ul><li>`token`：（选填） String 类型，用于鉴权的[动态密钥](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-namekeya动态密钥)。如果待审核的频道使用了动态密钥，请务必在该参数中传入一个动态密钥，详见[校验用户权限](https://docs.agora.io/cn/cloud-recording/token?platform=All%20Platforms)。</li><li>[`recordingConfig`](#recordingConfig)：（选填）JSON 类型，订阅的详细设置。</li><li>[`extensionServiceConfig`](#extensionServiceConfig)：JSON 类型，[扩展服务](/cn/Voice/extension_marketplace_terms#扩展服务)的设置，包括阿里语音智能审核的设置。</li></ul> |

#### <a name="recordingConfig"></a>订阅设置

`recordingConfig` 是一个用于设置订阅选项的 JSON Object。阿里语音智能审核会对你设置的订阅内容进行审核。`recordingConfig` 包含以下字段：

- `streamTypes`：Number 类型，订阅的媒体流类型。当要审核的内容为音频时，即当[扩展服务设置](#extensionServiceConfig)中的 `streamTypes` 为 `0` 时，`streamTypes` 必须设为 `0`，即仅订阅音频。
  - `0`：仅订阅音频
  - `1`：仅订阅视频
  - `2`：（默认）订阅音频和视频
- `decryptionMode`：（选填）Number 类型，解密方案。如果频道设置了加密，该参数必须设置。解密方式必须与频道设置的加密方式一致。
  - `0`：无（默认）
  - `1`：设置 AES128XTS 解密方案
  - `2`：设置 AES128ECB 解密方案
  - `3`：设置 AES256XTS 解密方案
- `secret`：（选填）String 类型。启用解密模式后，设置的解密密码。
- `channelType`：（选填）Number 类型，频道模式。频道模式必须与 Agora Native/Web SDK 的设置一致，否则可能导致问题。
  - `0`：通信模式（默认）
  - `1`：直播模式

- `audioProfile`：（选填）设置订阅文件的音频采样率，码率，编码模式和声道数。
  - `0`：（默认）48 kHz 采样率，音乐编码，单声道，编码码率约 48 Kbps
  - `1`：48 kHz 采样率，音乐编码, 单声道，编码码率约 128 Kbps
  - `2`：48 kHz 采样率，音乐编码, 双声道，编码码率约 192 Kbps
  
- `maxIdleTime`：（选填）Number 类型，最长空闲频道时间。默认值为 30 秒，该值需大于等于 5，且小于等于 (2<sup>32</sup>-1)。如果频道内无用户的状态持续超过该时间，阿里语音智能审核会自动退出。如果频道内有用户，但用户没有发流，不算作无用户状态。

- `subscribeAudioUids`：（选填）JSONArray 类型，由 UID 组成的数组，如 `["123","456"]`。指定审核哪几个用户的音频。数组长度不得超过 32。

- `subscribeUidGroup`: （选填）Number 类型，预估的订阅人数峰值。举例来说，如果 `subscribeAudioUids` 为 `["100","101","102"]`，则订阅人数为 3 人。
  - `0`: 1 到 2 人
  - `1`: 3 到 7 人
  - `2`: 8 到 12 人
  - `3`: 13 到 17 人

#### <a name="extensionServiceConfig"></a>扩展服务设置

`extensionServiceConfig` 是一个用于设置扩展服务的 JSON Object。扩展服务是基于 Agora RTC SDK 的一系列应用服务，能够对 Agora RTC SDK 中产生的音视频流进行进一步处理，如审核音视频流中的内容。`extensionServiceConfig` 包含以下字段：

- `errorHandlePolicy`：（选填）String 类型。错误处理策略。目前仅可设置为 `"error_abort"`。
  - `"error_abort"`：（默认）当扩展服务发生错误后，订阅等其他服务均停止。
  - `"error_ignore"`：当扩展服务发生错误后，扩展服务停止，订阅等其他服务继续。
- `extensionServices`：JSONArray 类型，由每个扩展服务的设置组成的数组。一个扩展服务的设置包含以下字段：
  - `serviceName`：String 类型，扩展服务的名称。要使用阿里语音智能审核，你需要将其设置为 `"aliyun_voice_async_scan"`。
  - `streamTypes`：Number 类型，扩展服务处理的内容类型。目前仅可设置为 `0`, 即处理音频。
  - `errorHandlePolicy`：（选填）String 类型。错误处理策略。目前仅可设置为 `"error_abort"`。
    - `"error_abort"`：（默认）当该扩展服务发生错误后，其他扩展服务均停止。
    - `"error_ignore"`：当该扩展服务发生错误后，该扩展服务停止，其他扩展服务继续。
  - `serviceParam`：扩展服务的具体参数设置。当使用阿里语音智能审核时，你需要设置以下参数：
    - `callbackAddr`：String 类型，接收[审核结果](#回调通知)的 HTTP 服务器地址。
    - `apiData`：JSON 类型，向阿里语音智能审核传入的参数值。  
      - `callbackSeed`：String 类型，随机字符串，用于审核结果中的签名，详见[阿里云文档](https://help.aliyun.com/document_detail/89630.html?spm=a2c4g.11186623.6.683.22c1d8e9FXVQtI)中对 `seed` 参数的解释。
      - `bizType`：（选填）String 类型，业务场景。详见[阿里云文档](https://help.aliyun.com/document_detail/89630.html?spm=a2c4g.11186623.6.683.22c1d8e9FXVQtI)。
      - `accessKey`：String 类型，阿里云访问秘钥 AccessKey 中的 `AccessKeyId`。详见[阿里云文档](https://help.aliyun.com/document_detail/53045.html?spm=a2c4g.11186623.2.11.64675809IpL9n5#concept-53045-zh)。
      - `secretKey`：String 类型，阿里云访问秘钥 AccessKey 中的 `AccessKeySecret`。详见[阿里云文档](https://help.aliyun.com/document_detail/53045.html?spm=a2c4g.11186623.2.11.64675809IpL9n5#concept-53045-zh)。

### `start` 请求示例

- 请求 URL：

```
https://api.agora.io/v1/apps/<yourappid>/cloud_recording/resourceid/<resourceid>/mode/<mode>/start
```

- `Content-type` 为 `application/json;charset=utf-8`
- `Authorization` 为 Basic authorization，生成方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。
- 请求包体内容：

```json
{
  "uid": "527841",  
  "cname": "httpClient463224",
  "clientRequest": {
    "token": "<token if any>",
    "recordingConfig": {
      "streamTypes":0
    },
    "extensionServiceConfig": {
      "extensionServices": [{
        "serviceParam": {
          "apiData": {
            "secretKey": "xxxxxx",
            "callbackSeed": "xxxxxx",
            "accessKey": "xxxxxx"
          },
          "callbackAddr": "http://xxxxx"
        },
        "streamTypes": 0,
        "serviceName": "aliyun_voice_async_scan"
      }]
    }
  }
}
```
### `start` 响应示例

```json
"Code": 200,
"Body":
{
  "sid": "38f8e3cfdc474cd56fc1ceba380d7e1a", 
  "resourceId": "JyvK8nXHuV1BE64GDkAaBGEscvtHW7v8BrQoRPCHxmeVxwY22-x-kv4GdPcjZeMzoCBUCOr9q-k6wBWMC7SaAkZ_4nO3JLqYwM1bL1n6wKnnD9EC9waxJboci9KUz2WZ4YJrmcJmA7xWkzs_L3AnNwdtcI1kr_u1cWFmi9BWAWAlNd7S7gfoGuH0tGi6CNaOomvr7-ILjPXdCYwgty1hwT6tbAuaW1eqR0kOYTO0Z1SobpBxu1czSFh1GbzGvTZG"
}
```

- `code`：Number 类型，[响应状态码](#response_status)。
- `resourceId`：String 类型，阿里语音智能审核使用的 resource ID。
- `sid`：String 类型，审核 ID。成功开始阿里语音智能审核后，你会得到一个 sid （审核 ID)。该 ID 是一次审核的唯一标识。


## <a name="query"></a>查询审核状态的 API

开始审核后，你可以调用 `query` 查询审核状态。

<div class="note alert"><code>query</code> 请求仅在会话内有效。如果审核启动错误，或审核已结束，调用 <code>query</code> 将返回 404。建议你同时使用<a href="#ncs">消息通知服务</a>，以获得阿里语音智能审核所有的事件通知和具体信息。</div>

- 方法：GET
- 接入点：/v1/apps/\<appid\>/cloud_recording/resourceid/\<resourceid\>/sid/\<sid\>/mode/\<mode\>/query

> 请求数限制为每秒钟 10 次。

### 参数

该 API 需要在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                         |
| :--------- | :----- | :----------------------------------------------------------- |
| appid      | String | 你的项目使用的 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id)。必须使用和待审核的频道相同的 App ID。 |
| resourceid | String | 通过 [`acquire`](#acquire) 请求获取的 resource ID。          |
| sid        | String | 通过 [`start`](#start) 请求获取的审核 ID。                   |
| mode       | String |  审核模式，目前只支持合流模式（`mix`）。            |

### `query` 请求示例

- 请求 URL：

```json
https://api.agora.io/v1/apps/<yourappid>/cloud_recording/resourceid/<resourceid>/sid/<sid>/mode/<mode>/query
```

- `Content-type` 为 `application/json;charset=utf-8`
- `Authorization` 为 Basic authorization，生成方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。

### `query` 响应示例

```json
{
  "resourceId":"JyvK8nXHuV1BE64GDkAaBGEscvtHW7v8BrQoRPCHxmeVxwY22-x-kv4GdPcjZeMzoCBUCOr9q-k6wBWMC7SaAkZ_4nO3JLqYwM1bL1n6wKnnD9EC9waxJboci9KUz2WZ4YJrmcJmA7xWkzs_L3AnNwdtcI1kr_u1cWFmi9BWAWAlNd7S7gfoGuH0tGi6CNaOomvr7-ILjPXdCYwgty1hwT6tbAuaW1eqR0kOYTO0Z1SobpBxu1czSFh1GbzGvTZG",
  "sid":"38f8e3cfdc474cd56fc1ceba380d7e1a",
  "serverResponse":{
    "subServiceStatus": {
      "recording_Service": "serviceInProgress",
      "mediaDistributeService": "serviceInProgress"
    },
    "extensionServiceState": [{
      "serviceName": "aliyun_voice_async_scan",
      "streamState":[{
        "status": "inProgress",
        "streamType": "audio",
        "uid": "0"
      }]
    }] 
  }       
}
```

- `code`：Number 类型，[响应状态码](#response_status)。
- `resourceId`：String 类型，阿里语音智能审核的 resource ID。
- `sid`：String 类型，通过 [`start`](#start) 请求获取的审核 ID。
- `serverResponse`：JSON 类型，服务器返回的具体信息。
  - `subServiceStatus`：JSON 类型，子模块的服务状态。
    - `recordingService`：String 类型，订阅模块的状态，具体取值详见[服务状态](#status)。
    - `mediaDistributeService`：String 类型，[媒体分发模块](/extension_marketplace_terms#媒体分发模块)的状态，具体取值详见[服务状态](#status)。该模块用于管理扩展服务。
- `extensionServiceState`：JSONArray 类型，由各个扩展服务的当前状态组成的数组。
  - `serviceName`：String 类型，扩展服务的名称。`"aliyun_voice_async_scan"` 表示当前使用的扩展服务为阿里语音智能审核。
  - `streamState`：JSONArray 类型，该扩展服务的状态。当选择阿里语音智能审核时，返回以下参数：
    - `uid`：Number 类型，用户 UID，表示审核的是哪个用户的媒体流。`0` 表示合流模式。
    - `streamType`：String 类型，审核的内容类型。`"audio"` 指纯音频。
    - `status`：审核的状态。
      - `"inProgress"`：审核正在进行中。
      - `"failed"`：审核发生错误。

 

## <a name="stop"></a>停止审核的 API

审核完成后，调用该方法离开频道，停止审核。审核停止后如需再次审核，必须再调用 [`acquire`](#acquire) 方法请求一个新的 resource ID。

- 方法：POST
- 接入点：/v1/apps/\<appid\>/cloud_recording/resourceid/\<resourceid\>/sid/\<sid\>/mode/\<mode\>/stop

> - 请求数限制为每秒钟 10 次。
> - 当频道空闲（无用户）超过预设时间（默认为 30 秒） 后，阿里语音智能审核也会自动退出频道停止审核。

### 参数

该 API 需要在 URL 中传入以下参数。

| 参数         | 类型   | 描述                                                         |
| :----------- | :----- | :----------------------------------------------------------- |
| `appid`      | String | 你的项目使用的 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id)。必须使用和待审核的频道相同的 App ID。 |
| `resourceid` | String | 通过 [`acquire`](#acquire) 请求获取的 resource ID。          |
| `sid`        | String | 通过 [`start`](#start) 请求获取的审核 ID。                   |
| `mode`       | String |  审核模式，目前只支持合流模式（`mix`）。                 |

该 API 需要在请求包体中传入以下参数。

| 参数            | 类型   | 描述                                                         |
| :-------------- | :----- | :----------------------------------------------------------- |
| `cname`         | String | 待审核的频道名。                                             |
| `uid`           | String | 字符串内容为阿里语音智能审核在频道内使用的用户 ID，需要和你在 [`acquire` ](#acquire)请求中输入的 `uid` 相同。 |
| `clientRequest` | JSON   | 特定的客户请求参数，对于该方法无需填入任何内容，为一个空的 JSON。 |

### `stop` 请求示例

- 请求 URL：

```
https://api.agora.io/v1/apps/<yourappid>/cloud_recording/resourceid/<resourceid>/sid/<sid>/mode/<mode>/stop

```

- `Content-type` 为 `application/json;charset=utf-8`
- `Authorization` 为 Basic authorization，生成方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。
- 请求包体内容：

```json
{
    "cname": "httpClient463224",
    "uid": "527841",  
    "clientRequest":{
   }
}

```

### `stop` 响应示例

```json
"Code": 200,
"Body":
{
  "sid": "38f8e3cfdc474cd56fc1ceba380d7e1a", 
  "resourceId": "JyvK8nXHuV1BE64GDkAaBGEscvtHW7v8BrQoRPCHxmeVxwY22-x-kv4GdPcjZeMzoCBUCOr9q-k6wBWMC7SaAkZ_4nO3JLqYwM1bL1n6wKnnD9EC9waxJboci9KUz2WZ4YJrmcJmA7xWkzs_L3AnNwdtcI1kr_u1cWFmi9BWAWAlNd7S7gfoGuH0tGi6CNaOomvr7-ILjPXdCYwgty1hwT6tbAuaW1eqR0kOYTO0Z1SobpBxu1czSFh1GbzGvTZG"
}
```

- `code`：Number 类型，[响应状态码](#response_status)。
- `resourceId`：String 类型，阿里语音智能审核使用的 resource ID。
- `sid`：String 类型，审核 ID。成功开始阿里语音智能审核后，你会得到一个 sid （审核 ID)。该 ID 是一次审核的唯一标识。

## <a name="回调通知"></a>回调通知

阿里语音智能审核的回调通知分为两类。

### 审核结果的回调

审核结果的回调，直接通知到你在 `extensionServiceConfig` 中的 `callbackAddr` 设置的地址。详见[阿里云文档](https://help.aliyun.com/document_detail/89630.html?spm=a2c4g.11186623.6.683.22c1d8e9FXVQtI#section-h1v-34k-z2b) `data` 字段的说明。其中，`dataId` 字段包含以下参数：

- `channel`：String 类型，此次审核的频道名。
- `uid`：String 类型，字符串内容为阿里语音智能审核在频道内使用的用户 ID，和你在 [`acquire` ](#acquire)请求中输入的 `uid` 相同。
- `streamType`：String 类型，阿里语音智能审核所审核的内容类型。`"audio"` 表示纯音频。

### <a name="ncs"></a>事件通知

云端录制及扩展服务的事件通知，需要联系 [sales@agora.io](mailto:sales@agora.io) 开通消息通知服务。

你可以参考[消息通知服务](https://docs-preview.agoralab.co/cn/Agora%20Platform/ncs)了解如何开通消息通知服务以及消息通知回调的数据格式。配置信息中，你需要设置业务 ID 为  `3`，即 Cloud Recording and Extension Service （云端录制及扩展服务），并选择相应的事件。建议你选择 `0` （云端录制服务）、`1` （录制服务）、`4` （扩展服务）。

你可以参考[云端录制 RESTful API 回调服务](/cn/cloud-recording/cloud_recording_callback_rest?platform=All%20Platforms&versionId=a534c620-4662-11ea-8218-196676895c48)了解回调请求中各字段的含义以及云端录制的相关回调。扩展服务的相关回调如下：

#### 201 extension_service_error
  
`eventType` 为 201 表示扩展服务发生错误， `details` 中包含以下字段：
  
- `msgName`：String 类型，消息名称，即 `extension_service_error`。
- `serviceName`：String 类型，扩展服务的名称。
- `streamType`：String 类型，扩展服务处理的内容类型。`"audio"` 指纯音频。
- `streamUid`：Number 类型，用户 UID，表示扩展服务处理的是哪个用户的媒体流。`0` 表示合流。
- `errorCode`：错误码，详见[扩展服务错误码](#vendor_error)。 
  
#### 202 extension_service_start
 
`eventType` 为 202 表示扩展服务开始拉流， `details` 中包含以下字段：
  
- `msgName`：String 类型，消息名称，即 `extension_service_start`。
- `serviceName`：String 类型，扩展服务的名称。
- `streamType`：String 类型，扩展服务处理的内容类型。`"audio"` 指纯音频。
- `streamUid`：Number 类型，用户 UID，表示扩展服务处理的是哪个用户的媒体流。`0` 表示合流。
  
#### 203 extension_service_stop
  
`eventType` 为 203 表示扩展服务停止拉流， `details` 中包含以下字段：
  
- `msgName`：String 类型，消息名称，即 `extension_service_stop`。
- `serviceName`：String 类型，扩展服务的名称。
- `streamType`：String 类型，扩展服务处理的内容类型。`"audio"` 指纯音频。
- `streamUid`：Number 类型，用户 UID，表示扩展服务处理的是哪个用户的媒体流。`0` 表示合流。


## <a name="status"></a>服务状态

| 状态                      | 描述                                                         |
| :------------------------ | :----------------------------------------------------------- |
| "serviceIdle"             | 服务未使用。                                                 |
| "serviceStarted"          | 服务已开始。                                                 |
| "serviceReady"            | 服务已就绪。                                                 |
| "serviceInProgress"       | 服务在进行中。                                               |
| "serviceCompleted"        | 审核内容已全部上传至阿里语音智能审核。                       |
| "servicePartialCompleted" | 审核内容部分上传至阿里语音智能审核。                         |
| "serviceValidationFailed" | 阿里语音智能审核验证失败。例如 `extensionServiceConfig` 中 `apiData` 填写错误。 |
| "serviceAbnormal"         | 服务状态异常。                                               |

##  <a name="response_status"></a>响应状态码

| 状态码 | 描述                                                         |
| :----- | :----------------------------------------------------------- |
| 200    | 请求成功。                                                   |
| 201    | 成功请求并创建了新的资源。                                   |
| 206    | 整个审核过程中没有用户发流。 |
| 400    | 请求的语法错误（如参数错误），服务器无法理解。               |
| 401    | 未经授权的（App ID/Customer Certificate 匹配错误）。          |
| 404    | 服务器无法根据请求找到资源（网页）。                         |
| 500    | 服务器内部错误，无法完成请求。                               |
| 504    | 服务器内部错误。充当网关或代理的服务器未从远端服务器获取请求。 |

## <a name="vendor_error"></a>扩展服务错误码

| 错误码 | 描述                     |
| :----- | :----------------------- |
| 1      | 请求扩展服务拉流失败     |
| 2      | 查询扩展服务拉流状态失败 |
| 3      | 扩展服务拉流发生错误     |
| 4      | 请求扩展服务停止拉流失败 |
| 5      | 扩展服务发生错误         |

## 常见错误

下面仅列出使用阿里语音智能审核 RESTful API 过程中常见的错误码或错误信息，如果遇到其他错误，请联系 Agora 技术支持。

- `2`：参数不合法，请确保参数类型正确、大小写正确、必填的参数均已填写。
- `7`：审核已经在进行中 ，请勿用同一个 resource ID 重复 `start` 请求。
- `8`：HTTP 请求头部字段错误，有以下几种情况：
  - `Content-type` 错误，请确保 `Content-type` 为 `application/json;charset=utf-8`。
  - 请求 URL 中缺少 `cloud_recording` 字段。
  - 使用了错误的 HTTP 方法。
- `53`：审核已经在进行中。当采用相同参数再次调用 [`acquire`](#acquire) 获得新的 resource ID，并用于 [`start`](#start) 请求时，会发生该错误。如需发起多路审核，需要在 `acquire` 方法中填入不同的 UID。
- `432`：请求参数错误。请求参数不合法。
- `433`：resource ID 过期。获得 resource ID 后必须在 5 分钟内开始审核。请重新调用 [`acquire`](#acquire) 获取新的 resource ID。
- `435`：频道内没有用户加入，无审核对象。
- `501`：审核正在退出。该错误可能在调用了 [`stop`](#stop) 方法后再调用 [`query`](#query) 时发生。
- `1001`：resource ID 解密失败。请重新调用 [`acquire`](#acquire) 获取新的 resource ID。
- `1003`：App ID 或者审核 ID（sid）与 resource ID 不匹配。请确保在一个审核周期内 resource ID、App ID 和审核 ID 一一对应。
- `1013`：频道名不合法。频道名必须为长度在 64 字节以内的字符串。以下为支持的字符集范围（共 89 个字符）：
  - 26 个小写英文字母 a-z
  - 26 个大写英文字母 A-Z
  - 10 个数字 0-9
  - 空格
  - "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","
- `"invalid appid"`：无效的 App ID。请确保 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id) 填写正确。如果检查了 App ID 没有问题仍遇到此错误，请联系 Agora 技术支持。


