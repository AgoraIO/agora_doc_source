# 用户关系管理 REST API

好友管理是指添加好友、移除好友、添加黑名单、移除黑名单等操作。

本文展示如何调用 Agora 即时通讯 RESTful API 管理好友。调用以下方法前，请先参考[限制条件](./agora_chat_limitation)了解即时通讯 RESTful API 的调用频率限制。

<a name="pubparam"></a>
## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述                                                         | 是否必填 |
| :--------- | :----- | :----------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。 | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。 | 是       |
| `username` | String | 用户名。用户的唯一登录账号。长度在 64 个字符内，不可设置为空。支持以下字符集：<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>"_", "-", "."</li></ul>注意：<ul><li>该参数不区分大小写，因此 `Aa` 和 `aa` 为相同用户名。</li><li>请确保同一个 app 下，`username` 唯一。</li></ul> | 是       |

### 响应参数

| 参数                 | 类型    | 描述                                                         |
| :------------------- | :------ | :----------------------------------------------------------- |
| `action`             | String  | 请求方式。                                                   |
| `organization`       | String  | 组织 ID，等同于 org_name，即时通讯服务分配给每个企业（组织）的唯一标识。 |
| `application`        | String  | 系统内为 app 生成的唯一内部标识，无需关注。                  |
| `applicationName`    | String  | App ID，等同于 app_name，即时通讯服务分配给每个 app 的唯一标识。 |
| `uri`                | String  | 请求 URL。                                                   |
| `path`               | String  | 请求路径，属于请求 URL 的一部分，无需关注。                  |
| `entities`           | JSON    | 返回实体信息。                                               |
| `data`               | Array   | 实际请求到的数据。                                           |
| `entities.uuid`      | String  | 用户的 UUID。系统为该请求中的用户生成唯一内部标识，无需关注。 |
| `entities.type`      | String  | 对象类型。无需关注。                                         |
| `entities.created`   | Long  | 注册用户的 Unix 时间戳（毫秒）。                             |
| `entities.username`  | String  | 用户 ID。用户登录的唯一账号。                                |
| `entities.activated` | Boolean | 用户是否为活跃状态：<ul><li>`true`：用户为活跃状态。</li><li>`false`：用户为封禁状态。</li></ul> |
| `timestamp`          | Long  | 响应的 Unix 时间戳（毫秒）。                                 |
| `duration`           | Number  | 从发送请求到响应的时长（毫秒）。                             |

## 认证方式

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

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
| `owner_username`  | String | 本地用户的用户名。   | 是       |
| `friend_username` | String | 待添加好友的用户名。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。                                 | 是       |
| `Accept`  | String | 内容类型。填入 `application/json`。                                 | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}` | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 Body 中的字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

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

将用户从好友列表中移除。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/users/{owner_username}/contacts/users/{friend_username}
```

#### 路径参数

| 参数            | 类型   | 描述                 | 是否必填 |
| :-------------- | :----- | :------------------- | :------- |
| `owner_username`  | String | 本地用户的用户名。   | 是       |
| `friend_username` | String | 待添加好友的用户名。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 内容类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`| 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 Body 中的字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考 [状态码](#code)了解可能的原因。

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
| `owner_username` | String | 指定用户的用户名。 | 是       |

其他字段说明详见 [公共参数](#pubparam)。

#### 请求 Header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 参数类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}` | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 Body 中包含以下字段：

| 参数  | 类型   | 描述                 |
| :---- | :----- | :------------------- |
| `data`  | Array  | 返回的好友列表数据。 |
| `count` | Number | 好友数量。           |

其他字段说明详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考 [状态码](#code) 了解可能的原因。

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

## 添加黑名单

将指定用户添加到黑名单。添加后，黑名单中的用户无法给该用户发消息。每个用户的黑名单人数上限为 500。

对于每个 App Key，此方法的调用频率限制为每秒 50 次。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/users/{owner_username}/blocks/users
```

#### 路径参数

| 参数             | 类型   | 是否必需 | 描述                                                         |
| :--------------- | :----- | :------- | :----------------------------------------------------------- |
| `owner_username` | String | 是    | 你的用户 ID。                                                 |

本方法的其他路径参数说明详见 [公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必填 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`                                   | 是       |
| `Accept`  | String | 内容类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}` | 是       |

#### 请求 body

请求包体为 JSON Object 类型，包含以下字段：

| 字段      | 类型       | 描述                                              | 是否必填 |
| :-------- | :--------- | :------------------------------------------------ | :------- |
| `usernames` | 用户名数组 | 待加入到黑名单中的用户名，如 ["user1", "user2"]。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 Body 中包含以下字段：

| 参数 | 类型  | 描述                           |
| :--- | :---- | :----------------------------- |
| `data` | Array | 添加到黑名单列表的用户名列表。 |

其他字段说明详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考 [状态码](#code)了解可能的原因。

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

## 获取黑名单

获取当前用户的黑名单列表。

对于每个 App Key，此方法的调用频率限制为每秒 50 次。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/users/{owner_username}/blocks/users
```

#### 路径参数

| 参数 | 类型 | 描述 | 是否必填 |
| --- | --- | --- | --- |
| `owner_username` | String | 本地用户的用户名。 | 是 |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 内容类型。填入 `application/json`。                                  | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`| 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 Body 中包含以下字段：

| 参数 | 类型  | 描述                       |
| :--- | :---- | :------------------------- |
| `data` | Array | 黑名单列表中的用户名数组。 |

其他字段说明详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考 [状态码](#state) 了解可能的原因。

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

## 移除黑名单

将指定用户从黑名单中移除。移除后，该用户恢复为好友或未添加为好友的普通用户关系，可以发送和接收消息。

对于每个 App Key，此方法的调用频率限制为每秒 50 次。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/users/{owner_username}/blocks/users/{blocked_username}
```

#### 路径参数

| 参数             | 类型   | 描述                   | 是否必填 |
| :--------------- | :----- | :--------------------- | :------- |
| `owner_username` | String | 本地用户的用户名。| 是 |
| `blocked_username` | String | 待移除黑名单的用户名。 | 是       |

其他路径参数说明详见 [公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必填 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 内容类型。填入 `application/json`。                                  | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}` | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 Body 中的字段说明详见[公共参数](#pubparam)。

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

有关详细信息，请参阅[HTTP 状态代码](https://docs.agora.io/en/agora-chat/agora_chat_status_code?platform=RESTful)。