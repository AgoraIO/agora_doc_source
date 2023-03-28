本文展示如何调用即时通讯 RESTful API 实现聊天室禁言管理，包括将用户添加至或移出禁言列表以及获取禁言列表。

调用本文中的 API 前，请先参考 [使用限制](./agora_chat_limitation?platform=RESTful#服务端接口调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

## <a name="param"></a>公共参数

下表列明即时通讯 RESTful API 的公共请求参数和响应参数：

### 请求参数

| 参数       | 类型   | 描述     | 是否必填 |
| :--------- | :----- | :--------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。         | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。        | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。        | 是       |
| `chatroom_id` | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符，可从[查询所有聊天室基本信息](./agora_chat_restful_chatroom%20?platform=RESTful#查询所有聊天室基本信息) 的响应 body 中获取。   | 是       |

### 响应参数

| 参数              | 类型   | 描述                                                              |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action`          | String | 请求方式。                                                        |
| `organization`    | String | 即时通讯服务分配给每个企业（组织）的唯一标识，与请求参数 `org_name` 相同。 |
| `application`     | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。             |
| `applicationName` | String | 即时通讯服务分配给每个 app 的唯一标识，与请求参数 `app_name` 相同。        |
| `uri`             | String | 请求 URL。                                                        |
| `entities`        | JSON   | 返回实体信息。                                                    |
| `timestamp`       | Number   | HTTP 响应的 Unix 时间戳，单位为毫秒。                                 |
| `duration`        | Number | 从发送 HTTP 请求到响应的时长，单位为毫秒。                            |

## 认证方式

即时通讯服务 RESTful API 要求 HTTP 身份验证。每次发送 HTTP 请求时，必须在请求 header 填入如下 `Authorization` 字段：

```http
Authorization: Bearer YourAppToken
```

为了提高项目的安全性，Agora 使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯服务 RESTful API 仅支持使用 app 权限 token 对用户进行身份验证。详见[使用 App Token 进行身份验证](./agora_chat_token?platform=RESTful)。

## 禁言聊天室单个成员

禁言单个用户。用户被禁言后，将无法在聊天室中发送消息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/mute
```

#### 路径参数

参数及描述详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。 | 是    |
| `Accept`   | String |内容类型。填入 `application/json`。 | 是    |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

#### 请求 body

请求 body 为 JSON Object，包含以下字段：

| 字段            | 类型   | 描述                                                          | 是否必填 |
| :-------------- | :----- | :------------------------------------------------------------ | :------- |
| `mute_duration` | Number   | 禁言时长，从当前时间开始计算。单位为毫秒。`-1` 表示永久禁言。 | 是       |
| `usernames`     | String | 要被禁言的聊天室成员的用户 ID。                          | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型   | 描述                                                    |
| :------- | :----- | :------------------------------------------------------ |
| `data` | JSON Array   | 禁言结果。 |
| `data.result` | Boolean   | 是否成功对聊天室成员禁言：<ul><li>`true：`是</li><li>`false`：否</li></ul> |
| `data.expire` | Number | 禁言到期的 Unix 时间戳，单位为毫秒。                        |
| `data.user`   | String | 被禁言的聊天室成员的用户 ID。                            |

其他字段及描述详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d
'{
    "usernames": [
        "user1",
        "user2"
    ],
    "mute_duration": 86400000
}''http://XXXX/XXXX/XXXX/chatrooms/XXXX/mute'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "22bcffa0-XXXX-XXXX-9df8-516f6df68c6d",
    "applicationName": "XXXX",
    "data": [
        {
            "result": true,
            "expire": 1642148173726,
            "user": "user1"
        },
        {
            "result": true,
            "expire": 1642148173726,
            "user": "user2"
        }
    ],
    "duration": 0,
    "entities": [],
    "organization": "XXXX",
    "timestamp": 1642060750410,
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/mute"
}
```

## 禁言聊天室全体成员

对所有聊天室成员一键禁言，即将聊天室的所有成员均加入禁言列表。

设置聊天室全员禁言后，仅聊天室白名单中的用户可在聊天室内发消息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/ban
```
#### 路径参数

参数及描述详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 是否必需 | 描述                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | 是       | 内容类型。填入 `application/json`。                          |
| `Accept`        | String | 是       | 内容类型。填入 `application/json`。                          |
| `Authorization` | String | 是       | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段        | 类型 | 描述                                                        |
| :---------- | :--- | :---------------------------------------------------------- |
| `data` | JSON | 一键禁言结果。 |
| `data.mute` | Boolean | 是否处于聊天室全员禁言状态：<ul><li>`true`：是</li><li>`false`：否</li></ul> |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' 'http://XXXX/XXXX/XXXX/chatrooms/12XXXX11/ban'
```

## 响应示例

```json
{
  "action": "put",
  "application": "5cXXXX75d",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/12XXXX11/ban",
  "entities": [],
  "data": {
    "mute": true
  },
  "timestamp": 1594628861058,
  "duration": 1,
  "organization": "XXXX",
  "applicationName": "testapp"
}
```

## 解除聊天室禁言成员

解除对一个或多个聊天室成员的禁言。解除禁言后，该成员可以正常在聊天室中发送消息。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/mute/{member}
```

#### 路径参数

| 参数     | 类型   | 描述     | 是否必填 |
| :------- | :----- | :--------------- | :------- |
| `member` | String | 待被解除禁言的聊天室成员的用户 ID。<br/>如果需要解除多个成员的禁言，则成员用户 ID 之间用逗号（","）隔开。在 URL 中，需要将逗号 "," 转义为 "%2C"。 | 是       |

其他参数及描述详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`   | String | 内容类型。填入 `application/json`。 | 是    |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应包体中包含以下字段：

| 字段     | 类型   | 描述                                               |
| :------- | :----- | :------------------------------------------------- |
| `data` | JSON Array   | 解除禁言的结果。 |
| `data.result` | Boolean   | 是否成功对聊天室成员解除禁言：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.user`   | String | 被解除禁言的聊天室成员的用户 ID。                   |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'https://XXXX/XXXX/XXXX/chatrooms/XXXX/mute/XXXX'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/mute/XXXX",
    "entities": [],
    "data": [
        {
            "result": true,
            "user": "XXXX"
        }
    ],
    "timestamp": 1489072695859,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 解除聊天室全员禁言

一键取消对聊天室全体成员的禁言。解除禁言后，聊天室成员可以在聊天室中正常发送消息。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/ban
```

#### 路径参数

参数及描述详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 是否必需 | 描述                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | 是       | 内容类型。填入 `application/json`。                          |
| `Accept`        | String | 是       | 内容类型。填入 `application/json`。                          |
| `Authorization` | String | 是       | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段        | 类型 | 描述                                                        |
| :---------- | :--- | :---------------------------------------------------------- |
| `data` | JSON | 聊天室全员解除禁言结果。 |
| `data.mute` | Boolean | 是否处于聊天室全员禁言状态：<ul><li>`true`：是</li><li>`false`：否</li></ul>|

其他字段及描述详见 [公共参数](https://docs-im-beta.easemob.com/document/server-side/chatroom.html#公共参数)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](https://docs-im-beta.easemob.com/document/server-side/error.html) 了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X DELETE -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' 'http://XXXX/XXXX/XXXX/chatrooms/12XXXX11/ban'
```

#### 响应示例

```json
{
  "action": "delete",
  "application": "5cXXXX75d",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/12XXXX11/ban",
  "entities": [],
  "data": {
    "mute": false
  },
  "timestamp": 1594628899502,
  "duration": 1,
  "organization": "XXXX",
  "applicationName": "testapp"
}
```

## 获取禁言列表

获取当前聊天室的禁言用户列表。

```http
GET https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/mute
```

### HTTP 请求

#### 路径参数

参数及描述详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。   | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应包体中包含以下字段：

| 字段     | 类型   | 描述                             |
| :------- | :----- | :------------------------------- |
| `data` | JSON Array | 获取的禁言列表信息。 |
| `data.expire` | Number | 禁言到期的 Unix 时间戳，单位为毫秒。 |
| `data.user`   | String | 被禁言的聊天室成员的用户 ID。     |

其他字段及描述详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'https://XXXX/XXXX/XXXX/chatrooms/XXXX/mute'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/mute",
    "entities": [],
    "data": [
        {
            "expire": 1489158589481,
            "user": "user1"
        },
        {
            "expire": 1489158589481,
            "user": "user2"
        }
    ],
    "timestamp": 1489072802179,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## <a name="code"></code> 状态码

详见  [HTTP 状态码](./agora_chat_status_code?platform=RESTful)。