---
title: 灵动课堂云服务 RESTful API
platform: All Platforms
updatedAt: 2021-03-22 03:50:35
---
本文介绍灵动课堂云服务 RESTful API 的详细信息。

<div class="alert info">查看灵动课堂云服务的<a href="./agora_class_restful_api_release">更新历史</a>。</div>

## 基本信息

### 域名

所有请求都发送给域名：api.agora.io。

### 数据格式

所有请求的 Content-Type 类型为 application/json。

### 认证方式

灵动课堂云服务 RESTful API 支持 Token 认证。你需要在发送 HTTP 请求时在 HTTP 请求头部的 `x-agora-token` 字段和 `x-agora-uid` 字段分别填入：

- 服务端生成的 RTM Token。
- 生成 RTM Token 时使用的 uid。

具体生成 RTM Token 的方法请参考[生成 RTM Token](https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms) 文档。

## 设置课堂状态

### 接口描述

设置课堂状态（未开始/开始/结束）。课堂状态说明详见[课堂状态管理文档](./class_state)。

### 接口原型

- 方法：PUT
- 接入点：/edu/apps/{appId}/v2/rooms/{roomUUid}/states/{state}

### 请求参数

**URL 参数**

需要在 URL 中传入以下参数。

| 参数       | 类型    | 描述                                                         |
| :--------- | :------ | :----------------------------------------------------------- |
| `appId`    | string  |（必需）Agora App ID，详见[获取 Agora App ID](./agora_class_prep#step1)。                 |
| `roomUUid` | string  |（必需）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `state`    | integer | （必需）课堂状态：<li>`0`: 未开始<li>`1`: 开始<li>`2`: 结束                      |

### 请求示例

```
// 设置 test_class 的课堂状态为开始
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/states/1
```

### 响应参数

| 参数   | 类型    | 描述                                         |
| :----- | :------ | :------------------------------------------- |
| `code` | integer | 业务状态码：<li>0: 请求成功。<li>非 0: 请求失败。    |
| `msg`  | string  | 详细信息。                                   |
| `ts`   | number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。 |

### 响应示例

```
"status": 200,
"body":
{
  "code": 0,
  "msg": "Success",
  "ts": 1610450153520
}
```

## 设置录制状态

### 接口描述

开始或结束录制指定课堂。

### 接口原型

- 方法：PUT
- 接入点：/edu/apps/{appId}/v2/rooms/{roomUUid}/records/states/{state}

### 请求参数

**URL 参数**

需要在 URL 中传入以下参数。

| 参数       | 类型    | 描述                                                         |
| :--------- | :------ | :----------------------------------------------------------- |
| `appId`    | string  |（必需）Agora App ID，详见[获取 Agora App ID](./agora_class_prep#step1)。 |
| `roomUUid` | string  | （必需）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |
| `state`    | integer | （必需）录制状态：<li>`1`: 开始<li>`2`: 结束                                 |

### 请求示例

```
// 开始录制 test_class
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records/states/1
```

### 响应参数

| 参数   | 类型    | 描述                                         |
| :----- | :------ | :------------------------------------------- |
| `code` | integer | 业务状态码：<li>0: 请求成功。<li>非 0: 请求失败。    |
| `msg`  | string  | 详细信息。                                   |
| `ts`   | number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。 |

### 响应示例

```
"status": 200,
"body":
{
  "code": 0,
  "ts": 1610450153520
}
```

## 获取录制列表

### 接口描述

获取指定课堂内的录制列表。

你可以通过 `nextId` 分页拉取，每次最多拉取 100 条数据。

### 接口原型

- 方法：GET
- 接入点：/edu/apps/{appId}/v2/rooms/{roomUuid}/records

### 请求参数

**URL 参数**

需要在 URL 中传入以下参数。

| 参数       | 类型   | 描述                                                         |
| :--------- | :----- | :----------------------------------------------------------- |
| `appId`    | string | （必需）Agora App ID，详见[获取 Agora App ID](./agora_class_prep#step1)。 |
| `roomUUid` | string | （必需）课堂 uuid。这是课堂的唯一标识符，也是加入 RTC 和 RTM 的频道名。长度在 64 字节以内。以下为支持的字符集范围（共 89 个字符）:<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 <li>0-9<li>空格<li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", "," |

**Query 参数**

| 参数     | 类型   | 描述                                                         |
| :------- | :----- | :----------------------------------------------------------- |
| `nextId` | string | （非必需）下一批数据的起始 ID。第一次获取可传 null，后续获取传入响应结果里得到的 `nextId`。 |

### 请求示例

```
// 获取 test_class 里的录制列表
https://api.agora.io/edu/apps/{yourappId}/v2/rooms/test_class/records?nextId=xxx
```

### 响应参数

| 参数   | 类型    | 描述                                                         |
| :----- | :------ | :----------------------------------------------------------- |
| `code` | integer | 业务状态码：<li>0: 请求成功。<li>非 0: 请求失败。                    |
| `msg`  | string  | 详细信息。                                                   |
| `ts`   | number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                 |
| `data` | object  | 具体数据，包含：<ul><li>`count`: Integer 型，本批数据条数。</li><li>`list`: 由多个 object 组成的数组。每个 object 包含以下字段：<ul><li>`appId`: 你的 Agora App ID。 </li><li>`roomUuid`: 课堂 uuid。这是课堂的唯一标识符，也是 Agora RTC SDK 和 Agora RTM SDK 中使用的频道名。 </li><li>`recordId`: 一次录制的的唯一标识符。调用设置录制状态 API 开始录制然后结束录制视为一次录制。</li><li>`startTime`: 录制开始的 UTC 时间戳，单位为毫秒。 </li><li>`endTime`: 录制结束的 UTC 时间戳，单位为毫秒。 </li><li>`resourceId`: Agora 云端录制服务的 `resourceId`。 </li><li>`sid`: Agora 云端录制服务的 `sid`。 </li><li>`recordUid`: Agora 云端录制服务在频道内使用的 UID。 </li><li>`boardAppId`: Netless 白板服务的 AppIdentifier。 </li><li>`boardToken`: Netless 白板服务的 sdkToken。 </li><li>`boardId`: 白板的唯一标识符。 </li><li>`type`: Integer 类型，录制类型：<ul><li>`1`: 单流录制</li><li>`2`: 合流录制</li></ul><li>`status`: Integer 类型，录制状态：<ul><li>`1`: 录制中</li><li>`2`: 录制已结束</li></ul><li>`url`: String 类型，录制文件的访问地址。 </li></ul><li>`nextId`: String 型，下一批数据的起始 ID。如为 null，则表示没有下一批数据。如不为 null，则可用此 `nextId` 继续查询，直到查到 null 为止。</li><li>`total`: Integer 型，数据总条数。</li></ul> |

### 响应示例

```
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
## 获取课堂事件

### 接口描述

在服务端获取指定 App ID 下所有课堂中发生的事件。

你可定时轮询该接口来监听灵动课堂中发生的事件。每个事件只能获取一次。

**注意事项**：最早可查一小时内未销毁的课堂里的事件。

### 接口原型

- 方法：GET
- 接入点：/edu/polling/apps/{appId}/v2/rooms/sequences

### 请求参数

**URL 参数**

需要在 URL 中传入以下参数。

| 参数    | 类型   | 描述                                                         |
| :------ | :----- | :----------------------------------------------------------- |
| `appId` | string  | （必需）Agora App ID，详见[获取 Agora App ID](./agora_class_prep#step1)。 |

### 请求示例

```
https://api.agora.io/edu/polling/apps/{yourappId}/v2/rooms/sequences
```

### 响应参数

| 参数   | 类型    | 描述                                                         |
| :----- | :------ | :----------------------------------------------------------- |
| `code` | integer | 业务状态码：<li>0: 请求成功。<li>非 0: 请求失败。                    |
| `msg`  | string  | 详细信息。                                                   |
| `ts`   | number  | 当前服务端的 Unix 时间戳（毫秒），UTC 时间。                 |
| `data` | object  | 具体数据，包含：<li>`roomUuid`: String 型，课堂 uuid。<li>`cmd`: Integer 型，事件类型。详见[事件枚举](./agora_class_restful_api_event)。<li>`sequence`: Integer 型。事件序号，是每个课堂内事件的唯一标识符，课堂内全局自增，用于确保事件的有序性。<li>`version`: Integer 型，版本号。<li>`data`: Object 型，事件的具体数据，取决于事件类型。详见[事件枚举](./agora_class_restful_api_event)。 |
	
### 响应示例

```
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

## 响应状态码

| HTTP 响应状态码 | 业务状态码 | 描述                                                         |
| :-------------- | :--------- | :----------------------------------------------------------- |
| 200             | 0          | 请求成功。                                                     |
| 400             | 400        | 请求的参数错误。                                               |
| 401             | N/A        | 可能的原因：<li>App ID 无效。<li>Token Authorization 中 `x-agora-uid` 和 `x-agora-token` 错误或不匹配。 |
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