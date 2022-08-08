随着监管机制日益完善，对 app 的监管不断加强，安全合规逐渐成为 app 的生命线。声网即时通讯 Agora Chat 提供全局禁言功能，对 app 提供用户 ID 级别的禁言管理，支持在管理员发现用户违规后进行全局禁言，以维护 app 良好的内容生态环境。禁言到期后，Agora Chat 服务器会自动解除禁言，恢复该用户发送消息的权限。

你可以对单个用户 ID 设置单聊、群组或聊天室消息全局禁言。禁言后，该用户将无法在对应的单聊、群组或聊天室发送消息；无论通过调用客户端 API，还是使用服务端 RESTful API 都不行。

该功能可广泛应用于实时互动 app 中，例如发现某用户频繁向多个聊天室发送违规广告，则可以对该用户开启全局聊天室禁言 15 天；发现某用户发表触犯红线的政治言论，则可以全局永久禁言，用户申诉通过后可以解禁。

<a name="param"></a>

## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述        | 是否必填 |
| :--------- | :----- | :------------------------ | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful)。                                                                                                              | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful)。                                                                                                         | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful)。                                                                                                                | 是       |
| `username` | String | 用户名。用户的唯一登录账号。长度在 64 个字节内，不可设置为空。支持以下字符集：</ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>"\_", "-", "."</li></ul><div class="alert note"><ul><li>不区分大小写。</li><li>同一个 app 下，用户名唯一。</li><li>请勿将该字段设置为 UUID、邮箱地址、手机号码或其它敏感信息。</li></ul></div> | 是       |

### 响应参数

| 参数                 | 类型   | 描述                              |
| :------------------- | :----- | :----------------- |
| `action`             | String | 请求方式。  |
| `organization`       | String | 即时通讯服务分配给每个企业（组织）的唯一标识。等同于 `org_name`。 |
| `application`        | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。|
| `applicationName`    | String | 即时通讯服务分配给每个 app 的唯一标识。等同于 `app_name`。       |
| `uri`                | String | 请求 URL。                |
| `path`               | String | 请求路径，属于请求 URL 的一部分，无需关注。         |
| `data`           | JSON   | 返回实体信息。      |
| `timestamp`          | Long | HTTP 响应的 Unix 时间戳（毫秒）。              |
| `duration`           | Number | 从发送 HTTP 请求到响应的时长（毫秒）。     |

## 认证方式

~e838c3b0-8e43-11ec-814c-17df6c7c3801~

## 设置用户全局禁言

该方法设置指定用户的单聊、群组、聊天室消息的全局禁言。设置成功后，该用户将无法在对应的单聊、群组或聊天室中发送消息。


### HTTP 请求

```http
POST https://{host}/{orgName}/{appName}/mutes
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求参数

| 字段  | 类型 | 是否必需 | 字段说明                                                |
| --------- | -------- | ------------ | ------------------------------------------------------------ |
| `username`  | String   | 必需         | 设置禁言配置的用户 ID。                                    |
| `chat`      | Number  | 非必需       | 单聊消息禁言时长，单位为秒，最大值为 2147483647。<ul><li>> `0`：该用户 ID 具体的单聊消息禁言时长。</li><li>`0`：取消该用户的单聊消息禁言。</li><li>`-1`：该用户被设置永久单聊消息禁言。</li><li>如果设为其他负值，则取值无效。</li></ul> |
| `groupchat` | Number  | 非必需       | 群组消息禁言时长，单位为秒，规则同上。                       |
| `chatroom`  | Number  | 非必需       | 聊天室消息禁言时长，单位为秒，规则同上。                     |

#### 请求 header

| 参数          | 类型   | 是否必需 | 描述                                     |
| ------------- | ------ | -------- | ---------------------------------------- |
| `Content-Type`  | String | 必需     | `application/json` 内容类型。             |
| `Authorization` | String | 必需     | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 |

### HTTP 响应

如果你返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 参数   | 类型   | 描述                |
| ------ | ------ | ------------------- |
| `result` | String | 该方法调用结果。`ok` 表示设置成功。 |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -L -X POST 'https://XXXX/XXXX/XXXX/mutes' \
-H 'Authorization: Bearer {{token}}' \
-H 'Content-Type: application/json' \
--data-raw '{
    "username": "XXXX",
    "chat": 100,
    "groupchat": 100,
    "chatroom": 100
}'
```

#### 响应示例

```json
{
    "path": "/mutes",
    "uri": "https://XXXX/XXXX/XXXX/mutes",
    "timestamp": 1631609754727,
    "organization": "XXXX",
    "application": "XXXX",
    "action": "post",
    "data": {
        "result": "ok"
    },
    "duration": 74,
    "applicationName": "XXXX"
}
```

## 查询单个用户 ID 全局禁言

查询单个用户的单聊/群聊/聊天室消息禁言。

### HTTP 请求

```http
GET https://{host}/{orgName}/{appName}/mutes/username
```

#### 路径参数

| 参数     | 类型   | 是否必需 | 描述                                     |
| -------- | ------ | -------- | ---------------------------------------- |
| `username` | String | 必需     | 查询禁言信息的用户 ID。                   |

其他参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数          | 类型   | 是否必需 | 描述                                      |
| ------------- | ------ | -------- | ----------------------------------------- |
| `Content-Type`  | String | 必需     | `application/json` 内容类型。             |
| `Authorization` | String | 必需     | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 |

### HTTP 响应

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 参数      | 类型   | 描述                                                         |
| --------- | ------ | ------------------------------------------------------------ |
| `userid`    | String | 设置禁言的用户 ID。                                          |
| `chat`      | Number    | 单聊消息剩余禁言时长，单位为秒，最大值为 2147483647。<ul><li>> `0`：该用户 ID 具体的单聊消息禁言时长。 </li><li>`0`：该用户的单聊消息禁言已取消。</li><li>`-1`：该用户被设置永久单聊消息禁言。</li></ul> |
| `groupchat` | Number    | 群组消息剩余禁言时长，单位为秒，规则同上。                   |
| `chatroom`  | Number    | 聊天室消息剩余禁言时长，单位为秒，规则同上。                 |
| `unixtime`  | Number    | 当前操作的 Unix 时间戳。                                     |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -L -X GET 'https://XXXX/XXXX/XXXX/mutes/{username}' \
-H 'Authorization: Bearer {{token}}' \
-H 'Content-Type: application/json'
```

#### 响应示例

```json
{
    "path": "/mutes",
    "uri": "https://XXXX/XXXX/XXXX/mutes",
    "timestamp": 1631609831800,
    "organization": "XXXX",
    "application": "XXXX",
    "action": "get",
    "data": {
        "userid": "XXXX",
        "chat": 96,
        "groupchat": 96,
        "chatroom": 96,
        "unixtime": 1631609831
    },
    "duration": 13,
    "applicationName": "XXXX"
}
```

## 查询 app 下的所有全局禁言的用户

该方法查询 app 下所有全局禁言的用户即其禁言剩余时间。

### HTTP 请求

```http
GET https://{host}/{orgName}/{appName}/mutes
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数          | 类型   | 是否必需 | 描述                                 |
| ------------- | ------ | -------- | ------------------------------------ |
| `Content-Type`  | String | 必需     | `application/json` 内容类型。             |
| `Authorization` | String | 必需     | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 |

### 请求 body

| 参数     | 类型 | 是否必需 | 描述               |
| -------- | ---- | -------- | ---------------------- |
| `pageNum`  | Number  | 必需     | 请求查询的页码。        |
| `pageSize` | Number  | 必需     | 请求查询每页显示的禁言用户的数量。 |

### HTTP 响应

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 参数      | 类型   | 描述                                                         |
| --------- | ------ | ------------------------------------------------------------ |
| `username`  | String | 设置禁言的用户 ID。                                            |
| `chat`      | Number    | 单聊消息剩余禁言时间，单位为秒。最大值为 2147483647。<ul><li>> `0`：该用户 ID 具体的单聊消息禁言时长。</li><li>`0`：该用户的单聊消息禁言已取消。</li><li>`-1`：该用户被设置永久单聊消息禁言。</li></ul> |

| `groupchat` | Number    | 群组消息剩余禁言时长，单位为秒，规则同上。                    |
| `chatroom`  | Number    | 聊天室消息剩余禁言时长，单位为秒，规则同上。                  |
| `unixtime`  | Number    | 当前操作的 Unix 时间戳。                                      |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -L -X GET 'https://XXXX/XXXX/XXXX/mutes?pageNum=1&pageSize=10' \
-H 'Authorization: Bearer {{token}}' \
-H 'Content-Type: application/json'
```

#### 响应示例

```json
{
    "path": "/mutes",
    "uri": "https://XXXX/XXXX/XXXX/mutes",
    "timestamp": 1631609858771,
    "organization": "XXXX",
    "application": "XXXX",
    "action": "get",
    "data": {
        "data": [
            {
                "username": "XXXX",
                "chatroom": 0
            },
            {
                "username": "XXXX",
                "groupchat": 69
            },
            {
                "username": "XXXX",
                "chat": 69
            },
            {
                "username": "XXXX",
                "chatroom": 69
            },
            {
                "username": "XXXX",
                "chatroom": 0
            },
            {
                "username": "XXXX",
                "groupchat": 0
            },
            {
                "username": "XXXX",
                "chat": 0
            }
        ],
        "unixtime": 1631609858
    },
    "duration": 17,
    "applicationName": "XXXX"
}
```