本文展示如何调用即时通讯 RESTful API 实现聊天室自定义属性（KV）管理，包括创建、删除、修改、查询聊天室自定义属性。调用以下方法前，请先参考 [限制条件](https://confluence.agoralab.co/pages/viewpage.action?pageId=857605065)了解即时通讯 RESTful API 的调用频率限制。

## <a name="param"></a>公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数：

### 请求参数

| 参数       | 类型   | 描述                                                                                                                                                                                                                                                        | 是否必填 |
| :--------- | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                                              | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                                         | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 Agora 控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。                                                                                                                | 是       |
| `username` | String | 用户 ID。用户的唯一登录账号。长度在 64 个字符内，不可设置为空。支持以下字符集：<li>26 个小写英文字母 a-z<li>26 个大写英文字母 A-Z<li>10 个数字 0-9<li>"\_", "-", "."<div class="alert note"><ul><li>不区分大小写。<li>同一个 app 下，用户 ID 唯一。</ul></div> | 是       |

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
| `timestamp`       | Long   | HTTP 响应的 Unix 时间戳（毫秒）。                                 |
| `duration`        | Number | 从发送 HTTP 请求到响应的时长（毫秒）。                            |

## 认证方式

~e838c3b0-8e43-11ec-814c-17df6c7c3801~

## 设置聊天室自定义属性

指定用户设置指定聊天室自定义属性。

### HTTP 请求

```http
PUT https://{host}/{org_name}/{app_name}/metadata/chatroom/{chatroom_id}/user/{username}
```

#### 路径参数

参数及说明详见 [公共参数](#param)。

#### 请求 header

| 参数    | 类型   |是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Content-Type`  | String | 是    | 内容类型。请填 `application/json`。 |
| `Accept`   | String | 是    | 内容类型。请填 `application/json`。 |
|`Authorization`| String | 是    | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。|

#### 请求 body

| 参数          | 类型   | 是否必需 | 说明                                                 |
| :------------ | :----- | :------- | :--------------------------------------------------- |
| `metaData`        | JSON | 是     | 聊天室的自定义属性，存储为键值对（key-value）集合，即 Map<String,String>。该集合中最多可包含 10 个键值对，在每个键值对中，key 为属性名称，最多可包含 128 个字符；value 为属性值，不能超过 4086 个字符。每个聊天室最多可有 100 个自定义属性，每个应用的聊天室自定义属性总大小为 10 GB。
  <br/> key 支持以下字符集：
   <li>26 个小写英文字母 a-z；
   <li>26 个大写英文字母 A-Z；
   <li>10 个数字 0-9；
   <li>“_”, “-”, “.”。 |
| `autoDelete` | String | 否     | 当前成员退出聊天室时是否自动删除该自定义属性。 <li>（默认）'DELETE'：是； <li>'NO_DELETE'：否。              |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段          | 类型    | 说明                                                         |
| :------------ | :------ | :----------------------------------------------------------- |
| `data.successKeys`   | Array | 设置成功的聊天室属性名称列表。 |
| `data.errorKeys` | Object | 设置失败的聊天室属性。这里返回键值对，key 为属性名称，value 为失败原因。 |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 AppToken

curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' -d '{
    "metaData": {
        "key1": "value1",
		    "key2": "value2"
      },
    "autoDelete": "DELETE"
 }' 'http://XXXX/XXXX/XXXX/metadata/chatroom/662XXXX13/user/user1'
```

#### 响应示例

```json
{
  "data":
  {
    "successKeys": ["key1"],
	  "errorKeys": {"key2":"errorDesc"},
  }
}
```

## 获取聊天室自定义属性

获取指定聊天室的自定义属性信息。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/metadata/chatroom/{chatroom_id}
```

#### 路径参数

参数及说明详见 [公共参数](#param)。

#### 请求 header

| 参数    | 类型   |是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Content-Type`  | String | 是    | 内容类型。请填 `application/json`。 |
| `Accept`   | String | 是    | 内容类型。请填 `application/json`。 |
|`Authorization`| String | 是    | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。|

#### 请求 body

| 参数          | 类型   | 是否必需 | 说明                                                 |
| :------------ | :----- | :------- | :--------------------------------------------------- |
| `keys`        | Array | 否     | 聊天室自定义属性名称列表。              |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段          | 类型    | 说明                                                         |
| :------------ | :------ | :----------------------------------------------------------- |
| `data`   | Object | 聊天室自定义属性，为键值对格式，key 为属性名称，value 为属性值。 |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 AppToken

curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' -d '{
    "keys": ["key1","key2"]
 }' 'http://XXXX/XXXX/XXXX/metadata/chatroom/662XXXX13'
```

#### 响应示例

```json
{
  "data":
  {
    "key1": "value1",
		"key2": "value2"
  }
}
```

## 删除聊天室自定义属性

指定用户删除指定聊天室设置的自定义属性。该方法不覆盖其他成员设置的自定义属性。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/metadata/chatroom/{chatroom_id}/user/{username}
```

#### 路径参数

参数及说明详见 [公共参数](#param)。

#### 请求 header

| 参数    | 类型   |是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Content-Type`  | String | 是    | 内容类型。请填 `application/json`。 |
| `Accept`   | String | 是    | 内容类型。请填 `application/json`。 |
|`Authorization`| String | 是    | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。|

#### 请求 body

| 参数          | 类型   | 是否必需 | 说明                                                 |
| :------------ | :----- | :------- | :--------------------------------------------------- |
| `keys`        | Array | 否     | 聊天室自定义属性名称列表。              |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段          | 类型    | 说明                                                         |
| :------------ | :------ | :----------------------------------------------------------- |
| `data.successKeys`   | Array | 成功删除的聊天室属性名称列表。 |
| `data.errorKeys` | Object | 删除失败的聊天室属性。这里返回键值对，key 为属性名称，value 为失败原因。 |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 AppToken

DELETE -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' -d '{
    "keys": ["key1","key2"]
 }' 'http://XXXX/XXXX/XXXX/metadata/chatroom/662XXXX13/user/user1'
```

#### 响应示例

```json
{
  "data":
  {
    "successKeys": ["key1"],
	  "errorKeys": {"key2":"errorDesc"}
  }
}
```

## 强制设置聊天室自定义属性

指定用户强制设置指定聊天室的自定义属性信息，即该方法可覆盖其他用户设置的聊天室自定义属性。

### HTTP 请求

```http
PUT https://{host}/{org_name}/{app_name}/metadata/chatroom/{chatroom_id}/user/{username}/forced
```

#### 路径参数

参数及说明详见 [公共参数](#param)。

#### 请求 header

| 参数    | 类型   |是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Content-Type`  | String | 是    | 内容类型。请填 `application/json`。 |
| `Accept`   | String | 是    | 内容类型。请填 `application/json`。 |
|`Authorization`| String | 是    | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。|

#### 请求 body

| 参数          | 类型   | 是否必需 | 说明                                                 |
| :------------ | :----- | :------- | :--------------------------------------------------- |
| `metaData`    | JSON | 是     | 聊天室的自定义属性，存储为键值对（key-value pair）集合，即 Map<String,String>。该集合中最多可包含 10 个键值对，在每个键值对中，key 为属性名称，最多可包含 128 个字符；value 为属性值，不能超过 4086 个字符。每个聊天室最多可有 100 个自定义属性，每个应用的聊天室自定义属性总大小为 10 GB。
  <br/> key 支持以下字符集：
   <li>26 个小写英文字母 a-z；
   <li>26 个大写英文字母 A-Z；
   <li>10 个数字 0-9；
   <li>“_”, “-”, “.”。|
| `autoDelete` | String | 否     | 当前成员退出聊天室时是否自动删除该自定义属性。 <li>（默认）'DELETE'：是； <li>'NO_DELETE'：否。              |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段          | 类型    | 说明                                                         |
| :------------ | :------ | :----------------------------------------------------------- |
| `data.successKeys`   | Array | 设置成功的聊天室属性名称列表。 |
| `data.errorKeys` | Object | 设置失败的聊天室属性。这里返回键值对，key 为属性名称，value 为失败原因。 |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token

curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' -d '{
    "metaData": {
        "key1": "value1",
		    "key2": "value2"
      },
    "autoDelete": "DELETE"
 }' 'http://XXXX/XXXX/XXXX/metadata/chatroom/662XXXX13/user/user1/forced'
```

#### 响应示例

```json
{
  "data":
  {
    "successKeys": ["key1"],
	  "errorKeys": {"key2":"errorDesc"}
  }
}
```

## 强制删除聊天室自定义属性

指定用户强制删除指定聊天室的自定义属性信息，即该方法会删除其他用户设置的聊天室自定义属性。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/metadata/chatroom/{chatroom_id}/user/{username}/forced
```

#### 路径参数

参数及说明详见 [公共参数](#param)。

#### 请求 header

| 参数    | 类型   |是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Content-Type`  | String | 是    | 内容类型。请填 `application/json`。 |
| `Accept`   | String | 是    | 内容类型。请填 `application/json`。 |
|`Authorization`| String | 是    | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。|

#### 请求 body

| 参数          | 类型   | 是否必需 | 说明                                                 |
| :------------ | :----- | :------- | :--------------------------------------------------- |
| `keys`        | Array | 否     | 聊天室自定义属性名称列表。              |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段          | 类型    | 说明                                                         |
| :------------ | :------ | :----------------------------------------------------------- |
| `data.successKeys`   | Array | 成功删除的聊天室属性名称列表。 |
| `data.errorKeys` | Object | 删除失败的聊天室属性。这里返回键值对，key 为属性名称，value 为失败原因。 |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 AppToken

DELETE -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' -d '{
    "keys": ["key1","key2"]
 }' 'http://XXXX/XXXX/XXXX/metadata/chatroom/662XXXX13/user/user1/forced'
```

#### 响应示例

```json
{
  "data":
  {
    "successKeys": ["key1"],
	"errorKeys": {"key2":"errorDesc"}
  }
}
```

## <a name="code"></code> 状态码

有关详细信息，请参阅 [HTTP 状态代码](./agora_chat_status_code?platform=RESTful)。