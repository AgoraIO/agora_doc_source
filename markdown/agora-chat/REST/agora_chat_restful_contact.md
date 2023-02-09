用户关系管理是指添加好友、移除好友以及将用户添加至或移出黑名单。

本文展示如何调用即时通讯 RESTful API 管理好友。调用以下方法前，请先参考 [限制条件](./agora_chat_limitation) 了解即时通讯 RESTful API 的调用频率限制。

<a name="pubparam"></a>
## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述                                                         | 是否必填 |
| :--------- | :----- | :----------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `username` | String | 用户 ID。 | 是       |

### 响应参数

| 参数                 | 类型    | 描述                                                         |
| :------------------- | :------ | :----------------------------------------------------------- |
| `action`             | String  | 请求方式。                                                   |
| `organization`       | String  | 即时通讯服务分配给每个企业（组织）的唯一标识，与请求参数 `org_name` 相同。 |
| `application`        | String  | 系统内为 app 生成的唯一内部标识，无需关注。                  |
| `applicationName`    | String  | 即时通讯服务分配给每个 app 的唯一标识，与请求参数 `app_name` 相同。 |
| `uri`                | String  | 请求 URL。                                                   |
| `path`               | String  | 请求路径，属于请求 URL 的一部分，无需关注。                  |
| `entities`           | JSON    | 返回实体信息。                                               |
| `data`               | Array   | 实际请求到的数据。                                           |
| `entities.uuid`      | String  | 用户的 UUID。系统为该请求中的用户生成唯一内部标识，无需关注。 |
| `entities.type`      | String  | 对象类型。无需关注。                                         |
| `entities.created`   | Number  | 注册用户的 Unix 时间戳（毫秒）。                             |
| `entities.modified`   | Number  | 用户信息的最新修改时间，为 Unix 时间戳（毫秒）。                             |
| `entities.username`  | String  | 用户 ID。用户登录的唯一账号。                                |
| `entities.activated` | Boolean | 用户是否为活跃状态：<ul><li>`true`：用户为活跃状态。</li><li>`false`：用户为封禁状态。</li></ul> |
| `timestamp`          | Long  | 响应的 Unix 时间戳（毫秒）。                                 |
| `duration`           | Number  | 从发送请求到响应的时长（毫秒）。                             |

## 认证方式

即时通讯服务 RESTful API 要求 HTTP 身份验证。每次发送 HTTP 请求时，必须在请求 header 填入如下 `Authorization` 字段：

```http
Authorization: Bearer ${YourAppToken}
```

为了提高项目的安全性，Agora 使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯服务 RESTful API 仅支持使用 app 权限 token 对用户进行身份验证。详见[使用 App Token 进行身份验证](./agora_chat_token?platform=RESTful)。

## 添加好友

将同一个 App Key 下的用户添加为好友。不同套餐版本支持的用户好友数不同，其中免费版支持的最多好友数为 100。详情请参考 [限制条件](./agora_chat_limitation)。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/users/{owner_username}/contacts/users/{friend_username}
```

#### 路径参数

| 参数            | 类型   | 描述                 | 是否必填 |
| :-------------- | :----- | :------------------- | :------- |
| `owner_username`  | String | 当前用户的用户 ID。   | 是       |
| `friend_username` | String | 待添加好友的用户 ID。 | 是       |

其他路径参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。                                 | 是       |
| `Accept`  | String | 内容类型。填入 `application/json`。                                 | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型      | 描述                                                         |
| :---------- | :---------------- | :----------------------------------------------------------- |
| `entities`     | JSON Array    | 添加的好友的详情。                                                   |
| `entities.uuid`       | String      | 系统内为好友生成的系统内唯一标识，开发者无需关心。           |
| `entities.type`        | String     | 对象类型，值为 `user` 或 `group`。                          |
| `entities.created`       | Number   | 用户创建时间，Unix 时间戳，单位为毫秒。                      |
| `entities.modified`      | Number  | 好友的用户信息如密码或者昵称等最新修改时间，Unix 时间戳，单位为毫秒。 |
| `entities.username`   | String   | 添加的好友的用户 ID。                                             |
| `entities.activated`   | Boolean  | 好友是否为正常状态：<ul><li>`true` 正常状态。</li><li>`false` 已被封禁。</li></ul> |
| `entities.nickname`      | String   | 好友的用户昵称。                                                   |

其他字段即说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则表示请求失败。你可以参考 [响应状态码](error.html) 了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users/user1/contacts/users/user2'
```

#### 响应示例

```json
{
    "path": "/users/4759aa70-XXXX-XXXX-925f-6fa0510823ba/contacts",
    "uri": "https://XXXX/XXXX/XXXX/users/4759aa70-eba5-11e8-925f-6fa0510823ba/contacts",
    "timestamp": 1542598913819,
    "organization": "XXXX",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "entities": [
      {
        "uuid": "b2aade90-XXXX-XXXX-a974-f3368f82e4f1",
        "type": "user",
        "created": 1542356523769,
        "modified": 1542597334500,
        "username": "user2",
        "activated": true
      }
    ],
    "action": "post",
    "duration": 63,
    "applicationName": "XXXX"
}
```

## 移除好友

从用户的好友列表中移除一个用户。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/users/{owner_username}/contacts/users/{friend_username}
```

#### 路径参数

| 参数            | 类型   | 描述                 | 是否必填 |
| :-------------- | :----- | :------------------- | :------- |
| `owner_username`  | String | 本地用户的用户 ID。   | 是       |
| `friend_username` | String | 被移除好友的用户 ID。 | 是       |

其他路径参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 内容类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。| 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段        | 类型   | 描述                                           |
| :---------- | :------------ | :--------------------------------------------- |
| `entities` | JSON Array   | 被移除的好友的详情。                                                   |
| `entities.uuid`    | String   | 系统内为好友生成的系统内唯一标识，开发者无需关心。           |
| `entities.type`         | String    | 对象类型，值为 `user` 或 `group`。                          |
| `entities.created`     | Number    | 用户创建时间，Unix 时间戳，单位为毫秒。                      |
| `entities.modified`      | Number   | 好友的用户信息如密码或者昵称等最近一次修改时间，Unix 时间戳，单位为毫秒。 |
| `entities.username`     | String    | 被移除好友的用户 ID。                                             |
| `entities.activated`      | Boolean  | 好友是否为正常状态：<ul><li>`true` 正常状态。</li><li>`false` 已被封禁。</li></ul> |
| `entities.nickname`      | String   | 好友的用户昵称。                                                   |

其他字段及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则表示请求失败。你可以参考 [响应状态码](error.html) 了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users/user1/contacts/users/user2'
```

#### 响应示例

```json
{
    "path": "/users/4759aa70-XXXX-XXXX-925f-6fa0510823ba/contacts",
    "uri": "https://XXXX/XXXX/XXXX/users/4759aa70-eba5-11e8-925f-6fa0510823ba/contacts",
    "timestamp": 1542599266616,
    "organization": "XXXX",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "entities": [
      {
        "uuid": "b2aade90-XXXX-XXXX-a974-f3368f82e4f1",
        "type": "user",
        "created": 1542356523769,
        "modified": 1542597334500,
        "username": "user2",
        "activated": true,
      }
    ],
    "action": "delete",
    "duration": 350,
    "applicationName": "XXXX"
}
```

## 获取好友列表

获取指定用户的好友列表。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/users/{owner_username}/contacts/users
```

#### 路径参数

| 参数           | 类型   | 描述               | 是否必需 |
| :------------- | :----- | :----------------- | :------- |
| `owner_username` | String | 好友列表所有者的用户 ID。 | 是       |

其他字段说明详见 [公共参数](#pubparam)。

#### 请求 Header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。请填 `application/json`。 | 是    | 
| `Accept`  | String | 参数类型。填入 `application/json`。            | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}` | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 Body 中包含以下字段：

| 参数  | 类型   | 描述                 |
| :---- | :----- | :------------------- |
| `data`  | Array  | 获取的好友列表，例如 "user1", "user2"。 |
| `count` | Number | 好友数量。           |

其他字段说明详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users/user1/contacts/users'
```

#### 响应示例

```json
{
    "uri": "http://XXXX/XXXX/XXXX/users/user1/contacts/users",
    "timestamp": 1543819826513,
    "entities": [],
    "count": 2,
    "action": "get",
    "data": [
      "user3",
      "user2"
    ],
    "duration": 12
}
```

## 添加用户至黑名单

将指定用户添加到黑名单。添加后，黑名单中的用户无法给该用户发消息。每个用户的黑名单人数上限为 500。

对于每个 App Key，此方法的调用频率限制为每秒 50 次。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/users/{owner_username}/blocks/users
```

#### 路径参数

| 参数             | 类型   | 是否必需 | 描述                                                         |
| :--------------- | :----- | :------- | :----------------------------------------------------------- |
| `owner_username` | String | 是    | 当前的用户 ID。                                                 |

本方法的其他路径参数及描述详见 [公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必填 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Accept`  | String | 内容类型。填入 `application/json`。                                  | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 Bearer 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

#### 请求 body

请求包体为 JSON Object 类型，包含以下字段：

| 字段      | 类型       | 描述                                              | 是否必填 |
| :-------- | :--------- | :------------------------------------------------ | :------- |
| `usernames` | Array | 待加入到黑名单中的用户 ID，如 ["user1", "user2"]。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 Body 中包含以下字段：

| 参数 | 类型  | 描述                           |
| :--- | :---- | :----------------------------- |
| `data` | Array | 添加到黑名单列表的用户 ID 列表。 |

其他字段说明详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{     "usernames": [       "user2"     ]   }' 'http://XXXX/XXXX/XXXX/users/user1/blocks/users'
```

#### 响应示例

```json
{
    "uri": "https://XXXX/XXXX/XXXX",
    "timestamp": 1542600372046,
    "organization": "XXXX",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "entities": [],
    "action": "post",
    "data": [
      "user2"
    ],
    "duration": 110,
    "applicationName": "XXXX"
}
```

## 获取黑名单列表

获取当前用户的黑名单列表。

对于每个 App Key，此方法的调用频率限制为每秒 50 次。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/users/{owner_username}/blocks/users
```

#### 路径参数

| 参数 | 类型 | 描述 | 是否必填 |
| :------------ | :----- | :---------------- | :------- |
| `owner_username` | String | 当前用户的用户 ID。 | 是 |

其他路径参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                  | 是否必需 |
| :------------ | :----- | :---------------- | :------- |
| `Accept`  | String | 内容类型。填入 `application/json`。                                  | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 Bearer 是固定字符，后面加英文空格，再加获取到的 token 值。| 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 Body 中包含以下字段：

| 参数 | 类型  | 描述                       |
| :--- | :---- | :------------------------- |
| `data` | Array | 获取的黑名单列表，例如 ["user1", "user2"]。 |
| `count`    | Number | 黑名单上用户的数量。                       |

其他字段说明详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users/user1/blocks/users'
```

#### 响应示例

```json
{
    "uri": "http://XXXX/XXXX/XXXX/users/user1/blocks/users",
    "timestamp": 1542599978751,
    "entities": [],
    "count": 1,
    "action": "get",
    "data": [
      "user2"
    ],
    "duration": 4
}
```

## 从黑名单中移除用户

从用户的黑名单中移除用户：
- 将好友从黑名单中移除后，恢复好友关系，可以正常收发消息；
- 将非好友从黑名单中移除后，恢复到未添加好友的状态。

对于每个 App Key，此方法的调用频率限制为每秒 50 次。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/users/{owner_username}/blocks/users/{blocked_username}
```

#### 路径参数

| 参数             | 类型   | 描述                   | 是否必填 |
| :--------------- | :----- | :--------------------- | :------- |
| `owner_username` | String | 当前用户的用户 ID。| 是 |
| `blocked_username` | String | 要移出黑名单的用户 ID。 | 是       |

其他路径参数及描述详见 [公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必填 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 内容类型。填入 `application/json`。                                  | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 Bearer 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 参数           | 类型   | 描述                                                         |
| :----------- | :------ | :---------------------------------------------- |
| `entities`       | JSON Array  | 从黑名单中移除的用户的详细信息。                             |
| `entities.uuid`        | String     | 用户在系统内的唯一标识。系统自动生成，开发者无需关心。       |
| `entities.type`          | String   | 对象类型，值为 `user`。         |
| `entities.created`         | Number  | 用户创建时间，Unix 时间戳，单位为毫秒。                      |
| `entities.modified`       | Number     | 用户信息如密码或昵称等的最新修改时间，Unix 时间戳，单位为毫秒。 |
| `entities.username`       | String  | 被移出黑名单的用户 ID。         |
| `entities.activated`      | Boolean   | 用户是否为正常状态：<ul><li>`true` 该用户为正常状态。</li><li>`false` 该用户为封禁状态。</li></ul> |
| `entities.nickname`      | String   | 被移出黑名单的用户的昵称。               |

其他字段及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考 [状态码](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users/user1/blocks/users/user2'
```

#### 响应示例

```json
{
    "path": "/users/4759aa70-XXXX-XXXX-925f-6fa0510823ba/blocks",
    "uri": "https://XXXX/XXXX/XXXX/users/4759aa70-eba5-11e8-925f-6fa0510823ba/blocks",
    "timestamp": 1542600712985,
    "organization": "XXXX",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "entities": [
      {
        "uuid": "b2aade90-XXXX-XXXX-a974-f3368f82e4f1",
        "type": "user",
        "created": 1542356523769,
        "modified": 1542597334500,
        "username": "user2",
        "activated": true,
      }
    ],
    "action": "delete",
    "duration": 20,
    "applicationName": "XXXX"
}
```

<a name="code"></a>
## 状态码

有关详细信息，请参阅 [HTTP 状态代码](./agora_chat_status_code?platform=RESTful)。