聊天群白名单列表是指在群主或管理员使用 [全员禁言](https://docs.agora.io/en/agora-chat/agora_chat_restful_group_mute?platform=RESTful#muting-all-chat-group-members) 方法将所有群成员禁言后，可以发送群消息的聊天室成员列表。即时通讯提供了一套完整的允许列表管理方法，包括将用户添加到白名单列表中、将其从其中删除，以及查询白名单列表中的成员。

本页面展示了如何使即时通讯 RESTful API 管理群组白名单列表。在调用以下方法之前，请确保了解 [使用限制](https://docs.agora.io/en/agora-chat/agora_chat_limitation?platform=RESTful#call-limit-of-server-side)。

<a name="pubparam"></a>

## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述                                                         | 是否必填 |
| :--------- | :--- | :----------------------------------------------------------- | :----- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。 | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。 | 是       |
| `username` | String | 用户名。用户的唯一登录账号。长度在 64 个字符内，不可设置为空。支持以下字符集：<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>"_", "-", "."</li></ul>注意：<ul><li>该参数不区分大小写，因此 `Aa` 和 `aa` 为相同用户名。</li><li>请确保同一个 app 下，`username` 唯一。</li></ul> | 是       |

### 响应参数

| 参数                 | 类型    | 描述                                                         |
| :------------------- | :------ | :----------------------------------------------------------- |
| `action`             | String  | 请求方式。                                                   |
| `organization`       | String  | 组织 ID，等同于 org_name，即时通讯服务分配给每个企业（组织）的唯一标识。 |
| `application`        | String  | 系统内为 app 生成的唯一内部标识，无需关注。                  |
| `applicationName`    | String  | App ID，等同于 app_name，即时通讯服务分配给每个 app 的唯一标识。 |
| `uri`                | String  | 请求 URL。                                                   |
| `path`               | String  | 请求路径，属于请求 URL 的一部分，无需关注。                  |
| `entities`           | JSON    | 返回实体信息。                                               |
| `data`               | Array   | 实际请求到的数据。                                           |
| `created`       | Long     | 群组创建时间，Unix 时间戳，单位为毫秒。                      |
| `username`    | String  | 用户 ID。                                                     |
| `groupname`     | String    | 群组名。                                                     |
| `nickname`          | String | 用户昵称。                                                   |
| `timestamp`          | Long  | 响应的 Unix 时间戳（毫秒）。                                 |
| `duration`           | Number  | 从发送请求到响应的时长（毫秒）。                             |

## 认证方式

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

## 查询群组白名单

查询一个群组白名单中的用户列表。

### HTTP 请求

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/white/users
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必填 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`   | String   |内容类型。请填 `application/json` | 是  |
| `Authorization` | String | `Bearer ${YourAppToken}` | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段中就包含群组白名单用户的 ID。其他参数详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码](#code)了解可能的原因。

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

## 添加单个成员至群组白名单列表

此方法将指定用户添加至群组白名单列表。在群组所有者或管理员使用 [全员禁言](https://docs.agora.io/en/agora-chat/agora_chat_restful_group_allowlist?platform=RESTful) 方法将所有群组成员禁言后，群组白名单列表中的成员仍然可以发送群组消息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/white/users/{username}
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :--------- | :--- | :------------------------------ | :----- |
| `group_id` | String | 群组 ID。 | 是       |
| `username` | String  | 要添加到群组白名单的用户 ID。 | 是   |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Accept`  | String | 内容类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}` | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 data 字段的说明见下文。

| 参数    | 类型    | 描述                                              |
| :-------- | :----- | :----------------------------------------------------------- |
| `result`  | Boolean | 是否成功将指定用户添加到白名单：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `reason`  | String   | 未能将成员添加到允许列表的原因。                             |
| `groupid` | String  | 群组 ID。                                         |
| `action`  | String  | 执行操作。                                        |
| `user`    | String  | 被添加到群组白名单的用户 ID。                     |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Accept: application/json' -H 'Authorization: Bearer {YourAppToken}' 'http://XXXX/XXXX/XXXX/chatgroups/{The group ID}/white/users/{username}'
```

#### 响应示例

```json
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

## 批量添加用户至群组白名单

此方法将多个成员添加到群组白名单列表中。每次方法调用最多可以将 60 个组成员添加到白名单列表。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/white/users
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :--------- | :--- | :---------- | :----- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Content-Type`  | String | 内容类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}` | 是       |

#### 请求 body

| 参数      | 类型  | 描述                            | 是否必须 |
| :-------- | :---- | :------------------------------ | :------- |
| `usernames` | Array | 待添加至群组白名单中的用户 ID。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 data 字段的说明见下文。

| 参数    | 类型    | 描述                                              |
| :------ | :------ | :------------------------------------------------ |
| `result`  | Boolean | 是否成功将指定用户添加到白名单：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `reason`  | String  | 添加失败的原因。                                  |
| `groupid` | String  | 群组 ID。                                         |
| `action`  | String  | 执行操作。                                        |
| `user`    | String  | 被添加到群组白名单的用户 ID。                     |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码](#code)了解可能的原因。

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

## 从群组白名单中删除成员

此方法从群组白名单中删除指定的群组成员。每次方法调用最多可以从白名单列表中删除 60 个组成员。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/white/users/{username}
```

#### 路径参数

| 参数      | 类型   | 描述                                      | 是否必需 |
| :-------- | :----- | :---------------------------------------- | :------- |
| `group_id`  | String | 群组 ID。                                 | 是       |
| `usernames` | String | 用户 ID。多个用户 ID 之间使用英文逗号隔开。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 内容类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}` | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文。

| 参数    | 类型    | 描述                                              |
| :-------- | :----- | :----------------------------------------------------------- |
| `result`  | Bool | 群组成员是否成功从群组白名单中删除。<ul><li>`true`：是。</li><li>`false`：否。</li></ul> |
| `reason`  | String  | 未能从允许列表中删除成员的原因。                             |
| `groupid` | String  | 群组 ID。                                         |
| `action`  | String  | 执行操作。                                        |
| `user`    | String  | 被从群组白名单移除的用户 ID。                     |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码](#code)了解可能的原因。

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

<a name="code"></a>

## 状态码

有关详细信息，请参阅 [HTTP 状态代码](https://docs.agora.io/en/agora-chat/agora_chat_status_code?platform=RESTful)。