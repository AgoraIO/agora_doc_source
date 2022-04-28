在即时通讯应用中，仅聊天室超级管理员具有在客户端创建聊天室的权限。
本文展示如何调用 Agora 即时通讯 RESTful API 实现聊天室超级管理员管理，包括添加、删除、查询聊天室超级管理员。调用以下方法前，请先参考[限制条件](./agora_chat_limitation?platform=RESTful#服务端调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

## <a name="param"></a>公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数：

### 请求参数


| 参数 | 类型 | 描述 | 是否必填 |
| :---------------- | :----- | :---------------------------------------------------------------- | :---------------------------------------------------------------- |
| `host` | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful)。 | 是 |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful)。 | 是 |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful)。 | 是 |
| `username` | String | 用户名。用户的唯一登录账号。长度在 64 个字符内，不可设置为空。支持以下字符集：<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 0-9<li>"\_", "-", "."<div class="alert note"><ul><li>不区分大小写。<li>同一个 app 下，用户名唯一。</ul></div> | 是 |
| `chatroom_id` | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符，从[查询所有聊天室基本信息](./agora_chat_restful_chatroom%20?platform=RESTful#a-namegetalla查询所有聊天室基本信息) 的响应 body 中获取。 | 是 |

### 响应参数

| 参数              | 类型   | 描述                                                              |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action`          | String | 请求方式。                                                        |
| `organization`    | String | 即时通讯服务分配给每个企业（组织）的唯一标识。等同于 `org_name`。 |
| `application`     | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。             |
| `applicationName` | String | 即时通讯服务分配给每个 app 的唯一标识。等同于 `app_name`。        |
| `uri`             | String | 请求 URL。                                                        |
| `path`            | String | 请求路径，属于请求 URL 的一部分，无需关注。                       |
| `entities`        | JSON   | 返回实体信息。                                                    |
| `data`            | JSON   | 返回数据详情。                                                    |
| `timestamp`       | Long | HTTP 响应的 Unix 时间戳（毫秒）。                                 |
| `duration`        | Number | 从发送 HTTP 请求到响应的时长（毫秒）。                            |

## 认证方式

~e838c3b0-8e43-11ec-814c-17df6c7c3801~
	
## 添加聊天室超级管理员

添加一个超级管理员。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/super_admin
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | `application/json`     | 是       |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

#### 请求 body

请求包体为 JSON Object 类型，包含以下字段：

| 字段         | 类型   | 描述                               | 是否必填 |
| :----------- | :----- | :--------------------------------- | :------- |
| `superadmin` | String | 待添加为聊天室超级管理员的用户名。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型   | 描述                                                    |
| :--------- | :----- | :------------------------------------------------------ |
| `result`   | Bool   | 添加结果：<li>`true`：添加成功。<li>`false`：添加失败。 |
| `resource` | String | 预留参数，无需关注。                                    |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
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

撤销指定用户的聊天室超级管理员角色，使之成为普通聊天室成员。

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/super_admin/{superAdmin}
```

### HTTP 请求

#### 路径参数

| 参数         | 类型   | 描述                                 | 是否必填 |
| :----------- | :----- | :----------------------------------- | :------- |
| `superAdmin` | String | 待被撤销的聊天室超级管理员的用户名。 | 是       |

其他参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段            | 类型   | 描述                             |
| :-------------- | :----- | :------------------------------- |
| `newSuperAdmin` | String | 被撤销的聊天室超级管理员用户名。 |
| `resource`      | String | 预留参数，无需关注。             |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
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

查询指定页码的聊天室超级管理员列表。

### HTTP 请求

```http
GET https://{host} /{org_name}/{app_name}/chatrooms/super_admin?pagenum={N}&pagesize={N}
```

#### 路径参数

| 参数       | 类型 | 描述                                    | 是否必填 |
| :--------- | :--- | :-------------------------------------- | :------- |
| `pagenum`  | Int  | 查询页码。默认值为 1。                  | 否       |
| `pagesize` | Int  | 每页显示的超级管理员数量。默认值为 10。 | 否       |

其他参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 参数       | 类型       | 说明                             |
| :--------- | :--------- | :------------------------------- |
| `pagenum`  | Int        | 当前页码。                       |
| `pagesize` | Int        | 当前页显示的超级管理员最大数量。 |
| `data`     | JSON Array | 聊天室超级管理员的用户名数组。   |
| `count`    | Number     | 返回超级管理员数量。             |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
curl -X GET http://XXXX/XXXX/XXXX/chatrooms/super_admin?pagenum=2&pagesize=2 -H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "action": "get",
    "application": "9fa492a0-XXXX-XXXX-b1b9-a76b05da6904",
    "params": {
        "pagesize": ["2"],
        "pagenum": ["2"]
    },
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/super_admin",
    "entities": [],
    "data": ["hxtest1", "hxtest11", "hxtest10"],
    "timestamp": 1596187292391,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX",
    "count": 3
}
```