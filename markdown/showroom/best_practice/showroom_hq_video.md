在秀场直播中，观众希望观看高清的直播视频。实现高清视频需要考虑用户设备和网络环境等因素。本文介绍声网自适应高清策略在秀场直播解决方案中的最佳实践。


## 单人直播场景

单人直播场景下，你需要为主播和观众进行设置，以获得高清视频体验。

### 主播设置

- 调用 `queryDeviceScore` 查询主播的用户设备等级：高端、中端、低端。在后续步骤中，你需要为不同等级的设备进行不同的视频配置。

- 调用 [`setCameraAutoFocusFaceModeEnabled`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_video_device_management.html#api_irtcengine_setcameraautofocusfacemodeenabled) 开启摄像头自动对焦人脸的功能。

- 调用 [`setCameraCapturerConfiguration`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_video_device_management.html#api_irtcengine_setcameracapturerconfiguration) 并将 `config` 参数中的 `followEncodeDimensionRatio` 字段设为 `true`，设置本地采集的视频宽高比跟随编码的视频宽高比。

- 编码视频属性包含编码视频分辨率、视频帧率、码率。你可以通过 [`setVideoEncoderConfiguration`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_video_process.html#api_irtcengine_setvideoencoderconfiguration) 方法中 `config` 参数中的 `dimensions`、`frameRate`、`bitrate` 字段设置主播端的编码视频属性。

    | 设备等级 | 视频分辨率  | 视频帧率 (fps)   | 视频码率  |
    | ---- | ----- | ------ | ------------------- |
    | 高端   | 1080P | 24 | `STANDARD_BITRATE(0)` |
    | 中端   | 720P  | 24 | `STANDARD_BITRATE(0)` |
    | 低端   | 720P  | 15 | `STANDARD_BITRATE(0)` |

- 调用 [`enableDualStreamMode`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_stream_management.html#api_irtcengine_enabledualstreammode3) 在主播端开启双流模式。视频大流更加高清，视频小流更加流畅。你可以在 `streamConfig` 参数中将主播发送的视频小流设置为如下值：

    | 设备等级 | 视频分辨率  | 视频帧率 (fps)   | 视频码率 (Kbps)  |
    | ---- |----- | ------ | -------|
    | 高端  |540P | 15 | 1100 |
    | 中端  |360P  | 15 | 680 |
    | 低端  |360P  | 15 | 680 |


### 观众设置

主播开启双流模式后，观众端可以通过 [`setRemoteVideoStreamType`](https://docportal.shengwang.cn/cn/live-streaming-premium-4.x/API%20Reference/java_ng/API/toc_stream_management.html#api_irtcengine_setremotevideostreamtype) 方法设置接收视频大流或视频小流。视频大流更加高清，视频小流更加流畅，你可以根据观众的设备性能和网络环境进行选择和切换。


## 观众连麦场景

观众与主播连麦的场景下，你需要为主播、上麦观众、普通观众进行设置，以获得高清视频体验。

### 主播设置

主播设置详见[单人直播主播设置](#主播设置)。

### 上麦观众设置

调用 `setVideoEncoderConfiguration` 并通过 `config` 参数中如下字段设置编码视频属性：

- `dimensions`：设置分辨率为 180 x 360。
- `frameRate`：设置帧率为 15 fps。
- `bitrate`：设置码率为 `STANDARD_BITRATE(0)`。


### 普通观众设置

普通观众会接收到主播和上麦观众的视频流。当某个主播（主播或上麦观众）的视频画面在 App 观众端的 UI 界面上占据更大的区域时，可以为这个主播（俗称主屏主播）开启超分功能。详见[注意事项](#注意事项)。

## PK 连麦场景

主播跨房间 PK 连麦的场景下，你需要为多个房间的主播和观众进行设置，以获得高清视频体验。

### 主播设置

- 调用 `queryDeviceScore` 查询主播的用户设备等级：高端、中端、低端。在后续步骤中，你需要为不同等级的设备进行不同的视频配置。

- 编码视频属性包含编码视频分辨率、视频帧率、码率。你可以通过 `setVideoEncoderConfiguration` 方法中 `config` 参数中的 `dimensions`、`frameRate`、`bitrate` 字段设置主播端的编码视频属性。

    | 设备等级 | 视频分辨率  | 视频帧率 (fps)   | 视频码率  |
    | ---- | ----- | ------ | ------------------- |
    | 高端   | 720P | 15 | `STANDARD_BITRATE(0)` |
    | 中端   | 540P  | 15 | `STANDARD_BITRATE(0)` |
    | 低端   | 540P  | 15 | `STANDARD_BITRATE(0)` |

- 调用 `enableDualStreamMode` 在主播端开启双流模式。视频大流更加高清，视频小流更加流畅。你可以在 `streamConfig` 参数中将主播发送的视频小流设置为如下值：

    | 设备等级 | 视频分辨率  | 视频帧率 (fps)   | 视频码率 (Kbps)  |
    | ---- |----- | ------ | -------|
    | 高端  |360P | 15 | 680 |
    | 中端  |360P  | 15 | 680 |
    | 低端  |360P  | 15 | 680 |

### 观众设置

主播开启双流模式后，观众端可以通过 `setRemoteVideoStreamType` 方法设置接收视频大流或视频小流。视频大流更加高清，视频小流更加流畅，你可以根据观众的设备性能和网络环境进行选择和切换。

## 伪直播场景

伪直播场景下，你需要为视频源和观众进行设置，以获得高清视频体验。

//TODO 本期不写

## 注意事项

- 为达到自适应高清效果，除了按照如上步骤设置代码逻辑外，你还需要联系[声网技术支持](https://docs.agora.io/cn/Agora%20Platform/ticket?platform=All%20Platforms)。声网技术支持会根据你的直播场景、用户角色、设备等级、网络带宽情况，为你配置下发开启一系列功能：

    - **PVC**：PVC（Perceptual Video Coding，视频感知编码）是一种在保障同等画质的前提下降低带宽消耗的视频编码方式。
    - **超分**：超分辨率可以提升本地看到远端视频的画面分辨率。
    - **SVC**：SVC（Scalable Video Coding，可伸缩视频编码）技术能够将视频流分为多个不同的层次，每个层次具有不同的编码质量和码率。这些层次可以独立地解码和传输，因而能够根据用户的网络环境和设备性能自适应调节视频流的编码质量，保证所有用户的观看体验。
    - **H.265**：视频流的一种编解码类型。为了达到高清效果，在某些情况下需要使用 H.265 类型。
    - **硬编硬解**：硬件编码和硬件解码。为了达到高清效果，在某些情况下需要使用硬编硬解。

- `queryDeviceScore` 方法仅在部分特殊版 RTC SDK 中提供。请联系声网技术支持获取。