本页面展示了如何通过调用即时通讯 IM RESTful API 来创建、修改、删除和获取子区。

在调用以下方法之前，请了解即时通讯 IM 的 [使用限制](..cn/agora-chat/agora_chat_limitation?platform=RESTful#call-limit-of-server-side)。

<a name="pubparam"></a>

## 公共参数

下表列出了即时通讯 IM RESTful API 的常用请求和响应参数。

### 请求参数

| 参数       | 类型   | 描述                                                                                                                                                                                                               | 是否必填 |
| :--------- | :----- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯 IM 服务分配的用于访问 RESTful API 的域名。获取域名的方法请参见[获取项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。      | 是       |
| `org_name` | String | 即时通讯 IM 服务分配给每个公司（组织）的唯一标识符。如何获取组织名称，请参见[获取项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `app_name` | String | Agora 聊天服务分配给每个应用的唯一标识符。获取应用名称的方法请参见[获取项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。           | 是       |

### 响应参数

| 参数              | 类型   | 描述                                                                |
| :---------------- | :----- | :------------------------------------------------------------------ |
| `action`          | String | HTTP 请求方法。                                                     |
| `organization`    | String | 即时通讯 IM 服务分配给每个公司（组织）的唯一标识符。这与`org_name`. |
| `applicationName` | String | Agora 聊天服务分配给每个应用的唯一标识符。这与`app_name`.           |
| `data`            | String | 响应的详细信息。                                                    |
| `duration`        | String | 从发送 HTTP 请求到收到响应的持续时间（毫秒）。                      |
| `timestamp`       | String | HTTP 响应的 Unix 时间戳 (ms)。                                      |
| `uri`             | String | 请求 URI，它是请求 URL 的一部分。无需关注。           |
| `entities`        | String | 请求实体。                                                          |
| `properties`      | String | 请求属性。                                                          |

## 认证方式 <a name="auth"></a>

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

## 创建子区

创建一个子区。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/thread
```

#### 路径参数

路径参数的说明详见 [公共参数](#pubparam)。

#### 请求 header

有关请求 header 参数的描述，请参阅 [认证方式](#auth)。

#### 请求 body

| 参数       | 类型   | 描述                                         | 是否必填 |
| :--------- | :----- | :------------------------------------------- | :------- |
| `group_id` | String | 子区所属组的 ID。                            | 是       |
| `name`     | String | 子区的名称。子区名称的最大长度为 64 个字符。 | 是       |
| `msg_id`   | String | 创建子区所基于的消息的 ID。                  | 是       |
| `owner`    | String | 子区创建者的用户 ID。                         | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应 body 中的 data 字段包含以下参数：

| 参数        | 类型   | 描述        |
| :---------- | :----- | :---------- |
| `thread_id` | String | 子区的 ID。 |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X POST http://XXXX.com/XXXX/testapp/thread -H 'Authorization: Bearer <YourAppToken>' -d '{
    "group_id": 179800091197441,
    "name": "1",
    "owner": "test4",
    "msg_id": 1234
}'
```

#### 响应示例

```json
{
    "action": "post",
    "applicationName": "testapp",
    "duration": 4,
    "data": {
        "thread_id": "177916702949377"
    }
    "organization": "XXXX",
    "timestamp": 1650869972109,
    "uri": "http://XXXX.com/XXXX/testy/thread"
}
```

## 修改子区

修改指定子区的名称。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
PUT https://{host}/{org_name}/{app_name}/thread/{thread_id}
```

#### 路径参数

| 参数        | 类型   | 描述        | 是否必填 |
| :---------- | :----- | :---------- | :------- |
| `thread_id` | String | 子区的 ID。 | 是       |

其他字段说明详见[公共参数](#pubparam)。

#### 请求 header

有关请求 header 参数的描述，请参阅 [认证方式](#auth)。

#### 请求 body

| 参数   | 类型   | 描述                                             | 是否必填 |
| :----- | :----- | :----------------------------------------------- | :------- |
| `name` | String | 子区的更新名称。子区名称的最大长度为 64 个字符。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应 body 中的 data 字段包含以下参数：

| 参数   | 类型   | 描述             |
| :----- | :----- | :--------------- |
| `name` | String | 子区更新后的名称。 |

其他字段说明详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X PUT http://XXXX.com/XXXX/testapp/thread/177916702949377 -H 'Authorization: Bearer <YourAppToken>' -d '{"name": "test4"}'
```

#### 响应示例

```json
{
    "action": "put",
    "applicationName": "testapp",
    "duration": 4,
    "data": {
        "name": "test4"
    }
    "organization": "XXXX",
    "timestamp": 1650869972109,
    "uri": "http://XXXX.com/XXXX/testy/thread"
}
```

## 删除子区

删除指定的子区。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/thread/{thread_id}
```

#### 路径参数

| 参数        | 类型   | 描述        | 是否必填 |
| :---------- | :----- | :---------- | :------- |
| `thread_id` | String | 子区的 ID。 | 是       |

其他字段说明详见 [公共参数](#pubparam)。

#### 请求 header

有关请求 header 参数的描述，请参阅 [认证方式](#auth)。

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应 body 中的 data 字段包含以下参数：

| 参数     | 类型   | 描述                                 |
| :------- | :----- | :----------------------------------- |
| `status` | String | 子区是否被删除。`ok`表示子区被删除。 |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X DELETE http://XXXX.com/XXXX/testapp/thread/177916702949377 -H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "action": "delete",
    "applicationName": "testapp",
    "duration": 4,
    "data": {
        "status": "ok"
    },
    "organization": "XXXX",
    "timestamp": 1650869972109,
    "uri": "http://XXXX.com/XXXX/testy/thread"
}
```

## 获取应用下的所有子区

分页获取应用程序下的所有子区。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/thread?limit={limit}&cursor={cursor}&sort={sort}
```

#### 路径参数

参数及说明详见 [公共参数](#pubparam)。

#### 查询参数

| 参数     | 类型   | 描述                                                                                            | 是否必填 |
| :------- | :----- | :---------------------------------------------------------------------------------------------- | :------- |
| `limit`  | String | 每页获取的最大子区数。范围是 [1, 50]。默认值为 50。                                             | 否       |
| `cursor` | String | 开始获取子区的页面。在第一次查询时传入 `null` 或空字符串。                                        | 否       |
| `sort`   | String | 列出查询结果的顺序：`asc`：按照子区创建的时间顺序。（默认）`desc`：按照子区创建的时间倒序排列。 | 否       |

#### 请求 header

有关请求 header 参数的描述，请参阅 [认证方式](#auth)。

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应 body 中的 entity 字段包含以下参数：

| 范围 | 类型   | 描述        |
| :--- | :----- | :---------- |
| `id` | String | 子区的 ID。 |
| `properties.cursor` | String | 查询游标，指定下次查询的起始位置。 |

其他字段说明详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X GET http://XXXX.com/XXXX/testapp/thread -H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "action": "get",
    "applicationName": "testapp",
    "duration": 7,
    "entities": [
        {
            "id": "179786360094768"
        }
    ],
    "organization": "XXXX",
    "properties": {
        "cursor": "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aW06dGhyZWFkOmVhc2Vtb2ItZGVtbyN0ZXN0eToxNzk3ODYzNjExNDMzMTE"
    },
    "timestamp": 1650869750247,
    "uri": "http://XXXX.com/XXXX/testy/thread"
}
```

## 获取用户在应用下加入的所有子区

获取用户在应用下加入的所有子区。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/threads/user/{username}?limit={limit}&cursor={cursor}&sort={sort}
```

#### 路径参数

参数及说明详见[公共参数](#pubparam)。

#### 查询参数

| 参数       | 类型   | 描述                                                                                            | 是否必填 |
| :--------- | :----- | :---------------------------------------------------------------------------------------------- | :------- |
| `limit`    | String | 每页获取的最大子区数。范围是 [1, 50]。默认值为 50。                                             | 否       |
| `cursor`   | String | 开始获取子区的页面。在第一次查询时传入 `null` 或空字符串。                                        | 否       |
| `sort`     | String | 列出查询结果的顺序：<li>`asc`：按照子区创建的时间顺序。<li>（默认）`desc`：按照子区创建的时间倒序排列。 | 否       |


#### 请求 header

有关请求 header 参数的描述，请参阅 [认证方式](#auth)。

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应 body 中的 entity 字段包含以下参数：

| 参数      | 类型   | 描述                        |
| :-------- | :----- | :-------------------------- |
| `name`    | String | 子区名称。                  |
| `owner`   | String | 子区创建者。                |
| `id`      | String | 子区 ID。                   |
| `msgId`   | String | 创建子区所基于的消息的 ID。 |
| `groupId` | String | 子区所属的群组的ID。        |
| `created` | String | 创建子区时的 Unix 时间戳。  |
| `properties.cursor` | String | 查询游标，指定服务器下次查询的起始位置。 |

其他字段说明详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X GET http://XXXX.com/XXXX/testapp/threads/user/test4 -H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "action": "get",
    "applicationName": "testapp",
    "duration": 4,
    "entities": [
        {
            "name": "1",
            "owner": "test4",
            "id": "17XXXX69",
            "msgId": "1920",
            "groupId": "17XXXX61",
            "created": 1650856033420
        }
    ],
    "organization": "XXXX",
    "properties": {
        "cursor": "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aW06dGhyZWFkOmVhc2Vtb2ItZGVtbyN0ZXN0eToxNzk3ODYzNjAwOTQ3Nzg"
    },
    "timestamp": 1650869972109,
    "uri": "http://XXXX.com/XXXX/testy/threads/user/test4"
}
```

## 获取用户在群组下加入的所有子区

获取用户在群组下加入的所有子区。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/threads/chatgroups/{group_id}/user/{username}?limit={limit}&cursor={cursor}&sort={sort}
```

#### 路径参数

| 参数       | 类型   | 描述                                                                                            | 是否必填 |
| :--------- | :----- | :---------------------------------------------------------------------------------------------- | :------- |
| `group_id` | String | 群组的 ID。                                                                                     | 是       |
| `username` | String | 用户 ID。                                                                            | 是       |

其他参数及说明详见[公共参数](#pubparam)。

#### 查询参数

| 参数       | 类型   | 描述                                                                                            | 是否必填 |
| :--------- | :----- | :---------------------------------------------------------------------------------------------- | :------- |
| `limit`    | String | 每页获取的最大子区数。范围是 [1, 50]。默认值为 50。                                             | 否       |
| `cursor`   | String | 开始获取子区的页面。在第一次查询时传入 `null` 或空字符串。                                        | 否       |
| `sort`     | String | 列出查询结果的顺序：<li>`asc`：按照子区创建的时间顺序。<li>（默认）`desc`：按照子区创建的时间倒序排列。 | 否       |

#### 请求 header

有关请求 header 参数的描述，请参阅 [认证方式](#auth)。

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应 body 中的 entity 字段包含以下参数：

| 参数      | 类型   | 描述                        |
| :-------- | :----- | :-------------------------- |
| `name`    | String | 子区名称。                  |
| `owner`   | String | 子区创建者。                |
| `id`      | String | 子区 ID。                   |
| `msgId`   | String | 创建子区所基于的消息的 ID。 |
| `groupId` | String | 子区所属的群组的ID。        |
| `created` | String | 创建子区时的 Unix 时间戳。  |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X GET http://XXXX.com/XXXX/testapp/threads/user/test4 -H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "action": "get",
    "applicationName": "testapp",
    "duration": 4,
    "entities": [
        {
            "name": "1",
            "owner": "test4",
            "id": "17XXXX69",
            "msgId": "1920",
            "groupId": "17XXXX61",
            "created": 1650856033420
        }
    ],
    "organization": "XXXX",
    "properties": {
        "cursor": "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aW06dGhyZWFkOmVhc2Vtb2ItZGVtbyN0ZXN0eToxNzk3ODYzNjAwOTQ3Nzg"
    },
    "timestamp": 1650869972109,
    "uri": "http://XXXX.com/XXXX/testy/threads/user/test4"
}
```

<a name="code"></code>

## 状态码

有关详细信息，请参阅 [HTTP 状态代码](./agora_chat_status_code?platform=RESTful)。