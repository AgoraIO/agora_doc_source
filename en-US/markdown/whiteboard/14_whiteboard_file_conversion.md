The file conversion feature provided by Agora Interactive Whiteboard can convert PPT, PPTX, Word, and PDF files into static images or dynamic HTML web pages. The generated images and web pages can be presented on the whiteboard. See [File conversion](/cn/whiteboard/file_conversion_overview?platform=RESTful).

<div class="alert note">Before calling the RESTful API for file conversion, ensure that:
<ul>
	<li>You have enabled <b>Docs to Picture</b> or <b>Docs to Web</b> and configured storage settings at <a href="https://console.agora.io/">Agora Console</a >. See <a href="https://docs.agora.io/cn/whiteboard/enable_whiteboard?platform=RESTful#%E5%BC%80%E5%90%AF%E4%BA%92%E5%8A%A8%E7%99%BD%E6%9D%BF%E9%85%8D%E5%A5%97%E6%9C%8D%E5%8A%A1">Enable server-side supporting features</a >.</li>
	<li>You have generated a URL address for the file you want to convert, and the address can be accessed by public IP addresses.</li></ul></div>

## Start file conversion (POST)

Call this API to start a file conversion task.

### Prototype

- Method: `POST`
- Access point: `https://api.netless.link/v5/services/conversion/tasks`

### Request header

Pass in the following parameters in the request header:

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | A `writer` or `admin` SDK Token. To get one, you can:<li>Use Agora Console. See [Get an SDK Token](/cn/whiteboard/enable_whiteboard?platform=RESTful#获取-sdk-token).</li><li>Call the RESTful API. See [Generate an SDK Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-sdk-token-（post）).</li><li>Write code on your app server. See [Generate a token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful).</li> |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li> For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Body

The following parameters are required in the URL.

| Parameter | Data type | Required/Optional | Description |
| :------------- | :------ | :------- | :----------------------------------------------------------- |
| `resource` | string | Required | The URL of the file you want to convert. |
| `type` | string | Required | The conversion type:<li>`dynamic`: Dynamic file conversion, converting the file to web pages.</li><li>`static`: Static file conversion, converting the file to images.</li> |
| `preview` | boolean | Optional | Whether to generate a preview of the generated images:<li>`true`: Generate.</li><li>`false`: Not generate.</li><div class="alert note">This parameter only takes effect when `type` is set to `dynamic`. Note that generating a preview can take a long time.</div> |
| `scale` | number | Optional | The scale factor. The range is [0.1,3.0], and the default value is `1.2`. The higher the value, the clearer the generated image.<div class="alert note">This parameter only takes effect when `type` is set to `static`.</div> |
| `outputFormat` | string | Optional | The format of the generated image:<li><code>png</code></li><li><code>jpg</code> or <code>jpeg</code></li><li><code>webp</code></li>The default value is <code>png.</code>  <div class="alert note">This parameter only takes effect when `type` is set to `static`.</div> |

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

For details about all possible response status codes, see the [status code table](/cn/whiteboard/basic_info?platform=RESTful#响应状态码).

If the status code is `201`, the request is successful. The response returns the status code and corresponding parameters.

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

**Description of parameters in the response:**

| Parameter | Data type | Description |
| :------- | :----- | :----------------------------------------------------------- |
| `uuid` | string | The Task UUID, which is the unique identifier of the file conversion task. |
| `type` | string | The conversion type:<li>`dynamic`: Dynamic file conversion, converting the file to web pages.</li><li>`static`: Static file conversion, converting the file to images.</li> |
| `status` | string | The status of the conversion task:<li>`Waiting`: Conversion is waiting to start.</li><li>`Converting`: Conversion is going on.</li><li>`Finished`: Conversion finished.</li><li>`Fail`: Conversion failed.</li> |

If the status code is not `201`, the request fails. The response body includes a `message` field that describes the reason for the failure.

## Query file conversion progress (GET)

Call this API to query the progress of a file-conversion task.

### Prototype

- Method: `GET`
- Access point: `https://api.netless.link/v5/services/conversion/tasks/{uuid}`

### Request header

Pass in the following parameters in the request header:

| Parameter | Data type | Required/Optional | Description |
| :------- | :----- | :------- | :----------------------------------------------------------- |
| `token` | string | Required | The Task Token. To get one, you can:<li>Call the RESTful API. See [Generate a Task Token](/cn/whiteboard/generate_whiteboard_token?platform=RESTful#生成-task-token-（post）).<li>Write code on your app server. See [Generate a Token from your app server](/cn/whiteboard/generate_whiteboard_token_at_app_server?platform=RESTful). |
| `region` | string | Optional | Specifies a data center to process the request:<li>(Default) `cn-hz`: The data center located in Hangzhou, China. Its service area includes East Asia, Southeast Asia, and areas not covered by other data centers.</li><li>`us-sv`: The data center located in Silicon Valley. Its service area includes North America and South America.</li>For details, see [Data center and globalization](https://developer.netless.link/javascript-zh/home/region-and-global). |

### Request Path

The following parameters are required in the URL:

| Parameter | Data type | Required/Optional | Description |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `uuid` | string | Required | The Task UUID, which is the unique identifier of the conversion task. You can get it by calling the RESTful API to start a file conversion. |

### Query Parameters

You need to pass in the following query parameters:

| Parameter | Data type | Required/Optional | Description |
| :----- | :----- | :------- | :----------------------------------------------------------- |
| `type` | string | Required | The conversion type:<li>`dynamic`: Dynamic file conversion, converting the file to web pages.</li><li>`static: Static file conversion, converting the file to images.`</li> |

### Request example

```
GET /v5/services/conversion/tasks/2fxxxxxx367e?type=static
Host: api.netless.link
Content-Type: application/json
token: NETLESSSDK_YWsxxxxxM2MjRi
```

### HTTP response

All possible response status codes. See the status code summary table for details.

If the status code is `200`, the request is successful. The response returns the status code and corresponding parameters.

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

**Description of parameters in the response:**

| Parameter | Data type | Description |
| :------------- | :----- | :----------------------------------------------------------- |
| `uuid` | string | The Task UUID, which is the unique identifier of the file conversion task. |
| `type` | string | The conversion type:<li>`dynamic`: Dynamic file conversion, converting the file to web pages.</li><li>`static`: Static file conversion, converting the file to images.</li> |
| `status` | string | The status of the conversion task:<li>`Waiting`: Conversion is waiting to start.</li><li>`Converting`: Conversion is going on.</li><li>`Finished`: Conversion finished.</li><li>`Fail`: Conversion failed.</li> |
| `failedReason` | string | The reason the conversion task failed. This field is returned only when `status` is `Fail`. |
| `progress` | object | The progress of the conversion task, which includes the following fields:<li>`totalPageSize`: Number. Indicates the number of pages of the source file.</li><li>`convertedPageSize`: Number. Indicates the number of pages that have been converted.</li><li>`convertedPercentage`: Number. Indicates the conversion progress in percentage form.</li><li>`convertedFileList`: Array. Contains a list of generated images, each containing the following parameters:<ul><li>`width`: Number. Indicates the width of the image in pixels.</subli><li>`height`: Number. Indicates the height of the image in pixels.</li><li>`conversionFileUrl`: String. Indicates the URL of the generated image.</li><li>`preview`: String. Indicates the address of the preview. This field is returned only when `preview` is set to `true` and `type` is set to `dynamic` in the request body when starting file conversion.</li></ul></li><li>`currentStep`: String. Indicates the current step of a dynamic conversion task:<ul><li> `Extracting`: The server is extracting resources.</li><li>`Packaging`: The server is packaging resources.</li><li>`GeneratingPreview`: The server is generating the preview.</li><li>`MediaTranscode`: The server is transcoding.</li></ul></li>` currentStep` is returned only when `type` is set to `dynamic` in the request body when starting file conversion. |

If the status code is not `200`, the request fails. The response body includes a `message` field that describes the reason for the failure.