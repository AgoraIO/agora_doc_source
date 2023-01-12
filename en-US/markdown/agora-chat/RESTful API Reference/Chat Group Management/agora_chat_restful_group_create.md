Upon login to the Agora Chat, you can create, modify, or delete a chat group.

This page shows how to create, retrieve, modify, and delete a group by calling Agora Chat RESTful APIs. Before calling the following methods, ensure that you understand the call frequency limit described in [Limitations](./agora_chat_limitation?platform=RESTful#call-limit-of-server-side).

<a name="param"></a>

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

## Creating a group

Creates a new chat group and sets the group information. The group information includes the chat group name,  description, whether the group is public or private, the maximum number of chat group members (including the group owner), whether a user requesting to join the group requires approval, the group owner, and group members.

### HTTP request

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups
```

#### Path parameter

For the descriptions of other path parameters, see [Common Parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The content type. Set it as `application/json`. | Yes |
| `Accept` | String | The content type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description | Required |
| :------------- | :------ | :----------------------------------------------------------- | :------- |
| `groupid` | String | The custom group ID. It cannot exceed 18 digits and cannot start with zero (0). This field is disabled by default. To enable this field, contact [support@agora.io](mailto:support@agora.io).  | No |
| `groupname` | String | The group name. It cannot exceed 128 characters. The group name cannot contain "/" or spaces. You can use "+" to represent the space. | Yes |
| `desc` | String | The group description. It cannot exceed 512 characters. The group name cannot contain "/" or spaces. You can use "+" to represent the space. | Yes |
| `public` | Boolean | Whether the group is a public group. Public groups can be searched and chat users can apply to join a public group. Private groups cannot be searched, and chat users can join a private group only if the group owner or admin invites the user to join the group.<ul><li>`true`: Yes</li><li>`false`: No</li></ul> | Yes |
| `maxusers` | String | The maximum number of chat group members (including the group owner). The default value is 200 and the maximum value is 2000.  The upper limit varies with your price plans. For details, see [Pricing Plan Details](./agora_chat_plan#group). | No |
| `allowinvites` | Boolean | Whether a regular group member is allowed to invite other users to join the chat group.<ul><li>`true`: Yes.</li><li>`false`: No. Only the group owner or admin can invite other users to join the chat group. </li></ul> | No |
| `membersonly` | Boolean | Whether the user requesting to join the public group requires approval from the group owner or admin:<ul><li>`true`: Yes.</li><li>`false`: (Default) No.</li></ul> | No |
| `owner` | String | The chat group owner. | Yes |
| `members` | Array | Regular chat group members. This chat group member array does not contain the group owner. If you want to set this field, you can enter one to 100 elements in this array. | No |
| `custom` | String | The extension information of the chat group. The extension information cannot exceed 1024 characters. | No |


### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the data field in the response body  contains the following parameters.

| Parameter | Type | Descriptions |
| :------ | :----- | :-------- |
| `groupid` | String | The group ID. |

For other fields and descriptions, see [Public parameter](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status code](#code) table for possible causes.

### Example

#### Request example

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
    "groupname": "testgroup",
    "desc": "test",
    "public": true
    "maxusers": 300,
    "owner": "testuser",
    "members": [
      "user2"
    ]
}' 'http://XXXX/XXXX/XXXX/chatgroups'
```

#### Response example

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups",
    "entities": [],
    "data": {
      "groupid": "6602XXXX783617"
    },
    "timestamp": 1542361730243,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```


## Banning a chat group

Bans the specified chat group when messages in the group violate community guidelines.

Once a chat group is banned, neither the chat group members in the group can send or receive messages, nor the owner and admins can perform supervisory operations.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/disable
```

#### Path parameter

For the descriptions of other path parameters, see [Common Parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The content type. Set it as `application/json`. | Yes |
| `Accept` | String | The content type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the `data` field in the response body contains the following parameters:

| Parameter | Type | Description |
|:------|:--------|:--|
| `disabled` | Bool | Whether the chat group is banned:<li>`true`: Yes.</li><li>`false`: No.</li> |

For other fields and descriptions, see [Public parameter](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status code](#code) table for possible causes.

### Example

#### Request example

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/XXXX/disable' 
```

#### Response example

```json
{
    "action": "post",
    "application": "XXXX",
    "applicationName": "XXXX",
    "data": {
        "disabled": true
    },
    "duration": 740,
    "entities": [],
    "organization": "XXXX",
    "properties": {},
    "timestamp": 1672974260359,
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/XXXX/disable"
}
```


## Unbanning a chat group

Lifts a ban on the specified chat group.

After unbanning a chat group, all chat group members resume their right to send and receive messages in the group, and the owner and admins resume their privileges to perform supervisory operations.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/enable
```

#### Path parameter

For the descriptions of other path parameters, see [Common Parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The content type. Set it as `application/json`. | Yes |
| `Accept` | String | The content type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response



If the returned HTTP status code is `200`, the request succeeds, and the `data` field in the response body contains the following parameters:

| Parameter | Type | Description |
|:------|:--------|:--|
| `disabled` | Bool | Whether the chat group is banned:<li>`true`: Yes.</li><li>`false`: No.</li> |

For other fields and descriptions, see [Public parameter](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status code](#code) table for possible causes.

### Example

#### Request example

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/XXXX/enable' 
```

#### Response example

```json
{
    "action": "post",
    "application": "XXXX",
    "applicationName": "XXXX",
    "data": {
        "disabled": false
    },
    "duration": 22,
    "entities": [],
    "organization": "XXXX",
    "properties": {},
    "timestamp": 1672974668171,
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/XXXX/enable"
}
```



## Retrieving group details

Retrieves the detailed information of one or more groups. If you specify multiple groups, details of the existing groups are returned. If the specified groups do not exist, "group id doesn't exist" is reported.

### HTTP request

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_ids}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :-------- | :----- | :----------------------------------------------------------- | :------- |
| `group_ids` | String | The ID of the group whose details you want to retrieve. You can type one or more group IDs that are separated with the comma (,). | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the data field in the response body contains the following parameters.

| Parameter | Type | Descriptions |
| :------------------- | :------ | :----------------------------------------------------------- |
| `id` | String | The group ID. The group's unique identifer. |
| `name` | String | The group name. |
| `description` | String | The group description. |
| `membersonly` | Boolean | Whether a user requesting to join the group requires the approval from the group owner or admin:<ul><li>`true`: Yes.</li><li>`false`: (Default) No.</li></ul> |
| `allowinvites` | Boolean | Whether a regular chat group member can invite other users to join the group.<ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> |
| `maxusers` | Number | The maximum number of members (including the group owner) allowed in the chat group. |
| `owner` | String | The username of the group owner, for example, `{"owner":"user1"}`. |
| `created` | Long | The Unix timestamp for creating the chat group. |
| `affiliations_count` | Number | The total number of the chat group members. |
| `disabled` | Bool | Whether the chat group is banned:<li>`true`: Yes.</li><li>`false`: No.</li> |
| `affiliations` | Array | The list of existing group members, including the group owner and regular group members, for example, `[{"owner":"user1"},{"member":"user2"},{"member":"user3"}]`. |
| `public` | Boolean | Whether the chat group is a public group.<ul><li>`true`: Yes.</li><li>`fale`: No.</li></ul> |
| `custom` | String | The extension information of the chat group. |

For other parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, it means the request fails. You can refer to [status code ](#code) for possible causes.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66016455491585'
```

#### Response example

```json
{
    "action": "get",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66016455491585",
    "entities": [],
    "data": [
      {
        "id": "66016455491585",
        "name": "testgroup1",
        "description": "testgroup1",
        "membersonly": false,
        "allowinvites": false,
        "maxusers": 200,
        "owner": "user1",
        "created": 1542356598609,
        "custom": "",
        "affiliations_count": 3,
        "disable":false,
        "affiliations": [
          {
            "member": "user3"
          },
          {
            "member": "user2"
          },
          {
            "owner": "user1"
          }
        ],
        "public": true
      }
    ],
    "timestamp": 1542360200677,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX",
}
```

## Modifying group information

Modifies the chat group information. You can only modify the `groupname`, `desc`, `maxusers`, `membersonly`, `allowinvites`, and `custom` fields. If you pass in fields that cannot be modified or do not exist in the request, an error is reported.

### HTTP request

```shell
PUT https://{host}/{org_name}/{app_name}/chatgroups/{group_id}
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
| :------------- | :------ | :----------------------------------------------------------- | :------- |
| `groupname` | String | The group name. It cannot exceed 128 characters. The group name cannot contain "/" or spaces. You can use "+" to represent the space. | Yes |
| `desc` | String | The group description. It cannot exceed 512 characters. The group name cannot contain "/" or spaces. You can use "+" to represent the space. | Yes |
| `maxusers` | String | The maximum number of chat group members (including the group owner). The default value is 200 and the maximum value is 2000.  The upper limit varies with your price plans. For details, see [Pricing Plan Details](./agora_chat_plan#group). | No |
| `allowinvites` | Boolean | Whether a regular chat group membercan invite other users to join the group.<ul><li>`true`: Yes.</li><li>`false`: No. Only the group owner or admin can invite other users to join the group. </li></ul> | No |
| `membersonly` | Boolean | Whether the user requesting to join the public group requires approval from the group owner or admin:<ul><li>`true`: Yes.</li><li>`false`: (Default) No.</li></ul> | No |
| `custom` | String | The extension information of the chat group. The extension information cannot exceed 1024 characters. | No |


### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the data field in the response body contains the following parameters.

| Parameter | Type | Descriptions |
| :------------------- | :------ | :----------------------------------------------------------- |
| `groupname` | String | The group name. |
| `description` | String | The group description. |
| `membersonly` | Boolean | Whether a user requesting to join the group requires the approval from the group owner or admin:<ul><li>`true`: Yes.</li><li>`false`: (Default) No.</li></ul> |
| `allowinvites` | Boolean | Whether a regular group member can invite other users to join the group.<ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> |
| `maxusers` | Number | The maximum number of chat group members (including the group owner. |

For other fields and descriptions, see [Common parameters](#pubparam).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status code ](#code) for possible causes.

### Example

#### Request example

```shell
curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{
    "groupname": "testgroup1",
    "description": "test",
    "maxusers": 300,
    "membersonly": true,
    "allowinvites": true
}' 'http://XXXX/XXXX/XXXX/chatgroups/66021836783617'
```

#### Response example

```json
{
    "action": "put",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66021836783617",
    "entities": [],
    "data": {
      "membersonly": true,
      "allowinvites": true,
      "description": true,
      "maxusers": true,
      "groupname": true
    },
    "timestamp": 1542363146301,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## Deleting a chat group

Deletes the specified chat group. Once a chat group is deleted, all the threads in this chat group are deleted as well.

### HTTP request

```shell
DELETE https://{host}//{org_name}/{app_name}/chatgroups/{group_id}
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

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following parameters.

| Parameter | Type | Description |
| :------ | :------ | :---------------------------------------------- |
| `success` | Boolean | The result of this method:<li>true: Success.</li><li>false: Failure.</li> |
| `groupid` | String | The group ID to be deleted. |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status code ](#code) for possible causes.

### Example

#### Request example

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66021836783617'
```

#### Response example

```json
{
    "action": "delete",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66021836783617",
    "entities": [],
    "data": {
      "success": true,
      "groupid": "66021836783617"
    },
    "timestamp": 1542363546590,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```


## Retrieving all chat groups

Retrieves all the chat groups under the app.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/chatgroups?limit={N}&cursor={cursor}
```

#### Path parameter

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type   | Description   | Required |
| :------- | :----- | :------------------------ | :------- |
| `limit`  | Number |  The number of chat groups to retrieve per page. The default value is `10`. The value range is [1,100].   | No  |
| `cursor` | String |  The start position for next query.  | No  |

<div class="alert info">If the <code>limit</code> and <code>cursor</code> parameters are not specified, the basic information of 10 chat groups on the first page are returned by default.<div>

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds， and the `data` field in the response body contains the following parameters.

| Parameter | Type | Description |
| :------------ | :----- | :---------------------------------------- |
| `owner` | String | The username of the group owner, for example, `{"owner":"user1"}`. |
| `groupid` | String | The group ID. |
| `affiliations` | Number | The number of existing group members. |
| `type` | String | The group type. |
| `last_modified` | String | When the group information was last modified, in milliseconds. |
| `groupname` | String | The group name. |
| `count` | Number | The number of groups that are returned. |
| `cursor` | String | The current page number. |

For other fields and descriptions, see [Public parameter](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status code ](#code) for possible causes.

### Example

#### Request example

```shell
// Gets the group information of the first page.
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups?limit=2'

// Gets the group information of the second page.
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups?limit=2&cursor=ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aW06Z3JvdXA6ZWFzZW1vYi1kZW1vI3Rlc3RhcHA6Mg'
```

#### Response example

```json
{
    "action": "get",
    "params": {
        "limit": [
            "2"
        ]
    },
    "uri": "https://XXXX/XXXX/XXXX/chatgroups",
    "entities": [],
    "data": [
        {
            "owner": "XXXX#XXXX_user1",
            "groupid": "100743775617286960",
            "affiliations": 2,
            "type": "group",
            "last_modified": "1441021038124",
            "groupname": "testgroup1"
        },
        {
            "owner": "XXXX#XXXX_user2",
            "groupid": "100973270123152176",
            "affiliations": 1,
            "type": "group",
            "last_modified": "1441074471486",
            "groupname": "testgroup2"
        }
    ],
    "timestamp": 1441094193812,
    "duration": 14,
    "cursor": "Y2hhdGdyb3VwczplYXNlbW9iLWRlbW8vY2hhdGRlbW91aV8z",
    "count": 2
}
```

## Retrieving all the chat groups a user joins

Retrieves all the chat groups that a user joins.

### HTTP request

```http
GET https://{host}/{app_name}/users/{username}/joined_chatgroups?pagesize={}&pagenum={}
```

#### Path parameter

For the descriptions of path parameters of this method, see [Common parameters](#param).

#### Query parameter

| Parameter | Type   | Description   | Required |
| :------- | :----- | :------------------------ | :------- |
| `pagesize`  | String |  The number of chat groups to retrieve per page. The default value is `10`. The value range is [1,100].   | No  |
| `pagenum` | String |  The start position for next query.  | No  |

<div class="alert info">If the <code>limit</code> and <code>cursor</code> parameters are not specified, the basic information of 10 chat groups on the first page are returned by default.<div>

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following parameters.

| Parameter | Type | Description |
| :-------- | :----- | :--------- |
| `groupid` | String | The group ID. |
| `groupname` | String | The group name. |

For other fields and descriptions, see [Public parameter](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [status code ](#code) for possible causes.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken> ' 'http://XXXX/XXXX/XXXX/users/user1/joined_chatgroups?pagesize=1&pagenum=100'
```

#### Response example

```json
{
    "action":"get",
    "application":"8bXXXX02",
    "applicationName":"testapp",
    "count":0,
    "data":[

    ],
    "duration":0,
    "entities":[

    ],
    "organization":"XXXX",
    "params":{
        "pagesize":[
            "1"
        ],
        "pagenum":[
            "100"
        ]
    },
    "properties":{

    },
    "timestamp":1645177932072,
    "uri":"http://XXXX/XXXX/XXXX/users/user1/joined_chatgroups"
}
```

<a name="code"></a>

## Status codes

For details, see [HTTP Status Codes](./agora_chat_status_code?platform=RESTful).