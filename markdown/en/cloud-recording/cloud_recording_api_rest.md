---
title: Agora Cloud Recording RESTful API
platform: All Platforms
updatedAt: 2021-04-01 04:15:53
---
Ensure that you know how to [record with the RESTful API](./cloud_recording_rest) before reading this document.

## <a name="auth"></a>Authentication

The RESTful API only supports HTTPS. Before sending HTTP requests, you must pass the basic Agora HTTP authentication (the `Authorization` parameter in the HTTP request head) with `api_key:api_secret`:

- `api_key`: Customer ID
- `api_secret`: Customer Certificate

You can find your Customer ID and Customer Certificate on the [RESTful API](https://dashboard.agora.io/restful) page in Console. See [RESTful API authentication](https://docs.agora.io/en/faq/restful_authentication) for details.

## Data format

All requests are sent to the host: `api.agora.io`.

- Request: See the examples in the following APIs.
- Response: The response content is in JSON format.

<div class="alert warning">All the request URLs and request bodies are case sensitive.</div>
## Call sequence

Use the RESTful API in the following steps:

1. Call the [`acquire`](#acquire) method to request a resource ID for cloud recording.
2. Call the  [`start`](#start) method within five minutes after getting the resource ID to start the recording.
3. Call the [`stop`](#stop) method to stop the recording.

During the recording, you can call the [`query`](#query) method to check the recording status.

See [Sample code](./cloud_recording_rest#demo-rest) for an example using the RESTful API.


## <a name="acquire"></a>Gets the recording resource

Before starting a cloud recording, you need to call this method to get a resource ID.

> One resource ID can only be used for one recording session.

- Method:POST
- Endpoint: /v1/apps/\<appid\>/cloud_recording/acquire

> The request frequency limit is 10 times per second per APP ID. Contact support@agora.io if you want to raise the limit.

If this method call succeeds, you get a resource ID (`resourceId`) from the HTTP response body. The resource ID is valid for five minutes, so you need to [start recording](#start) with this resource ID within five minutes.

### Parameters

The following parameter is required in the URL.

| Parameter | Type   | Description                                                  |
| :-------- | :----- | :----------------------------------------------------------- |
| `appid`   | String | The [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id) used in the channel to be recorded. |

The following parameters are required in the request body.

| Parameter       | Type   | Description                                                  |
| :-------------- | :----- | :----------------------------------------------------------- |
| `cname`         | String | The name of the channel to be recorded.                      |
| `uid`           | String | A string that contains the UID of the recording client, for example `"527841"`. The UID needs to meet the following requirements: <li>It is a 32-bit unsigned integer within the range between 1 and (2<sup>32</sup>-1).</li><li>It is unique and does not clash with any existing UID in the channel. </li><li>It should not be a string. Ensure that all UIDs in the channel are integers.</li> |
| `clientRequest` | JSON   | A client request including the `resourceExpiredHour` field. `resourceExpiredHour` is an integer, which sets the time limit (in hours) for the Cloud Recording RESTful API calls. It must be between `1` and `720`, the default value being `72`. The time limit starts from when you successfully start a cloud recording and get `sid`(the recording ID ). When you exceed the time limit, you can no longer call `query`, `updateLayout`, and `stop`. |

### An HTTP request example of `acquire`

- The request URL is `https://api.agora.io/v1/apps/<yourappid>/cloud_recording/acquire`.
- `Content-type` is `application/json;charset=utf-8`.
- `Authorization` is the basic authentication, see [RESTful API authentication](https://docs.agora.io/en/faq/restful_authentication) for details.
- The request body:

```json
{
    "cname": "httpClient463224",
    "uid": "527841",
    "clientRequest":{
      "resourceExpiredHour":  24
   }
}
```

### A response example of `acquire`

```json
"Code": 200,
"Body":
{
 "resourceId": "JyvK8nXHuV1BE64GDkAaBGEscvtHW7v8BrQoRPCHxmeVxwY22-x-kv4GdPcjZeMzoCBUCOr9q-k6wBWMC7SaAkZ_4nO3JLqYwM1bL1n6wKnnD9EC9waxJboci9KUz2WZ4YJrmcJmA7xWkzs_L3AnNwdtcI1kr_u1cWFmi9BWAWAlNd7S7gfoGuH0tGi6CNaOomvr7-ILjPXdCYwgty1hwT6tbAuaW1eqR0kOYTO0Z1SobpBxu1czSFh1GbzGvTZG"
}
```

- `code`: Number. [Status code](#status).
- `resourceId`: String. The resource ID for cloud recording. The resource ID is valid for five minutes.

## <a name="start"></a>Starts cloud recording

After getting a resource ID, call this method to start cloud recording.

- Method: POST
- Endpoint: /v1/apps/\<appid\>/cloud_recording/resourceid/\<resourceid\>/mode/\<mode\>/start

> The request frequency limit is 10 times per second per APP ID.

### Parameters

The following parameters are required in the URL.

| Parameter    | Type   | Description                                                  |
| :----------- | :----- | :----------------------------------------------------------- |
| `appid`      | String | The [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id) used in the channel to be recorded. |
| `resourceid` | String | The resource ID requested by the [`acquire`](#acquire) method. |
| `mode`       | String | The recording mode. Supports individual mode (`individual`) and composite mode (`mix`). Composite mode is the default mode. In individual mode, Agora Cloud Recording generates one audio and/or video file for each UID or each specified UID in the channel. In composite mode, Agora Cloud Recording combines the audio and video of all or specified UIDs into a single file. |

The following parameters are required in the request body.

| Parameter       | Type   | Description                                                  |
| :-------------- | :----- | :----------------------------------------------------------- |
| `cname`         | String | The name of the channel to be recorded.                      |
| `uid`           | String | A string that contains the UID of the recording client. Must be the same `uid` used in the [`acquire`](#acquire) method. |
| `clientRequest` | JSON   | A specific client request that requires the following parameters: <li>`token`: (Optional) String. The [dynamic key](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-namekeyadynamic-key) used in the channel to be recorded. Ensure that you set this parameter if the recording channel uses a token.</li><li>[`recordingConfig`](#recordingConfig): (Optional) JSON. The recording configuration.</li><li>[`storageConfig`](#storageConfig): (Optional) JSON. The third-party cloud storage configuration.</li> |

#### <a name="recordingConfig"></a>Recording configuration

`recordingConfig` is a JSON object for recording configuration with the following fields. 

- `streamTypes`: (Optional) Number. The type of the recorded media stream.
  - `0`: Records audio only.
  - `1`: Records video only.
  - `2`: (Default) Records audio and video.
- `decryptionMode`: (Optional) Number. The decryption mode that is the same as the encryption mode set by the Agora Native/Web SDK. When the channel is encrypted, Agora Cloud Recording uses `decryptionMode` to enable the built-in decryption function. 
  - `0`: (Default) None.
  - `1`: AES-128, XTS mode.
  - `2`: AES-128, ECB mode.
  - `3`: AES-256, XTS mode.
- `secret`: (Optional) String. The decryption password when decryption mode is enabled. 
- `channelType`: (Optional) Number. The channel profile. Agora Cloud Recording must use the same channel profile as the Agora Native/Web SDK. Otherwise, issues may occur.
  - `0`: (Default) Communication profile. 
  - `1`: Live broadcast profile.
- `audioProfile`: (Optional) Number. The sample rate, bitrate, encoding mode, and the number of channels. You cannot set this parameter in individual recording mode.
  - `0`: (Default) Sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 48 Kbps.
  - `1`: Sample rate of 48 kHz, music encoding, mono, and a bitrate of up to 128 Kbps.
  - `2`: Sample rate of 48 kHz, music encoding, stereo, and a bitrate of up to 192 Kbps.
- `videoStreamType`: (Optional) Number. The type of the video stream. 
  - `0`: (Default) Records the high-stream video.
  - `1`: Records the low-stream video.
- `maxIdleTime`: (Optional) Number. Agora Cloud Recording automatically stops recording and leaves the channel when there is no user in the recording channel after a time period (30 seconds by default) set by this parameter. The value range is from 5 to 2<sup>32</sup>-1. 
- `transcodingConfig`: (Optional) JSON. The transcoding configuration. You cannot set this parameter in individual recording mode. If you set this parameter, ensure that you set `width`, `height`, `fps`, and `bitrate`. Refer to [How do I set the video profile of the recorded video?](https://docs.agora.io/en/faq/recording_video_profile) for detailed information about setting `transcodingConfig`.
  - `width`: (Mandatory) Number. The width of the mixed video (pixels). The default value is 360. The maximum resolution is 1080p and an error occurs if the maximum resolution is exceeded.
  - `height`: (Mandatory) Number. The height of the mixed video (pixels). The default value is 640. The maximum resolution is 1080p and an error occurs if the maximum resolution is exceeded.
  - `fps`: (Mandatory) Number. The video frame rate (fps). The default value is 15.
  - `bitrate`: (Mandatory) Number. The video bitrate (Kbps). The default value is 500.
  - `maxResolutionUid`: (Optional) String. When `mixedVideoLayout` is set as `2` (vertical layout), you can specify the UID of the large video window by this parameter.
  - `backgroundColor`: (Optional) String. The background color of the canvas (the display window or screen) in RGB hex value. The string starts with a "#". The default value is `"#000000"`, the black color.
  - `mixedVideoLayout`: (Optional) Number. The video mixing layout. 0, 1, and 2 are the [predefined layouts](/en/cloud-recording/cloud_recording_layout). If you set this parameter as 3, you need to set the layout by the `layoutConfig` parameter.
    - `0`: (Default) Floating layout. The first user in the channel occupies the full canvas. The other users occupy the small regions on top of the canvas, starting from the bottom left corner. The small regions are arranged in the order of the users joining the channel. This layout supports one full-size region and up to four rows of small regions on top with four regions per row, comprising 17 users.
    - `1`: Best fit layout. This is a grid layout. The number of columns and rows and the grid size vary depending on the number of users in the channel. This layout supports up to 17 users.
    - `2`: Vertical layout. One large region is displayed on the left edge of the canvas, and several smaller regions are displayed along the right edge of the canvas. The space on the right supports up to 2 columns of small regions with 8 regions per column. This layout supports up to 17 users.
    - `3`: Customized layout. Set the `layoutConfig` parameter to customize the layout.
  - `layoutConfig`: (Optional) JSONArray. An array of the configuration of each user's region. Supports 17 users at most. Each user's region configuration is a JSON object with the following parameters:
    - `uid`: (Optional) String. The string contains the UID of the user displaying the video in the region. If this parameter is not specified, the configurations apply in the order of the users joining the channel.
    - `x_axis`: (Mandatory) Float. The relative horizontal position of the top-left corner of the region. The value is between 0.0 (leftmost) and 1.0 (rightmost). 
    - `y_axis`: (Mandatory) Float. The relative vertical position of the top-left corner of the region. The value is between 0.0 (top) and 1.0 (bottom).
    - `width`: (Mandatory) Float. The relative width of the region. The value is between 0.0 and 1.0.
    - `height`: (Mandatory) Float. The relative height of the region. The value is between 0.0 and 1.0.
    - `alpha`: (Optional) Float. The transparency of the image. The value is between 0.0 (transparent) and 1.0 (opaque). The default value is 1.0.
    - `render_mode`: (Optional) Number. The video display mode:
      - `0`: (Default) Cropped mode. Uniformly scales the video until it fills the visible boundaries (cropped). One dimension of the video may have clipped contents.
      - `1`: Fit mode. Uniformly scales the video until one of its dimension fits the boundary (zoomed to fit). Areas that are not filled due to the disparity in the aspect ratio will be filled with black.

- `subscribeVideoUids`: (Optional) JSONArray. An array of the user IDs (UIDs) of the users whose video you want to record, such as `["123","456"]`. The length of the array should not exceed 32. Once you set the parameter, do not set `streamTypes` in `recordingConfig` as `0`. 

- `subscribeAudioUids`: (Optional) JSONArray. An array of the user IDs (UIDs) of the users whose audio you want to record, such as `["123","456"]`. The length of the array should not exceed 32. Once you set the parameter, do not set `streamTypes` in `recordingConfig` as `1`.

> Once you set `subscribeVideoUids` or `subscribeAudioUids`, Agora Cloud Recording records the audio or video of the specified users only. For example, if `subscribeVideoUids` is set and `subscribeAudioUids` is not set or is an empty array, Agora Cloud Recording records only the video (no audio) of the specified users. If both parameters are empty or if neither is set, all the users' audio and video will be recorded.

- `subscribeUidGroup`: (Optional) Number. The estimated maximum number of subscribed users. You must set this parameter in individual mode. For example, if `subscribeVideoUids` is `["100","101","102"]` and `subscribeAudioUids` is `["101","102","103"]`, the number of subscribed users is 4.

  - `0`: 1 to 2 UIDs
  - `1`: 3 to 7 UIDs
  - `2`: 8 to 12 UIDs
  - `3`: 13 to 17 UIDs


#### <a name="storageConfig"></a>Cloud storage configuration

`storageConfig` is a JSON object that configures the third-party cloud storage with the following fields.

- `vendor`: Number. The third-party cloud storage vendor.    

  - `0`: [Qiniu Cloud](https://www.qiniu.com/en/products/kodo)
  - `1`: [Amazon S3](https://aws.amazon.com/s3/?nc1=h_ls)
  - `2`: [Alibaba Cloud](https://www.alibabacloud.com/product/oss)
  - `3`: [Tencent Cloud](https://intl.cloud.tencent.com/product/cos)

- `region`: Number. The regional information specified by the third-party cloud storage:
  When the third-party cloud storage is [Qiniu Cloud](https://www.qiniu.com/en/products/kodo) (`vendor` = 0):

  - `0`: East China
  - `1`: North China 
  - `2`: South China
  - `3`: North America  

  When the third-party cloud storage is [Amazon S3](https://aws.amazon.com/s3/?nc1=h_ls) (`vendor` = 1):

  - `0`: US_EAST_1 
  - `1`: US_EAST_2 
  - `2`: US_WEST_1 
  - `3`: US_WEST_2 
  - `4`: EU_WEST_1 
  - `5`: EU_WEST_2 
  - `6`: EU_WEST_3 
  - `7`: EU_CENTRAL_1 
  - `8`: AP_SOUTHEAST_1 
  - `9`: AP_SOUTHEAST_2 
  - `10`: AP_NORTHEAST_1 
  - `11`: AP_NORTHEAST_2 
  - `12`: SA_EAST_1 
  - `13`: CA_CENTRAL_1 
  - `14`: AP_SOUTH_1 
  - `15`: CN_NORTH_1 
  - `17`: US_GOV_WEST_1 

  When the third-party cloud storage is [Alibaba Cloud](https://www.alibabacloud.com/product/oss) (`vendor` = 2):

  - `0`: CN_Hangzhou 
  - `1`: CN_Shanghai 
  - `2`: CN_Qingdao 
  - `3`: CN_Beijing
  - `4`: CN_Zhangjiakou 
  - `5`: CN_Huhehaote 
  - `6`: CN_Shenzhen 
  - `7`: CN_Hongkong 
  - `8`: US_West_1 
  - `9`: US_East_1 
  - `10`: AP_Southeast_1 
  - `11`: AP_Southeast_2 
  - `12`: AP_Southeast_3 
  - `13`: AP_Southeast_5 
  - `14`: AP_Northeast_1 
  - `15`: AP_South_1 
  - `16`: EU_Central_1 
  - `17`: EU_West_1 
  - `18`: EU_East_1

When the third-party cloud storage is [Tencent Cloud](https://intl.cloud.tencent.com/product/cos) (`vendor` = 3):

  - `0`：AP_Beijing_1
  - `1`：AP_Beijing
  - `2`：AP_Shanghai
  - `3`：AP_Guangzhou
  - `4`：AP_Chengdu 
  - `5`：AP_Chongqing 
  - `6`：AP_Shenzhen_FSI 
  - `7`：AP_Shanghai_FSI 
  - `8`：AP_Beijing_FSI 
  - `9`：AP_Hongkong 
  - `10`：AP_Singapore 
  - `11`：AP_Mumbai 
  - `12`：AP_Seoul 
  - `13`：AP_Bangkok 
  - `14`：AP_Tokyo 
  - `15`：NA_Siliconvalley 
  - `16`：NA_Ashburn 
  - `17`：NA_Toronto 
  - `18`：EU_Frankfurt 
  - `19`：EU_Moscow


- `bucket`: String. The bucket of the third-party cloud storage.

- `accessKey`: String. The access key of the third-party cloud storage.

- `secretKey`: String. The secret key of the third-party cloud storage.

- `fileNamePrefix`: (Optional) JSONArray. An array of strings. Sets the path of the recorded files in the third-party cloud storage. For example, if `fileNamePrefix` = `["directory1","directory2"]`, Agora Cloud Recording will add the prefix "`directory1/directory2/`" before the name of the recorded file, that is, `directory1/directory2/xxx.m3u8`. The prefix's length, including the slashes, should not exceed 128 characters. The string itself should not contain any slash. The supported characters are as follows:
  - The 26 lowercase English letters: a to z
  - The 26 uppercase English letters: A to Z
  - The 10 numbers: 0 to 9


### An HTTP request example of `start`

- The request URL is：

```
https://api.agora.io/v1/apps/<yourappid>/cloud_recording/resourceid/<resourceid>/mode/<mode>/start
```
- `Content-type` is `application/json;charset=utf-8`.
- `Authorization` is basic HTTP authentication, see [RESTful API authentication](https://docs.agora.io/en/faq/restful_authentication) for details.
- The request body

```json
{
    "uid": "527841",
    "cname": "httpClient463224",
    "clientRequest": {
        "token": "<token if any>",
        "recordingConfig": {
            "maxIdleTime": 30,
            "streamTypes": 2,
            "audioProfile": 1,
            "channelType": 0, 
            "videoStreamType": 1, 
            "transcodingConfig": {
                "height": 640, 
                "width": 360,
                "bitrate": 500, 
                "fps": 15, 
                "mixedVideoLayout": 1,
                "backgroundColor": "#FF0000"
						},
            "subscribeVideoUids": ["123","456"], 
            "subscribeAudioUids": ["123","456"],
            "subscribeUidGroup": 0
        }, 
        "storageConfig": {
            "accessKey": "xxxxxxf",
            "region": 3,
            "bucket": "xxxxx",
            "secretKey": "xxxxx",
            "vendor": 2,
            "fileNamePrefix": ["directory1","directory2"]
        }
    }
}
```

### A response example of `start`

```json
"Code": 200,
"Body":
{
  "sid": "38f8e3cfdc474cd56fc1ceba380d7e1a", 
  "resourceId": "JyvK8nXHuV1BE64GDkAaBGEscvtHW7v8BrQoRPCHxmeVxwY22-x-kv4GdPcjZeMzoCBUCOr9q-k6wBWMC7SaAkZ_4nO3JLqYwM1bL1n6wKnnD9EC9waxJboci9KUz2WZ4YJrmcJmA7xWkzs_L3AnNwdtcI1kr_u1cWFmi9BWAWAlNd7S7gfoGuH0tGi6CNaOomvr7-ILjPXdCYwgty1hwT6tbAuaW1eqR0kOYTO0Z1SobpBxu1czSFh1GbzGvTZG"
}
```

- `code`: Number. [Status code](#status).
- `resourceId`: String. The resource ID for cloud recording. The resource ID is valid for five minutes.
- `sid`: String. The recording ID. The unique identification of the current recording.

## <a name="update"></a>Updates the video mixing layout

During a recording, you can call this method to update the video mixing layout multiple times.

This method call overrides the existing layout configurations. For example, if you set the `backgroundColor` parameter as `"#FF0000"` (red) when starting a recording and call this method to update the layout without setting the `backgroundColor` parameter, the background color changes back to black (the default value).

- Method: POST
- Endpoint: /v1/apps/\<appid\>/cloud_recording/resourceid/\<resourceid\>/sid/\<sid\>/mode/\<mode\>/updateLayout

> The request frequency limit is 10 times per second per APP ID.

### Parameters

The following parameters are required in the URL.

| Parameter    | Type   | Description                                                  |
| :----------- | :----- | :----------------------------------------------------------- |
| `appid`      | String | The [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id) used in the channel to be recorded. |
| `resourceid` | String | The resource ID requested by the [`acquire`](#acquire) method. |
| `sid`        | String | The recording ID created by the [`start`](#start) method.    |
| `mode`       | String | The recording mode. Supports individual mode (`individual`) and composite mode (`mix`). |

The following parameters are required in the request body.

| Parameter       | Type   | Description                                                  |
| :-------------- | :----- | :----------------------------------------------------------- |
| `cname`         | String | The name of the channel to be recorded.                      |
| `uid`           | String | A string that contains the UID of the recording client. Must be the same `uid` used in the [`acquire`](#acquire) method. |
| `clientRequest` | JSON   | A specific client request. See the following list for details. |

`clientRequest` requires the following parameters:

- `maxResolutionUid`: (Optional) String. When the `layoutType` parameter is set as `2` (vertical layout), you can specify the UID of the large video window by this parameter.
- `mixedVideoLayout`: (Optional) Number. The video mixing layout. 0, 1, and 2 are the [predefined layouts](/en/cloud-recording/cloud_recording_layout). If you set this parameter as 3, you need to set the layout by the `layoutConfig` parameter.
  - `0`: (Default) Floating layout. The first user in the channel occupies the full canvas. The other users occupy the small regions on top of the canvas, starting from the bottom left corner. The small regions are arranged in the order of the users joining the channel. This layout supports one full-size region and up to four rows of small regions on top with four regions per row, comprising 17 users.
  - `1`: Best fit layout. This is a grid layout. The number of columns and rows and the grid size vary depending on the number of users in the channel. This layout supports up to 17 users.
  - `2`: Vertical layout. One large region is displayed on the left edge of the canvas, and several smaller regions are displayed along the right edge of the canvas. The space on the right supports up to 2 columns of small regions with 8 regions per column. This layout supports up to 17 users.
  - `3`: Customized layout. Set the `layoutConfig` parameter to customize the layout.
- `backgroundColor`: (Optional) String. The background color of the canvas (the display window or screen) in RGB hex value. The string starts with a "#". The default value is `"#000000"`, the black color.
- `layoutConfig`: (Optional) JSONArray. An array of the configuration of each user's region. Supports 17 users at most. Each user's region configuration is a JSON object with the following parameters:
  - `uid`: (Optional) String. The string contains the UID of the user displaying the video in the region. If this parameter is not specified, the configurations apply in the order of the users joining the channel.
  - `x_axis`: (Mandatory) Float. The relative horizontal position of the top-left corner of the region. The value is between 0.0 (leftmost) and 1.0 (rightmost). `x_axis` can also be an integer 0 or 1.
  - `y_axis`: (Mandatory) Float. The relative vertical position of the top-left corner of the region. The value is between 0.0 (top) and 1.0 (bottom). `y_axis` can also be an integer 0 or 1.
  - `width`: (Mandatory) Float. The relative width of the region. The value is between 0.0 and 1.0. `width` can also be an integer 0 or 1.
  - `height`: (Mandatory) Float. The relative height of the region. The value is between 0.0 and 1.0. `height` can also be an integer 0 or 1.
  - `alpha`: (Optional) Float. The transparency of the image. The value is between 0.0 (transparent) and 1.0 (opaque). The default value is 1.0.
  - `render_mode`: (Optional) Number. The video display mode:
    - `0`: (Default) Cropped mode. Uniformly scales the video until it fills the visible boundaries (cropped). One dimension of the video may have clipped contents.
    - `1`: Fit mode. Uniformly scales the video until one of its dimension fits the boundary (zoomed to fit). Areas that are not filled due to the disparity in the aspect ratio will be filled with black.

### A request example of `updateLayout `

- The request URL is:

```
https://api.agora.io/v1/apps/<appid>/cloud_recording/resourceid/<resourceid>/sid/<sid>/mode/<mode>/updateLayout
```

- `Content-type` is `application/json;charset=utf-8`.
- `Authorization` is the basic authorization, see [RESTful API authentication](https://docs.agora.io/en/faq/restful_authentication) for details.
- The request body:

```json
{
    "uid": "527841",
    "cname": "httpClient463224",
    "clientRequest": {
        "mixedVideoLayout": 3,
        "backgroundColor": "#FF0000",
        "layoutConfig": [
        {
             "uid": "1",
             "x_axis": 0.1,
             "y_axis": 0.1,
             "width": 0.1,
             "height": 0.1,
             "alpha": 1.0,
             "render_mode": 1
         },
        {
             "uid": "2",
             "x_axis": 0.2,
             "y_axis": 0.2,
             "width": 0.1,
             "height": 0.1,
             "alpha": 1.0,
             "render_mode": 1
         }
         ]
     }
}
```

### A response example of `updateLayout`

```json
"Code": 200,
"Body":
{
  "sid": "38f8e3cfdc474cd56fc1ceba380d7e1a", 
  "resourceId": "JyvK8nXHuV1BE64GDkAaBGEscvtHW7v8BrQoRPCHxmeVxwY22-x-kv4GdPcjZeMzoCBUCOr9q-k6wBWMC7SaAkZ_4nO3JLqYwM1bL1n6wKnnD9EC9waxJboci9KUz2WZ4YJrmcJmA7xWkzs_L3AnNwdtcI1kr_u1cWFmi9BWAWAlNd7S7gfoGuH0tGi6CNaOomvr7-ILjPXdCYwgty1hwT6tbAuaW1eqR0kOYTO0Z1SobpBxu1czSFh1GbzGvTZG"
}
```

- `code`: Number. [Status code](#status).
- `resourceId`: String. The resource ID for cloud recording. The resource ID is valid for five minutes.
- `sid`: String. The recording ID. The unique identification of the current recording.

## <a name="query"></a>Queries the recording status

After you start a recording, you can call query to check its status.

<div class="note alert"><code>query</code> works only with an ongoing recording session. If you call <code>query</code> after a recording ends or after it starts with error, you get a 404 (Not Found) error. We recommend that you use the callback service for getting the details of all cloud recording events. See <a href="https://docs.agora.io/en/cloud-recording/cloud_recording_callback_rest">Agora Cloud Recording RESTful API Callback Service</a> for more information.</div>
- Method: GET
- Endpoint: /v1/apps/\<appid\>/cloud_recording/resourceid/\<resourceid\>/sid/\<sid\>/mode/\<mode\>/query

> The request frequency limit is 10 times per second per APP ID.

### Parameters

The following parameters are required in the URL.

| Parameter    | Type   | Description                                                  |
| :----------- | :----- | :----------------------------------------------------------- |
| `appid`      | String | The [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id) used in the channel to be recorded. |
| `resourceid` | String | The resource ID requested by the [`acquire`](#acquire) method. |
| `sid`        | String | The recording ID created by the [`start`](#start) method.    |
| `mode`       | String | The recording mode. Supports individual mode (`individual`) and composite mode (`mix`). |

### An HTTP request example of `query`

- The request URL is：

```
https://api.agora.io/v1/apps/<yourappid>/cloud_recording/resourceid/<resourceid>/sid/<sid>/mode/<mode>/query
```

- `Content-type` is `application/json;charset=utf-8`.
- `Authorization` is the basic authentication, see [RESTful API authentication](https://docs.agora.io/en/faq/restful_authentication) for details.

### A response example of `query`

```json
"Code": 200,
"Body":
{
  "resourceId":"JyvK8nXHuV1BE64GDkAaBGEscvtHW7v8BrQoRPCHxmeVxwY22-x-kv4GdPcjZeMzoCBUCOr9q-k6wBWMC7SaAkZ_4nO3JLqYwM1bL1n6wKnnD9EC9waxJboci9KUz2WZ4YJrmcJmA7xWkzs_L3AnNwdtcI1kr_u1cWFmi9BWAWAlNd7S7gfoGuH0tGi6CNaOomvr7-ILjPXdCYwgty1hwT6tbAuaW1eqR0kOYTO0Z1SobpBxu1czSFh1GbzGvTZG",
  "sid":"38f8e3cfdc474cd56fc1ceba380d7e1a",
  "serverResponse":{
    "fileListMode": "json",
    "fileList": [
   {
      "filename": "xxx.m3u8",
      "trackType": "audio_and_video",
      "uid": "123",
      "mixedAllUser": "true",
      "isPlayable": "true",
      "sliceStartTime": "1562724971626"
   },    
   {
      "filename": "xxx.m3u8",
      "trackType": "audio_and_video",
      "uid": "456",
      "mixedAllUser": "true",
      "isPlayable": "true",
      "sliceStartTime": "1562724971626"
   }
   ],
    "status": "5",
    "sliceStartTime": "1562724971626"
   }       
}
```

- `code`: Number. [Status code](#status).

- `resourceId`: String. The resource ID for cloud recording. The resource ID is valid for five minutes.

- `sid`: String. The recording ID. The unique identification of the current recording.

- `serverResponse`: JSON. The details about the recording status.
  - `fileListMode`: String. The data type of `fileList`.
    - `"string"`: `fileList` is a string. In composite mode, `fileListMode` is `"string"`.
    - `"json"`: `fileList` is a JSONArray. In individual mode, `fileListMode` is `"json"`.
  - `fileList`: When `fileListMode` is `"string"`, `fileList` is a string that represents the filename of the M3U8 file. When `fileListMode` is `"json"`, `fileList` is a JSONArray that contains the details of each recorded file.
    - `filename`: String. The name of the M3U8 file.
    - `trackType`: String. The type of the recorded file.
      - `"audio"`: Audio file.
      - `"video"`: Video file (no audio).
      - `"audio_and_video"`: Video file (with audio).
    - `uid`: String. User ID. The user whose audio or video is recorded in the file.
    - `mixedAllUser`: String. Whether the audio and video of all users are combined into a single file.
      - `"true"`: All users are recorded in a single file.
      - `"false"`: Each user is recorded separately.
    - `isPlayable`: String. Whether the file can be played online.
      - `"true"`: The file can be played online.
      - `"false"`: The file cannot be played online.
    - `sliceStartTime`: String. The Unix time (ms) when the recording starts.
  - `status`: Number. The recording status.
    - `0`: The recording has not started.
    - `1`: The initialization is complete.
    - `2`: The recorder is starting.
    - `3`: The uploader is ready.
    - `4`: The recorder is ready.
    - `5`: The first recorded file is uploaded. After uploading the first file, the status is `5` when the recording is running.
    - `6`: The recording stops.
    - `7`: The Agora Cloud Recording service stops.
    - `8`: The recording is ready to exit.
    - `20`: The recording exits abnormally.
  - `sliceStartTime`: String. The time when the recording starts. Unix timestamp (ms).

## <a name="stop"></a>Stops cloud recording

When a recording finishes, call this method to leave the channel and stop recording. To use Agora Cloud Recording again, you need to call the  [`acquire`](#acquire) method for a new resource ID.

- Method: POST
- Endpoint: /v1/apps/\<appid\>/cloud_recording/resourceid/\<resourceid\>/sid/\<sid\>/mode/\<mode\>/stop

> - The request frequency limit is 10 times per second per APP ID.
> - Agora Cloud Recording automatically leaves the channel and stops recording when no user is in the channel for more than 30 seconds by default.

### Parameters

The following parameters are required in the URL.

| Parameter    | Type   | Description                                                  |
| :----------- | :----- | :----------------------------------------------------------- |
| `appid`      | String | The [App ID](https://docs.agora.io/en/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id) used in the channel to be recorded. |
| `resourceid` | String | The resource ID requested by the [`acquire`](#acquire) method. |
| `sid`        | String | The recording ID created by the [`start`](#start) method.    |
| `mode`       | String | The recording mode. Supports individual mode (`individual`) and composite mode (`mix`). |

The following parameters are required in the request body.

| Parameter       | Type   | Description                                                  |
| :-------------- | :----- | :----------------------------------------------------------- |
| `cname`         | String | The name of the channel to be recorded.                      |
| `uid`           | String | A string that contains the UID of the recording client. Must be the same `uid` used in the [`acquire`](#acquire) method. |
| `clientRequest` | JSON   | A specific client request that is empty for this method.     |

### An HTTP request example of `stop`

- The request URL is:

```
https://api.agora.io/v1/apps/<yourappid>/cloud_recording/resourceid/<resourceid>/sid/<sid>/mode/<mode>/stop
```

- `Content-type` is `application/json;charset=utf-8`.

- `Authorization` is the basic authentication, see [RESTful API authentication](https://docs.agora.io/en/faq/restful_authentication) for details.

- The request body:

  ```json
  {
    "cname": "httpClient463224",
    "uid": "527841",
    "clientRequest":{
    }
  }
  ```

### A response example of `stop`

```json
"Code": 200,
"Body":
{
  "resourceId":"JyvK8nXHuV1BE64GDkAaBGEscvtHW7v8BrQoRPCHxmeVxwY22-x-kv4GdPcjZeMzoCBUCOr9q-k6wBWMC7SaAkZ_4nO3JLqYwM1bL1n6wKnnD9EC9waxJboci9KUz2WZ4YJrmcJmA7xWkzs_L3AnNwdtcI1kr_u1cWFmi9BWAWAlNd7S7gfoGuH0tGi6CNaOomvr7-ILjPXdCYwgty1hwT6tbAuaW1eqR0kOYTO0Z1SobpBxu1czSFh1GbzGvTZG",
  "sid":"38f8e3cfdc474cd56fc1ceba380d7e1a",
  "serverResponse":{
    "fileListMode": "json",
    "fileList": [
    {
      "filename": "xxx.m3u8",
      "trackType": "audio_and_video",
      "uid": "123",
      "mixedAllUser": "true",
      "isPlayable": "true",
      "sliceStartTime": "1562724971626"
    },
    {
      "filename": "xxx.m3u8",
      "trackType": "audio_and_video",
      "uid": "456",
      "mixedAllUser": "true",
      "isPlayable": "true",
      "sliceStartTime": "1562724971626"
    }
    ],
    "uploadingStatus": "uploaded"
  }
}
```

- `code`: Number. [Status code](#status).

- `resourceId`: String. The resource ID for cloud recording. The resource ID is valid for five minutes.

- `sid`: String. The recording ID. The unique identification of the current recording.

- `serverResponse`: JSON. The details about the recording status.
  - `fileListMode`: String. The data type of `fileList`.
    - `"string"`: `fileList` is a string. In composite mode, `fileListMode` is `"string"`.
    - `"json"`: `fileList` is a JSONArray. In individual mode, `fileListMode` is `"json"`.
  - `fileList`: When `fileListMode` is `"string"`, `fileList` is a string that represents the filename of the M3U8 file. When `fileListMode` is `"json"`, `fileList` is a JSONArray that contains the details of each recorded file.
    - `filename`: String. The name of the M3U8 file.
    - `trackType`: String. The type of the recorded file.
      - `"audio"`: Audio file.
      - `"video"`: Video file (no audio).
      - `"audio_and_video"`: Video file (with audio).
    - `uid`: String. User ID. The user whose audio or video is recorded in the file.
    - `mixedAllUser`: String. Whether the audio and video of all users are combined into a single file.
      - `"true"`: All users are recorded in a single file.
      - `"false"`: Each user is recorded separately.
    - `isPlayable`: String. Whether the file can be played online.
      - `"true"`: The file can be played online.
      - `"false"`: The file cannot be played online.
    - `sliceStartTime`: String. The Unix time (ms) when the recording starts.     
  - `uploadingStatus`: String. The upload status.
    - `"uploaded"`: All the recorded files are uploaded to the third-party cloud storage.
    - `"backuped"`:  Some of the recorded files fail to upload to the third-party cloud storage and upload to Agora Cloud Backup instead. Agora Cloud Backup automatically uploads these files to your cloud storage. 
    - `"unknown"`: Unknown status.

## <a name="status"></a>Status code

| Code | Description                                                  |
| :--- | :----------------------------------------------------------- |
| 200  | The request handle is successful.                            |
| 201  | The request is successful and new resources are created.     |
| 206  | No user in the channel sent a stream during the recording process, or some of the recorded files are uploaded to the Agora Cloud Backup instead of the third-party cloud storage. |
| 400  | The input is in the wrong format.                            |
| 401  | Unauthorized (incorrect App ID/Customer Certificate).        |
| 404  | The requested resource could not be found.                   |
| 500  | An internal error occurs in the Agora Cloud Recording RESTful API service. |
| 504  | The server was acting as a gateway or proxy and did not receive the response from the upstream server. |

## Errors

This section lists the common errors in using the Agora Cloud Recording RESTful API. If you encounter other errors, contact Agora technical support.

- `2`: Invalid parameter. Possible reasons:
  - The parameter type is wrong.
  - The parameter is spelt wrong. All the parameters are case sensitive.
  - The mandatory parameters are missing.
- `7`: The recording is already running. Do not repeat the [`start`](#start) request with the same resource ID.
- `8`: Errors in the HTTP request header fields. Possible reasons:
  - Content-type is wrong. Ensure that the `Content-type` field is `application/json;charset=utf-8`.
  - `cloud_recording` is missing in the request URL.
  - The HTTP method is wrong.
- `53`: The recording is already running. This error occurs when you use the same parameters to call [`acquire`](#acquire) again and use the new resource ID in the [`start`](#start) request. To start multiple recording instances, use a different UID for each instance.
- `432`: The parameter in the request is incorrect. Either the parameter is invalid, or the App ID, channel name, or UID does not match the resource ID.
- `433`: The resource ID has expired. You need to start recording within five minutes after getting a resource ID. Call [acquire](#acquire) to get a new resource ID.
- `435`: No recorded files created. There is nothing to record because no user is in the channel.
- `501`: The recording service is exiting. This error might occur when you call [query](#query) after [stop](#stop).
- `1001`: Fails to parse the resource ID. Call [acquire](#acquire) to get a new resource ID.
- `1003`: The App ID or recording ID (sid) does not match the resource ID. Ensure that the App ID or recording ID matches the resource ID in each recording session.
- `1013`: The channel name is invalid. The string length must be less than 64 bytes. Supported character scopes are:
  - All lowercase English letters: a to z.        
  - All uppercase English letters: A to Z.
  - All numeric characters: 0 to 9.
  - The space character.
  - Punctuation characters and other symbols, including: "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", " {", "}", "|", "~", ",".
- `1028`: Invalid parameters in the request body of the [`updateLayout`](#update) method.
- `"invalid appid"`: Invalid App ID. Ensure that the [App ID](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#a-nameappidaapp-id) is correct. If the App ID is correct and you still get this error message, contact Agora technical support.