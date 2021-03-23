This page includes the preparations you must make before launching a flexible classroom in your project.

<a name="step1"></a>
## 1. Create an Agora project and get the Agora App ID and App certificate

Before using Agora services, you need to sign up for [anAgora account](https://docs.agora.io/cn/Agora%20Platform/sign_in_and_sign_up). After signing up for an Agora account, follow these steps to create an Agora project and get the Agora App ID and App certificate in Agora Console.

1. Log into[ Agora Console](https://console.agora.io/), click the **Project Management **button in the left navigation menu to enter the **[Project Management](https://console.agora.io/projects)** page.

2. Click create ****on theProject **Management **page.

   ![Createproject](https://web-cdn.agora.io/docs-files/1594287028966)

3. Enter your **project name**, and select Secure mode: APP ID + Token for the authentication mechanism** in the pop-up** window.

4. Click **Submit**. You can see the created project on the **Project Management **page.

5. Agora automatically assigns each project an App ID as a unique identifier. To copy** this App ID, find your project on the Project Management** page in Agora Console, and click the eye icon to the right of the App ID. You need to make a note of this App ID for generating an RTM Token and calling API methods.

   ![GetappId](https://web-cdn.agora.io/docs-files/1603974707121)

6. Click the **edit **button of your project and enter the **project edit** page. Click the eye icon to the right of the primary certificate to copy the App Certificate of this project. Make a note of the App Certificate for generating an RTM Token.

![Getappcertificate](https://web-cdn.agora.io/docs-files/1611024919891)

<a name="step2"></a>
## 2. Get the Netless AppIdentifier and sdkToken

Agora Flexible Classroom uses the Netless Whiteboard SDK for interactive whiteboard. Therefore, you need to sign up for a Netless [account](https://console.netless.link) and get the Netless AppIdentifier and sdkToken as follows:

1. Log in to[ Netless console](https://console.netless.link/), click Application in the left navigation menu to enter **the project management **page, and make a note of the AppIdentifier. 后续在 Agora 控制台配置灵动课堂时需要传入。

   ![获取 AppIdentifier](https://web-cdn.agora.io/docs-files/1603975237931)

2. 点击默认项目的**配置**按钮，点击**生成 sdkToken**，然后复制并保存此 sdkToken。 后续在 Agora 控制台配置灵动课堂时需要传入。

   ![获取 sdktoken](https://web-cdn.agora.io/docs-files/1603975258941)

<a name="step3"></a>
## 3. 开通第三方云存储账号

灵动课堂中的互动白板和云端录制功能都需要使用第三方云存储用于储存课堂文件和录制文件。 因此，在使用灵动课堂前，你需要开通一个第三方云存储账号。 Agora 建议使用[阿里云 OSS](https://www.aliyun.com/product/oss)，请参考[阿里云官方文档](https://help.aliyun.com/product/31815.html?spm=5176.7933691.J_1309819.8.2e392a66QiJZD3)开通阿里云 OSS 服务。

<a name="step4"></a>
## 4. 在 Agora 控制台进行配置灵动课堂

参考以下步骤在 Agora 控制台对灵动课堂的白板和云端录制功能进行配置。

1. 登录 [Agora 控制台](https://console.agora.io/)，进入**项目管理**页面，找到你刚刚创建的项目，点击该项目的**编辑**按钮进入**项目编辑**页面，然后点击 **aPaaS 配置**按钮。

![apaas配置](https://web-cdn.agora.io/docs-files/1611024994160)

2. 进入 aPaaS 配置页面，**勾选**白板和云端录制以开通这两个功能，然后参考下文分别传入相应的 JSON 配置对象，点击**更新**。 返回**项目管理**页面后，再点击**保存**以确保 aPaaS 配置生效。

![apaas配置](https://web-cdn.agora.io/docs-files/1611025023884)

### 白板

白板的 JSON 配置对象包含以下字段：

| 字段 | 类型 | Description |
| :------ | :----- | :----------------------------------------------------------- |
| `appId` | string | （必填）你在[第 2 步](#step2)获取到的白板 Netless 的 AppIdentifier。 如不设置，则无法进入灵动课堂。 |
| `token` | string | （必填）你在[第 2 步](#step2)获取到的白板 Netless 的 sdkToken。 如不设置，则无法进入灵动课堂。 |
| `oss` | object | （选填）阿里云 OSS 配置，用于储存你在课堂中上传的课件。 如不设置，则无法使用白板中的课件上传功能。 包含以下字段：<li>`region`: String 类型，阿里云 OSS 指定的地区信息，例如 `"oss-cn-shanghai"`。<li>`bucket`: String 类型，阿里云 OSS 的 Bucket 名称，例如 `"agora-whiteboard"`。<li>`folder`: String 类型，阿里云 OSS 中的资源路径，例如 `"whiteboard"`。<li>`accessKey`：String 类型，阿里云访问密钥 AccessKey 中的 `AccessKeyId`。 详见[阿里云文档](https://help.aliyun.com/document_detail/53045.html)。<li>`secretKey`：String 类型，阿里云访问密钥 AccessKey 中的 `AccessKeySecret`。 详见[阿里云文档](https://help.aliyun.com/document_detail/53045.html)。<li>`endpoint`: String 类型，阿里云 OSS [访问域名](https://help.aliyun.com/document_detail/31837.html?spm=a2c4g.11186623.6.625.49002345WzP07l)，例如 `"oss-cn-shanghai.aliyuncs.com"`。<p>**注意事项**：当前白板只支持阿里云 OSS。 |

白板 JSON 示例：

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

### 云端录制

云端录制的 JSON 配置对象包含以下字段：

| 字段 | 类型 | Description |
| :---------------- | :----- | :----------------------------------------------------------- |
| `recordingConfig` | object | （选填）录制设置。 如不设置，则使用[合流录制模式](https://docs.agora.io/cn/Agora%20Platform/composite_recording_mode)且只录制老师的音视频。 如需更改录制行为，请参考[云端录制设置](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#recordingConfig)。 |
| `storageConfig` | object | （选填）云存储设置，用于储存你的录制文件。 如不设置，你的录制文件会存储在 Agora 的阿里云 OSS 账号中。 如需使用你自己的云存储，请参考[云存储设置](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#storageConfig)进行配置。<p>**注意事项**：`storageConfig` 中的 `endpoint` 字段为由阿里云 Bucket 名称和[访问域名](https://help.aliyun.com/document_detail/31837.html?spm=a2c4g.11186623.6.625.49002345WzP07l)拼成的完整路径。 假设你的 Bucket 名称为 `"agora-whiteboard"`，阿里云 OSS 访问域名为 `"oss-cn-shanghai.aliyuncs.com"`，则 `endpoint` 字段设为 `"https://agora-whiteboard.oss-cn-shanghai.aliyuncs.com"`。 |

云端录制 JSON 示例

```json
{
        "recordingConfig": {},
        "storageConfig": {
            "vendor": 2,
            "region": 1,
            "bucket": "<your_bucket_name>",
            "accessKey": "<your_access_key>",
            "secretKey": "<your_secret_key>",
            "fileNamePrefix": ["directory1","directory2"],
            "endpoint": "https://xxx.oss-cn-shanghai.aliyuncs.com"
        }
 }
```

<a name="step5"></a>
## 5. 生成 RTM Token

灵动课堂使用 RTM Token 进行鉴权。 RTM Token 是一种动态密钥，通过 Agora App ID、App 证书、UID 等参数生成，安全性较高。

- 在项目测试阶段，你可以使用 Agora 提供的[临时 RTM Token 生成器](https://webdemo.agora.io/token-builder/)，传入你在[第 1 步](#step1)获取到的 App ID 和 App 证书，然后自行填入一个 UID，快速生成一个临时 RTM Token，有效期为 24 小时。
<div class="alert info">UID 为一个不超过 64 字节的字符串。 以下为支持的字符集范围:<ul><li>26 个小写英文字母 a-z</li><li>26 个大写英文字母 A-Z</li><li>10 个数字</li><li>0-9</li><li>空格</li><li>"!", "#", "$", "%", "&amp;", "(", ")", "+", "-", ":", ";", "&lt;", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","</li></ul></div>
- 正式生产环境中，你需要在你的服务端部署一个 RTM Token 生成器。 用户进入课堂时，客户端需要向服务端申请 RTM Token；服务端生成 RTM Token 后，再将其传给客户端。 详情请参考[生成 RTM Token](https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms) 文档。