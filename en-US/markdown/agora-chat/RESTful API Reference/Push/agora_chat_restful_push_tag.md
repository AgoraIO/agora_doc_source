# Set push labels

The push service allows you to group targeting users by configuring labels. Each label marks a user group that has similar habits, hobbies, or characteristics. When sending notifications, you can implement a bespoke push by specifying relevant labels, and the messages can then be sent to the users under the labels. For example, you can label a group of users with "fashion trendsetters", and push related information about domestic and foreign trend brands to that user group on a regular basis.

You can manage the tags through RESTful API. The relationship between users and tags is many to many, that is, one user can have multiple tags and one tag can also have multiple users.


Before calling the following methods, ensure that you understand the call frequency limit of the Chat RESTful APIs as described in [Limitations](./reference/limitations#call-limit-of-server-sides).

## <a name="param"></a>Common parameters

The following table lists common request and response parameters of the Chat RESTful APIs:

### Request parameters

| Parameter      | Type | Description    | Required | 
| :--------- | :----- |:------------- | :------- | 
| `host`     | String | The domain name assigned by the Chat service to access RESTful APIs. For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes   | 
| `org_name` | String | The unique identifier assigned to each company (organization) by the Chat service. For how to get the organization name, see [Get the information of the Chat project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes     | 
| `app_name` | String | The unique identifier assigned to each app by the Chat service. For how to get the app name, see [Get the information of the Chat project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes    | 
| `username` | String | The unique login account of the user.    | Yes     | 

### Response parameters

| Parameter        | Type   | Description          |
| :----------| :----------- | :----------------- |
| `timestamp` | Number      | The Unix timestamp (ms) of the HTTP response.  |
| `duration`  | Number      | The duration (ms) from when the HTTP request is sent to the time the response is received. |


## Authorization

Chat RESTful APIs require Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authorization` field must be filled in the request header:

```
Authorization: Bearer ${YourAppToken}
```

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log in to the chat system. The Chat RESTful API only supports authenticating users using app tokens. For details, see [Authentication using App Token](./generate_app_tokens).


## Create a push label

Creates a push label.

<div class="alert note">You can create a maximum of 100 push labels. To lift the upper limit, contact <a href="mailto:support@agora.io">support@agora.io</a>.</div>

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/push/label
```
#### Path parameter

For the descriptions of path parameters, see [Common parameters](#param).

#### Request header

| Parameter           | Type | Description     | Required | 
| :-------------- | :----- | :------- | :---------- |
| `Content-Type`  | String | The content type. Set it as `application/json`.  | Yes   | 
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value.  | Yes    | 
 
#### Request body

| Parameter         | Type | Description      | Required | 
| :------------ | :------- | :----- | :--------------- |
| `name`        | String | The name of the push label. The length of each label name cannot exceed 64 characters, and the following character sets are supported:<ul><li>26 lowercase English letters (a-z)</li><li>26 uppercase English letters (A-Z)</li><li>10 numbers (0-9)</li><li>"\_", "-", "."</li></ul><div class="alert note"><ul><li>The label name is case insensitive, so "Aa" and "aa" are the same label.</li><li>Ensure that each label name under the same app is unique.</li></ul></div>          | Yes     | 
| `description` | String | The description of the push label. The length of the label description cannot exceed 255 characters. | No     | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter      | Type | Description    |
| :-------- | :----- | :-------- |
| `data` | JSON | The detailed information of the push label. |
| `name` | String | The label name. |
| `description` | String | The label description. |
| `createdAt` | Number | The Unix timestamp (ms) when the push label was created. |

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -L -X POST 'localhost/hx/hxdemo/push/label' \
-H 'Authorization: Bearer YWMt5lyAUJnNEeyHUS2MdMYkPAAAAAAAAAAAAAAAAAAAAAEHMpqy501HZr2ms92z-Hz9AQMAAAF_SGRs1QBPGgBOIAaoCYWXntKF-h0vuvlyUCNB-IXTM4eEpSVqIdei9A' \
-H 'Content-Type: application/json' \
--data-raw '{
    "name":"post-90s",
    "description":"hah"
}'
``` 

#### Response example

```json
{
    "timestamp": 1648720341157,
    "data": {
        "name": "post-90s",
        "description": "hah",
        "createdAt": 1648720341118
    },
    "duration": 13
}
```

## Query the detailed information of a push label

Retrieves the detailed information of the specified push label.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/push/label/{labelname}
```

#### Path parameter

| Parameter       | Type | Description      | Required | 
| :---------- | :------- | :----- | :------------- |
| `labelname` | String | The name of the push label. | Yes     | 

For the descriptions of other path parameters, see [Common parameters](#param).

#### Request header

| Parameter           | Type | Description     | Required | 
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes    | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter      | Type | Description    |
| :-------- | :----- | :-------- |
| `data` | JSON | The detailed information of the push label. |
| `name` | String | The label name. |
| `description` | String | The label description. |
| `count` | Number | The number of the users added to the push label. |
| `createdAt` | Number | The Unix timestamp (ms) when the push label was created. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example
 
```shell
curl -L -X GET 'localhost/hx/hxdemo/push/label/90' \
-H 'Authorization: Bearer YWMt5lyAUJnNEeyHUS2MdMYkPAAAAAAAAAAAAAAAAAAAAAEHMpqy501HZr2ms92z-Hz9AQMAAAF_SGRs1QBPGgBOIAaoCYWXntKF-h0vuvlyUCNB-IXTM4eEpSVqIdei9A'
```

#### Response example

```json
{
    "timestamp": 1648720562644,
    "data": {
        "name": "90",
        "description": "hah",
        "count": 0,
        "createdAt": 1648720341118
    },
    "duration": 0
}
```

## Query the detailed information of push labels by page

Retrieves the detailed information of multiple push labels by page.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/push/label
```

#### Path parameter

For the descriptions of the other path parameters, see [Common parameters](#param).

#### Query parameters

| Parameter    | Type | Description  | Required | 
| :------- | :------- | :----- | :----------------------- |
| `limit`  | Number | The number of push labels displayed per page. The range is [1,100]. The default value is `100`.  | No   | 
| `cursor` | String | The start position for the next query.  | No  | 

#### Request header

| Parameter           | Type | Description     | Required | 
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes     | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter      | Type | Description    |
| :-------- | :----- | :-------- |
| `data` | JSON Array | The detailed information of the push label. |
| `name` | String | The label name. |
| `description` | String | The label description. |
| `count` | Number | The number of the users added to the push label. |
| `createdAt` | Number | The Unix timestamp (ms) when the push label was created. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -L -X GET 'localhost/hx/hxdemo/push/label' \
-H 'Authorization: Bearer YWMt5lyAUJnNEeyHUS2MdMYkPAAAAAAAAAAAAAAAAAAAAAEHMpqy501HZr2ms92z-Hz9AQMAAAF_SGRs1QBPGgBOIAaoCYWXntKF-h0vuvlyUCNB-IXTM4eEpSVqIdei9A'
```

#### Response example

```json
{
    "timestamp": 1648720425599,
    "data": [
        {
            "name": "post-90s",
            "description": "hah",
            "count": 0,
            "createdAt": 1648720341118
        },
        {
            "name": "post-80s",
            "description": "post-80s generation",
            "count": 0,
            "createdAt": 1647512525642
        }
    ],
    "duration": 1
}
```

## Delete a push label

Deletes the specified push label. You can delete one push label at each call.

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/push/label/{labelname}
```

#### Path parameter

| Parameter       | Type | Description      | Required | 
| :---------- | :------- | :----- | :------------- |
| `labelname` | String | The name of the push label. | Yes     | 

For the descriptions of the other path parameters, see [Common parameters](#param).

#### Request header 

| Parameter           | Type | Description  | Required | 
| :------------- | :----- | :------- | :--------------- |
| `Authorization` | String |The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes     | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter      | Type | Description    |
| :-------- | :----- | :-------- |
| `data` | String | The request result. `success` indicates that the delete operation proceeds properly. | 

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -L -X DELETE 'localhost/hx/hxdemo/push/label/post-90s' \
-H 'Authorization: Bearer YWMt5lyAUJnNEeyHUS2MdMYkPAAAAAAAAAAAAAAAAAAAAAEHMpqy501HZr2ms92z-Hz9AQMAAAF_SGRs1QBPGgBOIAaoCYWXntKF-h0vuvlyUCNB-IXTM4eEpSVqIdei9A'
```

#### Response example

```json
{
    "timestamp": 1648721097405,
    "data": "success",
    "duration": 0
}
```


## Add users to a push label

Adds one or more users to the specified push label. A maximum of 200,000 users can be added to a push label. To lift the upper limit, contact <a href="mailto:support@agora.io">support@agora.io</a>.</div>

You can add a maximum of 100 users at each call.

### HTTP request

```http
POST https://{host}/{org_name}/{app_name}/push/label/{labelname}/user
```

#### Path parameter

| Parameter       | Type | Description      | Required | 
| :---------- | :------- | :----- | :------------- |
| `labelname` | String | The name of the push label. | Yes     | 

For the descriptions of the other path parameters, see [Common parameters](#param).

#### Request header

| Parameter           | Type | Description  | Required | 
| :------------- | :----- | :------- | :--------------- |
| `Content-Type`  | String | The content type. Set it as `application/json`.        | Yes     | 
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes     | 

#### Request body

| Parameter       |Type| Description                        | Required |
| :---------- | :------- | :--- | :---------------------------- |
| `usernames` | List | The IDs of the users to be added to the push label. You can pass a maximum of 100 users for each request. | Yes     |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter      | Type | Description    |
| :-------- | :----- | :-------- |
| `data` | JSON | The request result. |
| `success` | List | The user IDs properly added to the push label. |
| `fail` | JSON | If add operations fail, the user IDs failed to be added and the corresponding failure reasons are returned in key-value pairs. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -L -X POST 'localhost/hx/hxdemo/push/label/post-90s/user' \
-H 'Authorization: Bearer YWMt5lyAUJnNEeyHUS2MdMYkPAAAAAAAAAAAAAAAAAAAAAEHMpqy501HZr2ms92z-Hz9AQMAAAF_SGRs1QBPGgBOIAaoCYWXntKF-h0vuvlyUCNB-IXTM4eEpSVqIdei9A' \
-H 'Content-Type: application/json' \
--data-raw '{
    "usernames":["hx1","hx2"]
}'
```

#### Response example

```json
{
    "timestamp": 1648721496345,
    "data": {
        "success": [
            "hx1",
            "hx2"
        ],
        "fail": {}
    },
    "duration": 18
}
```

## Query the specified user under the specified push label

Retrieves the detailed information of the specified user under the specified push label.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/push/label/{labelname}/user/{member}
```

#### Path parameter

| Parameter       | Type | Description      | Required | 
| :---------- | :------- | :----- | :------------- |
| `labelname` | String | The name of the push label. | Yes     |
| `member`    | String | The ID of the user. | Yes     | 

For the descriptions of the other path parameters, see [Common parameters](#param).

#### Request header

| Parameter           | Type | Description  | Required | 
| :------------- | :----- | :------- | :--------------- |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes     | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter      | Type | Description    |
| :-------- | :----- | :-------- |
| `data` | JSON | The detailed information of the user. |
| `username` | String | The user ID. |
| `created` | Number | The Unix timestamp (ms) when the user was added to the push label. | 

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -L -X GET 'localhost/hx/hxdemo/push/label/post-90s/user/hx1' \
-H 'Authorization: Bearer YWMt5lyAUJnNEeyHUS2MdMYkPAAAAAAAAAAAAAAAAAAAAAEHMpqy501HZr2ms92z-Hz9AQMAAAF_SGRs1QBPGgBOIAaoCYWXntKF-h0vuvlyUCNB-IXTM4eEpSVqIdei9A'
```

#### Response example

```json
{
    "timestamp": 1648721589676,
    "data": {
        "username": "hx1",
        "created": 1648721496324
    },
    "duration": 1
}
```


## Query the detailed information of users under the specified push label by page

Retrieves the detailed information of one or more users under the specified push label by page.

### HTTP request

```http
GET https://{host}/{org_name}/{app_name}/push/label/{labelname}/user
```

#### Path parameter

| Parameter       | Type | Description      | Required | 
| :---------- | :------- | :----- | :------------- |
| `labelname` | String | The name of the push label. | Yes     |

For the descriptions of the other path parameters, see [Common parameters](#param).

#### Query parameters

| Parameter    | Type | Description          | Required |
| :------- | :------- | :----- | :----------------------- |
| `limit`  | String | The number of the users displayed per page. The range is [1,100]. The default value is `100`. | No   |
| `cursor` | String | The start position for the next query.        | No   |

#### Request header

| Parameter           | Type | Description      | Required | 
| :-------------- | :----- | :------- | :----------------------------------------------------------- |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes     | 

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter      | Type | Description    |
| :-------- | :----- | :-------- |
| `cursor` | String | The start position for the next query. |
| `data` | JSON Array | The detailed information of the users. |
| `username` | String | The user ID. |
| `created` | Number | The Unix timestamp (ms) when the user was added to the push label. | 

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -L -X GET 'localhost/hx/hxdemo/push/label/post-90s/user?limit=1' \
-H 'Authorization: Bearer YWMt5lyAUJnNEeyHUS2MdMYkPAAAAAAAAAAAAAAAAAAAAAEHMpqy501HZr2ms92z-Hz9AQMAAAF_SGRs1QBPGgBOIAaoCYWXntKF-h0vuvlyUCNB-IXTM4eEpSVqIdei9A'
```

#### Response example

```json
{
    "timestamp": 1648721736670,
    "cursor": "ZWFzZW1vYjpwdXNoOmxhYmVsOmN1cnNvcjo5NTkxNTMwMDM4ODQxMzgwMjc",
    "data": [
        {
            "username": "hx1",
            "created": 1648721496324
        }
    ],
    "duration": 1
}
```


## Remove users from a push label

Removes one or more users from the specified push label. You can remove a maximum of 100 users at each call.

### HTTP request

```http
DELETE https://{host}/{org_name}/{app_name}/push/label/{labelname}/user
```

#### Path parameter

| Parameter       | Type | Description         | Required |
| :---------- | :------- | :----- | :------------- |
| `labelname` | String | The name of the push label. | Yes     |

For the descriptions of the other path parameters, see [Common parameters](#param).

#### Request header

| Parameter           | Type | Description             | Required | 
| :-------------- | :----- | :------- | :----------- |
| `Content-Type`  | String | The content type. Set it as `application/json`.        | Yes     |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${YourAppToken}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes     | 

#### Request body

| `usernames` | List | The IDs of the users to be removed from the push label. You can pass a maximum of 100 users for each request. | Yes     |

### HTTP response

#### Response body

If the returned HTTP status code is `200`, the request succeeds, and the response body contains the following fields:

| Parameter      | Type | Description    |
| :-------- | :----- | :-------- |
| `data` | JSON | The request result. |
| `success` | List | The user IDs properly removed from the push label. |
| `fail` | JSON | If remove operations fail, the user IDs failed to be removed and the corresponding failure reasons are returned in key-value pairs. |

For other fields and detailed descriptions, see [Common parameters](#param).

If the returned HTTP status code is not `200`, the request fails. You can refer to [Status codes](#status-codes) for possible reasons.

### Example

#### Request example

```shell
curl -L -X DELETE 'localhost/hx/hxdemo/push/label/post-90s/user' \
-H 'Authorization: Bearer YWMt5lyAUJnNEeyHUS2MdMYkPAAAAAAAAAAAAAAAAAAAAAEHMpqy501HZr2ms92z-Hz9AQMAAAF_SGRs1QBPGgBOIAaoCYWXntKF-h0vuvlyUCNB-IXTM4eEpSVqIdei9A' \
-H 'Content-Type: application/json' \
--data-raw '{
    "usernames":["hx1","hx2"]
}'
```

#### Response example

```json
{
    "timestamp": 1648722018636,
    "data": {
        "success": [
            "hx1",
            "hx2"
        ],
        "fail": {}
    },
    "duration": 1
}
```

## Status codes

For details, see [HTTP Status Codes](./agora_chat_status_code).