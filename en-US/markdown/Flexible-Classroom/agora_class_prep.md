To use Agora Flexible Classroom, you need to enable and configure the aPaaS service in Agora Console.

## Prerequisites

Before configuring the aPaaS service, ensure that you meet the following requirements:

- A valid Agora account with an active Agora project. See [Get Started with Agora](https://docs.agora.io/en/Agora%20Platform/get_appid_token?platform=All%20Platforms).
- Enable the Agora Interactive Whiteboard service and get the App Identifier and SDK Token of the Agora Interactive Whiteboard service. See [Enable and Configure Interactive Whiteboard Service](https://docs.agora.io/en/whiteboard/enable_whiteboard).
- Third-party cloud storage for storing class files and recorded files in Flexible Classroom. Agora recommends using Alibaba Cloud OSS. For how to use Alibaba Cloud OSS, see the [documents](https://help.aliyun.com/product/31815.html?spm=5176.7933691.J_1309819.8.2e392a66QiJZD3) of Alibaba Cloud.

## Configure the aPaaS service

Configure the aPaaS service in Agora Console, as follows:

1. Log in to Agora Console and enter the [project management](https://console.agora.io/projects) page. In your Agora project, click **edit**. In **Edit**, click the **Configure aPaaS** button.

   ![apaas-configuration](https://web-cdn.agora.io/docs-files/1618474816680)

2. On the **aPaaS Configuration** page, select the tickbox next to **Whiteboard** and **Cloud recording** to enable these two functions.

   ![](https://web-cdn.agora.io/docs-files/1623305939818)
   
3. To configure the whiteboard and cloud recording service, paste the configuration parameters into the Configuration page as a JSON object, and click **Update** to apply the configuration.

   ![](https://web-cdn.agora.io/docs-files/1623306590863)

   For example:

   - Interactive Whiteboard

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

   - Cloud Recording

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

      For the detaild description of the configuration parameters, see [Reference](#reference).

4. After returning to the **project management** page, click **Save** to ensure the aPaaS configuration takes effect.

## Next steps

After configuring the aPaaS service, refer to the following documents to launch a flexible classroom using the Agora Classroom SDK:

- [Launch a flexible classroom (Web)](./agora-class/agora_class_quickstart_web?platform=Web)
- [Launch a flexible classroom (Android)](./agora_class_quickstart_android?platform=Android)
- [Launch a flexible classroom (iOS)](./agora-class/agora_class_quickstart_ios?platform=iOS)

## Reference

- The JSON object for **Interactive Whiteboard** contains the following fields:

  | Field Name | Type   | Description                                                  |
  | :--------- | :----- | :----------------------------------------------------------- |
  | `appId`    | String | (Required) The App Identifier of the Interactive Whiteboard service that you get in the previous step. If you do not set this parameter, you cannot enter a classroom. |
  | `token`    | String | (Required) The SDK Token of the Interactive Whiteboard service that you get in the previous step. If you do not set this parameter, you cannot enter a classroom. |
  | `oss`      | Object | (Optional) The configuration of Alibaba Cloud OSS for storing the files you upload in a classroom. If you do not set this parameter, you cannot upload any file in the classroom.<p>**Note**: Temporarily, the Agora Interactive Whiteboard service only supports Alibaba Cloud OSS.<p>The JSON object for the whiteboard contains the following fields:<ul><li>`region`: String. The service region of Alibaba Cloud OSS, such as `"oss-cn-shanghai"`.</li><li>`Bucket`: String. The bucket name of Alibaba Cloud OSS, such as `"agora-whiteboard"`.</li><li>`folder`: String. The resource path in Alibaba Cloud OSS, such as `"whiteboard"`.</li><li>`accessKey`: String. The `AccessKeyId` in the AccessKey of Alibaba Cloud OSS. For details, see the [documentation](https://help.aliyun.com/document_detail/53045.html) of Alibaba Cloud OSS. This parameter is only applicable to the Flexible Classroom versions earlier than v1.1.0.</li><li>`accessKey`: String. The `AccessKeySecret` in the AccessKey of Alibaba Cloud OSS. For details, see the [documentation](https://help.aliyun.com/document_detail/53045.html) of Alibaba Cloud OSS. This parameter is only applicable to the Flexible Classroom versions earlier than v1.1.0.</li><li>`endpoint`: String. The [access endpoint](https://help.aliyun.com/document_detail/31837.html?spm=a2c4g.11186623.6.625.49002345WzP07l) of Alibaba Cloud OSS, such as `"oss-cn-shanghai.aliyuncs.com"`.<li>`ramAccessKey`: String. The `AccessKeyId` in the STS AK of Alibaba Cloud OSS. For details, see the [documentation](https://www.alibabacloud.com/help/doc-detail/100624.htm?spm=a2c63.p38356.b99.135.48b226dcvXg2Yw) of Alibaba Cloud OSS. This parameter is only applicable to the Flexible Classroom v1.1.0 or later.</li><li>`ramAccessSecret`: String. The `AccessKeySecret` in the STS AK of Alibaba Cloud OSS. For details, see the [documentation](https://www.alibabacloud.com/help/doc-detail/100624.htm?spm=a2c63.p38356.b99.135.48b226dcvXg2Yw) of Alibaba Cloud OSS. This parameter is only applicable to the Flexible Classroom v1.1.0 or later.</li><li>`roleArn`: String. The role ARN for temporary access of Alibaba Cloud OSS. For details, see the [documentation](https://www.alibabacloud.com/help/doc-detail/100624.htm?spm=a2c63.p38356.b99.135.48b226dcvXg2Yw) of Alibaba Cloud OSS. This parameter is only applicable to the Flexible Classroom v1.1.0 or later.</li><li>`roleSessionName`: (Optional) String. The name of the temporary access of Alibaba Cloud OSS. For details, see the [documentation](https://www.alibabacloud.com/help/doc-detail/100624.htm?spm=a2c63.p38356.b99.135.48b226dcvXg2Yw) of Alibaba Cloud OSS. This parameter is only applicable to the Flexible Classroom v1.1.0 or later.</li></ul> |


- The JSON object for **Cloud Recording** contains the following fields:

  | Field Name        | Type   | Description                                                  |
  | :---------------- | :----- | :----------------------------------------------------------- |
  | `recordingConfig` | Object | (Optional) Recording configuration. If you do not set this parameter, Agora records the audio and video of teachers in a classroom in [composite recording mode](https://docs.agora.io/en/Agora%20Platform/composite_recording_mode) by default. To change the recording behavior, see the [cloud recording configuration](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#recordingConfig). |
  | `storageConfig`   | Object | (Optional) Cloud storage configuration, used for storing your recorded files. If you do not set this parameter, your recorded files will be stored in Agora's Alibaba Cloud OSS account. To use your own cloud storage account, see the [cloud storage configuration](https://docs.agora.io/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#storageConfig).<p>**Note**: The `endpoint` field in `storageConfig` is a path consisting of the bucket name and [access domain](https://help.aliyun.com/document_detail/31837.html?spm=a2c4g.11186623.6.625.49002345WzP07l) in Alibaba Cloud OSS. Suppose your bucket name is `"agora-whiteboard"` and your access domain is `"oss-cn-shanghai.aliyuncs.com"`, set `endpoint` as `"https://agora-whiteboard.oss-cn-shanghai. aliyuncs.com"`. |

  