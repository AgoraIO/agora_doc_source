This page shows how to manage the group announcement and group files by calling Agora Chat RESTful APIs. Before calling the following methods, ensure that you understand the call frequency limit described in [Limitations](./agora_chat_limitation?platform=RESTful#call-limit-of-server-side).

<a name="param"></a>

## Common parameters

The following table lists common request and response parameters of the Agora Chat RESTful APIs:

### Request parameters

| Parameter | Type | Description | Required |
| :--------- | :----- | :----------------------------------------------------------- | :------- |
| `host` | String | The domain name assigned by the Agora Chat service to access RESTful APIs.For how to get the domain name, see [Get the information of your project](./enable_agora_chat?platform=RESTful#get-the-information-of-the-agora-chat-project). | Yes |
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

Agora Chat RESTful APIs requires Bearer HTTP authentication. Every time an HTTP request is sent, the following `Authorization` field must be filled in the request header:

```shell
Authorization: Bearer ${YourAppToken}
```

In order to improve the security of the project, Agora uses a token (dynamic key) to authenticate users before they log into the chat system. The Agora Chat RESTful API only supports authenticating users using app tokens. For details, see [Authentication using App Token](./generate_app_tokens).

## Retrieving the chat group announcement

Retrieves the announcement of the specified chat group.

### HTTP request

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/announcement
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

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following parameters.

| Parameter | Type | Description |
| :----------- | :----- | :----------- |
| `announcement` | String | The content of the group announcement. |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X GET -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66021836783617/announcement'
```

#### Response example

```json
{
    "action": "get",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66021836783617/announcement",
    "entities": [],
    "data": {
      "announcement" : "group announcement..."
    },
    "timestamp": 1542363546590,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

## Modifying the chat group announcement

Modifies the announcement of the specified chat group. The group announcement cannot exceed 512 characters.

### HTTP request

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/announcement
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
| :------- | :----- | :-------- | :------- |
| `announcement` | String | The content of the group announcement. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following parameters.

| Parameter | Type | Description |
| :----- | :------ | :---------------------------------------------------- |
| `id` | String | The group ID. |
| `result` | Boolean | Whether the group announcement is successfully modified.<ul><li>`true`: Yes.</li><li>`false`: No.</li></ul> |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -d '{"announcement" : "group announcement…"}' 'http://XXXX/XXXX/XXXX/chatgroups/66021836783617/announcement'
```

#### Response example

```json
{
    "action": "post",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66021836783617/announcement",
    "entities": [],
    "data": {
      "id" : "66021836783617",
      "result" : true
    },
    "timestamp": 1542363546590,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

<a name="getall"></a>
## Retrieving the chat group shared files

Retrieves the shared files of the specified chat group with pagination. Each page can have a maximum of 1000 shared files.

After successfully calling this method, you can get the `file_id` from the response, which is the unique file ID that identifies the shared file. This field can be used to specify a shared file when you download or remove it.

### HTTP request

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/share_files

// Gets a group's shared files with pagination.
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/share_files?pagenum=1&pagesize=10
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------- | :----- | :-------- | :------- |
| group_id | String | The group ID. | Yes |

For the descriptions of other path parameters, see [Common Parameters](#param).

#### Query parameter

| Parameter | Type   | Description   | Required |
| :------- | :----- | :------------------------ | :------- |
| `pagesize`  | String | The number of shared files to retrieve per page. The value range is [1,1000] and the default value is `1000`.    | No  |
| `pagenum` | String | The current page number. The query starts from the first page by default.  | No  |

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
| :--------- | :----- | :----------------------------------------------------------- |
| `file_id` | String | The ID of the chat group shared file. This field is required if you want to download or remove a group's shared files. |
| `file_name` | String | The name of the chat group shared file. |
| `file_owner` | String | The ID of the user uploading the shared file. |
| `file_size` | Number | The size of the chat group shared file, in bytes. |
| `created` | Long | The Unix timestamp for uploading the group shared file. |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X GET -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files?pagenum=1&pagesize=10'
```

#### Response example

```json
{
    "action": "get",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "params": {
          "pagesize": [
              "10"
          ],
          "pagenum": [
              "1"
          ]
      },
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files",
    "entities": [],
    "data": [
          {
              "file_id": "dbd88d20-XXXX-XXXX-95fc-638fc2d59a8d",
              "file_name": "159781149272586.jpg",
              "file_owner": "u1",
              "file_size": 326127,
              "created": 1597811492594
          },
          {
              "file_id": "b30e0be0-XXXX-XXXX-8732-172a3f85134f",
              "file_name": "159781141836993.jpg",
              "file_owner": "u1",
              "file_size": 326127,
              "created": 1597811424158
          }
      ],
    "timestamp": 1542363546590,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```


## Uploading a chat group shared file

Uploads a chat group shared file. This shared file cannot exceed 10 MB.

### HTTP request

```shell
POST https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/share_files
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | The group ID. | Yes |

For the descriptions of other path parameters, see [Common Parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Content-Type` | String | The parameter type. Set it as `application/json`. | Yes |
| `Accept` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body contains the following parameters.

| Parameter | Type | Description |
| :-------- | :----- | :----------------------------------------------------------- |
| `file_url` | String | The URL to shared files of groups on the Agora Chat server. |
| `group_id` | String | The group ID. |
| `file_name` | String | The name of the group's shared file. |
| `created` | Long | The upload time of the group's shared file. |
| `file_id` | String | The ID of the group's shared file. This field is required if you want to download or remove a group's shared files. |
| `file_size` | Number | The size of the group's shared file, in the unit of bytes. |
For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X POST 'http://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files' -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' -F file=@/Users/test/image/IMG_3.JPG
```

#### Response example

```json
{
    "action" : "post",
    "application" : "7f7b5180-XXXX-XXXX-9558-092397c841ef",
    "uri" : "http://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files",
    "entities" : [ ],
    "data" : {
      "file_url" : "https://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files/c6906aa0-ed19-11ea-b480-f3cf141d15c0",
      "group_id" : "66021836783617",
      "file_name" : "img_3.jpg",
      "created" : 1599050554954,
      "file_id" : "c6906aa0-XXXX-XXXX-b480-f3cf141d15c0",
      "file_size" : 13512
    },
    "timestamp" : 1599050554978,
    "duration": 0,
    "organization" : "XXXX",
    "applicationName" : "XXXX"
}
```

## Downloading the chat group shared file

Downloads a shared file of the chat group. You can get the file ID (`file_id`) from the response body of [Retrieving the chat group shared files](#getall).

### HTTP request

```shell
GET https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/share_files/{file_id}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | The group ID. | Yes |
| `file_id` | String | The file ID. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds and the response body contains only the content of the uploaded file. For example, the content of the uploaded file is `Hello world`, the response body only contains `Hello world`.

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X GET -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files/b30e0be0-XXXX-XXXX-8732-172a3f85134f'
```

#### Response example

The response contains only the content of the uploaded file. For example, the content of the uploaded file is `Hello world`, the response only contains `Hello world`.

## Deleting a chat group shared file

Deletes a chat group shared file. You can get the file ID (`file_id`) the response body of [Retrieving the chat group shared files](#getall).

### HTTP request

```shell
DELETE https://{host}/{org_name}/{app_name}/chatgroups/{group_id}/share_files/{file_id}
```

#### Path parameter

| Parameter | Type | Description | Required |
| :------- | :----- | :-------- | :------- |
| `group_id` | String | The group ID. | Yes |
| `file_id` | String | The file ID. | Yes |

For other parameters and detailed descriptions, see [Common parameters](#param).

#### Request header

| Parameter | Type | Description | Required |
| :------------ | :----- | :----------------------------------------------------------- | :------- |
| `Accept` | String | The parameter type. Set it as `application/json`. | Yes |
| `Authorization` | String | The authentication token of the user or administrator, in the format of `Bearer ${token}`, where `Bearer` is a fixed character, followed by an English space, and then the obtained token value. | Yes |

### HTTP response

#### Response body

If the returned HTTP status code is 200, the request succeeds, and the `data` field in the response body  contains the following parameters.

| Parameter | Type | Description |
| :------- | :------ | :----------------------------------------------------------- |
| `group_id` | String | The group ID. |
| `file_id` | String | The ID of the chat group shared file. This field is required if you want to download or remove a shared files. |
| `result` | Boolean | The result of deleting the file: <li>true: Success.</li><li>false: Failure.</li> |

For other fields and descriptions, see [Common parameters](#param).

If the returned HTTP status code is not 200, the request fails. You can refer to [Status codes](#code) for possible causes.

### Example

#### Request example

```shell
curl -X DELETE -H 'Accept: application/json' -H 'Authorization: Bearer <YourAppToken>' 'http://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files/b30e0be0-XXXX-XXXX-8732-172a3f85134f'
```

#### Response example

```json
{
    "action": "delete",
    "application": "8be024f0-XXXX-XXXX-b697-5d598d5f8402",
    "uri": "http://XXXX/XXXX/XXXX/chatgroups/66021836783617/share_files/b30e0be0-e1d4-11ea-8732-172a3f85134f",
    "entities": [],
    "data": {
        "group_id": "66021836783617",
        "file_id": "b30e0be0-XXXX-XXXX-8732-172a3f85134f",
        "result": true
    },
    "timestamp": 1599049350114,
    "duration": 0,
    "organization": "XXXX",
    "applicationName": "XXXX"
}
```

<a name="code"></a>

## Status codes

For details, see [HTTP Status Codes](./agora_chat_status_code?platform=RESTful).