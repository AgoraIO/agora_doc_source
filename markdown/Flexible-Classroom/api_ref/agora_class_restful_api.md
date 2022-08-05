本文介绍灵动课堂云服务 RESTful API 的详细信息。

## 基本信息

### 域名

所有请求都发送给域名：api.agora.io。

### 数据格式

所有请求的 Content-Type 类型为 application/json。

### 认证方式

灵动课堂云服务 RESTful API 支持 Token 认证。你需要在发送 HTTP 请求时在 HTTP 请求头部的 `x-agora-token` 字段和 `x-agora-uid` 字段分别填入：

-   服务端生成的 RTM Token。
-   生成 RTM Token 时使用的 uid。

具体生成 RTM Token 的方法请参考[生成 RTM Token](/cn/Real-time-Messaging/token_server_rtm) 文档。

## 踢人

#### 接口描述

将指定用户从课堂中踢出。成功调用此接口后，服务端会触发一个用户进出课堂事件。你可通过 `dirty` 参数设置该用户后续是否还能再加入课堂。

#### 接口原型

-   方法：POST
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/users/{userUuid}/exit

#### 请求参数

**URL 参数**

在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                         |
| :--------- | :----- | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`    | String | （必填）Agora App ID。                                       |
| `roomUUid` | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `userUuid` | String | （必填）用户 uuid。这是用户的唯一标识符，也是登录 RTM 系统时使用的用户 ID。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**请求包体参数**

在请求包体中传入以下参数。

| 参数    | 类型   | 描述                                                         |
| :------ | :----- | :----------------------------------------------------------- |
| `dirty` | Object | （非必填）用户的污点设置，包含以下字段：<ul><li>`state`: Boolean 类型，污点状态：<ul><li>`1`: 有污点。有污点的用户无法进入课堂。</li><li>`0`: 无污点。</li></ul><li>`duration`: Number 类型，有污点状态持续时间，单位为秒，从被踢出的时候开始计时。</li></ul> |

#### 请求示例

**请求 URL**

```html
https://api.agora.io/edu/apps/{your_app_Id}/v2/rooms/test_class/users/123/exit
```

**请求包体**

```json
{
    "dirty": {
        "state": 1,
        "duration": 600
    }
}
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li> |
| `msg`  | String  | 详细信息。                                                  |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## 创建房间

#### 接口描述

房间创建后，默认保留 5 天。

#### 接口原型

-   方法：POST
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}

#### 请求参数

**URL 参数**

在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                         |
| :--------- | :----- | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`    | String | （必填）Agora App ID。                                       |
| `roomUUid` | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**请求包体参数**

在请求包体中传入以下参数。

| 参数                                         | 类型    | 描述                                                         |
| :------------------------------------------- | :------ | :----------------------------------------------------------- |
| `roomType`                                   | String  | （必填）房间类型，可设为：<ul><li>`0`: 一对一</li><li>`2`: 大班课</li><li>`4`: 小班课</li></ul><p>该字段不可更新。</p> |
| `roomName`                                   | String  | （必填）房间名称。                                           |
| `roomProperties`                             | Object  | （非必填）房间属性。                                         |
| `roomProperties.schedule`                    | Object  | （非必填）课程计划。                                         |
| `roomProperties.schedule.startTime`          | Integer | （非必填）课堂开始时间。该字段不可更新。                     |
| `roomProperties.schedule.duration`           | Integer | （非必填）课堂持续时间。                                     |
| `roomProperties.schedule.closeDelay`         | Integer | （非必填）拖堂时间。                                         |
| `roomProperties.processes`                   | Object  | （非必填）申请邀请流程。                                     |
| `roomProperties.processes.handsUp`           | Object  | （非必填）上台设置。                                         |
| `roomProperties.processes.handsUp.maxAccept` | Integer | （非必填）上台人数上限。                                     |

#### 请求示例

**请求包体**

```json
{
    "roomName": "jasoncai61734",
    "roomType": 4,
    "roomProperties": {
        "schedule": {
            "startTime": 1655452800000,
            "duration": 600,
            "closeDelay": 300
        },
        "processes": {
            "handsUp": {
                "maxAccept": 10
            }
        }
    }
}
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li> |
| `msg`  | String  | 详细信息。                                                  |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## 设置课堂状态

#### 接口描述

设置课堂状态（未开始/开始/结束）。详见[课堂状态说明](/cn/agora-class/faq/agora_class_state)。

#### 接口原型

-   方法：PUT
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/states/{state}

#### 请求参数

**URL 参数**

需要在 URL 中传入以下参数。

| 参数       | 类型    | 描述                                                         |
| :--------- | :------ | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`    | String  | （必填）Agora App ID。                                       |
| `roomUUid` | String  | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `state`    | Integer | （必填）课堂状态：<ul><li>`0`: 未开始</li><li>`1`: 开始</li><li>`2`: 结束</li><li>`3`: 拖堂时间结束，房间关闭，用户无法再进入</li></ul> |

#### 请求示例

```html
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/states/1
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li> |
| `msg`  | String  | 详细信息。                                                  |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                |

#### 响应示例

```json
"status": 200,
"body":
{
    "code": 0,
    "msg": "Success",
    "ts": 1610450153520
}
```

## 设置录制状态

#### 接口描述

开始或结束录制指定课堂。详见[课堂录制最佳实践](/cn/agora-class/agora_class_record?platform=Web)。

#### 接口原型

-   方法：PUT
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/records/states/{state}

#### 请求参数

**URL 参数**

需要在 URL 中传入以下参数。

| 参数       | 类型    | 描述                                                         |
| :--------- | :------ | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`    | String  | （必填）Agora App ID。                                       |
| `roomUUid` | String  | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `state`    | Integer | （必填）录制状态：<li>`0`: 结束</li><li>`1`: 开始</li>       |

**请求包体参数**

在请求包体中传入以下参数。

| 参数              | 类型   | 描述                                                         |
| :---------------- | :----- | :----------------------------------------------------------- |
| `mode`            | String | （非必填）录制模式：<li>设为 `web`，则启用[页面录制模式](/cn/Agora%20Platform/webpage_recording)。录制生成 MP4 文件。此外，录制服务会在当前 MP4 文件时长超过 2 小时或大小超过 2 GB 时创建一个新的 MP4 文件。</li><li>不填，则启用[合流录制模式](/cn/Agora%20Platform/composite_recording_mode)且只录制老师的音视频。录制生成 M3U8 和 TS 文件。</li> |
| `webRecordConfig`| Object | （非必填）当 `mode` 为 `web` 时，你需要通过 `webRecordConfig` 设置页面录制的详细信息，包含以下字段：<ul><li>`url`:（必填）String 类型，待录制页面地址。如你想要录制灵动课堂的某一节课，你需要在 URL 中传入启动课堂相关参数，以便 Agora 云端录制服务以一个“隐身用户”的身份加入指定课堂进行录制。可参考请求示例中 URL 的示例。URL 中需包含以下参数：<ul><li>`userUuid`: Agora 云端录制服务使用的用户 ID。请确保不要和课堂中已有用户的 ID 重复，否则 Agora 云端录制服务将无法加入课堂。</li><li>`roomUuid`: 待录制课堂的课堂 ID。</li><li>`roomType`: 待录制课堂的课堂类型。</li><li>`roleType`: Agora 云端录制服务在待录制课堂内的角色，设为 0（专用于录制的课堂角色）。</li><li>`pretest`: 是否开启课前检测，设为 `false`。</li><li>`rtmToken`: Agora 云端录制服务使用的 RTM Token。</li><li>`language`: 界面语言，可设为 `zh` 或 `en`。</li><li>`appId`: Agora App ID。</li></ul></li><li>`rootUrl`: （必填）String 类型，待录制页面的根地址。实际录制时，教育云服务会根据 `rootUrl` 自动拼接上 `roomUuid`、`roomType` 等参数。如你同时设置了 `url` 和 `rootUrl`， `url` 的优先级高于 `rootUrl`。</li><li>`publishRtmp`: （非必填）是否将页面录制的流推到 CDN：<ul><li>`true`: 推。</li><li>`false`: 不推。</li></ul></li><li>`onhold`: （非必填）Boolean 类型，可设为：<ul><li>`true`: 在启动页面录制任务后立即暂停录制。录制服务会打开并渲染待录制页面，但不生成切片文件。</li><li>`false`: （默认）启动页面录制任务并开始录制。</li></ul></li><li>`videoBitrate`:（非必填）Number 类型，输出视频的码率，单位为 kbps，范围为 [50, 8000]。针对不同的输出视频分辨率，`videoBitrate` 的默认值不同：<ul><li>输出视频分辨率大于或等于 1280 × 720：默认值为 2000。</li><li>输出视频分辨率小于 1280 × 720：默认值为 1500。</li></ul></li><li>`videoFps`:（非必填）Number 类型，输出视频的帧率，单位为 fps，范围为 [5, 60]，默认值为 15。</li><li>`audioProfile`: Number 类型，设置输出音频的采样率、码率、编码模式和声道数。<ul><li>0：（默认）48 kHz 采样率，音乐编码，单声道，编码码率约 48 Kbps</li><li>1：48 kHz 采样率，音乐编码，单声道，编码码率约 128 Kbps</li><li>2：48 kHz 采样率，音乐编码，双声道，编码码率约 192 Kbps</li></ul></li><li>`videoWidth`: Number 类型，设置输出视频的宽度，单位为 pixel，范围为 [480, 1920]。默认为 1280。`videoWidth` 和 `videoHeight` 的乘积需小于等于 1920 x 1080。</li><li>`videoHeight`: Number 类型，设置输出视频的高度，单位为 pixel，范围为 [480, 1920]。默认为 720。`videoWidth` 和 `videoHeight` 的乘积需小于等于 1920 × 1080。</li><li>`maxRecordingHour`: Number 类型，设置录制的最大时长，单位为小时，范围为 [1,720]。如果你设置了课堂持续时间，会按照课堂持续时间向上取整。假设课堂持续时间是 1800 秒，`maxRecordingHour` 则为 1 小时。如果你没有设置课堂持续时间，`maxRecordingHour` 默认为 2 小时。当录制时长超过 `maxRecordingHour`，录制会自动停止。</li></ul> |
| `retryTimeout`    | Number | 重试超时时间，单位为秒。最多重试两次。设置 `retryTimeout` 参数后，Agora 建议你参考[课堂录制最佳实践](/cn/agora-class/agora_class_record?platform=RESTful#启动课堂录制)进行操作。 |

#### 请求示例

**请求 URL**

```html
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records/states/1
```

**请求包体**

```json
{
    "mode": "web",
    "webRecordConfig": {
        "url": "https://webdemo.agora.io/xxxxx/?userUuid={recorder_id}&roomUuid={room_id_to_be_recorded}&roleType=0&roomType=4&pretest=false&rtmToken={recorder_token}&language=en&appId={your_app_id}",
        "rootUrl": "https://xxx.yyy.zzz",
        "publishRtmp": "true"
    },
    "retryTimeout": 60
}
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li> |
| `msg`  | String  | 详细信息。                                                  |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。|
| `streamingUrl`|Object | 经由页面录制后推到 CDN 的流地址。学生可以通过该地址观看教学。  |

#### 响应示例

```json
"status": 200,
"body":
{
    "code": 0,
    "ts": 1610450153520,
    "streamingUrl": {
            "rtmp": "",
            "flv": "",
            "hls": ""
        }
}
```

## 更新录制设置

#### 接口描述

在录制过程中随时调用此接口更新录制相关设置。每次调用此接口都会覆盖原先的设置。

<div class="alert note">由于录制启动需要一定时间，建议在开启录制至少一分钟后再调用此接口。</div>

#### 接口原型

-   方法：PATCH
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/records/states/1

#### 请求参数

**URL 参数**

需要在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                         |
| :--------- | :----- | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`    | String | （必填）Agora App ID。                                       |
| `roomUUid` | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**请求包体参数**

在请求包体中传入以下参数。

| 参数              | 类型   | 描述                                                         |
| :---------------- | :----- | :----------------------------------------------------------- |
| `webRecordConfig` | Object | （非必填）录制具体设置，包含以下字段：<ul><li>`onhold`: （必填）Boolean 类型，可设为：<ul><li>`true`: 在页面录制过程中暂停录制。暂停后，录制服务不再生成切片文件。</li><li>`false`: （默认）继续进行页面录制。录制暂停后，你可调用此接口并将 `onhold` 参数设为 `false` 继续页面录制。</li></ul></li></ul> |

#### 请求示例

**请求 URL**

```html
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records/states/1
```

**请求包体**

```json
{
    "webRecordConfig": {
        "onhold": false
    }
}
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li> |
| `msg`  | String  | 详细信息。                                                  |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                |

#### 响应示例

```json
"status": 200,
"body":
{
    "code": 0,
    "ts": 1610450153520
}
```

## 获取录制列表

#### 接口描述

获取指定课堂内的录制列表。

你可以通过 `nextId` 分批拉取，每批最多拉取 100 条数据。

#### 接口原型

-   方法：GET
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/records

#### 请求参数

**URL 参数**

需要在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                         |
| :--------- | :----- | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`    | String | （必填）Agora App ID。                                       |
| `roomUUid` | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**Query 参数**

| 参数     | 类型   | 描述                                                         |
| :------- | :----- | :----------------------------------------------------------- |
| `nextId` | String | （非必填）下一批数据的起始 ID。第一次获取可传 null，后续获取传入响应结果里得到的 `nextId`。 |

#### 请求示例

示例一：

```html
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records?null
```

示例二：

```html
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records?nextId=xxx
```

#### 响应参数

| 参数   | 类型    | 描述                                                         |
| :----- | :------ | :----------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li>  |
| `msg`  | String  | 详细信息。                                                   |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                 |
| `data` | Object  | 具体数据，包含：<ul><li>`count`: Integer 型，本批数据条数。</li><li>`list`: 由多个 Object 组成的数组。每个 Object 包含以下字段：<ul><li>`appId`: 你的 Agora App ID。 </li><li>`roomUuid`: 课堂 uuid。这是课堂的唯一标识符，也是 Agora RTC SDK 和 Agora RTM SDK 中使用的频道名。 </li><li>`recordId`: 一次录制的的唯一标识符。调用设置录制状态 API 开始录制然后结束录制视为一次录制。</li><li>`startTime`: 录制开始的 UTC 时间戳，单位为毫秒。 </li><li>`endTime`: 录制结束的 UTC 时间戳，单位为毫秒。 </li><li>`resourceId`: Agora 云端录制服务的 `resourceId`。 </li><li>`sid`: Agora 云端录制服务的 `sid`。 </li><li>`recordUid`: Agora 云端录制服务在频道内使用的 UID。 </li><li>`boardAppId`: Agora 互动白板服务的 App Identifier。 </li><li>`boardToken`: Agora 互动白板服务的 SDK Token。</li><li>`boardId`: 白板的唯一标识符。 </li><li>`type`: Integer 型，录制类型：<ul><li>`1`: 单流录制</li><li>`2`: 合流录制</li></ul></li><li>`status`: Integer 型，录制状态：<ul><li>`1`: 录制中</li><li>`2`: 录制已结束</li></ul></li><li>`url`: String 型，合流录制模式下录制文件的访问地址。 </li><li>`recordDetails`: JSONArray 类型。包含以下字段：<ul><li>`url`: String 型，网页录制模式下录制文件的访问地址。</li></ul></li><li>`nextId`: String 型，下一批数据的起始 ID。如为 null，则表示没有下一批数据。如不为 null，则可用此 `nextId` 继续查询，直到查到 null 为止。</li><li>`total`: Integer 型，数据总条数。</li><li>`unready`: Boolean 型，值为 `true` 表示录制失败。如果在开启录制时设置了 `retryTimeout` 参数，由于超时未报告 ready 而被自动停止的录制任务会被添加 `unready` 标记。</li></ul></li></ul> |

#### 响应示例

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

## 查询指定用户

#### 接口原型

-   方法：GET
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/users/{userUuid}

#### 请求参数

**URL 参数**

在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                                                                                              |
| :--------- | :----- | :-------------------------------------------------------------------------------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`    | String | （必填）Agora App ID。                                                                                                            |
| `roomUUid` | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `userUuid` | String | （必填）用户 uuid。这是用户的唯一标识符，也是登录 RTM 系统时使用的用户 ID。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

#### 响应参数

| 参数   | 类型    | 描述                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| :----- | :------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| `msg`  | String  | 详细信息。                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| `data` | Object  | 具体数据，包含：<ul><li>`userUuid`: 用户 ID。</li><li>`userName`: 用户名称。</li><li>`role`: 用户角色：<ul><li>`1`: 老师</li><li>`2`: 学生</li><li>`3`: 助教</li></ul></li><li>`streamUuid`: 流 ID。</li><li>`state`: 该用户是否在线。`0` 表示不在线；`1` 表示在线。</li><li>`userProperties`: 用户属性。</li><li>`updateTime`: 更新时间。</li></ul> |

#### 响应示例

```json
{
    "msg":"Success",
    "code":0,
    "ts":1658126805245,
    "data":{
        "userName":"jasoncai",
        "userUuid":"681d9aca4924e9a84ad301e8cca438a71",
        "role":"1",
        "userProperties":{},
        "updateTime":1658126782174,
        "streamUuid":"1417753684",
        "state":1
    }
}
```

## 查询指定事件

#### 接口描述

查询指定课堂内指定类型的事件。

你可以通过 `nextId` 分批查询，每批最多查询 100 条数据。

<div class="note info"><li>同一事件可重复查询。</li><li> 仅能查询未销毁课堂内的事件。默认情况下，课堂会在结束后一小时销毁。</li></div>

#### 接口原型

-   方法：GET
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/sequences

#### 请求参数

**URL 参数**

在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                         |
| :--------- | :----- | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`    | String | （必填）Agora App ID。                                       |
| `roomUUid` | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**Query 参数**

| 参数     | 类型    | 描述                                                         |
| :------- | :------ | :----------------------------------------------------------- |
| `nextId` | String  | （非必填）下一批数据的起始 ID。第一次获取可传 null，后续获取传入响应结果里得到的 `nextId`。 |
| `cmd`    | Integer | （非必填）事件类型，详见[事件枚举](/cn/agora-class/agora_class_restful_api_event)。 |

#### 请求示例

**请求 URL**

示例一：

```html
https://api.agora.io/edu/apps/{appId}/v2/rooms/test_class/sequences?null&cmd=1
```

示例二：

```html
https://api.agora.io/edu/apps/{appId}/v2/rooms/test_class/sequences?nextId=50&cmd=1
```

#### 响应参数

| 参数   | 类型    | 描述                                                         |
| :----- | :------ | :----------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li>  |
| `msg`  | String  | 详细信息。                                                   |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                 |
| `data` | Object  | 具体数据，包含：<ul><li>`total`: Integer 型，数据总条数。 </li><li>`count`: Integer 型，本批数据条数。 </li><li>`list`: 由多个 Object 组成的数组。每个 Object 包含以下：<ul><li>`roomUuid`: String 型，课堂 uuid。</li><li>`cmd`: Integer 型，事件类型。详见[事件枚举](/cn/agora-class/agora_class_restful_api_event)。</li><li>`sequence`: Integer 型。事件序号，是每个课堂内事件的唯一标识符，课堂内全局自增，用于确保事件的有序性。</li><li>`version`: Integer 型，版本号。</li><li>`data`: Object 型，事件的具体数据，取决于事件类型。详见[事件枚举](/cn/agora-class/agora_class_restful_api_event)。</li></ul><li>`nextId`: String 型，下一批数据的起始 ID。如为 null，则表示没有下一批数据。如不为 null，则可用此 `nextId` 继续查询，直到查到 null 为止。</li></ul> |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610433913533,
    "data": {
        "total": 1,
        "list": [
            {
                "roomUuid": "",
                "cmd": 20,
                "sequence": 1,
                "version": 1,
                "data": {}
            }
        ],
        "nextId": null,
        "count": 1
    }
}
```

## 获取课堂事件

#### 接口描述

在服务端获取指定 App ID 下所有课堂中发生的事件。

你可定时轮询该接口来监听灵动课堂中发生的事件。

<div class="alert note"><li>每个事件只能获取一次。</li><li>最早可查一小时内未销毁的课堂里的事件。</li></div>

#### 接口原型

-   方法：GET
-   接入点：/{region}/edu/polling/apps/{appId}/v2/rooms/sequences

#### 请求参数

**URL 参数**

需要在 URL 中传入以下参数。

| 参数    | 类型   | 描述                   |
| :------ | :----- | :--------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId` | String | （必填）Agora App ID。 |

#### 请求示例

```html
https://api.agora.io/edu/polling/apps/{yourappId}/v2/rooms/sequences
```

#### 响应参数

| 参数   | 类型    | 描述                                                         |
| :----- | :------ | :----------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li>  |
| `msg`  | String  | 详细信息。                                                   |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                 |
| `data` | Object  | 具体数据，包含：<li>`roomUuid`: String 型，课堂 uuid。</li><li>`cmd`: Integer 型，事件类型。详见[事件枚举](/cn/agora-class/agora_class_restful_api_event)。</li><li>`sequence`: Integer 型。事件序号，是每个课堂内事件的唯一标识符，课堂内全局自增，用于确保事件的有序性。<li>`version`: Integer 型，版本号。</li><li>`data`: Object 型，事件的具体数据，取决于事件类型。详见[事件枚举](/cn/agora-class/agora_class_restful_api_event)。</li> |

#### 响应示例

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

## 更新课堂属性

#### 接口描述

新增或更新指定课堂的自定义属性，详见[如何设置自定义用户属性和课堂属性？](/cn/agora-class/faq/agora_class_custom_properties)

#### 接口原型

-   方法：PUT
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/properties

#### 请求参数

**URL 参数**

在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                         |
| :--------- | :----- | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`    | String | （必填）Agora App ID。                                       |
| `roomUUid` | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**请求包体参数**

在请求包体中传入以下参数。

| 参数         | 类型   | 描述       |
| :----------- | :----- | :--------- |
| `properties` | Object | 课堂属性。 |
| `cause`      | Object | 更新原因。 |

#### 请求示例

**请求包体**

```json
{
    "properties": {
        "key1": "value1",
        "key2": "value2"
    },
    "cause": {}
}
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li> |
| `msg`  | String  | 详细信息。                                                  |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## 删除课堂属性

#### 接口描述

删除指定课堂的自定义属性，详见[如何设置自定义用户属性和课堂属性？](/cn/agora-class/faq/agora_class_custom_properties)

#### 接口原型

-   方法：DELETE
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/properties

#### 请求参数

**URL 参数**

在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                         |
| :--------- | :----- | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`    | String | （必填）Agora App ID。                                       |
| `roomUUid` | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**请求包体参数**

在请求包体中传入以下参数。

| 参数         | 类型        | 描述       |
| :----------- | :---------- | :--------- |
| `properties` | String 数组 | 课堂属性。 |
| `cause`      | Object      | 删除原因。 |

#### 请求示例

**请求包体**

```json
{
    "properties": ["key1", "key2"],
    "cause": {}
}
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li> |
| `msg`  | String  | 详细信息。                                                  |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## 更新用户属性

#### 接口描述

新增或更新指定用户的自定义属性，详见[如何设置自定义用户属性和课堂属性？](/cn/agora-class/faq/agora_class_custom_properties)

#### 接口原型

-   方法：PUT
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/users/{userUuid}/properties

#### 请求参数

**URL 参数**

在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                         |
| :--------- | :----- | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`    | String | （必填）Agora App ID。                                       |
| `roomUUid` | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `userUuid` | String | （必填）用户 uuid。这是用户的唯一标识符，也是登录 RTM 系统时使用的用户 ID。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**请求包体参数**

在请求包体中传入以下参数。

| 参数         | 类型   | 描述       |
| :----------- | :----- | :--------- |
| `properties` | Object | 用户属性。 |
| `cause`      | Object | 更新原因。 |

#### 请求示例

**请求包体**

```json
{
    "properties": {
        "key1": "value1",
        "key2": "value2"
    },
    "cause": {}
}
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li> |
| `msg`  | String  | 详细信息。                                                  |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## 删除用户属性

#### 接口描述

删除指定用户的自定义属性，详见[如何设置自定义用户属性和课堂属性？](/cn/agora-class/faq/agora_class_custom_properties)

#### 接口原型

-   方法：DELETE
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/users/{userUuid}/properties

#### 请求参数

**URL 参数**

在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                         |
| :--------- | :----- | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`    | String | （必填）Agora App ID。                                       |
| `roomUUid` | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `userUuid` | String | （必填）用户 uuid。这是用户的唯一标识符，也是登录 RTM 系统时使用的用户 ID。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**请求包体参数**

在请求包体中传入以下参数。

| 参数         | 类型        | 描述       |
| :----------- | :---------- | :--------- |
| `properties` | String 数组 | 用户属性。 |
| `cause`      | Object      | 删除原因。 |

#### 请求示例

**请求包体**

```json
{
    "properties": ["key1", "key2"],
    "cause": {}
}
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li> |
| `msg`  | String  | 详细信息。                                                  |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## 设置 Widget 属性

设置指定 Widget 的属性。

#### 接口原型

-   方法：PUT
-   请求路径：/{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/widgets/{widgetUuid}

#### 请求参数

**URL 参数**

在 URL 中传入以下参数。

| 参数         | 类型   | 描述                                                         |
| :----------- | :----- | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`      | String | （必填）Agora App ID。                                       |
| `roomUUid`   | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `widgetUuid` | String | （必填）Widget uuid。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**请求包体参数**

在请求包体中传入以下参数。

| 参数            | 类型    | 描述                                                         |
| :-------------- | :------ | :----------------------------------------------------------- |
| `extra`         | Object  | （非必填）Widget 扩展信息。                                  |
| `cause`         | Object  | （非必填）更新原因。                                         |
| `state`         | Integer | （非必填）Widget 的活跃状态。`0` 表示关闭，`1` 表示开启。    |
| `ownerUserUuid` | String  | （非必填）Widget 所属用户。该用户离线后，Widget 会被自动删除。 |

#### 请求示例

**请求包体**

```json
{
    "extra": {},
    "cause": {},
    "state": 1,
    "ownerUserUuid": "user"
}
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li> |
| `msg`  | String  | 详细信息。                                                  |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## 删除 Widget

#### 接口描述

删除指定 Widget。

#### 接口原型

-   方法：DELETE
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/widgets/{widgetUuid}

#### 请求参数

**URL 参数**

在 URL 中传入以下参数。

| 参数         | 类型   | 描述                                                         |
| :----------- | :----- | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`      | String | （必填）Agora App ID。                                       |
| `roomUUid`   | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `widgetUuid` | String | （必填）Widget uuid。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**请求包体参数**

在请求包体中传入以下参数。

| 参数    | 类型   | 描述                 |
| :------ | :----- | :------------------- |
| `cause` | Object | （非必填）更新原因。 |

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li> |
| `msg`  | String  | 详细信息。                                                  |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## 删除 Widget 属性

#### 接口描述

删除指定 Widget 的属性。

#### 接口原型

-   方法：DELETE
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/widgets/{widgetUuid}/extra

#### 请求参数

在 URL 中传入以下参数。

| 参数         | 类型   | 描述                                                         |
| :----------- | :----- | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`      | String | （必填）Agora App ID。                                       |
| `roomUUid`   | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `widgetUuid` | String | （必填）Widget uuid。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**请求包体参数**

在请求包体中传入以下参数。

| 参数         | 类型        | 描述                              |
| :----------- | :---------- | :-------------------------------- |
| `properties` | String 数组 | （必填）需删除的 extra 属性数组。 |
| `cause`      | Object      | （必填）删除原因。                |

#### 请求示例

**请求包体**

```json
{
    "properties": ["key-path1", "key-path2"],
    "cause": {}
}
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li> |
| `msg`  | String  | 详细信息。                                                  |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## 设置 Widget 的用户属性

设置指定 Widget 的用户属性。

#### 接口原型

-   方法：PUT
-   请求路径：/{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/widgets/{widgetUuid}/users/{userUuid}

#### 请求参数

**URL 参数**

在 URL 中传入以下参数。

| 参数         | 类型   | 描述                                                         |
| :----------- | :----- | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`      | String | （必填）Agora App ID。                                       |
| `roomUUid`   | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `widgetUuid` | String | （必填）Widget uuid。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `userUuid`   | String | （必填）用户 uuid。这是用户的唯一标识符，也是登录 RTM 系统时使用的用户 ID。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**请求包体参数**

在请求包体中传入以下参数。

| 参数         | 类型   | 描述                               |
| :----------- | :----- | :--------------------------------- |
| `properties` | Object | （必填）需设置的 Widget 用户属性。 |
| `cause`      | Object | （必填）更新原因。                 |

#### 请求示例

**请求包体**

```json
{
    "properties": {},
    "cause": {}
}
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li> |
| `msg`  | String  | 详细信息。                                                  |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## 删除 Widget 的用户属性

#### 接口描述

删除指定 Widget 的用户属性。

#### 接口原型

-   方法：DELETE
-   接入点：/{region}/edu/apps/{appId}/v2/rooms/{roomUUid}/widgets/{widgetUuid}/users/{userUuid}

#### 请求参数

| 参数         | 类型   | 描述                                                         |
| :----------- | :----- | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`      | String | （必填）Agora App ID。                                       |
| `roomUUid`   | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `widgetUuid` | String | （必填）Widget uuid。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |
| `userUuid`   | String | （必填）用户 uuid。这是用户的唯一标识符，也是登录 RTM 系统时使用的用户 ID。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**请求包体参数**

在请求包体中传入以下参数。

| 参数         | 类型        | 描述                                   |
| :----------- | :---------- | :------------------------------------- |
| `properties` | String 数组 | （必填）需删除的 Widget 用户属性数组。 |
| `cause`      | Object      | （必填）删除原因。                     |

#### 请求示例

**请求包体**

```json
{
    "properties": ["key-path1", "key-path2"],
    "cause": {}
}
```

#### 响应参数

| 参数   | 类型    | 描述                                                        |
| :----- | :------ | :---------------------------------------------------------- |
| `code` | Integer | 业务状态码：<li>0: 请求成功。</li><li>非 0: 请求失败。</li> |
| `msg`  | String  | 详细信息。                                                  |
| `ts`   | Number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                |

#### 响应示例

```json
{
    "msg": "Success",
    "code": 0,
    "ts": 1610167740309
}
```

## 获取答题器事件

#### 接口原型

-   方法：GET
-   请求路径：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/widgets/popupQuiz/sequences

#### 请求参数

**URL 参数**

在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                         |
| :--------- | :----- | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`    | String | （必填）Agora App ID。                                       |
| `roomUUid` | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**Query 参数**

| 参数     | 类型    | 描述                                                         |
| :------- | :------ | :----------------------------------------------------------- |
| `nextId` | String  | （非必填）下一批数据的起始 ID。第一次获取可传 null，后续获取传入响应结果里得到的 `nextId`。 |
| `count`  | Integer | （非必填）本批数据条数，默认值为 100。                       |

#### 响应参数

不同情况下 `data` 中返回的字段不同，具体如下：

-   老师开启答题后，答题器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                       | 类型     | 说明                                                         |
    | :----------------------------------------- | :------- | :----------------------------------------------------------- |
    | action                                     | Integer  | 操作类型                                                     |
    | widgetUuid                                 | String   | Widget ID                                                    |
    | changeProperties                           | Object   | 发生变更的属性                                               |
    | changeProperties.extra                     | Object   | 属性补充信息                                                 |
    | changeProperties.extra.correctItems        | Object[] | 正确选项                                                     |
    | changeProperties.extra.correctCount        | Integer  | 本题答对人数                                                 |
    | changeProperties.extra.answerState         | Integer  | 本次答题状态：<ul><li>`1` : 答题进行中</li><li>`0`: 答题结束</li></ul> |
    | changeProperties.extra.receiveQuestionTime | Long     | 收到题目时间                                                 |
    | changeProperties.extra.popupQuizId         | String   | 题目 ID                                                      |
    | changeProperties.extra.averageAccuracy     | Float    | 本题正确率                                                   |
    | changeProperties.extra.totalCount          | Integer  | 本题回答总人数                                               |
    | changeProperties.extra.items               | Object[] | 本题的所有选项                                               |
    | changeProperties.state                     | Integer  | 答题器状态：<ul><li>`0`: 非活跃</li><li>`1`: 活跃</li></ul>  |
    | cause                                      | Object   | 属性变更原由。                                               |
    | cause.popQuizId                            | String   | 答题器 ID。                                                  |
    | cause.action                               | Integer  | 操作类型：<ul><li>`1`: 老师开始答题。</li><li>`2`: 老师结束答题。</li><li>`3`: 学生提交答案。</li><li>`4`: 汇总信息同步。</li></ul> |
    | operator                                   | Object   | 操作人                                                       |
    | operator.userUuid                          | String   | 用户 ID                                                      |
    | operator.userName                          | String   | 用户名称                                                     |
    | operator.role                              | String   | 用户角色                                                     |

-   学生提交答案后，该学生的答题数据会发生变化，`data` 中包含以下字段：

    | 字段                            | 类型     | 说明                                                         |
    | :------------------------------ | :------- | :----------------------------------------------------------- |
    | action                          | Integer  | 操作类型                                                     |
    | widgetUuid                      | String   | Widget ID                                                    |
    | changeProperties                | Object   | 发生变更的属性                                               |
    | changeProperties.lastCommitTime | Long     | 最后一次提交时间                                             |
    | changeProperties.popupQuizId    | String   | 题目 ID                                                      |
    | changeProperties.selectedItems  | Object[] | 该学生提交的答案                                             |
    | changeProperties.isCorrect      | Boolean  | 该学生提交的答案是否正确                                     |
    | cause                           | Object   | 属性变更原由。                                               |
    | cause.popQuizId                 | String   | 答题器 ID。                                                  |
    | cause.action                    | Integer  | 操作类型：<ul><li>`1`: 老师开始答题。</li><li>`2`: 老师结束答题。</li><li>`3`: 学生提交答案。</li><li>`4`: 汇总信息同步。</li></ul> |
    | operator                        | Object   | 操作人                                                       |
    | operator.userUuid               | String   | 用户 uuid                                                    |
    | operator.userName               | String   | 用户名称                                                     |
    | operator.role                   | String   | 用户角色                                                     |
    | fromUser                        | Object   | 发起本次答题的用户                                           |
    | fromUser.userUuid               | String   | 用户 ID                                                      |
    | fromUser.userName               | String   | 用户名称                                                     |
    | fromUser.role                   | String   | 用户角色                                                     |

-   学生提交答案后，答题器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                   | 类型    | 说明                                                         |
    | :------------------------------------- | :------ | :----------------------------------------------------------- |
    | action                                 | Integer | 操作类型                                                     |
    | widgetUuid                             | String  | Widget ID                                                    |
    | changeProperties                       | Object  | 发生变更的属性                                               |
    | changeProperties.extra                 | Object  | 属性补充信息                                                 |
    | changeProperties.extra.selectedCount   | Integer | 已经答题人数                                                 |
    | changeProperties.extra.correctCount    | Integer | 本题答对人数                                                 |
    | changeProperties.extra.averageAccuracy | Float   | 本题正确率                                                   |
    | changeProperties.extra.totalCount      | Integer | 本题回答总人数                                               |
    | cause                                  | Object  | 属性变更原由。                                               |
    | cause.popQuizId                        | String  | 答题器 ID。                                                  |
    | cause.action                           | Integer | 操作类型：<ul><li>`1`: 老师开始答题。</li><li>`2`: 老师结束答题。</li><li>`3`: 学生提交答案。</li><li>`4`: 汇总信息同步。</li></ul> |
    | operator                               | Object  | 操作人                                                       |
    | operator.userUuid                      | String  | 用户 ID                                                      |
    | operator.userName                      | String  | 用户名称                                                     |
    | operator.role                          | String  | 用户角色                                                     |

-   老师结束答题后，答题器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                   | 类型    | 说明                                                         |
    | :------------------------------------- | :------ | :----------------------------------------------------------- |
    | action                                 | Integer | 操作类型                                                     |
    | widgetUuid                             | String  | Widget ID                                                    |
    | changeProperties                       | Object  | 发生变更的属性                                               |
    | changeProperties.extra                 | Object  | 属性补充信息                                                 |
    | changeProperties.extra.selectedCount   | Integer | 已经答题人数                                                 |
    | changeProperties.extra.correctCount    | Integer | 本题答对人数                                                 |
    | changeProperties.extra.answerState     | Integer | 本次答题状态：<ul><li>`1` : 答题进行中</li><li>`0`: 答题结束</li></ul> |
    | changeProperties.extra.averageAccuracy | Float   | 本题正确率                                                   |
    | changeProperties.extra.totalCount      | Integer | 本题回答总人数                                               |
    | cause                                  | Object  | 属性变更原由。                                               |
    | cause.popQuizId                        | String  | 答题器 ID。                                                  |
    | cause.action                           | Integer | 操作类型：<ul><li>`1`: 老师开始答题。</li><li>`2`: 老师结束答题。</li><li>`3`: 学生提交答案。</li><li>`4`: 汇总信息同步。</li></ul> |
    | operator                               | Object  | 操作人                                                       |
    | operator.userUuid                      | String  | 用户 uuid                                                    |
    | operator.userName                      | String  | 用户名称                                                     |
    | operator.role                          | String  | 用户角色                                                     |

#### 响应示例

-   老师开启答题后，答题器的汇总数据发生变化：

    ```json
    "action": NumberInt("1"),
    "widgetUuid": "xxxxxxxxx",
    "changeProperties": {
        "extra.correctItems": [
            "A",
            "B",
            "D"
        ],
        "extra.totalCount": NumberInt("1"),
        "extra.answerState": NumberInt("1"),
        "state": NumberInt("1"),
        "extra.popupQuizId": "ab5b183238a74d5a9c955dc87c6397e0",
        "extra.averageAccuracy": 0,
        "extra.correctCount": NumberInt("0"),
        "extra.items": [
            "A",
            "C",
            "B"
        ],
        "extra.receiveQuestionTime": NumberLong("1652413962895")
    },
    "operator": {
        "userName": "server",
        "userUuid": "server",
        "role": "server"
    }
    ```

-   学生提交答案后，该学生的答题数据发生变化：

    ```json
    "action": NumberInt("1"),
    "widgetUuid": "xxxxxxxxx",
    "changeProperties": {
        "selectedItems": [
            "A",
            "B",
            "D"
        ],
        "isCorrect": true,
        "popupQuizId": "ab5b183238a74d5a9c955dc87c6397e0",
        "lastCommitTime": NumberLong("1652413989997")
    },
    "fromUser": {
        "userName": "yerongzhe2",
        "userUuid": "yerongzhe22",
        "role": "audience"
    }
    ```

-   老师结束答题后，答题器的汇总数据发生变化：

    ```json
    "action": NumberInt("1"),
    "widgetUuid": "xxxxxxxxx",
    "changeProperties": {
        "extra.totalCount": NumberInt("1"),
        "extra.answerState": NumberInt("0"),
        "extra.selectedCount": NumberInt("1"),
        "extra.averageAccuracy": 1,
        "extra.correctCount": NumberInt("1")
    },
    "operator": {
        "userName": "server",
        "userUuid": "server",
        "role": "server"
    }
    ```

## 获取投票器事件

#### 接口原型

-   方法：GET
-   请求路径：/{region}/edu/apps/{appId}/v2/rooms/{roomUuid}/widgets/poll/sequences

#### 请求参数

**URL 参数**

在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                         |
| :--------- | :----- | :----------------------------------------------------------- |
| `region`      | String | （必填）区域。可设为：<ul><li>`cn`: 中国大陆</li><li>`ap`: 亚太</li><li>`eu`: 欧洲</li><li>`na`: 北美</li></ul>                                       |
| `appId`    | String | （必填）Agora App ID。                                       |
| `roomUUid` | String | （必填）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。~d6d26ba0-cf5b-11eb-9521-2d3265d0c546~ |

**Query 参数**

| 参数     | 类型    | 描述                                                         |
| :------- | :------ | :----------------------------------------------------------- |
| `nextId` | String  | （非必填）下一批数据的起始 ID。第一次获取可传 null，后续获取传入响应结果里得到的 `nextId`。 |
| `count`  | Integer | （非必填）本批数据条数，默认值为 100。                       |

#### 响应参数

不同情况下 `data` 中返回的字段不同，具体如下：

-   老师开启投票后，投票器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                          | 类型                | 说明                                                         |
    | :-------------------------------------------- | :------------------ | :----------------------------------------------------------- |
    | action                                        | Integer             | 操作类型                                                     |
    | widgetUuid                                    | String              | Widget ID                                                    |
    | changeProperties                              | Object              | 发生变更的属性                                               |
    | changeProperties.extra                        | Object              | 属性补充信息                                                 |
    | changeProperties.extra.mode                   | Integer             | 投票模式：<ul><li>`1`: 单选</li><li>`2`: 多选</li></ul>      |
    | changeProperties.extra.pollingState           | Integer             | 本次投票状态：<ul><li>`1` : 投票进行中</li><li>`0`: 投票结束</li></ul> |
    | changeProperties.extra.pollDetails            | Map<String，Object> | 投票详情，`key` 为选项索引，从 `0` 开始。                    |
    | changeProperties.extra.pollDetails.num        | Integer             | 选择该选项的人数                                             |
    | changeProperties.extra.pollDetails.percentage | Float               | 选择该选项的人数所占百分比                                   |
    | changeProperties.extra.pollId                 | String              | 本次投票 ID                                                  |
    | changeProperties.extra.pollItems              | Object[]            | 选项内容                                                     |
    | changeProperties.state                        | Integer             | 投票器状态：<ul><li>`0`: 非活跃</li><li>`1`: 活跃</li></ul>  |
    | cause                                         | Object              | 属性变更原由。                                               |
    | cause.pollId                                  | String              | 投票器 ID。                                                  |
    | cause.action                                  | Integer             | 操作类型：<ul><li>`1`: 老师开始投票。</li><li>`2`: 老师结束投票。</li><li>`3`: 学生提交投票。</li><li>`4`: 汇总信息同步。</li></ul> |
    | operator                                      | Object              | 操作人                                                       |
    | operator.userUuid                             | String              | 用户 ID                                                      |
    | operator.userName                             | String              | 用户名称                                                     |
    | operator.role                                 | String              | 用户角色                                                     |

-   学生提交选项后，该学生的投票数据会发生变化，`data` 中包含以下字段：

    | 字段                               | 类型     | 说明                                                         |
    | :--------------------------------- | :------- | :----------------------------------------------------------- |
    | action                             | Integer  | 操作类型                                                     |
    | widgetUuid                         | String   | Widget ID                                                    |
    | changeProperties                   | Object   | 发生变更的属性                                               |
    | changeProperties.extra             | Object   | 属性补充信息                                                 |
    | changeProperties.extra.pollId      | String   | 本次投票 ID                                                  |
    | changeProperties.extra.selectIndex | Object[] | 该学生选择的选项的索引                                       |
    | cause                              | Object   | 属性变更原由。                                               |
    | cause.pollId                       | String   | 投票器 ID。                                                  |
    | cause.action                       | Integer  | 操作类型：<ul><li>`1`: 老师开始投票。</li><li>`2`: 老师结束投票。</li><li>`3`: 学生提交投票。</li><li>`4`: 汇总信息同步。</li></ul> |
    | operator                           | Object   | 操作人                                                       |
    | operator.userUuid                  | String   | 用户 ID                                                      |
    | operator.userName                  | String   | 用户名称                                                     |
    | operator.role                      | String   | 用户角色                                                     |
    | fromUser                           | Object   | 发起本次投票的用户                                           |
    | fromUser.userUuid                  | String   | 用户 ID                                                      |
    | fromUser.userName                  | String   | 用户名称                                                     |
    | fromUser.role                      | String   | 用户角色                                                     |

-   学生提交选项后，投票器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                          | 类型                | 说明                                                         |
    | :-------------------------------------------- | :------------------ | :----------------------------------------------------------- |
    | action                                        | Integer             | 操作类型                                                     |
    | widgetUuid                                    | String              | Widget ID                                                    |
    | changeProperties                              | Object              | 发生变更的属性                                               |
    | changeProperties.extra                        | Object              | 属性补充信息                                                 |
    | changeProperties.extra.pollDetails            | Map<String，Object> | 投票详情，`key` 为选项索引，从 `0` 开始。                    |
    | changeProperties.extra.pollDetails.num        | Integer             | 选择该选项的人数                                             |
    | changeProperties.extra.pollDetails.percentage | Float               | 选择该选项的人数所占百分比                                   |
    | changeProperties.extra.pollId                 | String              | 本次投票 ID                                                  |
    | cause                                         | Object              | 属性变更原由。                                               |
    | cause.pollId                                  | String              | 投票器 ID。                                                  |
    | cause.action                                  | Integer             | 操作类型：<ul><li>`1`: 老师开始投票。</li><li>`2`: 老师结束投票。</li><li>`3`: 学生提交投票。</li><li>`4`: 汇总信息同步。</li></ul> |
    | operator                                      | Object              | 操作人                                                       |
    | operator.userUuid                             | String              | 用户 ID                                                      |
    | operator.userName                             | String              | 用户名称                                                     |
    | operator.role                                 | String              | 用户角色                                                     |

-   老师结束投票后，投票器的汇总数据会发生变化，`data` 中包含以下字段：

    | 字段                                          | 类型                | 说明                                                         |
    | :-------------------------------------------- | :------------------ | :----------------------------------------------------------- |
    | action                                        | Integer             | 操作类型                                                     |
    | widgetUuid                                    | String              | Widget ID                                                    |
    | changeProperties                              | Object              | 发生变更的属性                                               |
    | changeProperties.extra                        | Object              | 属性补充信息                                                 |
    | changeProperties.extra.pollingState           | Integer             | 本次投票状态：<ul><li>`1` : 投票进行中</li><li>`0`: 投票结束</li></ul> |
    | changeProperties.extra.pollDetails            | Map<String，Object> | 投票详情，`key` 为选项索引，从 `0` 开始。                    |
    | changeProperties.extra.pollDetails.num        | Integer             | 选择该选项的人数                                             |
    | changeProperties.extra.pollDetails.percentage | Float               | 选择该选项的人数所占百分比                                   |
    | changeProperties.extra.pollId                 | String              | 本次投票 ID                                                  |
    | cause                                         | Object              | 属性变更原由。                                               |
    | cause.pollId                                  | String              | 投票器 ID。                                                  |
    | cause.action                                  | Integer             | 操作类型：<ul><li>`1`: 老师开始投票。</li><li>`2`: 老师结束投票。</li><li>`3`: 学生提交投票。</li><li>`4`: 汇总信息同步。</li></ul> |
    | operator                                      | Object              | 操作人                                                       |
    | operator.userUuid                             | String              | 用户 ID                                                      |
    | operator.userName                             | String              | 用户名称                                                     |
    | operator.role                                 | String              | 用户角色                                                     |

#### 响应示例

-   老师开启投票后，投票器的汇总数据发生变化：

    ```json
    "action": NumberInt("1"),
    "widgetUuid": "xxxxxxxxx",
    "changeProperties": {
        "extra.pollId": "e556ce3df5cd4c23941b03bf54d29ba3",
        "extra.pollState": NumberInt("1"),
        "extra.pollItems": [
            "aaa",
            "bbb",
            "ccc",
            "ddd",
            "eee"
        ],
        "extra.mode": NumberInt("2"),
        "state": NumberInt("1"),
        "extra.pollDetails": {
            "0": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "1": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "2": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "3": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "4": {
                "num": NumberInt("0"),
                "percentage": 0
            }
        }
    },
    "operator": {
        "userName": "server",
        "userUuid": "server",
        "role": "server"
    }
    ```

-   学生提交选项后，该学生的投票数据发生变化：

    ```json
    "action": NumberInt("1"),
    "widgetUuid": "xxxxxxxxx",
    "changeProperties": {
        "pollId": "e556ce3df5cd4c23941b03bf54d29ba3",
        "selectIndex": [
            NumberInt("1"),
            NumberInt("2"),
            NumberInt("4")
        ]
    },
    "fromUser": {
        "userName": "yerongzhe2",
        "userUuid": "yerongzhe22",
        "role": "audience"
    },
    "operator": {
        "userName": "server",
        "userUuid": "server",
        "role": "server"
    }
    ```

-   学生提交选项后，投票器的汇总数据发生变化：

    ```json
    "action": NumberInt("1"),
    "widgetUuid": "xxxxxxxxx",
    "changeProperties": {
        "extra.pollId": "e556ce3df5cd4c23941b03bf54d29ba3",
        "extra.pollDetails": {
            "0": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "1": {
                "num": NumberInt("1"),
                "percentage": 1
            },
            "2": {
                "num": NumberInt("1"),
                "percentage": 1
            },
            "3": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "4": {
                "num": NumberInt("1"),
                "percentage": 1
            }
        }
    },
    "operator": {
        "userName": "server",
        "userUuid": "server",
        "role": "server"
    }
    ```

-   老师结束投票后，投票器的汇总数据会发生变化，`data` 中包含以下字段：

    ```json
    "action": NumberInt("1"),
    "widgetUuid": "xxxxxxxxx",
    "changeProperties": {
        "extra.pollId": "e556ce3df5cd4c23941b03bf54d29ba3",
        "extra.pollState": NumberInt("0"),
        "extra.pollDetails": {
            "0": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "1": {
                "num": NumberInt("1"),
                "percentage": 1
            },
            "2": {
                "num": NumberInt("1"),
                "percentage": 1
            },
            "3": {
                "num": NumberInt("0"),
                "percentage": 0
            },
            "4": {
                "num": NumberInt("1"),
                "percentage": 1
            }
        }
    },
    "operator": {
        "userName": "server",
        "userUuid": "server",
        "role": "server"
    }
    ```

## 响应状态码

| HTTP 响应状态码 | 业务状态码 | 描述                                                         |
| :-------------- | :--------- | :----------------------------------------------------------- |
| 200             | 0          | 请求成功。                                                   |
| 400             | 400        | 请求的参数错误。                                             |
| 401             | N/A        | 可能的原因：<li>App ID 无效。</li><li>Token Authorization 中 `x-agora-uid` 和 `x-agora-token` 错误或不匹配。</li> |
| 403             | 30403200   | 课堂已禁言，无法发送聊天消息。                               |
| 404             | N/A        | 服务器无法找到请求的资源。                                   |
| 404             | 20404100   | 课堂不存在。                                                 |
| 404             | 20404200   | 用户不存在。                                                 |
| 409             | 30409410   | 录制状态冲突，录制未开始。                                   |
| 409             | 30409411   | 录制状态冲突，录制未结束。                                   |
| 409             | 30409100   | 课程状态冲突，课程已开始。                                   |
| 409             | 30409101   | 课程状态冲突，课程已结束。                                   |
| 500             | 500        | 服务器内部错误，无法完成请求。                               |
| 503             | N/A        | 服务器内部错误。充当网关或代理的服务器未从远端服务器获取响应。 |
