# 管理环信超级社区的社区及其成员

社区（Server）是一群有着共同兴趣爱好的人的专属天地，也可以是同学朋友的社交圈子。社区是环信超级社区三层基础架构的最上层，各种消息事件均发生在社区内。任何用户均可以自由加入或退出社区，无需审批。

本文展示如何调用即时通讯 RESTful API 实现环信超级社区的社区管理和社区成员管理。调用以下方法前，请先参考[限制条件](https://docs.agora.io/en/agora-chat/reference/limitations?platform=android)了解即时通讯 RESTful API 的调用频率限制。

## <a name="param"></a>公共参数

### 请求参数

| 参数       | 类型   | 描述                                                         | 是否必需 | 
| :--------- | :----- | :------- | :----------------------------------------------------------- |
| `host`       | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       | 
| `org_name`   | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。            | 是       |
| `app_name`   | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。   | 是       |
| `server_id`  | String | 社区 ID。                | 是       |
| `channel_id` | String | 频道 ID。             | 是       |
| `user_id`    | String | 用户 ID。     |
| `role`       | Number    | 用户的角色：<br/> - `0`：社区所有者；<br/> - `1`：社区管理员；<br/> - `2`：社区的普通成员。 | 是       |

### 响应参数

| 参数             | 类型    | 描述                                                         |
| :-----------------| :----- | :----------------------------------------------------------- |
| `name`              | String | 社区名称。                                              |
| `owner`             | String | 社区的所有者。                                            |
| `description`      | String  | 社区描述。                                              |
| `custom`            | String | 社区的扩展信息。                                            |
| `icon_url`         | String  | 社区图标的 URL。                                          |
| `server_tag_id`   | String   | 社区标签 ID。                                           |
| `tag_name`        | String   | 社区标签名称。                                          |
| `tag_count`       | Number   | 社区标签数量。                                          |
| `server_id`       | String   | 社区 ID。                                                  |
| `default_channel_id` | String | 社区的默认频道的 ID。                                   |
| `user_id`           | String | 用户 ID。                                                |
| `role`              | Number | 社区成员的角色：<br/> - `0`：社区所有者；<br/> - `1`：社区管理员；<br/> - `2`：社区的普通成员。 |
| `created`          | Number  | 社区的创建时间，Unix 时间戳，单位为毫秒。                      |

## 认证方式

即时通讯 RESTful API 要求 Bearer HTTP 认证。每次发送 HTTP 请求时，都必须在请求头部填入如下 `Authorization` 字段：

```shell
Authorization：Bearer ${YourAppToken}
```

为提高项目的安全性，Agora 使用 Token（动态密钥）对即将登录即时通讯系统的开发者进行鉴权。即时通讯 RESTful API 仅支持使用 App Token 的鉴权方式，详见 [使用 app token 鉴权](https://docs.agora.io/en/agora-chat/develop/authentication?platform=android)。

## 查询环信超级社区用户是否存在

查询环信超级社区用户是否存在。

### HTTP 请求

```http
GET https://{host}/{orgName}/{appName}/circle/user/{user_id}
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数          | 类型   | 描述                      | 是否必需 |
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 内容类型。填入 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段   | 类型    | 描述                                              |
| :----- | :------ | :------------------------------------------------ |
| `code`   | Number     | 环信超级社区的服务状态码。                               |
| `result` | Boolean | 查询结果：<br/> - `true`：用户存在；<br/> - `false`：用户不存在。 |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/user/{user_id}'
```

#### 响应示例

```json
{
    "code": 200,
    "result" : true
}
```

## 创建和管理社区

本节介绍如何创建、修改、搜索、获取和删除社区。

### 创建社区

创建一个社区并设置社区名称、社区图标的 URL、社区描述和社区扩展信息。

默认每个用户最多可以创建 100 个社区。如需调整该阈值，请联系 [support@agora.io](mailto:support@agora.io)。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/circle/server
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述            | 是否必需 |
| :------------ | :----- | :------- | :-------------------------------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。                            | 是       |
|  `Accept`       | String | 内容类型。填入 `application/json`。                            | 是       |
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       |

##### 请求 body

| 参数        | 类型   | 备注                        | 是否必需 |
| :---------- | :----- | :------- | :----------------------------------------------------------- |
|  `owner`      | String | 社区创建者（即社区所有者）的用户 ID，长度不能超过 64 字节。           | 是       |
|  `name`    | String  | 社区名称，长度不能超过 50 个字符。                        | 是       |
| `icon_url`    | String | 社区图标的 URL，长度不能超过 500 个字符。                   | 否       |
| `description` | String | 社区描述，长度不能超过 500 个字符。                       | 否       |
| `custom`      | String | 社区的扩展信息，例如，你可以给社区添加业务相关的标记，长度不能超过 500 个字符。 | 否       |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段      | 类型   | 描述                |
| :-------- | :----- | :------------------ |
| `code`      | Number    | 环信超级社区的服务状态码。 |
| `server_id` | String | 社区 ID。         |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server' -d '{
 "owner" : "user1",
 "name" : "server",
 "icon_url" : "http://circle.oss/19b1d7b0-7079-11e9-9bd8-25c5e81b42a1",
 "description" : "community",
 "custom" : "custom"
}'
```

##### 响应示例

```json
{
    "code": 200,
    "server_id": "19VM9oPBasxxxxxx0tvWViEsdM"
}
```

### 修改社区信息

修改指定社区的信息。你可以修改社区名称、社区图标的 URL、社区描述和社区的扩展信息。

#### HTTP 请求

```http
PUT https://{host}/{org_name}/{app_name}/circle/server/{server_id} 
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                        | 是否必需 |
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。               | 是       | 
|  `Accept`       | String | 内容类型。填入 `application/json`。           | 是       | 
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       | 

##### 请求 body

| 参数        | 类型   |  备注          | 是否必需 |
| :---------- | :----- | :------- | :---------------------- |
|  `name`    | String | 社区名称，长度不能超过 50 个字符。                        | 否       |
| `icon_url`    | String | 社区图标的 URL，长度不能超过 500 个字符。      | 否       |
| `description` | String | 社区描述，长度不能超过 500 个字符。     | 否       |
| `custom`      | String | 社区的扩展信息，例如，可以给社区添加业务相关的标记，长度不能超过 500 个字符。 | 否       |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段   | 类型 | 描述                |
| :----- | :--- | :------------------ |
| `code`   | Number  | 环信超级社区的服务状态码。 |
| `server` | JSON | 社区数据。       |

具体字段及描述详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server/XXX' -d '{
 "name" : "easemob",
 "icon_url" : "http://discord.oss/19b1d7b0-7079-11e9-9bd8-25c5e81b42a1",
 "description" : "community",
 "custom" : ""custom"
}'
```

##### 响应示例

```json
{
    "code": 200,
    "server": {
        "name": "easemob",
        "owner": "u1",
        "description": "community",
        "custom": "custom",
        "tags": [
            {
                "server_tag_id": "1",
                "tag_name": "social networking"
            }
        ],
        "tag_count": 1,
        "created": 1658126097514,
        "server_id": "19SW5Q85jHxxxxx6T5kexvn",
        "icon_url": "http://discord.oss/19b1d7b0-7079-11e9-9bd8-25c5e81b42a1",
        "default_channel_id": "187xxxx09"
    }
}
```

### 为指定社区添加标签

每个社区最多可以添加 10 个标签。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/circle/server/{server_id}/tag/add
```

##### 路径参数

参数及描述详见[[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                  | 是否必需 | 
| :------------ | :----- | :------- | :---------------------------------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。                            | 是       | 
|  `Accept`       | String | 内容类型。填入 `application/json`。                            | 是       | 
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       | 

##### 请求 body

| 参数 | 类型 | 描述         | 是否必需 | 
| :--- | :--- | :------- | :------------------------ |
| `tags` | List | 为社区添加标签的数组，最多可以添加 10 个标签，每个标签的长度不能超过 20 个字符。 | 是       | 

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段 | 类型 | 描述                |
| :--- | :--- | :------------------ |
| `code` | Number  | 环信超级社区的服务状态码。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server/XXX/tag/add' -d '{
 "tags": ["social networking"]
}'
```

##### 响应示例

```json
{
    "code": 200,
    "tags": [
        {
            "server_tag_id": "1",
            "tag_name": "social networking"
        }
    ]
}
```

### 获取社区标签

获取指定社区的标签。

#### HTTP 请求

```http
GET http://a1.easemob.com/{orgName}/{appName}/circle/server/{server_id}/tag
```

##### 路径参数

参数及描述详见[[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。                            | 是       |
|  `Accept`       | String | 内容类型。填入 `application/json`。                            | 是       |
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段 | 类型 | 描述                |
| :--- | :--- | :------------------ |
| `code` | Number  | 环信超级社区的服务状态码。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourToken>' 'http://XXX/XXX/XXX/circle/server/XXX/tag'
```

##### 响应示例

```json
{
    "code": 200,
    "count": 1,
    "tags": [
        {
            "server_tag_id": "78",
            "tag_name": "uur2"
        }
    ]
}
```

### 移除指定社区的标签

根据标签的 ID 移除标签，不能使用标签名进行移除。移除标签之前，你可以通过获取社区详情获取标签 ID。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/circle/server/{server_id}/tag/remove
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                     | 是否必需 |
| :------------ | :----- | :------- | :---------------------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。                           | 是       | 
|  `Accept`       | String | 内容类型。填入 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       | 

##### 请求 body

| 参数   | 类型 | 描述                           | 是否必需 | 
| :----- | :--- | :------- | :----------------------- |
| `tagIds` | List | 要移除的社区标签 ID 的数组，一次移除的标签不能超过 10 个。 | 是       | 

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段 | 类型 | 描述                |
| :--- | :--- | :------------------ |
| `code` | Number  | 环信超级社区的服务状态码。 |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server/XXX/tag/remove' -d '{
 "tagIds" : ["1", "2"]
}'
```

##### 响应示例

```json
{
    "code": 200
}
```

### 搜索社区

你可以根据社区名称搜索社区，一次最多可查找出 15 个社区。

#### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/circle/server/search?name={name} 
```

##### 路径参数

| 参数 | 类型   | 描述                        | 是否必需 | 
| :--- | :----- | :------- | :------------------------------- |
| `name` | String | 社区名称。社区名称不能超过 50 个字符。需输入完整的社区名称，不支持模糊搜索。| 是       |

其他参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                  | 是否必需 | 
| :------------ | :----- | :------- | :--------------------- |
|  `Accept`       | String | 是       | 内容类型。填入 `application/json`。                            |
| `Authorization` | String | 是       | 该管理员的鉴权 App Token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段    | 类型 | 描述                   |
| :------ | :--- | :--------------------- |
| `code`    | Number  | 环信超级社区的服务状态码。    |
| `servers` | List | 搜索到的社区详情。 |
| `count`   | Number  | 搜索到的社区数量。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server/search?name=XXX'
```

##### 响应示例

```json
{
    "code": 200,
    "count": 1,
    "servers": [
        {
          "name": "easemob",
          "owner": "u1",
          "description": "community",
          "custom": "custom",
          "tags": [
              {
                  "server_tag_id": "1",
                  "tag_name": "social networking"
              }
          ],
          "tag_count": 1,
          "created": 1658126097514,
          "server_id": "19SW5Q85jHxxxxx6T5kexvn",
          "icon_url": "http://discord.oss/19b1d7b0-7079-11e9-9bd8-25c5e81b42a1",
          "default_channel_id": "187xxxx09"
        }
    ]
}
```

### 获取指定社区的详情

获取指定社区的详情。

#### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/circle/server/{server_id}/by-id
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
|  `Accept`       | String | 是       | 内容类型。填入 `application/json`。                            |
| `Authorization` | String | 是       | 该管理员的鉴权 App Token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段   | 类型 | 描述                |
| :----- | :--- | :------------------ |
| `code`   | Number  | 环信超级社区的服务状态码。 |
| `server` | JSON | 社区的详情。     |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server/XXX/by-id'
```

##### 响应示例

```json
{
    "code": 200,
    "server": {
        "name": "easemob",
        "owner": "u1",
        "description": "community",
        "custom": "custom",
        "tags": [
            {
                "server_tag_id": "1",
                "tag_name": "social networking"
            }
        ],
        "tag_count": 1,
        "created": 1658126097514,
        "server_id": "19SW5Q85jHxxxxx6T5kexvn",
        "icon_url": "http://discord.oss/19b1d7b0-7079-11e9-9bd8-25c5e81b42a1",
        "default_channel_id": "187xxxx09"
    }
}
```

### 获取推荐的社区列表

目前，该方法返回最新创建的 5 个社区。若社区数量少于 5 个，则返回实际的社区数量。

#### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/circle/server/recommend/list
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
|  `Accept`       | String | 内容类型。填入 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       | 

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段    | 类型 | 描述                 |
| :------ | :--- | :------------------- |
| `code`    | Number  | 环信超级社区的服务状态码。  |
| `servers` | List | 推荐的社区详情。 |
| `count`   | Number  | 推荐的社区数量。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server/recommend/list'
```

##### 响应示例

```json
{
    "code": 200,
    "count": 1,
    "servers": [
        {
            "name": "easemob",
          "owner": "u1",
          "description": "community",
          "custom": "custom",
          "tags": [
              {
                  "server_tag_id": "1",
                  "tag_name": "social networking"
              }
          ],
          "tag_count": 1,
          "created": 1658126097514,
          "server_id": "19SW5Q85jHxxxxx6T5kexvn",
          "icon_url": "http://discord.oss/19b1d7b0-7079-11e9-9bd8-25c5e81b42a1",
          "default_channel_id": "187xxxx09"
        }
    ]
}
```

### 获取当前用户加入的社区

获取当前用户加入的社区。

#### HTTP 请求

获取第一页：

```http
GET https://{host}/{org_name}/{app_name}/circle/server/list?userId={user_id} 
```

分页获取：

```http
GET https://{host}/{org_name}/{app_name}/circle/server/list?userId={user_id}&limit={limit}&cursor={cursor} 
```

##### 路径参数

| 参数  | 类型 | 描述             | 是否必需 |
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `limit` | Number    | 每页获取的社区数量。取值范围为 [1,20]，默认值为 20。该参数仅在分页获取时为必需。 | 否  |
| `cursor`     | String  | 游标，数据查询的起始位置。该参数仅在分页获取时为必需。       | 否  |

其他参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 是否必需 | 描述                                                         |
| :------------ | :----- | :------- | :----------------------------------------------------------- |
|  `Accept`       | String | 是       | 内容类型。填入 `application/json`。                           |
| `Authorization` | String | 是       | 该管理员的鉴权 App Token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段    | 类型 | 描述                   |
| :------ | :--- | :--------------------- |
| `code`    | Number  | 环信超级社区的服务状态码。    |
| `count`   | Number  | 获取到的社区数量。 |
| `servers` | List | 获取到的社区详情。 |
| `cursor`  | String  | 游标，下次数据查询的起始位置。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server/list?userId=XXX'
```

分页获取：

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server/list?userId=XXX&limit=1&cursor=XXX'
```

##### 响应示例

```json
{
    "code": 200,
    "count": 1,
    "servers": [
        {
            "name": "easemob",
          "owner": "u1",
          "description": "community",
          "custom": "custom",
          "tags": [
              {
                  "server_tag_id": "1",
                  "tag_name": "social networking"
              }
          ],
          "tag_count": 1,
          "created": 1658126097514,
          "server_id": "19SW5Q85jHxxxxx6T5kexvn",
          "icon_url": "http://discord.oss/19b1d7b0-7079-11e9-9bd8-25c5e81b42a1",
          "default_channel_id": "187xxxx09"
        }
    ],
    "cursor": "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aXXXXXXXXXXXXXX"
}
```

### 删除社区

删除指定的社区。删除社区后，该社区中的频道也将被删除。

#### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/circle/server/{server_id}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                       | 是否必需 |
| :------------ | :----- | :------- | :----------------------------------------------------------- |
|  `Accept`       | String | 内容类型。填入 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       | 

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段 | 类型 | 描述                |
| :--- | :--- | :------------------ |
| `code` | Number  | 环信超级社区的服务状态码。 |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server/XXX'
```

##### 响应示例

```json
{
    "code": 200
}
```

## 管理社区成员

本节介绍如何添加、获取、查询和移除社区成员。

### 获取社区成员列表

获取社区成员列表。

#### HTTP 请求

获取第一页：

```shell
GET https://{host}/{org_name}/{app_name}/circle/server/{server_id}/users 
```

分页获取：

```shell
GET https://{host}/{org_name}/{app_name}/circle/server/{server_id}/users?limit={limit}&cursor={cursor} 
```

##### 路径参数

| 参数  | 类型 | 描述                                        | 是否必需 |
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `limit` | Number   | 每页获取的社区成员数量。取值范围为 [1,20]，默认值为 20。该参数仅在分页获取时为必需。 | 否   | 
| `cursor`     | String | 游标，数据查询的起始位置。该参数仅在分页获取时为必需。       | 否   | 

其它参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :------- | :----------------------------------------------------------- |
|  `Accept`       | String | 内容类型。填入 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段  | 类型 | 描述                 |
| :---- | :--- | :------------------- |
| `code`  | Number  | 环信超级社区的服务状态码。  |
| `count` | Number  | 获取到的社区成员数量。 |
| `users` | List | 获取到的社区成员详情。 |
| `cursor` | String  | 游标，下次数据查询的起始位置。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server/XXX/users'
```

分页获取：

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server/XXX/users?limit=1&cursor=XXX'
```

##### 响应示例

```json
{
    "code": 200,
    "count": 1,
    "users": [
        {
            "user_id" : "user1",
            "role" : 0
        }
    ],
    "cursor": "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aXXXXXXXXXXXXXX"
}
```

### 将用户加入社区

将单个用户加入社区。默认每个用户最多加入 100 个社区。如需调整该阈值，请联系 [support@agora.io](mailto:support@agora.io)。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/circle/server/{server_id}/join?userId={user_id} 
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   |描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
|  `Accept`       | String | 内容类型。填入 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       | 

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段 | 类型 | 描述                |
| :--- | :--- | :------------------ |
| `code` | Number  | 环信超级社区的服务状态码。 |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X POST -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server/XXX/join?userId=XXX'
```

##### 响应示例

```json
{
    "code": 200,
    "server": {
        "name": "easemob",
        "owner": "u1",
        "description": "community",
        "custom": "custom",
        "tags": [
            {
                "server_tag_id": "1",
                "tag_name": "social networking"
            }
        ],
        "tag_count": 1,
        "created": 1658126097514,
        "server_id": "19SW5Q85jHxxxxx6T5kexvn",
        "icon_url": "http://discord.oss/19b1d7b0-7079-11e9-9bd8-25c5e81b42a1",
        "default_channel_id": "187xxxx09"
    }
}
```

### 查询指定成员在社区内的角色

查询指定成员在社区内的角色。

#### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/circle/server/{server_id}/user/role?userId={user_id} 
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
|  `Accept`       | String | 内容类型。填入 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段 | 类型 | 描述                                                         |
| :--- | :--- | :----------------------------------------------------------- |
| `code` | Number  | 环信超级社区的服务状态码。                                          |
| `role` | Number  | 社区成员角色：<br/> - `0`：社区所有者；<br/> - `1`：社区管理员；<br/> - `2`：社区的普通成员。 |

其他字段及描述详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X POST -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server/XXX/user/role?userId=XXX'
```

##### 响应示例

```json
{
    "code": 200,
    "role" : 1
}
```

### 查询用户是否在社区内

查询用户是否在社区内。

#### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/circle/server/{server_id}/user/{user_id} 
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :------- | :----------------------------------------------------------- |
|  `Accept`       | String | 内容类型。填入 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       | 

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段   | 类型    | 描述                                                         |
| :----- | :------ | :----------------------------------------------------------- |
| `code`   | Number     | 环信超级社区的服务状态码。                                          |
| `result` | Boolean | 查询结果：<br/> - `true`：用户在社区中；<br/> - `false`：用户不在社区中。 |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server/XXX/user/XXX'
```

##### 响应示例

```json
{
    "code": 200,
    "result": true
}
```

### 修改社区中指定成员的角色

修改社区中指定成员的角色。

#### HTTP 请求

```http
PUT https://{host}/{org_name}/{app_name}/circle/server/{server_id}/user/role?userId={user_id}&role={role} 
```

##### 路径参数

| 参数 | 类型 | 描述                                     |
| :--- | :--- | :--------------------------------------- |
| `role` | Number  | 要修改的成员角色，只能传 `1` 或 `2`，否则报错。 |

其它参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
|  `Accept`       | String | 内容类型。填入 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer ${YourApp Token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段 | 类型 | 描述                |
| :--- | :--- | :------------------ |
| `code` | Number  | 环信超级社区的服务状态码。 |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X PUT -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server/XXX/user/role?userId=XXX&role=XXX'
```

##### 响应示例

```json
{
    "code": 200
}
```

### 将成员移出社区

将指定成员移出社区。成员被移出社区的同时也会被移出该社区下的频道。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/circle/server/{server_id}/user/remove?userId={user_id}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                         | 是否必需 | 
| :------------ | :----- | :------- | :------------------------------- |
|  `Accept`       | String | 内容类型。填入 `application/json`。                            | 是       | 
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer YourAppToken`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       | 

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段 | 类型 | 描述                |
| :--- | :--- | :------------------ |
| `code` | Number  | 环信超级社区的服务状态码。 |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/server/XXX/user/remove?userId=XXX'
```

##### 响应示例

```json
{
    "code": 200
}
```