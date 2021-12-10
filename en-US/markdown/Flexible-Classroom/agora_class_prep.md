To use Agora Flexible Classroom, you need to enable and configure the aPaaS service in Agora Console.

## Prerequisites

Before configuring the aPaaS service, ensure that you meet the following requirements:

- A valid Agora account with an active Agora project. See [Create an Agora Project](/en/Agora%20Platform/get_appid_token#create-an-agora-project).
- Enable the Agora Interactive Whiteboard service and get the App Identifier and SDK Token of the Agora Interactive Whiteboard service. See [Enable and Configure Interactive Whiteboard Service](/en/whiteboard/enable_whiteboard).
- Third-party cloud storage for storing class files and recorded files in Flexible Classroom. Agora supports only [Amazon Simple Storage Service (Amazon S3)](https://aws.amazon.com/s3/?nc1=h_ls) now.
- [Generate a set of Customer ID and secret](/en/Agora%20Platform/get_appid_token#generate-a-set-of-customer-id-and-secret) for Agora RESTful API access.

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
                 "vendor": 1,
                 "region": "",
                 "endpoint": "",
                 "bucket": "",
                 "folder": "",
                 "accessKey": "",
                 "secretKey": ""
             }  
     }
```
     
     <div class="note alert">For the detaild description of the configuration parameters, see <a href="#reference">Reference</a>.</div>
   
   - Cloud Recording
   
     ```
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
   
     <div class="note alert">For the detaild description of the configuration parameters, see <a href="#reference">Reference</a>.</div>

4. After returning to the **project management** page, click **Save** to ensure the aPaaS configuration takes effect.

## Next steps

After configuring the aPaaS service, refer to the following documents to launch a flexible classroom using the Agora Classroom SDK as it is:

- [Launch a flexible classroom (Web)](./agora_class_quickstart_web?platform=Web)
- [Launch a flexible classroom (Android)](./agora_class_quickstart_android?platform=Android)
- [Launch a flexible classroom (iOS)](./agora_class_quickstart_ios?platform=iOS)
- [Launch a flexible classroom (Electron)](./agora_class_quickstart_electron?platform=Electron)

## Reference

- The JSON object for **Interactive Whiteboard** contains the following fields:

  | Field Name | Type   | Description                                                  |
  | :--------- | :----- | :----------------------------------------------------------- |
  | `appId`    | String | (Required) The App Identifier of the Interactive Whiteboard service that you get in the previous step. If you do not set this parameter, you cannot enter a classroom. |
  | `token`    | String | (Required) The SDK Token of the Interactive Whiteboard service that you get in the previous step. If you do not set this parameter, you cannot enter a classroom. |
  | `oss`      | Object | (Optional) The configuration of Amazon S3 for storing the files you upload in a classroom. If you do not set this parameter, you cannot upload any file in the classroom. The JSON object for the whiteboard contains the following fields:<ul><li>`vendor`: Number. The third-party cloud storage vendor. Set this parameter as `1` to use Amazon S3.</li><li>`region`: String. The location of the data center you specified when creating a bucket.</li><li>`endpoint`: String. The domain name used to access the Amazon S3 service, such as `s3.us-east-2.amazonaws.com`. For details, see the </li><li>`bucket`: String. The name of the storage space.</li><li>`folder`: String. The path used to save the resources in the storage space,  such as `"whiteboard"`. The default is the root directory.</li><li>`accessKey`: String. The Access Key provided by Amazon S3, which is used to identify visitors.</li><li>`secretKey`: String. The Secret Key provided by Amazon S3, which is used to authenticate signatures.</li></ul><p>**Note**: To get the above information about a third-party storage service, see the [documentation](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html) of Amazon S3. |


- The JSON object for **Cloud Recording** contains the following fields:

  | Field Name        | Type   | Description                                                  |
  | :---------------- | :----- | :----------------------------------------------------------- |
  | `recordingConfig` | Object | (Optional) Recording configuration. If you do not set this parameter, Agora records the audio and video of teachers in a classroom in [composite recording mode](/en/Agora%20Platform/composite_recording_mode) by default. To change the recording configuration, see the [cloud recording configuration](/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#recordingConfig). |
  | `storageConfig`   | Object | (Optional) Cloud storage configuration, used for storing your recorded files. If you do not set this parameter, your recorded files will be stored in Agora's Amazon S3 account. To use your own cloud storage, see the [cloud storage configuration](/en/cloud-recording/cloud_recording_api_rest?platform=RESTful#storageConfig). |