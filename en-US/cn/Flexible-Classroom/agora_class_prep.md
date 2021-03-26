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

   ![GetAppIdentifier](https://web-cdn.agora.io/docs-files/1603975237931)

2. Click the **configuration **button of the default project, click** Generate sdkToken**, and then copy and record the sdkToken. 后续在 Agora 控制台配置灵动课堂时需要传入。

   ![Getsdktoken](https://web-cdn.agora.io/docs-files/1603975258941)

<a name="step3"></a>
## 3. Third-party cloud storage service

Both the interactive whiteboard and cloud recording functions of Agora Flexible Classroom require third-party cloud storage for storing class files and recorded files. Therefore, you need to sign up for a third-party cloud storage account before using Agora Flexible Classroom. Agora recommends using[ Alibaba Cloud OSS](https://www.aliyun.com/product/oss). See the [Alibaba Cloud documents](https://help.aliyun.com/product/31815.html?spm=5176.7933691.J_1309819.8.2e392a66QiJZD3) for using Alibaba Cloud OSS.

<a name="step4"></a>
## 4. Configure Flexible Classroom in Agora Console

Configure the whiteboard and cloud recording functions in Agora Console, as follows:

1. Log in [to Agora Console ](https://console.agora.io/)and enter the **project management **page. Find the project you create, click the **edit **button of this project to enter the **project edit** page. Click the** aPaaS configuration **button.

![aPaaSconfiguration](https://web-cdn.agora.io/docs-files/1611024994160)

2. On the aPaaS Configuration page, **select the** tickbox next to Whiteboard and Cloud recording to enable these two functions, and pass in JSON objects to configure these two functions according to the following **table**. After returning to the **project management **page, click **Save** to ensure the aPaaS configuration takes effect.

![aPaaSconfiguration](https://web-cdn.agora.io/docs-files/1611025023884)

### Whiteboard

The JSON object for whiteboard contains the following fields:

| Field | Type | Description |
| :------ | :----- | :----------------------------------------------------------- |
| `appId` | string | (Required) TheNetless[](#step2) AppIdentifier that you get in Step 2. If you do not set this parameter, you cannot enter a classroom. |
| `token` | string | (Required) The[](#step2) Netless sdkToken that you get in Step 2. If you do not set this parameter, you cannot enter a classroom. |
| `oss` | object | (Optional) Alibaba Cloud OSS configuration, used for storing the files you upload in a classroom. If you do not set this parameter, you cannot upload any file in a classroom. It contains the following fields:<li>`region`: String. The service` region of Alibaba Cloud OSS, such as "oss-cn-shanghai"`.<li>`Bucket`: String. The bucket name of Alibaba Cloud OSS, such as `"agora-whiteboard"`.<li>`folder`: String. The resource path in Alibaba Cloud OSS, such as `"whiteboard"`.<li>`accessKey`: String. Corresponds to the` AccessKeyId in the AccessKey of Alibaba Cloud. For details, see Alibaba Cloud's documentation`. 详见[阿里云文档](https://help.aliyun.com/document_detail/53045.html)。<li>`accessKey`: String. Corresponds to the` AccessKeySecret in the AccessKey of Alibaba Cloud. For details, see Alibaba Cloud's documentation`. 详见[阿里云文档](https://help.aliyun.com/document_detail/53045.html)。<li>`endpoint`: String. The access[ endpoint of Alibaba Cloud OSS](https://help.aliyun.com/document_detail/31837.html?spm=a2c4g.11186623.6.625.49002345WzP07l), such as `"oss-cn-shanghai.aliyuncs.com"`.<p>**Note**: Whiteboard only supports Alibaba Cloud OSS. |

Whiteboard JSON example:

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

### Cloud recording

The JSON object for cloud recording contains the following fields:

| Field | Type | Description |
| :---------------- | :----- | :----------------------------------------------------------- |
| `recordingConfig` | object | (Optional) Recording configuration. If you do not set this parameter, Agora [Flexible Classroom ](https://docs.agora.io/cn/Agora%20Platform/composite_recording_mode)records the audio and video of the teachers in composite recording mode by default. To change the recording behavior, see [cloud recording configuration](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#recordingConfig). |
| `storageConfig` | object | (Optional) Cloud storage configuration, used for storing your recorded files. If you do not set this parameter, your recorded files will be stored in Agora's Alibaba Cloud OSS account. To use your own cloud storage account, see the [cloud storage configuration](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#storageConfig).<p>**Note:The **`endpoint `field in `storageConfig` is a path concatenating the bucket name and [access domain of Alibaba ](https://help.aliyun.com/document_detail/31837.html?spm=a2c4g.11186623.6.625.49002345WzP07l)Cloud OSS. Suppose your bucket name is `"agora-whiteboard"` and your access domain is `"oss-cn-shanghai.aliyuncs.com"`, set  `endpoint` as `"https://agora-whiteboard.oss-cn-shanghai. aliyuncs.com"` |

Cloud recording JSON example

```json
{
        "recordingConfig": {},
        storageConfig
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
## 5. Generate an RTM Token

Agora Flexible Classroom uses the RTM Token for authentication. The RTM token is generated dynamically with the parameters including the Agora App ID, App Certificate, and User ID, which is highly secure.

- When testing your app, you can use the[ Temporary RTM Token Generator](https://webdemo.agora.io/token-builder/) provided by Agora and pass[ the App ID and App Certificate that you get in Step 1](#step1), and a user ID to generate a temporary RTM Token with a validity period of 24 hours.
<div class="alert info">UID 为一个不超过 64 字节的字符串。 以下为支持的字符集范围:<ul><li>All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z.</li><li>All numeric characters: </li><li>0-9</li><li>The space character.</li><li>- Punctuation characters and other symbols, including: "!", "#", "$", "%", "&amp;", "(", ")", "+", "-", ":", ";", "&lt;", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".</li></ul></div>
For the development environment, you need to deploy an RTM token generator on your server. When a user enters the classroom, the client needs to apply for an RTM token from the server. After the server generates an RTM token, the sever passes it to the client. 详情请参考[生成 RTM Token](https://docs.agora.io/cn/Real-time-Messaging/token_server_rtm?platform=All%20Platforms) 文档。