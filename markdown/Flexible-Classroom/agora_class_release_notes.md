## 1.1.5 版

该版本于 2021 年 9 月 13 日发布。

### 升级必看

**集成变更（iOS）**

自 1.1.5 起，灵动课堂拆分为 `AgoraClassroomSDK`、`AgoraEduCore`、`AgoraEduUI`、`AgoraEduContext` 四个库。其中 `AgoraClassroomSDK`、`AgoraEduUI`、`AgoraEduContext` 在 Github 与 CocoaPods 上开源发布；`AgoraEduCore` 闭源，以二进制包在 CocoaPods 上发布。如果你在 1.1.2 或之前版本中修改了课堂 UI，请参考[升级指南]()升级至 1.1.5。

**Edu Context API 变动（iOS）**

自 1.1.5 起，Agora 对 Edu Context API 进行以下改动：

- 所有 handler 接口进行更名，去除名称中的 “Set” 或 “Get”。对于此前的接口，Agora 支持向下兼容，但建议尽快使用最新的接口。
- 废弃了所有 `onShowXXXTips` 方法，并将原文本及显示 toast 的处理移至 AgoraEduUI。

**库闭源（Web/Electron）**

自 1.1.5 起，灵动课堂中的 `agora-edu-core` 和 `agora-rte-sdk` 库闭源。`AgoraEduCore.launch` 实现逻辑移入 `agora-edu-core` 内部，开发者无法再进行改动。`launchOption` 当前支持的字段详见 API 文档。

### 新增特性

**设置视频编码参数（Web/Electron/Android/iOS）**

1.1.5 支持开发者自行设置视频编码参数，包含视频宽高、帧率和码率。如需修改视频编码参数，可调用 `launch` 接口，通过 `mediaOptions` 里的 `cameraEncoderConfiguration` 和 `screenShareEncoderConfiguration` 分别设置摄像头采集视频流和屏幕共享视频流的编码参数。

**学生轮播（Web/Electron/Android/iOS）**

1.1.5 在小班课场景中新增学生视频轮播功能。老师或助教开启此功能后，学生按照指定的时间间隔轮流上台。

**设置观众端延时级别（Android/iOS）**

1.1.5 支持开发者自行设置观众端延时级别。默认情况，观众端延时级别为超低延时。你可在调用 `launch` 接口时通过 `latencyLevel` 参数切换观众端延时级别：

- 超低延时：发流端与观众端的延时为 400 ms - 800 ms。
- 低延时：发流端与观众端的延时为 1500 ms - 2000 ms。

声网针对不同级别的延时收取不同的音视频费用。

**控制学生上台后是否自动发流（Android/iOS）**

1.1.5 支持开发者自行控制学生上台后是否自动发送发送音频或视频流。默认情况下，学生上台后不发送音视频流。你可在调用 `launch` 接口时通过 `streamState` 参数更改默认行为。

**课前设备检测和视频预览（Android/iOS）**

1.1.5 新增课件设备检测和视频预览能力，开发者可通过新增的 [Media Context API](/cn/agora-class/edu_context_api_ref_ios_media?platform=Web)，自行开发课前检测模块，方便学生在上课前确认本地摄像头、麦克风设备是否工作以及预览本地音频和视频。

**美颜（Electron）**

1.1.5 新增基础美颜能力，支持设置美白、磨皮和红润效果。

### 改进

**PPT 展示优化（Android/iOS）**

为优化学生端的 PPT 展示，1.1.5 在 `AgoraEduLaunchConfig` 中新增 `boardFitMode` 用于设置 PPT 显示模式。默认情况下，白板内容显示模式为 fit，等比缩放 PPT 以保证内容的完整显示。你可在调用 `launch` 接口时将 `boardFitMode` 更换为 `Retain`，PPT 尺寸会以本地记录的上一次学生手动调整的大小为准。