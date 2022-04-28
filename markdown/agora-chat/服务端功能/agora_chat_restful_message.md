本文展示如何调用 Agora 即时通讯 RESTful API 实现全类型的消息发送、文件上传下载以及历史消息查询。
调用以下方法前，请先参考[限制条件](./agora_chat_limitation?platform=RESTful#服务端调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

## <a name="param"></a>公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数：

### 请求参数

| 参数       | 类型   | 描述                                                                                                                                                                                                                                                        | 是否必填 |
| :--------- | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                         | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                    | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                           | 是       |
| `username` | String | 用户名。用户的唯一登录账号。长度在 64 个字符内，不可设置为空。支持以下字符集：<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 0-9<li>"\_", "-", "."<div class="alert note"><ul><li>不区分大小写。<li>同一个 app 下，用户名唯一。</ul></div> | 是       |

### 响应参数

| 参数              | 类型   | 描述                                                              |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action`          | String | 请求方式。                                                        |
| `organization`    | String | 即时通讯服务分配给每个企业（组织）的唯一标识。等同于 `org_name`。 |
| `application`     | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。             |
| `applicationName` | String | 即时通讯服务分配给每个 app 的唯一标识。等同于 `app_name`。        |
| `uri`             | String | 请求 URL。                                                        |
| `path`            | String | 请求路径，属于请求 URL 的一部分，无需关注。                       |
| `entities`        | JSON   | 返回实体信息。                                                    |
| `timestamp`       | Number | HTTP 响应的 Unix 时间戳（毫秒）。                                 |
| `duration`        | Number | 从发送 HTTP 请求到响应的时长（毫秒）。                            |

## 认证方式

Agora 即时通讯 RESTful API 要求 Bearer HTTP 认证。每次发送 HTTP 请求时，都必须在请求头部填入如下 `Authorization` 字段：

`Authorization`：Bearer ${YourAppToken}

为提高项目的安全性，Agora 使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯 RESTful API 仅支持使用 app token 的鉴权方式，详见[使用 App Token 鉴权](./generate_app_tokens?platform=RESTful)。

## <a name="sendmessage"></a>发送消息

用户到用户，或用户到群组的消息发送与接收，消息类型包括文本、图片、语音、视频、透传、扩展、文件、自定义消息。

请按照以下说明实现消息发送：

-   文本、透传、自定义消息：调用发送消息方法，在请求 body 中传入消息内容。
-   图片、语音、视频、文件消息：
    1. 调用[文件上传](#upload)方法上传图片、语音、视频或其他类型文件，并从响应 body 中获取文件 `uuid`。
    2. 调用发送消息方法，在请求 body 中传入该 `uuid`。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/messages
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

#### 请求 body

请求 body 为 JSON Object，包含以下字段：

| 字段          | 类型   | 描述                                                                                                                                                                                                                                                      | 是否必填 |
| :------------ | :----- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `target_type` | String | 消息接收方类型：<li>`users`：用户<li>`chatgroups`：群组<li>`chatrooms`：聊天室                                                                                                                                                                            | 是       |
| `target`      | List   | 消息接收方用户数组，数组长度必须在 600 以内。对于不同的 `target_type`，`target` 的值说明如下：<li>`target_type 为 users`：`target` 为用户名。<li>`target_type 为 chatgroups`：`target` 为群组 ID。 <li>`target_type 为 chatrooms`：`target` 为聊天室 ID。 | 是       |
| `msg`         | JSON   | 消息内容。对于不同消息类型，`msg` 包含的字段不同，详见 [msg 说明](#msg)。<div class="alert note"> 发送的消息大小必须在 5 KB 内，否则报错并返回错误码 `413` ，你可以将消息拆分后发送。</div>                                                               | 是       |
| `from`        | String | 消息发送方的用户名，不可为空。<br>如果不在请求 body 中传入该字段，则默认消息发送方为 `admin`。                                                                                                                                                            | 是       |
| `sync_device` | Bool   | 消息发送成功后，是否将消息同步到发送方。<li>`true`：是<li>（默认）`false`：否                                                                                                                                                                             | 否       |

#### <a name="msg"></a>msg 说明

**文本、透传消息**

| 字段   | 类型   | 描述                                             | 是否必填 |
| :----- | :----- | :----------------------------------------------- | :------- |
| `type` | String | 消息类型：<li>`txt`：文本消息<li>`cmd`：透传消息 | 是       |
| `msg`  | JSON   | 消息内容。                                       | 是       |

**图片消息**

| 字段       | 类型   | 描述                                                                                                                                                      | 是否必填                                                                |
| :--------- | :----- | :-------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------- |
| `filename` | String | 图片名称。                                                                                                                                                | 是                                                                      |
| `secret`   | String | 图片访问密钥，成功上传图片文件后，从[文件上传](#upload)的响应 body 中获取的 `share-secret`。                                                              | 如果文件上传时设置了文件访问限制（`restrict-access`），则该字段为必填。 |
| `size`     | JSON   | 图片尺寸，单位为像素，包含以下字段：<li>`height`：图片高度<li>`width`：图片宽度                                                                           | 是                                                                      |
| `url`      | String | 图片 URL 地址：`https://{host}/{org_name}/{app_name}/chatfiles/{uuid}`<br>`uuid` 为文件 ID，成功上传图片文件后，从[文件上传](#upload)的响应 body 中获取。 | 是                                                                      |
| `type`     | String | 消息类型。图片消息为 `img`。                                                                                                                              | 是                                                                      |

**语音消息**

| 字段       | 类型   | 描述                                                                                                                                                          | 是否必填                                                                |
| :--------- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------ | :---------------------------------------------------------------------- |
| `filename` | String | 图片名称。                                                                                                                                                    | 是                                                                      |
| `secret`   | String | 语音文件访问密钥，成功上传语音文件后，从[文件上传](#upload)的响应 body 中获取的 `share-secret`。                                                              | 如果文件上传时设置了文件访问限制（`restrict-access`），则该字段为必填。 |
| `Length`   | Int    | 语音文件时长，单位为秒。                                                                                                                                      | 是                                                                      |
| `url`      | String | 语音文件 URL 地址：`https://{host}/{org_name}/{app_name}/chatfiles/{uuid}`<br>`uuid` 为文件 ID，成功上传语音文件后，从[文件上传](#upload)的响应 body 中获取。 | 是                                                                      |
| `type`     | String | 消息类型。语音消息为 `audio`。                                                                                                                                | 是                                                                      |

**视频消息**

| 字段           | 类型           | 描述                                                                                                                                                                         | 是否必填                                                                      |
| :------------- | :------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------- |
| `thumb`        | String         | 视频缩略图 URL 地址：`https://{host}/{org_name}/{app_name}/chatfiles/{uuid}`<br>`uuid` 为视频缩略图唯一标识，成功上传缩略图文件后，从[文件上传](#upload)的响应 body 中获取。 | 是                                                                            |
| `length`       | Number         | 视频时长。单位为秒。                                                                                                                                                         | 是                                                                            |
| `secret`       | String         | 视频文件访问密钥，成功上传视频文件后，从[文件上传](#upload)的响应 body 中获取的 `share-secret`。                                                                             | 如果视频文件上传时设置了文件访问限制（`restrict-access`），则该字段为必填。   |
| `file_length`  | Long           | 视频文件大小。单位为字节。                                                                                                                                                   | 是                                                                            |
| `thumb_secret` | String         | 视频缩略图访问密钥，成功上传缩略图文件后，从[文件上传](#upload)的响应 body 中获取的 `share-secret`。                                                                         | 如果缩略图文件上传时设置了文件访问限制（`restrict-access`），则该字段为必填。 |
| `url`          | （必填）String | 视频文件 URL 地址：`https://{host}/{org_name}/{app_name}/chatfiles/{uuid}`<br>uuid 为文件 ID，成功上传视频文件后，从[文件上传](#upload)的响应 body 中获取。                  | 是                                                                            |
| `type`         | （必填）String | 消息类型。视频消息为 `video`。                                                                                                                                               | 是                                                                            |

**位置消息**

| 字段   | 类型   | 描述                       | 是否必填 |
| :----- | :----- | :------------------------- | :------- |
| `lat`  | String | 所在位置的纬度，单位为度。 | 是       |
| `lng`  | String | 所在位置的经度，单位为度。 | 是       |
| `addr` | String | 所在位置的具体描述。       | 是       |

**自定义消息**

| 参数          | 类型               | 描述                                                                                                                                                   | 是否必填 |
| :------------ | :----------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `customEvent` | String             | 用户自定义的事件类型。长度在 32 个字符内。支持的字符集如下：<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 0-9<li>"-", "\_", "/", "." | 否       |
| `customExts`  | Map<String,String> | 自定义事件属性。最多包含 16 个元素。                                                                                                                   | 否       |
| `from`        | String             | 消息发送方的用户名。不可为空。<br>如果不在请求 body 中传入该字段，则默认消息发送方用户名为 `admin`。                                                   | 是       |
| `ext`         | JSON               | 自定义扩展属性。不可为空。                                                                                                                             | 否       |
| `type`        | String             | 消息类型。自定义消息为 `custom`。                                                                                                                      | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应 body 包含如下字段：

| 字段   | 类型 | 描述                                                                                                |
| :----- | :--- | :-------------------------------------------------------------------------------------------------- |
| `data` | JSON | 返回数据详情。包含消息接收方用户名数组。<br>例如 `"user2" : "success"`，表示向 user2 发送消息成功。 |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

**文本消息**

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '
{
    "target_type": "users",
    "target": ["user2","user3"],
    "msg":
        {
            "type": "txt",
            "msg": "testmessage"
        },
    "from": "user1"
}'
'http://XXXX/XXXX/XXXX/messages'
```

**图片消息**

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST -i 'https://XXXX/XXXX/XXXX/messages' -H 'Authorization: Bearer <YourAppToken>' -d '
{
    "target_type":"users",
    "target":["user2"],
    "from":"user1",
    "msg":
        {
            "type":"img",
            "filename":"testimg.jpg",
            "secret":"VfEpSmSvEeS7yUXXXXXXXXXXXXpujTNfSTsrDt6eNb_",
            "url":"https://XXXX/XXXX/XXXX/chatfiles/55f12940-XXXX-XXXX-8a5b-ff2336f03252",
            "size":
                {
                    "width":480,
                    "height":720
                }
        }
}'
```

**语音消息**

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST -H "Authorization: Bearer <YourAppToken>" "https://XXXX/XXXX/XXXX/messages" -d '
{
    "target_type" : "users",
    "target" : [
        "user2",
        "user3"
    ],
    "msg" : {
        "type": "audio",
        "url": "https://XXXX/XXXX/XXXX/chatfiles/1dfc7f50-XXXX-XXXX-8a07-7d75b8fb3d42",
        "filename": "testaudio.amr",
        "length": 10,
        "secret": "Hfx_XXXXEeSdDW-SuX2EaZcXXXXEig3OgKZye9IzKOwoCjM"
    },
    "from" : "user1"
}'
```

**视频消息**

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST -i 'https://XXXX/XXXX/XXXX/messages' -H 'Authorization: Bearer <YourAppToken>' -d '
{
    "target_type":"users",
    "target":[
        "user2",
        "user3"
    ],
    "from":"user1",
    "msg":{
        "type":"video",
        "filename" : "testvideo.mp4",
        "thumb" : "https://a1.easemob.com/easemob-demo/testapp/chatfiles/67279b20-7f69-11e4-8eee-21d3334b3a97",
        "length" : 0,
        "secret":"VfEpSmSvEeS7yU8dwa9rAQc-DIL2HhmpujTNfSTsrDt6eNb_",
        "file_length" : 58103,
        "thumb_secret" : "ZyebKn9pEeSSfY03XXXXND24zXXXXs7HpPN1oMV-1JxN2O2I",
        "url" : "https://XXXX/XXXX/XXXX/chatfiles/671dfe30-XXXX-XXXX-ba67-8fef0d502f46"
    }
}'
```

**位置消息**

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '
{
    "target_type": "users",
    "target":[
        "user2"
    ],
    "msg": {
        "type": "loc",
        "lat": "39.966",
        "lng":"116.322",
        "addr":"test"
    },
    "from": "user1"
}' 'http://XXXX/XXXX/XXXX/messages'
```

**透传消息**

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST -H "Authorization:Bearer <YourAppToken>" -i "https://XXXX/XXXX/XXXX/messages" -d '
    {
        "target_type":"users",
        "target":
            [
                "user2",
                "user3"
            ],
        "msg":
            {
                "type":"cmd",
                "action":"action1"
            },
        "from":"user1"
}'
```

**自定义消息**

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -L -X POST 'https://XXXX/XXXX/XXXX/messages' -H 'Accept: application/json' -H 'Content-Type: application/json' -H 'Authorization: Bearer ${<YourAppToken>}' -d '
{
    "target_type":"users",
    "target":[
        "user2"
    ],
    "msg":{
            "type":"custom",
            "customEvent":"gift_1",
            "customExts":{
                "name":"flower",
                "size":"16",
                "price":"100"
                }
        },
    "from":"user1",
    "ext":{
        "attr1":"test"
    }
}'
```

**扩展消息**

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST -H "Authorization:Bearer <YourAppToken>" -i "https://a1.easemob.com/easemob-demo/testapp/messages" -d '
{
    "target_type":"users",
    "target":[
        "user2",
        "user3"],
    "msg":{
        "type":"txt",
        "msg":"testmessage"
    },
    "from":"user1",
    "ext":{
        "attr1":"test"
    }
}'
```

#### 响应示例

**文本消息**

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "path": "/messages",
    "uri": "https://XXXX/XXXX/XXXX/messages",
    "data": {
        "user2": "success",
        "user3": "success"
    },
    "timestamp": 1543922150902,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

**图片消息**

```json
{
    "action": "post",
    "application": "4d7e4ba0-XXXX-XXXX-90d5-e1ffbaacdaf5",
    "uri": "https://XXXX/XXXX/XXXX/messages",
    "entities": [],
    "data": {
        "user2": "success"
    },
    "timestamp": 1415166497129,
    "duration": 12,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

**语音消息**

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "path": "/messages",
    "uri": "https://XXXX/XXXX/XXXX/messages",
    "data": {
        "user2": "success",
        "user3": "success"
    },
    "timestamp": 1543922150902,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

**视频消息**

```json
{
    "action": "post",
    "application": "4d7e4ba0-XXXX-XXXX-90d5-e1ffbaacdaf5",
    "uri": "https://XXXX/XXXX/XXXX/messages",
    "entities": [],
    "data": {
        "user2": "success",
        "user3": "success"
    },
    "timestamp": 1415166234863,
    "duration": 5,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

**位置消息**

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "path": "/messages",
    "uri": "https://XXXX/XXXX/XXXX/messages",
    "data": {
        "user2": "success"
    },
    "timestamp": 1543922150902,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

**透传消息**

```json
{
    "action": "post",
    "application": "4d7e4ba0-XXXX-XXXX-90d5-e1ffbaacdaf5",
    "uri": "https://XXXX/XXXX/XXXX/messages",
    "entities": [],
    "data": {
        "user2": "success",
        "user3": "success"
    },
    "timestamp": 1415167842297,
    "duration": 4,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

**自定义消息**

```json
{
    "path": "/messages",
    "uri": "https://XXXX/XXXX/testapp/messages",
    "timestamp": 1597292981767,
    "organization": "XXXX",
    "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
    "action": "post",
    "data": {
        "user2": "success"
    },
    "duration": 0,
    "applicationName": "XXXX"
}
```

**扩展消息**

```json
{
    "action": "post",
    "application": "4d7e4ba0-XXXX-XXXX-90d5-e1ffbaacdaf5",
    "uri": "https://XXXX/XXXX/XXXX/messages",
    "entities": [],
    "data": {
        "user2": "success",
        "user3": "success"
    },
    "timestamp": 1415167842297,
    "duration": 4,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## <a name="upload"></a>文件上传

上传图片、语音、视频或其他类型文件。请在调用文件上传方法前阅读以下说明：

-   即时通讯支持对上传的文件限制访问，该功能开启后，你需要通过密钥才能下载被限制访问的文件。
-   上传图片或视频文件时，即时通讯服务会在服务端创建图片或视频的缩略图，以供下载文件时预览。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatfiles
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数              | 类型   | 描述                                                                                                                                                                                                                   | 是否必填 |
| :---------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `Content-Type`    | String | `multipart/form-data`                                                                                                                                                                                                  | 是       |
| `Authorization`   | String | Bearer ${YourAppToken}                                                                                                                                                                                                 | 是       |
| `restrict-access` | Bool   | 限制访问该文件。<li>传入该参数：无论字段值为 `true` 或 `false`，均表示限制访问。用户需要通过响应 body 中获取的文件访问密钥（`share-secret）`才能下载该文件。<li>不传入该参数：表示不限制访问。用户可以直接下载该文件。 | 否       |

#### 请求 body

请求 body 为 form-data 类型，包含以下字段：

| 字段  | 类型   | 描述                                                                                           | 是否必填 |
| :---- | :----- | :--------------------------------------------------------------------------------------------- | :------- |
| Key   | String | `file`                                                                                         | 是       |
| Value | String | 待上传文件的本地路径。<br>你可以在 Postman 中直接选择上传本地文件。文件大小必须在 10 MB 以内。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 中包含以下字段：

| 字段                    | 类型   | 描述                                                                                                                 |
| :---------------------- | :----- | :------------------------------------------------------------------------------------------------------------------- |
| `entities.uuid`         | String | 文件 ID，即时通讯服务分配给该文件的唯一标识符。<br>你需要自行保存该 `uuid`，以便[发送文件消息](#sendmessage)时使用。 |
| `entities.type`         | String | 文件类型：`chatfile`。                                                                                               |
| `entities.share-secret` | String | 文件访问密钥。<br>你需要自行保存 `share-secret`，以便[下载文件](#download)时使用。                                   |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token，将 file 的路径替换为待上传文件所在的本地完整路径
curl -X POST https://XXXX/XXXX/XXXX/chatfiles -H 'Authorization: Bearer <YourAppToken>' -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW'  -H 'restrict-access: true' -F file=@/Users/test/9.2/agora/image/IMG_2953.JPG
```

#### 响应示例

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "path": "/chatfiles",
    "uri": "https://XXXX/XXXX/XXXX/chatfiles",
    "entities": [
        {
            "uuid": "5fd74830-XXXX-XXXX-822a-81ea50bb049d",
            "type": "chatfile",
            "share-secret": "X9dIOla-EemnXXXXtUZLGyqG9Y-XXXX_ysw27NqTV1_g7Yc"
        }
    ],
    "timestamp": 1554371126338,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## <a name="download"></a>文件下载

下载图片、语音、视频或其他类型文件。

### HTTP 请求

```http
GET https://{HOST}/{org_name}/{app_name}/chatfiles/{uuid}
```

#### 路径参数

| 参数   | 类型   | 描述                                                                                                     | 是否必填 |
| :----- | :----- | :------------------------------------------------------------------------------------------------------- | :------- |
| `uuid` | String | 文件 ID，即时通讯系统分配给该文件的唯一标识符。成功上传文件后，从[文件上传](#upload)的响应 body 中获取。 | 是       |

其他参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                                                                                                                                                                         | 是否必填                                                                |
| :-------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------- |
| `Accept`        | String | `application/octet-stream`，表示下载二进制数据流格式的文件。                                                                                                                 | 是                                                                      |
| `Authorization` | String | Bearer ${YourAppToken}                                                                                                                                                       | 是                                                                      |
| `share-secret`  | String | 文件访问密钥。成功上传文件后，从[文件上传](#upload)的响应 body 中获取。                                                                                                      | 如果文件上传时设置了文件访问限制（`restrict-access`），则该字段为必填。 |
| `thumbnail`     | Bool   | 如果待下载文件的类型为图片或视频，你可以下载图片或视频的缩略图：<li>传入该参数：无论字段值为 `true` 或 `false`，均表示下载缩略图。<li>不传入该参数：表示下载图片或视频文件。 | 否                                                                      |

### HTTP 响应

如果返回的 HTTP 状态码为 `200`，表示请求成功，返回文件二进制数据流。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X GET -H 'Accept: application/octet-stream' -H 'Authorization: Bearer <YourAppToken>' -H 'share-secret: f0Vr-uyyEeiHpHmsu53XXXXXXXXZYgyLkdfsZ4xo2Z0cSBnB' 'http://XXXX/XXXX/XXXX/chatfiles/7f456bf0-XXXX-XXXX-b630-777db304f26c'
```

## 查询历史消息

获取用户发送和接收的历史消息。

-   一次请求获取从指定起始时间开始一小时内的全部历史消息。
-   历史消息生成时间约为一小时，你需要距离所要查询时间段一小时后进行历史消息查询。
-   对于不同的套餐版本，历史消息默认存储时间不同。详见[套餐包详情](./agora_chat_plan?platform=RESTful)。

### HTTP 请求

```http
GET https://{HOST}/{org_name}/{app_name}/chatmessages/${time}
```

#### 路径参数

| 参数   | 类型   | 描述                                                                                                                                                                                  | 是否必填 |
| :----- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :------- |
| `time` | String | 历史消息起始时间。UTC 时间，使用 ISO8601 标准，格式为 `yyyyMMddHH`。<br>例如 `time` 为` 2018112717`，则表示查询 2018 年 11 月 27 日 17 时至 2018 年 11 月 27 日 18 时期间的历史消息。 | 是       |

其他参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 描述                   | 是否必填 |
| :-------------- | :--------------------- | :------- |
| `Content-Type`  | `application/json`     | 是       |
| `Authorization` | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 中包含字段如下：

| 参数       | 类型   | 描述                                                                                                                                                                                                                                          |
| :--------- | :----- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `data.url` | String | 历史消息文件下载地址。<li>`url` 由历史消息文件存储地址、到期 Unix 时间戳（`Expires`）、第三方云存储访问密钥（`OSSAccessKeyId`）、第三方云存储验证签名（`Signature`）组成。<li>URL 仅在 `Expires` 前内有效，一旦过期需调用该方法重新获取 URL。 |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatmessages/2018112717'
```

#### 响应示例

```json
{
    "action": "get",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatmessages/2018112717",
    "data": [
        {
            "url": "http://XXXX?Expires=1543316122&OSSAccessKeyId=XXXX&Signature=XXXX"
        }
    ],
    "timestamp": 1543314322601,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

### 历史消息内容

查询历史消息成功后，你可以访问 URL 下载历史消息文件，查看历史消息具体内容。

历史消息为 JSON 类型，示例如下：

```json
{
    "msg_id": "5I02W-XX-8278a",
    "timestamp": 1403099033211,
    "direction": "outgoing",
    "to": "XXXX",
    "from": "XXXX",
    "chat_type": "chat",
    "payload": {
        "bodies": [
            {...}
        ],
        "ext": {
            "key1": "value1",
            ...
        },
        "from": "zw123",
        "to": "XXXX"
    }
}
```

历史消息包含以下字段：

| 字段             | 类型   | 描述                                                                                                                               |
| :--------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------- |
| `msg_id`         | String | 消息 ID。一次消息发送请求的唯一标识。                                                                                              |
| `timestamp`      | Number | 消息发送完成的 Unix 时间戳（毫秒），UTC 时间。                                                                                     |
| `direction`      | String | 消息发送方向：<li>`incoming`：上行消息，用户向即时通讯服务器发送的消息。<li>`outgoing`：下行消息，即时通讯服务器下发到用户的消息。 |
| `from`           | String | 消息发送方的用户名。                                                                                                               |
| `to`             | String | 消息接收方的用户名或群组 ID。                                                                                                      |
| `chat_type`      | String | 聊天方式：<li>`chat`：单聊<li>`groupchat`：群聊<li>`chatroom`：聊天室                                                              |
| `payload`        | JSON   | 包含消息的具体内容。例如消息扩展信息、自定义扩展属性等。                                                                           |
| `payload.bodies` | JSON   | 具体的消息内容，详见以下每个消息类型的 `bodies`。                                                                                  |

#### 文本消息

文本消息的 `bodies` 包含如下字段：

| 字段   | 类型   | 描述                             |
| :----- | :----- | :------------------------------- |
| `msg`  | String | 消息内容。                       |
| `type` | String | 消息类型，文本消息类型为 `txt`。 |

示例

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
| `secret`      | String | 图片文件访问密钥。<br>如果[文件上传](#upload)时设置了文件访问限制，则该字段存在。 |
| `size`        | Number | 图片的尺寸。单位为像素。<li>`height`：图片高度<li>`width`：图片宽度               |
| `type`        | String | 消息类型。图片消息为 `img`。                                                      |
| `url`         | String | 图片 URL 地址。                                                                   |

示例

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

示例

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
| `file_length` | Number | 语音附件大小。单位为字节。                                                        |
| `filename`    | String | 带文件格式后缀的语音文件名称。                                                    |
| `secret`      | String | 语音文件访问密钥。<br>如果[文件上传](#upload)时设置了文件访问限制，则该字段存在。 |
| `length`      | Number | 语音时长。单位为秒。                                                              |
| `type`        | String | 消息类型。位置消息为 `audio`。                                                    |
| `url`         | String | 语音文件 URL 地址。                                                               |

示例

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
| `secret`       | String | 视频文件访问密钥。<br>如果[文件上传](#upload)时设置了文件访问限制，则该字段存在。   |
| `length`       | Number | 视频时长。单位为秒。                                                                |
| `size`         | Number | 视频缩略图尺寸。单位为像素。<li>`width`：视频缩略图宽度<li>`height`：视频缩略图高度 |
| `thumb`        | String | 视频缩略图 URL 地址。                                                               |
| `thumb_secret` | String | 缩略图文件访问密钥。<br>如果[文件上传](#upload)时设置了文件访问限制，则该字段存在。 |
| `type`         | String | 消息类型。视频消息为 `video`。                                                      |
| `url`          | String | 视频文件 URL 地址。你可以访问该 URL 下载视频文件。                                  |

示例

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

| 字段          | 类型   | 说明                                                                          |
| :------------ | :----- | :---------------------------------------------------------------------------- |
| `file_length` | Number | 文件大小。单位为字节。                                                        |
| `filename`    | String | 带文件格式后缀的文件名称。                                                    |
| `secret`      | String | 文件访问密钥。<br>如果[文件上传](#upload)时设置了文件访问限制，则该字段存在。 |
| `type`        | String | 消息类型。文件消息为 `file`。                                                 |
| `url`         | String | 文件的 URL 地址。你可以访问该 URL 下载历史消息文件。                          |

示例

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
| `action` | String | 自定义请求方式。             |
| `type`   | String | 消息类型。透传消息为 `cmd`。 |

示例

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

自定义类型消息格式示例

```json
{
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
}
```