# Manage Chat Room Block List

A chat room block list refers to a list of users that can neither see nor receive chat room messages. Agora Chat provides a complete set of block list management methods, including adding users to the block list and removing them from it, as well as retrieving the members on the block list.

This page shows how to manage a chat room block list by calling the Agora Chat RESTful APIs. Before calling the following methods, ensure that you understand the call frequency limit described in [Limitations](./agora_chat_limitation?platform=RESTful).

## Common parameters <a name="param"></a>

The following table lists common request and response parameters of the Agora Chat RESTful APIs:

### Request parameters

| Parameter | Type | Description | Required |
| :--------- | :----- | :----------------------------------------------------- | :------- |
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service.  For how to get the org name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `username` | String | The username. The unique login account of the user. The username must be 64 characters or less and cannot be empty.  The following character sets are supported:<li>26 lowercase English letters (a-z)</li><li>26 uppercase English letters (A-Z)</li><li>10 numbers (0-9)</li><li>"\_", "-", "."</li><div class="alert note"><ul><li>The username is case insensitive, so `Aa` and `aa` are the same username. </li><li>Ensure that each username under the same app must be unique.</li></ul></div> | Yes |
| `chatroom_id` | String | The chat room ID. The unique identifier assigned to each chat room by the Agora Chat service. You can get the chat room ID from the response body of [Retrieve basic information of all chat rooms](./agora_chat_restful_chatroom?platform=RESTful#retrieving-basic-information-of-all-chat-rooms). | Yes |

### Response parameters

| Parameter | Type | Description |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action` | String | The request method. |
| `organization` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. This is the same as `org_name`. |
| `application` | String | A unique internal ID assigned to each app by the Agora Chat service. You can safely ignore this parameter. |
| `applicationName` | String | The unique identifier assigned to each app by the Agora Chat service. This is the same as `app_name`. |
| `uri` | String | The request URI. |
| `entities` | JSON | The response entity. |
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

## Retrieving the chat room block list

Retrieves the block list of the specified chat room.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter            | Type   | Required | Description                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | Yes     | `application/json`                                 |
| `Authorization` | String | Yes    | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the `data` field in the response body contains the usernames in the chat room block list.

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer YWMt7CoyjusbEeixOi3iod4eDAAAAAAAAAAAAAAAAAAAAAGL4CTw6XgR6LaXXVmNX4QCAgMAAAFnJlhJIwBPGgCqtjiyVnR209iyr8kNbhJhhanNQDdP9CMmpK2G-NIUOQ' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/blocks/users'
```

#### Response example

```
{
  "action": "get",
  "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/blocks/users",
  "entities": [],
  "data": [
    "user2",
    "user3"
  ],
  "timestamp": 1543466293681,
  "duration": 0,
  "organization": "XXXX",
  "applicationName": "XXXX",
  "count": 2
}
```

## Adding a user to the chat room block list

Adds the specified user to the chat room block list. Once added to the chat room block list, users receive a notification stating "You are kicked out of the chatroom {chatroom_id}" and can no longer join the chat room. They can neither send nor receive messages in the chat room.

You cannot add the chat room owner to the chat room block list.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users/{username}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter            | Type   | Required | Description                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | Yes     | `application/json`                                 |
| `Authorization` | String | Yes    | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the data field in the response body contains the following parameters.

| Parameter      | Type | Description                                                         |
| :-------- | :----- | :----------------------------------------------------------- |
| `result`  | Boolean | Whether the user is successfully added to the chat room block list. <li>`true`: Yes. <li>`false`: No. |
| `user`    | String | The username added to the chat room block list.                                   |

For the parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer YWMt7CoyjusbEeixOi3iod4eDAAAAAAAAAAAAAAAAAAAAAGL4CTw6XgR6LaXXVmNX4QCAgMAAAFnJlhJIwBPGgCqtjiyVnR209iyr8kNbhJhhanNQDdP9CMmpK2G-NIUOQ' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/blocks/users/user1'
```

#### Response example

```
{
  "action": "post",
  "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/blocks/users/user1",
  "entities": [],
  "data": {
    "result": true,
    "action": "add_blocks",
    "user": "user1",
    "chatroomid": "XXXX"
  },
  "timestamp": 1542539577124,
  "duration": 27,
  "organization": "XXXX",
  "applicationName": "XXXX"
}
```


## Adding multiple users to the chat room block list

Adds multiple users to the chat room block list. Once added to the chat room block list, users receive a notification stating "You are kicked out of the chatroom {chatroom_id}" and can no longer join the chat room. They can neither send nor receive messages in the chat room.

You can add a maximum of 60 users to the chat room block list at one time. You cannot add the chat room owner to the chat room block list.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).                                          |

#### Request header

| Parameter            | Type   | Required | Description                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | Yes     | `application/json`                                 |
| `Authorization` | String | Yes    | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. |

#### Request body

| Parameter        | Type  | Description              |
| :---------- | :---- | :---------------- |
| `usernames` | Array | The array of usernames to be added to the chat room block list. You can specify a maximum of 60 usernames, separated by commas (,). |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the data field in the response body contains the following parameters.

| Parameter      | Type    | Description                                                         |
| :-------- | :------ | :----------------------------------------------------------- |
| `result`  | Boolean | Whether the users are successfully added to the chat room block list.<li>`true`: Yes. <li>`false`: No. |
| `reason`  | String  | The reason why the users fail to be added to the chat room block list.                                       |
| `user`    | String  | The usernames added to the chat room block list.                                     |

For the parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer YWMt7CoyjusbEeixOi3iod4eDAAAAAAAAAAAAAAAAAAAAAGL4CTw6XgR6LaXXVmNX4QCAgMAAAFnJlhJIwBPGgCqtjiyVnR209iyr8kNbhJhhanNQDdP9CMmpK2G-NIUOQ' -d '{  
   "usernames": [  
     "user3","user4"  
   ]  
 }' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/blocks/users'
```

#### Response example

```
{
  "action": "post",
  "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/blocks/users",
  "entities": [],
  "data": [
    {
      "result": false,
      "action": "add_blocks",
      "reason": "user: user3 doesn't exist in chatroom: XXXX",
      "user": "user3",
      "chatroomid": "XXXX"
    },
    {
      "result": true,
      "action": "add_blocks",
      "user": "user4",
      "chatroomid": "XXXX"
    }
  ],
  "timestamp": 1542540095540,
  "duration": 16,
  "organization": "XXXX",
  "applicationName": "XXXX"
}
```

## Removing a user from the chat room block list

Removes the specified user from the chat room block list. To add a user that is in the block list back to the chat room, you need to remove that user from the block list first.

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users/{username}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter            | Type   | Required | Description                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | Yes     | `application/json`                                 |
| `Authorization` | String | Yes    | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the data field in the response body contains the following parameters.

| Parameter      | Type    | Description                                                         |
| :-------- | :------ | :----------------------------------------------------------- |
| `result`  | Boolean | Whether the user is successfully removed from the chat room block list.<li>`true`: Yes.<li>`false`: No. |
| `user`    | String  | The username removed from the chat room block list.                                     |

For the parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer YWMt7CoyjusbEeixOi3iod4eDAAAAAAAAAAAAAAAAAAAAAGL4CTw6XgR6LaXXVmNX4QCAgMAAAFnJlhJIwBPGgCqtjiyVnR209iyr8kNbhJhhanNQDdP9CMmpK2G-NIUOQ' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/blocks/users/user1'
```

#### Response example

```
{
  "action": "delete",
  "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/blocks/users/user1",
  "entities": [],
  "data": {
    "result": true,
    "action": "remove_blocks",
    "user": "user1",
    "chatroomid": "XXXX"
  },
  "timestamp": 1542540470679,
  "duration": 45,
  "organization": "XXXX",
  "applicationName": "XXXX"
}
```

## Removing multiple users from the chat room block list

Removes the specified users from the chat room block list. To add users that are in the block list back to the chat room, you need to remove these users from the block list first. You can remove a maximum of 60 users from the chat room block list at one time.

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/chatrooms/{chatroom_id}/blocks/users/{usernames}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter            | Type   | Required | Description                                                         |
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Content-Type`  | String | Yes     | `application/json`                                 |
| `Authorization` | String | Yes    | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. |

#### Request body

If the returned HTTP status code is `200`, the request succeeds, and the data field in the response body contains the following parameters.

| Parameter       | Type   | Required | Description                                                         |
| :--------- | :----- | :------- | :----------------------------------------------------------- |
| `username` | String | Yes     | The usernames to be removed from the chat room block list. You can specify a maximum of 60 usernames, separated by commas (,).                                        |


### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the data field in the response body contains the following parameters.

| Parameter      | Type    | Description                                                         |
| :-------- | :------ | :----------------------------------------------------------- |
| `result`  | Boolean | Whether the users are successfully removed from the chat room block list.<li>`true`: Yes.<li>`false`: No. |
| `user`    | String  | The usernames removed from the chat room block list.                            |

For the parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer YWMt7CoyjusbEeixOi3iod4eDAAAAAAAAAAAAAAAAAAAAAGL4CTw6XgR6LaXXVmNX4QCAgMAAAFnJlhJIwBPGgCqtjiyVnR209iyr8kNbhJhhanNQDdP9CMmpK2G-NIUOQ' 'http://XXXX/XXXX/XXXX/chatrooms/XXXX/blocks/users/user1%2Cuser2'
```

#### Response example

```
{
  "action": "delete",
  "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
  "uri": "http://XXXX/XXXX/XXXX/chatrooms/XXXX/blocks/users/user1%2Cuser2",
  "entities": [],
  "data": [
    {
      "result": true,
      "action": "remove_blocks",
      "user": "user1",
      "chatroomid": "XXXX" 
    },
    {
      "result": true,
      "action": "remove_blocks",
      "user": "user2",
      "chatroomid": "XXXX"
    }
  ],
  "timestamp": 1542541014655,
  "duration": 29,
  "organization": "XXXX",
  "applicationName": "XXXX"
}
```

## Status codes

For details, see [HTTP Status Code](./agora_chat_status_code?platform=RESTful).