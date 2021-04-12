## 创建房间（POST）

创建一个实时互动房间。

### Prototype

- Method: `POST`
- Access point: `https://api.netless.link/v5/tokens/teams`

### Request header

Pass in the following parameters in the request header:

| Parameter | Category | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | The SDK Token, which can be obtained through one of the following ways:<li>Go to Agora Console. See[ Get a SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See[ Generate a SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See Generate a[ Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li> For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Body

| Parameter | Category | Required/Optional | Description |
| :--------- | :------ | :------- | :----------------------------------------------------------- |
| `name` | string | Optional | 房间名，不能超过 2048 字节。 |
| `isRecord` | boolean | Optional | 是否开启录制：<li>`true`: (Default) Enables deep-learning noise reduction.</li><li>`false`: do not test.</li> |
| `limit` | integer | Optional | 房间内可写人数（拥有 `writer` 或 `admin` 权限的用户）的上限。 如果传 `0`，则表示无限制。 目前推荐设置为 `0`。 |

### Request example

```
POST /v5/rooms
Host: api.netless.link
token: NETLESSSDK_YWs9xxxxxxZGM2MjRi
Content-Type: application/json
```

### HTTP response

For details about all possible response status codes, see [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. 响应包含返回的操作结果和数据。

**The following is a response example for a successful request:**

```
"status": 201,
"body":
{
    "uuid": "4a5xxxxx6b",
    "name": "",
    "teamUUID": "RMxxxxx5aw",
    "appUUID": "i54xxxxx1AQ",
    "isRecord": true,
    "isBan": false,
    "createdAt": "2021-01-18T06:56:29.432Z",
    "limit": 0
}
```

**响应包体参数：**

| Parameter | Category | Description |
| :---------- | :------ | :----------------------------------------------------------- |
| `uuid` | string | 房间的 UUID，即房间的全局唯一标识符。 |
| `name` | string | 房间名。 |
| `teamUUID` | string | 互动白板控制台账号的唯一标识符。 |
| `appUUID` | string | 互动白板项目的唯一标识符。 |
| `isRecord` | boolean | 房间是否开启录制：<li>`true`: Enable the super-resolution algorithm.<li>`false`: do not test. |
| `isBan` | boolean | 房间是否被封禁：<li>`true`：已封禁。<li>`false`: 未封禁。 |
| `createdAt` | string | 创建房间的 UTC 时间。 |
| `limit` | integer | 房间内可写人数（拥有 `writer` 或 `admin` 权限的用户）的上限。 如果值为 `0`，则表示无限制。 |

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.

## 获取房间信息（GET）

获取指定房间的信息。

### Prototype

- Method: GET
- Access point: `https://api.netless.link/v5/tokens/rooms/{uuid}`

### Request header

Pass in the following parameters in the request header:

| Parameter | Category | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | 拥有 `writer` 或 `admin` 权限的 SDK Token 或 Room Token。 </br>The SDK Token, which can be obtained through one of the following ways:<li>Go to Agora Console. See[ Get a SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See[ Generate a SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See Generate a[ Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li>The SDK Token, which can be obtained through one of the following ways:<li>调用服务端生成 Room Token API， 详见[生成 Room Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-room-token（post）)。</li><li>Use code. See Generate a Token[ from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America. 。</li>For details, see [Data center and globalization.](https://developer.netless.link/javascript-zh/home/region-and-global) |

### Request Path

The following parameters are required in the URL:

| Parameter | Category | Required/Optional | Description |
| :------ | :----- | :------- | :----------------------------------------------------------- |
| ` uuid` | string | Required | The Room UUID, which is the unique identifier of a room. You can get it by calling the[ RESTful API to create a room](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) or[ calling the RESTful API to get room information](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）). |

### Request example

```
GET /v5/rooms/a7exxxxxxa69
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWs9xxxxxxM2MjRi
```

### HTTP response

For details about all possible response status codes, see [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. 响应包含返回的操作结果和数据。

**The following is a response example for a successful request:**

```
"status": 200,
"body":
{
    "uuid": "4axxxxx96b",
    "name": "",
    "teamUUID": "RMmxxxxx5aw",
    "appUUID": "i5xxxxx1AQ",
    "isRecord": true,
    "isBan": false,
    "createdAt": "2021-01-18T06:56:29.432Z",
    "limit": 0
}
```

**响应包体参数：**

| Parameter | Category | Description |
| :---------- | :------ | :----------------------------------------------------------- |
| `uuid` | string | 房间的 UUID，即房间的全局唯一标识符。 |
| `name` | string | 房间名。 |
| `teamUUID` | string | 互动白板控制台账号的唯一标识符。 |
| `appUUID` | string | 互动白板项目的唯一标识符。 |
| `isRecord` | boolean | 房间是否开启录制：<li> `true`: Enable the super-resolution algorithm.<li>`false`: Disable transcoding. |
| `isBan` | boolean | 房间是否被封禁：<li>`true`：已封禁。<li>`false`: 未封禁。 |
| `createdAt` | string | 创建房间的 UTC 时间。 |
| `limit` | integer | 房间内可写人数（拥有 `writer` 或 `admin` 权限的用户）的上限。 如果值为 0，则表示无限制。 |

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.

## 获取房间列表（GET）

Get a list of rooms

### Prototype

- Method: `GET`
- Access point: `https://api.netless.link/v5/tokens/teams`

### Request header

Pass in the following parameters in the request header:

| Parameter | Category | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | 拥有 `writer` 或 `admin` 权限的 SDK Token，可通过以下方式获取：<li>Go to Agora Console. See[ Get a SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See[ Generate a SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See Generate a[ Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li> For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### 查询参数

该 API 可以传入以下查询参数：

| Parameter | Category | Required/Optional | Description |
| :---------- | :------ | :------- | :----------------------------------------------------------- |
| `beginUUID` | string | Optional | 查询的起始房间的 UUID。 |
| `limit` | integer | Optional | 返回的房间列表的最大长度，取值范围为 (0,1000]。 如果不填，则最多返回 100 条房间信息。 |

### Request example

```
GET /v5/rooms/?beginUUID=0e6exxxxxx4d95&limit=2
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWs9QlxxxxxxM2MjRi

```

### HTTP response

For details about all possible response status codes, see [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. 响应包含返回的操作结果和数据。

**The following is a response example for a successful request:**

```
"status": 200,
"body":
[
    {
        "uuid": "0e6exxxxxxd95",
        "name": "",
        "teamUUID": "RMmxxxxxxaw",
        "appUUID": "vVxxxxzJF-A",
        "isRecord": true,
        "isBan": false,
        "createdAt": "2020-12-20T14:02:54.846Z",
        "limit": 0
    },
    {
        "uuid": "1d4xxxxxxca69",
        "name": "",
        "teamUUID": "RMmxxxxxx5aw",
        "appUUID": "vVsxxxxzJF-A",
        "isRecord": true,
        "isBan": false,
        "createdAt": "2020-12-20T14:10:29.265Z",
        "limit": 0
    }
]
```

**响应包体参数：**

| Parameter | Category | Description |
| :---------- | :------ | :----------------------------------------------------------- |
| `uuid` | string | 房间的 UUID，即房间的全局唯一标识符。 |
| `name` | string | 房间名。 |
| `teamUUID` | string | 互动白板控制台账号的唯一标识符。 |
| `appUUID` | string | 互动白板项目的唯一标识符。 |
| `isRecord` | boolean | 房间是否开启录制：<li>`true`: Enable the super-resolution algorithm.</li><li>`false`: Disable transcoding.</li> |
| `isBan` | boolean | 房间是否被封禁：<li>`true`：已封禁。</li><li>`false`: 未封禁。 </li> |
| `createdAt` | string | 创建房间的 UTC 时间。 |
| `limit` | integer | 房间内可写人数（拥有 `writer` 或 `admin` 权限的用户）上限。 如果值为 `0`，表示无限制。 |

If the status code is not 201, the request fails. The response body includes a `message` field that describes the reason for the failure.

## 封禁房间 （PATCH）

封禁或取消封禁指定的房间。

房间被封禁后，互动白板服务会移除房间内的用户并禁止新用户加入该房间。

你可以再次调用该 API，并在请求包体中将 `isBan` 设为 `false`，取消对房间的封禁。

### Prototype

- 方法：`PATCH`
- Access point: `https://api.netless.link/v5/tokens/rooms/{uuid}`

### Request header

Pass in the following parameters in the request header:

| Parameter | Category | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | 拥有 `admin` 权限的 SDK Token 或 Room Token。 </br>The SDK Token, which can be obtained through one of the following ways:<li>Go to Agora Console. See[ Get a SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See[ Generate a SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See Generate a[ Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li>The SDK Token, which can be obtained through one of the following ways:<li>调用服务端生成 Room Token API， 详见[生成 Room Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-room-token（post）)。</li><li>Use code. See Generate a Token[ from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li>For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Path

The following parameters are required in the URL:

| Parameter | Category | Required/Optional | Description |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | Required | The Room UUID, which is the unique identifier of a room. You can get it by calling the[ RESTful API to create a room](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) or[ calling the RESTful API to get room information](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）). |

### Request Body

| Parameter | Category | Required/Optional | Description |
| :------ | :------ | :------- | :----------------------------------------------------------- |
| `isBan` | boolean | Required | 是否封禁房间：<li>`true`：封禁。</li> <li>`false`: （默认值）不封禁。</li> |

### Request example

```
PATCH /v5/rooms/0e6exxxxxx4d95
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWs9xxxxxx5ZGM2MjRi
 
{
  "isBan": true
}
```

### HTTP response

For details about all possible response status codes, see [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. 响应包含返回的操作结果和数据。

**The following is a response example for a successful request:**

```
"status": 201,
"body":
{
    "uuid": "0e6xxxxxx95",
    "name": "",
    "teamUUID": "RMxxxxxaw",
    "appUUID": "vVxxxxxJF-A",
    "isRecord": true,
    "isBan": true,
    "createdAt": "2020-12-20T14:02:54.846Z",
    "limit": 0
}
```

**响应包体参数：**

| Parameter | Category | Description |
| :---------- | :------ | :----------------------------------------------------------- |
| Parameter | Category | Description |
| `uuid` | string | 房间的 UUID，即房间的全局唯一标识符。 |
| `name` | string | 房间名。 |
| `teamUUID` | string | 互动白板控制台账号的唯一标识符。 |
| `appUUID` | string | 互动白板项目的唯一标识符。 |
| `isRecord` | boolean | 房间是否开启录制：<li>`true`: Enable the super-resolution algorithm.</li><li>`false`: do not test.</li> |
| `isBan` | boolean | 房间是否被封禁：<li>`true`：已封禁。</li><li>`false`: 未封禁。    </li> |
| `createdAt` | string | 创建房间的 UTC 时间。 |
| `limit` | integer | 房间内可写人数（拥有 `writer` 或 `admin` 权限的用户）的上限。 如果值为 `0`，则表示无限制。 |

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.