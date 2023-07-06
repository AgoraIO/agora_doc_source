你可以通过你的业务服务器向声网服务器发送 HTTP 请求，在服务端进行云端录制。本文提供云端录制 RESTful API 的概览信息。

## 概述

在阅读本文前，你可以参考以下文档，了解云端录制支持的几大功能，以及各功能涉及的重点步骤。

- [单流录制](https://docs.agora.io/cn/cloud-recording/cloud_recording_individual_mode?platform=RESTful)：分开录制每个 UID 的音频和视频。录制服务会实时将 M3U8 和 TS/WebM 文件上传至第三方云存储。如果开启延时转码，录制服务会在录制结束后 24 小时内对录制文件进行转码生成 MP4 文件，并将 MP4 文件上传至你指定的第三方云存储，频道内每个 UID 均会生成一个 MP4 文件。
- [合流录制](https://docs.agora.io/cn/cloud-recording/cloud_recording_composite_mode?platform=RESTful)：将频道内所有 UID 的音视频混合录制为一个音视频文件，并将录制文件上传至第三方云存储。
- [视频截图](https://docs.agora.io/cn/cloud-recording/cloud_recording_screen_capture?platform=RESTful)：单流录制模式下，对频道内的视频流进行截图，并将图片文件上传至第三方云存储。
- [页面录制](https://docs.agora.io/cn/cloud-recording/cloud_recording_webpage_mode?platform=RESTful)：将指定网页的页面内容和音频混合录制为一个音视频文件，并将录制文件上传至第三方云存储。

<div class="alert note">云端录制不支持在一路录制中完成多个任务。例如，如果你需要同时录制频道内的音视频和进行页面录制，需要起两路录制，即使用两个不同的 <code>uid</code> 调用 <code>acquire</code>，获取两个 <code>resourceId</code>。两路录制均会产生费用。</div>

## 前提条件

请确保已[开通云端录制服务](https://docs.agora.io/cn/cloud-recording/cloud_recording_rest?platform=All%20Platforms#%E5%BC%80%E9%80%9A%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6%E6%9C%8D%E5%8A%A1)。

## 实现流程

一般进行云端录制的步骤如下：

1. 通过 [`acquire`](./cloud_recording_api_acquire?platform=RESTful) 请求获取一个 resource ID 用于开启云端录制。
2. 获取 resource ID 后在 5 分钟内调用 [`start`](./cloud_recording_api_start?platform=RESTful) 开始云端录制。
3. 录制完成后调用 [`stop`](./cloud_recording_api_stop?platform=RESTful) 停止录制。

开始录制后，你可以调用 [`query`](./cloud_recording_api_query?platform=RESTful) 请求查询云端录制的状态。


## 请求结构

### 认证方式

云端录制 RESTful API 仅支持 HTTPS 协议。发送请求时，你需要通过 Basic HTTP 认证，并将生成的凭证填入 HTTP 请求头部的 `Authorization` 字段。具体生成 `Authorization` 字段的方法请参考 [HTTP 基本认证](https://docs.agora.io/cn/faq/restful_authentication)。


### 数据格式

~601fe7e0-3aa5-11ea-98ea-dff00f97811c~



## 已知限制
云端录制服务的最大并发频道数为 100。如需提高上限，请联系[声网商务](mailto:sales@agora.io)。


