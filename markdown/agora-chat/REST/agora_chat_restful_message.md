
<a name="param"></a>

## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数：

### 请求参数

| 参数       | 类型   | 描述                                                                                                                                                                     | 是否必填 |
| :--------- | :----- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。      | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。        | 是       |
| `username` | String | 用户 ID。        | 是       |

### 响应参数

| `entities`        | JSON   | 返回实体信息。                                                    |
| `host`            | String | 即时通讯服务分配的用于访问 RESTful API 的域名，与请求参数 `host` 相同。    |
| `data`            | JSON   | 实际获取的数据详情。                  |
| `uuid`            | String | 消息附件的唯一标识。该标识由系统生成，开发者无需关心。       |
| `username`        | String | 用户 ID。      |

## 认证方式

~458499a0-7908-11ec-bcb4-b56a01c83d2e~


### 历史消息记录的内容

查询历史消息记录成功后，你可以访问 URL 下载历史消息记录文件，查看历史消息记录的具体内容。
历史消息记录为 JSON 类型，示例如下：

```json
{
    "msg_id": "5I02W-XX-8278a",
    "timestamp": 1403099033211,
    "direction": "outgoing",
    "to": "XXXX",
    "from": "XXXX",
    "chat_type": "chat",
    "payload":
    {
        "bodies": [    {
        //下面会将不同的消息类型进行说明
        }
        ],
        "ext":
        {
            "key1": "value1",              ...        },
            "from":"XXXX",
            "to":"XXXX"
    }
}
```

历史消息记录包含以下字段：

| 字段             | 类型   | 描述                                                                                                                               |
| :--------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------- |
| `msg_id`         | String | 消息 ID。一次消息发送请求的唯一标识。                                                                                              |
| `timestamp`      | Number | 消息发送完成的 Unix 时间戳（毫秒），UTC 时间。                                                                                     |
| `direction`      | String | 消息发送方向：<ul><li>`incoming`：上行消息，用户向即时通讯服务器发送的消息。</li><li>`outgoing`：下行消息，即时通讯服务器下发到用户的消息。</li></ul> |
| `from`           | String | 消息发送方的用户 ID。                                                                                                               |
| `to`             | String | 消息接收方的用户 ID 或群组 ID。                                                                                                      |
| `chat_type`      | String | 会话类型：<ul><li>`chat`：单聊</li><li>`groupchat`：群聊</li><li>`chatroom`：聊天室 </li></ul>                                                             |
| `payload`        | JSON   | 包含消息的具体内容。例如消息扩展信息、自定义扩展属性等。                                                                           |
| `payload.bodies` | JSON   | 具体的消息内容，详见以下每个消息类型的 `bodies`。                                                                                  |

#### 文本消息

文本消息的 `bodies` 包含如下字段：

| 字段   | 类型   | 描述                             |
| :----- | :----- | :------------------------------- |
| `msg`  | String | 消息内容。                       |
| `type` | String | 消息类型，文本消息类型为 `txt`。 |

示例如下：

```json
{
    "bodies": [
        {
            "msg": "welcome to agora!",
            "type": "txt"
        }
    ]
}
```

#### 图片消息

图片消息的 `bodies` 包含如下字段：

| 字段          | 类型   | 描述                                                                              |
| :------------ | :----- | :-------------------------------------------------------------------------------- |
| `file_length` | Number | 图片附件大小，单位为字节。                                                        |
| `filename`    | String | 包含图片格式后缀的图片名称。                                                      |
| `secret`      | String | 图片文件访问密钥。<br/>如果[文件上传](#upload)时设置了文件访问限制，则该字段存在。 |
| `size`        | Number | 图片的尺寸。单位为像素。<ul><li>`height`：图片高度</li><li>`width`：图片宽度</li></ul>               |
| `type`        | String | 消息类型。图片消息为 `img`。                                                      |
| `url`         | String | 图片 URL 地址。                                                                   |

示例如下：

```json
{
    "bodies": [
        {
            "file_length": 128827,
            "filename": "test1.jpg",
            "secret": "DRGM8OZrEeO1vaXXXXXXXXHBeKlIhDp0GCnFu54xOF3M6KLr",
            "size": {
                "height": 1325,
                "width": 746
            },
            "type": "img",
            "url": "https://a1.agora.com/agora-demo/chatdemoui/chatfiles/65e54a4a-XXXX-XXXX-b821-ebde7b50cc4b"
        }
    ]
}
```

#### 位置消息

位置消息的 `bodies` 包含如下字段：

| 字段   | 类型   | 描述                         |
| :----- | :----- | :--------------------------- |
| `addr` | String | 所在位置地址描述。           |
| `lat`  | Number | 所在位置的纬度。             |
| `lng`  | Number | 所在位置的经度。             |
| `type` | String | 消息类型。位置消息为 `loc`。 |

示例如下：

```json
{
    "bodies": [
        {
            "addr": "test",
            "lat": 39.9053,
            "lng": 116.36302,
            "type": "loc"
        }
    ]
}
```

#### 语音消息

语音消息的 `bodies` 包含如下字段：

| 字段          | 类型   | 描述                                                                              |
| :------------ | :----- | :-------------------------------------------------------------------------------- |
| `file_length` | Number   | 语音附件大小。单位为字节。                                                        |
| `filename`    | String | 语音文件名称，包含文件后缀名。                                                  |
| `secret`      | String | 语音文件访问密钥。<br/>如果[文件上传](#upload)时设置了文件访问限制，则该字段存在。 |
| `length`      | Number    | 语音时长。单位为秒。                                                              |
| `type`        | String | 消息类型。语音消息为 `audio`。                                                    |
| `url`         | String | 语音文件 URL 地址。                                                               |

示例如下：

```json
{
    "bodies": [
        {
            "file_length": 6630,
            "filename": "test1.amr",
            "length": 10,
            "secret": "DRGM8OZrEeO1vafuJSo2IjHBeKlIhDp0GCnFu54xOF3M6KLr",
            "type": "audio",
            "url": "https://a1.agora.com/agora-demo/chatdemoui/chatfiles/0637e55a-XXXX-XXXX-ba23-51f25fd1215b"
        }
    ]
}
```

#### 视频消息

视频消息的 `bodies` 包含如下字段：

| 字段           | 类型   | 描述                                                                                |
| :------------- | :----- | :---------------------------------------------------------------------------------- |
| `file_length`  | Number | 视频附件大小。单位为字节。                                                          |
| `filename`     | String | 带文件格式后缀的视频文件名称。                                                      |
| `secret`       | String | 视频文件访问密钥。<br/>如果[文件上传](#upload)时设置了文件访问限制，则该字段存在。   |
| `length`       | Number | 视频时长。单位为秒。                                                                |
| `size`         | JSON   | 视频缩略图尺寸。单位为像素。<ul><li>`width`：视频缩略图宽度</li><li>`height`：视频缩略图高度</li></ul> |
| `thumb`        | String | 视频缩略图 URL 地址。                                                               |
| `thumb_secret` | String | 缩略图文件访问密钥。<br/>如果[文件上传](#upload)时设置了文件访问限制，则该字段存在。 |
| `type`         | String | 消息类型。视频消息为 `video`。                                                      |
| `url`          | String | 视频文件 URL 地址。你可以访问该 URL 下载视频文件。                                  |

示例如下：

```json
{
    "bodies": [
        {
            "file_length": 58103,
            "filename": "1418105136313.mp4",
            "length": 10,
            "secret": "VfEpSmSvEeS7yU8dwa9rAQc-DIL2HhmpujTNfSTsrDt6eNb_",
            "size": {
                "height": 480,
                "width": 360
            },
            "thumb": "https://a1.agora.com/agora-demo/chatdemoui/chatfiles/67279b20-XXXX-XXXX-8eee-21d3334b3a97",
            "thumb_secret": "ZyebKn9pEeSSfY03ROk7ND24zUf74s7HpPN1oMV-1JxN2O2I",
            "type": "video",
            "url": "https://a1.agora.com/agora-demo/chatdemoui/chatfiles/671dfe30-XXXX-XXXX-ba67-8fef0d502f46"
        }
    ]
}
```

#### 文件消息

文件消息的 `bodies` 包含如下字段：

| 字段          | 类型   | 描述                                                                          |
| :------------ | :----- | :---------------------------------------------------------------------------- |
| `file_length` | Number | 文件大小。单位为字节。                                                        |
| `filename`    | String | 文件名称，包含文件后缀名。                                             |
| `secret`      | String | 文件访问密钥。<br/>如果[文件上传](#upload)时设置了文件访问限制，则该字段存在。 |
| `type`        | String | 消息类型。文件消息为 `file`。                                                 |
| `url`         | String | 文件的 URL 地址。你可以访问该 URL 下载历史消息文件。                          |

示例如下：

```json
{
    "bodies": [
        {
            "file_length": 3279,
            "filename": "record.md",
            "secret": "2RNXCgeeEeeXXXX-XXXXbtZXJH4cgr2admVXn560He2PD3RX",
            "type": "file",
            "url": "https://XXXX/XXXX/XXXX/chatfiles/d9135700-XXXX-XXXX-b000-a7039876610f"
        }
    ]
}
```

#### 透传消息

透传消息的 `bodies` 包含如下字段：

| 字段     | 类型   | 描述                         |
| :------- | :----- | :--------------------------- |
| `action` | String | 命令内容。          |
| `type`   | String | 消息类型。透传消息为 `cmd`。 |

示例如下：

```json
{
    "bodies": [
        {
            "action": "run",
            "type": "cmd"
        }
    ]
}
```

#### 自定义消息

自定义消息的 `bodies` 包含如下字段：

| 字段          | 类型   | 描述                                             |
| :------------ | :----- | :----------------------------------------------- |
| `customExts`  | JSON   | 自定义扩展属性。你可以自行设置扩展属性中的字段。 |
| `customEvent` | String | 自定义事件类型。                                 |
| `type`        | String | 消息类型。自定义消息为 `custom`。                |

自定义类型消息格式示例如下：

```json
    "bodies": [
        {
            "customExts": {
                "name": "flower",
                "size": "16",
                "price": "100"
            },
            "customEvent": "gift_1",
            "type": "custom"
        }
    ]
```




## 服务端消息撤回

应用管理员可撤回发送的消息。默认可撤回发出 2 分钟内的消息，如需调整请联系 [sales@agora.io](mailto:sales@agora.io)。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/messages/msg_recall
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                                                                                          | 是否必填 |
| :-------------- | :----- | :-------------------------------------------------------------------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。   | 是  |
| `Accept`   | String | 内容类型。填入 `application/json`。   | 是  |
| `Authorization` | String | `Bearer ${Your App Token}` Bearer 是固定字符，后面加英文空格，再加上获取到的 App Token 的值。 | 是       |

#### 请求 body

| 参数        | 类型   | 描述                                                                                                                                                                                                                      | 是否必填 |
| :---------- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :------- |
| `msg_id`    | String | 要撤回消息的消息 ID。      | 是       |
| `to`        | String | 要撤回消息的接收方。<ul><li>单聊为接收方用户 ID；</li><li>群聊为群组 ID；</li><li>聊天室聊天为聊天室 ID。</li><li>若不传入该参数，请求失败。</li></ul>       | 是       |
| `chat_type` | String | 要撤回消息的会话类型：<ul><li>`chat`：单聊</li><li>`groupchat`：群聊 </li><li>`chatroom`：聊天室 </li></ul>  | 是       |
| `from`      | String | 消息撤回方的用户 ID。若不传该参数，默认为 `admin`。      | 否       |
| `force`     | Boolean   | 是否为强制撤回：<ul><li>`true`：是，支持撤回超过服务器存储时间的消息。具体见[服务器消息保存时长](./agora_chat_limitation#消息存储时长)。</li><li>`false`：否，不支持撤回超过服务器存储时间的消息。</li></ul> | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 参数       | 类型   | 描述                                                                                              |
| :--------- | :----- | :------------------------------------------------------------------------------------------------ |
| `msg_id`   | String | 需要撤回的消息 ID。       |
| `recalled` | String | 消息撤回结果，成功是 `yes`。      |
| `from`     | String | 消息撤回方。           |
| `to`       | String | 撤回消息的送达方：<ul><li>单聊为送达方用户 ID；</li><li>群聊为群组 ID。</li></ul>  |
| `chattype` | String | 撤回消息的会话类型：<ul><li>`chat`：单聊</li><li>`groupchat`：群聊</li><li>`chatroom`：聊天室</li></ul>  |

其他参数及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -i -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H "Authorization: Bearer <YourAppToken>"
"http://XXXX/XXXX/XXXX/messages/msg_recall"
-d '{
    "msg_id": "1028442084794698104",
    "to": "user2",
    "from": "user1",
    "chat_type": "chat",
    "force": true
}'
```

#### 响应示例

撤销成功：

```json
{
  "path": "/messages/msg_recall",
  "uri": "https://XXXX/XXXX/XXXX/messages/msg_recall",
  "timestamp": 1657529588473,
  "organization": "XXXX",
  "application": "09ebbf8b-XXXX-XXXX-XXXX-d47c3b38e434",
  "action": "post",
  "data": {
    "recalled": "yes",
    "chattype": "chat",
    "from": "XXXX",
    "to": "XXXX",
    "msg_id": "1028442084794698104"
  },
  "duration": 8,
  "applicationName": "XXXX"
}
```

`recalled`：消撤回失败的可能原因包含以下几种情况：

- "can’t find msg to"：未找到撤回消息的接收⽅；
- "exceed recall time limit"：消息撤回超时；
- "not_found msg"：消息过期或已被撤回；
- "internal error"：后端服务出现异常。

```json
{
    "msgs":
    [
        { "msg_id":"673296835082717140",
            "recalled":"not_found msg"
        }
    ]
}
```

## 服务端单向删除会话

该方法使聊天用户能够从服务器中删除会话。删除会话后，该用户将从服务器获取不到该会话。该会话的其他参与聊天用户仍然可以从服务器获取会话内容。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/users/{username}/user_channel
```

#### 路径参数

| 参数       | 类型   | 描述                                      | 是否必填 |
| :--------- | :----- | :---------------------------------------- | :------- |
| `username` | String | 要删除会话的用户的唯一标识符，即用户 ID。 | 是       |

其他参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                                                                                          | 是否必填 |
| :-------------- | :----- | :-------------------------------------------------------------------------------------------- | :------- |
| `Authorization` | String | `Bearer ${Your App Token}` Bearer 是固定字符，后面加英文空格，再加上获取到的 App Token 的值。 | 是       |

#### 请求 body

| 参数          | 类型   | 描述                                                               | 是否必填 |
| :------------ | :----- | :----------------------------------------------------------------- | :------- |
| `channel`     | String | 要删除的会话 ID。该参数的值取决于会话类型 `type` 的值:<ul><li>`type` 为 `chat`，即单聊时，会话 ID 为对端用户 ID；</li><li>`type` 为 `groupchat`，即群聊时，会话 ID 为群组 ID。</li></ul>  | 是  |
| `type`        | String | 会话类型。<ul><li>`chat`：单聊</li><li>`groupchat`：群聊</li></ul> | 是       |
| `delete_roam` | Boolean   | 是否删除服务端消息。<ul><li>`true`：是。若删除了该会话的服务端消息，则用户无法从服务器拉取该会话的漫游消息。</li><li>`false`：否。用户仍可以从服务器拉取该会话的漫游消息。</li></ul>  | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型   | 描述                                                  |
| :------- | :----- | :---------------------------------------------------- |
| `result` | String | 删除结果，`ok` 表示成功，失败则直接返回错误码和原因。 |

其他参数及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X DELETE -H "Authorization: Bearer <YourAppToken>" "https://XXXX/XXXX/XXXX/users/u1/user_channel" -d '{"channel":"u2", "type":"chat"，"delete_roam": true}'
```

#### 响应示例

```json
{
    "path": "/users/user_channel",
    "uri": "https://XXXX/XXXX/XXXX/users/u1/user_channel",
    "timestamp": 1638440544078,
    "organization": "XXXX",
    "application": "c3624975-XXXX-XXXX-9da2-ee91ed4c5a76",
    "entities": [],
    "action": "delete",
    "data": {
        "result": "ok"
    },
    "duration": 3,
    "applicationName": "XXXX"
}
```

## 导入单聊消息

该接口用于数据迁移时单聊消息的批量导入。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/messages/users/import
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                                                                                          | 是否必填 |
| :-------------- | :----- | :-------------------------------------------------------------------------------------------- | :------- |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

#### 请求 body

| 参数            | 类型   | 描述                       | 是否必填 |
| :-------------- | :----- | :------------------------------------------ | :------- |
| `from`          | String | 消息发送方的用户 ID。                                                                                                                                                                                                        | 是       |
| `target`        | String | 消息接收方的用户 ID。                                                                                                                                                                                                        | 是       |
| `type`          | String | 消息类型：<ul><li>`txt`：文本消息</li><li>`img`：图片消息</li><li>`audio`：语音消息</li><li>`video`：视频消息</li><li>`file`：文件消息</li><li>`loc`：位置消息</li><li>`cmd`：透传消息</li><li>`custom`：自定义消息</li></ul> | 是       |
| `body`          | JSON   | 消息内容。                                                                                                                                                                                                                   | 是       |
| `is_ack_read`   | Boolean   | 是否设置消息为已读。<ul><li>`true`：是；</li><li>`false`：否。</li></ul>                                                                                                                                                                | 否       |
| `msg_timestamp` | Number  | 要导入的消息的时间戳，单位为毫秒。若不传该参数，声网服务器会将导入的消息的时间戳设置为当前时间。  | 否       |
| `need_download` | Boolean   | 是否需要下载附件并上传到服务器。<ul><li>`true`：是</li><li>（默认）`false`：否</li></ul>       | 否       |

与发送消息类似，不同类型的消息只是 `body` 字段内容存在差异。详见 [body 字段说明](#msg)。

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型   | 描述                    |
| :------- | :----- | :---------------------- |
| `msg_id` | String | 导入消息返回的消息 ID。 |

其他参数及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 导入文本消息
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H "Authorization: Bearer <YourAppToken>" "https://XXXX/XXXX/XXXX/messages/users/import" -d '{
    "target": "username2",
    "type": "txt",
    "body": {
        "msg": "import message."
    },
    "from": "username1",
    "is_ack_read": true,
    "msg_timestamp": 1656906628428
}'
```

```shell
# 导入图片消息
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H "Authorization: Bearer <YourAppToken>" "https://XXXX/XXXX/XXXX/messages/users/import" -d '{
    "target": "username2",
    "type": "img",
    "body": {
        "url": "<YourImageUrl>",
        "filename": "<ImageFileName>",
        "size": {
            "width": 1080,
            "height": 1920
        }
    },
    "from": "username1",
    "is_ack_read": true,
    "msg_timestamp": 1656906628428,
    "need_download": true
}'
```

#### 响应示例

```json
{
    "path": "/messages/users/import",
    "uri": "https://XXXX/XXXX/XXXX/messages/users/import",
    "timestamp": 1638440544078,
    "organization": "XXXX",
    "application": "c3624975-XXXX-XXXX-9da2-ee91ed4c5a76",
    "entities": [],
    "action": "post",
    "data": {
        "msg_id": "10212123848595"
    },
    "duration": 3,
    "applicationName": "XXXX"
}
```

## 导入群聊消息

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/messages/chatgroups/import
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                                                                                          | 是否必填 |
| :-------------- | :----- | :-------------------------------------------------------------------------------------------- | :------- |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

#### 请求 body

| 参数            | 类型   | 描述                                                                                                                                                                                                                         | 是否必填 |
| :-------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `from`          | String | 消息发送方的用户 ID。                | 是       |
| `target`        | String | 群组 ID。                           | 是       |
| `type`          | String | 消息类型：<li>`txt`：文本消息<li>`img`：图片消息<li>`audio`：语音消息<li>`video`：视频消息<li>`file`：文件消息<li>`loc`：位置消息<li>`cmd`：透传消息<li>`custom`：自定义消息 | 是       |
| `body`          | JSON   | 消息内容。                                 | 是       |
| `is_ack_read`   | Boolean   | 是否设置消息为已读。<li>`true`：是<li>`false`：否           | 否       |
| `msg_timestamp` | Number  | 要导入的消息的时间戳，单位为毫秒。若不传该参数，服务器会将导入的消息的时间戳设置为当前时间。  | 否       |
| `need_download` | Boolean   | 是否需要下载附件并上传到服务器。<li>`true`：是<li>（默认）`false`：否       | 否       |

>与发送消息类似，不同类型的消息只是 `body` 字段内容存在差异。详见 [body 字段说明](#msg)。
### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型   | 描述                    |
| :------- | :----- | :---------------------- |
| `msg_id` | String | 导入消息返回的消息 ID。 |

其他参数及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 导入文本消息
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H "Authorization: Bearer <YourAppToken> " "https://XXXX/XXXX/XXXX/messages/chatgroups/import" -d '{
    "target": "username2",
    "type": "txt",
    "body": {
        "msg": "import message."
    },
    "from": "username1",
    "is_ack_read": true,
    "msg_timestamp": 1656906628428
}'
```

```shell
# 导入图片消息
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H "Authorization: Bearer <YourAppToken> " "https://XXXX/XXXX/XXXX/messages/chatgroups/import" -d '{
    "target": "username2",
    "type": "img",
    "body": {
        "url": "<YourImageUrl>",
        "filename": "<ImageFileName>",
        "size": {
            "width": 1080,
            "height": 1920
        }
    },
    "from": "username1",
    "is_ack_read": true,
    "msg_timestamp": 1656906628428,
    "need_download": true
}'
```

#### 响应示例

```json
{
    "path": "/messages/users/import",
    "uri": "https://XXXX/XXXX/XXXX/messages/chatgroups/import",
    "timestamp": 1638440544078,
    "organization": "XXXX",
    "application": "c3624975-XXXX-XXXX-9da2-ee91ed4c5a76",
    "entities": [],
    "action": "post",
    "data": {
        "msg_id": "10212123848595"
    },
    "duration": 3,
    "applicationName": "XXXX"
}
```

## 状态码

详见 [HTTP 状态码](./agora_chat_status_code?platform=RESTful)。