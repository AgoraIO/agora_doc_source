## 简介

Agora 云端录制，可为 Agora 实时音视频提供录制服务。同 Agora 本地服务端录制相比，Agora 云端录制无需部署 Linux 服务器，减轻了研发和运维的压力，更轻量便捷。点击[云端录制产品概述](./product_cloud_recording)了解关键特性。

### 兼容性

Agora 云端录制与以下 Agora SDK 兼容:

<style>
table th:first-of-type {
width: 150px;
}
</style>
| SDK              | 描述                                                         |
| :--------------- | :----------------------------------------------------------- |
| Agora Native SDK | 云端录制与全平台 Agora Native SDK 1.7.0 或更高版本兼容，如果频道内有任何人使用了 1.6 版本的 Agora Native SDK， 则整个频道无法录制。 |
| Agora Web SDK    | 云端录制与 Agora Web SDK 1.12.0 或更高版本兼容。             |

## 2021.04.30

该版本于 2021 年 4 月 30 日发布。

**新增特性**

#### 合流录制支持输出 MP4 格式

为了满足用户多样化需求，合流录制模式新增支持输出 MP4 格式的录制文件。在调用 `start` 方法时，将 `avFileType` 参数设置为 `["hls","mp4"]`，即可在录制过程中实时获得 MP4 文件。

#### **AES-GCM 加密模式**

在安全要求高的场景中，为保证数据的保密性、完整性和真实性，提高数据加密的计算效率，该版本在 `decryptionMode` 参数中新增以下加密模式：

- 128 位 AES 加密，GCM 模式。
- 256 位 AES 加密，GCM 模式。

开启加密功能后，同一频道内的所有用户都必须使用相同的加密模式和密钥。

**改进**

页面录制过程中，录制服务将自动检测并修复偶现的录制文件无声问题。修复后，待录制页面会刷新；如有必要，你的 Web 应用需要保证刷新前后的状态一致。

**API 变更**

- [`start`](./cloud_recording_api_rest?platform=RESTful#start) 方法中的 `decryptionMode` 参数新增枚举值 `5` 和 `6`。
- [`uploaded`](./cloud_recording_callback_rest?platform=RESTful#31) 和 [`backuped`](./cloud_recording_callback_rest?platform=RESTful#32) 回调中新增 `fileList` 字段。

## 2021.03.31

该版本于 2021 年 3 月 31 日发布。

**新增特性**

#### 设置背景图

在合流录制模式下，你可以为视频画布以及单个用户画面设置背景图，并在录制过程中更新背景图。详见[设置背景色或背景图](./cloud_recording_layout?platform=RESTful#background)。

**改进**

添加了金山云存储的异常重试逻辑，在上传录制文件失败时，录制服务会进行重试。

**修复问题**

- 上传切片文件至腾讯云存储 COS 偶现文件丢失。
- 页面录制无法正常渲染 emoji 表情符号。
- 在录制静态页面时，`videoFps` 设置过高的情况下偶现录制失败。

**API 变更**

- [`start`](./cloud_recording_api_rest?platform=RESTful#start) 方法中的 `transcodingConfig` 参数新增 `backgroundImage`、`defaultUserBackgroundImage` 以及 `backgroundConfig` 字段。
- [`updateLayout`](./cloud_recording_api_rest?platform=RESTful#update) 方法中的 `clientRequest` 参数新增 `backgroundImage`、`defaultUserBackgroundImage` 以及 `backgroundConfig` 字段。
- [`web_recorder_stopped`](./cloud_recording_callback_rest?platform=RESTful#71) 回调中新增 `fileList` 字段。

## 2021.02.05
本次发版提高了[页面录制](/cn/cloud-recording/cloud_recording_webpage_mode?platform=RESTful)中针对视频源分辨率的限制，将待录制页面中任一视频源的分辨率上限从 1280 x 720 提高至 1920 × 1080。

## 2021.01.29

本次发布的新增特性和 API 变更如下：

**新增特性**

#### 延时转码

在单流录制模式下，你可以开启延时转码。开启后，录制服务会在录制结束后 24 小时内将录制文件转码生成 MP4 文件，并将 MP4 文件上传至你指定的第三方云存储。

**API 变更**

- [`acquire`](/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#acquire) 方法的 `scene` 参数新增枚举值 `2`，用于设置延时转码场景。
- [`start`](/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#start) 方法中的 `clientRequest` 新增 `appsCollection` 参数。
- 新增以下回调，用于报告转码的状态：
  - [`transcoder_started`](/cn/cloud-recording/cloud_recording_callback_rest?platform=RESTful#80)
  - [`transcoder_completed`](/cn/cloud-recording/cloud_recording_callback_rest?platform=RESTful#81)
  - [`download_failed`](/cn/cloud-recording/cloud_recording_callback_rest?platform=RESTful#90)
  - [`postpone_transcode_final_result`](/cn/cloud-recording/cloud_recording_callback_rest?platform=RESTful#1001)
- 所有云端录制回调新增 `serviceScene` 字段，表示当前运行的录制场景或录制阶段。

## 2020.12.10

本次发布的新增特性和 API 变更如下：

**新增特性**

#### 页面录制

新增[页面录制](https://docs.agora.io/cn/cloud-recording/cloud_recording_webpage_mode)模式。在该模式下，录制服务会将指定网页的页面内容和音频混合录制为一个音视频文件。

**API 变更**

- 请求 URL 中的 `mode` 参数新增支持 `web`（页面录制模式）。
- [`acquire`](/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#acquire) 方法新增 `scene` 参数，用于设置云端录制资源使用场景。
- [`start`](/cn/cloud-recording/cloud_recording_api_rest?platform=RESTful#start) 方法中的 `extensionServiceConfig` 新增 `"web_recorder_service"` 服务。
- 新增以下回调，用于报告页面录制状态：
  - [`web_recorder_started`](/cn/cloud-recording/cloud_recording_callback_rest?platform=RESTful#70)
  - [`web_recorder_stopped`](/cn/cloud-recording/cloud_recording_callback_rest?platform=RESTful#71)
  - [`web_recorder_capability_limit`](/cn/cloud-recording/cloud_recording_callback_rest?platform=RESTful#72)
  
## 2020.09.16

该版本进行了性能优化及服务稳定性优化，并修复了如下问题：

- 订阅小流不生效。
- 偶现的部分内容未被录制的问题。

## 2020.07.21

本次发布的新增特性和 API 变更如下：

**新增特性**

#### 阿里视频点播服务

在合流模式下，支持将录制文件上传至阿里视频点播服务（VoD）。

**API 变更**

- [`start`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/云端录制/start) 方法中新增了 `extensionServiceConfig` 参数，用于指定阿里视频点播服务的配置。
- 新增 [`vod_started`](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest?platform=All%20Platforms#60) 回调和 [`vod_triggered`](https://docs.agora.io/cn/cloud-recording/cloud_recording_callback_rest?platform=All%20Platforms#61) 回调，提供阿里视频点播服务上传模块的状态。

## 2020.06.12
本次发布的新增特性和 API 变更如下：

**新增特性**

#### 灵活的 UID 订阅

提供更为灵活的 UID 订阅，支持设置音频和视频的订阅白名单或黑名单，以及在录制过程中更新订阅名单。详见[设置订阅名单](https://docs.agora.io/cn/cloud-recording/cloud_recording_subscription)。

#### 高可用的回调

该版本增加了 [`session_failover`](/cn/cloud-recording/cloud_recording_callback_rest#12) 回调，在启用高可用机制后触发，返回启用高可用机制后的新录制 UID。

**API 变更**

- [`start`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6/start) 方法中新增了 `unSubscribeVideoUids` 和 `unSubscribeAudioUids` 参数，用于指定订阅黑名单。
- 新增 [`update` ](https://docs.agora.io/cn/cloud-recording/restfulapi/#/%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6/update)方法，用于在录制过程中更新订阅名单。
- 新增 `session_failover` 回调。

## 2020.05.09

本次发布新增了对金山云存储的支持。

## 2020.04.17

本次发布新增了截图功能，详见[视频截图](/cn/cloud-recording/cloud_recording_screen_capture)。

## 2019.12.16
本次发布提高了云端录制服务的可用性。当出现服务器断网、进程被杀时，云端录制会自动切换到新的服务器，在短时间内恢复录制服务。详情见[云端录制服务器断网、进程被杀的处理](/cn/faq/high-availability)。

**API 变更**

[`acquire`](https://docs.agora.io/cn/cloud-recording/restfulapi/#/%E4%BA%91%E7%AB%AF%E5%BD%95%E5%88%B6/acquire) 方法中新增了 `resourceExpiredHour` 参数，用于设置云端录制 RESTful API 的调用时效。

RESTful API 回调通知中新增事件 [`session_exit`](/cn/cloud-recording/cloud_recording_callback_rest?platform=All%20Platforms#a-name11a11-session_exit)，提供云端录制服务的退出状态。


## 2019.11.15

调用 `start` 方法后，你可以通过 `query` 请求立刻获得录制文件名，而不再需要等待 15 秒。

##  2019.10.24

本次发布新增了对腾讯云存储的支持。


##  2019.10.08

本次发布的新增特性、改进及修复问题如下：

**新增特性**

#### 1. 单流录制

RESTful API 新增单流录制模式，支持分开录制每个 UID 的音频流和视频流。使用方法详见[单流录制](/cn/cloud-recording/cloud_recording_individual_mode)。同时，Agora 提供了音视频合并脚本，用于合并单流录制模式下生成的音频和视频文件。使用方法详见[音视频文件合并](/cn/cloud-recording/cloud_recording_merge_files)。

#### 2. 录制指定 UID 的音视频流

RESTful API 新增 `subscribeAudioUids` 和 `subscribeVideoUids` 参数，支持录制指定 UID 的音视频流。

#### 3. 自定义录制文件存储路径

RESTful API 新增 `fileNamePrefix` 参数，支持指定录制文件在第三方云存储的存储位置。

#### 4. 频道状态变化的时间戳

RESTful API 回调通知中新增事件 `recorder_audio_stream_state_changed` 和 `recorder_video_stream_state_changed`，提供音频流和视频流状态变化的时间，和该路流对应的 UID。

#### 5. 音视频格式转换脚本

Agora 提供了音视频格式转换脚本，用于 TS、MP3、MP4 等文件格式之间的转换。使用方法详见[音视频格式转换](/cn/cloud-recording/cloud_recording_convert_format)。

#### 6. 同步回放

通过 RESTful API 回调或解析 M3U8 文件，你可以获取录制开始时的时间戳，从而将录制的音视频和其他数据流文件（白板、课件、课堂聊天记录等）同步回放。详情见[同步回放](/cn/cloud-recording/cloud_recording_playback)。

**改进**

在出现错误时，你会在 HTTP 响应包体内收到相应的错误信息，而不只是错误码。错误码详情见[云端录制 RESTful API](/cn/cloud-recording/cloud_recording_api_rest#常见错误)。

**问题修复**

如果因为第三方云存储的 `bucket` 及 `key` 参数值错误导致上传失败，云端录制服务将会直接报错，而不再将切片文件上传至 Agora 云备份。

##  2019.07.19

本次发布的新增特性、改进及修复问题如下：

**新增特性**

#### 自定义合流布局

RESTful API 新增自定义的合流布局。使用方法详见[自定义合流布局](./cloud_recording_layout#custom)。

你可以在开始录制时将 `mixedVideoLayout` 设为 3，并在 `layoutConfig` 中设置每个用户的画面大小和位置。你也可以在录制过程中调用 `updateLayout` 方法随时更新合流布局。

#### 自定义背景色

RESTful API 新增 `backgroundColor` 参数，支持自定义合流的画布背景色。无论使用何种合流布局，都可以通过该参数设置画布的背景色。

#### 录制的时间戳

为方便开发者获得精准的录制开始时间，RESTful API 提供录制开始第一片切片的 Unix 时间戳 `sliceStartTime`，可以通过 `query` 方法查询获得。同时在 RESTful API 的回调通知中新增事件 `recorder_slice_start`，提供第一片录制切片开始的时间和上一次录制失败的时间。

**改进**

RESTful API 优化了对 `resourceId` 和 `cname` 以及 `uid` 是否对应的检查。

**修复问题**

修复了默认的合流布局中存在的一些小问题。

##  2019.07.02

- 将合流布局默认背景色修改为黑色。
- 改善了在弱网环境下录制的视频卡顿问题。

##  2019.06.13

本次发布主要新增了对 RESTful API 的支持，无需集成 SDK，直接通过网络请求来控制云端录制。

你可以参考下面的文档使用 RESTful API：

- [RESTful API 录制](./cloud_recording_rest?platform=All%20Platforms)：使用 RESTful API 进行录制
- [云端录制 RESTful API](./cloud_recording_api_rest?platform=All%20Platforms)：RESTful API 参考
- [云端录制 RESTful API 回调服务](./cloud_recording_callback_rest?platform=All%20Platforms)：开通回调服务接收云端录制事件通知

##  2019.04.29

本次发布主要包括以下功能:

- Agora Native SDK 和 Agora Web SDK 的高清音视频通话的录制
- 频道内所有用户的音视频合流录制
- 支持 3 种合流布局样式：Float（默认布局）、BestFit（自适应布局）、Vertical（垂直布局）。
- 第三方云存储，目前支持七牛云、阿里云和 Amazon S3
- 提供 C++ 和 Java SDK 包