# Create, Delete, and Retrieve Threads

This page shows how to create, modify, delete, and retrieve a thread by calling Agora Chat RESTful APIs. Before calling the following methods, ensure that you understand the call frequency limit described in [Limitations](./agora_chat_limitation?platform=RESTful#call-limit-of-server-side).

## Common parameters

### Request parameters <a name="request"></a>

| Parameter | Type | Description | Required |
|:----------|:-----|:------------|:---------|
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. For how to get the organization name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |

### Response parameters <a name="response"></a>

| Parameter | Type | Description |
|:----------|:-----|:------------|
| `action` | String | The HTTP request method. |
| `organization` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. This is the same as `org_name`. |
| `applicationName` | String | The unique identifier assigned to each app by the Agora Chat service. This is the same as `app_name`. |
| `data` | String | The details of the response. |
| `duration` | String | The duration (ms) from when the HTTP request is sent to the time the response is received. |
| `timestamp` | String | The Unix timestamp (ms) of the HTTP response. |
| `uri` | String | The request URI, which is part of the request URL. You can safely ignore this parameter. |
| `entities` | String | The request entity. |
| `properties` | String | The request property. |


## Authorization <a name="auth"></a>

Agora Chat RESTful APIs require Bearer HTTP authentication. Every time an HTTP request is sent, the following Authorization field must be filled in the request header:

```
Authorization: Bearer ${YourAppToken}
```

The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log in to the chat system. The Agora Chat RESTful API only supports authenticating users using app tokens. For details, see [Authentication using App Token](./generate_app_tokens).


## Creating a thread

Creates a thread. An app can have up to 100,000 threads by default. To increase the limit, contact [support@agora.io](mailto:support@agora.io).

For each App Key, the call frequency limit of this method is 100 per second.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/thread
```

#### Path parameter

For the descriptions of the path parameters, see [Common Parameters](#request).

#### Request header

For the descriptions of the request headers, see [Authorization](#auth).

#### Request body

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `group_id` | String | The ID of the group to which the thread belongs. | Yes |
| `name` | String | The name of the thread. The maximum length of the thread name is 64 characters. | Yes |
| `msg_id` | String  | The ID of the message based on which the thread is created. |  Yes  |
| `owner` | String  | The username of the thread creator.  | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the data field in the response body contains the following parameters:

| Parameter      | Type           | Description |
| :------- |:-------------|:-------------|
| `thread_id` | String | The ID of the thread. | 

For other fields and descriptions, see [Common parameters](#response).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#Status-codes) for possible causes.

### Example

#### Request example

```shell
curl -X POST http://XXXX.com/XXXX/testapp/thread -H 'Authorization: Bearer <YourAppToken>' -H 'Content-Type:application/json' -d '
{
    "group_id": 179800091197441,
    "name": "1",
    "owner": "test4",
    "msg_id": 1234
}'
```

#### Response example

```json
{
    "action": "post",
    "applicationName": "testapp",
    "duration": 4,
    "data": {
        "thread_id": "177916702949377"
    },
    "organization": "XXXX",
    "timestamp": 1650869972109,
    "uri": "http://XXXX.com/XXXX/testy/thread"
}
```


## Modifying a thread

Modifies the name of the specified thread.

For each App Key, the call frequency limit of this method is 100 per second.

### HTTP request

```http
PUT https://{host}/{org_name}/{app_name}/thread/{thread_id}
```

#### Path parameter

| Parameter | Type | Description | Required |
|:------------|:-------|:-----|:-----------|
| `thread_id` | String | The ID of the thread. | Yes |

For the descriptions of the other path parameters, see [Common Parameters](#request).

#### Request header

for the descriptions of the request headers, see [Authorization](#auth).

#### Request body

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `name` | String | The updated name of the thread. The maximum length of the thread name is 64 characters. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the data field in the response body contains the following parameters:

| Parameter      | Type   | Description |
| :------- |:-------------|:-------------|
| `name` | String | The updated name of the thread. | 

For other fields and descriptions, see [Common parameters](#response).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#Status-codes) for possible causes.

### Example

#### Request example

```shell
curl -X PUT http://XXXX.com/XXXX/testapp/thread/177916702949377 -H 'Authorization: Bearer <YourAppToken>' -d '{"name": "test4"}'
```

#### Response example

```json
{
    "action": "put",
    "applicationName": "testapp",
    "duration": 4,
    "data": {
        "name": "test4"
    },
    "organization": "XXXX",
    "timestamp": 1650869972109,
    "uri": "http://XXXX.com/XXXX/testy/thread"
}
```


## Deleting a thread

Deletes the specified thread.

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/thread/{thread_id}
```

#### Path parameter

| Parameter | Type | Description | Required |
|:------------|:-------|:-----|:-----------|
| `thread_id` | String | The ID of the thread. | Yes |

For the descriptions of the other path parameters, see [Common Parameters](#request).

#### Request header

for the descriptions of the request headers, see [Authorization](#auth).

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the data field in the response body contains the following parameters:

| Parameter  | Type   | Description |
| :------- |:-------------|:-------------|
| `status` | String | Whether the thread is deleted. `ok` indicates that the thread is deleted. | 

For other fields and descriptions, see [Common parameters](#response).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#Status-codes) for possible causes.

### Example

#### Request example

```shell
curl -X DELETE http://XXXX.com/XXXX/testapp/thread/177916702949377 -H 'Authorization: Bearer <YourAppToken>'
```

#### Response example

```json
{
    "action": "delete",
    "applicationName": "testapp",
    "duration": 4,
    "data": {
        "status": "ok"
    },
    "organization": "XXXX",
    "timestamp": 1650869972109,
    "uri": "http://XXXX.com/XXXX/testy/thread"
}
```


## Retrieving all the threads under the app

Retrieves all the threads under the app by page.

For each App Key, the call frequency limit of this method is 100 per second.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/thread?limit={limit}&cursor={cursor}&sort={sort}
```

#### Path parameter

For the descriptions of the path parameters, see [Common Parameters](#request).

#### Query parameter

| Parameter | Type | Description | Required |
|:------------|:-------|:-----|:-----------|
| `limit` | String | The maximum number of threads to retrieve per page. The range is [1, 50]. The default value is 50. | No |
| `cursor` | String | The page from which to start retrieving threads. Pass in `null` or an empty string at the first query. | No |
| `sort` | String | The order in which to list the query results:<li>`asc`: In chronological order of thread creation.<li>(Default) `desc`: In reverse chronological order of thread creation. | No |


#### Request header

for the descriptions of the request headers, see [Authorization](#auth).

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the entity field in the response body contains the following parameters:

| Parameter  | Type   | Description |
| :------- |:-------------|:-------------|
| `id` | String | The ID of the thread. |
| `properties.cursor` | String | The cursor that indicates the starting position of the next query. |

For other fields and descriptions, see [Common parameters](#response).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#Status-codes) for possible causes.

### Example

#### Request example

```shell
curl -X GET http://XXXX.com/XXXX/testapp/thread -H 'Authorization: Bearer <YourAppToken>'
```

#### Response example

```json
{
    "action": "get",
    "applicationName": "testapp",
    "duration": 7,
    "entities": [
        {
            "id": "179786360094768"
        }
    ],
    "organization": "XXXX",
    "properties": {
        "cursor": "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aW06dGhyZWFkOmVhc2Vtb2ItZGVtbyN0ZXN0eToxNzk3ODYzNjExNDMzMTE"
    },
    "timestamp": 1650869750247,
    "uri": "http://XXXX.com/XXXX/testy/thread"
}
```


## Retrieving all the threads a user joins under the app

Retrieves all the threads a user joins under the app.

For each App Key, the call frequency limit of this method is 100 per second.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/threads/user/{username}?limit={limit}&cursor={cursor}&sort={sort}
```

#### Path parameter

For the descriptions of the path parameters, see [Common Parameters](#request).

#### Query parameter

| Parameter | Type | Description | Required |
|:------------|:-------|:-----|:-----------|
| `limit` | String | The maximum number of threads to retrieve per page. The range is [1, 50]. The default value is 50. | No |
| `cursor` | String | The page from which to start retrieving threads. Pass in `null` or an empty string at the first query. | No |
| `sort` | String | The order in which to list the query results:<li>`asc`: In chronological order of thread creation.<li>(Default) `desc`: In reverse chronological order of thread creation. | No |

#### Request header

for the descriptions of the request headers, see [Authorization](#auth).

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the entity field in the response body contains the following parameters:

| Parameter  | Type   | Description |
| :------- |:-------------|:-------------|
| `name` | String | The thread name. |
| `owner` | String | The thread creator. |
| `id` | String | The thread ID. |
| `msgId` | String | The ID of the message based on which the thread is created. |
| `groupId` | String | The ID of the chat group to which the thread belongs. |
| `created` | String | The Unix timestamp when the thread is created. |
| `properties.cursor` | String | The cursor that indicates the starting position of the next query. |

For other fields and descriptions, see [Common parameters](#response).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#Status-codes) for possible causes.

### Example

#### Request example

```shell
curl -X GET http://XXXX.com/XXXX/testapp/threads/user/test4 -H 'Authorization: Bearer <YourAppToken>'
```

#### Response example

```json
{
    "action": "get",
    "applicationName": "testapp",
    "duration": 4,
    "entities": [
        {
            "name": "1",
            "owner": "test4",
            "id": "17XXXX69",
            "msgId": "1920",
            "groupId": "17XXXX61",
            "created": 1650856033420
        }
    ],
    "organization": "XXXX",
    "properties": {
        "cursor": "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aW06dGhyZWFkOmVhc2Vtb2ItZGVtbyN0ZXN0eToxNzk3ODYzNjAwOTQ3Nzg"
    },
    "timestamp": 1650869972109,
    "uri": "http://XXXX.com/XXXX/testy/threads/user/test4"
}
```

## Retrieving all the threads a user joins under a chat group

Retrieves all the threads a user joins under a chat group.

For each App Key, the call frequency limit of this method is 100 per second.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/threads/chatgroups/{group_id}/user/{username}?limit={limit}&cursor={cursor}&sort={sort}
```

#### Path parameter

| Parameter | Type | Description | Required |
|:---------|:-------|:-----|:--------------------------|
| `group_id`   | String | The ID of the chat group.  | Yes |
| `username` | String | The unique login account of the user. | Yes |

For the descriptions of the other path parameters, see [Common Parameters](#request).


#### Query parameter

| Parameter | Type | Description | Required |
|:---------|:-------|:-----|:--------------------------|
| `limit` | String | The maximum number of threads to retrieve per page. The range is [1, 50]. The default value is 50. | No |
| `cursor` | String | The page from which to start retrieving threads. Pass in `null` or an empty string at the first query. | No |
| `sort` | String | The order in which to list the query results:<li>`asc`: In chronological order of thread creation.<li>(Default) `desc`: In reverse chronological order of thread creation. | No |


#### Request header

for the descriptions of the request headers, see [Authorization](#auth).

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the entity field in the response body contains the following parameters.

For the last page of data, the response still contains `cursor` and the number of retrieved threads is smaller than the value of `limit` in the request. If there is no more thread data returned in the response, you have retrieved data of all threads in this group. 

| Parameter  | Type   | Description |
| :------- |:-------------|:-------------|
| `name` | String | The thread name. |
| `owner` | String | The thread creator. |
| `id` | String | The thread ID. |
| `msgId` | String | The ID of the message based on which the thread is created. |
| `groupId` | String | The ID of the chat group to which the thread belongs. |
| `created` | String | The Unix timestamp when the thread is created. |

For other fields and descriptions, see [Common parameters](#response).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#Status-codes) for possible causes.

### Example

#### Request example

```shell
curl -X GET http://XXXX.com/XXXX/testapp/threads/user/test4 -H 'Authorization: Bearer <YourAppToken>'
```

#### Response example

```json
{
    "action": "get",
    "applicationName": "testapp",
    "duration": 4,
    "entities": [
        {
            "name": "1",
            "owner": "test4",
            "id": "17XXXX69",
            "msgId": "1920",
            "groupId": "17XXXX61",
            "created": 1650856033420
        }
    ],
    "organization": "XXXX",
    "properties": {
        "cursor": "ZGNiMjRmNGY1YjczYjlhYTNkYjk1MDY2YmEyNzFmODQ6aW06dGhyZWFkOmVhc2Vtb2ItZGVtbyN0ZXN0eToxNzk3ODYzNjAwOTQ3Nzg"
    },
    "timestamp": 1650869972109,
    "uri": "http://XXXX.com/XXXX/testy/threads/user/test4"
}
```


## Status codes

For details, see [HTTP Status Codes](./agora_chat_status_code?platform=RESTful).