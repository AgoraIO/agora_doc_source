群组白名单列表指在群主或管理员使用 [群组全员禁言](./agora_chat_restful_group_mute?platform=RESTful#禁言全体群成员) 方法将所有群成员禁言后，仍可发送群消息的群成员列表。即时通讯 IM 提供多个接口实现群组白名单管理，包括查看群组白名单中的用户以及将用户添加至或移除白名单等。

调用本文中的 API 前，请先参考 [使用限制](./agora_chat_limitation?platform=RESTful#服务端接口调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

<a name="pubparam"></a>

## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述                                                         | 是否必填 |
| :--------- | :--- | :----------------------------------------------------------- | :----- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `username` | String | 用户 ID。用户的唯一登录账号。 | 是       |

### 响应参数

| 参数                 | 类型    | 描述                                                         |
| :------------------- | :------ | :----------------------------------------------------------- |
| `action`             | String  | 请求方式。                                                   |
| `organization`       | String  | 组织 ID，即时通讯服务分配给每个企业（组织）的唯一标识，与请求参数 `org_name` 相同。 |
| `application`        | String  | 系统内为 app 生成的唯一内部标识，无需关注。                  |
| `applicationName`    | String  | App ID，即时通讯服务分配给每个 app 的唯一标识，与请求参数 `app_name` 相同。 |
| `uri`                | String  | 请求 URL。                                                   |
| `entities`           | JSON    | 返回实体信息。                                               |
| `timestamp`          | Number  | 响应的 Unix 时间戳，单位为毫秒。                                 |
| `duration`           | Number  | 从发送请求到响应的时长，单位为毫秒。                             |

## 认证方式

即时通讯服务 RESTful API 要求 HTTP 身份验证。每次发送 HTTP 请求时，必须在请求 header 填入如下 `Authorization` 字段：

```http
Authorization: Bearer ${YourAppToken}
```

为了提高项目的安全性，Agora 使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯服务 RESTful API 仅支持使用 app 权限 token 对用户进行身份验证。详见[使用 App Token 进行身份验证](./agora_chat_token?platform=RESTful)。

## 查询群组白名单

查询群组白名单中的用户列表。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/white/users
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必填 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`   | String   |内容类型。请填 `application/json`。 | 是  |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数                 | 类型    | 描述                                                         |
| :------------------- | :------ | :----------------------------------------------------------- |
| `data`             | Array  | 群组白名单中的成员信息。                   |
| `data.username`             | String  | 群组白名单中的成员的用户 ID。           |
| `count`             | Number  | 群组白名单中的成员数量。       |

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer {YourAppToken}' 'http://XXXX/XXXX/XXXX/chatgroups/{The group ID}/white/users'
```

#### 响应示例

```json
{
    "action": "get",
    "application": "5cf28979-XXXX-XXXX-b969-60141fb9c75d",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/1208XXXX5169153/white/users",
    "entities": [],
    "data": [
        "username1",
        "username1",
        "username3",
        "username4",
        "username5"
    ],
    "timestamp": 1594724947117,
    "duration": 3,
    "organization": "XXXX",
    "applicationName": "XXXX",
    "count": 5
}
```

## 添加单个成员至群组白名单

将指定的单个成员添加至群组白名单。用户添加至群组白名单后，[当群组全员禁言时](./agora_chat_restful_group_allowlist?platform=RESTful#禁言全体群成员) ，群组白名单列表中的成员仍然可以发送群组消息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/white/users/{username}
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :--------- | :--- | :------------------------------ | :----- |
| `group_id` | String | 群组 ID。 | 是       |
| `username` | String  | 要添加到群组白名单的成员的用户 ID。 | 是   |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Accept`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数    | 类型    | 描述                                              |
| :-------- | :----- | :----------------------------------------------------------- |
| `data`  | JSON | 群组白名单中添加成员的相关信息。 |
| `data.result`  | Boolean | 是否成功将指定成员添加到白名单：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.reason`  | String   | 成员未能成功添加到群组白名单的原因。                             |
| `data.groupid` | String  | 群组 ID。                                         |
| `data.action`  | String  | 执行操作。在该响应中，`add_user_whitelist` 表示将群成员添加至白名单。  |
| `data.user`    | String  | 被添加到群组白名单的成员的用户 ID。                     |

其他参数及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Accept: application/json' -H 'Authorization: Bearer {YourAppToken}' 'http://XXXX/XXXX/XXXX/chatgroups/{The group ID}/white/users/{username}'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "5cf28979-XXXX-XXXX-b969-60141fb9c75d",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/120824965169153/white/users/username1",
    "entities": [],
    "data": {
        "result": true,
        "action": "add_user_whitelist",
        "user": "username1",
        "groupid": "1208XXXX5169153"
    },
    "timestamp": 1594724293063,
    "duration": 4,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 批量添加成员至群组白名单

添加多个用户至群组白名单。你一次最多可添加 60 个用户。用户添加至白名单后，在群组全员禁言时仍可以在群组中发送消息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/white/users
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :--------- | :--- | :---------- | :----- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。| 是       |

#### 请求 body

| 参数      | 类型  | 描述                            | 是否必须 |
| :-------- | :---- | :------------------------------ | :------- |
| `usernames` | Array | 待添加至群组白名单中的用户 ID。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数    | 类型    | 描述                                              |
| :------ | :------ | :------------------------------------------------ |
| `data`  | JSON | 批量添加的相关信息。 |
| `data.result`  | Boolean | 是否成功将群成员批量添加至白名单：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.reason`  | String  | 添加失败的原因。                                  |
| `data.groupid` | String  | 群组 ID。                                         |
| `data.action`  | String  | 执行操作。在该响应中，`add_user_whitelist` 表示将群成员添加至白名单。                                      |
| `data.user`    | String  | 被添加至群组白名单的用户 ID。                     |

其他参数及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer {YourAppToken}' -d '{"usernames" : ["user1"]}' 'http://XXXX/XXXX/XXXX/chatgroups/{The group ID}/white/users'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "5cf28979-XXXX-XXXX-b969-60141fb9c75d",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/1208XXXX5169153/white/users",
    "entities": [],
    "data": [
        {
            "result": true,
            "action": "add_user_whitelist",
            "user": "username1",
            "groupid": "1208XXXX5169153"
        },
        {
            "result": true,
            "action": "add_user_whitelist",
            "user": "username2",
            "groupid": "1208XXXX5169153"
        }
    ],
    "timestamp": 1594724634191,
    "duration": 2,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 从群组白名单移除成员

将指定用户从群组白名单中移除。你每次最多可移除 60 个用户。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/white/users/{username}
```

#### 路径参数

| 参数      | 类型   | 描述                                      | 是否必需 |
| :-------- | :----- | :---------------------------------------- | :------- |
| `group_id`  | String | 群组 ID。                                 | 是       |
| `usernames` | String | 用户 ID。多个用户 ID 之间使用英文逗号隔开。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 内容类型。填入 `application/json`。                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数    | 类型    | 描述                                              |
| :-------- | :----- | :----------------------------------------------------------- |
| `data`  | JSON Array | 白名单成员移除结果。 |
| `data.result`  | Boolean | 群成员是否成功从群组白名单中移除：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.reason`  | String  | 群成员未能从群组白名单中移除的原因。                             |
| `data.groupid` | String  | 群组 ID。                                         |
| `data.action`  | String  | 执行操作。在该响应中，`remove_user_whitelist` 表示将群成员移除白名单。                                        |
| `user`    | String  | 被从群组白名单中移除的用户 ID。                     |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer {YourAppToken}' 'http://XXXX/XXXX/XXXX/chatgroups/1208XXXX5169153/white/users/{username}'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "5cf28979-XXXX-XXXX-b969-60141fb9c75d",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/1208XXXX5169153/white/users/username1,username2",
    "entities": [],
    "data": [
        {
            "result": true,
            "action": "remove_user_whitelist",
            "user": "username1",
            "groupid": "1208XXXX5169153"
        },
        {
            "result": true,
            "action": "remove_user_whitelist",
            "user": "username2",
            "groupid": "1208XXXX5169153"
        }
    ],
    "timestamp": 1594725137704,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## <a name="code"></code> 状态码

详见  [HTTP 状态码](./agora_chat_status_code?platform=RESTful)。