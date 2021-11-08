Agora 消息通知服务器以 HTTPS POST 请求方法向你的服务器发送融合 CDN 直播的消息通知回调。数据格式为 JSON，字符编码为 UTF-8，签名算法为 HMAC/SHA1 或 HMAC/SHA256。

## 请求的 Header

消息通知回调的 `header` 中包含以下字段：

| 字段名               | 值                                                           |
| :------------------- | :----------------------------------------------------------- |
| `Content-Type`       | `application/json;charset=utf-8`                                           |
| `Agora-Signature`    | Agora 用密钥（**secret**）和 HMAC/SHA1 算法生成的签名值。你需要使用密钥（**secret**）和 HMAC/SHA1 算法来验证该签名值。详见[验证签名](signature_verify?platform=RESTful)。 |
| `Agora-Signature-V2` | Agora 用密钥（**secret**）和 HMAC/SHA256 算法生成的签名值。你需要使用密钥（**secret**）和 HMAC/SHA256 算法来验证该签名值。详见[验证签名](signature_verify?platform=RESTful)。 |

## 请求的 Body

消息通知回调的请求包体包含以下字段：

| 字段        | 类型        | 描述                                                         |
| :---------- | :---------- | :----------------------------------------------------------- |
| `noticeId`  | String      | 通知 ID，标识来自 Agora 业务服务器的一次事件通知。           |
| `productId` | Integer      | 业务 ID。值为 7 表示融合 CDN 直播业务。                      |
| `eventType` | Integer      | 通知的事件类型。详见[融合 CDN 直播事件类型](#event-type)。   |
| `notifyMs`  | Integer      | Agora 消息服务器向你的服务器发送事件通知的 Unix 时间戳 (ms)。通知**重试**时该值会更新。 |
| `payload`   | JSON Object | 通知事件的具体内容。`payload` 因 `eventType` 而异，详见[融合 CDN 直播事件类型](#event-type)。 |

消息通知回调的请求包体示例：

```json
{
    "noticeId": "2000001428:4330:107",
    "productId": 7,
    "eventType": 0,
    "notifyMs": 1611566412672,
    "payload": {...}
}
```

<a name="event-type"></a>

## 融合 CDN 直播事件类型

Agora 消息通知服务可以通知融合 CDN 直播业务中的以下事件类型：

| eventType | event_name              | 事件描述           |
| :-------- | :---------------------- | :----------------- |
| [1](#1)   | `publish_start`         | 推流开始。         |
| [2](#2)   | `publish_end`           | 推流结束。         |
| [3](#3)   | `new_custom_record_file`       | 生成录制文件。     |
| [4](#4)   | `new_custom_snapshot_file`     | 生成截图文件。     |
| [5](#5)   | `new_custom_moderation_result` | 内容审核结果通知。 |

<a name="1"></a>

### 1 publish_start

`eventType` 为 1 表示推流开始，`payload` 中包含以下字段：

| 字段         | 数据类型 | 含义                      |
| :----------- | :------- | :------------------------ |
| `eventName`  | String   | 事件名称，publish_start。 |
| `domain`     | String   | 推流域名。                |
| `entryPoint` | String   | 发布点名称。              |
| `streamName` | String   | 直播流名称。              |
| `clientIp`   | String   | 推流客户端 IP。           |
| `nodeIp`     | String   | 节点服务器 IP。           |

`payload` 示例：

```json
{
   "eventName": "publish_start",
   "domain": "test.agora.io",
   "entryPoint": "live",
   "streamName": "test_stream",
   "clientIp": "253.199.199.199",
   "nodeIp": "253.199.199.199"
}
```

<a name="2"></a>

### 2 publish_end

`eventType` 为 2 表示推流结束，`payload` 中包含以下字段：

| 字段         | 数据类型 | 含义                    |
| :----------- | :------- | :---------------------- |
| `eventName`  | String   | 事件名称，publish_end。 |
| `domain`     | String   | 推流域名。              |
| `entryPoint` | String   | 发布点名称。            |
| `streamName` | String   | 直播流名称。            |
| `clientIp`   | String   | 推流客户端 IP。         |
| `nodeIp`     | String   | 节点服务器 IP。         |

`payload` 示例：

```json
{
   "eventName": "publish_end",
   "domain": "test.agora.io",
   "entryPoint": "live",
   "streamName": "test_stream",
   "clientIp": "253.199.199.199",
   "nodeIp": "253.199.199.199"
}
```

<a name="3"></a>

### 3 new_custom_record_file

`eventType` 为 3 表示录制文件已生成，`payload` 中包含以下字段：

| 字段         | 数据类型 | 含义                                          |
| :----------- | :------- | :-------------------------------------------- |
| `eventName`  | String   | 事件名称，new_custom_record_file。                   |
| `entryPoint` | String   | 发布点名称。                                  |
| `streamName` | String   | 直播流名称。                                  |
| `startTime`  | Int64    | 该文件的录制开始时间，Unix 时间戳，单位为秒。 |
| `endTime`    | Int64    | 该文件的录制结束时间，Unix 时间戳，单位为秒。 |
| `duration`   | Integer  | 录制时长，单位为秒。                          |
| `fileSize`   | Integer  | 录制文件大小，单位为 byte。                   |
| `fileName`   | String   | 录制文件名。                                  |

`payload` 示例：

```json
{
   "eventName": "new_custom_record_file",
   "entryPoint": "live",
   "streamName": "test_stream",
   "startTime": 1627886487,
   "endTime": 1627888487,
   "duration": 100,
   "fileSize": 1024,
   "fileName": ""
}
```

<a name="4"></a>

### 4 new_custom_snapshot_file

`eventType` 为 4 表示截图文件已生成，`payload` 中包含以下字段：

| 字段         | 数据类型 | 含义                          |
| :----------- | :------- | :---------------------------- |
| `eventName`  | String   | 事件名称，new_custom_snapshot_file。 |
| `entryPoint` | String   | 发布点名称。                  |
| `streamName` | String   | 直播流名称。                  |
| `fileName`   | String   | 截图文件名。                  |

`payload` 示例：

```json
{
   "eventName": "new_custom_snapshot_file",
   "entryPoint": "live",
   "streamName": "test_stream",
   "fileName": "test_filename",
}
```

<a name="5"></a>

### 5 new_custom_moderation_result

`eventType` 为 5 表示图片审核结果通知，`payload` 中包含以下字段：

| 字段         | 数据类型 | 含义                                                         |
| :----------- | :------- | :----------------------------------------------------------- |
| `eventName`  | String   | 事件名称，new_custom_moderation_result。                       |
| `entryPoint` | String   | 发布点名称。                                                 |
| `streamName` | String   | 直播流名称。                                                 |
| `fileName`   | String   | 截图文件名。                                                 |
| `results`    | JSON     | 此次审核的结果，包含以下字段：<br/> `porn`：JSON 类型。审核结果，包含以下字段：<ul><li>`outputs`：JSON 类型。该图片为正常、色情或性感图片的可能性。  <ul><li>`neutral`：Float 类型。该图片为正常图片的可能性。正常指图片中无不良内容，可能存在正常且适度的肢体裸露和身体曲线。</li><li> `porn`：Float 类型。该图片为色情图片的可能性。色情指图片包含生殖器官的裸露、性行为与性暗示、性征的过分强调等。</li><li> `sexy`：Float 类型，该图片为性感图片的可能性。性感指图片包含较大尺度的裸露或男女性征的轻微轮廓，但无生殖器官的裸露。</li></ul></li><li>`scene`：String 类型，审核结果。该审核结果为 RTC 视频智能审核基于 `outputs` 中的三个浮点数值对图片属性进行的判定。`scene` 可返回以下值： <ul><li>`"neutral"`：正常。</li><li>`"porn"`：色情。</li><li>`"sexy"`：性感。</li></ul></li></ul> |
| `suggestion` | String   | 图片处理意见。<li>`"pass"`：正常图片，不做处理。</li><li>`"block"`：色情图片，鉴黄不通过。</li><li>`"review"`：性感图片。可以根据自己的业务场景，直接将图片认定为正常，不做处理，或进行人工复审。例如，对性感容忍度较高的社交类应用，可以认定图片为正常；而对性感容忍度较低的教育类应用，可以对图片进行人工复审。</li> |

`payload` 示例：

```json
{
    "eventName": "new_custom_moderation_result",
    "entryPoint": "live",
    "streamName": "test_stream",
    "results": {
        "porn": {
            "outputs": {
                "sexy": 0.00188077823,
                "neutral": 0.915607393,
                "porn": 0.082511887
            },
            "scene": "neutral"
        }
    },
    "fileName": "test_file_name",
    "suggestion": "pass"
}
```
