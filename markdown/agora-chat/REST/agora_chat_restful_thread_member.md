本页展示了如何通过调用即时通讯 IM RESTful API 实现子区成员管理，包括获取子区成员列表以及批量加入和踢出子区成员。

调用本文中的 API 前，请先参考[使用限制](./agora_chat_limitation?platform=RESTful#服务端接口调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

<a name="pubparam"></a>

## 公共参数

### 请求参数

| 参数       | 类型   | 描述              | 是否必填 |
| :--------- | :----- | :---------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。      | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。           | 是       |

### 响应参数

| 参数              | 类型   | 描述                                                                |
| :---------------- | :----- | :------------------------------------------------------------------ |
| `action`          | String | HTTP 请求方法。                                                     |
| `organization`    | String | 即时通讯服务为每个企业（组织）分配的唯一标识，与请求参数 `org_name` 相同。 |
| `applicationName` | String | 即时通讯服务为每个 app 分配的唯一标识，与请求参数 `app_name` 相同。           |
| `duration`        | Number | 从发送 HTTP 请求到收到响应的持续时间，单位为毫秒。                      |
| `timestamp`       | Number | HTTP 响应的 Unix 时间戳，单位为毫秒。                               |
| `uri`             | String | 请求 URI，即请求 URL 的一部分。无需关注。                        |
| `properties`      | JSON | 响应属性。                                                          |

## 认证方式

即时通讯服务 RESTful API 要求 HTTP 身份验证。每次发送 HTTP 请求时，必须在请求 header 中填入如下 `Authorization` 字段：

```http
Authorization: Bearer YourAppToken
```

为了提高项目的安全性，声网使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯服务 RESTful API 仅支持使用 app 权限 token 对用户进行身份验证。详见[使用 App 权限 token 进行身份验证](./agora_chat_token?platform=RESTful)。

## 获取子区成员列表

获取指定子区中的所有成员。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/thread/{thread_id}/users?limit={N}&cursor={cursor}
```

#### 路径参数

| 参数        | 类型   | 描述                 | 是否必填 |
| :---------- | :----- | :--------------------- | :------- |
| `thread_id` | String | 子区的 ID。          | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 查询参数

| 参数        | 类型   | 描述                 | 是否必填 |
| :---------- | :----- | :--------------------- | :------- |
| `limit`     | Number | 每次期望返回的子区成员数量，取值范围为 [1,50]。      | 否       |
| `cursor`    | String | 数据查询的起始位置。 | 否       |

#### 请求 header

| 参数    | 类型   | 是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Authorization` | String | 是    | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。|

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应包体中包含以下字段：

| 参数           | 类型 | 描述                 |
| :------------- | :--- | :------------------- |
| `data` | JSON | 获取的子区中的成员信息。 |
| `data.affiliations` | Array | 子区中成员的用户 ID。 |
| `properties.cursor` | String | 查询游标，指定下次查询的起始位置。 |

其他参数及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X GET http://XXXX.com/XXXX/testapp/thread/177916702949377/users -H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "action": "get",
    "data": {
        "affiliations": [
            "test4"
        ]
    },
    "duration": 4,
    "properties": {
        "cursor": "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aW06dGhyZWFkOmVhc2Vtb2ItZGVtbyN0ZXN0eToyMA"
    },
    "timestamp": 1650872048366,
    "uri": "http://XXXX.com/XXXX/testy/thread/179786360094768/users"
}
```

## 用户批量加入子区

将多个用户添加到指定子区。每次调用最多可以将 10 个用户添加到一个子区。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/thread/{thread_id}/users
```

#### 路径参数

| 参数        | 类型   | 描述        | 是否必填 |
| :---------- | :----- | :---------- | :------- |
| `thread_id` | String | 子区的 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数    | 类型   | 是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Authorization` | String | 是    | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。|

#### 请求 body

| 参数        | 类型 | 描述                 | 是否必填 |
| :---------- | :--- | :------------------- | :------- |
| `usernames` | List | 批量加入子区的用户 ID 列表。每次最多可传 10 个用户 ID。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应包体中包含以下字段：

| 字段   |  类型     | 描述      |
|:------|:--------|:--------|
| `data` | JSON | 群成员加入子区的结果。 |
| `data.status` | String | 群成员是否成功加入子区。`ok` 表示成功添加。否则，你可以根据返回的原因进行故障排除。 |

其他参数及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST http://XXXX.com/XXXX/testapp/thread/177916702949377/users -d '{
"usernames": [
"test2",
"test3"
]
}' -H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "action": "post",
    "applicationName": "testapp",
    "data": {
        "status": "ok"
    },
    "duration": 1069,
    "organization": "XXXX",
    "timestamp": 1650872649160,
    "uri": "http://XXXX.com/XXXX/testy/thread/179786360094768/joined_thread"
}
```

## 批量删除子区成员

从指定子区中删除多个用户。每次最多可从一个子区中删除 10 个用户。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/threads/{thread_id}/users
```

#### 路径参数

| 参数        | 类型   | 描述        | 是否必填 |
| :---------- | :----- | :---------- | :------- |
| `thread_id` | String | 子区的 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数    | 类型   | 描述      | 是否必填 |
| :-------------- | :----- | :---------------- | :------- |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。| 是    |

#### 请求 body

| 参数        | 类型 | 描述                 | 是否必填 |
| :---------- | :--- | :------------------- | :------- |
| `usernames` | List | 批量移除的子区成员的用户 ID 列表。每次最多可踢出 10 个子区成员。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应包体中包含以下字段：

| 参数     | 类型 | 描述              |
| :------- | :--- | :------------------- |
| `entities` | JSON Array | 子区成员移出结果。|
| `entities.result` | Boolean | 指定的子区成员是否被成功移除：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `entities.user`   | String | 被移出子区的成员的用户 ID。     |

其他参数及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X DELETE http://XXXX.com/XXXX/testapp/thread/177916702949377/users -H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "action": "delete",
    "applicationName": "testy",
    "duration": 12412,
    "entities": [
        {
            "result": false,
            "user": "test2"
        },
        {
            "result": false,
            "user": "test6"
        }
    ],
    "organization": "XXXX",
    "timestamp": 1650874050419,
    "uri": "http://XXXX.com/XXXX/testy/thread/179786360094768/users"
}
```

## 状态码

详见 [HTTP 状态代码](./agora_chat_status_code?platform=RESTful)。