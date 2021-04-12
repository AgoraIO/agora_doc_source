## 获取场景地址列表（GET）

Get a list of scene addresses in the room

### Prototype

- Method: `GET`
- Access point: `https://api.netless.link/v5/tokens/rooms/{uuid}`

### Request header

Pass in the following parameters in the request header:

| Parameter | Category | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | 拥有 `writer` 或 `admin` 权限的 SDK Token 或 Room Token。 </br>The SDK Token, which can be obtained through one of the following ways:<li>Go to Agora Console. See[ Get a SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See[ Generate a SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See Generate a[ Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li>The SDK Token, which can be obtained through one of the following ways:<li>调用服务端生成 Room Token API， 详见[生成 Room Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-room-token（post）)。</li><li>Use code. See Generate a Token[ from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li> For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Path

The following parameters are required in the URL:

| Parameter | Category | Required/Optional | Description |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | Required | The Room UUID, which is the unique identifier of a room. You can get it by calling the[ RESTful API to create a room](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) or[ calling the RESTful API to get room information](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）). |

### 查询参数

该 API 可以传入以下查询参数：

| Parameter | Category | Required/Optional | Description |
| :--------- | :----- | :------- | :----------------------------------------------------------- |
| `sceneDir` | string | Optional | 场景组的路径地址，以 `/` 开头。 如果填入该参数，则返回指定场景组下的场景地址列表；如果不填，则返回当前所在场景组下的场景地址列表。 |

### Request example

```
GET /v5/rooms/faexxxxx47c/scenes?sceneDir=/test
Host: api.netless.link
token: NETLESSSDK_YWs9T3YtxxxxxYjc0
Content-Type: application/json
```

### HTTP response

For details about all possible response status codes, see [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. 响应包含返回的操作结果和数据。

**Response example**

```
"status": 200,
"body":
[
    "/test/cover",
    "/test/page1"
]
```

响应包体为 JSON Array，包含 String 型的场景地址。

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.

## 插入新场景（POST）

Add a scene

### Prototype

- Method: `POST`
- Access point: `https://api.netless.link/v5/tokens/rooms/{uuid}`

### Request header

Pass in the following parameters in the request header:

| Parameter | Category | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | 拥有 `write` 或 `admin` 权限的 SDK Token 或 Room Token。 </br>The SDK Token, which can be obtained through one of the following ways:<li>Go to Agora Console. See[ Get a SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See[ Generate a SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See Generate a[ Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li>The SDK Token, which can be obtained through one of the following ways:<li>调用服务端生成 Room Token API， 详见[生成 Room Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-room-token（post）)。</li><li>Use code. See Generate a Token[ from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li>For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Path

The following parameters are required in the URL:

| Parameter | Category | Required/Optional | Description |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | Required | The Room UUID, which is the unique identifier of a room. You can get it by calling the[ RESTful API to create a room](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) or[ calling the RESTful API to get room information](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）). |

### Request Body

| Parameter | Category | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `scenes` |    array(
 | Required | 由场景组成的数组，每个场景包含以下参数：<li>`name`：String 类型，场景名称，不能与所属场景组下的其他场景重名，不能包含 `/`。</li><li>`ppt`：（选填）Object 类型，场景背景图的属性。</li><li>`src`：String 类型，图片的 URL。<div class="alert note">请确保你的浏览器可以访问并支持展示该图片，否则，该图片可能无法显示在白板场景中。</div></li><li>`width`：Number 类型，图片的宽度，单位像素。</li><li>`height`：Number 类型，图片的高度，单位像素。 |
| `path` | string | Required | 场景组的地址。<div class="alert note">如果传入的场景组地址已经存在，则在已有的场景组下插入指定的新场景；<br>如果传入的场景组地址不存在，则自动新建一个场景组并在该场景下插入指定的新场景。</div> |


### Request example

```
POST /v5/rooms/a7e0xxxxxa69/scenes
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWs9QlxxxxxA0NzA5ZGM2MjRi
 
{
    "scenes": [
        {
            "name": "page1",
            "ppt": {
                "src": "xxxx",
                "width": 640,
                "height": 360
            }
        },
        {
            "name": "page2",
            "ppt": {
                "src": "xxxx",
                "width": 640,
                "height": 360
            }
        }
    ],
    "path": "/test"
}
```

### HTTP response

For details about all possible response status codes, see [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. 响应包含返回的操作结果和数据。

**The following is a response example for a successful request:**

```
"status": 201,
"body":
{}
```

响应包体为 JSON object，内容为空。

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.

## 场景跳转（PATCH）

当房间内存在多个场景或场景组，可调用该 API 切换场景。

### Prototype

- 方法：`PATCH`
- 接入点：`https://api.netless.link/v5/rooms/{uuid}/scene-state`

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
| :---------- | :----- | :------- | :--------------------- |
| `scenePath` | string | Required | 要切换到的场景的地址。 |

### Request example

```
PATCH /v5/rooms/faexxxxx1947c/scene-state
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWs9TxxxxxYjc0
 
{
    "scenePath": "/test/page1"
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
    "currentScenePath": [
        "test",
        "page1"
    ]
}
```

**响应包体参数：**

| Parameter | Category | Description |
| :----------------- | :---- | :------------------------------------------- |
| `currentScenePath` |    array(
 | 当前的场景地址，由场景组和场景名组成的数组。 |

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.