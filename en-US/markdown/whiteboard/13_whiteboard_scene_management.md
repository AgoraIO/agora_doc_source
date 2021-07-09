## Get scene address list (GET)

Call this API to get a list of scene addresses in a room

### Prototype

- Method: `GET`
- Access point: `https://api.netless.link/v5/rooms/{uuid}/scenes`

### Request header

Pass in the following parameters in the request header:

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | A `writer` or `admin` SDK Token or Room Token. </br>To get a SDK Token, you can:<li>Use Agora Console. See [Get an SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See [Generate an SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See [Generate a token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li>To get a Room Token, you can:<li>Call the RESTful API. See [Generate a Room Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-room-token（post）).</li><li>Write code on your app server. See [Generate a Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li> For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Path

The following parameters are required in the URL:

| Parameter | Data type | Required/Optional | Description |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | Required | The Room UUID, which is the unique identifier of a room. You can get it by [calling the RESTful API to create a room](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) or [calling the RESTful API to get room information](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）). |

### Query Parameters

You can choose to pass in the following query parameters:

| Parameter | Data type | Required/Optional | Description |
| :--------- | :----- | :------- | :----------------------------------------------------------- |
| `sceneDir` | string | Optional | The path to the group of scenes, which starts with `/`. If you pass in this parameter, the scene address list of the specified group is generated. If you do not pass in, the scene address list of the current group is generated. |

### Request example

```
GET /v5/rooms/faexxxxx47c/scenes?sceneDir=/test
Host: api.netless.link
token: NETLESSSDK_YWs9T3YtxxxxxYjc0
Content-Type: application/json
```

### HTTP response

For details about all possible response status codes, see the [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `200`, the request is successful. The response returns the status code and corresponding parameters.

**Response example**

```
"status": 200,
"body":
[
    "/test/cover",
    "/test/page1"
]
```

The response body is a JSON Array of scene address strings.

If the status code is not `200`, the request fails. The response body includes a `message` field that describes the reason for the failure.

## Add a scene (POST)

Call this API to add a scene.

### Prototype

- Method: `POST`
- Access point: `https://api.netless.link/v5/rooms/{uuid}/scenes`

### Request header

Pass in the following parameters in the request header:

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | A `writer` or `admin` SDK Token or Room Token. </br>To get a SDK Token, you can:<li>Use Agora Console. See [Get an SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See [Generate an SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See [Generate a token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li>To get a Room Token, you can:<li>Call the RESTful API. See [Generate a Room Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-room-token（post）).</li><li>Write code on your app server. See [Generate a Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li>For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Path

The following parameters are required in the URL:

| Parameter | Data type | Required/Optional | Description |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | Required | The Room UUID, which is the unique identifier of a room. You can get it by [calling the RESTful API to create a room](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) or [calling the RESTful API to get room information](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）). |

### Request Body

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `scenes` | array | Required | An array of scenes, each containing the following parameters:<li>`name`: String. Sets the scene name. It cannot be the same as another scene in the same group and cannot contain `/`.</li><li>`ppt`: (Optional) Object. Sets the property of the background image of the scene.</li><li>`src`: String. Sets the URL of the image.<div class="alert note">Ensure that your browser can access and display the image properly. Otherwise, the image may not be displayed in the scene.</div></li><li>`width`: Number. Sets the width of the image in pixels.</li><li>`height`: Number. Sets the height of the image in pixels. |
| `path` | string | Required | The address of a scene group.<div class="alert note">If the address already exists, the new scene is added to the corresponding scene group; If not, a new scene group is created and the new scene is added to the group.<br></div> |


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

For details about all possible response status codes, see the [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. The response returns the status code and corresponding parameters.

**The following is a response example for a successful request:**

```
"status": 201,
"body":
{}
```

The response body is an empty JSON object.

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.

## Switch to a scene (PATCH)

Call this API to switch scenes when there is multiple scenes or scene groups in the room.

### Prototype

- Method: `PATCH`
- Access point: `https://api.netless.link/v5/rooms/{uuid}/scene-state`

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
| :---------- | :----- | :------- | :--------------------- |
| `scenePath` | string | Required | The address of the scene you want to switch to. |

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

For details about all possible response status codes, see the [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).


If the status code is `201`, the request is successful. The response returns the status code and corresponding parameters.

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

**Description of parameters in the response:**

| Parameter | Data type | Description |
| :----------------- | :---- | :------------------------------------------- |
| `currentScenePath` | array | The address of the current scene, which is an array consisting of the scene name and the corresponding scene group name. |

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.