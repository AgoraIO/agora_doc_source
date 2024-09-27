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

## Send a push notification in a synchronous way

Sends a push notification to a user in a synchronous way. After sending a push notification, Agora server returns the push status in the HTTP response. If a third-party push service is used, the third-party push server will send the push result to the Agora server which will determine the push status based on the received push result.

For each App Key, the total call frequency limit of this method is 1 per second. 

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/push/sync/{target}
```

#### Path parameters

| Parameter           | Type | Description     | Required | 
| :------- | :----- | :---------------------- | :------- |
| `target` | String | The user ID of the push notification recipient. You can pass in only one user ID. | Yes       |

For the descriptions of other path parameters, see [Common parameters](#param).

#### Request header

| Parameter           | Type | Description     | Required | 
| :-------------- | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type`  | String | The content type. Set it as application/json.    | Yes       |
| `Authorization` | String | The authentication token of the user or administrator, in the format of Bearer ${YourAppToken}, where Bearer is a fixed character, followed by an English space, and then the obtained token value. | Yes  |

#### Request body

| Parameter           | Type | Description     | Required | 
| :------------ | :--- | :--------------- | :------- |
| `strategy`    | Number | The push strategy: <ul><li>`0`: Use the third-party push service first. If the push attempt fails, use the Agora push service instead.</li><li>`1`: Use Agora push service only. If the target user is online, Agora server sends the push message. If the user is offline, Agora retains the push message for a certain period (depending on the Chat package to which you subscribe) and will send it to the user as soon as he or she gets online. If the user remains offline until the retention period expires, the push message is dropped and the push attempt fails.</li><li>`2`: (Default) Use the third-party push service only. If the target user is offline, whether to retain the push message and how long the message can be retained depend on the setting of the third-party service. If the push attempt fails, the message is discarded.</li><li>`3`: Use the Agora push service first. If the user is online, Agora server sends the notification. If the user is offline, the notification is delivered via a third-party push service. If the offline push attempt fails, the notification is sent via Agora server once the user gets online. </li><li> `4` Only use online push via Agora server. Push notifications are sent only via Agora server for the online user. If the user is offline, the push notifications are discarded.</li></ul> | No  | 
| `pushMessage` | JSON | The push notification. For details, see [Configure push notifications](push_notification_config.html). | Yes   |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter     | Type  | Description  |
| :---------------- | :----- | :------------------------- |
| `data`            | Object | The push result. The server determines the push status based on the push result. |
| `data.pushStatus` | String | The push status: <br/> - `SUCCESS`: The push succeeds.<br/> - `FAIL`: The push fails due to an error that is not caused by the server, like `bad device token`, indicating that the mobile device delivers an incorrect device token to the server and the server does not accept it.<br/> - `ERROR`: The push exception occurs due to a server error, for example, connection timeout or read or write timeout.|
| `data.data`       | Object | The push result data returned by the push service used by the push notification recipient. |
| `data.desc`       | String | The description for the push failure.                  |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
# Replace {YourAppToken} with the app token generated in your server.
curl -X POST 'http://XXXX/XXXX/XXXX/push/sync/test1' \
-H 'Authorization: Bearer <YourAppToken>' \
-H 'Content-Type: application/json' \
-d '{
    "strategy": 3,
    "pushMessage": {
        "title": "Agora push",
        "content": "Hello and welcome",
        "sub_title": "Agora"
      }
}'
```

#### Response example

1. The push succeeds:

```json
{
    "timestamp": 1689154498019,
    "data": [
       {
            "pushStatus": "SUCCESS",
            "data": {
                "code": 200,
                "data": {
                    "expireTokens": [],
                    "sendResult": true,
                    "requestId": "104410638-fd96648b6bb4344bc4f5e29b158fdb07",
                    "failTokens": [],
                    "msgCode": 200
               },
                "message": "Success"
           }
       }
   ],
    "duration": 2
}
```

2. When a third-party push service is used, the push fails because the push-related information (like the push token or certificate) is not bound with the device:

```json
{
    "timestamp": 1689154624797,
    "data": [
       {
            "pushStatus": "FAIL",
            "desc": "no push binding"
       }
   ],
    "duration": 0
}
```

3. When a third-party push service is used, the push fails because the user ID of the push notification recipient does not exist:
```json
{
    "timestamp": 1689154534352,
    "data": [
       {
            "pushStatus": "FAIL",
            "desc": "appUser not exists"
       }
   ],
    "duration": 0
}
```

## Send a push notification to users in an asynchronous way

Sends a push notification to one or more users in an asynchronous way.

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
| `targets`     | List    | The user IDs of push notification recipients. You can pass in up to 100 user IDs each time.   | Yes     |
| `strategy`    | Number | The push strategy: <ul><li>`0`: Use the third-party push service first. If the push attempt fails, use the Agora push service instead.</li><li>`1`: Use Agora push service only. If the target user is online, Agora server sends the push message. If the user is offline, Agora retains the push message for a certain period (depending on the Chat package to which you subscribe) and will send it to the user as soon as he or she gets online. If the user remains offline until the retention period expires, the push message is dropped and the push attempt fails.</li><li>`2`: (Default) Use the third-party push service only. If the target user is offline, whether to retain the push message and how long the message can be retained depend on the setting of the third-party service. If the push attempt fails, the message is discarded.</li><li>`3`: Use the Agora push service first. If the user is online, Agora server sends the notification. If the user is offline, the notification is delivered via a third-party push service. If the offline push attempt fails, the notification is sent via Agora server once the user gets online. </li><li> `4` Only use online push via Agora server. Push notifications are sent only via Agora server for the online user. If the user is offline, the push notifications are discarded.</li></ul> | No  | 
| `pushMessage` | JSON   | The push message. See [Set push notifications](./agora_chat_restful_config_push_notification) for details. | Yes   | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter      | Type | Description    |
| :-------- | :----- | :-------- |
| `data`       | JSON   | The push result. |
| `id`         | String | The user IDs of push notification recipients.            |
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

## Send a push notification by label

Sends a push notification to all users under one label, or the intersection of users under multiple labels.

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
| `targets`     | List    | The targeting label names. You can either pass one label to send the push notification to all users under the label, or pass a maximum of five labels to send the push notification to the intersection of users under these labels.   | Yes     |
| `startDate` | String | The start date of the push task. The date format is yyyy-MM-dd HH:mm:ss, for example, 2024-01-01 12:00:00.<div class="alert note"><ul><li>1. The scheduled time must be one hour later than the curren time or 30 days from the current time. </li><li>2. By default, the scheduled time is in the time zone where the server resides. If you want to use a time in a different time zone, you must calculate that time according to your time zone.</li></ul></div> | No |
| `strategy`    | Number | The push strategy: <ul><li>`0`: Use the third-party push service first. If the push attempt fails, use the Agora push service instead.</li><li>`1`: Use Agora push service only. If the target user is online, Agora server sends the push message. If the user is offline, Agora retains the push message for a certain period (depending on the Chat package to which you subscribe) and will send it to the user as soon as he or she gets online. If the user remains offline until the retention period expires, the push message is dropped and the push attempt fails.</li><li>`2`: (Default) Use the third-party push service only. If the target user is offline, whether to retain the push message and how long the message can be retained depend on the setting of the third-party service. If the push attempt fails, the message is discarded.</li><li>`3`: Use the Agora push service first. If the user is online, Agora server sends the notification. If the user is offline, the notification is delivered via a third-party push service. If the offline push attempt fails, the notification is sent via Agora server once the user gets online. </li><li> `4` Only use online push via Agora server. Push notifications are sent only via Agora server for the online user. If the user is offline, the push notifications are discarded.</li></ul> | No  |   
| `pushMessage` | JSON   | The push message. See [Set push notifications](./agora_chat_restful_config_push_notification) for details. | Yes   | 


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


## Send a push notification to all users under the app

Sends a push notification to all users under the app.

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
| `startDate` | String | The start date of the push task. The date format is yyyy-MM-dd HH:mm:ss, for example, 2024-01-01 12:00:00.<div class="alert note"><ul><li>1. The scheduled time must be one hour later than the curren time or 30 days from the current time. </li><li>2. By default, the scheduled time is in the time zone where the server resides. If you want to use a time in a different time zone, you must calculate that time according to your time zone.</li></ul></div> | No |
| `strategy`    | Number | The push strategy: <ul><li>`0`: Use the third-party push service first. If the push attempt fails, use the Agora push service instead.</li><li>`1`: Use Agora push service only. If the target user is online, Agora server sends the push message. If the user is offline, Agora retains the push message for a certain period (depending on the Chat package to which you subscribe) and will send it to the user as soon as he or she gets online. If the user remains offline until the retention period expires, the push message is dropped and the push attempt fails.</li><li>`2`: (Default) Use the third-party push service only. If the target user is offline, whether to retain the push message and how long the message can be retained depend on the setting of the third-party service. If the push attempt fails, the message is discarded.</li><li>`3`: Use the Agora push service first. If the user is online, Agora server sends the notification. If the user is offline, the notification is delivered via a third-party push service. If the offline push attempt fails, the notification is sent via Agora server once the user gets online. </li><li> `4` Only use online push via Agora server. Push notifications are sent only via Agora server for the online user. If the user is offline, the push notifications are discarded.</li></ul> | No  |   
| `pushMessage` | JSON   | The push message. See [Set push notifications](./agora_chat_restful_config_push_notification) for details. | Yes   | 

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