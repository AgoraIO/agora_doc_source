即时通讯 IM 支持 HTTP 回调（Webhook）。对你的即时通讯应用设置 HTTP 回调后，即时通讯 IM 服务器会在事件发生时通过 HTTP POST 请求向你的应用服务器发送请求。你可以根据业务需求干预事件的后续处理流程（发送前回调），或据此进行必要的数据同步（发送后回调）。

## 技术原理

根据消息下发是否被干预，回调分为两类：

- 发送前回调：主要用于内容审核。当即时通讯 IM 服务器收到来自客户端 app 的消息时，会向你的应用服务器发送请求并等待响应，收到响应后决定是否下发消息。发送前回调仅适用于从你的客户端 app 发送的消息，不适用于通过 RESTful API 发送的消息。
- 发送后回调：主要用于数据同步。当某些事件发生时，例如用户发送消息或离线，即时通讯 IM 服务器会向你的应用服务器发送请求，并且不会验证响应内容。发送后回调适用于从你的客户端和服务端应用发送的消息及其他事件。

下表为两类回调的区别。

| 类别 | 发送前回调 | 发送后回调 |
| :------------ | :----- | :------------------------------- |
| 支持的平台 | 客户端 SDK | 客户端 SDK 和 RESTful API |
| 支持的事件 | 消息 | 消息和其他事件 |
| 是否需要响应 | 是 | 否 |
| 典型用例 | 内容审核 | 历史消息同步 |

### 发送前回调

下图展示了发送前回调的工作流程。

![发送前回调工作流程](https://web-cdn.agora.io/docs-files/1642478214940)

如图所示，发送前回调的工作流程如下：

1. 即时通讯 IM 服务器收到来自客户端 A 的消息。
2. 即时通讯 IM 服务器向你的应用服务器发送包含该消息信息的 HTTP 请求。
3. 你的应用服务器处理接收的数据并确定是否下发消息。
4. 你的应用服务器通过 HTTP 响应将是否下发与否的结果发送到即时通讯 IM 服务器。
5. 即时通讯 IM 服务器接收到 HTTP 响应并决定是否下发消息。
6. 若下发，即时通讯 IM 服务器将消息发送给客户端 B。

### 发送后回调

下图展示了发送后回调的工作流程。

![发送后回调工作流程](https://web-cdn.agora.io/docs-files/1642478242440)

如图所示，发送后回调的工作流程如下：

1. 即时通讯 IM 服务器从客户端或服务器收到消息或其他事件。
2. 即时通讯 IM 服务器向你的应用服务器发送包含消息或事件信息的 HTTP 请求。
3. 你的应用服务器向即时通讯 IM 服务器发送 HTTP 响应，表示收到回调。

## 前提条件

要使用 HTTP 回调，必须满足以下要求：

- 启用了即时通讯 IM 的声网项目。
- 了解 API 调用频率限制，详见[使用限制](./agora_chat_limitation?platform=RESTful#服务端接口调用频率限制)。
- 已订阅即时通讯 IM 进阶版或企业版套餐包，详见[管理套餐包](./agora_chat_pricing#管理套餐包)，并且在[声网控制台](https://console.agora.io/)开通 HTTP 回调功能。

<div class="alert note">若关闭 HTTP 回调功能，必须联系 <a href="mailto:support@agora.io">support@agora.io</a>，因为该操作会删除所有相关配置。</div>

## 配置回调规则

若要接收 HTTP 回调，你需在声网控制台配置发送前或发送后回调的规则。

1. 登录[声网控制台](https://console.agora.io)，在**项目管理**页面找到你的项目，然后点击**配置**。

2. 在**服务配置**页面找到 **即时通讯 IM**，点击 **配置**。

3. 在**功能配置** > **总览** 页面的 **消息功能** 区域开启 **消息回调**。

4. 在**功能配置** > **消息回调** 页面，单击 **添加回调规则**。

![](./images/enablechat/callback_add_rule.png)

5. 添加发送前回调规则。在 **发送前回调** 页签中设置下表中的字段，然后单击 **保存**。

| 字段           | 是否必填 | 描述                                                         |
| :----------------- | :------- | :----------------------------------------------------------- |
| 规则名称           |  是     | 规则名称。在一个项目下，每条规则都必须有一个唯一的名称。规则名称支持中英文，不能超过 32 个字符。                   |
| 会话类型           |  是     | 会话类型：<ul><li>单聊</li><li>群聊</li><li>聊天室</li></ul>  |
| 消息类型           |  是     | 消息类型，包括 文本、图片、视频、位置、语音、文件和自定义消息。      |
| 等待响应时间       |  是     | 即时通讯 IM 服务器等待 HTTP 响应的时间。默认值为 200，单位为毫秒。如果响应超时，即时通讯 IM 服务器将执行调用失败策略。                     |
| 调用失败时默认策略 | 是     | 当 HTTP 响应超时或返回错误时即时通讯 IM 服务器的操作。默认为**放行**，即正常下发消息。 |
| 消息拦截报错时显示 |  是     | 当消息被拦截时是否通知消息发送方：<ul><li> **报错**：通知发送者 SDK 消息发送失败，发送者会感知到消息发送失败；</li><li> **不报错**：不通知发送者 SDK 消息发送失败，发送者无感知。</li></ul> |
| 启用状态           |  是    | 是否启用回调规则：<ul><li>**启用**：启用后回调规则立即生效；<ul><li>**未启用**：回调规则为关闭状态，不生效。建议首次创建配置为**不启用**，等你的服务器配置验证信息后再修改为**启用**。</li></ul> |
| 回调地址           |  是     | 用于接收发送后回调的应用服务器的 URL，不能超过 512 字符。支持 HTTP 和 HTTPS 地址。       |
   
6. 添加发送后回调规则。在**发送后回调**页签中设置下表中的字段，然后单击**保存**。

| 字段           | 是否必填 | 描述                                                         |
| :----------------- | :------- | :----------------------------------------------------------- |
| 规则名称           |  是     | 规则名称。在一个项目下，每条规则都必须有一个唯一的名称。规则名称支持中英文，不能超过 32 个字符。                   |
| 回调服务           |  是     | 该规则适用的会话或事件类型：<ul><li>单聊</li><li>群聊</li><li>聊天室<ul><li>在线状态</li><li>消息撤回</li><li>ack事件</li><li>敏感词监测</li><li>好友关系操作</li><li>内容审核</li><li>群组和聊天室操作</li></ul>     |
| 消息类型           |  是     | 消息类型：<ul><li>聊天消息：上行消息；</li><li>离线消息：接收方离线时发送的消息。</li></ul>                   |
| 启用状态           |  是     | 是否启用回调规则：<ul><li>**启用**：启用后回调规则立即生效；</li><li>**未启用**：回调规则为关闭状态，不生效。</li></ul>                   |
| 回调地址           |  是     | 用于接收发送后回调的应用服务器的 URL，不能超过 512 字符。支持 HTTP 和 HTTPS 地址。                   |

<div class="alert info">发送前和发送后回调的注意事项如下：<ul><li>默认情况下，发送前和发送后回调规则总计最多能添加四个。若要添加更多规则，需[提交工单](https://agora-ticket.agora.io)。</li><li>规则配置仅支持消息事件。若要接收其他事件的通知，需[提交工单](https://agora-ticket.agora.io)。</li><li>如果你同时设置了发送前和发送后回调，若发送前回调触发后消息被拦截，则不会触发发送后回调。</li></ul></div>

## HTTP 请求和响应

本节介绍 HTTP 请求和响应的详细信息。

### HTTP 请求

当你的即时通讯 IM app 中发生某些事件时，即时通讯 IM 服务器会发送带有 JSON 有效负载的 HTTP POST 请求，字符编码为 UTF-8。所有 HTTP 请求头中的 `Content-Type` 字段都是 `application/json`。

有关支持的事件的详细信息，详见 [HTTP 回调事件](./agora_chat_receive_webhook)。

为了提升回调的安全性，即时通讯 IM 会在每个回调的请求体中添加一个签名。你可以通过验证签名确认回调是否来自即时通讯 IM 服务器。

要验证回调中的签名，参考以下步骤：

1. 获取下列信息：
   - 回调 ID，即回调请求体中的 `callId` 参数。
   - 分配给回调规则的密钥。你可以在 Agora 控制台的即时通讯 IM 配置页面找到该值。
    ![](./images/enablechat/postdelivery_callback_secret.png)
   - 回调时间戳，即回调请求体中的 `timestamp` 参数。
2. 计算由回调 ID、密钥和回调时间戳拼接的字符串的 [MD5](https://en.wikipedia.org/wiki/MD5) 值。
3. 检查计算的值是否与请求体中的 `secret` 参数相同。若相同，则表明回调由即时通讯 IM 发送。

### HTTP 响应

对于发送前回调，即时通讯 IM 服务器接受包含 JSON 正文的 HTTP 响应，如下例所示：

```json
{
    "valid": true,
    "code": "HX:10000"
}
```

- `valid`：布尔值。根据你的应用服务器上的处理结果明确消息是否有效：
   - `true`：消息有效，即时通讯 IM 服务器应下发该消息。
   - `false`：消息无效，即时通讯 IM 服务器应拦截该消息。
- `code`：字符串类型的自定义信息。

对于发送后回调，请确保响应内容不超过 1,000 个字符。

## 重试逻辑

- 对于发送前回调，如果你的应用服务器没有返回 HTTP 代码 200 和 `valid` 状态，则即时通讯 IM 服务器不会重新发送回调，并执行相应规则指定的调用失败策略。

- 对于发送后回调，即时通讯 IM 服务器会在下列情况下记录一次通知失败，并立即尝试重新发送回调：

   - 你的服务器在 60 秒内没有响应。
   - 从你的服务器收到的 HTTP 状态码不是 200。

   如果第二次尝试失败，即时通讯 IM 服务器将停止重试。如果 30 秒内发生 90 次通知失败，则相应的回调规则会自动禁用 5 分钟。要查询和补发错过的通知，请使用[查询和补发回调存储信息 API](#API)。

## 查询和补发回调存储信息<a name="API"></a>  

回调设置相关的 API 包括回调存储详情查询 API 和补发回调存储信息 API。

### 认证方式

即时通讯服务 RESTful API 要求 HTTP 身份验证。每次发送 HTTP 请求时，必须在请求 header 填入如下 `Authorization` 字段：

```http
Authorization: Bearer YourAppToken
```

为了提高项目的安全性，声网使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯服务 RESTful API 仅支持使用 app 权限 Token 对用户进行身份验证。详见[使用 App 权限 token 进行身份验证](./agora_chat_token?platform=RESTful)。

### 查询回调存储详情

查询 App Key 下由于异常（如链接超时、响应超时和回调规则封禁等）回调失败时存储的消息和事件类型集合，按每 10 分钟一个 date key 存储，然后用户可以根据消息集合按需拉取。

- 异常存储过期时间默认 3 天，若有存储需及时补发。
- 补发重试次数建议不超过 10 次。

#### HTTP 请求

```http
GET https://{host}/{org_name}/{app_name}/callbacks/storage/info
```

##### 路径参数

| 参数       | 类型   | 描述                | 是否必填 |
| :--------- | :----- | :---------------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是   |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是    |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是  |

##### 请求 header

| 参数            | 类型   | 是否必需 | 描述                                     |
| :-------------- | :----- | :------- | :--------------------------------------- |
| `Authorization` | String | 是       | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。|

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。响应包体中包含以下字段：

| 参数              | 类型   | 描述                                                         |
| :---------------- | :----- | :----------------------------------------------------------- |
| `path`               | String  | 请求路径，属于请求 URL 的一部分，无需关注。                  |
| `uri`                | String  | 请求 URL。                                                   |
| `timestamp`          | Number  | 响应的 Unix 时间戳，单位为毫秒。                                 |
| `organization`       | String  | 即时通讯服务分配给每个企业（组织）的唯一标识，与请求参数 `org_name` 相同。 |
| `application`        | String  | 系统内为 app 生成的唯一内部标识，无需关注。                  |
| `action`             | String  | 请求方式。                                                   |
| `data`            | JSON Array  | 响应数据内容。  |
| `data.date`       | String | 本次可以发送的补发的一个 10 分钟 date key，key 为 10 分钟的起始时间。 |
| `data.size`       | Number    | 本时段消息数量。                                             |
| `data.retry`      | Number    | 开发者已经重试补发的次数。考虑到补发也可能失败，服务器会继续存储。最开始是 0。 |
| `duration`           | Number  | 从发送请求到响应的时长，单位为毫秒。                             |
| `applicationName`    | String  | 即时通讯服务分配给每个 app 的唯一标识，与请求参数 `app_name` 相同。 |

如果返回的 HTTP 状态码不是 `200`，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

#### 示例

##### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X GET 'http://a1.easemob.com/easemob-demo/easeim/callbacks/storage/info' \
-H 'Authorization: Bearer <YourAppToken>'
```

##### 响应示例

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

可以调用该接口根据存储集合进行回调补发。

#### HTTP 请求

```http
POST http://{host}/{org_name}/{app_name}/callbacks/storage/retry
```

##### 路径参数

| 参数       | 类型   | 描述                 | 是否必填 |
| :--------- | :----- | :------------------------- | :------- |
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。你可以通过声网控制台获取该字段，详见[获取即时通讯项目信息](./enable_agora_chat?platform=RESTful#获取即时通讯项目信息)。 | 是       |

##### 请求 header

| 参数            | 类型   | 是否必需 | 描述                    |
| :---------- | :----- | :------- | :--------------- |
| `Content-Type`  | String | 是       | 内容类型，填入 `application/json`。                          |
| `Authorization` | String | 是       | App 管理员的鉴权 token，格式为 `Bearer YourAppToken`，其中 `Bearer` 为固定字符，后面为英文空格和获取到的 app 权限 token。 |

##### 请求 body

| 参数        | 类型   | 是否必需 | 描述                                                         |
| :---------- | :----- | :------- | :----------------------------------------------------------- |
| `date`      | String | 是       | 可以补发的一个 10 分钟 date key，key 为 10 分钟的起始时间。          |
| `retry`     | Number   | 否       | 开发者已重试的次数。考虑到补发也可能失败，服务器会继续存储。最开始是 0。 |
| `targetUrl` | String | 否       | 补发消息的回调地址，如果为空，则使用原回调规则的回调地址。   |

#### HTTP 响应

##### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功。

| 参数           | 类型   | 描述                                                         |
| :------------- | :----- | :----------------------------------------------------------- |
| `path`               | String  | 请求路径，属于请求 URL 的一部分，无需关注。                  |
| `uri`                | String  | 请求 URL。                                                   |
| `timestamp`          | Number  | 响应的 Unix 时间戳，单位为毫秒。                                 |
| `organization`       | String  | 即时通讯服务分配给每个企业（组织）的唯一标识，与请求参数 `org_name` 相同。 |
| `application`        | String  | 系统内为 app 生成的唯一内部标识，无需关注。                  |
| `action`             | String  | 请求方式。                                                   |
| `data`         | Boolean   | 补发是否成功：<ul><li>`success`：成功</li><li>`failure`：失败</li></ul>    |
| `duration`           | Number  | 从发送请求到响应的时长，单位为毫秒。                             |
| `retry`        | Number    | 开发者已经重试补发的次数。考虑到补发也可能失败，服务器会继续存储。最开始是 0。 |
| `applicationName`    | String  | 即时通讯服务分配给每个 app 的唯一标识，与请求参数 `app_name` 相同。 |

如果返回的 HTTP 状态码不是 `200`，则表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful) 了解可能的原因。

#### 示例

##### 请求示例

```shell
# 将 <YourAppToken> 替换为你在服务端生成的 App Token
curl -X POST 'http://a1.easemob.com/easemob-demo/easeim/callback/storage/retry' \
-H 'Authorization: Bearer <YourAppToken>' \
-H 'Content-Type: application/json' \
--data-raw '{
    "date": "202108272230",
    "retry": 0,
    "targetUrl": "http://localhost:8000/test"
}'
```

##### 响应示例

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

### 状态码

详见[HTTP 状态码](./agora_chat_status_code?platform=RESTful)。