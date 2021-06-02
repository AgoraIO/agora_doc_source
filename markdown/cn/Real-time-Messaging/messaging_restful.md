---
title: 消息发送 RESTful API
platform: All Platforms
updatedAt: 2021-03-22 10:30:54
---
## 认证

<div class="alert note">如果你使用 basic HTTP 认证，则可以通过服务端使用任意用户 ID 发送点对点消息或频道消息。如果你使用 Token 认证，则只能通过服务端使用生成 RTM Token 时使用的用户 ID 发送点对点消息或频道消息。</div>

### Basic HTTP 认证

离线推送 RESTful API 仅支持 HTTPS 协议。发送请求时，你需要提供 `api_key:api_secret` 通过 Basic HTTP 认证并填入 HTTP 请求头部的 Authorization 字段：

- `api_key`: Customer ID （客户 ID）
- `api_secret`: Customer Certificate （客户证书）

你可以在控制台的 [RESTful API](https://console.agora.io/restfulApi) 页面找到你的 Customer ID 和 Customer Certificate。具体生成 `Authorization` 字段的方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。

### Token 认证

如果你已经在服务端生成了 RTM Token，你也可以选用 token 认证。你需要在发送 HTTP 请求时在 HTTP 请求头部的 `x-agora-token` 字段和 `x-agora-uid` 字段分别填入：

- 服务端生成的 RTM Token。
- 生成 RTM Token 时使用的 uid。

#### 示例代码

下面的 Java 示例代码展示了如何实现 token 认证。

```java
Request request = new Request.Builder()
...
// 在 HTTP 请求头部的 x-agora-token 字段填入获取的 RTM Token
.addHeader("x-agora-token", "<Your RTM Token>")
// 在 HTTP 请求头部的 x-agora-uid 字段填入用于生成该 RTM Token 的 uid
.addHeader("x-agora-uid", "<Your uid used to generate the RTM Token>")
...
```

<div class="alert note">关于如何生成 RTM Token，详见<a href="https://docs.agora.io/cn/Real-time-Messaging/rtm_token?platform=All20%Platforms">校验用户权限</a>。</div>

## 数据格式

所有的请求都发送给域名：`api.agora.io`。

- 请求：请求的格式详见下面各个 API 中的示例
- 响应：响应内容的格式为 JSON
- 基本 URL：`https://api.agora.io/dev/v2/project/<appid>`

<div class="alert note"><code>&lt;appid&gt;</code> 是你的 RTM 项目使用的 <a href="https://docs.agora.io/cn/Agora20%Platform/terms?platform=All20%Platforms#appid">App ID</a>。所有的请求 URL 和请求包体内容都是区分大小写的。</div>


## 发送点对点消息 API

- 方法：POST
- 接入点：`/rtm/users/<user_id>/peer_messages`

通过服务端发送点对点消息。你不需要对发送消息的用户进行登录操作。

### 调用频率限制

对于每个 App ID，发送点对点消息 API 的调用频率上限是 500 次每秒。

### 调用时序

下图展示了应用服务端向 RTM SDK 发送点对点消息的流程。

#### `wait_for_ack` 参数设为 `true` 且接收端在线

![](https://web-cdn.agora.io/docs-files/1594276592219)

#### `wait_for_ack` 参数设为 `false`

![](https://web-cdn.agora.io/docs-files/1594276600436)


### 参数

#### URL 参数

此 API 需要在 URL 中传入以下参数。

| 参数      | 类型   | 描述                                                         |
| :-------- | :----- | :----------------------------------------------------------- |
| `user_id` | String | RTM 系统中发送点对点消息的用户 ID。最大长度为 64 个可见字符。不能是空字符串。以下为支持的字符集范围:<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>空格（如果用户 ID 中含有空格则不能和信令 SDK 互通）</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ",","'"</li></ul><div class="alert note">作为 URL 参数，<code>user_id</code> 开头和结尾的字符不能是空格。</div> |

#### 查询参数

此 API 需要传入以下查询参数。

| 参数           | 类型    | 描述                                                         |
| :------------- | :------ | :----------------------------------------------------------- |
| `wait_for_ack` | Boolean | （可选）此 API 是否等到 Agora RTM 系统确认消息投递成功之后再返回响应。默认为 `false`。<ul><li>`true`：代表此 API 会等到 Agora RTM 系统确认消息投递成功之后再返回响应。如果消息投递成功会返回 `“message delivered”`。</li><li>`false`：代表此 API 会在 Agora RTM 系统收到消息后立即返回响应，而不会确认消息是否投递成功。如果消息发送成功会返回 `“message sent”`。</li></ul> |

#### 请求包体参数

该 API 需要在请求包体中传入以下参数。

| 参数                          | 类型    | 描述                                                         |
| :---------------------------- | :------ | :----------------------------------------------------------- |
| `destination`                 | String  | RTM 系统中接收点对点消息的用户 ID。最大长度为 64 个可见字符。不能是空字符串。以下为支持的字符集范围:<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>空格（如果用户 ID 中含有空格则不能和信令 SDK 互通）</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ",","'"</li></ul>|
| `enable_offline_messaging`    | Boolean | （可选）是否开启离线消息。默认值是 `false`。<ul><li>`true`: 开启离线消息。如果在你发送消息时，接收消息的用户不在线，消息服务器会保存这条消息。接收消息的用户登录之后会收到此消息。每个接收端最多保存 200 条离线消息，最长保存七天。当保存的离线消息超出限制时，最新的消息会替换最老的消息。</li><li>`false`: 不开启离线消息。</li></ul> |
| `enable_historical_messaging` | Boolean | **（暂不支持）**（可选）是否保存为历史消息。默认值是 `false`。<ul><li>`true`：保存为历史消息。你可以使用[实时消息 RESTful API](https://docs.agora.io/cn/Real-time-Messaging/rtm_get_event?platform=All20%Platforms#历史消息-api) 查询历史消息。</li><li>`false`: 不保存为历史消息。</li></ul> |
| `payload`                     | String  | 点对点消息内容。不能为空字符串，长度最大 32 KB。             |

#### 响应包体参数

该 API 在响应包体中返回以下参数：

| 参数         | 类型   | 描述                                                         |
| :----------- | :----- | :----------------------------------------------------------- |
| `result`     | String | 请求结果。<ul><li>`"success"`：请求成功。</li><li>"failed"：请求失败。</li></ul>      |
| `request_id` | String | 标识此次请求的唯一 ID。                                      |
| `code`       | String | 消息发送状态。<ul><li>`"message_sent"`: 消息已发送。</li><li>`"message_delivered"`: 接收端已收到消息。</li><li>`"peer_offline"`: 接收端离线。</li></ul> |



### 请求示例

- 请求 URL：
	```
	https://api.agora.io/dev/v2/project/<appid>/rtm/users/userA/peer_message?wait_for_ack=true
	```
	```
	https://api.agora.io/dev/v2/project/<appid>/rtm/users/userA/peer_message?wait_for_ack=false
	```

- `Content-type` 为 `application/json;charset=utf-8`

- `Authorization` 可以是 Basic HTTP 认证或 Token 认证，生成方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。

- 请求包体内容

```json
{
    "destination": "userB",
    "enable_offline_messaging": false,
    "enable_historical_messaging": false,
    "payload": "Hello"
}
```

###  响应示例

消息已发送：

```json
{
    "result": "success",
    "request_id": "123",
    "code": "message_sent"
}
```

接收端已收到消息：

```json
{
    "result": "success",
    "request_id": "123",
    "code": "message_delivered"
}
```

接收端离线：

```json
{
    "result": "success",
    "request_id": "123",
    "code": "peer_offline"
}
```

## 发送频道消息 API

- 方法：POST
- 接入点：`/rtm/users/<user_id>/channel_messages`

通过服务端发送频道消息。你不需要对发送消息的用户进行登录和加入频道操作。

### 调用频率限制

对于每个 App ID，发送频道消息 API 的调用频率上限是 1000 次每秒。

### 参数

#### URL 参数

此 API 需要在 URL 中传入以下参数。

| 参数      | 类型   | 描述                                                         |
| :-------- | :----- | :----------------------------------------------------------- |
| `user_id` | String | RTM 系统中发送频道消息的用户 ID。最大长度为 64 个可见字符。不能是空字符串。以下为支持的字符集范围:<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>空格（如果用户 ID 中含有空格则不能和信令 SDK 互通）</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ",","'"</li></ul><div class="alert note">作为 URL 参数，<code>user_id</code> 开头和结尾的字符不能是空格。</div> |

#### 请求包体参数

该 API 需要在请求包体中传入以下参数：

| 参数                          | 类型    | 描述                                                         |
| :---------------------------- | :------ | :----------------------------------------------------------- |
| `channel_name`                | String  | 接收频道消息的 RTM 频道名。最大长度为 64 个可见字符。不能是空字符串。以下为支持的字符集范围:<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>空格（如果用户 ID 中含有空格则不能和信令 SDK 互通）</li><li>"!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "\|", "~", ",","'"</li></ul> |
| `enable_historical_messaging` | Boolean | **（暂不支持）**（可选）是否保存为历史消息。默认值是 `false`。<ul><li>`true`：保存为历史消息。你可以使用[实时消息 RESTful API](https://docs.agora.io/cn/Real-time-Messaging/rtm_get_event?platform=All20%Platforms#历史消息-api) 查询历史消息。</li><li>`false`: 不保存为历史消息。</li></ul> |
| `payload`                     | String  | 频道消息内容。不能为空字符串，长度最大 32 KB。               |

#### 响应包体参数

该 API 在响应包体中返回以下参数：

| 参数         | 类型   | 描述                                                    |
| :----------- | :----- | :------------------------------------------------------ |
| `result`     | String | 请求结果。<ul><li>`"success"`：请求成功。</li><li>`"failed"`：请求失败。</li></ul> |
| `request_id` | String | 标识此次请求的唯一 ID。                                 |

### 请求示例

- 请求 URL：
	```
	https://api.agora.io/dev/v2/project/<appid>/rtm/users/userA/channel_messages
	```

- `Content-type` 为 `application/json;charset=utf-8`

- `Authorization` 可以是 Basic HTTP 认证或 Token 认证，生成方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。

- 请求包体内容

```json
{
    "channel_name":"channelA",
    "enable_historical_messaging": false,
    "payload": "Hello"
}
```

### 响应示例

```json
{
	"result": "success",
	"request_id": "123"
}
```
	
## 响应状态码

| 状态码 | 描述                               |
| :----- | :--------------------------------- |
| 200    | 请求成功。                         |
| 400    | 请求参数错误，请根据返回提示检查。 |
| 401    | 用户权限错误。                     |
| 408    | 服务器请求超时，建议稍后重试。     |
| 500    | 服务器内部错误。                   |