## 获取场景地址列表（GET）

获取指定房间的场景地址列表。

### 接口原型

- 方法：`GET`
- 接入点：`https://api.netless.link/v5/rooms/{uuid}/scenes`

### 请求头部

该 API 需要在 HTTP 请求头部填入以下参数：

| 参数     | 类型   | 是否必需 | 描述                                                         |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token`  | string | 必需     | 拥有 `writer` 或 `admin` 权限的 SDK Token 或 Room Token。</br>SDK Token 可通过以下方式获取：<li>在 Agora 控制台生成，详见[获取 SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token)。</li><li>调用服务端 RESTful API， 详见[生成 SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）)。</li><li>在 app 服务端用代码生成，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful)。</li>Room Token 可以通过以下方式获取：<li>调用服务端生成 Room Token API， 详见[生成 Room Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-room-token（post）)。</li><li>在 app 服务端用代码生成 Token，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful)。</li> |
| `region` | string | 可选     | 指定处理该请求的数据中心，取值如下：<li>（默认值）`cn-hz`：中国杭州，服务区覆盖东亚、东南亚、以及其他数据中心未覆盖的地区。</li><li>`us-sv`：美国硅谷，服务区覆盖北美洲、南美洲。</li> 详见[数据中心与全球化](https://developer.netless.link/javascript-zh/home/region-and-global)。 |

### 请求路径

该 API 需要在 URL 中传入以下参数：

| 参数   | 类型   | 是否必需 | 描述                                                         |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | 必需     | 房间的 UUID, 即房间的全局唯一标识符，可通过调用[创建房间 API](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) 或[获取房间信息 API](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）) 获取。 |

### 查询参数

该 API 可以传入以下查询参数：

| 参数       | 类型   | 是否必需 | 描述                                                         |
| :--------- | :----- | :------- | :----------------------------------------------------------- |
| `sceneDir` | string | 可选     | 场景组的路径地址，以 `/` 开头。如果填入该参数，则返回指定场景组下的场景地址列表；如果不填，则返回当前所在场景组下的场景地址列表。 |

### 请求示例

```
GET /v5/rooms/faexxxxx47c/scenes?sceneDir=/test
Host: api.netless.link
token: NETLESSSDK_YWs9T3YtxxxxxYjc0
Content-Type: application/json
```

### HTTP 响应

所有可能的响应状态码详见[状态码汇总表](/cn/whiteboard/basic_info?platform=RESTful#响应状态码)。

如果状态码为 `200`，则请求成功。响应包含返回的操作结果和数据。

**响应示例：**

```
"status": 200,
"body":
[
    "/test/cover",
    "/test/page1"
]
```

响应包体为 JSON Array，包含 String 型的场景地址。

如果状态码不为 `200`，则请求失败。响应包体中包含 `message` 字段，描述失败的具体原因。

## 插入新场景（POST）

插入新场景。

### 接口原型

- 方法：`POST`
- 接入点：`https://api.netless.link/v5/rooms/{uuid}/scenes`

### 请求头部

该 API 需要在 HTTP 请求头部填入以下参数：

| 参数     | 类型   | 是否必需 | 描述                                                         |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token`  | string | 必需     | 拥有 `write` 或 `admin` 权限的 SDK Token 或 Room Token。</br>SDK Token 可通过以下方式获取：<li>在 Agora 控制台生成，详见[获取 SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token)。</li><li>调用服务端 RESTful API， 详见[生成 SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）)。</li><li>在 app 服务端用代码生成，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful)。</li>Room Token 可以通过以下方式获取：<li>调用服务端生成 Room Token API， 详见[生成 Room Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-room-token（post）)。</li><li>在 app 服务端用代码生成 Token，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful)。</li> |
| `region` | string | 可选     | 指定处理该请求的数据中心，取值如下：<li>（默认值）`cn-hz`：中国杭州，服务区覆盖东亚、东南亚、以及其他数据中心未覆盖的地区。</li><li>`us-sv`：美国硅谷，服务区覆盖北美洲、南美洲。</li>详见[数据中心与全球化](https://developer.netless.link/javascript-zh/home/region-and-global)。 |

### 请求路径

该 API 需要在 URL 中传入以下参数：

| 参数   | 类型   | 是否必需 | 描述                                                         |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | 必需     | 房间的 UUID, 即房间的全局唯一标识符，可通过调用[创建房间 API](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) 或[获取房间信息 API](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）) 获取。 |

### 请求包体

| 参数     | 类型   | 是否必需 | 描述                                                         |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `scenes` | array  | 必需     | 由场景组成的数组，每个场景包含以下参数：<li>`name`：String 类型，场景名称，不能与所属场景组下的其他场景重名，不能包含 `/`。</li><li>`ppt`：（选填）Object 类型，场景背景图的属性。</li><li>`src`：String 类型，图片的 URL。<div class="alert note">请确保你的浏览器可以访问并支持展示该图片，否则，该图片可能无法显示在白板场景中。</div></li><li>`width`：Number 类型，图片的宽度，单位像素。</li><li>`height`：Number 类型，图片的高度，单位像素。 |
| `path`   | string | 必需     | 场景组的地址。<div class="alert note">如果传入的场景组地址已经存在，则在已有的场景组下插入指定的新场景；<br>如果传入的场景组地址不存在，则自动新建一个场景组并在该场景下插入指定的新场景。</div> |


### 请求示例

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

### HTTP 响应

所有可能的响应状态码详见[状态码汇总表](/cn/whiteboard/basic_info?platform=RESTful#响应状态码)。

如果状态码为 `201`，则请求成功。响应包含返回的操作结果和数据。

**请求成功响应示例：**

```
"status": 201,
"body":
{}
```

响应包体为 JSON object，内容为空。

如果状态码不为 `201`，则请求失败。响应包体中包含 `message` 字段，描述失败的具体原因。
	
## 	场景跳转（PATCH）

当房间内存在多个场景或场景组，可调用该 API 切换场景。

### 接口原型

- 方法：`PATCH`
- 接入点：`https://api.netless.link/v5/rooms/{uuid}/scene-state`

### 请求头部

该 API 需要在 HTTP 请求头部填入以下参数：

| 参数     | 类型   | 是否必需 | 描述                                                         |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token`  | string | 必需     | 拥有 `admin` 权限的 SDK Token 或 Room Token。</br>SDK Token 可通过以下方式获取：<li>在 Agora 控制台生成，详见[获取 SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token)。</li><li>调用服务端 RESTful API， 详见[生成 SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）)。</li><li>在 app 服务端用代码生成，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful)。</li>Room Token 可以通过以下方式获取：<li>调用服务端生成 Room Token API， 详见[生成 Room Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-room-token（post）)。</li><li>在 app 服务端用代码生成 Token，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful)。</li> |
| `region` | string | 可选     | 指定处理该请求的数据中心，取值如下：<li>（默认值）`cn-hz`：中国杭州，服务区覆盖东亚、东南亚、以及其他数据中心未覆盖的地区。</li><li>`us-sv`：美国硅谷，服务区覆盖北美洲、南美洲。</li>详见[数据中心与全球化](https://developer.netless.link/javascript-zh/home/region-and-global)。 |

### 请求路径

该 API 需要在 URL 中传入以下参数：

| 参数   | 类型   | 是否必需 | 描述                                                         |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | 必需     | 房间的 UUID, 即房间的全局唯一标识符，可通过调用[创建房间 API](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) 或[获取房间信息 API](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）) 获取。 |

### 请求包体

| 参数        | 类型   | 是否必需 | 描述                   |
| :---------- | :----- | :------- | :--------------------- |
| `scenePath` | string | 必需     | 要切换到的场景的地址。 |

### 请求示例

```
PATCH /v5/rooms/faexxxxx1947c/scene-state
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWs9TxxxxxYjc0
 
{
    "scenePath": "/test/page1"
}
```

### HTTP 响应

所有可能的响应状态码详见[状态码汇总表](/cn/whiteboard/basic_info?platform=RESTful#响应状态码)。


如果状态码为 `201`，则请求成功。响应包含返回的操作结果和数据。

**请求成功响应示例：**

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

| 参数               | 类型  | 描述                                         |
| :----------------- | :---- | :------------------------------------------- |
| `currentScenePath` | array | 当前的场景地址，由场景组和场景名组成的数组。 |

如果状态码不为 `201`，则请求失败。响应包体中包含 `message` 字段，描述失败的具体原因。