本文展示如何调用即时通讯 RESTful API 实现聊天室管理，包括创建、删除、修改、查询聊天室。

调用本文中的 API 前，请先参考[使用限制](./agora_chat_limitation?platform=RESTful#服务端接口调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

<a name="param"></a>

## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数：

### 请求参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :-------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                   | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                  | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                            | 是       |
| `username` | String | 用户 ID。用户的唯一登录账号。 | 是       |

### 响应参数

| 参数              | 类型   | 描述                                                              |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action`          | String | 请求方式。                                                        |
| `organization`    | String | 即时通讯服务分配给每个企业（组织）的唯一标识，与请求参数 `org_name` 相同。 |
| `application`     | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。             |
| `applicationName` | String | 即时通讯服务分配给每个 app 的唯一标识。等同于 `app_name`。        |
| `uri`             | String | 请求 URL。                                                        |
| `entities`        | JSON   | 返回实体信息。                                                    |
| `data`            | JSON   | 返回数据详情。                                                    |
| `timestamp`       | Number   | HTTP 响应的 Unix 时间戳（毫秒）。                                 |
| `duration`        | Number | 从发送 HTTP 请求到响应的时长（毫秒）。                            |

## 认证方式

即时通讯服务 RESTful API 要求 HTTP 身份验证。每次发送 HTTP 请求时，必须在请求 header 填入如下 `Authorization` 字段：

```http
Authorization: Bearer YourAppToken
```

为了提高项目的安全性，声网使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯服务 RESTful API 仅支持使用 app 权限 token 对用户进行身份验证。详见[使用 App 权限 token 进行身份验证](./agora_chat_token?platform=RESTful)。

## 创建聊天室

创建一个聊天室，需设置聊天室名称、聊天室描述、聊天室成员最大人数（包括管理员）、聊天室管理员和普通成员以及聊天室扩展信息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。    | 是       |
| `Content-Type`  | String | 内容类型。填入 `application/json`。   | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。| 是       |

#### 请求 body

请求包体为 JSON Object 类型，包含以下字段：

| 字段          | 类型       | 描述                                     | 是否必填 |
| :------------ | :--------- | :--------------------------------------- | :------- |
| `name`        | String     | 聊天室名称，长度必须在 128 个字符内。    | 是       |
| `description` | String     | 聊天室描述，长度必须在 512 个字符内。    | 是       |
| `maxusers`    | Number        | 聊天室成员最大数量（包括聊天室创建者）。 | 否       |
| `owner`       | String     | 聊天室创建者的用户 ID。若传该参数，确保至少设置一个数组元素。                   | 是       |
| `members`     | JSON Array | 聊天室成员，不能设置为空。               | 否       |
| `custom`  | String | 聊天室自定义属性，例如可以给聊天室添加业务相关的标记，不能超过 1,024 个字符。  | 否  | 

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段 | 类型   | 描述                                                            |
| :--- | :----- | :-------------------------------------------------------------- |
| `data.id` | String | 创建的聊天室的 ID，即时通讯服务分配给每个聊天室的唯一标识符。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 请将 <YourAppToken> 替换为你在服务端生成的 app token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
   "name": "testchatroom1",
   "description": "test",
   "maxusers": 300,
   "owner": "user1",
   "members": [
     "user2"
   ]
 }' 'http://XXXX/XXXX/XXXX/chatrooms'
```

#### 响应示例

```json
{
    "data": {
        "id": "66213271109633"
    }
}
```

<a name="getall"></a>

## 查询所有聊天室基本信息

分页获取 app 下所有聊天室的信息。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatrooms?limit={N}&cursor={cursor}
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 查询参数

| 参数     | 类型   | 描述                   | 是否必填 |
| :------- | :----- | :------------------------ | :------- |
| `limit`  | Number | 每次期望获取的聊天室数量。取值范围为 [1,100]，默认值为 `10`。该参数仅在分页获取时为必需。   | 否  |
| `cursor` | String | 数据查询的起始位置。该参数仅在分页获取时为必需。 | 否  |

<div class="alert info"> 若请求中均未设置 limit 和 cursor，服务器返回聊天室列表的第一页中前 10 个聊天室。</div>

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。    | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应 body 包含如下字段：

| 字段                 | 类型   | 描述                                                  |
| :------------------- | :----- | :---------------------------------------------------- |
| `data.id`                 | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符。 |
| `data.name`               | String | 聊天室名称。                                          |
| `data.owner`              | String | 聊天室创建者的用户 ID。例如：{“owner”: “user1”}。                                |
| `data.affiliations_count` | Number    | 聊天室现有成员总数（包含聊天室创建者）。                  |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 请将 <YourAppToken> 替换为你在服务端生成的 app token

curl --location --request GET 'http://XXXX/XXXX/XXXX/chatrooms?limit=10' \
--header 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "action": "get",
    "application": "2a8f5b13-XXXX-XXXX-958a-838fd47f1223",
    "applicationName": "chatdemoui",
    "count": 3,
    "data": [
        {
            "affiliations_count": 1,
            "disabled": false,
            "id": "212126099636225",
            "name": "testchatroom1",
            "owner": "yifan1"
        },
        {
            "affiliations_count": 1,
            "disabled": false,
            "id": "212126098587649",
            "name": "testchatroom2",
            "owner": "yifan1"
        },
        {
            "affiliations_count": 1,
            "disabled": false,
            "id": "212126095441921",
            "name": "testchatroom3",
            "owner": "yifan1"
        }
    ],
    "duration": 1,
    "entities": [],
    "organization": "XXXX",
    "params": {
        "limit": [
            "5"
        ]
    },
    "properties": {},
    "timestamp": 1681697615739,
    "uri": "http://a1-hsb.easemob.com/easemob-demo/chatdemoui/chatrooms"
}
```

## 查询指定用户已加入的聊天室

查询指定用户已加入的聊天室。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/users/{username}/joined_chatrooms
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。    | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应 body 包含如下字段：

| 字段   | 类型   | 描述                                                             |
| :----- | :----- | :---------------------------------------------------------------- |
| `data.id`   | String | 该用户加入的聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符。 |
| `data.name` | String | 该用户加入的聊天室名称。                                          |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users/XXXX/joined_chatrooms'
```

#### 响应示例

```json
{
    "data": {
        "id": "66211860774913",
        "name": "test"
    }
}
```

## 查询指定聊天室详情

查询一个或多个聊天室详情。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}
```

#### 路径参数

| 参数          | 类型   | 描述                                                                                                                                                                                                                                               | 是否必填 |
| :------------ | :----- | :------------------------------------------------------------------- | :------- |
| `chatroom_id` | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符，从[查询所有聊天室基本信息](#getall)的响应 body 中获取。<ul><li>查询多个聊天室时，聊天室 ID 之间用逗号 "," 隔开。</li><li>一次请求最多查询 100 个聊天室。</li><li>在 URL 中，需要将逗号 "," 转义为 "%2C"。</li></ul> | 是       |

其他参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。   | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应 body 包含如下字段：

| 字段                 | 类型       | 描述          |
| :------------------- | :--------- | :-------------------------- |
| `data.id`                 | String     | 聊天室 ID。                                                                                                                                   |
| `data.name`               | String     | 聊天室名称。                                                                                                                                  |
| `data.description`        | String     | 聊天室描述。                                                                                                                                  |
| `data.membersonly`        | Boolean       | 加入聊天室是否需要聊天室创建者或管理员审批：<ul><li>`true`：是</li><li>`false`：否 </li></ul>                                                                    |
| `data.allowinvites`       | Boolean       | 是否允许聊天室成员邀请他人加入该聊天室：<ul><li>`true`：允许聊天室成员邀请他人加入该聊天室。</li><li>`false`：仅聊天室所有者和管理员能够邀请他人加入该聊天室。</li></ul> |
| `data.maxusers`           | Number        | 聊天室成员数量上限，创建聊天室时设置。                                                                                                                          |
| `data.owner`              | String     | 聊天室所有者的用户 ID。例如：{“owner”: “user1”}。                   |
| `data.created`            | Number     | 创建聊天室时间，Unix 时间戳，单位为毫秒。     |
| `data.custom`             | String     | 聊天室扩展信息，创建聊天室时为聊天室添加的自定义信息。                                                                                        |
| `data.affiliations_count` | Number       | 聊天室成员数量（包含聊天室创建者）。                                                                                                          |
| `data.affiliations`       | JSON Array | 聊天室成员数组，包含以下字段：<ul><li>`owner`： 聊天室创建者的用户 ID。</li><li>`member`：聊天室成员的用户 ID。</li></ul>                                          |
| `data.public`             | Boolean       | 预留字段，无需关注。       |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX%2CXXXX'
```

#### 响应示例

```json
{
    "action": "get",
    "application": "22bcffa0-XXXX-XXXX-9df8-516f6df68c6d",
    "applicationName": "XXXX",
    "count": 2,
    "data": [
        {
            "id": "XXXX",
            "name": "testchatroom1",
            "description": "test",
            "membersonly": false,
            "allowinvites": false,
            "maxusers": 1000,
            "created": 1641365888209,
            "custom": "",
            "affiliations_count": 2,
            "affiliations": [
                {
                    "member": "user1"
                },
                {
                    "owner": "user2"
                }
            ],
            "public": true
        },
        {
            "id": "XXXX",
            "name": "testchatroom2",
            "description": "test",
            "membersonly": false,
            "allowinvites": false,
            "invite_need_confirm": true,
            "maxusers": 10000,
            "created": 1641289021898,
            "custom": "",
            "mute": false,
            "scale": "large",
            "affiliations_count": 1,
            "affiliations": [
                {
                    "owner": "user3"
                }
            ],
            "public": true
        }
    ],
    "duration": 0,
    "entities": [],
    "organization": "XXXX",
    "timestamp": 1642064417048,
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX%2CXXXX"
}
```

## 修改聊天室信息

修改指定聊天室信息。仅支持修改聊天室名称、聊天室描述和聊天室最大成员数。

### HTTP 请求

```http
PUT https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}
```

#### 路径参数

| 参数          | 类型   | 描述                                                                                                          | 是否必填 |
| :------------ | :----- | :------------------------------------------------------------------------------------------------------------ | :------- |
| `chatroom_id` | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符，从[查询所有聊天室基本信息](#getall)的响应 body 中获取。 | 是       |

其他参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。    | 是       |
| `Accept`        | String | 内容类型。填入 `application/json`。    | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

#### 请求 body

请求包体为 JSON Object 类型，仅支持以下字段：

| 字段          | 类型   | 描述                                               | 是否必填 |
| :------------ | :----- | :------------------------------------------------- | :------- |
| `name`        | String | 聊天室名称。不能包含斜杠（"/"），用 "+" 代替空格。 | 否       |
| `description` | String | 聊天室描述。不能包含斜杠（"/"），用 "+" 代替空格。 | 否       |
| `maxusers`    | Number | 聊天室成员数量上限（包含聊天室创建者）。           | 否       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段          | 类型 | 描述                                                                                            |
| :------------ | :--- | :---------------------------------------------------------------------------------------------- |
| `data.groupname`   | Boolean | 聊天室名称是否修改成功：<li>`true`：是<li>`false`：否                           |
| `data.description` | Boolean | 聊天室描述是否修改成功：<li>`true`：是<li>`false`：否                         |
| `data.maxusers`    | Boolean | 聊天室成员最大数（包括聊天室创建者）是否修改成功：<li>`true`：是<li>`false`：否 |

如果返回的 HTTP 状态码非 `200`，表示请求失败，你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

> 如果在请求 body 中传入除 `name`、`description` 和 `maxusers` 以外的其他字段，则请求失败并返回错误码 `400`。

### 示例

#### 请求示例

```json
curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
   "name": "testchatroom",
   "description": "test",
   "maxusers": 300
 }' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX'
```

#### 响应示例

```json
{
    "data": {
        "description": true,
        "maxusers": true,
        "groupname": true
    }
}
```

## 删除聊天室

删除单个聊天室。如果要删除的聊天室不存在，会返回错误。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}
```

#### 路径参数

| 参数          | 类型   | 描述                                                                                                         | 是否必填 |
| :------------ | :----- | :----------------------------------------------------------------------------------------------------------- | :------- |
| `chatroom_id` | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符，从[查询所有聊天室基本信息](#getall)的响应 body 中获取。 | 是       |

其他参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | 内容类型。填入 `application/json`。    | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段      | 类型   | 描述                                                              |
| :-------- | :----- | :---------------------------------------------------------------- |
| `data.success` | Boolean   | 聊天室是否删除成功：<ul><li>`true`：是</li><li>`false`：否</li></ul> |
| `data.id`      | String | 被删除的聊天室 ID。                                             |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX",
    "entities": [],
    "data": {
        "success": true,
        "id": "66211860774913"
    },
    "timestamp": 1542545100474,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

### 获取聊天室公告

获取指定聊天室 ID 的聊天室公告。

#### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/announcement
```

##### 路径参数

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `chatroom_id` | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符，从[查询所有聊天室基本信息](#getall)的响应 body 中获取。 | 是       |

其他参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数            | 类型   | 是否必需 | 描述                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | 是       | 内容类型。填入 `application/json`。                          |
| `Accept`        | String | 是       | 内容类型。填入 `application/json`。                          |
| `Authorization` | String | 是       | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

在返回值中查看 data 字段包含的信息，获取到的聊天室公告信息。

| 参数                | 类型   | 说明             |
| :------------------ | :----- | :--------------- |
| `data.announcement` | String | 聊天室公告内容。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](http://docs-im-beta.easemob.com/document/server-side/error.html)了解可能的原因。

#### 示例

##### 请求示例

```shell
# 将 <YourToken> 替换为你在服务端生成的 App Token

curl -X GET -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' 'http://XXXX/XXXX/XXXX/chatrooms/12XXXX11/announcement'
```

##### 响应示例

```json
{
  "action": "get",
  "application": "52XXXXf0",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/12XXXX11/announcement",
  "entities": [],
  "data": {
    "announcement" : "XXXX."
  },
  "timestamp": 1542363546590,
  "duration": 0,
  "organization": "XXXX",
  "applicationName": "testapp"
}
```

### 修改聊天室公告

修改指定聊天室 ID 的聊天室公告。聊天室公告内容不能超过 512 个字符。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/announcement
```

##### 路径参数

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `chatroom_id` | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符，从[查询所有聊天室基本信息](#getall)的响应 body 中获取。 | 是       |

其他参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数            | 类型   | 是否必需 | 描述                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | 是       | 内容类型。填入 `application/json`。                          |
| `Accept`        | String | 是       | 内容类型。填入 `application/json`。                          |
| `Authorization` | String | 是       | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 |

##### 请求 body

| 字段           | 类型   | 是否必需 | 描述                 |
| :------------- | :----- | :------- | :------------------- |
| `announcement` | String | 是       | 修改后的聊天室公告。 |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段          | 类型   | 描述                                          |
| :------------ | :----- | :-------------------------------------------- |
| `data.id`     | String | 聊天室 ID。                                   |
| `data.result` | Boolean   | 聊天室公告是否修改成功：<ul><li>`true`：是</li><li>`false`：否</li></ul>|

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](http://docs-im-beta.easemob.com/document/server-side/error.html)了解可能的原因。

#### 示例

##### 请求示例

```shell
# 将 <YourToken> 替换为你在服务端生成的 App Token

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' 'http://XXXX/XXXX/XXXX/chatrooms/12XXXX11/announcement' -d '{"announcement" : "聊天室公告…"}'
```

##### 响应示例

```json
{
  "action": "post",
  "application": "52XXXXf0",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/12XXXX11/announcement",
  "entities": [],
  "data": {
    "id": "12XXXX11",
    "result": true
  },
  "timestamp": 1594808604236,
  "duration": 0,
  "organization": "XXXX",
  "applicationName": "testapp"
}
```

## 状态码

详见 [HTTP 状态码](./agora_chat_status_code?platform=RESTful)。