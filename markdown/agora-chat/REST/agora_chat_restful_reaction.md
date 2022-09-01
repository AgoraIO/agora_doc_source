在单聊和群聊中，用户可以使用表情符号回复指定消息，为实时聊天增添乐趣和多样性。在即时通讯 IM 中，此功能称为 Reaction 。本页展示了如何使用即时通讯 IM RESTful API 在项目中实现 Reaction。

在调用以下方法之前，请了解即时通讯 IM 的 [使用限制](..cn/agora-chat/agora_chat_limitation?platform=RESTful#call-limit-of-server-side)。

<a name="pubparam"></a>

## 公共参数

下表列出了即时通讯 IM RESTful API 的常用请求和响应参数。

### 请求参数

| 参数       | 类型   | 描述                                                                                                                                                                                                                                                                                                                | 是否必填 |
| :--------- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :------- |
| `host`     | String | 即时通讯 IM 服务分配的用于访问 RESTful API 的域名。获取域名的方法请参见[获取项目信息](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project)。                                                                                                       | 是       |
| `org_name` | String | 即时通讯 IM 服务分配给每个公司（组织）的唯一标识符。如何获取组织名称，请参见[获取项目信息](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project)。                                                                                                  | 是       |
| `app_name` | String | Agora 聊天服务分配给每个应用的唯一标识符。获取应用名称的方法请参见[获取项目信息](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project)。                                                                                                            | 是       |
| `username`      | String | 用户的唯一登录帐户。                                         |        |

### 响应参数

| 参数        | 类型   | 描述                           |
| :---------- | :----- | :----------------------------- |
| `data`      | JSON   | 返回的数据。                   |
| `timestamp` | Long   | HTTP 响应的 Unix 时间戳 (ms)。 |
| `username`  | String | 用户标识。                     |
| `groupname` | String | 群组名称。                     |

## 认证方式 <a name="auth"></a>

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

## 创建/追加 Reaction

在单聊和群聊场景中在单条消息上创建或追加 Reaction。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/reaction/user/{userId}
```

#### 路径参数

参数及说明详见 [公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                                | 是否必填 |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type`  | String | `application/x-www-form-urlencoded` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`            | 是       |

#### 请求 body

| 参数      | 类型   | 描述                                               | 是否必填 |
| :-------- | :----- | :------------------------------------------------- | :------- |
| `msg_Id`  | String | 要向其添加 Reaction 的消息 ID。                    | 是       |
| `message` | String | 表情 ID。长度不可超过 128 个字符。与客户端一致。允许的字符集包括：<li>26 个大写字母 (A-Z)；<li>26 个小写字母(a-z)；<li>10 个数字(0-9)；<li>特殊字符（建议不使用，如需使用需要你自行在查询和删除接口进行 URL 编码）。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应 body 中的 data 字段包含以下参数：

| 参数                | 类型   | 描述                                                           |
| :------------------ | :----- | :------------------------------------------------------------- |
| `requestStatusCode` | String | 此请求的状态码。`ok` 表示请求成功。                            |
| `id`                | String | Reaction ID。                                                  |
| `msgId`             | String | 消息 ID。                                                      |
| `msgType`           | String | 消息类型：<li>`chat`: 单聊。<li>`groupchat`: 群聊。            |
| `groupId`           | String | 群组 ID。如果消息类型为 `chat`，则服务器返回 null。            |
| `reaction`          | String | 作为响应添加的表情符号的 ID，与 `message` 请求 body 中的相同。 |
| `createAt`          | Long   | 创建 Reaction 的时间。                                         |
| `updateAt`          | Long   | 更新 Reaction 的时间。                                         |

其他字段及详细说明请参见 [公共参数](./agora_chat_restful_reaction?platform=RESTful#param)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -g -X POST 'http://XXXX/XXXX/XXXX/reaction/user/e1' -H 'Authorization: Bearer {YourAppToken}' -H 'Content-Type: application/json' --data-raw '{
    "msgId":"997625372793113144",
    "message":"emoji_40"
}'
```

#### 响应示例

```json
{
    "requestStatusCode": "ok",
    "timestamp": 1645774821181,
    "data": {
        "id": "946481033434607420",
        "msgId": "msg3333",
        "msgType": "chat",
        "groupId": null,
        "reaction": "message123456",
        "createdAt": "2022-02-24T10:57:43.138934Z",
        "updatedAt": "2022-02-24T10:57:43.138939Z"
    }
}
```

## 根据消息 ID 获取 Reaction

该方法根据单聊或群聊中的消息 ID 获取指定消息的 Reaction 信息，包括 Reaction ID、使用的表情 ID、以及使用该 Reaction 的用户 ID 及用户人数。获取的 Reaction 的用户列表只展示最早三个添加 Reaction 的用户。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/reaction/user/{userId}
```

#### 路径参数

参数及说明详见 [公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                                | 是否必填 |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type`  | String | `application/x-www-form-urlencoded` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`            | 是       |

#### 请求 body

| 参数        | 类型   | 描述                                                          | 是否必填 |
| :---------- | :----- | :------------------------------------------------------------ | :------- |
| `msgIdList` | Array  | 你要获取其 Reaction 的消息 ID。                               | 是       |
| `msgType`   | String | 消息类型：<li>`chat`: 单聊。<li>`groupchat`: 群聊。           | 是       |
| `groupId`   | String | 群组 ID。如果设置 `msgType` 为 `groupchat`，则必须指定组 ID。 |  否     |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应中的 `data` 包含以下字段：

| 参数                | 类型   | 描述                                                                                                                                                     |
| :------------------ | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `requestStatusCode` | String | 此请求的状态码。`ok` 表示请求成功。                                                                                                                      |
| `msgId`             | String | 消息 ID。                                                                                                                                                |
| `reactionId`        | String | [创建 Reaction](./agora_chat_restful_reaction?platform=RESTful#创建/追加 Reaction) 的响应体数据中返回的 Reaction ID 。 |
| `reaction`          | String | 作为 Reaction 添加的表情符号的 ID。                                                                                                                      |
| `count`             | Number | 将此 Reaction 添加到消息中的用户数。                                                                                                                     |
| `state`             | Bool   | 发送此请求的用户是否对此消息添加了 Reaction 。<li>`true`： 是的。<li>`false`：否。                                                                       |
| `userList`          | Array  | 已添加此 Reaction 的用户 ID 列表。它最多包含三个最先添加此 Reaction 的用户。                                                                             |

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -g -X GET 'http://XXXX/XXXX/XXXX/reaction/user/{{userId}}?msgIdList=msgId1&msgType=chat' -H 'Authorization: Bearer {YourAppToken}'
```

#### 响应示例

```json
{
    "requestStatusCode": "ok",
    "timestamp": 1645774821181,
    "data": [
        {
            "msgId": "msg123",
            "reactionList": [
                {
                    "reactionId": "944330310986837168",
                    "reaction": message123456,
                    "count": 0,
                    "state": false,
                    "userList": [
                        "test123",
                        "test456",
                        "test1"
                    ]
                }
            ]
        },
        {
            "msgId": "msg1234",
            "reactionList": [
                {
                    "reactionId": "945272584050659838",
                    "reaction": message123456,
                    "count": 0,
                    "state": false,
                    "userList": [
                        "test5"
                    ]
                }
            ]
        }
    ]
}
```

## 删除 Reaction

删除当前用户对该 Reaction 的追加操作。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/reaction/user/{userId}
```

#### 路径参数

参数及说明详见 [公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                                | 是否必填 |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type`  | String | `application/x-www-form-urlencoded` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`            | 是       |

#### 请求 body

| 参数      | 类型   | 描述                                | 是否必填 |
| :-------- | :----- | :---------------------------------- | :------- |
| `msgId`   | String | 消息 ID。                           | 是       |
| `message` | String | 表情 ID。长度不可超过 128 个字符。与客户端一致。  | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应中的 `data` 包含以下字段：

| 参数                | 类型   | 描述                                 |
| :------------------ | :----- | :----------------------------------- |
| `requestStatusCode` | String | 此请求的状态码。`ok` 表示请求成功。  |
| `timestamp`         | Long | 此操作的时间戳，单位为毫秒。|

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -g -X DELETE 'http://XXXX/XXXX/XXXX/reaction/user/wz?msgId=997625372793113144&message=emoji_40' -H 'Authorization: Bearer {YourAppToken}'
```

#### 响应示例

```json
{
    "requestStatusCode": "ok",
    "timestamp": 1645774821181
}
```

## 根据 消息 ID 和 表情 ID 获取 Reaction 信息

该方法根据指定的消息的 ID 和表情 ID 获取对应的 Reaction 信息，包括使用了该 Reaction 的用户 ID及用户人数。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/reaction/user/{userId}/detail
```

#### 路径参数

参数说明详见 [公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                                | 是否必填 |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type`  | String | `application/x-www-form-urlencoded` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`            | 是       |

#### 请求 body

| 参数      | 类型   | 描述                                                                                           | 是否必填 |
| :-------- | :----- | :--------------------------------------------------------------------------------------------- | :------- |
| `msgId`   | String | 消息 ID。                                                                                      | 是       |
| `message` | String | 作为 Reaction 添加的表情符号的 ID。                                                            | 是       |
| `limit`   | Number | 当使用分页获取 Reaction 时，在每页上获取到的 Reaction 数。取值范围为 [1,100]。默认值为 100。 | 否       |
| `cursor`  | String | 使用分页获取 Reaction ，则从中获取数据的起始页。                                         |          |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，`data` 响应中的 包含以下字段：

| 参数                | 类型   | 描述                                                                  |
| :------------------ | :----- | :-------------------------------------------------------------------- |
| `requestStatusCode` | String | 接口相应 code 状态。`OK` 表示操作成功。                      |
| `reactionId`        | String | Reaction  ID。                                                        |
| `reaction`          | String | 表情 ID，与客户端一致。同请求参数中 “message”。              |
| `count`             | Number | 添加该 Reaction 的用户人数。                                 |
| `state`             | Bool   | 当前请求用户是否添加过该 Reaction。 <li>`true`：是；<li>`false`：否。 |
| `userList`          | Array  | 追加 Reaction 的用户 ID 列表。只返回最早操作 Reaction 的三个用户的 ID。 |
| `cursor`            | String | 分页获取时使用，传入游标后便从游标起始的地方进行查询，类似于数据库 limit 1,5 中 1 的作用，可以理解为页码。 |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```shell
// 第一页
curl -g -X GET 'http://XXXX/XXXX/XXXX/reaction/user/wz/detail?msgId=997627787730750008&message=emoji_40&limit=50' -H 'Authorization: Bearer {YourAppToken}'

// 第 N 页
curl -g -X GET 'http://XXXX/XXXX/XXXX/reaction/user/wz/detail?msgId=997627787730750008&message=emoji_40&cursor=944330529971449164&limit=50' -H 'Authorization: Authorization: Bearer {YourAppToken}'
```

#### 响应示例

```json
{
    "requestStatusCode": "ok",
    "timestamp": 1645776986146,
    "data": {
        "reactionId": "946463470818405943",
        "reaction": "message123456",
        "count": 1,
        "state": true,
        "userList": [
            "wz1"
        ],
        "cursor": "946463471296555192"
    }
}
```

<a name="code"></code>

## 状态码

有关详细信息，请参阅 [HTTP 状态代码](./agora_chat_status_code?platform=RESTful)。