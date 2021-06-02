---
title: Agora Cloud Recording RESTful API Quickstart
platform: All Platforms
updatedAt: 2021-03-10 02:11:18
---
Agora Cloud Recording provides RESTful APIs for you to control cloud recording through HTTP requests.

> - You need to send the requests from your own app server.
> - The RESTful APIs only support HTTPS.

![](https://web-cdn.agora.io/docs-files/1559549537706)

With the RESTful APIs, you can send requests to do the following:

- Start/Stop a cloud recording

- Query the recording status

The Agora Cloud Recording RESTful APIs provide a callback service. After enabling the callback service, you can receive notifications about cloud recording events. See the table below for the differences between the recording status query and the callback service.

| Recording status query                                       | Callback service                                         |
| :----------------------------------------------------------- | :------------------------------------------------------- |
| Call the [`query`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/query) method to get the status. | Configure an HTTP server and enable the callback service. |
| You need to request for the status update.                   | You are notified when an event occurs.                   |
| Provides only the M3U8 filename and the recording status.    | Provides notifications about all events with details.        |

If you need to use the callback sercive, see [RESTful API Callbacks](./cloud_recording_callback_rest) for details.


## Prerequisites

Deploy a third-party cloud storage. Agora Cloud Recording supports [Amazon S3](https://aws.amazon.com/s3/?nc1=h_ls), [Alibaba Cloud](https://www.alibabacloud.com/product/oss), [Tencent Cloud](https://intl.cloud.tencent.com/product/cos) and [Qiniu Cloud](https://www.qiniu.com/en/products/kodo).

> Agora Cloud Recording does not support string user accounts. Ensure that the recording channel uses integer UIDs.

## Enable cloud recording

Enable the cloud recording service before using Agora Cloud Recording for the first time.

1. Login to [Console](https://dashboard.agora.io/), and click ![img](https://web-cdn.agora.io/docs-files/1551260936285) in the left navigation menu to go to the **Products & Usage** page. 
2. Select a project from the drop-down list in the upper-left corner, and click **Duration** under **Cloud Recording**. 
![](https://web-cdn.agora.io/docs-files/1566444271323)
1. Click **Enable Cloud Recording**.
2. Click **Apply**.

Now, you can use Agora Cloud Recording and see the usage statistics.


## Pass basic authentication

The RESTful APIs require the basic HTTP authentication. You need to set the `Authorization` parameter in every HTTP request header. For how to get the value for `Authorization`, see [RESTful API authentication](https://docs.agora.io/en/faq/restful_authentication).

## Implement cloud recording

The following figure shows the API call sequence of a cloud recording. 
> The `query`, `update`, and `updateLayout` methods are not mandatory, and can be called multiple times during the recording (after starting recording and before stopping recording).

![](https://web-cdn.agora.io/docs-files/1591872748124)


### Start recording

**Get a resource ID**

Call the [`acquire`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/acquire) method to request a resource ID for cloud recording. 

If this method call succeeds, you get a resource ID (`resourceId`) from the HTTP response body. The resource ID is valid for five minutes, so you need to start recording with this resource ID within five minutes.

> One resource ID can only be used for one recording session.


**Join a channel**

Call the [`start`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/start) method within five minutes after getting the resource ID to join a channel and start the recording. 

<div class="alert warning"> Agora Cloud Recording does not support string user IDs (User Accounts). Ensure that every user in the channel has an integer UID. When you call the start method, ensure that the UID in the quotation marks is an integer UID, too.</div>

If this method call succeeds, you get a recording ID (`sid`) from the HTTP response body.


### Query recording status

During the recording, you can call the [`query`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/query) method to check the recording status multiple times.

If this method call succeeds, you get the M3U8 filename and the current recording status from the HTTP response body.

### Update subscription lists

During the recording, you can call [`update`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/update) to update the subscription lists multiple times. See [Set up subscription lists](https://docs.agora.io/en/cloud-recording/cloud_recording_subscription) for details.

### Update video layout

During the recording, you can call the [`updateLayout`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/updateLayout)  method to set or update the video layout. See [Set Video Layout](/en/cloud-recording/cloud_recording_layout) for details.


### Stop recording

Call the [`stop`](https://docs.agora.io/en/cloud-recording/restfulapi/#/Cloud%20Recording/stop) method to stop the recording.

> Agora Cloud Recording automatically leaves the channel and stops recording when no user is in the channel for more than 30 seconds by default.

If this method call succeeds, you get the M3U8 filename and the current uploading status from the HTTP response body.


## Upload and manage the recorded files

After the recording starts, the Agora server automatically splits the recorded content into multiple TS/WebM files and keeps uploading them to the third-party cloud storage until the recording stops.

### Recording ID

The recording ID is the unique identification of a recording. Each cloud recording session has a unique recording ID.

After starting the recording with the `start` request, you can get the recording ID from its response. You can also get the recording ID from any of the callbacks.

### <a name="m3u8"></a>Playlist of the recorded files

In individual recording mode, if you choose to record audio or video only, each recording session generates one M3U8 file; if you record both audio and video, each recording session generates two M3U8 files. The M3U8 file is a playlist pointing to all the split TS/WebM files of the recording. You can use the M3U8 file to play and manage the recorded files. For detailed information about the naming conventions of the M3U8 and TS/WebM files in individual recording mode, see [Manage Recorded Files](./cloud_recording_manage_files).

In composite recording mode, each recording session generates one M3U8 file. The name of the M3U8 file is `sid_cname.m3u8`, which consists of the recording ID and the channel name. For more information, see [Manage Recorded Files](./cloud_recording_manage_files).

### Upload the recorded files

The Agora server automatically uploads the recorded files. Pay attention to the following callbacks.

During the recording, the SDK triggers the following callback once every minute:

- [`uploading_progress`](./cloud_recording_callback_rest?platform=All%20Platforms#33): Reports the upload progress (%) of the recorded files.

After the recording stops, the SDK triggers one of the following callbacks:

- [`uploaded`](./cloud_recording_callback_rest?platform=All%20Platforms#31): Occurs when all the recorded files are uploaded to the third-party cloud storage.
- [`backuped`](./cloud_recording_callback_rest?platform=All%20Platforms#32): Occurs when some of the recorded files fail to upload to the third-party cloud storage and upload to Agora Cloud Backup instead. Agora Cloud Backup automatically uploads these files to your cloud storage. If you cannot [play the recorded files](./cloud-recording/cloud_recording_onlineplay) after five minutes, contact Agora technical support.

If uploading takes a long time, the `stop` response returns the HTTP 206 status code, indicating that the recording stops but the uploading status is unknown. You need to get the uploading status from the callback events.

## Considerations

- Call `acquire` to get a resource ID before calling `start.`
- Use one resource ID for only one `start` request.
- Do not call `query` after calling `stop.`

The following are some common errors:

- `acquire` ➡ `start` ➡ `start`

  Repeating the `start` request with the same resource ID returns the HTTP 201 status code and error code 7.

- `acquire` ➡ `start` ➡ `acquire` ➡ `start`

  Repeating the acquire and start requests with the same parameters returns the HTTP 400 status code and error code 53.

- `acquire` ➡ `start` ➡ Recording stops ➡ `query`

  Calling `query` after the recording stops returns the HTTP 404 status code and error code 404. The recording stops in the following situations:

  - When you call `stop`.
  - When no user is in the channel for the idle time (30 seconds by default).
  - When the asynchronous parameter check finds errors. This means that some parameters of `transcodingConfig` or `storageConfig` in the `start` request are invalid.

- `acquire` ➡ `start` ➡ `stop` & `query`

  Calling `stop` together with `query` affects the response of `stop`: The HTTP status code is 206 and the response does not have the `fileList` field.

See the following if you have other issues using Agora Cloud Recording:

- [Common Errors](/en/cloud-recording/cloud_recording_api_rest?platform=All%20Platforms#errors) 
- [Why do I get a 404 error when I call query after successfully starting a cloud recording?](https://docs.agora.io/en/faq/return-404)
-  [Why are there no recorded files in the cloud storage?](https://docs.agora.io/en/faq/fail_to_upload)
- [How can I choose the region of my cloud storage?](https://docs.agora.io/en/faq/bucket_region)

## Sample requests

Agora provides a [Postman collection](https://github.com/AgoraIO/Agora-RESTful-Service/tree/master/cloud-recording), which contains sample RESTful API requests for a cloud recording. You can use the collection to get a quick start of the basic functionalities of the Cloud Recording RESTful APIs. All you need to do is to import the collection to Postman and set your environment variables. 

You can also use Postman to generate code snippets written in various programming languages. To do so, select a request, click **Code**, and select the desired language in **GENERATE CODE SNIPPETS**.

![](https://web-cdn.agora.io/docs-files/1588737618604)

## <a name="demo-rest"></a>Sample code

The following is the sample code in Python for your reference.

```python
import requests
import time
TIMEOUT=60

#TODO: Fill in AppId, Basic Auth string, Cname (channel name), and cloud storage information
APPID=""
Auth=""
Cname=""
ACCESS_KEY=""
SECRET_KEY=""
VENDOR = 0
REGION = 0
BUCKET = ""

url="https://api.agora.io/v1/apps/%s/cloud_recording/" % APPID

acquire_body={
        "uid": "123",
        "cname": Cname,
        "clientRequest": {}
        }

#Set up two regions for two users
layoutConfig = [{"x_axis": 0.0, "y_axis": 0.0, "width": 0.3, "height": 0.3, "alpha": 0.9, "render_mode": 1},
                {"x_axis": 0.3, "y_axis": 0.0, "width": 0.3,"height": 0.3, "alpha": 0.77, "render_mode": 0}]
start_body={
        "uid": "123",
        "cname": Cname,
        "clientRequest": {
            "storageConfig": {
                "secretKey": SECRET_KEY,
                "region": REGION,
                "accessKey": ACCESS_KEY,
                "bucket": BUCKET,
                "vendor": VENDOR
                },
            "recordingConfig": {
                "audioProfile": 0,
                "channelType": 0,
                "maxIdleTime": 30,
                "transcodingConfig": {
                    "width": 640,
                    "height": 360,
                    "fps": 15,
                    "bitrate": 600,
                    "mixedVideoLayout": 3,
                    "backgroundColor": "#fff000",
                    "layoutConfig": layoutConfig
                    }
                }
            }
        }
        
update_body = {
        "uid": "123",
        "cname": Cname,
        "clientRequest":{
            "mixedVideoLayout": 3,
            "backgroundColor": "#ff00cc",
            "layoutConfig":layoutConfig
        }
}
stop_body={
        "uid": "123",
        "cname": Cname,
        "clientRequest": {}
        }


def cloud_post(url, data=None,timeout=TIMEOUT):
    headers = {'Content-type': "application/json", "Authorization": Auth}

    try:
        response = requests.post(url, json=data, headers=headers, timeout=timeout, verify=False)
        print("url: %s, request body:%s response: %s" %(url, response.request.body,response.json()))
        return response
    except requests.exceptions.ConnectTimeout:
        raise Exception("CONNECTION_TIMEOUT")
    except requests.exceptions.ConnectionError:
        raise Exception("CONNECTION_ERROR")

def cloud_get(url, timeout=TIMEOUT):
    headers = {'Content-type':"application/json", "Authorization":Auth}
    try:
        response = requests.get(url, headers=headers, timeout=timeout, verify=False)
        print("url: %s,request:%s response: %s" %(url,response.request.body, response.json()))
        return response
    except requests.exceptions.ConnectTimeout:
        raise Exception("CONNECTION_TIMEOUT")
    except requests.exceptions.ConnectionError:
        raise Exception("CONNECTION_ERROR")

def start_record():
    acquire_url = url+"acquire"
    r_acquire = cloud_post(acquire_url, acquire_body)
    if r_acquire.status_code == 200:
        resourceId = r_acquire.json()["resourceId"]
    else:
        print("Acquire error! Code: %s Info: %s" %(r_acquire.status_code, r_acquire.json()))
        return False

    start_url = url+ "resourceid/%s/mode/mix/start" % resourceId
    r_start = cloud_post(start_url, start_body)
    if r_start.status_code == 200:
        sid = r_start.json()["sid"]
    else:
        print("Start error! Code:%s Info:%s" %(r_start.status_code, r_start.json()))
        return False

    time.sleep(30)
    query_url = url + "resourceid/%s/sid/%s/mode/mix/query" %(resourceId, sid)
    r_query = cloud_get(query_url)
    if r_query.status_code == 200:
        print("The recording status: %s" % r_query.json())
    else:
        print("Query failed. Code %s, info: %s" % (r_query.status_code, r_query.json()))

    time.sleep(10)

    update_url = url + "resourceid/%s/sid/%s/mode/mix/updateLayout" % (resourceId, sid)
    r_update = cloud_post(update_url, update_body)
    if r_update.status_code == 200:
        print("Update layout success.")
    else:
        print("Update layout failed. Code: %s Info: %s" % r_update.status_code, r_update.json())

    stop_url = url+"resourceid/%s/sid/%s/mode/mix/stop" % (resourceId, sid)
    r_stop = cloud_post(stop_url, stop_body)
    if r_stop.status_code == 200:
        print("Stop cloud recording success. FileList : %s, uploading status: %s"
            %(r_stop.json()["serverResponse"]["fileList"], r_stop.json()["serverResponse"]["uploadingStatus"]))
    else:
        print("Stop failed! Code: %s Info: %s" % r_stop.status_code, r_stop.json())

start_record()
```


