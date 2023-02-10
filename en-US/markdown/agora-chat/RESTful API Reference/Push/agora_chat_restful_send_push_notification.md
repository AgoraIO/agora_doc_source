# Send push notifications

Chat RESTful APIs allow you to send push notifications either by users or by tags.
 
## <a name="param"></a>Common parameters

The following table lists common request and response parameters of the Chat RESTful APIs:

### Request parameters

| Parameter      | Type | Description    | Required | 
| :--------- | :----- |:------------- | :------- | 
| `host`     | String | The domain name assigned by the Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes   | 
| `org_name` | String | The unique identifier assigned to each company (organization) by the Chat service. For how to get the organization name, see [Get the information of the Chat project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes     | 
| `app_name` | String | The unique identifier assigned to each app by the Chat service. For how to get the app name, see [Get the information of the Chat project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes    | 
| `username` | String | The unique login account of the user.    | Yes     | 

### Response parameters

| Parameter        | Type   | Description          |
| :----------| :----------- | :----------------- |
| `timestamp` | Number      | The Unix timestamp (ms) of the HTTP response.  |
| `duration`  | Number      | The duration (ms) from when the HTTP request is sent to the time the response is received. |


## Authorization

Chat RESTful APIs require Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authorization` field must be filled in the request header:

```
Authorization: Bearer ${YourAppToken}
```

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log in to the chat system. The Chat RESTful API only supports authenticating users using app tokens. For details, see [Authentication using App Token](./generate_app_tokens).


## Send push notifications by users

Sends push notifications to one or more users by specifying user IDs.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/push/single
```

#### Path parameters

For the descriptions of path parameters, see [Common parameters](#param).

#### Request header

| Parameter           | Type | Description     | Required | 
| :-------------- | :----- | :------- | :---------- |
| `Content-Type`  | String | The content type. Set it as `application/json`.  | Yes   | 
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value.  | Yes    | 

#### Request body

| Parameter           | Type | Description             | Required | 
| :-------------- | :----- | :------- | :----------- |
| `targets`     | List    | 推送的目标用户 ID。最多可传 100 个用户 ID。   | 是     |
| `async`       | Boolean    | 是否异步推送：<ul><li>（默认）`true`：异步推送，每次最多可推送给 100 个用户。</li><li>`false`：同步推送，每次只能推送给 1 个用户。</li></ul> | 否   | 
| `strategy`    | Number | 推送策略：<ul><li>`0`：厂商通道优先，失败时走声网通道。</li><li>`1`：只走声网通道。</li><li>（默认）`2`：只走厂商通道。若推送失败，直接丢弃推送消息。</li><li>`3`：声网通道优先，失败时走厂商通道。</li></ul> | 否   |  
| `pushMessage` | JSON   | 推送消息。消息内容详见[配置推送通知](./agora_chat_restful_config_push_notification)。| 是     | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter      | Type | Description    |
| :-------- | :----- | :-------- |
| `data`       | JSON   | 推送结果：<ul><li>同步推送：厂商返回的推送结果；</li><li>异步推送：异步推送的结果。</li></ul>|
| `id`         | String | 推送的目标用户 ID。             |
| `pushStatus` | String | 推送状态：<ul><li>`SUCCESS`：推送成功；</li><li>`FAIL`：推送失败；</li><li>`ERROR`：推送异常；</li><li>`ASYNC_SUCCESS`：异步推送成功。</li></ul> |
| `desc`       | String | 推送结果的相关描述。     | 

 For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
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

#### Response example

```json
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

## Send push notifications by tags

Sends push notifications to all users under one tag, or the intersection of users under multiple tags.

### HTTP request

```http
POST https://{host}/{org}/{app}/push/list/label
```

#### Path parameter

For the descriptions of path parameters, see [Common parameters](#param).

#### Request header

| Parameter           | Type | Description     | Required | 
| :-------------- | :----- | :------- | :---------- |
| `Content-Type`  | String | The content type. Set it as `application/json`.  | Yes   | 
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value.  | Yes    | 

#### Request body

| Parameter           | Type | Description             | Required | 
| :-------------- | :----- | :------- | :----------- |
| `targets`     | List    | 标签名称。可传单个或多个标签名称。<ul><li>若传单个标签名称，消息推送给该标签下的所有用户。</li><li>若传多个标签名称，消息推送给同时存在于这些标签中的用户，即取标签中的用户交集。</li></ul>  | 是     | 
| `strategy`    | Number | 推送策略：<ul><li>`0`：厂商通道优先，失败时走声网通道。</li><li>`1`：只走声网通道。</li><li>（默认）`2`：只走厂商通道。若推送失败，直接丢弃推送消息。</li><li>`3`：声网通道优先，失败时走厂商通道。</li></ul> | 否   | 
| `pushMessage` | JSON    | 推送消息。消息内容详见 [配置推送通知](./agora_chat_restful_config_push_notification)。 | 是     | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter      | Type | Description    |
| :-------- | :----- | :-------- |
| `data` | JSON | 推送任务数据。 |
| `taskId` | Number | 推送任务 ID。 |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

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

#### Response example

```json
{
    "timestamp": 1650859482843,
    "data": {
        "taskId": 968120369184112182
    },
    "duration": 0
}
```

## Status codes

For details, see [HTTP Status Codes](./agora_chat_status_code).