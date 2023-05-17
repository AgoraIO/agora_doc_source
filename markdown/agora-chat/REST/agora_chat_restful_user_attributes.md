用户属性指为用户添加的标签信息，包含属性名和属性值。

用户属性指实时消息互动用户的信息，如用户昵称、头像、邮箱、电话、性别、签名、生日等。

例如，在招聘场景下，利用用户属性功能，可以存储性别、邮箱、用户类型（面试者）、职位类型（Web 研发）等。当查看用户信息时，可以直接查询服务器存储的用户属性信息。

<div class="alert note">为保证用户信息安全，即时通讯 IM 仅支持用户本人或 app 管理员设置用户属性。</div>

调用本文中的 API 前，请先参考[使用限制](./agora_chat_limitation?platform=RESTful#服务端接口调用频率限制)了解即时通讯 RESTful API 的调用频率限制。

<a name="param"></a>

## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数：

### 请求参数

| 参数       | 类型   | 描述      | 是否必填 |
| :--------- | :----- | :------------------------------------------------ | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                                              | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                                         | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                                               | 是       |
| `username` | String | 用户 ID。用户的唯一登录账号。长度在 64 个字符内，不可设置为空。支持以下字符集：<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 0-9<li>"_", "-", "."<div class="alert note"><ul><li>不区分大小写。</li><li>同一个 app 下，用户 ID唯一。</li></ul></div> | 是       |

### 响应参数

| 参数              | 类型   | 描述                                                              |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action`          | String | 请求方式。                                                        |
| `organization`    | String | 即时通讯服务分配给每个企业（组织）的唯一标识，与请求参数 `org_name` 相同。 |
| `application`     | String | 即时通讯服务分配给每个 app 的唯一内部标识，无需关注。             |
| `applicationName` | String | 即时通讯服务分配给每个 app 的唯一标识，与请求参数 `app_name` 相同。        |
| `username`        | String | 用户 ID。                                                    |
| `entities`        | Object | 响应实体。                                                   |
| `data.nickname`   | String | 用户昵称。                                                   |
| `data.ext`        | String | 自定义的用户属性扩展字段。                                   |
| `data.avatarurl`  | String | 用户头像 URL。                                               |
| `timestamp`       | Number   | Unix 时间戳，单位为毫秒。                                    |
| `duration`        | Number   | 从发送 HTTP 请求到响应的时长, 单位为毫秒。                   |

## 认证方式

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

## 设置用户属性

用户属性由多个属性名和属性值的键值对组成，每个属性名有且仅有一个对应的属性值。

<div class="alert info">一个用户的属性总长度不得超过 2 KB，一个 app 下所有用户的属性总长度不得超过 10 GB。</div>

### HTTP 请求

```http
PUT https://{host}/{org_name}/{app_name}/metadata/user/{username}
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                                | 是否必填 |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type`  | String | 内容类型，请填 `application/x-www-form-urlencoded`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。   | 是       |

#### 请求 body

请求 body 为 `x-www-form-urlencoded` 类型，发送请求时数据类型为 JSON String，长度不得超过 4 KB，包含以下字段：

| 字段    | 类型   | 描述   | 是否必填 |
| :------ | :----- | :----- | :------- |
| `Key`   | String | 属性名 | 是       |
| `Value` | String | 属性值 | 是       |

例如:

requestBody = ‘name=ken&employer=easemob&title=developer’

JSONString = ‘{“name”:“ken”, “employer”:“easemob”, “title”:“developer”}’

这个 JSON String 的总长度不得超过 4 KB。

调用该 RESTful 接口设置用户昵称、头像、联系方式、邮箱、性别、签名、生日和扩展字段时，若要确保在客户端能够获取设置，请求中必须传以下键名，根据实际使用场景确定键值：

| 字段        | 类型   | 描述                                                         |
| :---------- | :----- | :----------------------------------------------------------- |
| `nickname`  | String | 用户昵称。长度在 64 个字符内。                                 |
| `avatarurl` | String | 用户头像 URL 地址。长度在 256 个字符内。                       |
| `phone`     | String | 用户联系方式。长度在 32 个字符内。                             |
| `mail`      | String | 用户邮箱。长度在 64 个字符内。                                 |
| `gender`    | Number | 用户性别：<ul><li>`1`：男；</li><li>`2`：女；</li><li>（默认）`0`：未知；</li><li>设置为其他值无效。</li></ul> |
| `sign`      | String | 用户签名。长度在 256 个字符内。                                 |
| `birth`     | String | 用户生日。长度在 64 个字符内。                                 |
| `ext`       | String | 扩展字段。                                                   |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 中包含以下字段：

| 字段   | 类型 | 描述                                                   |
| :----- | :--- | :----------------------------------------------------- |
| `data` | JSON | 返回数据详情。包含你在本次请求中设置的用户属性键值对。 |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

本示例中使用的用户属性名为 `avatarurl`、`ext` 和 `nickname`，你可以根据实际业务场景自定义用户属性。

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X PUT -H 'Content-Type: application/x-www-form-urlencoded' -H 'Authorization: Bearer <YourAppToken>' -d 'avatarurl=http://www.agorachat.com/avatar.png&ext=ext&nickname=nickname' 'http://XXXX/XXXX/XXXX/metadata/user/XXXX'
```

#### 响应示例

```json
{
    "timestamp": 1620445147011,
    "data": {
        "ext": "ext",
        "nickname": "nickname",
        "avatarurl": "http://XXXX.png"
    },
    "duration": 166
}
```

## 获取用户属性

获取指定用户的全部用户属性键值对。需要在请求中填写 {username}，指定获取用户属性的用户 ID。

如果指定的用户或用户属性不存在，返回空数据 {}。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/metadata/user/{username}
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                                | 是否必填 |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。 | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。            | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 中包含以下字段：

| 参数   | 类型 | 描述                |
| :----- | :--- | :---------------------------------------- |
| `data` | JSON | 返回数据详情。包含该用户所有用户属性键值对。<br/>如果 `data` 为空，请确认用户 ID 是否存在或该用户是否有用户属性。 |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X GET -H 'Authorization: Bearer <YourAppToken>' -H 'Content-Type:  application/json''http://XXXX/XXXX/XXXX/metadata/user/XXXX'
```

#### 响应示例

```json
{
    "timestamp": 1620445147011,
    "data": {
        "ext": "ext",
        "nickname": "nickname",
        "avatarurl": "http://XXXX.png"
    },
    "duration": 166
}
```

## 批量获取用户属性

根据指定的用户 ID 列表和属性列表查询用户属性。

如果指定的用户或用户属性不存在，返回空数据 {}。每次最多指定 100 个用户。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/metadata/user/get
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。     | 是       |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

#### 请求 body

请求 body 为 JSON Object 类型，包含以下字段：

| 参数         | 类型       | 描述                                        | 是否必填 |
| :----------- | :--------- | :------------------------------------------ | :------- |
| `targets`    | Array | 待查询的用户 ID 列表，最多包含 100 个用户 ID。 | 是       |
| `properties` | Array | 待查询的属性名列表。查询结果只返回该列表中包含的属性，不在该列表中的属性将被忽略。   | 是   |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 中包含以下字段：

| 参数   | 类型 | 描述                                         |
| :----- | :--- | :----------------------------------------------------------- |
| `data` | JSON | 返回数据详情。包含该用户所有用户属性键值对。<br/>如果 `data` 为空，请确认用户 ID 是否存在或用户是否有用户属性。 |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app token
curl -X POST -H 'Authorization: Bearer <YourAppToken>' -H 'Content-Type:  application/json' -d '{
  "properties": [
    "avatarurl",
    "ext",
    "nickname"
  ],
  "targets": [
    "user1",
    "user2",
    "user3"
  ]
}' 'http://XXXX/XXXX/XXXX/metadata/user/get'
```

#### 响应示例

```json
{
    "timestamp": 1620448826647,
    "data": {
        "user1": {
            "ext": "ext",
            "nickname": "nickname",
            "avatarurl": "http://XXXX.png"
        },
        "user2": {
            "ext": "ext",
            "nickname": "nickname",
            "avatarurl": "http://XXXX.png"
        },
        "user3": {
            "ext": "ext",
            "nickname": "nickname",
            "avatarurl": "http://XXXX.png"
        }
    },
    "duration": 3
}
```

## 获取 app 下的用户属性总大小

获取该 app 下所有用户的属性数据大小，单位为字节。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/metadata/user/capacity
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 中包含以下字段：

| 参数   | 类型   | 描述                               |
| :----- | :----- | :--------------------------------- |
| `data` | Number | app 下用户属性总长度，单位为字节。 |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app Token
curl -X GET -H 'Authorization: Bearer <YourAppToken>''http://XXXX/XXXX/XXXX/metadata/user/capacity'
```

#### 响应示例

```json
{
    "timestamp": 1620447051368,
    "data": 1673,
    "duration": 55
}
```

## 删除用户属性

删除指定用户的所有属性。如果指定的用户或用户属性不存在（可能已删除），也视为删除成功。
### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/metadata/user/{username}
```

#### 路径参数

参数及说明详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述                   | 是否必填 |
| :-------------- | :----- | :--------------------- | :------- |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应 body 中包含以下字段：

| 参数   | 类型 | 描述                                                                                                                        |
| :----- | :--- | :-------------------------------------------------------------------------------------------------------------------------- |
| `data` | Boolean | 用户属性是否删除成功：<ul><li>`true`：是。如果指定的用户不存在，或指定用户的用户属性不存在，也视为删除成功。</li><li>`false`：否。</li></ul> |

其他字段及说明详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 app Token

curl -X DELETE -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/metadata/user/XXXX'
```

#### 响应示例

```json
{
    "timestamp": 1616573382270,
    "duration": 10,
    "data": true
}
```

## 状态码

有关详细信息，请参阅[HTTP 状态代码](./agora_chat_status_code?platform=RESTful)。