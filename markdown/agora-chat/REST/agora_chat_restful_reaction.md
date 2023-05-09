消息表情回复（“Reaction”）指用户在单聊和群聊场景中对单条消息回复表情，可丰富用户聊天时的互动方式。

本页介绍如何使用即时通讯 IM RESTful API 实现 Reaction 功能。

调用本文中的 API 前，请先参考[使用限制](./agora_chat_limitation?platform=RESTful#服务端接口调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

<a name="pubparam"></a>

## 公共参数

下表列出了即时通讯 IM RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述          | 是否必填 |
| :--------- | :----- | :---------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。        | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。    | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。     | 是  |
| `username`      | String | 用户 ID，用户唯一登录帐户。           | 是  |

## 认证方式

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

<a name="create"></a>

## 创建/追加 Reaction

在单聊和群聊场景中在单条消息上创建或追加 Reaction。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/reaction/user/{username}
```

#### 路径参数

参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                                | 是否必填 |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

#### 请求 body

| 参数      | 类型   | 描述                                               | 是否必填 |
| :-------- | :----- | :------------------------------------------------- | :------- |
| `msgId`  | String | 要添加 Reaction 的消息 ID。                    | 是       |
| `message` | String | 表情 ID。长度不能超过 128 个字符，必须与客户端的设置一致。该参数对支持的字符集类型没有限制，若使用特殊字符，获取和删除 Reaction 时需对特殊字符进行 URL 编码。| 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应包体中包含以下字段：

| 参数                | 类型    | 描述                                                         |
| :------------------ | :------ | :----------------------------------------------------------- |
| `requestStatusCode` | String  | 操作结果，`ok` 表示成功创建或追加 Reaction。                                |
| `timestamp`         | Number    | 请求响应的时间，Unix 时间戳，单位为毫秒。                    |
| `data`              | JSON    | 添加的 Reaction 的详情。                                     |
| `data.id`           | String  | Reaction ID。                                                |
| `data.msgId`        | String  | 添加 Reaction 的消息 ID。                                    |
| `data.msgType`      | String  | 消息的会话类型：<ul><li>`chat`：单聊</li><li>`groupchat`：群聊</li></ul> |
| `data.groupId`      | String  | 群组 ID。该参数在单聊时为 null。                             |
| `data.reaction`     | String  | 表情 ID，与客户端一致，与[创建/追加 Reaction API](#create)的请求参数 `message` 相同。 |
| `data.createAt`     | Number | Reaction 的创建时间。                                        |
| `data.updateAt`     | Number | Reaction 的修改时间。                                        |

其他参数及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

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

该方法根据单聊或群聊中的消息 ID 获取单个或多个消息的 Reaction 信息，包括 Reaction ID、使用的表情 ID、以及使用该 Reaction 的用户 ID 及用户人数。获取的 Reaction 的用户列表只展示最早三个添加 Reaction 的用户。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/reaction/user/{username}?msgIdList={N,M}&msgType={msgType}&groupId={groupId}
```

#### 路径参数

参数及描述详见[公共参数](#pubparam)。

#### 查询参数

| 参数        | 类型   | 描述         | 是否必填 |
| :---------- | :----- | :------------------------- | :------- |
| `msgIdList` | Array  | 要获取 Reaction 的消息 ID，最多可传 20 个消息 ID。                               | 是       |
| `msgType`   | String | 消息的会话类型：<ul><li>`chat`: 单聊</li><li>`groupchat`: 群聊</li></ul>           | 是       |
| `groupId`   | String | 群组 ID。如果 `msgType` 设置为 `groupchat`，即拉取群中的 Reaction，必须指定群组 ID。 |  否     |

#### 请求 header

| 参数            | 类型   | 描述                                | 是否必填 |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 参数                           | 类型       | 描述                                                         |
| :----------------------------- | :--------- | :----------------------------------------------------------- |
| `requestStatusCode`            | String     | 操作结果。`ok` 表示成功获取 Reaction。                      |
| `timestamp`                    | Number     | 请求响应的时间，Unix 时间戳，单位为毫秒。                    |
| `data`                         | JSON Array | 单个消息添加的 Reaction 的详情。                             |
| `data.msgId`                   | String     | Reaction 对应的消息 ID。                                     |
| `data.reactionList`            | JSON Array | 单个消息的 Reaction 列表。                                   |
| `data.reactionList.reactionId` | String     | Reaction ID。                                                |
| `data.reactionList.reaction`   | String     | 表情 ID，与客户端一致。该参数与[创建/追加 Reaction API](#create)的请求参数 `message` 相同。 |
| `data.reactionList.count`      | Number        | 添加该 Reaction 的用户人数。                                 |
| `data.reactionList.state`      | Boolean       | 当前用户是否添加过该 Reaction：<ul><li>`true`: 是</li><li>`false`：否</li></ul> |
| `data.reactionList.userList`   | Array      | 添加 Reaction 的用户 ID 列表。只返回最早操作 Reaction 的三个用户的 ID。 |

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

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
                    "reaction": "message123456",
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
                    "reaction": "message123456",
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

删除当前用户添加的 Reaction。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/reaction/user/{username}?msgId={msgId}&message={message}
```

#### 路径参数

参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                                | 是否必填 |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。  | 是       |

#### 查询参数

| 参数      | 类型   | 描述                                | 是否必填 |
| :-------- | :----- | :---------------------------------- | :------- |
| `msgId`   | String | 消息 ID。                           | 是       |
| `message` | String | 表情 ID。长度不可超过 128 个字符，必须与客户端一致。  | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应包体中包含以下字段：

| 参数                | 类型   | 描述                                 |
| :------------------ | :----- | :----------------------------------- |
| `requestStatusCode` | String | 操作结果。`ok` 表示成功删除 Reaction。  |
| `timestamp`         | Number | 请求响应的时间，Unix 时间戳，单位为毫秒。|

其他参数及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

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

## 根据消息 ID 和表情 ID 获取 Reaction 信息

该方法根据指定的消息的 ID 和表情 ID 获取对应的 Reaction 信息，包括使用了该 Reaction 的用户 ID 及用户人数。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/reaction/user/{username}/detail?msgId={msgId}&message={message}&limit={limit}&cursor={cursor}
```

#### 路径参数

参数及描述详见[公共参数](#pubparam)。

#### 查询参数

| 参数      | 类型   | 描述                | 是否必填 |
| :-------- | :----- | :------------------------------------- | :------- |
| `msgId`   | String | 消息 ID。           | 是       |
| `message` | String | 表情 ID。长度不可超过 128 个字符。该参数的值必须与客户端一致。      | 是       |
| `limit`   | Number | 每页显示的 Reaction 条数。取值范围为 [1,50]，默认值为 `50`。| 否       |
| `cursor`  | String | 查询游标，指定数据查询的起始位置。                  | 否      |

<div class="alert note">分页获取时，服务器按 Reaction 添加时间的正序返回。若 limit 和 cursor 均不传值，服务器返回最早添加的 50 个 Reaction。</div>

#### 请求 header

| 参数            | 类型   | 描述                                | 是否必填 |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。  | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 参数                | 类型   | 描述                                                         |
| :------------------ | :----- | :----------------------------------------------------------- |
| `requestStatusCode` | String | 操作结果，`ok` 表示成功获取 Reaction 信息。                                |
| `timestamp`         | Number  | 请求响应的时间，Unix 时间戳，单位为毫秒。                    |
| `data`              | JSON   | 消息添加的 Reaction 的详情。                                 |
| `data.reactionId`   | String | Reaction ID。                                                |
| `data.reaction`     | String | 表情 ID，与客户端一致。该参数与[创建/追加 Reaction API](#create)的请求参数 `message` 相同。 |
| `data.count`        | Number   | 添加该 Reaction 的用户人数。                                 |
| `data.state`        | Boolean   | 当前请求用户是否添加过该 Reaction：<ul><li>`true`：是</li><li>`false`：否</li></ul>|
| `data.userList`     | Array  | 添加 Reaction 的用户 ID 列表。只返回最早操作 Reaction 的三个用户的 ID。 |
| `data.cursor`       | String | 查询游标，指定下次查询的起始位置。                           |

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

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

## 状态码

详见 [HTTP 状态码](./agora_chat_status_code?platform=RESTful)。