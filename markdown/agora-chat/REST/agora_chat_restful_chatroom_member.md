本文展示如何调用即时通讯 RESTful API 实现聊天室成员管理，包括添加和移除聊天室成员以及设置和移除聊天室管理员相关操作。

调用本文中的 API 前，请先参考[使用限制](./agora_chat_limitation?platform=RESTful#服务端接口调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

## 聊天室成员角色说明

| 成员角色     | 描述                                               | 管理权限                                                                       |
| :----------- | :------------------------------------------------- | :----------------------------------------------------------------------------- |
| 普通成员     | 不具备管理权限的聊天室成员。                       | 普通成员可以修改自己的聊天室资料。                                             |
| 聊天室管理员 | 由聊天室创建者授权，协助聊天室管理，具有管理权限。 | 管理员可以管理聊天室内的普通成员。 最多支持添加 99 个管理员。                  |
| 聊天室所有者 | 聊天室的创建者，具有聊天室最高权限。               | 聊天室所有者可以指定聊天室管理员、解散聊天室、修改聊天室信息、管理聊天室成员。 |

## <a name="param"></a>公共参数

下表列举了即时通讯 RESTful API 的公共请求参数和响应参数：

### 请求参数

| 参数          | 类型   | 描述                                                                                                                                                                                                                                                        | 是否必填 |
| :------------ | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host`        | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                                              | 是       |
| `org_name`    | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                                         | 是       |
| `app_name`    | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                                                | 是       |
| `username`    | String | 用户 ID。用户的唯一登录账号。 | 是       |
| `chatroom_id` | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符，可从[查询所有聊天室基本信息](./agora_chat_restful_chatroom%20?platform=RESTful#查询所有聊天室基本信息) 的响应 body 中获取。                                                                 | 是       |

### 响应参数

| 参数                | 类型   | 描述                                                              |
| :------------------ | :----- | :---------------------------------------------------------------- |
| `action`            | String | 请求方式。                                                        |
| `organization`      | String | 即时通讯服务分配给每个企业（组织）的唯一标识，与请求参数 `org_name` 相同。 |
| `application`       | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。             |
| `applicationName`   | String | 即时通讯服务分配给每个 app 的唯一标识，与请求参数 `app_name` 相同。        |
| `uri`               | String | 请求 URL。                                                        |
| `path`              | String | 请求路径，属于请求 URL 的一部分，无需关注。                       |
| `entities`          | JSON   | 返回实体信息。                                                    |
| `data`              | JSON   | 返回数据详情。                                                    |
| `timestamp`         | Number   | 响应的 Unix 时间戳，单位为毫秒。                                      |
| `duration`          | Number | 从发送请求到响应的时长，单位为毫秒。                                  |

## 认证方式

即时通讯服务 RESTful API 要求 HTTP 身份验证。每次发送 HTTP 请求时，必须在请求 header 填入如下 `Authorization` 字段：

```http
Authorization: Bearer YourAppToken
```

为了提高项目的安全性，Agora 使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯服务 RESTful API 仅支持使用 app 权限 token 对用户进行身份验证。详见[使用 App 权限 token 进行身份验证](./agora_chat_token?platform=RESTful)。

## 添加单个聊天室成员

向聊天室添加一个成员。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/users/{username}
```

#### 路径参数

参数及描述详见[公共参数](#param)。

> 如果待添加的用户在 app 中不存在或已经在聊天室中，则请求失败并返回错误码 `400`。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。   | 是       |
| `Accept`        | String | 内容类型。填入 `application/json`。  | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。| 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型   | 描述                                                    |
| :------- | :----- | :------------------------------------------------------ |
| `result` | Boolean   | 是否添加成功：<ul><li>`true：`是</li><li>`false`：否</li></ul> |
| `action` | String | 执行的操作，`add_member` 表示向聊天室添加成员。         |
| `id`     | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符。   |
| `user`   | String | 成功添加为成员的用户 ID。                                    |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/users/XXXX'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/users/XXXX",
    "entities": [],
    "data": {
        "result": true,
        "action": "add_member",
        "id": "XXXX",
        "user": "user1"
    },
    "timestamp": 1542554038353,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 批量添加聊天室成员

向聊天室添加多名用户。一次性最多可添加 60 位用户。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/users
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。    | 是       |
| `Accept`        | String | 内容类型。填入 `application/json`。    | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

#### 请求 body

请求包体为 JSON Object 类型，包含以下字段：

| 字段        | 类型       | 描述                     | 是否必填 |
| :---------- | :--------- | :----------------------- | :------- |
| `usernames` | JSON Array | 待添加成员的用户 ID 数组。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应 body 包含如下字段：

| 字段         | 类型       | 描述                                                  |
| :----------- | :--------- | :---------------------------------------------------- |
| `data.newmembers` | JSON Array | 已添加成员的用户 ID 数组。                              |
| `action`     | String     | 执行的操作，`add_member` 表示向聊天室添加成员。       |
| `id`         | String     | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符。 |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
   "usernames": [
     "user1","user2"
   ]
 }' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/users'
```

#### 响应示例

```json
{
  "action": "post",
  "application": "8beXXXX02",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/66XXXX33/users",
  "entities": [],
  "data": {
    "newmembers": [
      "user1",
      "user2"
    ],
    "action": "add_member",
    "id": "66XXXX33"
  },
  "timestamp": 1542554537237,
  "duration": 9,
  "organization": "XXXX",
  "applicationName": "testapp"
}
```

## 分页查询聊天室成员

分页查询聊天室成员。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/users?pagenum={N}&pagesize={N}
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 查询参数

| 参数       | 类型 | 描述                                                         | 是否必填 |
| :--------- | :--- | :----------------------------------------------------------- | :------- |
| `pagenum`  | Number  | 查询页码。默认值为 1。                                       | 否       |
| `pagesize` | Number  | 每页显示的聊天室成员数量。默认值为 1000。取值范围为 [0,1000]。 | 否       |

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。| 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型   | 描述                 |
| :------- | :----- | :------------------- |
| `data.member` | String | 聊天室成员的用户 ID。 |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token

curl -X GET http://XXXX/XXXX/XXXX/chatrooms/12XXXX11/users?pagenum=2&pagesize=2 -H 'Authorization: Bearer <YourAppToken> '
```

#### 响应示例

```json
{
    "action": "get",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "params": {
        "pagesize": ["2"],
        "pagenum": ["2"]
    },
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/users",
    "entities": [],
    "data": [
        {
            "member": "user1"
        },
        {
            "member": "user2"
        }
    ],
    "timestamp": 1489074511416,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX",
    "count": 2
}
```

## 删除单个聊天室成员

删除单个聊天室成员。如果被移除用户不在聊天室中或聊天室不存在，将返回错误。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/users/{username}
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。  | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型   | 描述                                                    |
| :------- | :----- | :------------------------------------------------------ |
| `data.result` | Boolean   | 是否成功移出聊天室成员：<li>`true`：是。<li>`false`：否。 |
| `data.action` | String | 执行的操作，`remove_member` 表示删除聊天室成员。        |
| `data.user`   | String | 已删除成员的用户 ID。                                    |
| `data.id`     | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符。   |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token

curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/users/XXXX'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/users/XXXX",
    "entities": [],
    "data": {
        "result": true,
        "action": "remove_member",
        "user": "user1",
        "id": "XXXX"
    },
    "timestamp": 1542555744726,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 批量删除聊天室成员

从聊天室移除多个成员，单次请求最多可移除 100 个成员。如果被移除用户不在聊天室中或聊天室不存在，将返回错误。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/users/{usernames}
```

### HTTP 请求

#### 路径参数

| 参数        | 类型   | 描述                                                                                                   | 是否必填 |
| :---------- | :----- | :----------------------------------------------------------------------------------------------------- | :------- |
| `usernames` | String | 一个或多个用户 ID，用户 ID 之间用 "," 分隔。在 URL 中，"," 需要转义为 "%2C"。一次最多传入 100 个 用户 ID。 | 是       |

其他参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。| 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。| 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应 body 包含如下字段：

| 字段     | 类型   | 描述                                                    |
| :------- | :----- | :------------------------------------------------------ |
| `data.result` | Boolean   | 是否成功批量移除聊天室成员：<li>`true`：是。<li>`false`：否。 |
| `data.action` | String | 执行的操作，`remove_member` 表示删除聊天室成员。        |
| `data.reason` | String | 删除失败原因。                                          |
| `data.user`   | String | 已删除成员的用户 ID 列表。                                |
| `data.id`     | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符。   |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token

curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/users/user1%2Cuser2'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/users/user1%2Cuser2",
    "entities": [],
    "data": [
        {
            "result": false,
            "action": "remove_member",
            "reason": "user: user1 doesn't exist in group: 66213271109633",
            "user": "user1",
            "id": "XXXX"
        },
        {
            "result": true,
            "action": "remove_member",
            "user": "user2",
            "id": "XXXX"
        }
    ],
    "timestamp": 1542556177147,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 添加单个聊天室管理员

将一个聊天室普通成员设置为聊天室管理员。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/admin
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。    | 是       |
| `Content-Type`  | String | 内容类型。填入 `application/json`。   | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。| 是       |

#### 请求 body

请求包体为 JSON Object 类型，包含以下字段：

| 字段       | 类型   | 描述                   | 是否必填 |
| :--------- | :----- | :--------------------- | :------- |
| `newadmin` | String | 待添加为聊天室管理员的成员用户 ID。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型   | 描述                                            |
| :--------- | :----- | :---------------------------------------------- |
| `data.result`   | Boolean   | 是否成功添加聊天室管理员：<ul><li>`true`：是</li><li>`false`：否</li></ul>  |
| `data.newadmin` | String | 添加为聊天室管理员的成员用户 ID。                        |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
   "newadmin": "user1"
 }' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/admin'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "22bcffa0-XXXX-XXXX-9df8-516f6df68c6d",
    "applicationName": "XXXX",
    "data": {
        "result": "success",
        "newadmin": "user1"
    },
    "duration": 0,
    "entities": [],
    "organization": "XXXX",
    "timestamp": 1642486989028,
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/admin"
}
```

## 获取聊天室管理员列表

获取聊天室管理员列表。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/admin
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。  | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段   | 类型       | 描述                     |
| :----- | :--------- | :----------------------- |
| `data` | JSON Array | 聊天室管理员用户 ID 数组。 |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token

curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/admin'
```

#### 响应示例

```json
{
    "action": "get",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/admin",
    "entities": [],
    "data": ["XXXX"],
    "timestamp": 1489073361210,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX",
    "count": 1
}
```

## 移除聊天室管理员权限

将聊天室成员的角色从聊天室管理员降为普通成员，即将管理员移除聊天室管理员列表。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/admin/{oldadmin}
```

#### 路径参数

| 参数       | 类型   | 描述                           | 是否必填 |
| :--------- | :----- | :----------------------------- | :------- |
| `oldadmin` | String | 待移除聊天室管理员权限的用户 ID。 | 是       |

其他参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json` | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。| 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型    | 描述                                            |
| :--------- | :------ | :---------------------------------------------- |
| `data.result`   | Boolean | 是否成功撤销聊天室管理员的管理权限：<ul><li>`true`：是。</li><li>`false`：否。</li></ul> |
| `data.oldadmin` | String  | 被移除聊天室管理员权限的用户 ID。                    |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token

curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/admin/XXXX'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/admin/XXXX",
    "entities": [],
    "data": {
        "result": "success",
        "oldadmin": "XXXX"
    },
    "timestamp": 1489073432732,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## <a name="code"></code> 状态码

详见 [HTTP 状态码](./agora_chat_status_code?platform=RESTful)。