# Channels

Circle is an online chat and community solution built on the Chat SDKs. It enables users to connect with communities of mutual interest and communicate with thousands of other users worldwide in real time.

Circle provides a three-layer structure, as follows:

- **Server**: Each server represents one of the communities within Circle. Users can search for and join servers by subject/interest. They can also create and manage their own servers.
- **Channel**: A server is organized into topic-based channels, where users can connect with other interested users to talk over specific topics. A default channel is automatically created during server creation.
- **Thread**: Threads serve as temporary sub-channels inside an existing channel, to help better organize conversations in a busy channel.

Once a server is created, a default channel containing all server members is automatically created to receive system notifications. The server owner can then create public or private channels, as desired. Note that users can join and leave a server freely; they do not require approval from anyone.

This page shows how to implement channels in Circle using RESTful APIs. Before proceeding, ensure that you understand the frequency limit of Chat RESTful API calls described in [Limitations](https://docs.agora.io/en/agora-chat/reference/limitations#call-limit-of-server-sides).


## <a name="param"></a>Common parameters

### Request parameters

| Parameter | Type | Description | Required |
| :--------- | :----- | :------ | :------- |
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service.  For how to get the org name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `server_id`  | String | The server ID.         | Yes   |
| `channel_id`    | String | The channel ID.   | Yes |
| `user_id`    | String | The user ID.   | Yes |


### Response parameters

| Parameter | Type | Description |
| :---------------- | :----- | :--------------- |
| `name`              | String |  The channel name.     |
| `type`            | Number     |  The channel type:<li>`0`: Public.</li><li>`1`: Private.</li>      				|
| `invite_mode`     | Number   |  Whether the channel invitation is automatically accepted:<li>`0`</li>: Yes.</li><li>`1`: No. After being invited, the invitee manually accepts or declines the invitation.</li> |
| `rank`        | Number | The maximum number of users in the channel:<li>(Default) `0`: 2,000; </li><li>`1`: 20,000</li><li>`2`: 100,000.    |
| `description`     | String      |  The channel description. |
| `custom`       | String     |  The channel extension.   |
| `default_channel` | Number |  Whether the channel serves as the default one in the server:<li>`0`: No.</li><li>`1`: Yes.</li>  |
| `created`      | Number    |  The Unix timestamp (ms) when the channel was created.        |
| `server_id`     | String    |  The ID of the server to which the channel belongs.     |
| `channel_id`     | String    |  The channel ID.    |


## Authorization

Agora Chat RESTful APIs require Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authorization` field must be filled in the request header:

```http
Authorization: Bearer ${YourAppToken}
```

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log in to the chat system. The Agora Chat RESTful API only supports authenticating users using app tokens. For details, see [Authentication using App Token](./generate_app_tokens?platform=RESTful).


## Create a channel

Creates a channel.

Note that one server can have a maximum of 100 channels.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/circle/channel
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Content-Type` | String | `application/json` | Yes  |
| `Accept` | String | `application/json` | Yes  |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `server_id`   | String | The server ID.  | Yes       | 
| `name`        | String | The channel name. The length cannot exceed 50 characters.      | Yes   | 
| `type`        | Number | The channel type:<li>`0`: Public.</li><li>`1`: Private.</li>       | Yes   | 
| `rank`        | Number | The maximum number of users in the channel:<li>(Default) `0`: 2,000; </li><li>`1`: 20,000</li><li>`2`: 100,000.    | No    | 
| `invite_mode` | Number | Whether the channel invitation is automatically accepted:<li>`0`</li>: Yes.</li><li>`1`: No. After being invited, the invitee manually accepts or declines the invitation.</li> | No | 
| `description` | String | The channel description. The length cannot exceed 500 characters.  | No       | 
| `custom`  | String | The channel extension. The length cannot exceed 500 characters. | No       | 

### HTTP response
#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code. |
| `channel_id` | String | The channel ID. |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.
### Example
#### Request example

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel'
-d '{
	"server_id" : "19VM9oPBasxxxxxx0tvWViEsdM",
	"name" : "chat",
	"type" : 0,
  "rank"：0,
	"invite_mode" : 0,
	"description" : "chat Channel",
	"custom" : "custom"
}'
```

#### Response example

```json
{
    "code": 200,
    "channel_id": "198900125668"
}
```


## Modify a channel

Modifies the detailed information of the specified channel.

### HTTP request

```http
PUT https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}?serverId={server_id}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `server_id` | String | The ID of the server to which the channel belongs. | Yes  |

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Content-Type` | String | `application/json` | Yes  |
| `Accept` | String | `application/json` | Yes  |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `name`        | String | The channel name. The length cannot exceed 50 characters.      | No   | 
| `rank`        | Number | The maximum number of users in the channel:<li>(Default) `0`: 2,000; </li><li>`1`: 20,000</li><li>`2`: 100,000.    | No    | 
| `description` | String | The channel description. The length cannot exceed 500 characters.  | No   | 
| `custom`  | String | The channel extension. The length cannot exceed 500 characters. | No       | 

### HTTP response
#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code. |
| `channel` | JSON | The detailed information of the channel. |

For other parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example
#### Request example

```shell
curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX' -d '{
 "name" : "chat",
 "rank" : 1,
 "description" : "chat Channel",
 "custom" : "custom"
}'
```

#### Response example

```json
{
    "code": 200,
    "channel": {
        "name": "chat",
        "type": 1,
        "description": "chat Channel11",
        "custom": "custom",
        "created": 1658201254843,
        "server_id": "19UyPIsiwxxxxxxxgLrfI9Z",
        "channel_id": "198900125668",
        "rank" : 1,
        "invite_mode": 0,
        "default_Channel": 1
    }
}
```

## Retrieve a channel

Retrieves the specified channel.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}?serverId={server_id}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `server_id` | String | The ID of the server to which the channel belongs. | Yes  |

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept` | String | `application/json` | Yes  |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code. |
| `channel` | JSON | The detailed information of the channel. |

For other parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel?serverId=XXX'
```

#### Response example

```json
{
    "code": 200,
    "channel": {
        "name": "chat",
        "type": 1,
        "description": "chat Channel11",
        "custom": "custom",
        "created": 1658201254843,
        "server_id": "19UyPIsiwxxxxxxxgLrfI9Z",
        "channel_id": "198900125668",
        "invite_mode": 0,
        "rank" : 0,
        "default_channel": 1
    }
}
```

## Retrieve all public channels within one server

Retrieves the detailed information of all public channels within the specified server (by page).

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/public?serverId={server_id}&limit={limit}&cursor={cursor} 
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `server_id` | String | The ID of the server to which the channel belongs. | Yes  |
| `limit` | Number    |   The number of channels to query per page. The value range is [1,20]. The default value is 20. This parameter is only required when retrieving by page.  |  No  |
| `cursor` | String  | The start position of the next query. This parameter is only required when retrieving by page.    |  No  |

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | Yes | `application/json` |
| `Authorization` | String | Yes | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:\

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code. |
| `count`    | Number   | The number of retrieved channels.   |
| `channels` | List | The list of the retrieved channels and the detailed information. |
| `cursor`  | String  | The start position of the next query. |

For other parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/public?serverId=XXX&limit=1&cursor=XXX'
```

#### Response example

```json
{
    "code": 200,
    "count": 1,
    "channels": [
        {
            "name": "chat",
        		"type": 0,
            "rank" : 0,
        		"description": "chat Channel11",
        		"custom": "custom",
        		"created": 1658201254843,
        		"server_id": "19UyPIsiwxxxxxxxgLrfI9Z",
        		"channel_id": "198900125668",
        		"invite_mode": 0,
        		"default_Channel": 1
        }
    ],
    "cursor": "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aXXXXXXXXXXXXXX"
}
```

## Retrieve the joined channels

Retrieves the detailed information of the channels where the specified user that has joined (by page).

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/user/joined/list?userId={user_id}&serverId={server_id}&limit={limit}&cursor={cursor} 
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `user_Id` | String | The user ID. | Yes  |
| `server_id` | String | The ID of the server to which the channel belongs. | Yes  |
| `limit` | Number    |   The number of channels to query per page. The value range is [1,20]. The default value is 20. This parameter is only required when retrieving by page.  |  No  |
| `cursor` | String  | The start position of the next query. This parameter is only required when retrieving by page.    |  No  |


#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | Yes | `application/json` |
| `Authorization` | String | Yes | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code. |
| `count`    | Number   | The number of retrieved channels.   |
| `channels` | List | The list of the retrieved channels and the detailed information. |
| `cursor`  | String  | The start position of the next query. |

For other parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/user/joined/list?userId=XXX&serverId=XXX&limit=1&cursor=XXX'
```

#### Response example

```json
{
    "code": 200,
    "count": 1,
    "channels": [
        {
          "name": "chat",
          "type": 1,
          "description": "chat Channel11",
          "custom": "custom",
          "created": 1658201254843,
          "server_id": "19UyPIsiwxxxxxxxgLrfI9Z",
          "channel_id": "198900125668",
          "rank": 1,
          "invite_mode": 0,
          "default_Channel": 1
        }
    ],
    "cursor": "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aXXXXXXXXXXXXXX"
}
```


## Retrieve all private channels visible to the current user

Retrieves the detailed information of all private channels that are visible to the current user (by page).

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/private?serverId={server_id}&limit={limit}&cursor={cursor} 
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `server_id` | String | The ID of the server to which the channel belongs. | Yes  |
| `limit` | Number    |   The number of channels to query per page. The value range is [1,20]. The default value is 20. This parameter is only required when retrieving by page.  |  No  |
| `cursor` | String  | The start position of the next query. This parameter is only required when retrieving by page.    |  No  |


For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | `application/json`      | Yes       | 
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code. |
| `count`    | Number   | The number of retrieved channels.   |
| `channels` | List | The list of the retrieved channels and the detailed information. |
| `cursor`  | String  | The start position of the next query. |

For other parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/private?serverId=XXX&limit=1&cursor=XXX'
```

#### Response example

```json
{
    "code": 200,
    "count": 1,
    "channels": [
        {
            "name": "chat",
        		"type": 1,
            "rank": 0,
        		"description": "chat Channel11",
        		"custom": "custom",
        		"created": 1658201254843,
        		"server_id": "19UyPIsiwxxxxxxxgLrfI9Z",
        		"channel_id": "198900125668",
        		"invite_mode": 0,
        		"default_Channel": 1
        }
    ],
    "cursor": "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aXXXXXXXXXXXXXX"
}
```


## Destroy a channel

Destroys the specified channel.

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}?serverId={server_id}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `server_id` | String | The ID of the server to which the channel belongs. | Yes  |

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | `application/json`      | Yes       | 
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code. |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX?serverId=XXX'
```

#### Response example

```json
{
    "code": 200
}
```


## Send a message

Sending a message to a channel via RESTful API is basically the same as sending a message to a chat group. The only difference lies in the setting of `to`. For sending a channel message, you need to set the `to` parameter to the targeted channel ID.

For details, see [Send a group message](https://docs.agora.io/en/agora-chat/restful-api/message-management#send-a-group-message).


## Add a reaction

Adds a reaction to the specified message.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/circle/reaction
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Content-Type` | String | `application/json` | Yes  |
| `Accept` | String | `application/json` | Yes  |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `user_id`    | String | The user ID.    | Yes       |
| `message_id` | String | The ID of the message to which you want to add the reaction.   | Yes       |
| `message` | String | The name of the reaction. The length cannot exceed 128 characters. | Yes       |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`        | Number    | The HTTP status code. |
| `reaction_id` | String | The ID of the reaction.     |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/reaction'
-d '{
  "user_id" : "user1",
  "message_id" : "131345390",
  "message" : "message"
}'
```

#### Response example

```json
{
  "code" : 200,
  "reaction_id" : "15890012560"
}
```

## Retrieve reactions from a message

Retrieves the detailed information of the reactions from the specified message.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/circle/reaction/user/{user_id}?msgIdList={message_id}&channelId={channel_id}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `message_id` | String | The ID of the message to which the reactions belong. | Yes  |
| `channel_id` | String | The ID of the channel to which the message belongs. | Yes  |

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | `application/json`  | Yes       |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`  | Number    | The HTTP status code. |
| `count` | Number  | The number of reactions. |
| `msgId` | String  | The ID of the message to which the reactions belong.  |
| `reactionList` | List  | The list of the reactions and detailed information.  |
| `reactionList.reactionId` | String  | The reaction ID.  |
| `reactionList.message` | String  | The reaction name.  |
| `reactionList.state` | Bool  | Whether the current user sending this request has added a reaction to this message:<li>`true`: Yes.</li><li>`false`: No.</li> |
| `reactionList.count` | Number  | The number of users that have added this reaction to the message.  |
| `reactionList.userList` | Number  | The list of user IDs that have added this reaction.  |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/reaction/user/XXX?msgIdList=XXX&channelId=XXX'
```

#### Response example

```json
{
    "code":200,
    "count" : 1,
    "reactions":[
        {
            "msgId":"message id",
            "reactionList":[
                {
                    "reactionId":"Reaction id",
                    "message":"Reaction name",
                    "state":"Whether the current user adds the reaction.",
                    "count":2,
                    "userList":[
                        "user1",
                        "user2"
                    ]
                }
            ]
        }
    ]
}
```

## Remove a reaction

Removes a reaction from the specified message.

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/circle/reaction/user/{user_id}?messageId={message_id}&message={message}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `message_id` | String | The ID of the message to which the reactions belong. | Yes  |
| `message` | String | The name of the reaction to remove. | Yes  |

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | `application/json`  | Yes       |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`  | Number    | The HTTP status code. |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/reaction/user/XXX?messageId=XXX&message=XXX'
```

#### Response example

```json
{
  "code" : 200
}
```

## Add a user to a channel

Adds a user to the specified channel.

Each user can join a maximum of 10,000 channels.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}/join?userId={user_id}&serverId={server_id}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `user_id` | String | The user ID. | Yes  |
| `server_id` | String | The server ID. | Yes  |

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | `application/json`  | Yes       |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code. |
| `channel` | JSON | The detailed information of the channel. |

For other parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X POST -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX/join?userId=XXX&serverId=XXX'
```

#### Response example

```json
{
    "code": 200,
    "channel": {
        "name": "chat",
        "type": 1,
        "description": "chat Channel11",
        "custom": "custom",
        "created": 1658201254843, 
        "server_id": "19UyPIsiwxxxxxxxgLrfI9Z",
        "rank": 0,
        "channel_id": "198900125668",
        "invite_mode": 0,
        "default_Channel": 1
    }
}
```


## Remove a user from a channel

Removes a user from the specified channel.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}/user/remove?userId={user_id}&serverId={server_id}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `user_id` | String | The user ID. | Yes  |
| `server_id` | String | The server ID. | Yes  |

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | `application/json`   | Yes       |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code. |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X POST -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX/user/remove?userId=XXX&serverId=XXX'
```

#### Response example

```json
{
    "code": 200
}
```


## Check whether a user exists in a channel

Checks whether a user exists in the specified channel.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}/user/{user_id}?serverId={server_id}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | `application/json`   | Yes       |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code.   |
| `result` | Boolean | Whether the user exists in the channel: <li>`true`: Yes.</li><li>`false`: No.</li> |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX/user/XXX?serverId=XXX'
```

#### Response example

```json
{
    "code": 200,
    "result": true
}
```

## Retrieve the member list of a channel

Retrieves the member list of the specified channel (by page).

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}/users?serverId={server_id}&limit={limit}&cursor={cursor} 
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `server_id` | String | The ID of the server to which the channel belongs. | Yes  |
| `limit` | Number    |   The number of members to query per page. The value range is [1,20]. The default value is 20. This parameter is only required when retrieving by page.  |  No  |
| `cursor` | String  | The start position of the next query. This parameter is only required when retrieving by page.  |  No  |

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | `application/json`   | Yes       |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code.   |
| `count`   | Number     | The number of retrieved members.  |
| `users` | List | The list of users and detailed information. |
| `users.user_id` | String | The ID of the user. |
| `users.role` | Number | The role of the user in the channel:<li>`0`</li>: Owner.<li>`1`</li>: Member. |

For other parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX/users?serverId=XXX&limit=1&cursor=XXX'
```

#### Response example

```json
{
    "code": 200,
    "count": 1,
    "users": [
        {
            "user_id" : "user1",
            "role" : 0
        }
    ],
    "cursor": "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aXXXXXXXXXXXXXX"
}
```


## Retrieve the mute list of a channel

Retrieves the mute list of the specified channel.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}/user/mute/list?serverId={server_id}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `server_id` | String | The ID of the server to which the channel belongs. | Yes  |

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | `application/json`   | Yes       |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code.   |
| `mute_users`   | List    | The list of muted users and their detailed information. |
| `mute_users.expire` | Number   | The Unix time stamp (ms) when the mute duration expires.    |
| `mute_users.user`   | String | The ID of the muted user.  |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/Channel/XXX/user/mute/list?serverId=XXX'
```

#### Response example

```json
{
  "code" : 200
  "mute_users" : [
    {
      "expire" : 86400000,
      "user" : "u1"
    },
    {
      "expire" : 86400000,
      "user" : "u2"
    }
  ]
}
```

## Add a user to the channel mute list

Adds a user to the mute list of the specified channel.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}/user/mute
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Content-Type` | String | `application/json` | Yes  |
| `Accept` | String | `application/json` | Yes  |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `server_id`    | String | The ID of the server to which the channel belongs. | Yes       |
| `user_id`    | String | The ID of the user to be muted. | Yes       |
| `duration`    | Number | The mute duration (ms). | Yes       |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code.   |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX/user/mute' -d '{
  "server_id" : "19UyPIsiwxxxxxxxgLrfI9Z",
  "user_id" : "u1",
  "duration" : 86400
}'
```

#### Response example

```json
{
    "code": 200
}
```

## Remove a user from the channel mute list

Removes a user from the mute list of the specified channel.

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/circle/channel/{channel_id}/user/mute?serverId={server_id}&userId={user_id}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `server_id` | String | The ID of the server to which the channel belongs. | Yes  |
| `user_id` | String | The ID of the user to be unmuted. | Yes  |

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | `application/json`  | Yes       | 
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code.   |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/channel/XXX/user/mute?serverId=XXX&userId=XXX'
```

#### Response example

```json
{
    "code": 200
}
```




## Create a thread

Creates a thread.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/circle/thread
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Content-Type`  | String | `application/json`  | Yes       |
| `Accept`        | String | `application/json`  | Yes       |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       |

#### Request body

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `channel_id` | String | The ID of the channel to which the thread belongs. | Yes       |
| `user_id`    | String | The user ID.     | Yes       |
| `name`       | String | The thread name. | Yes       |
| `message_id` | String | The ID of the message based on which the thread is created.   | Yes       |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code.   |
| `thread_id` | String | The thread ID.    |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread' -d '{
  "channel_id" : "156900086",
  "user_id" : "user1",
  "message_id" : 0,
  "name" : "thread-name"
}'
```

#### Response example

```json
{
  "code" : 200,
  "thread_id" : "15890012560"
}
```

## Modify a thread

Changes the name of the specified thread.

### HTTP request

```http
PUT https://{host}/{org_name}/{app_name}/circle/thread/{thread_id}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Content-Type`  | String | `application/json`  | Yes       | 
| `Accept`        | String | `application/json`  | Yes       |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       |

#### Request body

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `name` | String | The updated thread name. | Yes       | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code.   |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/XXX' -d '{
  "name" :"thread-name"
}'
```

#### Response example

```json
{
  "code" : 200
}
```

### Retrieve the details of a thread

Retrieves the detailed information of the specified thread.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/circle/thread/{thread_id}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | `application/json`  | Yes       |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code.   |
| `thread_id` | String | The thread ID.    |
| `msgId` | String | The ID of the message based on which the thread was created.   |
| `channelId` | String | The ID of the channel to which the thread belongs. |
| `owner`    | String | The ID of the user who creates the thread.     |
| `created`    | Number | The Unix timestamp (md) when the thread was created.     |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/XXX'
```

#### Response example

```json
{
    "code": 200
    "id" : "1895600",
    "msgId" : "198008034121000",
    "channelId" : "156009089",
    "owner" : "user1",
    "created" : 1650856033420
}
```

## Destroy a thread

Destroys the specified thread.

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/circle/thread/{thread_id}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | `application/json` | Yes       |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code.   |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/XXX'
```

#### Response example

```json
{
    "code": 200
}
```


## Add a user to a thread

Adds users to the specified thread.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/circle/thread/{thread_id}/user/join?userId={user_id}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | `application/json`                           | Yes       |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code.   |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/XXX/user/join?userId=XXX'
```

#### Response example

```json
{
  "code" : 200
}
```


## Remove a user from a thread

Removes users from the specified thread.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/circle/thread/{thread_id}/user/remove?userId={user_id}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Content-Type`  | String | `application/json`                           | Yes       |
| `Accept`        | String | `application/json`                           | Yes       |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code.   |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/XXX/user/remove?userId=XXX'
```

#### Response example

```json
{
  "code" : 200
}
```

## Retrieve threads created by a user

Retrieves the detailed information of the threads created by the specified user.

### HTTP request

```shell
GET https://{host}/{org_name}/{app_name}/circle/thread/created?userId={user_id}&channelId={channel_id}&limit={limit}&cursor={cursor}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `user_id` | String | The user ID. | Yes  |
| `channel_id` | String | The ID of the channel to which the thread belongs. | Yes  |
| `limit` | Number    |   The number of threads to query per page. The value range is [1,20]. The default value is 20. This parameter is only required when retrieving by page.  |  No  |
| `cursor` | String  | The start position of the next query. This parameter is only required when retrieving by page.  |  No  |

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | `application/json`                           | Yes       |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code.   |
| `count`   | Number  | The number of retrieved threads.    |
| `threads` | List | The list of threads and their detailed information. |
| `threads.id` | String | The thread ID.    |
| `threads.msgId` | String | The ID of the message based on which the thread was created.   |
| `threads.channelId` | String | The ID of the channel to which the thread belongs. |
| `threads.owner`    | String | The ID of the user who creates the thread.     |
| `threads.created`    | Number | The Unix timestamp (md) when the thread was created.     |
| `cursor` | String  | The start position of the next query. This parameter is only required when retrieving by page.  |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/created?userId=XXX&channelId=XXX&limit=1&cursor=XXX'
```

#### Response example

```json
{
  "code" : 200,
  "count" : 1,
  "threads" : [
    {
      "id" : "1895600",
      "msgId" : "198008034121000",
      "channelId" : "156009089",
      "owner" : "user1",
      "created" : 1650856033420
    }
    ],
     "cursor" : "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aW06ZGlzY29yZDo2MjI0MjEwMiM5MDoy"
}
```

## Retrieve threads in a channel

Retrieves the detailed information of all threads in the specified channel.

### HTTP request

```shell
curl -X GET https://{host}/{org_name}/{app_name}/circle/thread/list?channelId={channel_id}&limit={limit}&cursor={cursor}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).


#### Query parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `channel_id` | String | The ID of the channel to which the thread belongs. | Yes  |
| `limit` | Number    |   The number of threads to query per page. The value range is [1,20]. The default value is 20. This parameter is only required when retrieving by page.  |  No  |
| `cursor` | String  | The start position of the next query. This parameter is only required when retrieving by page.  |  No  |

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | `application/json`                           | Yes       | 
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code.   |
| `count`   | Number  | The number of retrieved threads.    |
| `threads` | List | The list of threads and their detailed information. |
| `threads.id` | String | The thread ID.    |
| `threads.msgId` | String | The ID of the message based on which the thread was created.   |
| `threads.channelId` | String | The ID of the channel to which the thread belongs. |
| `threads.owner`    | String | The ID of the user who creates the thread.     |
| `threads.created`    | Number | The Unix timestamp (md) when the thread was created.     |
| `cursor` | String  | The start position of the next query. This parameter is only required when retrieving by page.  |

For other parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/list?channelId=XXX&limit=1&cursor=XXX'
```

#### Response example

```json
{
  "code" : 200,
  "count" : 1,
  "threads" : [
    {
       "id" : "1895600",
       "msgId" : "198008034121000",
       "channelId" : "156009089",
       "owner" : "user1",
       "created" : 1650856033420
    }
    ],
     "cursor" : "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aW06ZGlzY29yZDo2MjI0MjEwMiM5MDoy"
}
```


## Retrieve threads joined by a user

Retrieves the detailed information of the threads joined by the specified user.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/circle/thread/joined?userId={user_id}&channelId={channel_id}&limit={limit}&cursor={cursor}
```

#### Path parameter

For the parameters and detailed descriptions, see [Common parameters](#param).

#### Query parameter

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `user_id` | String | The user ID. | Yes  |
| `channel_id` | String | The ID of the channel to which the thread belongs. | Yes  |
| `limit` | Number    |   The number of threads to query per page. The value range is [1,20]. The default value is 20. This parameter is only required when retrieving by page.  |  No  |
| `cursor` | String  | The start position of the next query. This parameter is only required when retrieving by page.  |  No  |

#### Request header

| Parameter | Type | Description | Required |
| :----- | :----- | :------- | :-------- |
| `Accept`        | String | `application/json`                           | Yes       | 
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes       | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

|  Parameter  |  Type  |  Description  |
| :-------- | :------- | :------- |
| `code`   | Number     | The HTTP status code.   |
| `count`   | Number  | The number of retrieved threads.    |
| `threads` | List | The list of threads and their detailed information. |
| `threads.id` | String | The thread ID.    |
| `threads.msgId` | String | The ID of the message based on which the thread was created.   |
| `threads.channelId` | String | The ID of the channel to which the thread belongs. |
| `threads.owner`    | String | The ID of the user who creates the thread.     |
| `threads.created`    | Number | The Unix timestamp (md) when the thread was created.     |
| `cursor` | String  | The start position of the next query. This parameter is only required when retrieving by page.  |

For other parameters and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXX/XXX/XXX/circle/thread/joined?userId={user_id}&channelId=XXX&limit=1&cursor=XXX'
```

#### Response example

```json
{
  "code" : 200,
  "threads" : [
    {
        "id" : "1895600",
        "msgId" : "198008034121000",
        "channelId" : "156009089",
        "owner" : "user1",
        "created" : 1650856033420
    }
    ],
     "cursor" : "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aW06ZGlzY29yZDo2MjI0MjEwMiM5MDoy"
}
```

## Status codes

For details, see [HTTP Status Codes](https://docs.agora.io/en/agora-chat/reference/http-status-codes).