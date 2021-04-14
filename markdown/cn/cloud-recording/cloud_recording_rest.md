---
title: 云端录制 RESTful API 快速开始
platform: All Platforms
updatedAt: 2020-11-11 06:08:07
---
Agora 云端录制 1.1.0 及以后版本支持 RESTful API，无需集成 SDK，直接通过网络请求开启和控制云录制，在自己的网页或应用中灵活使用。

通过 RESTful API，你可以发送网络请求控制云端录制：

- 开始/结束云端录制
- 查询当前的录制状态

![img](https://web-cdn.agora.io/docs-files/1559295245761)

> - 你需要通过自己的 app server 发送网络请求。
> - 云端录制 RESTful API 仅支持 HTTPS 协议。

同时云端录制 RESTful API 还提供回调服务，开通后你可以收到云端录制的事件通知，下表列出回调服务和使用 RESTful API 查询录制状态的区别，你可以根据自己的需要选择是否开通回调服务。

| 查询状态                                                     | 回调服务                                         |
| ------------------------------------------------------------ | ------------------------------------------------ |
| 调用 [`query`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6/query) 方法即可查询 | 需配置用于接收回调的 HTTP 服务器，并单独开通服务 |
| 需主动查询，无法保证及时性                                   | 事件发生时及时通知                               |
| 仅提供 M3U8 文件名和录制的状态                               | 提供云端录制所有的事件通知和具体信息             |

如需使用回调服务，请参考 [RESTful API 回调](./cloud_recording_callback_rest)。


## 前提条件

请确保开通第三方云存储服务，目前支持[七牛云](https://www.qiniu.com/products/kodo)、[阿里云](https://www.aliyun.com/product/oss)（推荐）、[腾讯云](https://cloud.tencent.com/product/cos) 和 [Amazon S3](https://aws.amazon.com/cn/s3/?nc2=h_m1)。

同时，你需要一个集成了 [Agora RTC SDK](https://docs.agora.io/cn/Agora%20Platform/terms?platform=All%20Platforms#rtc-sdk) 的应用。

## 开通云端录制服务

第一次使用云端录制需要先开通服务，步骤如下：

1. 登录 [控制台](https://console.agora.io)，点击左侧导航栏 ![img](https://web-cdn.agora.io/docs-files/1551250582235) 按钮进入**产品用量**页面。
2. 在页面左上角展开下拉列表选择需要开通云端录制的项目，然后点击云端录制下的**分钟数**。
 ![](https://web-cdn.agora.io/docs-files/1566385129523)
3. 点击**开启云端录制支持**。
4. 点击**应用**。

开通成功后你就可以在用量页面看到云端录制的使用情况。

## 通过 Basic HTTP 认证

Agora RESTful API 要求 Basic HTTP 认证。每次发送 HTTP 请求时，都必须在请求头部填入 `Authorization`  字段。关于如何生成该字段的值，请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。

## 实现云端录制

下图为实现云端录制需要调用的 API 时序图。

> 查询状态和更新合流布局都是可选的，且可以多次调用，但是必须在录制过程中（开始录制后到结束录制前）调用。

![](https://web-cdn.agora.io/docs-files/1565775542161)

### 开始录制

**获取 resource ID**

在开始录制前，必须调用 [`acquire`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6/acquire) 方法请求一个用于云端录制的 resource ID。

调用该方法成功后，你可以从 HTTP 响应包体中的 `resourceId` 字段得到一个 resource ID。这个 resource ID 的时效为 5 分钟，你需要在 5 分钟内用这个 resource ID 开始录制。

> 一个 resource ID 仅可用于一次录制。


**加入频道**

获得 resource ID 后，在五分钟內调用 [`start`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6/start) 方法加入频道开始录制。 

<div class="alert warning">云端录制不支持 String 用户 ID（User Account）。请确保频道内所有用户均使用整型 UID。同时，在调用 <code>start</code> 方法时，请确保 <code>uid</code> 字段引号内为整型 UID。</div>

调用该方法成功后，你可以从 HTTP 响应包体中获得一个 sid （录制 ID)。该 ID 是一次录制周期的唯一标识。

### 查询录制状态

录制过程中，你可以多次调用 [`query`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6/query) 方法查询录制的状态。

调用该方法成功后，你可以从 HTTP 响应包体中获得录制生成的[索引文件](#m3u8)和当前录制的状态。


### 更新合流布局

录制过程中，你可以多次调用 [`updateLayout`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6/updateLayout) 方法设置或更新合流布局。详见[设置合流布局](https://docs.agora.io/cn/cloud-recording/cloud_recording_layout?platform=Linux)。


### 停止录制

调用  [`stop`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6/stop) 方法停止录制。

> 当频道空闲（无用户）超过预设时间（默认为 30 秒） 后，云端录制也会自动退出频道停止录制。

调用该方法成功后，你可以从 HTTP 响应包体中获得录制生成的[索引文件](#m3u8)和当前录制上传的状态。


## 上传和管理录制文件

开始录制后，Agora 服务器会将录制内容切片为多个 TS/WebM 文件并不断上传至预先设定的第三方云存储，直至录制结束。

### 录制 ID

录制 ID 是录制的唯一标识，每一次云端录制对应一个录制 ID。

通过 `start` 请求成功开始录制后，你可以在响应中获取录制 ID（`sid`），所有的回调中也都包含录制 ID。

### <a name="m3u8"></a>录制文件索引

在单流录制模式下，如只录制音频或视频，则每次录制每个 UID 均会生成一个 M3U8 文件；如同时录制音视频，则每次录制每个 UID 会生成两个 M3U8 文件。M3U8文件用于索引该次录制所有的 TS/WebM 文件。你可以通过 M3U8 文件播放和管理录制文件。单流模式下 M3U8 文件以及 TS/WebM 文件的命名规则详见[管理录制文件](/cn/null/cloud_recording_manage_files)。

在合流录制模式下，每次录制均会生成一个 M3U8 文件。合流模式下的 M3U8 文件名由录制 ID 和频道名组成，即 `sid_cname.m3u8`。详情见[管理录制文件](/cn/null/cloud_recording_manage_files)。


### 上传录制文件

录制文件的上传由 Agora 服务器自动完成，你需要关注下面的回调。
> RESTful API 回调服务需单独开通，详见[云端录制 RESTful API 回调服务](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest?platform=All%20Platforms)。

- 录制过程中
  - [`uploading_progress`](./cloud_recording_callback_rest?platform=All%20Platforms#33)：录制开始后约每分钟触发一次，该回调中的 `progress` 参数表示已上传文件占已录制文件的百分比。
- 停止录制后，根据上传情况，SDK 会触发以下回调之一：
  - [`uploaded`](./cloud_recording_callback_rest?platform=All%20Platforms#31)：如果录制文件全部成功上传至预先设定的云存储，最后一个录制切片文件上传完成时触发该回调，通知上传完成。
  - [`backuped`](./cloud_recording_callback_rest?platform=All%20Platforms#32)：如果有录制文件未能成功上传至第三方云存储，Agora 服务器会将这部分文件自动上传至 Agora 云备份，当录制结束后会触发该回调。Agora 云备份会继续尝试将这部分文件上传至设定的第三方云存储。如果等待五分钟后仍然不能正常[播放录制文件](./cloud_recording_onlineplay)，请联系 Agora 技术支持。

如果上传比较耗时，会在 `stop` 的响应中收到 HTTP 状态码 206，表示录制已经停止，但是上传状态未知，需要结合回调事件了解上传状态。
 
## 开发注意事项

- 调用 `start` 之前必须调用 `acquire` 获取一个 resource ID。
- 一个 resource ID 只可用于一次 `start` 请求。
- 调用 `stop` 之后不要再调用 `query`。

### 常见调用错误

- `acquire` ➡ `start` ➡ `start`

  用同一个 resource ID 重复调用 `start`，会收到 HTTP 状态码 201，错误码 7。

- `acquire` ➡ `start` ➡ `acquire` ➡ `start`

  用相同的参数重复调用 `acquire` 和 `start`，会收到 HTTP 状态码 400，错误码 53。

- `acquire` ➡ `start` ➡ 停止录制 ➡ `query`

  停止录制后再去调用 `query`，会收到 HTTP 状态码 404，错误码 404。停止录制有以下几种情况：

  - 主动调用 `stop`。
  - 频道内没有用户超过设定的时间自动停止录制。
  - 异步检查参数错误导致录制停止，包括 `start` 请求的 `transcodingConfig` 和 `storageConfig` 中的参数错误。

- `acquire` ➡ `start` ➡ `stop` & `query`

  调用 `stop` 的过程中调用 `query`，会影响 `stop` 的响应内容：响应的 HTTP 状态码为 206，并且响应中没有 `fileList` 字段。

### 调用 `query` 返回 404

调用 `query` 方法返回 404，可能由多种原因造成。一个常见的原因为第三方云存储信息有误，如 `accessKey` 或 `secretKey` 错误，导致录制文件上传失败。如果你开通了 [Agora 消息通知服务](https://docs-preview.agoralab.co/cn/Agora%20Platform/ncs)，当你的云存储配置出错时，你会收到 [`cloud_recording_error`](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest?platform=All%20Platforms#a-name1a1-cloud_recording_error) 事件的通知。

详情见[为什么成功开启云端录制后调用 query 方法返回 404？](https://docs.agora.io/cn/faq/return-404)

## 其他问题

如果你在集成和使用中遇到其他问题，可以参考以下文档：

- [常见错误](/cn/cloud-recording/cloud_recording_api_rest?platform=All%20Platforms#常见错误)
- [为什么第三方云存储中没有录制文件？](https://docs.agora.io/cn/faq/fail_to_upload)
- [云存储 bucket 区域选择及跨区解决方案](https://docs.agora.io/cn/faq/bucket_region)



## 示例请求

Agora 在 GitHub 上提供一个 [Postman collection](https://github.com/AgoraIO/Agora-RESTful-Service/blob/master/cloud-recording/README.md)，包含了云端录制 RESTful API 的示例请求。你只需将该 collection 导入 Postman，并设置环境变量，便可快速体验云端录制 RESTful API 的基本功能。

你还可以使用 Postman 自动生成各种语言的代码片段。选择某一请求，点击 **Code**，在 **GENERATE CODE SNIPPETS** 窗口选择你需要的语言，即可生成该语言的示例代码。
![](https://web-cdn.agora.io/docs-files/1588737379230)


## <a name="demo-rest"></a>示例代码

以下为使用 RESTful API 进行云端录制的示例代码（Python），供你参考。

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
    "uid": "957947",
    "cname": Cname,
    "clientRequest": {}
}

start_body={
    "uid": "957947",
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
                    "bitrate": 500
            }
        }
    }
}

stop_body={
    "uid": "957947",
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

    time.sleep(10)
    query_url = url + "resourceid/%s/sid/%s/mode/mix/query" %(resourceId, sid)
    r_query = cloud_get(query_url)
    if r_query.status_code == 200:
        print("The recording status: %s" % r_query.json())
    else:
        print("Query failed. Code %s, info: %s" % (r_query.status_code, r_query.json()))

    time.sleep(30)
    stop_url = url+"resourceid/%s/sid/%s/mode/mix/stop" % (resourceId, sid)
    r_stop = cloud_post(stop_url, stop_body)
    if r_stop.status_code == 200:
        print("Stop cloud recording success. FileList : %s, uploading status: %s"
              %(r_stop.json()["serverResponse"]["fileList"], r_stop.json()["serverResponse"]["uploadingStatus"]))
    else:
        print("Stop failed! Code: %s Info: %s" % r_stop.status_code, r_stop.json())

start_record()
```


