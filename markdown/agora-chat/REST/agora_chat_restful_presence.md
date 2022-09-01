在线状态功能使用户可以公开显示其在线状态并快速确定其他人的状态。用户还可以自定义他们的在线状态，为实时聊天增添乐趣和多样性。

本页展示了如何使用即时通讯 IM RESTful API 在线状态订阅相关功能。

在调用以下方法之前，请了解即时通讯 IM 的 [使用限制](..cn/agora-chat/agora_chat_limitation?platform=RESTful#call-limit-of-server-side)。

在 [Agora 控制台](http://console.agora.io/) 中激活在线状态功能。

<a name="pubparam"></a>

## 公共参数

下表列出了即时通讯 IM RESTful API 的常用请求和响应参数。

### 请求参数

| 参数       | 类型   | 描述                                                                                                                                                                                                                                                                                                                | 是否必填 |
| :--------- | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | :------- |
| `host`     | String | 即时通讯 IM 服务分配的用于访问 RESTful API 的域名。获取域名的方法请参见[获取项目信息](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project)。                                                                                                       | 是       |
| `org_name` | String | 即时通讯 IM 服务分配给每个公司（组织）的唯一标识符。如何获取组织名称，请参见[获取项目信息](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project)。                                                                                                  | 是       |
| `app_name` | String | Agora 聊天服务分配给每个应用的唯一标识符。获取应用名称的方法请参见[获取项目信息](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project)。                                                                                                            | 是       |
| `username`      | String | 用户的唯一登录帐户。                                         |        |

### 响应参数

| 参数        | 类型   | 描述                           |
| :---------- | :----- | :----------------------------- |
| `data`      | JSON   | 返回的数据。                   |
| `timestamp` | Long   | HTTP 响应的 Unix 时间戳 (ms)。 |
| `username`  | String | 用户标识。                     |

## 认证方式 <a name="auth"></a>

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

## 设置用户的在线状态

设置用户的在线状态。

对于每个 App Key，此方法的调用频率限制为每秒 50 次。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/users/{uid}/presence/{resource}/{status}
```

#### 路径参数

| 参数      | 类型 | 描述                                                         | 是否必填|
| :--------- | :--- | :----------------------------------------------------------- | :----- |
| `resource` | String | 分配给每个设备资源的唯一标识符，格式为 `{Device Type}_{Resource ID}`，其中设备类型可以是 `android`、`ios` 或 `web`，后跟 SDK 分配的资源 ID。 | 是 |
| `status`   | String | 用户定义的在线状态：<li>`0`： 离线。<li>`1`： 在线。<li>其他字符串：自定义状态。 | 是 |

其他路径参数的说明详见 [公共参数](#pubparam)。

#### 请求 header

| 参数           | 类型 | 描述                                                         | 是否必填|
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Content-Type`  | String | 内容类型。将其设置为`application/json`。                     | 是 |
| `Authorization` | String | `Bearer ${token}` | 是 |

#### 请求 body

| 参数 | 类型 | 描述                                               | 是否必填|
| :---- | :--- | :------------------------------------------------- | :----- |
| `ext` | String | 在线状态的扩展信息。扩展字段的大小最大为 64 字节。 | 是 |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应 body 中的 data 字段包含以下参数：

| 参数        | 类型   | 描述        |
| :------- | :--- | :----------------------------------------------------------- |
| `result` | String | 在线状态设置是否成功。`ok` 表示出席设置成功；否则，您可以根据退回的原因进行故障排除。 |

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X POST 'a1-test.agora.com:8089/5101220107132865/test/users/c1/presence/android_123423453246/0' \
-H 'Authorization: Bearer YWMtnjEbUopPEeybKGMmN0wpeZsaLSh8UEgpirS4wNAM_qx8oS2wik8R7LE4Rclv5hu9AwMAAAF-4tr__wBPGgDWGAeO86wl2lHGeTnU030fpWuEDR015Vk6ULWGYGKccA' \
-H 'Content-Type: application/json' \
-d '{"ext":"123"}'
```

#### 响应示例

```json
{"result":"ok"}%
```

## 订阅多个用户的在线状态

订阅多个用户的在线状态。

对于每个 App Key，此方法的调用频率限制为每秒 50 次。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/users/{uid}/presence/{expiry}
```

#### 路径参数

| 参数        | 类型   | 描述        | 是否必填 |
| :------- | :--- | :--------------------------------------------------------- | :----- |
| `expiry` | String | 订阅持续时间（以秒为单位）。最大值为 2,592,000，即 30 天。 | 是   |

其他字段说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数           | 类型 | 描述                                                         | 是否必填|
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Content-Type`  | String | 内容类型。将其设置为 `application/json`。                     | 是 |
| `Authorization` | String | `Bearer ${token}` | 是 |

#### 请求 body

| 参数       | 类型      | 描述                                                         | 是否必填|
| :---------- | :-------- | :----------------------------------------------------------- | :----- |
| `usernames` | JSON | 订阅的用户列表，例如 `[“user1”, “user2”]`。此列表最多可包含 100 个用户 ID。 | 是 |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应 body 中的 data 字段包含以下参数：

| 参数       | 类型      | 描述                                                         |
| :---------- | :-------- | :----------------------------------------------------------- |
| `result`    | JSON | 订阅是否成功。如果成功，则返回用户的在线状态；否则，您可以根据退回的原因进行故障排除。 |
| `uid`       | String      | 用户的唯一登录帐户。                                         |
| `last_time` | Long      | 用户上次在线时的 Unix 时间戳。                               |
| `expiry`    | Long      | 订阅到期时的 Unix 时间戳。                                   |
| `ext`       | String      | 在线状态的扩展信息。                                         |
| `status`    | JSON 数组 | 用户在多个设备上的在线状态。<li>`0`： 离线。<li>`1`： 在线的。<li>其他字符串：用户定义的自定义在线状态。 |

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X POST 'a1-test.agora.com:8089/5101220107132865/test/users/wzy/presence/1000' \
-H 'Authorization: Bearer YWMtnjEbUopPEeybKGMmN0wpeZsaLSh8UEgpirS4wNAM_qx8oS2wik8R7LE4Rclv5hu9AwMAAAF-4tr__wBPGgDWGAeO86wl2lHGeTnU030fpWuEDR015Vk6ULWGYGKccA' \
-H 'Content-Type: application/json' \
-d '{"usernames":["c2","c3"]}'
```

#### 响应示例

```json
{"result":[{"uid":"","last_time":"1644466063","expiry":"1645500371","ext":"123","status":{"android":"1","android_6b5610ac-4e11-4661-82b3-dee17bc7b2cc":"0"}},{"uid":"c3","last_time":"1645183991","expiry":"1645500371","ext":"","status":{"android":"0","android_6b5610ac-4e11-4661-82b3-dee17bc7b2cc":"0"}}]}%
```

## 获取应用下的所有子区

获取应用程序下的所有子区。

对于每个 App Key，此方法的调用频率限制为每秒 50 次。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/users/{uid}/presence
```

#### 路径参数

路径参数的说明详见 [公共参数](#pubparam)。

#### 请求 header

| 参数           | 类型 | 描述                                                         | 是否必填|
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Content-Type`  | String | 内容类型。将其设置为`application/json`。                     | 是 |
| `Authorization` | String | `Bearer ${token}` | 是 |

#### 请求 body

| 参数       | 类型      | 描述                                                         | 是否必填|
| :---------- | :-------- | :----------------------------------------------------------- | :----- |
| `usernames` | JSON 数组 | 需要获取其在线状态的用户列表，例如 `[“user1”, “user2”]`。此列表最多可包含 100 个用户 ID。 | 是 |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应 body 中的 data 字段包含以下参数：

| 参数    | 类型 | 描述                                                         |
| :------- | :--- | :----------------------------------------------------------- |
| `result` | String | 在线状态设置是否成功。`ok` 表示设置成功；否则，根据退回的原因进行故障排除。 |

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

| 参数       | 类型      | 描述                                                         |
| :---------- | :-------- | :----------------------------------------------------------- |
| `result`    | JSON 数组 | 操作是否成功。如果成功，则返回用户的在线状态；否则，您可以根据退回的原因进行故障排除。 |
| `uid`       | String      | 用户的唯一登录帐户。                                         |
| `last_time` | Long      | 用户上次在线时的 Unix 时间戳。                               |
| `ext`       | String      | 在线状态的扩展信息。                                         |
| `status`    | JSON 数组 | 用户在多个设备上的在线状态。<li>`0`： 离线。<li>`1`： 在线的。<li>其他字符串：用户定义的自定义在线状态。 |

### 示例

#### 请求示例

```shell
curl -X POST 'a1-test.agora.com:8089/5101220107132865/test/users/wzy/presence' \
-H 'Authorization: Bearer YWMtnjEbUopPEeybKGMmN0wpeZsaLSh8UEgpirS4wNAM_qx8oS2wik8R7LE4Rclv5hu9AwMAAAF-4tr__wBPGgDWGAeO86wl2lHGeTnU030fpWuEDR015Vk6ULWGYGKccA' \
-H 'Content-Type: application/json' \
-d '{"usernames":["c2","c3"]}'
```

#### 响应示例

```json
{
"result":[
  {"uid":"c2",
  "last_time":"1644466063",
  "ext":"",
  "status":{"android":"0"}
     },
   {"uid":"c3",
   "last_time":"1644475330",
   "ext":"",
   "status":{
       "android":"0",
       "android":"0"}
    }]
 }
```

## 取消订阅多个用户的在线状态

取消订阅多个用户的在线状态。

对于每个 App Key，此方法的调用频率限制为每秒 50 次。

### HTTP 请求

```http
DELETE https://{host}/{org_name}/{app_name}/users/{uid}/presence
```

#### 路径参数

路径参数的说明详见 [公共参数](#pubparam)。

#### 请求 header

| 参数           | 类型 | 描述                                                         | 是否必填|
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Content-Type`  | String | 内容类型。将其设置为`application/json`。                     | 是 |
| `Authorization` | String | `Bearer ${token}` | 是 |

#### 请求 body

| 参数   | 类型      | 描述                                                         | 是否必填|
| :------ | :-------- | :----------------------------------------------------------- | :----- |
| `users` | JSON 数组 | 取消订阅的用户列表，例如 `[“user1”, “user2”]`. 此列表最多可包含 100 个用户 ID。 | 是 |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应 body 中的 data 字段包含以下参数：

| 参数    | 类型 | 描述                                                         |
| :------- | :--- | :----------------------------------------------------------- |
| `result` | String | 取消订阅是否成功。`ok` 表示取消订阅成功；否则，您可以根据退回的原因进行故障排除。 |

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X DELETE 'a1-test.agora.com:8089/5101220107132865/test/users/wzy/presence' \
-H 'Authorization: Bearer YWMtnjEbUopPEeybKGMmN0wpeZsaLSh8UEgpirS4wNAM_qx8oS2wik8R7LE4Rclv5hu9AwMAAAF-4tr__wBPGgDWGAeO86wl2lHGeTnU030fpWuEDR015Vk6ULWGYGKccA' \
-H 'Content-Type: application/json' \
-d '["c1"]'
```

#### 响应示例

```json
{"result":"ok"}%
```

## 检索用户的订阅

在分页列表中检索用户的订阅。

对于每个 App Key，此方法的调用频率限制为每秒 50 次。

### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/users/{uid}/presence/sublist?pageNum=1&pageSize=100
```

#### 路径参数

| 参数      | 类型 | 描述                                        | 是否必填|
| :--------- | :--- | :------------------------------------------ | :----- |
| `pageNum`  | Number | 开始检索订阅的页面。在 `1` 第一次查询时传入。 | 是 |
| `pageSize` | Number | 每页检索的最大订阅数。范围是 [1, 500]。     | 是 |

其他路径参数的说明详见 [公共参数](#pubparam)。

#### 请求 header

| 参数           | 类型 | 描述                                                         | 是否必填|
| :-------------- | :--- | :----------------------------------------------------------- | :----- |
| `Content-Type`  | String | 内容类型。将其设置为`application/json`。                     | 是 |
| `Authorization` | String | `Bearer ${token}` | 是 |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，则请求成功，响应 body 中的 data 字段包含以下参数：

| 参数      | 类型 | 描述                                                         |
| :--------- | :--- | :----------------------------------------------------------- |
| `result`   | String | 检索操作是否成功。如果成功，则返回订阅信息；否则，您可以根据退回的原因进行故障排除。 |
| `totalnum` | String | 您订阅的用户总数。                                           |
| `sublist`  | Object | 订阅列表。列表中的每个对象都包含 `uid` 和 `expiry` 字段。        |
| `uid`      | String | 用户的唯一登录帐户。                                         |
| `expiry`   | String | 订阅到期时的 Unix 时间戳。                                   |

如果返回的 HTTP 状态码不是 `200`，则请求失败。你可以参考 [响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X GET 'a1-test.agora.com:8089/5101220107132865/test/users/wzy/presence/sublist?pageNum=1&pageSize=100' \
-H 'Authorization: Bearer YWMtnjEbUopPEeybKGMmN0wpeZsaLSh8UEgpirS4wNAM_qx8oS2wik8R7LE4Rclv5hu9AwMAAAF-4tr__wBPGgDWGAeO86wl2lHGeTnU030fpWuEDR015Vk6ULWGYGKccA' \
-H 'Content-Type: application/json'
```

#### 响应示例

```json
{"result":{"totalnum":"2","sublist":[{"uid":"lxml2","expiry":"1645822322"},{"uid":"lxml1","expiry":"1645822322"}]}}%
```

<a name="code"></code>

## 状态码

有关详细信息，请参阅 [HTTP 状态代码](./agora_chat_status_code?platform=RESTful)。