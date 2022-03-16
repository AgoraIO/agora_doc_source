This page shows how to perform chat room member mute management by calling the Agora Chat RESTful APIs, including adding, retrieving, and removing muted members in a chat room.
Before calling the following methods, ensure that you understand the call frequency limit of the Agora Chat RESTful APIs described in [Limitations](./agora_chat_limitation?platform=RESTful#call-limit-of-server-side).


 <a name="param"></a>
## Common parameters

The following table lists common request and response parameters of the Agora Chat RESTful APIs:

### Request parameters

| Parameter | Type | Description | Required |
| :--------- | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. For how to get the org name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `username` | String | The username. The unique login account of the user. The username must be 64 characters or less and cannot be empty.  The following character sets are supported:<li>26 lowercase English letters (a-z)</li><li>26 uppercase English letters (A-Z)</li><li>10 numbers (0-9)</li><li>"\_", "-", "."</li><div class="alert note"><ul><li>The username is case insensitive,  so `Aa` and `aa` are the same username. </li><li>Ensure that each username under the same app must be unique.</li></ul></div> | Yes |

### Response parameters

| Parameter | Type | Description |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action` | String | The request method. |
| `organization` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. This is the same as `org_name`. |
| `application` | String | A unique internal ID assigned to each app by the Agora Chat service. You can safely ignore this parameter. |
| `applicationName` | String | The unique identifier assigned to each app by the Agora Chat service. This is the same as `app_name`. |
| `uri` | String | The request URI. |
| `entities ` | JSON | The response entity. |
| `data` | JSON | The details of the response. |
| `timestamp` | Number | The Unix timestamp (ms) of the HTTP response. |
| `duration` | Number | The duration (ms) from when the HTTP request is sent to the time the response is received. |

## Muting a chat room member

Mutes a chat room member. Once a chat room member is muted, this member cannot send messages in the chat room.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/mute
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters ](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type` | String | `application/json` | Yes |
| `Accept` | String | `application/json` | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

The request body is a JSON object, which contains the following fields:

| Field | Type | Description | Required |
| :-------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `mute_duration` | long | The duration (milliseconds) of how long the member is muted, starting from the current time.<br>`-1` indicates that the member is muted permanently. | Yes |
| `usernames` | String | The array of usernames of chat room members that are to be muted. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Field | Type | Description |
| :------- | :----- | :------------------------------------------------------ |
| `result` | Bool | The mute result:<li>`true: `Success<li><li>`false`: Failure</li> |
| `expire` | Number | The Unix timestamp (ms) when the mute state expires. |
| `user` | String | The username of the muted chat room member. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d
'{
    "usernames": [
        "user1",
        "user2"
    ],
    "mute_duration": 86400000
}''http://a1.easemob.com/easemob-demo/testapp/chatrooms/1265710621211/mute'
```

#### Response example

```json
{
    "action": "post",
    "application": "22bcffa0-XXXX-XXXX-9df8-516f6df68c6d",
    "applicationName": "XXXX",
    "data": [
        {
            "result": true,
            "expire": 1642148173726,
            "user": "user1"
        },
        {
            "result": true,
            "expire": 1642148173726,
            "user": "user2"
        }
    ],
    "duration": 0,
    "entities": [],
    "organization": "XXXX",
    "timestamp": 1642060750410,
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/mute"
}
```

## Unmuting chat room members

Unmutes one or more chat room members. The unmuted members can continue to send messages in the chat room.

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/mute/{member}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------- | :----- | :---------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `member` | String | The username of the chat room member to be unmuted. <br>If you want to unmute multiple members, separate the member usernames with commas (","). In the URL, use "%2C" to represent ",". | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept` | String | `application/json` | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds. The response body contains the following fields:

| Field | Type | Description |
| :------- | :----- | :------------------------------------------------- |
| `result` | Bool | The unmute result: `true`: Success; `false`: Failure. |
| `user` | String | The username of the unmuted chat room member. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'https://XXXX/XXXX/XXXX/chatrooms/XXXX/mute/XXXX'
```

#### Response example

```json
{
    "action": "delete",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/mute/XXXX",
    "entities": [],
    "data": [
        {
            "result": true,
            "user": "XXXX"
        }
    ],
    "timestamp": 1489072695859,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## Retrieving muted chat room members

Retrieves the list of all the muted members in the specified chat room.

```http
GET https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/mute
```

### HTTP request

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters ](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept` | String | `application/json` | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds. The response body contains the following fields:

| Field | Type | Description |
| :------- | :----- | :------------------------------- |
| `expire` | Number | The Unix timestamp (ms) when the mute expires. |
| `user` | String | The username of the muted chat room member. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'https://XXXX/XXXX/XXXX/chatrooms/XXXX/mute'
```

#### Response example

```json
{
    "action": "post",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/mute",
    "entities": [],
    "data": [
        {
            "expire": 1489158589481,
            "user": "user1"
        },
        {
            "expire": 1489158589481,
            "user": "user2"
        }
    ],
    "timestamp": 1489072802179,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

<a name="code"></a>

## Status codes

| Status code | Description |
| :------------------ | :----------------------------------------------------------- |
| 200 | The request succeeds. |
| 401 | Authentication fails. Possible reasons are missing token, invalid token, or expired token. You need to retrieve a new token and call the method again. |
| 404 | The user adding contacts or is added as a contact does not exist. |
| 429, 503 or 5xx | Call frequency exceeds the limit. Pause and try again later. If you need a higher call frequency, contact technical support. |
| 500 | An internal server error occurs, and the server is unable to complete the request. Contact our technical support. |