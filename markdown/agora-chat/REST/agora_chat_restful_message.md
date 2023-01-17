本文展示如何调用即时通讯 RESTful API 实现全类型的消息发送、文件上传下载以及历史消息查询。
调用以下方法前，请先参考 [限制条件](./agora_chat_limitation?platform=RESTful#服务端调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

## <a name="param"></a>公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数：

### 请求参数

| 参数       | 类型   | 描述                                                                                                                                                                     | 是否必填 |
| :--------- | :----- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。      | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。        | 是       |
| `username` | String | 用户 ID。        | 是       |

### 响应参数

| 参数              | 类型   | 描述                                                              |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action`          | String | 请求方式，即接口方法名。                                          |
| `organization`    | String | 即时通讯服务分配给每个企业（组织）的唯一标识。等同于 `org_name`。 |
| `application`     | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。             |
| `applicationName` | String | 即时通讯服务分配给每个 app 的唯一标识。等同于 `app_name`。        |
| `uri`             | String | 请求 URL。                                                        |
| `path`            | String | 请求路径，属于请求 URL 的一部分，无需关注。                       |
| `entities`        | JSON   | 返回实体信息。                                                    |
| `timestamp`       | Number | HTTP 响应的 Unix 时间戳（毫秒）。                                 |
| `duration`        | Number | 从发送 HTTP 请求到响应的时长（毫秒）。                            |

## 认证方式

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

## <a name="sendmessage"></a>发送消息

在服务端实现用户到用户，用户到群组或用户到聊天室的消息发送与接收。消息类型包括文本、图片、语音、视频、透传以及自定义消息。

请按照以下说明实现消息发送：

- 文本、透传、自定义消息：调用发送消息方法，在请求 body 中传入消息内容。
- 图片、语音、视频、文件消息：
    1. 调用 [文件上传](#upload)方法上传图片、语音、视频或其他类型文件，并从响应 body 中获取文件 `uuid`。
    2. 调用发送消息方法，在请求 body 中传入该 `uuid`。

调用服务端接口发送消息时，可选的 `from` 字段用于指定发送方。

此外，消息支持扩展属性 `ext`，可添加自定义信息。同时，推送通知也支持自定义扩展字段，详见 [APNs 自定义显示](TO DO:加链接#自定义显示) 和 [Android 推送字段说明](加链接#自定义显示)。

**注意**

在调用程序中，请求体若超过 5 KB 会导致 413 错误，需要拆成几个更小的请求体重试。同时，请求体和扩展字段的总长度不能超过 3 KB。

### 发送单聊消息

此方法可向单个用户发送消息。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/messages/users
```

##### 路径参数

参数及说明详见 [公共参数](#param)。

##### 请求 header

|      参数       | 类型   |                                             描述                                              | 是否必填 |
| :-------------: | :----- | :-------------------------------------------------------------------------------------------: | :------: |
| `Content-Type`  | String |                              内容类型。请填 `application/json`。                              |    是    |
|    `Accept`     | String |                              内容类型。请填 `application/json`。                              |    是    |
| `Authorization` | String | `Bearer ${Your App Token}` Bearer 是固定字符，后面加英文空格，再加上获取到的 App Token 的值。 |    是    |

#### 通用请求体

通用请求体为 JSON 对象，是所有消息的外层结构。不同类型的消息只是 `body` 字段内容存在差异。

| 参数          | 类型   | 描述                                                                                                                                                                                                                         | 是否必填 |
| :------------ | :----- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `from`        | String | 消息发送方的用户 ID。若不传入该字段，服务器默认设置为管理员，即 “admin”；若传入字段但值为空字符串 (“”)，请求失败。                                                                                                           | 否       |
| `to`          | List   | 消息接收方的用户 ID 数组。每次可发送的接收方用户上限为 600 人，即 600 条消息。每分钟最多可向 6000 个用户发送信息。                                                                                                           | 是       |
| `type`        | String | 消息类型：<li>`txt`：文本消息；<li>`img`：图片消息；<li>`audio`：语音消息；<li>`video`：视频消息；<li>`file`：文件消息；<li>`loc`：位置消息；<li>`cmd`：透传消息；<li>`custom`：自定义消息。 | 是       |
| `body`        | JSON   | 消息内容。对于不同消息类型 ，body 包含的字段不同，详情见下表。                                                                                                                                                               | 是       |
| `sync_device` | Bool   | 消息发送成功后，是否将消息同步到发送方。<li>`true`：是；<li>（默认）`false`：否。                                                                                                                                    | 否       |
| `routetype`   | String | 若传入该参数，其值为 “ROUTE_ONLINE”，表示只有接收方在线时，消息才能成功发送；若接收方离线，消息发送失败。若不传入该字段，接收方离线时，消息也能成功发送。                                                                    | 否       |
| `ext`         | JSON   | 消息支持扩展字段，可添加自定义信息。同时，推送通知也支持自定义扩展字段，详见 [APNs 自定义显示](#自定义显示) 和 [Android 推送字段说明](#自定义显示)。                                                                         | 否       |

#### <a name="msg"></a>body 字段说明

##### 文本消息

| 参数  | 类型   | 描述       | 是否必填 |
| :---- | :----- | :--------- | :------- |
| `msg` | String | 消息内容。 | 是       |

##### 图片消息

| 字段       | 类型   | 描述                                                                                                                                                      | 是否必填                                                                |
| :--------- | :----- | :-------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------- |
| `filename` | String | 图片名称。                                                                                                                                                | 是                                                                      |
| `secret`   | String | 图片访问密钥，成功上传图片文件后，从[文件上传](#upload)的响应 body 中获取的 `share-secret`。                                                              | 如果文件上传时设置了文件访问限制（`restrict-access`），则该字段为必填。 |
| `size`     | JSON   | 图片尺寸，单位为像素，包含以下字段：<li>`height`：图片高度<li>`width`：图片宽度                                                                           | 是                                                                      |
| `url`      | String | 图片 URL 地址：`https://{host}/{org_name}/{app_name}/chatfiles/{file_uuid}`<br/>`file_uuid` 为文件 ID，成功上传图片文件后，从[文件上传](#upload)的响应 body 中获取。 | 是                                                                      |

##### 语音消息

| 字段       | 类型   | 描述                                                                                                                                                          | 是否必填                                                                |
| :--------- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------ | :---------------------------------------------------------------------- |
| `filename` | String | 语音文件的名称。                                                                                                                                              | 是                                                                      |
| `secret`   | String | 语音文件访问密钥，成功上传语音文件后，从[文件上传](#upload)的响应 body 中获取的 `share-secret`。                                                              | 如果文件上传时设置了文件访问限制（`restrict-access`），则该字段为必填。 |
| `Length`   | Int    | 语音文件时长，单位为秒。                                                                                                                                      | 是                                                                      |
| `url`      | String | 语音文件 URL 地址：`https://{host}/{org_name}/{app_name}/chatfiles/{file_uuid}`<br/>`file_uuid` 为文件 ID，成功上传语音文件后，从[文件上传](#upload)的响应 body 中获取。 | 是                                                                      |

##### 视频消息

| 字段           | 类型   | 描述                                                                                                                                                                         | 是否必填                                                                      |
| :------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------- |
| `thumb`        | String | 视频缩略图 URL 地址：`https://{host}/{org_name}/{app_name}/chatfiles/{file_uuid}`<br/>`file_uuid` 为视频缩略图唯一标识，成功上传缩略图文件后，从[文件上传](#upload)的响应 body 中获取。 | 是                                                                            |
| `length`       | Number | 视频时长。单位为秒。                                                                                                                                                         | 是                                                                            |
| `secret`       | String | 视频文件访问密钥，成功上传视频文件后，从[文件上传](#upload)的响应 body 中获取的 `share-secret`。                                                                             | 如果视频文件上传时设置了文件访问限制（`restrict-access`），则该字段为必填。   |
| `file_length`  | Long   | 视频文件大小。单位为字节。                                                                                                                                                   | 是                                                                            |
| `thumb_secret` | String | 视频缩略图访问密钥，成功上传缩略图文件后，从[文件上传](#upload)的响应 body 中获取的 `share-secret`。                                                                         | 如果缩略图文件上传时设置了文件访问限制（`restrict-access`），则该字段为必填。 |
| `url`          | String | 视频文件 URL 地址：`https://{host}/{org_name}/{app_name}/chatfiles/{file_uuid}`<br/>`file_uuid` 为文件 ID，成功上传视频文件后，从[文件上传](#upload)的响应 body 中获取。                  | 是                                                                            |

##### 文件消息

| 参数       | 类型   | 描述                                                                                                                                                    | 是否必需                                                                    |
| :--------- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------ | :-------------------------------------------------------------------------- |
| `filename` | String | 文件名称。                                                                                                                                              | 是                                                                          |
| `secret`   | String | 文件访问密钥，成功上传文件后，从 [文件上传](#upload)的响应 body 中获取的 `share-secret`。                                                               | 如果视频文件上传时设置了文件访问限制（`restrict-access`），则该字段为必填。 |
| `url`      | String | 文件 URL 地址：`https://{host}/{org_name}/{app_name}/chatfiles/{file_uuid}`<br/>`file_uuid` 为文件 ID，成功上传视频文件后，从[文件上传](#upload)的响应 body 中获取。 | 是                                                                          |
##### 位置消息

| 字段   | 类型   | 描述                       | 是否必填 |
| :----- | :----- | :------------------------- | :------- |
| `lat`  | String | 所在位置的纬度，单位为度。 | 是       |
| `lng`  | String | 所在位置的经度，单位为度。 | 是       |
| `addr` | String | 所在位置的具体文字描述。   | 是       |

##### 透传消息

| 参数     | 类型   | 描述       | 是否必填 |
| :------- | :----- | :--------- | :------- |
| `action` | String | 命令内容。 | 是       |

##### 自定义消息

| 参数          | 类型               | 描述                                                                                                                                                   | 是否必填 |
| :------------ | :----------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `customEvent` | String             | 用户自定义的事件类型。长度在 32 个字符内。支持的字符集如下：<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 0-9<li>"-", "\_", "/", "." | 否       |
| `customExts`  | Map<String,String> | 自定义事件属性。最多包含 16 个元素。                                                                                                                   | 否       |
| `from`        | String             | 消息发送方的用户 ID。不可为空。<br/>如果不在请求 body 中传入该字段，则默认消息发送方用户 ID为 `admin`。                                                   | 是       |
| `ext`         | JSON               | 自定义扩展属性。不可为空。                                                                                                                             | 否       |
| `type`        | String             | 消息类型。自定义消息为 `custom`。                                                                                                                      | 是       |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应 body 包含如下字段：

| 字段   | 类型 | 描述                                                                                                                                                                         |
| :----- | :--- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `data` | JSON | 返回数据详情。该字段的值为包含接收方用户 ID 和 发送的消息的 ID 的键值对。<br/>例如 "user2": "1029457500870543736"，表示向 user2 发送了消息 ID 为1029457500870543736 的消息。 |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

###### 文本消息

发送给目标用户，消息无需同步给发送方：

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'http://XXXX/XXXX/XXXX/messages/users' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["user2"],"type": "txt","body": {"msg": "testmessages"}}'
```

仅发送给在线用户，消息同步给发送方：

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'http://XXXX/XXXX/XXXX/messages/users' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["user2"],"type": "txt","body": {"msg": "testmessages"},"routetype":"ROUTE_ONLINE", "sync_device":true}'
```

###### 图片消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'https://XXXX/XXXX/XXXX/messages/users' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["user2"],"type": "img","body": {"filename":"testimg.jpg","secret":"VfXXXXNb_","url":"https://XXXX/XXXX/XXXX/chatfiles/55f12940-XXXX-XXXX-8a5b-ff2336f03252","size":{"width":480,"height":720}}}'
```

###### 语音消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'https://XXXX/XXXX/XXXX/messages/users' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["user2"],"type": "audio","body": {"url": "https://XXXX/XXXX/XXXX/chatfiles/1dfc7f50-XXXX-XXXX-8a07-7d75b8fb3d42","filename": "testaudio.amr","length": 10,"secret": "HfXXXXCjM"}}'
```

###### 视频消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'https://XXXX/XXXX/XXXX/messages/users' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d  '{"from": "user1","to": ["user2"],"type": "video","body": {"thumb" : "https://XXXX/XXXX/XXXX/chatfiles/67279b20-7f69-11e4-8eee-21d3334b3a97","length" : 0,"secret":"VfXXXXNb_","file_length" : 58103,"thumb_secret" : "ZyXXXX2I","url" : "https://XXXX/XXXX/XXXX/chatfiles/671dfe30-XXXX-XXXX-ba67-8fef0d502f46"}}'
```

###### 文件消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'https://XXXX/XXXX/XXXX/messages/users' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["user2"],"type": "file","body": {"filename":"test.txt","secret":"1-g0XXXXua","url":"https://XXXX/XXXX/XXXX/chatfiles/d7eXXXX7444"}}'
```

###### 位置消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i "https://XXXX/XXXX/XXXX/messages/users"  -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["user2"],"type": "loc","body":{"lat": "39.966","lng":"116.322","addr":"中国北京市海淀区中关村"}}'
```

###### 透传消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i "https://XXXX/XXXX/XXXX/messages/users" -H 'Content-Type: application/json' -H 'Accept: application/json'  -H "Authorization:Bearer <YourAppToken>" -d '{"from": "user1","to": ["user2"],"type": "cmd","body":{"action":"action1"}}'
```

###### 自定义消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i "https://XXXX/XXXX/XXXX/messages/users" -H 'Content-Type: application/json' -H 'Accept: application/json'  -H "Authorization:Bearer <YourAppToken>" -d '{"from": "user1","to": ["user2"],"type": "custom","body": {"customEvent": "custom_event"}}'
```

##### 响应示例

###### 文本消息

```json
{
  "path": "/messages/users",
  "uri": "https://XXXX/XXXX/XXXX/messages/users",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "user2": "1029457500870543736"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 图片消息

```json
{
  "path": "/messages/users",
  "uri": "https://XXXX/XXXX/XXXX/messages/users",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "user2": "1029457500870543736"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 语音消息

```json
{
  "path": "/messages/users",
  "uri": "https://XXXX/XXXX/XXXX/messages/users",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "user2": "1029457500870543736"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 视频消息

```json
{
  "path": "/messages/users",
  "uri": "https://XXXX/XXXX/XXXX/messages/users",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "user2": "1029457500870543736"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 文件消息

```json
{
  "path": "/messages/users",
  "uri": "https://XXXX/XXXX/XXXX/messages/users",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "user2": "1029457500870543736"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 位置消息

```json
{
  "path": "/messages/users",
  "uri": "https://XXXX/XXXX/XXXX/messages/users",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "user2": "1029457500870543736"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 透传消息

```json
{
  "path": "/messages/users",
  "uri": "https://XXXX/XXXX/XXXX/messages/users",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "user2": "1029457500870543736"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 自定义消息

```json
{
    "path": "/messages/users",
    "uri": "https://XXXX/XXXX/XXXX/messages/users",
    "timestamp": 1657254052191,
    "organization": "XXXX",
    "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
    "action": "post",
    "data": {
        "user2": "1029457500870543736"
    },
    "duration": 0,
    "applicationName": "XXXX"
}
```

### 发送群聊消息

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/messages/chatgroups
```

#### 路径参数

参数及说明详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                                                                                          | 是否必填 |
| :-------------- | :----- | :-------------------------------------------------------------------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。请填 `application/json`。                                                           | 是       |
| `Accept`        | String | 内容类型。请填 `application/json`。                                                           | 是       |
| `Authorization` | String | `Bearer ${Your App Token}` Bearer 是固定字符，后面加英文空格，再加上获取到的 App Token 的值。 | 是       |

#### 通用请求体

通用请求体为 JSON 对象，是所有消息的外层结构。

| 参数 | 类型  | 描述                                                                                                                                      | 是否必填 |
| :--- | :---- | :---------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `to` | Array | 消息接收方群组 ID 数组，每秒最多可向群组发送 20 条信息，每次最多可向 3 个群组发送消息。例如，一次向 3 个群组发消息，表示发送了 3 条消息。 | 是       |

群聊消息的通用请求体中的其他参数与单聊消息类似，详见 [通用请求体](#通用请求体)。

与单聊消息类似，不同类型的消息只是 `body` 字段内容存在差异。详见 [body 字段说明](#body_字段说明)。

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 包含如下字段：

| 参数   | 类型 | 描述                                                                                                                                                                                                      |
| :----- | :--- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `data` | JSON | 返回数据详情。该字段的值为包含群组 ID 和 发送的消息的 ID 的键值对。<br/>例如 "184524748161025": "1029544257947437432"，表示在 ID 为 184524748161025 的群组中发送了消息 ID 为 1029544257947437432 的消息。 |

其他参数及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

###### 文本消息

发送给目标用户，消息无需同步给发送方：

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'http://XXXX/XXXX/XXXX/messages/chatgroups' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["184524748161025"],"type": "txt","body": {"msg": "testmessages"}}'
```

仅发送给在线用户，消息同步给发送方：

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'http://XXXX/XXXX/XXXX/messages/chatgroups' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["184524748161025"],"type": "txt","body": {"msg": "testmessages"},"routetype":"ROUTE_ONLINE", "sync_device":true}'
```

###### 图片消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'https://XXXX/XXXX/XXXX/messages/chatgroups' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["184524748161025"],"type": "img","body": {"filename":"testimg.jpg","secret":"VfXXXXNb_","url":"https://XXXX/XXXX/XXXX/chatfiles/55f12940-XXXX-XXXX-8a5b-ff2336f03252","size":{"width":480,"height":720}}}'
```

###### 语音消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'https://XXXX/XXXX/XXXX/messages/chatgroups' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["184524748161025"],"type": "audio","body": {"url": "https://XXXX/XXXX/XXXX/chatfiles/1dfc7f50-XXXX-XXXX-8a07-7d75b8fb3d42","filename": "testaudio.amr","length": 10,"secret": "HfXXXXCjM"}}'
```

###### 视频消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'https://XXXX/XXXX/XXXX/messages/chatgroups' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d  '{"from": "user1","to": ["184524748161025"],"type": "video","body": {"thumb" : "https://XXXX/XXXX/XXXX/chatfiles/67279b20-7f69-11e4-8eee-21d3334b3a97","length" : 0,"secret":"VfXXXXNb_","file_length" : 58103,"thumb_secret" : "ZyXXXX2I","url" : "https://XXXX/XXXX/XXXX/chatfiles/671dfe30-XXXX-XXXX-ba67-8fef0d502f46"}}'
```

###### 文件消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'https://XXXX/XXXX/XXXX/messages/chatgroups' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["184524748161025"],"type": "file","body": {"filename":"test.txt","secret":"1-g0XXXXua","url":"https://XXXX/XXXX/XXXX/chatfiles/d7eXXXX7444"}}'
```

###### 位置消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i "https://XXXX/XXXX/XXXX/messages/chatgroups"  -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["184524748161025"],"type": "loc","body":{"lat": "39.966","lng":"116.322","addr":"中国北京市海淀区中关村"}}'
```

###### 透传消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i "https://XXXX/XXXX/XXXX/messages/chatgroups" -H 'Content-Type: application/json' -H 'Accept: application/json'  -H "Authorization:Bearer <YourAppToken>" -d '{"from": "user1","to": ["184524748161025"],"type": "cmd","body":{"action":"action1"}}'
```

###### 自定义消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i "https://XXXX/XXXX/XXXX/messages/chatgroups" -H 'Content-Type: application/json' -H 'Accept: application/json'  -H "Authorization:Bearer <YourAppToken>" -d '{"from": "user1","to": ["184524748161025"],"type": "custom","body": {"customEvent": "custom_event"}}'
```

##### 响应示例

###### 文本消息

```json
{
  "path": "/messages/chatgroups",
  "uri": "https://XXXX/XXXX/XXXX/messages/chatgroups",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "184524748161025": "1029544257947437432"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 图片消息

```json
{
  "path": "/messages/chatgroups",
  "uri": "https://XXXX/XXXX/XXXX/messages/chatgroups",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "184524748161025": "1029544257947437432"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 语音消息

```json
{
  "path": "/messages/chatgroups",
  "uri": "https://XXXX/XXXX/XXXX/messages/chatgroups",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "184524748161025": "1029544257947437432"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 视频消息

```json
{
  "path": "/messages/chatgroups",
  "uri": "https://XXXX/XXXX/XXXX/messages/chatgroups",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "184524748161025": "1029544257947437432"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 文件消息

```json
{
  "path": "/messages/chatgroups",
  "uri": "https://XXXX/XXXX/XXXX/messages/chatgroups",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "184524748161025": "1029544257947437432"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 位置消息

```json
{
  "path": "/messages/chatgroups",
  "uri": "https://XXXX/XXXX/XXXX/messages/chatgroups",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "184524748161025": "1029544257947437432"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 透传消息

```json
{
  "path": "/messages/chatgroups",
  "uri": "https://XXXX/XXXX/XXXX/messages/chatgroups",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "184524748161025": "1029544257947437432"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 自定义消息

```json
{
    "path": "/messages/chatgroups",
    "uri": "https://XXXX/XXXX/XXXX/messages/chatgroups",
    "timestamp": 1657254052191,
    "organization": "XXXX",
    "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
    "action": "post",
    "data": {
      "184524748161025": "1029544257947437432"
    },
    "duration": 0,
    "applicationName": "XXXX"
}
```

### 发送聊天室消息

通过 RESTful API 单个应用每秒最多可向聊天室发送 100 条消息，每次最多可向 10 个聊天室发送消息。例如，一次向 10 个聊天室发送消息，视为 10 条消息。

对于聊天室消息，环信即时通讯提供消息分级功能，将消息的优先级划分为高、普通和低三种级别，高优先级的消息会优先送达。你可以在创建消息时对指定聊天室消息类型或指定成员的消息设置为高优先级，确保这些消息优先送达。这种方式确保在聊天室内消息并发量很大或消息发送频率过高时，重要消息能够优先送达，从而提升重要消息的可靠性。 当服务器的负载较高时，会优先丢弃低优先级的消息，将资源留给高优先级的消息。不过，消息分级功能只确保消息优先到达，并不保证必达。服务器负载过高的情况下，即使是高优先级消息依然会被丢弃。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/messages/chatrooms
```

#### 路径参数

参数及说明详见 [公共参数](#param)。

#### 请求 header

|      参数       | 类型   |                                             描述                                              | 是否必填 |
| :-------------: | :----- | :-------------------------------------------------------------------------------------------: | :------: |
| `Content-Type`  | String |                              内容类型。请填 `application/json`。                              |    是    |
|    `Accept`     | String |                              内容类型。请填 `application/json`。                              |    是    |
| `Authorization` | String | `Bearer ${Your App Token}` Bearer 是固定字符，后面加英文空格，再加上获取到的 App Token 的值。 |    是    |

#### 通用请求体

通用请求体为 JSON 对象，是所有消息的外层结构。不同类型的消息只是 `body` 字段内容存在差异。

| 参数 | 类型  | 描述                 | 是否必填 |
| :--- | :---- | :---------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `to` | Array | 消息接收方聊天室 ID 数组，每秒钟最多可向 100 个聊天室发送信息，每次可发送的接收方聊天室上限为 10 个，如：一次发送给 10 个聊天室时，表示为 10 条消息。 | 是       |
| `chatroom_msg_level` | String | 聊天室消息优先级：<br/> - `high`：高<br/> - （默认）`normal`：普通<br/> - `low`：低 | 否       | 

聊天室消息的通用请求体中的其他参数与单聊消息类似，详见 [通用请求体][https://docs-im.easemob.com/ccim/rest/message#通用请求体]。

与单聊消息类似，不同类型的消息只是 `body` 字段内容存在差异。详见 [body 字段说明](https://docs-im.easemob.com/ccim/rest/message#body_字段说明)。

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 包含如下字段：

| 参数   | 类型 | 描述                                                                                                                                                                                                          |
| :----- | :--- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `data` | JSON | 返回数据详情。该字段的值为包含聊天室 ID 和 发送的消息的 ID 的键值对。<br/>例如 "185145305923585": "1029545553039460728"，表示在 ID 为 184524748161025 的聊天室中发送了消息 ID 为 1029545553039460728 的消息。 |

其他参数及说明详见[公共参数](https://docs-im.easemob.com/ccim/rest/message#公共参数)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

#### 示例

##### 请求示例

###### 文本消息

发送给目标用户，消息无需同步给发送方：

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'http://XXXX/XXXX/XXXX/messages/chatrooms' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["185145305923585"],"type": "txt","body": {"msg": "testmessages"}}'
```

仅发送给在线用户，消息同步给发送方：

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'http://XXXX/XXXX/XXXX/messages/chatrooms' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["185145305923585"],"type": "txt","body": {"msg": "testmessages"},"routetype":"ROUTE_ONLINE", "sync_device":true}'
```

######  图片消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'https://XXXX/XXXX/XXXX/messages/chatrooms' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["185145305923585"],"type": "img","body": {"filename":"testimg.jpg","secret":"VfXXXXNb_","url":"https://XXXX/XXXX/XXXX/chatfiles/55f12940-XXXX-XXXX-8a5b-ff2336f03252","size":{"width":480,"height":720}}}'
```

######  语音消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'https://XXXX/XXXX/XXXX/messages/chatrooms' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["185145305923585"],"type": "audio","body": {"url": "https://XXXX/XXXX/XXXX/chatfiles/1dfc7f50-XXXX-XXXX-8a07-7d75b8fb3d42","filename": "testaudio.amr","length": 10,"secret": "HfXXXXCjM"}}'
```

###### 视频消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'https://XXXX/XXXX/XXXX/messages/chatrooms' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d  '{"from": "user1","to": ["185145305923585"],"type": "video","body": {"thumb" : "https://XXXX/XXXX/XXXX/chatfiles/67279b20-7f69-11e4-8eee-21d3334b3a97","length" : 0,"secret":"VfXXXXNb_","file_length" : 58103,"thumb_secret" : "ZyXXXX2I","url" : "https://XXXX/XXXX/XXXX/chatfiles/671dfe30-XXXX-XXXX-ba67-8fef0d502f46"}}'
```

###### 文件消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i 'https://XXXX/XXXX/XXXX/messages/chatrooms' -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["185145305923585"],"type": "file","body": {"filename":"test.txt","secret":"1-g0XXXXua","url":"https://XXXX/XXXX/XXXX/chatfiles/d7eXXXX7444"}}'
```

###### 位置消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i "https://XXXX/XXXX/XXXX/messages/chatrooms"  -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"from": "user1","to": ["185145305923585"],"type": "loc","body":{"lat": "39.966","lng":"116.322","addr":"中国北京市海淀区中关村"}}'
```

###### 透传消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i "https://XXXX/XXXX/XXXX/messages/chatrooms" -H 'Content-Type: application/json' -H 'Accept: application/json'  -H "Authorization:Bearer <YourAppToken>" -d '{"from": "user1","to": ["185145305923585"],"type": "cmd","body":{"action":"action1"}}'
```

###### 自定义消息

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -i "https://XXXX/XXXX/XXXX/messages/chatrooms" -H 'Content-Type: application/json' -H 'Accept: application/json'  -H "Authorization:Bearer <YourAppToken>" -d '{"from": "user1","to": ["185145305923585"],"type": "custom","body": {"customEvent": "custom_event"}}'
```

##### 响应示例

###### 文本消息

```json
{
  "path": "/messages/chatrooms",
  "uri": "https://XXXX/XXXX/XXXX/messages/chatrooms",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "185145305923585": "1029545553039460728"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 图片消息

```json
{
  "path": "/messages/chatrooms",
  "uri": "https://XXXX/XXXX/XXXX/messages/chatrooms",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "185145305923585": "1029545553039460728"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 语音消息

```json
{
  "path": "/messages/chatrooms",
  "uri": "https://XXXX/XXXX/XXXX/messages/chatrooms",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "185145305923585": "1029545553039460728"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 视频消息

```json
{
  "path": "/messages/chatrooms",
  "uri": "https://XXXX/XXXX/XXXX/messages/chatrooms",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "185145305923585": "1029545553039460728"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 文件消息

```json
{
  "path": "/messages/chatrooms",
  "uri": "https://XXXX/XXXX/XXXX/messages/chatrooms",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "185145305923585": "1029545553039460728"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 位置消息

```json
{
  "path": "/messages/chatrooms",
  "uri": "https://XXXX/XXXX/XXXX/messages/chatrooms",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "185145305923585": "1029545553039460728"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 透传消息

```json
{
  "path": "/messages/chatrooms",
  "uri": "https://XXXX/XXXX/XXXX/messages/chatrooms",
  "timestamp": 1657254052191,
  "organization": "XXXX",
  "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
  "action": "post",
  "data": {
    "185145305923585": "1029545553039460728"
  },
  "duration": 0,
  "applicationName": "XXXX"
}
```

###### 自定义消息

```json
{
    "path": "/messages/chatrooms",
    "uri": "https://XXXX/XXXX/XXXX/messages/chatrooms",
    "timestamp": 1657254052191,
    "organization": "XXXX",
    "application": "e82bcc5f-XXXX-XXXX-a7c1-92de917ea2b0",
    "action": "post",
    "data": {
      "185145305923585": "1029545553039460728"
    },
    "duration": 0,
    "applicationName": "XXXX"
}
```

## <a name="upload"></a>文件上传

对于附件类型的消息，如图片、语音、视频或其他类型文件，发送消息前需上传文件。图片和视频存在缩略图，文件上传详情如下：

- 图片：可调用文件上传接口上传原图，Agora 服务器会自动为图片生成缩略图。若上传的图片在 10 KB 以内，缩略图与原图等同；若图片超过 10 KB，Agora 服务器会根据你在请求中设置的图片高度和宽度，即 `thumbnail-height` 和 `thumbnail-width` 参数，生成缩略图。若这两个参数未传，则图片的高度和宽度均默认为 170 像素。
- 视频：可调用文件上传接口上传视频文件，。Agora 服务器不会自动为视频文件生成缩略图。如果需要缩略图，你需再次调用文件上传接口上传视频缩略图。上传视频文件时，无需传 `thumbnail-height` 和 `thumbnail-width` 参数。上传视频缩略图时，若图片在 10 KB 以内，视频缩略图即为上传的图片。如果图片超过 10 KB，而且设置了这两个参数，视频缩略图的高度和宽度取决于这两个参数的设置。若这两个参数未传，则图片的高度和宽度均默认为 170 像素。

同时，为了保证聊天文件的安全，我们的 API 保证了以下几点：

- 上传文件的大小不能超过 10 MB，超过会上传失败。
- 支持对上传的文件限制访问。该功能开启后，你需要通过密钥才能下载被限制访问的文件。消息回调（包含发送前回调和发送后回调）和获取历史消息涉及下载文件时，需要在下载 URL 中拼接密钥才能正常下载文件，拼接规则为：`{{url}}?share-secret={{secret}}`。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatfiles
```

#### 路径参数

参数及说明详见 [公共参数](#param)。

#### 请求 header

| 参数              | 类型   | 描述                                                                                                                                                                              | 是否必填 |
| :---------------- | :----- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `Content-Type`    | String | 内容类型。请填 `multipart/form-data`。上传文件会自动填充这个头。                                                                                                                  | 否       |
| `Authorization`   | String | `Bearer ${YourToken}` Bearer 是固定字符，后面加英文空格，再加上获取到的 App Token 的值。                                                                                          | 是       |
| `restrict-access` | Bool   | 是否限制访问该文件：<li>`true` ：是。用户需要通过响应 body 中获取的文件访问密钥（share-secret）才能下载该文件。<li>`false` ：否。表示不限制访问。用户可以直接下载该文件。 | 否       |

#### 请求 body

请求 body 为 form-data 类型，包含以下字段：

| 字段   | 类型   | 描述           | 是否必填 |
| :----- | :----- | :------------- | :------- |
| `file` | String | 文件本地路径。 | 是       |
| `thumbnail-height` | Number | 图片缩略图的高度。该参数仅在上传的图片超过 10 KB 时，才会生效。若不传该参数，默认为 170 像素。 | 否       |
| `thumbnail-width` | Number| 图片缩略图的宽度。该参数仅在上传的图片超过 10 KB 时，才会生效。若不传该参数，默认为 170 像素。 | 否       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 中包含以下字段：

| 字段                    | 类型   | 描述                                                                                                                  |
| :---------------------- | :----- | :-------------------------------------------------------------------------------------------------------------------- |
| `entities.uuid`         | String | 文件 ID，即时通讯服务分配给该文件的唯一标识符。<br/>你需要自行保存该 `uuid`，以便 [发送文件消息](#sendmessage)时使用。 |
| `entities.type`         | String | 消息类型。文件类型为 `chatfile`。                                                                                         |
| `entities.share-secret` | String | 文件访问密钥。<li>你需要自行保存 `share-secret`，以便[下载文件](#download)时使用。                                    |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

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
GET https://{host}/{org_name}/{app_name}/chatfiles/{file_uuid}
```

#### 路径参数

参数及说明详见 [公共参数](https://docs-im.easemob.com/ccim/rest/message#公共参数)。

#### 请求 header

| 参数            | 类型   | 描述                                                                                                                                                                     | 是否必填 |
| :-------------- | :----- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `Accept`        | string | 内容类型。请填 `application/octet-stream`，表示下载二进制数据流格式的文件。                                                                                              | 是       |
| `Authorization` | string | `Bearer ${Your App Token}` Bearer 是固定字符，后面加英文空格，再加上获取到的 App Token 的值。                                                                            | 是       |
| `share-secret`  | string | 文件访问密钥。若上传文件时限制了访问（`restrict-access` 设置为 `true`），则需要该访问密钥。成功上传文件后，从 [文件上传](https://docs-im.easemob.com/ccim/rest/message#文件上传) 的响应 body 中获取该密钥。 | 否       |

### HTTP 响应

#### 响应 body

参数及说明详见[公共参数](https://docs-im.easemob.com/ccim/rest/message#公共参数)。

### 示例

#### 请求示例

以下载图片为例：

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X GET -H 'Accept: application/octet-stream' -H 'Authorization: Bearer <YourAppToken>' -H 'share-secret: f0Vr-uyyEeiHpHmsu53XXXXXXXXZYgyLkdfsZ4xo2Z0cSBnB' 'http://XXXX/XXXX/XXXX/chatfiles/7f456bf0-XXXX-XXXX-b630-777db304f26c'-o /Users/test/easemob/image/image.JPG
```

**注意**

上述请求示例中，`/Users/test/easemob/image/image.JPG` 为即时通讯 IM 的本地文件路径，使用时请替换为自己的文件路径，否则会请求失败。

#### 响应示例

```json
{
//语音/图片文件内容
}
```

如果返回的 HTTP 状态码为 200，表示请求成功，返回文件二进制数据流。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

## 下载缩略图

收到图片或视频消息，你可以先下载图片或视频的缩略图，如果需要再下载图片或视频原文件。下载缩略图与下载原文件的唯一区别是前者在请求 header 中多了 `thumbnail: true`。当服务器收到包含该字段的请求 header 时，返回缩略图，否则返回原文件。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatfiles/{file_uuid}
```

#### 路径参数

| 参数        | 类型   | 是否必需 | 描述                            |
| :---------- | :----- | :------- | :------------------------------ |
| `file_uuid` | String | 是       | 服务器为缩略图文件生成的 UUID。 |

其他参数及说明详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                                                                                                                                                                         | 是否必填                                                                |
| :-------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------- |
| `Accept`        | String | `application/octet-stream`，表示下载二进制数据流格式的文件。                                                                                                                 | 是                                                                      |
| `Authorization` | String | Bearer ${YourAppToken}                                                                                                                                                       | 是                                                                      |
| `share-secret`  | String | 文件访问密钥。成功上传文件后，从[文件上传](#upload)的响应 body 中获取。                                                                                                      | 如果文件上传时设置了文件访问限制（`restrict-access`），则该字段为必填。 |
| `thumbnail`     | Bool   | 是否下载缩略图：<ul><li> `true`：是，下载缩略图。</li><li> `false`：否，下载原文件。</li></ul> <div class="alert info">若该参数为空，下载原文件。<div> | 否                                                                      |

### HTTP 响应

#### 响应 body

参数及说明详见[公共参数](#公共参数)。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X GET -H 'Accept: application/octet-stream' -H 'Authorization: Bearer <YourAppToken>' -H 'share-secret: f0Vr-uyyEeiHpHmsu53XXXXXXXXZYgyLkdfsZ4xo2Z0cSBnB' -H 'thumbnail: true' 'http://XXXX/XXXX/XXXX/chatfiles/7f456bf0-ecb2-11e8-b630-777db304f26c'
```

#### 响应示例

**返回值 200，表示下载缩略图成功**

```json
{
//缩略图信息
}
```

**返回值 401，未授权 [无 token、token 错误、token 过期]**

```json
{
  "error": "auth_bad_access_token",
  "timestamp": 1542350943210,
  "duration": 0,
  "exception": "org.apache.usergrid.rest.exceptions.SecurityException",
  "error_description": "Unable to authenticate due to corrupt access token"
}
```

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。


## 获取历史消息记录

获取用户发送和接收的历史消息的记录。

- 一次请求获取从指定起始时间开始一小时内的全部历史消息记录。
- 查询历史消息记录时存在一定延时，无法实时获取。
- 对于不同的套餐版本，历史消息记录的默认存储时间不同。详见 [套餐包详情](./agora_chat_plan?platform=RESTful)。

### HTTP 请求

```http
GET https://{HOST}/{org_name}/{app_name}/chatmessages/${time}
```

#### 路径参数

| 参数   | 类型   | 描述                                                                                                                                                                                  | 是否必填 |
| :----- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :------- |
| `time` | String | 历史消息记录查询的起始时间。UTC 时间，使用 ISO8601 标准，格式为 `yyyyMMddHH`。<br/>例如 `time` 为` 2018112717`，则表示查询 2018 年 11 月 27 日 17 时至 2018 年 11 月 27 日 18 时期间的历史消息。 | 是       |

其他参数及说明详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 中包含字段如下：

| 参数       | 类型   | 描述                                                                                                                                                                                                                                          |
| :--------- | :----- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `data.url` | String | 历史消息记录的下载地址。<br/>`url` 由历史消息记录的存储地址、到期 Unix 时间戳（`Expires`）、第三方云存储访问密钥（`OSSAccessKeyId`）、第三方云存储验证签名（`Signature`）组成。<br/>URL 仅在 `Expires` 前内有效，一旦过期需调用该方法重新获取 URL。 |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

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
| `direction`      | String | 消息发送方向：<li>`incoming`：上行消息，用户向即时通讯服务器发送的消息。<li>`outgoing`：下行消息，即时通讯服务器下发到用户的消息。 |
| `from`           | String | 消息发送方的用户 ID。                                                                                                               |
| `to`             | String | 消息接收方的用户 ID 或群组 ID。                                                                                                      |
| `chat_type`      | String | 聊天方式：<li>`chat`：单聊<li>`groupchat`：群聊<li>`chatroom`：聊天室                                                              |
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
| `size`        | Number | 图片的尺寸。单位为像素。<li>`height`：图片高度<li>`width`：图片宽度               |
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
| `file_length` | Long   | 语音附件大小。单位为字节。                                                        |
| `filename`    | String | 带文件格式后缀的语音文件名称。                                                    |
| `secret`      | String | 语音文件访问密钥。<br/>如果[文件上传](#upload)时设置了文件访问限制，则该字段存在。 |
| `length`      | Int    | 语音时长。单位为秒。                                                              |
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
| `size`         | JSON   | 视频缩略图尺寸。单位为像素。<li>`width`：视频缩略图宽度<li>`height`：视频缩略图高度 |
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

| 字段          | 类型   | 说明                                                                          |
| :------------ | :----- | :---------------------------------------------------------------------------- |
| `file_length` | Number | 文件大小。单位为字节。                                                        |
| `filename`    | String | 带文件格式后缀的文件名称。                                                    |
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
| `action` | String | 自定义请求方式。             |
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
```

## 服务端消息撤回

应用管理员可撤回发送的消息。默认可撤回发出 2 分钟内的消息，如需调整请联系 [support@agora.io](mailto:support@agora.io)。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/messages/msg_recall
```

#### 路径参数

参数及描述详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                                                                                          | 是否必填 |
| :-------------- | :----- | :-------------------------------------------------------------------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。请填 `application/json`。   | 是  |
| `Accept`   | String | 内容类型。请填 `application/json`。   | 是  |
| `Authorization` | String | `Bearer ${Your App Token}` Bearer 是固定字符，后面加英文空格，再加上获取到的 App Token 的值。 | 是       |

#### 请求 body

| 参数        | 类型   | 描述                                                                                                                                                                                                                      | 是否必填 |
| :---------- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :------- |
| `msg_id`    | String | 要撤回消息的消息 ID。                                                                                                                                                                                                     | 是       |
| `to`        | String | 要撤回消息的接收方。<ul><li>单聊为接收方用户 ID；</li><li>群聊为群组 ID；</li><li>聊天室聊天为聊天室 ID。</li><li>若不传入该参数，请求失败。</li></ul>                                                                                     | 是       |
| `chat_type` | String | 要撤回消息的会话类型：<ul><li>`chat`：单聊；</li><li>`groupchat`：群聊 ；</li><li>`chatroom`：聊天室 </li></ul>。                                                                                                                       | 是       |
| `from`      | String | 消息撤回方的用户 ID。若不传该参数，默认为 `admin`。                                                                                                                                                                       | 否       |
| `force`     | Bool   | 是否为强制撤回：<ul><li>`true`：是，支持撤回超过服务器存储时间的消息。具体见[服务器消息保存时长](https://docs-im.easemob.com/ccim/limitation#消息存储时长限制)；</li><li>`false`：否，不支持撤回超过服务器存储时间的消息。</li></ul> | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 参数       | 类型   | 描述                                                                                              |
| :--------- | :----- | :------------------------------------------------------------------------------------------------ |
| `msg_id`   | String | 需要撤回的消息 ID。                                                                               |
| `recalled` | String | 消息撤回结果，成功是 `yes`。                                                                      |
| `from`     | String | 消息撤回方。                                                                                      |
| `to`       | String | 撤回消息的送达方。<li>单聊为送达方用户 ID；<li>群聊为群组 ID。                            |
| `chattype` | String | 撤回消息的会话类型：<li>`chat`：单聊；<li>`groupchat`：群聊；<li>`chatroom`：聊天室。 |

其他参数及说明详见[公共参数](https://docs-im.easemob.com/ccim/rest/message#公共参数)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

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

- ”can’t find msg to”：未找到撤回消息的接收⽅；
- ”exceed recall time limit”：消息撤回超时；
- ”not_found msg”：消息过期或已被撤回；
- ”internal error”：后端服务出现异常。

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

此方法使聊天用户能够从服务器中删除会话。删除会话后，此聊天用户再从服务器获取时将不再能获取到该会话。该会话的其他参与聊天用户仍然可以从服务器获取会话内容。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
DELETE https://{host}/{orgName}/{appName}/users/{userName}/user_channel
```

#### 路径参数

| 参数       | 类型   | 描述                                      | 是否必填 |
| :--------- | :----- | :---------------------------------------- | :------- |
| `userName` | String | 要删除会话的用户的唯一标识符，即用户 ID。 | 是       |

其他参数及说明详见[公共参数](https://docs-im.easemob.com/ccim/rest/message#公共参数)。

#### 请求 header

| 参数            | 类型   | 描述                                                                                          | 是否必填 |
| :-------------- | :----- | :-------------------------------------------------------------------------------------------- | :------- |
| `Authorization` | String | `Bearer ${Your App Token}` Bearer 是固定字符，后面加英文空格，再加上获取到的 App Token 的值。 | 是       |

#### 请求 body

| 参数          | 类型   | 描述                                                               | 是否必填 |
| :------------ | :----- | :----------------------------------------------------------------- | :------- |
| `channel`     | String | 要删除的会话 ID。                                                  | 是       |
| `type`        | String | 会话类型。<li>`chat`：单聊会话；<li>`groupchat`：群聊会话。 | 是       |
| `delete_roam` | Bool   | 是否删除服务端消息。<li>`true`：是；<li>`false`：否。      | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型   | 描述                                                  |
| :------- | :----- | :---------------------------------------------------- |
| `result` | String | 删除结果，`ok` 表示成功，失败则直接返回错误码和原因。 |

其他参数及说明详见[公共参数](https://docs-im.easemob.com/ccim/rest/message#公共参数)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

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
POST https://{host}/{orgName}/{appName}/messages/users/import
```

#### 请求 header

| 参数            | 类型   | 描述                                                                                          | 是否必填 |
| :-------------- | :----- | :-------------------------------------------------------------------------------------------- | :------- |
| `Authorization` | String | `Bearer ${Your App Token}` Bearer 是固定字符，后面加英文空格，再加上获取到的 App Token 的值。 | 是       |

#### 请求 body

| 参数            | 类型   | 描述                                                                                                                                                                                                                         | 是否必填 |
| :-------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `from`          | String | 消息发送方的用户 ID。                                                                                                                                                                                                        | 是       |
| `target`        | String | 消息接收方的用户 ID。                                                                                                                                                                                                        | 是       |
| `type`          | String | 消息类型：<li>`txt`：文本消息；<li>`img`：图片消息；<li>`audio`：语音消息；<li>`video`：视频消息；<li>`file`：文件消息；<li>`loc`：位置消息；<li>`cmd`：透传消息；<li>`custom`：自定义消息。 | 是       |
| `body`          | JSON   | 消息内容。                                                                                                                                                                                                                   | 是       |
| `is_ack_read`   | Bool   | 是否设置消息为已读。<li>`true`：是；<li>`false`：否。                                                                                                                                                                | 否       |
| `msg_timestamp` | Long   | 要导入的消息的时间戳，单位为毫秒。若不传该参数，环信服务器会将导入的消息的时间戳设置为当前时间。  | 否       |
| `need_download` | Bool   | 是否需要下载附件并上传到服务器。<li>`true`：是；<li>（默认）`false`：否。        | 否       |

与发送消息类似，不同类型的消息只是 `body` 字段内容存在差异。详见 [body 字段说明](https://docs-im.easemob.com/ccim/rest/message#body_字段说明)。

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型   | 描述                    |
| :------- | :----- | :---------------------- |
| `msg_id` | String | 导入消息返回的消息 ID。 |

其他参数及说明详见 [公共参数](https://docs-im.easemob.com/ccim/rest/message#公共参数)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [状态码汇总表](#code) 了解可能的原因。

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
POST https://{host}/{orgName}/{appName}/messages/chatgroups/import
```

#### 请求 header

| 参数            | 类型   | 描述                                                                                          | 是否必填 |
| :-------------- | :----- | :-------------------------------------------------------------------------------------------- | :------- |
| `Authorization` | String | `Bearer ${Your App Token}` Bearer 是固定字符，后面加英文空格，再加上获取到的 App Token 的值。 | 是       |

#### 请求 body

| 参数            | 类型   | 描述                                                                                                                                                                                                                         | 是否必填 |
| :-------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `from`          | String | 消息发送方的用户 ID。                                                                                                                                                                                                        | 是       |
| `target`        | String | 群 ID。                                                                                                                                                                                                                      | 是       |
| `type`          | String | 消息类型：<li>`txt`：文本消息；<li>`img`：图片消息；<li>`audio`：语音消息；<li>`video`：视频消息；<li>`file`：文件消息；<li>`loc`：位置消息；<li>`cmd`：透传消息；<li>`custom`：自定义消息。 | 是       |
| `body`          | JSON   | 消息内容。                                                                                                                                                                                                                   | 是       |
| `is_ack_read`   | Bool   | 是否设置消息为已读。<li>`true`：是；<li>`false`：否。                                                                                                                                                                | 否       |
| `msg_timestamp` | Long   | 要导入的消息的时间戳，单位为毫秒。若不传该参数，服务器会将导入的消息的时间戳设置为当前时间。  | 否       |
| `need_download` | Bool   | 是否需要下载附件并上传到服务器。<li>`true`：是；<li>（默认）`false`：否。                                                                                                                                            | 否       |

与发送消息类似，不同类型的消息只是 `body` 字段内容存在差异。详见 [body 字段说明](https://docs-im.easemob.com/ccim/rest/message#body_字段说明)。

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型   | 描述                    |
| :------- | :----- | :---------------------- |
| `msg_id` | String | 导入消息返回的消息 ID。 |

其他参数及说明详见[公共参数](https://docs-im.easemob.com/ccim/rest/message#公共参数)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

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

## <a name="code"></code> 状态码

有关详细信息，请参阅 [HTTP 状态代码](./agora_chat_status_code?platform=RESTful)。