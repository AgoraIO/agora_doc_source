Agora Interactive Whiteboard use different types of tokens for user authentication. For details, see [Token overview](/cn/whiteboard/whiteboard_token_overview).

This article introduces how to call the interactive whiteboard RESTful API to generate tokens.

## Generate an SDK Token (POST)

Call this API to generate an SDK Token:

### Prototype

- Method: `POST`
- Access point: `https://api.netless.link/v5/tokens/teams`

### Request header

Pass in the following parameters in the request header:

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li> <li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li> For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Body

| Parameter | Data type | Required/Optional | Description |
| :---------------- | :------ | :------- | :----------------------------------------------------------- |
| `accessKey` | string | Required | The Access Key (AK), which can be obtained in Agora Console. See [Get an access key pair](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-ak-和-sk). |
| `secretAccessKey` | string | Required | The Secret Key (SK), which can be obtained in Agora Console. See [Get AK and SK](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-ak-和-sk). |
| `lifespan` | integer | Required | Token 的有效时间（ms）。 设为 `0` 表示永久有效。 |
| `role` | string | Required | The token role:<li>`admin`</li><li>`writer`</li><li>`reader`</li>See [Introduction](/cn/whiteboard/whiteboard_token_overview?platform=RESTful#token-类型与权限). |

### Request example

```
POST /v5/tokens/teams
Host: api.netless.link
Content-Type: application/json
 
{
    "accessKey": "BUxxxxxxrc",
    "secretAccessKey": "CxxxxxxxauY3",
    "lifespan": 600,
    "role": "admin"
}
```

### HTTP response

For details about all possible response status codes, see the [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. The response returns the generated `SDK Token`.

The following is a response example for a successful request:

```
"status": 201,
"body":
{ "NETLESSROOM_YWs9xxxxxxY2E2OQ"
}
```

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.

## Generate a Room Token (POST)

Call this API to generate a Room Token:

### Prototype

- Method: `POST`
- Access point: `https://api.netless.link/v5/tokens/rooms/{uuid}`

### Request header

Pass in the following parameters in the request header:

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | The SDK Token, which can be obtained through one of the following methods:<li>Use Agora Console. See [Get an SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See [Generate an SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See [Generate a token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li>For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Path

The following parameters are required in the URL:

| Parameter | Data type | Required/Optional | Description |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | Required | The Room UUID, which is the unique identifier of a room. You can get it by [calling the RESTful API to create a room](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) or [calling the RESTful API to get room information](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）). |

### Request Body

| Parameter | Data type | Required/Optional | Description |
| :--------- | :------ | :------- | :----------------------------------------------------------- |
| `ak` | string | Optional | The Access Key (AK), which can be obtained in Agora Console. See [Get an access key pair](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-ak-和-sk). |
| `lifespan` | integer | Required | Token 的有效时间（ms）。 设为 `0` 表示永久有效。 |
| `role` | string | Required | The token role:<li>`admin`</li><li>`writer`</li><li>`reader`</li>See [Introduction](/cn/whiteboard/whiteboard_token_overview?platform=RESTful#token-类型与权限). |

### Request example

```
POST /v5/tokens/rooms/a7exxxxxca69
Host: api.netless.link
token: NETLESSSDK_YWs9Qxxxxxx2MjRi
Content-Type: application/json
 
{
    "lifespan": 600,
    "role": "admin"
}
```

### HTTP response

For details about all possible response status codes, see the [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. The response returns the generated `Room Token`.

**The following is a response example for a successful request:**

```
"status": 201,
"body":
{ "NETLESSROOM_YWs9xxxxxxY2E2OQ"
}
```

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.

## Generate a Task Token (POST)

Call this API to generate a Task Token:

### Prototype

- Method: `POST`
- Access point: `https://api.netless.link/v5/tokens/tasks/{uuid}`

### Request header

Pass in the following parameters in the request header:

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | The SDK Token, which can be obtained through one of the following methods:<li>Use Agora Console. See [Get an SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See [Generate an SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See [Generate a token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li>For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Path

The following parameters are required in the URL:

| Parameter | Data type | Required/Optional | Description |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | Required | The Task UUID, which is the unique identifier of a file-conversion task. You can get it by [calling the RESTful API to start a file-conversion task](/cn/whiteboard/whiteboard_file_conversion?platform=RESTful#发起文档转换（post）) or [calling the RESTful API to query the task progress](/cn/whiteboard/whiteboard_file_conversion?platform=RESTful#查询转换任务的进度（get）). |

### Request Body

| Parameter | Data type | Required/Optional | Description |
| :--------- | :------ | :------- | :----------------------------------------------------------- |
| `ak` | string | Optional | The Access Key (AK), which can be obtained in Agora Console. See [Get an access key pair](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-ak-和-sk). |
| `lifespan` | integer | Required | Token 的有效时间（ms）。 设为 `0` 表示永久有效。 |
| `role` | string | Required | The token role:<li>`admin`</li><li>`writer`</li><li>`reader`</li>See [Introduction](/cn/whiteboard/whiteboard_token_overview?platform=RESTful#token-类型与权限). |

### Request example

```
POST /v5/tokens/tasks/a7e0xxxxxxxca69
Host: api.netless.link
token: NETLESSSDK_YWs9QlxxxxxxM2MjRi
Content-Type: application/json
 
{
    "lifespan": 600,
    "role": "admin"
}
```

### HTTP response

For details about all possible response status codes, see the [status code table.](/cn/whiteboard/basic_info?platform=RESTful#响应状态码)

If the status code is `201`, the request is successful. The response returns the generated `Task Token`.

**The following is a response example for a successful request:**

```
"status": 201,
"body":
{ "NETLESSTASK_YWxxxxxxM2ViMQ"
}
```

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.