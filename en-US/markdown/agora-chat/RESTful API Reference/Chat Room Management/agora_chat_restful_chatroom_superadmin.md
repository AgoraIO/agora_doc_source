In an app integrated with Agora Chat, only the super admin of chat rooms has the permission to create chat rooms on the client.

This page shows how to manage super administrators of chat rooms by calling the Agora Chat RESTful APIs, including adding and retrieving super administrators and revoking the chat room creation privilege of a super administrator. Before calling the following methods, ensure that you understand the call frequency limit of the Agora Chat RESTful APIs described in [Limitations](./agora_chat_limitation?platform=RESTful#call-limit-of-server-side).

## <a name="param"></a>Common parameters

The following table lists common request and response parameters of the Agora Chat RESTful APIs:

### Request parameters


| Parameter | Type | Description | Required |
| :---------------- | :----- | :---------------------------------------------------------------- | :---------------------------------------------------------------- |
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. For how to get the org name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `username` | String | The username. The unique login account of the user. The username must be 64 characters or less and cannot be empty.  The following character sets are supported:<li>26 lowercase English letters (a-z)</li><li>26 uppercase English letters (A-Z)</li><li>10 numbers (0-9)</li><li>"\_", "-", "."</li><div class="alert note"><ul><li>The username is case insensitive,  so `Aa` and `aa` are the same username. </li><li>Ensure that each username under the same app must be unique.</li></ul></div> | Yes |
| `chatroom_id` | String | The chat room ID. The unique chat room identifier assigned to each chat room by the Agora Chat. You can get the chat room ID from the response body in [Retrieve the basic information of all chat rooms](./agora_chat_restful_chatroom?platform=RESTful#getall). | Yes |

### Response parameters

| Parameter | Type | Description |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action` | String | The request method. |
| `organization` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. This is the same as `org_name`. |
| `application` | String | A unique internal ID assigned to each app by the Agora Chat service. You can safely ignore this parameter. |
| `applicationName` | String | The unique identifier assigned to each app by the Agora Chat service. This is the same as `app_name`. |
| `uri` | String | The request URI. |
| `path` | String | The request path, which is part of the request URL. You can safely ignore this parameter. |
| `entities ` | JSON | The response entity. |
| `data` | JSON | The details of the response. |
| `timestamp` | Number | The Unix timestamp (ms) of the HTTP response. |
| `duration` | Number | The duration (ms) from when the HTTP request is sent to the time the response is received. |

## Authorization

Agora Chat RESTful APIs require Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authorization` field must be filled in the request header:

```shell
Authorization: Bearer ${YourAppToken}
```

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log into the chat system. The Agora Chat RESTful API only supports authenticating users using app tokens. For details, see [Authentication using App Token](./generate_app_tokens).


## Adding a chat room super admin

Adds a regular chat room member as the super admin of the chat room.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/super_admin
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
| :----------- | :----- | :--------------------------------- | :------- |
| `superadmin` | String | The username of the user to be added as the super administrator of chat rooms. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Field | Type | Description |
| :--------- | :----- | :------------------------------------------------------ |
| `result` | Bool | The addition result:<li>`true`: Success</li><li>`false`: Failure</li> |
| `resource` | String | It is a reserved parameter. You can safely ignore this parameter. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```json
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>'-d
'{
   "superadmin": user1
 }''http://XXXX/XXXX/XXXX/chatrooms/super_admin'
```

#### Response example

```json
{
    "action": "post",
    "application": "9fa492a0-XXXX-XXXX-b1b9-a76b05da6904",
    "uri": "https://XXXX/XXXX/XXXX/chatrooms/super_admin",
    "entities": [],
    "data": {
        "result": "success",
        "resource": ""
    },
    "timestamp": 1596187658017,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## Removing a chat room super admin

Removes the super admin privileges of the chat room super admin and that super admin becomes a regular chat room member.

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/super_admin/{superAdmin}
```

### HTTP request

#### Path parameter

| Parameter | Type | Description | Required |
| :----------- | :----- | :----------------------------------- | :------- |
| `superAdmin` | String | The username of the super admin whose  privilege is to be revoked. | Yes |

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
| :-------------- | :----- | :------------------------------- |
| `newSuperAdmin` | String | The username of the super admin whose privilege is revoked. |
| `resource` | String | It is a reserved parameter. You can safely ignore this parameter. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```json
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatrooms/super_admin/XXXX'
```

#### Response example

```json
{
    "action": "delete",
    "application": "9fa492a0-XXXX-XXXX-b1b9-a76b05da6904",
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/super_admin/XXXX",
    "entities": [],
    "data": {
        "newSuperAdmin": "XXXX",
        "resource": ""
    },
    "timestamp": 1596187855832,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```
## Retrieving super admins of specified chat rooms with pagination

Retrieves the super admins of the specified chat rooms by pagination.

### HTTP request

```http
GET https://{host} /{org_name}/{app_name}/chatrooms/super_admin?pagenum={N}&pagesize={N}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :--------- | :--- | :-------------------------------------- | :------- |
| `pagenum` | Int | The number of page on which chat room admins are retrieved. The default value is 1. | No |
| `pagesize` | Int | The number of super admins displayed on each page. The default value is 10. | No |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Accept` | String | `application/json` | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter | Type | Descriptions |
| :--------- | :--------- | :------------------------------- |
| `pagenum` | Int | The current page number. |
| `pagesize` | Int | The maximum number of super administrators displayed on each page. |
| `data` | JSONArray | The array of usernames of super admins of the specified chat rooms. |
| `count` | Number | The number of super admins that are returned. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```json
curl -X GET http://XXXX/XXXX/XXXX/chatrooms/super_admin?pagenum=2&pagesize=2 -H 'Authorization: Bearer <YourAppToken>'
```

#### Response example

```json
{
    "action": "get",
    "application": "9fa492a0-XXXX-XXXX-b1b9-a76b05da6904",
    "params": {
        "pagesize": ["2"],
        "pagenum": ["2"]
    },
    "uri": "http://XXXX/XXXX/XXXX/chatrooms/super_admin",
    "entities": [],
    "data": ["hxtest1", "hxtest11", "hxtest10"],
    "timestamp": 1596187292391,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX",
    "count": 3
}
```
	
<a name="code"></a>

## Status codes

For details, see [HTTP Status Codes](./agora_chat_status_code?platform=RESTful).
