本页展示了如何通过调用即时通讯 IM RESTful API 来管理子区成员。在调用以下方法之前，请了解即时通讯 IM 的 [使用限制](./agora_chat_limitation?platform=RESTful#call-limit-of-server-side)。

<a name="pubparam"></a>

## 公共参数

### 请求参数

| 参数       | 类型   | 描述                                                                                                                                                                                                                | 是否必填 |
| :--------- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。      | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。           | 是       |

### 响应参数

| 参数              | 类型   | 描述                                                                |
| :---------------- | :----- | :------------------------------------------------------------------ |
| `action`          | String | HTTP 请求方法。                                                     |
| `organization`    | String | 即时通讯 IM 服务分配给每个公司（组织）的唯一标识符。这与`org_name`. |
| `applicationName` | String | Agora 聊天服务分配给每个应用的唯一标识符。这与`app_name`.           |
| `data`            | String | 响应的详细信息。                                                    |
| `duration`        | String | 从发送 HTTP 请求到收到响应的持续时间（毫秒）。                      |
| `timestamp`       | String | HTTP 响应的 Unix 时间戳 (ms)。                                      |
| `uri`             | String | 请求 URI，它是请求 URL 的一部分。无需关注。                         |
| `entities`        | String | 请求实体。                                                          |
| `properties`      | String | 请求属性。                                                          |

## 认证方式 <a name="auth"></a>

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

## 获取子区成员

获取指定子区中的所有成员。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/thread/{thread_id}/users?limit={N}&cursor={cursor}
```

#### 路径参数

| 参数        | 类型   | 描述                                                     | 是否必填 |
| :---------- | :----- | :------------------------------------------------------- | :------- |
| `thread_id` | String | 子区的 ID。                                              | 是       |

其他参数及说明详见[公共参数](#pubparam)。

#### 查询参数

| `limit`     | String | 每页获取的最大子区数。范围是 [1, 50]。默认值为 50。      | 否       |
| `cursor`    | String | 开始获取子区的页面。在第一次查询时传入 `null` 或空字符串。 | 否       |

#### 请求 header

有关请求 header 参数的描述，请参阅 [认证方式](#auth)。

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应 body 中的 data 字段包含以下参数：

| 参数           | 类型 | 描述                 |
| :------------- | :--- | :------------------- |
| `affiliations` | 列表 | 子区中成员的用户 ID。 |
| `properties.cursor` | String | 查询游标，指定下次查询的起始位置。 |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```json
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

## 将多个用户添加到子区

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

其他字段说明详见[公共参数](#pubparam)。

#### 请求 header

有关请求 header 参数的描述，请参阅 [认证方式](#auth)。

#### 请求 body

| 参数        | 类型 | 描述                 | 是否必填 |
| :---------- | :--- | :------------------- | :------- |
| `usernames` | List | 批量加入子区的用户 ID 列表。每次最多支持 10 个用户加入子区。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应包体中包含以下字段：

| 字段   |  类型     | 描述      |
|:------|:--------|:--------|
| `data.status` | String | 添加结果，`ok` 表示成功添加。否则，您可以根据返回的原因进行故障排除。 |

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

其他字段说明详见[公共参数](#pubparam)。

### 示例

#### 请求示例

```json
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

## 删除多个子区成员

从指定子区中删除多个用户。每次调用时，最多可以从一个子区中删除 10 个用户。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/threads/{thread_id}/users
```

#### 路径参数

| 参数        | 类型   | 描述        | 是否必填 |
| :---------- | :----- | :---------- | :------- |
| `thread_id` | String | 子区的 ID。 | 是       |

其他字段说明详见[公共参数](#pubparam)。

#### 请求 header

有关请求 header 参数的描述，请参阅 [认证方式](#auth)。

#### 请求 body

| 参数        | 类型 | 描述                 | 是否必填 |
| :---------- | :--- | :------------------- | :------- |
| `usernames` | List | 批量移除子区的用户 ID 列表。每次最多可踢出 10 个子区成员。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应 body 中的 data 字段包含以下参数：

| 参数     | 类型 | 描述                                                                 |
| :------- | :--- | :------------------------------------------------------------------- |
| `result` | Boolean | 指定的子区成员是否从子区中移除：<ul><li>`true`： 是</li><li>`false`：否</li></ul> |
| `user`   | String | 被移出子区的用户 ID。                                                |

其他字段说明详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
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

<a name="code"></code>

## 状态码

有关详细信息，请参阅 [HTTP 状态代码](./agora_chat_status_code?platform=RESTful)。