---
title: 单流录制
platform: All Platforms
updatedAt: 2021-02-26 08:02:27
---

本文介绍使用云端录制 RESTful API 进行单流录制的重点步骤。建议你同时参考[云端录制 RESTful API 快速开始](https://docs.agora.io/cn/cloud-recording/cloud_recording_rest)了解云端录制的基础流程。

## 功能描述

云端录制共支持三种录制模式：

- 单流录制
- 合流录制
- 页面录制

单流录制模式下，分别录制频道中每个 UID 的音频流和视频流，每个 UID 均有其对应的音频文件和视频文件。

举例来说，当频道中有两个用户，且同时录制音视频时，单流录制生成的文件如下图所示：

![](https://web-cdn.agora.io/docs-files/1576157340343)

录制后共生成四个 M3U8 文件（每个 UID 对应两个 M3U8 文件）和多个 TS/WebM 文件，分开存储音视频数据。通过[音视频合并转码脚本](https://docs.agora.io/cn/cloud-recording/cloud_recording_merge_files?platform=RESTful)完成文件合并后，你会得到两个 MP4 文件。

<div class="alert note">如果你想直接获得 MP4 文件，可以使用延时转码。开启后，录制服务会在录制结束后 24 小时内将录制文件转码生成 MP4 文件，并将 MP4 文件上传至你指定的第三方云存储（不支持七牛云）。该场景仅适用于单流录制模式。</div>

## <a name="test"></a>testheader

[testtext](https://docs.agora.io/cn/cloud-recording/cloud_recording_individual_mode?platform=RESTful#test)

## 实现方法

### 获取 resource ID

在开始录制前，必须调用 [`acquire`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#acquire) 方法请求一个用于云端录制的 resource ID。如果要使用延时转码，需要将 `scene` 设置为 `2`。

#### 请求示例

- 请求 URL：`https://api.agora.io/v1/apps/<yourappid>/cloud_recording/acquire`

- `Content-type` 为 `application/json;charset=utf-8`
- `Authorization` 为 Basic authorization，生成方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。
- 请求包体内容：

```
{
    "cname": "httpClient463224",
    "uid": "527841",
    "clientRequest":{
      "resourceExpiredHour": 24,
      "scene": 0
   }
}
```

### 开始录制

在调用 [`start`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#start) 方法时，你需要将 `mode` 参数设置为 `individual`，开启[单流录制模式](https://docs.agora.io/cn/Agora%20Platform/individual_recording_mode)。该模式下，你还需要通过 `recordingConfig` 设置单流录制的详细信息，以及通过 `storageConfig` 设置第三方云存储的信息。

<div class="alert note">录制模式的设置必须在开始录制的时候完成，不支持在录制开始后切换模式。</div>

单流录制支持的 `clientRequest` 参数包括：

| 参数                  | 配置内容                         | 是否选填                     |
| :-------------------- | :------------------------------- | :--------------------------- |
| `token`               | 动态密钥                         | 如频道使用了 token，则为必填 |
| `appsCollection`      | 应用组合                         | 如需使用延时转码，则为必填   |
| `recordingConfig`     | 媒体流订阅、转码、输出音视频属性 | 必填                         |
| `recordingFileConfig` | 录制文件                         | 选填                         |
| `storageConfig`       | 第三方云存储                     | 必填                         |

#### 请求示例

- 请求 URL：

```
https://api.agora.io/v1/apps/<yourappid>/cloud_recording/resourceid/<resourceid>/mode/individual/start
```

- `Content-type` 为 `application/json;charset=utf-8`
- `Authorization` 为 Basic authorization，生成方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。
- 请求包体内容：

**实时录制**

```json
{
  "uid": "527841",
  "cname": "httpClient463224",
  "clientRequest": {
    "token": "<token if any>",
    "recordingConfig": {
      "maxIdleTime": 30,
      "streamTypes": 2,
      "channelType": 0,
      "videoStreamType": 1,
      "subscribeVideoUids": ["123", "456"],
      "subscribeAudioUids": ["123", "456"],
      "subscribeUidGroup": 0
    },
    "storageConfig": {
      "accessKey": "xxxxxxf",
      "region": 3,
      "bucket": "xxxxx",
      "secretKey": "xxxxx",
      "vendor": 2,
      "fileNamePrefix": ["directory1", "directory2"]
    }
  }
}
```

**延时转码**

```json
{
  "uid": "527841",
  "cname": "httpClient463224",
  "clientRequest": {
    "token": "<token if any>",
    "appsCollection": {
      "combinationPolicy": "postpone_transcoding"
    },
    "recordingConfig": {
      "maxIdleTime": 30,
      "streamTypes": 2,
      "channelType": 0,
      "videoStreamType": 1,
      "subscribeVideoUids": ["123", "456"],
      "subscribeAudioUids": ["123", "456"],
      "subscribeUidGroup": 0
    },
    "storageConfig": {
      "accessKey": "xxxxxxf",
      "region": 3,
      "bucket": "xxxxx",
      "secretKey": "xxxxx",
      "vendor": 2,
      "fileNamePrefix": ["directory1", "directory2"]
    }
  }
}
```

## 录制生成文件

该模式下录制文件的音视频编码配置如下：

- 音频编码配置：采样率固定为 48 kHz，声道数和码率与原始音频流一致。
- 视频编码配置：与原始视频流一致。

根据录制内容的不同，录制生成的文件如下表所示：

| 录制内容       | 参数设置                            | 录制生成文件                                                                                    |
| :------------- | :---------------------------------- | :---------------------------------------------------------------------------------------------- |
| 仅录制音频     | `streamTypes` 设为 `0`              | 每个 UID 生成一个 M3U8 文件和多个 TS/WebM 文件，TS/WebM 文件内仅存储该 UID 的音频数据。         |
| 仅录制视频     | `streamTypes` 设为 `1`              | 每个 UID 生成一个 M3U8 文件和多个 TS/WebM 文件，TS/WebM 文件内仅存储该 UID 的视频数据。         |
| 同时录制音视频 | （默认设置） `streamTypes` 设为 `2` | 每个 UID 生成两个 M3U8 文件和多个 TS/WebM 文件，TS/WebM 文件分开存储 UID 的音频数据及视频数据。 |

> 单流模式下，Web 端选择 VP8 编码时，云端录制生成的切片文件为 WebM 文件。其他情况下生成的切片文件均为 TS 文件。

录制文件的命名规则详见[管理录制文件](https://docs.agora.io/cn/cloud-recording/cloud_recording_manage_files)。

## 开发注意事项

如果录制内容选择仅录制视频或同时录制音视频，但是 Web 端用户没有发送视频，也会生成视频录制文件，录制黑屏。
