# Presence

The presence feature enables users to publicly display their online presence status and quickly determine the status of others. Users can also customize their presence status, which adds fun and diversity to real-time chatting.

This page shows how to use the Agora Chat RESTful API to implement presence in your project. Before calling the following methods, ensure that you meet the following:
- You understand the call frequency limit of the Chat RESTful APIs as described in [Limitations](./agora_chat_limitation?platform=RESTful#call-limit-of-server-side).
- You have activated the presence feature in [Agora Console](http://console.staging.agora.io/).


## Common parameters <a name="param"></a>

| Parameter | Type | Description | Required |
|:----------|:-----|:------------|:---------|
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `org_name` | String | The unique identifier assigned to each company (organization) by the Agora Chat service. For how to get the organization name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `app_name` | String | The unique identifier assigned to each app by the Agora Chat service. For how to get the app name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
| `uid`      | String | The unique login account of the user.         |


## Authorization

Agora Chat RESTful APIs require Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authorization` field must be filled in the request header:

```
Authorization: Bearer ${YourAppToken}
```

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log in to the chat system. The Agora Chat RESTful API only supports authenticating users using app tokens. For details, see [Authentication using App Token](./generate_app_tokens).


## Set the presence status of a user

Sets the presence status of a user.

For each App Key, the call frequency limit of this method is 50 per second.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/users/{uid}/presence/{resource}/{status}
```

#### Path parameter

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `resource` | String | The unique identifier assigned to each device resource in the format `{Device Type}_{Resource ID}`, where the device type can be `android`, `ios`, or `web`, followed by a resource ID assigned by the SDK.  | Yes |
| `status` | String | The presence status defined by the user:<li>`0`: Offline.<li>`1`: Online<li>Other strings: Custom status. | Yes |

For the descriptions of the other path parameters, see [Common Parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `Content-Type` | String | The content type. Set it to `application/json`.  | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `ext` | String | The extension information of the presence status. The size of the extension field can be a maximum of 64 bytes. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the data field in the response body contains the following parameters:

| Parameter      | Type   | Description |
| :------- |:-------------|:-------------|
| `result` | String |  Whether the setting of the presence status succeeds. `ok` indicates the presence setting succeeds; otherwise, you can troubleshoot according to the returned reasons.  | 

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible causes.

### Example

#### Request example

```json
curl -X POST 'a1-test.agora.com:8089/5101220107132865/test/users/c1/presence/android_123423453246/0' \
-H 'Authorization: Bearer YWMtnjEbUopPEeybKGMmN0wpeZsaLSh8UEgpirS4wNAM_qx8oS2wik8R7LE4Rclv5hu9AwMAAAF-4tr__wBPGgDWGAeO86wl2lHGeTnU030fpWuEDR015Vk6ULWGYGKccA' \
-H 'Content-Type: application/json' \
-d '{"ext":"123"}'
```

#### Response example

```json
{"result":"ok"}%
```


## Subscribe to the presence status of multiple users

Subscribes to the presence status of multiple users.

For each App Key, the call frequency limit of this method is 50 per second.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/users/{uid}/presence/{expiry}
```

#### Path parameter

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `expiry` | String |  The subscription duration in seconds. The maximum value is 2,592,000, which equals 30 days.  | Yes |

For the descriptions of the other path parameters, see [Common Parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `Content-Type` | String | The content type. Set it to `application/json`.  | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `usernames` | JSON Array |  The list of users to whom you subscribe, for example, `[“user1”, “user2”]`. This list can contain a maximum of 100 usernames.  | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the data field in the response body contains the following parameters:

| Parameter | Type   | Description |
| :------- |:-------------|:-------------|
| `result`    | JSON Array | Whether the subscription succeeds. If successful, the presence statuses of the users return; otherwise, you can troubleshoot according to the returned reasons. |
| `uid`       | String     | The unique login account of the user.                |
| `last_time` | Number     | The Unix timestamp when the user was last online.                                           |
| `expiry`    | Number     | The Unix timestamp when the subscription expires.                                           |
| `ext`       | String     | The extension information of the presence status.                |
| `status`    | JSON Array | The presence statuses on multiple devices of the user.<li>`0`: Offline.<li>`1`: Online.<li>Other strings: The custom presence status defined by the user. |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible causes.

### Example

#### Request example

```json
curl -X POST 'a1-test.agora.com:8089/5101220107132865/test/users/wzy/presence/1000' \
-H 'Authorization: Bearer YWMtnjEbUopPEeybKGMmN0wpeZsaLSh8UEgpirS4wNAM_qx8oS2wik8R7LE4Rclv5hu9AwMAAAF-4tr__wBPGgDWGAeO86wl2lHGeTnU030fpWuEDR015Vk6ULWGYGKccA' \
-H 'Content-Type: application/json' \
-d '{"usernames":["c2","c3"]}'
```

#### Response example

```json
{"result":[{"uid":"","last_time":"1644466063","expiry":"1645500371","ext":"123","status":{"android":"1","android_6b5610ac-4e11-4661-82b3-dee17bc7b2cc":"0"}},{"uid":"c3","last_time":"1645183991","expiry":"1645500371","ext":"","status":{"android":"0","android_6b5610ac-4e11-4661-82b3-dee17bc7b2cc":"0"}}]}%
```


## Retrieve the presence status of multiple users

Retrieves the presence status of multiple users.

For each App Key, the call frequency limit of this method is 50 per second.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/users/{uid}/presence
```

#### Path parameter

For the descriptions of the path parameters, see [Common Parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `Content-Type` | String | The content type. Set it to `application/json`.  | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `usernames` | JSON Array |  The list of users whose presence statuses you attempt to retrieve, for example, `[“user1”, “user2”]`. This list can contain a maximum of 100 usernames.  | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the data field in the response body contains the following parameters:

| Parameter      | Type   | Description |
| :------- |:-------------|:-------------|
| `result` | String |  Whether the setting of the presence status succeeds. `ok` indicates the presence setting succeeds; otherwise, troubleshoot according to the returned reasons.  | 

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible causes.

| Parameter | Type   | Description |
| :------- |:-------------|:-------------|
| `result`    | JSON Array | Whether the retrieving operation succeeds. If successful, the presence statuses of the users return; otherwise, you can troubleshoot according to the returned reasons. |
| `uid`       | String     | The unique login account of the user.                |
| `last_time` | Number     | The Unix timestamp when the user was last online.                                           |
| `ext`       | String     | The extension information of the presence status.                |
| `status`    | JSON Array | The presence statuses on multiple devices of the user.<li>`0`: Offline.<li>`1`: Online.<li>Other strings: The custom presence status defined by the user. |

### Example

#### Request example

```json
curl -X POST 'a1-test.agora.com:8089/5101220107132865/test/users/wzy/presence' \
-H 'Authorization: Bearer YWMtnjEbUopPEeybKGMmN0wpeZsaLSh8UEgpirS4wNAM_qx8oS2wik8R7LE4Rclv5hu9AwMAAAF-4tr__wBPGgDWGAeO86wl2lHGeTnU030fpWuEDR015Vk6ULWGYGKccA' \
-H 'Content-Type: application/json' \
-d '{"usernames":["c2","c3"]}'
```

#### Response example

```json
{
"result":[
  {"uid":"c2",
  "last_time":"1644466063",
  "ext":"",
  "status":{"android":"0"}
     },
   {"uid":"c3",
   "last_time":"1644475330",
   "ext":"",
   "status":{
       "android":"0",
       "android":"0"}
    }]
 }
```

## Unsubscribe from the presence status of multiple users

Unsubscribes from the presence status of multiple users.

For each App Key, the call frequency limit of this method is 50 per second.

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/users/{uid}/presence
```

#### Path parameter

For the descriptions of the path parameters, see [Common Parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `Content-Type` | String | The content type. Set it to `application/json`.  | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

#### Request body

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `users` | JSON Array |  The list of users from whom you unsubscribe, for example, `[“user1”, “user2”]`. This list can contain a maximum of 100 usernames.  | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the data field in the response body contains the following parameters:

| Parameter      | Type   | Description |
| :------- |:-------------|:-------------|
| `result` | String |  Whether the subscription cancellation succeeds. `ok` indicates the subscription cancellation succeeds; otherwise, you can troubleshoot according to the returned reasons.  | 

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible causes.

### Example

#### Request example

```json
curl -X DELETE 'a1-test.agora.com:8089/5101220107132865/test/users/wzy/presence' \
-H 'Authorization: Bearer YWMtnjEbUopPEeybKGMmN0wpeZsaLSh8UEgpirS4wNAM_qx8oS2wik8R7LE4Rclv5hu9AwMAAAF-4tr__wBPGgDWGAeO86wl2lHGeTnU030fpWuEDR015Vk6ULWGYGKccA' \
-H 'Content-Type: application/json' \
-d '["c1"]'
```

#### Response example

```json
{"result":"ok"}%
```

## Retrieve the subscriptions of a user

Retrieves the subscriptions of a user in a paginated list.

For each App Key, the call frequency limit of this method is 50 per second.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/users/{uid}/presence/sublist?pageNum=1&pageSize=100
```

#### Path parameter

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `pageNum` | Int | The page from which to start retrieving subscriptions. Pass in `1` at the first query.  | Yes |
| `pageSize` | Int | The maximum number of subscriptions to retrieve per page. The range is [1, 500]. | Yes |

For the descriptions of the other path parameters, see [Common Parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
|:---------------| :------ | :------- |:------------------|
| `Content-Type` | String | The content type. Set it to `application/json`.  | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the data field in the response body contains the following parameters:

| Parameter      | Type   | Description |
| :------- |:-------------|:-------------|
| `result` | String | Whether the retrieving operation succeeds. If successful, the subscription information returns; otherwise, you can troubleshoot according to the returned reasons.  | 
| `totalnum` | String | The total number of the users you subscribe to.                         |
| `sublist`  | Object | The list of subscriptions. Each object in the list contains the `uid` and `expiry` fields.            |
| `uid`      | String |  The unique login account of the user.           |
| `expiry`   | String | The Unix timestamp when the subscription expires.       |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible causes.

### Example

#### Request example

```json
curl -X GET 'a1-test.agora.com:8089/5101220107132865/test/users/wzy/presence/sublist?pageNum=1&pageSize=100' \
-H 'Authorization: Bearer YWMtnjEbUopPEeybKGMmN0wpeZsaLSh8UEgpirS4wNAM_qx8oS2wik8R7LE4Rclv5hu9AwMAAAF-4tr__wBPGgDWGAeO86wl2lHGeTnU030fpWuEDR015Vk6ULWGYGKccA' \
-H 'Content-Type: application/json' 
```

#### Response example

```json
{"result":{"totalnum":"2","sublist":[{"uid":"lxml2","expiry":"1645822322"},{"uid":"lxml1","expiry":"1645822322"}]}}%
```


## Status codes

For details, see [HTTP Status Codes](./agora_chat_status_code?platform=RESTful).