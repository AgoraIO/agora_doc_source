# 离线推送

本文展示如何调用即时通讯 RESTful API 设置消息推送显示昵称、推送通知方式及免打扰模式。

调用以下方法前，请先参考[限制条件](./agora_chat_limitation?platform=RESTful#服务端调用频率限制)了解即时通讯 IM 的 RESTful API 的调用频率限制。

## 前提条件

- 了解即时通讯 IM 的 RESTful API 调用频率限制，详见 [使用限制](./agora_chat_limitation)；
- 你已在 [Agora 控制台](https://console.agora.io/)中激活推送高级功能。高级功能激活后，你可以设置推送通知方式、免打扰模式和自定义推送模板。

<div class="alert note">关闭推送高级功能必须联系 <a href="mailto:support@agora.io">support@agora.io</a>，因为该操作会删除所有相关配置。</div>

## <a name="param"></a>公共参数

以下表格列举了即时通讯 IM 的 RESTful API 的公共请求参数、响应参数及描述：

### 请求参数

| 参数       | 类型   | 描述         | 是否必填 |
| :--------- | :----- | :--------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                         | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                    | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                           | 是       |
| `username` | String | 用户 ID，即用户的唯一登录账号。 | 是       |

### 响应参数

| 参数                 | 类型   | 描述                   |
| :------------------- | :----- | :-------------------------------- |
| `action`             | String | 请求方式。   |
| `organization`       | String | 即时通讯服务分配给每个企业（组织）的唯一标识。等同于 `org_name`。    |
| `application`        | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。      |
| `applicationName`    | String | 即时通讯服务分配给每个 app 的唯一标识。等同于 `app_name`。         |
| `uri`                | String | 请求 URL。            |
| `path`               | String | 请求路径，属于请求 URL 的一部分，无需关注。             |
| `entities`           | JSON   | 返回实体信息。                                           |
| `entities.uuid`      | String | 用户的 UUID。系统为该请求中的 app 或用户生成的唯一内部标识，用于生成 user token。              |
| `entities.type`      | String | 对象类型，无需关注。                                     |
| `entities.created`   | Number | 注册用户的 Unix 时间戳（毫秒）。                              |
| `entities.modified`  | Number | 最近一次修改用户信息的 Unix 时间戳（毫秒）。          |
| `entities.username`  | String | 用户 ID。用户登录的唯一账号。                       |
| `entities.activated` | Boolean   | 用户是否为活跃状态：<li>`true`：用户为活跃状态。<li>`false`：用户为封禁状态。如要使用已被封禁的用户账户，你需要调用[解禁用户](./agora_chat_restful_registration?platform=RESTful#解禁用户)解除封禁。 |
| `timestamp`          | Number | HTTP 响应的 Unix 时间戳（毫秒）。    |
| `duration`           | Number | 从发送 HTTP 请求到响应的时长（毫秒）。       |

### 认证方式

即时通讯服务 RESTful API 要求 HTTP 身份验证。每次发送 HTTP 请求时，必须在请求 header 填入如下`Authorization` 字段：

```http
Authorization: Bearer ${YourAppToken}
```

为了提高项目的安全性，Agora 使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯服务 RESTful API 仅支持使用 app 权限 token 对用户进行身份验证。详见[使用 App Token 进行身份验证](./agora_chat_token?platform=RESTful)。

## 设置消息推送显示昵称

设置消息推送时显示的用户昵称。

对于每个 App Key，此方法的调用频率限制与[用户账号管理接口](./agora_chat_restful_registration?platform=RESTful)一致。

### HTTP 请求

```http
PUT https://{host}/{org_name}/{app_name}/users/{username} 
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | 内容类型：`application/json`。| 是       |
| `Accept`  | String | 内容类型： `application/json`。| 是       |
| `Authorization` | String | 用户或管理员的认证 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 为固定字符，后面为一个英文空格和获取的 token 值。  | 是       |

#### 请求 body

请求包体为 JSON Object 类型，包含以下字段：

| 字段       | 类型   | 描述                                           | 是否必填 |
| :--------- | :----- | :--------------------------------------------- | :------- |
| `nickname` | String | 推送通知中显示的昵称。昵称的长度不能超过 100 个字符，支持以下字符集：<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>中文</li><li>特殊字符</li></ul><div class="alert note">该昵称可与用户配置文件中的昵称不同，但 Agora 建议你使用相同的昵称。因此，如果其中一个昵称更新时，应同时修改另一个。要更新用户配置文件中的昵称，详见[设置用户属性](./agora_chat_restful_user_attributes?platform=RESTful#设置用户属性)。</div> | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段                | 类型   | 描述                                           |
| :------------------ | :----- | :--------------------------------------------- |
| `entities.type`    | String  | 用户类型，即 `user`。              |
| `entities.nickname` | String | 推送通知中显示的昵称。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```json
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer YWMte3bGuOukEeiTkNP4grL7iwAAAAAAAAAAAAAAAAAAAAGL4CTw6XgR6LaXXVmNX4QCAgMAAAFnKdc-ZgBPGgBFTrLhhyK8woMEI005emtrLJFJV6aoxsZSioSIZkr5kw' -d '{    "nickname": "testuser"   }' 'http://a1.agora.com/agora-demo/testapp/users/user1'
```

#### 响应示例

```json
{  
  "action": "put",  
  "application": "8be024f0-e978-11e8-b697-5d598d5f8402",  
  "path": "/users",  
  "uri": "https://a1.agora.com/agora-demo/testapp/users",  
  "entities": [    
    {      
      "uuid": "4759aa70-eba5-11e8-925f-6fa0510823ba",      
      "type": "user",      
      "created": 1542595573399,      
      "modified": 1542596083687,      
      "username": "user1",      
      "activated": true,      
      "nickname": "testuser"    
      }  ],  
"timestamp": 1542596083685,  
"duration": 6,  
"organization": "agora-demo",  
"applicationName": "testapp"
}
```

## 设置离线推送通知的展示方式

设置离线推送通知在客户端的展示方式，设置即时生效。服务端据此向用户推送离线消息。 

对于每个 App Key，此方法的调用频率限制与[用户账号管理接口](./agora_chat_restful_registration?platform=RESTful)一致。

### HTTP 请求

```http
PUT https://{host}/{org_name}/{app_name}/users/{username}
```

#### 路径参数

路径参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型 | 描述                                                         | 是否必填 |
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Content-Type`   | String | 内容类型：`application/json`    | 是  |
| `Authorization` | String | 用户或管理员的认证 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 为固定字符，后面为一个英文空格和获取的 token 值。 | 是   |

#### 请求 body

| 参数                         | 类型 | 描述                                                         | 是否必填 |
| :--------------------------- | :--- | :----------------------------------------------------------- | :----- |
| `notification_display_style` | Number | 离线推送通知的展示方式：<ul><li>（默认）`0`：推送标题为“你有一条新消息”，推送内容为“请点击查看”；</li><li>`1`：推送标题为“你有一条新消息”，推送内容为发送人昵称和离线消息的内容。</li></ul> | 是   |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应 body 包含以下字段：

| 参数                         | 类型 | 描述                                                         |
| :--------------------------- | :--- | :----------------------------------------------------------- |
| `uuid`                       | String | 即时通讯服务为该请求中的用户生成的唯一内部标识符。               |
| `type`                       | String | 用户类型，即 “user”。                           |
| `created`                    | Number | 注册用户的 Unix 时间戳，单位为毫秒。                      |
| `modified`                   | Number | 最近一次修改用户信息的 Unix 时间戳，单位为毫秒。                   |
| `username`                   | String | 用户 ID。                                                  |
| `activated`                  | Boolean | 用户是否为活跃状态：<ul><li>`true`：用户为活跃状态。</li><li>`false`：用户为封禁状态。如要使用已被封禁的用户账户，你需要调用[解禁用户](./agora_chat_restful_registration?platform=RESTful#解禁用户)。<ul><li> |
| `notification_display_style` | String | 离线推送通知的展示方式。                                         |
| `nickname`                   | String | 推送通知中显示的昵称。                                       |
| `notifier_name`              | String | 推送证书的名称。                                           |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。您可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```bash
curl -X PUT -H "Authorization: Bearer YWMtSozP9jHNEeSQegV9EKeAQAAAUlmBR2bTGr-GP2xNh8GhUCdKViBFDSEF2E" -i  https://a1.agora.com/agora-demo/testapp/users/a -d '{"notification_display_style": "1"}'
```

#### 响应示例

```json
{  
  "action" : "put",  
  "application" : "17d59e50-0aee-11e8-8092-0dc80c0f5e99",  
  "path" : "/users",  
  "uri" : "https://a1.agora.com/agora-demo/testapp/users",  
  "entities" : [ 
    {    
      "uuid" : "3b8c9890-7b9a-11e8-9d88-f50bf55cafad",    
      "type" : "user",    
      "created" : 1530276298905,    
      "modified" : 1534407146060,   
      "username" : "user1",    
      "activated" : true,      
      "notification_display_style" : 1,    
      "nickname" : "testuser",    
      "notifier_name" : "2882303761517426801"  
      } ],  
"timestamp" : 1534407146058,  
"duration" : 3,  
"organization" : "1112171214115068",  
"applicationName" : "testapp"
}
```

## 设置推送通知

在应用和会话级别设置推送通知和免打扰模式。

对于每个 App Key，该方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
PUT https://{host}/{org}/{app}/users/{username}/notification/{chattype}/{key}
```

#### 路径参数

| 参数   | 类型 | 描述                                                         | 是否必填 |
| :----- | :--- | :----------------------------------------------------------- | :----- |
| `chattype` | String | 会话类型：<ul><li>`user`: 单聊</li><li>`chatgroup`: 群聊。</li></ul>     | 是   |
| `key`  | String | 会话标识符：<ul><li>如果 `type` 设置为 `user`，`key` 表示对端用户的用户 ID；</li><li>如果 `type` 设置为 `chatgroup`，`key` 则表示群组 ID。</li></ul> | 是   |

<div class="alert note"> 若在应用级别设置推送通知，你可以设置 `type` 为 `user` 和 `key` 当前用户的用户 ID。<div>

其他路径参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型 | 描述                                                         | 是否必填 |
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Content-Type`  | String | 内容类型。设置为 `application/json`。                     | 是   |
| `Authorization` | String | 用户或管理员的认证 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 为固定字符，后面跟英文空格和获取的 token。 | 是   |

#### 请求 body

| 参数             | 类型 | 描述                                                         | 是否必填 |
| :--------------- | :--- | :----------------------------------------------------------- | :----- |
| `type`           | String | 推送通知方式：<ul><li>`DEFAULT`：继承应用级别的设置；</li><li>`ALL`：接收所有离线消息的推送通知；</li><li>`AT`：仅接收提及消息的推送通知；</li><li>`NONE`：不接收离线消息的推送通知。</li></ul> | 否    |
| `ignoreInterval` | String | 离线推送免打扰时间段，精确到分钟，格式为 HH:MM-HH:MM，例如 08:30-10:00。该时间为 24 小时制，免打扰时间段的开始时间和结束时间中的小时数和分钟数的取值范围分别为 [00,23] 和 [00,59]。该参数仅在请求 header 的 `type` 设置为 `user` 和 `key` 设置为当前用户的用户 ID 时有效，即免打扰时间段仅针对 app 生效，对单聊或群聊会话不生效。<ul><li>开始时间和结束时间的设置立即生效，免打扰模式每天定时触发。例如，开始时间为 `08:00`，结束时间为 `10:00`，免打扰模式在每天的 8:00-10:00 内生效。若你在 11:00 设置开始时间为 `08:00`，结束时间为 `12:00`，则免打扰模式在当天的 11:00-12:00 生效，以后每天均在 8:00-12:00 生效。</li><li>若开始时间和结束时间相同，免打扰模式则全天生效。</li><li> 若结束时间早于开始时间，则免打扰模式在每天的开始时间到次日的结束时间内生效。例如，开始时间为 `10:00`，结束时间为 `08:00`，则免打扰模式的在当天的 10:00 到次日的 8:00 生效。</li><li>目前仅支持在每天的一个指定时间段内开启免打扰模式，不支持多个免打扰时间段，新的设置会覆盖之前的设置。</li><li>若不设置该参数，传空字符串。</li></ul> | 否     |
| `ignoreDuration` | Number | 免打扰时长（以毫秒为单位）。取值范围为 [0,604800000]，其中 `0 ` 表示该参数无效，`604800000` 表示免打扰模式持续 7 天。 | 否     |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 包含以下字段：

| 参数             | 类型 | 描述             |
| :--------------- | :--- | :--------------- |
| `type`           | String | 推送通知方式。   |
| `ignoreInterval` | String | 免打扰时间段。 |
| `ignoreDuration` | Number   | 免打扰时长。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，则请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```bash
curl -L -X PUT '{url}/{org_name}/{app_name}/users/{username}/notification/user/{key}' \
-H 'Authorization: Bearer {token}' \
-H 'Content-Type: application/json' \
--data-raw '{
    "type":"NONE",
    "ignoreInterval":"21:30-08:00",
    "ignoreDuration":86400000
}'
```

#### 响应示例

```json
{
    "path": "/users",
    "uri": "https://localhost/hx/hxdemo/users/notification/user/hxtest",
    "timestamp": 1647503749918,
    "organization": "hx",
    "application": "17fe201b-ad9b-4a3a-83df-1ed1ebd7b227",
    "action": "put",
    "data": {
        "type": "NONE",
        "ignoreDuration": 1647590149924,
        "ignoreInterval": "21:30-08:00"
    },
    "duration": 20,
    "applicationName": "hxdemo"
}
```

## 获取推送通知的设置

查询指定单聊、指定群聊或全局的离线推送设置。

对于每个 App Key，该方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
GET https://{host}/{org}/{app}/users/{username}/notification/{type}/{key}
```

#### 路径参数

| 参数   | 类型 | 描述                                                         | 是否必填 |
| :----- | :--- | :----------------------------------------------------------- | :----- |
| `type` | String | 会话类型：<ul><li>`user`: 单聊</li><li> `chatgroup`: 群聊</li></ul>          | 是   |
| `key`  | String | 会话标识：<ul><li>如果 `type` 设置为 `user`，`key` 表示对端用户的用户 ID；</li><li>如果 `type` 设置为 `chatgroup`，`key` 则表示群组 ID。</li></ul> | 是   |

其他路径参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型 | 描述                                                         | 是否必填 |
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Authorization` | String | 用户或管理员的认证 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 为固定字符，后跟英文空格和获取的 token。 | 是   |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应 body 包含以下字段：

| 参数             | 类型 | 描述             |
| :--------------- | :--- | :--------------- |
| `type`           | String | 推送通知方式。   |
| `ignoreInterval` | String | 免打扰时间段。 |
| `ignoreDuration` | Number  | 免打扰时长。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非`200`，表示请求失败。您可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```bash
curl -L -X GET '{url}/{org}/{app}/users/{username}/notification/chatgroup/{key}' \
-H 'Authorization: Bearer {token}' 
```

#### 响应示例

```json
{
    "path": "/users",
    "uri": "https://localhost/hx/hxdemo/users/notification/chatgroup/12312312321",
    "timestamp": 1647503749918,
    "organization": "hx",
    "application": "17fe201b-ad9b-4a3a-83df-1ed1ebd7b227",
    "action": "get",
    "data": {
        "type": "NONE",
        "ignoreDuration": 1647590149924,
        "ignoreInterval": "21:30-08:00"
    },
    "duration": 20,
    "applicationName": "hxdemo"
}
```

## 设置推送通知的首选语言

设置推送通知的首选语言。

对于每个 App Key，该方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
PUT https://{host}/{org}/{app}/users/{username}/notification/language
```

#### 路径参数

路径参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型 | 描述                                                         | 是否必填 |
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Content-Type`  | String | 内容类型。设置为 `application/json`。                     | 是   |
| `Authorization` | String | 用户或管理员的认证 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 为固定字符，后跟英文空格和获取的 token。 | 是   |

#### 请求 body

| 参数                  | 类型 | 描述                                                         | 是否必填 |
| :-------------------- | :--- | :----------------------------------------------------------- | :----- |
| `translationLanguage` | String | 用户接收的推送通知的首选语言的代码。如果设置为空字符串，则服务器直接推送原语言的通知。 | 是   |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 包含以下字段：

| 参数       | 类型 | 描述                                     |
| :--------- | :--- | :--------------------------------------- |
| `language` | String | 用户接收推送通知的首选语言的代码。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。您可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```bash
curl -L -X PUT '{url}/{org}/{app}/users/{username}/notification/language' \
-H 'Authorization: Bearer {token}' \
-H 'Content-Type: application/json' \
--data-raw '{
    "translationLanguage":"EU"
}'
```

#### 响应示例

```json
{
    "path": "/users",
    "uri": "https://localhost/hx/hxdemo/users/notification/language",
    "timestamp": 1648089630244,
    "organization": "hx",
    "application": "17fe201b-ad9b-4a3a-83df-1ed1ebd7b227",
    "action": "put",
    "data": {
        "language": "EU"
    },
    "duration": 66,
    "applicationName": "hxdemo"
}
```

## 获取推送通知的首选语言

获取推送通知的首选语言。

对于每个 App Key，该方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
GET https://{host}/{org}/{app}/users/{username}/notification/language
```

#### 路径参数

路径参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型 | 描述                                                         | 是否必填 |
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Content-Type`  | String | 内容类型。设置为 `application/json`。                     | 是   |
| `Authorization` | String | 用户或管理员的认证 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 为固定字符，后跟英文空格和获取的 token。 | 是   |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 包含以下字段：

| 参数       | 类型 | 描述                                     |
| :--------- | :--- | :--------------------------------------- |
| `language` | String | 用户接收推送通知的首选语言的代码。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。您可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```bash
curl -L -X GET '{url}/{org}/{app}/users/{username}/notification/language' \
-H 'Authorization: Bearer {token}'
```

#### 响应示例

```json
{
    "path": "/users",
    "uri": "https://localhost/hx/hxdemo/users/notification/language",
    "timestamp": 1648089630244,
    "organization": "hx",
    "application": "17fe201b-ad9b-4a3a-83df-1ed1ebd7b227",
    "action": "put",
    "data": {
        "language": "EU"
    },
    "duration": 66,
    "applicationName": "hxdemo"
}
```

## 创建推送模板

创建推送通知模板。

对于每个 App Key，该方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
POST https://{host}/{org}/{app}/notification/template
```

#### 路径参数

路径参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型 | 描述                                                         | 是否必填 |
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Content-Type`  | String | 内容类型。将其设置为 `application/json`。                     | 是   |
| `Authorization` | String | 用户或管理员的认证 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 为固定字符，后跟英文空格和获取的 token。 | 是   |

#### 请求 body

| 参数              | 类型 | 描述                                                         | 是否必填 |
| :---------------- | :--- | :----------------------------------------------------------- | :----- |
| `name`            | String | 推送模板的名称。                                             | 是   |
| `title_pattern`   | String | 推送模板的自定义标题。你可以在标题中添加变量，例如 {0}。     | 是   |
| `content_pattern` | String | 推送模板的自定义内容。你可以在内容中添加变量，例如 {0} 和 {1}。 | 是   |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 包含以下字段：

| 参数              | 类型 | 描述                                |
| :---------------- | :--- | :---------------------------------- |
| `name`            | String | 推送模板的名称。                    |
| `createAt`        | Number | 创建模板的 Unix 时间戳（毫秒）。     |
| `updateAt`        | Number | 最近一次修改模板的 Unix 时间戳（毫秒）。 |
| `title_pattern`   | String | 推送模板的自定义标题。              |
| `content_pattern` | String | 推送模板的自定义内容。              |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。您可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)解可能的原因。

### 示例

#### 请求示例

```bash
curl -X POST '{url}/{org}/{app}/notification/template' \
-H 'Authorization: Bearer {token}' \
-H 'Content-Type: application/json' \
--data-raw '{
    "name": "test7",
    "title_pattern": "Hello,{0}",
    "content_pattern": "Test,{0}"
}'
```

#### 响应示例

```json
{
    "uri": "https://localhost/hx/hxdemo/notification/template",
    "timestamp": 1646989584108,
    "organization": "hx",
    "application": "17fe201b-ad9b-4a3a-83df-1ed1ebd7b227",
    "action": "post",
    "data": {
        "name": "test7",
        "createAt": 1646989584124,
        "updateAt": 1646989584124,
        "title_pattern": "Hello,{0}",
        "content_pattern": "Test,{0}"
    },
    "duration": 26,
    "applicationName": "hxdemo"
}
```

## 获取推送模板

获取推送通知的指定模板。

对于每个 App Key，该方法的调用频率限制为每秒 100 次。

### HTTP 请求

```
GET https://{host}/{org}/{app}/notification/template/{name}
```

#### 路径参数

| 参数   | 类型 | 描述             | 是否必填 |
| :----- | :--- | :--------------- | :----- |
| `name` | String | 推送模板的名称。 | 是   |

其他路径参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型 | 描述                                                         | 是否必填 |
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Content-Type` | String | 内容类型：`application/json`    | 是 |
| `Authorization` | String | 用户或管理员的认证 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 为固定字符，后跟英文空格和获取的 token。 | 是   |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 包含以下字段：

| 参数              | 类型 | 描述                                |
| :---------------- | :--- | :---------------------------------- |
| `name`            | String | 推送模板的名称。                    |
| `createAt`        | Number | 创建模板时的 Unix 时间戳（毫秒）。     |
| `updateAt`        | Number | 上次修改模板时的 Unix 时间戳（毫秒）。 |
| `title_pattern`   | String | 推送模板的自定义标题。              |
| `content_pattern` | String | 推送模板的自定义内容。              |

其他其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码不是 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```bash
curl -X GET '{url}/{org}/{app}/notification/template/{name}' \
-H 'Authorization: Bearer {token}'  
```

#### 响应示例

```json
{
    "uri": "https://localhost/hx/hxdemo/notification/template/test7",
    "timestamp": 1646989686393,
    "organization": "hx",
    "application": "17fe201b-ad9b-4a3a-83df-1ed1ebd7b227",
    "action": "get",
    "data": {
        "name": "test7",
        "createAt": 1646989584124,
        "updateAt": 1646989584124,
        "title_pattern": "Hello,{0}",
        "content_pattern": "Test,{0}"
    },
    "duration": 11,
    "applicationName": "hxdemo"
}
```

## 删除推送模板

删除推送通知的指定模板。

对于每个 App Key，此方法的调用频率限制为每秒 100 次。

### HTTP 请求

```http
DELETE https://{host}/{org}/{app}/notification/template/{name}
```

#### 路径参数

| 参数   | 类型 | 描述             | 是否必填 |
| :----- | :--- | :--------------- | :----- |
| `name` | String | 要删除的推送模板的名称。 | 是   |

其他路径参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型 | 描述                                                         | 是否必填 |
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Content-Type` | String | 内容类型：`application/json`    | 是 |
| `Authorization` | String | 用户或管理员的认证 token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 为固定字符，后跟英文空格和获取的 token。 | 是   |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 包含以下字段：

| 参数              | 类型 | 描述                                |
| :---------------- | :--- | :---------------------------------- |
| `name`            | String | 推送模板的名称。                    |
| `createAt`        | Number | 创建模板时的 Unix 时间戳（毫秒）。     |
| `updateAt`        | Number | 上次修改模板时的 Unix 时间戳（毫秒）。 |
| `title_pattern`   | String | 推送模板的自定义标题。              |
| `content_pattern` | String | 推送模板的自定义内容。              |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```bash
curl -X DELETE '{url}/{org}/{app}/notification/template' \
-H 'Authorization: Bearer {token}' 
```

#### 响应示例

```json
{
    "uri": "https://localhost/hx/hxdemo/notification/template",
    "timestamp": 1646989686393,
    "organization": "hx",
    "application": "17fe201b-ad9b-4a3a-83df-1ed1ebd7b227",
    "action": "delete",
    "data": {
        "name": "test7",
        "createAt": 1646989584124,
        "updateAt": 1646989584124,
        "title_pattern": "Hello,{0}",
        "content_pattern": "Test,{0}"
    },
    "duration": 11,
    "applicationName": "hxdemo"
}
```

## 状态码

有关详细信息，请参阅[响应状态码](./agora_chat_status_code?platform=RESTful)。