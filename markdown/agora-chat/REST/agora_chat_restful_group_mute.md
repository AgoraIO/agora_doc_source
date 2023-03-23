禁言是指禁止群成员在群组中发送消息。即时通讯 IM 提供多个接口实现禁言管理，包括获取禁言列表、将成员添加至或移出禁言列表。

本文展示如何调用即时通讯 RESTful API 管理禁言列表。调用本文中的 API 前，请先参考 [使用限制](./agora_chat_limitation?platform=RESTful#服务端接口调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

<a name="pubparam"></a>
## 公共参数

下表列明即时通讯 RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述                                                         | 是否必填 |
| :--------- | :----- | :----------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `username` | String | 用户 ID。用户的唯一登录账号。 | 是       |

### 响应参数

| 参数                 | 类型    | 描述                                                         |
| :------------------- | :------ | :----------------------------------------------------------- |
| `action`             | String  | 请求方式。                                                   |
| `organization`       | String  | 即时通讯服务为每个企业（组织）分配的唯一标识，与请求参数 `org_name` 相同。 |
| `application`        | String  | 即时通讯服务为 app 生成的唯一内部标识，无需关注。                  |
| `applicationName`    | String  | 即时通讯服务为每个 app 分配的唯一标识，与请求参数 `app_name` 相同。 |
| `uri`                | String  | 请求 URL。                                                   |
| `entities`           | JSON    | 返回实体信息。                                               |
| `timestamp`          | Long  | 响应的 Unix 时间戳，单位为毫秒。                                 |
| `duration`           | Number  | 从发送请求到响应的时长，单位为毫秒。                             |

## 认证方式

即时通讯服务 RESTful API 要求 HTTP 身份验证。每次发送 HTTP 请求时，必须在请求 header 填入如下 `Authorization` 字段：

```http
Authorization: Bearer ${YourAppToken}
```

为了提高项目的安全性，Agora 使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯服务 RESTful API 仅支持使用 app 权限 token 对用户进行身份验证。详见[使用 App Token 进行身份验证](./agora_chat_token?platform=RESTful)。

## 禁言指定群成员

对指定群成员禁言，即将用户添加至禁言列表。每次最多可禁言 10 个成员。

群成员被禁言后，将无法在群组中发送消息，也无法在该群组下的子区中发送消息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/mute
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Accept`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

#### 请求 body

| 参数          | 类型  | 描述                      | 是否必填 |
| :------------ | :---- | :------------------------ | :------- |
| `mute_duration` | Number  | 禁言时间，单位为毫秒。    | 是       |
| `usernames`     | Array | 要添加到禁言列表的用户 ID 列表。每次最多可传 10 个用户 ID。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数   | 类型    | 描述                                        |
| :----- | :------ | :------------------------------------------ |
| `data` | JSON | 群成员禁言结果。 |
| `data.result` | Boolean | 是否成功禁言群成员：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.expire` | Number    | 禁言到期的 Unix 时间戳，单位为毫秒。         |
| `data.user`   | String  | 被禁言的群成员的用户 ID。                           |

其他参数及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X POST -H 'Content-type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"usernames":["user1"], "mute_duration":86400000}' 'http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute",
    "entities": [],
    "data": [{
        "result": true,
        "expire": 1489158589481,
        "user": "user1"
    }],
    "timestamp": 1489072189508,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 禁言全体群成员

对所有群组成员一键禁言，即将群组的所有成员加入禁言列表。设置群组全员禁言后，仅群组白名单中的用户可在群组以及该群组下的子区内发送消息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/ban
```

#### 路径参数

参数及描述详见 [公共参数](#pubparam)。

#### 请求 header

| 参数    | 类型   | 是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Content-Type`  | String | 是    | 内容类型。请填 `application/json`。 |
| `Accept`   | String | 是    |内容类型。请填 `application/json`。 |
|`Authorization`| String | 是    |该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。|

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段      | 类型    | 描述                                                  |
| :------- | :------ | :---------------------------------------------------- |
| `data` | JSON | 全体成员禁言相关信息。 |
| `data.result` | Boolean | 操作结果：<ul><li>`true`：禁言成功；</li><li>`false`：禁言失败。</li></ul> |
| `data.expire` | Number   | 禁言到期的时间。该时间为 Unix 时间戳，单位为毫秒。    |

其他参数及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' 'http://XXXX/XXXX/XXXX/chatgroups/{groupid}/ban'
```

#### 响应示例

```json
{
  "action": "post",
  "application": "5cf28979-XXXX-XXXX-b969-60141fb9c75d",
  "uri": "http://XXXX/XXXX/XXXX/chatgroups/1208XXXX5169153/ban",
  "entities": [],
  "data": {
    "mute": true
  },
  "timestamp": 1594628861058,
  "duration": 1,
  "organization": "XXXX",
  "applicationName": "XXXX"
}
```

## 解除成员禁言

将一个或多个群成员解除禁言，即将其移出禁言列表。解除禁言后，群成员可以在群组中正常发送消息，同时也可以在该群组下的子区中发送消息。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/mute/{member_id}
```

#### 路径参数

| 参数      | 类型   | 描述                                                         | 是否必需 |
| :-------- | :----- | :----------------------------------------------------------- | :------- |
| `group_id`  | String | 群组 ID。                                                    | 是       |
| `member_id` | String | 解除禁言的成员的用户 ID。可传多个成员的用户 ID，使用英文逗号隔开，例如 {member1},{member2}。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数   | 类型    | 描述                                    |
| :----- | :------ | :-------------------------------------- |
| `data`   | JSON Array  | 解除禁言结果。                   |
| `data.result` | Boolean | 是否成功对成员解除禁言：<ul><li>`true`: 成功</li><li>`false`：失败</li></ul> |
| `data.user`   | String  | 被解除禁言的用户 ID。                   |

其他字段及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute/user1'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute/user1",
    "entities": [],
    "data": [{
        "result": true,
        "user": "user1"
    }],
    "timestamp": 1489072695859,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 解除全员禁言

一键取消对群组全体成员的禁言。解除禁言后，群成员可以在群组和该群组下的子区中正常发送消息。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/ban
```

#### 路径参数

参数及描述详见 [公共参数](#pubparam)。

#### 请求 header

| 参数    | 类型   | 是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Content-Type`  | String | 是    | 内容类型。请填 `application/json`。 |
| `Accept`   | String | 是    |内容类型。请填 `application/json`。 |
|`Authorization`| String | 是    |该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。|

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段      | 类型    | 描述                                                  |
| :------- | :------ | :---------------------------------------------------- |
| `data` | JSON | 全员禁言结果。 |
| `data.mute` | Boolean | 是否处于全员禁言状态。<br/> - `true`：是； <br/> - `false`：否。 |

其他字段及描述详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X DELETE -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' 'http://XXXX/XXXX/XXXX/chatgroups/1208XXXX5169153/ban'
```

#### 响应示例

```json
{
  "action": "delete",
  "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
  "uri": "http://XXXX/XXXX/XXXX/chatgroups/120824965169153/ban",
  "entities": [],
  "data": {
    "mute": false
  },
  "timestamp": 1594628899502,
  "duration": 1,
  "organization": "XXXX",
  "applicationName": "XXXX"
}
```

## 获取禁言列表

获取当前群组的禁言列表。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/mute
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段:

| 参数   | 类型   | 描述                          |
| :----- | :----- | :---------------------------- |
| `data` | JSON Array   | 禁言列表信息。 |
| `data.expire` | Number   | 禁言到期的时间戳，单位为毫秒。 |
| `data.user`   | String | 被禁言的用户 ID。             |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X GET -H 'Accept: application/json' 'http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute' -H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute",
    "entities": [],
    "data": [{
        "expire": 1489158589481,
        "user": "user1"
    }],
    "timestamp": 1489072802179,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## <a name="code"></code> 状态码

详见  [HTTP 状态码](./agora_chat_status_code?platform=RESTful)。