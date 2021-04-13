---
title: 合流录制
platform: All Platforms
updatedAt: 2021-04-01 04:07:22
---
## 功能描述

云端录制支持两种录制模式：

- 单流录制模式：分别录制每个 UID 的音频流和视频流。一个 UID 对应一个纯音频文件和一个纯视频文件。
- 合流录制模式：（默认模式）频道内所有 UID 的音视频混合录制为一个音视频文件。

本文介绍如何通过设置 RESTful API 参数在合流模式下进行录制。

阅读本文前，请确保你已了解如何使用 RESTful API 进行云端录制，详见[云端录制 RESTful API 快速开始](https://docs.agora.io/cn/cloud-recording/cloud_recording_rest?platform=All Platforms)。单流或合流模式的设置必须在开始录制的时候完成，不支持在录制开始后切换模式。

> 为方便起见，本文假设频道内每个用户都发送音频和视频。如果有用户没有发送音频或视频（例如直播频道中的观众），一般不会生成该用户的音频或视频录制文件（Web 端例外）。

## 实现方法

在调用 [start](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=All Platforms#start) 方法时，将 `mode` 参数设置为 `mix`，即可启用合流模式。

根据录制内容的不同，录制生成的文件如下表所示：

| 录制内容       | 参数设置                           | 录制生成文件                                                 |
| :------------- | :--------------------------------- | :----------------------------------------------------------- |
| 仅录制音频     | `streamTypes 设为 0`               | 生成一个 M3U8 文件和多个 TS 文件，TS 文件内仅存储该频道的音频数据。 |
| 仅录制视频     | `streamTypes 设为 1`               | 生成一个 M3U8 文件和多个 TS 文件，TS 文件内仅存储该频道的视频数据。 |
| 同时录制音视频 | `（默认设置）streamTypes 设为 ``2` | 生成一个 M3U8 文件和多个 TS 文件，TS 文件内存储该频道的音视频数据。 |

录制文件的命名规则如下：

- M3U8 文件的文件名：<`sid>_<cname>.m3u8`
- TS 文件的文件名：<`sid>_<cname>_<utc>.ts`

上述文件名中各字段含义如下：

- `<sid>` ：录制 ID
- `<cname>：`频道名
- <utc>：该切片文件开始录制时的 UTC 时间，时区为 UTC+0，由年、月、日、小时、分钟、秒和毫秒组成。例如 20190611073246073 表示该切片文件的开始时间为 UTC 2019 年 6 月 11 日 7 点 32 分 46 秒 73 毫秒。

## start 请求示例

- 在合流模式下进行录制的请求 URL 为：`https://api.agora.io/v1/apps/<yourappid>/cloud_recording/resourceid/<resourceid>/mode/mix/start`
- `Content-type` 为 `application/json;charset=utf-8`
- `Authorization` 为 Basic authorization，生成方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。
- 请求包体内容：

```
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
                "backgroundColor": "#FF0000",
            "subscribeVideoUids": ["123","456"], 
            "subscribeAudioUids": ["123","456"],
            "subscribeUidGroup": 0
           }
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

## 开发注意事项

如果录制内容选择**仅录制视频**或**同时录制音视频**，但是 Web 端用户没有发送视频，也会生成视频录制文件，录制黑屏。

## 相关文档

- [单流录制](https://confluence.agoralab.co/pages/viewpage.action?pageId=647374137)
- [时间戳同步](https://confluence.agoralab.co/pages/viewpage.action?pageId=647374929)