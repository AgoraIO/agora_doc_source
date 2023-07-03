This page shows how to manage chat rooms by calling Agora Chat RESTful APIs, including adding, deleting, modifying, and retrieving chat rooms.  

Before calling the following methods, ensure that you understand the frequency limit of calling Agora Chat RESTful API calls described in [Limitations](./agora_chat_limitation?platform=RESTful#call-limit-of-server-side).

## Common parameters <a name="param"></a>

The following table lists common request and response parameters of the Agora Chat RESTful APIs:

### Request parameters

| Parameter | Type | Description | Required |
| :--------- | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service.  For how to get the org name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `username` | String | The unique login account of the user. The username must be 64 characters or less and cannot be empty.  The following character sets are supported:<li>26 lowercase English letters (a-z)</li><li>26 uppercase English letters (A-Z)</li><li>10 numbers (0-9)</li><li>"\_", "-", "."</li><div class="alert note"><ul><li>The username is case insensitive, so `Aa` and `aa` are the same username. </li><li>Ensure that each username under the same app must be unique.</li></ul></div> | Yes |

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

## Authorization

Agora Chat RESTful APIs require Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authorization` field must be filled in the request header:

`Authorization`: Bearer ${YourAppToken}

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log into the chat system. The Agora Chat RESTful API only supports authenticating users using app tokens. For details, see [Authentication using App Token](./generate_app_tokens?platform=RESTful).

## Creating a chat room

Creates a chat room.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/chatrooms
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept` | String | `application/json` | Yes |
| `Content-Type` | String | `application/json` | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

The request body is a JSON object, which contains the following fields:

| Field | Type | Description | Required |
| :------------ | :--------- | :--------------------------------------- | :------- |
| `groupid` | String | The custom group ID. It cannot exceed 18 digits and cannot start with zero (0). This field is disabled by default. To enable this field, contact [support@agora.io](mailto:support@agora.io).  | No |
| `name` | String | The chat room name which can contain a maximum of 128 characters. | Yes |
| `description` | String | The chat room description which can contain a maximum of 512 characters. | Yes |
| `maxusers` | Int | The maximum number of members (including the chat room creator) that can join a chat room. | No |
| `owner` | String | The username of the chat room creator. | Yes |
| `members` | JSONArray | The members in the chat room. This parameter cannot be empty. | No |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Field | Type | Description |
| :--- | :----- | :-------------------------------------------------------------- |
| `id` | String | The chat room ID. This is the unique identifier assigned to each chat room by the Agora Chat service. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```json
# Replace <YourAppToken> with the app token you generated on the server
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
   "name": "testchatroom1",
   "description": "test",
   "maxusers": 300,
   "owner": "user1",
   "members": [
     "user2"
   ]
 }' 'http://XXXX/XXXX/XXXX/chatrooms'
```

#### Response example

```json
{
    "data": {
        "id": "66213271109633"
    }
}
```

## Retrieving basic information of all chat rooms <a name="getall"></a>

Retrieves the basic information of all chat rooms under the app by page.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/chatrooms?limit={N}&cursor={cursor}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters ](#param).

#### Query parameter

| Parameter | Type   | Description   | Required |
| :------- | :----- | :------------------------ | :------- |
| `limit`  | Number |  The number of chat rooms to retrieve per page. The default value is `10`. The value range is [1,100].   | No  |
| `cursor` | String |  The start position for the next query.  | No  |

<div class="alert info">If the <code>limit</code> and <code>cursor</code> parameters are not specified, the basic information of 10 chat rooms on the first page is returned by default.<div>

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept` | String | `application/json` | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds. The response body contains the following fields:

| Field | Type | Description |
| :------------------- | :----- | :---------------------------------------------------- |
| `id` | String | The chat room ID. This is the unique identifier assigned to the chat room by the Agora Chat. |
| `name` | String | The chat room name. |
| `owner` | String | The username of the chat room creator. |
| `affiliations_count` | Number | The number of members (including the chat room creator) in the chat room. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```json
# Replace <YourAppToken> with the app token you generated on the server
curl --location --request GET 'http://XXXX/XXXX/XXXX/chatrooms?limit=10' \
--header 'Authorization: Bearer <YourAppToken>'
```

#### Response example

```json
{
    "action": "get",
    "application": "2a8f5b13-XXXX-XXXX-958a-838fd47f1223",
    "applicationName": "chatdemoui",
    "count": 3,
    "data": [
        {
            "affiliations_count": 1,
            "disabled": false,
            "id": "212126099636225",
            "name": "testchatroom1",
            "owner": "yifan1"
        },
        {
            "affiliations_count": 1,
            "disabled": false,
            "id": "212126098587649",
            "name": "testchatroom2",
            "owner": "yifan1"
        },
        {
            "affiliations_count": 1,
            "disabled": false,
            "id": "212126095441921",
            "name": "testchatroom3",
            "owner": "yifan1"
        }
    ],
    "duration": 1,
    "entities": [],
    "organization": "XXXX",
    "params": {
        "limit": [
            "5"
        ]
    },
    "properties": {},
    "timestamp": 1681697615739,
    "uri": "http://a1-hsb.easemob.com/easemob-demo/chatdemoui/chatrooms"
}
```

## Retrieving chat rooms that a user joins

Retrieves all the chat rooms that a user joins.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/users/{username}/joined_chatrooms
```

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

| Field | Type | Descriptions |
| :----- | :----- | :---------------------------------------------------------------- |
| `id` | String | The ID of the chat room that the user joins. This is the unique identifer assigned to each chat room by the Agora Chat. |
| `name` | String | The name of the chat room that the user joins.  |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/users/XXXX/joined_chatrooms'
```

#### Response example

```json
{
    "data": {
        "id": "66211860774913",
        "name": "test"
    }
}
```

## Retrieving detailed information of the specified chat rooms

Retrieves the detailed information of one or more specified chat rooms.

### HTTP request

```json
# Replace <YourAppToken> with the app token generated in your server.
GET https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------------ | :----- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `chatroom_id` | String | The chat room ID. The unique identifier assigned to each chat room by the Agora Chat service. You can get the chat room ID from the response body of [Retrieve basic information of all chat rooms](#getall).<li>When retrieving multiple chat rooms, type multiple chatroom IDs (`chatroom_id`) separated with the comma (,). </li><li>A maximum of 100 chat rooms can be retrieved at one go.</li><li>In the URL, "," needs to be escaped as "%2C".</li> | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept` | String | `application/json` | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

### Response body

If the returned HTTP status code is `200`, the request succeeds. The response body contains the following fields:

| Field | Type | Description |
| :------------------- | :--------- | :-------------------------------------------------------------------------------------------------------------------------------------------- |
| `id` | String | The chat room ID. |
| `name` | String | The chat room name. |
| `description` | String | The chat room description. |
| `membersonly` | Bool | Whether a user requesting to join the chat room requires approval from the chat room administrator.<li>`true`: Yes</li><li>`fale`: No</li> |
| `allowinvites` | Bool | Whether to allow a chat room member to invite others to join the chat room.<li>`true`: A chat room member can invite others to join the chat room.</li><li>`false`: Only the chat room administrator can invite others to join the chat room.</li> |
| `maxusers` | Int | The maximum number of members that can join the chat room. |
| `owner` | String | The username of the chat room creator. |
| `created` | Number | The Unix timestamp (ms) when the chat room is created. |
| `custom` | String | Custom information added during creation of the chat room. |
| `affiliations_count` | int | The number of members (including the chat room creator) in the chat room. |
| `affiliations` | JSONArray | The chat room member array, which contains the following fields:<li>`owner`: The username of the chat room creator.</li><li>`member`: The username of each chat room member.</li> |
| `public` | Bool | It is a reserved parameter. You can safely ignore this parameter. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX%2CXXXX'
```

#### Response example

```json
{
    "action": "get",
    "application": "22bcffa0-XXXX-XXXX-9df8-516f6df68c6d",
    "applicationName": "XXXX",
    "count": 2
    "data": [
        {
            "id": "XXXX",
            "name": "testchatroom1",
            "description": "test",
            "membersonly": false,
            "allowinvites": false,
            "maxusers": 1000,
            "created": 1641365888209,
            "custom": "",
            "affiliations_count": 2,
            "affiliations": [
                {
                    "member": "user1"
                },
                {
                    "owner": "user2"
                }
            ],
            "public": true
        },
        {
            "id": "XXXX",
            "name": "testchatroom2",
            "description": "test",
            "membersonly": false,
            "allowinvites": false,
            "invite_need_confirm": true,
            "maxusers": 10000,
            "created": 1641289021898,
            "custom": "",
            "mute": false,
            "scale": "large",
            "affiliations_count": 1,
            "affiliations": [
                {
                    "owner": "user3"
                }
            ],
            "public": true
        }
    ],
    "duration": 0,
    "entities": [],
    "organization": "XXXX",
    "timestamp": 1642064417048,
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX%2CXXXX"
}
```

## Modifying chat room information

Modifies the information of the specified chat room. You can only modify the `name`, `description`, and `maxusers` of a chat room.

### HTTP request

```http
PUT https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------------ | :----- | :------------------------------------------------------------------------------------------------------------ | :------- |
| `chatroom_id` | String | The chat room ID. The unique identifier assigned to each chat room by the Agora Chat service. You can get the chat room ID from the response body of [Retrieve basic information of all chat rooms](#getall). | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type` | String | `application/json` | Yes |
| `Accept` | String | `application/json` | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

The request body is a JSON object which only contains the following fields:

| Field | Type | Description | Required |
| :------------ | :----- | :------------------------------------------------- | :------- |
| `name` | String | The chat room name. It cannot contain slashes or spaces that need to be replaced with "+". | No |
| `description` | String | The chat room description. It cannot contain slashes or spaces that need to be replaced with "+". | No |
| `maxusers` | Number | The maximum number of chat room members (including the chat room creator). | No |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds and the response body contains the following fields:

| Field | Type | Description |
| :------------ | :--- | :---------------------------------------------------------------------------------------------- |
| `groupname` | Bool | Whether the chat room name is successfully changed.<li>`true`: Success</li><li>`false`: Failure</li> |
| `description` | Bool | Whether the chat room description is successfully modified.<li>`true`: Success</li><li>`false`: Failure</li> |
| `maxusers` | Bool | Whether the maximum number of members that can join the chat room is successfully changed.<li>`true`: Success</li><li>`false`: Failure</li> |

If the returned HTTP status code is not `200`, the request failed. You can refer to [Status codes](#code) for possible reasons.

> If other fields than `name`, `description`, and `maxusers` are passed in the request body, the request fails and the error code `400` is returned.

### Example

#### Request example

```json
curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
   "name": "testchatroom",
   "description": "test",
   "maxusers": 300,
 }' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX'
```

#### Response example

```json
{
    "data": {
        "description": true,
        "maxusers": true,
        "groupname": true
    }
}
```

## Deleting the specified chat room

Deletes the specified chat room.  If the specified chat room does not exist, an error returns.

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------------------------------------------------------- | :------- |
| `chatroom_id` | String | The chat room ID. The unique identifier assigned to each chat room by the Agora Chat service. You can get the chat room ID from the response body of [Retrieve basic information of all chat rooms](#getall). | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept` | String | `application/json` | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds and the response body contains the following fields:

| Field | Type | Description |
| :-------- | :----- | :---------------------------------------------------------------- |
| `success` | Bool | Whether the chat room is successfully deleted.<li>`true`: Success</li><li>`false`: Failure</li> |
| `id` | String | The ID of the chat room that is deleted. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX'
```

#### Response example

```json
{
    "action": "delete",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX",
    "entities": [],
    "data": {
        "success": true,
        "id": "66211860774913"
    },
    "timestamp": 1542545100474,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```
	
<a name="code"></a>


## Retrieving a chat room announcement

Retrieves the announcement text for the specified chat room.

### HTTP request

```
GET https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/announcement
```

#### Path parameter

| Parameter         | Type   | Required | Description                                                       |
| :------------ | :----- | :------- | :--------------------------------------------------------- |
| `chatroom_id` | String | Yes | The chat room ID. The unique identifier assigned to each chat room by the Agora Chat service. You can get the chat room ID from the response body of [Retrieve basic information of all chat rooms](#getall). |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter            | Type   | Required | Description                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | Yes     | Set to `application/json`.                                 |
| `Accept` | String | Yes | `application/json` |
| `Authorization` | String | Yes     | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. |

### HTTP response

The response body contains the following fields:

| Parameter      | Type    | Description                                                       |
| :-------- | :------ | :--------------------------------------------------------- |
| data.announcement | String | The announcement text of the specified chat room. |

### Example

#### Request example

```
curl -X GET -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourToken> ' 'http://XXXX/XXXX/XXXX/chatrooms/12XXXX11/announcement'
```

#### Response example

```
{
  "action": "get",
  "application": "52XXXXf0",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/12XXXX11/announcement",
  "entities": [],
  "data": {
    "announcement" : "XXXX."
  },
  "timestamp": 1542363546590,
  "duration": 0,
  "organization": "XXXX",
  "applicationName": "testapp"
}
```

## Modifying a chat room announcement

Modifies the announcement text of the specified chat room. The length cannot exceed 512 characters.

### HTTP request

```
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/announcement
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------------------------------------------------------- | :------- |
| `chatroom_id` | String | The chat room ID. The unique identifier assigned to each chat room by the Agora Chat service. You can get the chat room ID from the response body of [Retrieve basic information of all chat rooms](#getall). | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter            | Type   | Required | Description                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | Yes     | Set to `application/json`.                                 |
| `Authorization` | String | Yes     | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. |


#### Request body

| Parameter           | Type   | Required | Description                 |
| :------------- | :----- | :------- | :------------------- |
| `announcement` | String | Yes       | The modified announcement text. |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds and the response body contains the following fields:

| Parameter      | Type    | Description                                                       |
| :-------- | :------ | :--------------------------------------------------------- |
| `data.id` | String | The chat room ID. |
| `data.result` | Boolean | Whether the chat room announcement is successfully modified: <li>`true`: Success</li><li>`false`: Failure</li> |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourToken> ' 'http://XXXX/XXXX/XXXX/chatrooms/12XXXX11/announcement' -d '{"announcement" : "chat room announcement"}'
```

#### Response example

```
{
  "action": "post",
  "application": "52XXXXf0",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/12XXXX11/announcement",
  "entities": [],
  "data": {
    "id": "12XXXX11",
    "result": true
  },
  "timestamp": 1594808604236,
  "duration": 0,
  "organization": "XXXX",
  "applicationName": "testapp"
}
```

## Status codes

For details, see [HTTP Status Codes](./agora_chat_status_code?platform=RESTful).