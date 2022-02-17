使用 Agora 灵动课堂前，你需要先在 Agora 控制台配置 aPaaS 服务。

## Prerequisites

配置 aPaaS 服务前，请确保已经具备以下条件：

- A valid Agora account. (Sign up for free)

- 在 Agora 控制台[创建一个 Agora 项目](/cn/Agora%20Platform/get_appid_token#创建-agora-项目)。

- 在你的 Agora 项目中[开启互动白板服务](/cn/whiteboard/enable_whiteboard#开启互动白板服务)，并[获取白板的 App Identifier 和 SDK Token](/cn/whiteboard/enable_whiteboard#获取互动白板项目的安全密钥)。

- 在 Agora 控制台生成一组客户 ID 和客户密钥，用于访问 RESTful API。 详见[生成客户 ID 和密钥](/cn/Agora%20Platform/get_appid_token#生成客户-id-和密钥)。

- 注册[环信即时通讯云](https://console.easemob.com/user/register)，并在环信开发者管理后台[创建应用](https://docs-im.easemob.com/im/quickstart/guide/experience#创建应用)。

<div class="alert info">如无环信即时通讯云账号，你仍可加入灵动课堂，但无法使用课堂中的消息聊天功能。</div>

- 第三方云存储账号。 灵动课堂中的以下功能需要使用第三方云存储：

   - 互动白板功能需要第三方云存储用于储存课堂文件。 当前仅支持[阿里云 OSS](https://www.aliyun.com/product/oss)。
   - 录制功能需要第三方云存储录制文件。 当前支持[阿里云 OSS](https://www.aliyun.com/product/oss)、[七牛云](https://www.qiniu.com/products/kodo)、[Amazon S3](https://aws.amazon.com/cn/s3/?nc2=h_m1)、[腾讯云](https://cloud.tencent.com/product/cos)、[金山云](https://www.ksyun.com/post/product/KS3.html)以及 [Microsoft Azure](https://azure.microsoft.com/zh-cn/)。

<div class="alert info">如无第三方云存储，你仍可加入课堂，但无法使用课堂白板中的课件上传功能。</div>

## 配置 aPaaS 服务

参照以下步骤在 Agora 控制台配置 aPaaS 服务。

1. 登录 Agora 控制台，进入[项目管理](https://console.agora.io/projects)页面。 点击 Agora 项目的**编辑**按钮进入**项目编辑**页面，然后点击 **aPaaS 配置**按钮。

![
![](](https://web-cdn.agora.io/docs-files/1619168684154))

2. 在 **aPaaS 配置**页面，勾选白板、云端录制和环信 IM 选择框，将下文的 JSON 对象示例分别粘贴至编辑框并替换相应参数，然后点击**更新**。

   ![](https://web-cdn.agora.io/docs-files/1624525178299)

   **Whiteboard JSON example:**

<div class="alert note">你需要将 <code>appId</code> 替换成你的白板 App Identifier，将 <code>token</code> 替换成你的白板 SDK Token。 点击<a href="#whiteboard">此处</a>查看字段详细介绍。</div>

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

   **Cloud recording JSON example**

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

   ![](https://web-cdn.agora.io/docs-files/1624525158077)

## Next steps

在 Agora 控制台配置 aPaaS 服务后，你可参考《启动课堂》文档使用 Agora Classroom SDK 加入一个灵动课堂。

## See also

<a name="whiteboard"></a>
### 白板 JSON 配置对象介绍

The JSON object for the interactive whiteboard function contains the following fields:

| Field Name | Type | Description |
| :------ | :----- | :----------------------------------------------------------- |
| `appId` | String | (Required) The App Identifier of the Interactive Whiteboard service that you get in the previous step. If you do not set this parameter, you cannot enter a classroom. |
| `token` | String | (Required) The SDK Token of the Interactive Whiteboard service that you get in the previous step. If you do not set this parameter, you cannot enter a classroom. |
| `oss` | Object | (Optional) The configuration of Alibaba Cloud OSS for storing the files you upload in a classroom. If you do not set this parameter, you cannot upload any file in the classroom.<p>**Note**: Temporarily, the Agora Interactive Whiteboard service only supports Alibaba Cloud OSS.</p>The JSON object for the whiteboard contains the following fields:<ul><li>`region`: String. The service` region` of Alibaba Cloud OSS, such as `"oss-cn-shanghai"`.</li><li>`Bucket`: String. The bucket name of Alibaba Cloud OSS, such as `"agora-whiteboard"`.</li><li>`folder`: String. The resource path in Alibaba Cloud OSS, such as `"whiteboard"`.</li><li>`accessKey`：String 型，阿里云访问密钥 AccessKey 中的 `AccessKeyId`，详见[阿里云文档](https://help.aliyun.com/document_detail/53045.html)。 This parameter is only applicable to the Flexible Classroom versions earlier than v1.1.0.</li><li>`secretKey`：String 型，阿里云访问密钥 AccessKey 中的 `AccessKeySecret`，详见[阿里云文档](https://help.aliyun.com/document_detail/53045.html)。 This parameter is only applicable to the Flexible Classroom versions earlier than v1.1.0.</li><li>`endpoint`: String 型，阿里云 OSS [访问域名](https://help.aliyun.com/document_detail/31837.html?spm=a2c4g.11186623.6.625.49002345WzP07l)，例如 `"oss-cn-shanghai.aliyuncs.com"`。</li><li>`ramAccessKey`: String. The AccessKeyId in the STS AK of Alibaba ``Cloud OSS. 详见[阿里云文档](https://www.alibabacloud.com/help/doc-detail/100624.htm?spm=a2c63.p38356.b99.135.48b226dcvXg2Yw)。 This parameter is only applicable to the Flexible Classroom v1.1.0 or later.</li><li>`ramAccessSecret`: String 型，阿里云临时访问密钥 STS AK 的 `AccessKeySecret`，详见[阿里云文档](https://www.alibabacloud.com/help/doc-detail/100624.htm?spm=a2c63.p38356.b99.135.48b226dcvXg2Yw)。 This parameter is only applicable to the Flexible Classroom v1.1.0 or later.</li><li>`roleArn`: String 型，阿里云 OSS 临时授权访问的角色 ARN，详见[阿里云文档](https://www.alibabacloud.com/help/doc-detail/100624.htm?spm=a2c63.p38356.b99.135.48b226dcvXg2Yw)。 This parameter is only applicable to the Flexible Classroom v1.1.0 or later.</li><li>`roleSessionName`: （必填）String 型，阿里云 OSS 标识临时访问凭证的名称，详见[阿里云文档](https://www.alibabacloud.com/help/doc-detail/100624.htm?spm=a2c63.p38356.b99.135.48b226dcvXg2Yw)。 This parameter is only applicable to the Flexible Classroom v1.1.0 or later.</li></ul> |

<a name="recording"></a>
### 录制 JSON 配置对象参数介绍

The JSON object for cloud recording contains the following fields:

| Field Name | Type | Description |
| :---------------- | :----- | :----------------------------------------------------------- |
| `recordingConfig` | Object | (Optional) Recording configuration. If you do not set this parameter, Flexible [Classroom records the audio and video of ](the teachers in composite recording mode/en/Agora%20Platform/composite_recording_mode )by default. 如需更改录制行为，请参考[云端录制设置](/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#recordingConfig)。 |
| `storageConfig` | Object | (Optional) Cloud storage configuration, used for storing your recorded files. If you do not set this parameter, your recorded files will be stored in Agora's Alibaba Cloud OSS account. 如需使用你自己的云存储，请参考[云存储设置](/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#storageConfig)进行配置。 请注意以下字段的设置：<li> `endpoint` : （必填）String 类型，由阿里云 Bucket 名称和[访问域名](https://help.aliyun.com/document_detail/31837.html?spm=a2c4g.11186623.6.625.49002345WzP07l)拼成的完整路径。 Suppose your bucket name is `"agora-whiteboard"` and your access domain is `"oss-cn-shanghai.aliyuncs.com"`, set `endpoint` as `"https://agora-whiteboard.oss-cn-shanghai. aliyuncs.com"`.</li><li>`fileNamePrefix`: （选填）String 数组，指定录制文件在第三方云存储中的存储位置。 你可使用变量来指定一个动态路径。 你发起录制时，灵动课堂云服务会用真实的值替换变量。 详见[如何指定动态存储路径](/cn/live-streaming/faq/agora_class_dynamic_addr)。</li> |

<a name="im"></a>

### 环信 IM JSON 配置对象参数介绍

The JSON object for whiteboard contains the following fields:

| Field Name | Type | Description |
| :------------- | :----- | :----------------------------------------------------------- |
| `apiHost` | String | （必填）环信 REST API 访问地址，例如 a1.easemob.com 或 a1.easecdn.com，你可在环信开发者管理后台获取。 |
| `orgName` | String | （必填）企业的唯一标识，你在环信开发者管理后台注册账号时填写的企业 ID。 |
| `appName` | String | （必填）企业下 App 的唯一标识，你在环信开发者管理后台创建应用时填写的应用名称。 |
| `superAdmin` | String | （必填）超级管理员用户名前缀。 **只支持数字或字母，不支持特殊字符，aPaaS 会以 `${superAdmin}-${timestamp}` 作为超级管理员创建 IM 房间。** |
| `appKey` | String | （必填）App 的唯一标识，由环信开发者管理后台基于 `${org_name}#${app_name} `的规则生成。 |
| `clientId` | String | （必填）开发者 Client ID，由环信开发者管理后台生成。 |
| `clientSecret` | String | （必填）开发者密钥，由环信开发者管理后台生成。 |

你可参考下图在环信开发者管理后台获取上述参数。

![](https://web-cdn.agora.io/docs-files/1624525158077)

![](https://web-cdn.agora.io/docs-files/1620822526000)