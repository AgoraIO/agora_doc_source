---
title: 审核频道内的音频
platform: All Platforms
updatedAt: 2020-11-25 05:43:54
---
本文介绍如何使用阿里语音智能审核 RESTful API 对频道内的音频进行实时审核。

## 前提条件

请确保满足以下要求：

- [开通 Agora 云端录制服务](https://docs.agora.io/cn/cloud-recording/cloud_recording_rest?platform=All%20Platforms#开通云端录制服务)。阿里语音智能审核依赖 Agora 云端录制服务对频道内的媒体流进行订阅。因此，在使用阿里语音智能审核 RESTful API 之前，你必须首先开通 Agora 云端录制服务。
- 联系 [sales@agora.io](mailto:sales@agora.io) 开通阿里语音智能审核。

## 实现方法

要对频道内的音频进行实时审核，你需要通过应用程序服务器调用阿里语音智能审核 RESTful API，发送 HTTP 请求。阿里语音智能审核会将审核结果以 HTTP 请求的形式发送到你指定的地址。

![](https://web-cdn.agora.io/docs-files/1579162816843)


下图为实现音频审核需要调用的 API 时序图。

![](https://web-cdn.agora.io/docs-files/1579162827815)

### 数据格式

所有的请求都发送给域名：`api.agora.io`。仅支持 HTTPS 协议。

- 请求：请求的格式详见下面的示例
- 响应：响应内容的格式为 JSON

> 所有的请求 URL 和请求包体内容都是区分大小写的。

### 通过 Basic HTTP 认证

Agora RESTful API 要求 Basic HTTP 认证。每次发送 HTTP 请求时，都必须在请求头部填入 `Authorization`字段。关于如何生成该字段的值，请参考 [HTTP 基本认证](https://docs.agora.io/cn/faq/restful_authentication)。

### 获取 resource ID

在开始审核前，必须调用 `acquire` 方法请求一个用于审核的 resource ID。

调用该方法成功后，你可以从 HTTP 响应包体中的 `resourceId` 字段得到一个 resource ID。这个 resource ID 的时效为 5 分钟，你需要在 5 分钟内用这个 resource ID 开始审核。

> 一个 resource ID 仅可用于一次审核。

### 加入频道

获得 resource ID 后，在五分钟內调用 `start` 方法加入频道开始审核。

<div class="alert note">阿里语音智能审核不支持 String 用户名（User Account）。请确保频道内所有用户均使用整型 UID。同时，在调用 <code>start</code> 方法时，请确保 <code>uid</code> 字段引号内为整型 UID。</div>

调用该方法成功后，你可以从 HTTP 响应包体中获得一个 sid （审核 ID)。该 ID 是一次审核周期的唯一标识。

### 查询服务状态

审核过程中，你可以多次调用 `query` 方法查询服务状态。

调用该方法成功后，你可以从 HTTP 响应包体中获得审核的状态。

### 停止审核

调用 `stop` 方法离开频道，停止审核。

> 当频道空闲（无用户）超过预设时间（默认为 30 秒） 后，阿里语音智能审核会自动停止。

调用该方法成功后，你可以从 HTTP 响应包体中获得审核的状态。

## 回调通知

阿里语音智能审核的回调通知包含以下两类：

- 审核结果的通知：直接通知到你通过 `callbackAddr` 参数设置的地址。

- 事件通知：需要联系 [sales@agora.io](mailto:sales@agora.io) 开通消息通知服务。

详情见[阿里语音智能审核 RESTful API](/cn/content-moderation/ali_audio_restful_api#回调通知)。

## 开发注意事项

- 调用 `start` 之前必须调用 `acquire` 获取一个 resource ID。
- 一个 resource ID 只可用于一次 `start` 请求。
- 调用 `stop` 之后不能再调用 `query`。

下面列出一些常见的调用错误：

- `acquire` ➡ `start` ➡ `start`

  用同一个 resource ID 重复调用 `start`，会收到 HTTP 状态码 201，错误码 7。

- `acquire` ➡ `start` ➡ `acquire` ➡ `start`

  用相同的参数重复调用 `acquire` 和 `start`，会收到 HTTP 状态码 400，错误码 53。

- `acquire` ➡ `start` ➡ 停止审核 ➡ `query`

  停止审核后再去调用 `query`，会收到 HTTP 状态码 404，错误码 404。停止审核有以下几种情况：

  - 主动调用 `stop`。
  - 频道内没有用户超过设定的时间自动停止审核。
  - 异步检查参数错误导致审核停止。

- `acquire` ➡ `start` ➡ `stop` & `query`

  调用 `stop` 的过程中调用 `query`，会影响 `stop` 的响应内容，响应的 HTTP 状态码为 206。

如果你在集成和使用中遇到其他问题，可以参考[常见错误](/cn/content-moderation/ali_audio_restful_api#常见错误)。

## 示例代码

我们提供使用阿里语音智能审核 RESTful API 进行语音审核的示例代码（Python），供你参考。

```python
import requests
import time
TIMEOUT=60

# TODO: Fill in the following information:
APPID=""
Auth=""            # Basic authorization
Cname=""
CHANNEL_TYPE = ""  # 0: 通信模式; 1: 直播模式
ACCESS_KEY=""
SECRET_KEY=""
CALLBACK_ADDR=""   # 接收审核结果的 HTTP 服务器地址
url="https://api.agora.io/v1/apps/%s/cloud_recording/" % APPID

acquire_body={
        "uid": "123",
        "cname": Cname,
        "clientRequest": {}
        }


start_body={
        "uid": "123",
        "cname": Cname,
        "clientRequest": {
            "recordingConfig": {
                "streamTypes": 0,
                "maxIdleTime": 30,
                "channelType": CHANNEL_TYPE
            },
            "extensionServiceConfig": {
                "extensionServices": [{
                    "serviceParam": {
                        "apiData": {
                            "secretKey": SECRET_KEY,
                            "callbackSeed": "test",
                            "accessKey": ACCESS_KEY
                        },
                        "callbackAddr": CALLBACK_ADDR
                    },
                    "streamTypes": 0,
                    "serviceName": "aliyun_voice_async_scan"
                }]
            }
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

def start_moderation():
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
        print("Status: %s" % r_query.json())
    else:
        print("Query failed. Code %s, info: %s" % (r_query.status_code, r_query.json()))

    time.sleep(15)

    stop_url = url+"resourceid/%s/sid/%s/mode/mix/stop" % (resourceId, sid)
    r_stop = cloud_post(stop_url, stop_body)
    if r_stop.status_code == 200:
        print("Stop success")
    else:
        print("Stop failed! Code: %s " % r_stop.status_code)

start_moderation()
```

## 相关文档

- [阿里语音智能审核 RESTful API](/cn/content-moderation/ali_audio_restful_api)