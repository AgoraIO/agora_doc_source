在即时通讯应用中，仅聊天室超级管理员具有在客户端创建聊天室的权限。

本文展示如何调用即时通讯 RESTful API 实现聊天室超级管理员管理，包括添加、删除、查询聊天室超级管理员。调用本文中的 API 前，请先参考[使用限制](./agora_chat_limitation?platform=RESTful#服务端接口调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

<a name="param"></a>

## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数：

### 请求参数

| 参数          | 类型   | 描述     | 是否必填 |
| :------------ | :----- | :------------------------------------------ | :------- |
| `host`        | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。         | 是       |
| `org_name`    | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                      | 是       |
| `app_name`    | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。       | 是       |
| `username`    | String | 用户 ID。用户的唯一登录账号。| 是       |
| `chatroom_id` | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符，从[查询所有聊天室基本信息](./agora_chat_restful_chatroom%20?platform=RESTful#a-namegetalla查询所有聊天室基本信息)的响应 body 中获取。         | 是       |

### 响应参数

| 参数              | 类型   | 描述            |
| :---------------- | :----- | :-------------------------------- |
| `action`          | String | 请求方式。                                                        |
| `organization`    | String | 即时通讯服务分配给每个企业（组织）的唯一标识，与请求参数 `org_name` 相同。 |
| `application`     | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。             |
| `applicationName` | String | 即时通讯服务分配给每个 app 的唯一标识，与请求参数 `app_name` 相同。        |
| `uri`             | String | 请求 URL。                                                        |
| `path`            | String | 请求路径，属于请求 URL 的一部分，无需关注。                       |
| `entities`        | JSON   | 返回实体信息。                                                    |
| `data`            | JSON   | 返回数据详情。                                                    |
| `timestamp`       | Number   | HTTP 响应的 Unix 时间戳（毫秒）。                                 |
| `duration`        | Number | 从发送 HTTP 请求到响应的时长（毫秒）。                            |

## 认证方式

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

## 添加聊天室超级管理员

添加一个超级管理员。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/super_admin
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。    | 是       |
| `Accept`        | String | 内容类型。填入 `application/json`。    | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

#### 请求 body

请求包体为 JSON Object 类型，包含以下字段：

| 字段         | 类型   | 描述                               | 是否必填 |
| :----------- | :----- | :--------------------------------- | :------- |
| `superadmin` | String | 待添加为聊天室超级管理员的用户 ID，每次只能添加一个。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型   | 描述                                                    |
| :--------- | :----- | :------------------------------------------------------ |
| `data.result`   | Boolean   | 是否成功添加聊天室超级管理员：<ul><li>`true`：是。</li><li>`false`：否。</li></ul> |
| `data.resource` | String | 预留参数，无需关注。                                    |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>'-d
'{
   "superadmin": user1
 }''http://XXXX/XXXX/XXXX/chatrooms/super_admin'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "9fa492a0-XXXX-XXXX-b1b9-a76b05da6904",
    "uri": "https://XXXX/XXXX/XXXX/chatrooms/super_admin",
    "entities": [],
    "data": {
        "result": "success",
        "resource": ""
    },
    "timestamp": 1596187658017,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 撤销聊天室超级管理员

撤销指定用户的聊天室超级管理员角色，使之成为普通聊天室成员，将不能再创建聊天室。

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/super_admin/{superAdmin}
```

### HTTP 请求

#### 路径参数

| 参数         | 类型   | 描述                                 | 是否必填 |
| :----------- | :----- | :----------------------------------- | :------- |
| `superAdmin` | String | 待被撤销的聊天室超级管理员的用户 ID。 | 是       |

其他参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。    | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段            | 类型   | 描述                             |
| :-------------- | :----- | :------------------------------- |
| `data.newSuperAdmin` | String | 被撤销的聊天室超级管理员用户 ID。 |
| `data.resource`      | String | 预留参数，无需关注。             |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/super_admin/XXXX'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "9fa492a0-XXXX-XXXX-b1b9-a76b05da6904",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/super_admin/XXXX",
    "entities": [],
    "data": {
        "newSuperAdmin": "XXXX",
        "resource": ""
    },
    "timestamp": 1596187855832,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 分页查询聊天室超级管理员

分页查询聊天室超级管理员列表。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatrooms/super_admin?pagenum={N}&pagesize={N}
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 查询参数

| 参数       | 类型 | 描述                                    | 是否必填 |
| :--------- | :--- | :-------------------------------------- | :------- |
| `pagenum`  | Number  | 查询页码。默认值为 `1`。                  | 否       |
| `pagesize` | Number  | 每页显示的超级管理员数量。默认值为 `10`。 | 否       |

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。    | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 参数       | 类型       | 描述                           |
| :--------- | :--------- | :------------------------------- |
| `data`     | JSON Array | 聊天室超级管理员的用户 ID 数组。   |
| `count`    | Number     | 超级聊天室管理员的数量。             |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X GET http://XXXX/XXXX/XXXX/chatrooms/super_admin?pagenum=2&pagesize=2 -H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
 {
    "action": "get",
    "application": "2a8f5b13-XXXX-XXXX-958a-838fd47f1223",
    "applicationName": "XXXX",
    "count": 3,
    "data": [
        "yifan4",
        "yifan3",
        "yifan2"
    ],
    "duration": 0,
    "entities": [],
    "organization": "XXXX",
    "properties": {},
    "timestamp": 1681698118068,
    "uri": "http://a1-hsb.easemob.com/easemob-demo/chatdemoui/chatrooms/super_admin"
}
```

## 状态码

详见 [HTTP 状态码](./agora_chat_status_code?platform=RESTful)。