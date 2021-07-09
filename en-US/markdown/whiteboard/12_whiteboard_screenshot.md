The screenshot management feature is implemented by Agora's server for the whiteboard service. You can take screenshots of a single scene or a group of scenes, generate images in PNG format, and upload them to a third-party cloud storage space.

Before calling the RESTful API for screen management, ensure that:

- You have created a third-party cloud storage account and a storage space under the account. Select one of the following third-party cloud storage service:
   - [AliCloud](https://help.aliyun.com/product/31815.html?spm=5176.7933691.J_1309819.8.2e392a66QiJZD3)
   - [Qiniu Cloud](https://www.qiniu.com/products/kodo)
   - [AWS](https://amazonaws-china.com/cn/products/storage/?nc2=h_ql_prod_st)
- You have enabled the screenshot feature and configured storage settings at Agora Console. See [Enable server-side supporting features](/cn/whiteboard/enable_whiteboard?platform=RESTful#开启互动白板配套服务).

## Screenshot a scene (POST)

Call this API to take screenshots of a single scene.

### Prototype

- Method: `POST`
- Access point: `https://api.netless.link/v5/rooms/{uuid}/screenshots`

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

### Request Body

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `width` | number | Required | The width of the screenshot in pixels. |
| `height` | number | Required | The height of the screenshot in pixels. |
| `path` | string | Optional | The path to the scene, which starts with `/`. If you do not set it, the default path `/init` is used. |

### Request example

```
POST /v5/rooms/a7e04xxxxx7d1eca69/screenshots
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWs9xxxxxxzA5ZGM2MjRi
 
{
    "width": 640,
    ç
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
    "url": "https://white-cover.oss-cn-hangzhou.aliyuncs.com/room_cover/2811/a7exxxxca69undefined.png",
    "key": "room_cover/2811/a7exxxxxca69undefined.png",
    "bucket": "white-cover",
    "region": "oss-cn-hangzhou"
}
```

**Description of parameters in the response:**

| Parameter | Data type | Description |
| :------- | :----- | :--------------------------- |
| `url` | string | The URL of the screenshot. |
| `key` | string | The filename of the screenshot in the storage space. |
| `bucket` | string | The name of the storage space where the screenshot is saved. |
| `region` | string | The region where the storage space is located. |

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.

## Screenshot a group of scenes (POST)

Call this API to take screenshots for a group of scenes.

### Prototype

- Method: `POST`
- Access point: `https://api.netless.link/v5/rooms/{uuid}/screenshot-list`

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

#### Request Body

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `width` | number | Required | The width of the screenshot in pixels. |
| `height` | number | Required | The height of the screenshot in pixels. |
| `path` | string | Required | The path to the group of scenes, which starts with `/`. If you do not set it, the current group of scenes is used. |

#### Request example

```
POST /v5/rooms/faed3130727911ebaea37759ee91947c/screenshot-list
Host: api.netless.link
token: NETLESSSDK_YWsxxxxxxYjc0
Content-Type: application/json
 
{
    "width": 640,
    "height": 480,
    "path": "/test"
}
```

#### HTTP response

For details about all possible response status codes, see the [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. The response returns the status code and corresponding parameters.

**The following is a response example for a successful request:**

```
"status": 201,
"body":
[
    {
        "url": "https://docs-test-xxx.oss-cn-hangzhou.aliyuncs.com/room_cover/2811/faxxxxx47c/test/cover.png",
        "key": "room_cover/2811/faxxxxx47c/test/cover.png",
        "bucket": "docs-test-xxx",
        "region": "oss-cn-hangzhou"
    },
    {
        "url": "https://docs-test-xxx.oss-cn-hangzhou.aliyuncs.com/room_cover/2811/faxxxxx47c/test/page1.png",
        "key": "room_cover/2811/faxxxxx47c/test/page1.png",
        "bucket": "docs-test-xxx",
        "region": "oss-cn-hangzhou"
    }
]
```

The response body is an array of the screenshot information for each scene. Every member in the array contains the following parameters:

| Parameter | Data type | Description |
| :------- | :----- | :--------------------------- |
| Parameter | Data type | Description |
| `url` | string | The URL of the screenshot. |
| `key` | string | The filename of the screenshot in the storage space. |
| `bucket` | string | The name of the storage space where the screenshot is saved. |
| `region` | string | The region where the storage space is located. |

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.