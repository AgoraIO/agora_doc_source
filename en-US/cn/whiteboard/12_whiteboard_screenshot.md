互动白板服务端可以对指定场景或指定场景组下的所有场景进行截图，生成 PNG 格式的图片并上传至你提供的第三方云存储空间中。

在调用截图管理 API 之前，请确保：

- 已开通第三方云存储账号，并创建了存储空间。 目前互动白板支持的第三方云存储包括：
   - [阿里云存储](https://help.aliyun.com/product/31815.html?spm=5176.7933691.J_1309819.8.2e392a66QiJZD3)
   - [七牛云存储](https://www.qiniu.com/products/kodo)
   - [AWS 云存储](https://amazonaws-china.com/cn/products/storage/?nc2=h_ql_prod_st)
- 已在 Agora 控制台开启截图服务，并添加了存储配置。 [Enable server-side supporting features](/cn/whiteboard/enable_whiteboard?platform=RESTful#开启互动白板配套服务)

## 生成场景截图（POST）

Take a screenshot of a specific scene

### Prototype

- Method: `POST`
- 接入点：`https://api.netless.link/v5/rooms/{uuid}/screenshots`

### Request header

Pass in the following parameters in the request header:

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | 拥有 `write` 或 `admin` 权限的 SDK Token 或 Room Token。 </br>The SDK Token, which can be obtained through one of the following ways:<li>Go to Agora Console. See [Get a SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See [Generate a SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See [Generate a Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li>The SDK Token, which can be obtained through one of the following ways:<li>调用服务端生成 Room Token API， 详见[生成 Room Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-room-token（post）)。</li><li>Use code. See Generate a Token[ from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li> For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Path

The following parameters are required in the URL:

| Parameter | Data type | Required/Optional | Description |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | Required | The Room UUID, which is the unique identifier of a room. You can get it by [calling the RESTful API to create a room](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) or [calling the RESTful API to get room information](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）). |

### Request Body

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `width` | number | Required | 获取截图的宽度，单位为像素。 |
| `height` | number | Required | 获取截图的高度，单位为像素。 |
| `path` | string | Optional | 需要截图的场景路径，以 `/` 开头。 如果不传，默认获取 `/init` 场景的截图。 |

### Request example

```
POST /v5/rooms/a7e04xxxxx7d1eca69/screenshots
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWs9xxxxxxzA5ZGM2MjRi
 
{
    "width": 640,
    "height": 480
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
    "url": "https://white-cover.oss-cn-hangzhou.aliyuncs.com/room_cover/2811/a7exxxxca69undefined.png",
    "key": "room_cover/2811/a7exxxxxca69undefined.png",
    "bucket": "white-cover",
    "region": "oss-cn-hangzhou"
}
```

**响应包体参数：**

| Parameter | Data type | Description |
| :------- | :----- | :--------------------------- |
| `url` | string | 截图的 URL。 |
| `key` | string | 截图在存储空间内的文件名。 |
| `bucket` | string | 截图存放的存储空间名称。 |
| `region` | string | 截图存放的存储空间所属地域。 |

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.

## 生成场景截图列表（POST）

Take screenshots for a group of scenes

### Prototype

- Method: `POST`
- 接入点：`https://api.netless.link/v5/rooms/{uuid}/screenshot-list`

### Request header

Pass in the following parameters in the request header:

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | 拥有 `write` 或 `admin` 权限的 SDK Token 或 Room Token。 </br>The SDK Token, which can be obtained through one of the following ways:<li>Go to Agora Console. See [Get a SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See [Generate a SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See [Generate a Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li>The SDK Token, which can be obtained through one of the following ways:<li>调用服务端生成 Room Token API， 详见[生成 Room Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-room-token（post）)。</li><li>Use code. See Generate a Token[ from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li>For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Path

The following parameters are required in the URL:

| Parameter | Data type | Required/Optional | Description |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | Required | The Room UUID, which is the unique identifier of a room. You can get it by [calling the RESTful API to create a room](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) or [calling the RESTful API to get room information](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）). |

#### Request Body

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `width` | number | Required | 截图的宽度，单位为像素。 |
| `height` | number | Required | 截图的高度，单位为像素。 |
| `path` | string | Required | 场景组的路径地址，以 `/` 开头。 如果不传，则对当前所在场景组进行截图。 |

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

For details about all possible response status codes, see [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. 响应包含返回的操作结果和数据。

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

响应包体为由场景截图信息组成的数组，每条场景信息包含以下参数：

| Parameter | Data type | Description |
| :------- | :----- | :--------------------------- |
| Parameter | Data type | Description |
| `url` | string | 截图的 URL。 |
| `key` | string | 截图在存储空间内的文件名。 |
| `bucket` | string | 截图存放的存储空间名称。 |
| `region` | string | 截图存放的存储空间所属地域。 |

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.