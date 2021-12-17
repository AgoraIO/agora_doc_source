This article describes how to start cloud recording, query cloud recording status, and end cloud recording by sending a RESTful API request.

<div class="alert note"> The command-line examples in this article are for demonstration only and should not be used in a production environment. In a production environment, you need to send RESTful API requests through your application server.</div>

## Understand the tech

The complete process of implementing a cloud recording is as follows:![](https://web-cdn.agora.io/docs-files/1625209047438)


**1. Get a resource ID**
Before starting a cloud recording, you must call the [`acquire`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/云端录制/acquire) method to obtain a cloud recording resource. After calling this method successfully, you can get a resource ID in the response body.

**2. Start a cloud recording**
Call the [`start`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/云端录制/start) method to join the channel and[` start`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/云端录制/start) a cloud recording. After calling this method successfully, you can get a recording ID from the response body to mark the current recording process.

**3. Stop the cloud recording**
Call the [`stop`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/云端录制/stop) method to[` stop`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/云端录制/stop) the cloud recording.

**4. Upload the recording file**
After the recording is over, the cloud recording service uploads the recording file to the third-party cloud storage you specify.

## Prerequisites

- A valid[ Agora developer account](https://docs.agora.io/cn/AgoraPlatform/sign_in_and_sign_up?platform=iOS),[ App ID and Token](https://docs.agora.io/cn/AgoraPlatform/get_appid_token?platform=AllPlatforms).
- Please ensure that the third-party cloud storage service has been enabled. The currently supported third-party cloud storage service providers are as follows:
   - [Qiniu Cloud](https://www.qiniu.com/products/kodo)
   - [Amazon S3](https://aws.amazon.com/cn/s3/?nc2=h_m1)
   - [Alibaba Cloud](https://www.aliyun.com/product/oss)
   - [Tencent Cloud](https://cloud.tencent.com/product/cos)
   - [Kingsoft Cloud](https://www.ksyun.com/post/product/KS3.html)
   - [Microsoft Azure](https://azure.microsoft.com/zh-cn/)
- Please make sure that you have joined the RTC channel and have users in the channel and are streaming.

## Sample project

Agora provides a [Postman collection](https://github.com/AgoraIO/Agora-RESTful-Service/blob/master/cloud-recording/README.md), which contains sample requests of RESTful API for a cloud recording. You can use the collection to get a quick start of the basic functionalities of the Cloud Recording RESTful APIs. All you need to do is to import the collection to Postman and set your environment variables.

You can also use Postman to generate code snippets written in various programming languages. To do so, select a request, click **Code**, and select the desired language in** GENERATE CODE SNIPPETS**.

![img](https://web-cdn.agora.io/docs-files/1588737379230)

## Enable cloud recording

Enable the cloud recording service before using Agora Cloud Recording for the first time.

1. Log in [Console](https://console.agora.io/), and click ![img](https://web-cdn.agora.io/docs-files/1551250582235) in the left navigation menu to go to the **Products & Usage **page.
2. Select a project from the drop-down list in the upper-left corner, and click **Duration** under Cloud Recording.
   ![ img](https://web-cdn.agora.io/docs-files/1566385129523)
3. Click **Enable Cloud Recording**.
4. Click **Apply**.

Now, you can use Agora Cloud Recording and see the usage statistics.****

## Implement cloud recording

The following figure shows the API call sequence of a cloud recording.
Querying the recording status (`query`), updating the subscription list (`update`), and updating the video layout (`updateLayout`) are optional and can be called multiple times, but they must be called during the recording process, that is, after the recording starts and before the recording ends.
![](https://web-cdn.agora.io/docs-files/1625213385395)

### Pass the basic HTTP authentication

The RESTful APIs require the basic HTTP authentication. You need to set the `Authorization` parameter in every HTTP request header. For how to get the value for Authorization, see[ RESTful API authentication](https://docs.agora.io/cn/faq/restful_authentication).

### Get a cloud recording resources

Call the [`acquire`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#a-nameacquirea获取云端录制资源的-api) method to request a resource ID for cloud recording.

After calling this method successfully, you can get a resource ID in the response body. The resource ID is valid for five minutes, so you need to start recording with this resource ID within five minutes. One resource ID can only be used for one recording session.

- The recording service is equivalent to a non-streaming client in the channel. The `uid`parameter in the request body is used to identify the recording service and cannot be the same as any existing UID in the channel. For example, if there are two users in the channel and the UIDs are 123 and 456 respectively, the `uid` cannot be `"123"` or `"456"`.
- Agora Cloud Recording does not support user IDs in string, that is, User Accounts. Ensure that every user in the channel has an integer UID. The string content of the`uid` parameter must also be an integer.

#### Sample code

You can use the command-line tool to send the following command to call the `acquire` method. You need to replace `appid` with the App ID of your Agora project, `YourChannelName` with the name of the channel you need to record, and `YourRecordingUID` with your UID that identifies the recording service.

```
curl --location --request POST 'https://api.agora.io/v1/apps/<appid>/cloud_recording/acquire' \
--header 'Authorization: Basic MjdiZjhjMmRkNTNhNGQwZGEwXXXXXXXXXXXXXXzc6YjM2N2NiMjRiOTExNDQyYTg5YjU5YTdmN2Y0YjM1OWM=' \
--header 'Content-type: application/json;charset=utf-8' \
--data-raw '{
  "cname": "<YourChannelName>",
  "uid": "<YourRecordingUID>",
  "clientRequest":{
}
}'
```

### Start a cloud recording

Call the start method within five minutes after getting the resource ID to join a channel and [`start`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#a-namestarta开始云端录制的-api) the recording. You can choose the recording mode as individual recording or composite recording.

If this method call succeeds, you get a recording ID (sid) from the HTTP response body. The unique identification of the current recording.

#### Sample code

You can use the command line tool to send the following commands to call the `start` method. You need to replace `appid` with the App ID of your Agora project, replace` resourceid` with the resource ID obtained through the `acquire` method, replace YourChannelName with the name of the channel you need to record, replace YourRecordingUID with your UID that identifies the recording service, and replace` YourToken` with you Obtain the temporary token from the console and set the `storageConfig` and `recordingConfig` related parameters.

- During the testing phase, you can[ obtain temporary tokens ](https://docs.agora.io/cn/AgoraPlatform/get_appid_token?platform=AllPlatforms#获取临时-token)directly on the console. When joining a channel, please make sure that the channel name entered is the same as the channel name entered when generating the temporary token.
- For production, we recommend using a Token generated at your server. For how to generate[ a token](https://docs.agora.io/cn/InteractiveBroadcast/token_server?platform=AllPlatforms), see[ Token Security](https://docs.agora.io/cn/InteractiveBroadcast/token_server?platform=AllPlatforms). When joining a channel, please make sure that the channel name and uid entered are consistent with the channel name and uid entered when the temporary token is generated.

<div class="alert note"> Please make sure that the channelType is consistent with the Agora RTC SDK setting, otherwise it may cause problems.</div>

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">Single stream recording</div>
		<div class="switch-tab">Composite recording</div>
	</div>
<pre class="单流录制 show"><code class="单流录制">
curl --location --request POST'https://api.agora.io/v1/apps/<appid>/cloud_recording/resourceid/<resourceid>/mode/individual/start' \
--header'Authorization: Basic MjdiZjhjMmRkNTNhNGQwZGEwXXXXXXXXXE5Yzc6YjM2N2NiMjRiOTExNDQyYTg5YjU5YTdmN2Y0YjM1OWM=' \
--header'Content-Type: application/json' \
--data-raw '{
    "cname": "YourChannelName",
    "uid": "YourRecordingUID",
    "clientRequest": {
	    "token": "YourToken",
        storageConfig
            "secretKey": "YourSecretKey",
            "vendor": 0,
            "region": 0,
            "bucket": "YourBucketName",
            "accessKey": "YourAccessKey"
        },
        recordingConfig
            "channelType": 1
            }
        }
}'
</pre>
<pre class="合流录制"><code class="合流录制">
curl --location --request POST'https://api.agora.io/v1/apps/<appid>/cloud_recording/resourceid/<resourceid>/mode/mix/start' \
--header 'Authorization: Basic MjdiZjhjMmRkNTNhNGQwZGEwXXXXXXXXXXXXXXzc6YjM2N2NiMjRiOTExNDQyYTg5YjU5YTdmN2Y0YjM1OWM=' \
--header'Content-Type: application/json' \
--data-raw '{
    "cname": "YourChannelName",
    "uid": "YourRecordingUID",
    "clientRequest": {
        "token": "YourToken",
        recordingConfig
            "channelType": 0
        },
        storageConfig
            "secretKey": "YourSecretKey",
            "vendor": 0,
            "region": 0,
            "bucket": "YourBucketName",
            "accessKey": "YourAccessKey"
    }
}
}'
</pre>
</div>

### Query recording status

During the recording, you can call the [`query`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/云端录制/query) method to check the recording status multiple times.

After calling this method successfully, you can get the current recording status and related information of the recording file from the response packet body. See [Best Practices in Integrating Cloud Recording ](https://confluence.agoralab.co/integration_best_practices?platform=RESTful)for details about monitoring [service status ](https://docs.agora.io/cn/cloud-recording/integration_best_practices#monitor_status)and[ getting the M3U8 filename](https://docs.agora.io/cn/cloud-recording/integration_best_practices#get_filename).

#### Sample code

You can use the command line tool to send the following commands to call the `query` method. You need to replace `appid` with the App ID of your Agora project, `resourceid `with the resource ID obtained through the `acquire` method, and `sid `with the sid obtained through the `start` method.

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">Single stream recording</div>
		<div class="switch-tab">Composite recording</div>
	</div>
<pre class="单流录制 show"><code class="单流录制">
curl --location --request GET'https://api.agora.io/v1/apps/<appid>/cloud_recording/resourceid/<resourceid>/sid/<sid>/mode/individual/query' \
--header 'Authorization: Basic MjdiZjhjMmRkNTNhNGQwZGEwXXXXXXXXXXXXXXzc6YjM2N2NiMjRiOTExNDQyYTg5YjU5YTdmN2Y0YjM1OWM=' \
Content-type is application/json;charset=utf-8.</code>
</pre>
<pre class="合流录制"><code class="合流录制">
curl --location --request GET'https://api.agora.io/v1/apps/<appid>/cloud_recording/resourceid/<resourceid>/sid/<sid>/mode/mix/query' \
--header 'Authorization: Basic MjdiZjhjMmRkNTNhNGQwZGEwXXXXXXXXXXXXXXzc6YjM2N2NiMjRiOTExNDQyYTg5YjU5YTdmN2Y0YjM1OWM=' \
Content-type is application/json;charset=utf-8.</code>
</pre>
</div>

### Stop recording

Call the [`stop`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#a-namestopa停止云端录制的-api) method to[` stop`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#a-namestopa停止云端录制的-api) the recording.

After calling this method successfully, you can get the status of the recording file upload and the information of the recording file from the response package body.

#### Sample code

You can use the command line tool to send the following command to call the `stop` method. You need to replace `appid` with the App ID of your Agora project, `resourceid` with the resource ID obtained through the `acquire` method, `sid` with the sid obtained through the `start` method, `YourChannelName` with the name of the channel you are recording, and `YourRecordingUID` with` your` identification The UID of the recording service.

<div class="switch-lang">
	<div class="switch-tabs">
		<div class="switch-tab selected">Single stream recording</div>
		<div class="switch-tab">Composite recording</div>
	</div>
<pre class="单流录制 show"><code class="单流录制">
curl --location --request POST'https://api.agora.io/v1/apps/v1/apps/<appid>/cloud_recording/resourceid/<resourceid>/sid/null/mode/individual/stop' \
--header 'Authorization: Basic MjdiZjhjMmRkNTNhNGQwZGEwXXXXXXXXXXXXXXzc6YjM2N2NiMjRiOTExNDQyYTg5YjU5YTdmN2Y0YjM1OWM=' \
--header 'Content-type: application/json;charset=utf-8' \
--data-raw '{
    "uid": "YourRecordingUID",
    "cname": "YourChannelName",
	"clientRequest":{
}
}'
</pre>
<pre class="合流录制"><code class="合流录制">
curl --location --request POST'https://api.agora.io/v1/apps/v1/apps/<appid>/cloud_recording/resourceid/<resourceid>/sid/<sid>/mode/mix/stop' \
--header 'Authorization: Basic MjdiZjhjMmRkNTNhNGQwZGEwXXXXXXXXXXXXXXzc6YjM2N2NiMjRiOTExNDQyYTg5YjU5YTdmN2Y0YjM1OWM=' \
--header 'Content-type: application/json;charset=utf-8' \
--data-raw '{
    "uid": "YourRecordingUID",
    "cname": "YourChannelName",
    "clientRequest":{
}
}'
</pre>
</div>

## Next steps

### Manage Recorded Files

After the recording starts, the Agora server automatically splits the recorded content into multiple TS/WebM files and keeps uploading them to the third-party cloud storage until the recording stops. You can refer to [the management of recording files ](https://docs.agora.io/cn/cloud-recording/cloud_recording_manage_files)to learn about the naming rules, file sizes, and slicing rules of recording files.

### Token authentication

To ensure communication security, in a formal production environment, you need to generate tokens on your app server. See[ Authenticate Your Users with Token](https://docs.agora.io/cn/cloud-recording/token_server?platform=AllPlatforms).

## Considerations

### parameter settings

- If the `uid `parameter in the request body is the same as the UID in the channel, or if a non-integer UID is used, the recording will fail. For details, see the notes[](https://confluence.agoralab.co/pages/viewpage.action?pageId=719466567#acquire) on the `uid `parameter in the section Obtaining Cloud Recording Resources.
- After the` start` request returns 200, it only means that the RESTful API request is successful. To ensure that the recording starts successfully and goes on normally, you also need to call query to query the recording status. Unreasonable` transcodingConfig` parameter settings, incorrect third-party cloud storage information, incorrect token information, etc. will cause the `query` method to return 404. [Why do I get a 404 error when I call query after successfully starting a cloud recording? ](https://confluence.agoralab.co/cn/cloud-recording/faq/return-404).
- Please set maxIdleTime reasonably according to your actual business needs``. Within the time range set by` maxIdleTime`, even if the channel is idle, the recording will continue and billing will be generated.

### API sequence

- After obtaining the resource ID, you must call the `start `method within 5 minutes to `start` recording. After the timeout, you need to request a resource ID again.
- After obtaining the `sid` (recording ID), after the time set by `resourceExpiredHour` has passed, you will not be able to call the `query`,` updateLayout` and `stop` methods.

## Reference documents

- [Common errors in cloud recording ](https://docs.agora.io/cn/cloud-recording/common_errors)lists common error codes and error messages in the response package body.

- [Cloud recording RESTful API callback service ](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest?platform=RESTful)lists all the callback events recorded in the cloud.
- To learn more about the implementation steps and details of basic functions, you can refer to the following documents:
   - [Single stream recording](https://docs.agora.io/cn/cloud-recording/cloud_recording_individual_mode?platform=RESTful)
   - [Composite recording](https://docs.agora.io/cn/cloud-recording/cloud_recording_composite_mode?platform=RESTful)
   - [Page recording](https://docs.agora.io/cn/cloud-recording/cloud_recording_webpage_mode?platform=RESTful)
   - [Capture screenshots](https://docs.agora.io/cn/cloud-recording/cloud_recording_screen_capture?platform=RESTful)