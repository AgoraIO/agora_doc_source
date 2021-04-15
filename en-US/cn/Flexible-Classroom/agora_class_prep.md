This page lists all the prerequisites required for using Flexible Classroom.

## 1. Create an Agora project and get the Agora App ID and App Certificate

Before using Agora services, you need to sign up for an Agora [developer account](https://docs.agora.io/en/Agora%20Platform/sign_in_and_sign_up). After signing up for an Agora account, follow these steps to create an Agora project and get the Agora App ID and App Certificate in Agora Console.

1. Log into [Agora Console](https://console.agora.io/), click the **Project Management** button in the left navigation menu to enter the [Project Management](https://console.agora.io/projects) page.

2. Click **create** on the **Project Management** page.

   ![create-project](https://web-cdn.agora.io/docs-files/1594287028966)

3. Enter your **project name**, and select **Secure mode: APP ID + Token** for the authentication mechanism in the pop-up window.

4. Click **Submit**. You can see the created project on the **Project Management** page.

5. Agora automatically assigns each project an App ID as a unique identifier. To copy this App ID, find your project on the **Project Management** page in Agora Console, and click the eye icon to the right of the App ID. Make a note of this App ID for generating an RTM Token and calling API methods later.

   ![get-app-id](https://web-cdn.agora.io/docs-files/1603974707121)

6. Click the **edit** button of your project and enter the **Project Edit** page. Click the eye icon to the right of the primary certificate to copy the App Certificate of this project. Make a note of the App Certificate for generating an RTM Token later.

![get-app-certificate](https://web-cdn.agora.io/docs-files/1611024919891)

## 2. Get the App Identifier and SDK Token of the Agora Interactive Whiteboard service

Flexible Classroom integrates the Agora Interactive Whiteboard SDK for implementing the interactive whiteboard function. Contact [support@agora.io](mailto:support@agora.io) to get an App Identifier and a SDK Token for using the Agora Interactive Whiteboard service.

## 3. Enable a third-party cloud storage service

Both the interactive whiteboard and cloud recording functions in Flexible Classroom require third-party cloud storage for storing class files and recorded files. Therefore, you need to sign up for a third-party cloud storage account before using Flexible Classroom. Agora recommends using [Alibaba Cloud OSS](https://www.alibabacloud.com/product/oss?spm=a3c0i.11270126.5942891490.41.355d5f93Nw3YOG). For how to use Alibaba Cloud OSS, see the [documents](https://www.alibabacloud.com/help/product/31815.htm?spm=a3c0i.7950270.1834322160.3.1276ab91D4dLl7) of Alibaba Cloud.

## 4. Configure Flexible Classroom in Agora Console

Configure the interactive whiteboard and cloud recording functions in Agora Console, as follows:

1. Log into [Agora Console](https://console.agora.io/) and enter the **project management** page. Find the project you create, click the **edit** button of this project to enter the **project edit** page. Click the **aPaaS configuration** button.

![project-management](https://web-cdn.agora.io/docs-files/1611024994160)

2. On the aPaaS Configuration page,select the **tick box** next to Whiteboard and Cloud recording to enable these two functions, pass in JSON objects to configure these two functions according to the following table, and click **Update**. After returning to the **project management** page, click **Save** to ensure the aPaaS configuration takes effect.

![apaas-configuration](https://web-cdn.agora.io/docs-files/1611025023884)

### Interactive whiteboard

The JSON object for the interactive whiteboard function contains the following fields:

| Field Name | Type | Description |
| :------ | :----- | :----------------------------------------------------------- |
| `appId` | String | (Required) The App Identifier of the Interactive Whiteboard service that you get in the [previous step](#2-get-the-app-identifier-and-sdk-token-of-the-agora-interactive-whiteboard-service). If you do not set this parameter, you cannot enter a classroom. |
| `token` | String | (Required) The SDK Token of the Interactive Whiteboard service that you get in the [previous step](#2-get-the-app-identifier-and-sdk-token-of-the-agora-interactive-whiteboard-service). If you do not set this parameter, you cannot enter a classroom. |
| `oss` | Object | (Optional) The configuration of Alibaba Cloud OSS for storing the files you upload in a classroom. If you do not set this parameter, you cannot upload any file in a classroom. The JSON object contains the following fields:<li>`region`: String. The service region in Alibaba Cloud OSS, such as `"oss-cn-shanghai"`.<li>`Bucket`: String. The bucket name in Alibaba Cloud OSS, such as `"agora-whiteboard"`.<li>`folder`: String. The resource path in Alibaba Cloud OSS, such as `"whiteboard"`.<li>`accessKey`: String.The `AccessKeyId` in the Alibaba Cloud OSS. For details, see the [documentation](https://www.alibabacloud.com/help/product/31815.htm?spm=a3c0i.7950270.1834322160.3.1276ab91D4dLl7) of Alibaba Cloud OSS.<li>`secretKey`: String. The `AccessKeySecret` in Alibaba Cloud OSS. For details, see the [documentation](https://www.alibabacloud.com/help/product/31815.htm?spm=a3c0i.7950270.1834322160.3.1276ab91D4dLl7) of Alibaba Cloud OSS.<li>`endpoint`: String. The [access endpoint](https://www.alibabacloud.com/help/product/31815.htm?spm=a3c0i.7950270.1834322160.3.1276ab91D4dLl7) of Alibaba Cloud OSS, such as `"oss-cn-shanghai.aliyuncs.com"`.<p>**Note**: Temporarily, the Agora Interactive Whiteboard service only supports Alibaba Cloud OSS. |

Example of the interactive whiteboard configuration:

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

The JSON object for the cloud recording function contains the following fields:

| Field Name | Type | Description |
| :---------------- | :----- | :----------------------------------------------------------- |
| `recordingConfig` | Object | (Optional) Recording configuration. If you do not set this parameter, Agora records the audio and video of teachers in a classroom in [composite recording mode](https://docs.agora.io/en/Agora%20Platform/composite_recording_mode) by default. To change the recording behavior, see the [cloud recording configuration](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#recordingConfig). |
| `storageConfig` | Object | (Optional) Cloud storage configuration, used for storing your recorded files. If you do not set this parameter, your recorded files will be stored in Agora's Alibaba Cloud OSS account. To use your own cloud storage account, see the [cloud storage configuration](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#storageConfig).<p>**Note**: The `endpoint` field in `storageConfig` is a path consisting of the bucket name and [access domain](https://help.aliyun.com/document_detail/31837.html?spm=a2c4g.11186623.6.625.49002345WzP07l) in Alibaba Cloud OSS. Suppose your bucket name is `"agora-whiteboard"` and your access domain is `"oss-cn-shanghai.aliyuncs.com"`, set `endpoint` as `"https://agora-whiteboard.oss-cn-shanghai.aliyuncs.com"`. |

Example of the cloud recording configuration:

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

## 5. Generate an RTM token

Flexible Classroom uses the RTM token for authentication.  The RTM token is generated dynamically with the Agora App ID, App Certificate, and a User ID.

- During the testing phase, you can use the [Temporary RTM Token Generator](https://webdemo.agora.io/token-builder/) and pass the App ID and App Certificate that you get in the [previous step](#1-create-an-agora-project-and-get-the-agora-app-id-and-app-certificate), and also a user ID to generate a temporary RTM Token with a validity period of 24 hours.
<div class="alert info">The user ID is a string smaller than 64 bytes. The scope of supported characters is:<ul><li>All lowercase English letters: a to z.</li><li>All uppercase English letters: A to Z.</li><li>All numeric characters.</li><li>0 to 9.</li><li>The space character.</li><li>"!", "#", "$", "%", "&amp;", "(", ")", "+", "-", ":", ";", "&lt;", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ","</li></ul></div>
- For the development environment, you need to deploy an RTM token generator on your server. When a user enters the classroom, the client needs to apply for an RTM token from the server. The server generates an RTM token and passes it to the client. For details, see [Generate an RTM Token](https://docs.agora.io/en/Real-time-Messaging/token_server_rtm?platform=All%20Platforms).