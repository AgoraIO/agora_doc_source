# Send push notifications

Chat RESTful APIs allow you to send push notifications either by users or by labels.
 
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
| `targets`     | List    | The targeting user IDs. You can pass one user at most for synchronous push and a maximum of 100 users for asynchronous push.   | Yes     |
| `async`       | Boolean    | Whether to implement a synchronous or asynchronous push:<ul><li>`true`: (Default) Push asynchronously to a maximum of 100 users.</li><li>`false`: Push synchronously to one user at most.</li></ul> <div class="alert">You can send push notifications to multiple users (set <code>targets</code> to more than one user ID) only if you set <code>async</code> to <code>true</code>.</div>  | No   | 
| `strategy`    | Number | The push strategies.<ul><li>`0`: Use third-party push service first. When the pushing attempt fails, use Agora push service instead.</li><li>`1`: Use Agora push service only. If the target user is offline, Agora retains the push message for a certain period (depending on the Chat package to which you subscribe). After the retention period, the push message is dropped and the push attempt fails.</li><li>`2`: (Default) Use third-party push service only. If the target user is offline, whether to retain the push message and the retention period of the push message depend on the setting of the third-party service. If the push attempt fails, the message is discarded.</li><li>`3`: Use Agora push service first. When the pushing attempt fails, use third-party push service instead.</li></ul> | No  |  
| `pushMessage` | JSON   | The push messages. See [Set push notifications](./agora_chat_restful_config_push_notification) for details. | Yes   | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter      | Type | Description    |
| :-------- | :----- | :-------- |
| `data`       | JSON   | The push result. |
| `id`         | String | The targeting user ID.            |
| `pushStatus` | String | The push status:<ul><li>`SUCCESS`: The push succeeds.</li><li>`FAIL`: The push fails due to non-server errors. For example, an invalid token is passed.</li><li>`ERROR`: The push fails due to server errors. For example, the request times out.</li><li>`ASYNC_SUCCESS`: The asynchronous push succeeds.</li></ul> |
| `desc`       | String | The result description.   | 

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X POST "http://XXXX/XXXX/XXXX/push/single" -H "Authorization: Bearer <YourAppToken>" -H "Content-Type: application/json" --data-raw "{
    "targets": [
        "test2"
    ],
    "pushMessage": {
        "title": "Hello",
        "subTitle": "Hello",
        "content": "Hello",
        "vivo": {
 
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

## Send push notifications by labels

Sends push notifications to all users under one label, or the intersection of users under multiple labels.

A push task is automatically created per request, and the ID of the push task is returned for data statistics. A maximum of three push tasks can be executed at the same time.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/push/list/label
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
| `targets`     | List    | The targeting label names. You can either pass one label to send push notifications to all users under the label, or pass a maximum of five labels to send push notifications to the intersection of users under these labels.   | Yes     |
| `strategy`    | Number | The push strategies.<ul><li>`0`: Use third-party push service first. When the pushing attempt fails, use Agora push service instead.</li><li>`1`: Use Agora push service only. If the target user is offline, Agora retains the push message for a certain period (depending on the Chat package to which you subscribe). After the retention period, the push message is dropped and the push attempt fails.</li><li>`2`: (Default) Use third-party push service only. If the target user is offline, whether to retain the push message and the retention period of the push message depend on the setting of the third-party service. If the push attempt fails, the message is discarded.</li><li>`3`: Use Agora push service first. When the pushing attempt fails, use third-party push service instead.</li></ul> | No  |  
| `pushMessage` | JSON   | The push messages. See [Set push notifications](./agora_chat_restful_config_push_notification) for details. | Yes   | 


### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter      | Type | Description    |
| :-------- | :----- | :-------- |
| `data` | JSON | The detailed information of the push task. |
| `taskId` | Number | The ID of the push task. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -L -X POST 'http://XXXX/XXXX/XXXX/push/list/label' \
-H 'Authorization: Bearer <YourAppToken>' \
-H 'Content-Type: application/json' \
--data-raw '{
    "targets": [
        "post-90s"
    ],
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


## Send push notifications to all users under the app

Sends push notifications to all users under the app.

A push task is automatically created per request, and the ID of the push task is returned for data statistics. A maximum of three push tasks can be executed at the same time.
### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/push/task
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
| `strategy`    | Number | The push strategies.<ul><li>`0`: Use third-party push service first. When the pushing attempt fails, use Agora push service instead.</li><li>`1`: Use Agora push service only. If the target user is offline, Agora retains the push message for a certain period (depending on the Chat package to which you subscribe). After the retention period, the push message is dropped and the push attempt fails.</li><li>`2`: (Default) Use third-party push service only. If the target user is offline, whether to retain the push message and the retention period of the push message depend on the setting of the third-party service. If the push attempt fails, the message is discarded.</li><li>`3`: Use Agora push service first. When the pushing attempt fails, use third-party push service instead.</li></ul> | No  |  
| `pushMessage` | JSON   | The push messages. See [Set push notifications](./agora_chat_restful_config_push_notification) for details. | Yes   | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter      | Type | Description    |
| :-------- | :----- | :-------- |
| `data` | Number | The ID of the push task.  |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X POST "http://XXXX/XXXX/XXXX/push/task" -H "Content-Type: application/json" --data-raw "{
    "pushMessage": {
        "title": "Hello1234",
        "subTitle": "Hello",
        "content": "Hello",
        "vivo": {}
    }
}"
```

#### Response example

```json
{
    "timestamp": 1618817591755,
    "data": 968120369184112182,
    "duration": 1
}
```



## Status codes

For details, see [HTTP Status Codes](./agora_chat_status_code).