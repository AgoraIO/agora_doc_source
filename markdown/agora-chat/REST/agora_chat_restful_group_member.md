即时通讯提供多个接口实现群成员管理，包括添加群成员、获取群成员列表、添加和移除管理员以及转让群主等功能。

本文展示如何调用即时通讯 RESTful API 管理群组成员。调用本文中的 API 前，请先参考 [使用限制](./agora_chat_limitation?platform=RESTful#服务端接口调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

<a name="pubparam"></a>
## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述                | 是否必填 |
| :--------- | :----- | :--------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。     | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。       | 是       |
| `username` | String | 用户 ID。用户的唯一登录账号。 | 是       |

### 响应参数

| 参数              | 类型   | 描述                                                                     |
| :---------------- | :----- | :----------------------------------------------------------------------- |
| `action`          | String | 请求方式。                                                               |
| `organization`    | String | 即时通讯服务分配给每个企业（组织）的唯一标识，与请求参数 `org_name` 相同。 |
| `application`     | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。             |
| `applicationName` | String | 即时通讯服务分配给每个 app 的唯一标识，与请求参数 `app_name` 相同。        |
| `uri`             | String | 请求 URL。                                                               |
| `entities`        | JSON   | 返回实体信息。                                                           |
| `timestamp`       | Number   | 响应的 Unix 时间戳，单位为毫秒。                                             |
| `duration`        | Number | 从发送请求到响应的时长，单位为毫秒。                                         |

## 认证方式

即时通讯服务 RESTful API 要求 HTTP 身份验证。每次发送 HTTP 请求时，必须在请求 header 填入如下 `Authorization` 字段：

```http
Authorization: Bearer YourAppToken
```

为了提高项目的安全性，Agora 使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯服务 RESTful API 仅支持使用 app 权限 token 对用户进行身份验证。详见[使用 App 权限 token 进行身份验证](./agora_chat_token?platform=RESTful)。

## 分页获取群组成员

分页获取群组成员列表。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/users?pagenum={N}&pagesize={N}
```

#### 路径参数

| 参数       | 类型   | 描述                                              | 是否必填 |
| :--------- | :----- | :------------------------------------------------ | :------- |
| `group_id` | String | 群组 ID。                                         | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 查询参数

| 参数       | 类型   | 描述                                              | 是否必填 |
| :--------- | :----- | :------------------------------------------------ | :------- |
| `pagenum`  | Number | 当前页码。默认从第 1 页开始获取。          | 否       |
| `pagesize` | Number | 每页期望返回的群组成员数量。取值范围为[1,100]，默认值为 `10`。 | 否       |

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。   | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数     | 类型   | 描述                                       |
| :------- | :----- | :----------------------------------------- |
| `data`  | JSON Array | 获取的群组成员列表。    |
| `data.owner`  | String | 群主的用户 ID，例如 `{"owner":"user1"}`。    |
| `data.member` | String | 群成员的用户 ID，例如 `{"member":"user2"}`。 |
| `count` | Number | 获取的群成员数量。 |

其他字段及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

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

每次添加一个群成员。若添加的用户已是群成员，则添加失败，返回错误。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/users/{username}
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。 | 是       |
| `Accept`        | String | 内容类型。填入 `application/json`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。        | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数      | 类型    | 描述                                                               |
| :-------- | :------ | :----------------------------------------------------------------- |
| `data`  | JSON | 群成员添加结果。 |
| `data.result`  | Boolean | 群成员是否成功添加：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.groupid` | String  | 群组 ID。                                                          |
| `data.action`  | String  | 执行操作，`add_member` 表示添加群成员。                                                         |
| `data.user`    | String  | 添加到群组的用户 ID。                                            |

其他字段及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

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

一次为群组添加多个成员，每次最多可以添加 60 位成员。如果所有待添加的用户均已是群成员，则添加失败，返回错误。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/users
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。 | 是       |
| `Accept`        | String | 内容类型。填入 `application/json`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。   | 是     |

#### 请求 body

| 参数        | 类型  | 描述                      | 是否必填 |
| :---------- | :---- | :------------------------ | :------- |
| `usernames` | Array | 要添加为群组成员的用户 ID。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数         | 类型   | 描述                    |
| :----------- | :----- | :---------------------- |
| `data` | JSON  | 群成员添加信息。 |
| `data.newmembers` | Array  | 添加的群组成员的用户 ID。 |
| `data.groupid`    | String | 群组 ID。               |
| `data.action`     | String | 执行操作。在该响应中，该字段的值为 `add_member`，表示添加群成员。              |

其他字段及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

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

从群中移除指定成员。如果指定用户不在群组内，则该方法会返回错误。移除后，该成员也会被移除其在该群组中加入的子区。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/users/{username}
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。  | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数      | 类型    | 描述                                                               |
| :-------- | :------ | :----------------------------------------------------------------- |
| `data`  | JSON | 群成员移除信息。 |
| `data.result`  | Boolean | 群成员是否成功移除：<ul><li>`true`：是。</li><li>`false`：否。</li></ul> |
| `data.groupid` | String  | 群组 ID。                                                          |
| `data.action`  | String  | 执行操作。在该响应中，该字段的值为 `remove_member`，表示移除群组成员。   |
| `data.user`    | String  | 被移除的群成员的用户 ID。                                          |

其他参数及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

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

一次移除多名群成员。一次最多可移除 60 名群成员。移除后，这些成员也会被移除其在该群组中加入的子区。

如果指定的用户不在群组中，则会在响应 body 中返回错误。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/users/{memebers}
```

#### 路径参数

| 参数     | 类型   | 描述                                                           | 是否必填 |
| :------- | :----- | :------------------------------------------------------------- | :------- |
| group_id | String | 群组 ID。                                                      | 是       |
| members  | String | 要移除的群成员的用户 ID。一次最多可传入 60 个用户 ID，用英文逗号分隔，例如 `user1,user2`。并且，需确保请求 URL 的长度不超过 4 KB。 | 是 |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。  | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数      | 类型    | 描述                                                               |
| :-------- | :------ | :----------------------------------------------------------------- |
| `data`  | JSON Array | 群成员移除信息。 |
| `data.result`  | Boolean | 是否成功批量移除群成员：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.groupid` | String  | 群组 ID。                                                          |
| `data.reason`  | String  | 操作失败的原因。                                                   |
| `data.action`  | String  | 执行操作。在该响应中，该字段的值为 `remove_member`，表示移除群组成员。      |
| `data.user`    | String  | 被移除成员的用户 ID。                                          |

其他字段及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

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

## 获取群组管理员列表

获取群组管理员的列表。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/admin
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。    | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段即返回的群管理员的信息。其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

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

将一个普通群成员设为为群管理员。群管理员有管理黑名单、禁言等权限。最多可以添加 99 个群管理员。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/admin
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。 | 是       |
| `Accept`        | String | 内容类型。填入 `application/json`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。  | 是       |

#### 请求 body

| 参数       | 类型   | 描述                          | 是否必须 |
| :--------- | :----- | :---------------------------- | :------- |
| `newadmin` | String | 要添加的新管理员的用户 ID。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段    | 类型   | 描述                    |
| :----- | :----- | :---------------------- |
| `data` | JSON | 群管理员添加结果。 |
| `data.result` | String | 群管理员是否添加成功。 |
| `data.newadmin` | String   | 添加的管理员的用户 ID。 |

其他字段及说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-type: application/json' -H 'Accept: application/json' 'http://XXXX/XXXX/XXXX/chatgroups/10130212061185/admin' -d '{"newadmin":"user1"}' -H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "applicationName": "demo",
    "data": {
        "result": "success",
        "newadmin": "man"
    },
    "duration": 0,
    "entities": [],
    "organization": "XXXX",
    "properties": {},
    "timestamp": 1680074570600,
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/admin"
}
```

## 移除群管理员

将用户角色从群管理员降为群普通成员，即将群管理员移出群管理员列表。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/admin
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。  | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数       | 类型    | 描述                                                                           |
| :--------- | :------ | :----------------------------------------------------------------------------- |
| `data`   | JSON | 群管理员移除结果。 |
| `data.result`   | Boolean | 是否成功将该群管理员移出管理员列表：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.oldadmin` | String  | 被移除的管理员的用户 ID。           |

其他字段及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

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

将群主修改为该群组中的其他成员。群主拥有群组的所有权限。

### HTTP 请求

```http
PUT https://{host}/{org_name}/{app_name}/chatgroups/{group_id}
```

#### 路径参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他参数及描述详见[公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 描述                              | 是否必填 |
| :-------------- | :----- | :-------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。 | 是       |
| `Accept`        | String | 内容类型。填入 `application/json`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。  | 是       |

#### 请求 body

| 参数       | 类型   | 描述             | 是否必须 |
| :--------- | :----- | :--------------- | :------- |
| `data.newowner` | String | 新群主的用户 ID。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应包体中包含以下字段：

| 参数       | 类型    | 描述                                                            |
| :--------- | :------ | :-------------------------------------------------------------- |
| `data` | JSON | 群组转让结果。 |
| `data.newowner` | Boolean | 是否成功将指定用户设为群主：<ul><li>`true`：是</li><li>`false`：否</li></ul> |

其他字段及描述详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

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

详见  [HTTP 状态码](./agora_chat_status_code?platform=RESTful)。