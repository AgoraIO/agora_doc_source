---
title: 生成 Token
platform: Android
updatedAt: 2021-03-31 09:01:52
---
互动白板服务使用不同类型和不同权限的 Token 对用户进行鉴权。关于互动白板的类型、权限和生成方式，详见[互动白板 Token](https://confluence.agoralab.co/pages/viewpage.action?pageId=719455830)。

本文介绍如何调用互动白板服务端 RESTful API 生成 Token。

## 生成 SDK Token （POST）

生成一个 SDK Token。

### 接口原型

- 方法：`POST`
- 接入点：`https://api.netless.link/v5/tokens/teams`

### 请求头部

在 HTTP 请求头部填入以下参数：

| 参数     | 类型   | 是否必需 | 描述                                                         |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `region` | string | 可选     | 指定处理该请求的数据中心，取值如下：<li>（默认值）`cn-hz`：中国杭州，服务区覆盖东亚、东南亚、以及其他数据中心未覆盖的地区。</li> <li>`us-sv`：美国硅谷，服务区覆盖北美洲、南美洲。详见[数据中心与全球化](https://developer.netless.link/javascript-zh/home/region-and-global)。</li> |

### 请求包体

| 参数              | 类型    | 是否必需 | 描述                                                         |
| :---------------- | :------ | :------- | :----------------------------------------------------------- |
| `accessKey`       | string  | 必需     | 访问密钥 Access Key (AK)，可在控制台的**[应用管理](https://console.netless.link/zh-CN/projects/)** > **配置** > **基本信息**页面获取。 |
| `secretAccessKey` | string  | 必需     | 私有访问密钥 Secret Access Key (SK)，可在控制台的**[应用管理](https://console.netless.link/zh-CN/projects/)** > **配置** > **基本信息**页面获取。 |
| `lifespan`        | integer | 必需     | Token 的有效时间（ms）。设为 `0` 表示永久有效。                |
| `role`            | string  | 必需     | 权限角色，取值如下：<li>`admin`</li><li>`writer`</li><li>`reader`</li>详见[权限管理](https://developer.netless.link/server-zh/home/server-introduction)。 |

### 请求示例

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

### HTTP 响应

所有可能的响应状态码详见状态码汇总表。// TODO 加链接

如果状态码为 `201`，则请求成功。响应包含返回的操作结果和生成的 `SDK Token`。

请求成功响应示例：

```
"status": 201,
"body":
{ "NETLESSROOM_YWs9xxxxxxY2E2OQ"
}
```

如果状态码不为 `201`，则请求失败。响应包体中包含 `message` 字段，描述失败的具体原因。

### 生成 Room Token（POST）

生成一个 Room Token。

#### 接口原型

- 方法：`POST`
- 接入点：`https://api.netless.link/v5/tokens/rooms/{uuid}`

#### 请求头部

该 API 需要在 HTTP 请求头部填入以下参数：

| 参数     | 类型   | 是否必需 | 描述                                                         |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token`    | string | 必需     | SDK Token，可以通过以下方式获取：登录[控制台](https://console.netless.link/zh-CN/)，点击**应用管理** > **配置 > 生成 sdkToken**。调用服务端 RESTful API， 详见[生成 SDK Token](https://confluence.agoralab.co/pages/viewpage.action?pageId=711052694#id-4.1互动白板服务端RESTfulAPI-postsdktoken)。在业务服务器上用代码生成 Token，详见开源项目 [netless-token](https://github.com/netless-io/netless-token)。 // TODO 加链接|
| `region` | string | 可选     | 指定处理该请求的数据中心，取值如下：<li>（默认值）`cn-hz`：中国杭州，服务区覆盖东亚、东南亚、以及其他数据中心未覆盖的地区。</li><li>`us-sv`：美国硅谷，服务区覆盖北美洲、南美洲。详见[数据中心与全球化](https://developer.netless.link/javascript-zh/home/region-and-global)。</li> |

#### 请求路径

该 API 需要在 URL 中传入以下参数：

| 参数 | 类型   | 是否必需 | 描述                                                         |
| :--- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | 必需     | 房间的 UUID, 即房间的全局唯一标识符，可通过调用创建房间 API 或获取房间信息 API 获取。 |

#### 请求包体

| 参数       | 类型    | 是否必需 | 描述                                                         |
| :--------- | :------ | :------- | :----------------------------------------------------------- |
| `ak`       | string  | 可选     | 访问密钥 Access Key (AK)，可在控制台的**[应用管理](https://console.netless.link/zh-CN/projects/)** > **配置** > **基本信息**页面获取。 |
| `lifespan` | integer | 必需     | Token 的有效时间（ms）。设为 `0` 表示永久有效。                |
| `role`     | string  | 必需     | 权限角色，取值如下：<li>`admin`</li><li>`writer`</li><li>`reader`</li>详见[权限管理](https://developer.netless.link/server-zh/home/server-introduction)。 |

#### 请求示例

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

#### HTTP 响应

所有可能的响应状态码详见状态码汇总表。

如果状态码为 `201`，则请求成功。响应包含返回的操作结果和生成的 Room Token。

**请求成功响应示例：**

```
"status": 201,
"body":
{ "NETLESSROOM_YWs9xxxxxxY2E2OQ"
}
```

如果状态码不为 `201`，则请求失败。响应包体中包含 `message` 字段，描述失败的具体原因。

### 生成 Task Token （POST）

生成一个 Task Token。

#### 接口原型

- 方法：`POST`
- 接入点：`https://api.netless.link/v5/tokens/tasks/{uuid}`

#### 请求头部

该 API 需要在 HTTP 请求头部填入以下参数：

| 参数     | 类型   | 是否必需 | 描述                                                         |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token`    | string | 必需     | SDK Token，可以通过以下方式获取：登录[控制台](https://console.netless.link/zh-CN/)，点击**应用管理** > **配置 > 生成 sdkToken**。调用服务端 RESTful API， 详见[生成 SDK Token](https://confluence.agoralab.co/pages/viewpage.action?pageId=711052694#id-4.1互动白板服务端RESTfulAPI-postsdktoken)。在业务服务器上用代码生成 Token，详见开源项目 [netless-token](https://github.com/netless-io/netless-token)。 // TODO 加链接|
| `region` | string | 可选     | 指定处理该请求的数据中心，取值如下：<li>（默认值）`cn-hz`：中国杭州，服务区覆盖东亚、东南亚、以及其他数据中心未覆盖的地区。</li><li>`us-sv`：美国硅谷，服务区覆盖北美洲、南美洲。详见[数据中心与全球化](https://developer.netless.link/javascript-zh/home/region-and-global)。</li> |

#### 请求路径

该 API 需要在 URL 中传入以下参数：

| 参数 | 类型   | 是否必需 | 描述                                                         |
| :--- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | 必需     | 转换任务的 UUID，即转换任务的全局唯一标识符，可通过调用发起文档转换任务 API 或查询任务进度 API 获取。 |

#### 请求包体

| 参数       | 类型    | 是否必需 | 描述                                                         |
| :--------- | :------ | :------- | :----------------------------------------------------------- |
| `ak`       | string  | 可选     | 访问密钥 Access Key (AK)，可在控制台的**[应用管理](https://console.netless.link/zh-CN/projects/)** > **配置** > **基本信息**页面获取。 |
| `lifespan` | integer | 必需     | Token 的有效时间（ms）。设为 `0` 表示永久有效。                |
| `role`     | string  | 必需     | 权限角色，取值如下：<li>`admin`</li><li>`writer`</li><li>`reader`详见[权限管理](https://developer.netless.link/server-zh/home/server-introduction)。</li> |

#### 请求示例

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

#### HTTP 响应

所有可能的响应状态码详见状态码汇总表。

如果状态码为 `201`，则请求成功。响应包含返回的操作结果和生成的 `Task Token`。

**请求成功响应示例：**

```
"status": 201,
"body":
{ "NETLESSTASK_YWxxxxxxM2ViMQ"
}
```

如果状态码不为 `201`，则请求失败。响应包体中包含 `message` 字段，描述失败的具体原因。