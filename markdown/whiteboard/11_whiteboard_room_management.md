## 创建房间（POST）

创建一个实时互动房间。

### 接口原型

- 方法：`POST`
- 接入点：`https://api.netless.link/v5/rooms`

### 请求头部

该 API 需要在 HTTP 请求头部填入以下参数：

| 参数     | 类型   | 是否必需 | 描述                                                         |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token`  | string | 必需     | SDK Token，可以通过以下方式获取：<li>在 Agora 控制台生成，详见[获取 SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token)。</li><li>调用服务端 RESTful API， 详见[生成 SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）)。</li><li>在 app 服务端用代码生成，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful)。</li> |
| `region` | string | 可选     | 指定处理该请求的数据中心，取值如下：<li>（默认值）`cn-hz`：中国杭州，服务区覆盖东亚、东南亚、以及其他数据中心未覆盖的地区。</li><li>`us-sv`：美国硅谷，服务区覆盖北美洲、南美洲。</li> 详见[数据中心与全球化](https://developer.netless.link/javascript-zh/home/region-and-global)。 |

### 请求包体

| 参数       | 类型    | 是否必需 | 描述                                                         |
| :--------- | :------ | :------- | :----------------------------------------------------------- |
| `name`     | string  | 可选     | 房间名，不能超过 2048 字节。                                 |
| `isRecord` | boolean | 可选     | 是否开启录制：<li>`true`：（默认值）开启。</li><li>`false`: 不开启。</li> |
| `limit`    | integer | 可选     | 房间内可写人数（拥有 `writer` 或 `admin` 权限的用户）的上限。如果传 `0`，则表示无限制。目前推荐设置为 `0`。 |

### 请求示例

```
POST /v5/rooms
Host: api.netless.link
token: NETLESSSDK_YWs9xxxxxxZGM2MjRi
Content-Type: application/json
```

### HTTP 响应

所有可能的响应状态码详见[状态码汇总表](/cn/whiteboard/basic_info?platform=RESTful#响应状态码)。

如果状态码为 `201`，则请求成功。响应包含返回的操作结果和数据。

**请求成功响应示例：**

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

| 参数        | 类型    | 描述                                                         |
| :---------- | :------ | :----------------------------------------------------------- |
| `uuid`      | string  | 房间的 UUID，即房间的全局唯一标识符。                        |
| `name`      | string  | 房间名。                                                     |
| `teamUUID`  | string  | 互动白板控制台账号的唯一标识符。                             |
| `appUUID`   | string  | 互动白板项目的唯一标识符。                                   |
| `isRecord`  | boolean | 房间是否开启录制：<li>`true`：开启。<li>`false`: 不开启。    |
| `isBan`     | boolean | 房间是否被封禁：<li>`true`：已封禁。<li>`false`: 未封禁。    |
| `createdAt` | string  | 创建房间的 UTC 时间。                                        |
| `limit`     | integer | 房间内可写人数（拥有 `writer` 或 `admin` 权限的用户）的上限。如果值为 `0`，则表示无限制。 |

如果状态码不为 `201`，则请求失败。响应包体中包含 `message` 字段，描述失败的具体原因。

## 获取房间信息（GET）

获取指定房间的信息。

### 接口原型

- 方法：GET
- 接入点：`https://api.netless.link/v5/rooms/{uuid}`

### 请求头部

该 API 需要在 HTTP 请求头部填入以下参数：

| 参数     | 类型   | 是否必需 | 描述                                                         |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token`  | string | 必需     | 拥有 `writer` 或 `admin` 权限的 SDK Token 或 Room Token。</br>SDK Token 可通过以下方式获取：<li>在 Agora 控制台生成，详见[获取 SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token)。</li><li>调用服务端 RESTful API， 详见[生成 SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）)。</li><li>在 app 服务端用代码生成，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful)。</li>Room Token 可以通过以下方式获取：<li>调用服务端生成 Room Token API， 详见[生成 Room Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-room-token（post）)。</li><li>在 app 服务端用代码生成 Token，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful)。</li> |
| `region` | string | 可选     | 指定处理该请求的数据中心，取值如下：<li>（默认值）`cn-hz`：中国杭州，服务区覆盖东亚、东南亚、以及其他数据中心未覆盖的地区。</li><li>`us-sv`：美国硅谷，服务区覆盖北美洲、南美洲。。</li>详见[数据中心与全球化](https://developer.netless.link/javascript-zh/home/region-and-global) |

### 请求路径

该 API 需要在 URL 中传入以下参数：

| 参数    | 类型   | 是否必需 | 描述                                                         |
| :------ | :----- | :------- | :----------------------------------------------------------- |
| ` uuid` | string | 必需     | 房间的 UUID, 即房间的全局唯一标识符，可通过调用[创建房间 API](/cn/whiteboard/whiteboard_room_management?platform=RESTful#创建房间（post）) 或[获取房间信息 API](/cn/whiteboard/whiteboard_room_management?platform=RESTful#获取房间信息（get）) 获取。 |

### 请求示例

```
GET /v5/rooms/a7exxxxxxa69
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWs9xxxxxxM2MjRi
```

### HTTP 响应

所有可能的响应状态码详见[状态码汇总表](/cn/whiteboard/basic_info?platform=RESTful#响应状态码)。

如果状态码为 `200`，则请求成功。响应包含返回的操作结果和数据。

**请求成功响应示例：**

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

| 参数        | 类型    | 描述                                                         |
| :---------- | :------ | :----------------------------------------------------------- |
| `uuid`      | string  | 房间的 UUID，即房间的全局唯一标识符。                        |
| `name`      | string  | 房间名。                                                     |
| `teamUUID`  | string  | 互动白板控制台账号的唯一标识符。                             |
| `appUUID`   | string  | 互动白板项目的唯一标识符。                                   |
| `isRecord`  | boolean | 房间是否开启录制：<li> `true`：开启。<li>`false`: 不开启。   |
| `isBan`     | boolean | 房间是否被封禁：<li>`true`：已封禁。<li>`false`: 未封禁。    |
| `createdAt` | string  | 创建房间的 UTC 时间。                                        |
| `limit`     | integer | 房间内可写人数（拥有 `writer` 或 `admin` 权限的用户）的上限。如果值为 0，则表示无限制。 |

如果状态码不为 `200`，则请求失败。响应包体中包含 `message` 字段，描述失败的具体原因。

## 获取房间列表（GET）

获取房间列表。

### 接口原型

- 方法：`GET`
- 接入点：`https://api.netless.link/v5/rooms`

### 请求头部

该 API 需要在 HTTP 请求头部填入以下参数：

| 参数     | 类型   | 是否必需 | 描述                                                         |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token`  | string | 必需     | 拥有 `writer` 或 `admin` 权限的 SDK Token，可通过以下方式获取：<li>在 Agora 控制台生成，详见[获取 SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token)。</li><li>调用服务端 RESTful API， 详见[生成 SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）)。</li><li>在 app 服务端用代码生成，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful)。</li> |
| `region` | string | 可选     | 指定处理该请求的数据中心，取值如下：<li>（默认值）`cn-hz`：中国杭州，服务区覆盖东亚、东南亚、以及其他数据中心未覆盖的地区。</li><li>`us-sv`：美国硅谷，服务区覆盖北美洲、南美洲。</li> 详见[数据中心与全球化](https://developer.netless.link/javascript-zh/home/region-and-global)。 |

### 查询参数

该 API 可以传入以下查询参数：

| 参数        | 类型    | 是否必需 | 描述                                                         |
| :---------- | :------ | :------- | :----------------------------------------------------------- |
| `beginUUID` | string  | 可选     | 查询的起始房间的 UUID。                                      |
| `limit`     | integer | 可选     | 返回的房间列表的最大长度，取值范围为 (0,1000]。如果不填，则最多返回 100 条房间信息。 |

### 请求示例

```

GET /v5/rooms/?beginUUID=0e6exxxxxx4d95&limit=2
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWs9QlxxxxxxM2MjRi
```

### HTTP 响应

所有可能的响应状态码详见[状态码汇总表](/cn/whiteboard/basic_info?platform=RESTful#响应状态码)。

如果状态码为 `200`，则请求成功。响应包含返回的操作结果和数据。

**请求成功响应示例：**

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

| 参数        | 类型    | 描述                                                         |
| :---------- | :------ | :----------------------------------------------------------- |
| `uuid`      | string  | 房间的 UUID，即房间的全局唯一标识符。                        |
| `name`      | string  | 房间名。                                                     |
| `teamUUID`  | string  | 互动白板控制台账号的唯一标识符。                             |
| `appUUID`   | string  | 互动白板项目的唯一标识符。                                   |
| `isRecord`  | boolean | 房间是否开启录制：<li>`true`：开启。</li><li>`false`: 不开启。 </li> |
| `isBan`     | boolean | 房间是否被封禁：<li>`true`：已封禁。</li><li>`false`: 未封禁。 </li> |
| `createdAt` | string  | 创建房间的 UTC 时间。                                        |
| `limit`     | integer | 房间内可写人数（拥有 `writer` 或 `admin` 权限的用户）上限。如果值为 `0`，表示无限制。 |

如果状态码不为 200，则请求失败。响应包体中包含 `message` 字段，描述失败的具体原因。

## 封禁房间 （PATCH）

封禁或取消封禁指定的房间。

房间被封禁后，互动白板服务会移除房间内的用户并禁止新用户加入该房间。

你可以再次调用该 API，并在请求包体中将 `isBan` 设为 `false`，取消对房间的封禁。

### 接口原型

- 方法：`PATCH`
- 接入点：`https://api.netless.link/v5/rooms/{uuid}`

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

| 参数    | 类型    | 是否必需 | 描述                                                         |
| :------ | :------ | :------- | :----------------------------------------------------------- |
| `isBan` | boolean | 必需     | 是否封禁房间：<li>`true`：封禁。</li> <li>`false`: （默认值）不封禁。</li> |

### 请求示例

```
PATCH /v5/rooms/0e6exxxxxx4d95
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWs9xxxxxx5ZGM2MjRi
 
{
  "isBan": true
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

| 参数        | 类型    | 描述                                                         |
| :---------- | :------ | :----------------------------------------------------------- |
| 参数        | 类型    | 描述                                                         |
| `uuid`      | string  | 房间的 UUID，即房间的全局唯一标识符。                        |
| `name`      | string  | 房间名。                                                     |
| `teamUUID`  | string  | 互动白板控制台账号的唯一标识符。                             |
| `appUUID`   | string  | 互动白板项目的唯一标识符。                                   |
| `isRecord`  | boolean | 房间是否开启录制：<li>`true`：开启。</li><li>`false`: 不开启。  </li> |
| `isBan`     | boolean | 房间是否被封禁：<li>`true`：已封禁。</li><li>`false`: 未封禁。    </li> |
| `createdAt` | string  | 创建房间的 UTC 时间。                                        |
| `limit`     | integer | 房间内可写人数（拥有 `writer` 或 `admin` 权限的用户）的上限。如果值为 `0`，则表示无限制。 |

如果状态码不为 `201`，则请求失败。响应包体中包含 `message` 字段，描述失败的具体原因。