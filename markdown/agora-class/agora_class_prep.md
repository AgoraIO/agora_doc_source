---
title: 灵动课堂前提条件
platform: Web
updatedAt: 2021-04-01 08:10:50
---
在接入声网灵动课堂前，你需要先完成以下准备工作。

## <a name="step1"></a>1. 创建 Agora 项目并获取 App ID 和 App 证书

在开始使用 Agora 服务之前，你需要注册一个 Agora [开发者账号](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up)。成功注册后，按照以下步骤，在 Agora 控制台创建一个 Agora 项目并获取该项目的 App ID 和 App 证书。

1. 登录 [Agora 控制台](https://console.agora.io/)，点击左侧导航栏**项目管理**按钮进入**[项目管理](https://console.agora.io/projects)**页面。

2. 在**项目管理**页面，点击**创建**按钮。

   ![创建项目](https://web-cdn.agora.io/docs-files/1594287028966)

3. 在弹出的对话框内输入**项目名称**，鉴权机制**必须为 APP ID + Token**。

4. 点击**提交**，新建的项目就会显示在**项目管理**页中。

5. Agora 会给每个项目自动分配一个 App ID 作为项目唯一标识。在**项目管理**页面，找到你刚刚创建的项目，点击 App ID 右侧的眼睛图标就可以直接复制此项目的 App ID。你需要保存此 App ID，后续生成 RTM Token 以及调用 API 时都需要用到。

   ![获取appid](https://web-cdn.agora.io/docs-files/1603974707121)

6. 点击该项目的**编辑**按钮进入**项目编辑**页面，点击主要证书右侧的眼睛图标就可以直接复制此项目的 App 证书。你需要保存此 App 证书，后续生成 RTM Token 进行鉴权时需要用到。

  ![获取app证书](https://web-cdn.agora.io/docs-files/1611024919891)

## <a name="step2"></a>2. 获取 Netless 的 AppIdentifier 和 sdkToken

声网灵动课堂集成了 Netless 的白板 SDK 以实现互动白板功能。因此，你需要注册一个 Netless [开发者账号](https://console.netless.link)，成功注册后，按照以下步骤获取 Netless 的 AppIdentifier 和 sdkToken：

1. 登录 [Netless 控制台](https://console.netless.link/)，点击左侧导航栏**应用管理**按钮，复制并保存此 AppIdentifier。

   ![获取 AppIdentifier](https://web-cdn.agora.io/docs-files/1603975237931)

2. 点击默认项目的**配置**按钮，点击**生成 sdkToken**，然后复制并保存此 sdkToken。

   ![获取 sdktoken](https://web-cdn.agora.io/docs-files/1603975258941)

## <a name="step3"></a>3. 开通第三方云存储账号

声网灵动课堂中的互动白板和云端录制功能都需要使用第三方云存储用于储存课堂文件和录制文件。因此，在使用声网灵动课堂前，你需要开通一个第三方云存储账号。Agora 建议使用[阿里云 OSS](https://www.aliyun.com/product/oss)，请参考[阿里云官方文档](https://help.aliyun.com/product/31815.html?spm=5176.7933691.J_1309819.8.2e392a66QiJZD3)开通阿里云 OSS 服务。

## <a name="step4"></a>4. 在 Agora 控制台进行配置灵动课堂

参考以下步骤在 Agora 控制台对声网灵动课堂的白板和云端录制功能进行配置。

1. 登录 [Agora 控制台](https://console.agora.io/)，进入**项目管理**页面，找到你刚刚创建的项目，点击该项目的**编辑**按钮进入**项目编辑**页面，然后点击 **aPaaS 配置**按钮。

  ![apaas配置](https://web-cdn.agora.io/docs-files/1611024994160)

2. 进入 aPaaS 配置页面，勾选白板和云端录制开通这两个功能，然后参考下文分别传入相应的 JSON 配置对象，点击**更新**。返回**项目管理**页面后，再点击**保存**以确保 aPaaS 配置生效。

  ![apaas配置](https://web-cdn.agora.io/docs-files/1611025023884)

### 白板

白板的 JSON 配置对象包含以下字段：

| 字段    | 类型   | 描述                                                         |
| :------ | :----- | :----------------------------------------------------------- |
| `appId` | string | （必填）你在[第 2 步](#step2)获取到的白板 Netless 的 AppIdentifier。如不设置，则无法进入灵动课堂。 |
| `token` | string | （必填）你在[第 2 步](#step2)获取到的白板 Netless 的 sdkToken。如不设置，则无法进入灵动课堂。 |
| `oss`   | object | （选填）阿里云 OSS 配置，用于储存你在课堂中上传的课件。如不设置，则无法使用白板中的课件上传功能。包含以下字段：<li>`region`: String 类型，阿里云 OSS 指定的地区信息，例如 `"oss-cn-shanghai"`。<li>`bucket`: String 类型，阿里云 OSS 的 bucket 名称，例如 `"agora-whiteboard"`。<li>`folder`: String 类型，阿里云 OSS 中的资源路径，例如 `"whiteboard"`。<li>`accessKey`：String 类型，阿里云访问密钥 AccessKey 中的 `AccessKeyId`。详见[阿里云文档](https://help.aliyun.com/document_detail/53045.html)。<li>`secretKey`：String 类型，阿里云访问密钥 AccessKey 中的 `AccessKeySecret`。详见[阿里云文档](https://help.aliyun.com/document_detail/53045.html)。<li>`endpoint`: String 类型，由阿里云 bucket 名称和[访问域名](https://help.aliyun.com/document_detail/31837.html?spm=a2c4g.11186623.6.625.49002345WzP07l)拼成的完整路径，例如 "https://agora-whiteboard.oss-cn-shanghai.aliyuncs.com"。<p>**注意事项**：当前白板只支持阿里云 OSS。 |

白板 JSON 示例：

```
{
        "appId": "<your_whiteboard_app_id>",
        "token": "<your_whiteboard_sdk_token>",
        "oss": {
            "region": "oss-cn-shanghai",
            "bucket": "<bucket_name>",
            "folder": "whiteboard",
            "accessKey": "<AK>",
            "secretKey": "<SK>",
            "endpoint": "https://agora-whiteboard.oss-cn-shanghai.aliyuncs.com"
        }
 }
```

### 云端录制

云端录制的 JSON 配置对象包含以下字段：

| 字段              | 类型   | 描述                                                         |
| :---------------- | :----- | :----------------------------------------------------------- |
| `recordingConfig` | object | （选填）录制设置。如不设置，则使用[合流录制模式](https://docs.agora.io/cn/Agora%20Platform/composite_recording_mode)且只录制老师的音视频。如需更改录制行为，请参考[云端录制设置](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#recordingConfig)。 |
| `storageConfig`   | object | （选填）云存储设置，用于储存你的录制文件。如不设置，你的录制文件会存储在 Agora 的阿里云 OSS 账号中。如需使用你自己的云存储，请参考[云存储设置](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#storageConfig)进行配置。 |

云端录制 JSON 示例

```
{
        "recordingConfig": {},
        "storageConfig": {
            "vendor": 2,
            "region": 3,
            "bucket": "<your_bucket_name>",
            "accessKey": "<your_access_key>",
            "secretKey": "<your_secret_key>",
            "fileNamePrefix": ["directory1","directory2"]
            "endpoint": "https://agora-adc-artifacts.oss-accelerate.aliyuncs.com"
        }
}
```

## <a name="step5"></a>5. 生成 RTM Token

声网灵动课堂使用 RTM Token 进行鉴权。 RTM Token 是一种动态密钥，通过 Agora App ID、App 证书、UID 等参数生成，安全性较高。

- 在项目测试阶段，你可以使用 Agora 提供的[临时 RTM Token 生成器](https://webdemo.agora.io/token-builder/)，传入你在[第 1 步](#step1)获取到的 App ID、App 证书和 UID，快速生成一个临时 RTM Token，有效期为 24 小时。
- 正式生产环境中，你需要在你的服务端部署一个 RTM Token 生成器。用户进入课堂时，客户端需要向服务端申请 RTM Token；服务端生成 RTM Token 后，再将其传给客户端。详情请参考[生成 RTM Token](https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms) 文档。