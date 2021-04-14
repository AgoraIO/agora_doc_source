---
title: 云端录制 RESTful API
platform: All Platforms
updatedAt: 2021-04-01 04:22:05
---
Agora 云端录制服务提供 RESTful API，可以让你直接通过网络请求开启和控制云录制，在自己的网页或应用中灵活使用。

通过 RESTful API，你可以发送网络请求控制云端录制：

- 开始/结束云端录制
- 查询当前的录制状态

## 认证

云端录制 RESTful API 仅支持 HTTPS 协议。发送请求时，你需要提供 `api_key:api_secret` 通过 Basic HTTP 认证：

- `api_key`: Customer ID
- `api_secret`: Customer Certificate

你可以在 Dashboard 的 [RESTful API](https://dashboard.agora.io/restful) 页面找到你的 Customer ID 和 Customer Certificate。

## 数据格式

所有的请求都发送给域名：<!!!待定>。

- 请求：请求的格式详见下文的具体 API 示例
- 响应：响应内容的格式为 JSON

## <a name="acquire"></a>获取云端录制资源的 API

在开始云端录制之前，你需要调用该方法获取一个 resource ID。

>  一个 resource ID 只能用于一次云端录制服务。

- 方法：POST
- 接入点：/v1/apps/\<appid\>/cloud_recording/acquire

> 请求数限制为每秒钟 3 次。<!!!待定>

调用该方法成功后，你可以从 HTTP 响应主体中的 `resourceId` 字段得到一个 resource ID。这个 resource ID 的时效为 5 分钟，你需要在 5 分钟内用这个 resource ID 去调用[开始云端录制的 API](#start)。

### 参数

该 API 需要在 URL 中传入以下参数。

| 参数    | 类型   | 描述                                                         |
| :------ | :----- | :----------------------------------------------------------- |
| `appid` | String | 你的项目使用的 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id)。必须使用和待录制的频道相同的 App ID。 |

该 API 需要在请求主体中传入以下参数。

| 参数            | 类型   | 描述                                                         |
| :-------------- | :----- | :----------------------------------------------------------- |
| `cname`         | String | 待录制的频道名。                                             |
| `uid`           | String | 云端录制使用的用户 ID，32 位无符号整数，取值范围 1 到 (2<sup>32</sup>-1)，需保证唯一性。 |
| `requestId`     | Number | 该请求的唯一 ID，32 位无符号整数，取值范围 1 到 (2<sup>32</sup>-1)，需保证唯一性。 |
| `clientRequest` | JSON   | 特定的客户请求参数，对于该方法无需填入任何内容，为一个空的 JSON。 |

### HTTP 请求示例

```http
POST /v1/apps/<appid>/cloud_recording/acquire
Host: <!!!待定>
Content-type: application/json;charset=utf-8
Authorization: Basic ZGJhZDMyNmFkMzQ0NDk2NGEzYzAwNjZiZmYwNTZmNjo2ZjIyMmZhMTkzNWE0MWQzYTczNzg2ODdiMmNiYjRh <!!!待定>
Body:
{
    "cname":"<cname>",
    "uid":"<uid>",
    "requestId":<requestId>,
    "clientRequest":{
    }
}
```

### 响应示例

```http
{
"Code": 200,
"Body":
{
 "resourceId":"<resourceId>"
}
}
```

- `code`: Number 类型，[响应状态码](#status)。
- `resourceId`: String 类型，云端录制资源 resource ID，使用这个 resource ID 可以开始一段云端录制。这个 resource ID 的有效期为 5 分钟，超时需要重新请求。

## <a name="start"></a>开始云端录制的 API

获取 resource ID 后，调用该方法开始云端录制。

- 方法：POST
- 接入点：/v1/apps/\<appid\>/cloud_recording/resourceid/\<resourceid\>/mode/\<mode\>/start

> 请求数限制为每秒钟 3 次。<!!!待定>

### 参数

该 API 需要在 URL 中传入以下参数。

| 参数         | 类型   | 描述                                                         |
| :----------- | :----- | :----------------------------------------------------------- |
| `appid`      | String | 你的项目使用的 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id)。必须使用和待录制的频道相同的 App ID。 |
| `resourceid` | String | 通过 `acquire` 请求获取的 resource ID。                      |
| `mode`       | String | 录制模式，目前只支持合流模式 `"mix"`。                       |

该 API 需要在请求主体中传入以下参数。

| 参数            | 类型   | 描述                                                         |
| :-------------- | :----- | :----------------------------------------------------------- |
| `cname`         | String | 待录制的频道名。                                             |
| `uid`           | String | 云端录制使用的用户 ID，32 位无符号整数，取值范围 1 到 (2<sup>32</sup>-1)，需保证唯一性。 |
| `clientRequest` | JSON   | 特定的客户请求参数，对于该请求请参考下面的列表设置。         |

`clientRequest` 中需要填写的内容如下：

- `recordingConfig`：JSON 类型，录制的详细设置。
  - `streamTypes`：（选填）Number 类型，录制的媒体流类型
    - 0：仅录制音频
    - 1：仅录制视频
    - 2：（默认）录制音频和视频
  - `decryptionMode`：（选填）Number 类型，解密方案。如果频道设置了加密，该参数必须设置。解密方式必须与频道设置的加密方式一致。
    - 0：无（默认）
    - 1：设置 AES128XTS 解密方案
    - 2：设置 AES128ECB 解密方案
    - 3：设置 AES256XTS 解密方案
  - `secret`：（选填）String 类型。启用解密模式后，设置的解密密码。
  - `channelType`：（选填）Number 类型，频道模式。频道模式必须与 Agora Native/Web SDK 的设置一致，否则可能导致问题。
  - `audioProfile`：（选填）设置录制文件的音频采样率，码率，编码模式和声道数。
    - 0：（默认）48 KHz 采样率，音乐编码，单声道，编码码率约 48 Kbps
    - 1：48 KHz 采样率，音乐编码, 单声道，编码码率约 128 Kbps
    - 2：48 KHz 采样率，音乐编码, 双声道，编码码率约 192 Kbps
  - `videoStreamType`：（选填）Number 类型，设置录制的视频流类型。如果频道中有用户开启了双流模式，你可以选择录制视频大流或者小流。
    - 0：视频大流（默认），即高分辨率高码率的视频流
    - 1：视频小流，即低分辨率低码率的视频流
  - `maxIdleTime`：（选填）Number 类型，最长空闲频道时间，单位为秒，默认值为 30 秒。如果频道内无用户的状态持续超过该时间，云端录制会自动离开频道结束录制。若设置为 0，则使用默认值。
  - `transcodingConfig`： JSON 类型，视频转码的详细设置。
    - `width`：Number 类型，录制视频的宽度，单位为像素，默认值 360。支持的最大分辨率为 1080p，超过该分辨率会报错。
    - `height`：Number 类型，录制视频的高度，单位为像素，默认值 640。支持的最大分辨率为 1080p，超过该分辨率会报错。
    - `fps`：Number 类型，录制视频的帧率，单位 fps，默认值 15。
    - `bitrate`：Number 类型，录制视频的码率，单位 Kbps，默认值 500。
    - `maxResolutionUid`：（选填）String 类型，如果视频合流布局设为垂直布局，用该参数指定显示大视窗画面的用户 ID。
    - `mixedVideoLayout`：（选填）Number 类型，视频合流布局，详见[设置合流布局](/cn/cloud-recording/cloud_layout_guide?platform=Linux)。
      - 0：（默认）悬浮布局。第一个加入频道的用户在屏幕上会显示为大视窗，铺满整个画布，其他用户的视频画面会显示为小视窗，从下到上水平排列，最多 4 行，每行 4 个画面，最多支持共 17 个录制画面。
      - 1：自适应布局。根据用户的数量自动调整每个画面的大小，每个用户的画面大小一致，最多支持 17 个录制画面。
    - 2：垂直布局。指定一个用户在屏幕左侧显示大视窗画面，其他用户的小视窗画面在右侧垂直排列，最多两列，一列 8 个画面，最多支持共 17 个录制画面。
  
- `storageConfig`：JSON 类型，第三方云存储的详细设置。
  - `vendor`：Number 类型，第三方云存储供应商。    
    - 0：七牛云
    - 1：Amazon S3
  - 2：阿里云
  - `region`：Number 类型，第三方云存储指定的地区信息。
    当 `vendor` = 0，即第三方云存储为七牛云时：  
    - 0：Huadong 
    - 1：Huabei 
    - 2：Huanan 
    - 3：Beimei  

    当 `vendor` = 1，即第三方云存储为 Amazon S3 时：
    - 0：US_EAST_1 
    - 1：US_EAST_2 
    - 2：US_WEST_1 
    - 3：US_WEST_2 
    - 4：EU_WEST_1 
    - 5：EU_WEST_2 
    - 6：EU_WEST_3 
    - 7：EU_CENTRAL_1 
    - 8：AP_SOUTHEAST_1 
    - 9：AP_SOUTHEAST_2 
    - 10：AP_NORTHEAST_1 
    - 11：AP_NORTHEAST_2 
    - 12：SA_EAST_1 
    - 13：CA_CENTRAL_1 
    - 14：AP_SOUTH_1 
    - 15：CN_NORTH_1 
    - 16：CN_NORTHWEST_1 
    - 17：US_GOV_WEST_1 

    当 `vendor` = 2，即第三方云存储为阿里云时： 
    - 0：CN_Hangzhou 
    - 1：CN_Shanghai 
    - 2：CN_Qingdao 
    - 3：CN_Beijin 
    - 4：CN_Zhangjiakou 
    - 5：CN_Huhehaote 
    - 6：CN_Shenzhen 
    - 7：CN_Hongkong 
    - 8：US_West_1 
    - 9：US_East_1 
    - 10：AP_Southeast_1 
    - 11：AP_Southeast_2 
    - 12：AP_Southeast_3 
    - 13：AP_Southeast_5 
    - 14：AP_Northeast_1 
    - 15：AP_South_1 
    - 16：EU_Central_1 
    - 17：EU_West_1 
    - 18：EU_East_1
  
  - `bucket`：String 类型，第三方云存储的 bucket。
  - `access_key`：String 类型，第三方云存储的 access key。
  - `secret_key`：String 类型，第三方云存储的 secret key。

### HTTP 请求示例

```http
POST /v1/apps/<appid>/cloud_recording/resourceid/<resourceid>/mode/<mode>/start
Host: <!!!待定>
Content-type: application/json;charset=utf-8
Authorization: Basic ZGJhZDMyNmFkMzQ0NDk2NGEzYzAwNjZiZmYwNTZmNjo2ZjIyMmZhMTkzNWE0MWQzYTczNzg2ODdiMmNiYjRh <!!!待定>
Body:
{
    "cname":"<cname>",
    "uid":"<uid>",
    "clientRequest":{
        "recordingConfig": {
            "streamTypes":<streamTypes>,
            "decryptionMode":<decryptionMode>,
            "secret":<secret>,
            "channelType":<channelType>,
            "audioProfile":<audioProfile>,
            "videoStreamType":<videoStreamType>,
            "maxIdleTime":<maxIdleTime>,
            "transcodingConfig": {
                "width": <width>, 
                "fps": <fps>, 
                "height": <height>, 
                "bitrate": <bitrate>,
                "mixedVideoLayout":<mixedVideoLayout>,
                "maxResolutionUid": "<maxResolutionUid>"
            }
        }, 
        "storageConfig": {
            "bucket":"<bucket>", 
            "region":<region>, 
            "accessKey":"<accessKey>", 
            "secretKey":"<secretKey>", 
            "vendor":<vendor>
        }
    }
}
```

### 响应示例

```http
{
"Code": 200,
"Body":
{
  "resourceId":"<resourceId>",
  "sid":"<sid>"
}
}
```

- `code`: Number 类型，[响应状态码](#status)。
- `resourceId`: String 类型，云端录制使用的 resource ID。
- `sid`: String 类型，录制 ID。成功开始云端录制后，你会得到一个 sid （录制 ID)。该 ID 是一次录制周期的唯一标识。

## 查询云录制状态的 API

- 方法：GET
- 接入点：/v1/apps/\<appid\>/cloud_recording/resourceid/\<resourceid\>/sid/\<sid\>/mode/\<mode\>/query

> 请求数限制为每秒钟 1 次，每天 1000 次。<!!!待定>

### 参数

该 API 需要在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                         |
| :--------- | :----- | :----------------------------------------------------------- |
| appid      | String | 你的项目使用的 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id)。必须使用和待录制的频道相同的 App ID。 |
| resourceid | String | 通过 `acquire` 请求获取的 resource ID。                      |
| sid        | String | 通过 `start` 请求获取的录制 ID。                             |
| mode       | String | 录制模式，目前只支持合流模式 `"mix"`。                       |

### HTTP 请求示例

```http
GET /v1/apps/<appid>/cloud_recording/resourceid/<resourceid>/sid/<sid>/mode/<mode>/query
Host: <!!!待定>
Content-type: application/json;charset=utf-8
Authorization: Basic ZGJhZDMyNmFkMzQ0NDk2NGEzYzAwNjZiZmYwNTZmNjo2ZjIyMmZhMTkzNWE0MWQzYTczNzg2ODdiMmNiYjRh <!!!待定>
```

### 响应示例

```http
{
"Code": 200,
"Body":
{
  "resourceId":"<resourceId>",
  "sid":"<sid>",
  "requestId":"<requestId>",
  "serverResponse":{
    "fileList": "<fileList>",
    "status": "<status>"
    }    
}
}
```

- `code`：Number 类型，[响应状态码](#status)。
- `resourceId`: String 类型，云端录制使用的 resource ID。
- `sid`: String 类型，录制 ID。成功开始云端录制后，你会得到一个 sid （录制 ID)。该 ID 是一次录制周期的唯一标识。
- `requestId`：String 类型，该请求的唯一 ID。
- `serverResponse`：JSON 类型，录制的具体信息。
  - `fileList`：String 类型，录制生成的文件索引。每次录制均会生成一个 M3U8 文件，用于索引该次录制所有的 TS 文件。你可以通过 M3U8 文件播放和管理录制文件。
  - `status`：Number 类型，当前录制的状态。
    - 0：没有开始云端录制。
    - 1：云端录制初始化完成。
    - 2：云录制开始启动。
    - 3：云录制上传任务启动。
    - 4：云录制启动完成。
    - 5：成功上传第一个文件。
    - 6：云录制已经停止录制。
    - 7：云录制服务全部停止。
    - 8：云录制准备退出。
    - 20：云录制异常退出。

## 停止云端录制的 API

- 方法：POST
- 接入点：/v1/apps/\<appid\>/cloud_recording/resourceid/\<resourceid\>/sid/\<sid\>/mode/\<mode\>/stop

> 请求数限制为每秒钟 1 次，每天 1000 次。<!!!待定>

### 参数

该 API 需要在 URL 中传入以下参数。

| 参数         | 类型   | 描述                                                         |
| :----------- | :----- | :----------------------------------------------------------- |
| `appid`      | String | 你的项目使用的 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id)。必须使用和待录制的频道相同的 App ID。 |
| `resourceid` | String | 通过 `acquire` 请求获取的 resource ID。                      |
| `sid`        | String | 通过 `start` 请求获取的录制 ID。                             |
| `mode`       | String | 录制模式，目前只支持合流模式 `"mix"`。                       |

### HTTP 请求示例

```
POST /v1/apps/\<appid\>/cloud_recording/resourceid/\<resourceid\>/sid/\<sid\>/mode/\<mode\>/stop
Host: <!!!待定>
Content-type: application/json;charset=utf-8
Authorization: Basic ZGJhZDMyNmFkMzQ0NDk2NGEzYzAwNjZiZmYwNTZmNjo2ZjIyMmZhMTkzNWE0MWQzYTczNzg2ODdiMmNiYjRh <!!!待定>
```

### 响应示例

```http
{
"Code": 200,
"Body":
{
  "resourceId":"<resourceId>",
  "sid":"<sid>",
  "serverResponse":{
    "fileList": "<fileList>",
    "uploadingStatus": "<uploadingStatus>"
  }
}
}
```

- `code`: Number 类型，[响应状态码](#status)。
- `resourceId`: String 类型，云端录制使用的 resource ID。
- `sid`: String 类型，录制 ID。成功开始云端录制后，你会得到一个 sid （录制 ID)。该 ID 是一次录制周期的唯一标识。
- `serverResponse`: JSON 类型，录制的具体信息。
  - `fileList`：String 类型，录制生成的文件索引。每次录制均会生成一个 M3U8 文件，用于索引该次录制所有的 TS 文件。你可以通过 M3U8 文件播放和管理录制文件。
  - `uploadingStatus`：String 类型，当前录制上传的状态。
    - `"uploaded"`：本次录制的文件已经全部上传至客户指定的第三方云存储。
    - `"backuped"`：本次录制的文件已经全部上传完成，但是至少有一个 TS 文件上传到了 Agora 云备份。Agora 服务器会自动将这部分文件继续上传至指定的第三方云存储。
    - `"unknown"`：未知状态，请尝试再次调用 `query` 方法查询状态。

## <a name="status"></a>响应状态码

| 状态码 | 描述                                            |
| :----- | :---------------------------------------------- |
| 200    | 请求处理成功                                    |
| 400    | 输入格式错误                                    |
| 401    | 未经授权 (App ID/Customer Certificate 匹配错误) |
| 404    | API 调用错误                                    |
| 500    | 服务器内部错误                                  |