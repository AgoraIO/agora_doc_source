This page introduces how to configure the whiteboard, recording, and messaging features in Flexible Classroom in Agora Console.

<div class="alert info">Before reading this page, ensure sure that you have <a href="/cn/agora-class/agora_class_enable?platform=Web" target="_blank">enabled the Flexible Classroom service</a> in Agora Console.</div>

## Configure the whiteboard feature

If you want to upload PPT, Word, or PDF files to a flexible classroom and display these files on the whiteboard, you need to configure the whiteboard feature in Agora Console.

### Prerequisites

The whiteboard feature in Flexible Classroom requires a third-party cloud storage service for storing files uploaded in a classroom. Before configuring the whiteboard feature, ensure that you have enabled a third-party cloud storage service. Temporarily, Agora only supports<a href="https://www.aliyun.com/product/oss" target="_blank"></a><a href="https://aws.amazon.com/cn/s3/?nc2=h_m1" target="_blank">Amazon S3</a>.

### Procedure

On the **Flexible Classroom configuration** page, find the whiteboard module, as shown in the following figure:

![](https://web-cdn.agora.io/docs-files/1641366278596)

You need to do the following:

1. Enable the advanced services. See <a href="/cn/whiteboard/enable_whiteboard#开启互动白板配套服务" target="_blank">Enable whiteboard server-side features</a>.

2. Configure a third-party cloud storage service for storing files uploaded in a classroom.

   - 如果你使用阿里云 OSS，填写以下信息：
      - `region`: 阿里云 OSS 中创建 Bucket 时指定的数据中心所在区域，例如 `oss-cn-shanghai`。
      - `endpoint`: String. The access` endpoint` of Alibaba Cloud OSS, such as "`oss-cn-shanghai.aliyuncs.com`".
      - `Bucket`: String. The bucket name of Alibaba Cloud OSS, such as "`agora-whiteboard`".
      - `folder`: String. The resource path in Alibaba Cloud OSS, such as "`whiteboard`".
      - `ramAccessKey`: String. The AccessKeyId in the STS AK of Alibaba ``Cloud OSS. This parameter is only applicable to the Flexible Classroom v1.1.0 or later.
      - `ramAccessSecret`: String. The` AccessKeySecret` in the STS AK of Alibaba Cloud OSS. For details, see the documentation of Alibaba ``Cloud OSS. This parameter is only applicable to the Flexible Classroom v1.1.0 or later.
      - `roleArn`: 阿里云 OSS 临时授权访问的角色 ARN。 This parameter is only applicable to the Flexible Classroom v1.1.0 or later.
      - `roleSessionName`: 阿里云 OSS 标识临时访问凭证的名称。 This parameter is only applicable to the Flexible Classroom v1.1.0 or later.
         <div class="alert info">对于如何获取这些信息，请查看<a href="https://help.aliyun.com/product/31815.html?spm=a2c4g.11186623.3.1.711a65d3R4TYEh" target="_blank">阿里云 OSS 官方文档</a>。</div>
   - If you use Amazon S3, fill in the following information:
      - `region`: Amazon S3 中创建 Bucket 时指定的数据中心所在区域。
      - `endpoint`: Amazon S3 的访问域名，例如 `s3.us-east-2.amazonaws.com`。
      - `Bucket`: The bucket name in Amazon S3.
      - `folder`: Amazon S3 中的资源存放路径，例如 `whiteboard`。
      - `accessKey`: The Access Key provided by Amazon S3, which is used to identify visitors.
      - `secretKey`: The Secret Key provided by Amazon S3, which is used to authenticate signatures.
         <div class="alert info">对于如何获取这些信息，请查看<a href="https://docs.aws.amazon.com/zh_cn/AmazonS3/latest/userguide/Welcome.html" target="_blank">Amazon S3 官方文档</a>。</div>

## 配置录制功能

The default recording behavior in Flexible Classroom is: Record the audio and video of teachers in a classroom in <a href="/cn/cloud-recording/cloud_recording_composite_mode?platform=RESTful" target="_blank">composite recording mode</a>. Your recorded files are be stored in Agora's Amazon S3 account.

To change the default  behavior, find the cloud recording module on the **Flexible Classroom configuration** page in Agora Console, and pass in JSON objects:

![](https://web-cdn.agora.io/docs-files/1641368314262)

### Recording configuration

Pass in the `recordingConfig` JSON object. For parameter descriptions, see <a href="/cn/cloud-recording/cloud_recording_api_start?platform=RESTful#recordingConfig" target="_blank">recordingConfig</a>.

An example of the `recordingConfig` JSON object:

```json
"recordingConfig": {
    "maxIdleTime": 30,
    "streamTypes": 2,
    "channelType": 0
}
```

### Storage configuration

Pass in the `storageConfig` JSON object for storing recorded files. For parameter descriptions, see <a href="/cn/cloud-recording/cloud_recording_api_start?platform=RESTful#storageConfig" target="_blank">storageConfig</a>.
- `endpoint` :（必填）String 类型，由阿里云 Bucket 名称和访问域名拼成的完整路径。 Suppose your bucket name is `"agora-whiteboard"` and your access domain is `"oss-cn-shanghai.aliyuncs.com"`, set `endpoint` as `"https://agora-whiteboard.oss-cn-shanghai. aliyuncs.com"`.
- `fileNamePrefix`: （选填）String 数组，指定录制文件在第三方云存储中的存储位置。 你可使用变量来指定一个动态路径。 你发起录制时，灵动课堂云服务会用真实的值替换变量。 详见[如何指定动态存储路径](/cn/live-streaming/faq/agora_class_dynamic_addr)。

An example of the `storageConfig` JSON object:

```json
"storageConfig": {
    "vendor": 2,
    "region": 3,
    "bucket": "xxxxx",
    "accessKey": "xxxxxxf",
    "secretKey": "xxxxx",
    "endpoint": "https://agora-recording.oss-cn-shanghai.aliyuncs.com",
    "fileNamePrefix": [
        "scenario",
        "recording"
    ]
}
```

## 配置环信 IM

灵动课堂集成了环信 IM SDK 实现实时消息功能。 因此，如需使用灵动课堂中的实时消息功能，你需要进行以下操作：

1. 注册<a href="https://console.easemob.com/user/register" target="_blank"></a>
2. 在环信开发者管理后台创建应用</a>，参考<a href="https://docs-im.easemob.com/im/quickstart/guide/experience#创建应用" target="_blank"></a>
3. 在环信开发者管理后台获取以下信息后填写在 Agora 控制台**灵动课堂配置**页面中。 ![](
   https://web-cdn.agora.io/docs-files/1624525178299)
   - `apiHost`:（必填）环信 REST API 访问地址，例如 a1.easemob.com 或 a1.easecdn.com，你可在环信开发者管理后台获取。
   - `orgName`:（必填）企业的唯一标识，你在环信开发者管理后台注册账号时填写的企业 ID。
   - `appName`:（必填）企业下 App 的唯一标识，你在环信开发者管理后台创建应用时填写的应用名称。
   - `superAdmin`:（必填）超级管理员用户名前缀。 **只支持数字或字母，不支持特殊字符，aPaaS 会以 `${superAdmin}-${timestamp}` 作为超级管理员创建 IM 房间。**
   - `appKey`:（必填）App 的唯一标识，由环信开发者管理后台基于 `${org_name}#${app_name} `的规则生成。
   - `clientId`:（必填）开发者 Client ID，由环信开发者管理后台生成。
   - `clientSecret`:（必填）开发者密钥，由环信开发者管理后台生成。

   你可参考下图获取这些信息。

   ![](https://web-cdn.agora.io/docs-files/1624525158077)
   ![](https://web-cdn.agora.io/docs-files/1620822526000)