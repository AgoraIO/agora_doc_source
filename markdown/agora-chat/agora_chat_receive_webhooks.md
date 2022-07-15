# HTTP 回调事件

Agora 即时通讯支持 HTTP 回调（Webhook）。为你的即时通讯应用设置 HTTP 回调后，当指定事件发生时，Agora 即时通讯服务器会以 HTTP POST 请求的形式向你的应用服务器发送通知。其中正文为 JSON 格式的字符串，字符集为 UTF-8。

本文介绍 Agora 即时通讯支持的发送后回调事件。

## 用户登录登出事件

当即时通讯 app 中有用户登录登出时，Agora 服务端会向你的应用服务器发送回调事件，通知你当前的操作。

### 用户登录

当本地有用户登录时，Agora 即时通讯服务会向你的应用服务器发送回调事件，示例如下：

```json
{
    "callId":"XXXX#XXXXe393c568-5ae5-4a0e-8a2c-008b52b49eed",
    "reason":"login",
    "security":"XXXXae2eXXXXced298883a0cf06d41b9",
    "os":"ios",
    "ip":"************",
    "host":"*******",
    "appkey":"XXXX#XXXX",
    "user":"XXXX#XXXXtstXXXX/ios_XXXX01fd-b5a4-84d5-ebeb-bf10XXXX0442",
    "version":"3.8.9.1",
    "timestamp":1642585154644,
    "status":"online"
}
```

| 字段 | 数据类型 | 描述 |
| --- | --- | --- |
| `callId` | String | 回调 ID，是每条 HTTP 回调的唯一标识。该字段由 `{appKey}_{uuid}` 组成，其中 `uuid` 为随机生成。|
| `reason` | Object | 触发回调的原因。`login` 表示用户登录。|
| `security` | String | 消息回调请求中的签名，用来确认该回调是否来自 Agora 即时通讯服务器。该签名使用 MD5 算法对 `{callId} + {secret} + {timestamp}` 进行加密，其中 `secret` 可以在 Agora 控制台即时通讯的 IM 配置页面找到。|
| `os` | String | 设备类型，指设备的操作系统。包含 `ios`、`android`、`linux`、`win` 及 `other`。|
| `ip` | String | 用户登录的 IP 地址。|
| `host` | String | Agora 即时通讯服务分配的 RESTful API 请求地址域名。|
| `appkey` | String | Agora 即时通讯服务分配给每个 app 的唯一标识。|
| `user` | String | 登录用户的识别号。该字段由 `{appKey}/{OS}_{deviceId}` 组成。|
| `version` | String | SDK 版本号。|
| `timestamp` | Long | 登录请求到 Agora 即时通讯服务器的 Unix 时间戳，单位为 ms。|
| `status` | String | 用户当前状态。`online` 表示该用户在线。|

### 用户登出

当本地有用户登出时，Agora 即时通讯服务会向你的应用服务器发送回调事件，示例如下：

```json
{
    "callId":"XXXX#XXXX25b54a81-1376-4669-bb3d-178339a8f11b",
    "reason":"logout",
    "security":"XXXXd77eXXXXf26801627fdaadca987e",
    "os":"ios",
    "ip":"223.71.97.198:4XXXX",
    "host":"********",
    "appkey":"XXXX#XXXX",
    "user":"XXXX#XXXXtstXXXX/ios_XXXX0737-db3a-d2b5-da18-b604XXXX195b",
    "version":"3.8.9.1",
    "timestamp":1642648914742,
    "status":"offline"
}
```

| 字段 | 数据类型 | 描述 |
| --- | --- | --- |
| `callId` | String | 回调 ID，是每条 HTTP 回调的唯一标识。该字段由 `{appKey}_{uuid}` 组成，其中 uuid 为随机生成。|
| `reason` | Object | 触发回调的原因。`logout` 表示用户登出。|
| `security` | String | 消息回调请求中的签名，用来确认该回调是否来自 Agora 即时通讯服务器。该签名使用 MD5 算法对 `{callId} + {secret} + {timestamp}` 进行加密，其中 `secret` 可以在 Agora 控制台即时通讯的 IM 配置页面找到。|
| `os` | String | 设备类型，指设备的操作系统。包含 `ios`、`android`、`linux`、`win` 及 `other`。|
| `ip` | String | 用户登出的 IP 地址。|
| `host` | String | Agora 即时通讯服务分配的 RESTful API 请求地址域名。|
| `appkey` | String | Agora 即时通讯服务分配给每个 app 的唯一标识。|
| `user` | String | 登出用户的识别号。该字段由 `{appKey}/{OS}_{deviceId}` 组成。|
| `version` | String | SDK 版本号。|
| `timestamp` | Long | 登出请求到 Agora 即时通讯服务器的 Unix 时间戳，单位为 ms。|
| `status` | String | 用户在线状态。`offline` 表示该用户已下线。|

### 用户因被其他设备踢掉而登出

当本地有用户因被其他设备踢掉而登出时，Agora 即时通讯服务会向你的应用服务器发送回调事件，示例如下：

```json
{
    "callId":"XXXX#XXXX260ae3eb-ba31-4f01-9a62-8b3b05f3a16c",
    "reason":"replaced",
    "security":"XXXX00b1XXXX4fe76dbfdc664cbaa76b",
    "os":"ios","ip":"223.71.97.198:52709",
    "host":"msync@ebs-ali-beijing-msync40",
    "appkey":"XXXX#XXXX",
    "user":"XXXX#XXXXtst01XXXX/ios_XXXX01fd-b5a4-84d5-ebeb-bf10XXXX0442",
    "version":"3.8.9.1",
    "timestamp":1642648955563,
    "status":"offline"
}
```

| 字段 | 数据类型 | 描述 |
| --- | --- | --- |
| `callId` | String | 回调 ID，是每条 HTTP 回调的唯一标识。该字段由 `{appKey}_{uuid}` 组成，其中 `uuid` 为随机生成。|
| `reason` | Object | 触发回调的原因。`replaced` 表示用户由于被其他设备踢掉而登出。|
| `security` | String | 消息回调请求中的签名，用来确认该回调是否来自 Agora 即时通讯服务器。该签名使用 MD5 算法对 `{callId} + {secret} + {timestamp}` 进行加密，其中 `secret` 可以在 Agora 控制台即时通讯的 IM 配置页面找到。|
| `os` | String | 设备类型，指设备的操作系统。包含 `ios`、`android`、`linux`、`win` 及 `other`。|
| `ip` | String | 用户登出的 IP 地址。|
| `host` | String | Agora 即时通讯服务分配的 RESTful API 请求地址域名。|
| `appkey` | String | Agora 即时通讯服务分配给每个 app 的唯一标识。|
| `user` | String | 登出用户的识别号。该字段由 {appKey}/{OS}_{deviceId} 组成。|
| `version` | String | SDK 版本号。|
| `timestamp` | Long | 登出请求到 Agora 即时通讯服务器的 Unix 时间戳，单位为 ms。|
| `status` | String | 用户在线状态。`offline` 表示该用户已下线。|


## 发送消息事件

当即时通讯 app 中有用户发送消息时，无论是单聊、群聊、聊天室，Agora 即时通讯服务均会向你的应用服务端发送回调事件。示例如下：

```json
{
    "callId":"{appkey}_{uuid}",
    "eventType":"chat_offline",
    "timestamp":1600060847294,
    "chat_type":"groupchat", 
    "group_id":"1693XXXX238921545",
    "from":"user1",
    "to":"user2",
    "msg_id":"8924XXXX42322",
    "payload":{
    // 具体的回调消息内容
    },
    "securityVersion":"1.0.0",
    "security":"XXXX2c39XXXX9e7abc83958bcc3156d3"
}
```

| 参数 | 类型 | 描述 |
| -- | -- | -- |
| `callId` | String | 回调 ID。是每条 HTTP 回调的唯一标识。该字段由 `{appKey}_{uuid}` 组成，其中 `uuid` 为随机生成。 |
| `eventType` | String | 消息类型：<ul><li>`chat`: 上行消息，即消息服务器收到指令要下发的消息。</li><li>`chat_offline`: 离线消息，即因用户离线消息服务器未成功下发的消息。</li></ul> |
| `timestamp` | Long | Agora 即时通讯服务器接收到此消息的 Unix 时间戳，单位为 ms。|
| `chat_type` | String | 会话类型：<ul><li>`chat`: 单聊</li><li>`groupchat`: 群组和聊天室</li></ul> |
| `group_id` | String | 消息回调所发生的群组或聊天室的 ID。当 `chat_type` 为 `groupchat` 时，才会有该参数。|
| `from` | String | 消息的发送方。|
| `to`  | String | 消息的接收方。 |
| `msg_id` | String | 该消息回调的 ID，与用户发送消息时的 `msg_id` 一致。|
| `payload` | Object | 消息回调事件的详细内容。根据用户在单聊、群聊、聊天室中发送的消息类型，回调事件中的 `payload` 包含的字段不同，具体示例及参数解释详见下文。|
| `securityVersion` | String | 预留参数。 |
| `security` | String | 消息回调请求中的签名，用来确认该回调是否来自 Agora 即时通讯服务器。该签名使用 MD5 算法对 `{callId} + {secret} + {timestamp}` 进行加密，其中 `secret` 可以在 Agora 控制台即时通讯的 IM 配置页面找到。|
| `appkey`          | String | Agora 即时通讯服务分配给每个 app 的唯一标识。              |
| `host`            | String | Agora 分配的 RESTful API 请求地址域名。  |

### 文字消息

当用户在单聊、群聊或聊天室中发送文字消息时，Agora 即时通讯服务会向你应用的服务器发送回调事件，其中 `payload` 示例如下：

```json
"payload":
{
    "ext":{},
    "bodies":[
        {
            "msg":"rr",
            "type":"txt"
        }
    ]
}
```

其中，`ext` 为消息的扩展字段，数据类型为 Object；`bodies` 为该回调的主体内容，数据类型为 Object。包含如下字段：

| 字段          | 数据类型 | 描述                                        |
| :------------ | :------- | :---------------------------------------- |
| `msg`        | String   | 文字消息内容。                                  |
| `type`       | String   | 消息类型。文字消息为 `txt`。 |


### 图片消息

当用户在单聊、群聊或聊天室发送图片消息时，Agora 即时通讯服务会向你的应用服务器发送回调事件，其中 `payload` 示例如下：

```json
"payload":
{
    "ext":{},
    "bodies":[
        {
            "filename":"image",
            "size":
            {
                "width":746,
                "height":1325
            },
            "secret":"XXXXqnkRXXXXAUHNhFQyIhTJxWxvGOwyx1",
            "file_length":118179,
            "type":"img",
            "url":"https://a1.agora.com/"
        }
    ]
}
```

其中，`ext` 为消息的扩展字段，数据类型为 Object；`bodies` 为该回调的主体内容，数据类型为 Object。包含如下字段：

| 字段          | 数据类型 | 描述                                        |
| :------------ | :------- | :---------------------------------------- |
| `filename`   | String    | 图片文件名称。 |
| `secret`     | String    | 成功上传图片文件后返回的密钥。|
| `file_length` | Int      | 图片文件大小，单位为字节（Byte）。 |
| `size`       | Json      | 图片尺寸，单位为像素。包含如下字段：<ul><li>`height`: 图片高度</li><li>`width`: 图片宽度</li></ul>   |
| `url`   | String  | 图片 URL 地址，格式为 `https://{host}/{org_name}/{app_name}/chatfiles/{uuid}`，其中 `uuid` 为文件 ID。成功上传图片文件后，从文件上传的响应 body 中获取。|
| `type`    | String  | 消息类型。图片消息为 `img`。 |


### 语音消息

当用户在单聊、群聊或聊天室中发送语音消息时，Agora 即时通讯服务会向你的应用服务器发送回调事件，其中 `payload` 示例如下：

```json
"payload":
{
    "ext":{},
    "bodies":[
        {
            "filename":"audio",
            "length":4,
            "secret":"XXXXynkRXXXX1e0Ksmmt2Ym6AzpRr9SxsUpF",
            "file_length":6374,
            "type":"audio",
            "url":"https://a1.agora.com/"
        }
    ]
}
```

其中，`ext` 为消息的扩展字段，数据类型为 Object；`bodies` 为该回调的主体内容，数据类型为 Object。包含如下字段：

| 字段          | 数据类型 | 描述                                        |
| :------------ | :------- | :---------------------------------------- |
| `filename`        | String   | 语音文件名称。                                  |
| `secret`          | String    | 成功上传语音文件后返回的密钥。  |
| `file_length`  |  Long  | 语音文件大小，单位为字节（Byte）。 |
| `length`    | Int | 语音时间，单位为秒。 |
| `url`  | String  | 语音文件的 URL 地址，格式为 `https://{host}/{org_name}/{app_name}/chatfiles/{uuid}`，其中 `uuid` 为文件 ID。成功上传语音文件后，从文件上传的响应 body 中获取。|
| `type`  | String | 消息类型。语音消息为 `audio`。 |

### 视频消息

当用户在单聊、群聊或聊天室中发送视频消息时，Agora 即时通讯服务会向你的应用服务器发送回调事件，其中 `payload` 示例如下：

```json
"payload":
{
    "ext":{},
    "bodies":[
        {
            "thumb_secret":"t1AEXXXXEeyS81-d10_HOpjSZc8TD-ud40XXXXOStQrr7Mbc",
            "filename":"video.mp4",
            "size":
            {
                "width":360,
                "height":480
            },
            "thumb":"https://a1.agora.com/agora-demo/shuang/chatfiles/XXXX0400-7a8b-11ec-8d83-7106XXXX33e6",
            "length":10,
            "secret":"XXXXgHqLXXXXBfuoalZCJPD7PVcoOu_RHTRa78bjU_KQAPr2",
            "file_length":601404,
            "type":"video",
            "url":"https://a1.agora.com/agora-demo/shuang/chatfiles/XXXX3270-7a8b-11ec-9735-6922XXXXb891"
        }
    ]
}
```

其中，`ext` 为消息的扩展字段，数据类型为 Object；`bodies` 为该回调的主体内容，数据类型为 Object。包含如下字段：

| 字段  | 数据类型  | 描述  |
| --- | --- | --- |
| `thumb_secret` | String | 成功上传视频缩略图后返回的秘钥。 |
| `filename` | String | 视频文件的名称。|
| `size` | Json | 缩略图图片尺寸，包含如下字段：<ul><li>`height`: 图片高度</li><li>`width`: 图片宽度</li></ul> |
| `thumb` | String  | 视频缩略图的 URL 地址，格式为 `https://{host}/{org_name}/{app_name}/chatfiles/{uuid}`，其中 `uuid` 为缩略图文件 ID。成功上传视频缩略图文件后，从文件上传的响应 body 中获取。 |
| `secret` | String | 成功上传视频文件后返回的秘钥。|
| `file_length` | Long | 视频文件大小，单位为字节（Byte）。|
| `url` | String | 视频文件的 URL 地址，格式为 `https://{host}/{org_name}/{app_name}/chatfiles/{uuid}`，其中 `uuid` 为视频文件 ID。成功上传视频文件后，从文件上传的响应 body 中获取。|
| `type` | String | 消息类型。视频消息为 `video`。|

### 位置消息

当用户在单聊、群聊或聊天室中发送位置消息时，Agora 即时通讯服务会向你的应用服务器发送回调事件，其中 `payload` 示例如下：

```json
"payload":
{
    "ext":{},
    "bodies":[
        {
            "lng":116.32309156766605,
            "type":"loc",
            "addr":"********",
            "lat":39.96612729238626
        }
    ]
}
```

其中，`ext` 为消息的扩展字段，数据类型为 Object；`bodies` 为该回调的主体内容，数据类型为 Object。包含如下字段：

| 字段 | 数据类型  | 描述  |
| --- | --- | --- |
| `log` | String | 纬度。|
| `lat` | String | 经度。|
| `addr` | String | 位置的文字描述。|
| `type` | String | 消息类型。位置消息为 `loc`。|

### 透传消息

当用户在单聊、群聊或聊天室中发送透传消息时，Agora 即时通讯服务会向你的应用服务器发送回调事件，其中 `payload` 示例如下：

```json
"payload":
{
    "ext":{},
    "bodies":[
        {
            "msg":"rr",
            "type":"cmd"
        }
    ]
}
```

其中，`ext` 为消息的扩展字段，数据类型为 Object；`bodies` 为该回调的主体内容，数据类型为 Object。包含如下字段：

| 字段          | 数据类型 | 描述                                        |
| :------------ | :------- | :---------------------------------------- |
| `msg`        | String   | 透传消息内容。                                  |
| `type`       | String   | 消息类型。透传消息为 `cmd`。 |

### 自定义消息

当用户在单聊、群聊或聊天室中发送自定义消息时，Agora 即时通讯服务会向你的应用服务器发送回调事件，其中 `payload` 示例如下：

```json
"payload": 
{
    "ext":{}, 
    "bodies":[
        { 
            "customExts": [ {"name": 1 } ], 
            "customEvent": "flower", 
            "type": "custom" 
        }
    ] 
}
```

其中，`ext` 为消息的扩展字段，数据类型为 Object；`bodies` 为该回调的主体内容，数据类型为 Object。包含如下字段：

| 字段 | 数据类型  | 描述  |
| --- | --- | --- |
| `customExts` | Json | 用户自定义的事件属性，类型为 `Map<String, String>`，最多包含 16 个元素。|
| `customEvent`| String | 用户自定义的事件类型。最短一个字符，最长 32 个字符。|
| `type` | String | 消息类型。自定义消息为 `custom`。|

## 撤回消息事件

当 Agora 即时通讯 app 中有用户在单聊、群聊或聊天室中撤回消息时，Agora 即时通讯服务会向你的应用服务器发送回调事件。示例如下：

```json
{
    "chat_type":"recall",
    "callId":"orgname#appname_9664XXXX5536657404",
    "security":"ea7aXXXX14fbXXXX33d5f4f169eb4f8d",
    "payload":
    {
        "ext":{},
        "ack_message_id":"9664XXXX0900644860",
        "bodies":[]
    },
    "host":"******",
    "appkey":"orgname#appname",
    "from":"tst",
    "recall_id":"9664XXXX0900644860",
    "to":"1709XXXX2023810",
    "eventType":"chat",
    "msg_id":"9664XXXX5536657404",
    "timestamp":1642589932646
}
```

| 字段  | 数据类型 | 描述  |
| --- | --- | --- |
| `callId` | String | 回调 ID。是每条 HTTP 回调的唯一标识。该字段由 `{appKey}_{uuid}` 组成，其中 uuid 为随机生成。 |
| `eventType` | String | 消息类型：<ul><li>`chat`: 上行消息，即消息服务器收到指令要下发的消息。</li><li>`chat_offline`: 离线消息，即因用户离线消息服务器未成功下发的消息。</li></ul> |
| `timestamp` | Long | Agora 即时通讯服务器接收到此消息的 Unix 时间戳，单位为 ms。|
| `chat_type` | String | 会话类型：<ul><li>`chat`: 单聊</li><li>`groupchat`: 群组和聊天室</li></ul> |
| `group_id` | String | 消息回调所发生的群组或聊天室的 ID。当 `chat_type` 为 `groupchat` 时，才会有该参数。|
| `from` | String | 消息的发送方。|
| `to`  | String | 消息的接收方。 |
| `recall_id` | String | 要撤回的消息 ID。|
| `msg_id` | String | 该消息回调的 ID，与发送消息时的 `msg_id` 一致。|
| `payload` | Object | 消息回调事件的内容结构体。包含如下字段：<ul><li>`ext`: 消息的扩展字段。对于撤回消息，该字段为空。</li><li>`ack_message_id`: 要撤回的消息 ID。与 `recall_id` 一致。</li><li>`bodies`: 该回调的主体内容。对于撤回消息，该字段为空。</ul> |
| `securityVersion` | String | 预留参数。 |
| `security` | String | 消息回调请求中的签名，用来确认该回调是否来自 Agora 即时通讯服务器。格式为 MD5(`callId` + `secret` + `timestamp`)，其中 `secret` 可以在 Agora 控制台即时通讯的 IM 配置页面找到。|
| `appkey`          | String | Agora 即时通讯服务分配给每个 app 的唯一标识。              |
| `host`            | String | Agora 分配的 RESTful API 请求地址域名。  |

## 群组与聊天室事件

当即时通讯 app 中有用户进行群组或聊天室操作时，Agora 即时通讯服务会向你的应用服务器发送回调事件。示例如下：

```json
{ 
    "chat_type": "muc",
    "callId": "XXXX#XXXX", 
    "security": "XXXX", 
    "payload":{
    // 具体的回调消息内容
    },
    "group_id": "1735XXXX6122369",
    "host": "XXXX",
    "appkey": "XXXX#XXXX",
    "from": "XXXX#XXXX_1111@easemob.com/android_8070d7b2-795eb6e63d",
    "to": "1111",
    "eventType": "chat",
    "msg_id": "9764XXXX3882744164",
    "timestamp": 1644914583273
}
```
| 字段  | 数据类型 | 描述  |
| --- | --- | --- |
| `chat_type` | String | 事件类型。`muc` 表示群组或聊天室。 |
| `callId` | String | 回调 ID。是每条 HTTP 回调的唯一标识。该字段由 `{appKey}_{uuid}` 组成，其中 `uuid` 为随机生成。 |
| `eventType` | String | 消息类型：<ul><li>`chat`: 上行消息，即消息服务器收到指令要下发的消息。</li><li>`chat_offline`: 离线消息，即因用户离线消息服务器未成功下发的消息。</li></ul> |
| `timestamp` | Long | Agora 即时通讯服务器接收到此消息的 Unix 时间戳，单位为 ms。|
| `group_id` | String | 消息回调所发生的群组或聊天室的 ID。当 `chat_type` 为 `groupchat` 时，才会有该参数。|
| `from` | String | 消息的发送方。|
| `to`  | String | 消息的接收方。 |
| `msg_id` | String | 该消息回调的 ID，与发送消息时的 `msg_id` 一致。|
| `payload` | Object | 回调事件的内容结构体。包含如下字段：<ul><li>`muc_id`: 该事件所在的群组或聊天室在服务器的唯一标识，格式为 `{appkey}_{group_ID}@conference.easemob.com`。</li><li>`reason`: (非必需) 当前操作的详细信息。各操作的详细信息详见下文。</li><li>`is_chatroom`: 该事件是否发生在聊天室<ul><li>`true`: 是</li><li>`false`: 否，该事件发生在群组</li></ul><li>`operation`: 当前操作。各群组或聊天室的操作详见下文。</li><li>`status`: 当前操作状态。包含如下字段：<ul><li>`description`: 该操作失败的原因描述</li><li>`error_code`: 操作失败对应的错误码</li></ul> |
| `securityVersion` | String | 预留参数。 |
| `security` | String | 消息回调请求中的签名，用来确认该回调是否来自 Agora 即时通讯服务器。该签名使用 MD5 算法对 `{callId} + {secret} + {timestamp}` 进行加密，其中 `secret` 可以在 Agora 控制台即时通讯的 IM 配置页面找到。|
| `appkey`          | String | Agora 即时通讯服务分配给每个 app 的唯一标识。              |
| `host`            | String | Agora 分配的 RESTful API 请求地址域名。  |


### 创建群组或聊天室

<div class="alert note">该回调事件需要在开通多设备服务后才会触发，以通知另外的设备该用户已创建群组或聊天室。</div>

当用户创建群组或聊天室时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{
    "muc_id": "XXXX#XXXX_173556296122369@conference.easemob.com", 
    "reason": "",
    "is_chatroom": false,
    "operation": "create",
    "status":
    {
        "description":"",
        "error_code": "ok"
    }
}
```

其中 `operation` 为当前操作，即 `create`。

### 删除群组或聊天室

当用户删除群组或聊天室时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload": 
{ 
    "muc_id": "XXXX#XXXX_173548612157441@conference.easemob.com", 
    "reason": "", 
    "is_chatroom": false, 
    "operation": "destroy", 
    "status": { 
        "description": "", 
        "error_code": "ok" 
    } 
} 
```

其中 `operation` 为当前操作，即 `destroy`。

### 用户申请加入群组

当用户申请加入群组时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX_.com", 
    "reason": "join group123", 
    "is_chatroom": false, 
    "operation": "apply", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    } 
}
```

其中：
- `reason` 为申请加入群组的消息。
- `operation` 为当前操作，即 `apply`。

### 同意用户加入群组

当本地用户同意其他用户加入群组时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX", 
    "reason": "", 
    "is_chatroom": false, 
    "operation": "apply_accept", 
    "status":
    { 
        "description": "",
        "error_code": "ok"
    }
}
```

其中 `operation` 为当前操作，即 `apply_accept`。

### 邀请用户加入群组

当本地用户邀请其他用户进入群组时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX",
    "reason": "Hello", 
    "is_chatroom": false, 
    "operation": "invite", 
    "status": { 
        "description": "",
        "error_code": "ok" 
    } 
}
```

其中：
- `reason` 为邀请入群的信息。
- `operation` 为当前操作，即 `invite`。

### 受邀用户同意加入群组

当受邀用户同意本地用户的进群邀请后，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173549292683265XXXX", 
    "reason": "", 
    "is_chatroom": false, 
    "operation": "invite_accept", 
    "status": { 
        "description": "", 
        "error_code": "ok" 
    } 
}
```

其中 `operation` 为当前操作，即 `invite_accept`。

### 受邀用户拒绝加入群组

当受邀用户拒绝本地用户的进群邀请时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173549292683265XXXX", 
    "reason": "", 
    "is_chatroom": false, 
    "operation": "invite_decline", 
    "status": { 
        "description": "", 
        "error_code": "ok" 
    } 
}
```

其中 `operation` 为当前操作，即 `invite_decline`。

### 将用户踢出群聊或聊天室

当用户将其他成员踢出群组或聊天室时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173549292683265XXXX", 
    "is_chatroom": false, 
    "operation": "kick", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    } 
}
```

其中 `operation` 为当前操作，即 `kick`。

### 添加成员至黑名单

当用户将其他成员添加至群组或聊天室黑名单时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173558358671361@conference.easemob.com", 
    "reason": "", 
    "is_chatroom": false, 
    "operation": "ban", 
    "status": { 
        "description": "",
        "error_code": "ok" 
    } 
}
```

其中 `operation` 为当前操作，即 `ban`。

### 将成员从黑名单中移除

当用户将其他成员从群组或聊天室黑名单中移除时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173549292683265XXXX", 
    "reason": "undefined", 
    "is_chatroom": false, 
    "operation": "allow", 
    "status": { 
        "description": "", 
        "error_code": "ok" 
    } 
}
```

其中 `operation` 为当前操作，即 `allow`。

### 修改群组或聊天室信息

当用户修改群组或聊天室信息时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173549200408577XXXX", 
    "is_chatroom": false, 
    "operation": "update", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    } 
}
```

其中 `operation` 为当前操作，即 `update`。

### 屏蔽群组或聊天室消息

当用户屏蔽群组或聊天室消息时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173560762007553XXXX", 
    "is_chatroom": false, 
    "operation": "block", 
    "status": { 
        "description": "", 
        "error_code": "ok" 
    } 
}
```

其中 `operation` 为当前操作，即 `block`。

### 取消屏幕群组或聊天室消息

当用户取消屏蔽群组或聊天室消息时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173560762007553XXXX", 
    "is_chatroom": false, 
    "operation": "unblock", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    }
}
```

其中 `operation` 为当前操作，即 `unblock`。

### 加入群组或聊天室

当用户加入群组或聊天室时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173560762007553XXXX", 
    "is_chatroom": false, 
    "operation": "presence", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    }
}
```

其中 `operation` 为当前操作，即 `presence`。

### 离开群组或聊天室

当用户主动离开聊天室时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173560762007553XXXX", 
    "is_chatroom": false, 
    "operation": "leave", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    }
}
```

其中 `operation` 为当前操作，即 `leave`。

当用户自愿或非自愿离开群组或聊天室时，Agora 即时通讯服务会向你的应用服务器发送离开的结果。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173560762007553XXXX", 
    "is_chatroom": false, 
    "operation": "absence", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    }
}
```

其中 `operation` 为当前操作，即 `absence`。

### 转让群主或所有者权限

当用户作为群主或聊天室所有者转让权限时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173560762007553XXXX", 
    "is_chatroom": false, 
    "operation": "assing_owner", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    }
}
```

其中 `operation` 为当前操作，即 `assing_owner`。

### 添加群组或聊天室管理员

当用户添加群组或聊天室管理员时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173560762007553XXXX", 
    "is_chatroom": false, 
    "operation": "add_admin", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    }
}
```

其中 `operation` 为当前操作，即 `add_admin`。


### 删除群组或聊天室管理员

当用户删除群组或聊天室管理员时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173560762007553XXXX", 
    "is_chatroom": false, 
    "operation": "remove_admin", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    }
}
```

其中 `operation` 为当前操作，即 `remove_admin`。


### 禁言群组或聊天室成员

当用户禁言群组或聊天室成员时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173560762007553XXXX", 
    "reason": "", 
    "is_chatroom": false, 
    "operation": "add_mute", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    }
}
```

其中 `operation` 为当前操作，即 `add_mute`。


### 解除群组或聊天室成员禁言

当用户取消群组或聊天室成员禁言时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173560762007553XXXX", 
    "reason": "", 
    "is_chatroom": false, 
    "operation": "remove_mute", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    }
}
```

其中 `operation` 为当前操作，即 `remove_mute`。

### 更新群组或聊天室公告

当用户更新群组或聊天室公告时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173560762007553XXXX", 
    "reason": "gogngao", 
    "is_chatroom": false, 
    "operation": "update_announcement", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    }
}
```

其中：
- `reason` 为群公告或聊天室公告内容。
- `operation` 为当前操作，即 `update_announcement`。

### 删除群组或聊天室公告

当用户删除群组或聊天室公告时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173560762007553XXXX", 
    "reason": "", 
    "is_chatroom": false, 
    "operation": "delete_announcement", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    }
}
```

其中：
- `reason` 为删除后的群公告，即为空。
- `operation` 为当前操作，即 `delete_announcement`。

### 上传群组共享文件

当用户上传群组共享文件时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173560762007553XXXX", 
    "reason": "{
        \"data\":{
            \"file_id\":\"79ddf840-8e2f-11ec-bec3-ad40868b03f9\",
            \"file_name\":\"a.csv\",
            \"file_owner\":\"@ppAdmin\",
            \"file_size\":6787,
            \"created\":1644909510085
            }
    }",
    "is_chatroom": false, 
    "operation": "upload_file", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    }
}
```

其中：
- `reason` 中包含上传群共享文件的详情，包含如下字段：
    - `file_id`: 文件 ID。
    - `file_name`: 文件名。
    - `file_owner`: 文件所有者，即上传文件的用户。
    - `file_size`: 文件大小，单位为字节（Byte）。
    - `created`: 文件创建的 Unix 时间戳，单位为 ms。
- `operation` 为当前操作，即 `upload_file`。

### 删除群组共享文件

当用户删除群组共享文件时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173549292683265XXXX", 
    "reason": "79ddf840-8e2f-11ec-bec3-ad40868b03f9", 
    "is_chatroom": false, 
    "operation": "delete_file", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    } 
}
```

其中：
- `reason` 为删除的共享文件 ID，与上传群文件时的 `file_id` 一致。
- `operation` 为当前操作，即 `delete_file`。

### 添加用户进群组或聊天室白名单

当用户添加其他成员进群组或聊天室白名单时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173549292683265XXXX", 
    "is_chatroom": false, 
    "operation": "add_user_white_list", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
        } 
}
```

其中 `operation` 为当前操作，即 `add_user_white_list`。

### 将用户移出群组或聊天室白名单

当用户将其他成员从群组或聊天室白名单中移出时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173549292683265XXXX", 
    "is_chatroom": false, 
    "operation": "remove_user_white_list", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    } 
}
```

其中，`operation` 为当前操作，即 `remove_user_white_list`。

### 群组或聊天室全局禁言

当用户将群组或聊天室全局禁言时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173553668390913XXXX", 
    "is_chatroom": false, 
    "operation": "ban_group", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    } 
}
```

其中，`operation` 为当前操作，即 `ban_group`。

### 解除群组或聊天室全局禁言

当用户解除群组或聊天室全局禁言时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{ 
    "muc_id": "XXXX#XXXX173553668390913XXXX", 
    "is_chatroom": false, 
    "operation": "remove_ban_group", 
    "status":
    { 
        "description": "", 
        "error_code": "ok" 
    } 
}
```

其中，`operation` 为当前操作，即 `remove_ban_group`。

## 好友关系事件

当即时通讯 app 中有用户进行好友关系操作时，Agora 即时通讯服务会向你的应用服务器发送回调事件。示例如下：

```json
{
    "chat_type": "roster",
    "callId": "orgname#appname_9664XXXX5536657404",
    "security": "XXXXa9feXXXX69241e17b15e2783dbb1",
    "payload": {
        // 具体的回调事件
    },
    "host": "msync@ebs-ali-beijing-msync26",
    "appkey":"orgname#appname",
    "from":"tst",
    "to":"tst01",
    "eventType":"chat",
    "msg_id":"9664XXXX5536657404",
    "timestamp":1642589932646
}
```

| 字段  | 数据类型 | 描述  |
| --- | --- | --- |
| `chat_type` | String | 事件类型。`roster` 表示好友关系。 |
| `callId` | String | 回调 ID。是每条 HTTP 回调的唯一标识。该字段由 `{appKey}_{uuid}` 组成，其中 `uuid` 为随机生成。 |
| `eventType` | String | 消息类型：<ul><li>`chat`: 上行消息，即消息服务器收到指令要下发的消息。</li><li>`chat_offline`: 离线消息，即因用户离线消息服务器未成功下发的消息。</li></ul> |
| `timestamp` | Long | Agora 即时通讯服务器接收到此消息的 Unix 时间戳，单位为 ms。|
| `from` | String | 发起好友操作的用户。|
| `to`  | String | 被进行好友操作的用户。 |
| `msg_id` | String | 该消息回调的 ID，与发送消息时的 `msg_id` 一致。|
| `payload` | Object | 消息回调事件的内容结构体。各回调事件包含的 `payload` 详情见下文。 |
| `security` | String | 消息回调请求中的签名，用来确认该回调是否来自 Agora 即时通讯服务器。该签名使用 MD5 算法对 `{callId} + {secret} + {timestamp}` 进行加密，其中 `secret` 可以在 Agora 控制台即时通讯的 IM 配置页面找到。|
| `appkey`          | String | Agora 即时通讯服务分配给每个 app 的唯一标识。              |
| `host`            | String | Agora 分配的 RESTful API 请求地址域名。  |

### 添加好友

当用户添加好友时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{
    "reason":"",
    "operation":"add"
}
```

其中，`operation` 为当前操作，即 `add`。

### 删除好友

当用户删除好友时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{
    "roster_ver":"XXXXD920XXXX5B51EB0B806E83BDD97F089B0092",
    "operation":"remove"
}
```

其中：
- `roster_ver` 为好友列表的版本号。
- `operation` 为当前操作，即 `remove`。

### 同意好友申请

当用户同意了其他用户的好友申请时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{
    "roster_ver":"XXXX14FEXXXXA9ABC52CA86C5DE1601CF729BFD6",
    "operation":"accept"
}
```

其中：
- `roster_ver` 为好友列表版本号。
- `operation` 为当前操作，即 `accept`。

### 拒绝好友申请

当用户拒绝了其他用户的好友申请时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{
    "roster_ver":"XXXXEC24XXXX32B2EB1B654AA446930DB9BAFE59",
    "operation":"decline"
}
```

其中：
- `roster_ver` 为好友列表版本号。
- `operation` 为当前操作，即 `decline`。

### 将好友拉入黑名单

当用户将好友拉入黑名单时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{
    "operation":"ban",
    "status":
    {
        "error_code":"ok"
    }
}
```

其中 `operation` 为当前操作，即 `ban`。

### 将好友从黑名单中移出

当用户将好友从黑名单中移出时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload":
{
    "operation":"allow",
    "status":
    {
        "error_code":"ok"
    }
}
```

其中 `operation` 为当前操作，即 `allow`。

### 其他用户同意好友请求

当有其他用户同意了本地用户的好友请求时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload": { 
    "roster_ver": "XXXX718EXXXX3F0C572A5157CFC711D4F6FA490F", 
    "operation": "remote_accept" 
}
```

其中：
- `roster_ver` 为好友列表的版本号。
- `operation` 为当前操作，即 `remote_accept`。

### 其他用户拒绝好友请求

当有其他用户拒绝了本地用户的好友请求时，Agora 即时通讯服务会向你的应用服务器发送回调事件。其中 `payload` 示例如下：

```json
"payload": { 
    "roster_ver": "1BD5718E9C9D3F0C572A5157CFC711D4F6FA490F", 
    "operation": "remote_decline" 
}
```

其中：
- `roster_ver` 为好友列表的版本号。
- `operation` 为当前操作，即 `remote_decline`。

## 回执事件

当即时通讯 app 的用户发送消息回执时，Agora 即时通讯服务会向你的应用服务器发送回调事件。示例如下：

```json
{
    "chat_type": "read_ack",
    "callId": "XXXX#XXXX968665325555943556",
    "security": "bd63XXXX8f72XXXX6d33e09a43aa4239",
    "payload": {
        "ext": {},
        "ack_message_id": "9686XXXX3572037776",
        "bodies": []
    },
    "host": "msync@ebs-ali-beijing-msync45",
    "appkey": "XXXX#XXXX",
    "from": "1111",
    "to": "2222",
    "eventType": "chat",
    "msg_id": "9686XXXX5555943556",
    "timestamp": 1643099771248
}
```

| 字段        | 数据类型 | 含义                                                         |
| :---------- | :------- | :----------------------------------------------------------- |
| `chat_type` | String   | 事件类型：<ul><li>`read_ack`: 表示消息已读回执</li><li>`delivery_ack`: 表示消息已送达回执</li></ul>                                        |
| `callId`    | String   | 回调 ID，是每条 HTTP 回调的唯一标识。该字段由 `{appKey}_{uuid}` 组成，其中 `uuid` 为随机生成。 |
| `security`  | String   | 消息回调请求中的签名，用来确认该回调是否来自 Agora 即时通讯服务器。格式为 MD5(`callId` + `secret` + `timestamp`)，其中 `secret` 可以在 Agora 控制台即时通讯的 IM 配置页面找到。 |
| `payload`   | Object   | 回调的具体内容，包括如下字段：<ul><li>`ext`：消息的扩展字段</li><li>`ack_message_id`：发送回执的消息 ID</li><li>`bodies`：消息体内容</li></ul> |
| `host`      | String   | Agora 即时通讯服务分配的 RESTful API 请求地址域名。                                                 |
| `appkey`    | String   | Agora 即时通讯服务分配给每个 app 的唯一标识。                         |
| `from`      | String   | 发送回执的用户 ID。                                        |
| `to`        | String   | 接收回执的用户 ID。                                        |
| `eventType` | String   | 消息类型：<ul><li>`chat`: 上行消息，即消息服务器收到指令要下发的消息。</li><li>`chat_offline`: 离线消息，即因用户离线消息服务器未成功下发的消息。</li></ul>                                               |
| `timestamp` | long     | 回执事件到 Agora 即时通讯 IM 服务器的 Unix 时间戳，单位为 ms。                  |
| `msg_id`    | String   | 该回执的消息 ID。                                        |