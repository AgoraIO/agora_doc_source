# 用户体系集成

本文展示如何调用 Agora 即时通讯 RESTful API 实现用户体系建立和管理。包括用户注册、获取、修改、删除、封禁、解禁、强制下线等。
调用以下方法前，请先参考 [限制条件](./agora_chat_limitation?platform=RESTful#服务端调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

## <a name="param"></a>公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数：

### 请求参数

| 参数       | 类型   | 描述                                                                                                                                                                                                                                                        | 是否必填 |
| :--------- | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful)。                                                                                                              | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful)。                                                                                                         | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful)。                                                                                                                | 是       |
| `username` | String | 用户名。用户的唯一登录账号。长度在 64 个字符内，不可设置为空。支持以下字符集：<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 0-9<li>"\_", "-", "."<div class="alert note"><ul><li>不区分大小写。<li>同一个 app 下，用户名唯一。</ul></div> | 是       |

### 响应参数

| 参数                 | 类型   | 描述                                                                                                                                            |
| :------------------- | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------- |
| `action`             | String | 请求方式。                                                                                                                                      |
| `organization`       | String | 即时通讯服务分配给每个企业（组织）的唯一标识。等同于 `org_name`。                                                                               |
| `application`        | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。                                                                                           |
| `applicationName`    | String | 即时通讯服务分配给每个 app 的唯一标识。等同于 `app_name`。                                                                                      |
| `uri`                | String | 请求 URL。                                                                                                                                      |
| `path`               | String | 请求路径，属于请求 URL 的一部分，无需关注。                                                                                                     |
| `entities`           | JSON   | 返回实体信息。                                                                                                                                  |
| `entities.uuid`      | String | 用户的 UUID。即时通讯服务为该请求中的 app 或用户生成的唯一内部标识，用于生成 user token。                                                       |
| `entities.type`      | String | 对象类型，无需关注。                                                                                                                            |
| `entities.created`   | Long   | 注册用户的 Unix 时间戳（毫秒）。                                                                                                                |
| `entities.modified`  | Long   | 最近一次修改用户信息的 Unix 时间戳（毫秒）。                                                                                                    |
| `entities.username`  | String | 用户名。用户登录的唯一账号。                                                                                                                    |
| `entities.activated` | Bool   | 用户是否为活跃状态：<li>`true`：用户为活跃状态。<li>`false`：用户为封禁状态。如要使用已被封禁的用户账户，你需要调用[解禁用户](#unban)解除封禁。 |
| `data`               | JSON   | 实际获取的数据详情。                                                                                                                            |
| `timestamp`          | Long   | HTTP 响应的 Unix 时间戳（毫秒）。                                                                                                               |
| `duration`           | Number | 从发送 HTTP 请求到响应的时长（毫秒）。                                                                                                          |

## 认证方式

~e838c3b0-8e43-11ec-814c-17df6c7c3801~

## 注册单个用户

注册一个用户。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/users
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

#### 请求 body

请求包体为 JSON Object 类型，包含以下字段：

| 字段       | 类型   | 描述                                                                                                                                                  | 是否必填 |
| :--------- | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `username` | String | 用户名。用户的唯一登录账号。长度在 64 个字符内，不可设置为空。                                                                                        | 是       |
| `password` | String | 用户的登录密码。长度必须在 64 个字符以内。                                                                                                            | 是       |
| `nickname` | String | 推送消息时，在消息推送通知栏内显示的用户昵称。长度必须在 100 个字符以内。默认为空。<br>该字段用于设置消息推送显示的用户昵称，而非用户属性的用户昵称。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段                | 类型   | 描述                                                                                                       |
| :------------------ | :----- | :--------------------------------------------------------------------------------------------------------- |
| `entities.nickname` | String | 推送消息时，在消息推送通知栏内显示的用户昵称。<br>该字段为消息推送显示的用户昵称，而非用户属性的用户昵称。 |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST -H 'Content-Type: application/json' -H 'Authorization:Bearer <YourAppToken>' -i "https://XXXX/XXXX/XXXX/users" -d '
    {
      "username": "user1",
      "password": "123",
      "nickname": "testuser"
    }'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "path": "/users",
    "uri": "https://a1.agora.com/XXXX/XXXX/users",
    "entities": [
        {
            "uuid": "0ffe2d80-XXXX-XXXX-8d66-279e3e1c214b",
            "type": "user",
            "created": 1542795196504,
            "modified": 1542795196504,
            "username": "user1",
            "activated": true,
            "nickname": "testuser"
        }
    ],
    "timestamp": 1542795196515,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 批量注册用户

一个请求内注册多个用户。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
POST https://api.agora.io/{org_name}/{app_name}/users
```

#### 路径参数

参数及说明详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

#### 请求 body

请求包体为 JSON Object 类型，包含以下字段：

| 字段       | 类型   | 描述                                                                                                                                                  | 是否必填 |
| :--------- | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `username` | String | 用户名。用户的唯一登录账号。长度在 64 个字符内，不可设置为空。                                                                                        | 是       |
| `password` | String | 用户的登录密码。长度必须在 64 个字符以内。                                                                                                            | 是       |
| `nickname` | String | 推送消息时，在消息推送通知栏内显示的用户昵称。长度必须在 100 个字符以内。默认为空。<br>该字段用于设置消息推送显示的用户昵称，而非用户属性的用户昵称。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段                | 类型       | 描述                                                                                         |
| :------------------ | :--------- | :------------------------------------------------------------------------------------------- |
| `entities.nickname` | String     | 用户昵称。推送消息时显示的昵称。<br>该字段为消息推送显示的用户昵称，而非用户属性的用户昵称。 |
| `data`              | JSON Array | 返回数据详情。在该接口中，注册失败的用户名和失败原因会显示在 `data` 数组中。                 |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例一

注册 2 个用户：

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST -H 'Content-Type: application/json' -H 'Authorization:Bearer <YourAppToken>' -i "https://XXXX/XXXX/XXXX/users" -d '
    {
        "username":"user1",
        "password":"123",
        "nickname":"testuser1"
    },
    {
        "username":"user2",
        "password":"456",
        "nickname":"testuser2"
    }'
```

#### 响应示例一

```json
{
    "action": "post",
    "application": "22bcffa0-XXXX-XXXX-9df8-516f6df68c6d",
    "path": "/users",
    "uri": "https://XXXX/XXXX/XXXX/users",
    "entities": [
        {
            "uuid": "278b5e60-XXXX-XXXX-8f9b-d5d83ebec806",
            "type": "user",
            "created": 1541587920710,
            "modified": 1541587920710,
            "username": "user1",
            "activated": true,
            "nickname": "testuser1"
        },
        {
            "uuid": "278bac80-XXXX-XXXX-b192-73e4cd5078a5",
            "type": "user",
            "created": 1541587920712,
            "modified": 1541587920712,
            "username": "user2",
            "activated": true,
            "nickname": "testuser2"
        }
    ],
    "timestamp": 1541587920714,
    "data": [],
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

#### 请求示例二

当请求 body 中存在已经注册过的用户 user 3 时，user 3 注册失败并在响应 body 中的 `data` 数组内返回，用户 user 1、user 2 仍然注册成功。

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST -H 'Content-Type: application/json' -H 'Authorization:Bearer <YourAppToken>' -i "https://XXXX/XXXX/XXXX/users" -d '
    {
        "username":"user1",
        "password":"123",
        "nickname":"testuser1"
    },
    {
        "username":"user2",
        "password":"456",
        "nickname":"testuser2"
    },
    {
        "username":"user3",
        "password":"789",
        "nickname":"testuser3"
    }'
```

#### 响应示例二

```json
{
    "action": "post",
    "application": "22bcffa0-XXXX-XXXX-9df8-516f6df68c6d",
    "path": "/users",
    "uri": "https://XXXX/XXXX/XXXX/users",
    "entities": [
        {
            "uuid": "278b5e60-XXXX-XXXX-8f9b-d5d83ebec806",
            "type": "user",
            "created": 1541587920710,
            "modified": 1541587920710,
            "username": "user1",
            "activated": true,
            "nickname": "testuser1"
        },
        {
            "uuid": "278bac80-XXXX-XXXX-b192-73e4cd5078a5",
            "type": "user",
            "created": 1541587920712,
            "modified": 1541587920712,
            "username": "user2",
            "activated": true,
            "nickname": "testuser2"
        }
    ],
    "timestamp": 1541587920714,
    "data": [
        {
            "username": "user3",
            "registerUserFailReason": "the user3 already exists"
        }
    ],
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 查询单个用户的详情

查询单个用户的详细信息。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
GET https://api.agora.io/{org_name}/{app_name}/users/{username}
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段                                          | 类型   | 描述                                                                                                                                             |
| :-------------------------------------------- | :----- | :----------------------------------------------------------------------------------------------------------------------------------------------- |
| `entities.nickname`                           | String | 推送消息时，在消息推送通知栏内显示的用户昵称。<br>该字段为消息推送显示的用户昵称，而非用户属性的用户昵称。                                       |
| `entities.notification_display_style`         | Int    | 消息推送方式：<br/> - “0”：仅通知；<br/> - “1”：通知以及消息详情，没有设置返不会返回。                                                           |
| `entities.notification_no_disturbing`         | Bool   | 是否开启免打扰。<br/> - `true`：免打扰开启。若用户未设该参数，则响应中不返回。<br/> - `false`：免打扰关闭。                                      |
| `entities.notification_no_disturbing_start`   | String | 免打扰的开始时间。例如，“8” 代表每日 8:00 开启免打扰。若用户未设该参数，则响应中不返回。                                                         |
| `entities.notification_no_disturbing_end`     | String | 免打扰的结束时间。例如，“18” 代表每日 18:00 关闭免打扰。若用户未设该参数，则响应中不返回。                                                       |
| `entities.notification_ignore_63112447328257` | Bool   | 是否屏蔽了群组消息的离线推送的设置。参数中的数字表示群组 ID。 <br/> -`true`：已屏蔽。<br/> - `false`：未屏蔽。若用户未设该参数，则响应中不返回。 |
| `entities.notifier_name`                      | String | 客户端推送证书名称。若用户未设置推送证书名称，则响应中不返回。                                                                                   |
| `entities.device_token`                       | String | 推送 token。若用户没有推送 token，则响应中不返回。                                                                                               |
| `count`                                       | Number | 返回用户数量。                                                                                                                                   |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users/XXXX'
```

#### 响应示例

```json
{
    "path": "/users",
    "uri": "http://XXXX/XXXX/XXXX/users/XXXX",
    "entities": [
        {
            "notification_no_disturbing": true,
            "created": 1644826508795,
            "notification_no_disturbing_start": 20,
            "notification_no_disturbing_end": 7,
            "type": "user",
            "uuid": "393d9960-XXXX-XXXX-809a-c5eb15f20aa8",
            "nickname": "test",
            "notification_display_style": 1,
            "modified": 1661242753511,
            "notification_ignored_users": [
                "hx_test1"
            ],
            "pushInfo": [
                {
                    "device_Id": "0f581e52-XXXX-XXXX-8774-f804a49571f5",
                    "device_token": "160XXXX892",
                    "notifier_name": "XXXX#1cXXXX807d"
                }
            ],
            "username": "XXXX",
            "activated": true
        }
    ],
    "count": 1,
    "action": "get",
    "duration": 4
}
```

## 批量查询用户详情

按照注册时间升序，查询多个用户的信息列表。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
GET https://api.agora.io/{org_name}/{app_name}/users
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

##### 请求 body

| 参数     | 类型   | 描述                                                                                                                                                                                                                                                      | 是否必填 |
| :------- | :----- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `limit`  | Number | 请求查询用户的数量。默认值 `10`，取值范围 [1,100]。<br>用户列表默认按照注册用户时间的升序显示。                                                                                                                                                           | 否       |
| `cursor` | String | 游标，用于分页显示用户列表。<br>第一次发起批量查询用户请求时无需设置 `cursor`，请求成功后会获得第一页用户列表。从响应 body 中获取 `cursor`，并在下一次请求的 URL 中传入该 `cursor`，直到响应 body 中不再有 `cursor` 字段，则表示已查询到 app 中所有用户。 | 否       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 参数                                          | 类型   | 描述                                                                                                                                                                                                                                  |
| :-------------------------------------------- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `entities.nickname`                           | String | 推送消息时，在消息推送通知栏内显示的用户昵称。该字段为消息推送显示的用户昵称，而非用户属性的用户昵称。                                                                                                                                |
| `cursor`                                      | String | 游标，用于分页显示用户列表。<br>第一次发起批量查询用户请求时无需设置 `cursor`，请求成功后，从响应 body 中获取 `cursor`，并在下一次请求的 URL 中传入该 `cursor`，直到响应 body 中不再有 `cursor` 字段，则表示已查询到 app 中所有用户。 |
| `entities.notification_display_style`         | Int    | 消息推送方式：<br/> - “0”：仅通知；<br/> - “1”：通知以及消息详情。若用户未设置该参数，则响应中不会返回。                                                                                                                              |
| `entities.notification_no_disturbing`         | Bool   | 是否开启免打扰模式。<br/> - `true`：免打扰开启。若用户未设置改参数，则响应中不返回。<br/> - `false`：代表免打扰关闭。                                                                                                                 |
| `entities.notification_no_disturbing_start`   | String | 免打扰的开始时间。例如， “8” 代表每日 8:00 开启免打扰。若用户未设该参数，则响应中不返回。                                                                                                                                             |
| `entities.notification_no_disturbing_end`     | String | 免打扰的结束时间。例如， “18” 代表每日 18:00 关闭免打扰。若用户未设该参数，则响应中不返回。                                                                                                                                           |
| `entities.notification_ignore_63112447328257` | Bool   | 是否屏蔽了群组消息的离线推送的设置。数字表示群组 ID。 <br/> -`true`：已屏蔽。 <br/> - `false`：未屏蔽，没有设置则不会返回。                                                                                                           |
| `entities.notifier_name`                      | String | 客户端推送证书名称。若用户未设置推送证书名称，则响应中不返回。                                                                                                                                                                        |
| `entities.device_token`                       | String | 推送 token。若用户没有推送 token，则响应中不返回。                                                                                                                                                                                    |
| `count`                                       | Number | 返回用户数量。                                                                                                                                                                                                                        |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例一

按照注册时间升序，查询 2 个用户的信息列表：

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users?limit=2'
```

#### <a name="http1"></a>响应示例一

返回注册时间较早的 2 个 用户的信息列表：

```json
{
    "action": "get",
    "params": {
        "limit": ["2"]
    },
    "path": "/users",
    "uri": "http://XXXX/XXXX/XXXX/users",
    "entities": [
        {
            "uuid": "ab90eff0-XXXX-XXXX-9174-8f161649a182",
            "type": "user",
            "created": 1542356511855,
            "modified": 1542356511855,
            "username": "XXXX",
            "activated": true,
            "nickname": "testuser1"
        },
        {
            "uuid": "b2aade90-XXXX-XXXX-a974-f3368f82e4f1",
            "type": "user",
            "created": 1542356523769,
            "modified": 1542356523769,
            "username": "user2",
            "activated": true,
            "nickname": "testuser2"
        }
    ],
    "timestamp": 1542558467056,
    "duration": 11,
    "cursor": "LTgzNDAxMjM3OToxTEFnNE9sNEVlaVQ0UEdhdmJNR2tB",
    "count": 2
}
```

#### 请求示例二

使用 [响应示例一](#http1) 中的 `cursor`，继续按照注册时间升序查询下一页用户列表，该页面用户数量为 2：

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users?limit=2&cursor=LTgzNDAxMjM3OToxTEFnNE9sNEVlaVQ0UEdhdmJNR2tB'
```

#### 响应示例二

继续返回 2 个 用户的信息列表：

```json
{
    "action": "get",
    "params": {
        "cursor": ["LTgzNDAxMjM3OToxTEFnNE9sNEVlaVQ0UEdhdmJNR2tB"],
        "limit": ["2"]
    },
    "path": "/users",
    "uri": "http://XXXX/XXXX/XXXX/users",
    "entities": [
        {
            "uuid": "fef7f250-XXXX-XXXX-ba39-0fed7dcc3cdd",
            "type": "user",
            "created": 1542361376245,
            "modified": 1542361376245,
            "username": "XXXX",
            "activated": true,
            "nickname": "testuser3"
        },
        {
            "uuid": "gufhj730-XXXX-XXXX-bc68-d8ij7dc3uyac",
            "type": "user",
            "created": 1542361376978,
            "modified": 1542361376978,
            "username": "XXXX",
            "activated": true,
            "nickname": "testuser4"
        }
    ],
    "timestamp": 1542559337702,
    "duration": 2,
    "count": 2
}
```

## 删除单个用户

删除单个用户。如果删除的用户是群组或者聊天室的管理员，该用户管理的群组和聊天室也会相应被删除。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
DELETE https://api.agora.io/{org_name}/{app_name}/users/{username}
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users/user1'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "XXXX",
    "path": "/users",
    "uri": "https://XXXX/XXXX/XXXX/users",
    "entities": [
        {
            "uuid": "ab90eff0-XXXX-XXXX-9174-8f161649a182",
            "type": "user",
            "created": 1542356511855,
            "modified": 1542356511855,
            "username": "XXXX",
            "activated": true,
            "nickname": "user1"
        }
    ],
    "timestamp": 1542559539776,
    "duration": 39,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 批量删除用户

删除 app 下指定多个用户。建议一次删除的用户数量不要超过 100。

如果删除的多个用户中包含群组或者聊天室的管理员，该用户管理的群组和聊天室也会相应被删除。

对于每个 App Key，此方法的调用频率限制为每秒 30 次。

### HTTP 请求

```http
DELETE https://api.agora.io/{org_name}/{app_name}/users
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码汇总表](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "XXXX",
    "path": "/users",
    "uri": "https://XXXX/XXXX/XXXX/users",
    "entities": [
        {
            "uuid": "ab90eff0-XXXX-XXXX-9174-8f161649a182",
            "type": "user",
            "created": 1542356511855,
            "modified": 1542356511855,
            "username": "XXXX",
            "activated": true,
            "nickname": "user1"
        }
    ],
    "timestamp": 1542559539776,
    "duration": 39,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 修改用户密码

修改用户密码，无需提供原密码。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
PUT https://api.agora.io/{org_name}/{app_name}/users/{username}/password
```

#### 路径参数

参数及说明详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | `application/json`     | 是       |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

#### 请求 body

请求包体为 JSON Object 类型，包含以下字段：

| 参数          | 类型   | 描述                                         | 是否必填 |
| :------------ | :----- | :------------------------------------------- | :------- |
| `newpassword` | String | 新的用户登录密码。长度必须在 64 个字符以内。 | 是       |

其他字段及说明详见[公共参数](#param)。

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token，<YourPassword> 替换为你设置的新密码
curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{ "newpassword": "<YourPassword>" }' 'http://XXXX/XXXX/XXXX/users/user1/password'
```

#### 响应示例

```json
{
    "action": "set user password",
    "timestamp": 1542595598924,
    "duration": 8
}
```

## 封禁用户

禁用一个用户账户。该用户会立即下线，且无法登录直到解除封禁。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
POST https://api.agora.io/{org_name}/{app_name}/users/{username}/deactivate
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | `application/json`     | 是       |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段                | 类型   | 描述                                                                                                       |
| :------------------ | :----- | :--------------------------------------------------------------------------------------------------------- |
| `entities.nickname` | String | 推送消息时，在消息推送通知栏内显示的用户昵称。<br>该字段为消息推送显示的用户昵称，而非用户属性的用户昵称。 |

其他字段及说明详见[公共参数](#param)。
如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users/user1/deactivate'
```

#### 响应示例

```json
{
    "action": "Deactivate user",
    "entities": [
        {
            "uuid": "4759aa70-XXXX-XXXX-925f-6fa0510823ba",
            "type": "user",
            "created": 1542595573399,
            "modified": 1542597578147,
            "username": "XXXX",
            "activated": false,
            "nickname": "user"
        }
    ],
    "timestamp": 1542602157258,
    "duration": 12
}
```

<a name="unban"></a>

## 解禁用户

解禁一个已被禁用的用户账户。解禁后，该用户恢复登录功能。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
POST https://api.agora.io/{org_name}/{app_name}/users/{username}/activate
```

#### 路径参数

参数及说明详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | `application/json`     | 是       |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型   | 描述                                                                                                       |
| :--------- | :----- | :--------------------------------------------------------------------------------------------------------- |
| `nickname` | String | 推送消息时，在消息推送通知栏内显示的用户昵称。<br>该字段为消息推送显示的用户昵称，而非用户属性的用户昵称。 |

其他字段及说明详见[公共参数](#param)。
如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users/user1/activate'
```

#### 响应示例

```json
{
    "action": "activate user",
    "timestamp": 1542602404132,
    "duration": 9
}
```

## 强制用户离线

强制下线一个用户，被下线的用户需要重新登录才能正常使用。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
POST https://api.agora.io/{org_name}/{app_name}/users/{username}/disconnect
```

#### 路径参数

参数及说明详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | `application/json`     | 是       |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段          | 类型 | 描述                                              |
| :------------ | :--- | :------------------------------------------------ |
| `data`        | JSON | 返回数据详情。                                    |
| `data.result` | Bool | 下线结果，仅显示为 `true`，表示用户已被强制下线。 |

其他字段及说明详见 [公共参数](#param)。
如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users/XXXX/disconnect'
```

#### 响应示例

```json
{
    "uri": "http://XXXX/XXXX/XXXX/users/XXXX/disconnect",
    "timestamp": 1642053735842,
    "organization": "1122161011178276",
    "application": "22bcffa0-XXXX-XXXX-9df8-516f6df68c6d",
    "entities": [],
    "action": "get",
    "data": {
        "result": true
    },
    "duration": 0,
    "applicationName": "XXXX"
}
```

## 获取单个用户在线状态（status）

该方法获取单个用户的在线状态。你可以调用该方法查询指定用户是否在线。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/users/{username}/status
```

#### 路径参数

参数及说明详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                                | 是否必填 |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Accept`        | String | 内容类型。请填 `application/json`。 | 是       |
| `Authorization` | String | Bearer ${YourAppToken}              | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码是 `200`，则表示请求成功。响应包体中包含如下字段：

| 参数       | 类型   | 说明                                                                                                                                               |
| :--------- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------- |
| `username` | String | 数据格式为 "用户 ID": "当前在线状态"。例如用户 user1 的在线状态：如果该用户在线，则返回 "user1": "online"；如果不在线，则返回 "user1": "offline"。 |

其他字段说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码不是 `200`，则表示请求失败。你可以参考 [状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users/user1/status'
```

#### 响应示例

```json
{
  "action": "get",
  "uri": "http://XXXX/XXXX/XXXX/users/user1/status",
  "entities": [],
  "data": {
    "user1": "offline"
  },
  "timestamp": 1542601284531,
  "duration": 4,
  "count": 0
}
```

## 批量获取用户在线状态（status）

该方法批量查看用户的在线状态。你可以调用该方法查询多个用户是否在线。一次调用最多可以同时获取 100 个用户的在线状态。

该接口不对用户 ID 进行校验。若查询不存在的用户 ID 的状态，则返回的状态为 `offline`。

对于每个 App Key，此方法的调用频率限制为每秒 50 次。

### HTTP 请求

```http
POST https://{host}{org_name}/{app_name}/users/batch/status
```

#### 路径参数

参数及说明详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                                | 是否必填 |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。 | 是       |
| `Authorization` | String | Bearer ${YourAppToken}              | 是       |

#### 请求 body

| 参数        | 说明                                                                           |
| :---------- | :----------------------------------------------------------------------------- |
| `usernames` | 批量查询在线状态的用户 ID，数据格式为数组。注意传入的用户 ID 不能超过 100 个。 |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码是 `200`，则表示请求成功。响应包体中包含如下字段：

| 参数       | 说明                                                                                                             |
| :--------- | :--------------------------------------------------------------------------------------------------------------- |
| `username` | 数据格式为：“用户 ID：当前在线状态”，例如，user1 的在线和离线状态分别为 "user1": "online" 和"user1": "offline"。 |

其他字段说明详见[公共参数](#param)。

如果返回的 HTTP 状态码不是 `200`，则表示请求失败。你可以参考[状态码汇总表](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST http://XXXX/XXXX/XXXX/users/batch/status -H 'Authorization: Bearer <YourAppToken>' -H 'Content-Type: application/json' -d '{"usernames":["user1","user2"]}'
```

#### 响应示例

该接口不对用户 ID 进行校验。若查询不存在的用户 ID 的状态，则返回的状态为 offline。

```json
{
  "action": "get batch user status",
  "data": [
    {
      "user1": "offline"
      },
    {
      "user2": "offline"
      }
    ],
  "timestamp": 1552280231926,
  "duration": 4
}
```

## 获取用户离线消息数量

获取即时通讯用户的离线消息数量。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/users/{owner_username}/offline_msg_count
```

#### 路径参数

|       参数       | 类型   | 描述                        | 是否必填 |
| :--------------: | :----- | :-------------------------- | -------- |
| `owner_username` | String | 要获取离线消息数的用户 ID。 | 是       |

其他参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                                | 是否必填 |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Accept`        | String | 内容类型。请填 `application/json`。 | 是       |
| `Authorization` | String | Bearer ${YourAppToken}              | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码是 `200`，则表示请求成功。响应包体中包含如下字段：

| 参数       | 说明                                                          |
| :--------- | :------------------------------------------------------------ |
| `username` | 数据格式为：“用户 ID：当前离线消息的数量“，例如，"user1: 0”。 |

其他字段说明详见[公共参数](#param)。

如果返回的 HTTP 状态码不是 `200`，则表示请求失败。你可以参考 [状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。
### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users/user1/offline_msg_count'
```

#### 响应示例

```json
{
  "action": "get",
  "uri": "http://XXXX/XXX/XXXX/users/XXX/offline_msg_count",
  "entities": [],
  "data": {
    "user1": 0
  },
  "timestamp": 1542601518137,
  "duration": 3,
  "count": 0
}
```

## 查询离线消息的投递状态

该方法获取指定离线消息的投递状态。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/users/{username}/offline_msg_status/{msg_id}
```

#### 路径参数

|    参数    | 类型   | 描述                          | 是否必填 |
| :--------: | :----- | :---------------------------- | -------- |
| `username` | String | 要获取离线消息状态的用户 ID。 | 是       |
|  `msg_id`  | String | 要查看离线消息状态的 ID。     | 是       |

其他参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                                | 是否必填 |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Accept`        | String | 内容类型。请填 `application/json`。 | 是       |
| `Authorization` | String | Bearer ${YourAppToken}              | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码是 `200`，则表示请求成功。响应包体中包含如下字段：

| 参数     | 说明                                                                                                               |
| :------- | :----------------------------------------------------------------------------------------------------------------- |
| `msg_id` | 数据格式为“消息 ID”：“离线消息的投递状态”。有两种：<li> “delivered”  表示已投递； <li> `undelivered“  表示未投递。 |

其他字段说明详见[公共参数](#param)。

如果返回的 HTTP 状态码不是 `200`，则表示请求失败。你可以参考[状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users/user1/offline_msg_status/123'
```

#### 响应示例

```json
{
  "action": "get",
  "uri": "http://XXXX/XXXX/XXXX/users/user1/offline_msg_status/123",
  "entities": [],
  "data": {
    "123": "delivered"
  },
  "timestamp": 1542601830084,
  "duration": 5,
  "count": 0
}
```

## 状态码

有关详细信息，请参阅 [HTTP 状态代码](https://docs.agora.io/en/agora-chat/agora_chat_status_code?platform=RESTful)。