本文展示如何调用 Agora 即时通讯 RESTful API 实现聊天室成员管理，包括添加、删除、查询聊天室成员或管理员。
调用以下方法前，请先参考[限制条件](./agora_chat_limitation?platform=RESTful#服务端调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

## 聊天室成员角色说明

| 成员角色     | 描述                                                 | 管理权限                                                                       |
| :----------- | :--------------------------------------------------- | :----------------------------------------------------------------------------- |
| 普通成员     | 不具备管理权限的聊天室成员。                         | 普通成员可以修改自己的聊天室资料。                                             |
| 聊天室管理员 | 由聊天室创建者授权，协助聊天室管理，具有管理权限。 | 管理员可以管理聊天室内的普通成员。 最多支持添加 99 个管理员。                  |
| 聊天室所有者 | 聊天室的创建者，具有聊天室最高权限。                 | 聊天室所有者可以指定聊天室管理员、解散聊天室、更改聊天室信息、管理聊天室成员。 |

## <a name="param"></a>公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数：

### 请求参数

| 参数          | 类型   | 描述                                                                                                                                                                                                                                                        | 是否必填 |
| :------------ | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host`        | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful)。                                                                                                              | 是       |
| `org_name`    | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful)。                                                                                                         | 是       |
| `app_name`    | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful)。                                                                                                                | 是       |
| `username`    | String | 用户名。用户的唯一登录账号。长度在 64 个字符内，不可设置为空。支持以下字符集：<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 0-9<li>"\_", "-", "."<div class="alert note"><ul><li>不区分大小写。<li>同一个 app 下，用户名唯一。</ul></div> | 是       |
| `chatroom_id` | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符，从[查询所有聊天室基本信息](./agora_chat_restful_chatroom%20?platform=RESTful#a-namegetalla查询所有聊天室基本信息) 的响应 body 中获取。                                                                 | 是       |

### 响应参数

| 参数                | 类型   | 描述                                                              |
| :------------------ | :----- | :---------------------------------------------------------------- |
| `action`            | String | 请求方式。                                                        |
| `organization`      | String | 即时通讯服务分配给每个企业（组织）的唯一标识。等同于 `org_name`。 |
| `application`       | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。             |
| `applicationName`   | String | 即时通讯服务分配给每个 app 的唯一标识。等同于 `app_name`。        |
| `uri`               | String | 请求 URL。                                                        |
| `path`              | String | 请求路径，属于请求 URL 的一部分，无需关注。                       |
| `entities`          | JSON   | 返回实体信息。                                                    |
| `entities.created`  | Number | 注册用户的 Unix 时间戳（毫秒）。                                  |
| `entities.username` | String | 用户 ID。用户登录的唯一账号。                                     |
| `data`              | JSON   | 返回数据详情。                                                    |
| `timestamp`         | Long | 响应的 Unix 时间戳（毫秒）。                                      |
| `duration`          | Number | 从发送请求到响应的时长（毫秒）。                                  |

## 认证方式

~e838c3b0-8e43-11ec-814c-17df6c7c3801~
	
## 添加单个聊天室成员

向聊天室添加一个成员。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroomid}/users/{username}
```

#### 路径参数

参数及说明详见[公共参数](#param)。

> 如果待添加的用户在 app 中不存在或已经在聊天室中，则请求失败并返回错误码 `400`。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | `application/json`     | 是       |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型   | 描述                                                    |
| :------- | :----- | :------------------------------------------------------ |
| `result` | Bool   | 添加结果：<li>`true：`添加成功。<li>`false`：添加失败。 |
| `action` | String | 执行的操作，`add_member` 表示向聊天室添加成员。         |
| `id`     | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符。   |
| `user`   | String | 已添加成员的用户名。                                    |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/users/XXXX'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/users/XXXX",
    "entities": [],
    "data": {
        "result": true,
        "action": "add_member",
        "id": "XXXX",
        "user": "user1"
    },
    "timestamp": 1542554038353,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 批量添加聊天室成员

向聊天室添加多个成员。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroomid}/users
```

#### 路径参数

参数及说明详见[公共参数](#param)。

<div class="alert note">一次请求最多添加 60 个用户。</div>

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | `application/json`     | 是       |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

#### 请求 body

请求包体为 JSON Object 类型，包含以下字段：

| 字段        | 类型       | 描述                     | 是否必填 |
| :---------- | :--------- | :----------------------- | :------- |
| `usernames` | JSON Array | 待添加成员的用户名数组。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应 body 包含如下字段：

| 字段         | 类型       | 描述                                                  |
| :----------- | :--------- | :---------------------------------------------------- |
| `newmembers` | JSON Array | 已添加成员的用户名数组。                              |
| `action`     | String     | 执行的操作，`add_member` 表示向聊天室添加成员。       |
| `id`         | String     | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符。 |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
   "usernames": [
     "user1","user2"
   ]
 }' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/users'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/users",
    "entities": [],
    "data": {
        "newmembers": ["user1", "user2"],
        "action": "add_member",
        "id": "XXXX"
    },
    "timestamp": 1542554537237,
    "duration": 9,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 分页查询聊天室成员

分页查询聊天室成员。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/users?pagenum={N}&pagesize={N}
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 查询参数

| 参数       | 类型 | 描述                                                         | 是否必填 |
| :--------- | :--- | :----------------------------------------------------------- | :------- |
| `pagenum`  | Int  | 查询页码。默认值为 1。                                       | 否       |
| `pagesize` | Int  | 每页显示的聊天室成员数量。默认值为 1000。取值范围 [0,1000]。 | 否       |

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型   | 描述                 |
| :------- | :----- | :------------------- |
| `member` | String | 聊天室成员的用户名。 |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/users?pagenum=2&pagesize=2'
```

#### 响应示例

```json
{
    "action": "get",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "params": {
        "pagesize": ["2"],
        "pagenum": ["2"]
    },
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/users",
    "entities": [],
    "data": [
        {
            "member": "user1"
        },
        {
            "member": "user2"
        }
    ],
    "timestamp": 1489074511416,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX",
    "count": 2
}
```

## 删除单个聊天室成员

删除单个聊天室成员。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroomid}/users/{username}
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型   | 描述                                                    |
| :------- | :----- | :------------------------------------------------------ |
| `result` | Bool   | 删除结果：<li>`true`：删除成功。<li>`false`：删除失败。 |
| `action` | String | 执行的操作，`remove_member` 表示删除聊天室成员。        |
| `user`   | String | 已删除成员的用户名。                                    |
| `id`     | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符。   |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/users/XXXX'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/users/XXXX",
    "entities": [],
    "data": {
        "result": true,
        "action": "remove_member",
        "user": "user1",
        "id": "XXXX"
    },
    "timestamp": 1542555744726,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 批量删除聊天室成员

删除聊天室多个成员。

### HTTP 请求

```http
DELETE https://{host} /{org_name}/{app_name}/chatrooms/{chatroomid}/users/{usernames}
```

### HTTP 请求

#### 路径参数

| 参数        | 类型   | 描述                                                                                                   | 是否必填 |
| :---------- | :----- | :----------------------------------------------------------------------------------------------------- | :------- |
| `usernames` | String | 一个或多个用户名，用户名之间用 "," 分隔。在 URL 中，"," 需要转义为 "%2C"。一次最多传入 100 个 用户名。 | 是       |

其他参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应 body 包含如下字段：

| 字段     | 类型   | 描述                                                    |
| :------- | :----- | :------------------------------------------------------ |
| `result` | Bool   | 删除结果：<li>`true`：删除成功。<li>`false`：删除失败。 |
| `action` | String | 执行的操作，`remove_member` 表示删除聊天室成员。        |
| `reason` | String | 删除失败原因。                                          |
| `user`   | String | 已删除成员的用户名列表。                                |
| `id`     | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符。   |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/users/user1%2Cuser2'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/users/user1%2Cuser2",
    "entities": [],
    "data": [
        {
            "result": false,
            "action": "remove_member",
            "reason": "user: user1 doesn't exist in group: 66213271109633",
            "user": "user1",
            "id": "XXXX"
        },
        {
            "result": true,
            "action": "remove_member",
            "user": "user2",
            "id": "XXXX"
        }
    ],
    "timestamp": 1542556177147,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 添加单个聊天室管理员

将一个聊天室普通成员作为聊天室管理员。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/admin
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | `application/json`     | 是       |
| `Content-Type`  | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

#### 请求 body

请求包体为 JSON Object 类型，包含以下字段：

| 字段       | 类型   | 描述                   | 是否必填 |
| :--------- | :----- | :--------------------- | :------- |
| `newadmin` | String | 待添加管理员的用户名。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型   | 描述                                            |
| :--------- | :----- | :---------------------------------------------- |
| `result`   | Bool   | 添加结果：`true：`添加成功。`false`：添加失败。 |
| `newadmin` | String | 已添加管理员的用户名。                          |

其他字段及说明详见[公共参数](#param)。
如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
   "newadmin": "user1"
 }' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/admin'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "22bcffa0-XXXX-XXXX-9df8-516f6df68c6d",
    "applicationName": "XXXX",
    "data": {
        "result": "success",
        "newadmin": "user1"
    },
    "duration": 0,
    "entities": [],
    "organization": "XXXX",
    "timestamp": 1642486989028,
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/admin"
}
```

## 查询聊天室管理员

查询聊天室管理员。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/admin
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段   | 类型       | 描述                     |
| :----- | :--------- | :----------------------- |
| `data` | JSON Array | 聊天室管理员用户名数组。 |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/admin'
```

#### 响应示例

```json
{
    "action": "get",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/admin",
    "entities": [],
    "data": ["XXXX"],
    "timestamp": 1489073361210,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX",
    "count": 1
}
```

## 撤销聊天室管理员

撤销指定用户的聊天室管理员角色，使之成为普通聊天室成员。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/admin/{oldadmin}
```

#### 路径参数

| 参数       | 类型   | 描述                           | 是否必填 |
| :--------- | :----- | :----------------------------- | :------- |
| `oldadmin` | String | 待被撤销聊天室管理员的用户名。 | 是       |

其他参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型    | 描述                                            |
| :--------- | :------ | :---------------------------------------------- |
| `result`   | Boolean | 撤销结果：`true：`撤销成功。`false`：撤销失败。 |
| `oldadmin` | String  | 被撤销的聊天室管理员用户名。                    |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/admin/XXXX'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/admin/XXXX",
    "entities": [],
    "data": {
        "result": "success",
        "oldadmin": "XXXX"
    },
    "timestamp": 1489073432732,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```