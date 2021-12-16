---
title: 文档转换
platform: Android
updatedAt: 2021-04-01 03:14:39
---
Agora 互动白板提供文档转换服务，支持将 PPT、PPTX、Word、PDF 等格式的文件转换成静态图片或动态 HTML 网页，转换后的图片或网页可作为演示资料在互动白板中展示。详见[文档转换服务](/cn/whiteboard/file_conversion_overview?platform=RESTful)。

<div class="alert note">调用文档转换 API 前，请确保：
<ul>
	<li>已在 [Agora 控制台](https://console.agora.io/)开启<b>文档转图片</b>或<b>文档转网页</b>服务并添加存储配置。详见<a href="https://docs.agora.io/cn/whiteboard/enable_whiteboard?platform=RESTful#%E5%BC%80%E5%90%AF%E4%BA%92%E5%8A%A8%E7%99%BD%E6%9D%BF%E9%85%8D%E5%A5%97%E6%9C%8D%E5%8A%A1">开启互动白板配套服务</a >。</li>
	<li>已为待转换的文档生成一个公网可访问的 URL 地址。</li></ul></div>

## 发起文档转换（POST）

发起一个文档转换任务。

### 接口原型

- 方法：`POST`
- 接入点：`https://api.netless.link/v5/services/conversion/tasks`

### 请求头部

该 API 需要在 HTTP 请求头部填入以下参数：

| 参数     | 类型   | 是否必需 | 描述                                                         |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token`    | string | 必需     | 拥有 `write` 或 `admin` 权限的 SDK Token，可通过以下方式获取：<li>在 Agora 控制台生成，详见[获取 SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token)。</li><li>调用服务端 RESTful API， 详见[生成 SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）)。</li><li>在 app 服务端用代码生成，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful)。</li> |
| `region` | string | 可选     | 指定处理该请求的数据中心，取值如下：<li>（默认值）`cn-hz`：中国杭州，服务区覆盖东亚、东南亚、以及其他数据中心未覆盖的地区。</li><li>`us-sv`：美国硅谷，服务区覆盖北美洲、南美洲。</li> 详见[数据中心与全球化](https://developer.netless.link/javascript-zh/home/region-and-global)。|

### 请求包体

该 API 需要在请求包体中传入以下参数：

| 参数           | 类型    | 是否必需 | 描述                                                         |
| :------------- | :------ | :------- | :----------------------------------------------------------- |
| `resource`     | string  | 必需     | 待转换的源文件 URL。 |
| `type`         | string  | 必需     | 转换任务类型，取值如下：<li>`dynamic`：动态文档转换，即文档转网页。</li><li>`static`：静态文档转换，即文档转图片。</li> |
| `preview`      | boolean | 可选     | 是否需要生成预览图：<li>`true`：是。</li><li>`false`：否。</li><div class="alert note">该参数仅在 `type` 设为 `dynamic` 时生效。生成预览图耗时较长，请谨慎选择。</div> |
| `scale`        | number  | 可选     | 图片缩放比例，取值范围 [0.1,3.0]，默认值为 `1.2`。数值越大，图片越清晰。<div class="alert note">该参数仅在 `type` 设为 `static` 时生效。</div> |
| `outputFormat` | string  | 可选     | 输出图片格式，取值如下：<li><code>png</code></li><li><code>jpg</code> 或 <code>jpeg</code></li><li><code>webp</code></li>默认值为 <code>png</code>  <div class="alert note">该参数仅在 `type` 设为 `static` 时生效。</div> |

### 请求示例

```
POST /v5/services/conversion/tasks
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWs9QxxxxxxMjRi
 
{
    "resource": "https://docs-test-xx.oss-cn-hangzhou.aliyuncs.com/xxx",
    "type": "static",
    "preview": true,
    "scale": 1,
    "outputFormat": "jpg"
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
    "uuid": "2fd2dxxxxx367e",
    "type": "static",
    "status": "Waiting"
}
```

**响应包体参数：**

| 参数     | 类型   | 描述                                                         |
| :------- | :----- | :----------------------------------------------------------- |
| `uuid`   | string | 转换任务的 UUID，即转换任务的唯一标识符。                    |
| `type`   | string | 转换任务类型，取值如下：<li>`dynamic`：动态文档转换，即文档转网页。</li><li>`static`：静态文档转换，即文档转图片。</li> |
| `status` | string | 转换任务的状态：<li>`Waiting`：等待转换。</li><li>`Converting`：转换中。</li><li>`Finished`：已完成。</li><li>`Fail`：失败。</li> |

如果状态码不为 `201`，则请求失败。响应包体中包含 `message` 字段，描述失败的具体原因。

## 查询转换任务的进度（GET）

查询文档转换任务的进度。

### 接口原型

- 方法：`GET`
- 接入点：`https://api.netless.link/v5/services/conversion/tasks/{uuid}`

### 请求头部

该 API 需要在 HTTP 请求头部填入以下参数：

| 参数     | 类型   | 是否必需 | 描述                                                         |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token`    | string | 必需     | Task Token，可通过以下方式获取：<li>调用服务端生成 SDK Token API， 详见[生成 Task Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-task-token-（post）)。<li>在 app 服务端用代码生成 Token，详见[在 app 服务端生成 Token](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful)。 |
| `region` | string | 可选     | 指定处理该请求的数据中心，取值如下：<li>（默认值）`cn-hz`：中国杭州，服务区覆盖东亚、东南亚、以及其他数据中心未覆盖的地区。</li><li>`us-sv`：美国硅谷，服务区覆盖北美洲、南美洲。</li>详见[数据中心与全球化](https://developer.netless.link/javascript-zh/home/region-and-global)。 |

### 请求路径

该 API 需要在 URL 中传入以下参数：

| 参数   | 类型   | 是否必需 | 描述                                                         |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | 必需     | 转换任务的 UUID, 即转换任务的唯一标识符，可通过调用发起转换任务 API 获取。 |

### 查询参数

该 API 需要传入以下查询参数：

| 参数   | 类型   | 是否必需 | 描述                                                         |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `type` | string | 必需     | 转换任务类型，取值如下：<li>`dynamic`：动态文档转换，即文档转网页。</li><li>`static`：静态文档转换，即文档转图片</li> |

### 请求示例

```
GET /v5/services/conversion/tasks/2fxxxxxx367e?type=static
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWsxxxxxM2MjRi
```

### HTTP 响应

所有可能的响应状态码详见状态码汇总表。

如果状态码为 `200`，则请求成功。响应包含返回的操作结果和数据。

**请求成功响应示例：**

```
"status": 200,
"body":
{
    "uuid": "2fdxxxx7e",
    "type": "static",
    "status": "Finished",
    "progress": {
        "totalPageSize": 2,
        "convertedPageSize": 2,
        "convertedPercentage": 100,
        "convertedFileList": [
            {
                "width": 1333,
                "height": 750,
                "conversionFileUrl": "https://docs-test-xxx.oss-cn-hangzhou.aliyuncs.com/staticConvert/2fdxxxxx67e/1.jpeg"
            },
            {
                "width": 1333,
                "height": 750,
                "conversionFileUrl": "https://docs-test-xxx.oss-cn-hangzhou.aliyuncs.com/staticConvert/2fdxxxxx67e/2.jpeg"
            }
        ]
    }
}
```

**响应包体参数：**

| 参数           | 类型   | 描述                                                         |
| :------------- | :----- | :----------------------------------------------------------- |
| `uuid`         | string | 转换任务的 UUID，转换任务的唯一标识符。                      |
| `type`         | string | 转换任务类型，取值如下：<li>`dynamic`：动态文档转换，即文档转网页。</li><li>`static`：静态文档转换，即文档转图片。</li> |
| `status`       | string | 转换任务的状态：<li>`Waiting`：等待中。</li><li>`Converting`：转换中。</li><li>`Finished`：已完成。</li><li>`Fail`：失败。</li> |
| `failedReason` | string | 转换任务失败的原因。只有当 `status` 为 `Fail` 时，才会返回该字段。 |
| `progress`     | object | 转换任务的进度，包括以下字段：<li>`totalPageSize`：Number 类型，转换文档总页数。</li><li>`convertedPageSize`：Number 类型，已经完成转换的页数。</li><li>`convertedPercentage`：Number 类型，转换进度百分比。</li><li>`convertedFileList`：Array 类型，已完成转换的图片列表，每个图片包含以下参数：<ul><li>`width`：Number 类型，图片宽度，单位为像素。</subli><li>`height`：Number 类型，图片高度，单位为像素。</li><li>`conversionFileUrl`：String 类型，转换图片的 URL。</li><li>`preview`: String 类型，预览图地址。当发起转换时请求包体中 `preview` 设为 `true` 且 `type` 为 `dynamic` 时，才会返回该字段。</li></ul></li><li>`currentStep`：String 类型，动态转换任务当前的步骤，返回值包括：<ul><li> `Extracting`：提取资源。</li><li>`Packaging`：打包资源。</li><li>`GeneratingPreview`：生成预览图。</li><li>`MediaTranscode`：媒体转码。</li></ul></li> 当发起转换时请求包体中 `type` 为 `dynamic` 时，才会返回 `currentStep` 字段。 |

如果状态码不为 `200`，则请求失败。响应包体中包含 `message` 字段，描述失败的具体原因。