管理群组成员是指对一个群组内的成员进行添加、移除等操作。Agora Chat 提供多个接口实现添加群成员、获取群成员、添加管理员、转让群主等功能。

本文展示如何调用 Agora 即时通讯 RESTful API 管理群组成员。调用以下方法前，请先参考[限制条件](./agora_chat_limitation)了解即时通讯 RESTful API 的调用频率限制。

<a name="pubparam"></a>
## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述                                                         | 是否必填 |
| :--------- | :----- | :----------------------------------------------------------- | :------- |
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
| `count`            | Number | 获取到的数组数量。                                       |
| `timestamp`          | Long  | 响应的 Unix 时间戳（毫秒）。                                 |
| `duration`           | Number  | 从发送请求到响应的时长（毫秒）。                             |

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

| 参数     | 类型   | 描述                                              | 是否必需 |
| :------- | :----- | :------------------------------------------------ | :------- |
| `group_id` | String | 群组 ID。                                         | 是       |
| `pagenum`  | Number | 分页页码，表示请求第几页上的成员列表。            | 否       |
| `pagesize` | Number | 每一页请求的成员数量。默认值为 10，最大值为 100。 | 否       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文：

| 参数   | 类型   | 描述                                     |
| :----- | :----- | :--------------------------------------- |
| `owner`  | String | 群主的用户 ID，如 `{"owner":"user1"}`。    |
| `member` | String | 群成员的用户 ID，如 `{"member":"user2"}`。 |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
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
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/users",
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

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求参数

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文：

| 参数    | 类型    | 描述                                              |
| :------ | :------ | :------------------------------------------------ |
| `result`  | Boolean | 是否成功将指定用户添加到黑名单：true：是false：否 |
| `groupid` | String  | 群组 ID。                                         |
| `action`  | String  | 执行操作。                                        |
| `user`    | String  | 被添加到群组的用户 ID。                           |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
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

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

#### 请求 body

| 参数      | 类型  | 描述                      | 是否必需 |
| :-------- | :---- | :------------------------ | :------- |
| `usernames` | Array | 待添加到群组中的成员 ID。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文：

| 参数       | 类型   | 描述                    |
| :--------- | :----- | :---------------------- |
| `newmembers` | Array  | 已添加进群组的成员 ID。 |
| `groupid`    | String | 群组 ID。               |
| `action`     | String | 执行操作。              |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
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

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文：

| 参数    | 类型    | 描述                                              |
| :------ | :------ | :------------------------------------------------ |
| `result`  | Boolean | 是否成功将指定用户添加到黑名单：true：是false：否 |
| `groupid` | String  | 群组 ID。                                         |
| `action`  | String  | 执行操作。                                        |
| `user`    | String  | 被从群组中移除的用户 ID。                         |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
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

```
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/users/{memebers}
```

#### 路径参数

| 参数     | 类型   | 描述                                                         | 是否必需 |
| :------- | :----- | :----------------------------------------------------------- | :------- |
| group_id | String | 群组 ID。                                                    | 是       |
| members  | String | 待移除的群组成员 ID，各 ID 之间用英文逗号分隔。如 user1, user2 | 是       |

其他路径参数说明详见公共参数。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文：

| 参数    | 类型    | 描述                                              |
| :------ | :------ | :------------------------------------------------ |
| 参数    | 类型    | 描述                                              |
| `result`  | Boolean | 是否成功将指定用户添加到黑名单：true：是false：否 |
| `groupid` | String  | 群组 ID。                                         |
| `reason`  | String  | 操作失败的原因。                                  |
| `action`  | String  | 执行操作。                                        |
| `user`    | String  | 被从群组中移除的用户 ID。                         |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
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

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| 参数          | 类型   | 描述                                                         | 是否必需 |
| `Content-Type`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段即返回的群管理员的信息。其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
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

将一个群成员角色权限提升为群管理员。群管理有管理黑名单、禁言等权限。最多可以添加 99 个群管理员。

### HTTP 请求

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/admin
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

#### 请求 body

| 参数     | 类型   | 描述                          | 是否必须 |
| :------- | :----- | :---------------------------- | :------- |
| `newadmin` | String | 待添加为新群管理员的用户 ID。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段即新的群管理员的用户 ID。其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
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

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文：

| 参数     | 类型    | 描述                                            |
| :------- | :------ | :---------------------------------------------- |
| `result`   | Boolean | 是否成功将指定用户移除管理员：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `oldadmin` | String  | 被移除的管理员 ID。                             |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
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

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

#### 请求 body

| 参数     | 类型   | 描述                | 是否必须 |
| :------- | :----- | :------------------ | :------- |
| `newowner` | String | 新群主的用户名。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文。

| 参数     | 类型    | 描述                                            |
| :------- | :------ | :---------------------------------------------- |
| `newowner` | Boolean | 是否成功将指定用户设为群主：<li>true：是</li><li>false：否</li> |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
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

<a name="code"></code>
## 状态码汇总表

| 状态码              | 描述                                                         |
| :------------------ | :----------------------------------------------------------- |
| 200                 | 请求成功。                                                   |
| 401                 | 鉴权失败。可能的原因是缺少 token、token 错误或 token 过期。请重新获取 token 后再试。 |
| 404                 | 群组 ID 不存在。                                             |
| 429，503 或其他 5xx | 调用频率超出上限，请暂停并稍后重试。如果你有更高调用频率需求，请联系技术支持。 |
| 500                 | 服务器内部错误，无法完成请求，请联系技术支持。