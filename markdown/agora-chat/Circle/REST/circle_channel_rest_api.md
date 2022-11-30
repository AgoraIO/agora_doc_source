# 管理环信超级社区的频道及其成员

频道（Channel）是一个社区下不同子话题的讨论分区，因此一个社区下可以有多个频道。社区创建时会自动创建默认频道，该频道中添加了所有社区成员，用于承载各种系统通知。社区创建者可以根据自己需求创建公开或者私密频道。

本文展示如何调用即时通讯 RESTful API 实现环信超级社区的频道管理和频道成员管理。调用以下方法前，请先参考[限制条件](https://docs.agora.io/en/agora-chat/reference/limitations?platform=android)了解即时通讯 RESTful API 的调用频率限制。

## <a name="param"></a>公共参数

### 请求参数

| 参数       | 类型   | 描述    | 是否必需 | 
| :--------- | :----- | :------- | :----------------------------------------------------------- |
| `host`       | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       | 
| `org_name`   | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。            | 是       |
| `app_name`   | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。   | 是       |
| `server_id`  | String | 社区 ID。                                                  | 是       | 
| `channel_id` | String | 频道 ID。                                                 | 是       | 
| `user_id`    | String | 用户 ID。                                                    | 是       | 
| `role`       | Number    | 频道成员的角色：<br/> - `0`：频道所有者；<br/> - `2`：频道的普通成员。 | 是       | 
| `limit`      | Number    | 每次期望返回的数量。该参数仅在分页获取时为必需。            | 否       | 
| `cursor`     | String | 游标，数据查询的起始位置。该参数仅在分页获取时为必需。       | 否       | 

### 响应参数

| 参数         | 类型   | 描述                                                     |
| :-------| :----- | :----------------------------------------------------------- |
| `name`            | String     | 频道名称。                                             |
| `type`            | Number     | 频道类型：<br/> - `0`：公开频道；<br/> - `1`：私密频道。      				|
| `invite_mode`     | Number   | 邀请用户时是否需受邀方确认才能加入频道：<br/> - `0`：受邀方直接加入频道，无需确认；<br/> - `1`：受邀方需确认是否加入频道。 |
| `description`     | String      | 频道描述。|
| `custom`       | String     | 频道的扩展信息。                                           |
| `default_channel` | Number | 是否为社区的默认频道：<br/> - `0`：否；<br/> - `1`：是。                 |
| `user_id`     | String    | 用户 ID。                                                    |
| `role`        | Number     | 频道成员的角色：<br/> - `0`：频道所有者；<br/> - `2`：频道的普通成员。 |
| `created`      | Number    | 频道的创建时间，Unix 时间戳，单位为毫秒。                                         |
| `cursor`       | String     | 游标，数据查询的起始位置。该参数仅在分页获取时为必需。       |
| `server_id`     | String    | 社区 ID。                                                  |

## 认证方式

即时通讯 RESTful API 要求 Bearer HTTP 认证。每次发送 HTTP 请求时，都必须在请求头部填入如下 `Authorization` 字段：

```shell
Authorization：Bearer ${YourAppToken}
```

为提高项目的安全性，Agora 使用 Token（动态密钥）对即将登录即时通讯系统的开发者进行鉴权。即时通讯 RESTful API 仅支持使用 App 权限 Token 的鉴权方式，详见 [使用 Token 鉴权](https://docs.agora.io/en/agora-chat/develop/authentication?platform=android)。

## 创建和管理频道

### 创建频道

每个社区最多可以创建 100 个频道。 

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/circle/channel
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                    | 是否必需 | 
| :------------ | :----- | :------- | :--------------------------------- |
| `Content-Type`  | String | 内容类型。请填 `application/json`。                          | 是       | 
| `Accept`        | String | 内容类型。请填 `application/json`。                          | 是       | 
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       | 

##### 请求 body

| 参数        | 类型   | 描述                  | 是否必需 | 
| :------------ | :----- | :------- | :----------------- |
| `server_id`   | String | 社区 ID。                                                  | 是       | 
| `name`        | String | 频道名称，长度不能超过 50 个字符。                       | 是       | 
| `type`        | Number    | 频道类型：<br/> - `0`：公开频道；<br/> - `1`：私密频道。           | 是       | 
| `rank`        | Number    | 频道成员数量上限级别：<br/> - （默认）`0`：2,000；<br/> - `1`：20,000；<br/> - `2`：100,000。      |否       | 
| `invite_mode` | Number    | 邀请用户时是否需受邀方确认才能加入频道：<br/> - `0`：受邀方直接加入频道，无需确认；<br/> - `1`：受邀方需确认是否加入加入频道。 | 
| `description` | String | 频道描述，长度不能超过 500 个字符。                      | 否       | 
| `custom`      | String | 频道扩展信息，例如可以给社区添加业务相关的标记，长度不能超过 500 个字符。 | 否       | 

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型   | 描述                |
| :--------- | :----- | :------------------ |
| `code`       | Number    | 环信超级社区的服务状态码。 |
| `channel_id` | String | 频道 ID。        |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel'
-d '{
	"server_id" : "19VM9oPBasxxxxxx0tvWViEsdM",
	"name" : "easemob",
	"type" : 0,
  "rank"：0,
	"invite_mode" : 0,
	"description" : "chat Channel",
	"custom" : "custom"
}'
```

#### 响应示例

```json
{
    "code": 200,
    "channel_id": "198900125668"
}
```

### 修改频道信息

修改指定频道的信息。

#### HTTP 请求

```http
PUT https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}?serverId={server_id}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         |是否必需 | 
| ------------- | ------ | -------- | ------------------------------------------------------------ |
| `Content-Type`  | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       | 

##### 请求 body

| 参数        | 类型   | 是否必需 | 描述                                                         |
| ----------- | ------ | -------- | ------------------------------------------------------------ |
| `name`        | String |频道名称，长度不能超过 50 个字符。                           | 否       | 
| `rank`        | Number    | 频道的成员数量上限级别，1、2级别需要开通服务后才可以有效的设置。<br/> - （默认）`0`：2,000；<br/> - `1`：20,000；<br/> - `2`：100,000。 | 否       | 
| `invite_mode` | Number    | 邀请用户时是否需受邀方确认才能加入频道：<br/> - `0`：受邀方直接加入频道，无需确认；<br/> - `1`：受邀方需确认是否加入加入频道。 | 否       | 
| `description` | String | 频道描述，长度不能超过 500 个字符。        | 否       | 
| `custom`      | String | 频道的扩展信息，例如可以给社区添加业务相关的标记，长度不能超过 500 个字符。 | 否       | 

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段    | 类型 | 描述                |
| :------ | :--- | :------------------ |
| `code`    | Number  | 环信超级社区的服务状态码。 |
| `channel` | JSON | 频道详情。    |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX' -d '{
 "name" : "easemob",
 "rank" : 1,
 "description" : "chat Channel",
  "custom" : "custom"
}'
```

#### 响应示例

```json
{
    "code": 200,
    "channel": {
        "name": "easemob",
        "type": 1,
        "description": "chat Channel11",
        "custom": "custom",
        "created": 1658201254843,
        "server_id": "19UyPIsiwxxxxxxxgLrfI9Z",
        "channel_id": "198900125668",
        "invite_mode": 0,
        "default_Channel": 1
    }
}
```

### 查询指定频道

查询指定的频道。

#### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}?serverId={server_id}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                 | 是否必需 |
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       | 

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段    | 类型 | 描述                |
| :------ | :--- | :------------------ |
| `code`    | Number  | 环信超级社区的服务状态码。 |
| `channel` | JSON | 频道详情。    |
| `channel.rank` | Number | 频道的成员数量上限级别。<br/> - （默认）`0`：2,000；<br/> - `1`：20,000；<br/> - `2`：100,000。 |

其他字段及描述详见[[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel?serverId=XXX'
```

#### 响应示例

```json
{
    "code": 200,
    "channel": {
        "name": "easemob",
        "type": 1,
        "description": "chat Channel11",
        "custom": "custom",
        "created": 1658201254843,
        "server_id": "19UyPIsiwxxxxxxxgLrfI9Z",
        "channel_id": "198900125668",
        "invite_mode": 0,
        "rank" : 0,
        "default_channel": 1
    }
}
```

### 获取单个社区下的所有公开频道

获取单个社区下的所有公开频道。

#### HTTP 请求

获取第一页：

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/public?serverId={server_id}
```

分页获取：

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/public?serverId={server_id}&limit={limit}&cursor={cursor} 
```

##### 路径参数

| 参数  | 类型 | 描述       | 是否必需            |
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `limit` | Number      | 每页获取的频道数量。取值范围为 [1,20]，默认值为 20。该参数仅在分页获取时必须。 | 否       |

其他参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 是       | 内容类型。请填 `application/json`。                           |
| `Authorization` | String | 是       | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型  | 描述                        |
| -------- | ----- | --------------------------- |
| `code`     | Number   | 环信超级社区的服务状态码。         |
| `count`    | Number   | 获取到的频道数量。     |
| `channels` | List | 获取到的频道详情列表。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/public?serverId=XXX'
```

分页获取：

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/public?serverId=XXX&limit=1&cursor=XXX'
```

#### 响应示例

```json
{
    "code": 200,
    "count": 1,
    "channels": [
        {
            "name": "easemob",
        		"type": 0,
            "rank" : 0,
        		"description": "chat Channel11",
        		"custom": "custom",
        		"created": 1658201254843,
        		"server_id": "19UyPIsiwxxxxxxxgLrfI9Z",
        		"channel_id": "198900125668",
        		"invite_mode": 0,
        		"default_Channel": 1
        }
    ],
    "cursor": "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aXXXXXXXXXXXXXX"
}
```

### 获取单个用户已加入的频道列表

获取单个用户已加入的频道列表。

#### HTTP 请求

获取第一页：

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/user/joined/list?userId={user_id}&serverId={server_id}
```

分页获取：

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/user/joined/list?userId={user_id}&serverId={server_id}&limit={limit}&cursor={cursor} 
```

##### 路径参数

| 参数  | 类型 | 描述       | 是否必需            |
| :------------ | :----- | :------- | :------------------------ |
| `limit` | Number      | 每页获取的频道数量。取值范围为 [1,20]，默认值为 20。该参数仅在分页获取时必须。 | 否       |

其他参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述          | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------- |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       |
| `Authorization` | String | 是       | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型 | 描述                        |
| :------- | :--- | :-------------------------- |
| `code`     | Number  | 环信超级社区的服务状态码。         |
| `channels` | List | 获取到的频道详情列表。 |
| `count`    | Number  | 获取到的频道数量。      |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/user/joined/list?userId=XXX&serverId=XXX'
```

分页获取：

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/user/joined/list?userId=XXX&serverId=XXX&limit=1&cursor=XXX'
```

#### 响应示例

```json
{
    "code": 200,
    "count": 1,
    "channels": [
        {
          "name": "easemob",
          "type": 1,
          "description": "chat Channel11",
          "custom": "custom",
          "created": 1658201254843,
          "server_id": "19UyPIsiwxxxxxxxgLrfI9Z",
          "channel_id": "198900125668",
          "invite_mode": 0,
          "default_Channel": 1
        }
    ],
    "cursor": "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aXXXXXXXXXXXXXX"
}
```

### 获取当前用户可见的所有私密频道列表

获取当前用户可见的所有私密频道列表。

#### HTTP 请求

获取第一页：

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/private?serverId={server_id}
```

分页获取：

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/private?serverId={server_id}&limit={limit}&cursor={cursor} 
```

##### 路径参数

| 参数  | 类型 | 描述       | 是否必需            |
| :------------ | :----- | :------- | :------------------------ |
| `limit` | Number      | 每页获取的私密频道数量。取值范围为 [1,20]，默认值为 20。该参数仅在分页获取时必须。 | 否       |

其他参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                        | 是否必需 | 
| :------------ | :----- | :------- | :------------------------ |
| `Accept`        | String | 内容类型。请填 `application/json`。      | 是       | 
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       | 

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段     | 类型 | 描述                            |
| :------- | :--- | :------------------------------ |
| `code`     | Number  | 环信超级社区的服务状态码。             |
| `count`    | Number   | 获取到的频道数量。         |
| `channels` | List | 获取到的私密频道详情列表。 |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/private?serverId=XXX'
```

分页获取：

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/private?serverId=XXX&limit=1&cursor=XXX'
```

#### 响应示例

```json
{
    "code": 200,
    "count": 1,
    "channels": [
        {
            "name": "easemob",
        		"type": 1,
            "rank": 0,
        		"description": "chat Channel11",
        		"custom": "custom",
        		"created": 1658201254843,
        		"server_id": "19UyPIsiwxxxxxxxgLrfI9Z",
        		"channel_id": "198900125668",
        		"invite_mode": 0,
        		"default_Channel": 1
        }
    ],
    "cursor": "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aXXXXXXXXXXXXXX"
}
```

### 删除频道

删除指定的频道。

#### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}?serverId={server_id}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       | 

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
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX?serverId=XXX'
```

#### 响应示例

```json
{
    "code": 200
}
```

## 发送消息

通过 RESTful API 在频道中发送消息与在群组中发送消息的方式类似，唯一的区别在于请求体中的 `to` 参数需要设置为频道 ID。详见 [发送群聊消息](https://docs.agora.io/en/agora-chat/restful-api/message-management?platform=android)。

## 管理 Reaction

### 添加消息 Reaction

添加消息 Reaction。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/circle/reaction
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   |描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       | 

##### 请求 body

| 参数       | 类型   | 描述                               | 是否必需 | 
| :--------- | :----- | :------- | :--------------------------------- |
| `user_id`    | String | 用户 ID。                          | 是       |
| `message_id` | String | 消息 ID。                          | 是       |
| `message`    | String | 表情 ID，长度不可超过 128 个字符。 | 是       |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段        | 类型   | 描述                |
| :---------- | :----- | :------------------ |
| `code`        | Number    | 环信超级社区的服务状态码。 |
| `reaction_id` | String | Reaction ID。       |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/reaction'
-d '{
  "user_id" : "user1",
  "message_id" : "131345390",
  "message" : "message"
}'
```

##### 响应示例

```json
{
  "code" : 200,
  "reaction_id" : "15890012560"
}
```

### 获取指定消息的 Reaction

获取指定消息的 Reaction。

#### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/circle/reaction/user/{user_id}?msgIdList={message_id}&channelId={channel_id}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

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
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/reaction/user/XXX?msgIdList=XXX&channelId=XXX'
```

#### 响应示例

```json
{
    "code":200,
    "count" : 1,
    "reactions":[
        {
            "msgId":"message id",
            "reactionList":[
                {
                    "reactionId":"reaction id",
                    "message":"Reaction id",
                    "count":2,
                    "state":"Whether this user adds the reaction",
                    "userList":[
                        "user1",
                        "user2"
                    ]
                }
            ]
        }
    ]
}
```

### 删除指定消息的 Reaction

删除指定消息的 Reaction。

#### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/circle/reaction/user/{user_id}?messageId={message_id}&message={message}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

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
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/reaction/user/XXX?messageId=XXX&message=XXX'
```

##### 响应示例

```json
{
  "code" : 200
}
```

## 管理频道成员

### 将用户加入频道

将用户加入频道，每个用户最多可以加入 10,000 个频道。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}/join?userId={user_id}&serverId={server_id}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                    | 是否必需 |
| :------------ | :----- | :------- | :----------------------------------------- |
| `Accept`        | String |内容类型。请填 `application/json`。                            | 是       | 
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       | 

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段    | 类型 | 描述                |
| :------ | :--- | :------------------ |
| `code`    | Number  | 环信超级社区的服务状态码。 |
| `channel` | JSON | 频道详情。    |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X POST -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX/join?userId=XXX&serverId=XXX'
```

#### 响应示例

```json
{
    "code": 200,
    "channel": {
        "name": "easemob",
        "type": 1,
        "description": "chat Channel11",
        "custom": "custom",
        "created": 1658201254843, 
        "server_id": "19UyPIsiwxxxxxxxgLrfI9Z",
        "channel_id": "198900125668",
        "invite_mode": 0,
        "default_Channel": 1
    }
}
```

### 将成员移出频道

将指定成员移出频道。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}/user/remove?userId={user_id}&serverId={server_id}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

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
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X POST -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX/user/remove?userId=XXX&serverId=XXX'
```

#### 响应示例

```json
{
    "code": 200
}
```

### 查询用户是否在频道

查询用户是否在频道中。

#### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}/user/{user_id}?serverId={server_id}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                  | 是否必需 | 
| :------------ | :----- | :------- | :--------------------------------- |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 |是       |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段   | 类型    | 描述                                                         |
| :----- | :------ | :----------------------------------------------------------- |
| `code`   | Number     | 环信超级社区的服务状态码。                                          |
| `result` | Boolean | 查询结果：<br/>- `true`：用户在频道中；<br/>- `false`：用户不在频道中。 |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX/user/XXX?serverId=XXX'
```

#### 响应示例

```json
{
    "code": 200,
    "result": true
}
```

### 获取频道的成员列表

获取频道的成员列表。

#### HTTP 请求

获取第一页：

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}/users?serverId={server_id}
```

分页获取：

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}/users?serverId={server_id}&limit={limit}&cursor={cursor} 
```

##### 路径参数

| 参数  | 类型 | 描述             | 是否必需 |
| :------------ | :----- | :------- | :----------------------- |
| `limit` | Number      | 每页获取的成员数量。取值范围为 [1,20]，默认值为 20。该参数仅在分页获取时必须。 | 否       | 

其它参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       | 

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段  | 类型 | 描述                     |
| :---- | :--- | :----------------------- |
| `code`  | Number  | 环信超级社区的服务状态码。      |
| `users` | List | 获取到的成员详情列表。 |
| `count` | Number  | 获取到的成员数量。     |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX/users?serverId=XXX'
```

分页获取：

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX/users?serverId=XXX&limit=1&cursor=XXX'
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

### 获取频道的禁言列表

获取频道的禁言列表。

#### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}/user/mute/list?serverId={server_id}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                    | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------- |
| Accept        | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       | 

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段   | 类型   | 描述                |
| :----- | :----- | :------------------ |
| `code`   | Number    | 环信超级社区的服务状态码。 |
| `expire` | Number   | 禁言的到期时间。    |
| `user`   | String | 被禁言的成员的用户 ID。   |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/Channel/XXX/user/mute/list?serverId=XXX'
```

##### 响应示例

```json
{
  "code" : 200
  "mute_users" : [
    {
      "expire" : 86400000,
      "user" : "u1"
    },
    {
      "expire" : 86400000,
      "user" : "u2"
    }
  ]
}
```

### 将成员加入频道禁言列表

将成员加入频道禁言列表。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}/user/mute
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       | 

##### 请求 body

| 参数      | 类型   | 描述                       | 是否必需 | 
| :-------- | :----- | :------- | :------------------------- |
| `server_id` | String | 社区 ID。                | 是       |
| `user_id`   | String | 被禁言的成员的用户 ID。          | 是       |
| `duration`  | Number   | 禁言时长，单位为毫秒。 | 是       |

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
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX/user/mute' -d '{
  "server_id" : "19UyPIsiwxxxxxxxgLrfI9Z",
  "user_id" : "u1",
  "duration" : 86400
}'
```

##### 响应示例

```json
{
    "code": 200
}
```

### 将成员移出频道禁言列表

将成员移出频道禁言列表。

#### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}/user/mute?serverId={server_id}&userId={user_id}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述               | 是否必需 | 
| :------------ | :----- | :------- | :--------------------- |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       | 

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
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX/user/mute?serverId=XXX&userId=XXX'
```

##### 响应示例

```json
{
    "code": 200
}
```

## 管理子区

### 创建子区

创建子区。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/circle/thread
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | 内容类型。请填 `application/json`。                           | 是       |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

##### 请求 body

| 参数       | 类型   | 描述          | 是否必需 | 
| :--------- | :----- | :------- | :------------ |
| `channel_id` | String | 频道 ID。  | 是       |
| `user_id`    | String | 用户 ID。     | 是       |
| `name`       | String | 子区名称。 | 是       |
| `message_id` | String | 消息 ID。     | 是       |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段      | 类型   | 描述                |
| :-------- | :----- | :------------------ |
| `code`      | Number    | 环信超级社区的服务状态码。 |
| `thread_id` | String | 子区 ID。         |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread' -d '{
  "channel_id" : "156900086",
  "user_id" : "user1",
  "message_id" : 0,
  "name" : "thread-name"
}'
```

##### 响应示例

```json
{
  "code" : 200,
  "thread_id" : "15890012560"
}
```

### 修改子区信息

修改指定子区的信息。

#### HTTP 请求

```http
PUT https://{host}/{org_name}/{app_name}/circle/thread/{thread_id}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   |  描述                      | 是否必需 |
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

##### 请求 body

| 参数 | 类型   | 描述          | 是否必需 | 
| :--- | :----- | :------- | :------------ |
| `name` | String | 子区名称。 | 是       | 

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
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/XXX' -d '{
  "name" :"thread-name"
}'
```

##### 响应示例

```json
{
  "code" : 200
}
```

### 查询子区的详情

查询指定子区的详情。

#### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/circle/thread/{thread_id}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述               | 是否必需 |
| :------------ | :----- | :------- | :------------------------ |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段 | 类型 | 描述                |
| :--- | :--- | :------------------ |
| `code` | Number  | 环信超级社区的服务状态码。 |

其它字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/XXX'
```

##### 响应示例

```json
{
    "code": 200
    "id" : "1895600",
    "msgId" : "198008034121000",
    "channelId" : "156009089",
    "owner" : "user1",
    "created" : 1650856033420
}
```

### 删除子区

删除指定的子区。

#### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/circle/thread/{thread_id}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段 | 类型 | 描述                |
| :--- | :--- | :------------------ |
| code | Number  | 环信超级社区的服务状态码。 |

其它字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/XXX'
```

##### 响应示例

```json
{
    "code": 200
}
```

### 加入子区

加入指定的子区。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/circle/thread/{thread_id}/user/join?userId={user_id}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

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
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/XXX/user/join?userId=XXX'
```

##### 响应示例

```json
{
  "code" : 200
}
```

### 将成员移出子区

将成员移出指定的子区。

#### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/circle/thread/{thread_id}/user/remove?userId={user_id}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | 内容类型。请填 `application/json`。                           | 是       |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

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
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/XXX/user/remove?userId=XXX'
```

##### 响应示例

```json
{
  "code" : 200
}
```

### 用户获取自己创建的子区

用户获取自己创建的子区。

#### HTTP 请求

获取第一页：

```http
GET https://{host}/{org_name}/{app_name}/circle/thread/created?userId={user_id}&channelId={channel_id}
```

分页获取：

```shell
GET https://{host}/{org_name}/{app_name}/circle/thread/created?userId={user_id}&channelId={channel_id}&limit={limit}&cursor={cursor}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       |
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段    | 类型 | 描述                       |
| :------ | :--- | :------------------------- |
| `code`    | Number  | 环信超级社区的服务状态码。        |
| `threads` | List | 获取到的子区详情列表。 |
| `count`   | Number  | 获取到的子区数量。     |

其它字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/created?userId=XXX&channelId=XXX'
```

分页获取：

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/created?userId=XXX&channelId=XXX&limit=1&cursor=XXX'
```

##### 响应示例

```json
{
  "code" : 200,
  "threads" : [
    {
      "id" : "1895600",
      "msgId" : "198008034121000",
      "channelId" : "156009089",
      "owner" : "user1",
      "created" : 1650856033420
    }
    ],
     "cursor" : "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aW06ZGlzY29yZDo2MjI0MjEwMiM5MDoy"
}
```

### 用户获取频道中的子区

用户获取频道中的子区。

#### HTTP 请求

获取第一页：

```http
GET https://{host}/{org_name}/{app_name}/circle/thread/list?channelId={channel_id}
```

分页获取：

```shell
curl -X GET https://{host}/{org_name}/{app_name}/circle/thread/list?channelId={channel_id}&limit={limit}&cursor={cursor}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       | 

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段    | 类型 | 描述                       |
| :------ | :--- | :------------------------- |
| `code`    | Number  | 环信超级社区的服务状态码。        |
| `threads` | List | 获取到的子区详情列表。 |
| `count`   | Number  | 获取到的子区数量。     |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/list?channelId=XXX'
```

分页获取：

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/list?channelId=XXX&limit=1&cursor=XXX'
```

##### 响应示例

```json
{
  "code" : 200,
  "threads" : [
    {
       "id" : "1895600",
       "msgId" : "198008034121000",
       "channelId" : "156009089",
       "owner" : "user1",
       "created" : 1650856033420
    }
    ],
     "cursor" : "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aW06ZGlzY29yZDo2MjI0MjEwMiM5MDoy"
}
```

### 用户获取频道中加入的子区

用户获取频道中加入的子区。

#### HTTP 请求

获取第一页：

```http
GET https://{host}/{org_name}/{app_name}/circle/thread/joined?userId={user_id}&channelId={channel_id}
```

分页获取：

```http
GET https://{host}/{org_name}/{app_name}/circle/thread/joined?userId={user_id}&channelId={channel_id}&limit={limit}&cursor={cursor}
```

##### 路径参数

参数及描述详见[公共参数](#param)。

##### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 | 
| :------------ | :----- | :------- | :----------------------------------------------------------- |
| `Accept`        | String | 内容类型。请填 `application/json`。                           | 是       | 
| `Authorization` | String | 该管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       | 

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段    | 类型 | 描述                       |
| :------ | :--- | :------------------------- |
| `code`    | Number  | 环信超级社区的服务状态码。        |
| `threads` | List | 获取到的子区详情列表。 |
| `count`   | Number  | 获取到的子区数量。     |

其他字段及描述详见[公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/joined?userId={user_id}&channelId=XXX'
```

分页获取：

```shell
将 <YourAppToken> 替换为你在服务端生成的 App 权限 Token
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/joined?userId={user_id}&channelId=XXX&limit=1&cursor=XXX'
```

##### 响应示例

```json
{
  "code" : 200,
  "threads" : [
    {
        "id" : "1895600",
        "msgId" : "198008034121000",
        "channelId" : "156009089",
        "owner" : "user1",
        "created" : 1650856033420
    }
    ],
     "cursor" : "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aW06ZGlzY29yZDo2MjI0MjEwMiM5MDoy"
}
```

