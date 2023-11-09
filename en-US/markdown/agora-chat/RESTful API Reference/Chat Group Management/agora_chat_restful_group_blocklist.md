A chat group block list refers to a list of users that can neither see nor receive group messages. Agora Chat provides a complete set of block list management methods, including adding and removing chat group members from the chat group block list, and retrieving the block list.

This page shows how to manage a chat group block list by calling the Agora Chat RESTful APIs. Before calling the following methods, ensure that you understand the call frequency limit described in [Limitations](./agora_chat_limitation?platform=RESTful#call-limit-of-server-side).


<a name="pubparam"></a>

## Common parameters

The following table lists common request and response parameters of the Agora Chat RESTful APIs:

### Request parameters

| Parameter | Type | Description | Required |
| :--------- | :----- | :----------------------------------------------------------- | :------- |
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. For how to get the org name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `username` | String | The unique login username. The username must be 64 characters or less and cannot be empty. The following character sets are supported:<li>26 lowercase English letters (a-z)</li><li>26 uppercase English letters (A-Z)</li><li>10 numbers (0-9)</li><li>"\_", "-", "."</li><div class="alert note"><ul><li>The username is case insensitive,  so `Aa` and `aa` are the same username. </li><li>Ensure that each username under the same app must be unique.</li></ul></div> | Yes |

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


## Retrieving the chat group block list

Retrieves the block list of the specified chat group. Users added to the block list can neither see nor receive messages in the chat group.

### HTTP request

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/blocks/users?pageSize={N}&cursor={cursor}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | The group ID. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| :------- | :----- | :-------- | :------- |
| `pageSize` | Number | The number of users on the block list to retrieve per page. | Yes |
| `cursor` | String | The position from which to start getting data. | Yes |

<div class="alert info">If you pass in neither `pageSize` nor `cursor`, the server returns the top 500 users in the descending order of time when they are added to the block list. If you pass in only  `pageSize`, but not `cursor`, the server returns a maximum of 50 users in the descending order of time when they are added to the block list.</div>


#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| Parameter | Type | Description | Required |
| `Content-Type` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the data field in the response body contains the following parameters:

| Parameter | Type | Description |
| :----- | :---- | :------------------ |
| `data` | Array | The user IDs in the chat group block list. |
| `count` | Number | The number of users in the chat group block list. |

For other fields and descriptions, see [Public parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'https://XXXX/XXXX/XXXX/chatgroups/66XXXX85/blocks/users?pageSize=2'
```

#### Response example

```json
{
    "uri": " https://XXXX/XXXX/XXXX/chatgroups/66XXXX85/users/blocks/users",
    "timestamp": 1682064422108,
    "entities": [],
    "cursor": "MTA5OTAwMzMwNDUzNTA2ODY1NA==",
    "count": 2,
    "action": "get",
    "data": [
        "tst05",
        "tst04"
    ],
    "duration": 52
}
```

## Adding a user to the chat group block list

Adds the specified user to the chat group block list. Once added to the chat group block list, users can neither send nor receive messages in the chat group.

You cannot add the chat group owner to the group block list.

### HTTP request

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/blocks/users/{username}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | The group ID. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The parameter type. Set it as `application/json`. | Yes |
| `Accept` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the data field in the response body contains the following parameters.

| Parameter | Type | Description |
| :------ | :------ | :------------------------------------------------ |
| `result` | Boolean | Whether the users are sucessfully added to the group block list.<ul><li>`true`: Yes.</li><li>`fale`: No.</li></ul> |
| `groupid` | String | The group ID. |
| `action` | String | The request method. |
| `user` | String | The usernames added to the group block list. |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/blocks/users/user1'
```

#### Response example

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585/blocks/users/user1",
    "entities": [],
    "data": {
      "result": true,
      "action": "add_blocks",
      "user": "user1"
      "groupid": "66016455491585"
    },
    "timestamp": 1542539577124,
    "duration": 27,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## Adding multiple users to the chat group block list

Adding multiple users to the group block list. Once added to the chat group block list, users can neither send nor receive messages in the chat group.

You can add a maximim of 60 users to the group block list each time. You cannot add the group owner to the group block list.


### HTTP request

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/blocks/users
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | The group ID. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The parameter type. Set it as `application/json`. | Yes |
| `Accept` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description | Required |
| :-------- | :---- | :------------------------------ | :------- |
| `usernames` | Array | The array of usernames to be added to the group block list. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the data field in the response body contains the following parameters.

| Parameter | Type | Description |
| :------ | :------ | :------------------------------------------------ |
| Parameter | Type | Description |
| `result` | Boolean | Whether the users are sucessfully added to the group block list.<ul><li>`true`: Yes.</li><li>`fale`: No.</li></ul> |
| `reason` | String | The reason why the users fail to be added to the group block list. |
| `groupid` | String | The group ID. |
| `action` | String | The request method. |
| `user` | String | The usernames added to the group block list. |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
    "usernames": [
      "user3","user4"
    ]
}' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/blocks/users'
```

#### Response example

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585/blocks/users",
    "entities": [],
    "data": [
      {
        "result": false,
        "action": "add_blocks",
        "reason": "user: user3 doesn't exist in group: 66016455491585",
        "user": "user3",
        "groupid": "66016455491585"
      },
      {
        "result": true,
        "action": "add_blocks",
        "user": "user4",
        "groupid": "66016455491585"
      }
    ],
    "timestamp": 1542540095540,
    "duration": 16,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## Removing a user from the chat group block list

Removes the specified user from the chat group block list. To add a user that is in the block list back to the chat group, you need to remove that user from the block list first.

### HTTP request

```shell
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/blocks/users/{username}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | The group ID. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the data field in the response body contains the following parameters.

| Parameter | Type | Description |
| :------ | :------ | :------------------------------------------------ |
| `result` | Boolean | Whether the user is successfully removed from the group block list. <li>true: Yes.</li><li>false: No.</li> |
| `groupid` | String | The group ID. |
| `action` | String | The request method. |
| `user` | String | The usernames removed from the group block list. |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/blocks/users/user1'
```

#### Response example

```json
{
    "action": "delete",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585/blocks/users/user1",
    "entities": [],
    "data": {
      "result": true,
      "action": "remove_blocks",
      "user": "user1"
      "groupid": "66016455491585"
    },
    "timestamp": 1542540470679,
    "duration": 45,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```


## Removing multiple users from the chat group block list

Removes the specified users from the group block list. To add users that are in the block list back to the chat group, you need to remove these users from the block list first. You can remove up to 60 users from the block list each time.

### HTTP request

```shell
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/blocks/users/{usernames}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :-------- | :----- | :---------------------------------------- | :------- |
| `group_id` | String | The group ID. | Yes |
| `usernames` | String | The usernames to be removed from the group block list, separated by the comma (,). | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following parameters.

| Parameter | Type | Description |
| :------ | :------ | :------------------------------------------------ |
| Parameter | Type | Description |
| `result` | Boolean | Whether the user is successfully removed from the group. <li>true: Yes.</li><li>false: No.</li> |
| `groupid` | String | The group ID. |
| `action` | String | The request method. |
| `user` | String | The usernames removed from the group block list. |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/blocks/users/user1%2Cuser2'
```

#### Response example

```json
{
    "action": "delete",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585/blocks/users/user1%2Cuser2",
    "entities": [],
    "data": [
      {
        "result": true,
        "action": "remove_blocks",
        "user": "user1"
        "groupid": "66016455491585"
      },
      {
        "result": true,
        "action": "remove_blocks",
        "user": "user2",
        "groupid": "66016455491585"
      }
    ],
    "timestamp": 1542541014655,
    "duration": 29,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

<a name="code"></a>

## Status codes

For details, see [HTTP Status Codes](./agora_chat_status_code?platform=RESTful).