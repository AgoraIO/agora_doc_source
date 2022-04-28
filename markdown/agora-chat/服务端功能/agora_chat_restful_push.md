本文展示如何调用即时通讯 RESTful API 设置消息推送显示昵称、提醒方式及免打扰模式。
调用以下方法前，请先参考[限制条件](./agora_chat_limitation?platform=RESTful#服务端调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

## 前提条件

已在客户端实现消息推送功能。详见[实现消息推送](./agora_chat_push_android?platform=Android)。

## <a name="param"></a>公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数、响应参数及描述：

### 请求参数

| 参数       | 类型   | 描述                                                                                                                                                                                                                                                        | 是否必填 |
| :--------- | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                         | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                    | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                           | 是       |
| `username` | String | 用户名。用户的唯一登录账号。长度在 64 个字符内，不可设置为空。支持以下字符集：<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 0-9<li>"\_", "-", "."<div class="alert note"><ul><li>不区分大小写。<li>同一个 app 下，用户名唯一。</ul></div> | 是       |

### 响应参数

| 参数                 | 类型   | 描述                                                                                                                                                                                                    |
| :------------------- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `action`             | String | 请求方式。                                                                                                                                                                                              |
| `organization`       | String | 即时通讯服务分配给每个企业（组织）的唯一标识。等同于 `org_name`。                                                                                                                                       |
| `application`        | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。                                                                                                                                                   |
| `applicationName`    | String | 即时通讯服务分配给每个 app 的唯一标识。等同于 `app_name`。                                                                                                                                              |
| `uri`                | String | 请求 URL。                                                                                                                                                                                              |
| `path`               | String | 请求路径，属于请求 URL 的一部分，无需关注。                                                                                                                                                             |
| `entities`           | JSON   | 返回实体信息。                                                                                                                                                                                          |
| `entities.uuid`      | String | 用户的 UUID。系统为该请求中的 app 或用户生成的唯一内部标识，用于生成 user token。                                                                                                                       |
| `entities.type`      | String | 对象类型，无需关注。                                                                                                                                                                                    |
| `entities.created`   | Long | 注册用户的 Unix 时间戳（毫秒）。                                                                                                                                                                        |
| `entities.modified`  | Long | 最近一次修改用户信息的 Unix 时间戳（毫秒）。                                                                                                                                                            |
| `entities.username`  | String | 用户名。用户登录的唯一账号。                                                                                                                                                                            |
| `entities.activated` | Bool   | 用户是否为活跃状态：<li>`true`：用户为活跃状态。<li>`false`：用户为封禁状态。如要使用已被封禁的用户账户，你需要调用[解禁用户](./agora_chat_restful_reg?platform=RESTful#a-nameunbana解禁用户)解除封禁。 |
| `timestamp`          | Long | HTTP 响应的 Unix 时间戳（毫秒）。                                                                                                                                                                       |
| `duration`           | Number | 从发送 HTTP 请求到响应的时长（毫秒）。                                                                                                                                                                  |

### 认证方式

~e838c3b0-8e43-11ec-814c-17df6c7c3801~

## 修改消息推送显示昵称

设置消息推送时显示的用户昵称。

### HTTP 请求

```http
PUT https://api.agora.io/{org_name}/{app_name}/users/{username}
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

#### 请求 body

请求包体为 JSON Object 类型，包含以下字段：

| 字段       | 类型   | 描述                                           | 是否必填 |
| :--------- | :----- | :--------------------------------------------- | :------- |
| `nickname` | String | 推送消息时，在消息推送通知栏内显示的用户昵称。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段                | 类型   | 描述                                           |
| :------------------ | :----- | :--------------------------------------------- |
| `entities.nickname` | String | 推送消息时，在消息推送通知栏内显示的用户昵称。 |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d
'{
    "nickname": "testuser"
}' 'http://XXXX/XXXX/XXXX/users/XXXX'
```

#### 响应示例

```json
{
    "path": "/users",
    "uri": "http://XXXX/XXXX/XXXX/users/XXXX",
    "timestamp": 1642131819392,
    "organization": "XXXX",
    "application": "22bcffa0-XXXX-XXXX-9df8-516f6df68c6d",
    "entities": [
        {
            "uuid": "025571d0-XXXX-XXXX-83a3-89bf95652a8f",
            "type": "user",
            "created": 1589856848244,
            "modified": 1642131819467,
            "username": "user1",
            "activated": true,
            "nickname": "test"
        }
    ],
    "action": "put",
    "duration": 97,
    "applicationName": "testapp"
}
```

## 设置消息推送提醒方式

设置消息推送时的提醒方式。

### HTTP 请求

```http
PUT https://api.agora.io/{org_name}/{app_name}/users/{username}
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

#### 请求 body

请求包体为 JSON Object 类型，包含以下字段：

| 字段                         | 类型   | 描述                                                                                                   | 是否必填 |
| :--------------------------- | :----- | :----------------------------------------------------------------------------------------------------- | :------- |
| `notification_display_style` | Number | 消息提醒方式：<li>`0`：通知但不在消息通知栏中显示消息详情。<li>`1`：通知并在消息通知栏中显示消息详情。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段                                  | 类型   | 描述                                                                                                   |
| :------------------------------------ | :----- | :----------------------------------------------------------------------------------------------------- |
| `entities.notification_display_style` | Number | 消息提醒方式：<li>`0`：通知但不在消息通知栏中显示消息详情。<li>`1`：通知并在消息通知栏中显示消息详情。 |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 200，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X PUT -H "Authorization: Bearer <YourAppToken>" -i  https://XXXX/XXXX/XXXX/users/a -d
'{
    "notification_display_style": "1"
}'
```

#### 响应示例

```json
{
    "action": "put",
    "application": "17d59e50-XXXX-XXXX-8092-0dc80c0f5e99",
    "path": "/users",
    "uri": "https://XXXX/XXXX/XXXX/users",
    "entities": [
        {
            "uuid": "3b8c9890-XXXX-XXXX-9d88-f50bf55cafad",
            "type": "user",
            "created": 1530276298905,
            "modified": 1534407146060,
            "username": "user1",
            "activated": true,
            "notification_no_disturbing": false,
            "notification_no_disturbing_start": 1,
            "notification_no_disturbing_end": 3,
            "notification_display_style": 1,
            "nickname": "testuser",
            "notifier_name": "2882303761517426801"
        }
    ],
    "timestamp": 1534407146058,
    "duration": 3,
    "organization": "1112171214115068",
    "applicationName": "testapp"
}
```

## 设置消息推送免打扰

设置消息推送免打扰。在免打扰期间，用户不会收到离线消息推送。

### HTTP 请求

```http
PUT https://api.agora.io/{org_name}/{app_name}/users/{username}
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | `application/json`     | 是       |
| `Authorization` | String | Bearer ${YourAppToken} | 是       |

#### 请求 body

请求包体为 JSON Object 类型，包含以下字段：

| 字段                               | 类型   | 描述                                                                          | 是否必填 |
| :--------------------------------- | :----- | :---------------------------------------------------------------------------- | :------- |
| `notification_no_disturbing`       | Number | 是否开启免打扰：<li>`0`：关闭免打扰<li>`1`：开启免打扰                        | 是       |
| `notification_no_disturbing_start` | Number | 免打扰开始时间，UTC 时间，单位小时。<br>例如 “8” 代表每日 8:00 开启免打扰。   | 是       |
| `notification_no_disturbing_end`   | Number | 免打扰结束时间，UTC 时间，单位小时。<br>例如 “18” 代表每日 18:00 关闭免打扰。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段                                        | 类型   | 描述                                                                          |
| :------------------------------------------ | :----- | :---------------------------------------------------------------------------- |
| `entities.notification_display_style`       | Number | 免打扰是否开启：<li>`0`：免打扰关闭<li>`1`：免打扰开启                        |
| `entities.notification_no_disturbing_start` | Number | 免打扰开始时间，UTC 时间，单位小时。<br>例如 `8` 代表每日 8:00 开启免打扰。   |
| `entities.notification_no_disturbing_end`   | Number | 免打扰结束时间，UTC 时间，单位小时。<br>例如 `18` 代表每日 18:00 关闭免打扰。 |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

**设置免打扰开始时间和结束时间**

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X PUT -H "Authorization: Bearer <YourAppToken>" -i  "https://a1.agora.com/agora-demo/testapp/users/XXXX" -d
'{
    "notification_no_disturbing": 1,
    "notification_no_disturbing_start": "1",
    "notification_no_disturbing_end": "3"
}'
```

**取消免打扰**

```json
# 请将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X PUT -H "Authorization: Bearer <YourAppToken>" -i  "https://XXXX/XXXX/XXXX/users/XXXX" -d
'{
    "notification_no_disturbing": 0
}'
```

#### 响应示例

```json
{
    "action": "put",
    "application": "17d59e50-XXXX-XXXX-8092-0dc80c0f5e99",
    "path": "/users",
    "uri": "https://XXXX/XXXX/XXXX/users",
    "entities": [
        {
            "uuid": "3b8c9890-XXXX-XXXX-9d88-f50bf55cafad",
            "type": "user",
            "created": 1530276298905,
            "modified": 1534405429835,
            "username": "User1",
            "activated": true,
            "notification_no_disturbing": true,
            "notification_no_disturbing_start": 1,
            "notification_no_disturbing_end": 3,
            "notification_display_style": 0,
            "nickname": "test",
            "notifier_name": "2882303761517426801"
        }
    ],
    "timestamp": 1534405429833,
    "duration": 4,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```