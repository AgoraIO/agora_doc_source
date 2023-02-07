# 发送推送通知

利用 RESTful 接口可通过以下两种方式使用即时推送服务：
- 对单个或多个用户发送推送通知；
- 对指定标签下的用户发送推送通知。
 
## <a name="param"></a>公共参数

### 请求参数

| 参数       | 类型   | 描述                    | 是否必需 | 
| :--------- | :----- | :------------- | :------- | 
| `host`     | String | 即时通讯服务分配的 RESTful API 访问域名。 | 是     | 
| `org_name` | String | 即时通讯服务分配给每个企业（组织）的唯一标识。| 是     | 
| `app_name` | String | 即时通讯服务分配给每个 app 的唯一标识。| 是    | 
| `username` | String | 用户 ID。          | 是     |

### 响应参数

| 参数       | 类型       | 描述                |
| :---------------- | :----------------------------------- | :----------------------------------- |
| `timestamp`    | Number    | 响应的 Unix 时间戳，单位为毫秒。         |
| `duration`     | Number   | 从发送请求到响应的时长，单位为毫秒。         |

## 认证方式

即时通讯 RESTful API 要求 Bearer HTTP 认证。每次发送 HTTP 请求时，都必须在请求头部填入如下 Authorization 字段：

Authorization：`Bearer ${YourAppToken}`

为提高项目的安全性，Agora 使用 Token（动态密钥）对即将登录即时通讯系统的用户进行鉴权。即时通讯 RESTful API 推荐使用 app 权限 token 的鉴权方式，详见 [使用 app token 鉴权](./agora_chat_token?platform=RESTful)。

## 向指定用户发送推送通知

向单个或多个用户发送推送通知。

### HTTP 请求

```http
POST https://{host}/{org_name}/{app_name}/push/single
```

#### 路径参数

参数及描述详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述      | 是否必需 | 
| :-------------- | :----- | :------- | :---------- |
| `Content-Type`  | String | 内容类型：`application/json`   | 是   | 
| `Authorization` | String | `Bearer ${YourAppToken}` Bearer 是固定字符，后面加英文空格，再加上获取到的 app token 的值。 | 是    | 

#### 请求 body

| 字段          | 类型    | 描述                       | 是否必需 |
| :------------ | :------- | :------ | :------------------ |
| `targets`     | List    | 推送的目标用户 ID。最多可传 100 个用户 ID。   | 是     |
| `async`       | Boolean    | 是否异步推送：<ul><li>（默认）`true`：异步推送，每次最多可推送给 100 个用户。</li><li>`false`：同步推送，每次只能推送给 1 个用户。</li></ul> | 否   | 
| `strategy`    | Number | 推送策略：<ul><li>`0`：厂商通道优先，失败时走声网通道。</li><li>`1`：只走声网通道。</li><li>（默认）`2`：只走厂商通道。若推送失败，直接丢弃推送消息。</li><li>`3`：声网通道优先，失败时走厂商通道。</li></ul> | 否   |  
| `pushMessage` | JSON   | 推送消息。消息内容详见[配置推送通知](./agora_chat_restful_config_push_notification)。| 是     | 

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段： 

| 字段         | 类型   | 描述   |
| :----------- | :----- | :-------- |
| `data`       | JSON   | 推送结果：<ul><li>同步推送：厂商返回的推送结果；</li><li>异步推送：异步推送的结果。</li></ul>|
| `id`         | String | 推送的目标用户 ID。             |
| `pushStatus` | String | 推送状态：<ul><li>`SUCCESS`：推送成功；</li><li>`FAIL`：推送失败；</li><li>`ERROR`：推送异常；</li><li>`ASYNC_SUCCESS`：异步推送成功。</li></ul> |
| `desc`       | String | 推送结果的相关描述。     | 

其他参数及描述详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```
curl -X POST "http://localhost:8099/agora-demo/testy/push/single" -H "Authorization: Bearer YWMtOzQVjJ3mEeuJQv1qXhB5QAAAAAAAAAAAAAAAAAAAAAFDtjwasNNKD6W3CET2O3RNAQMAAAF41YIKUABPGgDuIZeu5IMVC_M9G5JlTjUsZeYVSg5o8BwshLgWveZxjA" -H "Content-Type: application/json" --data-raw "{
    \"targets\": [
        \"test2\"
    ],
    \"pushMessage\": {
        \"title\": \"Hello\",
        \"subTitle\": \"Hello\",
        \"content\": \"Hello\",
        \"vivo\": {
 
        }
    }
}"
```

#### 响应示例

```
{
    "timestamp": 1619506344007,
    "data": [
        {
            "id": "test2",
            "pushStatus": "ASYNC_SUCCESS",
            "desc": "async success."
        }
    ],
    "duration": 14
}
```

## 对指定标签下的用户发送推送通知

若传单个标签，则向单个标签内的所有用户发送推送通知。若传多个标签，则消息推送给同时存在这些标签中的用户，即取标签中的用户交集。

### HTTP 请求

```http
POST https://{host}/{org}/{app}/push/list/label
```

#### 路径参数

参数及说明详见 [公共参数](#param)。

#### 请求 header

| 参数            | 类型   | 描述      | 是否必需 | 
| :-------------- | :----- | :------- | :---------- |
| `Content-Type`  | String | 内容类型：`application/json`   | 是   | 
| `Authorization` | String | `Bearer ${YourAppToken}` Bearer 是固定字符，后面加英文空格，再加上获取到的 app token 的值。 | 是    | 

#### 请求 body

| 字段          | 类型    | 描述     | 是否必需 | 
| :------------ | :------- | :------ | :---------------- |
| `targets`     | List    | 标签名称。可传单个或多个标签名称。<ul><li>若传单个标签名称，消息推送给该标签下的所有用户。</li><li>若传多个标签名称，消息推送给同时存在于这些标签中的用户，即取标签中的用户交集。</li></ul>  | 是     | 
| `strategy`    | Number | 推送策略：<ul><li>`0`：厂商通道优先，失败时走声网通道。</li><li>`1`：只走声网通道。</li><li>（默认）`2`：只走厂商通道。若推送失败，直接丢弃推送消息。</li><li>`3`：声网通道优先，失败时走厂商通道。</li></ul> | 否   | 
| `pushMessage` | JSON    | 推送消息。消息内容详见 [配置推送通知](./agora_chat_restful_config_push_notification)。 | 是     | 

### HTTP 响应

#### 响应 body

如果返回的 HTTP 状态码为 `200`，表示请求成功，响应包体中包含以下字段：

| 字段  | 类型 | 描述      |
| :----- | :-----| :---------------------- |
| `data` | JSON | 推送任务数据。 |
| `taskId` | Number | 推送任务 ID。 |

其他参数及描述详见 [公共参数](#param)。

如果返回的 HTTP 状态码非 `200`，表示请求失败。你可以参考[响应状态码](./agora_chat_status_code?platform=RESTful)了解可能的原因。

### 示例

#### 请求示例

```shell
curl -L -X POST 'http://a1-hsb.agora.com/agora-demo/easeim/push/list' \
-H 'Authorization: Bearer YWMtIPBHKsOyEeAAAAAAAAAAAExCXvf5bRGAJBgXNYFJVQ9AQMAAAGAWu67KQBPGgBOV9ghkGKbtt9H9b1' \
-H 'Content-Type: application/json' \
--data-raw '{
    "targets": [
        "post-90s"
    ],
    "pushFunc":"LABEL",
    "strategy": 2,
    "pushMessage": {
        "title": "Agora PUSH",
        "content": "Welcome to Agora Push Service",
        "sub_title": "Agora"
    }
}'
```

#### 响应示例

```json
{
    "timestamp": 1650859482843,
    "data": {
        "taskId": 968120369184112182
    },
    "duration": 0
}
```