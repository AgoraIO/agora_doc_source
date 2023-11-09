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
| `username` | String | The unique login account of the user. The username must be 64 characters or less and cannot be empty.  The following character sets are supported:<li>26 lowercase English letters (a-z)<li>26 uppercase English letters (A-Z)<li>10 numbers (0-9)<li>"\_", "-", "."<div class="alert note"><ul><li>The username is case insensitive, so `Aa` and `aa` are the same username.</li><li>Ensure that each `username` under the same app is unique.</li><li>Do not set this parameter as a UUID, email address, phone number, or other sensitive information.</li></ul></div> | Yes |

### Response parameters

| Parameter | Type | Description |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action` | String | The request method. |
| `organization` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. This is the same as `org_name`. |
| `application` | String | A unique internal ID assigned to each app by the Agora Chat service. You can safely ignore this parameter. |
| `applicationName` | String | The unique identifier assigned to each app by the Agora Chat service. This is the same as `app_name`. |
| `uri` | String | The request URI. |
| `username`        | String | The unique login account of the user.                    |
| `entities` | JSON | The response entity. |
| `nickname`   | String | The nickname of the user.                                                  |
| `ext`        | String | The custom extension field of the user.                  |
| `avatarurl`  | String | The avatar URL of the user.                                               |
| `timestamp` | Number | The Unix timestamp (ms) of the HTTP response. |
| `duration` | Number | The duration (ms) from when the HTTP request is sent to the time the response is received. |

## Authorization

Agora Chat RESTful APIs require Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authorization` field must be filled in the request header:

```http
Authorization: Bearer ${YourAppToken}
```

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log in to the chat system. Agora Chat RESTful APIs only support authenticating users using app tokens. For details, see [Authentication using App Token](./generate_app_tokens?platform=RESTful).

## Setting user attributes

User attributes are composed of multiple key-value pairs of attribute names and attribute values, and each attribute name has one corresponding attribute value.

For each App Key, the call frequency limit of this method is 100 per second.

> The total length of attributes for one user cannot exceed 2 KB, and the total length of attributes for all users under an app cannot exceed 10 GB.

### HTTP request

```http
PUT https://{host}/{org_name}/{app_name}/metadata/user/{username}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :---------------------------------- | :------- |
| `Content-Type` | String | `application/x-www-form-urlencoded` | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

The request body is in the format of JSON String, and the length cannot exceed 4 KB. The request body contains the following fields:

| Field | Type | Description | Required |
| :------ | :----- | :----- | :------- |
| `Key` | String | Attribute name | Yes |
| `Value` | String | Attribute value | Yes |

When you call this RESTful API to set the user's nickname, avatar, contact information, email address, gender, signature, birthday and extension fields, you must pass in the following keys to make sure that the client can obtain the settings from the server:

| Field        | Type   | Description                                                         |
| :---------- | :----- | :----------------------------------------------------------- |
| `nickname`  | String | The user nickname, which can contain at most 64 characters.    |
| `avatarurl` | String | The user avatar URL, which can contain at most 256 characters.     |
| `phone`     | String | The user's phone number, which can contain at most 32 characters.  |
| `mail`      | String | The user's email address, which can contain at most 64 characters. |
| `gender`    | Number | The user gender: <ul><li>`1`：Male; </li><li>`2`：Female;</li><li>(Default) `0`: Unknown;</li><li>Other values are invalid.</li></ul> |
| `sign`      | String | The user's signature, which can contain at most 256 characters.  |
| `birth`     | String | The user's birthday, which can contain at most 64 characters.  |
| `ext`       | String | The extension fields.                                                   |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter | Type | Description |
| :----- | :--- | :----------------------------------------------------- |
| `data` | JSON | The details of the response. It contains the user attribute key-value pair you set in this request. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](./agora_chat_status_code?platform=RESTful) for possible reasons.

### Example

The user attributes used in this example are named `ext`, `nickname`, and `avatar`. You can customize user attributes according to actual business scenarios.

#### Request example

```shell
# Replace {YourAppToken} with the app token generated in your server.
curl -X PUT -H 'Content-Type: application/x-www-form-urlencoded' -H 'Authorization: Bearer {YourAppToken}' -d 'avatarurl=http://www.agorachat.com/avatar.png&ext=ext&nickname=nickname' 'http://XXXX/XXXX/XXXX/metadata/user/XXXX'
```

#### Response example

```json
{
    "timestamp": 1620445147011,
    "data": {
        "ext": "ext",
        "nickname": "nickname",
        "avatarurl": "http://XXXX.png"
    },
    "duration": 166
}
```

## Retrieving user attributes

Retrieves the user attributes of the specified user. 

For each App Key, the call frequency limit of this method is 100 per second.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/metadata/user/{username}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type` | String | `application/json` | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter | Type | Description |
| :----- | :--- | :------------------------------------------------------------------------------------------------------------- |
| `data` | JSON | The details of the response. It contains all user attribute key-value pairs for this user. <br>If `data` is empty, ensure that the username exists or the user has at least one user attribute. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](./agora_chat_status_code?platform=RESTful) for possible reasons.

### Example

#### Request example

```shell
# Replace {YourAppToken} with the app token generated in your server.
curl -X GET -H 'Authorization: Bearer {YourAppToken}' -H 'Content-Type:  application/json''http://XXXX/XXXX/XXXX/metadata/user/XXXX'
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

For each App Key, the call frequency limit of this method is 100 per second.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/metadata/user/get
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Content-Type` | String | `application/json` | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

The request body is a JSON object with the following fields:

| Parameter | Type | Description | Required |
| :----------- | :--------- | :------------------------------------------ | :------- |
| `targets` | JSONArray | A list of usernames to be queried, containing up to 100 usernames. | Yes |
| `properties` | JSONArray | A list of attribute names to be queried. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter | Type | Description |
| :----- | :--- | :----------------------------------------------------------------------------------------------------------- |
| `data` | JSON | The details of the response. It contains all user attribute key-value pairs for this user. <br>If `data` is empty, ensure that the username exists or the user has at least one user attribute. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](./agora_chat_status_code?platform=RESTful) for possible reasons.

### Example

#### Request example

```shell
# Replace {YourAppToken} with the app token generated in your server.
curl -X POST -H 'Authorization: Bearer {YourAppToken}' -H 'Content-Type:  application/json' -d '{
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

## Retrieving the total size of user attributes in the app

This method retrieves the total size of user attributes under the app.

For each App Key, the call frequency limit of this method is 100 per second.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/metadata/user/capacity
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

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

```shell
curl -X GET -H 'Authorization: Bearer {YourAppToken}''http://XXXX/XXXX/XXXX/metadata/user/capacity'
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

This method deletes all the user attributes of the specified user.

For each App Key, the call frequency limit of this method is 100 per second.

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/metadata/user/{username}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :-------------- | :----- | :--------------------- | :------- |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter | Type | Description |
| :----- | :--- | :-------------------------------------------------------------------------------------------------------------------------- |
| `data` | Bool | Whether the user attribute is deleted successfully. If `data` is `true`, the user attribute is deleted. <br>If the specified user does not exist, or the user attribute of the specified user does not exist, the deletion is still considered successful. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](./agora_chat_status_code?platform=RESTful) for possible reasons.

### Example

#### Request example

```shell
curl -X DELETE -H 'Authorization: Bearer {YourAppToken}' 'http://XXXX/XXXX/XXXX/metadata/user/XXXX'
```

#### Response example

```json
{
    "timestamp": 1616573382270,
    "duration": 10,
    "data": true
}
```

## Status codes

For details, see [HTTP Status Codes](./agora_chat_status_code?platform=RESTful).
