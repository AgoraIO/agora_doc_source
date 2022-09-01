关于回调设置相关的 API 主要是回调储存详情描述查询和发送后回调停止后补发回调存储信息。

## 认证方式

~458499a0-7908-11ec-bcb4-b56a01c83d2e~

### 查询回调储存详情接口描述

查询 App Key 下由于异常（比如链接超时，响应超时，回调规则封禁等）回调失败时存储的消息和事件类型集合，按每十分钟一个 date key 存储，然后用户可以根据消息集合按需拉取。

#### 功能限制说明

- 异常存储过期时间默认 3 天，若有存储需及时补发。
- 补发重试次数建议控制在 10 次以内。

#### 认证方式

即时通讯 RESTful API 要求 Bearer HTTP 认证。每次发送 HTTP 请求时，都必须在请求头部填入如下 Authorization 字段：

Authorization：`Bearer ${YourAppToken}`

为提高项目的安全性，使用 token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯 RESTful API 仅支持使用 App Token 的鉴权方式，详见 [使用 Token 鉴权](https://docs-im.easemob.com/ccim/authentication)。

#### 基本信息

方法：`GET`

接入点： `/{orgName}/{appName}/callbacks/storage/info`

#### 路径参数

| 参数      | 类型   | 是否必需 | 描述                                       |
| :-------- | :----- | :------- | :----------------------------------------- |
| `orgName` | String | 是       | 你在环信 IM 管理后台注册的组织唯一标识。   |
| `appName` | String | 是       | 你在环信 IM 管理后台注册的 App 唯一标识 。 |

#### 请求头

| 参数            | 类型   | 是否必需 | 描述                                     |
| :-------------- | :----- | :------- | :--------------------------------------- |
| `Authorization` | String | 是       | 鉴权 Token，管理员 Token（含）以上权限。 |

#### 响应参数

| 参数              | 类型   | 描述                                                         |
| :---------------- | :----- | :----------------------------------------------------------- |
| `path`            | string | 请求路径。                                                   |
| `uri`             | string | 请求路径的 URI。                                             |
| `timestamp`       | long   | 环信 IM 服务器接收到此消息的 Unix 时间戳，单位为毫秒。       |
| `organization`    | string | 你在环信 IM 管理后台注册的组织唯一标识。                     |
| `application`     | string | 你在环信 IM 管理后台注册的 App 唯一标识。                    |
| `action`          | string | 请求方法。                                                   |
| `duration`        | long   | 请求耗时，单位为毫秒。                                       |
| `applicationName` | string | 你在环信 IM 管理后台注册的 App 名称。                        |
| `data`            | object | 响应数据内容。包括以下三个参数：`date`、`size` 和 `retry`。  |
| `date`            | String | 代表本次可以发送的补发的一个十分钟 date key，key 为十分钟的起点。 |
| `size`            | Int    | 本时段消息数量。                                             |
| `retry`           | Int    | 开发者已经重试补发的次数。考虑到补发也可能失败，服务器会继续存储。最开始是 0。 |

#### 请求示例

```shell
curl -X GET 'http://a1.easemob.com/easemob-demo/easeim/callbacks/storage/info' \
-H 'Authorization: Bearer {{token}}'
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

### 补发回调存储信息

调用接口根据存储集合进行回调补发。

#### 基本信息

方法：`POST`

接入点： `http://{host}/{orgName}/{appName}/callbacks/storage/retry`

#### 路径参数

| 参数      | 类型   | 是否必需 | 描述                                      |
| :-------- | :----- | :------- | :---------------------------------------- |
| `orgName` | String | 是       | 你在环信 IM 管理后台注册的组织唯一标识。  |
| `appName` | String | 是       | 你在环信 IM 管理后台注册的 App 唯一标识。 |

#### 请求头

| 参数            | 类型   | 是否必需 | 描述                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | 是       | 内容类型，请填 `application/json`。                          |
| `Authorization` | String | 是       | 鉴权 App Token 的值。详见[使用 token 鉴权](https://docs-im.easemob.com/ccim/authentication)。 |

#### 请求体

| 参数        | 类型   | 是否必需 | 描述                                                         |
| :---------- | :----- | :------- | :----------------------------------------------------------- |
| `date`      | String | 是       | 可以补发的一个十分钟 date key，key 为十分钟的起点。          |
| `retry`     | Int    | 否       | 开发已重试的次数。考虑到补发也可能失败，服务器会继续存储。最开始是 0。 |
| `targetUrl` | String | 否       | 补发消息的回调地址，如果为空，则使用原回调规则的回调地址。   |

#### 响应参数

| 参数           | 类型   | 描述                                                         |
| :------------- | :----- | :----------------------------------------------------------- |
| `path`         | String | 请求路径。                                                   |
| `uri`          | String | 请求路径的 URI。                                             |
| `timestamp`    | long   | 环信 IM 服务器接收到此消息的 Unix 时间戳，单位为毫秒。       |
| `organization` | String | 你在环信 IM 管理后台注册的组织唯一标识。                     |
| `application`  | String | 你在环信 IM 管理后台注册的 app 唯一标识。                    |
| `action`       | String | 请求方法。                                                   |
| `data`         | Bool   | - `success`：成功；<br/> - `failure`：失败。                 |
| `duration`     | long   | 请求耗时，单位为毫秒。                                       |
| `retry`        | Int    | 开发者已经重试补发的次数。考虑到补发也可能失败，服务器会继续存储。最开始是 0。 |

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

#### 响应码说明

| 状态码 | 描述                               |
| :----- | :--------------------------------- |
| 200    | 请求成功。                         |
| 400    | 请求参数错误，请根据返回提示检查。 |
| 401    | 用户权限错误。                     |
| 403    | 服务未开通或权限不足。             |
| 429    | 单位时间内请求过多。               |
| 500    | 服务器内部错误。                   |