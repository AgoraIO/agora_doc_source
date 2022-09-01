关于回调设置相关的 API 主要是回调储存详情描述查询和补发回调存储信息。

## 认证方式

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

<a name="pubparam"></a>
## 公共参数

以下表格列举了即时通讯 RESTful API 的公共请求参数和响应参数。

### 请求参数

| 参数       | 类型   | 描述                                                         | 是否必填 |
| :--------- | :----- | :----------------------------------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。 | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过 [Agora 控制台](https://console.agora.io/)获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat)。 | 是       |
| `username` | String | 用户名。用户的唯一登录账号。长度在 64 字节内，不可设置为空。支持以下字符集：<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字 0-9</li><li>"_", "-", "."</li></ul>注意：<ul><li>该参数不区分大小写，因此 `Aa` 和 `aa` 为相同用户名。</li><li>请确保同一个 app 下，`username` 唯一。</li></ul> | 是       |

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
| `entities.uuid`      | String  | 用户的 UUID。系统为该请求中的用户生成唯一内部标识，无需关注。 |
| `entities.type`      | String  | 对象类型。无需关注。                                         |
| `entities.created`   | Long  | 注册用户的 Unix 时间戳（毫秒）。                             |
| `entities.modified`  | Long  | 最近一次修改用户属性的 Unix 时间戳（毫秒）。                 |
| `entities.username`  | String  | 用户 ID。用户登录的唯一账号。                                |
| `entities.activated` | Boolean | 用户是否为活跃状态：<ul><li>`true`：用户为活跃状态。</li><li>`false`：用户为封禁状态。</li></ul> |
| `timestamp`          | Long  | 响应的 Unix 时间戳（毫秒）。                                 |
| `duration`           | Number  | 从发送请求到响应的时长（毫秒）。                             |

## 查询回调储存详情

查询 App Key 下由于异常（比如链接超时，响应超时，回调规则封禁等）回调失败时存储的消息和事件类型集合，按每十分钟一个 date key 存储，然后用户可以根据消息集合按需拉取。

> 异常存储过期时间默认 3 天，若有存储需及时补发。
> 补发重试次数建议控制在 10 次以内。

### HTTP 请求

```http
GET /{orgName}/{appName}/callbacks/storage/info
```

#### 路径参数

详见 [公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 是否必需 | 描述                                     |
| :-------------- | :----- | :------- | :--------------------------------------- |
| `Authorization` | String | 是       | `Bearer {YourAppToken}` |

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 200，表示请求成功。

| 参数              | 类型   | 描述                                                         |
| :---------------- | :----- | :----------------------------------------------------------- |
| `data`            | object | 响应数据内容。包括以下三个参数：`date`、`size` 和 `retry`。  |
| `date`            | String | 代表本次可以发送的补发的一个十分钟 date key，key 为十分钟的起点。 |
| `size`            | Int    | 本时段消息数量。                                             |
| `retry`           | Int    | 开发者已经重试补发的次数。考虑到补发也可能失败，服务器会继续存储。最开始是 0。 |

其他详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X GET 'http://a1.easemob.com/easemob-demo/easeim/callbacks/storage/info' \
-H 'Authorization: Bearer {YourAppToken}'
```

#### 响应示例

```json
{
    "path": "/callbacks",
    "uri": "http://a1.easemob.com/easemob-demo/easeim/callbacks",
    "timestamp": 1631193031254,
    "organization": "easemob-demo",
    "application": "8dfb1641-b6d8-450b-bbe9-d8d45a3be39f",
    "action": "post",
    "data": [
        {
            "date": "202109091440",
            "size": 15,
            "retry": 0
        },
        {
            "date": "202109091450",
            "size": 103,
            "retry": 1
        }
    ],
    "duration": 153,
    "applicationName": "easeim"
}
```

## 补发回调存储信息

调用接口根据存储集合进行回调补发。

### HTTP 请求

```shell
POST http://{host}/{orgName}/{appName}/callbacks/storage/retry
```

#### 路径参数

详见 [公共参数](#pubparam)。

#### 请求 header

| 参数            | 类型   | 是否必需 | 描述                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | 是       | 内容类型，请填 `application/json`。                          |
| `Authorization` | String | 是       | 鉴权 App Token 的值。详见[使用 token 鉴权](https://docs-im.easemob.com/ccim/authentication)。 |

#### 请求 body

| 参数        | 类型   | 是否必需 | 描述                                                         |
| :---------- | :----- | :------- | :----------------------------------------------------------- |
| `date`      | String | 是       | 可以补发的一个十分钟 date key，key 为十分钟的起点。          |
| `retry`     | Int    | 否       | 开发已重试的次数。考虑到补发也可能失败，服务器会继续存储。最开始是 0。 |
| `targetUrl` | String | 否       | 补发消息的回调地址，如果为空，则使用原回调规则的回调地址。   |

#### 响应参数

如果返回的 HTTP 状态码为 200，表示请求成功。

| 参数           | 类型   | 描述                                                         |
| :------------- | :----- | :----------------------------------------------------------- |
| `data`         | Bool   | <li>`success`：成功；<li>`failure`：失败。                 |
| `retry`        | Int    | 开发者已经重试补发的次数。考虑到补发也可能失败，服务器会继续存储。最开始是 0。 |

其他详见 [公共参数](#pubparam)。

如果返回的 HTTP 状态码不是 200，则表示请求失败。你可以参考[状态码汇总表](#code)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -X POST 'http://a1.easemob.com/easemob-demo/easeim/callback/storage/retry' \
-H 'Authorization: Bearer {{token}}' \
-H 'Content-Type: application/json' \
--data-raw '{
    "date": "202108272230",
    "retry": 0,
    "targetUrl": "http://localhost:8000/test"
}'
```

#### 响应示例

```json
{
    "path": "/callbacks",
    "uri": "http://a1.easemob.com/easemob-demo/easeim/callbacks",
    "timestamp": 1631194031721,
    "organization": "easemob-demo",
    "application": "8dfb1641-b6d8-450b-bbe9-d8d45a3be39f",
    "action": "post",
    "data": "success",
    "duration": 225,
    "applicationName": "easeim"
}
```

## 状态码

有关详细信息，请参阅 [HTTP 状态代码](./agora_chat_status_code?platform=RESTful)。