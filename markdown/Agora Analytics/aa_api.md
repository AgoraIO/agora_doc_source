---
title: 水晶球 RESTful API (Beta)
platform: All Platforms
updatedAt: 2021-03-11 08:31:23
---
水晶球现在提供 RESTful API，可以让你直接通过网络请求获取水晶球里的数据，在自己的网页或应用中灵活使用。
THis is a random test

在阅读本文之前，我们推荐你先在 [Dashboard](https://dashboard.agora.io) 中试用水晶球的界面，以便对各项参数和数据指标有更直观的了解，详情可参考[水晶球](./aa_guide)。

通过 RESTful API，你可以发送请求获取以下数据：

- 通话调查
  - 符合指定条件的通话及基本信息
  - 某个通话的详细质量指标
- 数据洞察
  - 指定时间段的用量指标

当通话质量出现问题时，你还可以发送请求向 Agora 反馈。

> 水晶球 RESTful API 目前处于 BETA 阶段，不对外开放。如需开通服务，请联系 sales@agora.io。

## 认证

发送请求时，你需要提供 `api_key:api_secret` 通过 Basic HTTP 认证并填入 HTTP 请求头部的 Authorization 字段：

- `api_key`: Customer ID
- `api_secret`: Customer Certificate

你可以在 Dashboard 的 [RESTful API](https://dashboard.agora.io/restful) 页面找到你的 Customer ID 和 Customer Certificate。具体生成 `Authorization` 字段的方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。

## 数据格式

所有的请求都发送给域名：`api.agora.io`。

- 请求：请求直接在 URL 中使用查询字符串参数（query String）
- 响应：响应内容的格式为 JSON

## <a name="limit"></a>API 限制

水晶球 RESTful API 有以下限制：

| 接入点                       | 请求次数                | 数据延迟 | 响应内容                | 可查询时间范围 |
| ---------------------------- | ----------------------- | -------- | ----------------------- | -------------- |
| /beta/analytics/call/lists   | 每秒 3 次，每天 1000 次 | 20 秒    | 最多返回 10 个通话      | 最近 3 天      |
| /beta/analytics/call/details | 每秒 1 次，每天 1000 次 | 150 秒   | 最多返回 3 小时通话数据 | 最近 3 天      |
| /beta/insight/usage/by_time  | 每分钟 1 次，每天 10 次 | 24 小时  | 最近 7 天               |                |
|                              |                         |          |                         |                |

> 数据延迟是指从一个通话开始到能获取该通话的数据需要的时间。

## 通话调查

通话调查可以搜索出现质量问题的通话并且查询具体的质量指标。

### 获取通话列表

获取符合指定条件的通话及其基本信息。

- 方法：GET
- 接入点：/beta/analytics/call/lists

> 关于该接入点的限制详见 [API 限制](#limit)。

#### 参数

该 API 需要在 URL 中传入以下参数指定搜索通话的条件。

| 参数       | 类型   | 描述                                                         |
| ---------- | ------ | ------------------------------------------------------------ |
| `start_ts` | Number | 搜索的时间范围起点。Unix 时间戳 （秒）。                     |
| `end_ts`   | Number | 搜索的时间范围终点。Unix 时间戳（秒）。                      |
| `cname`    | String | （可选）频道名称。                                           |
| `appid`    | String | 你的项目使用的 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id)。 |

#### HTTP 请求示例

```http
GET /beta/analytics/call/lists?start_ts=1550024508&end_ts=1550025508&appid=xxxxxxxxxxxxxxxxxxxx HTTP/1.1
Host: api.agora.io
Accept: application/json
Authorization: Basic ZGJhZDMyNmFkMzQ0NDk2NGEzYzAwNjZiZmYwNTZmNjo2ZjIyMmZhMTkzNWE0MWQzYTczNzg2ODdiMmNiYjRh
```

#### 响应示例

```json
{
"code": 200,
"message": "",
"has_more": false,
"call_lists": 
[
  {
  "call_id": "cxxxxxxxxxxxxxxxxxxxx",
  "cname":   "cname1",
  "created_ts": 1547448383,
  "destroyed_ts": 1547448483,
  "finished": true
  }
]
}
```

- `code`: Number 类型，响应状态码。200 表示请求成功，详见[状态码](#code)。
- `message`: String 类型，错误消息。
- `has_more`: Boolean 类型，是否还有更多通话未列出。如果为 `true`，表示还有更多符合查询条件的通话没有在 `call_lists` 中列出。如果你要查找的通话未列出，请修改查询条件重新发送请求。
- `call_lists`: Array 类型,，返回的通话。默认返回最近的 10 个通话，按通话开始时间降序排列。每个通话中包含以下信息：
  - `call_id`: String 类型，通话的唯一标识。
  - `cname`: String 类型，频道名称。
  - `created_ts`: Number 类型，通话开始的时间。Unix 时间戳（秒）。
  - `destroyed_ts`: Number类型，通话结束的时间。Unix 时间戳（秒）。
  - `finished`: Boolean 类型，通话是否已结束。

### 获取通话指标

获取某个特定通话的具体质量指标数据。

- 方法：GET
- 接入点：/beta/analytics/call/details

> 关于该接入点的限制详见 [API 限制](#limit)。

#### 参数

该 API 需要在 URL 中传入以下参数指定要查看的通话。

| 参数                  | 类型    | 描述                                                         |
| --------------------- | ------- | ------------------------------------------------------------ |
| `start_ts`            | Number  | 通话开始的时间。Unix 时间戳（秒）。                          |
| `end_ts`              | Number  | 通话结束的时间。Unix 时间戳（秒）。                          |
| `appid`               | String  | 你的项目使用的 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id)。 |
| `call_id`             | String  | 通话的唯一标识。                                             |
| `exclude_server_user` | Boolean | （可选）是否排除 Linux 用户，默认为 `true` 。                |

#### HTTP 请求示例

```http
GET /beta/analytics/call/details?start_ts=1548665345&end_ts=1548670821&appid=axxxxxxxxxxxxxxxxxxxx&call_id=cxxxxxxxxxxxxxxxxxxxx HTTP/1.1
Host: api.agora.io
Accept: application/json
Authorization: Basic ZGJhZDMyNmFkMzQ0NDk2NGEzYzAwNjZiZmYwNTZmNjo2ZjIyMmZhMTkzNWE0MWQzYTczNzg2ODdiMmNiYjRh
```

#### 响应示例

```json
{
    "code": 200,
    "message": "",
    "call_id": "00057b6093a5d3e8b1fc67aa",
    "call_info": [
        {
            "sid": "EDB224CCF4FB4F99815C24302BDF3301",
            "cname": "15056678066620",
            "uid": 630985881,
            "network": "Wi-Fi",
            "platform": "Android",
            "speaker": true,
            "sdk_version": "2.2.0.07_14",
            "device_type": "Android (6.0)",
            "join_ts": 1548670251,
            "leave_ts": 1548670815,
            "finished": true
        },
		......
		],
    "metrics": [
        {
            "sid": "EDB224CCF4FB4F99815C24302BDF3301",
            "data": [
                {
                    "mid": 20003,
                    "kvs": [
                        [
                            1548670255,
                            215
                        ],
                        [
                            1548670257,
                            129
                        ],
                        [
                            1548670259,
                            121
                        ],
						......
					],
					"peer_uid": 0,
				},
				......
			]
		},
......
]
}
```

- `code`: Number 类型，响应状态码。200 表示请求成功，详见[状态码](#code)。
- `message`: String 类型，错误消息。
- `call_id`: String 类型，通话的唯一标识。
- `call_info`: Array 类型，包含通话中各个用户的信息。最多返回 10 个用户，按照用户加入频道的时间降序排列。每个用户包含以下信息 ：
  - `sid`: String 类型，用户通话的唯一标识。
  - `cname`: String 类型，频道名称。
  - `uid`: Number 类型，用户 ID。
  - `network`: String 类型，网络类型。
  - `platform`: String 类型，平台信息。
  - `speaker`: Boolean 类型，用户在通话中是否发送音视频。
  - `sdk_version`: String 类型，SDK 版本信息。
  - `device_type`: String 类型，设备信息。
  - `join_ts`: Number 类型，用户加入频道的时间。Unix 时间戳（秒）。
  - `leave_ts`: Number 类型，用户离开频道的时间。Unix 时间戳（秒）。
  - `finished`: Boolean 类型，用户是否已离开频道。
- `metrics`: Array 类型，各个用户通话（`sid`）的具体指标数据。每个用户通话包含以下信息：
  - `sid`: String 类型，用户通话的唯一标识。
  - `data`: Array 类型，用户通话的质量指标数据。
    - `mid`: Number 类型，指标 ID，详见 [指标 ID 表](#mid)。
    - `peer_uid`: Number 类型，对端的用户 ID，如果为 0 表示该指标为本端数据。
    - `kvs`: 时间戳及相应时间的指标数值。

## 数据洞察

数据洞察可以查询阶段性的用量数据。

### 查询频道和用户数

获取指定时间段的通话人数、人次和频道数。

- 方法：GET
- 接入点：/beta/insight/usage/by_time

> 关于该接入点的限制详见 [API 限制](#limit)。

#### 参数

该 API 需要在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                         |
| ---------- | ------ | ------------------------------------------------------------ |
| `start_ts` | Number | 查询的时间范围起点，Unix 时间戳 （秒）。                     |
| `end_ts`   | Number | 查询的时间范围终点，Unix 时间戳 （秒）。                     |
| `appid`    | String | 你的项目使用的 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All Platforms#a-name-appid-a-app-id)。 |
| `metric`   | String | 要查询的指标，支持同时查询多个指标，用逗号分隔，如 `userCount,sessionCount`<li>userCount：通话人数，不同频道中的相同用户名计为多人。</li><li>sessionCount：通话人次，用户每次加入频道计为一个通话人次。</li><li>channelCount：频道数，从有用户加入频道到所有用户离开频道计为一个通话频道。</li> |

### HTTP 请求示例

```http
GET /beta/insight/usage/by_time?start_ts=1548665345&end_ts=1548670821&appid=axxxxxxxxxxxxxxxxxxxx&metric=userCount HTTP/1.1
Host: api.agora.io
Accept: application/json
Authorization: Basic ZGJhZDMyNmFkMzQ0NDk2NGEzYzAwNjZiZmYwNTZmNjo2ZjIyMmZhMTkzNWE0MWQzYTczNzg2ODdiMmNiYjRh
```

### 响应示例

```json
{
    "code": 200,
    "message": "success",
    "data": [
        {
            "userCount": 42,
            "ts": 1568619660
        },
        ......
    ]
}
```

- `code`: Number 类型，响应状态码。200 表示请求成功，详见[状态码](#code)。
- `message`: String 类型，错误消息。
- `data`: Array 类型，由指标数据值和日期时间戳组成的数组。查询的数据以天为单位计算，例如指定查询过去 7 天的通话人数，该数组会包含 7 组数据，每组数据值包含当天的时间戳和通话人数。
  - `ts`: Unix 时间戳 （秒）。
  - `userCount`: 请求的指标名称，通话人数。

## 报告问题

向 Agora 报告通话质量问题。

- 方法：POST
- 接入点：/beta/analytics/feedback/report

> 该方法每秒最多可调用 10 次。

### 参数

该 API 需要在 URL 中传入 appid 参数，你的项目使用的 [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-name-appid-a-app-id)。

该 API 需要在请求包体中传入以下参数。

| 参数          | 类型   | 描述                                                         |
| :------------ | :----- | :----------------------------------------------------------- |
| `cname`       | String | 频道名称。                                                   |
| `teacher_uid` | Number | 老师的 ID。                                                  |
| `action_uid`  | Number | （可选）操作者的 ID。                                        |
| `ts`          | Number | （可选）问题发生时间，UNIX 时间戳，单位为秒。                |
| `comments`    | String | （可选）备注。可以简单描述问题。                             |
| `type`        | Number | 问题类型：<li>1: 切课</li><li>2: 求助</li><li>3: 投诉</li><li>4: 问题反馈</li> |

### HTTP 请求示例

```http
POST /beta/analytics/feedback/report?appid=axxxxxxxxxxxxxxxxxxxx HTTP/1.1
Host: api.agora.io
Content-type: application/json
Authorization: Basic ZGJhZDMyNmFkMzQ0NDk2NGEzYzAwNjZiZmYwNTZmNjo2ZjIyMmZhMTkzNWE0MWQzYTczNzg2ODdiMmNiYjRh
Cache-Control: no-cache

{ 
	"cname":"android_video_engine_1561704454355",
	"teacher_uid":111,
	"comments":"bad network",
	"type":1,
	"action_uid":111
}
```

### 响应示例

```json
{
"code": 200,
"message": "",
}
```

- `code`: Number 类型，响应状态码。200 表示请求成功，详见[状态码](#code)。
- `message`: String 类型，错误消息。

## 参考

### <a name="code"></a>状态码

| 状态码 | 描述                   |
| ------ | ---------------------- |
| 200    | 请求处理成功           |
| 400    | 输入格式错误           |
| 401    | 未经授权               |
| 403    | 授权信息错误，禁止访问 |
| 404    | API 调用错误           |
| 500    | 服务器内部错误         |

### <a name="mid"></a>指标 ID 表

| `mid` | 描述                                     |
| ----- | ---------------------------------------- |
| 20001 | SDK 的 CPU 使用率                        |
| 20002 | 系统 CPU 使用率                          |
| 20003 | 音频发送码率，单位 Kbps                  |
| 20004 | 音频接收码率，单位 Kbps                  |
| 20005 | 音频渲染卡顿时间，单位 ms                |
| 20006 | 视频发送码率，单位 Kbps                  |
| 20007 | 视频采集帧率，单位 fps                   |
| 20008 | 视频发送帧率，单位 fps                   |
| 20009 | 视频接收码率，单位 Kbps                  |
| 20010 | 视频接收帧率，单位 fps                   |
| 20011 | 视频渲染卡顿时间，单位 ms                |
| 20013 | 视频的画面质量，该数值越低表示画面越清晰 |
| 20015 | 音频上行丢包率                           |
| 20016 | 音频端到端丢包率                         |
| 20017 | 视频上行丢包率                           |
| 20018 | 视频端到端丢包率                         |
| 20019 | 视频分辨率的宽                           |
| 20020 | 视频分辨率的高                           |