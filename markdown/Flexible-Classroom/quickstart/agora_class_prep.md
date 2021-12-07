使用 Agora 灵动课堂前，你需要先在 Agora 控制台配置 aPaaS 服务。

## 前提条件

配置 aPaaS 服务前，请确保已经具备以下条件：

- 创建一个 Agora 开发者账号。

- 在 Agora 控制台[创建一个 Agora 项目](/cn/Agora%20Platform/get_appid_token#创建-agora-项目)。

- 在你的 Agora 项目中[开启互动白板服务](/cn/whiteboard/enable_whiteboard#开启互动白板服务)，并[获取白板的 App Identifier 和 SDK Token](/cn/whiteboard/enable_whiteboard#获取互动白板项目的安全密钥)。

- 在 Agora 控制台生成一组客户 ID 和客户密钥，用于访问 RESTful API。详见[生成客户 ID 和密钥](/cn/Agora%20Platform/get_appid_token#生成客户-id-和密钥)。

- 注册[环信即时通讯云](https://console.easemob.com/user/register)，并在环信开发者管理后台[创建应用](https://docs-im.easemob.com/im/quickstart/guide/experience#创建应用)。

  <div class="alert info">如无环信即时通讯云账号，你仍可加入灵动课堂，但无法使用课堂中的消息聊天功能。</div>

- 第三方云存储账号。灵动课堂中的以下功能需要使用第三方云存储：

  - 互动白板功能需要第三方云存储用于储存课堂文件。当前仅支持[阿里云 OSS](https://www.aliyun.com/product/oss)。
  - 录制功能需要第三方云存储录制文件。当前支持[阿里云 OSS](https://www.aliyun.com/product/oss)、[七牛云](https://www.qiniu.com/products/kodo)、[Amazon S3](https://aws.amazon.com/cn/s3/?nc2=h_m1)、[腾讯云](https://cloud.tencent.com/product/cos)、[金山云](https://www.ksyun.com/post/product/KS3.html)以及 [Microsoft Azure](https://azure.microsoft.com/zh-cn/)。

  <div class="alert info">如无第三方云存储，你仍可加入课堂，但无法使用课堂白板中的课件上传功能。</div>

## 配置 aPaaS 服务

参照以下步骤在 Agora 控制台配置 aPaaS 服务。

1. 登录 Agora 控制台，进入[项目管理](https://console.agora.io/projects)页面。点击 Agora 项目的**编辑**按钮进入**项目编辑**页面，然后点击 **aPaaS 配置**按钮。

  ![项目管理页面](https://web-cdn.agora.io/docs-files/1611024994160)

2. 在 **aPaaS 配置**页面，勾选白板、云端录制和环信 IM 选择框，将下文的 JSON 对象示例分别粘贴至编辑框并替换相应参数，然后点击**更新**。

   ![](https://web-cdn.agora.io/docs-files/1626856137892)

   **白板 JSON 示例**
	
	 <div class="alert note">你需要将 <code>appId</code> 替换成你的白板 App Identifier，将 <code>token</code> 替换成你的白板 SDK Token。点击<a href="#whiteboard">此处</a>查看字段详细介绍。</div>

    ```json
   {       
	 "enabled": true,
     "appId": "<your_whiteboard_app_id>",
     "token": "<your_whiteboard_sdk_token>",
     "oss": {
       "region": "oss-cn-shanghai",
       "bucket": "your-bucket-name",
       "folder": "whiteboard",
       "accessKey": "your-access-key",
       "secretKey": "your-secret-key",
       "endpoint": "oss-cn-shanghai.aliyuncs.com"
       }
   }
    ```

   **录制 JSON 示例**
	
	 <div class="alert note">点击<a href="#recording">此处</a>查看字段详细介绍。</div>

     ```json
   {       
	 "enabled": true,
     "recordingConfig": {},
     "storageConfig": {}
   }
     ```

   **环信 IM JSON 示例**

   <div class="alert note">点击<a href="#im">此处</a>查看字段详细介绍。</div>
   
     ```json
     {
       "enabled": true,
       "vendor": 1,
       "huanxin": {
         "apiHost": "",
         "orgName": "",
         "appName": "",
         "superAdmin": "",
         "appKey": "",
         "clientId": "",
         "clientSecret": ""
       }
     }
     ```
   
   配置成功后，你可以看到以下页面：
   
   ![](https://web-cdn.agora.io/docs-files/1632470916770)

## 后续步骤

在 Agora 控制台配置 aPaaS 服务后，你可参考《启动课堂》文档使用 Agora Classroom SDK 加入一个灵动课堂。

## 更多信息

<a name="whiteboard"></a>
### 白板 JSON 配置对象介绍

白板的 JSON 配置对象包含以下字段：

| 字段    | 类型   | 描述                                                         |
| :------ | :----- | :----------------------------------------------------------- |
| `appId` | String | （必填）你的白板 App Identifier。如不设置，则无法进入灵动课堂。 |
| `token` | String | （必填）你的白板 SDK Token。如不设置，则无法进入灵动课堂。   |
| `oss`   | Object | （选填）阿里云 OSS 配置，用于储存你在课堂中上传的课件。如不设置，则无法使用白板中的课件上传功能。<p>**注意事项**：当前白板只支持阿里云 OSS。</p>JSON 对象包含以下字段：<ul><li>`region`: String 型，阿里云 OSS 指定的地区信息，例如 `"oss-cn-shanghai"`。</li><li>`bucket`: String 型，阿里云 OSS 的 Bucket 名称，例如 `"agora-whiteboard"`。</li><li>`folder`: String 型，阿里云 OSS 中的资源路径，例如 `"whiteboard"`。</li><li>`accessKey`：String 型，阿里云访问密钥 AccessKey 中的 `AccessKeyId`，详见[阿里云文档](https://help.aliyun.com/document_detail/53045.html)。仅适用于灵动课堂 1.1.0 之前版本。</li><li>`secretKey`：String 型，阿里云访问密钥 AccessKey 中的 `AccessKeySecret`，详见[阿里云文档](https://help.aliyun.com/document_detail/53045.html)。仅适用于灵动课堂 1.1.0 之前版本。</li><li>`endpoint`: String 型，阿里云 OSS [访问域名](https://help.aliyun.com/document_detail/31837.html?spm=a2c4g.11186623.6.625.49002345WzP07l)，例如 `"oss-cn-shanghai.aliyuncs.com"`。</li><li>`ramAccessKey`: String 型，阿里云临时访问密钥 STS AK 的 `AccessKeyId`。详见[阿里云文档](https://www.alibabacloud.com/help/doc-detail/100624.htm?spm=a2c63.p38356.b99.135.48b226dcvXg2Yw)。仅适用于灵动课堂 1.1.0 及之后版本。</li><li>`ramAccessSecret`: String 型，阿里云临时访问密钥 STS AK 的 `AccessKeySecret`，详见[阿里云文档](https://www.alibabacloud.com/help/doc-detail/100624.htm?spm=a2c63.p38356.b99.135.48b226dcvXg2Yw)。仅适用于灵动课堂 1.1.0 及之后版本。</li><li>`roleArn`: String 型，阿里云 OSS 临时授权访问的角色 ARN，详见[阿里云文档](https://www.alibabacloud.com/help/doc-detail/100624.htm?spm=a2c63.p38356.b99.135.48b226dcvXg2Yw)。仅适用于灵动课堂 1.1.0 及之后版本。</li><li>`roleSessionName`: （必填）String 型，阿里云 OSS 标识临时访问凭证的名称，详见[阿里云文档](https://www.alibabacloud.com/help/doc-detail/100624.htm?spm=a2c63.p38356.b99.135.48b226dcvXg2Yw)。仅适用于灵动课堂 1.1.0 及之后版本。</li></ul> |

<a name="recording"></a>
### 录制 JSON 配置对象参数介绍

录制的 JSON 配置对象包含以下字段：

| 字段              | 类型   | 描述                                                         |
| :---------------- | :----- | :----------------------------------------------------------- |
| `recordingConfig` | Object | （选填）录制设置。如不设置，则使用[合流录制模式](/cn/Agora%20Platform/composite_recording_mode)且只录制老师的音视频。如需更改录制行为，请参考[云端录制设置](/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#recordingConfig)。 |
| `storageConfig`   | Object | （选填）云存储设置，用于储存你的录制文件。如不设置，你的录制文件会存储在 Agora 的阿里云 OSS 账号中。如需使用你自己的云存储，请参考[云存储设置](/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#storageConfig)进行配置。请注意以下字段的设置：<li> `endpoint` : （必填）String 类型，由阿里云 Bucket 名称和[访问域名](https://help.aliyun.com/document_detail/31837.html?spm=a2c4g.11186623.6.625.49002345WzP07l)拼成的完整路径。假设你的 Bucket 名称为 `"agora-recording"`，阿里云 OSS 访问域名为 `"oss-cn-shanghai.aliyuncs.com"`，则 `endpoint` 字段设为 `"https://agora-recording.oss-cn-shanghai.aliyuncs.com"`。</li><li>`fileNamePrefix`: （选填）String 数组，指定录制文件在第三方云存储中的存储位置。你可使用变量来指定一个动态路径。你发起录制时，灵动课堂云服务会用真实的值替换变量。详见[如何指定动态存储路径](/cn/live-streaming/faq/agora_class_dynamic_addr)。</li> |

<a name="im"></a>

### 环信 IM JSON 配置对象参数介绍

环信 IM 的 JSON 配置对象包含以下字段：

| 字段           | 类型   | 描述                                                         |
| :------------- | :----- | :----------------------------------------------------------- |
| `apiHost`      | String | （必填）环信 REST API 访问地址，例如 a1.easemob.com 或 a1.easecdn.com，你可在环信开发者管理后台获取。 |
| `orgName`      | String | （必填）企业的唯一标识，你在环信开发者管理后台注册账号时填写的企业 ID。 |
| `appName`      | String | （必填）企业下 App 的唯一标识，你在环信开发者管理后台创建应用时填写的应用名称。 |
| `superAdmin`   | String | （必填）超级管理员用户名前缀。**只支持数字或字母，不支持特殊字符，aPaaS 会以 `${superAdmin}-${timestamp}` 作为超级管理员创建 IM 房间。**         |
| `appKey`       | String | （必填）App 的唯一标识，由环信开发者管理后台基于 `${org_name}#${app_name} `的规则生成。 |
| `clientId`     | String | （必填）开发者 Client ID，由环信开发者管理后台生成。         |
| `clientSecret` | String | （必填）开发者密钥，由环信开发者管理后台生成。               |

你可参考下图在环信开发者管理后台获取上述参数。

![](https://web-cdn.agora.io/docs-files/1631178001176)

![](https://web-cdn.agora.io/docs-files/1631178086130)