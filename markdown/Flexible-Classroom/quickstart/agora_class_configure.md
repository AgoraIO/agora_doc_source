本文介绍如何在声网控制台配置灵动课堂中的互动白板、实时录制和实时消息功能。

<div class="alert info">阅读本文前，请确保你已在声网控制台<a href="/cn/agora-class/agora_class_enable?platform=Web" target="_blank">开通灵动课堂服务</a>。</div>

## 配置白板功能

如需在灵动课堂中上传 PPT、Word、PDF 等课件并在课堂白板上展示，你需要在声网控制台配置灵动课堂中的互动白板功能。

### 前提条件

互动白板功能使用第三方云存储服务储存在课堂中上传的文件。因此，使用互动白板功能前，请确保你已开通第三方云存储服务。声网当前支持<a href="https://www.aliyun.com/product/oss" target="_blank">阿里云 OSS</a> 和 <a href="https://aws.amazon.com/cn/s3/?nc2=h_m1" target="_blank">Amazon S3</a>。

### 操作步骤

在**灵动课堂配置**页面，找到白板模块，如下图所示：

![](https://web-cdn.agora.io/docs-files/1673418335384)

你需要进行以下操作：

1. 配置第三方云存储信息用于储存在课堂中上传的文件。

   - 如果你使用阿里云 OSS，填写以下信息：
     - `region`: String 型，阿里云 OSS 中创建 Bucket 时指定的数据中心所在区域，例如 `oss-cn-shanghai`。
     - `endpoint`: String 型，阿里云 OSS 的访问域名，例如 `oss-cn-shanghai.aliyuncs.com`。
     - `bucket`: String 型，阿里云 OSS 中的 Bucket 名称，例如 `agora-whiteboard`。
     - `folder`: String 型，阿里云 OSS 中的资源存放路径，例如 `whiteboard`。
     - `accessKey`: String 型，阿里云 OSS 临时访问密钥 STS Access Key 的 AccessKeyId。
     - `secretKey`: String 型，阿里云 OSS 临时访问密钥 STS Access Key 的 AccessKeySecret。
     <div class="alert info">对于如何获取上述信息，请查看<a href="https://www.alibabacloud.com/help/zh/object-storage-service/latest/use-a-temporary-credential-provided-by-sts-to-access-oss">阿里云官方文档</a>。</div>

   - 如果你使用 Amazon S3，填写以下信息：
     - `region`: String 型，Amazon S3 中创建 Bucket 时指定的数据中心所在区域。
     - `endpoint`: String 型，Amazon S3 的访问域名。
     - `bucket`: String 型，Amazon S3 中的 Bucket 名称。
     - `folder`: String 型，Amazon S3 中的资源存放路径，例如 `agora-whiteboard`。
     - `accessKey`: String 型，Amazon S3 提供的访问密钥中的 Access Key，用于识别访问者的身份。
     - `secretKey`: String 型，Amazon S3 提供的访问密钥中的 Secret Key，用于验证签名的密钥。
     <div class="alert info">对于如何获取上述信息，请查看 <a href="https://docs.aws.amazon.com/general/latest/gr/s3.html" target="_blank">Amazon S3 官方文档</a>。</div>

2. 如果你需要在课堂里使用 PPT、DOC、PDF 等格式的课件，你还需要点击**进阶服务**下方的**前往配置**，来为灵动课堂开启并配置文档转网页、文档转图片、截图服务。操作步骤详见<a href="/cn/whiteboard/enable_whiteboard#开启互动白板配套服务" target="_blank">开启互动白板配套服务</a>。

## 配置录制功能

灵动课堂中默认录制行为是：使用<a href="/cn/cloud-recording/cloud_recording_composite_mode?platform=RESTful" target="_blank">合流录制模式</a>且只录制老师的音视频，录制文件会存储在声网的阿里云 OSS 账号中。

如需修改上述行为，你可在声网控制台**灵动课堂配置**页面找到云录制模块，分别传入 JSON 对象进行配置：

![](https://web-cdn.agora.io/docs-files/1641291167789)

### 录制配置

传入 `recordingConfig` JSON 对象。参考 <a href="/cn/cloud-recording/cloud_recording_api_start?platform=RESTful#recordingConfig" target="_blank">recordingConfig 介绍</a>。

`recordingConfig` JSON 对象示例：

```json
{
    "maxIdleTime": 30,
    "streamTypes": 2,
    "channelType": 0
}
```

### 录制文件存储配置

传入 `storageConfig` JSON 对象用于存储录制文件。参考 <a href="/cn/cloud-recording/cloud_recording_api_start?platform=RESTful#storageConfig" target="_blank">storageConfig 介绍</a>，请注意以下字段的设置：
  - `endpoint`:（必填）String 类型，由 Bucket 名称和访问域名拼成的完整路径。假设你的 Bucket 名称为 `"agora-recording"`，OSS 访问域名为 `"oss-cn-shanghai.aliyuncs.com"`，则 `endpoint` 字段设为 `"https://agora-recording.oss-cn-shanghai.aliyuncs.com"`。
  - `fileNamePrefix`:（选填）String 数组，指定录制文件在第三方云存储中的存储位置。你可使用变量来指定一个动态路径。你发起录制时，灵动课堂云服务会用真实的值替换变量。详见[如何指定动态存储路径](/cn/agora-class/faq/agora_class_dynamic_addr)。

`storageConfig` JSON 对象示例：

```json
{
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

灵动课堂集成了环信 IM SDK 实现实时消息功能。因此，如需使用灵动课堂中的实时消息功能，你需要进行以下操作：

1. 注册<a href="https://console.easemob.com/user/register" target="_blank">环信即时通讯云</a>。
2. 在环信开发者管理后台创建应用</a>，参考<a href="https://docs-im.easemob.com/im/quickstart/guide/experience#创建应用" target="_blank">创建应用</a>。
3. 在环信开发者管理后台获取以下信息后填写在声网控制台**灵动课堂配置**页面中。
   ![](https://web-cdn.agora.io/docs-files/1641291229597)
   - `apiHost`:（必填）环信 REST API 访问地址，例如 a1.easemob.com 或 a1.easecdn.com，你可在环信开发者管理后台获取。
   - `orgName`:（必填）企业的唯一标识，你在环信开发者管理后台注册账号时填写的企业 ID。
   - `appName`:（必填）企业下 App 的唯一标识，你在环信开发者管理后台创建应用时填写的应用名称。
   - `superAdmin`:（必填）超级管理员用户名前缀。**只支持数字或字母，不支持特殊字符，aPaaS 会以 `${superAdmin}-${timestamp}` 作为超级管理员创建 IM 房间。**
   - `appKey`:（必填）App 的唯一标识，由环信开发者管理后台基于 `${org_name}#${app_name} `的规则生成。
   - `clientId`:（必填）开发者 Client ID，由环信开发者管理后台生成。
   - `clientSecret`:（必填）开发者密钥，由环信开发者管理后台生成。

   你可参考下图获取这些信息。

   ![](https://web-cdn.agora.io/docs-files/1631178001176)
   ![](https://web-cdn.agora.io/docs-files/1631178086130)



## 注意事项

~4c2dbcc0-d2a7-11ec-8e95-1b7dfd4b7cb0~
