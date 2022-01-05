This article describes how to configure the interactive whiteboard, real-time recording, and real-time messaging functions in the Smart Flexible Classroom on the Agora Console console.

<div class="alert info">Before reading this article, please make sure that you have <a href="/cn/agora-class/agora_class_enable?platform=Web" target="_blank">enabled the Flexible Classroom service on the Agora Console console</a>.</div>

## Configure whiteboard

If you need to upload PPT, Word, PDF and other courseware in the Flexible Classroom and display it on the classroom whiteboard, you need to configure the interactive whiteboard function in Flexible Classroom on the Agora Console console.

### Prerequisites

The interactive whiteboard function uses a third-party cloud storage service to store files uploaded in the classroom. Therefore, before using the interactive whiteboard function, please make sure that you have activated a third-party cloud storage service. Agora currently supports<a href="https://www.aliyun.com/product/oss" target="_blank">Alibaba Cloud OSS</a> and<a href="https://aws.amazon.com/cn/s3/?nc2=h_m1" target="_blank">Amazon S3</a>

### Procedure

On the **Flexible Classroom configuration **page, find the whiteboard module, as shown in the figure below:

![](https://web-cdn.agora.io/docs-files/1624525202089)

Therefore, you need to do the following:

1. Turn on advanced services. refer to<a href="/cn/whiteboard/enable_whiteboard#开启互动白板配套服务" target="_blank">Enable server-side supporting features</a>

2. Configure third-party cloud storage information to store files uploaded in the classroom.

   - If you use Alibaba Cloud OSS, fill in the following information:
      - `region`: String. The service` region` of Alibaba Cloud OSS, such as "`oss-cn-shanghai`".
      - `endpoint`: String. The access` endpoint` of Alibaba Cloud OSS, such as "`oss-cn-shanghai.aliyuncs.com`".
      - `Bucket`: String. The bucket name of Alibaba Cloud OSS, such as "`agora-whiteboard`".
      - `folder`: String. The resource path in Alibaba Cloud OSS, such as "`whiteboard`".
      - `ramAccessKey`: String. The AccessKeyId in the STS AK of Alibaba ``Cloud OSS. This parameter is only applicable to the Flexible Classroom v1.1.0 or later.
      - `ramAccessSecret`: String. The` AccessKeySecret` in the STS AK of Alibaba Cloud OSS. For details, see the documentation of Alibaba ``Cloud OSS. This parameter is only applicable to the Flexible Classroom v1.1.0 or later.
      - roleArn: String. The `role ARN` for temporary access of Alibaba Cloud OSS. For details, see the documentation of Alibaba Cloud OSS. This parameter is only applicable to the Flexible Classroom v1.1.0 or later.
      - `roleSessionName`: (Optional) String. The name of the temporary access of Alibaba Cloud OSS. For details, see the documentation of Alibaba Cloud OSS. This parameter is only applicable to the Flexible Classroom v1.1.0 or later.
   - If you use Amazon S3, fill in the following information:
      - `region`: The` region` information specified in Amazon S3.
      - `endpoint`: The access domain name in Amazon S3.
      - `Bucket`: The name of the bucket in Amazon S3.
      - `folder`: The storage path of the resource in Amazon S3.
      - `accessKey`: The Access Key in the access key provided by Amazon S3 is used to identify the identity of the visitor.
      - `secretKey`: (Required) The Secret Key provided by the OSS provider, which is used to authenticate signatures.

## Configure cloud recording

The default recording behavior in Flexible Classroom is: use<a href="/cn/cloud-recording/cloud_recording_composite_mode?platform=RESTful" target="_blank">composite recording mode</a> only records the teacher's audio and video, and the recording file will be stored in the Alibaba Cloud OSS account of Agora.

If you need to modify the above behavior, you can find the cloud recording module on the **Flexible Classroom configuration** page of the Agora **Console console**, and pass in JSON objects for configuration:

![](https://web-cdn.agora.io/docs-files/1624525158077)

### Recording configuration

Pass in the `recordingConfig` JSON object. refer to<a href="/cn/cloud-recording/cloud_recording_api_start?platform=RESTful#recordingConfig" target="_blank">recordingConfig</a>

Example of` recordingConfig` JSON object:

```json
"recordingConfig": {
    "maxIdleTime": 30,
    "streamTypes": 2,
    "channelType": 0
}
```

### Recording file storage configuration

The `storageConfig` JSON object passed in is used to store the recording file. refer to<a href="/cn/cloud-recording/cloud_recording_api_start?platform=RESTful#storageConfig" target="_blank">Introducing storageConfig</a>, please pay attention to the settings of the following fields:
- `endpoint`: (required) String type, complete path composed of Alibaba Cloud Bucket name and access domain name. Suppose your bucket name is `"agora-whiteboard"` and your access domain is `"oss-cn-shanghai.aliyuncs.com"`, set `endpoint` as `"https://agora-whiteboard.oss-cn-shanghai. aliyuncs.com"`.
- `fileNamePrefix`: (optional) String array, specify the storage location of the recording file in the third-party cloud storage. You can use variables to specify a dynamic path. When you initiate a recording, Smart Flexible Classroom Cloud Service will replace variables with real values. See [how to specify the dynamic storage path ](/cn/live-streaming/faq/agora_class_dynamic_addr )for details.

Example of` storageConfig` JSON object:

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

## Configure ring letter IM

Flexible Classroom integrates Huanxin IM SDK to realize real-time message function. Therefore, if you need to use the real-time message function in Flexible Classroom, you need to do the following:

1. register<a href="https://console.easemob.com/user/register" target="_blank">Huanxin instant messaging cloud</a>.
2. Create an application in the backend of Huanxin Developer Management</a>, refer to<a href="https://docs-im.easemob.com/im/quickstart/guide/experience#创建应用" target="_blank">Create an application</a>.
3. Obtain the following information in the backend of Huanxin Developer Management and fill it in the Agora Console **Flexible Classroom Configuration **page. ![](
   https://web-cdn.agora.io/docs-files/1624525178299)
   - `apiHost`: (Required) The access address of Huanxin REST API, such as a1.easemob.com or a1.easecdn.com, which you can obtain from the Huanxin developer management background.
   - `orgName`: (Required) The unique identification of the company, the company ID you filled in when you registered your account in the Huanxin Developer Management Backstage.
   - `appName`: (required) the unique identifier of the app under the enterprise, which is the name of the app you filled in when you created the app in the backend of Huanxin Developer Management.
   - `superAdmin`: (Required) The prefix of the super administrator username. **Only numbers or letters are supported, and special characters are not supported. aPaaS will create an IM room **with **`${superAdmin}-${timestamp}` as the super administrator.**
   - `appKey`: (Required) The unique identifier of the App, which is generated by the Huanxin Developer Management Backstage based on the rules of` ${org_name}#${app_name}`.
   - `clientId`: (Required) Developer Client ID, which is generated by Huanxin Developer Management Backstage.
   - `clientSecret`: (required) developer secret, generated by Huanxin developer management background.

   You can refer to the figure below to get this information.

   ![](https://web-cdn.agora.io/docs-files/1624525158077)
   ![](https://web-cdn.agora.io/docs-files/1620822526000)