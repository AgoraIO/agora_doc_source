本文介绍如何通过发送 RESTful API 请求开始云端录制、查询云端录制状态以及结束云端录制。

<div class="alert note"> 文中命令行示例仅用于演示，请勿用于生产环境。生产环境中，你需要通过应用服务器发送 RESTful API 请求。</div>

##  技术原理

实现云端录制的完整流程如下所示：
![](https://web-cdn.agora.io/docs-files/1625209047438)

**1. 获取 resource ID**
在开始录制前，必须调用 [`acquire`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/云端录制/acquire) 方法获取云端录制资源。调用该方法成功后，你可以在响应包体中得到一个 resource ID。

**2. 开始录制**
调用 [`start`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/云端录制/start) 方法加入频道开始录制。调用该方法成功后，你可以从响应包体中获得一个录制 ID，标记当前录制进程。

 **3. 结束录制**
 调用 [`stop`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/云端录制/stop) 方法停止录制。

**4. 上传录制文件**
   录制结束后，云端录制服务上传录制文件到你指定的第三方云存储。

## 前提条件

- 有效的 [Agora 开发者账号](https://docs.agora.io/cn/AgoraPlatform/sign_in_and_sign_up?platform=iOS)，[App ID 和 Token](https://docs.agora.io/cn/AgoraPlatform/get_appid_token?platform=AllPlatforms)。
- 请确保已开通第三方云存储服务。目前支持的第三方云存储服务商如下：
  - [七牛云](https://www.qiniu.com/products/kodo)
  - [Amazon S3](https://aws.amazon.com/cn/s3/?nc2=h_m1)
  - [阿里云](https://www.aliyun.com/product/oss)
  - [腾讯云](https://cloud.tencent.com/product/cos)
  - [金山云](https://www.ksyun.com/post/product/KS3.html)
  - [Microsoft Azure](https://azure.microsoft.com/zh-cn/)
- 请确保已加入 RTC 频道并且频道内有用户且正在发流。

## 示例项目

Agora 在 GitHub 上提供一个 [Postman collection](https://github.com/AgoraIO/Agora-RESTful-Service/blob/master/cloud-recording/README.md)，包含了云端录制 RESTful API 的所有示例请求。你只需将该 collection 导入 Postman，并设置环境变量，便可快速体验云端录制 RESTful API 的基本功能。

你还可以使用 Postman 自动生成各种语言的代码片段。选择某个请求，点击 **Code**，在 **GENERATE CODE SNIPPETS** 窗口选择你需要的语言，即可生成该语言的示例代码。

![img](https://web-cdn.agora.io/docs-files/1588737379230)

## 开通云端录制服务

第一次使用云端录制首先需要开通服务，步骤如下：

1. 登录[控制台](https://console.agora.io/)，点击左侧导航栏 ![img](https://web-cdn.agora.io/docs-files/1551250582235) 按钮进入**产品用量**页面。
2. 在页面左上角展开下拉列表选择需要开通云端录制的项目，然后点击云端录制下的**分钟数**。 ![img](https://web-cdn.agora.io/docs-files/1566385129523)
3. 点击**开启云端录制支持**。
4. 点击**应用**。

开通成功后你可以在**产品用量**页面看到云端录制的使用情况。

## 实现云端录制

下图为实现云端录制需要调用的 API 时序图。
查询录制状态（`query`）、更新订阅名单（`update`）和更新合流布局（`updateLayout`）均为可选，且可多次调用，但须在录制过程中，即开始录制后到结束录制前调用。
![](https://web-cdn.agora.io/docs-files/1625213385395)

### 通过 Basic HTTP 认证

Agora RESTful API 要求 Basic HTTP 认证。每次发送 HTTP 请求时，都必须在请求头部填入 `Authorization` 字段。关于如何生成该字段的值，请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。

### 获取云端录制资源 

在开始录制前，必须先调用 [`acquire`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#a-nameacquirea获取云端录制资源的-api) 方法获取一个云端录制 resource ID。

调用该方法成功后，你可以在响应包体中得到一个 resource ID。resource ID 的时效为 5 分钟，你需要在 5 分钟内使用该 resource ID 开始录制。一个 resource ID 仅可用于一次录制。

- 录制服务相当于频道中一个不发流的客户端。请求包体中的 `uid` 参数用于标识录制服务，不可与频道内的任何已有 UID 重复。例如，如果频道内已有两个用户，UID 分别为 123 和 456，则 `uid` 不可为 `"123"` 或 `"456"`。
- 云端录制不支持 String 用户 ID（User Account）。请确保频道内所有用户均使用整型 UID。`uid` 参数的字符串内容也必须为整型。

#### 示例代码

你可以使用命令行工具发送以下命令调用 `acquire` 方法。你需要将 `appid` 替换为你的 Agora 项目的 App ID，`YourChannelName` 替换为你需要录制的频道名称，`YourRecordingUID` 替换为你标识该录制服务的 UID。

```
curl --location --request POST 'https://api.agora.io/v1/apps/<appid>/cloud_recording/acquire' \
--header 'Authorization: Basic MjdiZjhjMmRkNTNhNGQwZGEwXXXXXXXXXXXXXXzc6YjM2N2NiMjRiOTExNDQyYTg5YjU5YTdmN2Y0YjM1OWM=' \
--header 'Content-type: application/json;charset=utf-8' \
--data-raw '{
  "cname": "<YourChannelName>",
  "uid": "<YourRecordingUID>",
  "clientRequest":{
  }
}'

```

### 开始录制

获得 resource ID 后，在五分钟內调用 [`start`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#a-namestarta开始云端录制的-api) 方法加入频道开始录制。你可以选择录制模式为单流录制或合流录制。

调用该方法成功后，你可以从响应包体中获得一个 sid （录制 ID)。该 ID 是一次录制周期的唯一标识。

#### 示例代码

你可以使用命令行工具发送以下命令，调用 `start` 方法。你需要将 `appid` 替换为你的 Agora 项目的 App ID，`resourceid` 替换为通过 `acquire` 方法获取的 resource ID，YourChannelName 替换为你需要录制的频道名称，YourRecordingUID 替换为你标识该录制服务的 UID，`YourToken` 替换成你在控制台获取的临时 Token，并设置 `storageConfig` 和 `recordingConfig` 相关参数。

- 在测试阶段，你可以直接在控制台[获取临时 Token](https://docs.agora.io/cn/AgoraPlatform/get_appid_token?platform=AllPlatforms#获取临时-token)。加入频道时，请确保填入的频道名和生成临时 Token 时填入的频道名一致。
- 在生产环境，我们推荐你在自己的服务端生成 Token，详见[在服务端生成 Token](https://docs.agora.io/cn/InteractiveBroadcast/token_server?platform=AllPlatforms)。加入频道时，请确保填入的频道名和 uid 与生成临时 Token 时填入的频道名和 uid 一致。

<div class="alert note"> 请确保 channelType 与 Agora RTC SDK 的设置一致，否则可能导致问题。</div>

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">单流录制</div>
		<div class="switch-tab">合流录制</div>
	</div>
<pre class="单流录制 show"><code class="单流录制">
curl --location --request POST  'https://api.agora.io/v1/apps/<appid>/cloud_recording/resourceid/<resourceid>/mode/individual/start' \
--header 'Authorization: Basic MjdiZjhjMmRkNTNhNGQwZGEwXXXXXXXXXE5Yzc6YjM2N2NiMjRiOTExNDQyYTg5YjU5YTdmN2Y0YjM1OWM=' \
--header 'Content-Type: application/json' \
--data-raw '{
    "cname": "YourChannelName",
    "uid": "YourRecordingUID",
    "clientRequest": {
	    "token": "YourToken",
        "storageConfig": {
            "secretKey": "YourSecretKey",
            "vendor": 0,
            "region": 0,
            "bucket": "YourBucketName",
            "accessKey": "YourAccessKey"
        },
        "recordingConfig": {
            "channelType": 1
        }
    }
}'
</code></pre>
<pre class="合流录制"><code class="合流录制">
curl --location --request POST 'https://api.agora.io/v1/apps/<appid>/cloud_recording/resourceid/<resourceid>/mode/mix/start' \
--header 'Authorization: Basic MjdiZjhjMmRkNTNhNGQwZGEwXXXXXXXXXXXXXXzc6YjM2N2NiMjRiOTExNDQyYTg5YjU5YTdmN2Y0YjM1OWM=' \
--header 'Content-Type: application/json' \
--data-raw '{
    "cname": "YourChannelName",
    "uid": "YourRecordingUID",
    "clientRequest": {
        "token": "YourToken",
        "recordingConfig": {
            "channelType": 0
        },
        "storageConfig": {
            "secretKey": "YourSecretKey",
            "vendor": 0,
            "region": 0,
            "bucket": "YourBucketName",
            "accessKey": "YourAccessKey"
        }
    }
}'
</code></pre>
</div>

### 查询录制状态

录制过程中，你可以多次调用 [`query`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/云端录制/query) 方法查询录制的状态。

调用该方法成功后，你可以从响应包体中获得当前录制的状态和录制文件的相关信息。你可以参考[云端录制最佳集成实践](https://confluence.agoralab.co/integration_best_practices?platform=RESTful)来实现[录制过程中的服务状态监控](https://docs.agora.io/cn/cloud-recording/integration_best_practices#monitor_status)和[获取 M3U8 文件名](https://docs.agora.io/cn/cloud-recording/integration_best_practices#get_filename)。

#### 示例代码

你可以使用命令行工具发送以下命令，调用 `query` 方法。你需要将 `appid` 替换为你的 Agora 项目的 App ID，`resourceid` 替换为通过 `acquire` 方法获取的 resource ID，`sid` 替换为通过 `start` 方法获取的 sid。

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">单流录制</div>
		<div class="switch-tab">合流录制</div>
	</div>
<pre class="单流录制 show"><code class="单流录制">
curl --location --request GET 'https://api.agora.io/v1/apps/<appid>/cloud_recording/resourceid/<resourceid>/sid/<sid>/mode/individual/query' \
--header 'Authorization: Basic MjdiZjhjMmRkNTNhNGQwZGEwXXXXXXXXXXXXXXzc6YjM2N2NiMjRiOTExNDQyYTg5YjU5YTdmN2Y0YjM1OWM=' \
--header 'Content-type: application/json;charset=utf-8'
</code></pre>
<pre class="合流录制"><code class="合流录制">
curl --location --request GET 'https://api.agora.io/v1/apps/<appid>/cloud_recording/resourceid/<resourceid>/sid/<sid>/mode/mix/query' \
--header 'Authorization: Basic MjdiZjhjMmRkNTNhNGQwZGEwXXXXXXXXXXXXXXzc6YjM2N2NiMjRiOTExNDQyYTg5YjU5YTdmN2Y0YjM1OWM=' \
--header 'Content-type: application/json;charset=utf-8'
</code></pre>
</div>

###  停止录制

调用 [`stop`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#a-namestopa停止云端录制的-api) 方法停止录制。

调用该方法成功后，你可以从响应包体中获得录制文件上传的状态和录制文件的信息。

#### 示例代码

你可以使用命令行工具发送以下命令，调用 `stop` 方法。你需要将 `appid` 替换为你的 Agora 项目的 App ID，`resourceid` 替换为通过 `acquire` 方法获取的 resource ID，`sid` 替换为通过 `start` 方法获取的 sid，`YourChannelName` 替换为你正在录制的频道名称，`YourRecordingUID` 替换为你标识该录制服务的 UID。

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">单流录制</div>
		<div class="switch-tab">合流录制</div>
	</div>
<pre class="单流录制 show"><code class="单流录制">
curl --location --request POST 'https://api.agora.io/v1/apps/v1/apps/<appid>/cloud_recording/resourceid/<resourceid>/sid/null/mode/individual/stop' \
--header 'Authorization: Basic MjdiZjhjMmRkNTNhNGQwZGEwXXXXXXXXXXXXXXzc6YjM2N2NiMjRiOTExNDQyYTg5YjU5YTdmN2Y0YjM1OWM=' \
--header 'Content-type: application/json;charset=utf-8' \
--data-raw '{
    "uid": "YourRecordingUID",
    "cname": "YourChannelName",
	"clientRequest":{
    }
}'
</code></pre>
<pre class="合流录制"><code class="合流录制">
curl --location --request POST 'https://api.agora.io/v1/apps/v1/apps/<appid>/cloud_recording/resourceid/<resourceid>/sid/<sid>/mode/mix/stop' \
--header 'Authorization: Basic MjdiZjhjMmRkNTNhNGQwZGEwXXXXXXXXXXXXXXzc6YjM2N2NiMjRiOTExNDQyYTg5YjU5YTdmN2Y0YjM1OWM=' \
--header 'Content-type: application/json;charset=utf-8' \
--data-raw '{
    "uid": "YourRecordingUID",
    "cname": "YourChannelName",
    "clientRequest":{
    }
}'
</code></pre>
</div>

##  后续步骤

### 管理录制文件

开始录制后，Agora 服务器会将录制内容切片为多个 TS/WebM 文件并不断上传至预先设定的第三方云存储，直至录制结束。你可以参考[管理录制文件](https://docs.agora.io/cn/cloud-recording/cloud_recording_manage_files)了解录制文件的命名规则、文件大小以及切片规则。

### Token 鉴权

为保障通信安全，在正式生产环境中，你需要在自己的 app 服务端生成 Token。详见[使用 Token 鉴权](https://docs.agora.io/cn/cloud-recording/token_server?platform=AllPlatforms)。

## 开发注意事项

### 参数设置

- 如果请求包体中的 `uid` 参数与频道内的 UID 重复、或使用了非整型 UID，均会导致录制失败。详见[获取云端录制资源](https://confluence.agoralab.co/pages/viewpage.action?pageId=719466567#acquire)一节中关于 `uid` 参数的注意事项。
- `start` 请求返回 200 后，仅代表 RESTful API 请求成功。要确保录制成功启动并正常进行，你还需要调用 query 查询录制状态。`transcodingConfig` 参数设置不合理、第三方云存储信息有误、token 信息有误等均会导致 `query` 方法返回 404。详见[为什么成功开启云端录制后调用 query 方法返回 404？](https://confluence.agoralab.co/cn/cloud-recording/faq/return-404)。
- 请结合你的实际业务需求合理设置 `maxIdleTime` 。在 `maxIdleTime` 设置的时间范围内，即使频道空闲，录制仍会持续进行，并产生计费。

### API 调用

- 获得 resource ID 后，必须在 5 分钟内调用 `start` 方法开始录制，超时后需要重新请求一个 resource ID。
- 从获得 `sid` （录制 ID）起，超过 `resourceExpiredHour` 设定的时间后，你将无法调用 `query`，`updateLayout `和 `stop` 方法。

## 参考文档

- [云端录制常见错误](https://docs.agora.io/cn/cloud-recording/common_errors)列出了响应包体中常见的错误码及错误信息。

- [云端录制 RESTful API 回调服务](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest?platform=RESTful)列出了云端录制的所有回调事件。
- 如需了解更多基础功能的实现步骤及细节，可参考以下文档：
  - [单流录制](https://docs.agora.io/cn/cloud-recording/cloud_recording_individual_mode?platform=RESTful)
  - [合流录制](https://docs.agora.io/cn/cloud-recording/cloud_recording_composite_mode?platform=RESTful)
  - [页面录制](https://docs.agora.io/cn/cloud-recording/cloud_recording_webpage_mode?platform=RESTful)
  - [视频截图](https://docs.agora.io/cn/cloud-recording/cloud_recording_screen_capture?platform=RESTful)