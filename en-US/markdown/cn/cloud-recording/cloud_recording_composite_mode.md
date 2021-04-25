本文介绍使用云端录制 RESTful API 进行合流录制的重点步骤。 建议你同时参考[云端录制 RESTful API 快速开始](https://docs.agora.io/cn/cloud-recording/cloud_recording_rest)了解云端录制的基础流程。

## 功能描述

云端录制共支持三种录制模式：

- 单流录制
- 合流录制
- 页面录制

合流录制模式下，频道内所有或指定 UID 的音视频混合录制为一个音视频文件。

举例来说，当频道中有两个用户，且同时录制音视频时，合流录制生成的文件如下图所示：

![img](/Users/cy/Downloads/未命名表单.svg)

录制后共生成一个 M3U8 文件和多个 TS 文件。 如你在调用 `start` 方法时将 `avFileType` 设置为 `["hls","mp4"]`，则还会生成 MP4 文件，包含所有用户的音视频数据。

## 实现方法

### 获取 resource ID

在开始录制前，必须调用 [`acquire`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#acquire) 方法请求一个用于云端录制的 resource ID。

#### 请求示例

- Request URL:
```
Endpoint: /v1/apps/\<appid\>/cloud_recording/acquire
```

- `Content-type` is `application/json;charset=utf-8.`
- `Authorization` is the basic authentication, see[ RESTful API authentication for details](https://docs.agora.io/cn/faq/restful_authentication).
- The request body:

```
{
    "cname": "httpClient463224",
    uid: "",
    "clientRequest":{
      "resourceExpiredHour": 24,
      "scene": 0
   }
}
```

### 开始录制

在调用 [`start`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#start) 方法时，你需要将 `mode` 参数设置为 mix，开启[合流录制模式](https://docs.agora.io/cn/Agora%20Platform/composite_recording_mode)。 该模式下，你还需要通过 `recordingConfig` 设置合流录制的详细信息，以及通过 `storageConfig` 设置第三方云存储的信息。

<div class="alert note">录制模式的设置必须在开始录制的时候完成，不支持在录制开始后切换模式。</div>

合流录制支持的 `clientRequest` 参数包括：

| Parameter | 配置内容 | 是否选填 |
| :-------------------- | :------------------------------- | :--------------------------- |
| `token` | 动态密钥 | 如频道使用了 token，则为必填 |
| `recordingConfig` | 媒体流订阅、转码、输出音视频属性 | 必填 |
| `recordingFileConfig` | 录制文件 | 选填 |
| `storageConfig` | 第三方云存储 | 必填 |

#### 请求示例

- Request URL:

```
https://api.agora.io/v1/apps/<yourappid>/cloud_recording/resourceid/<resourceid>/mode/mix/start
```

- `Content-type` is `application/json;charset=utf-8.`
- `Authorization` is the basic authentication, see[ RESTful API authentication for details](https://docs.agora.io/cn/faq/restful_authentication).
- The request body:

```json
{
    uid: "",
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

## <a name="generated_files"></a>录制生成文件

根据录制内容的不同，录制生成的文件如下表所示：

| 录制内容 | 参数设置 | 录制生成文件 |
| :------------- | :--------------------------------- | :----------------------------------------------------------- |
| 仅录制音频 | `streamTypes` 设为 `0` | 生成一个 M3U8 文件和多个 TS 文件，TS 文件内仅存储该频道的音频数据。 如果将 `avFileType` 设置为 `["hls","mp4"]`，则还会生成一个或多个 MP4 文件，包含所有用户的音频数据。 |
| 仅录制视频 | `streamTypes` 设为 `1` | 生成一个 M3U8 文件和多个 TS 文件，TS 文件内仅存储该频道的视频数据。 如果将 `avFileType` 设置为 `["hls","mp4"]`，则还会生成一个或多个 MP4 文件，包含所有用户的视频数据。 |
| 同时录制音视频 | （默认设置）`streamTypes` 设为 `2` | 生成一个 M3U8 文件和多个 TS 文件，TS 文件内存储该频道的音视频数据。 如果将 `avFileType` 设置为 `["hls","mp4"]`，则还会生成一个或多个 MP4 文件，包含所有用户的音视频数据。 |

录制文件的命名规则详见[管理录制文件](https://docs.agora.io/cn/cloud-recording/cloud_recording_manage_files)。

<a name="Considerations"></a>

## Considerations

A Web client and a Native client have different display strategies when they stop publishing streams or leave the channel. See the table below for details.

| <span style="white-space:nowrap;">发流端类型&emsp;&emsp;&emsp;&emsp;</span> | <span style="white-space:nowrap;">停止发流 3.5 秒内&emsp;&emsp;</span> | <span style="white-space:nowrap;">停止发流 3.5 秒后&emsp;&emsp;&emsp;&emsp;</span> | <span style="white-space:nowrap;">退出频道&emsp;&emsp;&emsp;&emsp;</span> |
| :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- |
| Native client | Displays the last frame. | Displays the background color or background image of the canvas or the user region. See [Set Video Layout for details.](./cloud_recording_layout?platform=RESTful#background) | Displays the background color or background image of the canvas. |
| Web client | For the Web SDK 3.x and earlier, if the user unpublishes the local video stream (`unpublish`), the user region displays the background color of the canvas; if the user disables the video track (`muteVideo`), the user region becomes black. Web SDK 4.x 及以后，显示最后一帧。 | Displays the background color or background image of the canvas or the user region. See [Set Video Layout for details.](./cloud_recording_layout?platform=RESTful#background) | Displays the background color or background image of the canvas. |


