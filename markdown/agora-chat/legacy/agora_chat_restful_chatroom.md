本文展示如何调用 Agora 即时通讯 RESTful API 实现聊天室管理，包括创建、删除、修改、查询聊天室。调用以下方法前，请先参考[限制条件](https://confluence.agoralab.co/pages/viewpage.action?pageId=857605065)了解即时通讯 RESTful API 的调用频率限制。

## <a name="param"></a>公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数：

### 请求参数

| 参数       | 类型   | 描述                                                                                                                                                                                                                                                        | 是否必填 |
| :--------- | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful)。                                                                                                              | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful)。                                                                                                         | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful)。                                                                                                                | 是       |
| `username` | String | 用户名。用户的唯一登录账号。长度在 64 个字符内，不可设置为空。支持以下字符集：<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 0-9<li>"\_", "-", "."<div class="alert note"><ul><li>不区分大小写。<li>同一个 app 下，用户名唯一。</ul></div> | 是       |

### 响应参数

| 参数              | 类型   | 描述                                                              |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action`          | String | 请求方式。                                                        |
| `organization`    | String | 即时通讯服务分配给每个企业（组织）的唯一标识。等同于 `org_name`。 |
| `application`     | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。             |
| `applicationName` | String | 即时通讯服务分配给每个 app 的唯一标识。等同于 `app_name`。        |
| `uri`             | String | 请求 URL。                                                        |
| `entities`        | JSON   | 返回实体信息。                                                    |
| `data`            | JSON   | 返回数据详情。                                                    |
| `timestamp`       | Long | HTTP 响应的 Unix 时间戳（毫秒）。                                 |
| `duration`        | Number | 从发送 HTTP 请求到响应的时长（毫秒）。                            |

## 认证方式

~e838c3b0-8e43-11ec-814c-17df6c7c3801~

## 创建聊天室

创建一个聊天室。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms
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

| 字段          | 类型       | 描述                                     | 是否必填 |
| :------------ | :--------- | :--------------------------------------- | :------- |
| `name`        | String     | 聊天室名称，长度必须在 128 个字符内。    | 是       |
| `description` | String     | 聊天室描述，长度必须在 512 个字符内。    | 是       |
| `maxusers`    | Int        | 聊天室成员最大数量（包括聊天室创建者）。 | 否       |
| `owner`       | String     | 聊天室创建者的用户名。                   | 是       |
| `members`     | JSON Array | 聊天室成员，不能设置为空。               | 否       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段 | 类型   | 描述                                                            |
| :--- | :----- | :-------------------------------------------------------------- |
| `id` | String | 本次创建的聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符。 |

其他字段及说明详见[公共参数](#param)。

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

## <a name="getall"></a>查询所有聊天室基本信息

查询 app 下所有的聊天室信息。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/chatrooms
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

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应 body 包含如下字段：

| 字段                 | 类型   | 描述                                                  |
| :------------------- | :----- | :---------------------------------------------------- |
| `id`                 | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符。 |
| `name`               | String | 聊天室名称。                                          |
| `owner`              | String | 聊天室创建者的用户名。                                |
| `affiliations_count` | Int    | 聊天室成员数量（包含聊天室创建者）。                  |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 请将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms'
```

#### 响应示例

```json
{
    "data": {
        "id": "66211860774913",
        "name": "test",
        "owner": "user1",
        "affiliations_count": 2
    }
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
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应 body 包含如下字段：

| 字段   | 类型   | 说明                                                              |
| :----- | :----- | :---------------------------------------------------------------- |
| `id`   | String | 该用户加入的聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符。 |
| `name` | String | 该用户加入的聊天室名称。                                          |

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

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
GET https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}
```

#### 路径参数

| 参数          | 类型   | 描述                                                                                                                                                                                                                                               | 是否必填 |
| :------------ | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `chatroom_id` | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符，从[查询所有聊天室基本信息](#getall) 的响应 body 中获取。<li>查询多个聊天室时，将每个 `chatroom_id` 用 "," 隔开。，<li>一次请求最多查询 100 个聊天室。<li>在 URL 中，需要将 "," 转义为 "%2C"。 | 是       |

其他参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应 body 包含如下字段：

| 字段                 | 类型       | 描述                                                                                                                                          |
| :------------------- | :--------- | :-------------------------------------------------------------------------------------------------------------------------------------------- |
| `id`                 | String     | 聊天室 ID。                                                                                                                                   |
| `name`               | String     | 聊天室名称。                                                                                                                                  |
| `description`        | String     | 聊天室描述。                                                                                                                                  |
| `membersonly`        | Bool       | 加入聊天室是否需要聊天室创建者或管理员审批：<li>`true`：是<li>`false`：否                                                                     |
| `allowinvites`       | Bool       | 是否允许聊天室成员邀请他人加入该聊天室：<li>`true`：允许聊天室成员邀请他人加入该聊天室。<li>`false`：仅聊天室管理员能够邀请他人加入该聊天室。 |
| `maxusers`           | Int        | 聊天室成员数量上限。                                                                                                                          |
| `owner`              | String     | 聊天室创建者的用户名。                                                                                                                        |
| `created`            | Number     | 创建聊天室的 Unix 时间戳（毫秒）。                                                                                                            |
| `custom`             | String     | 聊天室附加信息，创建聊天室时为聊天室添加的自定义信息。                                                                                        |
| `affiliations_count` | int        | 聊天室成员数量（包含聊天室创建者）。                                                                                                          |
| `affiliations`       | JSON Array | 聊天室成员数组，包含以下字段：<li>`owner`： 聊天室创建者的用户名。<li>`member`：聊天室成员的用户名。                                          |
| `public`             | Bool       | 预留字段，无需关注。                                                                                                                          |

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

修改指定聊天室信息。仅支持修改 `name`、`description`、`maxusers。`

### HTTP 请求

```http
PUT https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}
```

#### 路径参数

| 参数          | 类型   | 描述                                                                                                          | 是否必填 |
| :------------ | :----- | :------------------------------------------------------------------------------------------------------------ | :------- |
| `chatroom_id` | String | 聊天室 ID，即时通讯服务分配给每个聊天室的唯一标识符，从[查询所有聊天室基本信息](#getall) 的响应 body 中获取。 | 是       |

其他参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | `application/json`     | 是       |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

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
| `groupname`   | Bool | 聊天室名称是否修改成功：<li>`true`：修改成功。<li>`false`：修改失败。                           |
| `description` | Bool | 聊天室描述是否修改成功：<li>`true`：修改成功。<li>`false`：修改失败。                           |
| `maxusers`    | Bool | 聊天室成员最大数（包括聊天室创建者）是否修改成功：<li>`true`：修改成功。<li>`false`：修改失败。 |

如果返回的 HTTP 状态码非 `200`，表示请求失败，你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

> 如果在请求 body 中传入除 `name`、`description`、`maxusers` 以外的其他字段，则请求失败并返回错误码 `400`。

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

删除单个聊天室。如果被删除的聊天室不存在，会返回错误。

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
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段      | 类型   | 描述                                                              |
| :-------- | :----- | :---------------------------------------------------------------- |
| `success` | Bool   | 聊天室是否删除成功：<li>`true`：删除成功。<li>`false`：删除失败。 |
| `id`      | String | 已被删除的聊天室 ID。                                             |

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