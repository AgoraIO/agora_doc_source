# 推送标签管理

即时通讯服务支持通过设置标签自定义推送用户，实现精准推送。标签用于描述用户的生活习惯、兴趣爱好、行为特征等信息。对用户设置标签后，推送消息时，指定某一推送标签，即可向该标签下的用户发送消息。例如，可以为一些用户打上“时尚弄潮儿”标签后，可定期向该人群推送国内外潮流品牌的相关信息。

你可以通过 RESTful API 进行标签管理。用户与标签是多对多的关系，即一个用户可以有多个标签，一个标签下也可以有多个用户。

本文档主要介绍如何调用即时推送 RESTful API 实现创建及管理推送标签。调用以下方法前，请先参考[限制条件](./agora_chat_limitation)了解即时通讯 RESTful API 的调用频率限制。

<a name="param"></a>

## 公共参数

### 请求参数

| 参数       | 类型   | 描述                    | 是否必需 | 
| :--------- | :----- |:------------- | :------- | 
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。 | 是     | 
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。| 是     | 
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。 | 是    | 
| `username` | String | 用户 ID。          | 是     | 

### 响应参数

| 参数         | 类型     | 描述           |
| :----------| :----------- | :----------------- |
| `timestamp` | Number      | 响应的 Unix 时间戳，单位为毫秒。 |
| `duration`  | Number      | 从发送请求到响应的时长，单位为毫秒。 |

## 认证方式

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

## 创建推送标签

为推送的目标用户添加标签，对用户进行分组，实现精细化推送。当前最多可创建 100 个推送标签。如需提升该上限，请联系 [sales@agora.io](mailto:sales@agora.io)。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/push/label
```
#### 路径参数

参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述      | 是否必需 | 
| :-------------- | :----- | :------- | :---------- |
| `Content-Type`  | String | 内容类型：`application/json`   | 是   | 
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是    | 
 
#### 请求 body

| 字段          | 类型   | 描述       | 是否必需 | 
| :------------ | :------- | :----- | :--------------- |
| `name`        | String | 要创建的推送标签的名称，不能超过 64 个字符。支持以下字符集：<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>"\_", "-", "."</li></ul><div class="alert note"><li>区分大小写，因此 `Aa` 和 `aa` 为两个标签名称。<li>同一个 app 下，标签名称必须唯一。</div>          | 是     | 
| `description` | String | 推送标签的描述，不能超过 255 个字符。 | 否     | 

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型   | 描述     |
| :-------- | :----- | :-------- |
| `data` | JSON | 推送标签的数据。 |
| `name` | String | 推送标签的名称。 |
| `description` | String | 推送标签的描述。 |
| `createdAt` | Number | 推送标签的创建时间。该时间为 Unix 时间戳，单位为毫秒。 |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -L -X POST 'http://XXXX/XXXX/XXXX/push/label' \
-H 'Authorization: Bearer <YourAppToken>' \
-H 'Content-Type: application/json' \
--data-raw '{
    "name":"post-90s",
    "description":"hah"
}'
``` 

#### 响应示例

```json
{
    "timestamp": 1648720341157,
    "data": {
        "name": "post-90s",
        "description": "hah",
        "createdAt": 1648720341118
    },
    "duration": 13
}
```

## 查询指定的推送标签

查询指定的推送标签。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/push/label/{labelname}
```

#### 路径参数

| 参数        | 类型   | 描述       | 是否必需 | 
| :---------- | :------- | :----- | :------------- |
| `labelname` | String | 要查询的推送标签的名称。 | 是     | 

其他参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述      | 是否必需 | 
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是    | 

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型   | 描述     |
| :-------- | :----- | :-------- |
| `data` | JSON | 推送标签的数据。 |
| `name` | String | 推送标签的名称。 |
| `description` | String | 推送标签的描述。 |
| `count` | Number | 该推送标签下的用户数量。 |
| `createdAt` | Number | 推送标签的创建时间。该时间为 Unix 时间戳，单位为毫秒。 |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例
 
```shell
curl -L -X GET 'http://XXXX/XXXX/XXXX/push/label/90' \
-H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "timestamp": 1648720562644,
    "data": {
        "name": "90",
        "description": "hah",
        "count": 0,
        "createdAt": 1648720341118
    },
    "duration": 0
}
```

## 分页查询推送标签

分页查询推送标签。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/push/label
```

#### 路径参数

参数及描述详见[公共参数](#param)。

#### 查询参数

| 参数     | 类型   | 描述   | 是否必需 | 
| :------- | :------- | :----- | :----------------------- |
| `limit`  | Number | 每页显示的推送标签的数量，取值范围为 [1,100]，默认为 `100`。 | 否   | 
| `cursor` | String | 数据查询的起始位置。           | 否  | 

#### 请求 header

| 参数            | 类型   | 描述      | 是否必需 | 
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是     | 

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型   | 描述     |
| :-------- | :----- | :-------- |
| `data` | JSON Array | 推送标签的数据。 |
| `name` | String | 推送标签的名称。 |
| `description` | String | 推送标签的描述。 |
| `count` | Number | 该推送标签下的用户数量。 |
| `createdAt` | Number | 推送标签的创建时间。该时间为 Unix 时间戳，单位为毫秒。 |

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```
curl -L -X GET 'http://XXXX/XXXX/XXXX/push/label' \
-H 'Authorization: Bearer <YourAppToken>'
```

### 响应示例

```
{
    "timestamp": 1648720425599,
    "data": [
        {
            "name": "post-90s",
            "description": "hah",
            "count": 0,
            "createdAt": 1648720341118
        },
        {
            "name": "post-80s",
            "description": "post-80s generation",
            "count": 0,
            "createdAt": 1647512525642
        }
    ],
    "duration": 1
}
```

## 删除指定的推送标签

删除指定的推送标签。每次只能删除单个推送标签。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/push/label/{labelname}
```

#### 路径参数

| 参数        | 类型   | 描述       | 是否必需 | 
| :---------- | :------- | :----- | :------------- |
| `labelname` | String | 要删除的推送标签的名称。 | 是     | 

其他参数及描述详见[公共参数](#param)。

#### 请求 header 

| 参数            | 类型   | 描述   | 是否必需 | 
| :------------- | :----- | :------- | :--------------- |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是     | 

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型   | 描述     |
| :-------- | :----- | :-------- |
| `data` | String | `success` 表示推送标签成功删除。 | 

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -L -X DELETE 'http://XXXX/XXXX/XXXX/push/label/post-90s' \
-H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "timestamp": 1648721097405,
    "data": "success",
    "duration": 0
}
```

## 在推送标签下添加用户 

为用户分配指定的推送标签。单个标签最多可包含 200,000 个用户，每次最多可添加 100 个用户。若需提升上限，可联系 <a href="mailto:sales@agora.io">sales@agora.io</a>。</div>

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/push/label/{labelname}/user
```

#### 路径参数

| 参数        | 类型   | 描述       | 是否必需 | 
| :---------- | :------- | :----- | :------------- |
| `labelname` | String | 推送标签的名称。 | 是     | 

其他参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述   | 是否必需 | 
| :------------- | :----- | :------- | :--------------- |
| `Content-Type`  | String | 内容类型：`application/json`        | 是     | 
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是     | 

#### 请求 body

| 字段        | 类型 | 描述                         | 是否必需 |
| :---------- | :------- | :--- | :---------------------------- |
| `usernames` | List | 推送标签下的用户 ID 列表，最多可传 100 个用户 ID。 | 是     |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型   | 描述     |
| :-------- | :----- | :-------- |
| `data` | JSON | 用户添加结果。 |
| `success` | List | 列明成功添加的用户 ID。|
| `fail` | JSON | 返回的用户添加失败的结果，为键值对格式，其中 key 为添加失败的用户 ID，value 为失败原因。|

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```
curl -L -X POST 'http://XXXX/XXXX/XXXX/push/label/post-90s/user' \
-H 'Authorization: Bearer <YourAppToken>' \
-H 'Content-Type: application/json' \
--data-raw '{
    "usernames":["hx1","hx2"]
}'
```

### 响应示例

```
{
    "timestamp": 1648721496345,
    "data": {
        "success": [
            "hx1",
            "hx2"
        ],
        "fail": {}
    },
    "duration": 18
}
```

## 查询指定标签下的指定用户

查询推送标签是否存在指定用户。若存在，返回该用户的用户 ID 以及为该用户添加标签的时间；若不存在则不返回这些信息。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/push/label/{labelname}/user/{username}
```

#### 路径参数

| 参数        | 类型   | 描述       | 是否必需 | 
| :---------- | :------- | :----- | :------------- |
| `labelname` | String | 推送标签的名称。 | 是     |
| `username`    | String | 要查询的用户 ID。 | 是     | 

其他参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述   | 是否必需 | 
| :------------- | :----- | :------- | :--------------- |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是     | 

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型   | 描述     |
| :-------- | :----- | :-------- |
| `data` | JSON | 用户数据。 |
| `username` | String | 要查询的用户 ID。 |
| `created` | Number | 添加用户的 Unix 时间戳，单位为毫秒。| 

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -L -X GET 'http://XXXX/XXXX/XXXX/push/label/post-90s/user/hx1' \
-H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "timestamp": 1648721589676,
    "data": {
        "username": "hx1",
        "created": 1648721496324
    },
    "duration": 1
}
```

## 分页查询指定标签下的用户

分页查询指定标签下包含的用户。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/push/label/{labelname}/user
```

#### 路径参数

| 参数        | 类型   | 描述       | 是否必需 | 
| :---------- | :------- | :----- | :------------- |
| `labelname` | String | 推送标签的名称。 | 是     |

其他参数及描述详见[公共参数](#param)。

#### 查询参数

| 字段     | 类型   | 描述           | 是否必需 |
| :------- | :------- | :----- | :----------------------- |
| `limit`  | String | 每次查询的用户数量，取值范围为 [1,100]，默认为 `100`。 | 否   |
| `cursor` | String | 数据查询的起始位置。           | 否   |

#### 请求 header

| 参数            | 类型   | 描述       | 是否必需 | 
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是     | 

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型   | 描述     |
| :-------- | :----- | :-------- |
| `cursor` | String | 下次查询的起始位置。 |
| `data` | JSON Array | 获得的用户的数据。 |
| `username` | String | 获得的该标签下的用户 ID。 |
| `created` | Number | 添加用户的 Unix 时间戳，单位为毫秒。| 

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -L -X GET 'http://XXXX/XXXX/XXXX/push/label/post-90s/user?limit=1' \
-H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "timestamp": 1648721736670,
    "cursor": "ZWFzZW1vYjpwdXNoOmxhYmVsOmN1cnNvcjo5NTkxNTMwMDM4ODQxMzgwMjc",
    "data": [
        {
            "username": "hx1",
            "created": 1648721496324
        }
    ],
    "duration": 1
}
```

## 批量移出指定推送标签下的用户

一次移除指定推送标签下的单个或多个用户。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/push/label/{labelname}/user
```

#### 路径参数

| 参数        | 类型   | 描述          | 是否必需 |
| :---------- | :------- | :----- | :------------- |
| `labelname` | String | 推送标签的名称。 | 是     |

其他参数及描述详见[公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述              | 是否必需 | 
| :-------------- | :----- | :------- | :----------- |
| `Content-Type`  | String | 内容类型。填入 `application/json`。        | 是     |
| `Authorization` | String | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 | 是     | 

#### 请求 body

| 字段        | 类型 | 描述        | 是否必需 | 
| :---------- | :------- | :--- | :-------------------------- |
| `usernames` | List | 要移出标签的用户 ID 列表，最多可传 100 个用户 ID。 | 是   | 

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段       | 类型   | 描述     |
| :-------- | :----- | :-------- |
| `data` | JSON | 用户移出标签的结果。 |
| `Success` | List | 被移出标签的用户 ID。 |
| `fail` | JSON | 返回的用户移出标签失败的结果，为键值对格式，其中 key 为移出失败的用户 ID，value 为失败原因。 | 

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -L -X DELETE 'http://XXXX/XXXX/XXXX/push/label/post-90s/user' \
-H 'Authorization: Bearer <YourAppToken>' \
-H 'Content-Type: application/json' \
--data-raw '{
    "usernames":["hx1","hx2"]
}'
```

#### 响应示例

```json
{
    "timestamp": 1648722018636,
    "data": {
        "success": [
            "hx1",
            "hx2"
        ],
        "fail": {}
    },
    "duration": 1
}
```