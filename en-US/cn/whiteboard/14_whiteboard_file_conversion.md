The file conversion feature provided by Agora Interactive Whiteboard allows for converting PPT, PPTX, DOC, DOCX, PDF, and other files into static images, and PPTX files into dynamic HTML web pages. The generated images and web pages can be presented on the whiteboard. 详见[文档转换服务](/cn/whiteboard/file_conversion_overview?platform=RESTful)。

<div class="alert note">调用文档转换 API 前，请确保：
<ul>
	<li>已在 <a href="https://console.agora.io/">Agora 控制台</a >开启<b>文档转图片</b>或<b>文档转网页</b>服务并添加存储配置。 <a href="https://docs.agora.io/cn/whiteboard/enable_whiteboard?platform=RESTful#%E5%BC%80%E5%90%AF%E4%BA%92%E5%8A%A8%E7%99%BD%E6%9D%BF%E9%85%8D%E5%A5%97%E6%9C%8D%E5%8A%A1">Enable server-side supporting features</a ></li>
	<li>已为待转换的文档生成一个公网可访问的 URL 地址。</li></ul></div>

## 发起文档转换（POST）

Start a file-conversion task

### Prototype

- Method: `POST`
- 接入点：`https://api.netless.link/v5/services/conversion/tasks`

### Request header

Pass in the following parameters in the request header:

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | 拥有 `write` 或 `admin` 权限的 SDK Token，可通过以下方式获取：<li>Go to Agora Console. See [Get a SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See [Generate a SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See [Generate a Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li> For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Body

The following parameters are required in the URL.

| Parameter | Data type | Required/Optional | Description |
| :------------- | :------ | :------- | :----------------------------------------------------------- |
| `resource` | string | Required | 待转换的源文件 URL。 |
| `type` | string | Required | 转换任务类型，取值如下：<li>`dynamic`：动态文档转换，即文档转网页。</li><li>`static`：静态文档转换，即文档转图片。</li> |
| `preview` | boolean | Optional | 是否需要生成预览图：<li>`true`: Rotate.</li><li>`false`：否。</li><div class="alert note">该参数仅在 `type` 设为 `dynamic` 时生效。 生成预览图耗时较长，请谨慎选择。</div> |
| `scale` | number | Optional | 图片缩放比例，取值范围 [0.1,3.0]，默认值为 `1.2`。 数值越大，图片越清晰。<div class="alert note">该参数仅在 `type` 设为 `static` 时生效。</div> |
| `outputFormat` | string | Optional | 输出图片格式，取值如下：<li><code>png</code></li><li><code>jpg</code> 或 <code>jpeg</code></li><li><code>webp</code></li>默认值为 <code>png</code>  <div class="alert note">该参数仅在 `type` 设为 `static` 时生效。</div> |

### Request example

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

### HTTP response

For details about all possible response status codes, see [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. 响应包含返回的操作结果和数据。

**The following is a response example for a successful request:**

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

| Parameter | Data type | Description |
| :------- | :----- | :----------------------------------------------------------- |
| `uuid` | string | 转换任务的 UUID，即转换任务的唯一标识符。 |
| `type` | string | 转换任务类型，取值如下：<li>`dynamic`：动态文档转换，即文档转网页。</li><li>`static`：静态文档转换，即文档转图片。</li> |
| `status` | string | 转换任务的状态：<li>`Waiting`：等待转换。</li><li>`Converting`：转换中。</li><li>`Finished`：已完成。</li><li>`Fail`：失败。</li> |

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.

## 查询转换任务的进度（GET）

Query the progress of the file-conversion task

### Prototype

- Method: `GET`
- Access point: `https://api.netless.link/v5/tokens/tasks/{uuid}`

### Request header

Pass in the following parameters in the request header:

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | The SDK Token, which can be obtained through one of the following ways:<li>调用服务端生成 SDK Token API， 详见[生成 Task Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-task-token-（post）)。<li>Use code. See Generate a Token[ from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful). |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li>For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Path

The following parameters are required in the URL:

| Parameter | Data type | Required/Optional | Description |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | Required | 转换任务的 UUID, 即转换任务的唯一标识符，可通过调用发起转换任务 API 获取。 |

### 查询参数

该 API 需要传入以下查询参数：

| Parameter | Data type | Required/Optional | Description |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `type` | string | Required | 转换任务类型，取值如下：<li>`dynamic`：动态文档转换，即文档转网页。</li><li>`static`：静态文档转换，即文档转图片</li> |

### Request example

```
GET /v5/services/conversion/tasks/2fxxxxxx367e?type=static
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWsxxxxxM2MjRi
```

### HTTP response

All possible response status codes. See the status code summary table for details.

If the status code is `2XX`, the request is successful. 响应包含返回的操作结果和数据。

**The following is a response example for a successful request:**

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

| Parameter | Data type | Description |
| :------------- | :----- | :----------------------------------------------------------- |
| `uuid` | string | 转换任务的 UUID，转换任务的唯一标识符。 |
| `type` | string | 转换任务类型，取值如下：<li>`dynamic`：动态文档转换，即文档转网页。</li><li>`static`：静态文档转换，即文档转图片。</li> |
| `status` | string | 转换任务的状态：<li>`Waiting`：等待中。</li><li>`Converting`：转换中。</li><li>`Finished`：已完成。</li><li>`Fail`：失败。</li> |
| `failedReason` | string | 转换任务失败的原因。 只有当 `status` 为 `Fail` 时，才会返回该字段。 |
| `progress` | object | 转换任务的进度，包括以下字段：<li>`totalPageSize`：Number 类型，转换文档总页数。</li><li>`convertedPageSize`：Number 类型，已经完成转换的页数。</li><li>`convertedPercentage`：Number 类型，转换进度百分比。</li><li>`convertedFileList`：Array 类型，已完成转换的图片列表，每个图片包含以下参数：<ul><li>`width`：Number 类型，图片宽度，单位为像素。</subli><li>`height`：Number 类型，图片高度，单位为像素。</li><li>`conversionFileUrl`：String 类型，转换图片的 URL。</li><li>`preview`: String 类型，预览图地址。 当发起转换时请求包体中 `preview` 设为 `true` 且 `type` 为 `dynamic` 时，才会返回该字段。</li></ul></li><li>`currentStep`：String 类型，动态转换任务当前的步骤，返回值包括：<ul><li> `Extracting`：提取资源。</li><li>`Packaging`：打包资源。</li><li>`GeneratingPreview`：生成预览图。</li><li>`MediaTranscode`：媒体转码。</li></ul></li> 当发起转换时请求包体中 `type` 为 `dynamic` 时，才会返回 `currentStep` 字段。 |

If the status code is not `2XX`, the request fails. The response body includes a `message` field that describes the reason for the failure.