# Servers

Circle is an online chat and community solution built on Chat SDKs. It allows users to connect with communities by interest and communicate with thousands of kindred spirits in real time.

Circle provides a three-layer structure that contains the following:

- **Server**: Servers are different communities within Circle. You can not only find and join servers by your interest, but also create and manage your own servers.
- **Channel**: A server is organized into topic-based channels, where you can share with kindred spirits and talk over specific topics. A default channel is automatically created in tandem with the server creation.
- **Thread**: Threads serve as temporary sub-channels inside an existing channel, to help better organize conversations in a busy channel.

Once a server is created, a default channel with all server members in is automatically created to receive system notifications. The server owner can then create public or private channels by demand. Note that users can join and leave a server freely without anyone's approval.

This page shows how to implement servers in circle using RESTful APIs. Before proceeding, ensure that you understand the frequency limit of Chat RESTful API calls described in [Limitations](https://docs.agora.io/en/agora-chat/reference/limitations#call-limit-of-server-sides).


## <a name="param"></a>Common parameters

### Request parameters

| Parameter | Type | Description | Required |
| :--------- | :----- | :------ | :------- |
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service.  For how to get the org name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `server_id`  | String | The server.         | Yes   |
| `channel_id` | String | The channel ID.         | Yes     |
| `user_id`    | String | The user ID.   | Yes |
| `role`       | Number    | The role of the user in a server.<li>`0`: Owner.</li><li>`1`: Admin.</li><li>`2`: Member.</li> | Yes    |


### Response parameters

| Parameter | Type | Description |
| :---------------- | :----- | :--------------- |
| `name`              | String | The server name.     |
| `owner`             | String | The server owner.      |
| `description`      | String  | The server description.    |
| `custom`            | String | The server extension.    |
| `icon_url`         | String  | The URL of the server icon.                   |
| `server_tag_id`   | String   | The ID of the server tag.             |
| `tag_name`        | String   | The name of the server tag.               |
| `tag_count`       | Number   | The number of the server tags.             |
| `server_id`       | String   | The server ID.                   |
| `default_channel_id` | String | The channel ID of the default channel.             |
| `user_id`   | String |  The user ID.      |
| `role`              | Number | The role of the user in a server.<li>`0`: Owner.</li><li>`1`: Admin.</li><li>`2`: Member.</li> |
| `created`          | Number  | The Unix timestamp (ms) when the server is created.     |



## Authorization

Agora Chat RESTful APIs require Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authorization` field must be filled in the request header:

```http
Authorization: Bearer ${YourAppToken}
```

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log into the chat system. The Agora Chat RESTful API only supports authenticating users using app tokens. For details, see [Authentication using App Token](./generate_app_tokens?platform=RESTful).



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
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       |

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

默认每个用户最多可以创建 100 个社区。如需调整该阈值，请联系 [support@agora.io](support@agora.io)。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/circle/server
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述            | 是否必需 |
| :------------ | :----- | :------- | :-------------------------------- |
| `Content-Type`  | String | 内容类型。请填 `application/json`。                            | 是       |
|  `Accept`       | String | 内容类型。请填 `application/json`。                            | 是       |
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       |

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
| `Content-Type`  | String | 内容类型。请填 `application/json`。               | 是       | 
|  `Accept`       | String | 内容类型。请填 `application/json`。           | 是       | 
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       | 

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
| `Content-Type`  | String | 内容类型。请填 `application/json`。                            | 是       | 
|  `Accept`       | String | 内容类型。请填 `application/json`。                            | 是       | 
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       | 

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
| `Content-Type`  | String | 内容类型。请填 `application/json`。                            | 是       |
|  `Accept`       | String | 内容类型。请填 `application/json`。                            | 是       |
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       |

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
| `Content-Type`  | String | 内容类型。请填 `application/json`。                           | 是       | 
|  `Accept`       | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       | 

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
|  `Accept`       | String | 是       | 内容类型。请填 `application/json`。                            |
| `Authorization` | String | 是       | 该管理员的鉴权 App Token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 |

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
|  `Accept`       | String | 是       | 内容类型。请填 `application/json`。                            |
| `Authorization` | String | 是       | 该管理员的鉴权 App Token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 |

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
|  `Accept`       | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       | 

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
|  `Accept`       | String | 是       | 内容类型。请填 `application/json`。                           |
| `Authorization` | String | 是       | 该管理员的鉴权 App Token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 |

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
|  `Accept`       | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       | 

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
|  `Accept`       | String | 内容类型。请填 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       |

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

将单个用户加入社区。默认每个用户最多加入 100 个社区。如需调整该阈值，请联系 [support@agora.io](support@agora.io)。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/circle/server/{server_id}/join?userId={user_id} 
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   |描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
|  `Accept`       | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       | 

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
|  `Accept`       | String | 内容类型。请填 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       |

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
|  `Accept`       | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       | 

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
|  `Accept`       | String | 内容类型。请填 `application/json`。                           | 是       |
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
|  `Accept`       | String | 内容类型。请填 `application/json`。                            | 是       | 
| `Authorization` | String | 该管理员的鉴权 App Token，格式为 `Bearer ${YourAppToken}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。 | 是       | 

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