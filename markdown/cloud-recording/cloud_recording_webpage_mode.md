---
title: 页面录制
platform: RESTful
updatedAt: 2021-03-05 08:21:13
---

本文介绍使用云端录制 RESTful API 进行页面录制的重点步骤。建议你同时参考[云端录制 RESTful API 快速开始](https://docs.agora.io/cn/cloud-recording/cloud_recording_rest)了解云端录制的基础流程。

页面录制为收费功能，会按照最终生成的录制文件时长收费。根据所生成录制文件的分辨率，区分 HD（1280 × 720 及以下）、HDP（1280 × 720 以上, 1920 × 1080 及以下）两个档级，不同档级对应不同单价。详情可咨询 [sales@agora.io](mailto:sales@agora.io)。

该功能目前处于公测期。公测期间，你可以免费使用。

<div class="alert info">如果被录制的 Web 页面中集成了 Agora SDK，该部分用量会产生计费</div>

## 功能描述

云端录制共支持三种录制模式：

- 单流录制
- 合流录制
- 页面录制

页面录制模式下，录制服务将指定 URL 的页面内容和音频混合录制为一个音视频文件，如下图：

![](https://web-cdn.agora.io/docs-files/1604990307461)

你可以使用页面录制还原在线课堂、视频会议等场景的完整体验。举例来说，当一个 Web 应用集成了 Agora SDK 以及第三方白板 SDK，页面录制可以录制页面内的全部元素，而不仅限于音视频流。

![](https://web-cdn.agora.io/docs-files/1604990333415)

你可以通过定义页面中的内容，以特定的视角进行录制。例如，如果你想以教师视角录制一个在线课堂，你可以定义某个页面包含教师端的所有操作，并录制该页面。

## 前提条件

页面录制需满足以下前提条件：

- 你需要提供一个能通过 URL 访问的 Web 应用，作为待录制的内容源。（其他主播和观众可以使用该 Web 应用，也可以使用其他平台的应用。）
- 你的 Web 应用需要兼容 Chrome 浏览器。
- 由于云端录制仅录制浏览器窗口可见部分，该 Web 页面需要全部可见，即无需滚动条。
- 如需还原主播端看到的全部内容，你需要将主播端的操作同步到应用中。

## 实现方法

### 获取 resource ID

在开始录制前，必须调用 [`acquire`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#acquire) 方法请求一个用于云端录制的 resource ID。你需要将 `scene` 参数设置为 `1`，即分配页面录制资源。

#### 请求示例

- 请求 URL：

```
https://api.agora.io/v1/apps/<yourappid>/cloud_recording/acquire
```

- `Content-type` 为 `application/json;charset=utf-8`
- `Authorization` 为 Basic authorization，生成方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。
- 请求包体内容：

```
{
   "cname": "httpClient463224",
    "uid": "527841",
    "clientRequest":{
      "resourceExpiredHour": 24,
      "scene": 1
   }
}
```

### 开始录制

在调用 [`start`](https://docs.agora.io/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#start)方法时，将 `mode` 参数设置为 `web`，启用[页面录制模式](https://docs.agora.io/cn/Agora%20Platform/webpage_recording)。该模式下，你还需要通过 `extensionServiceConfig` 设置页面录制的详细信息，以及通过 `storageConfig` 设置第三方云存储的信息。

<div class="alert note">录制模式的设置必须在开始录制的时候完成，不支持在录制开始后切换模式。</div>

页面录制支持的 `clientRequest` 参数包括：

| 参数                     | 配置内容     | 是否选填 |
| :----------------------- | :----------- | :------- |
| `recordingFileConfig`    | 录制文件     | 选填     |
| `storageConfig`          | 第三方云存储 | 必填     |
| `extensionServiceConfig` | 页面录制     | 必填     |

请求示例

- 请求 URL：

```
https://api.agora.io/v1/apps/<yourappid>/cloud_recording/resourceid/<resourceid>/mode/web/start
```

- `Content-type` 为 `application/json;charset=utf-8`
- `Authorization` 为 Basic authorization，生成方法请参考 [RESTful API 认证](https://docs.agora.io/cn/faq/restful_authentication)。

请求包体内容：

```
{
  "cname":"httpClient463224",
    "uid":"527841",
    "clientRequest":{
        "token": "<token if any>",
        "extensionServiceConfig": {
             "errorHandlePolicy": "error_abort",
             "extensionServices":[{
                  "serviceName":"web_recorder_service",
                  "errorHandlePolicy": "error_abort",
                  "serviceParam": {
                      "url": "https://xxxxx",
                      "audioProfile":0,
                      "videoWidth":1280,
                      "videoHeight":720,
                      "maxRecordingHour":72
                 }
             }]
       },
        "recordingFileConfig":{
            "avFileType":[
                "hls",
                "mp4"
           ]
       },
        "storageConfig":{
            "vendor":2,
            "region":3,
            "bucket":"xxxxx",
            "accessKey":"xxxxx",
            "secretKey":"xxxxx",
            "fileNamePrefix":[
                "directory1",
                "directory2"
           ]
       }
   }
}
```

## 录制生成文件

录制后共生成一个 M3U8 文件和多个 TS 文件。根据 `avFileType` 参数的设置，还有可能生成一个或多个 MP4 文件。录制文件的命名规则详见[管理录制文件](https://docs.agora.io/cn/cloud-recording/cloud_recording_manage_files)。

## 开发注意事项

### 针对 Web 应用的限制

- 待录制页面中不得包含超过 1280 x 720 分辨率的视频源。
- 待录制页面不得使用 WebGL 功能。
- 待录制页面的下行带宽不得超过 10 Mbps，上行带宽不得超过 2 Mbps。
- 请尽量避免你的 Web 应用占用过多的 CPU 内存和带宽，且该 Web 应用的使用目的应合法合规。
- 页面录制支持 video 元素启用了 autoplay 属性后在无用户交互状态下自动播放。但如果待录制页面中的 video 元素未启用 autoplay 属性，其内容将不会自动播放，这将会导致页面录制无法录制到该视频。
- 主页面加载失败的情况下，页面录制会报错并退出。如果你需要在某个子 iframe 加载失败时也停止录制，需要自行实现该逻辑。 例如，你可以在子 iframe 加载失败后调用 Windows.close 方法。调用该方法后，页面录制会自动停止并退出。

### RESTful API 请求

- 从发起请求到开始页面录制，有 5s 左右的延时。建议提前发起录制请求，以保证录制内容完整。
- 页面录制不支持 `update` 和 `updateLayout` 方法。
- 如果你在 `start` 方法中填入的 URL 无法正常打开，录制服务会在 `start` 成功后自动退出。你可以参考<a name="确认录制服务已成功启动"></a>[云端录制集成最佳实践](https://docs.agora.io/cn/cloud-recording/integration_best_practices?platform=RESTful#a-namestart_successa确认录制服务已成功启动)，使用退避策略多次调用 `query`，来确认录制服务正常启动。

### 其他

- 进行页面录制时，录制服务相当于一个使用 Web 应用的客户端，因此：
  - 如你在 `start` 方法中填入的 URL 会自动触发客户端发布音视频流，录制服务器所启动的浏览器引擎也会成为一个发流端，因此你的应用中可能会出现一个无视频内容的用户画面。
  - 如你的 Web 应用包含用户列表，建议你在用户列表中隐藏该客户端，避免终端用户产生疑惑。
