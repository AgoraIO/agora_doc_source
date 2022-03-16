User attributes refers to the label information added for the user, including key-value pairs.

This page shows how to call Agora Chat RESTful APIs to manage user attributes, including adding, deleting, modifying, and retrieving user attributes.
Before calling the following methods, make sure you understand the call frequency limit of the Agora Chat RESTful APIs as described in [Limitations](./agora_chat_limitation?platform=RESTful#call-limit-of-server-side).

<a name="param"></a>

## Common parameters

The following table lists common request and response parameters of the Agora Chat RESTful APIs:

### Request parameters

| Parameter | Type | Description | Required |
| :--------- | :----- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------- |
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. For how to get the org name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `username` | String | The unique login account of the user. The username must be 64 characters or less and cannot be empty.  The following character sets are supported:<li>26 lowercase English letters (a-z)<li>26 uppercase English letters (A-Z)<li>10 numbers (0-9)<li>"\_", "-", "."<div class="alert note"><ul><li>The username is case insensitive, so `Aa` and `aa` are the same username<li>Ensure that each username under the same app is unique.</ul></div> | Yes |

### Response parameters

| Parameter | Type | Description |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action` | String | The request method. |
| `organization` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. This is the same as `org_name`. |
| `application` | String | A unique internal ID assigned to each app by the Agora Chat service. You can safely ignore this parameter. |
| `applicationName` | String | The unique identifier assigned to each app by the Agora Chat service. This is the same as `app_name`. |
| `uri` | String | The request URI. |
| `entities ` | JSON | The response entity. |
| `timestamp` | Number | The Unix timestamp (ms) of the HTTP response. |
| `duration` | Number | The duration (ms) from when the HTTP request is sent to the time the response is received. |

## Authorization

Agora Chat RESTful APIs require Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authorization` field must be filled in the request header:

`Authorization`: Bearer ${YourAppToken}

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log in to the chat system. Agora Chat RESTful APIs only support authenticating users using app tokens. For details, see [Authentication using App Token](./generate_app_tokens?platform=RESTful).

## Setting user attributes

User attributes are composed of multiple key-value pairs of attribute names and attribute values, and each attribute name has one corresponding attribute value.

> The total length of attributes for one user cannot exceed 2 KB, and the total length of attributes for all users under an app cannot exceed 10 GB.

### HTTP request

```http
PUT https://{host}/{org_name}/{app_name}/metadata/user/{username}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters ](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type` | String | `application/x-www-form-urlencoded` | Yes |
| `Authorization` | String | Bearer ${YourAppToken} | Yes |

#### Request body

The request body is in the format of `x-www-form-urlencoded`. The data type is JSON String, and the length cannot exceed 4 KB. The request body contains the following fields:

| Field | Type | Description | Required |
| :------ | :----- | :----- | :------- |
| `Key` | String | Attribute name | Yes |
| `Value` | String | Attribute value | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request is successful, and the response body contains the following fields:

| Parameter | Type | Description |
| :----- | :--- | :----------------------------------------------------- |
| `data` | JSON | The details of the response. It contains the user attribute key-value pair you set in this request. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [the status code summary table](#code) for possible reasons.

### Example

The user attributes used in this example are named `ext`, `nickname`, and `avatar`. You can customize user attributes according to actual business scenarios.

#### Request example

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -X PUT -H 'Content-Type: application/x-www-form-urlencoded' -H 'Authorization: Bearer <YourAppToken>' -d 'avatar=http://www.agorachat.com/avatar.png&ext=ext&nickname=nickname' 'http://XXXX/XXXX/XXXX/metadata/user/XXXX'
```

#### Response example

```json
{
    "timestamp": 1620445147011,
    "data": {
        "ext": "ext",
        "nickname": "nickname",
        "avatar": "http://XXXX.png"
    },
    "duration": 166
}
```

## Retrieving user attributes

Retrieves the user attributes of the specified user.

### HTTP request

```http
GET https://{host} /{org_name}/{app_name}/metadata/user/{username}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters ](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type` | String | `application/json` | Yes |
| `Authorization` | String | Bearer ${YourAppToken} | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request is successful, and the response body contains the following fields:

| Parameter | Type | Description |
| :----- | :--- | :------------------------------------------------------------------------------------------------------------- |
| `data` | JSON | The details of the response. It contains all user attribute key-value pairs for this user. <br>If `data` is empty, ensure that the username exists or the user has at least one user attribute. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -X GET -H 'Authorization: Bearer <YourAppToken>' -H 'Content-Type:  application/json''http://XXXX/XXXX/XXXX/metadata/user/XXXX'
```

#### Response example

```json
{
    "timestamp": 1620445147011,
    "data": {
        "ext": "ext",
        "nickname": "nickname",
        "avatar": "http://XXXX.png"
    },
    "duration": 166
}
```

## Retrieving the user attributes of multiple users

Retrieves the user attributes of multiple users by specifying the user name list and user attribute list.

### HTTP request

```http
POST https://{host} /{org_name}/{app_name}/metadata/user/get
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters ](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type` | String | `application/json` | Yes |
| `Authorization` | String | Bearer ${YourAppToken} | Yes |

#### Request body

The request body is a JSON object with the following fields:

| Parameter | Type | Description | Required |
| :----------- | :--------- | :------------------------------------------ | :------- |
| `targets` | JSONArray | A list of usernames to be queried, containing up to 100 usernames. | Yes |
| `properties` | JSONArray | A list of attribute names to be queried. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request is successful, and the response body contains the following fields:

| Parameter | Type | Description |
| :----- | :--- | :----------------------------------------------------------------------------------------------------------- |
| `data` | JSON | The details of the response. It contains all user attribute key-value pairs for this user. <br>If `data` is empty, ensure that the username exists or the user has at least one user attribute. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#code) for possible reasons.

### Example

#### Request example

```json
# Replace <YourAppToken> with the app token generated in your server.
curl -X POST -H 'Authorization: Bearer <YourAppToken>' -H 'Content-Type:  application/json' -d '{
  "properties": [
    "avatar",
    "ext",
    "nickname"
  ],
  "targets": [
    "user1",
    "user2",
    "user3"
  ]
}' 'http://XXXX/XXXX/XXXX/metadata/user/get'
```

#### Response example

```json
{
    "timestamp": 1620448826647,
    "data": {
        "user1": {
            "ext": "ext",
            "nickname": "nickname",
            "avatar": "http://XXXX.png"
        },
        "user2": {
            "ext": "ext",
            "nickname": "nickname",
            "avatar": "http://XXXX.png"
        },
        "user3": {
            "ext": "ext",
            "nickname": "nickname",
            "avatar": "http://XXXX.png"
        }
    },
    "duration": 3
}
```

## Retrieving the total length of user attributes

Retrieves the total length of the user attributes under the app.

### HTTP request

```http
GET https://{host} /{org_name}/{app_name}/metadata/user/capacity
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters ](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Authorization` | String | Bearer ${YourAppToken} | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request is successful, and the response body contains the following fields:

| Parameter | Type | Description |
| :----- | :----- | :--------------------------------- |
| `data` | Number | The total length of the user attributes under the app, in bytes. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](./agora_chat_status_code?platform=RESTful) for possible reasons.

### Example

#### Request example

```json
curl -X GET -H 'Authorization: Bearer <YourAppToken>''http://XXXX/XXXX/XXXX/metadata/user/capacity'
```

#### Response example

```json
{
    "timestamp": 1620447051368,
    "data": 1673,
    "duration": 55
}
```

## Deleting user attributes

Deletes all the user attributes of the specified user.

### HTTP request

```http
DELETE https://{host} /{org_name}/{app_name}/metadata/user/{username}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters ](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Authorization` | String | Bearer ${YourAppToken} | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request is successful, and the response body contains the following fields:

| Parameter | Type | Description |
| :----- | :--- | :-------------------------------------------------------------------------------------------------------------------------- |
| `data` | Bool | Whether the user attribute is deleted successfully. If `data` is `true`, the user attribute is deleted. <br>If the specified user does not exist, or the user attribute of the specified user does not exist, the deletion is still considered successful. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](./agora_chat_status_code?platform=RESTful) for possible reasons.

### Example

#### Request example

```json
curl -X DELETE -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/metadata/user/XXXX'
```

#### Response example

```json
{
    "timestamp": 1616573382270,
    "duration": 10,
    "data": true
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
