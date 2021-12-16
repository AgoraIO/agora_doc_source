---
title: 截图管理
platform: Android
updatedAt: 2021-03-31 09:02:03
---
互动白板服务端可以对指定场景或指定场景组下的所有场景进行截图，生成 PNG 格式的图片并上传至你提供的第三方云存储空间中。

在调用截图管理 API 之前，请确保：

- 已开通第三方云存储账号，并创建了存储空间。目前互动白板支持的第三方云存储包括：
  - [阿里云存储](https://help.aliyun.com/product/31815.html?spm=5176.7933691.J_1309819.8.2e392a66QiJZD3)
  - [七牛云存储](https://www.qiniu.com/products/kodo)
  - [AWS 云存储](https://amazonaws-china.com/cn/products/storage/?nc2=h_ql_prod_st)
- 已在 Agora 控制台开启截图服务，并添加了存储配置。详见[开启互动白板配套服务](/cn/whiteboard/enable_whiteboard?platform=RESTful#开启互动白板配套服务)。

## 生成场景截图（POST）

对指定场景进行截图。

### 接口原型

- 方法：`POST`
- 接入点：`https://api.netless.link/v5/rooms/{uuid}/screenshots`

### 请求头部

该 API 需要在 HTTP 请求头部填入以下参数：

| 参数     | 类型   | 是否必需 | 描述                                                         |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token`    | string | 必需     | 拥有 `write` 或 `admin` 权限的 SDK Token 或 Room Token。</br>SDK Token 可通过以下方式获取：<li>在 Agora 控制台生成，详见[获取 SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token)。</li><li>调用服务端 RESTful API， 详见[生成 SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）)。</li><li>在 app 服务端用代码生成，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful)。</li>Room Token 可以通过以下方式获取：<li>调用服务端生成 Room Token API， 详见[生成 Room Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-room-token（post）)。</li><li>在 app 服务端用代码生成 Token，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful)。</li>  |
| `region` | string | 可选     | 指定处理该请求的数据中心，取值如下：<li>（默认值）`cn-hz`：中国杭州，服务区覆盖东亚、东南亚、以及其他数据中心未覆盖的地区。</li><li>`us-sv`：美国硅谷，服务区覆盖北美洲、南美洲。</li> 详见[数据中心与全球化](https://developer.netless.link/javascript-zh/home/region-and-global)。|

### 请求路径

该 API 需要在 URL 中传入以下参数：

| 参数   | 类型   | 是否必需 | 描述                                                         |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | 必需     | 房间的 UUID, 即房间的全局唯一标识符，可通过调用[创建房间 API](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) 或[获取房间信息 API](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）) 获取。 |

### 请求包体

| 参数     | 类型   | 是否必需 | 描述                                                         |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `width`  | number | 必需     | 获取截图的宽度，单位为像素。                                 |
| `height` | number | 必需     | 获取截图的高度，单位为像素。                                 |
| `path`   | string | 可选     | 需要截图的场景路径，以 `/` 开头。如果不传，默认获取 `/init` 场景的截图。 |

### 请求示例

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

### HTTP 响应

所有可能的响应状态码详见[状态码汇总表](/cn/whiteboard/basic_info?platform=RESTful#响应状态码)。

如果状态码为 `201`，则请求成功。响应包含返回的操作结果和数据。

**请求成功响应示例：**

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

| 参数     | 类型   | 描述                         |
| :------- | :----- | :--------------------------- |
| `url`    | string | 截图的 URL。                 |
| `key`    | string | 截图在存储空间内的文件名。   |
| `bucket` | string | 截图存放的存储空间名称。     |
| `region` | string | 截图存放的存储空间所属地域。 |

如果状态码不为 `201`，则请求失败。响应包体中包含 `message` 字段，描述失败的具体原因。

## 生成场景截图列表（POST）

对指定场景组下的所有场景进行截图。

### 接口原型

- 方法：`POST`
- 接入点：`https://api.netless.link/v5/rooms/{uuid}/screenshot-list`

### 请求头部

该 API 需要在 HTTP 请求头部填入以下参数：

| 参数     | 类型   | 是否必需 | 描述                                                         |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token`    | string | 必需     | 拥有 `write` 或 `admin` 权限的 SDK Token 或 Room Token。</br>SDK Token 可通过以下方式获取：<li>在 Agora 控制台生成，详见[获取 SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token)。</li><li>调用服务端 RESTful API， 详见[生成 SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）)。</li><li>在 app 服务端用代码生成，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful)。</li>Room Token 可以通过以下方式获取：<li>调用服务端生成 Room Token API， 详见[生成 Room Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-room-token（post）)。</li><li>在 app 服务端用代码生成 Token，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful)。</li>  |
| `region` | string | 可选     | 指定处理该请求的数据中心，取值如下：<li>（默认值）`cn-hz`：中国杭州，服务区覆盖东亚、东南亚、以及其他数据中心未覆盖的地区。</li><li>`us-sv`：美国硅谷，服务区覆盖北美洲、南美洲。</li>详见[数据中心与全球化](https://developer.netless.link/javascript-zh/home/region-and-global)。 |

### 请求路径

该 API 需要在 URL 中传入以下参数：

| 参数   | 类型   | 是否必需 | 描述                                                         |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | 必需     | 房间的 UUID, 即房间的全局唯一标识符，可通过调用[创建房间 API](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) 或[获取房间信息 API](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）) 获取。 |

#### 请求包体

| 参数     | 类型   | 是否必需 | 描述                                                         |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `width`  | number | 必需     | 截图的宽度，单位为像素。                                     |
| `height` | number | 必需     | 截图的高度，单位为像素。                                     |
| `path`   | string | 必需     | 场景组的路径地址，以 `/` 开头。如果不传，则对当前所在场景组进行截图。 |

#### 请求示例

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

#### HTTP 响应

所有可能的响应状态码详见[状态码汇总表](/cn/whiteboard/basic_info?platform=RESTful#响应状态码)。

如果状态码为 `201`，则请求成功。响应包含返回的操作结果和数据。

**请求成功响应示例：**

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

| 参数     | 类型   | 描述                         |
| :------- | :----- | :--------------------------- |
| 参数     | 类型   | 描述                         |
| `url`    | string | 截图的 URL。                 |
| `key`    | string | 截图在存储空间内的文件名。   |
| `bucket` | string | 截图存放的存储空间名称。     |
| `region` | string | 截图存放的存储空间所属地域。 |

如果状态码不为 `201`，则请求失败。响应包体中包含 `message` 字段，描述失败的具体原因。