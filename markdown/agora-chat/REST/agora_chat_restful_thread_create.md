本文展示如何通过调用即时通讯 IM 的 RESTful API 实现子区管理，包括创建、修改、删除和获取子区。

调用本文中的 API 前，请先参考 [使用限制](./agora_chat_limitation?platform=RESTful#服务端接口调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

<a name="pubparam"></a>

## 公共参数

下表列明即时通讯 IM RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述                      | 是否必填 |
| :--------- | :----- | :---------------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |

### 响应参数

| 参数              | 类型   | 描述                                                                |
| :---------------- | :----- | :------------------------------------------------------------------ |
| `action`          | String | HTTP 请求方法。                                                     |
| `organization`    | String | 即时通讯服务为每个企业（组织）分配的唯一标识，与请求参数 `org_name` 相同。  |
| `applicationName` | String | 即时通讯服务为每个 app 分配的唯一标识，与请求参数 `app_name` 相同。        |
| `data`            | String | 响应的详细信息。                                                    |
| `duration`        | String | 从发送 HTTP 请求到收到响应的持续时间，单位为毫秒。                     |
| `timestamp`       | String | HTTP 响应的 Unix 时间戳，单位为毫秒。    |
| `uri`             | String | 请求 URI，即请求 URL 的一部分。无需关注。           |
| `properties`      | JSON | 响应属性。                                                          |

## 认证方式 <a name="auth"></a>

即时通讯服务 RESTful API 要求 HTTP 身份验证。每次发送 HTTP 请求时，必须在请求 header 填入如下 `Authorization` 字段：

```http
Authorization: Bearer YourAppToken
```

为了提高项目的安全性，Agora 使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯服务 RESTful API 仅支持使用 app 权限 token 对用户进行身份验证。详见[使用 App Token 进行身份验证](./agora_chat_token?platform=RESTful)。

## 创建子区

创建一个子区。单个 app 下的子区总数默认为 10 万，如需调整请联系商务。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/thread
```

#### 路径参数

参数及描述详见 [公共参数](#pubparam)。

#### 请求 header

| 参数    | 类型   | 是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Authorization` | String | 是    |App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。|

#### 请求 body

| 参数       | 类型   | 描述                                         | 是否必填 |
| :--------- | :----- | :------------------------------------------- | :------- |
| `group_id` | String | 子区所在的群组 ID。                           | 是       |
| `name`     | String | 子区名称，不能超过 64 个字符。 | 是       |
| `msg_id`   | String | 子区的父消息 ID，即创建子区所基于的消息 ID。                  | 是       |
| `owner`    | String | 子区的所有者，即创建子区的群成员的用户 ID。                         | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应包体中包含以下字段：

| 参数        | 类型   | 描述        |
| :---------- | :----- | :---------- |
| `data` | JSON | 创建的子区的详情。 |
| `data.thread_id` | String | 子区的 ID。 |

其他参数及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

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

对于每个 App Key，该方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
PUT https://{host}/{org_name}/{app_name}/thread/{thread_id}
```

#### 路径参数

| 参数        | 类型   | 描述        | 是否必填 |
| :---------- | :----- | :---------- | :------- |
| `thread_id` | String | 子区的 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数    | 类型   | 是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Authorization` | String | 是    |App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。|

#### 请求 body

| 参数   | 类型   | 描述                                             | 是否必填 |
| :----- | :----- | :----------------------------------------------- | :------- |
| `name` | String | 要修改的子区的名称。修改后的子区名称不能超过 64 个字符。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应包体中包含以下字段：

| 参数   | 类型   | 描述             |
| :----- | :----- | :--------------- |
| `data` | JSON | 子区修改信息。 |
| `data.name` | String | 修改后的子区名称。 |

其他参数及描述详见 [公共参数](#pubparam)。

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
    },
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

其他参数及描述详见 [公共参数](#pubparam)。

#### 请求 header

| 参数    | 类型   | 是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Authorization` | String | 是    | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。|

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应包体中包含以下字段：

| 参数     | 类型   | 描述                                 |
| :------- | :----- | :----------------------------------- |
| `data` | JSON | 子区删除结果。 |
| `data.status` | String | 子区是否被删除。`ok` 表示子区被删除。 |

其他参数及描述详见[公共参数](#pubparam)。

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

分页获取应用下的所有子区。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/thread?limit={limit}&cursor={cursor}&sort={sort}
```

#### 路径参数

参数及描述详见 [公共参数](#pubparam)。

#### 查询参数

| 参数     | 类型   | 描述                 | 是否必填 |
| :------- | :----- | :------------------- | :------- |
| `limit`  | Number | 每次期望返回的子区数量，取值范围为 [1,50]。  | 否       |
| `cursor` | String | 数据查询的起始位置。       | 否       |
| `sort`   | String | 获取的子区的排序顺序：<ul><li>`asc`：按照子区创建的时间顺序。</li><li>（默认）`desc`：按照子区创建的时间倒序排列。</li></ul> | 否   |

#### 请求 header

| 参数    | 类型   | 是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Authorization` | String | 是    | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。|

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应包体中包含以下字段：

| 参数 | 类型   | 描述        |
| :--- | :----- | :---------- |
| `entities` | JSON Array | 获取的子区详情。|
| `entities.id` | String | 子区 ID。 |
| `properties.cursor` | String | 查询游标，指定下次查询的起始位置。 |

其他参数及描述详见 [公共参数](#pubparam)。

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

## 获取单个用户在应用下加入的所有子区

根据用户 ID 获取用户在应用下加入的所有子区。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/threads/user/{username}?limit={limit}&cursor={cursor}&sort={sort}
```

#### 路径参数

参数及描述详见[公共参数](#pubparam)。

#### 查询参数

| 参数       | 类型   | 描述            | 是否必填 |
| :--------- | :----- | :----------------------- | :------- |
| `limit`    | Number | 每次期望返回的子区数量，取值范围为 [1,50]。          | 否       |
| `cursor`   | String | 数据查询的起始位置。            | 否       |
| `sort`     | String | 获取的子区的排序顺序：<ul><li>`asc`：按照子区创建的时间顺序。</li><li>（默认）`desc`：按照子区创建的时间倒序排列。</li></ul> | 否       |

#### 请求 header

| 参数    | 类型   | 描述      | 是否必填 |
| :-------------- | :----- | :---------------- | :------- |
|`Authorization`| String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。| 是  | 

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应包体中包含以下字段：

| 参数      | 类型   | 描述                        |
| :-------- | :----- | :-------------------------- |
| `entities`  | JSON Array  | 获取的用户加入的子区的详情。      |
| `entities.name`  | String  |子区名称。      |
| `entities.owner`  | String |子区创建者的用户 ID。    |
| `entities.id`    | String  |子区 ID。     |
| `entities.msgId`  | String |子区的父消息 ID。 |
| `entities.groupId` | String |子区所属群组 ID。  |
| `entities.created` | Number |子区创建时间，Unix 时间戳。    |
| `properties.cursor`  | String  | 查询游标，指定服务器下次查询的起始位置。 |

其他参数及描述详见 [公共参数](#pubparam)。

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

根据用户 ID 分页获取该用户在指定群组中加入的所有子区。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/threads/chatgroups/{group_id}/user/{username}?limit={limit}&cursor={cursor}&sort={sort}
```

#### 路径参数

| 参数       | 类型   | 描述          | 是否必填 |
| :--------- | :----- | :------------------------------ | :------- |
| `group_id` | String | 群组的 ID。            | 是       |
| `username` | String | 用户 ID。           | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 查询参数

| 参数       | 类型   | 描述                      | 是否必填 |
| :--------- | :----- | :--------------------------- | :------- |
| `limit`    | String | 每次期望返回的子区数量，取值范围为 [1,50]。       | 否       |
| `cursor`   | String | 数据查询的起始位置。                                      | 否       |
| `sort`     | String | 获取的子区的排序顺序：<ul><li>`asc`：按照子区创建的时间顺序。</li><li>（默认）`desc`：按照子区创建的时间倒序排列。</li><li> | 否       |

#### 请求 header

| 参数    | 类型   | 是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
|`Authorization`| String | 是    |App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。|

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应包体中包含以下字段：

| 参数      | 类型   | 描述                        |
| :-------- | :----- | :-------------------------- |
| `entities`   | JSON Array |获取的子区的详情。      |
| `entities.name`   | String |子区名称。      |
| `entities.owner`  | String |子区创建者的用户 ID。    |
| `entities.id`     | String |子区 ID。     |
| `entities.msgId`   | String |子区的父消息 ID。 |
| `entities.groupId` | String |子区所属群组 ID。  |
| `entities.created` | Number  |子区创建时间，Unix 时间戳，单位为毫秒。    |
| `properties.cursor`  | String  | 查询游标，指定下次查询的起始位置。 |

其他参数及描述详见[公共参数](#pubparam)。

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

详见 [HTTP 状态代码](./agora_chat_status_code?platform=RESTful)。