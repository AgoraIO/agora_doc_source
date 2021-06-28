# 配置 aPaaS 服务

使用 Agora 灵动课堂前，你需要先在 Agora 控制台配置 aPaaS 服务。

## 前提条件

配置 aPaaS 服务前，请确保已经具备以下条件：

- 创建一个 Agora 开发者账号，并创建 Agora 项目，详见[开始使用 Agora 平台](/cn/Agora%20Platform/get_appid_token)。
- 开启 Agora 互动白板服务，并获取白板的 App Identifier 和 SDK Token，详见[开启和配置互动白板服务](/cn/whiteboard/enable_whiteboard)。
- 第三方云存储账号。灵动课堂中的互动白板和云端录制功能都需要使用第三方云存储用于储存课堂文件和录制文件。当前互动白板功能仅支持阿里云 OSS，请参考[阿里云官方文档](https://help.aliyun.com/product/31815.html?spm=5176.7933691.J_1309819.8.2e392a66QiJZD3)开通阿里云 OSS 服务。

## 配置 aPaaS 服务

参考以下步骤在 Agora 控制台配置 aPaaS 服务。

1. 登录 Agora 控制台，进入**[项目管理](https://console.agora.io/projects)**页面。点击 Agora 项目的**编辑**按钮进入**项目编辑**页面，然后点击 **aPaaS 配置**按钮。

  ![项目管理页面](https://web-cdn.agora.io/docs-files/1611024994160)

2. 在 aPaaS 配置页面，勾选白板和云端录制选择框。

  ![apaas配置](https://web-cdn.agora.io/docs-files/1611025023884)

3. 将下文的 JSON 对象示例分别粘贴至编辑框并替换相应参数以配置白板和云端录制功能，然后点击**更新**。

   - 白板 JSON 示例：

     ```json
     {
             "appId": "<your_whiteboard_app_id>",
             "token": "<your_whiteboard_sdk_token>",
             "oss": {
                 "region": "oss-cn-shanghai",
                 "bucket": "<your_bucket_name>",
                 "folder": "whiteboard",
                 "accessKey": "<your_access_key>",
                 "secretKey": "<your_secret_key>",
                 "endpoint": "oss-cn-shanghai.aliyuncs.com"
             }
      }
     ```

     > 查看[配置参数具体介绍](#reference)。

   - 云端录制 JSON 示例：

     ```json
     {
             "recordingConfig": {},
             "storageConfig": {
                 "vendor": 1,
                 "region": 1,
                 "bucket": "<your_bucket_name>",
                 "accessKey": "<your_access_key>",
                 "secretKey": "<your_secret_key>",
                 "fileNamePrefix": ["directory1","directory2"],
                 "endpoint": ""
               }
     }
     ```

     > 查看[配置参数具体介绍](#reference)。

4. 返回**项目管理**页面后，再点击**保存**以确保 aPaaS 配置生效。

<a name="reference"></a>

## 更多信息

- 互动白板的 JSON 配置对象包含以下字段：

  | 字段    | 类型   | 描述                                                         |
  | :------ | :----- | :----------------------------------------------------------- |
  | `appId` | String | （必填）你获取到的互动白板 App Identifier。如不设置，则无法进入灵动课堂。 |
  | `token` | String | （必填）你获取到的互动白板 SDK Token。如不设置，则无法进入灵动课堂。 |
  | `oss`   | Object | （选填）阿里云 OSS 配置，用于储存你在课堂中上传的课件。如不设置，则无法使用白板中的课件上传功能。<p>**注意事项**：当前白板只支持阿里云 OSS。<p>JSON 对象包含以下字段：<ul><li>`region`: String 型，阿里云 OSS 指定的地区信息，例如 `"oss-cn-shanghai"`。</li><li>`bucket`: String 型，阿里云 OSS 的 Bucket 名称，例如 `"agora-whiteboard"`。</li><li>`folder`: String 型，阿里云 OSS 中的资源路径，例如 `"whiteboard"`。</li><li>`accessKey`：String 型，阿里云访问密钥 AccessKey 中的 `AccessKeyId`，详见[阿里云文档](https://help.aliyun.com/document_detail/53045.html)。仅适用于灵动课堂 1.1.0 之前版本。</li><li>`secretKey`：String 型，阿里云访问密钥 AccessKey 中的 `AccessKeySecret`，详见[阿里云文档](https://help.aliyun.com/document_detail/53045.html)。仅适用于灵动课堂 1.1.0 之前版本。</li><li>`endpoint`: String 型，阿里云 OSS [访问域名](https://help.aliyun.com/document_detail/31837.html?spm=a2c4g.11186623.6.625.49002345WzP07l)，例如 `"oss-cn-shanghai.aliyuncs.com"`。<li>`ramAccessKey`: String 型，阿里云临时访问密钥 STS AK 的 `AccessKeyId`。详见[阿里云文档](https://www.alibabacloud.com/help/doc-detail/100624.htm?spm=a2c63.p38356.b99.135.48b226dcvXg2Yw)。仅适用于灵动课堂 1.1.0 及之后版本。</li><li>`ramAccessSecret`: String 型，阿里云临时访问密钥 STS AK 的 `AccessKeySecret`，详见[阿里云文档](https://www.alibabacloud.com/help/doc-detail/100624.htm?spm=a2c63.p38356.b99.135.48b226dcvXg2Yw)。仅适用于灵动课堂 1.1.0 及之后版本。</li><li>`roleArn`: String 型，阿里云 OSS 临时授权访问的角色 ARN，详见[阿里云文档](https://www.alibabacloud.com/help/doc-detail/100624.htm?spm=a2c63.p38356.b99.135.48b226dcvXg2Yw)。仅适用于灵动课堂 1.1.0 及之后版本。</li><li>`roleSessionName`: （必填）String 型，阿里云 OSS 标识临时访问凭证的名称，详见[阿里云文档](https://www.alibabacloud.com/help/doc-detail/100624.htm?spm=a2c63.p38356.b99.135.48b226dcvXg2Yw)。仅适用于灵动课堂 1.1.0 及之后版本。</li></ul> |

- 云端录制的 JSON 配置对象包含以下字段：

  | 字段              | 类型   | 描述                                                         |
  | :---------------- | :----- | :----------------------------------------------------------- |
  | `recordingConfig` | Object | （选填）录制设置。如不设置，则使用[合流录制模式](https://docs.agora.io/cn/Agora%20Platform/composite_recording_mode)且只录制老师的音视频。如需更改录制行为，请参考[云端录制设置](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#recordingConfig)。 |
  | `storageConfig`   | Object | （选填）云存储设置，用于储存你的录制文件。如不设置，你的录制文件会存储在 Agora 的阿里云 OSS 账号中。如需使用你自己的云存储，请参考[云存储设置](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#storageConfig)进行配置。<p>**注意事项**：`storageConfig` 中的 `endpoint` 字段为由阿里云 Bucket 名称和[访问域名](https://help.aliyun.com/document_detail/31837.html?spm=a2c4g.11186623.6.625.49002345WzP07l)拼成的完整路径。假设你的 Bucket 名称为 `"agora-whiteboard"`，阿里云 OSS 访问域名为 `"oss-cn-shanghai.aliyuncs.com"`，则 `endpoint` 字段设为 `"https://agora-whiteboard.oss-cn-shanghai.aliyuncs.com"`。 |
