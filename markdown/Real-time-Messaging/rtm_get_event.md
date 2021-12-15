---
title: 事件与历史消息查询 RESTful API
platform: All Platforms
updatedAt: 2021-03-02 07:26:07
---

实时消息 RESTful API 目前支持查询用户事件和频道事件。

<div class="alert note">厂商事件查询 RESTful API 的 qps 限制为：单厂商每秒 10 次。</div>

> 除本文外，你也可以查看我们全新的交互式 API 文档[实时消息 RESTful API](https://agoradoc.github.io/cn/Real-time-Messaging/restfulapi/) ![](https://web-cdn.agora.io/docs-files/1583736328279)。你可以通过切换 **Example Value** 和 **Schema** 标签页查看各 API 请求和响应包体的示例代码和参数说明。

## <a name="auth"></a>认证

实时消息 RESTful API 仅支持 HTTPS 协议。你可以使用以下任意一种认证方式：

- [Basic HTTP 认证](#basicauth)
- [Token 认证](#tokenauth)

### <a name="basicauth"></a>Basic HTTP 认证

发送请求时，你需要提供 `api_key:api_secret` 通过 Basic HTTP 认证并填入 HTTP 请求头部的 Authorization 字段：

- `api_key`: Customer ID
- `api_secret`: Customer Certificate

你可以在控制台的 [RESTful API](https://console.agora.io/restful) 页面找到你的 Customer ID 和 Customer Certificate。具体生成 `Authorization` 字段的方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。

### <a name="tokenauth"></a>Token 认证

如果你已经在服务端生成了 RTM Token，你也可以选用 token 认证。你需要在发送 HTTP 请求时在 HTTP 请求头部的 `x-agora-token` 字段和 `x-agora-uid` 字段分别填入：

- 服务端生成的 RTM Token。
- 生成 RTM Token 时使用的 uid。

**示例代码**

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

> 关于如何生成 RTM Token，详见[校验用户权限](https://docs.agora.io/cn/Real-time-Messaging/rtm_token?platform=All%20Platforms)。

## 数据格式

所有的请求都发送给域名：`api.agora.io`。

- Base URL:

```
https://api.agora.io/dev/v2/project/<appid>/
```

- Content-type： `application/json;charset=utf-8`
- Authorization： 详见：[认证](#auth)。
- 请求：请求的格式详见下面各个 API 中的示例。
- 响应：响应内容的格式为 JSON。

> 所有的请求 URL 和请求包体内容均区分大小写。

## <a name="get"></a>获取用户上下线事件 API

该方法从 Agora RTM 服务器指定的地址获取用户上下线事件。

- 方法：GET
- 接入点：~/rtm/vendor/user_events
- 请求 URL：

```
https://api.agora.io/dev/v2/project/<appid>/rtm/vendor/user_events
```

### `get` 响应包体示例

```json
{
    "result": "success",
    "request_id" : "10116762670167749259",
    "events" : [event]
}
```

| 参数         | 类型   | 描述                |
| :----------- | :----- | :------------------ |
| `result`     | string | 本次请求结果。      |
| `request_id` | string | 本次请求唯一的 ID。 |
| `events`     | JSON   | 用户登录登出事件。  |

### `event` 事件包体示例

```json
{
  "user_id": "rtmtest_RTM_4852_4857w7%",
  "type": "Login",
  "ts": 1578027420761
}
```

| 参数      | 类型   | 描述                                                                                    |
| :-------- | :----- | :-------------------------------------------------------------------------------------- |
| `user_id` | string | 本次事件对应的用户名。                                                                  |
| `type`    | string | 事件类型：<li>Login: 用户登录（上线）事件，</li><li>Logout: 用户登出（下线）事件。</li> |
| `ts`      | int    | 时间戳（ms）。                                                                          |

> - RTM 后台最多存储 2000 条事件。
> - 单次返回最多 1000 条事件。
> - 我们对事件按区域缓存，因此不保证来自不同区域的事件的事件顺序的正确性。
> - 我们只在同一区域内同步事件，不在区域间同步。所以，你从某区域拉取了事件后，如果你从另一个区域再次拉取仍然会得到相同的事件。

### 错误码

| 错误码 | 描述                                         |
| :----- | :------------------------------------------- |
| 408    | 服务器请求超时或服务器无响应，建议稍后重试。 |

## 获取频道登入登出事件 API

- 方法：GET
- 接入点：~/rtm/vendor/channel_events
- 请求 URL：

```
https://api.agora.io/dev/v2/project/<appid>/rtm/vendor/channel_events
```

### `get` 响应包体示例

```json
{
    "result": "success",
    "request_id" : "10116762670167749259",
    "events" : [event]
}
```

| 参数         | 类型   | 描述                |
| :----------- | :----- | :------------------ |
| `result`     | string | 本次请求结果。      |
| `request_id` | string | 本次请求唯一的 ID。 |
| `events`     | JSON   | 加入退出频道事件。  |

### `event` 事件包体示例

```json
{
    "channel_id": "example_channel_id"
    "user_id": "rtmtest_RTM_4852_4857w7%",
    "type" : "Join",
    "ts" : 1578027418981
}
```

| 参数         | 类型   | 描述                                                                          |
| :----------- | :----- | :---------------------------------------------------------------------------- |
| `channel_id` | string | 本次事件对应的频道名。                                                        |
| `user_id`    | string | 本次事件对应的用户名。                                                        |
| `type`       | string | 事件类型：<li>Join: 用户加入频道事件，</li><li>Leave: 用户离开频道事件。</li> |
| `ts`         | int    | 时间戳（ms）。                                                                |

> - RTM 后台最多存储 2000 条事件。
> - 单次返回最多 1000 条事件。
> - 我们对事件按区域缓存，因此不保证来自不同区域的事件的事件顺序的正确性。
> - 我们只在同一区域内同步事件，不在区域间同步。所以，你从某区域拉取了事件后，如果你从另一个区域再次拉取仍然会得到相同的事件。

### 错误码

| 错误码 | 描述                                         |
| :----- | :------------------------------------------- |
| 408    | 服务器请求超时或服务器无响应，建议稍后重试。 |
