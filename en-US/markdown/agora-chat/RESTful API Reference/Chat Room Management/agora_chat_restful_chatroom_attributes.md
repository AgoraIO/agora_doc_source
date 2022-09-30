# Manage Chat Room Attributes

This page shows how to manage custom attributes by calling Agora Chat RESTful APIs, including adding, removing, modifying, and retrieving attributes that are stored as key0-value maps.

Before calling the following methods, ensure that you understand the frequency limit of calling Agora Chat RESTful API calls described in [Limitations](./agora_chat_limitation).

## <a name="param"></a>Common parameters

The following table lists common request and response parameters of the Agora Chat RESTful APIs:

### Request parameters

| Parameter | Type | Description | Required |
| :--------- | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service.  For how to get the org name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `username` | String | The unique login account of the user. The username must be 64 characters or less and cannot be empty.  The following character sets are supported:<li>26 lowercase English letters (a-z)</li><li>26 uppercase English letters (A-Z)</li><li>10 numbers (0-9)</li><li>"\_", "-", "."</li><div class="alert note"><ul><li>The username is case insensitive, so `Aa` and `aa` are the same username. </li><li>Ensure that each username under the same app must be unique.</li></ul></div> | Yes |


### Response parameters

| Parameter | Type | Description |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action` | String | The request method. |
| `organization` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. This is the same as `org_name`. |
| `application` | String | A unique internal ID assigned to each app by the Agora Chat service. You can safely ignore this parameter. |
| `applicationName` | String | The unique identifier assigned to each app by the Agora Chat service. This is the same as `app_name`. |
| `uri` | String | The request URI. |
| `entities ` | JSON | The response entity. |
| `data` | JSON | The details of the response. |
| `timestamp` | Number | The Unix timestamp (ms) of the HTTP response. |
| `duration` | Number | The duration (ms) from when the HTTP request is sent to the time the response is received. |


## Authorization

~e838c3b0-8e43-11ec-814c-17df6c7c3801~

## Set a custom attribute

指定用户设置指定聊天室自定义属性。

Sets the custom attributes of 

### HTTP request

```http
PUT https://{host}/{org_name}/{app_name}/metadata/chatroom/{chatroom_id}/user/{username}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| 参数    | 类型   |是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Content-Type`  | String | 是    | 内容类型。请填 `application/json`。 |
| `Accept`   | String | 是    | 内容类型。请填 `application/json`。 |
|`Authorization`| String | 是    | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。|

#### Request body

| 参数          | 类型   | 是否必需 | 说明                                                 |
| :------------ | :----- | :------- | :--------------------------------------------------- |
| `metaData`        | JSON | 是     | 聊天室的自定义属性，存储为键值对（key-value）集合，即 Map<String,String>。该集合中最多可包含 10 个键值对，在每个键值对中，key 为属性名称，最多可包含 128 个字符；value 为属性值，不能超过 4086 个字符。每个聊天室最多可有 100 个自定义属性，每个应用的聊天室自定义属性总大小为 10 GB。
  <br/> key 支持以下字符集：
   <li>26 个小写英文字母 a-z；
   <li>26 个大写英文字母 A-Z；
   <li>10 个数字 0-9；
   <li>“_”, “-”, “.”。 |
| `autoDelete` | String | 否     | 当前成员退出聊天室时是否自动删除该自定义属性。 <li>（默认）'DELETE'：是； <li>'NO_DELETE'：否。              |

### HTTP response

#### Response body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段          | 类型    | 说明                                                         |
| :------------ | :------ | :----------------------------------------------------------- |
| `data.successKeys`   | Array | 设置成功的聊天室属性名称列表。 |
| `data.errorKeys` | Object | 设置失败的聊天室属性。这里返回键值对，key 为属性名称，value 为失败原因。 |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### Example

#### Request example

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

#### Response example

```json
{
  "data":
  {
    "successKeys": ["key1"],
	  "errorKeys": {"key2":"errorDesc"},
  }
}
```

## Retrieve a custom attribute

获取指定聊天室的自定义属性信息。

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/metadata/chatroom/{chatroom_id}
```

#### Path parameter

参数及说明详见 [公共参数](#param)。

#### Request header

| 参数    | 类型   |是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Content-Type`  | String | 是    | 内容类型。请填 `application/json`。 |
| `Accept`   | String | 是    | 内容类型。请填 `application/json`。 |
|`Authorization`| String | 是    | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。|

#### Request body

| 参数          | 类型   | 是否必需 | 说明                                                 |
| :------------ | :----- | :------- | :--------------------------------------------------- |
| `keys`        | Array | 否     | 聊天室自定义属性名称列表。              |

### HTTP response

#### Response body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段          | 类型    | 说明                                                         |
| :------------ | :------ | :----------------------------------------------------------- |
| `data`   | Object | 聊天室自定义属性，为键值对格式，key 为属性名称，value 为属性值。 |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### Example

#### Request example

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 AppToken
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' -d '{
    "keys": ["key1","key2"]
 }' 'http://XXXX/XXXX/XXXX/metadata/chatroom/662XXXX13'
```

#### Response example

```json
{
  "data":
  {
    "key1": "value1",
		"key2": "value2"
  }
}
```

## Remove a custom attribute

指定用户删除指定聊天室设置的自定义属性。该方法不覆盖其他成员设置的自定义属性。

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/metadata/chatroom/{chatroom_id}/user/{username}
```

#### Path parameter

参数及说明详见 [公共参数](#param)。

#### Request header

| 参数    | 类型   |是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Content-Type`  | String | 是    | 内容类型。请填 `application/json`。 |
| `Accept`   | String | 是    | 内容类型。请填 `application/json`。 |
|`Authorization`| String | 是    | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。|

#### Request body

| 参数          | 类型   | 是否必需 | 说明                                                 |
| :------------ | :----- | :------- | :--------------------------------------------------- |
| `keys`        | Array | 否     | 聊天室自定义属性名称列表。              |

### HTTP response

#### Response body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段          | 类型    | 说明                                                         |
| :------------ | :------ | :----------------------------------------------------------- |
| `data.successKeys`   | Array | 成功删除的聊天室属性名称列表。 |
| `data.errorKeys` | Object | 删除失败的聊天室属性。这里返回键值对，key 为属性名称，value 为失败原因。 |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### Example

#### Request example

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 AppToken
DELETE -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' -d '{
    "keys": ["key1","key2"]
 }' 'http://XXXX/XXXX/XXXX/metadata/chatroom/662XXXX13/user/user1'
```

#### Response example

```json
{
  "data":
  {
    "successKeys": ["key1"],
	  "errorKeys": {"key2":"errorDesc"}
  }
}
```


## Force to set a custom attribute

指定用户强制设置指定聊天室的自定义属性信息，即该方法可覆盖其他用户设置的聊天室自定义属性。

### HTTP request

```http
PUT https://{host}/{org_name}/{app_name}/metadata/chatroom/{chatroom_id}/user/{username}/forced
```

#### Path parameter

参数及说明详见 [公共参数](#param)。

#### Request header

| 参数    | 类型   |是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Content-Type`  | String | 是    | 内容类型。请填 `application/json`。 |
| `Accept`   | String | 是    | 内容类型。请填 `application/json`。 |
|`Authorization`| String | 是    | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。|

#### Request body

| 参数          | 类型   | 是否必需 | 说明                                                 |
| :------------ | :----- | :------- | :--------------------------------------------------- |
| `metaData`    | JSON | 是     | 聊天室的自定义属性，存储为键值对（key-value pair）集合，即 Map<String,String>。该集合中最多可包含 10 个键值对，在每个键值对中，key 为属性名称，最多可包含 128 个字符；value 为属性值，不能超过 4086 个字符。每个聊天室最多可有 100 个自定义属性，每个应用的聊天室自定义属性总大小为 10 GB。
  <br/> key 支持以下字符集：
   <li>26 个小写英文字母 a-z；
   <li>26 个大写英文字母 A-Z；
   <li>10 个数字 0-9；
   <li>“_”, “-”, “.”。|
| `autoDelete` | String | 否     | 当前成员退出聊天室时是否自动删除该自定义属性。 <li>（默认）'DELETE'：是； <li>'NO_DELETE'：否。              |

### HTTP response

#### Response body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段          | 类型    | 说明                                                         |
| :------------ | :------ | :----------------------------------------------------------- |
| `data.successKeys`   | Array | 设置成功的聊天室属性名称列表。 |
| `data.errorKeys` | Object | 设置失败的聊天室属性。这里返回键值对，key 为属性名称，value 为失败原因。 |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### Example

#### Request example

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

#### Response example

```json
{
  "data":
  {
    "successKeys": ["key1"],
	  "errorKeys": {"key2":"errorDesc"}
  }
}
```


## Force to remove a custom attribute

指定用户强制删除指定聊天室的自定义属性信息，即该方法会删除其他用户设置的聊天室自定义属性。

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/metadata/chatroom/{chatroom_id}/user/{username}/forced
```

#### Path parameter

参数及说明详见 [公共参数](#param)。

#### Request header

| 参数    | 类型   |是否必需 | 描述      |
| :-------------- | :----- | :---------------- | :------- |
| `Content-Type`  | String | 是    | 内容类型。请填 `application/json`。 |
| `Accept`   | String | 是    | 内容类型。请填 `application/json`。 |
|`Authorization`| String | 是    | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 App Token 值。|

#### Request body

| 参数          | 类型   | 是否必需 | 说明                                                 |
| :------------ | :----- | :------- | :--------------------------------------------------- |
| `keys`        | Array | 否     | 聊天室自定义属性名称列表。              |

### HTTP response

#### Response body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段          | 类型    | 说明                                                         |
| :------------ | :------ | :----------------------------------------------------------- |
| `data.successKeys`   | Array | 成功删除的聊天室属性名称列表。 |
| `data.errorKeys` | Object | 删除失败的聊天室属性。这里返回键值对，key 为属性名称，value 为失败原因。 |

其他字段及说明详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### Example

#### Request example

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 AppToken
DELETE -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' -d '{
    "keys": ["key1","key2"]
 }' 'http://XXXX/XXXX/XXXX/metadata/chatroom/662XXXX13/user/user1/forced'
```

#### Response example

```json
{
  "data":
  {
    "successKeys": ["key1"],
	"errorKeys": {"key2":"errorDesc"}
  }
}
```

## <a name="code"></code> Status codes

有关详细信息，请参阅 [HTTP 状态代码](./agora_chat_status_code?platform=RESTful)。