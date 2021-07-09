## Create a room (POST)

Refer to the following information to create a live room:

### Prototype

- Method: `POST`
- Access point: `https://api.netless.link/v5/rooms`

### Request header

Pass in the following parameters in the request header:

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | The SDK Token, which can be obtained through one of the following methods:<li>Use Agora Console. See [Get an SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See [Generate an SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See [Generate a token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li> For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Body

| Parameter | Data type | Required/Optional | Description |
| :--------- | :------ | :------- | :----------------------------------------------------------- |
| `name` | string | Optional | The room name, which cannot be longer than 2048 bytes. |
| `isRecord` | boolean | Optional | Whether to enable recording for the room:<li>`true`: (Default) Enable.</li><li>`false`: Not enable.</li> |
| `limit` | integer | Optional | The limit on the number of users with a `writer` or `admin` Token. If you set it to `0`, there is no limit. Agora recommends setting it to `0`. |

### Request example

```
POST /v5/rooms
Host: api.netless.link
token: NETLESSSDK_YWs9xxxxxxZGM2MjRi
Content-Type: application/json
```

### HTTP response

For details about all possible response status codes, see the [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. The response returns the status code and corresponding parameters.

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

**Description of parameters in the response:**

| Parameter | Data type | Description |
| :---------- | :------ | :----------------------------------------------------------- |
| `uuid` | string | The Room UUID, which is the unique identifier of a room. |
| `name` | string | The room name. |
| `teamUUID` | string | The unique identifier of the Agora Console account that creates the whiteboard project. |
| `appUUID` | string | The unique identifier of the whiteboard project. |
| `isRecord` | boolean | Whether recording is enabled for the room:<li>`true`: Enabled.<li>`false`: Not enable. |
| `isBan` | boolean | Whether the room is disabled:<li>`true`: Disabled.<li>`false`: Not disabled. |
| `createdAt` | string | The UTC time when the room is created. |
| `limit` | integer | The limit on the number of users with a `writer` or `admin` Token. If you set it to `0`, there is no limit. |

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.

## Get room information (GET)

Refer to the following information to get information about a room:

### Prototype

- Method: GET
- Access point: `https://api.netless.link/v5/rooms/{uuid}`

### Request header

Pass in the following parameters in the request header:

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | A `writer` or `admin` SDK Token or Room Token. </br>To get a SDK Token, you can:<li>Use Agora Console. See [Get an SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See [Generate an SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See [Generate a token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li>To get a Room Token, you can:<li>Call the RESTful API. See [Generate a Room Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-room-token（post）).</li><li>Write code on your app server. See [Generate a Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.  </li>For details, see [Data center and globalization.](https://developer.netless.link/javascript-zh/home/region-and-global) |

### Request Path

The following parameters are required in the URL:

| Parameter | Data type | Required/Optional | Description |
| :------ | :----- | :------- | :----------------------------------------------------------- |
| ` uuid` | string | Required | The Room UUID, which is the unique identifier of a room. You can get it by [calling the RESTful API to create a room](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) or [calling the RESTful API to get room information](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）). |

### Request example

```
GET /v5/rooms/a7exxxxxxa69
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWs9xxxxxxM2MjRi
```

### HTTP response

For details about all possible response status codes, see the [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `200`, the request is successful. The response returns the status code and corresponding parameters.

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

**Description of parameters in the response:**

| Parameter | Data type | Description |
| :---------- | :------ | :----------------------------------------------------------- |
| `uuid` | string | The Room UUID, which is the unique identifier of a room. |
| `name` | string | The room name. |
| `teamUUID` | string | The unique identifier of the Agora Console account that creates the whiteboard project. |
| `appUUID` | string | The unique identifier of the whiteboard project. |
| `isRecord` | boolean | Whether recording is enabled for the room:<li> `true`: Enabled.<li>`false`: Not enable. |
| `isBan` | boolean | Whether the room is disabled:<li>`true`: Disabled.<li>`false`: Not disabled. |
| `createdAt` | string | The UTC time when the room is created. |
| `limit` | integer | The limit on the number of users with a `writer` or `admin` Token. If you set it to 0, there is no limit. |

If the status code is not `200`, the request fails. The response body includes a `message` field that describes the reason for the failure.

## Get a room list (GET)

Refer to the following information to get a list of rooms:

### Prototype

- Method: `GET`
- Access point: `https://api.netless.link/v5/rooms`

### Request header

Pass in the following parameters in the request header:

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | A `writer` or `admin` SDK Token. To get one, you can:<li>Use Agora Console. See [Get an SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See [Generate an SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See [Generate a token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li> For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Query Parameters

You can choose to pass in the following query parameters:

| Parameter | Data type | Required/Optional | Description |
| :---------- | :------ | :------- | :----------------------------------------------------------- |
| `beginUUID` | string | Optional | The UUID of the room you want to start querying from. |
| `limit` | integer | Optional | The maximum number of rooms on the list. The range is (0,1000]. If you do not set it, the list contains a maximum of 100 rooms. |

### Request example

```
GET /v5/rooms/?beginUUID=0e6exxxxxx4d95&limit=2
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWs9QlxxxxxxM2MjRi
```

### HTTP response

For details about all possible response status codes, see the [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `200`, the request is successful. The response returns the status code and corresponding parameters.

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

**Description of parameters in the response:**

| Parameter | Data type | Description |
| :---------- | :------ | :----------------------------------------------------------- |
| `uuid` | string | The Room UUID, which is the unique identifier of a room. |
| `name` | string | The room name. |
| `teamUUID` | string | The unique identifier of the Agora Console account that creates the whiteboard project. |
| `appUUID` | string | The unique identifier of the whiteboard project. |
| `isRecord` | boolean | Whether recording is enabled for the room:<li>`true`: Enabled.</li><li>`false`: Not enable.</li> |
| `isBan` | boolean | Whether the room is disabled:<li>`true`: Disabled.</li><li>`false`: Not disabled.</li> |
| `createdAt` | string | The UTC time when the room is created. |
| `limit` | integer | The limit on the number of users with a `writer` or `admin` Token. If you set it to 0, there is no limit.`` |

If the status code is not 200, the request fails. The response body includes a message field that describes the reason for the failure.``

## Disable a room (PATCH)

Refer to the following information to disable or cancel disabling a room.

Note that when you disable a room, the users in the room will be removed out and no user can join the room again.

If you want to cancel disabling the room, call the RESTful API again and set `isBan` to `false`.

### Prototype

- Method: `PATCH`
- Access point: `https://api.netless.link/v5/rooms/{uuid}`

### Request header

Pass in the following parameters in the request header:

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | An `admin` SDK Token or Room Token. </br>To get a SDK Token, you can:<li>Use Agora Console. See [Get an SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See [Generate an SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See [Generate a token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li>To get a Room Token, you can:<li>Call the RESTful API. See [Generate a Room Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-room-token（post）).</li><li>Write code on your app server. See [Generate a Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li>For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Path

The following parameters are required in the URL:

| Parameter | Data type | Required/Optional | Description |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | Required | The Room UUID, which is the unique identifier of a room. You can get it by [calling the RESTful API to create a room](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) or [calling the RESTful API to get room information](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）). |

### Request Body

| Parameter | Data type | Required/Optional | Description |
| :------ | :------ | :------- | :----------------------------------------------------------- |
| `isBan` | boolean | Required | Whether to disable the room:<li>`true`: Disable.</li> <li>`false`: (Default) Not disable.</li> |

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

For details about all possible response status codes, see the [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. The response returns the status code and corresponding parameters.

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

**Description of parameters in the response:**

| Parameter | Data type | Description |
| :---------- | :------ | :----------------------------------------------------------- |
| Parameter | Data type | Description |
| `uuid` | string | The Room UUID, which is the unique identifier of a room. |
| `name` | string | The room name. |
| `teamUUID` | string | The unique identifier of the Agora Console account that creates the whiteboard project. |
| `appUUID` | string | The unique identifier of the whiteboard project. |
| `isRecord` | boolean | Whether recording is enabled for the room:<li>`true`: Enabled.</li><li>`false`: Not enable.</li> |
| `isBan` | boolean | Whether the room is disabled:<li>`true`: Disabled.</li><li>`false`: Not disabled.</li> |
| `createdAt` | string | The UTC time when the room is created. |
| `limit` | integer | The limit on the number of users with a `writer` or `admin` Token. If you set it to `0`, there is no limit. |

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.