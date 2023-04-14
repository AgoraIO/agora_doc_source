During one-to-one chats and group chats, users can reply a specified message with emojis, which adds fun and diversity to real-time chatting. In Agora Chat, this feature is known as reaction. This page shows how to use the Agora Chat RESTful API to implement reaction in your project.

Before calling the following methods, make sure you understand the call frequency limit of the Chat RESTful APIs as described in [Limitations](./agora_chat_limitation?platform=RESTful#call-limit-of-server-side).

<a name="param"></a>

## Common parameters

This following table lists the common request and response parameters of the Agora Chat RESTful API.

### Request parameters

| Parameter | Type | Description | Required |
| :--------- | :----- | :-------- | :------- |
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. For how to get org name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `userId` | String | The unique login account of the user. The user ID must be 64 characters or less and cannot be empty.  The following character sets are supported:<ul><li>26 lowercase English letters (a-z)</li><li>26 uppercase English letters (A-Z)</li><li>10 numbers (0-9)</li><li>"\_", "-", "."</li></ul><div class="alert note"><ul><li>The username is case insensitive, so `Aa` and `aa` are the same username.</li><li>Ensure that each `username` under the same app is unique.</li><li>Do not set this parameter as a UUID, email address, phone number, or other sensitive information.</li></ul></div> | Yes |

### Response parameters

| Parameter | Type | Description |
| :---------------- | :----- | :------------------------ |
| `data` | JSON | The returned data. |
| `timestamp` | Number | The Unix timestamp (ms) of the HTTP response. |
| `username` | String | The user ID. |
| `groupname` | String | The chat group name. |

## Authorization

The Agora Chat RESTful API requires Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authoriazation` field must be filled in the request header, in which `Bearer` is a fixed character, followed by an English space, and then the obtained app token value. 

```http
Authorization: Bearer ${YourAppToken}
```

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log in to the chat system. The Agora Chat RESTful API only supports authenticating users using app tokens. For how to generate an app token, see [Generate an App Token](/generate_app_tokens?platform=All%20Platforms).

<a name="create"></a>

## Create/Add a reaction

This method creates or adds a reaction to a specified message in one-to-one chats or group chats.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/reaction/user/{userId}
```

#### Path parameter

For the path parameters and the detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type` | String | `application/x-www-form-urlencoded` | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description |
| :-------------- | :----- | :---------------------------------- |
| `msg_Id`  | String | The message ID to which you want to add the reaction. |
| `message` | String | The ID of the emoji, same as that on the client. The maximum length is 128 bytes.  |

### HTTP Response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the `data` in the response contains the following fields:

| Parameter  | Type  | Description |
| --- | --- | --- |
| `requestStatusCode` | String | The status code of this request. `ok` means that the request succeeds. |
| `id` | String | The reaction ID. |
| `msgId` | String | The message ID. |
| `msgType` | String | The message type:<ul><li>`chat`: One-to-one chat.</li><li>`groupchat`: Group chat.</li></ul> |
| `groupId` | String | The chat group ID. If the message type is `chat`, the server returns null. |
| `reaction` | String | The ID of the emoji added as the reaction, same as `message` in the request body. |
| `createAt` | Instant | The time when the reaction is created. |
| `updateAt` | Instant | The time when the reaction is updated. |

For other fields and the detailed descriptions, see [Public parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](./agora_chat_status_code?platform=RESTful) for possible reasons.

### Example

#### Request example

```shell
curl -g -X POST 'http://XXXX/XXXX/XXXX/reaction/user/e1' -H 'Authorization: Bearer {YourAppToken}' -H 'Content-Type: application/json' --data-raw '{
    "msgId":"997625372793113144",
    "message":"emoji_40"
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

This method retrieves the information of the reaction according to the message ID, including the reaction ID, emoji ID, and the user IDs that have used this reaction. This method only returns the first three chat users that added this reaction.

For each method call, you can retrieve reactions in either one-to-one chats or group chats, but not in both of them.

### HTTP request

```shell
GET https://{host}/{org_name}/{app_name}/reaction/user/{userId}?msgIdList={N,M}&msgType={msgType}&groupId={groupId}
```

#### Path parameter

For the path parameters and the detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter        | Type   | Description                                                       | Required |
| :---------- | :----- | :------------------------------------------------------------ | :------- |
| `msgIdList` | Array  |  The ID of the message from which you attempt to retrieve reactions.  | Yes      |
| `msgType`   | String | The chat type:<ul><li>`chat`: One-to-one chats.</li><li>`groupchat`: Group chats.</li></ul>  | Yes     |
| `groupId`   | String | The ID of the chat group. This parameter is only required if you set `msgType` to `groupchat`.  |  No    |

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type` | String | `application/x-www-form-urlencoded` | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the `data` in the response contains the following fields:

| Parameter | Type | Description |
| --- | --- | --- |
| `requestStatusCode` | String | The status code of this request. `ok` means that the request succeeds. |
| `msgId` | String | The message ID. |
| `reactionId` | String | The reaction ID returned in the response body of [Create a reaction](#create). |
| `reaction` | String | The emoji ID that is the same as the `message` parameter specified in the request body when [adding a reaction](#create).    |
| `count` | Number | The number of users that have added this reaction to the message. |
| `state` | Bool | Whether the user sending this request has added a reaction to this message:<ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> |
| `userList` | Array | The list of user IDs that have added this reaction. It contains a maximum of three users that first added this reaction. |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](./agora_chat_status_code?platform=RESTful) for possible reasons.

### Example

#### Request example

```shell
curl -g -X GET 'http://XXXX/XXXX/XXXX/reaction/user/{{userId}}?msgIdList=msgId1&msgType=chat' -H 'Authorization: Bearer {YourAppToken}'
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
DELETE https://{host}/{org_name}/{app_name}/reaction/user/{userId}
```

#### Path parameter

For the parameters and the detailed descriptions, see [Common parameters](#param).

#### Reqest header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type` | String | `application/x-www-form-urlencoded` | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

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
| `timestamp` | Long | The Unix timestamp of this response, in milliseconds. |

For other fields and the detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](./agora_chat_status_code?platform=RESTful) for possible reasons.

### Example

#### Request example

```shell
curl -g -X DELETE 'http://XXXX/XXXX/XXXX/reaction/user/wz?msgId=997625372793113144&message=emoji_40' -H 'Authorization: Bearer {YourAppToken}'
```

#### Response example

```json
{
    "requestStatusCode": "ok",
    "timestamp": 1645774821181
}
```

## Retrieve the detailed information of the reaction

This method retrieves the detailed information of the reaction by specifying the message ID and reaction ID.

### HTTP request

```shell
GET https://{host}/{org_name}/{app_name}/reaction/user/{userId}/detail?msgId={msgId}&message={message}&limit={limit}&cursor={cursor}
```

#### Path parameter

For the parameters and the detailed description, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| --- | --- | --- | --- |
| `msgId` | String | The message ID. | Yes |
| `message` | String | The ID of the emoji that is added as the reaction. | Yes |
| `limit` | Number | The number of reactions retrieved on each page when you retrieve the reactions with pagination. The value range is [1,100]. The default value is 100. | No |
| `cursor` | String | The starting page from which to retrieve data if you retrieve the reactions with pagination.| No |

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type` | String | `application/x-www-form-urlencoded` | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the `data` in the response contains the following fields:

| Parameter | Type | Description |
| --- | --- | --- |
| `requestStatusCode` | String | The status code of this request. `ok` means that the request succeeds. |
| `reactionId` | String | The reaction ID. |
| `reaction` | String | The emoji ID that is the same as the `message` parameter specified in the request body when [adding a reaction](#create). |
| `count` | Number | The number of users that have added the reaction. |
| `state` | Bool | Whether the user sending this request has added a reaction to this message:<ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> |
| `userList` | Array | The list of the users that have added this reaction. Note that this list only contains the last three user IDs to do so. |
| `cursor` | String | The cursor that indicates that starting position of the next query. |

For other fields and the detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](./agora_chat_status_code?platform=RESTful) for possible reasons.

### Example

#### Request example

```shell
// Starts querying from the first page
curl -g -X GET 'http://XXXX/XXXX/XXXX/reaction/user/wz/detail?msgId=997627787730750008&message=emoji_40&limit=50' -H 'Authorization: Bearer {YourAppToken}'

// Starts querying from the second page
curl -g -X GET 'http://XXXX/XXXX/XXXX/reaction/user/wz/detail?msgId=997627787730750008&message=emoji_40&cursor=944330529971449164&limit=50' -H 'Authorization: Authorization: Bearer {YourAppToken}'
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

## Status codes

For details, see [HTTP Status Codes](./agora_chat_status_code?platform=RESTful).















