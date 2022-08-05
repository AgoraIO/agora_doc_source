A chat group allow list refers to a list of chat room members that can send group messages after the group owner or admins have muted all the group members using the [mute-all](./agora_chat_restful_group_mute?platform=RESTful#muting-all-chat-group-members) method. Agora Chat provides a complete set of allow list management methods, including adding users to the allow list and removing them from it, as well as retrieving the members on the allow list.

This page shows how to manage a chat group allow list using the Agora Chat RESTful APIs. Before calling the following methods, ensure that you understand the call frequency limit described in [Limitations](./agora_chat_limitation?platform=RESTful#call-limit-of-server-side).

<a name="param"></a>

## Common parameters

The following table lists the common request and response parameters of the Agora Chat RESTful APIs:

### Request parameters

| Parameter | Type | Description | Required |
| :--------- | :----- | :----------------------------------------------------------- | :------- |
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. For how to get the org name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `username` | String | The unique login user ID. The user ID must be 64 characters or less and cannot be empty. The following character sets are supported:<li>26 lowercase English letters (a-z)</li><li>26 uppercase English letters (A-Z)</li><li>10 numbers (0-9)</li><li>"\_", "-", "."</li><div class="alert note"><ul><li>The user ID is case insensitive, so `Aa` and `aa` are the same user ID. </li><li>Make sure that each user ID under the same app is unique.</li></ul></div> | Yes |

### Response parameters

| Parameter | Type | Description |
| :---------------- | :----- | :---------------------------------------------------------------- |
| `action` | String | The request method. |
| `organization` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. This is the same as `org_name`. |
| `application` | String | A unique internal identifier assigned to each app by the Agora Chat service. You can safely ignore this parameter. |
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

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log in to the chat system. The Agora Chat RESTful API only supports authenticating users using app tokens. For details, see [Authentication using App Token](generate_app_tokens?platform=RESTful).

## Retrieving the group allow list

This method retrieves the list of all the members on the chat group allow list. 

### HTTP request

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/white/users
```
#### Path parameter

| Parameter | Type | Description | Required |
| --- | --- | --- | --- |
| `group_id` | String | The chat group ID. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the user IDs on the group allow list. For other parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer {Your app token}' 'http://XXXX/XXXX/XXXX/chatgroups/{The group ID}/white/users'
```

#### Response example

```json
{
    "action": "get",
    "application": "5cf28979-XXXX-XXXX-b969-60141fb9c75d",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/1208XXXX5169153/white/users",
    "entities": [],
    "data": [
        "username1",
        "username1",
        "username3",
        "username4",
        "username5"
    ],
    "timestamp": 1594724947117,
    "duration": 3,
    "organization": "XXXX",
    "applicationName": "XXXX",
    "count": 5
}
```

## Adding a member to the group allow list

This method adds the specified user to the chat group allow list. Members in the group allow list can still send group messages after the group owner or admin has muted all the group members using the [mute-all]() method.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/white/users/{username}
```

#### Path parameter

| Parameter | Type | Description | Required |
| --- | --- | --- | --- |
| `group_id` | String | The chat group ID. | Yes |
| `username` | String | The user ID that you want to add to the group allow list. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following fields:

| Parameter | Type | Description |
| --- | --- | --- |
| `result` | Boolean | Whether the chat group member is successfully added to the group allow list. <ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> |
| `reason` | String | The reason for failing to add the member to the allow list. |
| `groupid` | String | The chat group ID. |
| `action` | String | The operation of the method call. |
| `user` | String | The user ID added to the allow list. |

For other parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```shell
curl -X POST -H 'Accept: application/json' -H 'Authorization: Bearer {Your app token}' 'http://XXXX/XXXX/XXXX/chatgroups/{The group ID}/white/users/{username}'
```

#### Response example

```json
    "action": "post",
    "application": "5cf28979-XXXX-XXXX-b969-60141fb9c75d",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/120824965169153/white/users/username1",
    "entities": [],
    "data": {
        "result": true,
        "action": "add_user_whitelist",
        "user": "username1",
        "groupid": "1208XXXX5169153"
    },
    "timestamp": 1594724293063,
    "duration": 4,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## Adding multiple members to the group allow list

This method adds multiple chat group members to the group allow list. You can add a maximum of 60 group members to the allow list per method call.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/white/users
```

| Parameter | Type | Description | Required |
| --- | --- | --- | --- |
| `group_id` | String | The chat group ID. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description |
| --- | --- | --- |
| `usernames` | Array | The user IDs that you want to add to the group allow list. |

### HTTP response

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following fields:

| Parameter | Type | Description |
| --- | --- | --- |
| `result` | Boolean | Whether the chat group member is successfully added to the group allow list. <ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> |
| `reason` | String | The reason for failing to add the member to the allow list. |
| `groupid` | String | The chat group ID. |
| `action` | String | The operation of the method call. |
| `user` | String | The user ID added to the allow list. |

For other parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer {Your app token}' -d '{"usernames" : ["user1"]}' 'http://XXXX/XXXX/XXXX/chatgroups/{The group ID}/white/users'
```

#### Response example

```json
{
    "action": "post",
    "application": "5cf28979-XXXX-XXXX-b969-60141fb9c75d",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/1208XXXX5169153/white/users",
    "entities": [],
    "data": [
        {
            "result": true,
            "action": "add_user_whitelist",
            "user": "username1",
            "groupid": "1208XXXX5169153"
        },
        {
            "result": true,
            "action": "add_user_whitelist",
            "user": "username2",
            "groupid": "1208XXXX5169153"
        }
    ],
    "timestamp": 1594724634191,
    "duration": 2,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## Removing members from the group allow list

This method removes the specified chat group member(s) from the group allow list. You can remove a maximum of 60 group members from the allow list per method call.

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/white/users/{username}
```

#### Path parameter

| Parameter | Type | Description | Required |
| --- | --- | --- | --- |
| `group_id` | String | The chat group ID. | Yes |
| `username` | String | The user ID(s) that you want to remove from the allow list. For multiple user IDs, use the English comma "," to separate each user ID.| Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or admin, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following fields:

| Parameter | Type | Description |
| --- | --- | --- |
| `result` | Boolean | Whether the chat group member is successfully removed from the group allow list. <ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> |
| `reason` | String | The reason for failing to remove the member from the allow list. |
| `groupid` | String | The chat group ID. |
| `action` | String | The operation of the method call. |
| `user` | String | The user ID removed from the allow list. |

For other parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status code](./agora_chat_status_code?platform=RESTful) for possible causes.

### Example

#### Request example

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer {Your app token}' 'http://XXXX/XXXX/XXXX/chatgroups/1208XXXX5169153/white/users/{username}'
```

#### Response example

```json
{
    "action": "delete",
    "application": "5cf28979-XXXX-XXXX-b969-60141fb9c75d",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/1208XXXX5169153/white/users/username1,username2",
    "entities": [],
    "data": [
        {
            "result": true,
            "action": "remove_user_whitelist",
            "user": "username1",
            "groupid": "1208XXXX5169153"
        },
        {
            "result": true,
            "action": "remove_user_whitelist",
            "user": "username2",
            "groupid": "1208XXXX5169153"
        }
    ],
    "timestamp": 1594725137704,
    "duration": 1,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```












