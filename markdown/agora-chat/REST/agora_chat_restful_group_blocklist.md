群组黑名单是指群组中无法查看和接收群组消息的用户列表。即时通讯 IM 提供多个接口实现群组黑名单管理，包括查看黑名单中的用户以及将用户加入和移除黑名单等。

调用本文中的 API 前，请先参考[使用限制](./agora_chat_limitation?platform=RESTful#服务端接口调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

<a name="pubparam"></a>
## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述                | 是否必填 |
| :--------- | :----- | :------------------ | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `username` | String | 用户 ID。用户的唯一登录账号。 | 是       |

### 响应参数

| 参数                 | 类型    | 描述                                                         |
| :------------------- | :------ | :----------------------------------------------------------- |
| `action`             | String  | 请求方式。                                                   |
| `organization`       | String  | 组织 ID，即时通讯服务分配给每个企业（组织）的唯一标识，与请求参数 `org_name` 相同。 |
| `application`        | String  | 系统内为 app 生成的唯一内部标识，无需关注。                  |
| `applicationName`    | String  | App ID，即时通讯服务分配给每个 app 的唯一标识，与请求参数 `app_name` 相同。  |
| `entities`           | JSON    | 返回实体信息。                                               |
| `timestamp`          | Number | 响应的 Unix 时间戳，单位为毫秒。                                 |
| `duration`           | Number  | 从发送请求到响应的时长，单位为毫秒。                             |

## 认证方式

即时通讯服务 RESTful API 要求 HTTP 身份验证。每次发送 HTTP 请求时，必须在请求 header 填入如下 `Authorization` 字段：

```http
Authorization: Bearer YourAppToken
```

为了提高项目的安全性，Agora 使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯服务 RESTful API 仅支持使用 app 权限 token 对用户进行身份验证。详见[使用 App 权限 token 进行身份验证](./agora_chat_token?platform=RESTful)。

## 查询群组黑名单

查询群组黑名单中的用户列表。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/blocks/users
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必填 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 字段    | 类型  | 描述                |
| :----- | :---- | :------------------ |
| `data` | Array | 群组黑名单上的用户 ID。 |
| `count` | Number | 群组黑名单中的用户数量。 |

其他字段及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/blocks/users'
```

#### 响应示例

```json
{
    "action": "get",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/67178793598977/blocks/users",
    "entities": [],
    "data": [
      "user2",
      "user3"
    ],
    "timestamp": 1543466293681,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX",
    "count": 2
}
```

## 添加单个用户至群组黑名单

将单个用户添加至群组黑名单。群主无法被加入群组的黑名单。

用户进入群组黑名单后会收到加入黑名单的回调。之后，该用户无法查看该群组的信息，也收不到该群组的消息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/blocks/users/{username}
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Accept`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数    | 类型    | 描述                                              |
| :------ | :------ | :------------------------------------------------ |
| `data`  | JSON| 将用户添加到群组黑名单的结果。 |
| `data.result`  | Boolean | 是否成功将指定用户添加到群组黑名单：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.groupid` | String  | 群组 ID。                                         |
| `data.action`  | String  | 执行操作。在该响应中，`add_blocks` 表示将用户添加到群组黑名单。                                       |
| `data.user`    | String  | 添加到群组黑名单的用户 ID。                     |

其他参数及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/blocks/users/user1'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585/blocks/users/user1",
    "entities": [],
    "data": {
      "result": true,
      "action": "add_blocks",
      "user": "user1",
      "groupid": "66016455491585"
    },
    "timestamp": 1542539577124,
    "duration": 27,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 批量添加用户至群组黑名单

将多个用户添加至群组黑名单，一次最多可以添加 60 个用户。群主无法被加入群组的黑名单。

用户进入群组黑名单后会收到加入黑名单的回调。黑名单上的用户无法查看该群组的信息，也收不到该群组的消息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/blocks/users
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Accept`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

#### 请求 body

| 参数      | 类型  | 描述                            | 是否必须 |
| :-------- | :---- | :------------------------------ | :------- |
| `usernames` | Array | 待添加至群组黑名单中的用户 ID。| 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数    | 类型    | 描述                                              |
| :------ | :------ | :------------------------------------------------ |
| `data`  | JSON Array | 添加结果。 |
| `data.result`  | Boolean | 是否成功将指定用户添加至群组黑名单：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.reason`  | String  | 用户未能添加至群组黑名单的原因。       |
| `data.groupid` | String  | 群组 ID。        |
| `data.action`  | String  | 执行操作。在该响应中，`add_blocks` 表示将成员添加至群组黑名单。        |
| `data.user`    | String  | 添加到群组黑名单的用户 ID。     |

其他参数及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
    "usernames": [
      "user3","user4"
    ]
}' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/blocks/users'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585/blocks/users",
    "entities": [],
    "data": [
      {
        "result": false,
        "action": "add_blocks",
        "reason": "user: user3 doesn't exist in group: 66016455491585",
        "user": "user3",
        "groupid": "66016455491585"
      },
      {
        "result": true,
        "action": "add_blocks",
        "user": "user4",
        "groupid": "66016455491585"
      }
    ],
    "timestamp": 1542540095540,
    "duration": 16,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 从群组黑名单移除单个用户

将单个用户移出群组黑名单。对于群组黑名单中的用户，如果需要将其再次加入群组，需要先将其从群组黑名单中移除。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/blocks/users/{username}
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数    | 类型    | 描述                                              |
| :------ | :------ | :------------------------------------------------ |
| `data`  | JSON | 移除结果。 |
| `data.result`  | Boolean | 是否成功将指定用户移出群组黑名单：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.groupid` | String  | 群组 ID。                                         |
| `data.action`  | String  | 执行操作。在该响应中，`remove_blocks` 表示将用户移出群组黑名单。        |
| `data.user`    | String  | 从群组黑名单移除的用户 ID。                     |

其他字段及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/blocks/users/user1'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585/blocks/users/user1",
    "entities": [],
    "data": {
      "result": true,
      "action": "remove_blocks",
      "user": "user1",
      "groupid": "66016455491585"
    },
    "timestamp": 1542540470679,
    "duration": 45,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 从群组黑名单批量移除用户

将多名指定用户从群组黑名单中移除。对于群组黑名单中的用户，如果需要将其再次加入群组，需要先将其从群组黑名单中移除。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/blocks/users/{usernames}
```

#### 路径参数

| 参数      | 类型   | 描述                                      | 是否必需 |
| :-------- | :----- | :---------------------------------------- | :------- |
| `group_id`  | String | 群组 ID。                                 | 是       |
| `usernames` | String | 要移除群组黑名单的用户 ID。多个用户 ID 之间使用英文逗号隔开。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 内容类型。填入 `application/json`。                                  | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数    | 类型    | 描述                                              |
| :------ | :------ | :------------------------------------------------ |
| `data`  | JSON Array | 批量移除结果。 |
| `data.result`  | Boolean | 是否成功将指定用户移出群组黑名单：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.groupid` | String  | 群组 ID。                                         |
| `data.action`  | String  | 执行操作。在该响应中，`remove_blocks` 表示将用户移出群组黑名单。                                        |
| `data.user`    | String  | 从群组黑名单批量移除的用户 ID。                     |

其他参数及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/blocks/users/user1%2Cuser2'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66XXXX85/blocks/users/user1%2Cuser2",
    "entities": [],
    "data": [
      {
        "result": true,
        "action": "remove_blocks",
        "user": "user1",
        "groupid": "66XXXX85"
      },
      {
        "result": true,
        "action": "remove_blocks",
        "user": "user2",
        "groupid": "66XXXX85"
      }
    ],
    "timestamp": 1542541014655,
    "duration": 29,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## <a name="code"></code> 状态码

详见 [HTTP 状态码](./agora_chat_status_code?platform=RESTful)。