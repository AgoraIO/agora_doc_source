本文展示如何实现聊天室黑名单管理，包括查看黑名单中的用户以及将用户添加至和移出黑名单等操作。

## <a name="param"></a>公共参数

下表列举了即时通讯 RESTful API 的公共请求参数和响应参数：

### 请求参数

| 参数          | 类型   | 描述        | 是否必填 |
| :------------ | :----- | :------------------------------- | :------- |
| `host`        | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                                              | 是       |
| `org_name`    | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                                         | 是       |
| `app_name`    | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。     | 是       |
| `chatroom_id` | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符，可从[查询所有聊天室基本信息](./agora_chat_restful_chatroom%20?platform=RESTful#查询所有聊天室基本信息) 的响应 body 中获取。                                                                 | 是       |

### 响应参数

| 参数                | 类型   | 描述                             |
| :------------------ | :----- | :-------------------------------------------- |
| `action`            | String | 请求方式。                                                        |
| `organization`      | String | 即时通讯服务分配给每个企业（组织）的唯一标识，与请求参数 `org_name` 相同。 |
| `application`       | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。             |
| `applicationName`   | String | 即时通讯服务分配给每个 app 的唯一标识，与请求参数 `app_name` 相同。       |
| `uri`               | String | 请求 URL。                                                        |
| `entities`          | JSON   | 返回实体信息。                                                    |
| `timestamp`         | Number   | 响应的 Unix 时间戳，单位为毫秒。                                 |
| `duration`          | Number | 从发送请求到响应的时长，单位为毫秒。                                  |

## 认证方式

即时通讯服务 RESTful API 要求 HTTP 身份验证。每次发送 HTTP 请求时，必须在请求 header 填入如下 `Authorization` 字段：

```http
Authorization: Bearer ${YourAppToken}
```

为了提高项目的安全性，Agora 使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯服务 RESTful API 仅支持使用 app 权限 token 对用户进行身份验证。详见[使用 App Token 进行身份验证](./agora_chat_token?platform=RESTful)。

## 查询聊天室黑名单

查询一个聊天室黑名单中的用户列表。黑名单中的用户无法查看或接收该聊天室的信息。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 是否必需 | 描述                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 是       | 内容类型。请填 `application/json`。                          |
| `Authorization` | String | 是       | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段   | 类型  | 描述                      |
| :----- | :---- | :------------------------ |
| `data` | Array | 聊天室黑名单中的用户 ID。 |
| `count` | Number | 聊天室黑名单中的用户数量。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' 'http://XXXX/XXXX/XXXX/chatrooms/66XXXX33/blocks/users'
```

#### 响应示例

```json
{
  "action": "get",
  "application": "8beXXXX02",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/66XXXX33/blocks/users",
  "entities": [],
  "data": [
    "user2",
    "user3"
  ],
  "timestamp": 1543466293681,
  "duration": 0,
  "organization": "XXXX",
  "applicationName": "testapp",
  "count": 2
}
```

## 添加单个用户至聊天室黑名单

将单个用户加入指定聊天室的黑名单。聊天室所有者无法被加入聊天室的黑名单。

用户进入聊天室黑名单后，无法查看和收发该聊天室的消息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users/{username}
```

#### 路径参数

| 参数          | 类型   | 描述        | 是否必填 |
| :------------ | :----- | :------------------------------- | :------- |
| `username`    | String | 要添加至聊天室黑名单的用户 ID。 | 是       |

其他参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 是否必需 | 描述                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | 是       | 内容类型。请填 `application/json`。                          |
| `Accept`        | String | 是       | 内容类型。请填 `application/json`。                          |
| `Authorization` | String | 是       | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段              | 类型   | 描述                                                         |
| :---------------- | :----- | :----------------------------------------------------------- |
| `data`     | JSON   | 将用户添加至聊天室黑名单的结果。 |
| `data.result`     | Boolean   | 是否成功将用户添加至聊天室黑名单：<ul><li>`true`：是</li><li>`false`：否<ul><li> |
| `data.action`     | String | 执行的操作。在该响应中，该字段的值为 `add_blocks`，表示向聊天室黑名单中添加用户。 |
| `data.user`       | String | 添加至聊天室白名单的用户 ID。      |
| `data.chatroomid` | String | 聊天室 ID。              |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' 'http://XXXX/XXXX/XXXX/chatrooms/66XXXX33/blocks/users/user1'
```

#### 响应示例

```json
{
  "action": "post",
  "application": "8beXXXX02",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/66XXXX33/blocks/users/user1",
  "entities": [],
  "data": {
    "result": true,
    "action": "add_blocks",
    "user": "user1",
    "chatroomid": "66XXXX33"
  },
  "timestamp": 1542539577124,
  "duration": 27,
  "organization": "XXXX",
  "applicationName": "testapp"
}
```

## 批量添加用户至聊天室黑名单

将多个用户加入指定聊天室的黑名单。你一次最多可以添加 60 个用户至聊天室黑名单。聊天室所有者无法被添加至聊天室黑名单。

用户进入聊天室黑名单后无法查看和接收该聊天室中的消息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 是否必需 | 描述                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | 是       | 内容类型。请填 `application/json`。                          |
| `Accept`        | String | 是       | 内容类型。请填 `application/json`。                          |
| `Authorization` | String | 是       | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 |

### 请求 body

| 参数        | 类型  | 描述                                                         |
| :---------- | :---- | :----------------------------------------------------------- |
| `usernames` | Array | 要添加至聊天室黑名单的用户 ID。多个用户 ID 通过英文逗号（,）分隔，一次最多可添加 60 个。 |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段              | 类型   | 描述                                                         |
| :---------------- | :----- | :----------------------------------------------------------- |
| `data`     | JSON Array   | 批量添加用户至聊天室黑名单的结果。|
| `data.result`     | Boolean   | 是否成功批量添加用户至聊天室黑名单：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.action`     | String | 执行的操作。在该响应中，该字段的值为 `add_blocks`，表示向聊天室黑名单中添加用户。 |
| `data.reason`     | String | 添加失败的原因。                                             |
| `data.user`       | String | 添加至聊天室黑名单的用户 ID。                                              |
| `data.chatroomid` | String | 聊天室 ID。                                                  |

其他参数及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' -d '{
   "usernames": [
     "user3","user4"
 }' 'http://XXXX/XXXX/XXXX/chatrooms/66XXXX33/blocks/users'
```

#### 响应示例

```json
{
  "action": "post",
  "application": "8beXXXX02",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/66XXXX33/blocks/users",
  "entities": [],
  "data": [
    {
      "result": false,
      "action": "add_blocks",
      "reason": "user: user3 doesn't exist in chatroom: 66XXXX33",
      "user": "user3",
      "chatroomid": "66XXXX33"
    },
    {
      "result": true,
      "action": "add_blocks",
      "user": "user4",
      "chatroomid": "66XXXX33"
    }
  ],
  "timestamp": 1542540095540,
  "duration": 16,
  "organization": "XXXX",
  "applicationName": "testapp"
}
```

## 从聊天室黑名单移出单个用户

将指定用户移出聊天室黑名单。对于聊天室黑名单中的用户，如果需要将其再次加入聊天室，需要先将其从聊天室黑名单中移除。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users/{username}
```

#### 路径参数

| 参数          | 类型   | 描述        | 是否必填 |
| :------------ | :----- | :------------------------------- | :------- |
| `username`    | String | 要从聊天室黑名单中移除的用户 ID。 | 是       |

其他参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 是否必需 | 描述                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 是       | 内容类型。请填 `application/json`。                          |
| `Authorization` | String | 是       | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段              | 类型   | 描述                                                         |
| :---------------- | :----- | :----------------------------------------------------------- |
| `data`     | JSON   | 将该用户移出聊天室黑名单的结果。 |
| `data.result`     | Boolean   | 是否成功将该用户移出聊天室黑名单：<ul><li>`true`：是</li><li>`false`：否<ul><li>|
| `data.chatroomid` | String | 聊天室 ID。                                                  |
| `data.action`     | String | 执行的操作。在该响应中，该字段的值为 `remove_blocks`，表示将用户移出聊天室黑名单。 |
| `data.user`       | String | 被移除的用户 ID。                                            |

其他参数及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。


### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' 'http://XXXX/XXXX/XXXX/chatrooms/66XXXX33/blocks/users/user1'
```

#### 响应示例

```json
{
  "action": "delete",
  "application": "8beXXXX02",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/66XXXX33/blocks/users/user1",
  "entities": [],
  "data": {
    "result": true,
    "action": "remove_blocks",
    "user": "user1",
    "chatroomid": "66XXXX33"
  },
  "timestamp": 1542540470679,
  "duration": 45,
  "organization": "XXXX",
  "applicationName": "testapp"
}
```

## 从聊天室黑名单批量移除用户

将多名指定用户从聊天室黑名单中移除。你每次最多可移除 60 个用户。

对于聊天室黑名单中的用户，如果需要将其再次加入聊天室，需首先将其从聊天室黑名单中移除。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users/{usernames}
```

#### 路径参数

| 参数       | 类型   | 描述            | 是否必填 | 
| :--------- | :----- | :------- | :------------------- |
| `usernames` | String | 要从聊天室黑名单中移出的用户 ID。多个用户 ID 以逗号（,）分隔，每次最多可传 60 个。 | 是       | 

其他参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述          | 是否必填 | 
| :-------------- | :----- | :------- | :--------------------------- |
| `Accept`        | String | 内容类型。请填 `application/json`。                          | 是       | 
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是  | 

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段              | 类型   | 描述                                                         |
| :---------------- | :----- | :----------------------------------------------------------- |
| `data`     | JSON Array   | 批量移出聊天室黑名单的结果。 |
| `data.result`     | Boolean   | 是否成功将用户批量移出聊天室黑名单：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.action`     | String | 执行的操作。在该响应中，该字段的值为 `remove_blocks`，表示将用户移出聊天室黑名单。 |
| `data.user`       | String | 被移除的用户 ID。                                            |
| `data.chatroomid` | String | 聊天室 ID。                                                  |

其他参数及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' 'http://XXXX/XXXX/XXXX/chatrooms/66XXXX33/blocks/users/user1%2Cuser2'
```

#### 响应示例

```json
{
  "action": "delete",
  "application": "8beXXXX02",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/66XXXX33/blocks/users/user1%2Cuser2",
  "entities": [],
  "data": [
    {
      "result": true,
      "action": "remove_blocks",
      "user": "user1",
      "chatroomid": "66XXXX33"
    },
    {
      "result": true,
      "action": "remove_blocks",
      "user": "user2",
      "chatroomid": "66XXXX33"
    }
  ],
  "timestamp": 1542541014655,
  "duration": 29,
  "organization": "XXXX",
  "applicationName": "testapp"
}
```

 