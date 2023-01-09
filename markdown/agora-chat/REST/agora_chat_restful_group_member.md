管理群组成员是指对一个群组内的成员进行添加、移除等操作。即时通讯提供多个接口实现添加群成员、获取群成员、添加管理员、转让群主等功能。

本文展示如何调用即时通讯 RESTful API 管理群组成员。调用以下方法前，请先参考[限制条件](./agora_chat_limitation)了解即时通讯 RESTful API 的调用频率限制。

<a name="pubparam"></a>
## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述                                                                                                                                                                                                                                                                                                                       | 是否必填 |
| :--------- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                                                                                                 | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                                                                                            | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                                                                                                   | 是       |
| `username` | String | 用户 ID。用户的唯一登录账号。长度在 64 个字符内，不可设置为空。支持以下字符集：<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>"_", "-", "."</li></ul>注意：<ul><li>该参数不区分大小写，因此 `Aa` 和 `aa` 为相同用户 ID。</li><li>请确保同一个 app 下，`username` 唯一。</li></ul> | 是       |

### 响应参数

| 参数              | 类型   | 描述                                                                     |
| :---------------- | :----- | :----------------------------------------------------------------------- |
| `action`          | String | 请求方式。                                                               |
| `organization`    | String | 即时通讯服务分配给每个企业（组织）的唯一标识。等同于 `org_name`。 |
| `application`     | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。             |
| `applicationName` | String | 即时通讯服务分配给每个 app 的唯一标识。等同于 `app_name`。        |
| `uri`             | String | 请求 URL。                                                               |
| `path`            | String | 请求路径，属于请求 URL 的一部分，无需关注。                              |
| `entities`        | JSON   | 返回实体信息。                                                           |
| `data`            | Array  | 实际请求到的数据。                                                       |
| `count`           | Number | 获取到的数组数量。                                                       |
| `created`         | Number| 群组创建时间，Unix 时间戳，单位为毫秒。                      |
| `username`    | String| 用户 ID。                                                     |
| `groupname`      | String | 群组名。                                                     |
| `nickname`         | String| 用户昵称。                                                   |
| `timestamp`       | Long   | 响应的 Unix 时间戳（毫秒）。                                             |
| `duration`        | Number | 从发送请求到响应的时长（毫秒）。                                         |

## 认证方式

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

## 分页获取群组成员

分页获取群组成员列表。

### HTTP 请求

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/users

// 分页获取
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/users?pagenum={N}&pagesize={N}
```

#### 路径参数

| 参数       | 类型   | 描述                                              | 是否必填 |
| :--------- | :----- | :------------------------------------------------ | :------- |
| `group_id` | String | 群组 ID。                                         | 是       |

参数及说明详见[公共参数](#pubparam)。

#### 查询参数

| 参数       | 类型   | 描述                                              | 是否必填 |
| :--------- | :----- | :------------------------------------------------ | :------- |
| `pagenum`  | Number | 当前页码。默认从第 1 页开始获取。          | 否       |
| `pagesize` | Number | 每页请求的成员数量。取值范围为[1,100]。默认值为 10。 | 否       |

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`          | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文：

| 参数     | 类型   | 描述                                       |
| :------- | :----- | :----------------------------------------- |
| `owner`  | String | 群主的用户 ID，如 `{"owner":"user1"}`。    |
| `member` | String | 群成员的用户 ID，如 `{"member":"user2"}`。 |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考 [状态码](#code) 了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X GET -H 'Accept: application/json' 'http://XXXX/XXXX/XXXX/chatgroups/10130212061185/users?pagenum=2&pagesize=2' -H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "action": "get",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "params": {
        "pagesize": [
          "2"
        ],
        "pagenum": [
          "2"
        ]
    },
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10XXXX85/users",
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

## 添加单个群组成员

将指定用户添加进群组。如果该指定用户已经是群成员，则该方法会返回错误。

### HTTP 请求

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/users/{username}
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求参数

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json` | 是       |
| `Accept`        | String | 内容类型。填入 `application/json` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`          | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文：

| 参数      | 类型    | 描述                                                               |
| :-------- | :------ | :----------------------------------------------------------------- |
| `result`  | Boolean | 是否成功添加：<ul><li>`true`：是。</li><li>`false`：否。</li></ul> |
| `groupid` | String  | 群组 ID。                                                          |
| `action`  | String  | 执行操作。                                                         |
| `user`    | String  | 被添加到群组的用户 ID。                                            |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/users/user4'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585/users/user4",
    "entities": [],
    "data": {
      "result": true,
      "groupid": "66016455491585",
      "action": "add_member",
      "user": "user4"
    },
    "timestamp": 1542364958405,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 批量添加群组成员

将多个指定用户添加进群组。你一次最多可以添加 60 个用户进群组。如果指定的用户已经是群成员，则会在响应的 body 中返回错误。

### HTTP 请求

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{chatgroupid}/users
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json` | 是       |
| `Accept`        | String | 内容类型。填入 `application/json` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`          | 是       |

#### 请求 body

| 参数        | 类型  | 描述                      | 是否必填 |
| :---------- | :---- | :------------------------ | :------- |
| `usernames` | Array | 待添加到群组中的成员 ID。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文：

| 参数         | 类型   | 描述                    |
| :----------- | :----- | :---------------------- |
| `newmembers` | Array  | 已添加进群组的成员 ID。 |
| `groupid`    | String | 群组 ID。               |
| `action`     | String | 执行操作。              |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
    "usernames": [
      "user4","user5"
    ]
}' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/users'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585/users",
    "entities": [],
    "data": {
      "newmembers": [
        "user5",
        "user4"
      ],
      "groupid": "66016455491585",
      "action": "add_member"
    },
    "timestamp": 1542365557942,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 移除单个群组成员

将指定用户从群组中移除。如果指定用户不在群组内，则该方法会返回错误。

### HTTP 请求

```shell
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/users/{username}
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`          | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文：

| 参数      | 类型    | 描述                                                               |
| :-------- | :------ | :----------------------------------------------------------------- |
| `result`  | Boolean | 是否成功移除：<ul><li>`true`：是。</li><li>`false`：否。</li></ul> |
| `groupid` | String  | 群组 ID。                                                          |
| `action`  | String  | 执行操作。                                                         |
| `user`    | String  | 被从群组中移除的用户 ID。                                          |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考 [状态码](#code) 了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/users/user3'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585/users/user3",
    "entities": [],
    "data": {
      "result": true,
      "action": "remove_member",
      "user": "user3",
      "groupid": "66016455491585"
    },
    "timestamp": 1542365943067,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 批量移除群组成员

将多名指定用户从群组中移除。你一次最多可以移除 60 名群成员。如果指定的用户不在群组中，则会在响应的 body 中返回错误。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/users/{memebers}
```

#### 路径参数

| 参数     | 类型   | 描述                                                           | 是否必填 |
| :------- | :----- | :------------------------------------------------------------- | :------- |
| group_id | String | 群组 ID。                                                      | 是       |
| members  | String | 待移除的群组成员 ID，各 ID 之间用英文逗号分隔。如 user1, user2。建议一次最多移除 60 个群成员，并且 URL 的长度不超过 4 KB。 | 是       |

其他路径参数说明详见公共参数。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`          | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文：

| 参数      | 类型    | 描述                                                               |
| :-------- | :------ | :----------------------------------------------------------------- |
| `result`  | Boolean | 操作是否成功：<ul><li>`true`：是。</li><li>`false`：否。</li></ul> |
| `groupid` | String  | 群组 ID。                                                          |
| `reason`  | String  | 操作失败的原因。                                                   |
| `action`  | String  | 执行操作。                                                         |
| `user`    | String  | 被从群组中移除的用户 ID。                                          |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考 [状态码](#code) 了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/users/ttestuser0015981,user2,user3'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "9b848cf0-XXXX-XXXX-b5b8-0f74e8e740f7",
    "uri": "https://XXXX/XXXX/XXXX",
    "entities": [],
    "data": [{
        "result": false,
        "action": "remove_member",
        "reason": "user ttestuser0015981 doesn't exist.",
        "user": "user1",
        "groupid": "1433492852257879"
    },
    {
        "result": true,
        "action": "remove_member",
        "user": "user2",
        "groupid": "1433492852257879"
    },
    {
        "result": true,
        "action": "remove_member",
        "user": "user3",
        "groupid": "1433492852257879"
    }],
    "timestamp": 1433492935318,
    "duration": 84,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 获取群管理员列表

获取群组管理员的列表。

### HTTP 请求

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/admin
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`          | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段即返回的群管理员的信息。其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考 [状态码](#code) 了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X GET HTTP://XXXX/XXXX/XXXX/chatgroups/10130212061185/admin -H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "action": "get",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/admin",
    "entities": [],
    "data": ["user1"],
    "timestamp": 1489073361210,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX",
    "count": 1
}
```

## 添加群管理员

将一个群成员角色权限提升为群管理员。群管理员有管理黑名单、禁言等权限。最多可以添加 99 个群管理员。

### HTTP 请求

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/admin
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json` | 是       |
| `Accept`        | String | 内容类型。填入 `application/json` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`          | 是       |

#### 请求 body

| 参数       | 类型   | 描述                          | 是否必须 |
| :--------- | :----- | :---------------------------- | :------- |
| `newadmin` | String | 待添加为新群管理员的用户 ID。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段    | 类型   | 描述                    |
| :----- | :----- | :---------------------- |
| `data` | String | 添加的新管理员用户 ID。 |
| `count` | Number   | 添加的新管理员的数量。 |

其他字段及说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-type: application/json' -H 'Accept: application/json' 'http://XXXX/XXXX/XXXX/chatgroups/10130212061185/admin' -d '{"newadmin":"user1"}' -H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "action": "get",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/admin",
    "entities": [],
    "data": ["user1"],
    "timestamp": 1489073361210,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX",
    "count": 1
}
```

## 移除群管理员

将用户角色从群管理员降为群普通成员。

### HTTP 请求

```shell
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/admin
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`          | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文：

| 参数       | 类型    | 描述                                                                           |
| :--------- | :------ | :----------------------------------------------------------------------------- |
| `result`   | Boolean | 是否成功将指定用户移除管理员：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `oldadmin` | String  | 被移除的管理员 ID。                                                            |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X DELETE -H 'Accept: application/json' 'http://XXXX/XXXX/XXXX/chatgroups/10130212061185/admin/user1' -H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/admin/user1",
    "entities": [],
    "data": {
        "result": "success",
        "oldadmin": "user1"
    },
    "timestamp": 1489073432732,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 转让群组

将群主改为同一群组中的其他成员。群主拥有群组的所有权限。

### HTTP 请求

```shell
PUT https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/admin
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json` | 是       |
| `Accept`        | String | 内容类型。填入 `application/json` | 是       |
| `Authorization` | String | `Bearer ${YourAppToken}`          | 是       |

#### 请求 body

| 参数       | 类型   | 描述             | 是否必须 |
| :--------- | :----- | :--------------- | :------- |
| `newowner` | String | 新群主的用户 ID。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文。

| 参数       | 类型    | 描述                                                            |
| :--------- | :------ | :-------------------------------------------------------------- |
| `newowner` | Boolean | 是否成功将指定用户设为群主：<ul><li>`true`：是</li><li>`false`：否</li></ul> |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考 [状态码](#code) 了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{     "newowner": "user2"   }' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585'
```

#### 响应示例

```json
{
    "action": "put",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585",
    "entities": [],
    "data": {
      "newowner": true
    },
    "timestamp": 1542537813420,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## <a name="code"></code> 状态码

有关详细信息，请参阅 [HTTP 状态代码](./agora_chat_status_code?platform=RESTful)。