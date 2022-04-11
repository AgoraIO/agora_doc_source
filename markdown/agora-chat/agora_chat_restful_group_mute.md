禁言是指防止群组用户在群组中发送消息。Agora Chat 提供多个接口进行禁言管理，包括获取、添加、移除等。

本文展示如何调用 Agora 即时通讯 RESTful API 管理禁言列表。调用以下方法前，请先参考[限制条件](./agora_chat_limitation)了解即时通讯 RESTful API 的调用频率限制。

<a name="pubparam"></a>
## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述                                                         | 是否必填 |
| :--------- | :----- | :----------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。 | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。 | 是       |
| `username` | String | 用户名。用户的唯一登录账号。长度在 64 个字符内，不可设置为空。支持以下字符集：<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>"_", "-", "."</li></ul>注意：<ul><li>该参数不区分大小写，因此 `Aa` 和 `aa` 为相同用户名。</li><li>请确保同一个 app 下，`username` 唯一。</li></ul> | 是       |

### 响应参数

| 参数                 | 类型    | 描述                                                         |
| :------------------- | :------ | :----------------------------------------------------------- |
| `action`             | String  | 请求方式。                                                   |
| `organization`       | String  | 组织 ID，等同于 org_name，即时通讯服务分配给每个企业（组织）的唯一标识。 |
| `application`        | String  | 系统内为 app 生成的唯一内部标识，无需关注。                  |
| `applicationName`    | String  | App ID，等同于 app_name，即时通讯服务分配给每个 app 的唯一标识。 |
| `uri`                | String  | 请求 URL。                                                   |
| `path`               | String  | 请求路径，属于请求 URL 的一部分，无需关注。                  |
| `entities`           | JSON    | 返回实体信息。                                               |
| `data`               | Array   | 实际请求到的数据。                                           |
| `timestamp`          | Long  | 响应的 Unix 时间戳（毫秒）。                                 |
| `duration`           | Number  | 从发送请求到响应的时长（毫秒）。                             |

## 认证方式

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

## 添加禁言

将制定用户添加进禁言列表。用户被禁言后，会无法在群里发送消息。

### HTTP 请求

```json
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/mute
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

#### 请求 body

| 参数          | 类型  | 描述                      | 是否必填 |
| :------------ | :---- | :------------------------ | :------- |
| `mute_duration` | Long  | 禁言时间，单位为毫秒。    | 是       |
| `usernames`     | Array | 添加进禁言列表的用户 ID。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文。

| 参数   | 类型    | 描述                                        |
| :----- | :------ | :------------------------------------------ |
| `result` | Boolean | 添加禁言列表是否成功：<ul><li>`true`：成功</li><li>`false`：失败</li></ul> |
| `expire` | Long    | 禁言到期的 Unix 时间戳，单位为 ms。         |
| `user`   | String  | 被禁言的用户 ID。                           |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X POST -H 'Content-type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"usernames":["user1"], "mute_duration":86400000}' 'http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute",
    "entities": [],
    "data": [{
        "result": true,
        "expire": 1489158589481,
        "user": "user1"
    }],
    "timestamp": 1489072189508,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```


## 移除禁言

将指定用户从禁言列表中移除。移除后，该用户可以在群中正常发送消息。

### HTTP 请求

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/mute/{member_id}
```

#### 路径参数

| 参数      | 类型   | 描述                                                         | 是否必需 |
| :-------- | :----- | :----------------------------------------------------------- | :------- |
| `group_id`  | String | 群组 ID。                                                    | 是       |
| `member_id` | String | 群组成员 ID，如果有多个成员，则填入多个成员 ID，中间使用英文逗号隔开。如 {member1}, {member2} | 是       |

其他路径参数说明详见[公共参数](#pub_param)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文。

| 参数   | 类型    | 描述                                    |
| :----- | :------ | :-------------------------------------- |
| `result` | Boolean | 移除禁言是否成功：<ul><li>`true`: 成功</li><li>`false`：失败</li></ul> |
| `user`   | String  | 被移除禁言的用户 ID。                   |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute/user1'
```

#### 响应示例

```json
{
    "action": "delete",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute/user1",
    "entities": [],
    "data": [{
        "result": true,
        "user": "user1"
    }],
    "timestamp": 1489072695859,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 获取禁言列表

获取当前群组的禁言用户列表。

### HTTP 请求

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/mute
```

#### 路径参数

| 参数     | 类型   | 描述      | 是否必需 |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | 群组 ID。 | 是       |

其他路径参数说明详见[公共参数](#pubparam)。

#### 请求 header

| 参数          | 类型   | 描述                                                         | 是否必需 |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| 参数          | 类型   | 描述                                                         | 是否必需 |
| `Accept`  | String | 参数类型。填入 `application/json`                                   | 是       |
| `Authorization` | String | 该用户或管理员的鉴权 token，格式为 `Bearer ${token}`，其中 `Bearer` 是固定字符，后面加英文空格，再加获取到的 token 值。 | 是       |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功，响应 body 中 `data` 字段的说明见下文。

| 参数   | 类型   | 描述                          |
| :----- | :----- | :---------------------------- |
| `expire` | Long   | 禁言到期的时间戳，单位为 ms。 |
| `user`   | String | 被禁言的用户 ID。             |

其他字段说明详见[公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X GET -H 'Accept: application/json' 'http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute' -H 'Authorization: Bearer <YourAppToken>'
```

#### 响应示例

```json
{
    "action": "post",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/mute",
    "entities": [],
    "data": [{
        "expire": 1489158589481,
        "user": "user1"
    }],
    "timestamp": 1489072802179,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## 状态码汇总表

| 状态码              | 描述                                                         |
| :------------------ | :----------------------------------------------------------- |
| 200                 | 请求成功。                                                   |
| 401                 | 鉴权失败。可能的原因是缺少 token、token 错误或 token 过期。请重新获取 token 后再试。 |
| 404                 | 群组 ID 不存在。                                             |
| 429，503 或其他 5xx | 调用频率超出上限，请暂停并稍后重试。如果你有更高调用频率需求，请联系技术支持。 |
| 500                 | 服务器内部错误，无法完成请求，请联系技术支持。               |