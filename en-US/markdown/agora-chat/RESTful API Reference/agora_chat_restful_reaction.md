During one-to-one chats and group chats, users can reply to a specified message with emojis, which adds fun and diversity to real-time chatting. In Agora Chat, this feature is known as reaction. This page shows how to use the Agora Chat RESTful API to implement reaction in your project.

<a name="param"></a>

## Common parameters

This following table lists the common request and response parameters of the Agora Chat RESTful API.

### Request parameters

| Parameter | Type | Description | Required |
| :--------- | :----- | :-------- | :------- |
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. For how to get org name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `username` | String | The unique login account of the user. The user ID must be 64 characters or less and cannot be empty.  The following character sets are supported:<ul><li>26 lowercase English letters (a-z)</li><li>26 uppercase English letters (A-Z)</li><li>10 numbers (0-9)</li><li>"\_", "-", "."</li></ul><div class="alert note"><ul><li>The username is case insensitive, so `Aa` and `aa` are the same username.</li><li>Ensure that each `username` under the same app is unique.</li><li>Do not set this parameter as a UUID, email address, phone number, or other sensitive information.</li></ul></div> | Yes |

### Response parameters

| Parameter | Type | Description |
| :---------------- | :----- | :------------------------ |
| `action` | String | The request method. |
| `organization` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. This is the same as `org_name`. |
| `application` | String | A unique internal ID assigned to each app by the Agora Chat service. You can safely ignore this parameter. |
| `applicationName` | String | The unique identifier assigned to each app by the Agora Chat service. This is the same as `app_name`. |
| `uri` | String | The request URI. |
| `entities ` | JSON | The response entity. |
| `data` | JSON | The returned data. |
| `timestamp` | Number | The Unix timestamp (ms) of the HTTP response. |
| `duration` | Number | The duration (ms) from when the HTTP request is sent to the time the response is received. |

## Authorization

The Agora Chat RESTful API requires Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authoriazation` field must be filled in the request header, in which `Bearer` is a fixed character, followed by an English space, and then the obtained app token value. 

```http
Authorization: Bearer ${YourAppToken}
```

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log in to the chat system. The Agora Chat RESTful API only supports authenticating users using app tokens. For how to generate an app token, see [Generate an App Token](/generate_app_tokens?platform=All%20Platforms).

<a name="create"></a>

## Create/Add a reaction

This method creates or add a reaction to a specified message in one-to-one chats or group chats.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/{username}/reaction
```

#### Path parameter

For the path parameters and the detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type` | String | `application/x-www-form-urlencoded` | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description |
| :-------------- | :----- | :---------------------------------- |
| `msg_Id`  | String | The message ID to which you want to add the reaction. |
| `message` | The reaction ID. |

### HTTP Response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the `data` in the response contains the following fields:

| Parameter  | Type  | Description |
| --- | --- | --- |
| `id` | String | The reaction ID. |
| `msgId` | String | The message ID. |
| `msgType` | String | The message type:<ul><li>`chat`: One-to-one chat.</li><li>`groupchat`: Group chat.</li></ul> |
| `groupId` | String | The chat group ID. If the message type is `chat`, the server returns null. |
| `reaction` | String | The ID of the emoji added as the reaction, same as `message` in the request body. |
| `createAt` | String | The time when the reaction is created. |
| `updateAt` | String | The time when the reaction is updated. |


If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](./agora_chat_status_code?platform=RESTful) for possible reasons.

### Example

#### Request example

```shell
curl -X POST 'http://XXXX/XXXX/XXXX/XXXX/reaction' -H 'Authorization: Bearer {YourAppToken}' -H 'Content-Type: application/json' --data-raw '{
    "msgId":"msg12345678",
    "message":"message123456"
}'
```

#### Response example

```json
{
    "requestStatusCode": "ok",
    "timestamp": 1645774821181,
    "data": {
        "id": "946481033434607420",
        "msgId": "msg3333",
        "msgType": "chat",
        "groupId": null,
        "reaction": "message123456",
        "createdAt": "2022-02-24T10:57:43.138934Z",
        "updatedAt": "2022-02-24T10:57:43.138939Z"
    }
}
```

## Retrieve reactions with message IDs

This method retrieves a list of reactions according to the message IDs. The method also returns the chat users that have added the last three reactions.

For each method call, you can retrieve reactions in either one-to-one chats or group chats, but not in both of them.

### HTTP request

```shell
GET https://{host}/{org_Name}/{app_name}/{username}/reaction
```

#### Path parameter

For the path parameters and the detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type` | String | `application/x-www-form-urlencoded` | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Query parameter

| Parameter | Type | Description | Required |
| --- | --- | --- | --- |
| `msgIdList` | Array | The message IDs whose reaction you want to retrieve. | Yes |
| `msgType` | String | The message type:<ul><li>`chat`: One-to-one chat.</li><li>`groupchat`: Group chat.</li></ul> | Yes |
| `groupId` | String | The chat group ID. If you set `msgType` as `groupchat`, you must specify a group ID. |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the `data` in the response contains the following fields:

| Parameter | Type | Description |
| `msgId` | String | The message ID. |
| `reactionId` | String | The reaction ID returned in the data of the response body of [Create a reaction](#create). |
| `reaction` | String | The ID of the emoji that is added as the reaction. |
| `userCount` | Number | The number of users that have added a reaction to this message. |
| `state` | Boolean | Whether the user sending this request has added a reaction to this message.<ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> |
| `userList` | Array | The list of users that have added a reaction to this message. It contains a maximum of three users that have added that reaction. |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](./agora_chat_status_code?platform=RESTful) for possible reasons.

### Example

#### Request example

```shell
curl -X GET 'http://XXXX/XXXX/XXXX/XXXX/reaction?msgIdList=msg123,msg1234&msgType=groupchat&groupId=173446846808065' -H 'Authorization: {YourAppToken}' -H 'Content-Type: application/json'
```

#### Response example

```json
{
    "requestStatusCode": "ok",
    "timestamp": 1645774821181,
    "data": [
        {
            "msgId": "msg123",
            "reactionList": [
                {
                    "reactionId": "944330310986837168",
                    "reaction": message123456,
                    "userCount": 0,
                    "state": false,
                    "userList": [
                        "test123",
                        "test456",
                        "test1"
                    ]
                }
            ]
        },
        {
            "msgId": "msg1234",
            "reactionList": [
                {
                    "reactionId": "945272584050659838",
                    "reaction": message123456,
                    "userCount": 0,
                    "state": false,
                    "userList": [
                        "test5"
                    ]
                }
            ]
        }
    ]
}
```

## Delete a reaction

This method deletes a reaction.

### HTTP request

```shell
DELETE https://{host}/{orgName}/{appName}/{userId}/reaction
```

#### Path parameter

For the parameters and the detailed descriptions, see [Common parameters](#param).

#### Reqest header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type` | String | `application/x-www-form-urlencoded` | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Query parameters

| Parameter | Type | Description | Required |
| --- | --- | --- | --- |
| `msgId` | String | The message ID. | Yes |
| `message` | String | The ID of the emoji that is added as the reaction. | Yes |

### HTTP Response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the `data` in the response contains the following fields:

| Parameter | Type | Description |
| --- | --- | --- |
| `requestStatusCode` | String | The status code of this request. `ok` means that the request succeeds. |
| `timestamp` | Long | The Unix timestamp of this response, in miliseconds. |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](./agora_chat_status_code?platform=RESTful) for possible reasons.

### Example

#### Request example

```shell
curl -X DELETE 'http://localhost:8089/easemob-demo/easeim/wz1/reaction?msgId=msg123&message=message123' -H 'Authorization: {YourAppToken}' -H 'Content-Type: application/json'
```

#### Response example

```json
{
    "requestStatusCode": "ok",
    "timestamp": 1645774821181
}
```

## Retrieve the information of the specified reaction

This method retrieves the detailed information of the reaction by specifying the message ID and reaction ID.

### HTTP request

```shell
GET https://{host}/{orgName}/{appName}/{userId}/reaction/detail
```

#### Path parameter

For the parameters and the detailed description, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type` | String | `application/x-www-form-urlencoded` | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Query parameters

| Parameter | Type | Description | Required |
| --- | --- | --- | --- |
| `msgId` | String | The message ID. | Yes |
| `message` | String | The ID of the emoji that is added as the reaction. | Yes |
| `limit` | Number | The number of reactions retrieved on each page when you retrieve the reactions with pagination. The value range is [1,100]. The default value is 100. | No |
| `cursor` | String | The starting page from which to retrieve data if you retrieve the reactions with pagination.|

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the `data` in the response contains the following fields:

| Parameter | Type | Description |
| --- | --- | --- |
| `reactionId` | String | The reaction ID. |
| `reaction` | String | The ID of the emoji that is added as the reaction. |
| `userCount` | Number | The number of users that have added the reaction. |
| `state` | String | The state of the this request. |
| `userList` | Array | The list of the users that have added this reaction. It only contains the three user IDs that last used reaction. |
| `cursor` | String | The starting page from which to retrieve data if you retrieve the reactions with pagination. |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](./agora_chat_status_code?platform=RESTful) for possible reasons.

### Example

#### Request example

```shell
// Starts querying from the first page
curl -X GET 'http://localhost:8089/easemob-demo/easeim/wz1/reaction/detail?msgId=msg123456&message=message123456&cursor=944330529971449164&limit=4'

// Starts querying from the second page
curl -X GET 'http://localhost:8089/easemob-demo/easeim/wz1/reaction/detail?msgId=msg123456&message=message123456&cursor=944330529971449164&limit=4'
```

#### Response example

```json
{
    "requestStatusCode": "ok",
    "timestamp": 1645776986146,
    "data": {
        "reactionId": "946463470818405943",
        "reaction": "message123456",
        "userCount": 1,
        "state": true,
        "userList": [
            "wz1"
        ],
        "cursor": "946463471296555192"
    }
}
```
















