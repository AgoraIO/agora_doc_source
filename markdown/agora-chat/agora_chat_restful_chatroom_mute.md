本文展示如何调用 Agora 即时通讯 RESTful API 实现聊天室禁言管理，包括添加、解除、查询聊天室中被禁言的成员。
调用以下方法前，请先参考[限制条件](./agora_chat_limitation?platform=RESTful#服务端调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

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

## 禁言聊天室成员

禁言指定的聊天室成员。被禁言后，该成员将无法在聊天室中发送消息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/mute
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

请求 body 为 JSON Object，包含以下字段：

| 字段            | 类型   | 描述                                                                                                                               | 是否必填 |
| :-------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `mute_duration` | long   | 从当前时间起算，禁言的时间长度。单位毫秒。`-1` 表示永久禁言。 | 是       |
| `usernames`     | String | 待被禁言的聊天室成员的用户名数组。                                                                                                 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型   | 描述                                                    |
| :------- | :----- | :------------------------------------------------------ |
| `result` | Bool   | 禁言结果：<li>`true：`禁言成功。<li>`false`：禁言失败。 |
| `expire` | Number | 禁言到期的 Unix 时间戳（毫秒）。                        |
| `user`   | String | 被禁言的聊天室成员的用户名。                            |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d
'{
    "usernames": [
        "user1",
        "user2"
    ],
    "mute_duration": 86400000
}''http://a1.easemob.com/easemob-demo/testapp/chatrooms/1265710621211/mute'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "22bcffa0-XXXX-XXXX-9df8-516f6df68c6d",
    "applicationName": "XXXX",
    "data": [
        {
            "result": true,
            "expire": 1642148173726,
            "user": "user1"
        },
        {
            "result": true,
            "expire": 1642148173726,
            "user": "user2"
        }
    ],
    "duration": 0,
    "entities": [],
    "organization": "XXXX",
    "timestamp": 1642060750410,
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/mute"
}
```

## 解除聊天室禁言成员

解除一个或多个聊天室成员的禁言。解除禁言后，该成员可以正常在聊天室中发送消息。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/mute/{member}
```

#### 路径参数

| 参数     | 类型   | 描述                                                                                                                                      | 是否必填 |
| :------- | :----- | :---------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `member` | String | 待被解除禁言的聊天室成员的用户名。<br>如果需要解除多个成员的禁言，则成员用户名之间用逗号（","）隔开。在 URL 中，需要将 "," 转义为 "%2C"。 | 是       |

其他参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept`        | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应 body 包含如下字段：

| 字段     | 类型   | 描述                                               |
| :------- | :----- | :------------------------------------------------- |
| `result` | Bool   | 移除禁言结果：`true`：解除成功;`false`：解除失败。 |
| `user`   | String | 被解除禁言的聊天室成员的用户名。                   |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'https://XXXX/XXXX/XXXX/chatrooms/XXXX/mute/XXXX'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/mute/XXXX",
    "entities": [],
    "data": [
        {
            "result": true,
            "user": "XXXX"
        }
    ],
    "timestamp": 1489072695859,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 查询聊天室禁言成员

查询指定聊天室的所有禁言用户列表。

```http
GET https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/mute
```

### HTTP 请求

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

| 字段     | 类型   | 描述                             |
| :------- | :----- | :------------------------------- |
| `expire` | Number | 禁言到期的 Unix 时间戳（毫秒）。 |
| `user`   | String | 被禁言的聊天室成员的用户名。     |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'https://XXXX/XXXX/XXXX/chatrooms/XXXX/mute'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/mute",
    "entities": [],
    "data": [
        {
            "expire": 1489158589481,
            "user": "user1"
        },
        {
            "expire": 1489158589481,
            "user": "user2"
        }
    ],
    "timestamp": 1489072802179,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```