互动白板服务使用不同类型和不同权限的 Token 对用户进行鉴权。 关于互动白板的类型、权限和生成方式，详见[互动白板 Token 概述](/cn/whiteboard/whiteboard_token_overview)。

本文介绍如何调用互动白板服务端 RESTful API 生成 Token。

## 生成 SDK Token （POST）

生成一个 SDK Token。

### Prototype

- Method: `POST`
- 接入点：`https://api.netless.link/v5/tokens/teams`

### Request header

在 HTTP 请求头部填入以下参数：

| Parameter | Category | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li> <li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li> For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Body

| Parameter | Category | Required/Optional | Description |
| :---------------- | :------ | :------- | :----------------------------------------------------------- |
| `accessKey` | string | Required | 访问密钥 Access Key (AK)，可在 Agora 控制台获取，详见[获取 AK 和 SK](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-ak-和-sk)。 |
| `secretAccessKey` | string | Required | 私有访问密钥 Secret Access Key (SK)，可在 Agora 控制台获取，详见[获取 AK 和 SK](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-ak-和-sk)。 |
| `lifespan` | integer | Required | Token 的有效时间（ms）。 设为 `0` 表示永久有效。 |
| `role` | string | Required | 权限角色，取值如下：<li>`admin`</li><li>`writer`</li><li>`reader`</li>详见 [Token 的类型与权限](/cn/whiteboard/whiteboard_token_overview?platform=RESTful#token-类型与权限)。 |

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

For details about all possible response status codes, see [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. 响应包含返回的操作结果和生成的 `SDK Token`。

请求成功响应示例：

```
"status": 201,
"body":
{ "NETLESSROOM_YWs9xxxxxxY2E2OQ"
}
```

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.

## 生成 Room Token（POST）

生成一个 Room Token。

### Prototype

- Method: `POST`
- 接入点：`https://api.netless.link/v5/tokens/rooms/{uuid}`

### Request header

Pass in the following parameters in the request header:

| Parameter | Category | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | The SDK Token, which can be obtained through one of the following ways:<li>Go to Agora Console. See[ Get a SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See[ Generate a SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See Generate a[ Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li>For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Path

The following parameters are required in the URL:

| Parameter | Category | Required/Optional | Description |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | Required | The Room UUID, which is the unique identifier of a room. You can get it by calling the[ RESTful API to create a room](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) or[ calling the RESTful API to get room information](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）). |

### Request Body

| Parameter | Category | Required/Optional | Description |
| :--------- | :------ | :------- | :----------------------------------------------------------- |
| `ak` | string | Optional | 访问密钥 Access Key (AK)，可在 Agora 控制台获取，详见[获取 AK 和 SK](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-ak-和-sk)。 |
| `lifespan` | integer | Required | Token 的有效时间（ms）。 设为 `0` 表示永久有效。 |
| `role` | string | Required | 权限角色，取值如下：<li>`admin`</li><li>`writer`</li><li>`reader`</li>详见 [Token 的类型与权限](/cn/whiteboard/whiteboard_token_overview?platform=RESTful#token-类型与权限)。 |

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

For details about all possible response status codes, see [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. 响应包含返回的操作结果和生成的 `Room Token`。

**The following is a response example for a successful request:**

```
"status": 201,
"body":
{ "NETLESSROOM_YWs9xxxxxxY2E2OQ"
}
```

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.

## 生成 Task Token （POST）

生成一个 Task Token。

### Prototype

- Method: `POST`
- 接入点：`https://api.netless.link/v5/tokens/tasks/{uuid}`

### Request header

Pass in the following parameters in the request header:

| Parameter | Category | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | The SDK Token, which can be obtained through one of the following ways:<li>Go to Agora Console. See[ Get a SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See[ Generate a SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See Generate a[ Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li>For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Path

The following parameters are required in the URL:

| Parameter | Category | Required/Optional | Description |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | Required | 转换任务的 UUID，即转换任务的全局唯一标识符，可通过调用[发起文档转换任务 API](/cn/whiteboard/whiteboard_file_conversion?platform=RESTful#发起文档转换（post）) 或[查询任务进度 API](/cn/whiteboard/whiteboard_file_conversion?platform=RESTful#查询转换任务的进度（get）) 获取。 |

### Request Body

| Parameter | Category | Required/Optional | Description |
| :--------- | :------ | :------- | :----------------------------------------------------------- |
| `ak` | string | Optional | 访问密钥 Access Key (AK)，可在 Agora 控制台获取，详见[获取 AK 和 SK](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-ak-和-sk)。 |
| `lifespan` | integer | Required | Token 的有效时间（ms）。 设为 `0` 表示永久有效。 |
| `role` | string | Required | 权限角色，取值如下：<li>`admin`</li><li>`writer`</li><li>`reader`</li>详见 [Token 的类型与权限](/cn/whiteboard/whiteboard_token_overview?platform=RESTful#token-类型与权限)。 |

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

所有可能的响应状态码详见[状态码汇总表](/cn/whiteboard/basic_info?platform=RESTful#响应状态码)

If the status code is `201`, the request is successful. 响应包含返回的操作结果和生成的 `Task Token`。

**The following is a response example for a successful request:**

```
"status": 201,
"body":
{ "NETLESSTASK_YWxxxxxxM2ViMQ"
}
```

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.