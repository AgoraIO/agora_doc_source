本文展示如何实现聊天室白名单管理，包括查看白名单中的用户以及将用户添加至和移出聊天室白名单等。

聊天室白名单中的成员在聊天室中发送的消息为高优先级，会优先送达，但不保证必达。当负载较高时，服务器会优先丢弃低优先级的消息。若即便如此负载仍很高，服务器也会丢弃高优先级消息。

<a name="param"></a>

## 公共参数

下表列举了即时通讯 RESTful API 的公共请求参数和响应参数：

### 请求参数

| 参数          | 类型   | 描述        | 是否必填 |
| :------------ | :----- | :------------------------------- | :------- |
| `host`        | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                                              | 是       |
| `org_name`    | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                                         | 是       |
| `app_name`    | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。     | 是       |
| `username`    | String | 用户 ID。用户的唯一登录账号。 | 是       |
| `chatroom_id` | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符，可从[查询所有聊天室基本信息](./agora_chat_restful_chatroom%20?platform=RESTful#查询所有聊天室基本信息) 的响应 body 中获取。                                                                 | 是       |

### 响应参数

| 参数                | 类型   | 描述                             |
| :------------------ | :----- | :-------------------------------------------- |
| `action`            | String | 请求方式。                                                        |
| `organization`      | String | 即时通讯服务分配给每个企业（组织）的唯一标识，与请求参数 `org_name` 相同。 |
| `application`       | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。             |
| `applicationName`   | String | 即时通讯服务分配给每个 app 的唯一标识，与请求参数 `app_name` 相同。       |
| `uri`               | String | 请求 URL。                                                        |
| `path`              | String | 请求路径，属于请求 URL 的一部分，无需关注。                       |
| `entities`          | JSON   | 返回实体信息。                                                    |
| `data`              | JSON   | 返回数据详情。                                                    |
| `timestamp`         | Number   | 响应的 Unix 时间戳，单位为毫秒。                                 |
| `duration`          | Number | 从发送请求到响应的时长，单位为毫秒。                                  |

## 认证方式

即时通讯服务 RESTful API 要求 HTTP 身份验证。每次发送 HTTP 请求时，必须在请求 header 填入如下 `Authorization` 字段：

```http
Authorization: Bearer YourAppToken
```

为了提高项目的安全性，声网使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯服务 RESTful API 仅支持使用 app 权限 token 对用户进行身份验证。详见[使用 App 权限 token 进行身份验证](./agora_chat_token?platform=RESTful)。

## 查询聊天室白名单

查询一个聊天室白名单中的用户列表。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                      | 是否必填 | 
| :-------------- | :----- | :------- | :----------------------------- |
| `Accept`        | String | 内容类型。填入 `application/json`。     | 是       | 
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       | 

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段   | 类型  | 描述                      |
| :----- | :---- | :------------------------ |
| `data` | Array | 聊天室白名单中的用户 ID。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' 'http://XXXX/XXXX/XXXX/chatrooms/66XXXX33/white/users'
```

#### 响应示例

```json
{
  "action": "get",
  "application": "5cXXXX75d",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/66XXXX33/white/users",
  "entities": [],
  "data": [
    "wzy_test",
    "wzy_vivo",
    "wzy_huawei",
    "wzy_xiaomi",
    "wzy_meizu"
  ],
  "timestamp": 1594724947117,
  "duration": 3,
  "organization": "XXXX",
  "applicationName": "testapp",
  "count": 5
}
```

## 添加单个用户至聊天室白名单

将单个用户添加至聊天室白名单。用户添加至聊天室白名单后，当聊天室全员禁言时，仍可以在聊天室中发送消息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users/{username}
```

#### 路径参数

| 参数          | 类型   | 描述        | 是否必填 |
| :------------ | :----- | :------------------------------- | :------- |
| `username`        | String | 要添加至聊天室白名单中的用户 ID。    | 是       |

其他参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                            | 是否必需 | 
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 内容类型。填入 `application/json`。                          | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段              | 类型   | 描述                                                         |
| :---------------- | :----- | :----------------------------------------------------------- |
| `data`     | JSON   | 聊天室白名单成员添加结果。 |
| `data.result`     | Boolean   | 是否成功将单个成员添加至聊天室白名单：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.chatroomid` | String | 聊天室 ID。                                                  |
| `data.action`     | String | 执行操作。在该响应中，该字段的值为 `add_user_whitelist`，表示将用户添加至聊天室白名单中。 |
| `data.user`       | String | 添加至聊天室白名单的成员的用户 ID。                                              |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' 'http://XXXX/XXXX/XXXX/chatrooms/{66XXXX33}/white/users/{username}'
```

#### 响应示例

```json
{
  "action": "post",
  "application": "5cXXXX75d",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/66XXXX33/white/users/wzy_xiaomi",
  "entities": [],
  "data": {
    "result": true,
    "action": "add_user_whitelist",
    "user": "wzy_xiaomi",
    "chatroomid": "66XXXX33"
  },
  "timestamp": 1594724293063,
  "duration": 4,
  "organization": "XXXX",
  "applicationName": "testapp"
}
```

## 批量添加用户至聊天室白名单

添加多个用户至聊天室白名单。你一次最多可添加 60 个用户。用户添加至聊天室白名单后，聊天室全员禁言时，仍可以在聊天室中发送消息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 是否必需 | 描述                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | 是       | 内容类型。填入 `application/json`。                          |
| `Accept`        | String | 是       | 内容类型。填入 `application/json`。                          |
| `Authorization` | String | 是       | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 |

### 请求 body

| 参数        | 类型  | 描述                                                         |
| :---------- | :---- | :----------------------------------------------------------- |
| `usernames` | Array | 待添加至聊天室白名单中的用户 ID，每次最多可传 60 个，用户 ID 之间以英文逗号（,）分隔。 |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段              | 类型   | 描述                                                         |
| :---------------- | :----- | :----------------------------------------------------------- |
| `data`     | JSON Array   | 将用户批量添加至聊天室白名单的结果。 |
| `data.result`     | Boolean   | 是否成功将用户批量添加至聊天室白名单：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.reason`     | String | 添加失败的原因。                                             |
| `data.chatroomid` | String | 聊天室 ID。                                                  |
| `data.action`     | String | 执行的操作。在该响应中，该字段的值为 `add_user_whitelist`，表示添加用户至聊天室白名单。 |
| `data.user`       | String | 添加至聊天室白名单中的用户 ID。                              |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' -d '{"usernames" : ["user1"]}' 'http://XXXX/XXXX/XXXX/chatrooms/{chatroomid}/white/users'
```

#### 响应示例

```json
{
  "action": "post",
  "application": "5cXXXX75d",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/66XXXX33/white/users",
  "entities": [],
  "data": [
    {
      "result": true,
      "action": "add_user_whitelist",
      "user": "wzy_test",
      "chatroomid": "66XXXX33"
    },
    {
      "result": true,
      "action": "add_user_whitelist",
      "user": "wzy_meizu",
      "chatroomid": "66XXXX33"
    }
  ],
  "timestamp": 1594724634191,
  "duration": 2,
  "organization": "XXXX",
  "applicationName": "testapp"
}
```

## 将用户移出聊天室白名单

将指定用户从聊天室白名单移除。你每次最多可移除 60 个用户。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users/{username}
```

#### 路径参数

| 参数          | 类型   | 描述        | 是否必填 |
| :------------ | :----- | :------------------------------- | :------- |
| `username`        | String | 要移出聊天室白名单的用户 ID。    | 是       |

其他参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 是否必需 | 描述                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 是       | 内容类型。填入 `application/json`。                          |
| `Authorization` | String | 是       | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段              | 类型   | 描述                                                         |
| :---------------- | :----- | :----------------------------------------------------------- |
| `data`     | JSON Array  | 将用户移出聊天室白名单的结果。 |
| `data.result`     | Boolean   | 是否成功将用户移出聊天室白名单：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.chatroomid` | String | 聊天室 ID。                                                  |
| `data.action`     | String | 执行的操作。在该响应中，该字段的值为 `remove_user_whitelist`，表示将用户移出聊天室白名单。 |
| `data.user`       | String | 移出聊天室白名单的成员的用户 ID。              |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' 'http://XXXX/XXXX/XXXX/chatrooms/{66XXXX33}/white/users/{username}'
```

#### 响应示例

```json
{
  "action": "delete",
  "application": "5cXXXX75d",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/66XXXX33/white/users/wzy_huawei,wzy_meizu",
  "entities": [],
  "data": [
    {
      "result": true,
      "action": "remove_user_whitelist",
      "user": "wzy_huawei",
      "chatroomid": "66XXXX33"
    },
    {
      "result": true,
      "action": "remove_user_whitelist",
      "user": "wzy_meizu",
      "chatroomid": "66XXXX33"
    }
  ],
  "timestamp": 1594725137704,
  "duration": 1,
  "organization": "XXXX",
  "applicationName": "XXXX"
}
```

## 状态码

详见 [HTTP 状态码](./agora_chat_status_code?platform=RESTful)。
 