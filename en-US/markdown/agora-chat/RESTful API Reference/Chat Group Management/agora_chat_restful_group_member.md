Group member management involves operations such as member creation and deletion.  Agora Chat provides multiple APIs for adding and retrieving group members, adding a group administrator, and transferring the group owner.

This page shows how to manage group members by calling the Agora Chat RESTful APIs. Before calling the following methods, ensure that you understand the call frequency limit described in [Limitations](./agora_chat_limitation?platform=RESTful#call-limit-of-server-side).

<a name="pubparam"></a>

## Common parameters

The following table lists common request and response parameters of the Agora Chat RESTful APIs:

### Request parameters

| Parameter | Type | Description | Required |
| :--------- | :----- | :----------------------------------------------------------- | :------- |
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

## Retrieving group members

Retrieves the member list of the specified chat group with pagination.

### HTTP request

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/users?pagenum={N}&pagesize={N}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------- | :----- | :------------------------------------------------ | :------- |
| `group_id` | String | The group ID. | Yes |


#### Query parameter

| Parameter | Type | Description | Required |
| :------- | :----- | :------------------------------------------------ | :------- |
| `pagenum` | Number | The current page number. The query starts from the first page by default. | No |
| `pagesize` | Number | The number of members to retrieve per page. The value range is [1,1000] and the default value is `1000`.  | No |

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
| :----- | :----- | :--------------------------------------- |
| `owner` | String | The username of the group owner, for example, `{"owner":"user1"}`. |
| `member` | String | The username of a group admin or regular group member, for example, `{"member":"user2"}`. |
| `count` | String | The number of group members retrieved at this call of this API. |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' 'http://XXXX/XXXX/XXXX/chatgroups/10130212061185/users?pagenum=2&pagesize=2' -H 'Authorization: Bearer <YourAppToken>'
```

#### Response example

```json
{
    "action": "get",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "params": {
        "pagesize": [
          "2"
        ],
        "pagenum": [
          "2"
        ]
    },
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/users",
    "entities": [],
    "data": [
    {
            "owner": "user1"
    },
    {
            "member": "user2"
    }
    ],
    "timestamp": 1489074511416,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX",
    "count": 2
}
```

## Adding a user to the chat group

Adds the specified user to the chat group.  If the user is already a member of the chat group, an error is returned.

### HTTP request

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/users/{username}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | The group ID. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request parameters

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The parameter type. Set it as `application/json`. | Yes |
| `Accept` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following parameters.

| Parameter | Type | Description |
| :------ | :------ | :------------------------------------------------ |
| `result` | Boolean | Whether the user is successfully added to the chat group. <li>true: Yes.</li><li>false: No.</li> |
| `groupid` | String | The group ID. |
| `action` | String | The request method. |
| `user` | String | The username added to the chat group. |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/users/user4'
```

#### Response example

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585/users/user4",
    "entities": [],
    "data": {
      "result": true,
      "groupid": "66016455491585",
      "action": "add_member",
      "user": "user4"
    },
    "timestamp": 1542364958405,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## Adding multiple users to the chat group

Adds multiple users to the specified chat group. You can add a maximum of 60 users into a chat group at one time. If the users are already members of the chat group, an error is returned in the response body.

### HTTP request

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{chatgroupid}/users
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
| :-------- | :---- | :------------------------ | :------- |
| `usernames` | Array | The usernames added to the chat group. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following parameters.

| Parameter | Type | Description |
| :--------- | :----- | :---------------------- |
| `newmembers` | Array | The array of usernames that are added to the group. |
| `groupid` | String | The group ID. |
| `action` | String | The request method. |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
    "usernames": [
      "user4","user5"
    ]
}' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/users'
```

#### Response example

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585/users",
    "entities": [],
    "data": {
      "newmembers": [
        "user5",
        "user4"
      ],
      "groupid": "66016455491585",
      "action": "add_member"
    },
    "timestamp": 1542365557942,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```


## Removing a chat group member

Removes the specified user from the chat group. If the specified user is not in the chat group, an error is returned.

Once a member is removed from a chat group, they are also removed from all the threads they have joined in this chat group.

### HTTP request

```shell
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/users/{username}
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

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following parameters.

| Parameter | Type | Description |
| :------ | :------ | :------------------------------------------------ |
| `result` | Boolean | Whether the user is successfully removed from the chat group. <li>true: Yes.</li><li>false: No.</li> |
| `groupid` | String | The group ID. |
| `action` | String | The request method. |
| `user` | String | The usernames removed from the chat group. |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/users/user3'
```

#### Response example

```json
{
    "action": "delete",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585/users/user3",
    "entities": [],
    "data": {
      "result": true,
      "action": "remove_member",
      "user": "user3",
      "groupid": "66016455491585"
    },
    "timestamp": 1542365943067,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## Removing multiple group members

Removes multiple users from the chat group. You can remove a maximum of 60 members from the chat group at one time. If the specified users are not in the group, an error is returned.

Once a member is removed from a chat group, they are also removed from all the threads they have joined in this chat group.

### HTTP request

```
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/users/{memebers}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------- | :----- | :----------------------------------------------------------- | :------- |
| `group_id` | String | The group ID. | Yes |
| `members` | String | The usernames of group members, separated by the comma (,). For example, `user1, user2`. Agora recommends that you remove a maximum of 60 members at each request, and ensure that length of the request URL does not exceed 4 KB. | Yes |

For the descriptions of other path parameters, see [Common Parameters](#param).

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
| `result` | Boolean | Whether the user is successfully removed from the chat group. <li>true: Yes.</li><li>false: No.</li> |
| `groupid` | String | The group ID. |
| `reason` | String | The reason why the users fail to be removed from the chat group. |
| `action` | String | The request method. |
| `user` | String | The usernames removed from the chat group. |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585/users/ttestuser0015981,user2,user3'
```

#### Response example

```json
{
    "action": "delete",
    "application": "9b848cf0-XXXX-XXXX-b5b8-0f74e8e740f7",
    "uri": "https://XXXX/XXXX/XXXX",
    "entities": [],
    "data": [{
        "result": false,
        "action": "remove_member",
        "reason": "user ttestuser0015981 doesn't exist.",
        "user": "user1",
        "groupid": "1433492852257879"
    },
    {
        "result": true,
        "action": "remove_member",
        "user": "user2",
        "groupid": "1433492852257879"
    },
    {
        "result": true,
        "action": "remove_member",
        "user": "user3",
        "groupid": "1433492852257879"
    }],
    "timestamp": 1433492935318,
    "duration": 84,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```


## Retrieving group admin list

Retrieves the list of the chat group admins.

### HTTP request

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/admin
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
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds， and the `data` field in the response body contain the information of the chat group admins. For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X GET HTTP://XXXX/XXXX/XXXX/chatgroups/10130212061185/admin -H 'Authorization: Bearer <YourAppToken>'
```

#### Response example

```json
{
    "action": "get",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/admin",
    "entities": [],
    "data": ["user1"],
    "timestamp": 1489073361210,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX",
    "count": 1
}
```

## Adding a group admin

Adds a regular group member to the group admin list. A chat group admin has the privilege to manage the chat group block list and mute chat group members. You can add a maximum of 99 chat group admins.

### HTTP request

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/admin
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
| :------- | :----- | :---------------------------- | :------- |
| `newadmin` | String | The username be added as the chat group admin. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following parameters.

| Parameter | Type | Description |
| :------ | :------ | :------------------------------------------------ |
| `data` | String | The user IDs promoted to group admins. |
| `count` | Number   | The number of users to be promoted as group admins. |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X POST -H 'Content-type: application/json' -H 'Accept: application/json' 'http://XXXX/XXXX/XXXX/chatgroups/10130212061185/admin' -d '{"newadmin":"user1"}' -H 'Authorization: Bearer <YourAppToken>'
```

#### Response example

```json
{
    "action": "post",
    "application": "52XXXXf0",
    "applicationName": "demo",
    "data": {
        "result": "success",
        "newadmin": "man"
    },
    "duration": 0,
    "entities": [],
    "organization": "XXXX",
    "properties": {},
    "timestamp": 1680074570600,
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/190141728620545/admin"
}
```


## Removing a group admin

Removes the specified user from the chat group admin list.

### HTTP request

```shell
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/admin
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

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following parameters.

| Parameter | Type | Description |
| :------- | :------ | :---------------------------------------------- |
| `result` | Boolean | Whether the group admin is successfully demoted to a regular group member:<ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> |
| `oldadmin` | String | The ID of the group admin demoted to a regular group member. |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X DELETE -H 'Accept: application/json' 'http://XXXX/XXXX/XXXX/chatgroups/10130212061185/admin/user1' -H 'Authorization: Bearer <YourAppToken>'
```

#### Response example

```json
{
    "action": "delete",
    "application": "527cd7e0-XXXX-XXXX-9f59-ef10ecd81ff0",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/10130212061185/admin/user1",
    "entities": [],
    "data": {
        "result": "success",
        "oldadmin": "user1"
    },
    "timestamp": 1489073432732,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## Transferring group ownership

Changes the group owner to another group member. Group owners possess all group privileges.

### HTTP request

```shell
PUT https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/admin
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
| :------- | :----- | :------------------ | :------- |
| `newowner` | String | The username of the new group owner. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds and the `data` field in the response body will contain the following parameters.

| Parameter | Type | Description |
| :------- | :------ | :---------------------------------------------- |
| `newowner` | Boolean | Whether the user is successfully set as the chat group owner. true: Yes; false: No. |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{     "newowner": "user2"   }' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585'
```

#### Response example

```json
{
    "action": "put",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585",
    "entities": [],
    "data": {
      "newowner": true
    },
    "timestamp": 1542537813420,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

<a name="code"></a>

## Status codes

For details, see [HTTP Status Codes](./agora_chat_status_code?platform=RESTful).