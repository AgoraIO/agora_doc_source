# Manage Chat Room Allow List

A chat room allow list refers to a list of chat room members that can send messages after the chat room owner or admins have muted all the chat room members using the global mute method. Agora Chat provides a complete set of allow list management methods, including adding users to the allow list and removing them from it, as well as retrieving the members on the allow list.

This page shows how to manage a chat room allow list using the Agora Chat RESTful APIs. Before calling the following methods, ensure that you understand the call frequency limit described in [Limitations](./agora_chat_limitation?platform=RESTful).

## Common parameters<a name="param"></a>

The following table lists the common request and response parameters of the Agora Chat RESTful APIs:

### Request parameters

| Parameter | Type | Description | Required |
| :--------- | :----- | :----------------------------------------------------------- | :------- |
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. For how to get the org name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `username` | String | The username. The unique login account of the user. The username must be 64 characters or less and cannot be empty. The following character sets are supported:<li>26 lowercase English letters (a-z)</li><li>26 uppercase English letters (A-Z)</li><li>10 numbers (0-9)</li><li>"\_", "-", "."</li><div class="alert note"><ul><li>The username is case insensitive,  so `Aa` and `aa` are the same username. </li><li>Ensure that each username under the same app must be unique.</li></ul></div> | Yes |
| `chatroom_id` | String | The chat room ID. The unique identifier assigned to each chat room by the Agora Chat service. You can get the chat room ID from the response body of [Retrieve basic information of all chat rooms](./agora_chat_restful_chatroom?platform=RESTful#retrieving-basic-information-of-all-chat-rooms). | Yes |

### Response parameters

| Parameter | Type | Description |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action` | String | The request method. |
| `organization` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. This is the same as `org_name`. |
| `application` | String | A unique internal ID assigned to each app by the Agora Chat service. You can safely ignore this parameter. |
| `applicationName` | String | The unique identifier assigned to each app by the Agora Chat service. This is the same as `app_name`. |
| `uri` | String | The request URI. |
| `path` | String | The request path, which is part of the request URI. You can safely ignore this parameter. |
| `entities ` | JSON | The response entity. |
| `data` | JSON | The details of the response. |
| `timestamp` | Number | The Unix timestamp (ms) of the HTTP response. |
| `duration` | Number | The duration (ms) from when the HTTP request is sent to the time the response is received. |
| `chatroomid` | String | The unique identifier of the chat room. | Yes |

## Authorization

Agora Chat RESTful APIs require Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authorization` field must be filled in the request header:

```shell
Authorization: Bearer ${YourAppToken}
```

In order to improve project security, Agora uses a token (dynamic key) to authenticate users before they log in to the chat system. The Agora Chat RESTful API only supports authenticating users using app tokens. For details, see [Authentication using App Token](./generate_app_tokens).

## Retrieving the chat room allow list

Retrieves the list of all the members on the chat group allow list.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the `data` field in the response body contains the usernames in the chat room allow list.

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer YWMt4LqJIul7EeizhBO5TSO_UgAAAAAAAAAAAAAAAAAAAAGL4CTw6XgR6LaXXVmNX4QCAgMAAAFnG7GyAQBPGgDv4ENRUku7fg05Kev0a_aVC8NyA6O6PgpxIRjajSVN3g' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/white/users'
```

#### Response example

```
{
  "action": "get",
  "application": "5cf28979-XXXX-XXXX-b969-60141fb9c75d",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/white/users",
  "entities": [],
  "data": [
    "wzy_test",
    "wzy_vivo",
    "wzy_huawei",
    "wzy_xiaomi",
    "wzy_meizu"
  ],
  "timestamp": 1594724947117,
  "duration": 3,
  "organization": "XXXX",
  "applicationName": "XXXX",
  "count": 5
}
```

## Adding a user to the chat room allow list

Adds the specified user to the chat room allow list. Members in the chat room allow list can still send messages after the chat room owner or an admin has muted all the chat room members using the global mute method.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users/{username}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the data field in the response body contains the following fields:

| Parameter      | Type | Description                                                         |
| :-------- | :----- | :----------------------------------------------------------- |
| `result`  | Boolean | Whether the user is successfully added to the chat room allow list. <li>`true`: Yes. <li>`false`: No. |
| `user`    | String | The username added to the chat room block list.                                   |

For other parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```
curl -X POST -H 'Accept: application/json' -H 'Authorization: Bearer YWMt4LqJIul7EeizhBO5TSO_UgAAAAAAAAAAAAAAAAAAAAGL4CTw6XgR6LaXXVmNX4QCAgMAAAFnG7GyAQBPGgDv4ENRUku7fg05Kev0a_aVC8NyA6O6PgpxIRjajSVN3g' 'http://XXXX/XXXX/XXXX/chatrooms/{XXXX}/white/users/{username}' 
```

#### Response example

```
{
  "action": "post",
  "application": "5cf28979-13e7-4c87-b969-60141fb9c75d",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/white/users/wzy_xiaomi",
  "entities": [],
  "data": {
    "result": true,
    "action": "add_user_whitelist",
    "user": "wzy_xiaomi",
    "chatroomid": "XXXX"
  },
  "timestamp": 1594724293063,
  "duration": 4,
  "organization": "XXXX",
  "applicationName": "XXXX"
}
```

## Adding multiple members to the chat room allow list

Adds multiple users to the chat room allow list. You can add a maximum of 60 users to the chat room allow list each time.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter        | Type  | Description              |
| :---------- | :---- | :---------------- |
| `usernames` | Array | The array of usernames to be added to the chat room allow list. You can specify a maximum of 60 usernames, separated by commas (,). |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the data field in the response body contains the following parameters.

| Parameter      | Type    | Description                                                         |
| :-------- | :------ | :----------------------------------------------------------- |
| `result`  | Boolean | Whether the users are successfully added to the chat room allow list.<li>`true`: Yes. <li>`false`: No. |
| `reason`  | String  | The reason why the users fail to be added to the chat room allow list.                                       |
| `user`    | String  | The usernames added to the chat room allow list.                                     |

For the parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer YWMt4LqJIul7EeizhBO5TSO_UgAAAAAAAAAAAAAAAAAAAAGL4CTw6XgR6LaXXVmNX4QCAgMAAAFnG7GyAQBPGgDv4ENRUku7fg05Kev0a_aVC8NyA6O6PgpxIRjajSVN3g' -d '{"usernames" : ["user1"]}' 'http://XXXX/XXXX/XXXX/chatrooms/{XXXX}/white/users'
```

#### Response example

```
{
  "action": "post",
  "application": "5cf28979-XXXX-XXXX-b969-60141fb9c75d",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/white/users",
  "entities": [],
  "data": [
    {
      "result": true,
      "action": "add_user_whitelist",
      "user": "wzy_test",
      "chatroomid": "XXXX"
    },
    {
      "result": true,
      "action": "add_user_whitelist",
      "user": "wzy_meizu",
      "chatroomid": "XXXX"
    }
  ],
  "timestamp": 1594724634191,
  "duration": 2,
  "organization": "XXXX",
  "applicationName": "XXXX"
}
```

## Removing users from the chat room allow list

Removes the specified users from the chat room allow list. You can remove a maximum of 60 members from the chat room allow list each time.

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/white/users/{username}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).                                        

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the data field in the response body contains the following parameters.

| Parameter      | Type    | Description                                                         |
| :-------- | :------ | :----------------------------------------------------------- |
| `result`  | Boolean | Whether the users are successfully removed from the chat room allow list.<li>`true`: Yes.<li>`false`: No. |
| `user`    | String  | The username removed from the chat room allow list.                              |

For the parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer YWMt4LqJIul7EeizhBO5TSO_UgAAAAAAAAAAAAAAAAAAAAGL4CTw6XgR6LaXXVmNX4QCAgMAAAFnG7GyAQBPGgDv4ENRUku7fg05Kev0a_aVC8NyA6O6PgpxIRjajSVN3g' 'http://XXXX/XXXX/XXXX/chatrooms/{XXXX}/white/users/{username}'
```

#### Response example

```
{
  "action": "delete",
  "application": "5cf28979-XXXX-XXXX-b969-60141fb9c75d",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/white/users/wzy_huawei,wzy_meizu",
  "entities": [],
  "data": [
    {
      "result": true,
      "action": "remove_user_whitelist",
      "user": "wzy_huawei",
      "chatroomid": "XXXX"
    },
    {
      "result": true,
      "action": "remove_user_whitelist",
      "user": "wzy_meizu",
      "chatroomid": "XXXX"
    }
  ],
  "timestamp": 1594725137704,
  "duration": 1,
  "organization": "XXXX",
  "applicationName": "XXXX"
}
```

## Status codes

For details, see [HTTP Status Code](./agora_chat_status_code?platform=RESTful).